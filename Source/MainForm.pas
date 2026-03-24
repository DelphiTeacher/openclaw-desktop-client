//convert pas to utf8 by ¥

unit MainForm;

interface

//HAS_CCBARCODESCANNER
//HAS_X5WEBBROWSER
//HAS_WXPAY
//HAS_ALIPAY
//HAS_APPLESIGNIN
//NO_GPSLOCATION/HAS_GPSLOCATION
//HAS_XIAOMIPUSH
//HAS_HUAWEIPUSH
//HAS_X5WEBBROWSER
//HAS_IOSAPNSPush
//HAS_ORANGESCANCODE
//HAS_PUSHNOTIFICATION
//USE_NATIVE_SELECTMEDIA
{$I OpenPlatformClient.inc}




uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.Messaging,


  IniFiles,
  uBaseLog,
  uFuncCommon,
  uFileCommon,
  uComponentType,
  uFrameContext,
  FMX.WebBrowser,

  CommonImageDataMoudle,

  uOpenClientCommon,
  uOpenUISetting,
  uOpenCommon,
  uConst,
  uDatasetToJson,

  FMX.Graphics,
  FMX.StatusBar,
  FMX.Utils,
  uLang,



  {$IFDEF HAS_AUTOUPDATE}
  uVersionChecker,
//  UpdateFrame,
  {$ENDIF}

  {$IFDEF HAS_X5WEBBROWSER}
  uTBSSDK,
  {$ENDIF}





  //百度OCR
  {$IFDEF HAS_CCBAIDU_OCR}
  CC.BaiduOCR,
  {$ELSE}
  {$ENDIF}
  uHttpBaiduOCR,

  {$IFDEF HAS_CCBARCODESCANNER}
  CC.BarcodeScanner,
  {$ELSE}
  {$ENDIF}

  {$IFDEF HAS_ORANGESCANCODE}
  uOrangeScanCodeForm,
  {$ENDIF}


//  uOpenUISetting,

//  {$IFDEF IOS}
//  iOSApi.CTCellularData,
//  {$ENDIF IOS}



  {$IFDEF HAS_WXPAY}
  //微信支付
  uWeiChat,
  {$ENDIF HAS_WXPAY}

//  {$IFDEF HAS_FACEBOOK}
//  FBLoginCommon,
//  {$ENDIF}



  {$IFDEF HAS_ALIPAY}
  //支付宝支付
  uAlipayMobilePay,
  uPayAPIParam,
  {$ENDIF HAS_ALIPAY}


  {$IFDEF IOS}
    {$IFDEF HAS_APPLESIGNIN}
    uAppleSignIn,
    {$ENDIF HAS_APPLESIGNIN}
    {$IFDEF HAS_GETUIPUSH}
    uGetuiPush,
    {$ENDIF}
  {$ENDIF IOS}


  {$IFDEF HAS_GPSLOCATION}
    {$IFDEF ANDROID}
//    Androidapi.Helpers,
    //用于跳转到权限页面,需要添加jar
    Androidapi.JNI.PermissionPageManagement,
    {$ENDIF}
  {$ENDIF}
  //定位
  uGPSUtils,
  uGPSLocation,



  //推送
  {$IFDEF HAS_PUSHNOTIFICATION}
    uBasePush,
    uPushClientLogic,
    uPushClientRestImpl,
  //  {$IFDEF IOS}
  //    {$IFDEF HAS_IOSAPNSPush}
  //    uIOSAPNSPush,
  //    {$ENDIF}
  //  {$ENDIF}



    {$IFDEF ANDROID}
      {$IFDEF HAS_GETUIPUSH}
      uGetuiPush,
      {$ENDIF}
      {$IFDEF HAS_XIAOMIPUSH}
      uXiaomiPush,
      {$ENDIF}
      {$IFDEF HAS_HUAWEIPUSH}
      uHuaweiPush,
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}




//  uThirdPartyAccountAuth,


  uUIFunction,
  uManager,
  uMobileUtils,

  uGraphicCommon,
  uBaseHttpControl,
  uDrawPicture,

  XSuperObject,
  XSuperJson,
  MessageBoxFrame,
  WaitingFrame,
  HintFrame,
  uSkinPanelType,


  uTimerTask,
  uRestInterfaceCall,
  FMX.DeviceInfo,
//  uGetDeviceInfo,


  {$IFDEF HAS_PAGESTRUCTURE}
  uPageStructure,
  uBasePageStructure,
  uPageFramework,
  {$ENDIF}




  EasyServiceCommonMaterialDataMoudle,


  FMX.Platform,

  {$IFDEF ANDROID}
  Androidapi.JNI.Net,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.Helpers,
  Androidapi.JNI.App,
  FMX.Helpers.Android,
  Androidapi.JNI.Os,
    {$IF RTLVersion>=33}// 10.3+
    System.Permissions, // 动态权限单元
    {$ENDIF}
    uAndroidPermission_D10_2,
  {$ENDIF}


  {$IFDEF IOS}
  FMX.Platform.iOS,
  {$ENDIF IOS}

//  {$IFDEF IOS}
//  iOSQRCodeScanForm,
//  {$ENDIF IOS}



  FMX.Forms,
  FMX.Dialogs,
  uSkinImageListViewerType,
  FMX.Media, FMX.Types, uSkinButtonType, uSkinFireMonkeyButton,
  FMX.Controls, uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, FMX.Gestures, FMX.ScrollBox, FMX.Memo,
  uSkinFireMonkeyMemo, FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit,
  System.Notification, System.Sensors, System.Sensors.Components, FMX.StdCtrls,
  uTimerTaskEvent, uSkinLabelType, uSkinFireMonkeyLabel, System.Actions,
  FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions, FMX.MediaLibrary;//uSDKVersion;




type
  TScanCodeResultEvent=procedure(Sender:TObject;AScanCode:String) of object;

  {$IFDEF HAS_CCBAIDU_OCR}
  TBaiduOCR_OnResultEvent = procedure(Sender: TObject; AOCRType: TCCBaiduOCRType; AErrorCode: Integer; AErrorMsg: String; AFilePath: String; AJosonResult: String; AIDCardInfo: TCCIDCardInfo; ABankCardInfo: TCCBankCardInfo) of object;
  {$ELSE}
  {$ENDIF}


  TfrmMain = class(TForm)
    tmrTestGPSLocation: TTimer;
    tmrStartLocation: TTimer;
    tmrSaveTranslate: TTimer;
    MediaPlayerMain: TMediaPlayer;
    tteGetApp: TTimerTaskEvent;
    tmrAutoLogin: TTimer;
    NotificationCenter1: TNotificationCenter;
    tmrSyncBadge: TTimer;
    tmrSetStatusBarLight: TTimer;
    lblGPSLocation: TSkinFMXLabel;
    Panel1: TPanel;
    lblDistance: TLabel;
    Label3: TLabel;
    tbDistance: TTrackBar;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure tmrTestGPSLocationTimer(Sender: TObject);
    procedure tmrStartLocationTimer(Sender: TObject);
    procedure tmrSaveTranslateTimer(Sender: TObject);
    procedure tteGetAppExecute(ATimerTask: TTimerTask);
    procedure tteGetAppExecuteEnd(ATimerTask: TTimerTask);virtual;
    procedure tmrAutoLoginTimer(Sender: TObject);
    procedure tmrSyncBadgeTimer(Sender: TObject);
    procedure tmrSetStatusBarLightTimer(Sender: TObject);
    procedure FormTouch(Sender: TObject; const Touches: TTouches;
      const Action: TTouchAction);
    procedure tbDistanceChange(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    { Private declarations }
  private
    //翻译文件的路径
    FTranslateFilePath:String;
  private
    //要动态创建,不然在有些Win7电脑上会报错
    //手势管理控件
    FGestureManager:TGestureManager;
  public
    //延迟显示的所点击的推送(等登录之后再加载)
    FDelayViewClickPushUserCustomJson:ISuperObject;

    //获取未读消息数,更新桌面图标未读数
    function GetApplicationIconBadgeNumber:Integer;virtual;


    //IOS下点击推送
    procedure DoBasePushIOSRecvAPNSNotification(Sender:TObject;ANotification:String;AIsAtBackground:Boolean;AIsStartup:Boolean);virtual;
//    //Android下点击推送
//    procedure DoBasePushAndroidReceivePayloadMsg(Sender:TObject;APayloadMsg:String;AIsAtBackground:Boolean);virtual;
    //    //统一点击推送消息事件
    //    TClickNotificationMsgEvent=procedure(Sender:TObject;
    //                                      //标题
    //                                      ATitle:String;
    //                                      //内容
    //                                      AContent:String;
    //                                      //推送内容,Json格式,自己解析?
    //                                      APayload: String;
    //                                      //是否在后台
    //                                      AIsAtBackground:Boolean;
    //                                      //是否在启动的时候
    //                                      AIsStartup:Boolean) of object;
    //点击推送后触发的事件
    procedure ClickPushNotification(Sender:TObject;ATitle:String;ABody:String;APayload:String;AIsAtBackground:Boolean;AIsStartup:Boolean);virtual;
  protected
    //GlobalManager加载之后,加载了上次的用户信息
    procedure CustomLoadedGlobalManager;virtual;

    //自动登陆
    //自定义登陆接口调用
    procedure DoCustomAutoLoginExecute(ATimerTask:TObject);virtual;
    procedure DoAutoLoginExecute(ATimerTask:TObject);virtual;
    procedure DoAutoLoginExecuteEnd(ATimerTask:TObject);virtual;

    //自动登陆-密码错误返回
    procedure OnModalResultFromLoginErrorInAutoLogin(Frame: TObject);
    //自动登陆-网络连接失败返回
    procedure OnModalResultFromNetConnectionFailInAutoLogin(Frame: TObject);

    //服务端更新
    procedure DoModalResultFromUseNewServerMessageBoxFrame(AMessageBoxFrame:TObject);
  private
    //获取未读通知数
    procedure DoGetUserNoticeUnReadCountExecute(ATimerTask:TObject);
    procedure DoGetUserNoticeUnReadCountExecuteEnd(ATimerTask:TObject);
//    //获取通知详情
//    procedure DoGetNoticeExecute(ATimerTask:Tobject);
//    procedure DoGetNoticeExecuteEnd(ATimerTask:TObject);
  public
    procedure StartGPSLocation;
    procedure DoModalResultFromRequestLocationPermissionMessageBox(AMessageBoxFrame:TObject);
    procedure DoModalResultFromOpenGPSMessageBox(AMessageBoxFrame:TObject);
    {$IFDEF HAS_GPSLOCATION}
    //定位事件,可能在线程中调用的,也可能在后台被调用,因此要小心处理
    procedure DoGPSLocation_LocationChange(Sender: TObject);
    procedure DoGPSLocation_LocationTimeout(Sender: TObject);
    procedure DoGPSLocation_StartError(Sender: TObject);

    procedure DoGPSLocation_AddrChange(Sender: TObject);
    procedure DoGPSLocation_GeocodeAddrError(Sender: TObject);
    procedure DoGPSLocation_GeocodeAddrTimeout(Sender: TObject);

    {$ENDIF}
  private
    {$IFDEF HAS_X5WEBBROWSER}
    FTBSSDK:TTBSSDK;
    {$ENDIF}

  protected
    //二维码扫描
    {$IFDEF HAS_CCBARCODESCANNER}
    ccbsBarCode:TCCBarcodeScanner;
    {$ENDIF}

    {$IFDEF HAS_ORANGESCANCODE}
    FOrangeScanCodeForm:TOrangeScanCodeForm;
    //设置二维码扫描的类型
    procedure CustomSettingOrangeScanCodeForm(AOrangeScanCodeForm:TOrangeScanCodeForm);virtual;
    {$ENDIF}

    procedure ccbsBarCodeScanComletedCallbackEvent(Sender: TObject;
      const ResultCode: Integer; const ResultString: string);
    procedure frmOrangeQRCodeScanResult(Sender: TObject; AResult,
      AFormat: string);
    procedure frmOrangeQRCodeScanFormResult(Sender: TObject; AResult,
      AFormat: string;var AIsCanContinue:Boolean);
  protected
    {$IFDEF HAS_PAGESTRUCTURE}
    //开放平台的数据源
    FPageFrameworkDataSource:TPageFrameworkDataSource;
    //开放平台中,给控件设置图片
    function DoPageFrameworkDataSourceGetDrawPicture(AImageName:String;var AIsGeted:Boolean):TDrawPicture;virtual;
    //将页面框架中的变量转换为对应的值
    function DoPageFrameworkDataSourceGetParamValue(AValueFrom:String;AParamName:String;var AIsGeted:Boolean):Variant;virtual;
    procedure DoPageFrameworkDataSourceSetParamValue(AValueFrom:String;AParamName:String;AValue:Variant;var AIsSeted:Boolean);virtual;
    //处理自定义的动作
    procedure DoMainProgramSettingCustomProcessPageAction(Sender:TObject;
                                                        APageInstance:TPageInstance;
                                                        AAction:String;
                                                        AFieldControlSettingMap:TFieldControlSettingMap;
                                                        var AIsProcessed:Boolean);virtual;
    {$ENDIF}

  public
    {$IFDEF HAS_PUSHNOTIFICATION}
    //推送实现
    FPushClientRestImpl:TPushClientRestImpl;
    {$ENDIF}

    //手动登陆成功
    //调用登录接口成功
    procedure DoCallLoginAPISucc(
                                  //是否是自动登陆成功的
                                  AIsAutoLogin:Boolean;
                                  //是否需要显示主界面
                                  AIsNeedShowMainFrame:Boolean=True
                                  );virtual;
    procedure DoShowMainFrame;virtual;
    //登录成功,显示主页面
    procedure LoginShowMainFrame(AIsAutoLogin:Boolean);

    //退出登录
    procedure Logout;virtual;

    //IM登录成功
    procedure IMLoginSucc;virtual;
  public
    //扫描二维码
    FScanCodeResult:TScanCodeResultEvent;
    procedure ScanQRCode(AScanCodeResult:TScanCodeResultEvent=nil);
    function GetScanTitle:String;virtual;
    function GetScanTips:String;virtual;
  public
    FHttpBaiduOCR:THttpBaiduOCR;
    {$IFDEF HAS_CCBAIDU_OCR}
    //百度OCR
    CCBaiduOCR1:TCCBaiduOCR;
    FBaiduOCR_OnResultEvent:TBaiduOCR_OnResultEvent;
    procedure DoRequestPermissions(AResult: TProc<boolean>);
    procedure CCBaiduOCR1RecognizeResult(Sender: TObject; AOCRType: TCCBaiduOCRType; AErrorCode: Integer; AErrorMsg, AFilePath, AJosonResult: string; AIDCardInfo: TCCIDCardInfo; ABankCardInfo: TCCBankCardInfo);
    procedure CCBaiduOCR1InitAccessTokenWithAkSkResult(Sender: TObject; AErrorCode: Integer; AErrorMsg, AToken: string);
    procedure StartBaiduOCR(ABaiduOCR_OnResultEvent:TBaiduOCR_OnResultEvent=nil);
    {$ENDIF}
  public
    procedure MyInfoChange;virtual;
    //获取未读通知数
    procedure GetUserNoticeUnReadCount;
  protected
    FApplicationEventService:IFMXApplicationEventService;
    function DoApplicationEventHandler(AAppEvent: TApplicationEvent; AContext: TObject):Boolean;virtual;
  protected
//    //IOS下判断网络是否授权访问
    function DoTimerThreadCanExecute(Sender: TObject): Boolean;
//    function DoTimerThreadCanExecute(Sender:TObject):Boolean;
//    {$IFDEF IOS}
//  	procedure DoCellularDataRestrictionDidUpdateNotifierEvent(state:CTCellularDataRestrictedState);
//    {$ENDIF IOS}
    { Public declarations }
  public
    FmyIniFile: TIniFile;

    //更新服务器设置
    procedure SyncServerSetting(AServer:String;APort:Integer);virtual;

    //加载主题配置
    function CustomLoadFromINI: Boolean;
  end;




var
  frmMain: TfrmMain;


//  //IOS任务栏字体的颜色,默认为白色
//  GlobalIOSStatusBarFontColor:TAlphaColor;
//
//
//  //Android是否透明任务栏,默认为True,那么pnlToolbar需要拉高25个像素
//  GlobalIsAndroidTransparentToolbar:Boolean;
//


//AIsLoginedThenReturn:
//True,登录成功之后是否返回原来的页面
//为False,那么默认就显示主页面MainFrame
procedure ShowLoginFrame(AIsLoginedThenReturn:Boolean=False);


function GetCurrentFrameToolBarColor:TAlphaColor;


implementation


uses


  WebbrowserControlUtils,
  WebBrowserFrame,

//  NoticeListFrame,
  ClipHeadFrame,

  LoginFrame,

  {$IFDEF HAS_GUIDEFRAME}
  GuideFrame,
  {$ENDIF}

  BindPhoneNumberFrame,
//  RegisterProtocolFrame,



  MainFrame;


{$R *.fmx}

procedure DoWebBrowserRealign;
//{$IFDEF FMX}
var
  BrowserManager : IFMXWBService;
//{$ENDIF}
begin
//{$IFDEF FMX}
  if TPlatformServices.Current.SupportsPlatformService(IFMXWBService, BrowserManager) then
    BrowserManager.RealignBrowsers;
//{$ENDIF}
end;

procedure ShowLoginFrame(AIsLoginedThenReturn:Boolean);
begin
  HideFrame;
  ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin);
  GlobalLoginFrame.Clear;
  GlobalLoginFrame.IsLoginedThenReturn:=AIsLoginedThenReturn;
