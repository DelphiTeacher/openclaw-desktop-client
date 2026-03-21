//convert pas to utf8 by ¥

unit AboutUsFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uConst,
  //翻译
  FMX.Consts,

  uOpenUISetting,
  uOpenCommon,
  uOpenClientCommon,
  uManager,
  uTimerTask,
  uUIFunction,
  uRestInterfaceCall,
  MessageBoxFrame,
  WaitingFrame,
  HintFrame,
  uFrameContext,


  XSuperObject,
  XSuperJson,
  uMobileUtils,
  uBaseHttpControl,
  CommonImageDataMoudle,
  EasyServiceCommonMaterialDataMoudle,

  uSkinFireMonkeyButton, uSkinFireMonkeyControl, uSkinFireMonkeyPanel,
  uSkinFireMonkeyScrollBoxContent,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyScrollBox, uSkinFireMonkeyImage,
  uSkinFireMonkeyLabel, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, uSkinFireMonkeyFrameImage, uSkinLabelType,
  uSkinImageType, uSkinFrameImageType, uSkinScrollBoxContentType,
  uSkinScrollControlType, uSkinScrollBoxType, uSkinButtonType, uBaseSkinControl,
  uSkinPanelType, uSkinMaterial;

type
  TFrameAboutUs = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    SkinFMXScrollBox1: TSkinFMXScrollBox;
    SkinFMXScrollBoxContent1: TSkinFMXScrollBoxContent;
    SkinFMXPanel1: TSkinFMXPanel;
    imgQRBitmap: TSkinFMXFrameImage;
    SkinFMXPanel2: TSkinFMXPanel;
    lblVersion: TSkinFMXLabel;
    btnShowImg: TSkinFMXButton;
    ActionListShare: TActionList;
    ShowShareSheetAction1: TShowShareSheetAction;
    lblCopyright: TSkinFMXLabel;
    lblCompany: TSkinFMXLabel;
    lblVersionInfo: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    BtnSendPushNotificationTest: TSkinFMXButton;
    btnViewPirvacyPolicy: TSkinFMXButton;
    btnViewUserServiceProtocol: TSkinFMXButton;
    procedure btnReturnClick(Sender: TObject);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
    procedure imgQRBitmapClick(Sender: TObject);
    procedure BtnSendPushNotificationTestClick(Sender: TObject);
    procedure btnViewPirvacyPolicyClick(Sender: TObject);
    procedure btnViewUserServiceProtocolClick(Sender: TObject);
  private
//    FUrl:String;
//    //获取APP下载链接
//    procedure DoGetAppUrlExecute(ATimerTask:TObject);
//    procedure DoGetAppUrlExecuteEnd(ATimerTask:TObject);
    //给自己发送推送,测试推送是否正常
    procedure DoSendPushNotificationTestExcute(ATimerTask:TObject);
    procedure DoSendPushNotificationTestExcuteEnd(ATimerTask:TObject);
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
  public
    procedure Load(ACopyrightCompany:String;
                    ACopyrightTime:String;
                    //隐私政策
                    APirvacyPolicyUrl:String;
                    //服务协议,用户协议
                    AUserSerivceProtocalUrl:String
                    );
    { Public declarations }
  end;


var
  GlobalAboutUsFrame:TFrameAboutUs;

implementation

uses
  MainForm,
  WebBrowserFrame
//  MyInvitationCodeFrame
  ;


{$R *.fmx}

procedure TFrameAboutUs.btnReturnClick(Sender: TObject);
begin
  if IsRepeatClickReturnButton(Self) then Exit;


  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);

end;

procedure TFrameAboutUs.BtnSendPushNotificationTestClick(Sender: TObject);
begin
  //自己发送推送测试是否成功
  ShowWaitingFrame(Self,'发送中...');
  uTimerTask.GetGlobalTimerThread.RunTempTask(DoSendPushNotificationTestExcute,
                                              DoSendPushNotificationTestExcuteEnd,
                                              'SendPushNotificationTest');

end;

procedure TFrameAboutUs.btnViewPirvacyPolicyClick(Sender: TObject);
begin
  //是网页
  //网页链接
  HideFrame;

  //显示网页界面
  ShowFrame(TFrame(GlobalWebBrowserFrame),TFrameWebBrowser);
  GlobalWebBrowserFrame.LoadUrl(btnViewPirvacyPolicy.TagString,
                                btnViewPirvacyPolicy.Caption
                                );

end;

procedure TFrameAboutUs.btnViewUserServiceProtocolClick(Sender: TObject);
begin
  //是网页
  //网页链接
  HideFrame;

  //显示网页界面
  ShowFrame(TFrame(GlobalWebBrowserFrame),TFrameWebBrowser);
  GlobalWebBrowserFrame.LoadUrl(btnViewUserServiceProtocol.TagString,
                                btnViewUserServiceProtocol.Caption
                                );

end;

constructor TFrameAboutUs.Create(AOwner: TComponent);
begin
  inherited;


  lblVersion.Caption:=Const_APPName+' '+CurrentVersion;


  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);

end;

