//convert pas to utf8 by ¥

unit uManager;

interface

uses
  Classes,
  SysUtils,
  IniFiles,
  Types,
  UITypes,
  FMX.Forms,
  FMX.Graphics,
  uDrawTextParam,

  AIModels,


  uSkinItems,
  uSkinListViewType,

  StrUtils,
  uConst,
  Variants,
  IdURI,
  uBaseHttpControl,
  uDrawPicture,
  uOpenClientCommon,
//  uSkinMultiColorLabelType,
  uOpenCommon,
  uRestInterfaceCall,
  uCommandLineHelper,
//  IdHashSHA,
//  IdGlobal,
  System.Hash,
  uDatasetToJson,
  Winapi.WinSvc,
  Winapi.ShellApi,
  Windows,



//  uThumbCommon,
  uFuncCommon,
  uFileCommon,
  uBaseList,
//  uDataSetToJson,

  XSuperObject,
  XSuperJson
  ;


type


//  TScanInStoreMode=(
//                    //正常模式
//                    simNormal,
//                    //可以重复扫描并且直接插入数据库
//                    simCanRepeatAndDirectInsertToDB
//                    );

  TManager=class(TBaseManager)
//  public
//    //员工信息
//    EmployeeJson:ISuperObject;
//
//    //操作员
//    OperatorJson:ISuperObject;
//
////    //列表项样式
////    ProcessTaskOrderListItemStyle:String;
//
//    //扫码模式
//    ScanInStoreMode:TScanInStoreMode;

  public
    //基础数据
//    //班组列表
//    GroupArray:ISuperArray;
//    //车间列表
//    WorkShopArray:ISuperArray;
//    //工序列表
//    ProcessArray:ISuperArray;
//    //成品入库备注
//    NotesArray:ISuperArray;
//    //门类型
//    DoorTypeArray:ISuperArray;
//    //车间延期类型
//    WorkshopDelayTypeArray:ISuperArray;
//    //部门列表
//    DepartmentArray:ISuperArray;
//
//    //仓库列表
//    StorkArray:ISuperArray;
//    //物品类别列表
//    GoodsTypeArray:ISuperArray;



//    FCurrentProcess:String;
//    //当前选择的门类型
//    FCurrentDoorType:String;
//
//    //仓库页面中上次选择的仓库
//    FLastSelectStoreHourse:String;
//    //仓库页面中上次选择的物品类别
//    FLastSelectGoodsTypeCaption:String;
//    FLastSelectGoodsTypeValue:String;
//
//
//    function CurrentProcess:String;
//
//    //需要拥有权限
//    function HasPower(APowerName:String):Boolean;
//    //获取系统变量
//    function GetSysMemory(AName:String):String;
//  public
//    //用户界面的设置
//    UserUISettingJson:ISuperObject;
  protected
  public
    //给外网访问的IP地址,预览文件的时候需要
    FWebHost:String;
    //Web服务的端口
    FWebPort:Integer;
    //全局配置
    function CustomLoadFromINI(AIniFile:TIniFile): Boolean;override;
    function CustomSaveToINI(AIniFile:TIniFile): Boolean;override;
    //用户配置
    procedure CustomLoadFromUserConfigINI(AIniFile:TIniFile);override;
    procedure CustomSaveToUserConfigINI(AIniFile:TIniFile);override;
  public
    constructor Create;override;
    //加载本地搜索历史
    procedure LoadUserConfig;override;
    //保存本地搜索历史
    procedure SaveUserConfig;override;
    //保存上次登录的用户信息
    procedure SaveLastLoginInfo;override;
  public

//    FIsFirstRun:Boolean;

    //AI渠道类型
    AIChannelArray:ISuperArray;
    AIModelsJson:ISuperArray;
    MyAIModelsJson:ISuperArray;


    // FOneAPIUrl:String;
    // FOneAPIAccessToken:String;
    //OneApi已经配置的AI渠道
    FConfigedChannels:ISuperArray;
    // FExecuteOllamaListCommand:TExecuteCommand;
    // FIsInstalledOllama:Boolean;



    // //本地已经安装的大模型
    // FLocalInstalledModels:ISuperArray;

    // //AI应用
    // FJetAIApps:ISuperArray;
    // FJetAIToken:String;
    // FJetAILoginResponseJson:ISuperObject;
    FJetAIUrl:String;


//    //加载已经配置的AI
//    function LoadConfigedChannels(var ADesc:String):Boolean;
    //保存AI模型配置
    function SaveAIConfig(AIChannel:ISuperObject;AConfigedJson:ISuperObject;AOllamaConfigedJson:ISuperObject;AOfficicalKey:String;AOfficialModels:TStringList;AOllamaModels:TStringList;var ADesc:String):Boolean;

//    //添加一个用户自定义模型
//    procedure SaveCustomAIModel(AChannelJson:ISuperObject;AModleName:String);

  end;







var
  GlobalManager:TManager;





function GetOllamaSupportModelName(AOneAPIModelName:String):String;

function UploadPictureFile(AHttpControl:THttpControl;ALocalFilePath:String;var AServerFilePath:String):Boolean;



//procedure LoadDoorTypeToListView(ADoorTypeArray:ISuperArray;ASkinListView:TSkinListView);


implementation


//procedure LoadDoorTypeToListView(ADoorTypeArray:ISuperArray;ASkinListView:TSkinListView);
//var
//  I:Integer;
//  ASkinItem:TSkinItem;
//begin
//  //加载门类型
//  ASkinListView.Prop.Items.BeginUpdate;
//  try
//    ASkinListView.Prop.Items.Clear;
//
//    if (ADoorTypeArray<>nil) then
//    begin
//      for I := 0 to ADoorTypeArray.Length-1 do
//      begin
//        ASkinItem:=ASkinListView.Prop.Items.Add;
//        ASkinItem.Selected:=(I=0);
//        ASkinItem.Caption:=ADoorTypeArray.O[I].S['值的值'];
//        ASkinItem.Width:=1/ADoorTypeArray.Length;
//      end;
//
//      ASkinListView.Visible:=(GlobalManager.FCurrentDoorType<>'标门');
//    end
//    else
//    begin
//      ASkinListView.Visible:=False;
//    end;
//
//  finally
//    ASkinListView.Prop.Items.EndUpdate();
//  end;
//
//end;

function IsModelSize(AModelSize:String):Boolean;
var
  ASize:Double;
begin
  Result:=False;

  if AModelSize[Length(AModelSize)]='b' then
  begin
    //并且里面是数值
    if TryStrToFloat(Copy(AModelSize,1,Length(AModelSize)-1),ASize) then
    begin
      Result:=True;
    end;
  end;
end;


function GetOllamaSupportModelName(AOneAPIModelName:String):String;
var
  ASplitStringList:TStringList;