end;


function GetCurrentFrameToolBarColor:TAlphaColor;
var
  pnlToolbar:TComponent;
  ASubCurrentFrame:TFrame;
  AFramePaintSettingIntf:IFramePaintSetting;
begin
  Result:=uGraphicCommon.SkinNavigationBarColor;

  if CurrentFrame=nil then
  begin
    Exit;
  end;



  //找到pnlToolBar组件,使用它的背景色
  pnlToolbar:=CurrentFrame.FindComponent('pnlToolbar');
  if (pnlToolbar<>nil)
    and (pnlToolbar is TSkinPanel)
    and (TSkinPanel(pnlToolbar).CurrentUseMaterial<>nil)
    and (not TSkinPanel(pnlToolbar).CurrentUseMaterial.IsTransparent)
    and (TSkinPanel(pnlToolbar).CurrentUseMaterial.BackColor.IsFill) then
  begin
    Result:=TSkinPanel(pnlToolbar).CurrentUseMaterial.BackColor.FillColor.Color;
    Exit;
  end;




  //是MainFrame
  ASubCurrentFrame:=nil;
  if (CurrentFrame.ClassName='TFrameMain') and (TFrameMain(CurrentFrame).pcMain.Prop.ActivePage<>nil) then
  begin
    if (TFrameMain(CurrentFrame).pcMain.Prop.ActivePage.ControlsCount>0) and (TFrameMain(CurrentFrame).pcMain.Prop.ActivePage.Controls[0] is TFrame) then
    begin
      ASubCurrentFrame:=TFrame(TFrameMain(CurrentFrame).pcMain.Prop.ActivePage.Controls[0]);
    end
    else
    if (TFrameMain(CurrentFrame).pcMain.Prop.ActivePage.ControlsCount>1) and (TFrameMain(CurrentFrame).pcMain.Prop.ActivePage.Controls[1] is TFrame) then
    begin
      ASubCurrentFrame:=TFrame(TFrameMain(CurrentFrame).pcMain.Prop.ActivePage.Controls[1]);
    end;
  end;
  if ASubCurrentFrame=nil then
  begin
    Exit;
  end;


  pnlToolbar:=ASubCurrentFrame.FindComponent('pnlToolbar');
  if (pnlToolbar<>nil)
    and (pnlToolbar is TSkinPanel)
    and (not TSkinPanel(pnlToolbar).CurrentUseMaterial.IsTransparent)
    and (TSkinPanel(pnlToolbar).CurrentUseMaterial.BackColor.IsFill) then
  begin
    Result:=TSkinPanel(pnlToolbar).CurrentUseMaterial.BackColor.FillColor.Color;
    Exit;
  end;


  if ASubCurrentFrame.GetInterface(IID_IFramePaintSetting,AFramePaintSettingIntf) then
  begin
    Result:=AFramePaintSettingIntf.GetFillColor;
    Exit;
  end;


end;



{ TfrmMain }


procedure TfrmMain.StartGPSLocation;
begin
  GlobalGPSLocation.CheckPermission(
    //授权成功后的方法
    procedure
    begin
      //判断GPS有没有打开,打开就开始定位，没有打开就提醒
      if GlobalGPSLocation.IsGPSOpened then
      begin
        GlobalGPSLocation.StartLocation;
        {$IFDEF MSWINDOWS}
          //在Windows下面测试定位

          //测试定位,在Windows上面模拟定位的事件
          {$IFDEF USE_GOOGLE_ROUTE_PLAN}
          //在国外,新西兰
          GlobalGPSLocation.Longitude:=175.621713;
          GlobalGPSLocation.Latitude:=-40.363828;
          {$ELSE}
          //在国内,龙腾创业大厦
          GlobalGPSLocation.Longitude:=119.649502;
          GlobalGPSLocation.Latitude:=29.076664;

          if AppID='1004' then
          begin
            //亿诚生活测试地址,绍兴市柯桥区润达锦秀河山
            GlobalGPSLocation.Longitude:=120.496104;
            GlobalGPSLocation.Latitude:=30.103408;
          end;

//          if AppID='1005' then
//          begin
//            //宠圈测试地址,绍兴市柯桥区润达锦秀河山
//            GlobalGPSLocation.Longitude:=120.496104;
//            GlobalGPSLocation.Latitude:=30.103408;
//          end;

          if AppID='1032' then
          begin
            //急救达人测试地址,南国名城
            GlobalGPSLocation.Longitude:=119.65494956888;
            GlobalGPSLocation.Latitude:=29.0646902732421;
          end;

        //  //浙江省绍兴市诸暨市柯桥区华舍街道兴华社区居民委员会
        //  GlobalGPSLocation.Longitude:=120.492359;
        //  GlobalGPSLocation.Latitude:=30.115129;
          {$ENDIF}

          tmrTestGPSLocation.Enabled:=True;
        {$ENDIF}
      end
      else
      begin
        //提示用户打开GPS
        ShowMessageBoxFrame(nil,'APP需要使用定位，请开启！','',TMsgDlgType.mtInformation,['取消','已开启'],DoModalResultFromOpenGPSMessageBox);
      end;
    end,
    //授权失败后的方法
    procedure
    begin
      //定位权限没有申请成功
      ShowMessageBoxFrame(nil,'APP需要使用定位权限，请允许！','',TMsgDlgType.mtInformation,['取消','去开启'],DoModalResultFromRequestLocationPermissionMessageBox);
    end
  );
end;

procedure TfrmMain.DoAutoLoginExecute(ATimerTask: TObject);
var
  ATempTimerTask:TTimerTask;
begin
//  TThread.Synchronize(nil,procedure
//  begin
//    ShowWaitingFrame(frmMain,'自动登陆中...');
//  end);




  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  ATempTimerTask:=TTimerTask.Create();
  try



      TTimerTask(ATempTimerTask).TaskOtherInfo.Values['User']:=GlobalManager.LastLoginUser;
      TTimerTask(ATempTimerTask).TaskOtherInfo.Values['Password']:=GlobalManager.LastLoginPass;


      DoCustomAutoLoginExecute(ATempTimerTask);

      if ATempTimerTask.TaskTag<>TASK_SUCC then
      begin
        //调用没有成功
        TTimerTask(ATimerTask).TaskDesc:=TTimerTask(ATempTimerTask).TaskDesc;
        if TTimerTask(ATimerTask).TaskDesc<>'' then
        begin
          TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
        end;
        Exit;
      end;



      //自动登陆
      TTimerTask(ATimerTask).TaskDesc:=
          SimpleCallAPI('auto_login',
                        nil,
                        UserCenterInterfaceUrl,
                        ['appid',
                        'user_fid',
                        'user_type',
//                        'login_type',
//                        'username',
                        'login_key',
                        'version',
                        'phone_imei',
                        'phone_uuid',
                        'phone_type',
                        'os',
                        'os_version'],
                        [AppID,
                        GlobalManager.User.fid,
                        APPUserType,
//                        '',
//                        GlobalManager.LastLoginUser,
                        GlobalManager.LastLoginKey,
                        '',
                        '',//GetIMEI,
                        '',//GetUUID,
                        '',//GetPhoneType,
                        '',//GetOS,
                        ''//GetOSVersion
                        ],
                        GlobalRestAPISignType,
                        GlobalRestAPIAppSecret
                        );


    if TTimerTask(ATimerTask).TaskDesc<>'' then
    begin
      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
    end;


  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;
  FreeAndNil(ATempTimerTask);

end;

procedure TfrmMain.DoAutoLoginExecuteEnd(ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
begin
  uBaseLog.HandleException(nil,'TfrmMain.DoAutoLoginExecuteEnd Begin');
  try
      if TTimerTask(ATimerTask).TaskTag=0 then
      begin
        ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
        if ASuperObject.I['Code']=200 then
        begin
            uBaseLog.HandleException(nil,'TfrmMain.DoAutoLoginExecuteEnd Succ');

            GlobalManager.User.ParseFromJson(ASuperObject.O['Data'].A['User'].O[0]);

            //登录令牌,用于确认用户已经登录
            GlobalManager.User.key:=ASuperObject.O['Data'].S['Key'];
            GlobalManager.User.server_version:=ASuperObject.O['Data'].S['server_version'];


            //调用登录接口成功事件
            //显示主界面
            DoCallLoginAPISucc(True,True);




        end
        else
        begin
            uBaseLog.HandleException(nil,'TfrmMain.DoAutoLoginExecuteEnd Fail');


            //自动登录失败
            //退出重新登录
            //Self.Logout;

            //登录失败
            ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],OnModalResultFromLoginErrorInAutoLogin);


            //可以保持离线
            //ShowMessageBoxFrame(Self,ASuperObject.S['Desc']);
        end;

      end
      else if TTimerTask(ATimerTask).TaskTag=1 then
      begin
          //网络异常
//        ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],OnModalResultFromNetConnectionFailInAutoLogin);



            //可以保持离线
            //ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!');//,TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],OnModalResultFromNetConnectionFailInAutoLogin);

            //不可以保持离线
            //ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!','',TMsgDlgType.mtInformation,['确定'],OnModalResultFromLoginErrorInAutoLogin);


      end;
  finally
    //需要
//    HideWaitingFrame;
  end;

  uBaseLog.HandleException(nil,'TfrmMain.DoAutoLoginExecuteEnd End');
end;

procedure TfrmMain.DoCallLoginAPISucc(AIsAutoLogin:Boolean;AIsNeedShowMainFrame:Boolean=True);
begin

  //登录状态
  uManager.GlobalManager.IsLogin:=True;


  uBaseLog.HandleException(nil,'TfrmMain.DoCallLoginAPISucc 1');


  //保存上次登陆的用户名密码
  uManager.GlobalManager.Save;

  uBaseLog.HandleException(nil,'TfrmMain.DoCallLoginAPISucc 2');

  //保存这次登录的用户信息
  uManager.GlobalManager.SaveLastLoginInfo;


  uBaseLog.HandleException(nil,'TfrmMain.DoCallLoginAPISucc 3');

  if AIsNeedShowMainFrame then
  begin
      uBaseLog.HandleException(nil,'TfrmMain.DoCallLoginAPISucc 3.1');
      //登录成功
      LoginShowMainFrame(AIsAutoLogin);
  end
  else
  begin
      uBaseLog.HandleException(nil,'TfrmMain.DoCallLoginAPISucc 3.2');
      if GlobalMainFrame<>nil then
      begin
        GlobalMainFrame.Login(True);
      end;
  end;

  uBaseLog.HandleException(nil,'TfrmMain.DoCallLoginAPISucc 4');




  {$IFDEF HAS_PUSHNOTIFICATION}
      //wn
      //处理推送
      //当前的用户
//      FPushClientRestImpl.UserFID:=GlobalManager.User.fid;



      {$IF DEFINED(ANDROID)}
      //绑定用户和ClientID
      Self.FPushClientRestImpl.BindUserAndBasePush;
      {$ENDIF}
      {$IFDEF IOS}
        {$IFNDEF CPUX86}
        //绑定用户和ClientID
        Self.FPushClientRestImpl.BindUserAndBasePush;
        {$ENDIF}
      {$ENDIF}



      {$IFDEF MSWINDOWS}
      //Windows下面模拟注册推送
      //绑定用户和ClientID
      FPushClientRestImpl.BindUserAndBasePush;
      {$ENDIF}


      //更新未读消息数
      tmrSyncBadge.Enabled:=True;

  {$ENDIF}


  uBaseLog.HandleException(nil,'TfrmMain.DoCallLoginAPISucc 5');


//  if GlobalIOSStatusBarFontColor=TAlphaColorRec.White then
//  begin
//    //因为要把IOS下面状态栏的字体改为白色
//    //所以把窗体颜色改为黑色
//    Self.Fill.Color:=TAlphaColorRec.Black;
//    UpdateFormStatusBarColor(Self);
////    //再恢复窗体颜色为白色
////    Self.Fill.Color:=TAlphaColorRec.White;
//  end;


    //不是第一次登录了
    //当前没有手机号
    //绑定手机号
    if GlobalIsThirdPartyNeedPhone
        and GlobalManager.IsLogin
        and (GlobalManager.User.phone='')
        //不是苹果登录的,苹果审核规定不允许苹果登录的再进行二次手机验证
        and (GlobalManager.User.apple_open_id='') then
    begin
      //不是第一次登录了
      //当前没有手机号
      //绑定手机号
      HideFrame;
      ShowFrame(TFrame(GlobalBindPhoneNumberFrame),TFrameBindPhoneNumber);
      GlobalBindPhoneNumberFrame.Clear;
      GlobalBindPhoneNumberFrame.btnReturn.Visible:=False;
    end;



end;

//{$IFDEF IOS}
//procedure TfrmMain.DoCellularDataRestrictionDidUpdateNotifierEvent(state: CTCellularDataRestrictedState);
//begin
//
//  FMX.Types.Log.d('OrangeUI TfrmMain.DoCellularDataRestrictionDidUpdateNotifierEvent');
//
//  case CTCellularDataRestrictedState_(state) of
//    kCTCellularDataRestrictedStateUnknown:
//    begin
//      FMX.Types.Log.d('OrangeUI TfrmMain.DoCellularDataRestrictionDidUpdateNotifierEvent Unknown');
//
//    end;
//    kCTCellularDataRestricted:
//    begin
//      FMX.Types.Log.d('OrangeUI TfrmMain.DoCellularDataRestrictionDidUpdateNotifierEvent Restricted');
//
//    end;
//    kCTCellularDataNotRestricted:
//    begin
//      FMX.Types.Log.d('OrangeUI TfrmMain.DoCellularDataRestrictionDidUpdateNotifierEvent Not Restricted');
//      GlobalIsTimerThreadCanExecute:=True;
//    end;
//  end;
//
//end;
//{$ENDIF IOS}