procedure TFrameAboutUs.DoSendPushNotificationTestExcute(ATimerTask: TObject);
begin
  TTimerTask(ATimerTask).TaskTag := 1;
  try
    TTimerTask(ATimerTask).TaskDesc :=SimpleCallAPI('push_message_to_user',
                                                      nil,
                                                      PushManageInterfaceUrl,
                                                      ['appid',
                                                      'user_fid',
                                                      'key',
                                                      'recv_user_fid',
                                                      'title',
                                                      'message',
                                                      'custom_data_json'],
                                                      [AppID,
                                                       GlobalManager.User.fid,
                                                       GlobalManager.User.key,
                                                       GlobalManager.User.fid, //接收者  自己发给自己
                                                       '推送测试',
                                                       '推送设置检测成功,设置没问题',
                                                       '{"notice_sub_type":"test_push_msg"}'],
                                        GlobalRestAPISignType,
                                        GlobalRestAPIAppSecret
                                                      );
    if TTimerTask(ATimerTask).TaskDesc <> '' then
    begin
      TTimerTask(ATimerTask).TaskTag := 0;
    end;

  except
    on E: Exception do
    begin
      // 异常
      TTimerTask(ATimerTask).TaskDesc := E.Message;
    end;
  end;
end;

procedure TFrameAboutUs.DoSendPushNotificationTestExcuteEnd(ATimerTask: TObject);
var
  //发送返回结果
  ASuperObject: ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag = 0 then
    begin
      ASuperObject := TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code'] = 200 then
//      begin
      //不管成功失败都提示  不用showmessageBoxMessgae  不要弹框
        ShowHintFrame(nil,ASuperObject.S['Desc']);
//      end
//      else
//      begin
//        //发送失败
//        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;

    end
    else if TTimerTask(ATimerTask).TaskTag = 1 then
    begin
      // 网络异常
      ShowMessageBoxFrame(Self, '网络异常,请检查您的网络连接!', TTimerTask(ATimerTask)
        .TaskDesc, TMsgDlgType.mtInformation, ['确定'], nil);
    end;
  finally
    HideWaitingFrame;
  end;
end;

procedure TFrameAboutUs.imgQRBitmapClick(Sender: TObject);
begin

end;

//procedure TFrameAboutUs.DoGetAppUrlExecute(ATimerTask: TObject);
//begin
//  //出错
//  TTimerTask(ATimerTask).TaskTag:=1;
//  try
//    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('get_app_info',
//                                                  nil,
//                                                  InterfaceUrl,
//                                                  ['appid',
//                                                  'key'],
//                                                  [AppID,
//                                                   GlobalManager.User.key
//                                                  ],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//                                                  );
//
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
//end;
//
//procedure TFrameAboutUs.DoGetAppUrlExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//begin
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//
////        //获取成功
////        FUrl:=ASuperObject.O['Data'].A['AppInfo'].O[0].S['app_download_link'];
////        //生成二维码
////        Self.imgQRBitmap.Prop.Picture.ClearPicture;
////
////
////        SyncQRCode(FUrl,TSkinFMXImage(Self.imgQRBitmap));
////        imgQRBitmap.Invalidate;
//
//      end
//      else
//      begin
//        //获取链接失败
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
//
//end;

procedure TFrameAboutUs.Load(ACopyrightCompany:String;
                              ACopyrightTime:String;
                              //隐私政策
                              APirvacyPolicyUrl:String;
                              //服务协议,用户协议
                              AUserSerivceProtocalUrl:String
                              );
begin
//  if FUrl='' then
//  begin
//    ShowWaitingFrame(Self,'加载中...');
//    uTimerTask.GetGlobalTimerThread.RunTempTask(
//                   DoGetAppUrlExecute,
//                   DoGetAppUrlExecuteEnd);
//  end;


  lblCompany.Caption:=ACopyrightCompany;
  lblCopyright.Caption:=ACopyrightTime;


  //版本信息
  Self.lblVersionInfo.Caption:='';
  if GlobalIsGooglePlayVersion then
  begin
    Self.lblVersionInfo.Caption:='谷歌专版';
  end;


  //隐私协议
  Self.btnViewPirvacyPolicy.TagString:=APirvacyPolicyUrl;
  Self.btnViewPirvacyPolicy.Visible:=(APirvacyPolicyUrl<>'');


  //用户服务协议
  Self.btnViewUserServiceProtocol.TagString:=AUserSerivceProtocalUrl;
  Self.btnViewUserServiceProtocol.Visible:=(AUserSerivceProtocalUrl<>'');



//  lblCompany.Visible:=False;
//  lblCopyright.Visible:=False;


//  //申请微信支付,需要显示版权
//  if GlobalManager.ServerHost='www.orangeui.cn' then
//  begin
//    lblCopyright.Visible:=True;
//    lblCompany.Visible:=True;
//  end;

end;

procedure TFrameAboutUs.ShowShareSheetAction1BeforeExecute(Sender: TObject);
//var
//  ATempBitmap:TBitmap;
begin
//  ATempBitmap:=Self.imgQRBitmap.MakeScreenshot;
//  ShowShareSheetAction1.Bitmap.Assign(ATempBitmap);

  //下载链接
//  ShowShareSheetAction1.TextMessage:=FUrl;

//  ATempBitmap.Free;
end;

end.

