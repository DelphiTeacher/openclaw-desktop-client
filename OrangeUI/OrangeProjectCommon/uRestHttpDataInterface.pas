unit uRestHttpDataInterface;

interface


uses
  Classes,
  uFuncCommon,
  uOpenClientCommon,


  {$IF CompilerVersion <= 21.0} // D2010之前
  SuperObject,
  superobjecthelper,
  {$ELSE}
    {$IFDEF SKIN_SUPEROBJECT}
    uSkinSuperObject,
    {$ELSE}
    XSuperObject,
    XSuperJson,
    {$ENDIF}
  {$IFEND}

  uBaseLog,
  uDatasetToJson,
  uRestInterfaceCall,
  uDataInterface;

type


  //通用接口框架的Rest接口
  TTableCommonRestHttpDataInterface=class(TDataInterface)
  public
    FInterfaceUrl:String;
    FKey:String;
    //是否使用默认的uOpenClientCommon中的InterfaceUrl
    FIsUseDefaultInterfaceUrl:Boolean;
    function GetAppID(ALoadDataSetting:TLoadDataSetting):String;overload;virtual;
    function GetAppID(ASaveDataSetting:TSaveDataSetting):String;overload;virtual;
    function GetUserFID:String;virtual;
    function GetKey:String;virtual;
    function GetInterfaceUrl:String;

    //从json中加载
    function CustomLoadFromJson(ASuperObject:ISuperObject):Boolean;override;

    //获取字段列表
    function GetFieldList(AAppID:String;
                          var ADesc:String;
                          var ADataJson:ISuperObject
                           ):Boolean;override;
    //获取记录列表
    function GetDataList(
                           ALoadDataSetting:TLoadDataSetting;
                           ADataIntfResult:TDataIntfResult
                           ):Boolean;override;
    //获取记录
    function GetDataDetail(
                       ALoadDataSetting:TLoadDataSetting;
                       ADataIntfResult:TDataIntfResult
                       ):Boolean;override;
    //保存记录
    function SaveData(ASaveDataSetting:TSaveDataSetting;
                      ADataIntfResult:TDataIntfResult):Boolean;override;
    //保存记录列表
    function SaveDataList(
                          //要保存的数据
                          ASaveDataSetting:TSaveDataSetting;
                          ARecordList:ISuperArray;
                          //原数据
    //                      ALoadDataIntfResult:TDataIntfResult;
                          ADataIntfResult:TDataIntfResult):Boolean;override;

    //保存记录列表
    function AddDataList(ASaveDataSetting:TSaveDataSetting;
                      ARecordList:ISuperArray;
                      ADataIntfResult:TDataIntfResult):Boolean;override;


    //删除记录,删除ALoadDataIntfResult这条获取的记录
    function DelData(ALoadDataSetting: TLoadDataSetting;
                      ALoadDataIntfResult:TDataIntfResult;
                      ADataIntfResult:TDataIntfResult):Boolean;override;
//  public
//    constructor Create;virtual;
  end;


  {$IFDEF OPEN_PLATFORM_SERVER}
    //在开放平台服务端中使用
  {$ELSE}
    //在客户端中使用
  TDefaultTableCommonRestHttpDataInterface=class(TTableCommonRestHttpDataInterface)
  public
    function GetUserFID:String;override;
    function GetKey:String;override;
    constructor Create;override;
  end;
  {$ENDIF}



  //Http的Rest接口
  TRestHttpDataInterface=class(TDataInterface)
  public

    //比如http://www.orangeui.cn:10000/usercenter/
    InterfaceUrl:String;

    //从json中加载
    function CustomLoadFromJson(ASuperObject:ISuperObject):Boolean;override;

    //参数Json数组的格式,[{参数1},{},{},{}]
    {name,value}
    //比如appid,user_fid,key,........
