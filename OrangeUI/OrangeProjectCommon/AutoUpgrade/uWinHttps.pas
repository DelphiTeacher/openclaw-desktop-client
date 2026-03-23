unit uWinHttps;

{*
  Http 客户端请求连接

  -- fpack@163.com

  version 1.0
  - Windows 实现 WinHttp接口, 使用异步请求模式
    WinHttp 头定义pas从 Delphi10.2 中获取，内容稍微有些修改。
    使用动态加载Dll模式，初始化API

*}

interface

uses
  Classes, SysUtils, Windows, uWinHttpAPI;

type
  TDataRequest = class;
  TDataRequestClass = class of TDataRequest;
  THttpConnection = class;
  THttpContext = class;

  PConnectParams = ^TConnectParams;
  TConnectParams = record
    Server: string;
    Port: Word;
    IsHttps: boolean;
    ProxyName: string;
    ProxyByPass: string;
    ConnectionTimeOut: DWORD;
    SendTimeout: DWORD;
    ReceiveTimeout: DWORD;
    procedure Init(const ASvr: string; APort: word; AIsSSL: boolean);
    procedure InitOf(const Addr: string);


  end;

  TWinHttpUpload = function(Sender: TObject; CurrentSize, ContentLength: DWORD): boolean of object;
  TWinHttpDownload = function(Sender: TObject; CurrentSize, ContentLength, ChunkSize: DWORD; const ChunkData): boolean of object;
  TWinHttpProgress = procedure(Sender: TObject; CurrentSize, ContentLength: DWORD) of object;


  TResponseDataFun = reference to procedure(Sender: THttpContext; Code: DWORD);

  IResponseEvent = interface
    ['{BF376E5D-B65F-4F7B-A659-2C66B1F6CF84}']
    function GetIsActived: Boolean; stdcall;
    procedure SetIsActived(const Value: Boolean); stdcall;
    procedure Load(Sender: THttpContext; Code: DWORD); stdcall;
    procedure Close; stdcall;
    property IsActived: Boolean read GetIsActived write SetIsActived;
  end;

  THttpObjectStatus = set of (hosFree);
  TContextOptions = set of (coDisableZip,       // 不需要服务等压缩数据
                            coDumpResponseData  // 丢弃返回值, 只要状态码
                            );

  THttpObjectState = set of (hosWriting, hosWrited, hosReading, hosReaded,
      hosCloseing, hosDestroying, hosFreeNotification);
  //csLoading ,

  // HTTP 请求上下文
  THttpContext = class
  private
    {$ifdef Debug}
    FDebugID: Cardinal;
    {$endif}
    FOwner: TObject;
    FSender: TObject;
    FComponentState: THttpObjectState;
    FRequestHandle: HINTERNET;

    FAPI: string;
    FMethod: string;
    FIsHttps: boolean;
    FOptions : TContextOptions;

    FBuffer: RawByteString;
    FBufferSize: DWORD;
    FDownloadChunkSize: DWORD;  // 下载代码块长度
    // response Data
    FCode: DWORD;
    FEncoding :RawByteString;

    FOutDataLength: DWORD;
    FResponseTmpData: TStream;
    FResponseReadSize: DWORD;   // 读取总长度

    // 最后的错误信息
    FLastError: DWORD;
    FErrorMsg: string;

    FWaitEvent: THandle;    // 同步信号
    FOnFinshed: TNotifyEvent;
    FDatas: TDataRequest;

    procedure InitBuff;
    function  InternalGetInfo(Info: DWORD): RawByteString;
    function  InternalGetInfo32(Info: DWORD): DWORD;
    function  SetOption(AOpt, AFlags: DWORD): Boolean;
    function  AddHeader(const Data: string): boolean;
    procedure WriteLastError;
    procedure SetDatas(const Value: TDataRequest);
  protected
    fOnDownload: TWinHttpDownload;
    fOnProgress: TWinHttpProgress;
    FOnUpload: TWinHttpUpload;
    procedure WriteLastRequestError;
    procedure ConvertRequestBuffer;
    function  PushBuffer(Buffer: Pointer; Size: DWORD): Boolean;
    function  QueryData: boolean;
    function  ReadData(Size: DWORD): Boolean;

    procedure DoSendRequestComplete(dwStatusInformationLength: DWORD);
    procedure DoHeadersAvailable(dwStatusInformationLength: DWORD);
    procedure DoDataAvailable(lpvStatusInformation: LPVOID);
    procedure DoReadComplete(lpvStatusInformation: LPVOID; dwStatusInformationLength: DWORD);
    function  DoRequest: Cardinal;
    procedure DoRequestError(lpvStatusInformation: LPWINHTTP_ASYNC_RESULT);
    procedure DoResponseData;
    function  IsHttps: Boolean;
    function  IsCancel: Boolean;
  public
    constructor Create(AOwner: TObject); virtual;
    destructor Destroy; override;

    procedure CloseRequst;
    function Request: Integer;

    property API: string read FAPI write FAPI;
    property Method: string read FMethod write FMethod;
    property Owner: TObject read FOwner;
    property Sender: TObject read FSender;

    property LastError: DWORD read FLastError write FLastError;
    property ErrorMsg: string read FErrorMsg write FErrorMsg;

    property DownloadChunkSize: DWORD read FDownloadChunkSize write FDownloadChunkSize;
    property Code: DWORD read FCode;
    property Datas: TDataRequest read FDatas write SetDatas;
    property OnDownload: TWinHttpDownload read fOnDownload write fOnDownload;
    property OnFinshed: TNotifyEvent read FOnFinshed write FOnFinshed;
    property OnProgress: TWinHttpProgress read fOnProgress write fOnProgress;
    property OnUpload: TWinHttpUpload read FOnUpload write FOnUpload;
    property ComponentState: THttpObjectState read FComponentState;

  end;

  THttpConnection = class
  private
    FOwner: TObject;
    FComponentState: THttpObjectState;
    function GetParams: PConnectParams;
  protected
    FContextList: TList;
    FParams: TConnectParams;
    FURL: string;
  public
    constructor Create(AOwner: TObject; const AParams: TConnectParams); virtual;
    destructor Destroy; override;
    procedure Close; virtual;
    function BuildContext(Sender: TObject; const API, AMethod: string): THttpContext; virtual;
    function Async(Sender: TObject; API, Method: string; AData: TDataRequest;
        AOptions: TContextOptions = []): Boolean; overload;
    function Async(Sender: TObject; API, Method, AParams: string): Boolean; overload;
    function Await(Sender: TObject; const API, Method: string;
        AData: TDataRequest; AOptions: TContextOptions = []): Boolean; overload;
    property Params: PConnectParams read GetParams;
    property ComponentState: THttpObjectState read FComponentState;
  end;

  THttpConnectionClass = class of THttpConnection;


  EWinHTTP = Class(Exception);

  THttpRequestContext = class(THttpContext)
  protected
  public
  end;
  // WinHttp API
  TWinHttpConnection = class(THttpConnection)
  private
    FSession: HINTERNET;
    FConnection: HINTERNET;
  protected
    procedure InternalConnect;
    procedure InternetCloseHandle(var h: HINTERNET);
    procedure WaitCloseAllRequest;
  public
    constructor Create(AOwner: TObject; const AParams: TConnectParams); override;
    destructor Destroy; override;
    procedure Close; override;

    function BuildContext(Sender: TObject; const API, AMethod: string): THttpContext; override;
  end;

  TDataRequestProgressEvent = procedure(Sender: TObject; CurrentSize, ContentLength: DWORD) of object;
  TRequestFinishedEvent = procedure(Sender: TDataRequest; ACode: DWORD) of object;

  TDataRequestStates = set of (drsConnected, drsSendFinished, drsResponeFinished, drsCancel);
  TDataBuildOptions = set of (dboAutoFree);

  TDataRequest = class
  private
    FOwner : TObject;
    FRefCnt: integer;       // 引用计数自释放
    FStates: TDataRequestStates;
    FIsOwnerParam: boolean;
    FParams: RawByteString;
    FIsOwnerData: boolean;
    FDatas: TStream;
    FReadFinishedFree: Boolean;
    FCode: DWORD;
    FOnProgress: TDataRequestProgressEvent;
    FOnDownloadFinished: TRequestFinishedEvent;
    FUserData: string;
    FErrorMsg: string;
    FLastError: DWORD;
    function GetOutData: TStream;
    function GetOutLength: Int64;
    procedure SetOutData(const Value: TStream);
    function  GetParams: RawByteString;
  protected
    procedure DoDownloadFinished; virtual;
    function  GetParamsLen: int64; stdcall;
  public
    constructor Create(AOwner: TObject); virtual;
    destructor Destroy; override;
    procedure AddRef;
    procedure DecRef;
    procedure Cancel;

    class procedure Close(var ARequest: TDataRequest); static;
    class function BuildOf(AClass: TDataRequestClass; AOwner: TObject; const AParams: RawByteString; const AUserData: string;
                    AFinishedFun: TRequestFinishedEvent; AOpts: TDataBuildOptions = []): TDataRequest;
    class function Build(AOwner: TObject; const AParams: RawByteString; const AUserData: string;
                    AFinishedFun: TRequestFinishedEvent; AOpts: TDataBuildOptions = []): TDataRequest; overload; static;
    class function Build(AOwner: TObject; const AParams: RawByteString; const AUserData: string;
                    AOpts: TDataBuildOptions = []): TDataRequest; overload; static;
    class function Build(AOwner: TObject; const AParams: RawByteString; AOpts: TDataBuildOptions): TDataRequest; overload; static;
    class function Build(AOwner: TObject; const AParams, AOutData: TStream; AOpts: TDataBuildOptions = []): TDataRequest; overload; static;

    function  PrepareData: Int64;
    procedure FinishRequest(ACode:DWORD);
    procedure Progress(Size, ContentLength: DWORD); stdcall;
    procedure SetParams(const s: RawByteString); overload;
    procedure SetParams(s: TStream); overload;
    function  ReadParams(var Buffer; Count: Longint): Longint;  stdcall;
    function  WriteData(Buffer: Pointer; Size: DWORD): Longint; stdcall;
    function  OutText: RawByteString;
    property  ParamsLen: int64 read GetParamsLen;
    property  OnProgress: TDataRequestProgressEvent read FOnProgress write FOnProgress;
    property  OnDownloadFinished: TRequestFinishedEvent read FOnDownloadFinished write FOnDownloadFinished;
    property  Code: DWORD read FCode write FCode;
    property  OutData: TStream read GetOutData write SetOutData;
    property  OutLength: Int64 read GetOutLength;
    property  UserData: string read FUserData write FUserData;
    property  States: TDataRequestStates read FStates;
    property  LastError: DWORD read FLastError;
    property  ErrorMsg: string read FErrorMsg;
    property  Params: RawByteString read GetParams;
  end;

  function GetHttpConnecitonClass: THttpConnectionClass;


