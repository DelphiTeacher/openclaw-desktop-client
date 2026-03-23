//convert pas to utf8 by ¥
unit uDataBaseConfig;

interface

uses
  Classes,
  SysUtils,
  IniFiles,
  StrUtils,
    {$IFDEF SKIN_SUPEROBJECT}
    uSkinSuperObject,
    uSkinSuperJson,
    {$ELSE}
    XSuperObject,
    XSuperJson,
    {$ENDIF}

  {$IF CompilerVersion>31}
  System.NetEncoding,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  {$ENDIF}


//  {$IFDEF MSWINDOWS}
  DES,
//  FlyUtils.AES,
//  {$ENDIF}

//  Forms,
  uBaseList,
//  uBinaryObjectList,
  Types;

const
  Const_Default_DBConfigFileName='DataBaseConfig.ini';

type
  TDataBaseConfig=class(TPersistent)
  public
    function LoadFromINI(AINIFilePath: String): Boolean;
    function SaveToINI(AINIFilePath: String): Boolean;

    procedure AssignTo(Dest: TPersistent); override;

  public
    fid:String;//数据库ID字段
    constructor Create;virtual;
    destructor Destroy;override;
  public
    procedure Clear;
    procedure Load(AIniFileName:String=Const_Default_DBConfigFileName);
    procedure Save(AIniFileName:String=Const_Default_DBConfigFileName);

    procedure SaveToJson(AJson:ISuperObject);
    procedure LoadFromJson(AJson:ISuperObject);
  public
    //给它取了个标题
    FName:String;

    //数据库类型
    FDBType:String;

    //数据库服务器
    FDBHostName:String;
    //数据库端口
    FDBHostPort:String;
    //数据库用户名
    FDBUserName:String;
    //数据库密码
    FDBPassword:String;
    //PostgreSQL在数据库中还有一层
    FDBSchema:String;
    FDBVersion:String;

    //数据库
    FDBDataBaseName:String;
    //Windows账户验证
    FDBOSAuth:Boolean;

    //字符集
    FDBCharset:String;

    FDBSSL:Boolean;

    //连接池最大连接数
    FMaxConnections:Integer;

    //连接方式
    FSpecificOptions_Provider:String;
    FSpecificOptions_NativeClientVersion:String;



    //数据库服务器
    FProxyHostName:String;
    //数据库端口
    FProxyHostPort:String;
    //数据库用户名
    FProxyUserName:String;
    //数据库密码
    FProxyPassword:String;
    //
    FProxyType:String;


    //数据库模块 在设计器时使用
    FDBModule:TObject;


    function IsEmpty:Boolean;
    function GetTablePrefix:String;
    function ServerUrl: String;
    {$IF CompilerVersion>31}
    function GetESDBNetHTTPRequestHeaders:TNetHeaders;
    {$ENDIF}

  end;



  TDataBaseConfigList=class(TBaseList)
  private
    function GetItem(Index: Integer): TDataBaseConfig;
  public
    function CreateItem:TDataBaseConfig;virtual;
    function Find(fid:String):TDataBaseConfig;
    function FindByName(AName:String):TDataBaseConfig;
    procedure SaveToJsonArray(AJsonArray:ISuperArray);
    procedure LoadFromJsonArray(AJsonArray:ISuperArray);
    property Items[Index:Integer]:TDataBaseConfig read GetItem;default;
  end;



var
  GlobalDataBaseConfig:TDataBaseConfig;
//  GlobalDataBaseConfigList:TDataBaseConfigList;


implementation


function GetApplicationPath:String;
begin
    Result:=ExtractFilePath(GetModuleName(HInstance));
end;

{ TDataBaseConfig }

function TDataBaseConfig.ServerUrl: String;
begin
  if not FDBSSL then
  begin
    Result:='http://'
  end
  else
  begin
    Result:='https://';//+Self.FDBHostName+':'+Self.FDBHostPort+'/';
  end;
  Result:=Result+Self.FDBHostName;
  if FDBHostPort<>'' then
  begin
    Result:=Result+':'+Self.FDBHostPort;
  end;
  Result:=Result+'/';
