unit uLocalDBDataSource;

interface


uses
  SysUtils,
  FMX.Controls,

  {$IFDEF SKIN_SUPEROBJECT}
  uSkinSuperObject,
  {$ELSE}
  XSuperObject,
  XSuperJson,
  {$ENDIF}

  FMX.Types,
  Classes,
  uBaseList,
  uBaseLog,
  IniFiles,
  uFuncCommon,
  uBaseDBHelper,
  uFileCommon,
  uDatasetToJson,
  uComponentType,
  uBaseDBDataSource,
  uDataBaseConfig,
  uBaseDataBaseModule,
  uFMXUnidacDataBaseModule;

type
  //数据库查询源，内部其实是一个Json数组
  TLocalDBDataSource=class(TBaseDBDataSource)
  private
//    FSQL: TStringList;
//    FDBConfigName: String;
////    FDBModule:TDataBaseModule;
//    FDataArray:ISuperArray;
//    FActive: Boolean;
//    procedure Close;
    function DoOpen:Boolean;override;
//    procedure SetSQL(const Value: TStringList);
//    procedure SetDBConfigName(const Value: String);
//    procedure SetActive(const Value: Boolean);
//    procedure DoSQLChange(Sender:TObject);
//  protected
//    procedure LoadFromJson(AJson:ISuperObject);override;
//    procedure SaveToJson(AJson:ISuperObject);override;
//  public
//    constructor Create(AComponent:TComponent);override;
//    destructor Destroy;override;
//  public
//    //根据绑定的FieldName获取Item的值,然后赋给绑定的控件
//    function GetValueTypeByBindItemField(AFieldName:String):TVarType;override;
//    function GetValueArrayByBindItemField(AParamName:String):ISuperArray;override;
//  published
//    property Active:Boolean read FActive write SetActive;
//    //数据库配置名称
//    property DBConfigName:String read FDBConfigName write SetDBConfigName;
//    //查询语句
//    property SQL:TStringList read FSQL write SetSQL;
  end;



implementation


{ TLocalDBDataSource }

//procedure TLocalDBDataSource.Close;
//begin
//  if FActive then
//  begin
//    FDataArray:=SA();
//
//    FActive:=False;
//  end;
//
//end;
//
//constructor TLocalDBDataSource.Create(AComponent: TComponent);
//begin
//  inherited;
//
//  FDataArray:=SA();
//  FSQL:=TStringList.Create;
//  FSQL.OnChange:=DoSQLChange;
//end;
//
//destructor TLocalDBDataSource.Destroy;
//begin
//  FreeAndNil(FSQL);
//  inherited;
//end;
//
//procedure TLocalDBDataSource.DoSQLChange(Sender: TObject);
//begin
//  if FActive then
//  begin
//    Close;
//  end;
//end;
//
//function TLocalDBDataSource.GetValueArrayByBindItemField(
//  AParamName: String): ISuperArray;
//begin
//  Result:=FDataArray;
//end;
//
//function TLocalDBDataSource.GetValueTypeByBindItemField(
//  AFieldName: String): TVarType;
//begin
//  Result:=varArray;
//end;
//
//procedure TLocalDBDataSource.LoadFromJson(AJson: ISuperObject);
//begin
//  inherited;
//  FSQL.Text:=AJson.S['SQL'];
//  FDBConfigName:=AJson.S['DBConfigName'];
//  Active:=AJson.B['Active'];
//end;

function TLocalDBDataSource.DoOpen:Boolean;
var
  ADesc:String;
  ADBConfig:TDatabaseConfig;
  ADBHelper:TBaseDBHelper;
  ADBModule:TDatabaseModule;
begin

  Result:=False;

  //通过FDBConfigName找FDBConfig
  ADBConfig:=nil;


//  //设计时
//  if (Owner<>nil) and (Owner is TPageDesignPanel) then
//  begin
//    APage:=TPageDesignPanel(Owner).Page;
//    AProgramTemplate:=(APage.ProgramTemplate);
//    if AProgramTemplate<>nil then
//    begin
//      ADBConfig:=AProgramTemplate.DataBaseConfigList.FindByName(FDBConfigName);
//    end;
//  end;


  if ADBConfig=nil then Exit;

  if ADBConfig.FDBModule=nil then Exit;

  ADBModule:=TDatabaseModule(ADBConfig.FDBModule);

  if not ADBModule.GetDBHelperFromPool(ADBHelper,ADesc) then
  begin
    Exit;
  end;
  try
    if not ADBHelper.SelfQuery(FSQL.Text,[],[]) then
    begin
      Exit;
    end;
    FDataArray:=JSonArrayFromDataSetTo(ADBHelper.Query);

    Self.DoGetedData;

    FActive:=True;

    Result:=True;
  finally
    ADBModule.FreeDBHelperToPool(ADBHelper);
  end;

end;

//procedure TLocalDBDataSource.SaveToJson(AJson: ISuperObject);
//begin
//  inherited;
//  AJson.S['SQL']:=FSQL.Text;
//  AJson.S['DBConfigName']:=FDBConfigName;
//  AJson.B['Active']:=Active;
//end;
//
//procedure TLocalDBDataSource.SetActive(const Value: Boolean);
//begin
//  if FActive<>Value then
//  begin
//    if FActive then
//    begin
//      Close;
//    end;
//
//    FActive := Value;
//
//    if FActive then
//    begin
//      Open;
//    end;
//
//  end;
//end;
//
//procedure TLocalDBDataSource.SetDBConfigName(const Value: String);
//begin
//  if FDBConfigName<>Value then
//  begin
//    if FDBConfigName<>'' then
//    begin
//      Close;
//    end;
//
//    FDBConfigName := Value;
//
//    //找到DBConfig
//    if (FDBConfigName<>'') and FActive then
//    begin
//      Open;
//    end;
//
//  end;
//end;
//
//procedure TLocalDBDataSource.SetSQL(const Value: TStringList);
//begin
//  FSQL.Assign(Value);
//end;


initialization
  GetGlobalFrameworkComponentTypeClasses.Add('LobalDBQueryDataSource',TLocalDBDataSource,'本地数据库数据源');



end.