//    FLoadParams:ISuperArray;

    //获取记录列表
    function GetDataList(
                         ALoadDataSetting:TLoadDataSetting;
                         ADataIntfResult:TDataIntfResult
                         ):Boolean;override;
    //获取记录
    function GetDataDetail(
                       ALoadDataSetting:TLoadDataSetting;
                       ADataIntfResult:TDataIntfResult
                       ):Boolean;override;
    //保存记录
    function SaveData(ASaveDataSetting:TSaveDataSetting;
                      ADataIntfResult:TDataIntfResult):Boolean;override;
    //保存记录列表
    function AddDataList(ASaveDataSetting:TSaveDataSetting;
                      ARecordList:ISuperArray;
                      ADataIntfResult:TDataIntfResult):Boolean;override;
    //删除记录,删除ALoadDataIntfResult这条获取的记录
    function DelData(ALoadDataSetting: TLoadDataSetting;ALoadDataIntfResult:TDataIntfResult;
                      ADataIntfResult:TDataIntfResult):Boolean;override;
  end;







implementation



{ TTableCommonRestHttpDataInterface }

function TTableCommonRestHttpDataInterface.CustomLoadFromJson(
  ASuperObject: ISuperObject): Boolean;
begin
  if ASuperObject.Contains('is_use_default_interface_url') then
  begin
    FIsUseDefaultInterfaceUrl:=ASuperObject.B['is_use_default_interface_url'];
  end;
  if ASuperObject.Contains('interface_url') then
  begin
    FInterfaceUrl:=ASuperObject.S['interface_url'];
  end;
end;

function TTableCommonRestHttpDataInterface.DelData(
  ALoadDataSetting: TLoadDataSetting;
//  ADelDataSetting:TDelDataSetting;
//  ALoadDataSetting:TLoadDataSetting;
  ALoadDataIntfResult:TDataIntfResult;
  ADataIntfResult: TDataIntfResult): Boolean;
var
  ACode:Integer;
  AWhereKeyJson:String;
begin
  Result:=False;


  //生成删除记录的条件
  AWhereKeyJson:=GetWhereConditions(['appid','fid'],
                                    [GetAppID(ALoadDataSetting),ALoadDataIntfResult.DataJson.V['fid']]);

  if not SimpleCallAPI('del_record',
                      nil,
                      GetInterfaceUrl+'tablecommonrest/',
                      ['appid',
                      'user_fid',
                      'key',
                      'rest_name',
                      'where_key_json'
                      ],
                      [GetAppID(ALoadDataSetting),
                      GetUserFID,
                      GetKey,
                      Name,
                      AWhereKeyJson
                      ],
                      ACode,
                      ADataIntfResult.Desc,
                      ADataIntfResult.DataJson,
                      GlobalRestAPISignType,
                      GlobalRestAPIAppSecret) then
  begin
    Exit;
  end;
//  if not SimpleCallAPI('del_record2',
//                      nil,
//                      GetInterfaceUrl+'tablecommonrest/',
//                      ['appid',
//                      'user_fid',
//                      'key',
//                      'rest_name',
//                      'where_key_json',
//                      'fid'
//                      ],
//                      [GetAppID(ALoadDataSetting),
//                      GetUserFID,
//                      GetKey,
//                      Name,
//                      '[]',
//                      ALoadDataIntfResult.DataJson.V['fid']
//                      ],
//                      ACode,
//                      ADataIntfResult.Desc,
//                      ADataIntfResult.DataJson,
//                      GlobalRestAPISignType,
//                      GlobalRestAPIAppSecret) then
//  begin
//    Exit;
//  end;


  ADataIntfResult.DataType:=TDataIntfResultType.ldtJson;
  ADataIntfResult.Succ:=(ACode=SUCC);
  Result:=True;

end;

function TTableCommonRestHttpDataInterface.GetAppID(ALoadDataSetting:TLoadDataSetting): String;
begin
//  if ALoadDataSetting<>nil then
//  begin
    Result:=ALoadDataSetting.AppID;
//  end
//  else if ASaveDataSetting<>nil then
//  begin
//    Result:=ASaveDataSetting.AppID;
//  end
//  else
//  begin
//    Result:=uOpenClientCommon.AppID;
//  end;
end;

function TTableCommonRestHttpDataInterface.GetAppID(
  ASaveDataSetting: TSaveDataSetting): String;
begin
    Result:=ASaveDataSetting.AppID;
end;

function TTableCommonRestHttpDataInterface.GetDataDetail(
  ALoadDataSetting: TLoadDataSetting;
  ADataIntfResult: TDataIntfResult): Boolean;
var
  ACode:Integer;
