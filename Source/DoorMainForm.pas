//convert pas to utf8 by ¥
unit DoorMainForm;

interface


uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  Zlib,
//  MD5,
  System.Zip,
  uTimerTask,
  uManager,
  XSuperObject,
  uRestInterfaceCall,
  uUIFunction,
  uFileCommon,
  uDrawTextParam,
  uOpenCommon,
  uDrawRectParam,
  uGraphicCommon,
  uOpenClientCommon,
  uGetDeviceInfo,
  LoginFrame,
  uOpenUISetting,
//  uUIFunction,
  uBaseLog,
  uFMXSVGSupport,
  CommonImageDataMoudle,
//  CarRepairCommonMaterialDataMoudle,
  EasyServiceCommonMaterialDataMoudle,


  uConst,
  uRestHttpDataInterface,
//  uPageStructure,
//  uDataInterface,
//  OrderListFrame,
//  ClientListFrame,

  PK.TrayIcon,


  MainForm, uSkinButtonType, uSkinFireMonkeyButton, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinFireMonkeyControl, uSkinPanelType,
  uSkinFireMonkeyPanel, uSkinControlGestureManager,
  uSkinControlPanDragGestureManager, FMX.Media, uTimerTaskEvent,
  System.Notification, FMX.Edit, FMX.Controls.Presentation, uSkinFireMonkeyEdit,
  uDrawPicture, uSkinImageList, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinMaterial, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, uDrawCanvas, FMX.MediaLibrary, System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions;

type
  TfrmDoorManageMain = class(TfrmMain)
    DrawCanvasSetting1: TDrawCanvasSetting;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    FTrayIcon: TTrayIcon;
    procedure MenuClickedHandler(Sender: TObject);
    procedure ExitMenuClickedHandler(Sender: TObject);
    procedure TrayIconClickHandler(Sender: TObject);
    { Private declarations }
  protected
//    FScanCode:String;
    function GetScanTitle:String;override;
    function GetScanTips:String;override;
    //门业中心登录
    procedure DoCustomAutoLoginExecute(ATimerTask:TObject);override;
  protected
//    function DoPageFrameworkDataSourceGetDrawPicture(AImageName:String;var AIsGeted:Boolean):TDrawPicture;override;
//    //将页面框架中的变量转换为对应的值
//    function DoPageFrameworkDataSourceGetParamValue(AValueFrom:String;AParamName:String;var AIsGeted:Boolean):Variant;override;
////    procedure DoPageFrameworkDataSourceSetParamValue(AValueFrom:String;AParamName:String;AValue:Variant;var AIsSeted:Boolean);override;
//    //处理自定义的动作
//    procedure DoMainProgramSettingCustomProcessPageAction(Sender:TObject;
//                                                          APageInstance:TPageInstance;
//                                                          AAction:String;
//                                                          AFieldControlSettingMap:TFieldControlSettingMap;
//                                                          var AIsProcessed:Boolean);override;

  public
    //更新服务器设置
    procedure SyncServerSetting(AServer:String;APort:Integer);override;
    { Public declarations }
  end;




var
  frmDoorManageMain: TfrmDoorManageMain;

implementation

{$R *.fmx}

//uses
//  ScanInStoreFrame;