procedure TfrmMain.DoCustomAutoLoginExecute(ATimerTask: TObject);
begin
  //执行成功
  TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
end;

//procedure TfrmMain.WeiChatLogin(AWeiXinString:String);
//begin
//  Self.FWeiXinString:=AWeiXinString;
//
//  uBaseLog.HandleException('TFrameLogin.WeiChatLogin');
//
//  {$IFDEF HAS_WXPAY}
//  uBaseLog.HandleException('TFrameLogin.WeiChatLogin Begin');
//  GlobalWeiChat.OnAuthLoginResult:=Self.DoWeiChatAuthLoginResult;
//  GlobalWeiChat.OnAuthLoginError:=Self.DoWeiChatAuthLoginError;
//  if not GlobalWeiChat.AuthLogin(frmMain) then
//  begin
//    ShowMessageBoxFrame(nil,Trans('发送请求给微信失败!'));
//  end;
//  uBaseLog.HandleException('TFrameLogin.WeiChatLogin End');
//  {$ENDIF HAS_WXPAY}
//end;
//
//procedure TfrmMain.DoWeiChatAuthLoginError(Sender: TObject);
//begin
//  {$IFDEF HAS_WXPAY}
//  ShowMessageBoxFrame(nil,GlobalWeiChat.FDoLoadUserInfoError);
//  {$ENDIF HAS_WXPAY}
//end;
//
//procedure TfrmMain.DoWeiChatAuthLoginResult(Sender: TObject);
//begin
//  {$IFDEF HAS_WXPAY}
//
//  //获取微信登录口令
//  Self.FWxOpenID:=GlobalWeiChat.FOpenID;
//  FMX.Types.Log.d('OrangeUI TfrmMain.DoWeiChatAuthLoginResult FWxOpenId:'+Self.FWxOpenID);
//  Self.FWxAuthToken:=GlobalWeiChat.FAccessToken;
//  FMX.Types.Log.d('OrangeUI TfrmMain.DoWeiChatAuthLoginResult FWxAuthToken:'+Self.FWxAuthToken);
////  //用户名称
////  Self.FUserName:=GlobalWeiChat.FNickName;
//  if Self.FWeiXinString='login' then
//  begin
//      GlobalLoginFrame.DoWeichatLogin;
//  end
//  else if Self.FWeiXinString='binding' then
//  begin
//      ShowWaitingFrame(Self,'绑定中...');
//      //微信绑定
//      uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                             OnWeiXinBindingExecute,
//                                             OnWeiXinBindingExecuteEnd);
//  end
//  else if Self.FWeiXinString='notbinding' then
//  begin
//      ShowWaitingFrame(Self,'解绑中...');
//      //微信绑定
//      uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                             OnWeiXinnotBindingExecute,
//                                             OnWeiXinnotBindingExecuteEnd);
//  end;
//  {$ENDIF HAS_WXPAY}
//end;

//procedure TfrmMain.DoGetNoticeExecute(ATimerTask: Tobject);
//begin
//  //出错
//  TTimerTask(ATimerTask).TaskTag:=1;
//
//  try
//    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI(
//          'get_user_notice',
//          nil,
//          UserCenterInterfaceUrl,
//          ['appid',
//          'user_fid',
//          'key',
//          'notice_fid'
//          ],
//          [AppID,
//          GlobalManager.User.fid,
//          GlobalManager.User.key,
//          FNoticeFID
//          ],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//          );
//    if TTimerTask(ATimerTask).TaskDesc<>'' then
//    begin
//      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
//    end;
//
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
//end;
//
//procedure TfrmMain.DoGetNoticeExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//begin
//
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//
//          if FNotice.is_readed=1 then
//          begin
//            FNoticeClassify.notice_classify_unread_count:=FNoticeClassify.notice_classify_unread_count;
//          end
//          else
//          begin
//            //未读设置为已读
//            FNoticeClassify.notice_classify_unread_count:=FNoticeClassify.notice_classify_unread_count-1;
//
//            //返回需要刷新
//            GlobalIsNoticeListChanged:=True;
//          end;
//
//
//          FNotice.ParseFromJson(ASuperObject.O['Data'].A['Notice'].O[0]);
//          ASuperObject:=TSuperObject.Create(FNotice.custom_data_json);
//
//          GlobalMainFrame.ProcessGetNotice(FNotice,ASuperObject);
//
//
//          FNotice.is_readed:=1;
//
////          //订单消息
////          if FNotice.notice_classify='order' then
////          begin
////            if ASuperObject.Contains('order_fid') then
////            begin
////                //是订单消息
////                FOrder.fid:=ASuperObject.I['order_fid'];
////
////                //订单详情
////                uTimerTask.GetGlobalTimerThread.RunTempTask(
////                              DoGetNoticeOrderExecute,
////                              DoGetNoticeOrderExecuteEnd);
////                //
////
////
////            end;
////          end
////          //其他消息
////          else if FNotice.notice_classify='other' then
////          begin
////            //酒店审核结果    FNotice.notice_sub_type='hotel_audit_result'
////            //挂钩信息、实名认证等
////            //有要用的属性就先借用了
////            FHotel.audit_user_name:=ASuperObject.S['audit_user_name'];
////            FHotel.audit_state:=ASuperObject.I['audit_state'];
////            FHotel.audit_remark:=ASuperObject.S['audit_remark'];
////            FHotel.audit_time:=FNotice.createtime;
////
////            //隐藏
////            HideFrame;//(CurrentFrame,hfcttBeforeShowFrame);
////
////            //审核意见
////            ShowFrame(TFrame(GlobalAuditInfoFrame),TFrameAuditInfo,frmMain,nil,nil,nil,Application);
////            GlobalAuditInfoFrame.Clear;
////            GlobalAuditInfoFrame.LoadHotel(FHotel);
////            GlobalAuditInfoFrame.FrameHistroy:=CurrentFrameHistroy;
////
////          end
////          else
////          begin
////
////            //隐藏
////            HideFrame;//(CurrentFrame,hfcttBeforeShowFrame);
////            //详情界面
////            ShowFrame(TFrame(GlobalSystemNotificationInfoFrame),TFrameSystemNotificationInfo,frmMain,nil,nil,nil,Application);
////            GlobalSystemNotificationInfoFrame.FrameHistroy:=CurrentFrameHistroy;
////            //系统通知
////            if FNotice.notice_classify='system' then
////            begin
////              GlobalSystemNotificationInfoFrame.Load('公告详情',FNotice);
////            end
////            //站内信
////            else if FNotice.notice_classify='mail' then
////            begin
////              GlobalSystemNotificationInfoFrame.Load('消息详情',FNotice);
////            end;
////          end;
//
//      end
//      else
//      begin
//        //获取失败
//        ShowMessageBoxFrame(frmMain,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//
//      end;
//
//    end
//    else if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(frmMain,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//    end;
//  finally
//    HideWaitingFrame;
//  end;
//
//end;

//procedure TfrmMain.DoBasePushAndroidReceivePayloadMsg(Sender: TObject;APayloadMsg: String; AIsAtBackground: Boolean);
////var
////  AUserCustomJson:ISuperObject;
//begin
//  HandleException(nil,'TfrmMain.DoBasePushAndroidReceivePayloadMsg '+APayloadMsg+' AIsAtBackground='+BoolToStr(AIsAtBackground));
//
//  if APayloadMsg<>'' then
//  begin
//
////      AUserCustomJson:=TSuperObject.Create(APayloadMsg);
//      //接收到了推送
//      TThread.Synchronize(nil,
//        procedure
//        begin
//          ClickPushNotification(Sender,
//                                '',
//                                '',
//                                APayloadMsg,//AUserCustomJson,
//                                AIsAtBackground,
//                                False);
//        end);
//
//  end
//  else
//  begin
//      //普通推送
//
//  end;
//
//  Self.GetUserNoticeUnReadCount;
//
//
//end;

procedure TfrmMain.DoBasePushIOSRecvAPNSNotification(Sender: TObject;ANotification: String;AIsAtBackground:Boolean; AIsStartup: Boolean);
var
  AApsSuperObject:ISuperObject;
  AUserCustomJsonStr:String;
  ATitle:String;
  AContent:String;
begin
  HandleException(nil,'TfrmMain.DoBasePushIOSRecvAPNSNotification ANotification:'+ANotification
                            +' AIsAtBackground:'+IntToStr(Ord(AIsAtBackground))
                            +' AIsStartup:'+IntToStr(Ord(AIsStartup))
                            );

  //判断是个推还是APNS发过来的
//  {
//    "aps":{
//          "alert":{
//                  "title":"Title",
//                  "body":"Text"
//                  },
//          "content-available":0,
//          "badge":6
//        },
//    "usercustom":{
//                  "Data":"TransmissionContent"
//                }
//  }


  ATitle:='';
  AContent:='';
  AApsSuperObject:=nil;
  AUserCustomJsonStr:='';
  try
    AApsSuperObject:=TSuperObject.Create(ANotification);
    if AApsSuperObject.Contains('aps') then
    begin
        //APNS发过来的
        AUserCustomJsonStr:=AApsSuperObject.O['usercustom'].AsJson;
        ATitle:=AApsSuperObject.O['aps'].O['alert'].S['title'];
        AContent:=AApsSuperObject.O['aps'].O['alert'].S['content'];
        AIsAtBackground:=(AApsSuperObject.I['IsAtBackground']=1);
    end
    else
    begin
        AUserCustomJsonStr:=AApsSuperObject.AsJson;
    end;
  except
    on E:Exception do
    begin
      ATitle:='';
      AContent:='';
      AApsSuperObject:=nil;
      AUserCustomJsonStr:='';
    end;
  end;



  //接收到了推送
  TThread.Synchronize(nil,
  procedure
  begin
      if (GlobalMainFrame<>nil) and (AIsAtBackground or AIsStartup) then
      begin
          ClickPushNotification(
                      Sender,
                      ATitle,
                      AContent,
                      AUserCustomJsonStr,
                      AIsAtBackground,
                      AIsStartup
                      );
      end;
  end);



  Self.GetUserNoticeUnReadCount;



//  //外卖项目需要
//  //APNS推送前台提示音
//  if AppID='1002' then
//  begin
//      if AApsSuperObject.I['IsAtBackground']<>1 then
//      begin
//        if MediaPlayerMain=nil then MediaPlayerMain:=TMediaPlayer.Create(Self);
//        if (MediaPlayerMain.State=TMediaState.Playing) then MediaPlayerMain.Stop;
//        //判断推送的类型
//        if (AUserCustomJson.S['notice_sub_type']=Const_NoticeSubType_OrderPayed_NoticeShoper)
//        OR (AUserCustomJson.S['notice_sub_type']=Const_NoticeSubType_OrderAcceptNoticeRider) then
//        begin
//          MediaPlayerMain.FileName:=GetApplicationPath+'sound_1.mp3';
//
//          MediaPlayerMain.Play;
//        end;
//      end;
//  end;



end;