end;

procedure TDataBaseConfig.AssignTo(Dest: TPersistent);
var
  ADest:TDataBaseConfig;
begin
//  inherited;

  ADest:=TDataBaseConfig(Dest);
  if ADest<>nil then
  begin
    ADest.fid:=fid;


    ADest.FName:=FName;
    //数据库类型
    ADest.FDBType:=FDBType;

    //数据库服务器
    ADest.FDBHostName:=FDBHostName;
    //数据库端口
    ADest.FDBHostPort:=FDBHostPort;
    //数据库用户名
    ADest.FDBUserName:=FDBUserName;
    //数据库密码
    ADest.FDBPassword:=FDBPassword;
    ADest.FDBVersion:=FDBVersion;
    ADest.FDBSchema:=FDBSchema;

    //数据库
    ADest.FDBDataBaseName:=FDBDataBaseName;

    //字符集
    ADest.FDBCharset:=FDBCharset;

    //字符集
    ADest.FDBSSL:=FDBSSL;
    ADest.FDBOSAuth:=FDBOSAuth;




    ADest.FProxyType:=FProxyType;
    ADest.FProxyHostName:=FProxyHostName;
    ADest.FProxyHostPort:=FProxyHostPort;
    ADest.FProxyUserName:=FProxyUserName;
    ADest.FProxyPassword:=FProxyPassword;

  end;
end;

procedure TDataBaseConfig.Clear;
begin
  Self.FName:='';
  Self.FDBType:='';
  Self.FDBHostName:='';
  Self.FDBDataBaseName:='';
  Self.FDBUserName:='';
  Self.FDBPassword:='';
  Self.FDBHostPort:='';
  Self.FDBVersion:='';

  Self.FDBSSL:=False;
  FDBOSAuth:=False;

  Self.FProxyType:='';
  Self.FProxyHostName:='';
  Self.FProxyHostPort:='';
  Self.FProxyUserName:='';
  Self.FProxyPassword:='';


  Self.FDBCharset:='utf8';
  FMaxConnections:=100;
end;

constructor TDataBaseConfig.Create;
begin
  //默认设置
//  Self.FDBType:='MYSQL';
  Self.FDBType:='MSSQL';


  Self.FDBHostName:='';
  Self.FDBDataBaseName:='';
  Self.FDBUserName:='sa';
  Self.FDBPassword:='';
  Self.FDBHostPort:='1433';


  Self.FDBCharset:='utf8';

  FMaxConnections:=100;


//  if GlobalDatabaseConfigList<>nil then
//  begin
//    GlobalDatabaseConfigList.Add(Self);
//  end;

end;

destructor TDataBaseConfig.Destroy;
begin

//  if GlobalDatabaseConfigList<>nil then
//  begin
//    GlobalDatabaseConfigList.Remove(Self,False);
//  end;

  FreeAndNil(FDBModule);
  inherited;
end;

    {$IF CompilerVersion>31}
function TDataBaseConfig.GetESDBNetHTTPRequestHeaders: TNetHeaders;
var
  ANameValuePair:TNameValuePair;
begin
  if Self.FDBUserName<>'' then
  begin
    SetLength(Result,2);
    ANameValuePair.Name:= 'Authorization';
    //Basic bXhlczptZjJvZWc2VVU0ViM=
    ANameValuePair.Value:= 'Basic '+TNetEncoding.Base64.Encode(Self.FDBUserName+':'+Self.FDBPassword);
    Result[0]:=ANameValuePair;

    ANameValuePair.Name:= 'Content-type';
    ANameValuePair.Value:= 'application/json';
    Result[1]:=ANameValuePair;
  end
  else
  begin
    SetLength(Result,1);

    ANameValuePair.Name:= 'Content-type';
    ANameValuePair.Value:= 'application/json';
    Result[0]:=ANameValuePair;
  end;