procedure TfrmDoorManageMain.DoCustomAutoLoginExecute(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
begin
  inherited;

//  //出错
//  TTimerTask(ATimerTask).TaskTag:=1;
//  try
////      //门业中心登录
////      TTimerTask(ATimerTask).TaskDesc:=
////          SimpleCallAPI('employee_login',
////                        nil,
////                        DoorManageInterfaceUrl,
////                        ['appid',
////                        'phone',
////                        'password'],
////                        [AppID,
////                        TTimerTask(ATimerTask).TaskOtherInfo.Values['User'],
////                        TTimerTask(ATimerTask).TaskOtherInfo.Values['Password']],
////                        GlobalRestAPISignType,
////                        GlobalRestAPIAppSecret
////                        );
////
////
////      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
////      if ASuperObject.I['Code']<>200 then
////      begin
////        Exit;
////      end;
////
////
////      //登录成功
////      GlobalManager.EmployeeJson:=ASuperObject.O['Data'];
//
//
//      //测试权限
//      //GlobalManager.EmployeeJson.S['权限']:='管理员';
//
//
//
//      //连接服务器
//      // 服务器地址
//      dmCommonImageDataMoudle.RFConnection1.ServerAddr := '150.158.93.139';
//      // 服务器端口
//      dmCommonImageDataMoudle.RFConnection1.ServerPort := '9981';
//      // 数据库连接名称
//      dmCommonImageDataMoudle.RFConnection1.ConnectionDefName := 'JmtServer';
//
//      if not dmCommonImageDataMoudle.RFConnection1.Connect() then
//      begin
//        Exit;
//      end;
//      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
//
//
//
////      if TTimerTask(ATimerTask).TaskDesc<>'' then
////      begin
////        TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
////      end;
//
//
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//
//  end;

end;

procedure TfrmDoorManageMain.ExitMenuClickedHandler(Sender: TObject);
begin
  Free;
end;

//procedure TfrmDoorManageMain.DoMainProgramSettingCustomProcessPageAction(
//  Sender: TObject; APageInstance: TPageInstance; AAction: String;
//  AFieldControlSettingMap: TFieldControlSettingMap; var AIsProcessed: Boolean);
//begin
//  inherited;
//
//  if AAction='select_process_task_bill' then
//  begin
//    //选择生产任务单
//    AIsProcessed:=True;
//    HideFrame;
//    ShowFrame(TFrame(GlobalOrderListFrame),TFrameOrderList,AFieldControlSettingMap.DoReturnFrame);
////    GlobalOrderListFrame.Load;
//    //告诉页面,我要用选择模式
//    (GlobalOrderListFrame as IPageFrameworkSelectDataFrame).SetSelectDataMode(AFieldControlSettingMap);
////    GlobalOrderListFrame.lvData.OnClickItem:=DoSelectFrameListControlClickItem;
//  end;
//
//  if AAction='select_sale_order_bill' then
//  begin
//    //选择销售单
//    AIsProcessed:=True;
//    HideFrame;
//    ShowFrame(TFrame(GlobalOrderListFrame),TFrameOrderList,AFieldControlSettingMap.DoReturnFrame);
////    GlobalOrderListFrame.Load;
//    //告诉页面,我要用选择模式
//    (GlobalOrderListFrame as IPageFrameworkSelectDataFrame).SetSelectDataMode(AFieldControlSettingMap);
////    GlobalOrderListFrame.lvData.OnClickItem:=DoSelectFrameListControlClickItem;
//  end;
//
//  //选择货款录入客户
//  if AAction='select_customer' then
//  begin
//    AIsProcessed:=True;
//    HideFrame;
//    ShowFrame(TFrame(FrameClientList),TFrameClientList,AFieldControlSettingMap.DoReturnFrame);
////    GlobalOrderListFrame.Load;
//    //告诉页面,我要用选择模式
//    (FrameClientList as IPageFrameworkSelectDataFrame).SetSelectDataMode(AFieldControlSettingMap);
////    GlobalOrderListFrame.lvData.OnClickItem:=DoSelectFrameListControlClickItem;
//  end;
//
//end;
//
//function TfrmDoorManageMain.DoPageFrameworkDataSourceGetParamValue(AValueFrom,
//  AParamName: String; var AIsGeted: Boolean): Variant;
//begin
////  if SameText(AParamName,'$new_quality_check_bill_no') then
////  begin
////    //在新增品质检查的时候,获取新的单据编码
////    Result:=
////    AIsGeted:=True;
////  end;
//end;

procedure TfrmDoorManageMain.FormCreate(Sender: TObject);
begin


  {$IFDEF MSWINDOWS}
//  WinIsPadDevice:=True;

  if WinIsPadDevice then
  begin
    ClientWidth:=1200;
    ClientHeight:=800;
  end;
  {$ENDIF}


  //任务栏不透明
  GlobalIsAndroidTransparentToolbar:=False;
  //是否允许缓存,总开关
  GlobalIsEnableBuffer:=True;

  inherited;


  MainForm.frmMain:=Self;

//  //不定位
//  GlobalIsNeedGPSLocation:=True;


//  //是否启用微信登录
//  GlobalIsEnabledWeichatLogin:=False;
//  //是否启用QQ登录
//  GlobalIsEnabledQQLogin:=False;
//  //是否启用Facebook登录
//  GlobalIsEnabledFacebookLogin:=False;
//  //是否启用Twitter登录
//  GlobalIsEnabledTwitterLogin:=False;




  // Generate TaskTray Icon library
  FTrayIcon := TTrayIcon.Create;

  // Event when the icon itself is clicked (Windows Only)
  FTrayIcon.RegisterOnClick(TrayIconClickHandler);
  FTrayIcon.RegisterOnDblClick(TrayIconClickHandler);

//  // Menu setting
//  FTrayIcon.AddMenu('退出', ExitMenuClickedHandler);
//  FTrayIcon.AddMenu('MenuItem2', MenuClickedHandler);
//  FTrayIcon.AddMenu('-', nil);
//  FTrayIcon.AddMenu('MenuItem3', MenuClickedHandler);

  // Icon registration
  // An icon is an instance of TBitmap. Here we are extracting from ImageList
  // Bmp := ImageList1.Bitmap(TSizeF.Create(24, 24), 0);
  // FTrayIcon.RegisterIcon('Normal', Bmp);

  // Bmp := ImageList1.Bitmap(TSizeF.Create(24, 24), 1);
  // FTrayIcon.RegisterIcon('Error', Bmp);

  // Specify the image to use (Please note that it is not displayed unless specified!)
  // FTrayIcon.ChangeIcon('Normal', 'HintText');

  // Displayed in TaskTray / StatusBar
  FTrayIcon.Apply(Const_APPName);

end;


procedure TfrmDoorManageMain.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FTrayIcon);
end;