procedure TfrmMain.DoGetUserNoticeUnReadCountExecute(ATimerTask: TObject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;

  try
    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('get_user_notice_unread_count',
                                                    nil,
                                                    UserCenterInterfaceUrl,
                                                    ['appid',
                                                    'user_fid',
                                                    'key'],
                                                    [AppID,
                                                    GlobalManager.User.fid,
                                                    GlobalManager.User.key
                                                    ],
                                                    GlobalRestAPISignType,
                                                    GlobalRestAPIAppSecret
                                                    );
    if TTimerTask(ATimerTask).TaskDesc<>'' then
    begin
      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
    end;

  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;
end;

procedure TfrmMain.DoGetUserNoticeUnReadCountExecuteEnd(ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

        //获取未读通知数
        GlobalManager.User.notice_unread_count:=ASuperObject.O['Data'].I['notice_unread_count'];

        GlobalMainFrame.PorcessGetUserNoticeUnReadCount(ASuperObject.O['Data'].I['notice_unread_count']);

      end
//      else
//      begin
//        //调用失败 后台刷新,不能弹出对话框
//        ShowMessageBoxFrame(frmMain,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end
      ;

    end
//    else if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常 后台刷新,不能弹出对话框
//      ShowMessageBoxFrame(frmMain,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//    end
    ;
  finally

  end;

end;

procedure TfrmMain.FormCreate(Sender: TObject);
//{$IFDEF IOS}
//var
//  cellularData:CTCellularData;
//{$ENDIF}
begin
  //因为OrangeUI不能引用FMX.WebBrowser,很多人加入了WebBrowser的修复
  uFrameContext.OnWebBrowserRealign:=DoWebBrowserRealign;



  OutputDebugString('OrangeUI TfrmMain.FormCreate Begin'+' ThreadID:'+IntToStr(TThread.CurrentThread.ThreadID));


  // 从配置文件加载主题
  CustomLoadFromINI;

  //窗体背景色默认是黑色,为了在IOS下面状态栏字体初始就显示为白色
  //但窗体显示之后,就要恢复窗体背景色为白色
//  Self.Fill.Color:=TAlphaColorRec.White;
//  {$IFDEF IOS}
//  if GlobalIOSStatusBarFontColor=TAlphaColorRec.White then
//  begin
////    Self.Fill.Color:=TAlphaColorRec.Black;
//    GlobalStatusBarLuminance:=0;//0字体白
//  end
//  else
//  begin
////    Self.Fill.Color:=TAlphaColorRec.White;
//    GlobalStatusBarLuminance:=1;////1字体黑
//  end;
//  {$ENDIF IOS}



  //注册程序事件
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(FApplicationEventService)) then
  begin
    FApplicationEventService.SetApplicationEventHandler(DoApplicationEventHandler);
  end;



  OutputDebugString('OrangeUI TfrmMain.FormCreate 1');

  //加载翻译
  {$IFDEF MSWINDOWS}
      if AppID='1000' then
      begin
          if  (DirectoryExists('E:\MyFiles')
                or DirectoryExists('C:\MyFiles'))
                //E:\MyFiles\OrangeUIProduct\外卖平台\APP\AppLang.lng
              and FileExists(GetApplicationPath
                              +'..'+PathDelim
                              +'..'+PathDelim
                              +'..'+PathDelim
                              +'..'+PathDelim
                              +'..'+PathDelim
                              +'OrangeUIAppFramework'+PathDelim
                              +'AppLang.lng') then
          begin
              //开发模式下,
              //E:\MyFiles\OrangeUIProduct\外卖平台\APP\AppLang.lng
              FTranslateFilePath:=GetApplicationPath
                                        +'..'+PathDelim
                                        +'..'+PathDelim
                                        +'..'+PathDelim
                                        +'..'+PathDelim
                                        +'..'+PathDelim
                                        +'OrangeUIAppFramework'+PathDelim
                                        +'AppLang.lng';
              GlobalLang.LoadFromFile(FTranslateFilePath);
          end
          else
          //放在C盘供翻译
          if FileExists('C:\'+'AppLang.lng') then
          begin
              FTranslateFilePath:='C:\AppLang.lng';
              //供翻译人员翻译
              GlobalLang.LoadFromFile('C:\AppLang.lng');
          end;
//          //当前的语言
//          GlobalCurLang:='en';


//          //英文
//          LangKind:=TLangKind.lkEN;
      end;
  {$ENDIF}
  {$IF DEFINED(ANDROID) OR DEFINED(IOS) }
      //加载
      if AppID='1000' then
      begin
        if FileExists(GetApplicationPath+'AppLang.lng') then
        begin
          FTranslateFilePath:=GetApplicationPath+'AppLang.lng';

          GlobalLang.LoadFromFile(FTranslateFilePath);
        end;
//        //当前的语言
//        GlobalCurLang:='en';

//          //英文
//          LangKind:=TLangKind.lkEN;
      end;
  {$ENDIF}





  //显示对应的APP标题
  Self.Caption:=Const_APPName;



  //不较正一个像素的线条
  //不然ListBox滑动的时候分隔线会不对
  uGraphicCommon.IsAdjustDrawLinePos:=False;




  {$IFDEF ANDROID}
  //清除一下剪贴板
  //避免Android下面点击TEdit的时候,老是会弹出粘贴按钮
  uMobileUtils.MySetClipboard('');
  {$ENDIF}



  //获取设备详情,IMEI,UUID,PhoneType,OS等
  //登录和注册推送的时候需要使用
  DeviceInfoByPlatform;


  OutputDebugString('OrangeUI TfrmMain.FormCreate 2');

  {$IFNDEF MSWINDOWS}
  //在有些Windows的电脑上
  //窗体上放TGestureManager会报错
  //所以要动态创建
  //剪裁头像窗体等一些页面要用
  FGestureManager:=TGestureManager.Create(Self);
  Self.Touch.GestureManager:=FGestureManager;
  {$ENDIF}

  OutputDebugString('OrangeUI TfrmMain.FormCreate 3');


  {$IFDEF ANDROID}
  OutputDebugString('OrangeUI OSVersion '+TOSVersion.ToString
                      +' Major '+IntToStr(TOSVersion.Major)
                      +' Major '+IntToStr(TOSVersion.Major)
                      +' Build '+IntToStr(TOSVersion.Build)
                      );

  if GlobalIsAndroidTransparentToolbar then
  begin
      //Android 4.4.4及以上版本
      if (TOSVersion.Major>4)
        or (TOSVersion.Major=4)
        and (TOSVersion.Minor>=4)
        and (TOSVersion.Build>=4)
        //有时候不准
        or (Pos('4.4.4',TOSVersion.ToString)>0)
        //有时候4.4.2也需要加高,华为荣耀6plus
        or (Pos('4.4.2',TOSVersion.ToString)>0) then
      begin
          //Android下用了透明任务栏的模式
          //顶部任务栏用Panel增高的方式
          uComponentType.IsAndroidIntelCPU:=True;

//          //因为外卖平台用了谷歌推送,与透明任务栏有冲突。
//          if AppID=1002 then
//          begin
//            uComponentType.IsAndroidIntelCPU:=False;
//          end;
      end;
  end;
  {$ENDIF}




  //新版本OrangeUI不需要了,直接去掉了
  //在Windows平台下的模拟虚拟键盘控件
  SimulateWindowsVirtualKeyboardHeight:=160;
  IsSimulateVirtualKeyboardOnWindows:=True;
//  GlobalAutoProcessVirtualKeyboardControlClass:=TSkinFMXPanel;
//  GlobalAutoProcessVirtualKeyboardControl:=pnlVirtualKeyBoard;
//  GlobalAutoProcessVirtualKeyboardControl.Visible:=False;
//  {$IFNDEF MSWINDOWS}
//  pnlVirtualKeyBoard.SelfOwnMaterialToDefault.IsTransparent:=True;
//  pnlVirtualKeyBoard.Caption:='';
//  {$ENDIF}



  //新版本OrangeUI不需要了,直接去掉了
//  //修复Android下的虚拟键盘隐藏和显示
//  GetGlobalVirtualKeyboardFixer.StartSync(Self);




  //初始微信,一定要放在MainForm的Create,不然微信支付的时候会没有反应
  {$IFDEF HAS_WXPAY}
    OutputDebugString('OrangeUI TfrmMain.FormCreate Init WeiChat Begin');
    GlobalWeiChat:=TWeiChat.Create(nil);
    GlobalWeiChat.AppID:=Const_WeiXin_AppId;
    GlobalWeiChat.AppSecret:=Const_WeiXin_AppSecret;
    GlobalWeiChat.PartnerID:=Const_WeiXin_PartnerID;
    GlobalWeiChat.PartnerKey:=Const_WeiXin_PartnerKey;
    GlobalWeiChat.IOSUniversalLink:=Const_WeiXin_IOSUniversalLink;

    {$IFDEF IOS}
    //IOS返回需要
    GlobalApplicationContinueUserActivityEvent:=GlobalWeiChat.DoApplicationContinueUserActivity;
    {$ENDIF}


    //注册
    if not GlobalWeiChat.RegisterWeiChat then
    begin
//      ShowHintFrame(nil,'微信SDK初始失败');
//      ShowMessage('微信SDK初始失败');
    end;
    OutputDebugString('OrangeUI TfrmMain.FormCreate Init WeiChat End');
  {$ENDIF}


//  {$IFDEF HAS_FACEBOOK}
//  InitGlobalFBLoginManager(Const_Facebook_AppId);
//  {$ENDIF HAS_FACEBOOK}



  {$IFDEF HAS_ALIPAY}
    OutputDebugString('OrangeUI TfrmMain.FormCreate Init Alipay Begin');
    GlobalAlipayMobilePay:=TAlipayMobilePay.Create(nil);
    //IOS系统中的框架
    GlobalAlipayMobilePay.AppID:=Const_AliPay_AppId;
    OutputDebugString('OrangeUI TfrmMain.FormCreate Init Alipay End');
  {$ENDIF}





  {$IFDEF IOS}
  {$IFDEF HAS_APPLESIGNIN}
    OutputDebugString('OrangeUI TfrmMain.FormCreate Init AppleSignIn Begin');
    //苹果登录
    GlobalAppleSignIn:=TAppleSignIn.Create(nil);
    OutputDebugString('OrangeUI TfrmMain.FormCreate Init AppleSignIn End');
  {$ENDIF}
  {$ENDIF}





  {$IFDEF HAS_X5WEBBROWSER}
  //初始腾讯X5内核浏览器
  FTBSSDK:=TTBSSDK.Create(nil);
  {$ENDIF}




  //#define IPHONE_X \
  //({BOOL isPhoneX = NO;\
  //if (@available(iOS 11.0, *)) {\
  //isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
  //}\
  //(isPhoneX);})
  //  FMX.Helpers.IOS.SharedApplication.delegate.window.
//  GlobalIsIPhoneX:=True;
//搜索路径要配置如下
//C:\Program Files (x86)\Embarcadero\Studio\20.0\source\fmx;
//C:\Program Files (x86)\Embarcadero\Studio\20.0\source\rtl\ios
//  {$IFDEF IOS}
//  if WindowHandleToPlatform(Handle).View.safeAreaInsets.bottom>0 then
//  begin
//    GlobalIsIPhoneX:=True;
////    ShowMessage('是IphoneX');
//  end
//  else
//  begin
////    ShowMessage('不是IphoneX');
//  end;
//  {$ENDIF IOS}


  {$IFDEF IOS}
  //判断网络是否允许访问
//  GlobalIsTimerThreadCanExecute:=False;
//  cellularData:=TCTCellularData.Create;
//  cellularData.setCellularDataRestrictionDidUpdateNotifier(DoCellularDataRestrictionDidUpdateNotifierEvent);
  {$ENDIF}


  {$IFDEF HAS_PAGESTRUCTURE}
  //页面框架的数据源,可以定义多个
  FPageFrameworkDataSource:=TPageFrameworkDataSource.Create(nil);
  Self.FPageFrameworkDataSource.OnGetDrawPicture:=DoPageFrameworkDataSourceGetDrawPicture;
  Self.FPageFrameworkDataSource.OnGetParamValue:=DoPageFrameworkDataSourceGetParamValue;
  Self.FPageFrameworkDataSource.OnSetParamValue:=DoPageFrameworkDataSourceSetParamValue;


  GlobalOpenPlatformFramework.OnCustomProcessPageAction:=DoMainProgramSettingCustomProcessPageAction;
  {$ENDIF}



  {$IFDEF HAS_CCBAIDU_OCR}
  {$IFDEF ANDROID}
  CCBaiduOCR1:=TCCBaiduOCR.Create(Self);
  CCBaiduOCR1.OnInitAccessTokenWithAkSkResult:=CCBaiduOCR1InitAccessTokenWithAkSkResult;
  CCBaiduOCR1.OnRecognizeResult:=CCBaiduOCR1RecognizeResult;
  // 授权文件（安全模式）获取AccessToken
//  CCBaiduOCR1.initAccessTokenWithAkSk();
  CCBaiduOCR1.initAccessTokenLicenseFile;
//  {
//    通过API Key / Secret Key获取AccessToken
//    此种身份验证方案使用AK/SK获得AccessToken。
//
//    虽然SDK对网络传输的敏感数据进行了二次加密，但由于AK/SK是明文填写在代码中，在移动设备中可能会存在AK/SK被盗取的风险。有安全考虑的开发者可使用第二种授权方案。
//  }
//  {
//    self.CCBaiduOCR1.initAccessTokenWithAkSk('3gCv6XGcIfOID70nerG5vECD',
//    'ot1Mwsfzy9oU9R5rkm1FoAmVAESPEVYO');
//  }


  {$ENDIF}
  {$ENDIF}


  FHttpBaiduOCR:=THttpBaiduOCR.Create;
  FHttpBaiduOCR.FAccessKey:='ik7EckvwL2gDnp5S1kueDGwG';
  FHttpBaiduOCR.FAccessSecret:='hFaONhb3PrXHiGOSe4E668kw5sGblgG5';


  OutputDebugString('OrangeUI TfrmMain.FormCreate End'+' ThreadID:'+IntToStr(TThread.CurrentThread.ThreadID));
end;

{$IFDEF HAS_CCBAIDU_OCR}

procedure TfrmMain.CCBaiduOCR1InitAccessTokenWithAkSkResult(Sender: TObject; AErrorCode: Integer; AErrorMsg, AToken: string);
begin
  {$IFDEF ANDROID}
  if AErrorCode = 0 then
  begin
//    ShowMessage('获取token成功!' + #13#10 + AToken);
  end
  else
  begin
    ShowMessage('获取token失败!' + #13#10 + AErrorMsg);
  end;
  {$ENDIF}

end;

procedure TfrmMain.CCBaiduOCR1RecognizeResult(Sender: TObject; AOCRType: TCCBaiduOCRType; AErrorCode: Integer; AErrorMsg, AFilePath, AJosonResult: string; AIDCardInfo: TCCIDCardInfo; ABankCardInfo: TCCBankCardInfo);
begin

  TThread.Synchronize(nil,procedure
  begin
    //ShowMessage('识别成功'+AJosonResult);
    FBaiduOCR_OnResultEvent(Sender,AOCRType,AErrorCode,AErrorMsg, AFilePath, AJosonResult,AIDCardInfo,ABankCardInfo);
  end);

//  uResultForm.ShowForm(AOCRType, AErrorCode, AErrorMsg, AFilePath, AJosonResult, AIDCardInfo, ABankCardInfo,
//    procedure(AResult: TModalResult)
//    begin
//
//    end);

end;

procedure TfrmMain.DoRequestPermissions(AResult: TProc<boolean>);
begin
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions([JStringToString(TJManifest_permission.JavaClass.CAMERA), JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE), JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE)],
    procedure(const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray)
    begin
      if (Length(AGrantResults) = 3) then // 为什么为3？因为只申请了3个权限，返回肯定判断3个
      begin
        // 三个全选都允许了,才能拍照
        if (AGrantResults[0] = TPermissionStatus.Granted) and (AGrantResults[1] = TPermissionStatus.Granted) and (AGrantResults[2] = TPermissionStatus.Granted) then
        begin
          if assigned(AResult) then
          begin
            AResult(true);
          end;
        end
        else
        begin
          AResult(false);
        end;

      end;
    end);
  {$ENDIF}
end;

procedure TfrmMain.StartBaiduOCR(ABaiduOCR_OnResultEvent:TBaiduOCR_OnResultEvent=nil);
begin
  FBaiduOCR_OnResultEvent:=ABaiduOCR_OnResultEvent;
  {$IFDEF ANDROID}
  Self.DoRequestPermissions(
    procedure(AResult: boolean)
    begin
      if AResult then
      begin
        CCBaiduOCR1.TagString := 'ocr_general_basic';
        CCBaiduOCR1.ocr_general_basic;
      end
      else
      begin
        ShowMessage('权限未允许！');
      end;
    end);
  {$ENDIF}
  {$IFDEF IOS}
  Self.TakePhotoFromCameraAction1.ExecuteTarget(Self);
  {$ENDIF}
end;
{$ENDIF}


procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  OutputDebugString('OrangeUI TfrmMain.FormDestroy Begin'+' ThreadID:'+IntToStr(TThread.CurrentThread.ThreadID));


  if AppID='1000' then
  begin
      {$IFDEF MSWINDOWS}
      //保存语言文件
      if FTranslateFilePath<>'' then
      begin
        //开发模式
        GlobalLang.SaveToFile(FTranslateFilePath);
      end;
      {$ENDIF}
  end;


  FreeAndNil(FHttpBaiduOCR);

  //初始微信,一定要放在MainForm的Create,不然微信支付的时候会没有反应
  {$IFDEF HAS_WXPAY}
  FreeAndNil(GlobalWeiChat);
  {$ENDIF}



  {$IFDEF HAS_ALIPAY}
  FreeAndNil(GlobalAlipayMobilePay);
  {$ENDIF}



  {$IFDEF IOS}
  {$IFDEF HAS_APPLESIGNIN}
  FreeAndNil(GlobalAppleSignIn);
  {$ENDIF}
  {$ENDIF}




  {$IFDEF HAS_X5WEBBROWSER}
  FreeAndNil(FTBSSDK);
  {$ENDIF}




  {$IFDEF HAS_PUSHNOTIFICATION}
  FreeAndNil(FPushClientRestImpl);
  {$ENDIF}



  {$IFDEF HAS_PAGESTRUCTURE}
  FreeAndNil(FPageFrameworkDataSource);
  {$ENDIF}


  OutputDebugString('OrangeUI TfrmMain.FormDestroy End'+' ThreadID:'+IntToStr(TThread.CurrentThread.ThreadID));
end;

procedure TfrmMain.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  LObj: IControl;
  LImage: TSkinImageListViewer;
  LImageCenter: TPointF;
begin
//  OutputDebugString('OrangeUI TfrmMain.FormGesture');

  if CurrentFrame=GlobalClipHeadFrame then
  begin
    GlobalClipHeadFrame.DoGesture(Sender,EventInfo,Handled);
  end
  else
  begin
    //  FMX.Types.Log.d('TfrmMain.FormGesture Begin');

      if EventInfo.GestureID = igiZoom then
      begin
        LObj := Self.ObjectAtPoint(ClientToScreen(EventInfo.Location));
    //    FMX.Types.Log.d('TfrmMain.FormGesture igiZoom LObj:'+LObj.GetObject.ClassName);
        if LObj.GetObject is TSkinImageListViewer then
        begin
    //      if (not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags)) and
    //        (not(TInteractiveGestureFlag.gfEnd in EventInfo.Flags)) then
    //      begin
    //        { zoom the image }
    //        LImage := TImage(LObj.GetObject);
    //        LImageCenter := LImage.Position.Point + PointF(LImage.Width / 2,
    //          LImage.Height / 2);
    //        LImage.Width := Max(LImage.Width + (EventInfo.Distance - FLastDistance), 10);
    //        LImage.Height := Max(LImage.Height + (EventInfo.Distance - FLastDistance), 10);
    //        LImage.Position.X := LImageCenter.X - LImage.Width / 2;
    //        LImage.Position.Y := LImageCenter.Y - LImage.Height / 2;
    //      end;
    //      FLastDistance := EventInfo.Distance;

            //缩放
            TSkinImageListViewer(LObj.GetObject).Prop.Gesture(EventInfo,Handled);

        end;
      end;


      if EventInfo.GestureID = igiDoubleTap then
      begin
        LObj := Self.ObjectAtPoint(ClientToScreen(EventInfo.Location));
    //    FMX.Types.Log.d('TfrmMain.FormGesture igiDoubleTap LObj:'+LObj.GetObject.ClassName);
        if LObj.GetObject is TSkinImageListViewer then
        begin
    //      if (not(TInteractiveGestureFlag.gfBegin in EventInfo.Flags)) and
    //        (not(TInteractiveGestureFlag.gfEnd in EventInfo.Flags)) then
    //      begin
    //        { zoom the image }
    //        LImage := TImage(LObj.GetObject);
    //        LImageCenter := LImage.Position.Point + PointF(LImage.Width / 2,
    //          LImage.Height / 2);
    //        LImage.Width := Max(LImage.Width + (EventInfo.Distance - FLastDistance), 10);
    //        LImage.Height := Max(LImage.Height + (EventInfo.Distance - FLastDistance), 10);
    //        LImage.Position.X := LImageCenter.X - LImage.Width / 2;
    //        LImage.Position.Y := LImageCenter.Y - LImage.Height / 2;
    //      end;
    //      FLastDistance := EventInfo.Distance;

            //恢复初始
            TSkinImageListViewer(LObj.GetObject).Prop.CancelZoom;

        end;
      end;

    //  FMX.Types.Log.d('TfrmMain.FormGesture End');
  end;



end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
var
  AFrameReturnActionType:TFrameReturnActionType;
begin
  if
    (Key = vkHardwareBack)
    //Windows下Escape键模拟返回键
    or (Key = vkEscape)
    then
  begin



      //返回
      if (CurrentFrameHistroy.ToFrame<>nil)
          //如果当前是登陆页面,不返回上一页
         and (CurrentFrameHistroy.ToFrame<>GlobalLoginFrame)
          //如果当前是主页面,不返回上一页
         and (CurrentFrameHistroy.ToFrame<>GlobalMainFrame)
         then
      begin
          AFrameReturnActionType:=CanReturnFramePro(CurrentFrameHistroy);

          if IsRepeatClickReturnButton(CurrentFrameHistroy.ToFrame) then
          begin
              //连续点击返回键
              Key:=0;
              KeyChar:=#0;

              Exit;

          end
          else if AFrameReturnActionType=TFrameReturnActionType.fratDefault then
          begin
              //不需要效果
              HideFrame;//(CurrentFrameHistroy.ToFrame,hfcttBeforeReturnFrame,ufsefNone);
              ReturnFrame;//(CurrentFrameHistroy);

              Key:=0;
              KeyChar:=#0;
          end
          else if AFrameReturnActionType=TFrameReturnActionType.fratReturnAndFree then
          begin
              //返回上一页
              HideFrame;//(CurrentFrameHistroy.ToFrame,hfcttBeforeReturnFrame);
              ReturnFrame(nil,1,True);//(CurrentFrameHistroy);

              Key:=0;
              KeyChar:=#0;
          end
          else if AFrameReturnActionType=TFrameReturnActionType.fratCanNotReturnAndToBack then
          begin
              //表示当前Frame不允许返回

              {$IFDEF ANDROID}
              //程序退到后台挂起,需要引用Androidapi.Helpers单元
              OutputDebugString('OrangeUI moveTaskToBack');
              SharedActivity.moveTaskToBack(False);

              //表示不关闭APP
              Key:=0;
              KeyChar:=#0;
              {$ENDIF}

          end
          else
          begin
              Key:=0;
              KeyChar:=#0;
          end;


      end
      else
      begin
          {$IFDEF ANDROID}
          //程序退到后台挂起,需要引用Androidapi.Helpers单元
          OutputDebugString('OrangeUI moveTaskToBack');
          SharedActivity.moveTaskToBack(False);

          //表示不关闭APP
          Key:=0;
          KeyChar:=#0;
          {$ENDIF}
      end;

  end;

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin

  OutputDebugString('OrangeUI TfrmMain.FormShow Begin'+' ThreadID:'+IntToStr(TThread.CurrentThread.ThreadID));

  try

      {$IFDEF MSWINDOWS}
      // 设置IE8渲染模式
      //SetIE8FeatureMode;
      // 设置与IE同等的渲染模式
      SetIEFeatureModeCorrespond;
      {$ENDIF}


      dmEasyServiceCommonMaterial.SyncSkinThemeColor;


      //动态申请权限,Const_Android_RequestPermissions在uConst中定义
      //10.2 WILL CRASH
      {$IFDEF ANDROID}
          {$IF RTLVersion>=32}// 10.2+
          if Length(Const_Android_RequestPermissions)>0 then
          begin
            PermissionsService.RequestPermissions(Const_Android_RequestPermissions,
                  //不能为nil,不然会闪退,RequestPermissions调用两次会闪退
          procedure(const APermissions: {$IF CompilerVersion >= 35.0}TClassicStringDynArray{$ELSE}TArray<string>{$IFEND};
            const AGrantResults: {$IF CompilerVersion >= 35.0}TClassicPermissionStatusDynArray{$ELSE}TArray<TPermissionStatus>{$IFEND})
                  begin
                  end);
          end;
          {$ELSE}
          {$ENDIF}
      {$ELSE}
      {$ENDIF}






      {$IFDEF HAS_GPSLOCATION}
//      //是否需要启动定位
//      if GlobalIsNeedGPSLocation then
//      begin
//        //启动定位
//        tmrStartLocation.Enabled:=True;
//      end;
//      {$ELSE}
//      if GlobalGPSLocation=nil then
//      begin
//        GlobalGPSLocation:=TGPSLocation.Create(nil);
//      end;
      if GlobalGPSLocation=nil then
      begin
        //启动定位
        GlobalGPSLocation:=TGPSLocation.Create(nil);
        GlobalGPSLocation.GPSType:=gtGCJ02;

        GlobalGPSLocation.Clear;

        GlobalGPSLocation.OnLocationChange:=Self.DoGPSLocation_LocationChange;
        GlobalGPSLocation.OnLocationTimeout:=Self.DoGPSLocation_LocationTimeout;
        GlobalGPSLocation.OnStartError:=Self.DoGPSLocation_StartError;


        GlobalGPSLocation.OnAddrChange:=Self.DoGPSLocation_AddrChange;
        GlobalGPSLocation.OnGeocodeAddrError:=Self.DoGPSLocation_GeocodeAddrError;
        GlobalGPSLocation.OnGeocodeAddrTimeout:=Self.DoGPSLocation_GeocodeAddrTimeout;

        GlobalGPSLocation.LocationChanged:=False;
      end;
      {$ENDIF}





      //加载上次登录的用户名和密码,以及服务器地址
      GlobalManager.Load;
      //自动还是用户自己选?
      //目前用户自己选
//      LangKind:=GlobalManager.LangKind;
      CustomLoadedGlobalManager;




      //设置服务器
      OutputDebugString('OrangeUI TfrmMain.FormShow 2');
      //从配置文件加载服务器配置
      SyncServerSetting(GlobalManager.ServerHost,GlobalManager.ServerPort);

      //在这里下面才能访问接口



      if (AppID<>'') and (Const_CenterServerHost<>'') then
      begin
        //获取开放平台的应用信息
        if GlobalIsNeedGetAppInfo then
        begin
          //为什么要登陆成功才获取APP信息?
          //获取APP基本信息
          tteGetApp.Run();
        end;
      end;





      CurrentVersion:='1.0.0';
      {$IFDEF ANDROID}
      //获取Android下面版本,升级检测版本需要使用
      CurrentVersion:=GetAndroidAppVersionName;
      {$ENDIF}
      {$IFDEF IOS}
      //获取IOS下面版本,在关于页面显示需要使用
      CurrentVersion:=GetIOSBundleKey('CFBundleVersion');
      {$ENDIF}





      OutputDebugString('OrangeUI TfrmMain.FormShow 3');


      //显示登陆界面
      //1、上次登录的账户的密码被清除(退出登录)
      //2、第一次安装App(ini文件不存在)
      //3、ini中未找到UserFid
      GlobalManager.LoadUserConfig;


      OutputDebugString('OrangeUI TfrmMain.FormShow 4');









      {$IFDEF HAS_PUSHNOTIFICATION}


          //  {$IFDEF USE_FCM_PUSH}
          //  //谷歌FCM推送配置,国外需要,外卖项目需要
          //  uBasePush.DefaultFcmPushProjectId:=Const_FcmPush_ProjectId;
          //  uBasePush.DefaultFcmPushApiKey:=Const_FcmPush_ApiKey;
          //  uBasePush.DefaultFcmPushApplicationId:=Const_FcmPush_ApplicationId;
          //  uBasePush.DefaultFcmPushDatabaseUrl:=Const_FcmPush_DatabaseUrl;
          //  uBasePush.DefaultFcmPushGcmSenderId:=Const_FcmPush_GcmSenderId;
          //  {$ENDIF USE_FCM_PUSH}
          //
          //
          //
          //  //个推参数配置
          //  uBasePush.DefaultGetuiPushAppId:=Const_GetuiPush_AppId;
          //  uBasePush.DefaultGetuiPushAppSecret:=Const_GetuiPush_AppSecret;
          //  uBasePush.DefaultGetuiPushAppKey:=Const_GetuiPush_AppKey;



            //HAS_XIAOMIPUSH;HAS_HUAWEIPUSH
            //没有说明要使用小米推送
            {$IFDEF HAS_XIAOMIPUSH}
            GlobalIsEnableXiaoMiPush:=True;
            {$ELSE}
            GlobalIsEnableXiaoMiPush:=False;
            {$ENDIF}
            //没有说明要使用华为推送
            {$IFDEF HAS_HUAWEIPUSH}
            GlobalIsEnableHuaweiPush:=True;
            {$ELSE}
            GlobalIsEnableHuaweiPush:=False;
            {$ENDIF}



            //启动推送
            //创建推送
            FPushClientRestImpl:=TPushClientRestImpl.Create;
      {$ENDIF}







      OutputDebugString('OrangeUI TfrmMain.FormShow 5');







//      //if DirectoryExists('C:\MyFiles') then
//      begin
//        //Exit;
//      end;
 


      //自动登录
      //上次登录过,那么需要自动登录
      if not GlobalIsAlwaysNeedLogin
        and (uManager.GlobalManager.LastLoginKey<>'')
        and (uManager.GlobalManager.IsLogin=True) then
      begin
          OutputDebugString('OrangeUI TfrmMain.FormShow 5.1');


          //自动登录,先显示主界面,不需要效果
          HideFrame;//(CurrentFrame,hfcttBeforeShowFrame);
          DoShowMainFrame;
//          ShowFrame(TFrame(GlobalMainFrame),TFrameMain,frmMain,nil,nil,nil,Application,True,True);//,ufsefNone);
          //{$IFDEF CLIENT_APP}
          //客户端直接获取首页
          GlobalMainFrame.Login(False);
          //{$ENDIF}


          OutputDebugString('OrangeUI TfrmMain.FormShow 5.2');


          //{$IFDEF EMP_APP}
          //PC端直接获取首页
          //GlobalMainFrame.Login;
          //{$ENDIF}


          //放在Timer中自动登录,不然等待框卡，不会居中
          Self.tmrAutoLogin.Enabled:=True;

      end
      else
      begin
          //上次没有登陆过

          if GlobalIsNeedLoginThenShowMainFrame then
          begin
              //需要登陆
              ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application,True,True,ufsefNone);
              GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
              GlobalLoginFrame.btnReturn.Visible:=False;

          end
          else
          begin
              //客户端
              if APPUserType=utClient then
              begin
                {$IFDEF HAS_GUIDEFRAME}
                //没有显示过向导页面
                if not GlobalManager.IsShowedGuideFrame then
                begin
                  GlobalManager.IsShowedGuideFrame:=True;
                  GlobalManager.Save;

                  //存在向导页面GuideFrame
                  ShowFrame(TFrame(GlobalGuideFrame),TFrameGuide,frmMain,nil,nil,nil,Application,True,True,ufsefNone);
                  GlobalGuideFrame.Load;
                end
                else
                begin
