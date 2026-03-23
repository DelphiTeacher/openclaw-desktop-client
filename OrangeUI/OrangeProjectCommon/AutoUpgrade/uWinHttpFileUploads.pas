unit uWinHttpFileUploads;

interface

uses
  Classes,  uWinHttpAPI, Windows, SysUtils;


type
  TWinHttpUpload = procedure(Sender: TObject; CurrentSize, ContentLength: DWORD; var ACancel: boolean) of object;

  TTempFileStream = class(THandleStream)
  private
    FFileName: string;
  public
    constructor Create(const ADir: string = ''; AutoClear: boolean = True);
    destructor Destroy; override;
    property FileName: string read FFileName;
  end;

function UploadFile(const ASvrAdd, AFileKey, AFileName: string; AUpdateProcess: TWinHttpUpload): Integer;
function DownloadFile(const ASvrAdd, AFileKey, AFileName: string; AUpdateProcess: TWinHttpUpload): Integer;

Function GetFileSizeEx(hFile: THandle; Var lpFileSizeHigh :UInt64):Boolean; stdcall; external kernel32 name 'GetFileSizeEx';
procedure RaiseLastModuleError(ModuleName: PChar; ModuleException: ExceptClass);


implementation

uses
  //uLogWriter,
  HTTPApp, untCommFuns, RTLConsts, uWinHttps;

const
  SAGENT_UPGRADE = 'MSSearcher/2.0 (%s %d.%d.%d)';

type
  EWinHTTP = Exception;


const
  APIMethod_Upgrade = 'GET';
  APIMethod_Upload = 'PUT';
  API_Upload = '/v1/upload/';
  API_Upgrade = '/v1/upgrade/';

  BOUNDARYPART = '--MSSearcher-MULTIPARTS-WINHTTP-EUROPA20';
  CRLF = #13#10;


var
  LogOutLevel: Integer = MAXWORD;
  MaxRequestID: Cardinal = 0;
  FResponseList: TList = nil;
  {$ifdef debug}
  _MaxDebugID: cardinal = 0;
  {$endif}

  _OSVerInfo: TOSVersionInfoEx;

  _iTmpFileIdx: integer = 0;



function OSVer: TOSVersionInfoEx;
begin
  if _OSVerInfo.dwOSVersionInfoSize = 0 then
  begin
    _OSVerInfo.dwOSVersionInfoSize := sizeof(_OSVerInfo);
    GetVersionEx(_OSVerInfo);
  end;
  Result := _OSVerInfo;
end;


function GetTmpFileName(const ADir: string): string;
var
  p,f: array[0..MAX_PATH] of Char;
begin
  if ADir = '' then GetTempPath(MAX_PATH, p)
  else
  begin
    StrCopy(p, PChar(ADir));
    if ADir[Length(ADir)] <> PathDelim then
    begin
      p[Length(ADir)] := PathDelim;
      p[Length(ADir)+1] := #0;
    end;

  end;
  inc(_iTmpFileIdx);
  Windows.GetTempFileName(p, '~Data', _iTmpFileIdx, f);
  Result := f;
end;


function SysErrorMessagePerModule(Code: DWORD; ModuleName: PChar): string;
var
  tmpLen: DWORD;
  err: PChar;
begin
  result := '';
  if Code=NO_ERROR then
    exit;

  tmpLen := FormatMessage(FORMAT_MESSAGE_FROM_HMODULE or FORMAT_MESSAGE_ALLOCATE_BUFFER,
    pointer(GetModuleHandle(ModuleName)),Code, LOCALE_USER_DEFAULT,@err,0,nil);
  try
    while (tmpLen>0) and (ord(err[tmpLen-1]) in [0..32,ord('.')]) do
      dec(tmpLen);
    SetString(result,err,tmpLen);
  finally
    LocalFree(HLOCAL(err));
  end;

  if result='' then
  begin
    result := SysErrorMessage(Code);
    if result='' then
    begin
      case code of
        ERROR_WINHTTP_CANNOT_CONNECT: result := 'cannot connect';
        ERROR_WINHTTP_TIMEOUT       : result := 'timeout';
        ERROR_WINHTTP_INVALID_SERVER_RESPONSE : result := 'invalid server response';
        else result := IntToHex(Code,8);
      end;
    end;
  end;
end;

procedure RaiseLastModuleError(ModuleName: PChar; ModuleException: ExceptClass);
var LastError: Integer;
    Error: Exception;
