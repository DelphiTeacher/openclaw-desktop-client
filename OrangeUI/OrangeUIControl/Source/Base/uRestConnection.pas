unit uRestConnection;

interface


uses
  SysUtils,

  {$IFDEF FMX}
  FMX.Controls,
  FMX.Types,
  {$ENDIF}

  {$IFDEF SKIN_SUPEROBJECT}
  uSkinSuperObject,
  {$ELSE}
  XSuperObject,
  XSuperJson,
  {$ENDIF}

  Classes,
  uBaseList,
  uBaseLog,
  IniFiles,
  DB,
  uFuncCommon,
//  uBaseDBHelper,
  uFileCommon,
  uDatasetToJson_Copy,
//  uPageStructure,
  uComponentType,

//  uManager,
//  uOpenClientCommon,
  uRestInterfaceCall_Copy,
  uBaseDBDataSource;



type
  //数据库连接
  TRestConnection=class(TComponent)
  private
    FAccessToken: String;
    FInterfaceUrl: String;
  protected
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    property InterfaceUrl:String read FInterfaceUrl write FInterfaceUrl;
    property AccessToken:String read FAccessToken write FAccessToken;
  end;


  TRestDBConnection=class(TRestConnection)
  private
    FActive: Boolean;
    FDBConfigName: String;
    procedure SetActive(const Value: Boolean);
    procedure SetDBConfigName(const Value: String);
  public
    function GetData(ARestDBDataSource:TObject;var ADesc:String;var ADataJson:ISuperObject):Boolean;
  published
    property Active:Boolean read FActive write SetActive;
    property DBConfigName:String read FDBConfigName write SetDBConfigName;
  end;



implementation

uses
  uRestDBDataSource;

{ TRestConnection }

constructor TRestConnection.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TRestConnection.Destroy;
begin

  inherited;
end;

function TRestDBConnection.GetData(ARestDBDataSource: TObject;
  var ADesc: String; var ADataJson: ISuperObject): Boolean;
var
  ACode:Integer;
  APostJson:ISuperObject;
begin
  Result:=False;

  //调用接口来获取数据
  APostJson:=SO();
  APostJson.S['dbconfig_name']:=TRestDBDataSource(ARestDBDataSource).DBConfigName;
  APostJson.S['sql']:=TRestDBDataSource(ARestDBDataSource).SQL.Text;
  APostJson.I['pageindex']:=TRestDBDataSource(ARestDBDataSource).PageIndex;
  APostJson.I['pagesize']:=TRestDBDataSource(ARestDBDataSource).PageSize;

  if not SimpleCallAPI('program_framework/execute_database_sql',
                nil,
                FInterfaceUrl,
                [
                'key'
                ],
                [
                FAccessToken
                ],
                ACode,
                ADesc,
                ADataJson,
                GlobalRestAPISignType,
                GlobalRestAPIAppSecret,
                True,
                nil,
                APostJson.AsJSON
                ) or (ACode<>200) then
  begin
    Exit;
  end;

  Result:=True;

end;

procedure TRestDBConnection.SetActive(const Value: Boolean);
begin
  FActive := Value;
  //此时应该加载所有支持的数据库列表
end;

procedure TRestDBConnection.SetDBConfigName(const Value: String);
begin
  FDBConfigName := Value;
end;

initialization
  GetGlobalFrameworkComponentTypeClasses.Add('RestConnection',TRestConnection,'远程服务端连接');//服务端数据库数据源
  GetGlobalFrameworkComponentTypeClasses.Add('RestDBConnection',TRestDBConnection,'远程数据库连接');//服务端数据库数据源



end.