//                  ShowFrame(TFrame(GlobalMainFrame),TFrameMain,frmMain,nil,nil,nil,Application,True,True);//,ufsefNone);
                  DoShowMainFrame;
                  GlobalMainFrame.Login;
                end;
                {$ELSE}
                //直接显示主界面,不需要登录
//                ShowFrame(TFrame(GlobalMainFrame),TFrameMain,frmMain,nil,nil,nil,Application,True,True);//,ufsefNone);
                DoShowMainFrame;
                GlobalMainFrame.Login(False);
                {$ENDIF}

              end;

              //商户端
              if APPUserType=utShop then
              begin
                //显示登录界面
                ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application,True,True,ufsefNone);
                if AppID='1004' then
                begin
                  GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
                end;
              end;

              //骑手端
              if APPUserType=utRider then
              begin
                //显示登录界面,不需要效果
                ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application,True,True,ufsefNone);
                if AppID='1004' then
                begin
                  GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
                end;
              end;

              //员工
              if APPUserType=utEmp then
              begin
                //显示登录界面
                ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application,True,True,ufsefNone);
              end;
          end
      end;

      OutputDebugString('OrangeUI TfrmMain.FormShow 6');






      OutputDebugString('OrangeUI TfrmMain.FormShow End'+' ThreadID:'+IntToStr(TThread.CurrentThread.ThreadID));




    //  {$IFDEF MSWINDOWS}//测试
    //      GlobalVersionChecker.IsGooglePlayVersion:=GlobalIsGooglePlayVersion;
    //      //仅在Android下检查新版本,要放在SyncServerSetting后面,因为要先加载升级服务器
    //      //不然升级不了
    //      GlobalVersionChecker.CheckNewVersion;
    //  {$ENDIF MSWINDOWS}




      {$IFDEF HAS_AUTOUPDATE}

        //升级版本的线程调用放在最后面,以免影响其他接口调用的速度
        {$IFDEF ANDROID}
            GlobalVersionChecker.IsGooglePlayVersion:=GlobalIsGooglePlayVersion;
        {$ENDIF}

        if Const_AppUpdateINIUrl<>'' then
        begin
           GlobalVersionChecker.//CheckNewVersion(AppUpdateServerUrl,ImageHttpServerUrl);
                              CheckNewVersionByIni(Const_AppUpdateINIUrl,
                                                  '');
        end
        else
        begin
          if (Const_APPEnName<>'') and (AppUpdateServerUrl<>'') then
          begin
            GlobalVersionChecker.//CheckNewVersion(AppUpdateServerUrl,ImageHttpServerUrl);
                                CheckNewVersionByIni(AppUpdateServerUrl+'/Upload/'+Const_APPEnName+'/'+'Update/'+AppUserTypeName+'/'+'Version.ini',
                                                    AppUpdateServerUrl+'/Upload/'+Const_APPEnName+'/'+'Update/'+APPUserTypeName);
          end;
        end;
      {$ENDIF}


  except
    on E:Exception do
    begin
      FMX.Types.Log.d('OrangeUI TfrmMain.FormShow '+E.Message);
    end;
  end;

end;

procedure TfrmMain.FormTouch(Sender: TObject; const Touches: TTouches;
  const Action: TTouchAction);