implementation

uses
  uLogWriter, SynZip, untCommFuns, IniFiles;

type
  TWorkThread = class(TThread)
  private
    FContext: THttpContext;
    FWaitCount: Cardinal;
    FAPI: string;
    FLoading: boolean;
    FWaitEvent: THandle;
  protected
    constructor Create(AContext: THttpContext);
    procedure Execute; override;
  end;

var
  OSVersionInfo: TOSVersionInfoEx;
  LogOutLevel: Integer = MAXWORD;
  MaxRequestID: Cardinal = 0;
  FResponseList: TList = nil;
  Mutex :TMutex = nil;
  {$ifdef debug}
  _MaxDebugID: cardinal = 0;
  {$endif}


function InterlockedIncrement(var Addend: Integer): Integer;
asm
      MOV   EDX,1
      XCHG  EAX,EDX
 LOCK XADD  [EDX],EAX
      INC   EAX
end;

function InterlockedDecrement(var Addend: Integer): Integer;
asm
      MOV   EDX,-1
      XCHG  EAX,EDX
 LOCK XADD  [EDX],EAX
      DEC   EAX
end;


function GZReadToStream(const orig, destgz: TStream): Boolean;
var gzr: TGZRead;
  pData: PAnsiChar;
  iLen: Integer;
begin
  Result := False;
  pData := nil;
  if orig is TMemoryStream then
    pData := TMemoryStream(orig).Memory;
  iLen := integer(orig.Size);

  if gzr.Init(pData,iLen) then
    Result := gzr.ToStream(destgz, 0);
end;

procedure WriteLog(ALevel: TLogWriteKind; const s: string); overload;
begin
  if ord(ALevel) < LogOutLevel then
    LogWriter.Add(ALevel, s);
  //OutputDebugString(Pchar(s));
  //Writeln(Pchar(s));
end;

procedure WriteLog(ALevel: TLogWriteKind; const Fmt: string; const args: array of const); overload;
begin
  WriteLog(ALevel, format(Fmt, args));