begin

  Result:=AOneAPIModelName;

  ASplitStringList:=TStringList.Create;
  try
    ASplitStringList.StrictDelimiter:=True;
    ASplitStringList.Delimiter:='-';
    ASplitStringList.DelimitedText:=AOneAPIModelName;

    //"qwen2-7b-instruct"
    //  deepseek-r1
    if ASplitStringList.Count>=2 then
    begin

      if IsModelSize(ASplitStringList[1]) then
      begin
        Result:=ASplitStringList[0]+':'+ASplitStringList[1];
      end;


    end
    else
    begin
      Result:=ASplitStringList[0];
    end;

  finally
    ASplitStringList.Free;

  end;


end;

function UploadPictureFile(AHttpControl:THttpControl;ALocalFilePath:String;var AServerFilePath:String):Boolean;
var
  ASuperObject:ISuperObject;
  APicStream:TMemoryStream;
  AResponseStream:TStringStream;
begin
  Result:=False;
  //上传图片
  APicStream:=TMemoryStream.Create;
  AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
  try
    APicStream.LoadFromFile(ALocalFilePath);
    Result:=AHttpControl.Post(
                              ImageHttpServerUrl
                              +'/Upload'
                              +'?FileName='+ExtractFileName(ALocalFilePath)
                              +'&FileDir='+'Temp',

                              //图片文件
                              APicStream,
                              //返回数据流
                              AResponseStream
                              );
    if Result then
    begin
      Result:=False;

      AResponseStream.Position:=0;

      //ASuperObject:=TSuperObject.ParseStream(AResponseStream);
      //会报错'Access violation at address 004B6C7C in module ''Server.exe''. Read of address 00000000'
      //要从AResponseStream.DataString加载
      ASuperObject:=TSuperObject.Create(AResponseStream.DataString);

      if ASuperObject.I['Code']=200 then
      begin
        AServerFilePath:=ASuperObject.O['Data'].S['FileName'];
        Result:=True;
      end;

    end
    else
    begin
      //图片上传失败
    end;

  finally
    uFuncCommon.FreeAndNil(APicStream);
    uFuncCommon.FreeAndNil(AResponseStream);
  end;
end;



{ TManager }


function TManager.CustomLoadFromINI(AIniFile: TIniFile): Boolean;
var
  I:Integer;
begin
  Inherited CustomLoadFromINI(AIniFile);

//  AppID:=AIniFile.ReadInteger('','AppID',AppID);
//
//  Self.CenterServerHost:=AIniFile.ReadString('','CenterServerHost',CenterServerHost);
//  Self.CenterServerPort:=AIniFile.ReadInteger('','CenterServerPort',CenterServerPort);

//  //列表项样式
//  Self.ProcessTaskOrderListItemStyle:=AIniFile.ReadString('','ProcessTaskOrderListItemStyle','');

//  ScanInStoreMode:=TScanInStoreMode(AIniFile.ReadInteger('','ScanInStoreMode',0));

//  FIsFirstRun:=AIniFile.ReadBool('','IsFirstRun',True);
  //给外网访问的IP地址,预览文件的时候需要
  FWebHost:=AIniFile.ReadString('','WebHost','localhost');
  //Web服务的端口
  FWebPort:=AIniFile.ReadInteger('','WebPort',Const_Node_Port);

  FJetAIUrl:='';




  //加载AI渠道列表
  // 也就是模型供应商列表
  // AIChannelArray:=SA(GetStringFromFile(GetApplicationPath+'channel.json',TEncoding.UTF8));
  AIChannelArray:=GetDefaultChannelList();
  // 模型厂商都在providers中





  //加载AI模型列表
  // AIModelsJson:=SO(GetStringFromFile(GetApplicationPath+'models.json',TEncoding.UTF8));
  AIModelsJson:=GetDefaultModelList();

  // if FileExists(GetApplicationPath+'my_models.json') then
  // begin
  //   //用户自己添加的模型
  //   MyAIModelsJson:=SO(GetStringFromFile(GetApplicationPath+'my_models.json',TEncoding.UTF8));
  // end
  // else
  // begin
  //   MyAIModelsJson:=SO();
  // end;


  // for I := 0 to AIChannelArray.Length-1 do
  // begin
  //   AIChannelArray.O[I].A['models']:=AIModelsJson.O['data'].A[IntToStr(AIChannelArray.O[I].I['value'])];
  //   //如果存在用户自定义的模型,那么需要添加进去
  //   ConcatJsonArray(AIChannelArray.O[I].A['models'],MyAIModelsJson.O['data'].A[IntToStr(AIChannelArray.O[I].I['value'])]);

  //   //配对图标
  //   if AIChannelArray.O[I].S['icon_file']='' then
  //   begin
  //     if FileExists(GetApplicationPath+'icons'+PathDelim+AIChannelArray.O[I].S['text']+'.svg') then
  //     begin
  //       AIChannelArray.O[I].S['icon_file']:=AIChannelArray.O[I].S['text']+'.svg';
  //     end
  //     else if FileExists(GetApplicationPath+'icons'+PathDelim+AIChannelArray.O[I].S['text']+'.png') then
  //     begin
  //       AIChannelArray.O[I].S['icon_file']:=AIChannelArray.O[I].S['text']+'.png';
  //     end;
  //   end;

  // end;



end;

procedure TManager.CustomLoadFromUserConfigINI(AIniFile: TIniFile);
begin
  Inherited CustomLoadFromUserConfigINI(AIniFile);

//  FLastSelectStoreHourse:=AIniFile.ReadString('','LastSelectStoreHourse','');
//  FLastSelectGoodsTypeCaption:=AIniFile.ReadString('','LastSelectGoodsTypeCaption','');
//  FLastSelectGoodsTypeValue:=AIniFile.ReadString('','LastSelectGoodsTypeValue','');


end;

function TManager.SaveAIConfig(AIChannel:ISuperObject;AConfigedJson:ISuperObject;AOllamaConfigedJson:ISuperObject;AOfficicalKey:String;AOfficialModels:TStringList;AOllamaModels:TStringList;var ADesc:String):Boolean;
var
  ARequest:TStringStream;
  AResponse:TStringStream;
  ASuperObject:ISuperObject;
  APostJson:ISuperObject;
  ASystemHttpControl:TSystemHttpControl;
  AJetAIDataJson:ISuperObject;
  AJetAIModelJson:ISuperObject;
  I: Integer;
  AOpenClawJson:ISuperObject;
begin

  Result:=False;
  //保存设置




