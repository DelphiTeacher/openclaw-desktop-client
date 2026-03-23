unit uPageFrameworkDataSource;

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

  DB,
  uDatasetToJson_Copy,
  Classes,
  uBaseList,
  uBaseLog,
  IniFiles,
  uFuncCommon,
  uFileCommon,
  uComponentType;

type
  //开放平台统一根据变量名获取数据设置数据的地方
  TBindDataSourceManager=class
  public
    FOnGetParamValue:TOnGetParamValueEvent;
    FOnSetParamValue:TOnSetParamValueEvent;
  public
    constructor Create;virtual;
    destructor Destroy;override;

    //本地数据,比如医院显示屏项目,保存办公室fid
    //FDataJson:ISuperObject;
    function GetParamValue(AValueFrom:String;AParamName:String):Variant;virtual;
    procedure SetParamValue(AValueFrom:String;AParamName:String;AValue:Variant);virtual;

//    function GetDrawPicture(AImageName:String):TDrawPicture;virtual;

    procedure Load;virtual;
    procedure Save;virtual;
  end;
  TBindDataSourceManagerClass=class of TBindDataSourceManager;



  //本地文件，比如配置文件,比如医院显示屏项目,保存办公室fid
  TFileBindDataSource=class(TBindDataSource)
  private
    FFileName: String;
    procedure SetFileName(const Value: String);virtual;
  published
    property FileName:String read FFileName write SetFileName;
  end;



  //本地数据,比如医院显示屏项目,保存办公室fid
  TIniFileBindDataSource=class(TFileBindDataSource)
  public
    FIniFile:TIniFile;
    procedure SetFileName(const Value: String);override;
  public
    destructor Destroy;override;
  public
    function GetValueByBindItemField(AParamName:String):Variant;override;
    procedure SetValue(AParamName:String;AValue:Variant);override;
  end;


  //本地数据,比如医院显示屏项目,保存办公室fid
  TJsonBindDataSource=class(TBindDataSource)
  public
    FDataJson:ISuperObject;
    FJsonStr:TStringList;
    procedure DoJsonStrChange(Sender:TObject);
  public
    constructor Create(AComponent:TComponent);override;
    destructor Destroy;override;
  private
    function GetJsonStr: TStringList;
    procedure SetJsonStr(const Value: TStringList);
    procedure SetDataJson(const Value: ISuperObject);
  public
    procedure LoadFromJson(AJson:ISuperObject);override;
    procedure SaveToJson(AJson:ISuperObject);override;

  public
    //IDataSource
    //获取字段列表,绑定的时候需要供用户选择
    function GetFieldDefList(ABindItemFieldName:String):TFieldDefs;override;
    function GetValueTypeByBindItemField(AFieldName:String):TVarType;override;
    function GetValueArrayByBindItemField(AFieldName:String):ISuperArray;override;
    function GetValueByBindItemField(AParamName:String):Variant;override;
    procedure SetValue(AParamName:String;AValue:Variant);override;

    property DataJson:ISuperObject read FDataJson write SetDataJson;
  published
    property JsonStr:TStringList read GetJsonStr write SetJsonStr;
  end;

  //本地数据,比如医院显示屏项目,保存办公室fid
  TJsonFileBindDataSource=class(TJsonBindDataSource)
  private
    FFileName: String;
    procedure SetFileName(const Value: String);
  published
    property FileName:String read FFileName write SetFileName;
  end;


  TRecordListBindDataSource=class(TBindDataSource)
  private
    FPageIndex: Integer;
    FPageSize: Integer;
    procedure ChangePage;virtual;abstract;
    procedure SetPageIndex(const Value: Integer);
    procedure SetPageSize(const Value: Integer);
  public
    property PageIndex:Integer read FPageIndex write SetPageIndex;
    property PageSize:Integer read FPageSize write SetPageSize;
  end;




  {$REGION 'TLocalJsonBindDataSourceManager'}
  TLocalJsonBindDataSourceManager=class(TBindDataSourceManager)
  public
    //本地数据,比如医院显示屏项目,保存办公室fid
    FDataJson:ISuperObject;

  public
    constructor Create;override;
    destructor Destroy;override;

  public
    procedure Load;override;
    procedure Save;override;
    function GetParamValue(AValueFrom:String;AParamName:String):Variant;override;
    procedure SetParamValue(AValueFrom:String;AParamName:String;AValue:Variant);override;

  end;
  {$ENDREGION}