procedure TfrmDoorManageMain.MenuClickedHandler(Sender: TObject);
begin
//  ShowMessage('The menu was clicked!');
//  Self.WindowState:=TWindowState.wsNormal;
end;

procedure TfrmDoorManageMain.TrayIconClickHandler(Sender: TObject);
begin
//  ShowMessage('TaskTray icon was clicked!');
//  Self.WindowState:=TWindowState.wsMinimized;
//  Self.WindowState:=TWindowState.wsNormal;
end;

procedure TfrmDoorManageMain.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  FMX.Types.Log.d('OrangeUI TfrmDoorManageMain.FormKeyDown '+IntToStr(Key)+' '+KeyChar );

  inherited;

end;

procedure TfrmDoorManageMain.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin

//  FMX.Types.Log.d('OrangeUI TfrmDoorManageMain.FormKeyUp '+IntToStr(Key)+' '+KeyChar +FScanCode);
//
//  if (Key=13) then
//  begin
//      if (CurrentFrame<>nil)
//        and (CurrentFrame=GlobalScanInStoreFrame) then
//      begin
//        GlobalScanInStoreFrame.DoScanCodeResultEvent(nil,Trim(FScanCode));
//        FScanCode:='';
//      end;
//  end
//  else
//  begin
//      if Key=0 then
//      begin
//        FScanCode:=FScanCode+KeyChar;
//      end;
//  end;


  inherited;

end;

procedure TfrmDoorManageMain.FormShow(Sender: TObject);
begin


  inherited;

//  dmCarRepairCommonMaterial.SyncSkinThemeColor;




//  //自定义扩展登录接口调用
//  LoginFrame.OnCustomLoginExecute:=DoCustomAutoLoginExecute;



//
//  //自定义素材
//  dmEasyServiceCommonMaterial.pnlToolBarMaterial.BackColor.BrushKind:=drpbkGradient;
//  dmEasyServiceCommonMaterial.pnlToolBarMaterial.BackColor.GradientStyle:=TGradientStyle.Linear;
//  dmEasyServiceCommonMaterial.pnlToolBarMaterial.BackColor.GradientStopPosition.Y:=1.2;
//  dmEasyServiceCommonMaterial.pnlToolBarMaterial.BackColor.FillColor.Color:=$FF4965E0;
//  dmEasyServiceCommonMaterial.pnlToolBarMaterial.BackColor.GradientColor1:=$FF66A5FF;
////  dmEasyServiceCommonMaterial.pnlToolBarMaterial.DrawCaptionParam.DrawRectSetting.Enabled:=False;
////  dmEasyServiceCommonMaterial.pnlToolBarMaterial.DrawCaptionParam.FontHorzAlign:=
////    TFontHorzAlign.fhaCenter;


  {$IFDEF MSWINDOWS}
