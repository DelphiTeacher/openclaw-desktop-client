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
  FMX.Platform.iOS in '..\OrangeUI\OrangeProjectCommon\FMX.Platform.iOS.pas',
  FMX.FontGlyphs.iOS in '..\OrangeUI\OrangeProjectCommon\FMX.FontGlyphs.iOS.pas',
  FMX.Context.GLES.iOS in '..\OrangeUI\OrangeProjectCommon\FMX.Context.GLES.iOS.pas',
  HzSpell in '..\OrangeUI\OrangeProjectCommon\HzSpell\HzSpell.pas',
  MainFrame in 'MainFrame.pas' {FrameMain: TFrame},
  Android.JNI.Toast in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Android.JNI.Toast.pas',
  Androidapi.JNI.ActivityManager in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.ActivityManager.pas',
  Androidapi.JNI.android.os.storage.StorageManager in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.android.os.storage.StorageManager.pas',
  Androidapi.JNI.Environment in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.Environment.pas',
  Androidapi.JNI.java.lang.FlyUtils in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.java.lang.FlyUtils.pas',
  Androidapi.JNI.StatFs in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.StatFs.pas',
  Androidapi.JNI.Stream2 in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.Stream2.pas',
  Androidapi.JNI.ToastForService in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\Androidapi.JNI.ToastForService.pas',
  FlyFilesUtils in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\FlyFilesUtils.pas',
  FlyFmxUtils in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\FlyFmxUtils.pas',
  FlyUtils.Android.PostRunnableAndTimer in '..\OrangeUI\OrangeProjectCommon\FlyFilesUtils\FlyUtils.Android.PostRunnableAndTimer.pas',
  FMX.DeviceInfo in '..\OrangeUI\OrangeProjectCommon\FMX.DeviceInfo.pas',
  uGetDeviceInfo in '..\OrangeUI\OrangeProjectCommon\uGetDeviceInfo.pas',
  uAPPCommon in '..\OrangeUI\OrangeProjectCommon\uAPPCommon.pas',
  MainForm in 'MainForm.pas' {frmMain},
  EasyServiceCommonMaterialDataMoudle in '..\OrangeUI\OrangeProjectCommon\EasyServiceCommonMaterialDataMoudle.pas' {dmEasyServiceCommonMaterial: TDataModule},
  uAndroidLog in '..\OrangeUI\OrangeProjectCommon\Android\uAndroidLog.pas',
  BaseListItemStyleFrame in '..\OrangeUI\OrangeUIStyles\BaseListItemStyleFrame.pas',
  BaseParentItemStyleFrame in '..\OrangeUI\OrangeUIStyles\BaseParentItemStyleFrame.pas',
  ListItemStyleFrame_Base in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_Base.pas',
  ListItemStyleFrame_Caption_BottomDetail_IconRight in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_Caption_BottomDetail_IconRight.pas',
  ListItemStyleFrame_Caption_DelButton in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_Caption_DelButton.pas',
  ListItemStyleFrame_CaptionGrayCenter in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionGrayCenter.pas',
  ListItemStyleFrame_CaptionLeft_DetailRight_Accessory in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionLeft_DetailRight_Accessory.pas',
  ListItemStyleFrame_CaptionTop16_DetailBottom in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionTop16_DetailBottom.pas',
  ListItemStyleFrame_CaptionTopDetailBottom in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionTopDetailBottom.pas',
  ListItemStyleFrame_CarglSelectRepairItem in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CarglSelectRepairItem.pas',
  ListItemStyleFrame_CarglSelectRepairMaterial in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CarglSelectRepairMaterial.pas',
  ListItemStyleFrame_Comment in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_Comment.pas',
  ListItemStyleFrame_CommentDetail in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CommentDetail.pas',
  ListItemStyleFrame_ContentCommentDetail in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ContentCommentDetail.pas',
  ListItemStyleFrame_Group in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_Group.pas',
  ListItemStyleFrame_HorzImageListBox in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_HorzImageListBox.pas',
  ListItemStyleFrame_IconCaption in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaption.pas',
  ListItemStyleFrame_IconCaption_BottomDetail_RightGrayDetail1 in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaption_BottomDetail_RightGrayDetail1.pas',
  ListItemStyleFrame_IconCaption_BottomDetail_Service_Item_Book in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaption_BottomDetail_Service_Item_Book.pas',
  ListItemStyleFrame_IconCaption_RightGrayDetail in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaption_RightGrayDetail.pas',
  ListItemStyleFrame_IconCaptionMultiColor in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaptionMultiColor.pas',
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenter_Selected in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconTopCenter_CaptionBottomCenter_Selected.pas',
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack.pas',
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenterWhite in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconTopCenter_CaptionBottomCenterWhite.pas',
  ListItemStyleFrame_ImageListViewer in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ImageListViewer.pas',
  ListItemStyleFrame_ItemDevide in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ItemDevide.pas',
  ListItemStyleFrame_PushedButton in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_PushedButton.pas',
  ListItemStyleFrame_RadioButton in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_RadioButton.pas',
  ListItemStyleFrame_SearchBar in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_SearchBar.pas',
  ListItemStyleFrame_SearchBar_BottomMargin in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_SearchBar_BottomMargin.pas',
  ListItemStyleFrame_SmallCoupon in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_SmallCoupon.pas',
  ListItemStyleFrame_ThemeColorButton in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ThemeColorButton.pas',
  ListItemStyleFrame_ScanInStoreConfirm in '..\OrangeUI\OrangeUIStyles\DoorManage\ListItemStyleFrame_ScanInStoreConfirm.pas',
  ListItemStyleFrame_ScanBarCodeItem in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ScanBarCodeItem.pas',
  ListItemStyleFrame_FinishedProcessTask in '..\OrangeUI\OrangeUIStyles\DoorManage\ListItemStyleFrame_FinishedProcessTask.pas',
  SettingFrame in 'SettingFrame.pas',
  uOpenClientCommon in '..\OrangeUI\OrangeProjectCommon\uOpenClientCommon.pas',
  uOpenCommon in '..\OrangeUI\OrangeProjectCommon\uOpenCommon.pas',
  uOpenUISetting in '..\OrangeUI\OrangeProjectCommon\uOpenUISetting.pas',
  ListItemStyleFrame_IconCaption_NotifyNumberIconRight in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconCaption_NotifyNumberIconRight.pas',
  ListItemStyleFrame_ContentNews in '..\OrangeUI\OrangeUIStyles\DCommunity\ListItemStyleFrame_ContentNews.pas',
  ListItemStyleFrame_LiveStream in '..\OrangeUI\OrangeUIStyles\DCommunity\ListItemStyleFrame_LiveStream.pas',
  ListItemStyleFrame_ShortVideo in '..\OrangeUI\OrangeUIStyles\DCommunity\ListItemStyleFrame_ShortVideo.pas',
  ChatDialogFrame in '..\OrangeUI\OrangeUIStyles\IM\ChatDialogFrame.pas',
  MyChatDialogFrame in '..\OrangeUI\OrangeUIStyles\IM\MyChatDialogFrame.pas',
  ChatCreatTime in '..\OrangeUI\OrangeUIStyles\IM\ChatCreatTime.pas',
  ListItemStyleFrame_SimpleContact in '..\OrangeUI\OrangeUIStyles\IM\ListItemStyleFrame_SimpleContact.pas',
  ListItemStyleFrame_WorkOrderContent in '..\OrangeUI\OrangeUIStyles\DCommunity\ListItemStyleFrame_WorkOrderContent.pas' {FrameWorkOrderContentListItemStyle},
  ListItemStyleFrame_ProcessTaskSchedule in '..\OrangeUI\OrangeUIStyles\DoorManage\ListItemStyleFrame_ProcessTaskSchedule.pas' {FrameListItemStyle_ProcessTaskSchedule: TFrame},
  ListItemStyleFrame_DelphiContent in '..\OrangeUI\OrangeUIStyles\DCommunity\ListItemStyleFrame_DelphiContent.pas',
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack_Notify in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack_Notify.pas',
  uSelectMediaDialog in '..\OrangeUI\OrangeProjectCommon\uSelectMediaDialog.pas',
  uDataInterface in '..\OrangeUI\OrangeProjectCommon\uDataInterface.pas',
  ListItemStyleFrame_CaptionTopDetailBottom_SelectedBorder in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionTopDetailBottom_SelectedBorder.pas',
  ListItemStyleFrame_CaptionTop_DetailBottom_Detail1Button in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionTop_DetailBottom_Detail1Button.pas',
  ListItemStyleFrame_CaptionBottomDetailTop in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionBottomDetailTop.pas',
  iOSapi.Photos.Manager in '..\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\iOSapi.Photos.Manager.pas',
  iOSapi.Photos in '..\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\iOSapi.Photos.pas',
  uPhotoManager.Android in '..\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\uPhotoManager.Android.pas',
  uPhotoManager.iOS in '..\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\uPhotoManager.iOS.pas',
  uPhotoManager in '..\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\uPhotoManager.pas',
  uPhotoManager.Windows in '..\OrangeUI\OrangeProjectCommon\MultiSelectPhotos\uPhotoManager.Windows.pas',
  uRestIntfMemTable in '..\OrangeUI\OrangeProjectCommon\RestIntfMemTable\uRestIntfMemTable.pas',
  uFMXSVGSupport in '..\OrangeUI\OrangeProjectCommon\uFMXSVGSupport.pas',
  ListItemStyleFrame_IconTopCenterBackColor_CaptionBottomCenterBlack in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconTopCenterBackColor_CaptionBottomCenterBlack.pas',
  ListItemStyleFrame_IconLeft_CaptionRightBottom_DetailRightTop in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconLeft_CaptionRightBottom_DetailRightTop.pas',
  ListItemStyleFrame_IconLeftRoundBack_CaptionRightBottom_DetailRightTop in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_IconLeftRoundBack_CaptionRightBottom_DetailRightTop.pas',
  ParentItemStyleFrame_CaptionAutoSize_ExpandButtonRight in '..\OrangeUI\OrangeUIStyles\ParentItemStyleFrame_CaptionAutoSize_ExpandButtonRight.pas',
  ListItemStyleFrame_GrayCaptionLeftAutoSize_DetailLeft in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_GrayCaptionLeftAutoSize_DetailLeft.pas',
  ListItemStyleFrame_CaptionGrayCenter_BottomBorderSelected in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionGrayCenter_BottomBorderSelected.pas',
  ListItemStyleFrame_CaptionGrayCenter_BottomBorderSelected_DropDown in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CaptionGrayCenter_BottomBorderSelected_DropDown.pas',
  uManager in 'uManager.pas',
  ListItemStyleFrame_CalendarTitle in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CalendarTitle.pas',
  ListItemStyleFrame_CalendarItem in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CalendarItem.pas',
  ListItemStyleFrame_CustomerRank in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_CustomerRank.pas',
  ListItemStyleFrame_ItemSelectedRight in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_ItemSelectedRight.pas',
  uMapCommon in '..\OrangeUI\OrangeProjectCommon\uMapCommon.pas',
  uDataSetToJson in '..\OrangeUI\OrangeProjectCommon\uDataSetToJson.pas',
  AIChatFrame in 'AIChatFrame.pas' {FrameAIChat: TFrame},
  uConst in 'uConst.pas',
  uCommandLineHelper in '..\OrangeUI\OrangeProjectCommon\uCommandLineHelper.pas',
  PK.TrayIcon.Win in '..\OrangeUI\OrangeProjectCommon\FMX-TrayIcon\PK.TrayIcon.Win.pas',
  PK.TrayIcon.Default in '..\OrangeUI\OrangeProjectCommon\FMX-TrayIcon\PK.TrayIcon.Default.pas',
  PK.TrayIcon.Mac in '..\OrangeUI\OrangeProjectCommon\FMX-TrayIcon\PK.TrayIcon.Mac.pas',
  PK.TrayIcon in '..\OrangeUI\OrangeProjectCommon\FMX-TrayIcon\PK.TrayIcon.pas',
  ServiceManageFrame in 'ServiceManageFrame.pas' {FrameServiceManage: TFrame},
  uServiceManage in 'uServiceManage.pas',
  DoorMainForm in 'DoorMainForm.pas' {frmDoorManageMain},
  ConfigFrame in 'ConfigFrame.pas' {FrameConfig: TFrame},
  uLocalOpenClawHelper in 'uLocalOpenClawHelper.pas',
  CustomAIModelSettingFrame in 'CustomAIModelSettingFrame.pas' {FrameCustomAIModelSetting: TFrame},
  InstallDaemonFrame in 'InstallDaemonFrame.pas' {FrameInstallDaemon: TFrame},
  CommonImageDataMoudle in 'CommonImageDataMoudle.pas' {dmCommonImageDataMoudle: TDataModule},
  OpenClawGateway in 'OpenClawGateway.pas',
  OpenClawDeviceIdentity in 'OpenClawDeviceIdentity.pas',
  OpenClawDeviceAuth in 'OpenClawDeviceAuth.pas',
  ED25519 in 'ED25519.pas',
  ListItemStyleFrame_AIModelConfig in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_AIModelConfig.pas',
  AIModels in 'AIModels.pas',
  ConfigAIModelListFrame in 'ConfigAIModelListFrame.pas' {FrameConfigAIModelList: TFrame},
  SkillFrame in 'SkillFrame.pas' {FrameSkill: TFrame},
  LoginFrame in 'LoginFrame.pas' {FrameLogin: TFrame},
  DatasetManageFrame in 'DatasetManageFrame.pas' {FrameDatasetManage: TFrame},
  OpenclawChatFrame in 'OpenclawChatFrame.pas' {FrameOpenclawChat: TFrame},
  ListItemStyleFrame_RagDataset in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_RagDataset.pas',
  DatasetDetailFrame in 'DatasetDetailFrame.pas' {FrameDatasetDetail: TFrame},
  ListItemStyleFrame_RagDatasetCollection in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_RagDatasetCollection.pas',
  DatasetImportFrame in 'DatasetImportFrame.pas' {FrameDatasetImport: TFrame},
  ListItemStyleFrame_DatasetImportLocalFile in '..\OrangeUI\OrangeUIStyles\ListItemStyleFrame_DatasetImportLocalFile.pas',
  DatasetImportLocalFileFrame in 'DatasetImportLocalFileFrame.pas' {FrameDatasetImportLocalFile: TFrame};

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

