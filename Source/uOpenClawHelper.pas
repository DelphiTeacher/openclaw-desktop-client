unit uOpenClawHelper;

interface


uses
  Classes,
  SysUtils,
  IniFiles,
  Types,
  uFuncCommon,
  uFileCommon,
  uCommandLineHelper,
  XSuperObject,
  System.IOUtils;

type
  TOpenClawHelper=class
  public
    FAuthToken:String;
    FGatewayPort:Integer;
    //模型设置
    FAuthChoice:String;
    FCustomBaseUrl:String;
    FCustomModelId:String;
    FCustomApiKey:String;
    FCustomCompatibility:String;
    //获取openclaw的配置目录
    function GetOpenClawConfigDir:String;
    //获取openclaw是否已经配置过了
    function IsOpenClawConfigured:Boolean;
    function GetOpenClawConfigureFile:String;
    //获取openclaw的网关token，用于验证
    procedure GetOpenClawSetting;
    function GetGatewayUrl:String;
    //应用模型设置
    function ApplyModelSettingByCommand(var ADesc:String):Boolean;
  end;



var
  GlobalOpenClawHelper:TOpenClawHelper;

implementation

{ TOpenClawHelper }

procedure TOpenClawHelper.GetOpenClawSetting;
var
  AOpenClawJson:ISuperObject;
  ADefaultAgentModel:String;
  ADefaultAgentModelProvider:String;
  ADefaultAgentModelId:String;
begin
//  if not IsOpenClawConfigured then Exit;
  if not FileExists(GetOpenClawConfigureFile) then Exit;
  

  AOpenClawJson:=SO(GetStringFromFile(GetOpenClawConfigureFile,TEncoding.UTF8));
  FAuthToken:=AOpenClawJson.O['gateway'].O['auth'].S['token'];
  FGatewayPort:=AOpenClawJson.O['gateway'].I['port'];

  //获取默认应用所使用的模型ID
  //custom-dashscope-aliyuncs-com/qwen3.5-plus
  ADefaultAgentModel:=AOpenClawJson.O['agents'].O['defaults'].O['model'].S['primary'];
  //然后从models中获取设置
  ADefaultAgentModelProvider:=Copy(ADefaultAgentModel,1,Pos('/',ADefaultAgentModel)-1);
  ADefaultAgentModelId:=Copy(ADefaultAgentModel,Pos('/',ADefaultAgentModel)+1,MaxInt);
  FCustomBaseUrl:=AOpenClawJson.O['models'].O['providers'].O[ADefaultAgentModelProvider].S['baseUrl'];
  FCustomApiKey:=AOpenClawJson.O['models'].O['providers'].O[ADefaultAgentModelProvider].S['apiKey'];
  FCustomModelId:=ADefaultAgentModelId;

end;

function TOpenClawHelper.ApplyModelSettingByCommand(var ADesc:String):Boolean;
var
  ACommandLine:String;
//  ADesc:String;
begin
  Result:=False;

  // ARootDir:=GetApplicationPath;

  //读取设置,然后使用openclaw onboard命令来应用设置
//  ACommandLine:='onboard --non-interactive --auth-choice custom-api-key --custom-base-url "https://dashscope.aliyuncs.com/compatible-mode/v1" --custom-model-id "qwen3.5-plus" --custom-api-key "sk-5c2de62c553f41bdafa7357c390a0079" --secret-input-mode plaintext --custom-compatibility openai --accept-risk';
  ACommandLine:='"'+GetApplicationPath+'openclaw'+PathDelim+'openclaw.mjs" onboard --non-interactive --auth-choice custom-api-key --custom-base-url "'+Self.FCustomBaseUrl+'" --custom-model-id "'+Self.FCustomModelId+'" --custom-api-key "'+Self.FCustomApiKey+'" --secret-input-mode plaintext --custom-compatibility openai --accept-risk';
  Result:=ExecuteCommand(
    //如果可执行文件没有参数,而且路径带空格括号一些字符，那么需要用双引号括起来
    GetApplicationPath+'node'+PathDelim+'node.exe',
    'node',
    ACommandLine,
    '',
    '',
    nil,nil,ADesc
    );

  //获取最新的配置
  GetOpenClawSetting;

end;

function TOpenClawHelper.GetGatewayUrl: String;
begin
  //'http://127.0.0.1:18789/#token=2303f6528e8789d41201c7070eadb1e775d21df5e6b21324'
  Result:='http://localhost:'+IntToStr(Self.FGatewayPort)+'/#token='+Self.FAuthToken;
end;

function TOpenClawHelper.GetOpenClawConfigDir:String;
begin
  Result:=TPath.GetDocumentsPath+PathDelim+'..'+PathDelim+'.openclaw'+PathDelim;
end;

function TOpenClawHelper.IsOpenClawConfigured:Boolean;
begin
//  Result:=False;
//  Exit;
  Result:=DirectoryExists(GetOpenClawConfigDir);
end;

function TOpenClawHelper.GetOpenClawConfigureFile: String;
begin
  Result:=GetOpenClawConfigDir+'openclaw.json';
end;

initialization
  GlobalOpenClawHelper:=TOpenClawHelper.Create;
  GlobalOpenClawHelper.GetOpenClawSetting;

finalization
  FreeAndNil(GlobalOpenClawHelper);


end.