end;
    {$ENDIF}

function TDataBaseConfig.GetTablePrefix: String;
begin
  Result:='';
  if SameText(FDBType,'MYSQL') then
  begin
    Result:=FDBDataBaseName+'.';
  end;

end;

function TDataBaseConfig.IsEmpty: Boolean;
begin
  //SQLITE则不需要主机名
  if SameText(FDBType,'SQLITE') then
  begin
    Result:=(FDBDataBaseName='')
            ;
  end
  else
  begin
    Result:=(FDBHostName='')
            or (FDBDataBaseName='')
            ;
  end;
end;

procedure TDataBaseConfig.Load(AIniFileName:String);
begin
  //如果AIniFileName是'Wxpay_DataBaseConfig.ini'
  //先判断文件是否存在
  if (Const_Default_DBConfigFileName<>AIniFileName)
    and FileExists(GetApplicationPath+AIniFileName) then
  begin
    Self.LoadFromINI(GetApplicationPath+AIniFileName);
  end
  else
  begin
    //加载默认的DataBaseConfig.ini
    Self.LoadFromINI(GetApplicationPath+Const_Default_DBConfigFileName);
  end;
end;

function StringHexToByte(Hex: AnsiString): Byte;
var
  I, Res: Byte;
  ch: AnsiChar;
begin
  if Length(Hex) <> 2 then
    raise Exception.Create('Error: not a Complete HEX String');
  Res := 0;
  for I := 0 to 1 do
  begin
    ch := AnsiChar(Hex[I + 1]);
    if (ch >= '0') and (ch <= '9') then
      Res := Res * 16 + Ord(ch) - Ord('0')
    else if (ch >= 'A') and (ch <= 'F') then
      Res := Res * 16 + Ord(ch) - Ord('A') + 10
    else if (ch >= 'a') and (ch <= 'f') then
      Res := Res * 16 + Ord(ch) - Ord('a') + 10
    else
      raise Exception.Create('Error: not a HEX String');
  end;
  Result := Res;
end;


function HEXToBytes(StrHEX: AnsiString): TBytes;
var
  temp: AnsiString;
  I: Integer;
begin
  SetLength(Result, Length(StrHEX) div 2);
  for I := 0 to Length(StrHEX) div 2 - 1 do
  begin
    temp := Copy(StrHEX, I * 2 + 1, 2);
    Result[I] := StringHexToByte(temp);
  end;
end;

function TDataBaseConfig.LoadFromINI(AINIFilePath: String): Boolean;
var
  AIniFile:TIniFile;
  ATempStr:String;
  ATempAnsiStr:String;
begin
  Result:=False;

  AIniFile:=TIniFile.Create(AINIFilePath{$IFDEF MSWINDOWS}{$ELSE},TEncoding.UTF8{$ENDIF});

  Self.FName:=AIniFile.ReadString('','Name','');

  Self.FDBType:=AIniFile.ReadString('','DBType','MYSQL');

  Self.FDBHostName:=AIniFile.ReadString('','DBHostName','');
  Self.FDBHostPort:=AIniFile.ReadString('','DBHostPort','');
  Self.FDBUserName:=AIniFile.ReadString('','DBUserName','');
  Self.FDBPassword:=AIniFile.ReadString('','DBPassword','');
  Self.FDBVersion:=AIniFile.ReadString('','DBVersion','');
  Self.FDBSchema:=AIniFile.ReadString('','DBSchema','');
  Self.FDBSSL:=AIniFile.ReadBool('','DBSSL',False);

  Self.FDBOSAuth:=AIniFile.ReadBool('','DBOSAuth',False);


