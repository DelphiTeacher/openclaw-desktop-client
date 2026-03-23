unit uRestDBDataSource;

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
//  uRestInterfaceCall,
  uRestConnection,
  uBaseDBDataSource;



type
  //数据库查询源，内部其实是一个Json数组
  TRestDBDataSource=class(TBaseDBDataSource)
  private
    FSumCount: Integer;
    FPageIndex: Integer;
    FPageSize: Integer;
    FConnection: TRestDBConnection;
    procedure SetPageIndex(const Value: Integer);
    procedure SetPageSize(const Value: Integer);
    procedure SetConnection(const Value: TRestDBConnection);
    function GetDBConfigName: String;
    procedure SetDBConfigName(const Value: String);
//  private
//    FInterfaceUrl: String;
//    FAccessToken: String;
  protected
//    FSQL: TStringList;
//    FDBConfigName: String;
////    FDBModule:TDataBaseModule;
//    FDataArray:ISuperArray;
//    FActive: Boolean;
//    procedure Close;
    function CanOpen:Boolean;override;
    function DoOpen():Boolean;override;
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
  public
    FCode:Integer;
    FDesc:String;
    FDataJson:ISuperObject;
    //获取字段列表,绑定的时候需要供用户选择
    function GetFieldDefList(ABindItemFieldName:String):TFieldDefs;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    property Connection:TRestDBConnection read FConnection write SetConnection;
    //数据库配置名称
    property DBConfigName:String read GetDBConfigName write SetDBConfigName;

    //顺序有严格要求,放在Connection下面,但是好像不管用,还是先加载的Active,再加载Connnection，导致切换Connection而使Active一直为False
    property Active:Boolean read FActive write SetActive;

    property PageIndex:Integer read FPageIndex write SetPageIndex;
    property PageSize:Integer read FPageSize write SetPageSize;
    property SumCount:Integer read FSumCount;
//    property InterfaceUrl:String read FInterfaceUrl write FInterfaceUrl;
//    property AccessToken:String read FAccessToken write FAccessToken;
//    property Active:Boolean read FActive write SetActive;
//    //数据库配置名称
//    property DBConfigName:String read FDBConfigName write SetDBConfigName;
//    //查询语句
//    property SQL:TStringList read FSQL write SetSQL;
  end;



implementation


{ TRestDBDataSource }
function TRestDBDataSource.CanOpen: Boolean;
begin
  Result:=Inherited;
  if Self.FConnection=nil then
  begin
    Result:=False;
  end;
end;

constructor TRestDBDataSource.Create(AOwner: TComponent);
begin
  inherited;
  FSumCount:=0;
  FPageIndex:=1;
  FPageSize:=20;

end;

destructor TRestDBDataSource.Destroy;
begin

  inherited;
end;

//
//procedure TRestDBDataSource.Close;
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
//constructor TRestDBDataSource.Create(AComponent: TComponent);
//begin
//  inherited;
//
//  FDataArray:=SA();
//  FSQL:=TStringList.Create;
//  FSQL.OnChange:=DoSQLChange;
//end;
//
//destructor TRestDBDataSource.Destroy;
//begin
//  FreeAndNil(FSQL);
//  inherited;
//end;
//
//procedure TRestDBDataSource.DoSQLChange(Sender: TObject);
//begin
//  if FActive then
//  begin
//    Close;
//  end;
//end;
//
//function TRestDBDataSource.GetValueArrayByBindItemField(
//  AParamName: String): ISuperArray;
//begin
//  Result:=FDataArray;
//end;
//
//function TRestDBDataSource.GetValueTypeByBindItemField(
//  AFieldName: String): TVarType;
//begin
//  Result:=varArray;
//end;
//
//procedure TRestDBDataSource.LoadFromJson(AJson: ISuperObject);
//begin
//  inherited;
//  FSQL.Text:=AJson.S['SQL'];
//  FDBConfigName:=AJson.S['DBConfigName'];
//  Active:=AJson.B['Active'];
//end;

function TRestDBDataSource.DoOpen():Boolean;
var
//  ACode:Integer;
  ADesc:String;
//  ADataJson:ISuperObject;
//  AInterfaceUrl:String;
//  AAccessToken:String;
//  ADBHelper:TBaseDBHelper;
//  ARestDBConfig:TRestDatabaseConfig;
//  AProgramTemplate:TProgramTemplate;
//  ADBModule:TDatabaseModule;
begin
//  ARestDBConfig:=TRestDatabaseConfig(ADBConfig);

//  AProgramTemplate:=TProgramTemplate(ARestDBConfig.FProgramTemplate);