//  //规则,官方的和自己布署的怎么都保存在一起？
//  //官方只需要保存sk和支持的模型即可
//  //本地部署的需要从Ollama中获取
//  //所以,一个模型,需要保存两条记录，挺麻烦的
//  if not AConfigedJson.Contains('id') then
//  begin
//    AConfigedJson:=SO();
//
//    AConfigedJson.I['type']:=AIChannel.I['value'];
//    AConfigedJson.S['name']:=AIChannel.S['text'];
//    AConfigedJson.S['key']:='1234567';
//    AConfigedJson.A['groups']:=SA();
//    AConfigedJson.A['groups'].S[0]:='default';
//    AConfigedJson.S['group']:='default';
//
//  end;
//  //官方渠道保存到oneapi
//  AConfigedJson.S['key']:=AOfficicalKey;
//  AConfigedJson.S['models']:=AOfficialModels.CommaText;
//
//
//  ASystemHttpControl:=TSystemHttpControl.Create();
//  ASystemHttpControl.SetCustomHeader(['Authorization',FOneAPIAccessToken]);
//  AResponse:=TStringStream.Create('',TEncoding.UTF8);
//  ARequest:=TStringStream.Create(AConfigedJson.AsJSON,TEncoding.UTF8);
//  try
//    //保存到oneapi
//    if AConfigedJson.Contains('id') then
//    begin
//      //PUT是修改
//  //    AResponse:=SimpleCallAPI('channel/',nil,FOneAPIUrl,[],[],'','',True,nil,AConfigedJson.AsJSON,['Authorization',FOneAPIAccessToken]);
//  //    ASuperObject:=SO(AResponse);
//      ASystemHttpControl.Put(FOneAPIUrl+'channel/',ARequest,AResponse);
//
//    end
//    else
//    begin
//      //Post是添加
//  //    AResponse:=SimpleCallAPI('channel/',nil,FOneAPIUrl,[],[],'','',True,nil,AConfigedJson.AsJSON,['Authorization',FOneAPIAccessToken]);
//  //    ASuperObject:=SO(AResponse);
//      ASystemHttpControl.Post(FOneAPIUrl+'channel/',ARequest,AResponse);
//
//    end;
//    ASuperObject:=SO(AResponse.DataString);
//    if not ASuperObject.B['success'] then
//    begin
//      ADesc:=ASuperObject.S['message'];
//      Exit;
//    end;
//    AConfigedJson:=ASuperObject.O['data'];
//
//
//  finally
//    FreeAndNil(ARequest);
//    FreeAndNil(AResponse);
//    FreeAndNil(ASystemHttpControl);
//  end;

















//  //本地部署的ollama渠道怎么存呢？
//  if not AOllamaConfigedJson.Contains('id') then
//  begin
//    AOllamaConfigedJson:=SO();
//    //  { key: 30, text: 'Ollama', value: 30, color: 'black' },
//    //{
//    //  "name": "jjj",
//    //  "type": 1,
//    //  "key": "jjjj",
//    //  "base_url": "",
//    //  "other": "",
//    //  "model_mapping": "",
//    //  "system_prompt": "",
//    //  "models": "gpt-3.5-turbo",
//    //  "groups": [
//    //    "default"
//    //  ],
//    //  "group": "default",
//    //  "config": "{\"region\":\"\",\"sk\":\"\",\"ak\":\"\",\"user_id\":\"\",\"vertex_ai_project_id\":\"\",\"vertex_ai_adc\":\"\"}"
//    //}
//    AOllamaConfigedJson.I['type']:=30;
//    AOllamaConfigedJson.S['name']:='Ollama';
//    AOllamaConfigedJson.S['key']:='1234567';
//    AOllamaConfigedJson.A['groups']:=SA();
//    AOllamaConfigedJson.A['groups'].S[0]:='default';
//    AOllamaConfigedJson.S['group']:='default';
//  end;
//  //把本地安装的模型加进来
//  AOllamaConfigedJson.S['models']:=AOllamaModels.CommaText;
//  ASystemHttpControl:=TSystemHttpControl.Create();
//  ASystemHttpControl.SetCustomHeader(['Authorization',FOneAPIAccessToken]);
//  AResponse:=TStringStream.Create('',TEncoding.UTF8);
//  ARequest:=TStringStream.Create(AOllamaConfigedJson.AsJSON,TEncoding.UTF8);
//  try
//    //保存到oneapi
//    if AOllamaConfigedJson.Contains('id') then
//    begin
//      //PUT是修改
//  //    AResponse:=SimpleCallAPI('channel/',nil,FOneAPIUrl,[],[],'','',True,nil,AConfigedJson.AsJSON,['Authorization',FOneAPIAccessToken]);
//  //    ASuperObject:=SO(AResponse);
//      ASystemHttpControl.Put(FOneAPIUrl+'channel/',ARequest,AResponse);
//
//    end
//    else
//    begin
//      //Post是添加
//  //    AResponse:=SimpleCallAPI('channel/',nil,FOneAPIUrl,[],[],'','',True,nil,AConfigedJson.AsJSON,['Authorization',FOneAPIAccessToken]);
//  //    ASuperObject:=SO(AResponse);
//      ASystemHttpControl.Post(FOneAPIUrl+'channel/',ARequest,AResponse);
//
//    end;
//    ASuperObject:=SO(AResponse.DataString);
//    if not ASuperObject.B['success'] then
//    begin
//      ADesc:=ASuperObject.S['message'];
//      Exit;
//    end;
//    AOllamaConfigedJson:=ASuperObject.O['data'];
//  finally
//    FreeAndNil(ARequest);
//    FreeAndNil(AResponse);
//    FreeAndNil(ASystemHttpControl);
//  end;


  //当前要使用哪些模型？







  //改data.json,把模型加进去
  AJetAIDataJson:=SO(GetStringFromFile(GetApplicationPath+'config.json',TEncoding.UTF8));

  for I := 0 to AOfficialModels.Count-1 do
  begin
    AJetAIModelJson:=LocateJsonArray(AJetAIDataJson.A['llmModels'],'model',AOfficialModels[I]);
    if AJetAIModelJson<>nil then Continue;

    //判断模型在不在里面,如果不在里面就加进去,再里面就删除
    AJetAIModelJson:=SO();
    AJetAIModelJson.S['provider']:='Alibaba';//模型供应商
    AJetAIModelJson.S['model']:=AOfficialModels[I];
    AJetAIModelJson.S['name']:=AOfficialModels[I];
    AJetAIModelJson.I['maxContext']:=125000;
    AJetAIModelJson.I['maxResponse']:=4000;
    AJetAIModelJson.I['quoteMaxToken']:=120000;
    AJetAIModelJson.F['maxTemperature']:=1.2;
    AJetAIModelJson.F['charsPointsPrice']:=0;
    AJetAIModelJson.B['censor']:=false;
    AJetAIModelJson.B['vision']:=true;
    AJetAIModelJson.B['datasetProcess']:=true;
    AJetAIModelJson.B['usedInClassify']:=true;
    AJetAIModelJson.B['usedInExtractFields']:=true;
    AJetAIModelJson.B['usedInToolCall']:=true;
    AJetAIModelJson.B['usedInQueryExtension']:=true;
    AJetAIModelJson.B['toolChoice']:=true;
    AJetAIModelJson.B['functionCall']:=false;
    AJetAIModelJson.S['customCQPrompt']:='';
    AJetAIModelJson.S['customExtractPrompt']:='';
    AJetAIModelJson.S['defaultSystemChatPrompt']:='';
    AJetAIModelJson.O['defaultConfig']:=SO();
    AJetAIModelJson.O['fieldMap']:=SO();
    AJetAIDataJson.A['llmModels'].O[AJetAIDataJson.A['llmModels'].Length]:=AJetAIModelJson;

    SaveStringToFile(AJetAIDataJson.AsJson,GetApplicationPath+'config.json',TEncoding.UTF8)
  end;



  for I := 0 to AOllamaModels.Count-1 do
  begin
    AJetAIModelJson:=LocateJsonArray(AJetAIDataJson.A['llmModels'],'model',AOllamaModels[I]);
    if AJetAIModelJson<>nil then Continue;

    //判断模型在不在里面,如果不在里面就加进去,再里面就删除
    AJetAIModelJson:=SO();
    AJetAIModelJson.S['provider']:='Ollama';//模型供应商
    AJetAIModelJson.S['model']:=AOllamaModels[I];
    AJetAIModelJson.S['name']:=AOllamaModels[I];
    AJetAIModelJson.I['maxContext']:=125000;
    AJetAIModelJson.I['maxResponse']:=4000;
    AJetAIModelJson.I['quoteMaxToken']:=120000;
    AJetAIModelJson.F['maxTemperature']:=1.2;
    AJetAIModelJson.F['charsPointsPrice']:=0;
    AJetAIModelJson.B['censor']:=false;
    AJetAIModelJson.B['vision']:=true;
    AJetAIModelJson.B['datasetProcess']:=true;
    AJetAIModelJson.B['usedInClassify']:=true;
    AJetAIModelJson.B['usedInExtractFields']:=true;
    AJetAIModelJson.B['usedInToolCall']:=true;
    AJetAIModelJson.B['usedInQueryExtension']:=true;
    AJetAIModelJson.B['toolChoice']:=true;
    AJetAIModelJson.B['functionCall']:=false;
    AJetAIModelJson.S['customCQPrompt']:='';
    AJetAIModelJson.S['customExtractPrompt']:='';
    AJetAIModelJson.S['defaultSystemChatPrompt']:='';
    AJetAIModelJson.O['defaultConfig']:=SO();
    AJetAIModelJson.O['fieldMap']:=SO();
    AJetAIDataJson.A['llmModels'].O[AJetAIDataJson.A['llmModels'].Length]:=AJetAIModelJson;


    SaveStringToFile(AJetAIDataJson.AsJson,GetApplicationPath+'config.json',TEncoding.UTF8)
  end;





