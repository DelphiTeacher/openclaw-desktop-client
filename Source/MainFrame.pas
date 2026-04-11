//convert pas to utf8 by ¥
unit MainFrame;

interface



uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uComponentType,
  uFuncCommon,
  uUIFunction,
  uDataSetToJson,

  Math,
  DateUtils,
//  uGPSLocation,
  uBaseLog,
  uDataInterface,
  uFMXSVGSupport,
//  uBaiduOCR,
//  uHttpBaiduOCR,
  uFrameContext,
  uManager,
  uTimerTask,
  HintFrame,
  uGetDeviceInfo,
  uOpenCommon,
  uOpenClientCommon,
  uBasePageStructure,
  uFileCommon,
//  ClientModuleUnit1,
  uRestInterfaceCall,
  WaitingFrame,
  MessageBoxFrame,
  ConfigFrame,
//  SettingFrame,
//  WorkBenchFrame,
//  ConsoleFrame,
//  ReportMenuFrame,
//  HomeFrame,

//  uFMXSVGSupport,
  uConst,
  HZSpell,
  uAppCommon,
//  uVirtualListDataController,

  FMX.Platform,

  XSuperObject,
  XSuperJson,
  uLocalOpenClawHelper,

  uBaseList,
  uSkinItems,
  uSkinListBoxType,
  uSkinListViewType,
  uServiceManage,

  AIChatFrame,
  OpenclawChatFrame,
  DatasetManageFrame,
  SkillFrame,
  ServiceManageFrame,
  Winapi.ShellApi,
  Winapi.WIndows,
  InstallDaemonFrame,

  System.RegularExpressions,
  System.RegularExpressionsCore,


  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, uSkinFireMonkeyButton, uSkinFireMonkeyLabel,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyVirtualList,
  uSkinFireMonkeyListBox, uSkinFireMonkeyControl,
  uSkinFireMonkeyItemDesignerPanel, uSkinFireMonkeyListView,
  uSkinFireMonkeyImage, uSkinFireMonkeyPanel, uSkinFireMonkeyMultiColorLabel,
  FMX.Edit, uSkinFireMonkeyEdit, uSkinFireMonkeyNotifyNumberIcon,
  uSkinFireMonkeyCheckBox, uSkinMaterial, uSkinButtonType,
  uSkinFireMonkeyCustomList, uSkinNotifyNumberIconType, uSkinCheckBoxType,
  uSkinMultiColorLabelType, uSkinImageType, uSkinLabelType,
  uSkinItemDesignerPanelType, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinPanelType, uSkinPageControlType,
  uSkinSwitchPageListPanelType, uSkinFireMonkeyPageControl,
  uSkinScrollBoxContentType, uSkinFireMonkeyScrollBoxContent,
  uSkinScrollBoxType, uSkinFireMonkeyScrollBox, FMX.ScrollBox, FMX.Memo,
  uSkinFireMonkeyMemo, uSkinImageListViewerType, uSkinFireMonkeyImageListViewer,
  uDrawPicture, uSkinImageList, uTimerTaskEvent, System.ImageList, FMX.ImgList,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.MediaLibrary.Actions, System.Actions,
  FMX.ActnList, FMX.StdActns, uDrawCanvas, FMX.MultiView, uSkinTreeViewType,
  uSkinFireMonkeyTreeView;

type
  TFrameMain = class(TFrame)
    tteGetBasicData: TTimerTaskEvent;
    pcMain: TSkinFMXPageControl;
    tsMy: TSkinFMXTabSheet;
    tsSkill: TSkinFMXTabSheet;
    tsHome: TSkinTabSheet;
    tsConfig: TSkinTabSheet;
    tmrCheckService: TTimer;
    lvMenu: TSkinFMXTreeView;
    SkinFMXPanel1: TSkinFMXPanel;
    SkinFMXPanel2: TSkinFMXPanel;
    edtKeyword: TSkinFMXEdit;
    lblLogo: TSkinFMXImage;
    SkinFMXImage1: TSkinFMXImage;
    tsAssistant: TSkinTabSheet;
    tsDataset: TSkinTabSheet;
    procedure pcMainChange(Sender: TObject);
    procedure tteGetBasicDataExecute(ATimerTask: TTimerTask);
    procedure tteGetBasicDataExecuteEnd(ATimerTask: TTimerTask);
    procedure tteGetBasicDataBegin(ATimerTask: TTimerTask);
    procedure tteSyncDataExecute(ATimerTask: TTimerTask);
    procedure ActionTakePhotoFromCameraDidFinishTaking(Image: TBitmap);
    procedure lvMenuClickItem(AItem: TSkinItem);
  private
    procedure DoReturnFrameFromInstallDaemonFrame(AFrame:TFrame);
    { Private declarations }
  public
    procedure DoOpenclawGatewayEvent(Sender:TObject;AMessageID:String;AMessageDataStr:String;AMessageData:Pointer);

    procedure ProcessGetNotice(ANotice:TNotice;ASuperObject:ISuperObject);

    procedure PorcessGetUserNoticeUnReadCount(ANoticeUnReadCount:Integer);

  public
    //获取并刷新未读消息数
    function SyncUnReadMsgCount:Integer;

  public
    procedure Login(AIsOnlineLogin:Boolean);
    procedure Logout;
  public