begin
  //可能是放大缩小的手势
  if (Length(Touches)=2) then
  begin
    gFormTouch1:=Touches[0].Location;
    gFormTouch2:=Touches[1].Location;
  end;
  gFormTouchCount:=Length(Touches);
  ProcessFormTouch(Sender,Touches,Action);

end;

procedure TfrmMain.FormVirtualKeyboardHidden(Sender: TObject;KeyboardVisible: Boolean; const Bounds: TRect);
begin
//  FMX.Types.Log.d('OrangeUI TfrmMain.FormVirtualKeyboardHidden ');
//  CallSubFrameVirtualKeyboardHidden(Sender,Self,KeyboardVisible,Bounds);
end;

procedure TfrmMain.FormVirtualKeyboardShown(Sender: TObject;KeyboardVisible: Boolean; const Bounds: TRect);
begin
//  FMX.Types.Log.d('OrangeUI TfrmMain.FormVirtualKeyboardShown ');
//  CallSubFrameVirtualKeyboardShown(Sender,Self,KeyboardVisible,Bounds);
end;

procedure TfrmMain.frmOrangeQRCodeScanFormResult(Sender: TObject; AResult,
  AFormat: string; var AIsCanContinue: Boolean);
begin
  frmOrangeQRCodeScanResult(Sender,AResult,AFormat);
end;

procedure TfrmMain.frmOrangeQRCodeScanResult(Sender: TObject; AResult,
  AFormat: string);
begin
  ccbsBarCodeScanComletedCallbackEvent(Sender,0,AResult);
end;

function TfrmMain.GetScanTips: String;
begin
  Result := '将二维码放入框内，即可自动扫描';
end;

function TfrmMain.GetScanTitle: String;
begin
  Result := '二维码扫描';
end;

function TfrmMain.GetApplicationIconBadgeNumber: Integer;
begin
  Result:=0;
  if GlobalManager<>nil then
  begin
    Result:=GlobalManager.User.notice_unread_count;
  end;
end;

procedure TfrmMain.GetUserNoticeUnReadCount;
begin
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                 DoGetUserNoticeUnReadCountExecute,
                 DoGetUserNoticeUnReadCountExecuteEnd,
                 'GetUserNoticeUnReadCount');
end;

procedure TfrmMain.IMLoginSucc;
begin

end;

procedure TfrmMain.LoginShowMainFrame(AIsAutoLogin:Boolean);
begin
  FMX.Types.Log.d('OrangeUI TfrmMain.LoginShowMainFrame Begin');







  //手动登录的情况下,要先显示主界面
  if Not AIsAutoLogin then
  begin

//      {$IFDEF CLIENT_APP}
//      //释放原主界面
//      uFuncCommon.FreeAndNil(GlobalMainFrame);
//
//      //显示主界面
//      ShowFrame(TFrame(GlobalMainFrame),TFrameMain,frmMain,nil,nil,nil,Application,True,True);//,ufsefNone);
//      GlobalMainFrame.Login;
//      {$ENDIF}
//
//
//      {$IFDEF RIDER_APP}



//      //骑手端登录
//      //释放原主界面
//      FMX.Types.Log.d('OrangeUI TfrmMain.LoginShowMainFrame FreeAndNil(GlobalMainFrame)');
//      try
//        uFuncCommon.FreeAndNil(GlobalMainFrame);
//      except
//      end;


      FMX.Types.Log.d('OrangeUI TfrmMain.LoginShowMainFrame ShowFrame(GlobalMainFrame)');
      //显示主界面
      HideFrame;//(CurrentFrame,hfcttBeforeShowFrame);
//      ShowFrame(TFrame(GlobalMainFrame),TFrameMain,frmMain,nil,nil,nil,Application,True,True);//,ufsefNone);
      DoShowMainFrame;
      FMX.Types.Log.d('OrangeUI TfrmMain.LoginShowMainFrame GlobalMainFrame.Login');
      GlobalMainFrame.Login(True);


//      {$ENDIF}
//
//
//      {$IFDEF SHOP_APP}
//      //商家端登录
//      //释放原主界面
//      uFuncCommon.FreeAndNil(GlobalMainFrame);
//      //显示主界面
//      HideFrame;//(CurrentFrame,hfcttBeforeShowFrame);
//      ShowFrame(TFrame(GlobalMainFrame),TFrameMain,frmMain,nil,nil,nil,Application);
//      GlobalMainFrame.Login;
//      {$ENDIF}
//
//
//
//      {$IFDEF EMP_APP}
//      //员工端登录
//      //释放原主界面
//      uFuncCommon.FreeAndNil(GlobalMainFrame);
//      //显示主界面
//      HideFrame;//(CurrentFrame,hfcttBeforeShowFrame);
//      ShowFrame(TFrame(GlobalMainFrame),TFrameMain,frmMain,nil,nil,nil,Application);
//      GlobalMainFrame.Login;
//      {$ENDIF}

  end
  else
  begin

      //自动登陆的话,MainFrame已经显示了
      FMX.Types.Log.d('OrangeUI TfrmMain.LoginShowMainFrame GlobalMainFrame.Login');
      GlobalMainFrame.Login(True);

  end;


  //要放在这里,推送的APPID和服务器IP需要在这里才能被确定
  {$IFDEF HAS_PUSHNOTIFICATION}
      FMX.Types.Log.d('OrangeUI TfrmMain.LoginShowMainFrame Start Push Begin');


//        //一定要设置
//        //当前的服务器接口地址
//        FPushClientRestImpl.PushServerUrl:=PushManageInterfaceUrl;
//        //当前的APP
//        FPushClientRestImpl.AppID:=(AppID);
//        FPushClientRestImpl.AppType:=Const_GetuiPush_AppType;
//        //wn
//        FPushClientRestImpl.UserFID:=GlobalManager.User.fid;
        //设置实现方法
        FPushClientRestImpl.FBasePush.OnIOSRecvAPNSPushNotification:=Self.DoBasePushIOSRecvAPNSNotification;
        FPushClientRestImpl.FBasePush.OnClickNotificationMsg:=Self.ClickPushNotification;



        //启动推送
        {$IF DEFINED(ANDROID)}

           {$IFDEF HAS_GETUIPUSH}
            //个推推送
            if FPushClientRestImpl.FBasePush is TGetuiPush then
            begin
              TGetuiPush(FPushClientRestImpl.FBasePush).AppID:=Const_GetuiPush_AppId;
              TGetuiPush(FPushClientRestImpl.FBasePush).AppKey:=Const_GetuiPush_AppKey;
              TGetuiPush(FPushClientRestImpl.FBasePush).AppSecret:=Const_GetuiPush_AppSecret;
            end;
            {$ENDIF}

            {$IFDEF HAS_XIAOMIPUSH}
            //小米推送
            if FPushClientRestImpl.FBasePush is TXiaomiPush then
            begin
              TXiaomiPush(FPushClientRestImpl.FBasePush).AppID:=Const_XiaomiPush_AppId;
              TXiaomiPush(FPushClientRestImpl.FBasePush).AppKey:=Const_XiaomiPush_AppKey;
            end;
            {$ENDIF}


            FPushClientRestImpl.FBasePush.Start;
        {$ENDIF}




        {$IFDEF IOS}
            {$IFNDEF CPUX86}//非IOS模拟器,IOS真机


            {$IFDEF HAS_GETUIPUSH}
            //个推推送
            if FPushClientRestImpl.FBasePush is TGetuiPush then
            begin
              TGetuiPush(FPushClientRestImpl.FBasePush).AppID:=Const_GetuiPush_AppId;
              TGetuiPush(FPushClientRestImpl.FBasePush).AppKey:=Const_GetuiPush_AppKey;
              TGetuiPush(FPushClientRestImpl.FBasePush).AppSecret:=Const_GetuiPush_AppSecret;
            end;
            {$ENDIF}


            FPushClientRestImpl.FBasePush.Start;
//              {$IFNDEF HAS_GETUIPUSH}
//              if FPushClientRestImpl.FBasePush is TIOSAPNSPush then
//              begin
                GlobalClickRemoteNotificationInNotificationCenterEvent:=FPushClientRestImpl.FBasePush.ClickRemoteNotificationInNotificationCenter;
//              end;
//              {$ENDIF}
            {$ENDIF}
        {$ENDIF}
      //  {$IFDEF MSWINDOWS}
      //  //Windows下面模拟注册推送
      //  //绑定用户和ClientID
      //  FPushClientRestImpl.BindUserAndBasePush;
      //  {$ENDIF}


      FMX.Types.Log.d('OrangeUI TfrmMain.LoginShowMainFrame Start Push End');
  {$ENDIF}



  FMX.Types.Log.d('OrangeUI TfrmMain.LoginShowMainFrame End');

end;

procedure TfrmMain.Logout;
begin


  GlobalManager.Logout;



  {$IFDEF HAS_PUSHNOTIFICATION}
  //停止推送,其实是不需要停止的,在IOS下发面停止了推送之后,再开启推送还是收不到推送
  Self.FPushClientRestImpl.StopBasePush;
  {$ENDIF}


  //停止刷新个人信息,清除密码,
  if GlobalMainFrame<>nil then
  begin
    GlobalMainFrame.Logout;
  end;


  tmrSyncBadge.Enabled:=False;

end;

procedure TfrmMain.OnModalResultFromNetConnectionFailInAutoLogin(Frame: TObject);
begin
  //登录失败  手动登陆
  ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application,True,True,ufsefNone);
end;


//procedure TfrmMain.OnWeiXinBindingExecute(ATimerTask: TObject);
//begin
//  //出错
//  TTimerTask(ATimerTask).TaskTag:=1;
//
//  try
//
//    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('bind_thirdparty_account',
//                                                    nil,
//                                                    UserCenterInterfaceUrl,
//                                                    ['appid',
//                                                    'user_fid',
//                                                    'key',
//                                                    'wx_open_id',
//                                                    'wx_auth_token'],
//                                                    [AppID,
//                                                    GlobalManager.User.fid,
//                                                    GlobalManager.User.key,
//                                                    Self.FWxOpenID,
//                                                    Self.FWxAuthToken],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//                                                    );
//    if TTimerTask(ATimerTask).TaskDesc<>'' then
//    begin
//      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
//    end;
//
//
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
//
//
//end;
//
//procedure TfrmMain.OnWeiXinBindingExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//  I: Integer;
//begin
//
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//        //绑定成功
//        ShowHintFrame(nil,Trans('微信绑定成功!'));
//      end
//      else
//      begin
//        //绑定失败
//        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;
//
//    end
//    else if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//    end;
//  finally
//    HideWaitingFrame;
//  end;
//end;
//
//procedure TfrmMain.OnWeiXinLoginExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//  I: Integer;
//begin
//
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//        GlobalManager.User.ParseFromJson(ASuperObject.O['Data'].A['User'].O[0]);
//
//        //登录令牌,用于确认用户已经登录
//        GlobalManager.User.key:=ASuperObject.O['Data'].S['Key'];
//
//
////        //登录成功
////        uManager.GlobalManager.LastLoginUser:=Self.FOpenID;
////        uManager.GlobalManager.LastLoginPass:=FLoginPassword;
//        //登录状态
//        uManager.GlobalManager.IsLogin:=True;
//        //登录类型
//        uManager.GlobalManager.LastLoginType:=Const_RegisterLoginType_WeiXin;
////        //添加上次登录的用户
////        if uManager.GlobalManager.LoginedUserList.IndexOf(FLoginUser)=-1 then
////        begin
////          uManager.GlobalManager.LoginedUserList.Add(FLoginUser);
////        end
////        else
////        begin
////          uManager.GlobalManager.LoginedUserList.Move(
////                                          uManager.GlobalManager.LoginedUserList.IndexOf(FLoginUser),
////                                              uManager.GlobalManager.LoginedUserList.Count-1);
////
////        end;
////
////        uManager.GlobalManager.Save;
////
////
////        uManager.GlobalManager.SaveLastLoginInfo;
////        //加载上次登录用户的信息
////        uManager.GlobalManager.LoadUserConfig;
////
////        //释放原主界面
////        uFuncCommon.FreeAndNil(GlobalMainFrame);
//
//        //显示主界面
////        HideFrame;//(Self,hfcttBeforeShowFrame);
//        ShowFrame(TFrame(GlobalMainFrame),TFrameMain,frmMain,nil,nil,nil,Application,True,True);//,ufsefNone);
//        GlobalMainFrame.FrameHistroy:=CurrentFrameHistroy;
////
////        Self.Login;
//
//
//
////        GlobalVersionChecker.CheckNewVersion;
//
//      end
//      else
//      begin
//        //登录失败
//        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;
//
//    end
//    else if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//    end;
//  finally
//    HideWaitingFrame;
//  end;
//end;

//procedure TfrmMain.OnWeiXinnotBindingExecute(ATimerTask: TObject);
//begin
//  //出错
//  TTimerTask(ATimerTask).TaskTag:=1;
//
//  try
//
//    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('unbind_thirdparty_account',
//                                                    nil,
//                                                    UserCenterInterfaceUrl,
//                                                    ['appid',
//                                                    'user_fid',
//                                                    'key',
//                                                    'account_type'],
//                                                    [AppID,
//                                                    GlobalManager.User.fid,
//                                                    GlobalManager.User.key,
//                                                    Const_RegisterLoginType_WeiXin],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//                                                    );
//    if TTimerTask(ATimerTask).TaskDesc<>'' then
//    begin
//      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
//    end;
//
//
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
//
//end;
//
//procedure TfrmMain.OnWeiXinnotBindingExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//  I: Integer;
//begin
//
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//        //解除绑定成功
//        ShowHintFrame(nil,Trans('微信解绑成功!'));
//      end
//      else
//      begin
//        //解除绑定失败
//        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;
//
//    end
//    else if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//    end;
//  finally
//    HideWaitingFrame;
//  end;
//end;

procedure TfrmMain.OnModalResultFromLoginErrorInAutoLogin(Frame: TObject);
begin
  //登录失败  手动登陆
  ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application,True,True,ufsefNone);
  //清除密码输入框
  GlobalLoginFrame.ClearPass;
  GlobalLoginFrame.Clear();
  GlobalLoginFrame.btnReturn.Visible:=False;
end;

  {$IFDEF HAS_GPSLOCATION}

procedure TfrmMain.DoGPSLocation_AddrChange(Sender: TObject);
begin
  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_AddrChange Begin');

  TThread.Synchronize(nil,procedure
  begin
    if GlobalMainFrame<>nil then
    begin
      GlobalMainFrame.DoLocationAddrChange;
    end;
  end);

  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_AddrChange End');
end;

procedure TfrmMain.DoGPSLocation_LocationChange(Sender: TObject);
begin
  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_LocationChange Begin');

  if GlobalGPSLocation<>nil then
  begin
      TThread.Synchronize(nil,procedure
      begin
        Self.lblGPSLocation.Text:=FloatToStr(GlobalGPSLocation.Longitude)+','+FloatToStr(GlobalGPSLocation.Latitude);
        if GlobalMainFrame<>nil then
        begin
          GlobalMainFrame.DoLocationChange;
        end;
      end);
  end
  else
  begin
      OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_LocationChange GlobalGPSLocation=nil');
  end;
  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_LocationChange End');

end;

procedure TfrmMain.DoGPSLocation_GeocodeAddrError(Sender: TObject);
begin
  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_GeocodeAddrError Begin');

  TThread.Synchronize(nil,procedure
  begin
    if GlobalMainFrame<>nil then
    begin
      GlobalMainFrame.DoGeocodeAddrError;
    end;
  end);

  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_GeocodeAddrError End');
