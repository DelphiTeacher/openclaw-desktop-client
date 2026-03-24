unit SettingFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uDrawPicture, uUIFunction, uSkinItems, EasyServiceCommonMaterialDataMoudle,
  uManager, uBaseList, uLang, uFuncCommon, HintFrame, uOpenUISetting,
  uViewPictureListFrame,
  uFrameContext,

  MessageBoxFrame, ViewPictureListFrame, uSkinFireMonkeyScrollControl,
  uSkinFireMonkeyCustomList, uSkinFireMonkeyVirtualList, uSkinFireMonkeyListBox,
  uSkinFireMonkeyControl, uSkinFireMonkeyPanel, uSkinFireMonkeyLabel,
  uSkinFireMonkeyItemDesignerPanel, uSkinFireMonkeyButton,
  uSkinFireMonkeyListView, uSkinFireMonkeyImage, uSkinLabelType,
  uSkinItemDesignerPanelType, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinButtonType, uBaseSkinControl,
  uSkinPanelType, uSkinListBoxType, uDrawCanvas, uSkinImageType,
  uSkinRadioButtonType, uSkinFireMonkeyRadioButton, uGraphicCommon,
  uSkinPageControlType;

type
  TFrameSetting = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    lbSetting: TSkinFMXListBox;
    ItemMenu: TSkinFMXItemDesignerPanel;
    lblItemMenuCaption: TSkinFMXLabel;
    lblDetail: TSkinFMXLabel;
    idpLayout: TSkinFMXItemDesignerPanel;
    lblLayout: TSkinFMXLabel;
    imgRight: TSkinFMXImage;
    Item2: TSkinFMXItemDesignerPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    RadioBtn: TSkinFMXRadioButton;
    procedure btnReturnClick(Sender: TObject);
    procedure lbSettingClickItem(AItem: TSkinItem);
    procedure RadioBtnClick(Sender: TObject);
  private
    FBusinessLicenceDrawPicture: TDrawPicture;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    //显示对应功能
    procedure Load;
    //客服联系方式
    procedure OnModalResultFromRiderPhoneNumber(AFrame: TObject);
    { Public declarations }
  end;



var
  GlobalSettingFrame: TFrameSetting;

implementation

uses
  MainForm, uOpenClientCommon, uOpenCommon, UserInfoFrame, ChangePasswordFrame,
  uVersionChecker,
//  PrivacySettingFrame,
//  CommonUseFrame,
  LoginFrame, uConst, AboutUsFrame, MainFrame, RegisterProtocolFrame,
//  uCommonUtils,
  uMobileUtils;



{$R *.fmx}

procedure TFrameSetting.btnReturnClick(Sender: TObject);
begin
  if IsRepeatClickReturnButton(Self) then
    Exit;

  //返回
  HideFrame; //(Self,hfcttBeforeReturnFrame);
  ReturnFrame; //(Self);
end;

constructor TFrameSetting.Create(AOwner: TComponent);
begin
  inherited;

  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);

  FBusinessLicenceDrawPicture := TDrawPicture.Create;

  Self.lbSetting.Prop.Items.FindItemByName('service_phone').Detail := Const_ServiceEmp_Phone;
  Self.lbSetting.Prop.Items.FindItemByName('service_phone').Visible := GlobalIsNeedServiceTel;
end;

destructor TFrameSetting.Destroy;
begin

  FreeAndNil(FBusinessLicenceDrawPicture);
  inherited;
end;

procedure TFrameSetting.lbSettingClickItem(AItem: TSkinItem);
var
  ADrawPictureList: TDrawPictureList;
begin
  if AItem.ItemType = sitItem1 then
  begin

    //退出登录
    frmMain.Logout;

//    //返回我的页面
//    HideFrame; //(Self,hfcttBeforeReturnFrame);
//    ReturnFrame; //(Self);
    ShowLoginFrame();
    GlobalLoginFrame.btnReturn.Visible:=False;



      //测试返回白屏的问题