//  if AOfficialModels.Count>0 then
//  begin
//      //找到对应的应用,然后修改模型即可
////      APostJson:=LocateJsonArray(Self.FJetAIApps,['channel_text','is_official'],[AIChannel.S['text'],True]);
//      APostJson:=LocateJsonArray(Self.FJetAIApps,['name'],[AIChannel.S['text']+'-'+'官方']);
//
//      if APostJson=nil then
//      begin
//        //新建一个应用
//        APostJson:=SO(GetStringFromFile(GetApplicationPath+'emptyapp.json',TEncoding.UTF8));
//        APostJson.S['name']:=AIChannel.S['text']+'-'+'官方';
////        //渠道的信息
////        APostJson.S['channel_text']:=AIChannel.S['text'];
////        APostJson.I['channel_type']:=AIChannel.I['value'];
////        APostJson.B['is_official']:=True;
//      //指定AI模型
//      ASuperObject:=LocateJsonArray(APostJson.A['modules'],'name','common:core.module.template.ai_chat');
//      ASuperObject:=LocateJsonArray(ASuperObject.A['inputs'],'key','model');
//      ASuperObject.S['value']:=AOfficialModels[0];
//
//
//
//      ASystemHttpControl:=TSystemHttpControl.Create();
//      AResponse:=TStringStream.Create('',TEncoding.UTF8);
//      ARequest:=TStringStream.Create(APostJson.AsJson,TEncoding.UTF8);
//      try
//        ASystemHttpControl.FNetHTTPClient.ContentType:='application/json; charset=utf-8';
//
//        //    ASystemHttpControl.SetCustomHeader(['Authorization','Bearer '+FJetAIToken]);
//        ASystemHttpControl.SetCustomHeader(['Cookie','jetai_token='+FJetAIToken]);
//
//
//        if not APostJson.Contains('_id') then
//        begin
//            //新建应用
//            ASystemHttpControl.Post(FJetAIUrl+'api/core/app/create',ARequest,AResponse);
//        end
//        else
//        begin
//            //修改应用,保存应用
//
//        end;
//
//        //'{"code":200,"statusText":"","message":"","data":"67b592c962566c097425bec9"}'
//        ASuperObject:=SO(AResponse.DataString);
//
//
//
//        if ASuperObject.I['code']<>200 then
//        begin
//          ADesc:=ASuperObject.S['message'];
//          Exit;
//        end;
//
//
//      finally
//        FreeAndNil(ARequest);
//        FreeAndNil(AResponse);
//        FreeAndNil(ASystemHttpControl);
//      end;
//
//      end;
//  end;
//
//
//  if AOllamaModels.Count>0 then
//  begin
//      //找到对应的应用,然后修改模型即可
////      APostJson:=LocateJsonArray(Self.FJetAIApps,['channel_text','is_official'],[AIChannel.S['text'],False]);
//      APostJson:=LocateJsonArray(Self.FJetAIApps,['name'],[AIChannel.S['text']+'-'+'本地']);
//
//      if APostJson=nil then
//      begin
//        //新建一个应用
//        APostJson:=SO(GetStringFromFile(GetApplicationPath+'emptyapp.json',TEncoding.UTF8));
//        APostJson.S['name']:=AIChannel.S['text']+'-'+'本地';
////        //渠道的信息
////        APostJson.S['channel_text']:=AIChannel.S['text'];
////        APostJson.I['channel_type']:=AIChannel.I['value'];
////        APostJson.B['is_official']:=False;
//      //指定AI模型
//      ASuperObject:=LocateJsonArray(APostJson.A['modules'],'name','common:core.module.template.ai_chat');
//      ASuperObject:=LocateJsonArray(ASuperObject.A['inputs'],'key','model');
//      ASuperObject.S['value']:=AOllamaModels[0];
//
//
//
//      ASystemHttpControl:=TSystemHttpControl.Create();
//      AResponse:=TStringStream.Create('',TEncoding.UTF8);
//      ARequest:=TStringStream.Create(APostJson.AsJson,TEncoding.UTF8);
//      try
//        ASystemHttpControl.FNetHTTPClient.ContentType:='application/json; charset=utf-8';
//
//        //    ASystemHttpControl.SetCustomHeader(['Authorization','Bearer '+FJetAIToken]);
//        ASystemHttpControl.SetCustomHeader(['Cookie','jetai_token='+FJetAIToken]);
//
//
//        if not APostJson.Contains('_id') then
//        begin
//            //新建应用
//            ASystemHttpControl.Post(FJetAIUrl+'api/core/app/create',ARequest,AResponse);
//        end
//        else
//        begin
//            //修改应用,保存应用
//
//        end;
//
//        //'{"code":200,"statusText":"","message":"","data":"67b592c962566c097425bec9"}'
//        ASuperObject:=SO(AResponse.DataString);
//
//
//
//        if ASuperObject.I['code']<>200 then
//        begin
//          ADesc:=ASuperObject.S['message'];
//          Exit;
//        end;
//
//
//      finally
//        FreeAndNil(ARequest);
//        FreeAndNil(AResponse);
//        FreeAndNil(ASystemHttpControl);
//      end;
//
//      end;
//  end;



  Result:=True;