begin
  Result:=False;
  //加载程序模板的所有功能和页面
  if not SimpleCallAPI(
                      'get_record',
                      nil,
                      GetInterfaceUrl+'tablecommonrest/',
                      ConvertToStringDynArray(['appid',
                                              'user_fid',
                                              'key',

                                              'rest_name',
                                              'where_key_json'
                                              ]),
                      ConvertToVariantDynArray([
                                                GetAppID(ALoadDataSetting),
                          //                      GlobalMainProgramSetting.AppID,
                                                GetUserFID,
                                                GetKey,
                                                Name,
                                                ALoadDataSetting.WhereKeyJson
                                                ]),
                      ACode,
                      ADataIntfResult.Desc,
                      ADataIntfResult.DataJson,
                                        GlobalRestAPISignType,
                                        GlobalRestAPIAppSecret) then
  begin
    Exit;
  end;


  ADataIntfResult.DataType:=TDataIntfResultType.ldtJson;
  ADataIntfResult.Succ:=(ACode=SUCC);
  Result:=True;

end;

function TTableCommonRestHttpDataInterface.GetDataList(
  ALoadDataSetting: TLoadDataSetting;
  ADataIntfResult: TDataIntfResult): Boolean;
var
  ACode:Integer;
begin
  Result:=False;
  //加载程序模板的所有功能和页面
  if not SimpleCallAPI(
                      'get_record_list',
                      nil,
                      GetInterfaceUrl+'tablecommonrest/',
                      ConvertToStringDynArray(['appid',
                                            'user_fid',
                                            'key',
                                            'rest_name',
                                            'pageindex',
                                            'pagesize',
                                            'where_key_json',
                                            'order_by',
                                            'group_by',
                                            'group_by_summary',
                                            'where_sql'
                                            ]),
                      ConvertToVariantDynArray([
                                              GetAppID(ALoadDataSetting),
                        //                      GlobalMainProgramSetting.AppID,
                                              GetUserFID,
                                              GetKey,
                                              Name,
                                              ALoadDataSetting.PageIndex,
                                              ALoadDataSetting.PageSize,
                                              ALoadDataSetting.WhereKeyJson,
                                              ALoadDataSetting.OrderBy,
                                              ALoadDataSetting.GroupBy,
                                              ALoadDataSetting.GroupBySummary,
                                              ALoadDataSetting.CustomWhereSQL
                                              ]),
                      ACode,
                      ADataIntfResult.Desc,
                      ADataIntfResult.DataJson,
                      GlobalRestAPISignType,
                      GlobalRestAPIAppSecret) or (ACode<>SUCC) then
  begin
    Exit;
  end;

  //保存到本地测试



  ADataIntfResult.DataType:=TDataIntfResultType.ldtJson;
  ADataIntfResult.Succ:=(ACode=SUCC);
  Result:=True;
end;

function TTableCommonRestHttpDataInterface.GetFieldList(AAppID:String;var ADesc: String; var ADataJson: ISuperObject): Boolean;
var
  ACode:Integer;
begin
  Result:=False;
  //加载程序模板的所有功能和页面
  if not SimpleCallAPI(
                      'get_field_list',
                      nil,
                      GetInterfaceUrl+'tablecommonrest/',
                      ConvertToStringDynArray(['appid',
                                            'user_fid',
                                            'key',
                                            'rest_name'
                                            ]),
                      ConvertToVariantDynArray([
                                              AAppID,
                        //                      GlobalMainProgramSetting.AppID,
                                              GetUserFID,
                                              GetKey,
                                              Name
                                              ]),
                      ACode,
                      ADesc,
                      ADataJson,
                      GlobalRestAPISignType,
                      GlobalRestAPIAppSecret) or (ACode<>SUCC) then
  begin
    Exit;
  end;

  Result:=True;

end;

function TTableCommonRestHttpDataInterface.GetInterfaceUrl: String;
begin
  if FIsUseDefaultInterfaceUrl then
  begin
    Result:=uOpenClientCommon.InterfaceUrl;
  end
  else
  begin
    Result:=Self.FInterfaceUrl;
  end;
end;