//      HideFrame;//(Self,hfcttBeforeReturnFrame);
//      ReturnFrame;//(Self);


  end;

  if AItem.Name = 'account_and_safe' then
  begin
      //未登录时调到登录页面
      if GlobalManager.IsLogin = False then
      begin
    //        //隐藏
    //        HideFrame;//(Self,hfcttBeforeShowFrame);
    //        //显示登录页面
    //        ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
    //        GlobalLoginFrame.FrameHistroy:=CurrentFrameHistroy;
        ShowLoginFrame(False);
            //清除输入框
        GlobalLoginFrame.Clear;
      end
      else
      begin
           //跳到我的账户与安全页面
           //隐藏
        HideFrame; //(Self,hfcttBeforeShowFrame);
           //显示登录页面
        ShowFrame(TFrame(GlobalUserInfoFrame), TFrameUserInfo, frmMain, nil, nil, nil, Application);
  //         GlobalUserInfoFrame.FrameHistroy:=CurrentFrameHistroy;
        GlobalUserInfoFrame.Load(GlobalManager.User);

        GlobalUserInfoFrame.Sync;
      end;
  end;

//  if AItem.Caption='通用' then
//  begin
//    //显示通用页面
//    //隐藏
//    HideFrame;//(Self,hfcttBeforeShowFrame);
//    //显示登录页面
//    ShowFrame(TFrame(GlobalCommonUseFrame),TFrameCommonUse,frmMain,nil,nil,nil,Application);
//    GlobalCommonUseFrame.FrameHistroy:=CurrentFrameHistroy;
//    GlobalCommonUseFrame.Load;
//  end;

  if AItem.name = 'change_password' then
  begin
    if GlobalManager.IsLogin = True then
    begin
      //隐藏
      HideFrame; //(CurrentFrame,hfcttBeforeShowFrame);
        //修改密码
      ShowFrame(TFrame(GlobalChangePasswordFrame), TFrameChangePassword, frmMain, nil, nil, nil, Application);
//        GlobalChangePasswordFrame.FrameHistroy:=CurrentFrameHistroy;
      GlobalChangePasswordFrame.Clear;
    end
    else
    begin
//        //隐藏
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//        //显示登录页面
//        ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
//        GlobalLoginFrame.FrameHistroy:=CurrentFrameHistroy;
      ShowLoginFrame(False);
        //清除输入框
      GlobalLoginFrame.Clear;
    end;
  end;

  if AItem.name = 'notification_setting' then
  begin
//    FreeAndNil(GlobalRegisterProtocolFrame);//释放会报错
    //查看协议
    ShowFrame(TFrame(GlobalRegisterProtocolFrame), TFrameRegisterProtocol, frmMain, nil, nil, nil, Application, False, False, ufsefNone);
    GlobalRegisterProtocolFrame.Load(Trans('接收通知设置'), Const_OpenWebRoot+'/android_push_setting.html');
    GlobalRegisterProtocolFrame.pnlButton.Visible:=False;
    GlobalRegisterProtocolFrame.btnClose.Visible:=True;
  end;

  if AItem.name = 'service_phone' then
  begin
    if IsMobPhone(Const_ServiceEmp_Phone) then
    begin
      ShowMessageBoxFrame(Self, Trans('电话: ') + Const_ServiceEmp_Phone, '', TMsgDlgType.mtInformation, [Trans('呼叫'), Trans('取消')], OnModalResultFromRiderPhoneNumber);
    end;
  end;

  if AItem.name = 'business_licence' then
  begin
      //显示证件照
    if (GlobalManager.AppJson.S['business_licence_pic_path'] <> '') then
    begin
          //查看照片信息
      HideFrame; //();
          //查看照片信息
      ShowFrame(TFrame(GlobalViewPictureListFrame), TFrameViewPictureList);
//          GlobalViewPictureListFrame.FrameHistroy:=CurrentFrameHistroy;
      ADrawPictureList := TDrawPictureList.Create(ooReference);
      try
        FBusinessLicenceDrawPicture.Url := GetImageUrl(GlobalManager.AppJson.S['business_licence_pic_path']);
        ADrawPictureList.Add(FBusinessLicenceDrawPicture);

        GlobalViewPictureListFrame.Init(Trans('营业执照'), ADrawPictureList, 0, nil,                                              //不能保存
          False);
      finally
        FreeAndNil(ADrawPictureList);
      end;
    end
    else
    begin
      ShowHintFrame(nil, Trans('没有营业执照照片!'));
    end;
  end;

  //隐私设置
  if AItem.Name = 'ItemPrivacy' then
  begin
    //未登录时调到登录页面
    if GlobalManager.IsLogin = False then
    begin
      ShowLoginFrame(False);
          //清除输入框
      GlobalLoginFrame.Clear;
    end
    else
    begin
       //跳到隐私设置页面
     // 隐藏