//  AInterfaceUrl:=uOpenClientCommon.InterfaceUrl;
//  AAccessToken:=GlobalManager.User.key;

  Result:=False;

  if FConnection=nil then Exit;

  if not FConnection.GetData(Self,ADesc,FDataJson) then
  begin
    Exit;
  end;


  FDataArray:=FDataJson.A['RecordList'];

  //返回总数

//  FSumCount:

  //通知控件获取到数据了
  Self.DoGetedData;


  Result:=True;
  FActive:=True;

//  if FDBConfigName='' then Exit;
//  if FSQL.Text='' then Exit;
//
//  //通过FDBConfigName找FDBConfig
//  ADBConfig:=GlobalDatabaseConfigList.FindByName(FDBConfigName);
//  if ADBConfig=nil then Exit;
//
//  if ADBConfig.FDBModule=nil then
//  begin
//    ADBConfig.FDBModule:=TDataBaseModule.Create();
//    TDataBaseModule(ADBConfig.FDBModule).DBConfig.Assign(ADBConfig);
//  end;
//
//
//  if ADBConfig.FDBModule=nil then Exit;
//
//  ADBModule:=TDatabaseModule(ADBConfig.FDBModule);
//
//  if not ADBModule.GetDBHelperFromPool(ADBHelper,ADesc) then
//  begin
//    Exit;
//  end;
//  try
//    if not ADBHelper.SelfQuery(FSQL.Text,[],[]) then
//    begin
//      Exit;
//    end;
//    FDataArray:=JSonArrayFromDataSetTo(ADBHelper.Query);
//
//    Self.DoGetedData;
//
//    FActive:=True;
//  finally
//    ADBModule.FreeDBHelperToPool(ADBHelper);
//  end;

end;

function TRestDBDataSource.GetDBConfigName: String;
begin
  Result:='';
  if FConnection<>nil then
  begin
    Result:=FConnection.DBConfigName;
  end;
end;

function TRestDBDataSource.GetFieldDefList(ABindItemFieldName:String): TFieldDefs;
var
  AJsonNameArray:TStringDynArray;
  I: Integer;
  AJson:ISuperObject;
  AJsonAray:ISuperArray;
begin
  Self.FFieldDefs.Clear;
  Result:=FFieldDefs;

  if (FDataJson=nil) then Exit;

  if ABindItemFieldName<>'' then
  begin
      //是否存在这个节点
      if not GetJsonContainsHasLevel(FDataJson,ABindItemFieldName) then
      begin
        Exit;
      end;

      //判断节点的类型,
      case GetJsonTypeHasLevel(FDataJson,ABindItemFieldName) of
        varArray:
        begin

          AJsonAray:=GetJsonArrayHasLevel(FDataJson,ABindItemFieldName);
          if AJsonAray.Length>0 then
          begin
            AJson:=AJsonAray.O[0];
          end;

        end;

      end
  end
  else
  begin
      AJson:=FDataJson;

  end;

  if AJson=nil then Exit;
  
  //是对象数组
  AJsonNameArray:=GetJsonNameArray(AJson);
  for I := 0 to Length(AJsonNameArray)-1 do
  begin
    FFieldDefs.Add(AJsonNameArray[I],
                   ConvertVarTypeToFieldType(FDataJson.GetType(AJsonNameArray[I])),
                   0,
                   False
                  );
  end;

end;

procedure TRestDBDataSource.SetConnection(const Value: TRestDBConnection);
var
  AOldActive:Boolean;
begin
  if FConnection<>Value then
  begin
    AOldActive:=FActive;

    Close;

    FConnection := Value;

    Active:=AOldActive;
  end;
end;

procedure TRestDBDataSource.SetDBConfigName(const Value: String);
begin
  if FConnection<>nil then
  begin
    FConnection.DBConfigName:=Value;
  end;
end;

//procedure TRestDBDataSource.SaveToJson(AJson: ISuperObject);
//begin
//  inherited;
//  AJson.S['SQL']:=FSQL.Text;
//  AJson.S['DBConfigName']:=FDBConfigName;
//  AJson.B['Active']:=Active;
//end;
//
//procedure TRestDBDataSource.SetActive(const Value: Boolean);
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
//procedure TRestDBDataSource.SetDBConfigName(const Value: String);
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
//procedure TRestDBDataSource.SetSQL(const Value: TStringList);
//begin
//  FSQL.Assign(Value);
//end;


procedure TRestDBDataSource.SetPageIndex(const Value: Integer);
begin
  FPageIndex := Value;
end;

procedure TRestDBDataSource.SetPageSize(const Value: Integer);
begin
  FPageSize := Value;
end;

initialization
  GetGlobalFrameworkComponentTypeClasses.Add('RestDBDataSource',TRestDBDataSource,'远程数据库数据源');//服务端数据库数据源



end.