function TTableCommonRestHttpDataInterface.GetKey: String;
begin
//  if FIsUseDefaultInterfaceUrl then
//  begin
//    Result:=uOpenClientCommon.GlobalBaseManager.User.key;
//  end
//  else
//  begin
//    Result:=Self.FKey;
//  end;
//  Result:=FKey;
end;

function TTableCommonRestHttpDataInterface.GetUserFID: String;
begin
//  if FIsUseDefaultInterfaceUrl then
//  begin
//    Result:=uOpenClientCommon.GlobalBaseManager.User.fid;
//  end
//  else
//  begin
//    Result:='';
//  end;
  Result:='';
end;

function TTableCommonRestHttpDataInterface.SaveData(ASaveDataSetting: TSaveDataSetting;ADataIntfResult:TDataIntfResult): Boolean;
var
  ACode:Integer;
begin
  Result:=False;

  ADataIntfResult.DataType:=TDataIntfResultType.ldtJson;

  if ASaveDataSetting.IsAddIfNotExist then
  begin

      //更新记录
      if not SimpleCallAPI('save_record_post',
                              nil,
                              GetInterfaceUrl+'tablecommonrest/',
                              ConvertToStringDynArray(['appid',
                                                      'user_fid',
                                                      'key',
                                                      'rest_name',
                                                      'check_exist_field_names']),
                              ConvertToVariantDynArray([GetAppID(ASaveDataSetting),
                                                        GetUserFID,
                                                        GetKey,
                                                        Name,
                                                        ASaveDataSetting.CheckExistFieldNames
                                                        ]),
                              ACode,
                              ADataIntfResult.Desc,
                              ADataIntfResult.DataJson,
                              GlobalRestAPISignType,
                              GlobalRestAPIAppSecret,
                              True,
                              nil,
                              ASaveDataSetting.RecordDataJson.AsJson
                              ) or (ACode<>SUCC)  then
      begin
//        uBaseLog.HandleException(nil,'SaveRecordToServer '+ADesc);
        Exit;
      end;

      Result:=True;


      Exit;
  end;


          //将接口保存到数据库
          if SaveRecordToServer(GetInterfaceUrl,//GlobalMainProgramSetting.DataIntfServerUrl,//Self.InterfaceUrl,//
                                GetAppID(ASaveDataSetting),
                                GetUserFID,
                                GetKey,
                                Self.Name,
                                ASaveDataSetting.EditingRecordKeyValue,//Self.FDataIntfResult.DataJson.I['fid'],
                                ASaveDataSetting.RecordDataJson,
                                ASaveDataSetting.IsAddedRecord,
                                ADataIntfResult.Desc,
                                ADataIntfResult.DataJson,
                                GlobalRestAPISignType,
                                GlobalRestAPIAppSecret,
                                FHasAppID,
                                Self.FKeyFieldName,
                                ASaveDataSetting.CustomWhereSQL,
                                ASaveDataSetting.CustomWhereKeyJson,
                                ASaveDataSetting.IsAddRecord) then
          begin
            ADataIntfResult.Succ:=True;//(ACode=SUCC);
//              //保存成功,要取出新增记录的fid
//              if AIsAdd then
//              begin
//                FPage.DataInterface.fid:=ADataJson.I['fid'];
//              end;
//              TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
            Result:=True;
          end
          else
          begin
        //      ShowMessage(ADesc);
            Exit;
          end;

end;



function TTableCommonRestHttpDataInterface.SaveDataList(
  ASaveDataSetting: TSaveDataSetting; ARecordList: ISuperArray;
  ADataIntfResult: TDataIntfResult): Boolean;
var
  ACode:Integer;
  I: Integer;
  ADesc:String;
  ADataJson:ISuperObject;