end;

function Ansi7ToUnicode(const Ansi: RawByteString): RawByteString;
var
  n, i: PtrInt;
begin
  // fast ANSI 7 bit conversion
  result := '';
  if Ansi='' then
    exit;
  n := length(Ansi);
  SetLength(result,n*2+1);
  for i := 0 to n do // to n = including last #0
    PWordArray(pointer(result))^[i] := PByteArray(pointer(Ansi))^[i];
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

function GetHttpConnecitonClass: THttpConnectionClass;
begin
  Result := TWinHttpConnection;
end;

procedure THttpConnection.Close;
begin

end;

constructor THttpConnection.Create(AOwner: TObject; const AParams: TConnectParams);
var
  cDefConnectionTimeout: Cardinal;
  cDefReceiveTimeout: Cardinal;
  cDefSendTimeout: Cardinal;
  cIniFile: TIniFile;
begin
  inherited Create;
  FOwner := AOwner;
  FParams := AParams;
  if FParams.Port = INTERNET_DEFAULT_PORT then
  begin
    if FParams.IsHttps then
      FParams.Port := INTERNET_DEFAULT_HTTPS_PORT
    else FParams.Port := INTERNET_DEFAULT_HTTP_PORT;
  end;

  cDefConnectionTimeout := 15000;
  cDefSendTimeout := 20000;
  cDefReceiveTimeout := 20000;
  cIniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'ClientConfig.dat');
  try
    cDefConnectionTimeout := cIniFile.ReadInteger('connect', 'ConnectionTimeout', cDefConnectionTimeout);
    cDefSendTimeout := cIniFile.ReadInteger('connect', 'SendTimeout', cDefSendTimeout);
    cDefReceiveTimeout := cIniFile.ReadInteger('connect', 'ReceiveTimeout', cDefReceiveTimeout);
  finally
    cIniFile.Free;
  end;

  if FParams.ConnectionTimeOut = 0 then
    FParams.ConnectionTimeOut := cDefConnectionTimeout;
  if FParams.SendTimeout = 0 then
    FParams.SendTimeout := cDefSendTimeout;
  if FParams.ReceiveTimeout = 0 then
    FParams.ReceiveTimeout := cDefReceiveTimeout;

  if FParams.IsHttps then FURL := 'https://'
  else FURL := 'http://';
  FURL := FURL + FParams.Server + ':' + IntToStr(FParams.Port) + '/';
  FContextList:= TList.Create;
end;

destructor THttpConnection.Destroy;
begin
  Include(FComponentState, hosDestroying);
  // ContextList 不处理释放问题
//  for I := FContextList.Count - 1 downto 0 do
//  begin
//    cObj := THttpContext(FContextList[i]);
//    Include(cObj.FComponentState, hosFreeNotification);
//    FContextList.Delete(i);
//  end;

  FContextList.Free;
  inherited;
end;

function THttpConnection.GetParams: PConnectParams;
begin
  Result := @FParams;
end;

function THttpConnection.Async(Sender: TObject; API, Method: string;
    AData: TDataRequest; AOptions: TContextOptions = []): Boolean;
var
  cContext: THttpContext;
begin
  // 异步处理请求
  cContext := BuildContext(Sender, API, Method);
  cContext.Datas := AData;
  cContext.FOptions := AOptions;
  Result := cContext.Request = ID_OK;
end;

function THttpConnection.Async(Sender: TObject; API, Method, AParams: string): Boolean;
begin
  // 异步执行不返回值
  //  主要用于写日志之类的操作，不作返回值处理
  Result := Async(Sender, API, Method,
        TDataRequest.Build(Sender, UTF8Encode(AParams), [dboAutoFree]),
        [coDumpResponseData, coDisableZip]);
end;

function THttpConnection.Await(Sender: TObject; const API, Method: string;
    AData: TDataRequest; AOptions: TContextOptions = []): Boolean;
var
  cContext: THttpContext;
  cWorkThread: TWorkThread;
  hEvent: THandle;
begin
  // 异步处理请求
  hEvent := CreateEvent(nil, True, False, 'RequestData');
  if hEvent = 0 then
  begin
    WriteLog(lkErr, 'Http Request CreateEvent failed %s', [GetLastError()]);
    Exit(False);
  end;

  LogWriter.Add(lkDebug, 'WinHttp Await :' + AData.FOwner.ClassName + ' Method:' + Method + ' URL: ' + API);

  //WriteLog(lkDebug, '1/4 CreateEvent %x', [hEvent]);
  cContext := BuildContext(Sender, API, Method);
  cContext.Datas := AData;
  cContext.FOptions := AOptions;
  cContext.FWaitEvent := hEvent;

  // 使用同步等待线程
  cWorkThread := TWorkThread.Create(cContext);
  cWorkThread.FAPI := API;

  cWorkThread.Start;
  cWorkThread.WaitFor;
  cWorkThread.Free;

  CloseHandle(hEvent);

  LogWriter.Add(lkDebug, 'WinHttp Await : End ' + API);

  Result := True;
end;


function THttpConnection.BuildContext(Sender: TObject; const API, AMethod:
    string): THttpContext;
begin
  Result := nil;
end;

{ TWinHttpConnection }

function TWinHttpConnection.BuildContext(Sender: TObject; const API, AMethod: string): THttpContext;
begin
  Result := THttpRequestContext.Create(Self);
  Result.FIsHttps := FParams.IsHttps;
  Result.FSender := Sender;
  Result.API := API;
  Result.Method := AMethod;
end;

procedure TWinHttpConnection.Close;
begin
  WaitCloseAllRequest;

  if Assigned(FSession) then
    WinHttpAPI.SetStatusCallback(FSession, nil, 0, 0); // WinHTTPSecurityErrorCallback
  InternetCloseHandle(FConnection);
  InternetCloseHandle(FSession);

  FConnection := nil;
  FSession := nil;
  WriteLog(lkWarn, 'close winhttp connecting');
end;

constructor TWinHttpConnection.Create(AOwner: TObject;
  const AParams: TConnectParams);
begin
  inherited;
  InternalConnect;
end;

destructor TWinHttpConnection.Destroy;
begin
  Include(FComponentState, hosDestroying);

  if Assigned(FSession) then
    WinHttpAPI.SetStatusCallback(FSession, nil, 0, 0); // WinHTTPSecurityErrorCallback

  InternetCloseHandle(FConnection);
  InternetCloseHandle(FSession);
  inherited;
end;

