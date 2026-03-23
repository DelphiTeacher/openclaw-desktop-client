unit uBaseDBDataSource;

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
  uFuncCommon,
//  uBaseDBHelper,
  uFileCommon,
//  uDatasetToJson,
//  uPageStructure,
//  uBaseDataBaseModule,
//  uFMXUnidacDataBaseModule,
//  uDataBaseConfig,
  uComponentType;

type
  //数据库查询源，内部其实是一个Json数组
  TBaseDBDataSource=class(TBindDataSource)
  protected
    FSQL: TStringList;
//    FDBConfigName: String;
//    FDBModule:TDataBaseModule;
    FDataArray:ISuperArray;
    function CanOpen: Boolean;override;
    procedure Close;override;
    procedure SetSQL(const Value: TStringList);
//    procedure SetDBConfigName(const Value: String);
//    procedure SetActive(const Value: Boolean);
    procedure DoSQLChange(Sender:TObject);
  protected
    procedure LoadFromJson(AJson:ISuperObject);override;
    procedure SaveToJson(AJson:ISuperObject);override;
  public
//    FDBConfig:TDatabaseConfig;
    constructor Create(AComponent:TComponent);override;
    destructor Destroy;override;
  public
    //根据绑定的FieldName获取Item的值,然后赋给绑定的控件
    function GetValueTypeByBindItemField(AFieldName:String):TVarType;override;
    function GetValueArrayByBindItemField(AParamName:String):ISuperArray;override;

//    //数据库配置名称
//    property DBConfigName:String read FDBConfigName write SetDBConfigName;
  published
    //查询语句
    property SQL:TStringList read FSQL write SetSQL;
  end;



implementation

//
//uses
//  PageDesignFrame;

{ TBaseDBDataSource }

function TBaseDBDataSource.CanOpen: Boolean;
begin
  Result:=False;
//  if FDBConfigName='' then Exit;
  if FSQL.Text='' then Exit;

  Result:=True;
end;

procedure TBaseDBDataSource.Close;
begin
  if FActive then
  begin
    FDataArray:=SA();

    FActive:=False;
  end;

end;

constructor TBaseDBDataSource.Create(AComponent: TComponent);
begin
  inherited;

  FDataArray:=SA();
  FSQL:=TStringList.Create;
  FSQL.OnChange:=DoSQLChange;
end;

destructor TBaseDBDataSource.Destroy;
begin
  FreeAndNil(FSQL);
  inherited;
end;

procedure TBaseDBDataSource.DoSQLChange(Sender: TObject);
begin
  if FActive then
  begin
    Close;

    Open;
  end;
end;

function TBaseDBDataSource.GetValueArrayByBindItemField(
  AParamName: String): ISuperArray;
begin
  Result:=FDataArray;
end;

function TBaseDBDataSource.GetValueTypeByBindItemField(
  AFieldName: String): TVarType;
begin
  Result:=varArray;
end;

procedure TBaseDBDataSource.LoadFromJson(AJson: ISuperObject);
begin
  inherited;
  FSQL.Text:=AJson.S['SQL'];
//  FDBConfigName:=AJson.S['DBConfigName'];
  SetActive(AJson.B['Active']);
end;

//procedure TBaseDBDataSource.Open;
////var
////  ADesc:String;
////  ADBHelper:TBaseDBHelper;
////  ADBConfig:TDatabaseConfig;
////  APage:TPage;
////  AProgramTemplate:TProgramTemplate;
////  ADBModule:TDatabaseModule;
//begin
//  if not CanOpen then Exit;
//
//  DoOpen;
//
////  if ADBConfig.FDBModule=nil then
////  begin
////    ADBConfig.FDBModule:=TDataBaseModule.Create();
////    TDataBaseModule(ADBConfig.FDBModule).DBConfig.Assign(ADBConfig);
////  end;
////
////
////  if ADBConfig.FDBModule=nil then Exit;
////
////  ADBModule:=TDatabaseModule(ADBConfig.FDBModule);
////
////  if not ADBModule.GetDBHelperFromPool(ADBHelper,ADesc) then
////  begin
////    Exit;
////  end;
////  try
////    if not ADBHelper.SelfQuery(FSQL.Text,[],[]) then
////    begin
////      Exit;
////    end;
////    FDataArray:=JSonArrayFromDataSetTo(ADBHelper.Query);
////
////    Self.DoGetedData;
////
////    FActive:=True;
////  finally
////    ADBModule.FreeDBHelperToPool(ADBHelper);
////  end;
//
//end;

procedure TBaseDBDataSource.SaveToJson(AJson: ISuperObject);
begin
  inherited;
  AJson.S['SQL']:=FSQL.Text;
//  AJson.S['DBConfigName']:=FDBConfigName;
  AJson.B['Active']:=FActive;
end;

//procedure TBaseDBDataSource.SetActive(const Value: Boolean);
//begin
//  if FActive<>Value then
//  begin
//    if FActive then
//    begin
//      Close;
//    end;
//
//    FActive:=Value;
//
//    if Value then
//    begin
//      Open;
//    end;
//
//  end;
//end;
//
//procedure TBaseDBDataSource.SetDBConfigName(const Value: String);
//var
//  AOldActive:Boolean;
////  APage:TPage;
////  AProgramTemplate:TProgramTemplate;
//begin
//  if FDBConfigName<>Value then
//  begin
//
//    AOldActive:=FActive;
//    if FDBConfigName<>'' then
//    begin
//      Close;
//    end;
//
//    FDBConfigName := Value;
//
//    Active:=AOldActive;
//
//  end;
//end;

procedure TBaseDBDataSource.SetSQL(const Value: TStringList);
begin
  FSQL.Assign(Value);
end;


//initialization
//  GetGlobalFrameworkComponentTypeClasses.Add('DBQueryDataSource',TBaseDBDataSource,'数据库查询数据源');



end.