begin
  LastError := GetLastError;
  if LastError <> NO_ERROR then
    Error := ModuleException.CreateFmt('%s error %d (%s)',
      [ModuleName,LastError, SysErrorMessagePerModule(LastError, ModuleName)]) else
    Error := ModuleException.CreateFmt('Undefined %s error',[ModuleName]);
  raise Error;
end;

procedure WriteDebugLog(const s: string);
begin
  Writeln(s);
end;


function TWinHTTPInternalGetInfo(fRequest: HINTERNET; Info: DWORD): RawByteString;
var dwSize, dwIndex: DWORD;
    tmp: RawByteString;
    i: integer;
begin
  result := '';
  dwSize := 0;
  dwIndex := 0;
  if not WinHttpAPI.QueryHeaders(fRequest, Info, nil, nil, dwSize, @dwIndex) and
     (GetLastError=ERROR_INSUFFICIENT_BUFFER) then begin
    SetLength(tmp,dwSize);
    if WinHttpAPI.QueryHeaders(fRequest, Info, nil, pointer(tmp), dwSize, @dwIndex) then begin
      dwSize := dwSize shr 1;
      SetLength(result,dwSize);
      for i := 0 to dwSize-1 do // fast ANSI 7 bit conversion
        PByteArray(result)^[i] := PWordArray(tmp)^[i];
    end;
  end;
end;

//
procedure AppendChar(var str: string; chr: Char);
var len: Integer;
begin // str := str+chr would have created a temporary string for chr
  len := length(str);
  SetLength(str,len+1);
  PChar(pointer(str))[len] := chr; // SetLength() made str unique
end;