function GetCallbackName(dwInternetStatus: DWORD): string;
begin
  case dwInternetStatus of
    WINHTTP_CALLBACK_STATUS_RESOLVING_NAME      : Result := 'RESOLVING_NAME';
    WINHTTP_CALLBACK_STATUS_NAME_RESOLVED       : Result := 'NAME_RESOLVED';
    WINHTTP_CALLBACK_STATUS_CONNECTING_TO_SERVER: Result := 'CONNECTING_TO_SERVER';
    WINHTTP_CALLBACK_STATUS_CONNECTED_TO_SERVER : Result := 'CONNECTED_TO_SERVER';
    WINHTTP_CALLBACK_STATUS_SENDING_REQUEST     : Result := 'SENDING_REQUEST';
    WINHTTP_CALLBACK_STATUS_REQUEST_SENT        : Result := 'REQUEST_SENT';
    WINHTTP_CALLBACK_STATUS_RECEIVING_RESPONSE  : Result := 'RECEIVING_RESPONSE';
    WINHTTP_CALLBACK_STATUS_RESPONSE_RECEIVED   : Result := 'RESPONSE_RECEIVED';
    WINHTTP_CALLBACK_STATUS_CLOSING_CONNECTION  : Result := 'CLOSING_CONNECTION';
    WINHTTP_CALLBACK_STATUS_CONNECTION_CLOSED   : Result := 'CONNECTION_CLOSED';
    WINHTTP_CALLBACK_STATUS_HANDLE_CREATED      : Result := 'HANDLE_CREATED';
    WINHTTP_CALLBACK_STATUS_HANDLE_CLOSING      : Result := 'HANDLE_CLOSING';
    WINHTTP_CALLBACK_STATUS_DETECTING_PROXY     : Result := 'DETECTING_PROXY';
    WINHTTP_CALLBACK_STATUS_REDIRECT            : Result := 'REDIRECT';
    WINHTTP_CALLBACK_STATUS_INTERMEDIATE_RESPONSE : Result := 'INTERMEDIATE_RESPONSE';
    WINHTTP_CALLBACK_STATUS_SECURE_FAILURE      : Result := 'SECURE_FAILURE';
    WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE   : Result := 'HEADERS_AVAILABLE';
    WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE      : Result := 'DATA_AVAILABLE';
    WINHTTP_CALLBACK_STATUS_READ_COMPLETE       : Result := 'READ_COMPLETE';
    WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE      : Result := 'WRITE_COMPLETE';
    WINHTTP_CALLBACK_STATUS_REQUEST_ERROR       : Result := 'REQUEST_ERROR';
    WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE : Result := 'SENDREQUEST_COMPLETE';
    else Result := format('unknown %X', [dwInternetStatus]);
  end;
end;

procedure WinHTTPRequestCallback(
      hInternet: HINTERNET;
      dwContext: DWORD_PTR;
      dwInternetStatus: DWORD;
      lpvStatusInformation: LPVOID;
      dwStatusInformationLength: DWORD); stdcall;
var
  cContext: THttpContext;
begin
  {$ifdef debug}
//  WriteLog(lkDebug, 'Request Callback hInternet:%0.8X  dwContext: $%0.8X  state: %6X %s', [
//      integer(hInternet),
//      integer(dwContext),
//      dwInternetStatus, GetCallbackName(dwInternetStatus)]);
  {$endif}

  if dwContext = 0 then Exit;
  cContext := THttpContext(dwContext);
  if cContext.ComponentState * [hosDestroying, hosCloseing] <> [] then
    Exit;

  case dwInternetStatus of
    WINHTTP_CALLBACK_STATUS_SENDREQUEST_COMPLETE,
    WINHTTP_CALLBACK_STATUS_WRITE_COMPLETE:
      cContext.DoSendRequestComplete(dwStatusInformationLength);
    WINHTTP_CALLBACK_STATUS_HEADERS_AVAILABLE:
      cContext.DoHeadersAvailable(dwStatusInformationLength);
    WINHTTP_CALLBACK_STATUS_DATA_AVAILABLE:
      cContext.DoDataAvailable(lpvStatusInformation);
    WINHTTP_CALLBACK_STATUS_READ_COMPLETE:
      cContext.DoReadComplete(lpvStatusInformation, dwStatusInformationLength);
    //WINHTTP_CALLBACK_STATUS_REDIRECT:;
    //WINHTTP_CALLBACK_STATUS_CLOSE_COMPLETE:;
    WINHTTP_CALLBACK_STATUS_REQUEST_ERROR:
      cContext.DoRequestError(LPWINHTTP_ASYNC_RESULT(lpvStatusInformation));
  end;
end;


procedure TWinHttpConnection.InternalConnect;
var
  iOpenType: integer;
  pCallback: TWinHttpStatusCallback;
  CallbackRes: PtrInt absolute pCallback;
  iProtocols: DWORD;
  sUserAgent: string;
begin
//  WaitForSingleObject()
  if OSVersionInfo.dwOSVersionInfoSize=0 then
  begin
    OSVersionInfo.dwOSVersionInfoSize := sizeof(OSVersionInfo);
    GetVersionEx(OSVersionInfo);
  end;

  iOpenType := WINHTTP_ACCESS_TYPE_NAMED_PROXY;
  if FParams.ProxyName='' then
  begin
    // Windows 8.1 and newer
    // https://docs.microsoft.com/en-us/windows/win32/api/winhttp/nf-winhttp-winhttpopen
    if (OSVersionInfo.dwMajorVersion>6) or
       ((OSVersionInfo.dwMajorVersion=6) and (OSVersionInfo.dwMinorVersion>=3)) then
      iOpenType := WINHTTP_ACCESS_TYPE_AUTOMATIC_PROXY
    else
      iOpenType := WINHTTP_ACCESS_TYPE_NO_PROXY
  end;

  sUserAgent := 'Mozilla/5.0 (Windows M8Client '+ ClassName+')';
  FSession := WinHttpAPI.Open(PChar(sUserAgent), iOpenType,
                              PChar(FParams.ProxyName), PChar(FParams.ProxyByPass),
                              WINHTTP_FLAG_ASYNC); // 全部采用异步模式

  if not Assigned(FSession) then
    RaiseLastModuleError(WinHttpDll, EWinHTTP);

  // cf. http://msdn.microsoft.com/en-us/library/windows/desktop/aa384116
  // HTTP_DEFAULT_RESOLVETIMEOUT
  WinHttpAPI.SetTimeouts(FSession, 0, FParams.ConnectionTimeOut, FParams.SendTimeout, FParams.ReceiveTimeout);

  if FParams.IsHttps then
  begin
     iProtocols := WINHTTP_FLAG_SECURE_PROTOCOL_SSL3 or
                   WINHTTP_FLAG_SECURE_PROTOCOL_TLS1;
     // Windows 7 and newer support TLS 1.1 & 1.2
     if (OSVersionInfo.dwMajorVersion>6) or
       ((OSVersionInfo.dwMajorVersion=6) and (OSVersionInfo.dwMinorVersion>=1)) then
       iProtocols :=  iProtocols or
                      WINHTTP_FLAG_SECURE_PROTOCOL_TLS1_1 or
                      WINHTTP_FLAG_SECURE_PROTOCOL_TLS1_2;

    if not WinHttpAPI.SetOption(FSession, WINHTTP_OPTION_SECURE_PROTOCOLS,
                                @iProtocols, SizeOf(iProtocols)) then
      RaiseLastModuleError(winhttpdll,EWinHTTP);