var

  GlobalBindDataSourceManagerClass:TBindDataSourceManagerClass;


function GetGlobalBindDataSourceManager:TBindDataSourceManager;


procedure Register;


implementation

//uses
//  uPageStructure;

var

  //本地参数的数据源
  //初始本地数据源,调用接口的有些参数从这里取出来的
  GlobalPlatformDataSourceManager:TBindDataSourceManager;

procedure Register;
begin
  RegisterComponents('OrangePageFramework',
                      [TBindDataSource]);
end;


{ TLocalJsonBindDataSourceManager }

constructor TLocalJsonBindDataSourceManager.Create;
begin
  inherited;
  FDataJson:=TSuperObject.Create;

end;

destructor TLocalJsonBindDataSourceManager.Destroy;
begin

  inherited;
end;

function TLocalJsonBindDataSourceManager.GetParamValue(AValueFrom,
  AParamName: String): Variant;
begin
  if Self.FDataJson.Contains(AParamName) then
  begin
    Result:=FDataJson.V[AParamName];
  end
  else
  begin
    Result:=Inherited;
  end;

end;

procedure TLocalJsonBindDataSourceManager.Load;
begin
  inherited;

  if FileExists(GetApplicationPath+'local_data_source.json') then
  begin
    FDataJson:=TSuperObject.Create(GetStringFromTextFile(GetApplicationPath+'local_data_source.json'));
  end
  else
  begin
    FDataJson:=TSuperObject.Create;
  end;

end;

procedure TLocalJsonBindDataSourceManager.Save;
begin
  inherited;

  SaveStringToFile(FDataJson.AsJSON,GetApplicationPath+'local_data_source.json',TEncoding.UTF8);

end;

procedure TLocalJsonBindDataSourceManager.SetParamValue(AValueFrom,
  AParamName: String; AValue: Variant);
begin
  inherited;

end;

//{$IFDEF VCL}
//procedure Register;
//begin
//  RegisterComponents('OrangeUIConrol',[TPageCheckBox,TPageComboBox,TPageEdit,TPageMemo]);
//end;
//{$ENDIF VCL}

function GetGlobalBindDataSourceManager:TBindDataSourceManager;
begin
  if GlobalPlatformDataSourceManager=nil then
  begin
    GlobalPlatformDataSourceManager:=GlobalBindDataSourceManagerClass.Create;
  end;
  Result:=GlobalPlatformDataSourceManager;
end;


{ TBindDataSourceManager }

constructor TBindDataSourceManager.Create;
begin
//  FDataJson:=TSuperObject.Create;

end;

destructor TBindDataSourceManager.Destroy;
begin
//  FDataJson:=nil;
  inherited;
end;

//function TBindDataSourceManager.GetDrawPicture(
//  AImageName: String): TDrawPicture;
//var
//  AIsGeted:Boolean;
//  I: Integer;
//begin
//  AIsGeted:=False;
//
//  Result:=nil;
//
////  if Assigned(FOnGetParamValue) then
////  begin
////    Result:=FOnGetParamValue(AValueFrom,AParamName,AIsGeted);
////  end;
////
////  if AIsGeted then Exit;
//
//
//  for I := 0 to GlobalBindDataSourceList.Count-1 do
//  begin
//    AIsGeted:=False;
//    if Assigned(GlobalBindDataSourceList[I].FOnGetDrawPicture) then
//    begin
//      Result:=GlobalBindDataSourceList[I].FOnGetDrawPicture(AImageName,AIsGeted);
//    end;
//    if AIsGeted then Exit;
//  end;
//
//
////  if Result=nil then
////  begin
////    //没有取到值就要弹出报错
////    raise Exception.Create('The Image named '+AImageName+' is not geted');
////  end;
//
//end;

function TBindDataSourceManager.GetParamValue(AValueFrom:String;AParamName: String): Variant;
var
  AIsGeted:Boolean;
  I: Integer;