//        HideFrame;//(CurrentFrame,hfcttBeforeShowFrame);
//        ShowFrame(TFrame(GlobalPrivacySettingFrame),TFramePrivacySetting,frmMain,nil,nil,nil,Application);
//        GlobalPrivacySettingFrame.Load;

    end;
  end;

  //版本更新
  if AItem.Name = 'ItemVersion' then
  begin
    try

      //升级版本的线程调用放在最后面,以免影响其他接口调用的速度
      {$IFDEF ANDROID}
      GlobalVersionChecker.IsGooglePlayVersion := GlobalIsGooglePlayVersion;
      {$ENDIF}


//      if AppUpdateServerUrl <> '' then
//      begin
//        GlobalVersionChecker.FIsManualCheckUpdate:=True;
//        GlobalVersionChecker.//CheckNewVersion(AppUpdateServerUrl,ImageHttpServerUrl);
//                              CheckNewVersionByIni(
//                              AppUpdateServerUrl + '/Upload/' + Const_APPEnName + '/' + 'Update/' + AppUserTypeName + '/' + 'Version.ini',
//                              AppUpdateServerUrl + '/Upload/' + Const_APPEnName + '/' + 'Update/' + APPUserTypeName,
//                              True);
//      end;

        GlobalVersionChecker.FIsManualCheckUpdate:=True;
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


    except
      on E: Exception do
      begin
        FMX.Types.Log.d('OrangeUI TfrmMain.FormShow ' + E.Message);
      end;
    end;
  end;

  if AItem.name = 'about_us' then
  begin
    //显示关于页面
    //隐藏
    HideFrame; //(CurrentFrame,hfcttBeforeShowFrame);
    //显示登录页面
    ShowFrame(TFrame(GlobalAboutUsFrame), TFrameAboutUs, frmMain, nil, nil, nil, Application);

//    if AppID=1004 then
//    begin
//      GlobalAboutUsFrame.Load('深圳亿诚服务管理合伙企业(有限合伙)',
//                              'Copyright @2016-2019');
//    end
//    else
//    begin
    GlobalAboutUsFrame.Load(Const_CopyrightCompany, Const_CopyrightTime,                              //隐私协议
      Const_RegisterProtocolUrl, '');
//    end;
  end;
end;

procedure TFrameSetting.Load;
begin
  Self.lbSetting.Prop.Items.FindItemByName('ItemVersion').Detail := '当前版本 ' + CurrentVersion;

  if GlobalManager.AutoPlayVideoOnWiFi = 'true' then
    Self.lbSetting.Prop.Items.FindItemByName('ItemWifi').Checked := True
  else
    Self.lbSetting.Prop.Items.FindItemByName('ItemWifi').Checked := False;
  if GlobalManager.AutoPlayVideoWithoutWiFi = 'true' then
    Self.lbSetting.Prop.Items.FindItemByName('ItemWithoutWifi').Checked := True
  else
    Self.lbSetting.Prop.Items.FindItemByName('ItemWithoutWifi').Checked := False;
  Self.lbSetting.Prop.Items.FindItemByType(sitItem1).Visible:=GlobalManager.IsLogin;

//  //business_licence
//  Self.lbSetting.Prop.Items.FindItemByName('business_licence').Visible:=
//    (GlobalManager.AppJson<>nil) and (GlobalManager.AppJson.S['business_licence_pic_path']<>'');

end;

procedure TFrameSetting.OnModalResultFromRiderPhoneNumber(AFrame: TObject);
begin
  if TFrameMessageBox(AFrame).ModalResult = Trans('呼叫') then
  begin
    uMobileUtils.Dail(Const_ServiceEmp_Phone);
  end;
end;

procedure TFrameSetting.RadioBtnClick(Sender: TObject);
begin
  if lbSetting.Prop.InteractiveItem <> nil then
  begin
    lbSetting.Prop.InteractiveItem.Checked := not RadioBtn.Prop.Checked;
    if lbSetting.Prop.InteractiveItem.Name = 'ItemWifi' then
    begin
      if lbSetting.Prop.InteractiveItem.Checked then
        GlobalManager.AutoPlayVideoOnWiFi := 'true'
      else
        GlobalManager.AutoPlayVideoOnWiFi := 'false';

      GlobalManager.Save;
    end;

    if lbSetting.Prop.InteractiveItem.Name = 'ItemWithoutWifi' then
    begin
      if lbSetting.Prop.InteractiveItem.Checked then
        GlobalManager.AutoPlayVideoWithoutWiFi := 'true'
      else
        GlobalManager.AutoPlayVideoWithoutWiFi := 'false';
      GlobalManager.Save;
    end;
  end;

end;

end.