//    pCallback := WinHttpAPI.SetStatusCallback(FSession, WinHTTPSecurityErrorCallback,
//                                    WINHTTP_CALLBACK_FLAG_SECURE_FAILURE, 0);
//    if CallbackRes = WINHTTP_INVALID_STATUS_CALLBACK then
//      RaiseLastModuleError(winhttpdll,EWinHTTP);
  end;

  fConnection := WinHttpAPI.Connect(FSession, PChar(FParams.Server), FParams.Port, 0);
  if fConnection=nil then
    RaiseLastModuleError(winhttpdll, EWinHTTP);
end;

procedure TWinHttpConnection.InternetCloseHandle(var h: HINTERNET);
begin
  if h <> nil then
    WinHttpAPI.CloseHandle(h);
  h := nil;
end;

procedure TWinHttpConnection.WaitCloseAllRequest;
begin
  // TODO -cMM: TWinHttpConnection.WaitCloseAllRequest default body inserted
end;

procedure THttpContext.CloseRequst;
var
  cReqHandle: HINTERNET;
begin
{$ifdef debug}
//  WriteLog(lkDebug, format('THttpContext %3d CloseRequst', [FDebugID]));
{$endif}
  if ComponentState * [hosCloseing] <> [] then
    Exit;

  Include(FComponentState, hosCloseing);
  if Assigned(FRequestHandle) then
  begin
    cReqHandle := FRequestHandle;
    FRequestHandle := nil;
    WinHttpAPI.SetStatusCallback(cReqHandle, nil, 0, 0);
    WinHttpAPI.CloseHandle(cReqHandle);
  end;

  if ComponentState * [hosDestroying, hosFreeNotification] = [] then
    DoResponseData;

  if FWaitEvent <> 0 then
  begin
    if not SetEvent(FWaitEvent) then
      FErrorMsg := Format('SetEvent failed (%d)', [GetLastError()]);
    //WriteLog(lkDebug, '3/4 SetEvent %x  %x', [FWaitEvent, integer(cReqHandle)]);
    FWaitEvent := 0;
  end;

  if ComponentState * [hosDestroying, hosFreeNotification] = [] then
    Free;
end;

constructor THttpContext.Create(AOwner: TObject);
begin
  {$ifdef debug}
  inc(_MaxDebugID);
  FDebugID := _MaxDebugID;
  {$endif}
  FCode := 0;
  FOwner := AOwner;
  FResponseReadSize := 0;
  FWaitEvent := 0;
  if Assigned(FOwner) and (FOwner is THttpConnection) then
    THttpConnection(FOwner).FContextList.Add(Self);
  FResponseTmpData := TMemoryStream.Create;
end;

destructor THttpContext.Destroy;
begin
  Include(FComponentState, hosDestroying);

  {$ifdef Debug}
//    WriteLog(lkDebug , format('THttpContext %3d Destroy', [FDebugID]));
  {$endif}
  if (FComponentState * [hosFreeNotification] <> []) and Assigned(FOwner) then
    if (FOwner is THttpConnection) and (THttpConnection(FOwner).ComponentState * [hosDestroying] = []) then
      THttpConnection(FOwner).FContextList.Remove(Self);

  if Assigned(FRequestHandle) then
  begin
    WinHttpAPI.SetStatusCallback(FRequestHandle, nil, 0, 0);
    WinHttpAPI.CloseHandle(FRequestHandle);
    FRequestHandle := nil;
  end;

  if Assigned(FResponseTmpData) then
    FreeAndNil(FResponseTmpData);

  if Assigned(FDatas) then
  begin
    FDatas.DecRef;
    FDatas := nil;
  end;
  inherited;
end;

function THttpContext.InternalGetInfo(Info: DWORD): RawByteString;
var dwSize, dwIndex: DWORD;
    tmp: RawByteString;
    i: integer;
begin
  result := '';
  dwSize := 0;
  dwIndex := 0;
  if not WinHttpAPI.QueryHeaders(FRequestHandle, Info, nil, nil, dwSize, @dwIndex) and
     (GetLastError = ERROR_INSUFFICIENT_BUFFER) then
  begin
    SetLength(tmp,dwSize);
    if WinHttpAPI.QueryHeaders(FRequestHandle, Info, nil, pointer(tmp), dwSize, @dwIndex) then begin
      dwSize := dwSize shr 1;
      SetLength(result,dwSize);
      for i := 0 to dwSize-1 do // fast ANSI 7 bit conversion
        PByteArray(result)^[i] := PWordArray(tmp)^[i];
    end;
  end;
end;

function THttpContext.InternalGetInfo32(Info: DWORD): DWORD;
var dwSize, dwIndex: DWORD;
begin
  dwSize := sizeof(result);
  dwIndex := 0;
  Info := Info or WINHTTP_QUERY_FLAG_NUMBER;
  if not WinHttpAPI.QueryHeaders(FRequestHandle, Info, nil, @result, dwSize, @dwIndex) then
    result := 0;
end;

function THttpContext.PushBuffer(Buffer: Pointer; Size: DWORD): Boolean;
var
  iWriteSize: Longint;
begin
  // 对于没有压缩的数据直接放到目标流中
  iWriteSize := FResponseTmpData.Write(buffer^, Size);
  Result := DWORD(iWriteSize) = Size;
  if Result then
  begin
    FResponseReadSize := FResponseReadSize + Size;
    if Assigned(FDatas) then
      FDatas.Progress(FResponseReadSize, FOutDataLength);
  end;
end;