begin
  AIsGeted:=False;
  if Assigned(FOnGetParamValue) then
  begin
    Result:=FOnGetParamValue(AValueFrom,AParamName,AIsGeted);
  end;

  if AIsGeted then Exit;


  for I := 0 to GlobalBindDataSourceList.Count-1 do
  begin
    AIsGeted:=False;
    if Assigned(GlobalBindDataSourceList[I].OnGetParamValue) then
    begin
      Result:=GlobalBindDataSourceList[I].OnGetParamValue(AValueFrom,AParamName,AIsGeted);
    end;
    if AIsGeted then Exit;
  end;

  //没有取到值就要弹出报错
//  raise Exception.Create('The Value of '+AParamName+' is not geted');
  uBaseLog.HandleException(nil,'TBindDataSourceManager.GetParamValue The Value of '+AParamName+' is not geted');
  Result:='';

//  if not FDataJson.Contains(AParamName) then
//  begin
//    //没有取到值就要弹出报错
//    raise Exception.Create('The Value of '+AParamName+' is not geted');
//  end;
//  Result:=FDataJson.V[AParamName];
end;

procedure TBindDataSourceManager.Load;
begin
//  if FileExists(GetApplicationPath+'local_data_source.json') then
//  begin
//    FDataJson:=TSuperObject.Create(GetStringFromTextFile(GetApplicationPath+'local_data_source.json'));
//  end
//  else
//  begin
//    FDataJson:=TSuperObject.Create;
//  end;
end;

procedure TBindDataSourceManager.Save;
begin
//  SaveStringToFile(FDataJson.AsJSON,GetApplicationPath+'local_data_source.json',TEncoding.UTF8);
end;

procedure TBindDataSourceManager.SetParamValue(AValueFrom:String;AParamName: String;AValue: Variant);
var
  AIsSeted:Boolean;
  I: Integer;
begin
  AIsSeted:=False;
  if Assigned(FOnSetParamValue) then
  begin
    FOnSetParamValue(AValueFrom,AParamName,AValue,AIsSeted);
  end;

  if AIsSeted then Exit;


  for I := 0 to GlobalBindDataSourceList.Count-1 do
  begin
    AIsSeted:=False;
    if Assigned(GlobalBindDataSourceList[I].OnSetParamValue) then
    begin
      GlobalBindDataSourceList[I].OnSetParamValue(AValueFrom,AParamName,AValue,AIsSeted);
    end;
    if AIsSeted then Exit;
  end;


  //没有取到值就要弹出报错
  raise Exception.Create('The Value of '+AParamName+' is not Seted');


//  FDataJson.V[AParamName]:=AValue;
end;


{ TJsonBindDataSource }

constructor TJsonBindDataSource.Create(AComponent: TComponent);
begin
  inherited;
  FDataJson:=SO();
  FJsonStr:=TStringList.Create;
  FJsonStr.OnChange:=DoJsonStrChange;
end;

destructor TJsonBindDataSource.Destroy;
begin
  FreeAndNil(FJsonStr);
  inherited;
end;

procedure TJsonBindDataSource.DoJsonStrChange(Sender: TObject);
begin
//  FDataJson:=AJson.O['DataJson'];//'File pool not specified.'#$D#$A

  FDataJson:=SO(FJsonStr.Text);
  Self.DoGetedData;

end;

function TJsonBindDataSource.GetFieldDefList(ABindItemFieldName:String): TFieldDefs;
var
  AJsonNameArray:TStringDynArray;
  I: Integer;
  AJson:ISuperObject;
  AJsonAray:ISuperArray;
begin
  Self.FFieldDefs.Clear;
  Result:=FFieldDefs;

//  AJsonNameArray:=GetJsonNameArray(FDataJson);
//  for I := 0 to Length(AJsonNameArray)-1 do
//  begin
//    FFieldDefs.Add(AJsonNameArray[I],
//                   ConvertVarTypeToFieldType(FDataJson.GetType(AJsonNameArray[I])),
//                   0,
//                   False
//                  );
//  end;


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

function TJsonBindDataSource.GetJsonStr: TStringList;
begin
  //要能格式化哦