//    FrameHistroy:TFrameHistroy;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    //点击推送后触发的事件
    procedure ClickPushNotification(AUserCustomJson:ISuperObject;
                                      ATitle:String;
                                      ABody:String;
//                                      AOS:String;
                                      AIsAtBackground:Boolean);
  public
    FHomeFrame:TFrameAIChat;
    FOpenclawChatFrame:TFrameOpenclawChat;
    FConfigFrame:TFrameConfig;
    FSkillFrame:TFrameSkill;
    FDatasetManageFrame:TFrameDatasetManage;
  public

    //开始定位
    procedure DoStartLocation;
    //定位改变
    procedure DoLocationChange;
    //定位超时
    procedure DoLocationTimeout;
    //定位启动失败
    procedure DoLocationStartError;

    //地址改变
    procedure DoLocationAddrChange;
    //地址解析失败了
    procedure DoGeocodeAddrError;
    //地址解析超时了
    procedure DoGeocodeAddrTimeout;
    { Public declarations }
  end;



var
  GlobalMainFrame:TFrameMain;



implementation



uses
  MainForm;

{$R *.fmx}

procedure TFrameMain.ActionTakePhotoFromCameraDidFinishTaking(Image: TBitmap);
var
  AFilePath:String;
  ABitmapCodecSaveParams:TBitmapCodecSaveParams;
begin
  AFilePath:=GetApplicationPath+FormatDateTime('YYYY-MM-DD HH:MM:SS',Now)+'.png';
  ABitmapCodecSaveParams.Quality:=70;
  Image.SaveToFile(AFilePath);
end;

constructor TFrameMain.Create(AOwner: TComponent);
begin
  inherited;



  Self.pcMain.Prop.Orientation:=toNone;
  Self.pcMain.Prop.IsAfterPaintTabIcon:=True;
end;

destructor TFrameMain.Destroy;
begin

  GlobalManager.DisconnectGatewayServer;

  inherited;
end;

procedure TFrameMain.ClickPushNotification(AUserCustomJson:ISuperObject;
                                          ATitle:String;
                                          ABody:String;
//                                          AOS:String;
                                          AIsAtBackground:Boolean);
begin
  ShowMessage('您收到一条通知!'+#13#10
        +'ATitle:'+ABody+#13#10
        +'ABody:'+ABody+#13#10
        +'AUserCustomJson:'+AUserCustomJson.AsJSON+#13#10
        );
end;

procedure TFrameMain.DoGeocodeAddrError;
begin

end;

procedure TFrameMain.DoGeocodeAddrTimeout;
begin

end;

procedure TFrameMain.DoLocationAddrChange;
begin

end;

procedure TFrameMain.DoLocationChange;
begin
  OutputDebugString('OrangeUI TFrameMain.DoLocationChange Begin');

  OutputDebugString('OrangeUI TFrameMain.DoLocationChange End');

end;

procedure TFrameMain.DoLocationStartError;
begin

end;

procedure TFrameMain.DoLocationTimeout;
begin

end;

procedure TFrameMain.DoOpenclawGatewayEvent(Sender: TObject; AMessageID,
  AMessageDataStr: String; AMessageData: Pointer);
var
  APayloadJson:ISuperObject;
begin
  if AMessageID='health' then
  begin
    //更新智能体列表
    APayloadJson:=SO();
    //更新智能体列表

  end;
end;

procedure TFrameMain.DoReturnFrameFromInstallDaemonFrame(AFrame: TFrame);
begin
  Self.tteGetBasicData.Run();
end;

procedure TFrameMain.DoStartLocation;
begin

end;

procedure TFrameMain.Login(AIsOnlineLogin:Boolean);
begin


  Self.pcMain.Prop.Orientation:=toNone;
  Self.pcMain.Prop.ActivePage:=tsHome;
  pcMainChange(nil);


end;

