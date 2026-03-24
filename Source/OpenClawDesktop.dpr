//convert pas to utf8 by Â¥
program OpenClawDesktop;




uses
  System.StartUpCopy,
  Classes,
  uIdHttpControl,
  System.Net.HttpClientComponent,
  System.Net.URLClient,
  SysUtils,
  uBaseLog,
  FMX.Forms,
  FMX.Dialogs,
  uGraphicCommon,
  FMX.Platform.iOS in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FMX.Platform.iOS.pas',
  FMX.FontGlyphs.iOS in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FMX.FontGlyphs.iOS.pas',
  FMX.Context.GLES.iOS in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FMX.Context.GLES.iOS.pas',
  HzSpell in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\HzSpell\HzSpell.pas',
  MainFrame in 'MainFrame.pas' {FrameMain: TFrame},
  Android.JNI.Toast in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Android.JNI.Toast.pas',
  Androidapi.JNI.ActivityManager in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.ActivityManager.pas',
  Androidapi.JNI.android.os.storage.StorageManager in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.android.os.storage.StorageManager.pas',
  Androidapi.JNI.Environment in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.Environment.pas',
  Androidapi.JNI.java.lang.FlyUtils in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.java.lang.FlyUtils.pas',
  Androidapi.JNI.StatFs in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.StatFs.pas',
  Androidapi.JNI.Stream2 in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.Stream2.pas',
  Androidapi.JNI.ToastForService in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.ToastForService.pas',
  FlyFilesUtils in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\FlyFilesUtils.pas',
  FlyFmxUtils in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\FlyFmxUtils.pas',
  FlyUtils.Android.PostRunnableAndTimer in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FlyFilesUtils\FlyUtils.Android.PostRunnableAndTimer.pas',
  FMX.DeviceInfo in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FMX.DeviceInfo.pas',
  uGetDeviceInfo in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uGetDeviceInfo.pas',
  uAPPCommon in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uAPPCommon.pas',
  MainForm in 'MainForm.pas' {frmMain},
  EasyServiceCommonMaterialDataMoudle in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\EasyServiceCommonMaterialDataMoudle.pas' {dmEasyServiceCommonMaterial: TDataModule},
  uAndroidLog in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\Android\uAndroidLog.pas',
  BaseListItemStyleFrame in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\BaseListItemStyleFrame.pas',
  BaseParentItemStyleFrame in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\BaseParentItemStyleFrame.pas',
  ListItemStyleFrame_Base in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_Base.pas',
  ListItemStyleFrame_Caption_BottomDetail_IconRight in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_Caption_BottomDetail_IconRight.pas',
  ListItemStyleFrame_Caption_DelButton in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_Caption_DelButton.pas',
  ListItemStyleFrame_CaptionGrayCenter in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionGrayCenter.pas',
  ListItemStyleFrame_CaptionLeft_DetailRight_Accessory in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionLeft_DetailRight_Accessory.pas',
  ListItemStyleFrame_CaptionTop16_DetailBottom in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionTop16_DetailBottom.pas',
  ListItemStyleFrame_CaptionTopDetailBottom in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionTopDetailBottom.pas',
  ListItemStyleFrame_CarglSelectRepairItem in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CarglSelectRepairItem.pas',
  ListItemStyleFrame_CarglSelectRepairMaterial in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CarglSelectRepairMaterial.pas',
  ListItemStyleFrame_Comment in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_Comment.pas',
  ListItemStyleFrame_CommentDetail in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CommentDetail.pas',
  ListItemStyleFrame_ContentCommentDetail in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ContentCommentDetail.pas',
  ListItemStyleFrame_Group in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_Group.pas',
  ListItemStyleFrame_HorzImageListBox in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_HorzImageListBox.pas',
  ListItemStyleFrame_IconCaption in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaption.pas',
  ListItemStyleFrame_IconCaption_BottomDetail_RightGrayDetail1 in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaption_BottomDetail_RightGrayDetail1.pas',
  ListItemStyleFrame_IconCaption_BottomDetail_Service_Item_Book in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaption_BottomDetail_Service_Item_Book.pas',
  ListItemStyleFrame_IconCaption_RightGrayDetail in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaption_RightGrayDetail.pas',
  ListItemStyleFrame_IconCaptionMultiColor in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaptionMultiColor.pas',
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenter_Selected in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconTopCenter_CaptionBottomCenter_Selected.pas',
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack.pas',
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenterWhite in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconTopCenter_CaptionBottomCenterWhite.pas',
  ListItemStyleFrame_ImageListViewer in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ImageListViewer.pas',
  ListItemStyleFrame_ItemDevide in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ItemDevide.pas',
  ListItemStyleFrame_PushedButton in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_PushedButton.pas',
  ListItemStyleFrame_RadioButton in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_RadioButton.pas',
  ListItemStyleFrame_SearchBar in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_SearchBar.pas',
  ListItemStyleFrame_SearchBar_BottomMargin in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_SearchBar_BottomMargin.pas',
  ListItemStyleFrame_SmallCoupon in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_SmallCoupon.pas',
  ListItemStyleFrame_ThemeColorButton in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ThemeColorButton.pas',
  ListItemStyleFrame_ScanInStoreConfirm in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\DoorManage\ListItemStyleFrame_ScanInStoreConfirm.pas',
  ListItemStyleFrame_ScanBarCodeItem in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ScanBarCodeItem.pas',
  ListItemStyleFrame_FinishedProcessTask in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\DoorManage\ListItemStyleFrame_FinishedProcessTask.pas',
  SettingFrame in 'SettingFrame.pas',
  uOpenClientCommon in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uOpenClientCommon.pas',
  uOpenCommon in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uOpenCommon.pas',
  uOpenUISetting in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uOpenUISetting.pas',
  ListItemStyleFrame_IconCaption_NotifyNumberIconRight in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaption_NotifyNumberIconRight.pas',
  ListItemStyleFrame_ContentNews in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\DCommunity\ListItemStyleFrame_ContentNews.pas',
  ListItemStyleFrame_LiveStream in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\DCommunity\ListItemStyleFrame_LiveStream.pas',
  ListItemStyleFrame_ShortVideo in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\DCommunity\ListItemStyleFrame_ShortVideo.pas',
  ChatDialogFrame in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\IM\ChatDialogFrame.pas',
  MyChatDialogFrame in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\IM\MyChatDialogFrame.pas',
  ChatCreatTime in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\IM\ChatCreatTime.pas',
  ListItemStyleFrame_SimpleContact in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\IM\ListItemStyleFrame_SimpleContact.pas',
  ListItemStyleFrame_WorkOrderContent in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\DCommunity\ListItemStyleFrame_WorkOrderContent.pas' {FrameWorkOrderContentListItemStyle},
  ListItemStyleFrame_ProcessTaskSchedule in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\DoorManage\ListItemStyleFrame_ProcessTaskSchedule.pas' {FrameListItemStyle_ProcessTaskSchedule: TFrame},
  ListItemStyleFrame_DelphiContent in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\DCommunity\ListItemStyleFrame_DelphiContent.pas',
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack_Notify in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack_Notify.pas',
  uSelectMediaDialog in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uSelectMediaDialog.pas',
  uDataInterface in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uDataInterface.pas',
  ListItemStyleFrame_SelectCompanyCheckBox in 'D:\MyFilesNew\OrangeUI\OrangeUIStylesPro\MgrPlus\ListItemStyleFrame_SelectCompanyCheckBox.pas',
  ListItemStyleFrame_CaptionTopDetailBottom_SelectedBorder in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionTopDetailBottom_SelectedBorder.pas',
  ListItemStyleFrame_CaptionTop_DetailBottom_Detail1Button in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionTop_DetailBottom_Detail1Button.pas',
  ListItemStyleFrame_CaptionBottomDetailTop in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionBottomDetailTop.pas',
  iOSapi.Photos.Manager in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\iOSapi.Photos.Manager.pas',
  iOSapi.Photos in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\iOSapi.Photos.pas',
  uPhotoManager.Android in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\uPhotoManager.Android.pas',
  uPhotoManager.iOS in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\uPhotoManager.iOS.pas',
  uPhotoManager in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\uPhotoManager.pas',
  uPhotoManager.Windows in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\uPhotoManager.Windows.pas',
  ListItemStyleFrame_Product in 'D:\MyFilesNew\OrangeUI\OrangeUIStylesPro\MgrPlus\ListItemStyleFrame_Product.pas',
  uRestIntfMemTable in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\RestIntfMemTable\uRestIntfMemTable.pas',
  uFMXSVGSupport in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uFMXSVGSupport.pas',
  ListItemStyleFrame_IconTopCenterBackColor_CaptionBottomCenterBlack in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconTopCenterBackColor_CaptionBottomCenterBlack.pas',
  ListItemStyleFrame_IconLeft_CaptionRightBottom_DetailRightTop in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconLeft_CaptionRightBottom_DetailRightTop.pas',
  ListItemStyleFrame_IconLeftRoundBack_CaptionRightBottom_DetailRightTop in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconLeftRoundBack_CaptionRightBottom_DetailRightTop.pas',
  ParentItemStyleFrame_CaptionAutoSize_ExpandButtonRight in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ParentItemStyleFrame_CaptionAutoSize_ExpandButtonRight.pas',
  ListItemStyleFrame_GrayCaptionLeftAutoSize_DetailLeft in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_GrayCaptionLeftAutoSize_DetailLeft.pas',
  ListItemStyleFrame_CaptionGrayCenter_BottomBorderSelected in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionGrayCenter_BottomBorderSelected.pas',
  ListItemStyleFrame_CaptionGrayCenter_BottomBorderSelected_DropDown in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionGrayCenter_BottomBorderSelected_DropDown.pas',
  uManager in 'uManager.pas',
  ListItemStyleFrame_CalendarTitle in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CalendarTitle.pas',
  ListItemStyleFrame_CalendarItem in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CalendarItem.pas',
  ListItemStyleFrame_CustomerRank in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CustomerRank.pas',
  ListItemStyleFrame_ItemSelectedRight in 'D:\MyFilesNew\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ItemSelectedRight.pas',
  uMapCommon in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uMapCommon.pas',
  uDataSetToJson in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uDataSetToJson.pas',
  AIChatFrame in 'AIChatFrame.pas' {FrameAIChat: TFrame},
  uConst in 'uConst.pas',
  uCommandLineHelper in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\uCommandLineHelper.pas',
  PK.TrayIcon.Win in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FMX-TrayIcon\PK.TrayIcon.Win.pas',
  PK.TrayIcon.Default in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FMX-TrayIcon\PK.TrayIcon.Default.pas',
  PK.TrayIcon.Mac in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FMX-TrayIcon\PK.TrayIcon.Mac.pas',
  PK.TrayIcon in 'D:\MyFilesNew\OrangeUI\OrangeProjectCommon\FMX-TrayIcon\PK.TrayIcon.pas',
  ServiceManageFrame in 'ServiceManageFrame.pas' {FrameServiceManage: TFrame},
  uServiceManage in 'uServiceManage.pas',
  DoorMainForm in 'DoorMainForm.pas' {frmDoorManageMain},
  ConfigFrame in 'ConfigFrame.pas' {FrameConfig: TFrame},
  uOpenClawHelper in 'uOpenClawHelper.pas',
  CustomAIModelSettingFrame in 'CustomAIModelSettingFrame.pas' {FrameCustomAIModelSetting: TFrame},
  InstallDaemonFrame in 'InstallDaemonFrame.pas' {FrameInstallDaemon: TFrame},
  CommonImageDataMoudle in 'CommonImageDataMoudle.pas' {dmCommonImageDataMoudle: TDataModule};