//    //数据库服务器
//    FProxyHostName:String;
//    //数据库端口
//    FProxyHostPort:String;
//    //数据库用户名
//    FProxyUserName:String;
//    //数据库密码
//    FProxyPassword:String;
//    //
//    FProxyType:String;


  Self.FProxyType:=AIniFile.ReadString('','ProxyType','http');

  Self.FProxyHostName:=AIniFile.ReadString('','ProxyHostName','');
  Self.FProxyHostPort:=AIniFile.ReadString('','ProxyHostPort','');
  Self.FProxyUserName:=AIniFile.ReadString('','ProxyUserName','');
  Self.FProxyPassword:=AIniFile.ReadString('','ProxyPassword','');



//  {$IFDEF MSWINDOWS}
  //增加加密存储，Damon
  if (LeftStr(Self.FDBPassword,5)='[ENC]') and (Length(Self.FDBPassword)-5>0) and ((Length(Self.FDBPassword)-5) mod 16 = 0) then
  begin
    //[ENC]52D45BF87F6EB1661F3E2A8896423969
    //解密
    ATempStr:=RightStr(Self.FDBPassword,Length(Self.FDBPassword)-5);
    ATempStr:=Trim(ATempStr);
    ATempAnsiStr:=ATempStr;
    ATempAnsiStr:=DES.DESDecryptHEX(ATempAnsiStr,
                                                      gKEY,
                                                      gIV);

//    //'31333835373577616E676E656E67'
    Self.FDBPassword:=Hex2String(ATempAnsiStr);

//    Self.FDBPassword:=AESEncryptStrToHex(ATempAnsiStr,gKEY);
  end
  else
  begin
  end;
//  {$ENDIF}


  Self.FDBDataBaseName:=AIniFile.ReadString('','DBDataBaseName','');
  Self.FDBCharset:=AIniFile.ReadString('','DBCharset','utf8');


  //连接方式  prAuto prDirect等等，有很多选项，在有些电脑上prDirect会报错
  Self.FSpecificOptions_Provider:=AIniFile.ReadString('','SpecificOptions_Provider','prDirect');
//  Self.FSpecificOptions_Provider:=AIniFile.ReadString('','SpecificOptions_Provider','');
  Self.FSpecificOptions_NativeClientVersion:=AIniFile.ReadString('','SpecificOptions_NativeClientVersion','ncAuto');

  //连接池最大连接数
  Self.FMaxConnections:=AIniFile.ReadInteger('','MaxConnections',100);


  FreeAndNil(AIniFile);

  Result:=True;

end;

function GetJsonValue(AJson: ISuperObject;AKey:String;ADefault:Variant):Variant;
begin
  if AJson.Contains(AKey) then
  begin
    Result:=AJson.V[AKey];
  end
  else
  begin
    Result:=ADefault;
  end;

end;

procedure TDataBaseConfig.LoadFromJson(AJson: ISuperObject);
var
  ATempStr:String;
  ATempAnsiStr:AnsiString;
begin
  Self.fid:=GetJsonValue(AJson,'fid','');

  Self.FName:=GetJsonValue(AJson,'name','');

  Self.FDBType:=GetJsonValue(AJson,'dbtype','MYSQL');

  Self.FDBHostName:=AJson.S['host'];
  Self.FDBHostPort:=AJson.S['port'];
  Self.FDBUserName:=AJson.S['username'];
  Self.FDBPassword:=AJson.S['password'];
  Self.FDBVersion:=AJson.S['version'];
  Self.FDBSSL:=GetJsonValue(AJson,'ssl',False);
  Self.FDBOSAuth:=GetJsonValue(AJson,'osauth',False);


  {$IFDEF MSWINDOWS}
  //增加加密存储，Damon
  if (LeftStr(Self.FDBPassword,5)='[ENC]') and (Length(Self.FDBPassword)-5>0) and ((Length(Self.FDBPassword)-5) mod 16 = 0) then
  begin
    //解密
    ATempStr:=RightStr(Self.FDBPassword,Length(Self.FDBPassword)-5);
    ATempStr:=Trim(ATempStr);
    ATempAnsiStr:=ATempStr;
    ATempAnsiStr:=DESDecryptHEX(ATempAnsiStr,
                                                      gKEY,
                                                      gIV);
    Self.FDBPassword:=Hex2String(ATempAnsiStr);
  end
  else
  begin
  end;
  {$ENDIF}


  Self.FDBDataBaseName:=AJson.S['dbname'];
  Self.FDBCharset:=GetJsonValue(AJson,'charset','utf8');


  //连接方式  prAuto prDirect等等，有很多选项，在有些电脑上prDirect会报错
  Self.FSpecificOptions_Provider:=GetJsonValue(AJson,'SpecificOptions_Provider','prDirect');