end;

//procedure TManager.SaveCustomAIModel(AChannelJson: ISuperObject; AModleName: String);
//var
//  AModels:ISuperArray;
//begin
//
//  AChannelJson.A['models'].S[AChannelJson.A['models'].Length]:=AModleName;
//
//  AModels:=MyAIModelsJson.O['data'].A[IntToStr(AChannelJson.I['value'])];
//  AModels.S[AModels.Length]:=AModleName;
//  //用户自己添加的模型
//  SaveStringToFile(MyAIModelsJson.AsJson,GetApplicationPath+'my_models.json',TEncoding.UTF8);
//
//end;

procedure TManager.SaveLastLoginInfo;
begin
  inherited;
  ForceDirectories(GetUserLocalDir);
//  Self.SaveToUserInfoINI(GetUserLocalDir+'LastLoginOperator.json');

//  if Self.OperatorJson<>nil then
//  begin
//    SaveJsonToFile(OperatorJson,GetUserLocalDir+'LastLoginOperator.json');
//  end;
//
//  if Self.EmployeeJson<>nil then
//  begin
//    SaveJsonToFile(EmployeeJson,GetUserLocalDir+'LastLoginEmployee.json');
//  end;
end;

function TManager.CustomSaveToINI(AIniFile: TIniFile): Boolean;
begin
  Inherited CustomSaveToINI(AIniFile);

//  AIniFile.WriteInteger('','AppID',AppID);
//
//  AIniFile.WriteString('','CenterServerHost',Self.CenterServerHost);
//  AIniFile.WriteInteger('','CenterServerPort',Self.CenterServerPort);

//  AIniFile.WriteString('','ProcessTaskOrderListItemStyle',ProcessTaskOrderListItemStyle);

//  AIniFile.WriteInteger('','ScanInStoreMode',Ord(ScanInStoreMode));

//  AIniFile.WriteBool('','IsFirstRun',FIsFirstRun);

  //给外网访问的IP地址,预览文件的时候需要
  AIniFile.WriteString('','WebHost',FWebHost);
  //Web服务的端口
  AIniFile.WriteInteger('','WebPort',FWebPort);

end;

procedure TManager.CustomSaveToUserConfigINI(AIniFile: TIniFile);
begin
  Inherited CustomSaveToUserConfigINI(AIniFile);

//  AIniFile.WriteString('','LastSelectStoreHourse',FLastSelectStoreHourse);
//  AIniFile.WriteString('','LastSelectGoodsTypeCaption',FLastSelectGoodsTypeCaption);
//  AIniFile.WriteString('','LastSelectGoodsTypeValue',FLastSelectGoodsTypeValue);

end;

//function TManager.GetSysMemory(AName: String): String;
//var
//  ASuperObject:ISuperObject;
//begin
//  Result:='';
//  ASuperObject:=LocateJsonArray(Self.EmployeeJson.A['sys_memory'],'变量名',AName);
//  if ASuperObject<>nil then
//  begin
//    Result:=ASuperObject.S['值'];
//  end;
//end;
//
//function TManager.HasPower(APowerName: String): Boolean;
//var
//  I: Integer;
//  ARolePowerJson:ISuperObject;
//begin
//  Result:=False;
//
//  if (Self.FCurrentDoorType='标门') and ((APowerName='品质报表') or (APowerName='品质管理')) then
//  begin
//    Result:=False;
//    Exit;
//  end;
//
////  if (EmployeeJson.S['权限']='管理员') then
////  begin
////      Result:=True;
////  end;
//
//  Result:=True;
//
////  if not EmployeeJson.Contains('RolePowerList') then
////  begin
////      //服务端还没有更新过
////      //原来的权限 ：管理员、车间主任、操作员
////      if (EmployeeJson.S['权限']='管理员') then
////      begin
////
////          Result:=True;
////      end
////      else
////      begin
////          //管理员、车间主任、操作员
////          if EmployeeJson.A['RolePowerList'].Length=0 then
////          begin
////
////            //操作员权限
////            ARolePowerJson:=SO();
////            ARolePowerJson.S['name']:='报工报表';
////            ARolePowerJson.S['value']:='1';
////            EmployeeJson.A['RolePowerList'].O[EmployeeJson.A['RolePowerList'].Length]:=ARolePowerJson;
////
////            ARolePowerJson:=SO();
////            ARolePowerJson.S['name']:='车间报工';
////            ARolePowerJson.S['value']:='1';
////            EmployeeJson.A['RolePowerList'].O[EmployeeJson.A['RolePowerList'].Length]:=ARolePowerJson;
////
////            ARolePowerJson:=SO();
////            ARolePowerJson.S['name']:='异常分析';
////            ARolePowerJson.S['value']:='1';
////            EmployeeJson.A['RolePowerList'].O[EmployeeJson.A['RolePowerList'].Length]:=ARolePowerJson;
////
////
////
////            if (EmployeeJson.S['权限']='车间主任') then
////            begin
////
////              ARolePowerJson:=SO();
////              ARolePowerJson.S['name']:='订单管理';
////              ARolePowerJson.S['value']:='1';
////              EmployeeJson.A['RolePowerList'].O[EmployeeJson.A['RolePowerList'].Length]:=ARolePowerJson;
////
////
////              ARolePowerJson:=SO();
////              ARolePowerJson.S['name']:='生产进度';
////              ARolePowerJson.S['value']:='1';
////              EmployeeJson.A['RolePowerList'].O[EmployeeJson.A['RolePowerList'].Length]:=ARolePowerJson;
////
////              ARolePowerJson:=SO();
////              ARolePowerJson.S['name']:='车间延期';
////              ARolePowerJson.S['value']:='1';
////              EmployeeJson.A['RolePowerList'].O[EmployeeJson.A['RolePowerList'].Length]:=ARolePowerJson;
////
////
////            end;
////          end;
////
////
////
////      end;
////
////  end;
////
////  //服务端更新过了
////  for I := 0 to Self.EmployeeJson.A['RolePowerList'].Length-1 do
////  begin
////
////    if (EmployeeJson.A['RolePowerList'].O[I].S['name']=APowerName)
////      and (EmployeeJson.A['RolePowerList'].O[I].S['value']='1') then
////    begin
////      Result:=True;
////      Break;
////    end;
////
////  end;
//
//end;