end;

procedure TfrmMain.DoGPSLocation_GeocodeAddrTimeout(Sender: TObject);
begin
  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_GeocodeAddrTimeout Begin');

  TThread.Synchronize(nil,procedure
  begin
    if GlobalMainFrame<>nil then
    begin
      GlobalMainFrame.DoGeocodeAddrTimeout;
    end;
  end);

  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_GeocodeAddrTimeout End');
end;

procedure TfrmMain.DoGPSLocation_LocationTimeout(Sender: TObject);
begin
  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_LocationTimeout Begin');

  TThread.Synchronize(nil,procedure
  begin
    Self.lblGPSLocation.Text:='定位超时';
    if GlobalMainFrame<>nil then
    begin
      GlobalMainFrame.DoLocationTimeout;
    end;
  end);

  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_LocationTimeout End');
end;

procedure TfrmMain.DoGPSLocation_StartError(Sender: TObject);
begin
  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_StartError Begin');

  TThread.Synchronize(nil,procedure
  begin
    Self.lblGPSLocation.Text:='定位启动失败';
    if GlobalMainFrame<>nil then
    begin
      GlobalMainFrame.DoLocationStartError;
    end;
  end);
  OutputDebugString('OrangeUI TfrmMain.DoGPSLocation_StartError End');

end;
  {$ENDIF}



procedure TfrmMain.DoModalResultFromOpenGPSMessageBox(
  AMessageBoxFrame: TObject);
begin
  if (TFrameMessageBox(AMessageBoxFrame).ModalResult='确定')
    or (TFrameMessageBox(AMessageBoxFrame).ModalResult='已开启') then
  begin
    Self.StartGPSLocation;
  end;
end;

procedure TfrmMain.DoModalResultFromRequestLocationPermissionMessageBox(
  AMessageBoxFrame: TObject);
begin
  if (TFrameMessageBox(AMessageBoxFrame).ModalResult='确定')
    or (TFrameMessageBox(AMessageBoxFrame).ModalResult='去开启') then
  begin
    {$IFDEF ANDROID}
    {$IFDEF HAS_GPSLOCATION}
    //跳转到应用的权限设置页
    TJPermissionPageManagement.JavaClass.goToSetting(TAndroidHelper.Activity);
    {$ENDIF}
    {$ENDIF}
  end;
end;

{$IFDEF HAS_PAGESTRUCTURE}
procedure TfrmMain.DoMainProgramSettingCustomProcessPageAction(Sender: TObject;
  APageInstance: TPageInstance; AAction: String;
  AFieldControlSettingMap: TFieldControlSettingMap; var AIsProcessed: Boolean);
begin

end;

function TfrmMain.DoPageFrameworkDataSourceGetDrawPicture(AImageName: String;
  var AIsGeted: Boolean): TDrawPicture;
begin

end;

function TfrmMain.DoPageFrameworkDataSourceGetParamValue(AValueFrom,
  AParamName: String; var AIsGeted: Boolean): Variant;
begin
  if AParamName='$appid' then
  begin
    Result:=AppID;
    AIsGeted:=True;
  end;
  if AParamName='$user_fid' then
  begin
    Result:=GlobalManager.User.fid;
    AIsGeted:=True;
  end;
  if AParamName='$key' then
  begin
    Result:=GlobalManager.LastLoginKey;
    AIsGeted:=True;
  end;
end;

procedure TfrmMain.DoPageFrameworkDataSourceSetParamValue(AValueFrom,
  AParamName: String; AValue: Variant; var AIsSeted: Boolean);
begin

end;
{$ENDIF}


function TfrmMain.DoTimerThreadCanExecute(Sender: TObject): Boolean;
begin
  Result:=True;
  {$IFDEF IOS}

  {$ENDIF}
end;

procedure TfrmMain.DoModalResultFromUseNewServerMessageBoxFrame(
  AMessageBoxFrame: TObject);
begin
  if TFrameMessageBox(AMessageBoxFrame).ModalResult='确定' then
  begin

    //服务器
    GlobalManager.ServerHost:=GlobalManager.AppJson.S['server'];
    //端口
    if GlobalManager.AppJson.I['port']<>0 then
    begin
      GlobalManager.ServerPort:=GlobalManager.AppJson.I['port'];
    end;

    //保存
    GlobalManager.Save;



    //更新客户端连接
    frmMain.SyncServerSetting(GlobalManager.ServerHost,GlobalManager.ServerPort);


  end;

end;

procedure TfrmMain.DoShowMainFrame;
begin
  ShowFrame(TFrame(GlobalMainFrame),TFrameMain,frmMain,nil,nil,nil,Application);//,True,True);//,ufsefNone);
end;

procedure TfrmMain.ccbsBarCodeScanComletedCallbackEvent(Sender: TObject;
  const ResultCode: Integer; const ResultString: string);
var
  AResultString:String;
begin
  OutputDebugString('OrangeUI TfrmMain.ccbsBarCodeScanComletedCallbackEvent End');
//  Self.pnlToolBar.Caption := '[' + formatdatetime('HH:mm:ss', now) + ']' + ResultString;

  if Assigned(FScanCodeResult) then
  begin
    FScanCodeResult(Self,ResultString);
    Exit;
  end;

  AResultString:=ResultString;

  if GlobalManager.IsLogin
    and (
       (LowerCase(AResultString.Substring(0,7))='http://')
    or (LowerCase(AResultString.Substring(0,8))='https://')
    or (LowerCase(AResultString.Substring(0,4))='www.')
        ) then
  begin
      //要加当前登录账号的UUID
      if AResultString.IndexOf('?')>=0 then
      begin
        AResultString:=AResultString+'&app_user_uuid='+GlobalManager.User.fid;
      end
      else
      begin
        AResultString:=AResultString+'?app_user_uuid='+GlobalManager.User.fid;
      end;
  end;




//  //是网页
//  //网页链接
//  HideFrame;
//  //显示网页界面
//  ShowFrame(TFrame(GlobalWebBrowserFrame),TFrameWebBrowser);
//  GlobalWebBrowserFrame.LoadUrl(AResultString);
  OpenWebBrowserAndNavigateURL(AResultString);


  FMX.Types.Log.d('OrangeUI Result:'+AResultString);

end;

procedure TfrmMain.ClickPushNotification(Sender:TObject;ATitle:String;ABody:String;APayload:String;AIsAtBackground:Boolean;AIsStartup:Boolean);
var
  AUserCustomJson:ISuperObject;
begin
  AUserCustomJson:=TSuperObject.Create(APayload);
  if GlobalMainFrame<>nil then
  begin
    GlobalMainFrame.ClickPushNotification(
                                          AUserCustomJson,
                                          ATitle,
                                          ABody,
                                          AIsAtBackground);
  end;

//  Self.tmrSyncBadgeTimer(nil);

end;

procedure TfrmMain.CustomLoadedGlobalManager;
begin
  //

end;

function TfrmMain.CustomLoadFromINI: Boolean;
var
  AappThemeColor: String;
begin

  try
    try
      {$IFDEF MSWINDOWS}
        FmyIniFile := TIniFile.Create(GetApplicationPath + 'Config.ini');
      {$ELSE}
        FmyIniFile := TIniFile.Create(GetApplicationPath + 'Config.ini', TEncoding.UTF8);
      {$ENDIF}

      AappThemeColor := FmyIniFile.ReadString('', 'appThemeColor', '');

      if AappThemeColor <> '' then
      begin
        dmCommonImageDataMoudle.SkinTheme1.NavigationBarColor:= WebHexToColor(AappThemeColor);
        dmCommonImageDataMoudle.SkinTheme1.SkinThemeColor:= WebHexToColor(AappThemeColor);
      end;

    except
      on E:Exception do
      begin
        OutputDebugString('OrangeUI TfrmMain.CustomLoadFromINI Error:'+E.Message);
      end;
    end;
  finally
    FmyIniFile.Free;
  end;
  Result:=True;

end;

{$IFDEF HAS_ORANGESCANCODE}
procedure TfrmMain.CustomSettingOrangeScanCodeForm(AOrangeScanCodeForm:TOrangeScanCodeForm);
begin

end;
{$ENDIF HAS_ORANGESCANCODE}

function TfrmMain.DoApplicationEventHandler(AAppEvent: TApplicationEvent;AContext: TObject): Boolean;
begin

//    {$IFDEF ANDROID}
//  if GlobalIOSStatusBarFontColor=TAlphaColorRec.White then
//  begin
      case AAppEvent of
        TApplicationEvent.BecameActive:
        begin
          //转到前台
          //要注意的就是每次从后台返回APP的时候，要重新调用下。
          //设置任务栏字体为黑色
          //FMX.StatusBar.StatusBarLight(True);

          tmrSetStatusBarLight.Enabled:=True;
        end;
        TApplicationEvent.EnteredBackground:
        begin
          //转到后台

          tmrSetStatusBarLight.Enabled:=False;
        end;
      end;
//  end;
//    {$ENDIF ANDROID}


  case AAppEvent of
    TApplicationEvent.FinishedLaunching:
    begin
       //程序第一次启动结束
      HandleException(nil,'FinishedLaunching');
      GlobalApplicationState:=TApplicationEvent.FinishedLaunching;

    end;
    TApplicationEvent.BecameActive:
    begin
      //转到前台
      HandleException(nil,'BecameActive');
      GlobalApplicationState:=TApplicationEvent.BecameActive;

//      //更新推送前后台状态
//      {$IFDEF IOS}
//      if GlobalManager.User.fid<>'' then
//      begin
//        FPushClientRestImpl.UpdatePushIsAtBackground(False);
//      end;
//      {$ENDIF}

    end;
    TApplicationEvent.WillBecomeInactive:
    begin
      HandleException(nil,'WillBecomeInactive');
      GlobalApplicationState:=TApplicationEvent.WillBecomeInactive;

    end;
    TApplicationEvent.EnteredBackground:
    begin
      //转到后台
      HandleException(nil,'EnteredBackground');
      GlobalApplicationState:=TApplicationEvent.EnteredBackground;

//      //更新推送前后台状态
//      {$IFDEF IOS}
//      if GlobalManager.User.fid<>'' then
//      begin
//        FPushClientRestImpl.UpdatePushIsAtBackground(True);
//      end;
//      {$ENDIF}

    end;
    TApplicationEvent.WillBecomeForeground:
    begin
      HandleException(nil,'WillBecomeForeground');
      GlobalApplicationState:=TApplicationEvent.WillBecomeForeground;
    end;
    TApplicationEvent.WillTerminate:
    begin
      HandleException(nil,'WillTerminate');
      GlobalApplicationState:=TApplicationEvent.WillTerminate;
    end;
    TApplicationEvent.LowMemory:
    begin
      HandleException(nil,'LowMemory');
    end;
    TApplicationEvent.TimeChange:
    begin

    end;
    TApplicationEvent.OpenURL:
    begin
//      {$IFDEF IOS}
//      FBLoginManager.DoApplicationEvent(AContext);
//      {$ENDIF}
    end;
  end;

end;

procedure TfrmMain.ScanQRCode(AScanCodeResult:TScanCodeResultEvent=nil);
begin

  FMX.Types.Log.d('OrangeUI TFrameMain.ScanQRCode');
  FScanCodeResult:=AScanCodeResult;

//      {$IFDEF IOS}
//          //苹果
//          if frmiOSQRCodeScan=nil then
//          begin
//            frmiOSQRCodeScan:=TfrmiOSQRCodeScan.Create(Application);
//          end;
//          frmiOSQRCodeScan.Show;
//          frmiOSQRCodeScan.StartScan;
//          frmiOSQRCodeScan.FOnScanResult:=frmOrangeQRCodeScanResult;
//      {$ELSE}
          {$IFDEF HAS_CCBARCODESCANNER}


                          {$IFDEF ANDROID}
                          //先要申请权限
                          PermissionsService.RequestPermissions([JStringToString(TJManifest_permission.JavaClass.CAMERA)],
                                //不能为nil,不然会闪退,RequestPermissions调用两次会闪退
                                procedure(const APermissions: {$IF CompilerVersion >= 35.0}TClassicStringDynArray{$ELSE}TArray<string>{$IFEND};
                                  const AGrantResults: {$IF CompilerVersion >= 35.0}TClassicPermissionStatusDynArray{$ELSE}TArray<TPermissionStatus>{$IFEND})
                                var
                                  I:Integer;
                                begin
                                    //如果允许获取相册,那么先获取,打开相册管理的速度会快一点
                                    for I := 0 to Length(AGrantResults)-1 do
                                    begin
                                      if (I=Length(AGrantResults)-1) and (AGrantResults[I]=TPermissionStatus.Granted) then
                                      begin
                                          //打开相机
                                          //安卓
                                          if ccbsBarCode=nil then
                                          begin
                                            ccbsBarCode:=TCCBarcodeScanner.Create(Self);
                                            ccbsBarCode.OnScanComletedCallbackEvent:=Self.ccbsBarCodeScanComletedCallbackEvent;
                                          end;


                                          //扫描二维码
                                          ccbsBarCode.SdkConfig.Scan_Title := GetScanTitle;//'二维码扫描';
                                          ccbsBarCode.SdkConfig.Scan_Tips := GetScanTips;//'将二维码放入框内，即可自动扫描';
                                          ccbsBarCode.SdkConfig.Vibrate := True;
                                          ccbsBarCode.SdkConfig.PlayVoice := False;
                                //          ccbsBarCode.SdkConfig.PlayVoice := True;
                                          ccbsBarCode.SdkConfig.ToastResult := True;

                                          ccbsBarCode.SdkConfig.Flashlight := False;

                                //          ccbsBarCode.SdkConfig

                                          self.ccbsBarCode.StartScan(); // 结果在事件中返回


                                  Break;
                                end;
                              end;
                          end);

                          {$ELSE}
                          //打开相机
                          if ccbsBarCode=nil then
                          begin
                            ccbsBarCode:=TCCBarcodeScanner.Create(Self);
                            ccbsBarCode.OnScanComletedCallbackEvent:=Self.ccbsBarCodeScanComletedCallbackEvent;
                          end;


                          //扫描二维码
                          ccbsBarCode.SdkConfig.Scan_Title := GetScanTitle;//'二维码扫描';
                          ccbsBarCode.SdkConfig.Scan_Tips := GetScanTips;//'将二维码放入框内，即可自动扫描';
                          ccbsBarCode.SdkConfig.Vibrate := True;
                          ccbsBarCode.SdkConfig.PlayVoice := False;
                //          ccbsBarCode.SdkConfig.PlayVoice := True;
                          ccbsBarCode.SdkConfig.ToastResult := True;

                          ccbsBarCode.SdkConfig.Flashlight := False;

                //          ccbsBarCode.SdkConfig

                          self.ccbsBarCode.StartScan(); // 结果在事件中返回

                          {$ENDIF}
          {$ELSE}
              {$IFDEF HAS_ORANGESCANCODE}
              if FOrangeScanCodeForm=nil then
              begin
                FOrangeScanCodeForm:=TOrangeScanCodeForm.Create(Self);
                FOrangeScanCodeForm.OnScanResult:=frmOrangeQRCodeScanFormResult;
                CustomSettingOrangeScanCodeForm(FOrangeScanCodeForm);
              end;
              FOrangeScanCodeForm.StartScan;
              {$ENDIF}
          {$ENDIF}


//      {$ENDIF}
//
//
//  {$ELSE}
//
//  ShowFrame(TFrame(GlobalQRCodeScannerFrame),TFrameQRCodeScanner//);
//        ,Application.MainForm,nil,nil,DoReturnFrameFromQRCodeScannerFrame,nil,True,
//        True,ufsefNone);
//  GlobalQRCodeScannerFrame.StartScan;
//
//  {$ENDIF}
end;