procedure TFrameMain.Logout;
begin
  GlobalManager.FEventManager.UnRegisterChanges('OpenclawGateway',DoOpenclawGatewayEvent);
  GlobalManager.DisconnectGatewayServer;
end;

procedure TFrameMain.lvMenuClickItem(AItem: TSkinItem);
begin
  if AItem.Name='assistant' then
  begin
    Self.pcMain.Prop.ActivePage:=tsAssistant;
  end;
  if AItem.Name='skill' then
  begin
    Self.pcMain.Prop.ActivePage:=tsSkill;
  end;
  if AItem.Name='setting' then
  begin
    Self.pcMain.Prop.ActivePage:=tsConfig;
  end;
  if AItem.Name='chat' then
  begin
    Self.pcMain.Prop.ActivePage:=tsHome;
  end;
  if AItem.Name='dataset' then
  begin
    Self.pcMain.Prop.ActivePage:=tsDataset;
  end;
end;

procedure TFrameMain.pcMainChange(Sender: TObject);
begin

  //首页
  if Self.pcMain.Prop.ActivePage=tsHome then
  begin

    if FHomeFrame=nil then
    begin
      FHomeFrame:=TFrameAIChat.Create(Self);
      FHomeFrame.Parent:=Self.pcMain.Prop.ActivePage;
      FHomeFrame.Align:=TAlignLayout.Client;
      FHomeFrame.Load;
    end;
  end;

  //数字助手
  if Self.pcMain.Prop.ActivePage=tsAssistant then
  begin

    if FOpenclawChatFrame=nil then
    begin
      FOpenclawChatFrame:=TFrameOpenclawChat.Create(Self);
      FOpenclawChatFrame.Parent:=Self.pcMain.Prop.ActivePage;
      FOpenclawChatFrame.Align:=TAlignLayout.Client;
      FOpenclawChatFrame.Load;
    end;
  end;



  if Self.pcMain.Prop.ActivePage=tsConfig then
  begin
    if FConfigFrame=nil then
    begin
      FConfigFrame:=TFrameConfig.Create(Self);
      FConfigFrame.Parent:=Self.pcMain.Prop.ActivePage;
      FConfigFrame.Align:=TAlignLayout.Client;
      FConfigFrame.Load;
    end;

  end;

  if Self.pcMain.Prop.ActivePage=tsSkill then
  begin
    if FSkillFrame=nil then
    begin
      FSkillFrame:=TFrameSkill.Create(Self);
      FSkillFrame.Parent:=Self.pcMain.Prop.ActivePage;
      FSkillFrame.Align:=TAlignLayout.Client;
      FSkillFrame.Load;
    end;

  end;

  //知识库管理
  if Self.pcMain.Prop.ActivePage=tsDataset then
  begin
    if FDatasetManageFrame=nil then
    begin
      FDatasetManageFrame:=TFrameDatasetManage.Create(Self);
      FDatasetManageFrame.Parent:=Self.pcMain.Prop.ActivePage;
      FDatasetManageFrame.Align:=TAlignLayout.Client;
      FDatasetManageFrame.Load;
    end;

  end;


end;

procedure TFrameMain.PorcessGetUserNoticeUnReadCount(ANoticeUnReadCount: Integer);
begin
  //

end;

procedure TFrameMain.ProcessGetNotice(ANotice: TNotice;
  ASuperObject: ISuperObject);
begin

end;

function TFrameMain.SyncUnReadMsgCount: Integer;
begin

end;

procedure TFrameMain.tteGetBasicDataBegin(ATimerTask: TTimerTask);
begin
  ShowWaitingFrame('服务检测中...');
end;

procedure TFrameMain.tteGetBasicDataExecute(ATimerTask: TTimerTask);
var
  ADesc:String;