//function GetSHA256Hash(const Input: string): string;
//var
//  SHA256: TIdHashSHA256;
//  HashBytes: TIdBytes;
//begin
//  SHA256 := TIdHashSHA256.Create;
//  try
//    // 计算SHA256哈希值，返回字节数组
//    //[dcc32 Error] uManager.pas(624): E2010 Incompatible types: 'IIdTextEncoding' and 'TEncoding'
//    HashBytes := SHA256.HashString(Input, IndyTextEncoding_UTF8);
//
//    // 将字节数组转换为十六进制字符串
//    Result := '';
//    for var I := 0 to Length(HashBytes) - 1 do
//      Result := Result + IntToHex(HashBytes[I], 2);
//  finally
//    SHA256.Free;
//  end;
//end;

//function TManager.LoadConfigedChannels(var ADesc:String):Boolean;
//var
//  APostString:String;
//  AResponse:String;
//  APostJson:ISuperObject;
//  ASuperObject:ISuperObject;
//  I: Integer;
//  ALog:String;
//  ASplitStringList:TStringList;
//  ARequest:TStringStream;
//  AResponseStream:TStringStream;
//  ASystemHttpControl:TSystemHttpControl;
//begin
//  Result:=False;
//
//
//
//
//  //从oneapi加载已经配置的AI
//  try
//    //先登录one-api
//    APostJson:=SO();
//    APostJson.S['username']:='root';
//    APostJson.S['password']:='123456';
//    {username: "root", password: "123456"}
//    AResponse:=SimpleCallAPI('user/login/',nil,FOneAPIUrl,[],[],'','',True,nil,APostJson.AsJSON);
//
//
//    if AResponse='' then
//    begin
//      ADesc:='OneAPI服务未连接成功,请确认该服务是否启动';
//      Exit;
//    end;
//
//    //'{"data":{"id":1,"username":"root","password":"","display_name":"Root User","role":100,"status":1,"email":"","github_id":"","wechat_id":"","lark_id":"","oidc_id":"","verification_code":"","access_token":"b4a2e2a1c95649be9e375dd9d98d8837","quota":0,"used_quota":0,"request_count":0,"group":"","aff_code":"","inviter_id":0},"message":"","success":true}'
//    ASuperObject:=SO(AResponse);
//    FOneAPIAccessToken:=ASuperObject.O['data'].S['access_token'];
//
//
//    //获取oneapi的access_token
//
//
//    //获取oneapi已经配置的渠道
//    //http://localhost:3001/api/channel/
//    //http://localhost:3002/api/channel/?access_token=b4a2e2a1c95649be9e375dd9d98d8837
//    //{"data":[{"id":3,"type":17,"key":"","status":1,"name":"阿里通义千问官方","weight":0,"created_time":1736811703,"test_time":1739675710,"response_time":436,"base_url":"","other":"","balance":0,"balance_updated_time":0,"models":"qwen-turbo,qwen-plus,qwen-max,qwen-max-longcontext,text-embedding-v1,ali-stable-diffusion-xl,ali-stable-diffusion-v1.5,wanx-v1,qwen2.5-72b-instruct","group":"default","used_quota":1233941,"model_mapping":"","priority":0,"config":"{\"region\":\"\",\"sk\":\"\",\"ak\":\"\",\"user_id\":\"\"}","system_prompt":null}],"message":"","success":true}
//    AResponse:=SimpleCallAPI('channel/',nil,FOneAPIUrl,[],[],'','',False,nil,'',['Authorization',FOneAPIAccessToken]);
//    if AResponse='' then
//    begin
//      ADesc:='OneAPI服务未连接成功,请确认该服务是否启动';
//      Exit;
//    end;
//    ASuperObject:=SO(AResponse);
//    Self.FConfigedChannels:=ASuperObject.A['data'];
//
//
//  except
//    on E:Exception do
//    begin
//      ADesc:='连接OneAPI服务异常：'+E.Message;
//      Exit;
//    end;
//  end;
//
//
//
//
//  //获取已经创建的AI应用
//  APostJson:=SO();
//  APostJson.S['username']:='root';
//
//  ///* hash string */
//  //export const hashStr = (str: string) => {
//  //  return crypto.createHash('sha256').update(str).digest('hex');
//  //};
//
//  APostJson.S['password']:=THashSHA2.GetHashString('123456');
//
//
//
//  {username: "root", password: "123456"}
//  APostString:=APostJson.AsJSON;
////  APostString:=ReplaceStr(APostString,'"username"','username');
////  APostString:=ReplaceStr(APostString,'"password"','password');
//  //  APostString:=ReplaceStr(APostString,'"username"','username');
//{
//  "username": "root",
//  "password": "8b3dac8cee7085590b9c93ffb47875506874b707017d50a5e2c3ad8e0f7e9d2e"
//}
//  //'{"code":403,"statusText":"unAuthorization","message":"common:code_error.error_message.403","data":null}'
//  //FNetHTTPClient.ContentType:='application/octet-stream; charset=utf-8';
//
////  AResponse:=SimpleCallAPI('support/user/account/loginByPassword',nil,FJetAIAPIUrl,[],[],'','',True,nil,APostString);
////  ASuperObject:=SO(AResponse);
//
//
//  ASystemHttpControl:=TSystemHttpControl.Create();
//  AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
//  ARequest:=TStringStream.Create(APostString,TEncoding.UTF8);
//  try
//    try
//        ASystemHttpControl.FNetHTTPClient.ContentType:='application/json; charset=utf-8';
//        ASystemHttpControl.Post(FJetAIUrl+'api/support/user/account/loginByPassword',ARequest,AResponseStream);
//
//
//
//        ASuperObject:=SO(AResponseStream.DataString);
//        if ASuperObject.I['code']<>200 then
//        begin
//          ADesc:=ASuperObject.S['message'];
//          Exit;
//        end;
//
//        //API密钥藏在令牌中
//        ASystemHttpControl.FHTTPResponse.GetCookies;
//        for I := 0 to ASystemHttpControl.FHTTPResponse.Cookies.Count-1 do
//        begin
//          if ASystemHttpControl.FHTTPResponse.Cookies[I].name='jetai_token' then
//          begin
//            FJetAIToken:=ASystemHttpControl.FHTTPResponse.Cookies[I].Value;
//            Break;
//          end;
//
//        end;
//
//        FJetAILoginResponseJson:=ASuperObject.O['data'];
//
//
//    //     ARequest:=TStringStream.Create('{}',TEncoding.UTF8);
//        ARequest.WriteString('{}');
//    //    ASystemHttpControl.SetCustomHeader(['Authorization','Bearer '+FJetAIToken]);
//        ASystemHttpControl.SetCustomHeader(['Cookie','jetai_token='+FJetAIToken]);
//        ASystemHttpControl.Post(FJetAIUrl+'api/core/app/list',ARequest,AResponseStream);
//        ASuperObject:=SO(AResponseStream.DataString);
//
//        if ASuperObject.I['code']<>200 then
//        begin
//          ADesc:=ASuperObject.S['message'];
//          Exit;
//        end;
//
//
//        FJetAIApps:=ASuperObject.A['data'];
//        //还得把明细取下来，明细里面才有模型,或者应用名称直接用模型名称呗
//
//    except
//      on E:Exception do
//      begin
//        ADesc:='连接Node服务异常：'+E.Message;
//        Exit;
//      end;
//    end;
//
//
//  finally
//    FreeAndNil(ARequest);
//    FreeAndNil(AResponseStream);
//    FreeAndNil(ASystemHttpControl);
//  end;
//
//
//
//  FLocalInstalledModels:=SA();
//  //获取ollama已经安装的本地大模型
//  FExecuteOllamaListCommand:=TExecuteCommand.Create(nil);
//  try
//
//    FExecuteOllamaListCommand.FTag:='';
//    FExecuteOllamaListCommand.FPipeUseTypes:=[putReadFromStdout,putWriteToStdin];
//  //  FExecuteOllamaListCommand.FOnGetData:=Self.DoGetDataEvent;
//  //  FExecuteOllamaListCommand.FOnGetCommandLineOutput:=Self.DoGetCommandLineOutput;
//
//    {$IFDEF MSWINDOWS}
//    FExecuteOllamaListCommand.FProgramFilePath:='';
//    FExecuteOllamaListCommand.FCommandLine:='ollama';
//    FExecuteOllamaListCommand.FParams:='list';
//    FExecuteOllamaListCommand.FWorkDir:='';
//    {$ENDIF}
//
//
//
//    {$IFDEF LINUX}
//    FExecuteOllamaListCommand.FProgramFilePath:='/usr/bin/python3';
//    FExecuteOllamaListCommand.FCommandLine:='python3';
//  //  FExecuteOllamaListCommand.FProgramFilePath:='/usr/bin/python';
//  //  FExecuteOllamaListCommand.FCommandLine:='python';
//    FExecuteOllamaListCommand.FParams:='python_convert_word/convert_word_main.py';
//    FExecuteOllamaListCommand.FWorkDir:='';
//    {$ENDIF}
//
//
//
//    //NAME          ID              SIZE      MODIFIED
//    //qwen2:7b      dd314f039b9d    4.4 GB    5 weeks ago
//    //qwen2:0.5b    6f48b936a09f    352 MB    5 weeks ago
//    //qwen:0.5b     b5dc5e784f2a    394 MB    5 weeks ago
//    //gemma:7b      a72c7f4d0a15    5.0 GB    5 months ago
//    //gemma:2b      b50d6c999e59    1.7 GB    5 months ago
//
//    //运行命令
//    //运行程序并读取数据
//    if FExecuteOllamaListCommand.Execute(True,ADesc) then
//    begin
//      for I := 1 to FExecuteOllamaListCommand.FCommandLineOutputHelper.FLogList.Count-1 do
//      begin
//        ALog:=FExecuteOllamaListCommand.FCommandLineOutputHelper.FLogList[I];
//        ALog:=ReplaceStr(ALog,'  ',',');
//        ALog:=ReplaceStr(ALog,',,',',');
//        ALog:=ReplaceStr(ALog,',,',',');
//        ALog:=ReplaceStr(ALog,',,',',');
//        ALog:=ReplaceStr(ALog,',,',',');
//        ALog:=ReplaceStr(ALog,',,',',');
//        ALog:=ReplaceStr(ALog,',,',',');
//        //取出来
//        ASplitStringList:=TStringList.Create;
//        ASplitStringList.Delimiter:=',';
//        ASplitStringList.StrictDelimiter:=True;
//        ASplitStringList.DelimitedText:=ALog;
//
//        //'{"name":"qwen2:7b","id":"dd314f039b9d","size":"4.4 GB","modified":"5 weeks ago"}'
//        ASuperObject:=SO();
//        ASuperObject.S['name']:=ReplaceStr(ASplitStringList[0],':latest','');
//        ASuperObject.S['id']:=ASplitStringList[1];
//        ASuperObject.S['size']:=ASplitStringList[2];
//        ASuperObject.S['modified']:=ASplitStringList[3];
//
//        FLocalInstalledModels.O[I-1]:=ASuperObject;
//
//        ASplitStringList.Free;
//
//
//      end;
//
//
//      //判断模型有没有安装
//      FIsInstalledOllama:=True;
//
//    end;
//
//
//
////    //等数据读取线程和进程执行完
////    FExecuteOllamaListCommand.WaitFor;
//
//  finally
//    FreeAndNil(FExecuteOllamaListCommand);
//  end;
//
//  Result:=True;
//end;