//  FJsonStr.Text:=FDataJson.AsJson;
  Result:=FJsonStr;
end;

function TJsonBindDataSource.GetValueByBindItemField(
  AParamName: String): Variant;
begin
//  Result:=FDataJson.V[AParamName];
  Result:=GetJsonValueHasLevel(FDataJson,AParamName);
end;

function TJsonBindDataSource.GetValueTypeByBindItemField(
  AFieldName: String): TVarType;
begin
//  Result:=FDataJson.GetType(AFieldName);
  Result:=GetJsonTypeHasLevel(FDataJson,AFieldName);
end;

procedure TJsonBindDataSource.LoadFromJson(AJson: ISuperObject);
begin
  inherited;
//  FDataJson:=AJson.O['DataJson'];
  FJsonStr.Text:=UTFStrToUnicode(AJson.O['DataJson'].AsJSON);
end;

function TJsonBindDataSource.GetValueArrayByBindItemField(
  AFieldName: String): ISuperArray;
begin
  Result:=GetJsonArrayHasLevel(FDataJson,AFieldName);
end;

procedure TJsonBindDataSource.SaveToJson(AJson: ISuperObject);
begin
  inherited;

  AJson.O['DataJson']:=FDataJson;
end;

procedure TJsonBindDataSource.SetDataJson(const Value: ISuperObject);
begin
  FJsonStr.Text:=Value.AsJSON;
//  FDataJson := Value;
//  Self.DoGetedData;
end;

procedure TJsonBindDataSource.SetJsonStr(const Value: TStringList);
begin
  FJsonStr.Assign(Value);
end;

procedure TJsonBindDataSource.SetValue(AParamName: String;
  AValue: Variant);
begin
  FDataJson.V[AParamName]:=AValue;
end;

{ TFileBindDataSource }

procedure TFileBindDataSource.SetFileName(const Value: String);
begin
  FFileName := Value;
end;

{ TJsonFileBindDataSource }


procedure TJsonFileBindDataSource.SetFileName(const Value: String);
begin
  FFileName := Value;
  if FileExists(Value) then
  begin
    JsonStr.Text:=GetStringFromFile(Value,TEncoding.UTF8);
  end;
end;

{ TIniFileBindDataSource }

destructor TIniFileBindDataSource.Destroy;
begin
  FreeAndNil(FIniFile);
  inherited;
end;

function TIniFileBindDataSource.GetValueByBindItemField(AParamName: String): Variant;
begin
  if FIniFile<>nil then
  begin
    Result:=FIniFile.ReadString('',AParamName,'');
  end;
end;

procedure TIniFileBindDataSource.SetFileName(const Value: String);
begin
  inherited;
  FreeAndNil(FIniFile);
  if FileExists(Value) then
  begin
    FIniFile:=TIniFile.Create(Value{$IFDEF MSWINDOWS}{$ELSE},TEncoding.UTF8{$ENDIF});
  end;
end;

procedure TIniFileBindDataSource.SetValue(AParamName: String;AValue: Variant);
begin
  if FIniFile<>nil then
  begin
    FIniFile.WriteString('',AParamName,AValue);
  end;
end;

{ TRecordListBindDataSource }


procedure TRecordListBindDataSource.SetPageIndex(const Value: Integer);
begin
  if FPageIndex<>Value then
  begin
    FPageIndex := Value;
    ChangePage;
  end;
end;

procedure TRecordListBindDataSource.SetPageSize(const Value: Integer);
begin
  if FPageSize<>Value then
  begin
    FPageSize := Value;
    ChangePage;
  end;
end;


initialization
  GlobalBindDataSourceManagerClass:=TBindDataSourceManager;
  GlobalBindDataSourceManagerClass:=TLocalJsonBindDataSourceManager;


  //数据源
  GetGlobalFrameworkComponentTypeClasses.Add('JsonDataSource',TJsonBindDataSource,'Json数据源');
//  GetGlobalFrameworkComponentTypeClasses.Add('JsonFileDataSource',TJsonFileBindDataSource,'Json文件数据源');

finalization
  FreeAndNil(GlobalPlatformDataSourceManager);


end.