begin
  try
      //出错
      TTimerTask(ATimerTask).TaskTag:=1;


      //首次安装,全部都安装，检测都不需要检测
      ADesc:='';

      if not GlobalOpenClawHelper.IsOpenClawConfigured then
      begin
        TTimerTask(ATimerTask).TaskDesc:=ADesc;
        Exit;
      end;


      //判断服务是否启动
      if GlobalServiceManager.IsServerRunning(ADesc) then
      begin
        TTimerTask(ATimerTask).TaskTag:=0;
        TTimerTask(ATimerTask).TaskDesc:=ADesc;
      end
      else
      begin

        if not GlobalServiceManager.StartServer(ADesc) then
        begin
          TTimerTask(ATimerTask).TaskDesc:=ADesc;
          Exit;
        end;



        //等待服务启动，等收到指定输出就表示服务启动成功了
        //09:49:25 [gateway] [plugins] plugins.allow is empty; discovered non-bundled plugins may auto-load: feishu (D:\Program Files\nodejs\node_global\node_modules\openclaw\extensions\feishu\index.ts). Set plugins.allow to explicit trusted ids.
        //09:49:38 [gateway] [plugins] duplicate plugin id detected; bundled plugin will be overridden by config plugin (D:\OpenClawCode\openclaw\extensions\feishu\index.ts) (plugin=feishu, source=D:\OpenClawCode\openclaw\extensions\feishu\index.ts)
        //09:49:38 [canvas] host mounted at http://127.0.0.1:18789/__openclaw__/canvas/ (root C:\Users\Administrator\.openclaw\canvas)
        //09:49:39 [heartbeat] started
        //09:49:39 [health-monitor] started (interval: 300s, startup-grace: 60s, channel-connect-grace: 120s)
        //09:49:39 [gateway] agent model: custom-api-moleapi-com/gpt-5.4
        //09:49:39 [gateway] listening on ws://127.0.0.1:18789, ws://[::1]:18789 (PID 2392)
        //09:49:39 [gateway] log file: C:\Users\ADMINI~1\AppData\Local\Temp\openclaw\openclaw-2026-03-22.log
        //09:49:39 [browser/server] Browser control listening on http://127.0.0.1:18791/ (auth=token)



        //判断服务有没有启动，有没有配置成功
        if not GlobalServiceManager.WaitServerStarted(2*60,ADesc) then
        begin
          TTimerTask(ATimerTask).TaskDesc:=ADesc;
          Exit;
        end;
      end;


      //在其他节点上使用的话，需要连接网关服务来进行一些通信,或者检测服务是否启动可用，获取配置、设置配置这些操作
      if not GlobalManager.ConnectGatewayServer then
      begin
        TTimerTask(ATimerTask).TaskDesc:=ADesc;
        Exit;
      end;


     TTimerTask(ATimerTask).TaskTag:=0;
  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;

end;

procedure TFrameMain.tteGetBasicDataExecuteEnd(ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin

        GlobalManager.SaveUserConfig;

        Self.pcMain.Prop.ActivePage:=tsHome;
        pcMainChange(nil);
        //显示网页
        Self.FOpenclawChatFrame.Load;

        //ShowHintFrame(Self,'获取基础数据成功!');

//      end
//      else
//      begin
//        //获取基础数据失败
////        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin

        if not GlobalOpenClawHelper.IsOpenClawConfigured then
        begin
          //刚安装好没有配置过,跳转到配置向导
          HideFrame;
          ShowFrame(TFrame(GlobalInstallDaemonFrame),TFrameInstallDaemon,DoReturnFrameFromInstallDaemonFrame);
          GlobalInstallDaemonFrame.Load();
          Exit;
        end;


        //网络异常
        ShowMessageBoxFrame(Self,'服务检测失败!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
        Self.pcMain.Prop.ActivePage:=tsConfig;


    end;
  finally
    HideWaitingFrame;
  end;
end;

procedure TFrameMain.tteSyncDataExecute(ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
begin
  try
      //出错
      TTimerTask(ATimerTask).TaskTag:=1;




//      //获取首页统计
//      TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI(
//            'get_home_stat',
//            nil,
//            CarglCenterInterfaceUrl,
//            ['appid','user_fid','key','operator'],
//            [AppID,
//            GlobalManager.User.fid,
//            '',
//            GlobalManager.OperatorJson.S['操作员']
//            ],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//            );
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if (ASuperObject.I['Code']=200) then
//      begin
//            TThread.Synchronize(nil,procedure
//            begin
//              Self.lbHome.Prop.Items.FindItemByCaption('待结算').Detail:=IntToStr(ASuperObject.O['Data'].I['待结算']);
//              Self.lbHome.Prop.Items.FindItemByCaption('今日接车').Detail:=IntToStr(ASuperObject.O['Data'].I['今日接车']);
//              Self.lbHome.Prop.Items.FindItemByCaption('今日结算').Detail:=IntToStr(ASuperObject.O['Data'].I['今日结算']);
//              Self.lbHome.Prop.Items.FindItemByCaption('今日营收').Detail:=Format('%.2f',[ASuperObject.O['Data'].F['今日营收']]);
//            end);
//      end;



//      TThread.Synchronize(nil,procedure
//      begin
//        Self.tmrSyncData.Enabled:=True;
//      end);


     TTimerTask(ATimerTask).TaskTag:=0;
  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;

end;

end.