procedure TManager.LoadUserConfig;
var
  I: Integer;
begin
  inherited;

//  //最后一次登录的用户的部分信息
//  if FileExists(GetUserLocalDir+'LastLoginOperator.json') then
//  begin
//    OperatorJson:=TSuperObject.ParseFile(GetUserLocalDir+'LastLoginOperator.json');
//  end;
//
//  //最后一次登录的用户的部分信息
//  if FileExists(GetUserLocalDir+'LastLoginEmployee.json') then
//  begin
//    EmployeeJson:=TSuperObject.ParseFile(GetUserLocalDir+'LastLoginEmployee.json');
//  end;
//
//  //基础数据
//  //班组列表
//  if FileExists(GetUserLocalDir+'GroupArray.json') then
//  begin
//    GroupArray:=TSuperArray.Create(GetStringFromFile(GetUserLocalDir+'GroupArray.json',TEncoding.UTF8));
//  end;
//
//
//  //车间列表
//  if FileExists(GetUserLocalDir+'WorkShopArray.json') then
//  begin
//    WorkShopArray:=TSuperArray.Create(GetStringFromFile(GetUserLocalDir+'WorkShopArray.json',TEncoding.UTF8));
//  end;
//
//  //工序列表
//  if FileExists(GetUserLocalDir+'ProcessArray.json') then
//  begin
//    ProcessArray:=TSuperArray.Create(GetStringFromFile(GetUserLocalDir+'ProcessArray.json',TEncoding.UTF8));
//  end;
//
//  //成品入库备注
//  if FileExists(GetUserLocalDir+'NotesArray.json') then
//  begin
//    NotesArray:=TSuperArray.Create(GetStringFromFile(GetUserLocalDir+'NotesArray.json',TEncoding.UTF8));
//  end;
//
//  //门类型
//  if FileExists(GetUserLocalDir+'DoorTypeArray.json') then
//  begin
//    DoorTypeArray:=TSuperArray.Create(GetStringFromFile(GetUserLocalDir+'DoorTypeArray.json',TEncoding.UTF8));
//  end;
//
//  //车间延期类型
//  if FileExists(GetUserLocalDir+'WorkshopDelayTypeArray.json') then
//  begin
//    WorkshopDelayTypeArray:=TSuperArray.Create(GetStringFromFile(GetUserLocalDir+'WorkshopDelayTypeArray.json',TEncoding.UTF8));
//  end;
//
//  //部门列表
//  if FileExists(GetUserLocalDir+'DepartmentArray.json') then
//  begin
//    DepartmentArray:=TSuperArray.Create(GetStringFromFile(GetUserLocalDir+'DepartmentArray.json',TEncoding.UTF8));
//  end;
//
//
//  //加载当前工序
//  if FileExists(GetUserLocalDir+'CurrentProcess.txt') then
//  begin
//    FCurrentProcess:=GetStringFromFile(GetUserLocalDir+'CurrentProcess.txt',TEncoding.UTF8);
//  end;
//
//  //加载当前门类型
//  if FileExists(GetUserLocalDir+'CurrentDoorType.txt') then
//  begin
//    FCurrentDoorType:=GetStringFromFile(GetUserLocalDir+'CurrentDoorType.txt',TEncoding.UTF8);
//  end;
//
//
//  //加载用户界面设置
//  if FileExists(GetUserLocalDir+'UserUISettingJson.txt') then
//  begin
//    UserUISettingJson:=SO(GetStringFromFile(GetUserLocalDir+'UserUISettingJson.txt',TEncoding.UTF8));
//  end;