procedure THttpContext.WriteLastRequestError;
begin
  // last error info
  FLastError := GetLastError;
  if FLastError <> NO_ERROR then
    FErrorMsg := SysErrorMessagePerModule(FLastError, WinHttpDll)
  else
  begin
    FLastError := ERROR_BAD_NET_RESP;
    FErrorMsg := 'Undefined error';
  end;

end;

function THttpContext.QueryData: boolean;
begin
	Result := WinHttpAPI.QueryDataAvailable(FRequestHandle, nil);
  if not Result then
    WriteLastRequestError;
end;

function THttpContext.ReadData(Size: DWORD): Boolean;
begin
  if FBufferSize = 0 then
    InitBuff;

  Result := WinHttpAPI.ReadData(FRequestHandle, @PByteArray(FBuffer)[0], FBufferSize, nil);
  if not Result then
    WriteLastRequestError;
end;

function THttpContext.Request: Integer;
begin
  Include(FComponentState, hosWriting);
  Result := integer(DoRequest);
  Exclude(FComponentState, hosWriting);
  if Result <> S_OK then
  begin
    WriteLastError;
    CloseRequst;
  end;

end;

procedure THttpContext.ConvertRequestBuffer;
var
  sEncoding: string;
begin
  // 转换接收的缓存数据
  // GZIP, BR
  if assigned(FDatas) then
  begin
    sEncoding := UTF8ToString(FEncoding);
    if sEncoding = '' then
      FDatas.WriteData(TMemoryStream(FResponseTmpData).Memory, FResponseTmpData.Size)
    else if sEncoding = 'gzip' then
    begin
      if Assigned(FResponseTmpData) then
      begin
        GZReadToStream(FResponseTmpData, FDatas.OutData);
        FreeAndNil(FResponseTmpData);
      end;
    end
    else
      raise Exception.Create('Encoding 不支持: ' + sEncoding);
  end;
end;

procedure THttpContext.DoSendRequestComplete(dwStatusInformationLength: DWORD);
begin
	// 准备接收请求响应
  if (FDatas.States * [drsCancel] <> []) then
    CloseRequst
  else if not WinHttpAPI.ReceiveResponse(FRequestHandle, nil) then
  begin
    WriteLastRequestError;
    CloseRequst;
  end;
end;

procedure THttpContext.DoHeadersAvailable(dwStatusInformationLength: DWORD);
begin
  if (FDatas.States * [drsCancel] <> [])  then
  begin
    CloseRequst;
  end
  else
  begin
    FCode := InternalGetInfo32(WINHTTP_QUERY_STATUS_CODE);
    if (FOptions * [coDumpResponseData] = []) then
    begin
      //WriteLog(lkDebug, UTF8ToString(InternalGetInfo(WINHTTP_QUERY_RAW_HEADERS_CRLF)));
      FEncoding := InternalGetInfo(WINHTTP_QUERY_CONTENT_ENCODING);
      //FAcceptEncoding := InternalGetInfo(WINHTTP_QUERY_ACCEPT_ENCODING);
      FOutDataLength := InternalGetInfo32(WINHTTP_QUERY_CONTENT_LENGTH);
      //FContentType := InternalGetInfo(WINHTTP_QUERY_CONTENT_TYPE);

      // 读取数据
      if (FCode = HTTP_STATUS_OK)  then
      begin
        if not QueryData then
          CloseRequst;
      end
      else
        CloseRequst;
    end
    else
      CloseRequst;
  end;

  //WriteLog(lkDebug, 'readheader %x  size: %d', [integer(self), FOutDataLength]);
end;

procedure THttpContext.DoDataAvailable(lpvStatusInformation: LPVOID);
var
  iSize: DWORD;
begin
  if (FDatas.States * [drsCancel] <> []) then
  begin
    CloseRequst;
  end
  else
  begin
    iSize := LPDWORD(lpvStatusInformation)^;
    // iSize = 0 数据接收完成
    if (iSize > 0) then
    begin
      if not ReadData(iSize) then
        CloseRequst;
    end
    else
    begin
      ConvertRequestBuffer;
      CloseRequst;
    end;
  end;
end;

procedure THttpContext.DoReadComplete(lpvStatusInformation: LPVOID; dwStatusInformationLength: DWORD);
var
  bWrite: Boolean;
begin
  if dwStatusInformationLength > 0  then
  begin
    bWrite := PushBuffer(lpvStatusInformation, dwStatusInformationLength);
    if not bWrite or not QueryData then
      CloseRequst;
  end;
end;

procedure THttpContext.DoRequestError(lpvStatusInformation: LPWINHTTP_ASYNC_RESULT);
begin
  case lpvStatusInformation.dwResult of
    API_RECEIVE_RESPONSE      :;
    API_QUERY_DATA_AVAILABLE  :;
    API_READ_DATA             :;
    API_WRITE_DATA            :;
    API_SEND_REQUEST          :;
  end;
  if FCode = 0 then
    FCode := HTTP_STATUS_SERVICE_UNAVAIL;
  WriteLastRequestError;
  CloseRequst;
  WriteLog(lkErr, 'Server request error dwResult: %d dwError: %d'#13#10'%d:%s' ,
      [lpvStatusInformation.dwResult, lpvStatusInformation.dwError,
       FLastError, FErrorMsg]);
end;

procedure THttpContext.DoResponseData;
begin
  if Assigned(FDatas) then
  begin
    FDatas.FLastError := FLastError;
    FDatas.FErrorMsg := FErrorMsg;
    FDatas.FinishRequest(FCode);
    if Assigned(FOnFinshed) then
      FOnFinshed(Self);
    FDatas.DecRef;
    FDatas := nil;
  end;
end;

function THttpContext.IsCancel: Boolean;
begin
  Result := (ComponentState * [hosCloseing, hosDestroying, hosFreeNotification] <> []) or
             not Assigned(FDatas) or
             (FDatas.States * [drsCancel] <> []);
end;

function THttpContext.IsHttps: Boolean;
begin
  Result := TWinHttpConnection(Owner).FParams.IsHttps;
end;

procedure THttpContext.WriteLastError;
begin
  LastError := GetLastError;
  if LastError <> NO_ERROR then
    ErrorMsg := Format('%s error %d (%s)', [ClassName,LastError, SysErrorMessagePerModule(LastError, WinHttpDll)])
  else
    ErrorMsg := Format('Undefined %s error',[WinHttpDll]);
end;

