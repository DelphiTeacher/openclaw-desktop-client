unit uRestDatabaseConfig;

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


  {$IFDEF MSWINDOWS}
  DES,
  {$ENDIF}

  uDataBaseConfig,
  uRestInterfaceCall,
  uOpenClientCommon,

  uManager,
//  Forms,
  uBaseList,
  Types;




type
  TRestDatabaseConfig=class(TDataBaseConfig)
  public
//    appid:String;
//    FInterfaceUrl:String;
//    FProgramTemplate:TObject;
    function AddToServer(var ADesc:String):Boolean;
    function UpdateToServer(var ADesc:String):Boolean;
    function TestConntectToServer(var ADesc:String):Boolean;

//    constructor Create(AProgramTemplate:TObject);
  end;


  TRestDataBaseConfigList=class(TDataBaseConfigList)
  private
    function GetItem(Index: Integer): TRestDatabaseConfig;
  public
//    FProgramTemplate:TObject;
    function CreateItem:TDataBaseConfig;override;
//    constructor Create(AProgramTemplate:TObject);
    property Items[Index:Integer]:TRestDatabaseConfig read GetItem;default;
  end;


implementation

uses
  uPageStructure;

{ TRestDatabaseConfig }

function TRestDatabaseConfig.TestConntectToServer(var ADesc: String): Boolean;
var
  ACode:Integer;
  ADataJson:ISuperObject;
  ARecordJson:ISuperObject;
begin
  Result:=False;
  ARecordJson:=SO();
  SaveToJson(ARecordJson);
  if not SimpleCallAPI('test_connect_database_config',
                nil,
                uOpenClientCommon.InterfaceUrl+'program_framework/',
                [
                'key'
                ],
                [
                GlobalManager.User.key
                ],
                ACode,
                ADesc,
                ADataJson,
                GlobalRestAPISignType,
                GlobalRestAPIAppSecret,
                True,
                nil,
                ARecordJson.AsJSON
                ) then
  begin
    Exit;
  end;

  Result:=True;
end;

//constructor TRestDatabaseConfig.Create;//(AProgramTemplate: TObject);
//begin
//  Inherited Create;
////  FProgramTemplate:=AProgramTemplate;
//end;

function TRestDatabaseConfig.UpdateToServer(var ADesc: String): Boolean;
var
  ACode:Integer;
  ADataJson:ISuperObject;
  ARecordJson:ISuperObject;
begin
  Result:=False;

  ARecordJson:=SO();
  SaveToJson(ARecordJson);
  //将页面记录保存到服务端
  if not SimpleCallAPI('update_database_config',
                nil,
                ProgramFrameworkRestCenterInterfaceUrl,
                [
                'key'
                ],
                [
                GlobalManager.User.key
                ],
                ACode,
                ADesc,
                ADataJson,
                GlobalRestAPISignType,
                GlobalRestAPIAppSecret,
                True,
                nil,
                ARecordJson.AsJSON
                ) or (ACode<>200)  then
  begin
    Exit;
  end;

  Result:=True;
end;

function TRestDatabaseConfig.AddToServer(var ADesc:String):Boolean;
var
  ACode:Integer;
  ADataJson:ISuperObject;
  ARecordJson:ISuperObject;
begin
  Result:=False;

  ARecordJson:=SO();
  SaveToJson(ARecordJson);
  //将页面记录保存到服务端
  if not SimpleCallAPI('add_database_config',
                nil,
                ProgramFrameworkRestCenterInterfaceUrl,
                [
                'key'
                ],
                [
                GlobalManager.User.key
                ],
                ACode,
                ADesc,
                ADataJson,
                GlobalRestAPISignType,
                GlobalRestAPIAppSecret,
                True,
                nil,
                ARecordJson.AsJSON
                ) or (ACode<>200) then
  begin
    Exit;
  end;

  Result:=True;

end;

{ TRestDataBaseConfigList }

//constructor TRestDataBaseConfigList.Create(AProgramTemplate: TObject);
//begin
//  Inherited Create;
//  FProgramTemplate:=AProgramTemplate;
//end;

function TRestDataBaseConfigList.CreateItem: TDataBaseConfig;
begin
  Result:=TRestDatabaseConfig.Create();//FProgramTemplate);
end;

function TRestDataBaseConfigList.GetItem(Index: Integer): TRestDatabaseConfig;
begin
  Result:=TRestDatabaseConfig(Inherited Items[Index]);
end;

end.