{$R *.res}


//var
//  AStringStream:TStringStream;
////  ANetHttpClient:TNetHttpClient;
//  ANetHttpClient:TIdHttpControl;
//  AProxySettings:TProxySettings;
begin
  ReportMemoryLeaksONShutdown:=DebugHook<>0;

  uBaseLog.GlobalLog.IsWriteLog:=True;
  uBaseLog.GlobalLog.IsOutputLog:=True;

//  WebbrowserControlUtils.SetIEFeatureModeCorrespond;


//  AStringStream:=TStringStream.Create('',TEncoding.UTF8);



//  ANetHttpClient:=TNetHttpClient.Create(nil);

//  AProxySettings:=TProxySettings.Create('http://127.0.0.1:11000');
//  ANetHTTPClient.ProxySettings:=AProxySettings;
//  ANetHTTPClient.ProxySettings.Host:='127.0.0.1';
//  ANetHTTPClient.ProxySettings.Port:='11000';

//  ANetHTTPClient.CustomHeaders['accept']:='text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9';
//  ANetHTTPClient.CustomHeaders['accept-encoding']:='gzip, deflate, br';
//  ANetHTTPClient.CustomHeaders['accept-language']:='zh-CN,zh;q=0.9';
//  ANetHTTPClient.CustomHeaders['cache-control']:='no-cache';
//  ANetHTTPClient.CustomHeaders['pragma']:='no-cache';
//  ANetHTTPClient.CustomHeaders['sec-ch-ua']:='" Not A;Brand";v="99", "Chromium";v="99", "Google Chrome";v="99"';
//  ANetHTTPClient.CustomHeaders['sec-ch-ua-mobile']:='?0';
//  ANetHTTPClient.CustomHeaders['sec-ch-ua-platform']:='"Windows"';
//  ANetHTTPClient.CustomHeaders['sec-fetch-dest']:='document';
//  ANetHTTPClient.CustomHeaders['sec-fetch-mode']:='navigate';
//  ANetHTTPClient.CustomHeaders['sec-fetch-site']:='none';
//  ANetHTTPClient.CustomHeaders['sec-fetch-user']:='?1';
//  ANetHTTPClient.CustomHeaders['upgrade-insecure-requests']:='1';

//  ANetHTTPClient.CustomHeaders['user-agent']:='Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36';


//  IsIdHttpNeedSSL:=True;
//  ANetHttpClient:=TIdHttpControl.Create();
//  ANetHttpClient.FIdHttp.ProxyParams.ProxyServer:='127.0.0.1';
//  ANetHttpClient.FIdHttp.ProxyParams.ProxyPort:=11000;
//  ANetHttpClient.FIdHttp.Request.UserAgent:='Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36';
//
//  ANetHttpClient.Get('https://www.tiktok.com/foryou',AStringStream);
////  ANetHttpClient.Get('https://www.facebook.com',AStringStream);
//  ShowMessage(AStringStream.DataString);



//  //ä¸?é¢˜é¢œè‰?
//  uGraphicCommon.SkinThemeColor:=$FF1F65C0;////$FF1F65C0;


  Application.Initialize;
  Application.CreateForm(TdmCommonImageDataMoudle, dmCommonImageDataMoudle);
  Application.CreateForm(TdmEasyServiceCommonMaterial, dmEasyServiceCommonMaterial);
  Application.CreateForm(TfrmDoorManageMain, frmDoorManageMain);
  Application.Run;

end.