procedure THttpContext.SetDatas(const Value: TDataRequest);
begin
  assert(FDatas = nil, 'SetDatas 有多处赋值请求数据设置 ');

  FDatas := Value;
  if Assigned(FDatas) then
    FDatas.AddRef;
end;

function THttpContext.SetOption(AOpt, AFlags: DWORD): Boolean;
begin
 Result := WinHttpAPI.SetOption(FRequestHandle, AOpt, @AFlags, sizeOf(AFlags));
end;

function THttpContext.AddHeader(const Data: string): boolean;
begin
  Result := True;
  if (Data<>'') then
  begin
    Result := WinHttpAPI.AddRequestHeaders(FRequestHandle, PChar(Data), length(Data),
      WINHTTP_ADDREQ_FLAG_COALESCE);
  end;
end;



function THttpContext.DoRequest: Cardinal;
const
  ALL_ACCEPT: array[0..1] of PWideChar = ('*/*',nil);
  IGNRECERTOPTS = SECURITY_FLAG_IGNORE_UNKNOWN_CA or
                  SECURITY_FLAG_IGNORE_CERT_DATE_INVALID or
                  SECURITY_FLAG_IGNORE_CERT_CN_INVALID or
                  SECURITY_FLAG_IGNORE_CERT_WRONG_USAGE;
var
  bSended: Boolean;
  iFlags: DWORD;
  pCallback: TWinHttpStatusCallback;
  CallbackRes: PtrInt absolute pCallback;
  L: DWORD;
  rData: RawByteString;
begin
  Result := ERROR_WINHTTP_INVALID_URL;
  if (API = '') or (Method = '') then
    Exit;

  if TWinHttpConnection(Owner).FConnection = nil then
    TWinHttpConnection(Owner).InternalConnect;

  // options for a true RESTful request
  iFlags := WINHTTP_FLAG_REFRESH;
  if FIsHttps then
    iFlags := iFlags or WINHTTP_FLAG_SECURE;


  FRequestHandle := WinHttpAPI.OpenRequest(TWinHttpConnection(Owner).FConnection,
                PChar(Method), PChar(API), nil, nil, @ALL_ACCEPT, iFlags);
  if not Assigned(FRequestHandle) then
    Exit;
    // callback set
  pCallback := WinHttpAPI.SetStatusCallback(FRequestHandle,
                  WinHTTPRequestCallback,
                  WINHTTP_CALLBACK_FLAG_ALL_NOTIFICATIONS, 0);
  if WINHTTP_INVALID_STATUS_CALLBACK = CallbackRes then
    Exit;

  //if FKeepAlive = 0 then
  //  SetOption(cRequest, WINHTTP_OPTION_DISABLE_FEATURE, WINHTTP_DISABLE_KEEP_ALIVE);

  // SSL ignore certificates
  if iFlags and WINHTTP_FLAG_SECURE = WINHTTP_FLAG_SECURE then
  begin
    if not SetOption(WINHTTP_OPTION_SECURITY_FLAGS, IGNRECERTOPTS) then
      Exit;
  end;

  if FOptions * [coDisableZip] = [] then
    if not AddHeader('Accept-Encoding: gzip') then
      Exit;
  if not AddHeader('Content-Type: application/json; charset=utf-8') then
    Exit;

  rData := FDatas.Params;
  L := length(rData);
  bSended :=  WinHttpAPI.SendRequest(FRequestHandle, nil,0,
                  pointer(rData),L,L,
                  DWORD_PTR(Pointer(Self)));

  if bSended then
    Result := S_OK;
end;

procedure THttpContext.InitBuff;
var
  iBytes: DWORD;
begin
  if FBufferSize = 0 then
  begin
    iBytes := DownloadChunkSize;
    if iBytes <= 0 then iBytes := 65536; // 64KB
    SetLength(FBuffer, iBytes);
    FBufferSize := iBytes;
  end;
end;


constructor TWorkThread.Create(AContext: THttpContext);
begin
  inherited Create(True);
  FWaitCount := 0;
  FContext := AContext;
  FLoading := True;
  FWaitEvent := FContext.FWaitEvent;
end;

{ TWorkThread }

procedure TWorkThread.Execute;
const
  MAXCNT = 120000;
var
  res: Cardinal;
  iwait: Cardinal;
begin
  assert(FWaitEvent <> 0, 'Http wait event not create');
  iWait := WAIT_OBJECT_0;
  res := FContext.Request;
  if res = S_OK then
    iWait := WaitForSingleObject(FWaitEvent, MAXCNT);
  if iWait <> WAIT_OBJECT_0 then
    WriteLog(lkWarn, 'Request http %s Fa' , [FAPI]);
end;

procedure TConnectParams.Init(const ASvr: string; APort: word; AIsSSL:
    boolean);
begin
  Server := ASvr;
  Port := APort;
  IsHttps := AIsSSL;
  ProxyName:= '';
  ProxyByPass:= '';
  ConnectionTimeOut:= 0;
  SendTimeout:= 0;
  ReceiveTimeout:= 0;
end;

constructor TDataRequest.Create(AOwner: TObject);
begin
  FReadFinishedFree := False;
  FOwner := AOwner;
  //FParams:= TStringStream.Create('', TEncoding.UTF8);
  FIsOwnerParam := False;
  FIsOwnerData := True;
  FDatas := TStringStream.Create('', TEncoding.UTF8);
  {$ifdef Debug}
  //WriteLog(lkDebug, 'TDataRequest Create');
  {$endif}

end;

destructor TDataRequest.Destroy;
begin
  assert(FRefCnt = 0, '引用计数自释放模式，需要调用DecRef 进行释放。');

//  if FIsOwnerParam then
//    FreeAndNil(FParams);
  if FIsOwnerData then
    FreeAndNil(FDatas);

  {$ifdef Debug}
  //WriteLog(lkDebug, format('TDataRequest Destroy %s', [UserData]));
  {$endif}

  inherited;
end;

procedure TDataRequest.AddRef;
begin
  InterlockedIncrement(FRefCnt);
  {$ifdef Debug}
//  Writeln('TDataRequest AddRef ' + intToStr(FRefCnt));
  {$endif}
end;

procedure TDataRequest.DecRef;
begin
  InterlockedDecrement(FRefCnt);
  assert(FRefCnt >= 0, '引用计数自释放模式必须同AddRef配合使用');

//  {$ifdef Debug}
//  Writeln('TDataRequest DecRef ' + intToStr(FRefCnt));
//  {$endif}

  if FRefCnt = 0 then
    Free;
end;