begin
  Result:=False;

  ADataIntfResult.DataType:=TDataIntfResultType.ldtJson;


  if ASaveDataSetting.IsAddIfNotExist then
  begin

    //更新记录
    if not SimpleCallAPI('save_record_list_post',
                            nil,
                            GetInterfaceUrl+'tablecommonrest/',
                            ConvertToStringDynArray(['appid',
                                                    'user_fid',
                                                    'key',
                                                    'rest_name',
                                                    'check_exist_field_names']),
                            ConvertToVariantDynArray([GetAppID(ASaveDataSetting),
                                                      GetUserFID,
                                                      GetKey,
                                                      Name,
                                                      ASaveDataSetting.CheckExistFieldNames
                                                      ]),
                            ACode,
                            ADataIntfResult.Desc,
                            ADataIntfResult.DataJson,
                            GlobalRestAPISignType,
                            GlobalRestAPIAppSecret,
                            True,
                            nil,
                            ARecordList.AsJson
                            ) or (ACode<>SUCC)  then
    begin
      uBaseLog.HandleError(nil,'TTableCommonRestHttpDataInterface.SaveDataList save_record_list_post '+ADataIntfResult.Desc);
      Exit;
    end;
    ADataIntfResult.Succ:=True;//(ACode=SUCC);
    Result:=True;
    Exit;
  end;


  ADataIntfResult.DataJson:=SO();
  for I := 0 to ARecordList.Length-1 do
  begin
          ACode:=FAIL;
          ADesc:='';
          ADataJson:=nil;
          //将接口保存到数据库
          if SaveRecordToServer(GetInterfaceUrl,//GlobalMainProgramSetting.DataIntfServerUrl,//Self.InterfaceUrl,//
                                GetAppID(ASaveDataSetting),
                                GetUserFID,
                                GetKey,
                                Self.Name,
                                ASaveDataSetting.EditingRecordKeyValue,//Self.FDataIntfResult.DataJson.I['fid'],
                                ARecordList.O[I],//ASaveDataSetting.RecordDataJson,
                                ASaveDataSetting.IsAddedRecord,
                                ADesc,
                                ADataJson,
                                GlobalRestAPISignType,
                                GlobalRestAPIAppSecret,
                                FHasAppID,
                                Self.FKeyFieldName,
                                ASaveDataSetting.CustomWhereSQL,
                                ASaveDataSetting.CustomWhereKeyJson) then
          begin
//            ADataIntfResult.Succ:=True;//(ACode=SUCC);
//              //保存成功,要取出新增记录的fid
//              if AIsAdd then
//              begin
//                FPage.DataInterface.fid:=ADataJson.I['fid'];
//              end;
//              TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
            ACode:=SUCC;
          end
          else
          begin
        //      ShowMessage(ADesc);
//            Exit;
          end;
          ADataIntfResult.DataJson.A['RecordList'].O[I]:=ReturnJson(ACode,ADesc,ADataJson);
  end;

  ADataIntfResult.Succ:=True;//(ACode=SUCC);
  Result:=True;

end;

function TTableCommonRestHttpDataInterface.AddDataList(
  ASaveDataSetting: TSaveDataSetting;
  ARecordList: ISuperArray;
  ADataIntfResult: TDataIntfResult): Boolean;
var
  ACode:Integer;
begin
  Result:=False;

  ADataIntfResult.DataType:=TDataIntfResultType.ldtJson;


  //不存在fid,表示要新增该记录
  if not SimpleCallAPI('add_record_list_post_2',
                          nil,
                          GetInterfaceUrl+'tablecommonrest/',
                          ConvertToStringDynArray(
                                                  ['appid',
                                                  'user_fid',
                                                  'key',
                                                  'rest_name'
                                                  ]),
                          ConvertToVariantDynArray([GetAppID(ASaveDataSetting),
                                                    GetUserFID,
                                                    GetKey,
                                                    Self.Name
                                                    ]),
                          ACode,
                          ADataIntfResult.Desc,
                          ADataIntfResult.DataJson,
                          GlobalRestAPISignType,
                          GlobalRestAPIAppSecret,
                          True,
                          nil,
                          ARecordList.AsJson
                          ) or (ACode<>SUCC) then
  begin
    uBaseLog.HandleError(nil,'TTableCommonRestHttpDataInterface.AddDataList add_record_list_post_2 '+ADataIntfResult.Desc);
    Exit;
  end;

  ADataIntfResult.Succ:=True;
  Result:=True;

end;

{ TRestHttpDataInterface }

function TRestHttpDataInterface.AddDataList(ASaveDataSetting: TSaveDataSetting;
  ARecordList: ISuperArray; ADataIntfResult: TDataIntfResult): Boolean;
begin

end;

function TRestHttpDataInterface.CustomLoadFromJson(
  ASuperObject: ISuperObject): Boolean;