function UrlEncode(const aValue: string): string;
const
  HexChars: array[0..15] of string = (
    '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
var i,c: integer;
    utf8: RawByteString;
begin
  result := '';
  utf8 := UTF8Encode(aValue);
  for i := 1 to length(utf8) do begin
    c := ord(utf8[i]);
    case c of
    ord('0')..ord('9'),ord('a')..ord('z'),ord('A')..ord('Z'),
    ord('_'),ord('-'),ord('.'),ord('~'):
              AppendChar(result,char(c));
    ord(' '): AppendChar(result,'+');
    else result := result+'%'+HexChars[c shr 4]+HexChars[c and $F];
    end; // see rfc3986 2.3. Unreserved Characters
  end;
end;


function UploadFile(const ASvrAdd, AFileKey, AFileName: string; AUpdateProcess:
    TWinHttpUpload): Integer;
var
  FSession:HINTERNET;
  FConnection: HINTERNET;
  FRequest: HINTERNET;

  procedure InternetCloseHandle(var h: HINTERNET);
  begin
    if h <> nil then WinHttpAPI.CloseHandle(h);
    h := nil;
  end;

  function InternalGetInfo32(Info: DWORD): DWORD;
  var dwSize, dwIndex: DWORD;
  begin
    dwSize := sizeof(result);
    dwIndex := 0;
    Info := Info or WINHTTP_QUERY_FLAG_NUMBER;
    if not WinHttpAPI.QueryHeaders(fRequest, Info, nil, @result, dwSize, @dwIndex) then
      result := 0;
  end;

  function InternalGetInfo(Info: DWORD): RawByteString;
  var dwSize, dwIndex: DWORD;
      tmp: RawByteString;
      i: integer;
  begin
    result := '';
    dwSize := 0;
    dwIndex := 0;
    if not WinHttpAPI.QueryHeaders(fRequest, Info, nil, nil, dwSize, @dwIndex) and
       (GetLastError=ERROR_INSUFFICIENT_BUFFER) then begin
      SetLength(tmp,dwSize);
      if WinHttpAPI.QueryHeaders(fRequest, Info, nil, pointer(tmp), dwSize, @dwIndex) then begin
        dwSize := dwSize shr 1;
        SetLength(result,dwSize);
        for i := 0 to dwSize-1 do // fast ANSI 7 bit conversion
          PByteArray(result)^[i] := PWordArray(tmp)^[i];
      end;
    end;
  end;

  function InternalQueryDataAvailable: DWORD;
  begin
    if not WinHttpAPI.QueryDataAvailable(fRequest, @result) then
      RaiseLastModuleError(winhttpdll,EWinHTTP);
  end;

  function InternalReadData(var Data: RawByteString; Read: integer; Size: cardinal): cardinal;
  begin
    if not WinHttpAPI.ReadData(fRequest, @PByteArray(Data)[Read], Size, @result) then
      RaiseLastModuleError(winhttpdll,EWinHTTP);
  end;

const
  ALL_ACCEPT: array[0..1] of PWideChar = ('*/*',nil);
  IGNRECERTOPTS = SECURITY_FLAG_IGNORE_UNKNOWN_CA or
                  SECURITY_FLAG_IGNORE_CERT_DATE_INVALID or
                  SECURITY_FLAG_IGNORE_CERT_CN_INVALID or
                  SECURITY_FLAG_IGNORE_CERT_WRONG_USAGE;
  WINHTTP_OPTION_UPGRADE_TO_WEB_SOCKET = 114;
  MAXUPDATEFILESIZE = 1000 * 1024 * 1024; // 500M //UInt64(MAXDWORD)
var
  AcceptEncoding: string;
  iOpenType: integer;
  pCallback: TWinHttpStatusCallback;
  CallbackRes: PtrInt absolute pCallback;
  iProtocols: DWORD;
  sUserAgent: string;

  // request
  bSended: Boolean;
  iFlags: DWORD;
  cStr: TStringBuilder;
  L: DWORD;
  rData: RawByteString;


  FParams: TConnectParams;
  Method: string;
  API: string;
  bCancel: Boolean;
  Bytes: DWORD;
  Current: DWORD;
  dTotalLen: DWORD;
  hFile: THandle;
  iFileSize: UInt64;
  Max: DWORD;
  sHeader: string;
  Buffer: RawByteString;
  BufferSize: DWORD;

  BytesWritten: DWORD;
  ContentLength: DWORD;
  Data: RawByteString;
  dWriteLen: DWORD;
  Encoding: string;
  Header: string;
  sBlockEnd: string;
//  sBlockState: string;
  sFilePath: string;
  I: Integer;
  iCode: DWORD;
  iReadLen: DWORD;
  Read: DWORD;
  sFileName: string;
  sRawFileHeader: RawByteString;
  sRawBlockEnd: RawByteString;
  sSvrAddress, sSvrPost: string;

  function SetOption(AOpt, AFlags: DWORD): Boolean;
  begin
    Result := WinHttpAPI.SetOption(FRequest, AOpt, @AFlags, sizeOf(AFlags));
  end;
  function AddHeader(const Data: string): boolean;
  begin
    Result := True;
    if (Data<>'') then
      Result := WinHttpAPI.AddRequestHeaders(FRequest, PChar(Data), length(Data), WINHTTP_ADDREQ_FLAG_COALESCE);
  end;

begin
  dWriteLen := 0;
  dTotalLen := 0;
  iCode := 500;

  TryReadSegmentValue(ASvrAdd, 0, sSvrAddress, ':');
  TryReadSegmentValue(ASvrAdd, 1, sSvrPost, ':');

  FParams.Init(sSvrAddress, StrToInt(sSvrPost), False);
  FParams.ReceiveTimeout := 40000;
  FParams.SendTimeout := 40000;

  FSession := nil;
  FConnection := nil;

  BufferSize:= 64 * 1024; // 64K;  DWORD;
  SetLength(Buffer, BufferSize);

  iOpenType := WINHTTP_ACCESS_TYPE_NAMED_PROXY;
  if FParams.ProxyName='' then
  begin
    // Windows 8.1 and newer
    // https://docs.microsoft.com/en-us/windows/win32/api/winhttp/nf-winhttp-winhttpopen
    iOpenType := WINHTTP_ACCESS_TYPE_NO_PROXY;
    if (OSVer.dwMajorVersion>6) or ((OSVer.dwMajorVersion=6) and (OSVer.dwMinorVersion>=3)) then
      iOpenType := WINHTTP_ACCESS_TYPE_AUTOMATIC_PROXY;
  end;
  sUserAgent := format(SAGENT_UPGRADE, [String(OSVer.szCSDVersion),
      OSVer.dwMajorVersion, OSVer.dwMinorVersion, OSVer.dwBuildNumber]);

  //WriteDebugLog('WinHttp Open Session');
  FSession := WinHttpAPI.Open(PChar(sUserAgent), iOpenType,
                              PChar(FParams.ProxyName), PChar(FParams.ProxyByPass),
                              0);
                              //WINHTTP_FLAG_ASYNC); // 全部采用异步模式
  if not Assigned(FSession) then
    RaiseLastModuleError(WinHttpDll, EWinHTTP);

  try
    // cf. http://msdn.microsoft.com/en-us/library/windows/desktop/aa384116
    WinHttpAPI.SetTimeouts(FSession, 0, FParams.ConnectionTimeOut, FParams.SendTimeout, FParams.ReceiveTimeout);

    if FParams.IsHttps then
    begin
       iProtocols := WINHTTP_FLAG_SECURE_PROTOCOL_SSL3 or WINHTTP_FLAG_SECURE_PROTOCOL_TLS1;
       // Windows 7 and newer support TLS 1.1 & 1.2
       if (OSVer.dwMajorVersion>6) or ((OSVer.dwMajorVersion=6) and (OSVer.dwMinorVersion>=1)) then
         iProtocols :=  iProtocols or WINHTTP_FLAG_SECURE_PROTOCOL_TLS1_1 or
                                      WINHTTP_FLAG_SECURE_PROTOCOL_TLS1_2;
      if not WinHttpAPI.SetOption(FSession, WINHTTP_OPTION_SECURE_PROTOCOLS, @iProtocols, SizeOf(iProtocols)) then
        RaiseLastModuleError(winhttpdll,EWinHTTP);
    end;

    //WriteDebugLog('WinHttp Connect');
    FConnection := WinHttpAPI.Connect(FSession, PChar(FParams.Server), FParams.Port, 0);
    if not assigned(FConnection) then RaiseLastModuleError(winhttpdll, EWinHTTP);


    ///
    ///  Request
    ///
    Method := APIMethod_Upload;
    API := API_Upload;

    iFlags := 0;
    if FParams.IsHttps then iFlags := iFlags or WINHTTP_FLAG_SECURE;

    //WriteDebugLog('WinHttp Open request');
    FRequest := WinHttpAPI.OpenRequest(FConnection,PChar(Method), PChar(API),
                            nil, nil, WINHTTP_DEFAULT_ACCEPT_TYPES, iFlags);
    if not Assigned(FRequest) then RaiseLastModuleError(WinHttpDll,EWinHTTP);

    // SSL ignore certificates
    if iFlags and WINHTTP_FLAG_SECURE = WINHTTP_FLAG_SECURE then
      if not SetOption(WINHTTP_OPTION_SECURITY_FLAGS, IGNRECERTOPTS) then
        RaiseLastModuleError(WinHttpDll,EWinHTTP);

    hFile := CreateFile(PChar(AFileName), GENERIC_READ, FILE_SHARE_READ, Nil,OPEN_EXISTING, 0, 0);
    try
      if hFile = 0 then
        RaiseLastModuleError(WinHttpDll, EWinHTTP);
      if Not GetFileSizeEx(hFile, iFileSize) then
        RaiseLastModuleError(WinHttpDll, EWinHTTP);
      if iFileSize > MAXUPDATEFILESIZE then
        raise Exception.Create('文件过大，上传文件不能超过2G');

      //WriteDebugLog('Open file: ' + AFileName + '  size:' + intToStr(iFileSize shr 4));

      sFilePath := AFileName;
      for I := 1 to Length(sFilePath) do
        if sFilePath[i] = '\' then
          sFilePath[i] := '/';
      sFileName := ExtractFileName(AFileName);

      sRawFileHeader := UTF8Encode('--'+ BOUNDARYPART + CRLF +
                        'Content-Disposition: form-data; ' +
                        //'name="fileToUpload"; ' +
                        'name="'+AFileKey+'"; ' +
                        'filename="'+AFileName+'" ' + CRLF +
                        'Content-Type: application/octet-stream '+ CRLF +
                        'Content-Transfer-Encoding: binary'+ CRLF + CRLF);

      //  每个文件结束都要加
      sRawBlockEnd := UTF8Encode(CRLF +
                                 '--' + BOUNDARYPART + '--'+ CRLF);

      dTotalLen :=  iFileSize +
                    Length(sRawFileHeader) +
                    length(sRawBlockEnd); //2{'--'} + Length(BOUNDARYPART) + 4{'--'+CRLF};

     if not (
        AddHeader('Content-Type: multipart/form-data; boundary=' + BOUNDARYPART) and
        AddHeader('Content-Length: ' + intToStr(dTotalLen)) and
        AddHeader('Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8') and
        AddHeader('Accept-Encoding: identity, gzip') and
        AddHeader('User-Agent: MSSearcher/2.0 (WinHTTP texst)')) then
        RaiseLastModuleError(WinHttpDll,EWinHTTP);

      WriteDebugLog('WinHttp Send request');
      if not WinHttpAPI.SendRequest(FRequest ,nil,0,nil,0,dTotalLen,0) then
        RaiseLastModuleError(WinHttpDll, EWinHTTP);

      if Assigned(AUpdateProcess) then
          AUpdateProcess(nil, 0, dTotalLen, bCancel);

      dWriteLen := 0;
      // 发送文件定义头
      if not WinHttpAPI.WriteData(FRequest, @PByteArray(sRawFileHeader)[0], Length(sRawFileHeader), @BytesWritten) then
        RaiseLastModuleError(WinHttpDll, EWinHTTP);

      inc(dWriteLen, BytesWritten);
      if Assigned(AUpdateProcess) then
        AUpdateProcess(nil, dWriteLen, dTotalLen, bCancel);

      // 发送文件实体
      L := DWORD(iFileSize);
      Current := 0;
      while Current < L do
      begin
        Bytes := BufferSize;
        Max := L - Current;
        if BufferSize > Max then
          Bytes := Max;

        if not ReadFile(hFile, PByteArray(Buffer)^, Bytes, BytesWritten, nil) then
          RaiseLastModuleError(WinHttpDll, EWinHTTP);

        if not WinHttpAPI.WriteData(FRequest, @PByteArray(Buffer)[0], BytesWritten, @BytesWritten) then
          RaiseLastModuleError(WinHttpDll, EWinHTTP);

        Current := Current + BytesWritten;

        dWriteLen := dWriteLen + BytesWritten;
        if Assigned(AUpdateProcess) then
        begin
          AUpdateProcess(nil, dWriteLen, dTotalLen, bCancel);
          WriteDebugLog('  send data: ' + intToStr(dWriteLen shr 4) + 'KB /' + IntToStr(dTotalLen shr 4) + 'KB');
        end;
      end;
    finally
      CloseHandle(hFile);
    end;
      // 发送扩展信息
    if not WinHttpAPI.WriteData(FRequest, @PByteArray(sRawBlockEnd)[0], Length(sRawBlockEnd), @BytesWritten) then
      RaiseLastModuleError(WinHttpDll, EWinHTTP);

    WriteDebugLog('  send data: ' + intToStr(dWriteLen shr 4) + 'KB /' + IntToStr(dTotalLen shr 4) + 'KB');

    dWriteLen := dWriteLen + BytesWritten;
    if Assigned(AUpdateProcess) then
      AUpdateProcess(nil, dWriteLen, dTotalLen, bCancel);

    //
    // 获取返回数据
    //
    WriteDebugLog('WinHttp receive response');
    if not WinHttpAPI.ReceiveResponse(FRequest, nil) then
      RaiseLastModuleError(WinHttpDll, EWinHTTP);

    iCode := InternalGetInfo32(WINHTTP_QUERY_STATUS_CODE);
    Header := UTF8ToString(InternalGetInfo(WINHTTP_QUERY_RAW_HEADERS_CRLF));
    Encoding := UTF8ToString(InternalGetInfo(WINHTTP_QUERY_CONTENT_ENCODING));
    AcceptEncoding := UTF8ToString(InternalGetInfo(WINHTTP_QUERY_ACCEPT_ENCODING));

    // retrieve received content (if any)
    Read := 0;
    ContentLength := InternalGetInfo32(WINHTTP_QUERY_CONTENT_LENGTH);
    if ContentLength<>0 then
    begin
      // optimized version reading "Content-Length: xxx" bytes
      SetLength(Data,ContentLength);
      repeat
        Bytes := InternalQueryDataAvailable;
        if Bytes=0 then
        begin
          SetLength(Data,Read); // truncated content
          break;
        end;
        Bytes := InternalReadData(Data,Read,Bytes);
        if Bytes=0 then
        begin
          SetLength(Data,Read); // truncated content
          break;
        end;
        inc(Read,Bytes);
  //      if Assigned(fOnProgress) then
  //        fOnProgress(self,Read,ContentLength);
      until Read=ContentLength;
    end else begin
      // Content-Length not set: read response in blocks of HTTP_RESP_BLOCK_SIZE
      repeat
        Bytes := InternalQueryDataAvailable;
        if Bytes=0 then
          break;
        SetLength(Data,Read+Bytes{HTTP_RESP_BLOCK_SIZE});
        Bytes := InternalReadData(Data,Read,Bytes);
        if Bytes=0 then
          break;
        inc(Read,Bytes);
  //      if Assigned(fOnProgress) then
  //        fOnProgress(self,Read,ContentLength);
      until false;
      SetLength(Data,Read);
    end;
  finally
    InternetCloseHandle(FRequest);
    InternetCloseHandle(FConnection);
    InternetCloseHandle(FSession);
  end;

  Result := iCode;
end;


function DownloadFile(const ASvrAdd, AFileKey, AFileName: string; AUpdateProcess:
    TWinHttpUpload): Integer;
var
  FSession:HINTERNET;
  FConnection: HINTERNET;
  FRequest: HINTERNET;


  procedure InternetCloseHandle(var h: HINTERNET);
  begin
    if h <> nil then WinHttpAPI.CloseHandle(h);
    h := nil;
  end;

  function InternalGetInfo32(Info: DWORD): DWORD;
  var dwSize, dwIndex: DWORD;
  begin
    dwSize := sizeof(result);
    dwIndex := 0;
    Info := Info or WINHTTP_QUERY_FLAG_NUMBER;
    if not WinHttpAPI.QueryHeaders(fRequest, Info, nil, @result, dwSize, @dwIndex) then
      result := 0;
  end;

  function InternalGetInfo(Info: DWORD): RawByteString;
  var dwSize, dwIndex: DWORD;
      tmp: RawByteString;
      i: integer;
  begin
    result := '';
    dwSize := 0;
    dwIndex := 0;
    if not WinHttpAPI.QueryHeaders(fRequest, Info, nil, nil, dwSize, @dwIndex) and
       (GetLastError=ERROR_INSUFFICIENT_BUFFER) then begin
      SetLength(tmp,dwSize);
      if WinHttpAPI.QueryHeaders(fRequest, Info, nil, pointer(tmp), dwSize, @dwIndex) then begin
        dwSize := dwSize shr 1;
        SetLength(result,dwSize);
        for i := 0 to dwSize-1 do // fast ANSI 7 bit conversion
          PByteArray(result)^[i] := PWordArray(tmp)^[i];
      end;
    end;
  end;

  function InternalQueryDataAvailable: DWORD;
  begin
    if not WinHttpAPI.QueryDataAvailable(fRequest, @result) then
      RaiseLastModuleError(winhttpdll,EWinHTTP);
  end;

  function InternalReadData(var Data: RawByteString; Read: integer; Size: cardinal): cardinal;
  begin
    if not WinHttpAPI.ReadData(fRequest, @PByteArray(Data)[Read], Size, @result) then
      RaiseLastModuleError(winhttpdll,EWinHTTP);
  end;

const
  ALL_ACCEPT: array[0..1] of PWideChar = ('*/*',nil);
  IGNRECERTOPTS = SECURITY_FLAG_IGNORE_UNKNOWN_CA or
                  SECURITY_FLAG_IGNORE_CERT_DATE_INVALID or
                  SECURITY_FLAG_IGNORE_CERT_CN_INVALID or
                  SECURITY_FLAG_IGNORE_CERT_WRONG_USAGE;
  WINHTTP_OPTION_UPGRADE_TO_WEB_SOCKET = 114;
  MAXUPDATEFILESIZE = 1000 * 1024 * 1024; // 500M //UInt64(MAXDWORD)
var
  AcceptEncoding: string;
  iOpenType: integer;
  pCallback: TWinHttpStatusCallback;
  CallbackRes: PtrInt absolute pCallback;
  iProtocols: DWORD;
  sUserAgent: string;

  // request
  iFlags: DWORD;

  FParams: TConnectParams;
  Method: string;
  API: string;
  bCancel: Boolean;
  Bytes: DWORD;
  Buffer: RawByteString;
  BufferSize: DWORD;

  cFile: TFileStream;
  ContentLength: DWORD;
  Data: RawByteString;
  Encoding: string;
  Header: string;
  iCode: DWORD;
  Read: DWORD;
  sDownFileName: string;
  sSvrAddress, sSvrPost: string;

  function SetOption(AOpt, AFlags: DWORD): Boolean;
  begin
    Result := WinHttpAPI.SetOption(FRequest, AOpt, @AFlags, sizeOf(AFlags));
  end;
  function AddHeader(const Data: string): boolean;
  begin
    Result := True;
    if (Data<>'') then
      Result := WinHttpAPI.AddRequestHeaders(FRequest, PChar(Data), length(Data), WINHTTP_ADDREQ_FLAG_COALESCE);
  end;

begin
  //https://192.168.8.61:7000/v1/upload/DocManage%2FAttachDoc%2F2020-10-21%2F1021101744248F0800270DC715.dll
  TryReadSegmentValue(ASvrAdd, 0, sSvrAddress, ':');
  TryReadSegmentValue(ASvrAdd, 1, sSvrPost, ':');

  FParams.Init(sSvrAddress, StrToInt(sSvrPost), False);
  FParams.ReceiveTimeout := 40000;
  FParams.SendTimeout := 40000;

  FSession := nil;
  FConnection := nil;

  BufferSize:= 64 * 1024; // 64K;  DWORD;
  SetLength(Buffer, BufferSize);

  iOpenType := WINHTTP_ACCESS_TYPE_NAMED_PROXY;
  if FParams.ProxyName='' then
  begin
    // Windows 8.1 and newer
    // https://docs.microsoft.com/en-us/windows/win32/api/winhttp/nf-winhttp-winhttpopen
    iOpenType := WINHTTP_ACCESS_TYPE_NO_PROXY;
    if (OSVer.dwMajorVersion>6) or ((OSVer.dwMajorVersion=6) and (OSVer.dwMinorVersion>=3)) then
      iOpenType := WINHTTP_ACCESS_TYPE_AUTOMATIC_PROXY;
  end;
  sUserAgent := format('MSSearcher/2.0 (%s %d.%d.%d)', [String(OSVer.szCSDVersion),
      OSVer.dwMajorVersion, OSVer.dwMinorVersion, OSVer.dwBuildNumber]);

  WriteDebugLog('WinHttp Open Session');
  FSession := WinHttpAPI.Open(PChar(sUserAgent), iOpenType,
                              PChar(FParams.ProxyName), PChar(FParams.ProxyByPass),
                              0);
                              //WINHTTP_FLAG_ASYNC); // 全部采用异步模式
  if not Assigned(FSession) then
    RaiseLastModuleError(WinHttpDll, EWinHTTP);

  try
    // cf. http://msdn.microsoft.com/en-us/library/windows/desktop/aa384116
    WinHttpAPI.SetTimeouts(FSession, 0, FParams.ConnectionTimeOut, FParams.SendTimeout, FParams.ReceiveTimeout);

    if FParams.IsHttps then
    begin
       iProtocols := WINHTTP_FLAG_SECURE_PROTOCOL_SSL3 or WINHTTP_FLAG_SECURE_PROTOCOL_TLS1;
       // Windows 7 and newer support TLS 1.1 & 1.2
       if (OSVer.dwMajorVersion>6) or ((OSVer.dwMajorVersion=6) and (OSVer.dwMinorVersion>=1)) then
         iProtocols :=  iProtocols or WINHTTP_FLAG_SECURE_PROTOCOL_TLS1_1 or
                                      WINHTTP_FLAG_SECURE_PROTOCOL_TLS1_2;
      if not WinHttpAPI.SetOption(FSession, WINHTTP_OPTION_SECURE_PROTOCOLS, @iProtocols, SizeOf(iProtocols)) then
        RaiseLastModuleError(winhttpdll,EWinHTTP);
    end;

    WriteDebugLog('WinHttp Connect');
    FConnection := WinHttpAPI.Connect(FSession, PChar(FParams.Server), FParams.Port, 0);
    if not assigned(FConnection) then RaiseLastModuleError(winhttpdll, EWinHTTP);

    ///
    ///  Request
    ///
    Method := APIMethod_Upgrade;
    API := API_Upgrade + AFileKey;

    iFlags := 0;
    if FParams.IsHttps then iFlags := iFlags or WINHTTP_FLAG_SECURE;

    WriteDebugLog('WinHttp Open request');
    FRequest := WinHttpAPI.OpenRequest(FConnection,PChar(Method), PChar(API),
                            nil, nil, WINHTTP_DEFAULT_ACCEPT_TYPES, iFlags);
    if not Assigned(FRequest) then RaiseLastModuleError(WinHttpDll,EWinHTTP);


    // callback set
//    pCallback := WinHttpAPI.SetStatusCallback(FRequest, WinHTTPRequestCallback,
//                    WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS, 0);
//    if WINHTTP_INVALID_STATUS_CALLBACK = CallbackRes then
//      RaiseLastModuleError(WinHttpDll,EWinHTTP);

    //if FKeepAlive = 0 then
    //  SetOption(cRequest, WINHTTP_OPTION_DISABLE_FEATURE, WINHTTP_DISABLE_KEEP_ALIVE);

    // SSL ignore certificates
    if iFlags and WINHTTP_FLAG_SECURE = WINHTTP_FLAG_SECURE then
      if not SetOption(WINHTTP_OPTION_SECURITY_FLAGS, IGNRECERTOPTS) then
        RaiseLastModuleError(WinHttpDll,EWinHTTP);


     if not (
        AddHeader('Accept: */*') and
        AddHeader('Accept-Encoding: identity') and
        AddHeader('User-Agent: MSSearcher/2.0 (WinHTTP texst)')) then
        RaiseLastModuleError(WinHttpDll,EWinHTTP);

      //WriteDebugLog('WinHttp Send request');
      if not WinHttpAPI.SendRequest(FRequest ,nil,0,nil,0,0,0) then
        RaiseLastModuleError(WinHttpDll, EWinHTTP);

    //
    // 获取返回数据
    //
    WriteDebugLog('WinHttp receive response');
    if not WinHttpAPI.ReceiveResponse(FRequest, nil) then
      RaiseLastModuleError(WinHttpDll, EWinHTTP);

    iCode := InternalGetInfo32(WINHTTP_QUERY_STATUS_CODE);
    Header := UTF8ToString(InternalGetInfo(WINHTTP_QUERY_RAW_HEADERS_CRLF));
    Encoding := UTF8ToString(InternalGetInfo(WINHTTP_QUERY_CONTENT_ENCODING));
    AcceptEncoding := UTF8ToString(InternalGetInfo(WINHTTP_QUERY_ACCEPT_ENCODING));

    // retrieve received content (if any)
    Read := 0;
    ContentLength := InternalGetInfo32(WINHTTP_QUERY_CONTENT_LENGTH);

    sDownFileName := AFileName; // ChangeFileExt(AFileName, '.WinHttp') + ExtractFileExt(AFileName);
    cFile := TFileStream.Create(sDownFileName, fmCreate);
    try
    if ContentLength<>0 then
    begin
      if assigned(AUpdateProcess) then
        AUpdateProcess(nil, 0, ContentLength, bCancel);
      repeat
        Bytes := InternalQueryDataAvailable;
        if Bytes = 0 then
          Break;

        if Bytes > BufferSize then
          Bytes := BufferSize;

        if not WinHttpAPI.ReadData(fRequest, @PByteArray(Buffer)[0], Bytes, @Bytes) then
          RaiseLastModuleError(winhttpdll,EWinHTTP);

        if Bytes = 0 then
          Break;

        cFile.Write(PByteArray(Buffer)[0], Bytes);

        inc(Read,Bytes);
        if assigned(AUpdateProcess) then
        begin
          AUpdateProcess(nil, Read, ContentLength, bCancel);
          WriteDebugLog(format('%d/%d KB', [Read shr 4 , ContentLength shr 4 ]));
        end;
      until Read=ContentLength;
    end
    else begin
      // Content-Length not set: read response in blocks of HTTP_RESP_BLOCK_SIZE
      repeat
        Bytes := InternalQueryDataAvailable;
        if Bytes=0 then
          break;

        if Bytes > BufferSize then
          Bytes := BufferSize;

        if not WinHttpAPI.ReadData(fRequest, @PByteArray(Buffer)[0], Bytes, @Bytes) then
          RaiseLastModuleError(winhttpdll,EWinHTTP);

        if Bytes = 0 then
          Break;

        cFile.Write(PByteArray(Buffer)[0], Bytes);
        inc(Read,Bytes);
        //if assigned(AUpdateProcess) then
        //begin
          //AUpdateProcess(nil, Read, ContentLength, bCancel);
          //WriteDebugLog(format('%d/%d KB', [Read shr 4 , ContentLength shr 4 ]));
        //end;
      until false;
      SetLength(Data,Read);
    end;
    finally
      cFile.Free;
    end;
  finally
    InternetCloseHandle(FRequest);
    InternetCloseHandle(FConnection);
    InternetCloseHandle(FSession);
  end;

//  WriteDebugLog('Code: ' + intToStr(iCode) + #13#10 + Header);
//  WriteDebugLog(UTF8ToString(Data));
  Result := iCode;
end;

constructor TTempFileStream.Create(const ADir: string = ''; AutoClear: boolean = True);
var
  att: DWORD;
begin
  att := FILE_ATTRIBUTE_HIDDEN or FILE_ATTRIBUTE_TEMPORARY;
  if AutoClear then
    att := att or FILE_FLAG_DELETE_ON_CLOSE;

  FFileName := GetTmpFileName(ADir);
  inherited Create(CreateFile(PChar(FFileName), GENERIC_ALL, FILE_SHARE_READ,
                  nil, CREATE_ALWAYS, att, 0));

  if FHandle = INVALID_HANDLE_VALUE then
    raise EFCreateError.CreateResFmt(@SFCreateErrorEx, [ExpandFileName(FFileName), SysErrorMessage(GetLastError)]);
end;

destructor TTempFileStream.Destroy;
begin
  if FHandle <> INVALID_HANDLE_VALUE then
    FileClose(FHandle);
  inherited;
end;


end.
