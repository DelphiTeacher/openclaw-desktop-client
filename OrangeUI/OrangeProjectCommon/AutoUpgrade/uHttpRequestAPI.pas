unit uHttpRequestAPI;

interface

uses
  Classes, SynCrtSock, SysUtils;

type
  THttpSvrParam = record
    Addr: string;
    Port: integer;
    IsSSL: boolean;
//    APIPrefix: string;
//    FileListAPIPrefix: string;
  end;

  EHttpRequestSvr = class(Exception);

  THttpRequestSvr = class
  private
    FParams: THttpSvrParam;
    FHttpRequest: THttpRequest;
    FState: Integer;
    FHeader: SockString;
    FOutData : SockString;
    FAPIList: TStringList;

    function GetAPIAddrs(const AName: string): string;
    function GetURL(const API: string): string;
    function InternalRequest(const url, method: SockString; KeepAlive: cardinal;
        const InHeader, InData, InDataType: SockString): integer;
    procedure SetAPIAddrs(const AName: string; const Value: string);
  public
    constructor Create(AOwner: TObject); virtual;
    destructor  Destroy; override;

    procedure Init(const AServer: THttpSvrParam);

    function RequestOf(const URL, AMethod: string; const AData: string): Integer;
    function Request(const API, AMethod: string; const AData: string = ''): Integer;
    function Get(const API: string; const AParams: array of variant): Integer; overload;
    function Get(const API: string; const AData: string = ''): Integer; overload;
    function Post(const API: string; const AData: string = ''): Integer;
    function Delete(const API: string; const AData: string = ''): Integer;

    function Ping: Boolean;


    property APIAddrs[const AName: string]: string read GetAPIAddrs write SetAPIAddrs;
    property OutData: SockString read FOutData;
  end;

implementation

uses
  //uLogWriter,
  SynCommons, Variants, untCommFuns, uLangRes;


const
  APIName_Ping = 'Ping';
  APIName_Login = 'Login';
  APIName_Logout = 'Logout';
  APIName_Scope = 'Scope';
  APIName_Record = 'Record';

  MXHOST_Port = '4593';
{$ifdef debug}
  MXHOST = '192.168.0.103';
  MXISHTTPS = False;
{$else}
  MXHOST = 'mxsearch.laifuyun.com';
  MXISHTTPS = True;
{$endif}


function S2SS(const s: string):SockString;
begin
  Result := UTF8Encode(s);
end;

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


constructor THttpRequestSvr.Create(AOwner: TObject);
begin
  FAPIList := TStringList.Create;
end;

destructor THttpRequestSvr.Destroy;
begin
  FAPIList.Free;
  if assigned(FHttpRequest) then
    FHttpRequest.Free;
  inherited;
end;

function THttpRequestSvr.Ping: Boolean;
begin
  Result := Get(APIName_Ping, []) = 200;
end;

function THttpRequestSvr.Get(const API: string; const AParams: array of
    variant): Integer;
var
  cParamas: TStringBuilder;
  sURL: string;
  I: Integer;
  sVal: string;
begin
  sURL := GetURL(API);
  if Length(AParams) > 0 then
  begin
    cParamas := TStringBuilder.Create;
    try
      for I := 0 to Length(AParams) div 2 - 1 do
      begin
        cParamas.Append(v2s(AParams[i*2]));
        cParamas.Append('=');
        sVal := v2s(AParams[i*2 + 1]);
        if VarIsStr(AParams[i*2 + 1]) then
          sVal := UrlEncode(sVal);
        cParamas.Append(sVal);
        cParamas.Append('&');
      end;
      cParamas.Length := cParamas.Length - 1;

      sURL := sURL + '?' + cParamas.ToString;
    finally
      cParamas.Free;
    end;
  end;
  Result := InternalRequest(S2SS(sURL), 'GET', 0, '', '', '');
end;

function THttpRequestSvr.Get(const API: string; const AData: string = ''): Integer;
var
  sURL: string;
begin
  sURL := GetURL(API);
  if AData <> '' then
  begin
    if sURL[Length(sURL)] <> '/' then
      sURL := sURL + '/';
    sURL := sURL + AData;
  end;
  Result := InternalRequest(S2SS(sURL), 'GET', 0, '', '', '');
end;

function THttpRequestSvr.GetURL(const API: string): string;
var
  sAPI: string;
begin
  sAPI := FAPIList.Values[API];
//  if sAPI = '' then
//    raise EHttpRequestSvr.Create(SMSG_InvalidAPI + API);

  if (sAPI<>'') and (sAPI[1] <> '/') then
  begin
    sAPI := //'/' + FParams.APIPrefix +
            '/' + sAPI;
//  end
//  else
//  begin
//    sAPI := '/' + FParams.APIPrefix ;
  end;
  Result := sAPI;
end;

function THttpRequestSvr.InternalRequest(const url, method: SockString; KeepAlive:
    cardinal; const InHeader, InData, InDataType: SockString): integer;
begin
  try
    FState := FHttpRequest.Request(url, method, KeepAlive, InHeader, InData,
                  InDataType, FHeader, FOutData);
  except
    on E: Exception do
    begin
//      LogWriter.Add(lkErr, e.Classname + e.message);
      FState := STATUS_SERVERERROR;
    end;
  end;
  Result := FState;
end;

function THttpRequestSvr.Post(const API: string; const AData: string): Integer;
begin
  Result := Request(API, 'POST', AData);
end;

function THttpRequestSvr.RequestOf(const URL, AMethod: string; const AData: string): Integer;
var
  sURL: SockString;
  sType, sData: SockString;
begin
  sURL := S2SS(URL);
  sType := '';
  sData := '';
  if AData <> '' then
  begin
    sType := JSON_CONTENT_TYPE;
    sData := S2SS(AData);
  end;

  Result := InternalRequest(sURL, S2SS(AMethod), 0, '', sData, sType);
end;

function THttpRequestSvr.Request(const API, AMethod, AData: string): Integer;
begin
  Result := RequestOf(GetURL(API), AMethod, AData);
end;

function THttpRequestSvr.Delete(const API: string; const AData: string = ''): Integer;
begin
  Result := Request(API, 'DELETE', AData);
end;

function THttpRequestSvr.GetAPIAddrs(const AName: string): string;
begin
  Result := FAPIList.Values[AName];
end;

procedure THttpRequestSvr.Init(const AServer: THttpSvrParam);
begin
  if assigned(FHttpRequest) then
    FreeAndNil(FHttpRequest);

  FParams := AServer;
  FHttpRequest := THttpRequest(MainHttpClass.NewInstance).Create(
      S2SS(FParams.Addr),
      Int32ToUtf8(FParams.Port), // MXHOST_Port,
      FParams.IsSSL, //MXISHTTPS
      '','',30000
      );
end;

procedure THttpRequestSvr.SetAPIAddrs(const AName: string; const Value: string);
begin
  FAPIList.Values[AName] := Value;
end;

end.