begin
  InterfaceUrl:=ASuperObject.S['interface_url'];

end;

function TRestHttpDataInterface.DelData(ALoadDataSetting: TLoadDataSetting;ALoadDataIntfResult,
  ADataIntfResult: TDataIntfResult): Boolean;
begin

end;

function TRestHttpDataInterface.GetDataDetail(
  ALoadDataSetting: TLoadDataSetting;
  ADataIntfResult: TDataIntfResult): Boolean;
begin

end;

//procedure GetParamsArray(AParams:ISuperArray;var ALoadDataParamNames:TStringDynArray;var ALoadDataParamValues:TVariantDynArray);
//begin
//  //设置参数的长度
//  SetLength(ALoadDataParamNames,AParams.Length);
//  SetLength(ALoadDataParamValues,AParams.Length);
//
//
//  //{name:appid,value:1012,....}
//  for I := 0 to AParams.Length-1 do
//  begin
//    ALoadDataParamNames[I]:=AParams.O[I].S['name'];
//    ALoadDataParamValues[I]:=AParams.O[I].S['value'];
//  end;
//
//
//
//end;


function TRestHttpDataInterface.GetDataList(ALoadDataSetting: TLoadDataSetting;
  ADataIntfResult: TDataIntfResult): Boolean;
var
  ACode:Integer;
//  //加载参数名和参数值
//  ALoadDataParamNames:TStringDynArray;
//  ALoadDataParamValues:TVariantDynArray;
//  I: Integer;
begin
  Result:=False;


//  GetParamsArray(FLoadParams,ALoadDataParamNames,ALoadDataParamValues);

  //加载程序模板的所有功能和页面
  if not SimpleCallAPI(
                      Name,
                      nil,
                      InterfaceUrl+ALoadDataSetting.InterfaceName,
//                      ['appid',
//                      'user_fid',
//                      'key',
//                      'rest_name',
//                      'pageindex',
//                      'pagesize',
//                      'where_key_json',
//                      'order_by'
//                      ],
                      ALoadDataSetting.ParamNames,
//                      [
////                      ALoadDataSetting.AppID,
//                      GlobalMainProgramSetting.AppID,
//                      0,
//                      '',
//                      Name,
//                      ALoadDataSetting.PageIndex,
//                      ALoadDataSetting.PageSize,
//                      ALoadDataSetting.WhereKeyJson,
//                      ''//ALoadDataSetting.OrderBy
//                      ],
                      ALoadDataSetting.ParamValues,

                      ACode,
                      ADataIntfResult.Desc,
                      ADataIntfResult.DataJson,

                      GlobalRestAPISignType,
                      GlobalRestAPIAppSecret) then
  begin
    Exit;
  end;

  //保存到本地测试



  ADataIntfResult.DataType:=TDataIntfResultType.ldtJson;
  ADataIntfResult.Succ:=(ACode=SUCC);
  Result:=True;
end;

function TRestHttpDataInterface.SaveData(ASaveDataSetting: TSaveDataSetting;
  ADataIntfResult: TDataIntfResult): Boolean;
begin

end;

  {$IFDEF OPEN_PLATFORM_SERVER}
    //在开放平台服务端中使用
  {$ELSE}

{ TDefaultTableCommonRestHttpDataInterface }

constructor TDefaultTableCommonRestHttpDataInterface.Create;
begin
  inherited;
  FIsUseDefaultInterfaceUrl:=True;
end;

function TDefaultTableCommonRestHttpDataInterface.GetKey: String;
begin
  Result:=GlobalBaseManager.User.Key;
end;

function TDefaultTableCommonRestHttpDataInterface.GetUserFID: String;
begin
  Result:=GlobalBaseManager.User.fid;
end;
  {$ENDIF}

initialization
  {$IFDEF OPEN_PLATFORM_SERVER}
    //在开放平台服务端中使用
    GlobalDataInterfaceClassRegList.Add('TableCommonRestHttp',TTableCommonRestHttpDataInterface);
  {$ELSE}
    GlobalDataInterfaceClassRegList.Add('TableCommonRestHttp',TDefaultTableCommonRestHttpDataInterface);
  {$ENDIF}
  GlobalDataInterfaceClassRegList.Add('RestHttp',TRestHttpDataInterface);



end.