end;


constructor TManager.Create;
begin
  inherited;
//  UserUISettingJson:=SO();


  //给外网访问的IP地址,预览文件的时候需要
  FWebHost:='localhost';
  //Web服务的端口
  FWebPort:=Const_Node_Port;

//  FOneAPIUrl:='http://localhost:5434/api/';
  //vscode
  FJetAIUrl:='http://127.0.0.1:18789/#token=2303f6528e8789d41201c7070eadb1e775d21df5e6b21324';
//  FJetAIUrl:='http://127.0.0.1:3000/';


  //nginx
//  FJetAIUrl:='http://127.0.0.1:3003/';






end;

//function TManager.CurrentProcess: String;
//var
//  AProcessList:TStringList;
//begin
//  Result:=FCurrentProcess;
//
//  if Result='' then
//  begin
//      AProcessList:=TStringList.Create;
//      try
//        AProcessList.CommaText:=Self.EmployeeJson.S['岗位'];
//        if AProcessList.Count>0 then
//        begin
//          FCurrentProcess:=AProcessList[0];
//        end;
//      finally
//        FreeAndNil(AProcessList);
//      end;
//      Result:=FCurrentProcess;
//  end;
//end;

procedure TManager.SaveUserConfig;
begin
  inherited;
//  //基础数据
//  //班组列表
//  if GroupArray<>nil then
//  begin
//    SaveStringToFile(GroupArray.AsJSON,GetUserLocalDir+'GroupArray.json',TEncoding.UTF8);
//  end;
//
//  //车间列表
//  if WorkShopArray<>nil then
//  begin
//    SaveStringToFile(WorkShopArray.AsJSON,GetUserLocalDir+'WorkShopArray.json',TEncoding.UTF8);
//  end;
//
//  //工序列表
//  if ProcessArray<>nil then
//  begin
//    SaveStringToFile(ProcessArray.AsJSON,GetUserLocalDir+'ProcessArray.json',TEncoding.UTF8);
//  end;
//
//  //成品入库备注
//  if NotesArray<>nil then
//  begin
//    SaveStringToFile(NotesArray.AsJSON,GetUserLocalDir+'NotesArray.json',TEncoding.UTF8);
//  end;
//
//  //门类型
//  if DoorTypeArray<>nil then
//  begin
//    SaveStringToFile(DoorTypeArray.AsJSON,GetUserLocalDir+'DoorTypeArray.json',TEncoding.UTF8);
//  end;
//
//  //车间延期类型
//  if WorkshopDelayTypeArray<>nil then
//  begin
//    SaveStringToFile(WorkshopDelayTypeArray.AsJSON,GetUserLocalDir+'WorkshopDelayTypeArray.json',TEncoding.UTF8);
//  end;
//
//  //部门列表
//  if DepartmentArray<>nil then
//  begin
//    SaveStringToFile(DepartmentArray.AsJSON,GetUserLocalDir+'DepartmentArray.json',TEncoding.UTF8);
//  end;
//
//
//  //保存当前工序,多个工序才需要保存
//  if (FCurrentProcess<>'') and (Pos(',',GlobalManager.EmployeeJson.S['岗位'])>0) then
//  begin
//    SaveStringToFile(FCurrentProcess,GetUserLocalDir+'CurrentProcess.txt',TEncoding.UTF8);
//  end;
//
//  //保存当前门类型,多个门类型才需要保存
//  if (FCurrentDoorType<>'') and (Pos(',',GlobalManager.GetSysMemory('支持门类型'))>0) then
//  begin
//    SaveStringToFile(FCurrentDoorType,GetUserLocalDir+'CurrentDoorType.txt',TEncoding.UTF8);
//  end;
//
//  SaveStringToFile(UserUISettingJson.AsJSON,GetUserLocalDir+'UserUISettingJson.txt',TEncoding.UTF8);


end;




initialization
  AppID:=Const_APPID;
  APPUserType:=Const_APPUserType;
  APPUserTypeName:=Const_GetuiPush_AppType;


  GlobalManager:=TManager.Create;

  //默认的服务器(包括接口服务器和Web服务器)
  //之后是从配置文件中修改
  {$IFDEF IOS}
  GlobalManager.ServerHost:=Const_Server_Host_IOS;
//  GlobalManager.CenterServerHost:=Const_Server_Host_IOS;
  {$ELSE}
  GlobalManager.ServerHost:=Const_Server_Host_Other;
//  GlobalManager.CenterServerHost:=Const_Server_Host_Other;
  {$ENDIF}
  //端口
  GlobalManager.ServerPort:=Const_Server_Port;
//  GlobalManager.CenterServerPort:=Const_Server_Port;



finalization
  uFuncCommon.FreeAndNil(GlobalManager);



end.