//  ExtractIconsZip(GetApplicationPath+'icons.zip',GetApplicationPath);
  {$ELSE}
  //Android平台
  //解压assets\internal\icons.zip中的图标
  ExtractIconsZip(GetApplicationPath+'icons.zip',GetApplicationPath);
  {$ENDIF}
//  dmCommonImageDataMoudle.SkinTheme1.FilePictureSearchPaths.Add(GetApplicationPath+'icons'+PathDelim);
//  uGraphicCommon.GlobalFilePictureSearchPaths.Add(GetApplicationPath);
  uGraphicCommon.GlobalFilePictureSearchPaths.Add(GetApplicationPath+'icons'+PathDelim);

end;

function TfrmDoorManageMain.GetScanTips: String;
begin
  Result := '将条码放入框内，即可自动扫描';
end;

function TfrmDoorManageMain.GetScanTitle: String;
begin
  Result := '条码扫描';
end;

procedure TfrmDoorManageMain.SyncServerSetting(AServer: String;
  APort: Integer);
begin
  inherited;


  //门业管理接口,连的是公司私有的自己的服务器
//  CarglCenterInterfaceUrl:=InterfaceUrl+'carglcenter/';
  DoorManageInterfaceUrl:=InterfaceUrl+'door_manage/';
  CommonRestCenterInterfaceUrl:=InterfaceUrl+'tablecommonrest/';









//  //授权服务器
//  //可以使用其他的服务器
//  ACenterInterfaceUrl:='http://'+GlobalManager.CenterServerHost+':'+IntToStr(GlobalManager.CenterServerPort)+'/';
//  //用户中心接口地址
//  UserCenterInterfaceUrl:=ACenterInterfaceUrl+'usercenter/';
//  //推送中心接口地址
//  PushManageInterfaceUrl:=ACenterInterfaceUrl+'pushmanage/';







//  //页面框架的配置
//  GlobalMainProgramSetting.OpenPlatformAppID:='1000';
//  //服务端接口地址
//  GlobalMainProgramSetting.OpenPlatformServerUrl:='http://'+AServer+':'+IntToStr(APort)+'/';
//  //图片上传下载地址
//  GlobalMainProgramSetting.OpenPlatformImageUrl:='http://'+AServer+':'+IntToStr(APort+1)+'/';
//
//
//  GlobalMainProgramSetting.AppID:=AppID;
//  GlobalMainProgramSetting.ProgramTemplateName:='open_platform';
//  GlobalMainProgramSetting.DataIntfServerUrl:=InterfaceUrl+'/';
//  GlobalMainProgramSetting.DataIntfImageUrl:=ImageHttpServerUrl+'/';
//
//  //开放平台页面框架的接口类型
//  GlobalDataInterfaceClass:=TTableCommonRestHttpDataInterface;







  //授权服务器
  //可以使用其他的服务器
  CenterInterfaceUrl:='http://'+Const_CenterServerHost+':'+IntToStr(Const_CenterServerPort)+'/';
//  //用户中心接口地址
//  UserCenterInterfaceUrl:=ACenterInterfaceUrl+'usercenter/';
//  //推送中心接口地址
//  PushManageInterfaceUrl:=ACenterInterfaceUrl+'pushmanage/';

  UserSuggectionUserCenterInterfaceUrl:=CenterInterfaceUrl+'usercenter/';



  //门业管理APP统一从OrangeUI服务器下载
  AppUpdateServerUrl:='http://'+Const_CenterServerHost+':'+IntToStr(Const_CenterServerPort+1)+'/';//'';//'http://'+'www.orangeui.cn:10011';



end;

end.