procedure TDataRequest.Cancel;
begin
  Include(FStates, drsCancel);
  {$ifdef Debug}
//  Writeln('TDataRequest Cancel request');
  {$endif}
end;

class procedure TDataRequest.Close(var ARequest: TDataRequest);
begin
  if Assigned(ARequest) then
  begin
    ARequest.Cancel;
    ARequest.DecRef;
    ARequest := nil;
  end;
end;

class function TDataRequest.BuildOf(AClass: TDataRequestClass; AOwner: TObject;
    const AParams: RawByteString; const AUserData: string;
    AFinishedFun: TRequestFinishedEvent; AOpts: TDataBuildOptions = []): TDataRequest;
var
  cData: TDataRequest;
begin
  cData := TDataRequest(AClass.NewInstance).Create(AOwner);
  cData.SetParams(AParams);
  cData.UserData := AUserData;
  cData.OnDownloadFinished := AFinishedFun;
  if AOpts * [dboAutoFree] = [] then
    cData.AddRef;
  Result := cData;
end;

class function TDataRequest.Build(AOwner: TObject; const AParams: RawByteString;
    const AUserData: string; AFinishedFun: TRequestFinishedEvent;
    AOpts: TDataBuildOptions): TDataRequest;
begin
  ///  创建请求数据对象
  ///
  ///  参数： AParams       --- 请求Json参数 UTF8
  ///         AUserData     --- 用户自定义数据，类似 Tag
  ///         AFinishedFun  --- 完成请求回调函数
  ///         IsAutoFree    --- 是否自动释放
  ///                 True： 请求完成后TDataRequest对象Free自动释放，不需要显示调用关闭
  ///                 False: 由外部控制释放时机
  ///
  Result := TDataRequest.BuildOf(TDataRequest, AOwner, AParams, AUserData, AFinishedFun, AOpts);
end;

class function TDataRequest.Build(AOwner: TObject; const AParams: RawByteString;
    const AUserData: string; AOpts: TDataBuildOptions): TDataRequest;
begin
  Result := TDataRequest.BuildOf(TDataRequest, AOwner, AParams, AUserData, nil, AOpts);
end;

class function TDataRequest.Build(AOwner: TObject; const AParams: RawByteString;
    AOpts: TDataBuildOptions): TDataRequest;
begin
  Result := TDataRequest.BuildOf(TDataRequest, AOwner, AParams, '', nil, AOpts);
end;

class function TDataRequest.Build(AOwner: TObject; const AParams, AOutData: TStream;
    AOpts: TDataBuildOptions):TDataRequest;
var
  cData: TDataRequest;
begin
  cData := TDataRequest.Create(AOwner);
  cData.SetParams(AParams);
  cData.OutData := AOutData;
  if AOpts * [dboAutoFree] = [] then
    cData.AddRef;
  Result := cData;
end;

procedure TDataRequest.DoDownloadFinished;
begin
  if Assigned(FOnDownloadFinished) then
    FOnDownloadFinished(Self, FCode);
end;

procedure TDataRequest.FinishRequest(ACode: DWORD);
begin
  FCode := ACode;
  Include(FStates, drsResponeFinished);
  if (FStates * [drsCancel] = []) then
  begin
    Try
      DoDownloadFinished;
    except on E: exception do
      LogWriter.Err('TDataRequest.FinishRequest', E.ClassName + E.Message);
    End;
  end;
end;

function TDataRequest.GetOutData: TStream;
begin
  Result := FDatas;
end;

function TDataRequest.GetOutLength: Int64;
begin
  Result := FDatas.Size;
end;

function TDataRequest.GetParams: RawByteString;
begin
  Result := FParams;
end;

function TDataRequest.GetParamsLen: int64;
begin
  Result := Length(FParams);
end;

function TDataRequest.OutText: RawByteString;
var
  iLen: Cardinal;
begin
  iLen := OutData.Size;
  if iLen > 0 then
  begin
    SetLength(Result, iLen);
    OutData.Position := 0;
    OutData.Read(PByteArray(Result)[0], iLen);
  end
  else
    Result := UTF8Encode('{}');
end;

procedure TDataRequest.Progress(Size, ContentLength: DWORD);
begin
  if (FStates * [drsCancel] = []) and Assigned(OnProgress) then
    OnProgress(Self, Size, ContentLength);
end;

procedure TDataRequest.SetParams(const s: RawByteString);
begin
  FParams := s;
end;

procedure TDataRequest.SetParams(s: TStream);
begin
  if s is TStringStream then
    SetParams(UTF8Encode(TStringStream(s).DataString))
  else
  begin
    s.Position := 0;
    with TStringStream.Create('', TEncoding.UTF8) do
    begin
      LoadFromStream(s);
      SetParams(UTF8Encode(DataString));
      Free;
    end;
  end;
end;

function TDataRequest.ReadParams(var Buffer; Count: Integer): Longint;
begin
  raise Exception.Create('未实现 TDataRequest.ReadParams');
end;

function TDataRequest.PrepareData: Int64;
begin
  Result := ParamsLen;
end;

procedure TDataRequest.SetOutData(const Value: TStream);
begin
  if FIsOwnerData and Assigned(FDatas) then
    FreeAndNil(FDatas);
  FDatas := Value;
  FIsOwnerData := False;
end;

function TDataRequest.WriteData(Buffer: Pointer; Size: DWORD): Longint;
begin
  Result := 0;
  if Assigned(FDatas) then
    Result := FDatas.Write(Buffer^, Size);
end;


procedure TConnectParams.InitOf(const Addr: string);
const
  DEFAULT_PORT: array[boolean] of Integer = (80, 443);

var
  idx: Integer;
  bIsSSL: Boolean;
  sSvr, sPost: string;
  iPost: Integer;
begin
  // https:// sss:99
  bIsSSL := True;
  idx := pos('//', Addr);
  sSvr := Addr;
  if idx > 4 then
  begin
    bIsSSL := UpCase(sSvr[idx - 2]) = 'S';
    delete(sSvr, 1, idx + 1);
  end;

  sPost := ReadSegmentValue(sSvr, 1, ':');
  sSvr := ReadSegmentValue(sSvr, 0, ':');
  if not TryStrToInt(sPost, iPost) then
    iPost := DEFAULT_PORT[bIsSSL];

  Init(sSvr, iPost, bIsSSL);
end;

initialization
  Mutex :=TMutex.Create;
  FResponseList := TList.Create;

finalization
  FResponseList.Free;
  Mutex.Free;
  FResponseList := nil;
  Mutex := nil;
end.