procedure TfrmMain.SyncServerSetting(AServer: String;APort: Integer);
begin
  //设置连接
  ServerHost:=AServer;



  //服务端接口地址
  InterfaceUrl:='http://'+AServer+':'+IntToStr(APort)+'/';
  //支持HTTPS
//  InterfaceUrl:='https://'+AServer+':'+IntToStr(443)+'/';




  UserCenterInterfaceUrl:=InterfaceUrl+'usercenter/';
  UserSuggectionUserCenterInterfaceUrl:=UserCenterInterfaceUrl;
  CaptchaCenterInterfaceUrl:=InterfaceUrl+'captcha/';
  ShopCenterInterfaceUrl:=InterfaceUrl+'shopcenter/';
  DeliveryCenterInterfaceUrl:=InterfaceUrl+'deliverycenter/';
  PayCenterInterfaceUrl:=InterfaceUrl+'paycenter/';
  AlipayCenterInterfaceUrl:=InterfaceUrl+'alipayservice/';
  PushManageInterfaceUrl:=InterfaceUrl+'pushmanage/';
  BasicDataManageInterfaceUrl:=InterfaceUrl+'basicdatamanage/';
  EvaluateCenterInterfaceUrl:=InterfaceUrl+'evaluatecenter/';
//  TeaEcologyInterfaceUrl:=InterfaceUrl+'tea_ecology/';
  ScoreCenterInterfaceUrl:=InterfaceUrl+'scorecenter/';
  IndianaCenterInterfaceUrl:=InterfaceUrl+'indianacenter/';
  //验证码
  CapchaInterfaceUrl:=InterfaceUrl+'capcha/';
  TableRestCenterInterfaceUrl:=InterfaceUrl+'tablecommonrest/';
  ProgramFrameworkRestCenterInterfaceUrl:=InterfaceUrl+'program_framework/';


  PromotionCenterInterfaceUrl:=InterfaceUrl+'promotioncenter/';
  TelCenterInterfaceUrl:=InterfaceUrl+'telcenter/';

  XFOlineRestServiceUrl:=InterfaceUrl+'xfonline/';

  FastmsgCenterInterfaceUrl:=InterfaceUrl+'fastmsg/';

  //图片上传下载地址
  ImageHttpServerUrl:='http://'+AServer+':'+IntToStr(APort+1);
//  //新版服务器才支持
//  ImageHttpServerUrl:=InterfaceUrl+'filemanage';


  //支持HTTPS
//  ImageHttpServerUrl:='https://'+AServer+':'+IntToStr(444);


  ContentCenterInterfaceUrl:=InterfaceUrl+'contentcenter/';


  //APP更新地址
  AppUpdateServerUrl:='http://'+AServer+':'+IntToStr(APort+1);

  PetchipInterfaceUrl:=InterfaceUrl+'petchip/';

//  CommonSyncServerSetting(AServer,APort);



  //授权服务器
  //可以使用其他的服务器
//  CenterInterfaceUrl:='http://'+CenterServerHost+':'+IntToStr(CenterServerPort)+'/';
  CenterInterfaceUrl:='http://'+Const_CenterServerHost+':'+IntToStr(Const_CenterServerPort)+'/';
end;

procedure TfrmMain.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
  //OCR拍照返回
  Image.SaveToFile(GetApplicationPath+'card.jpg');
  TThread.CreateAnonymousThread(procedure
  var
      ACard:String;
  begin
//      if not FHttpBaiduOCR.CarLicensePlate('E:\car_plate.jpeg',ACarPlate) then
      if not FHttpBaiduOCR.Basic(GetApplicationPath+'card.jpg',ACard) then
      begin
          TThread.Synchronize(nil,procedure
          begin
            ShowMessage('扫描不到名片!');
          end);

          Exit;
      end;

      TThread.Synchronize(nil,procedure
      begin
        ShowMessage(ACard);
      end);


  end).Start;

end;

procedure TfrmMain.tbDistanceChange(Sender: TObject);
begin
  Self.lblDistance.Text:=FloatToStr(Self.tbDistance.Value)+'米/秒';
end;

procedure TfrmMain.tmrAutoLoginTimer(Sender: TObject);
begin
  Self.tmrAutoLogin.Enabled:=False;


  //注释掉了,苹果手机上会卡
//  ShowWaitingFrame(frmMain,'自动登陆中...');
  //调用自动登录接口
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                                            DoAutoLoginExecute,
                                            DoAutoLoginExecuteEnd,
                                            'AutoLogin'
                                            );

end;

procedure TfrmMain.tmrSaveTranslateTimer(Sender: TObject);
begin

  Exit;

  {$IFDEF MSWINDOWS}
  //保存语言文件
  if FTranslateFilePath<>'' then
  begin
    //开发模式
    GlobalLang.SaveToFile(FTranslateFilePath);
  end;
  {$ENDIF}


  {$IFDEF MSWINDOWS}
  //保存语言文件
  if  (DirectoryExists('E:\MyFiles')
        or DirectoryExists('C:\MyFiles')) then
  begin
    //开发模式
    //保存到E:\MyFiles\OrangeUIProduct\外卖平台\APP\AppLang.lng
    GlobalLang.SaveToFile(GetApplicationPath
                              +'..'+PathDelim
                              +'..'+PathDelim
                              +'..'+PathDelim
                              +'..'+PathDelim
                              +'..'+PathDelim
                              +'OrangeUIAppFramework'+PathDelim
                              +'AppLang.lng');
  end
  else
  begin
    //供翻译人员翻译
    GlobalLang.SaveToFile('C:\'
                          +'AppLang.lng');
  end;
  {$ENDIF}


end;

procedure TfrmMain.tmrSetStatusBarLightTimer(Sender: TObject);
const
  //亮度
  MaxLightLuminance = 0.6;//5;
{$IFDEF IOS}
var
  AiOSWindowHandle:TiOSWindowHandle;
{$ENDIF}
begin
  //转到前台
  //要注意的就是每次从后台返回APP的时候，要重新调用下。
  //设置任务栏字体为黑色



  //Luminance值最大,越亮吗？
  //Luminance(TAlphaColorRec.White)=1
  //Luminance(TAlphaColorRec.Black)=0
  if Luminance(GetCurrentFrameToolBarColor) < MaxLightLuminance then
  begin
    //标题栏比较暗,比较黑
//    //Result := UIStatusBarStyleLightContent;
//    FMX.Types.Log.d('OrangeUI　TfrmMain.tmrSetStatusBarLightTimer UIStatusBarStyleLightContent');

    {$IFDEF ANDROID}
    FMX.StatusBar.StatusBarLight(False);//白色字体
    {$ENDIF}


    {$IFDEF IOS}
      GlobalStatusBarLuminance:=0;//0字体白
      //更新状态栏
      AiOSWindowHandle:=WindowHandleToPlatform(Handle);

      //在扫码打开的时候调用它会报错
      if AiOSWindowHandle.Wnd<>nil then
      begin
        AiOSWindowHandle.Wnd.rootViewController.setNeedsStatusBarAppearanceUpdate;
      end;
    {$ENDIF}

  end
  else
  begin
    //标题栏比较亮,比较变
    //Result := UIStatusBarStyleDefault;
//    FMX.Types.Log.d('OrangeUI　TfrmMain.tmrSetStatusBarLightTimer UIStatusBarStyleDefault');

    {$IFDEF ANDROID}
    FMX.StatusBar.StatusBarLight(True);//黑色字体
    {$ENDIF}


    {$IFDEF IOS}
      GlobalStatusBarLuminance:=1;////1字体黑
      //更新状态栏
      AiOSWindowHandle:=WindowHandleToPlatform(Handle);
      //在扫码打开的时候调用它会报错
      if AiOSWindowHandle.Wnd<>nil then
      begin
        AiOSWindowHandle.Wnd.rootViewController.setNeedsStatusBarAppearanceUpdate;
      end;
    {$ENDIF}
  end;



end;

procedure TfrmMain.tmrStartLocationTimer(Sender: TObject);
begin
  OutputDebugString('OrangeUI TfrmMain.tmrStartLocationTimer Begin'+' ThreadID:'+IntToStr(TThread.CurrentThread.ThreadID));

  tmrStartLocation.Enabled:=False;



  {$IFDEF HAS_GPSLOCATION}
//  if not GlobalGPSLocation.StartLocation then
//  begin
//    ShowHintFrame(nil,'启动定位失败!');
//  end;
  {$ENDIF}




  {$IFDEF MSWINDOWS}
  //在Windows下面测试定位
  tmrTestGPSLocation.Enabled:=True;
  {$ENDIF}

  {$IFDEF IOS}
    {$IFDEF CPUX86}
    //IOS模拟器下面测试定位
    tmrTestGPSLocation.Enabled:=True;
    {$ENDIF}
  {$ENDIF}



  {$IFDEF HAS_GPSLOCATION}
  //通知首页开始定位
  if GlobalMainFrame<>nil then
  begin
    GlobalMainFrame.DoStartLocation;
  end;
  {$ENDIF}


  OutputDebugString('OrangeUI TfrmMain.tmrStartLocationTimer End');
end;

procedure TfrmMain.tmrSyncBadgeTimer(Sender: TObject);
var
  AUnReadMsgCount:Integer;
begin
  AUnReadMsgCount:=GetApplicationIconBadgeNumber;


  {$IFDEF HAS_PUSHNOTIFICATION}
  if (GlobalManager<>nil)
    and (FPushClientRestImpl<>nil) then
  begin
      //App一直在前台的时候,一直改的是FBadge,如果FBadge和AUnReadMsgCount不相等,则需要同步
      if GlobalManager.IsLogin
        and (FPushClientRestImpl.FBadge<>AUnReadMsgCount) then
      begin
        OutputDebugString('OrangeUI TfrmMain.tmrSyncBadgeTimer AUnReadMsgCount 1:'+IntToStr(AUnReadMsgCount));
        Self.FPushClientRestImpl.UpdateBadge(AUnReadMsgCount);
        Self.NotificationCenter1.ApplicationIconBadgeNumber:=AUnReadMsgCount;
      end;


      {$IFDEF IOS}
      //当APP在后台的时候,改的是ApplicationIconBadgeNumber,则也需要同步
      if GlobalManager.IsLogin
    //    and (Self.NotificationCenter1.ApplicationIconBadgeNumber<>Self.FPushClientRestImpl.FBadge)
        and (Self.NotificationCenter1.ApplicationIconBadgeNumber<>AUnReadMsgCount) then
      begin
        OutputDebugString('OrangeUI TfrmMain.tmrSyncBadgeTimer AUnReadMsgCount 2:'+IntToStr(AUnReadMsgCount));

        Self.FPushClientRestImpl.FBadge:=Self.NotificationCenter1.ApplicationIconBadgeNumber;

        Self.FPushClientRestImpl.UpdateBadge(AUnReadMsgCount);
        Self.NotificationCenter1.ApplicationIconBadgeNumber:=AUnReadMsgCount;
      end;
      {$ENDIF}

  end;
  {$ENDIF}

end;

procedure TfrmMain.tmrTestGPSLocationTimer(Sender: TObject);
var
  ALongitude,ALatitude:Double;
begin
//  tmrTestGPSLocation.Enabled:=False;

  {$IFDEF HAS_GPSLOCATION}
  if GlobalGPSLocation<>nil then
  begin
      ALongitude:=GlobalGPSLocation.Longitude+Self.tbDistance.Value*OneMeter;
      ALatitude:=GlobalGPSLocation.Latitude+Self.tbDistance.Value*OneMeter;

//      GlobalGPSLocation.LocationChanged:=True;
//
//      Self.DoGPSLocation_LocationChange(GlobalGPSLocation);

      GlobalGPSLocation.DoReceiveLocation(ALongitude,ALatitude);
//      GlobalGPSLocation.GeocodeAddr;
  end;
  {$ENDIF }

end;

procedure TfrmMain.tteGetAppExecute(ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;

  GlobalManager.AppJson:=nil;
  try
//
    TTimerTask(ATimerTask).TaskDesc:=
      SimpleCallAPI('get_record',
                    nil,
                    //TableRestCenterInterfaceUrl,
                    CenterInterfaceUrl+'tablecommonrest/',
                    ['appid',
                    'user_fid',
                    'key',
                    'rest_name',
                    'where_key_json'],
                    [AppID,
                    GlobalManager.User.fid,
                    '',
                    'app',
                    GetWhereConditions(['fid'],
                                      [AppID])
                    ],
                    GlobalRestAPISignType,
                    GlobalRestAPIAppSecret
                    );
    if TTimerTask(ATimerTask).TaskDesc<>'' then
    begin
      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;

      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=SUCC then
      begin
        GlobalManager.AppJson:=ASuperObject.O['Data'];

      end;


    end;

//    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('get_app_with_user_type_info',
//                                                    nil,
//                                                    ProgramFrameworkRestCenterInterfaceUrl,
//                                                    ['appid',
//                                                    'user_fid',
//                                                    'key',
//                                                    'my_appid',
//                                                    'platform',
//                                                    'user_type'
//                                                    ],
//                                                    [AppID,
//                                                    //未登录的情况下调用的
//                                                    0,//GlobalManager.User.fid,
//                                                    '',//GlobalManager.User.key,
//                                                    AppID,
//                                                    'app',
//                                                    IntToStr(Ord(Const_APPUserType))
//                                                    ],
//                                                    GlobalRestAPISignType,
//                                                    GlobalRestAPIAppSecret
//                                                    );
//    if TTimerTask(ATimerTask).TaskDesc<>'' then
//    begin
//      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
//    end;



  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;


end;

procedure TfrmMain.tteGetAppExecuteEnd(ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
  AMessage:String;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

          //tteGetAppExecute
          //GlobalManager.AppJson:=ASuperObject.O['Data'];


          //判断服务端的IP地址是否需要更新
          if (GlobalManager.AppJson<>nil)
            and (GlobalManager.AppJson.S['server']<>'')
            and (
                      (GlobalManager.AppJson.S['server']<>GlobalManager.ServerHost)
                  or ((GlobalManager.AppJson.I['server_port']<>0) and (GlobalManager.AppJson.I['server_port']<>GlobalManager.ServerPort))
                  ) then
          begin
//            ShowMessageBoxFrame(nil,'',DoModalResultFromUseNewServerMessageBoxFrame);
            if (GlobalManager.AppJson.I['server_port']<>0) then
            begin
              //配了端口
              AMessage:='服务器地址已经更新为'+GlobalManager.AppJson.S['server']+':'+IntToStr(GlobalManager.AppJson.I['server_port'])+',是否需要使用？'
            end
            else
            begin
              //没有配端口
              AMessage:='服务器地址已经更新为'+GlobalManager.AppJson.S['server']+',是否需要使用？'
            end;
            ShowMessageBoxFrame(nil,AMessage,'',TMsgDlgType.mtInformation,['取消','确定'],DoModalResultFromUseNewServerMessageBoxFrame);
          end;


          //放在GlobalMainFrame中去了




      end
      else
      begin
        //获取失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc']);
      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin
      //网络异常
      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!');
    end;
  finally
  end;


end;

procedure TfrmMain.MyInfoChange;
begin

end;

procedure TfrmMain.NotificationCenter1ReceiveLocalNotification(Sender: TObject;
  ANotification: TNotification);
begin
  //收到本地通知
  OutputDebugString('OrangeUI TfrmMain.NotificationCenter1ReceiveLocalNotification');
end;

initialization


end.