//  Self.FSpecificOptions_Provider:=AJson.S['SpecificOptions_Provider'];
  Self.FSpecificOptions_NativeClientVersion:=GetJsonValue(AJson,'SpecificOptions_NativeClientVersion','ncAuto');

  //连接池最大连接数
  Self.FMaxConnections:=GetJsonValue(AJson,'MaxConnections',100);


//    //数据库服务器
//    FProxyHostName:String;
//    //数据库端口
//    FProxyHostPort:String;
//    //数据库用户名
//    FProxyUserName:String;
//    //数据库密码
//    FProxyPassword:String;
//    //
//    FProxyType:String;


  Self.FProxyType:=GetJsonValue(AJson,'proxy_type','http');

  Self.FProxyHostName:=AJson.S['proxy_host'];
  Self.FProxyHostPort:=AJson.S['proxy_port'];
  Self.FProxyUserName:=AJson.S['proxy_user'];
  Self.FProxyPassword:=AJson.S['proxy_pass'];


end;


procedure TDataBaseConfig.SaveToJson(AJson: ISuperObject);
var
  ADBPassword:String;
begin
  AJson.S['name']:=Self.FName;

  AJson.S['dbtype']:=Self.FDBType;

  AJson.S['host']:=Self.FDBHostName;
  AJson.S['port']:=Self.FDBHostPort;
  AJson.S['username']:=Self.FDBUserName;

  ADBPassword:=FDBPassword;

  {$IFDEF MSWINDOWS}
  if (LeftStr(Self.FDBPassword,5)<>'[ENC]') then
  begin
    ADBPassword:='[ENC]'+String(DESEncryptHEX(String2Hex(AnsiString(
                    RightStr(Self.FDBPassword,Length(Self.FDBPassword))
                    )), gKEY, gIV));
  end;
  {$ENDIF}

//  Self.SaveToINI(ExtractFilePath(Application.ExeName)+DBConfigFileName;
//  Self.FDBPassword::=String(Hex2String(DESDecryptHEX(AnsiString(Trim(
//  RightStr(Self.FDBPassword,Length(Self.FDBPassword)-5)
//  )), gKEY, gIV)))


  AJson.S['password']:=ADBPassword;
  AJson.S['dbname']:=Self.FDBDataBaseName;
  AJson.S['charset']:=Self.FDBCharset;
  AJson.B['ssl']:=Self.FDBSSL;
  AJson.B['osauth']:=Self.FDBOSAuth;

  //连接方式
  AJson.S['SpecificOptions_Provider']:=Self.FSpecificOptions_Provider;
  AJson.S['SpecificOptions_NativeClientVersion']:=Self.FSpecificOptions_NativeClientVersion;


  AJson.I['MaxConnections']:=Self.FMaxConnections;



end;

procedure TDataBaseConfig.Save(AIniFileName:String);
begin
  Self.SaveToINI(GetApplicationPath+AIniFileName);
end;

function TDataBaseConfig.SaveToINI(AINIFilePath: String): Boolean;
var
  AIniFile:TIniFile;
  ADBPassword:String;
begin
  Result:=False;
  AIniFile:=TIniFile.Create(AINIFilePath{$IFDEF MSWINDOWS}{$ELSE},TEncoding.UTF8{$ENDIF});

  AIniFile.WriteString('','Name',Self.FName);

  AIniFile.WriteString('','DBType',Self.FDBType);

  AIniFile.WriteString('','DBHostName',Self.FDBHostName);
  AIniFile.WriteString('','DBHostPort',Self.FDBHostPort);
  AIniFile.WriteString('','DBUserName',Self.FDBUserName);
  AIniFile.WriteString('','DBSchema',Self.FDBSchema);


  ADBPassword:=FDBPassword;

//  {$IFDEF MSWINDOWS}
//  if (LeftStr(Self.FDBPassword,5)<>'[ENC]') then
//  begin
//    ADBPassword:='[ENC]'+String(DESEncryptHEX(String2Hex(AnsiString(
//                    RightStr(Self.FDBPassword,Length(Self.FDBPassword))
//                    )), gKEY, gIV));
//  end;
//  {$ENDIF}

//  Self.SaveToINI(ExtractFilePath(Application.ExeName)+DBConfigFileName);
//  Self.FDBPassword:=String(Hex2String(DESDecryptHEX(AnsiString(Trim(
//  RightStr(Self.FDBPassword,Length(Self.FDBPassword)-5)
//  )), gKEY, gIV)))


  AIniFile.WriteString('','DBPassword',ADBPassword);
  AIniFile.WriteString('','DBDataBaseName',Self.FDBDataBaseName);
  AIniFile.WriteString('','DBCharset',Self.FDBCharset);

  //连接方式
  AIniFile.WriteString('','SpecificOptions_Provider',Self.FSpecificOptions_Provider);
  AIniFile.WriteString('','SpecificOptions_NativeClientVersion',Self.FSpecificOptions_NativeClientVersion);


  AIniFile.WriteBool('','DBSSL',Self.FDBSSL);
  AIniFile.WriteBool('','DBOSAuth',Self.FDBOSAuth);

  AIniFile.WriteInteger('','MaxConnections',Self.FMaxConnections);

  FreeAndNil(AIniFile);
  Result:=True;

end;

{ TDataBaseConfigList }

function TDataBaseConfigList.CreateItem: TDataBaseConfig;
begin
  Result:=TDataBaseConfig.Create;
end;

function TDataBaseConfigList.Find(fid: String): TDataBaseConfig;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Count-1 do
  begin
    if (Items[I].fid=fid) then
    begin
      Result:=Items[I];
      Break;
    end;
  end;
end;

function TDataBaseConfigList.FindByName(AName: String): TDataBaseConfig;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Count-1 do
  begin
    if Items[I].FName=AName then
    begin
      Result:=Items[I];
      Break;
    end;
  end;
end;

function TDataBaseConfigList.GetItem(Index: Integer): TDataBaseConfig;
begin
  Result:=TDataBaseConfig(Inherited Items[Index]);
end;

procedure TDataBaseConfigList.LoadFromJsonArray(AJsonArray: ISuperArray);
var
  I: Integer;
  ADataBaseConfig:TDataBaseConfig;
begin
  Clear;
  for I := 0 to AJsonArray.Length-1 do
  begin
    ADataBaseConfig:=CreateItem;//TDatabaseConfig.Create();
    ADataBaseConfig.LoadFromJson(AJsonArray.O[I]);
    Self.Add(ADataBaseConfig);
  end;
end;

procedure TDataBaseConfigList.SaveToJsonArray(AJsonArray: ISuperArray);
var
  I: Integer;
  ADataBaseConfig:TDataBaseConfig;
begin
  for I := 0 to Count-1 do
  begin
    ADataBaseConfig:=TDataBaseConfig(Items[I]);
    ADataBaseConfig.SaveToJson(AJsonArray.O[I]);
  end;
end;

initialization
  GlobalDataBaseConfig:=TDataBaseConfig.Create;
//  GlobalDataBaseConfigList:=TDataBaseConfigList.Create(ooReference);

finalization
  FreeAndNil(GlobalDataBaseConfig);
//  FreeAndNil(GlobalDataBaseConfigList);

end.
