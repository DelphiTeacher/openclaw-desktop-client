unit LoginFrame;

interface

{$I OpenPlatformClient.inc}

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
//  uFileCommon,
//  uComponentType,
//  IOUtils,
//  IdURI,


  uBaseLog,
  uOpenClientCommon,
  uOpenCommon,
  uOpenUISetting,
  uFuncCommon,
  uSkinItems,
//  uTimerTask,
  uFrameContext,

  {$IFDEF HAS_WXPAY}
  //微信登录
  uWeiChat,
  {$ENDIF HAS_WXPAY}

  {$IFDEF HAS_ALIPAY}
  //支付宝登录
  uAlipayMobilePay,
  {$ENDIF HAS_WXPAY}

  {$IFDEF HAS_FACEBOOK}
  FBLoginCommon,
  {$ENDIF HAS_FACEBOOK}



//  uBaseThirdPartyAccountAuth,
//  uThirdPartyAccountAuth,



  {$IFDEF HAS_APPLESIGNIN}
  uAppleSignIn,
  {$ENDIF HAS_APPLESIGNIN}

  WaitingFrame,
  MessageBoxFrame,

//  uAppleSignIn,
  uSkinListBoxType,
//  uOpenCommon,

  uConst,
  uLang,



  HintFrame,
  uManager,
//  uGetDeviceInfo,
  uRestInterfaceCall,
//  uCommonUtils,
  uTimerTask,
  uUIFunction,
  XSuperObject,
  XSuperJson,
  uBaseHttpControl,
  PopupMenuFrame,
  CommonImageDataMoudle,
  EasyServiceCommonMaterialDataMoudle,

  SelectAccountSetFrame,

  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uSkinFireMonkeyControl, uSkinFireMonkeyPanel, uSkinFireMonkeyScrollControl,
  uSkinFireMonkeyScrollBox,
  uSkinFireMonkeyScrollBoxContent, uSkinMaterial, uSkinPanelType,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit, uSkinEditType,
  uSkinFireMonkeyButton, uSkinFireMonkeyLabel, uSkinFireMonkeyCheckBox,
  uSkinFireMonkeyImage, uSkinFireMonkeyCustomList, uSkinFireMonkeyVirtualList,
  uSkinFireMonkeyListBox, uSkinFireMonkeyItemDesignerPanel,
  uSkinItemDesignerPanelType, uSkinCustomListType, uSkinVirtualListType,
  uSkinLabelType, uSkinImageType, uSkinButtonType, uSkinScrollBoxContentType,
  uBaseSkinControl, uSkinScrollControlType, uSkinScrollBoxType,
  uSkinListViewType, uSkinFireMonkeyListView,

//  FBLoginCommon,
  System.ImageList, FMX.ImgList, uDrawPicture, uSkinImageList, uDrawCanvas,
//  uBaseNativeControl,
  FMX.Objects, uTimerTaskEvent;




type
  TFrameLogin = class(TFrame)//,IFrameVirtualKeyboardAutoProcessEvent)
    sbLogin: TSkinFMXScrollBox;
    sbcLogin: TSkinFMXScrollBoxContent;
    btnLogin: TSkinFMXButton;
    pnlLogo: TSkinFMXPanel;
    pnlBottom: TSkinFMXPanel;
    lblRegister: TSkinFMXLabel;
    lblServerSetting: TSkinFMXLabel;
    idpLogin: TSkinFMXItemDesignerPanel;
    imgPicture: TSkinFMXImage;
    lblName: TSkinFMXLabel;
    lblThirdLogin: TSkinFMXLabel;
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    btnLoginByCaptcha1: TSkinFMXButton;
    pnlPassword: TSkinFMXPanel;
    edtPassWord: TSkinFMXEdit;
    btnClearPassword: TSkinFMXButton;
    pnlPhone: TSkinFMXPanel;
    edtUser: TSkinFMXEdit;
    btnClearUser: TSkinFMXButton;
    lblForgetPassword: TSkinFMXLabel;
    pnlThirdLogin: TSkinFMXPanel;
    lvThirdLogin: TSkinFMXListView;
    lblTestAccount: TSkinFMXLabel;
    lblTestWeichat: TSkinFMXLabel;
    pnlThirdLoginButtons: TSkinFMXPanel;
    btnLoginByWeixin: TSkinFMXButton;
    btnLoginByAlipay: TSkinFMXButton;
    btnZH: TSkinFMXButton;
    btnEN: TSkinFMXButton;
    pnlCaptcha: TSkinFMXPanel;
    edtCaptcha: TSkinFMXEdit;
    btnSendCaptcha: TSkinFMXButton;
    tmrSendCaptchaCheck: TTimer;
    btnLoginByPassword: TSkinFMXButton;
    btnLoginByCaptcha: TSkinFMXButton;
    tteGetAccountAppList: TTimerTaskEvent;
    pnlCompanyName: TSkinFMXPanel;
    edtCompanyName: TSkinFMXEdit;
    btnLoginByFacebook: TSkinFMXButton;
    btnCompanyName: TSkinFMXButton;
    imgLogo: TSkinFMXImage;
    pnlBottomSetting: TSkinFMXPanel;
    imgSetting: TSkinFMXImage;
    pnlCenter: TSkinFMXPanel;
    SkinFMXPanel1: TSkinFMXPanel;
    procedure btnLoginClick(Sender: TObject);
    procedure lblRegisterClick(Sender: TObject);
    procedure lblForgetPasswordClick(Sender: TObject);
    procedure lblServerSettingClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure lvThirdLoginClickItem(AItem: TSkinItem);
    procedure edtUserChangeTracking(Sender: TObject);
    procedure edtPassWordChangeTracking(Sender: TObject);
    procedure btnClearUserClick(Sender: TObject);
    procedure btnClearPasswordClick(Sender: TObject);
    procedure btnLoginByCaptcha1Click(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure lblTestAccountClick(Sender: TObject);
    procedure lblTestWeichatClick(Sender: TObject);
    procedure btnLoginByAppleClick(Sender: TObject);
    procedure btnLoginByWeixinClick(Sender: TObject);
    procedure btnLoginByAlipayClick(Sender: TObject);
    procedure btnZHClick(Sender: TObject);
    procedure btnENClick(Sender: TObject);
    procedure btnSendCaptchaClick(Sender: TObject);
    procedure tmrSendCaptchaCheckTimer(Sender: TObject);
    procedure btnLoginByPasswordClick(Sender: TObject);
    procedure btnLoginByCaptchaClick(Sender: TObject);
    procedure edtPassWordKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtCaptchaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edtUserExit(Sender: TObject);
    procedure tteGetAccountAppListBegin(ATimerTask: TTimerTask);
    procedure tteGetAccountAppListExecute(ATimerTask: TTimerTask);
    procedure tteGetAccountAppListExecuteEnd(ATimerTask: TTimerTask);
    procedure btnLoginByFacebookClick(Sender: TObject);
    procedure imgSettingClick(Sender: TObject);
//  private
//    //当前需要处理的控件
//    function GetCurrentPorcessControl(AFocusedControl:TControl):TControl;
//    function GetVirtualKeyboardControlParent:TControl;
  private
//    FLoginUser:String;
//    FLoginPassword:String;


    //登录类型
    FLoginType:String;
    {$IFDEF HAS_APPLESIGNIN}
    btnLoginByApple: TSkinASAuthorizationAppleIDButton;
    {$ENDIF HAS_APPLESIGNIN}

//  private
//    //FaceBook登录
//    FFbOpenId:String;
//    FFbAuthToken:String;
//    //facebook 授权返回
//    procedure DoFacebookLoginSuccess(Sender:TObject;AName,AGender,AUserID,ALocal,AUrl,AEmail,AToken:String);
//    procedure DoFacebookLoginCancel(Sender:TObject);
//    procedure DoFacebookLoginError(Sender:TObject;AError:String);
//  private
//    FWxOpenID:String;
//    FWxAuthToken:String;
//    //微信登录
//    procedure WeiChatLogin(AWeiXinString:String);
//    //微信返回事件
//    procedure DoWeiChatAuthLoginResult(Sender:TObject;
//                                  //微信授权后的信息
//                                    //昵称
//                                    ANickName:String;
//                                    //OpenID
//                                    AOpenID:String;
//                                    AUnionID:String;
//                                    //授权号,用于获取用户信息
//                                    AAccessToken:String;
//                                    //头像下载链接
//                                    AHeadImgUrl:String;
//                                    AHeadImgLocalFilePath:String;
//                                    //
//                                    AAuthCode:String;
//
//                                    //加载用户信息出错信息
//                                    ADoLoadUserInfoError:String;
//                                    AResponseCode:Integer;
//                                    AIsSucc:Boolean);
//    procedure DoWeiChatAuthLoginError(Sender:TObject);
//  private
//    FAlipayOpenID:String;
//    FAlipayAuthToken:String;
//    //微信登录
//    procedure AlipayLogin(AWeiXinString:String);
//    //微信返回事件
//    procedure DoAlipayAuthLoginResult(Sender:TObject;
//                                        //昵称
//                                        ANickName:String;
//                                        //支付宝用户ID
//                                        AUserId:String;
//                                        //获取用户信息的授权码
//                                        AAuthToken:String;
//                                        //头像下载链接
//                                        AHeadImgUrl:String;
//                                        //头像缓存在本地的路径
//                                        AHeadImgLocalFilePath:String;
//
//                                        //加载用户信息出错信息
//                                        ALoadUserInfoError:String;
//                                        //用户信息
////                                        AUserInfoJson:ISuperObject;
//
//                                        //授权登录返回
//                                        AAuthLoginResultJson:String;
//                                        AIsAuthLoginSucc:Boolean);
////    procedure DoAlipayAuthLoginError(Sender:TObject);
//
//    procedure OnGetAlipayAuthLoginUrlExecute(ATimerTask: TObject);
//    procedure OnGetAlipayAuthLoginUrlExecuteEnd(ATimerTask: TObject);
//  private
//    FAppleOpenID:String;
//    FAppleAuthToken:String;
//    //苹果登录
//    procedure AppleLogin(AWeiXinString:String);
//    //苹果返回事件
//    procedure DoAppleAuthLoginResult(Sender: TObject; AUser, AFamilyName,
//                  AMiddleName, AGivenName, ANickName, AEmail, APassword: string;
//                  AAuthorizationCredential: Pointer);
//    procedure DoAppleAuthLoginError(Sender: TObject; AError: string;
//                  AErrorCode: Integer);

//  private
//    //用户名称
//    FUserName:String;
//    FUserHeadPicFilePath:String;
//
//    //调用判断三方账号是否存在接口
//    procedure DoIsThirdPartyAccountExecute(ATimerTask:TObject);
//    //判断三方账号是否存在事件
//    procedure DoIsThirdPartyAccountExecuteEnd(ATimerTask:TObject);
//  private
//    //跳转到注册界面用
//    FRegisterLoginType:String;

//  private
//    //IFrameHistroyVisibleEvent
//    //显示Frame
//    procedure DoShow;
//    //隐藏Frame
//    procedure DoHide;
  private

    procedure ChangeLoginType(ALoginType:String);

    //调用登录接口
    procedure DoLoginExecute(ATimerTask:TObject);
    //统一的登录结束事件
    procedure DoLoginExecuteEnd(ATimerTask:TObject);

    //三方平台的开放平台ID不存在,表示没有登录过
    procedure DoThirdPartyAccountNoExist(Sender:TObject);
    // 弹出框,选择APP授权
    procedure DoMenuClickFromSelectAppIDPopupMenuFrame(APopupMenuFrame: TFrame);
    procedure SetApp(AAppJson:ISuperObject);
  private
    // 发送验证码
    procedure DoSendRegisterCaptchaExecute(ATimerTask: TObject);
    procedure DoSendRegisterCaptchaExecuteEnd(ATimerTask: TObject);
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    //登陆之后是否返回
    IsLoginedThenReturn:Boolean;

    procedure DoLoginSucc(Sender:TObject);

    //清除密码(在退出登录时使用)
    procedure ClearPass;
    //清除用户名和密码
    procedure Clear;//(ADefaultLoginType:String=Const_RegisterLoginType_PhoneNum_PassWord);
  end;





var
  GlobalLoginFrame:TFrameLogin;


//  //自定义扩展的登录事件,用于获取额外的数据
//  OnCustomLoginExecute:TTaskNotify;
//  OnCustomLoginExecuteEnd:TTaskNotify;




implementation

uses
  MainForm,
  RegisterFrame,
  ForgetPasswordFrame,
  ServerSettingFrame,
//  LoginByCaptcha,
  MainFrame;



{$R *.fmx}

//procedure TFrameLogin.AlipayLogin(AWeiXinString: String);
//begin
//  uBaseLog.HandleException('TFrameLogin.AlipayLogin');
//
//  {$IFDEF HAS_ALIPAY}
//  uBaseLog.HandleException('TFrameLogin.AlipayLogin Begin');
//  GlobalAlipayMobilePay.OnAuthLoginResult:=Self.DoAlipayAuthLoginResult;
////  GlobalAlipayMobilePay.OnAuthLoginError:=Self.DoWeiChatAuthLoginError;
//  GlobalAlipayMobilePay.OnCustomGetUserInfo:=GlobalUserBindThirdPartyAccount.DoCustomGetUserInfo;
//
////  if not GlobalAlipayMobilePay.AuthLogin() then
////  begin
////    ShowMessageBoxFrame(nil,Trans('发送请求失败!'));
////  end;
//
//
//  uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                         OnGetAlipayAuthLoginUrlExecute,
//                                         OnGetAlipayAuthLoginUrlExecuteEnd,
//                                         'GetAlipayAuthLoginUrl');
//
//
//  uBaseLog.HandleException('TFrameLogin.AlipayLogin End');
//  {$ENDIF HAS_ALIPAY}
//
//end;
//
//procedure TFrameLogin.AppleLogin(AWeiXinString: String);
//begin
//  uBaseLog.HandleException('TFrameLogin.AppleLogin');
//
//  uBaseLog.HandleException('TFrameLogin.AppleLogin Begin');
//
//  {$IFDEF HAS_APPLESIGNIN}
//  GlobalAppleSignIn.OnAuthorization:=Self.DoAppleAuthLoginResult;
//  GlobalAppleSignIn.OnError:=Self.DoAppleAuthLoginError;
//
//
//  GlobalAppleSignIn.SignIn;
//  {$ENDIF HAS_APPLESIGNIN}
//
//
//  uBaseLog.HandleException('TFrameLogin.AppleLogin End');
//
//end;

procedure TFrameLogin.btnClearPasswordClick(Sender: TObject);
begin
  Self.edtPassWord.Text:='';
end;

procedure TFrameLogin.btnClearUserClick(Sender: TObject);
begin
  Self.edtUser.Text:='';
end;

procedure TFrameLogin.btnENClick(Sender: TObject);
begin
//  GlobalManager.LangKind:=lkEN;
  ChangeLanguage(lkEN);
  TranslateSubControlsLang(Self);
end;

procedure TFrameLogin.btnLoginByFacebookClick(Sender: TObject);
begin
//  GlobalUserBindThirdPartyAccount.FacebookAction(tpaatLogin);

end;

procedure TFrameLogin.btnLoginClick(Sender: TObject);
begin
  HideVirtualKeyboard;



  if AppID='' then
  begin
    ShowMessageBoxFrame(Self,'授权不能为空!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;


  if pnlCompanyName.Visible and (Self.edtCompanyName.Text='') then
  begin
    ShowMessageBoxFrame(Self,'请输入公司名称!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;


  if (Const_APPLoginType=Const_RegisterLoginType_PhoneNum) or (Const_APPLoginType=Const_RegisterLoginType_PhoneNum_Password) then
  begin
      //用手机号登陆
      if Self.edtUser.Text='' then
      begin
        ShowMessageBoxFrame(Self,Trans('请输入手机号!'),'',TMsgDlgType.mtInformation,['确定'],nil);
        Exit;
      end;
  end
  else
  begin
      //用邮箱登陆
      if Self.edtUser.Text='' then
      begin
        ShowMessageBoxFrame(Self,Trans('请输入用户名!'),'',TMsgDlgType.mtInformation,['确定'],nil);
        Exit;
      end;
  end;



  //如果是手机验证
  if IsMobPhone(Self.edtUser.Text)=True then
  begin
//    if Self.edtCaptcha.Text='' then
    if Self.pnlPassword.Visible then
    begin
      FLoginType:=Const_RegisterLoginType_PhoneNum_PassWord;
    end
    else
    begin
      //手机验证码登记录
      FLoginType:=Const_RegisterLoginType_PhoneNum_Captcha;
    end;
  end
  else if CheckEmail(Self.edtUser.Text)  then
  begin
    //邮箱
    FLoginType:=Const_RegisterLoginType_Email;
  end
  else
  begin
    ShowMessageBoxFrame(Self,Trans('输入的用户名不合法!'),'',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;



  if Self.pnlPassword.Visible then//FLoginType<>Const_RegisterLoginType_PhoneNum_Captcha then
  begin

    if Trim(Self.edtPassWord.Text) = '' then
    begin
      ShowMessageBoxFrame(Self, Trans('请输入密码!'), '', TMsgDlgType.mtInformation,['确定'], nil);
      Exit;
    end;
  end;


  if Self.pnlCaptcha.Visible then//FLoginType=Const_RegisterLoginType_PhoneNum_Captcha then
  begin
    if Trim(Self.edtCaptcha.Text) = '' then
    begin
      ShowMessageBoxFrame(Self, Trans('请输入验证码!'), '', TMsgDlgType.mtInformation,['确定'], nil);
      Exit;
    end;
  end;



//  FLoginUser:=Self.edtUser.Text;
//  FLoginPassword:=Self.edtPassWord.Text;


//  FFbOpenId:='';
//  FFbAuthToken:='';




  ShowWaitingFrame(frmMain,Trans('登录中...'));
  //登录
  uTimerTask.GetGlobalTimerThread.RunTempTask(
      DoLoginExecute,
      DoLoginExecuteEnd,
      'Login'
      );
end;

procedure TFrameLogin.btnLoginByAlipayClick(Sender: TObject);
begin
  //支付宝登陆
//  GlobalUserBindThirdPartyAccount.AlipayAction(tpaatLogin);
end;

procedure TFrameLogin.btnLoginByAppleClick(Sender: TObject);
begin
  //苹果登录
  //Apple授权登录
//  Self.AppleLogin('login');
//  GlobalUserBindThirdPartyAccount.AppleAction(tpaatLogin);
end;

procedure TFrameLogin.btnLoginByCaptcha1Click(Sender: TObject);
begin
//  //验证码登录
//  HideFrame;//(Self,hfcttBeforeShowFrame);
//  ShowFrame(TFrame(GlobalLoginByCaptcha),TFrameLoginByCaptcha,frmMain,nil,nil,nil,Application);
//  GlobalLoginByCaptcha.FrameHistroy:=CurrentFrameHistroy;
//  GlobalLoginByCaptcha.Clear;
end;

procedure TFrameLogin.btnLoginByCaptchaClick(Sender: TObject);
begin
  ChangeLoginType(Const_RegisterLoginType_PhoneNum_Captcha);

end;

procedure TFrameLogin.btnLoginByPasswordClick(Sender: TObject);
begin
  //
  ChangeLoginType(Const_RegisterLoginType_PhoneNum_Password);

end;

procedure TFrameLogin.btnLoginByWeixinClick(Sender: TObject);
begin
//  //微信授权登录
//  Self.WeiChatLogin('login');
//  GlobalUserBindThirdPartyAccount.WeiChatAction(tpaatLogin);
end;

procedure TFrameLogin.btnReturnClick(Sender: TObject);
begin

  //按钮恢复默认
  Self.btnSendCaptcha.Tag := 61;



  HideFrame;//(Self, hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);
end;

procedure TFrameLogin.btnSendCaptchaClick(Sender: TObject);
begin
  HideVirtualKeyboard;

  if AppID='' then
  begin
    ShowMessageBoxFrame(Self,'授权不能为空!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;


  if not CheckEmail(Self.edtUser.Text) then
  begin
      //手机号
      if Self.edtUser.Text = '' then
      begin
        ShowMessageBoxFrame(Self, '请输入手机号!', '', TMsgDlgType.mtInformation,
          ['确定'], nil);
        Exit;
      end;

      if Not IsMobPhone(Self.edtUser.Text) then
      begin
        ShowMessageBoxFrame(Self, '手机号码格式不正确!', '', TMsgDlgType.mtInformation,
          ['确定'], nil);
        Exit;
      end;

  end
  else
  begin
      //邮箱
      if Self.edtUser.Text = '' then
      begin
        ShowMessageBoxFrame(Self, '请输入邮箱地址!', '', TMsgDlgType.mtInformation,
          ['确定'], nil);
        Exit;
      end;

//      if Not IsEmail(Self.edtUser.Text) then
//      begin
//        ShowMessageBoxFrame(Self, '邮箱地址格式不正确!', '', TMsgDlgType.mtInformation,
//          ['确定'], nil);
//        Exit;
//      end;

  end;




  ShowWaitingFrame(Self, '发送中...');

  Self.btnSendCaptcha.Tag := 0;
  Self.btnSendCaptcha.Enabled := False;

  uTimerTask.GetGlobalTimerThread.RunTempTask(DoSendRegisterCaptchaExecute,
    DoSendRegisterCaptchaExecuteEnd,
    'SendRegisterCaptcha');


end;

procedure TFrameLogin.btnZHClick(Sender: TObject);
begin
//  GlobalManager.LangKind:=lkZH;
  ChangeLanguage(lkZH);
  TranslateSubControlsLang(Self);
end;

procedure TFrameLogin.ChangeLoginType(ALoginType: String);
begin

  Self.pnlPassword.Visible:=(ALoginType<>Const_RegisterLoginType_PhoneNum_Captcha);
  Self.pnlCaptcha.Visible:=(ALoginType=Const_RegisterLoginType_PhoneNum_Captcha);

  Self.btnLoginByCaptcha.Visible:=((ALoginType=Const_RegisterLoginType_PhoneNum_Password) or (ALoginType=Const_RegisterLoginType_PhoneNum)) and GlobalIsEnabledPhoneCaptchaLogin;
  Self.btnLoginByPassword.Visible:=(ALoginType=Const_RegisterLoginType_PhoneNum_Captcha);


  AlignControls(pnlLogo,
                Self.pnlPhone,
                Self.pnlCompanyName,
                Self.pnlPassWord,
                Self.pnlCaptcha,
                Self.btnLogin,
                pnlBottom);

end;

procedure TFrameLogin.Clear;//(ADefaultLoginType:String);
begin
  //旋风OnLineApp不要求清除用户名
//  Self.edtUser.Text:='';


//  Self.edtPassWord.Text:='';
  Self.edtCaptcha.Text := '';



  Self.btnZH.Prop.IsPushed:=(LangKind=lkZH);
  Self.btnEN.Prop.IsPushed:=(LangKind=lkEN);


//  Self.pnlPassword.Visible:=(Const_APPLoginType<>Const_RegisterLoginType_PhoneNum_Captcha);
//  Self.pnlCaptcha.Visible:=(Const_APPLoginType=Const_RegisterLoginType_PhoneNum_Captcha);
  ChangeLoginType(Const_APPLoginType);


  //亿诚生活加的
//  {$IFDEF NZ}
//  Self.FRegisterLoginType:=ADefaultLoginType;
//  {$ELSE}
//  Self.FRegisterLoginType:=Const_RegisterLoginType_PhoneNum;
//  {$ENDIF}

//  Self.FRegisterLoginType:=Const_APPLoginType;
end;

procedure TFrameLogin.ClearPass;
begin
  Self.edtPassWord.Text:='';

  //亿诚生活加的
//  {$IFDEF NZ}
//  Self.FRegisterLoginType:=Const_RegisterLoginType_Email;
//  {$ELSE}
//  Self.FRegisterLoginType:=Const_RegisterLoginType_PhoneNum;
//  {$ENDIF}
//  Self.FRegisterLoginType:=Const_APPLoginType;
end;

constructor TFrameLogin.Create(AOwner: TComponent);
var
  I:Integer;
  ATop:Double;
begin
  inherited;


  Self.pnlCaptcha.Visible:=False;


//  Self.lblRegister.Visible:=GlobalIsNeedRegister;
//  Self.lblForgetPassword.Visible:=GlobalIsNeedForgetPassword;

//  Self.lblServerSetting.Visible:=GlobalIsNeedServerSetting;
  if not GlobalIsNeedServerSetting then
  begin
    Self.lblServerSetting.Caption:='';//标题没有了，这样就看不到了
  end;


  Self.lblRegister.Material.DrawCaptionParam.FontColor:=SkinThemeColor;
  Self.lblForgetPassword.Material.DrawCaptionParam.FontColor:=SkinThemeColor;


  // 隐藏登录界面的账套选择
//  Self.pnlCompanyName.Visible:=(Const_APPID='') or GlobalIsNeedAPPIDSetting;
  Self.edtCompanyName.Text:=GlobalManager.CompanyName;//TFramePopupMenu(APopupMenuFrame).ModalResult;
  Self.btnCompanyName.Text:=GlobalManager.CompanyName;//TFramePopupMenu(APopupMenuFrame).ModalResult;



  //商户端不需要返回按钮,不需要登录的标题
  if APPUserType=utShop then
  begin
    Self.btnReturn.Visible:=False;
//    Self.pnlToolBar.Caption:='商家端登录';
  end;
  if APPUserType=utClient then
  begin
    Self.btnReturn.Visible:=False;
//    Self.pnlToolBar.Caption:='客户端登录';
  end;
  if APPUserType=utRider then
  begin
    Self.btnReturn.Visible:=False;
//    Self.pnlToolBar.Caption:='骑手端登录';
  end;
  if APPUserType=utEmp then
  begin
    Self.btnReturn.Visible:=False;
    Self.pnlToolBar.Caption:=Trans('员工端登录');
  end;

//  Self.edtUser.TextPrompt:=Trans('请输入用户名');
//  if Const_APPLoginType=Const_RegisterLoginType_PhoneNum then
//  begin
//    Self.edtUser.TextPrompt:=Trans('请输入手机号');
//  end;
//  if Const_APPLoginType=Const_RegisterLoginType_Email then Self.edtUser.TextPrompt:='请输入邮箱';




  //不显示连接设置
  lblTestAccount.Caption:='';
  lblServerSetting.Caption:='';


  //隐藏清除键
  Self.btnClearUser.Visible:=False;
  Self.btnClearPassword.Visible:=False;



  //加载上次登录的用户名和密码
  GlobalManager.Load;
  //设置上次登录的用户名和密码
  Self.edtUser.Text:=uManager.GlobalManager.LastLoginUser;
  Self.edtPassWord.Text:=uManager.GlobalManager.LastLoginPass;




  //不显示连接设置
//  Self.lblServerSetting.Visible:=False;


  //暂时隐藏其他登录方式
  Self.btnLoginByCaptcha1.Visible:=False;
//  Self.lvThirdLogin.Visible:=True;
//  Self.lblThirdLogin.Visible:=True;


  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);



  //两种登录按钮显示方式
  //一种是用水平ListView,
  //一种是用Button堆起来



  //设置ListView中的按钮是否显示
  //是否启用微信登录
  Self.lvThirdLogin.Prop.Items.FindItemByName('weichat_login').Visible:=
    GlobalIsEnabledWeichatLogin;
  //是否启用支付宝登录
  Self.lvThirdLogin.Prop.Items.FindItemByName('alipay_login').Visible:=
    GlobalIsEnabledAlipayLogin;
  //是否启用Apple登录
//  Self.lvThirdLogin.Prop.Items.FindItemByName('apple_login').Visible:=False;
//  {$IFDEF IOS}
//    if TOSVersion.Check(13) then
//    begin
      Self.lvThirdLogin.Prop.Items.FindItemByName('apple_login').Visible:=
        GlobalIsEnabledAppleLogin;
//    end;
//  {$ENDIF}
//  {$IFDEF MSWINDOWS}
//      //Windows下测试用
//      Self.lvThirdLogin.Prop.Items.FindItemByName('apple_login').Visible:=
//        GlobalIsEnabledAppleLogin;
//  {$ENDIF}
  //是否启用QQ登录
  Self.lvThirdLogin.Prop.Items.FindItemByName('qq_login').Visible:=
    GlobalIsEnabledQQLogin;
  //是否启用Facebook登录
  Self.lvThirdLogin.Prop.Items.FindItemByName('facebook_login').Visible:=
    GlobalIsEnabledFacebookLogin;
  //是否启用Twitter登录
  Self.lvThirdLogin.Prop.Items.FindItemByName('twitter_login').Visible:=
    GlobalIsEnabledTwitterLogin;
  Self.lvThirdLogin.Prop.Items.FindItemByName('phone_captcha_login').Visible:=
    GlobalIsEnabledPhoneCaptchaLogin;
  Self.lvThirdLogin.Prop.Items.FindItemByName('phone_password_login').Visible:=
    GlobalIsEnabledPhonePasswordLogin;





  //之前显示有问题  微信登录和FB登录黏在一起了
  lvThirdLogin.Prop.ColCount:=0;
  for I := 0 to lvThirdLogin.Prop.Items.Count-1 do
  begin
    if lvThirdLogin.Prop.Items.Items[I].Visible=True then
    begin
      lvThirdLogin.Prop.ColCount:=lvThirdLogin.Prop.ColCount+1;
    end;
  end;
  lvThirdLogin.Width:=lvThirdLogin.Prop.ColCount*lvThirdLogin.Prop.ItemWidth;
  //-------------
  //之前的代码
//  lvThirdLogin.Width:=lvThirdLogin.Prop.GetContentWidth;
//  Self.lvThirdLogin.Visible:=lvThirdLogin.Prop.GetContentWidth>1;
  Self.lblThirdLogin.Visible:=lvThirdLogin.Prop.ColCount>1;
//  Self.pnlBottom.Height:=lvThirdLogin.Prop.ColCount*(Self.btnLoginByWeixin.Height+20);
  lvThirdLogin.Visible:=False;






  //一种是用Button堆起来
  btnLoginByWeixin.Visible:=False;
  {$IFDEF HAS_APPLESIGNIN}
  if btnLoginByApple<>nil then
  begin
    btnLoginByApple.Visible:=False;
  end;
  {$ENDIF HAS_APPLESIGNIN}
  btnLoginByAlipay.Visible:=False;
  btnLoginByPassword.Visible:=False;
  btnLoginByCaptcha.Visible:=False;
  btnLoginByFacebook.Visible:=False;
  btnLoginByFacebook.Visible:=False;


  ATop:=10;
  for I := 0 to lvThirdLogin.Prop.Items.Count-1 do
  begin
    if lvThirdLogin.Prop.Items.Items[I].Visible=True then
    begin
        if lvThirdLogin.Prop.Items.Items[I].Name='weichat_login' then
        begin
          btnLoginByWeixin.Visible:=True;
          Self.btnLoginByWeixin.Top:=ATop;
          ATop:=ATop+Self.btnLoginByWeixin.Height+Self.btnLoginByWeixin.Margins.Top+10;
        end;
        if lvThirdLogin.Prop.Items.Items[I].Name='apple_login' then
        begin
          {$IFDEF HAS_APPLESIGNIN}
          try
            //创建苹果登录图标
            btnLoginByApple:=TSkinASAuthorizationAppleIDButton.Create(Self);
            btnLoginByApple.OnClick:=Self.btnLoginByAppleClick;
            btnLoginByApple.Parent:=btnLoginByWeixin.Parent;
            btnLoginByApple.Margins.Assign(btnLoginByWeixin.Margins);
            //btnLoginByApple.Margins.Top:=20;
            btnLoginByApple.Visible:=True;
            btnLoginByApple.Align:=btnLoginByWeixin.Align;
            btnLoginByApple.Height:=btnLoginByWeixin.Height;
            btnLoginByApple.Fill.Kind:=TBrushKind.None;
            btnLoginByApple.Stroke.Kind:=TBrushKind.None;

            btnLoginByApple.Visible:=True;
            Self.btnLoginByApple.Position.Y:=ATop;
            ATop:=ATop+Self.btnLoginByApple.Height+Self.btnLoginByApple.Margins.Top+10;
          except

          end;
          {$ENDIF HAS_APPLESIGNIN}
        end;
        if lvThirdLogin.Prop.Items.Items[I].Name='alipay_login' then
        begin
          btnLoginByAlipay.Visible:=True;
          Self.btnLoginByAlipay.Position.Y:=ATop;
          ATop:=ATop+Self.btnLoginByAlipay.Height+Self.btnLoginByAlipay.Margins.Top+10;
        end;
        if lvThirdLogin.Prop.Items.Items[I].Name='phone_captcha_login' then
        begin
          btnLoginByCaptcha.Visible:=True;
          Self.btnLoginByCaptcha.Position.Y:=ATop;
          ATop:=ATop+Self.btnLoginByCaptcha.Height+Self.btnLoginByCaptcha.Margins.Top+10;
        end;
        if lvThirdLogin.Prop.Items.Items[I].Name='facebook_login' then
        begin
          btnLoginByFacebook.Visible:=True;
          Self.btnLoginByFacebook.Position.Y:=ATop;
          ATop:=ATop+Self.btnLoginByFacebook.Height+Self.btnLoginByFacebook.Margins.Top+10;
        end;
        if lvThirdLogin.Prop.Items.Items[I].Name='phone_password_login' then
        begin
          btnLoginByPassword.Visible:=True;
          Self.btnLoginByPassword.Position.Y:=ATop;
          ATop:=ATop+Self.btnLoginByPassword.Height+Self.btnLoginByPassword.Margins.Top+10;
        end;
    end;
  end;


  Self.btnZH.Visible:=(AppID='1000');
  Self.btnEN.Visible:=(AppID='1000');


//  GlobalUserBindThirdPartyAccount.OnLoginSucc:=DoLoginSucc;
//  GlobalUserBindThirdPartyAccount.OnThirdPartyAccountNoExist:=DoThirdPartyAccountNoExist;
end;

destructor TFrameLogin.Destroy;
begin
  inherited;
end;

procedure TFrameLogin.DoLoginExecute(ATimerTask: TObject);
var
  ATempTimerTask:TTimerTask;
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  ATempTimerTask:=TTimerTask.Create();
  try




//    //用于门业,先本地服务器登录
//    if Assigned(OnCustomLoginExecute) then
//    begin
//
//      //自定义登录
//      TTimerTask(ATempTimerTask).TaskOtherInfo.Values['User']:=Self.edtUser.Text;
//      TTimerTask(ATempTimerTask).TaskOtherInfo.Values['Password']:=Self.edtPassword.Text;
//
//      OnCustomLoginExecute(ATempTimerTask);
//
//      if ATempTimerTask.TaskTag<>TASK_SUCC then
//      begin
//        //调用没有成功
//        TTimerTask(ATimerTask).TaskDesc:=TTimerTask(ATempTimerTask).TaskDesc;
//        if TTimerTask(ATimerTask).TaskDesc<>'' then
//        begin
//          TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
//        end;
//        Exit;
//      end;
//    end;




    //先开放平台进行登录
    TTimerTask(ATimerTask).TaskDesc:=
      SimpleCallAPI('login',
                    nil,
                    UserCenterInterfaceUrl,
                    ['appid',
                    'user_type',
                    'login_type',
                    'username',
                    'password',
                    'captcha',
                    'version',
                    'phone_imei',
                    'phone_uuid',
                    'phone_type',
                    'os',
                    'os_version',
                    //是否需要返回用户权限
                    'is_need_user_power'

//                    'fb_open_id',
//                    'fb_auth_token',
//
//                    'wx_open_id',
//                    'wx_auth_token',
//
//                    'alipay_open_id',
//                    'alipay_auth_token',
//
//                    'apple_open_id',
//                    'apple_auth_token'
                    ],
                    [AppID,
                    APPUserType,
                    Self.FLoginType,
                    Self.edtUser.Text,//Self.FLoginUser,
                    Self.edtPassword.Text,//FLoginPassword,
                    Self.edtCaptcha.Text,
                    '',
                    '',//GetIMEI,
                    '',//GetUUID,
                    '',//GetPhoneType,
                    '',//GetOS,
                    '',//GetOSVersion,
                    '1'

//                    FFbOpenId,
//                    FFbAuthToken,
//
//                    Self.FWxOpenId,
//                    Self.FWxAuthToken,
//
//                    Self.FAlipayOpenId,
//                    Self.FAlipayAuthToken,
//
//                    Self.FAppleOpenId,
//                    Self.FAppleAuthToken

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

procedure TFrameLogin.DoLoginExecuteEnd(ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
  I: Integer;
begin


  try

//    //用于门业,先本地服务器登录
//    if Assigned(OnCustomLoginExecuteEnd) then
//    begin
//
//      OnCustomLoginExecuteEnd(ATimerTask);
//
//      Exit;
//    end;


    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

          //登录成功
          uManager.GlobalManager.LastLoginUser:=Self.edtUser.Text;
          uManager.GlobalManager.LastLoginPass:=Self.edtPassWord.Text;


          GlobalManager.User.ParseFromJson(ASuperObject.O['Data'].A['User'].O[0]);


          //登录令牌,用于确认用户已经登录
          GlobalManager.User.key:=ASuperObject.O['Data'].S['Key'];

          //保存用户登录key,用于下次自动登陆
          GlobalManager.LastLoginKey:=ASuperObject.O['Data'].S['login_key'];


          GlobalManager.EmployeeJson:=SO();

          DoLoginSucc(Self);




//          if not IsLoginedThenReturn then
//          begin
//              //登陆成功之后返回主页
//              HideFrame;
//              //主窗体接口调用成功
//              frmMain.DoCallLoginAPISucc(False,
//                                          //显示主页MainFrame
//                                          True);
//          end
//          else
//          begin
//              //登陆成功之后返回上一页
//              //主窗体接口调用成功
//              frmMain.DoCallLoginAPISucc(False,
//                                          //不显示主页MainFrame
//                                          False);
//
//              HideFrame;//(CurrentFrame);
//              ReturnFrame;//(Self);
//          end;


      end
      else
      begin
        //登录失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin
      //网络异常
      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',
                            UserCenterInterfaceUrl+#13#10
                            +TTimerTask(ATimerTask).TaskDesc,
                            TMsgDlgType.mtInformation,
                            ['确定'],nil);
    end;
  finally
    HideWaitingFrame;
  end;
end;

procedure TFrameLogin.DoLoginSucc(Sender: TObject);
begin

    if not Self.IsLoginedThenReturn then
    begin
        //登陆成功之后到账套选择界面
        HideFrame;

        ShowFrame(TFrame(GlobalSelectAccountSetFrame),TFrameSelectAccountSet);
        GlobalSelectAccountSetFrame.FUserName:= Self.edtUser.Text;
        GlobalSelectAccountSetFrame.Load;

        //主窗体接口调用成功
//        frmMain.DoCallLoginAPISucc(False,
//                                    //显示主页MainFrame
//                                    True);
    end
    else
    begin
        //登陆成功之后返回上一页
        //主窗体接口调用成功
        frmMain.DoCallLoginAPISucc(False,
                                    //不显示主页MainFrame
                                    False);

        HideFrame;
        ReturnFrame;
    end;

end;


procedure TFrameLogin.DoMenuClickFromSelectAppIDPopupMenuFrame(APopupMenuFrame: TFrame);
begin
  SetApp(TFramePopupMenu(APopupMenuFrame).ModalResultDataJson);
end;

procedure TFrameLogin.DoSendRegisterCaptchaExecute(ATimerTask: TObject);
begin
  // 出错
  TTimerTask(ATimerTask).TaskTag := 1;
    try

      if not CheckEmail(Self.edtUser.Text) then
      begin
        //发验证码给手机
        TTimerTask(ATimerTask).TaskDesc := SimpleCallAPI(
            'send_login_captcha',
            nil,
            UserCenterInterfaceUrl,
            ['appid',
            'user_type',
            'phone'],
            [AppID,
            APPUserType,
            Self.edtUser.Text],
            GlobalRestAPISignType,
            GlobalRestAPIAppSecret);
      end
      else
      begin
        //发验证码给邮箱
        TTimerTask(ATimerTask).TaskDesc := SimpleCallAPI(
            'send_login_captcha',
            nil,
            UserCenterInterfaceUrl,
            ['appid',
            'user_type',
            'account'],
            [AppID,
            APPUserType,
            Self.edtUser.Text],
            GlobalRestAPISignType,
            GlobalRestAPIAppSecret);
      end;

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

procedure TFrameLogin.DoSendRegisterCaptchaExecuteEnd(ATimerTask: TObject);
var
  ASuperObject: ISuperObject;
begin

  try
    if TTimerTask(ATimerTask).TaskTag = 0 then
    begin
      ASuperObject := TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code'] = 200 then
      begin
        // 发送验证码成功
        tmrSendCaptchaCheck.Enabled := True;
      end
      else
      begin
        //按钮恢复默认状态
        Self.btnSendCaptcha.Enabled := True;
        Self.btnSendCaptcha.Tag := 61;
        // 发送验证码失败
        ShowMessageBoxFrame(Self, ASuperObject.S['Desc'], '',
          TMsgDlgType.mtInformation, ['确定'], nil);
      end;

    end
    else if TTimerTask(ATimerTask).TaskTag = 1 then
    begin
      // 网络异常
      ShowMessageBoxFrame(Self, '网络异常,请检查您的网络连接!', TTimerTask(ATimerTask)
        .TaskDesc, TMsgDlgType.mtInformation, ['确定'], nil);
      //按钮恢复默认状态
      tmrSendCaptchaCheck.Enabled := True;
      Self.btnSendCaptcha.Tag := 61;
    end;
  finally
    HideWaitingFrame;
  end;
end;

procedure TFrameLogin.DoThirdPartyAccountNoExist(Sender: TObject);
begin
  HideFrame;//(nil,hfcttBeforeShowFrame);
  ShowFrame(TFrame(GlobalRegisterFrame),TFrameRegister,frmMain,nil,nil,nil,Application);
//  GlobalRegisterFrame.FrameHistroy:=CurrentFrameHistroy;
  GlobalRegisterFrame.Clear;//(Self.FRegisterLoginType);
  GlobalRegisterFrame.pnlToolBar.Caption:=Trans('手机验证');


//  GlobalRegisterFrame.FUserName:=GlobalUserBindThirdPartyAccount.FUserName;
//  GlobalRegisterFrame.FUserHeadPicFilePath:=GlobalUserBindThirdPartyAccount.FUserHeadPicFilePath;
//  GlobalRegisterFrame.FWxUnionID:=FWxUnionID;
//  GlobalRegisterFrame.FWxOpenID:=FWxOpenID;
//  GlobalRegisterFrame.FWxAuthToken:=FWxAuthToken;
//  GlobalRegisterFrame.FAlipayOpenID:=FAlipayOpenID;
//  GlobalRegisterFrame.FAlipayAuthToken:=FAlipayAuthToken;
  GlobalRegisterFrame.Load;//(FUserName,FUserHeadPicFilePath,
//                          FWxOpenID,FWxAuthToken,
//                          FAlipayOpenID,FAlipayAuthToken
//                          );

end;

//procedure TFrameLogin.DoShow;
//begin
//
//end;

procedure TFrameLogin.edtCaptchaKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key=13 then
  begin
    btnLoginClick(nil);
  end;

end;

procedure TFrameLogin.edtPassWordChangeTracking(Sender: TObject);
begin
  if Self.edtPassWord.Text<>'' then
  begin
    Self.btnClearPassword.Visible:=True;
  end
  else
  begin
    Self.btnClearPassword.Visible:=False;
  end;
end;

procedure TFrameLogin.edtPassWordKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key=13 then
  begin
    btnLoginClick(nil);
  end;
end;

procedure TFrameLogin.edtUserChangeTracking(Sender: TObject);
begin
  if  Self.edtUser.Text<>'' then
  begin
    Self.btnClearUser.Visible:=True;
  end
  else
  begin
    Self.btnClearUser.Visible:=False;
  end;
end;

procedure TFrameLogin.edtUserExit(Sender: TObject);
begin

  // (改为登录后弹出选择)
//  if ((Const_APPID='') or GlobalIsNeedAPPIDSetting) and IsMobPhone(Self.edtUser.Text) then
//  begin
//    //需要选择AppID
//    tteGetAccountAppList.Run();
//  end;

end;

procedure TFrameLogin.FrameResize(Sender: TObject);
begin
  //设置高度
  Self.sbcLogin.Height:=Self.Height-Self.pnlToolBar.Height-10;
  Self.pnlLogo.Margins.Top:= (Self.sbcLogin.Height-
                              Self.pnlLogo.Height-
                              Self.pnlPhone.Height-
                              Self.pnlPassword.Height-
                              Self.btnLogin.Height-
                              Self.pnlBottom.Height-50)/2;
end;

//function TFrameLogin.GetCurrentPorcessControl(AFocusedControl:TControl):TControl;
//begin
//  Result:=AFocusedControl;
//end;
//
//function TFrameLogin.GetVirtualKeyboardControlParent: TControl;
//begin
//  Result:=Self;
//end;

procedure TFrameLogin.lblRegisterClick(Sender: TObject);
begin
  //注册          1
  HideFrame;//(Self,hfcttBeforeShowFrame);
  ShowFrame(TFrame(GlobalRegisterFrame),TFrameRegister,frmMain,nil,nil,nil,Application);
//  GlobalRegisterFrame.FrameHistroy:=CurrentFrameHistroy;
  GlobalRegisterFrame.Clear();//(Self.FRegisterLoginType);
end;

procedure TFrameLogin.lblServerSettingClick(Sender: TObject);
begin

  HideVirtualKeyboard;

  //隐藏
  HideFrame;//(Self,hfcttBeforeShowFrame);

  //连接设置
  ShowFrame(TFrame(GlobalServerSettingFrame),TFrameServerSetting,frmMain,nil,nil,nil,Application);
//  GlobalServerSettingFrame.FrameHistroy:=CurrentFrameHistroy;
  GlobalServerSettingFrame.Load;
end;

procedure TFrameLogin.imgSettingClick(Sender: TObject);
begin
  HideVirtualKeyboard;

  //隐藏
  HideFrame;//(Self,hfcttBeforeShowFrame);

  //连接设置
  ShowFrame(TFrame(GlobalServerSettingFrame),TFrameServerSetting,frmMain,nil,nil,nil,Application);
//  GlobalServerSettingFrame.FrameHistroy:=CurrentFrameHistroy;
  GlobalServerSettingFrame.Load;
end;

procedure TFrameLogin.lblTestAccountClick(Sender: TObject);
begin
//  if (FRegisterLoginType='') or (FRegisterLoginType=Const_RegisterLoginType_PhoneNum) then
  if (LangKind=lkZH) then
  begin
      //中国,手机号
      Self.edtUser.Text:='18957901025';
  end
  else
  begin
      //国外,邮箱
      Self.edtUser.Text:='ggggcexx@163.com';
  end;

  if DirectoryExists('E:\MyFiles') then
  begin
    Self.edtPassWord.Text:='123456';
  end;
end;

//procedure TFrameLogin.WeiChatLogin(AWeiXinString:String);
//begin
//  uBaseLog.HandleException('TFrameLogin.WeiChatLogin');
//
//  {$IFDEF HAS_WXPAY}
//  uBaseLog.HandleException('TFrameLogin.WeiChatLogin Begin');
//  GlobalWeiChat.OnAuthLoginResult:=Self.DoWeiChatAuthLoginResult;
////  GlobalWeiChat.OnAuthLoginError:=Self.DoWeiChatAuthLoginError;
//  if not GlobalWeiChat.AuthLogin(frmMain) then
//  begin
//    ShowMessageBoxFrame(nil,Trans('发送请求失败!'));
//  end;
//  uBaseLog.HandleException('TFrameLogin.WeiChatLogin End');
//  {$ENDIF HAS_WXPAY}
//end;
//
//procedure TFrameLogin.DoWeiChatAuthLoginError(Sender: TObject);
//begin
//  //微信授权登录失败
//  {$IFDEF HAS_WXPAY}
////  ShowMessageBoxFrame(nil,GlobalWeiChat.FDoLoadUserInfoError);
//  ShowMessageBoxFrame(nil,Trans('微信授权失败!'));
//  {$ENDIF HAS_WXPAY}
//end;
//
//procedure TFrameLogin.DoWeiChatAuthLoginResult(Sender: TObject;
//                                  //微信授权后的信息
//                                    //昵称
//                                    ANickName:String;
//                                    //OpenID
//                                    AOpenID:String;
//                                    AUnionID:String;
//                                    //授权号,用于获取用户信息
//                                    AAccessToken:String;
//                                    //头像下载链接
//                                    AHeadImgUrl:String;
//                                    AHeadImgLocalFilePath:String;
//                                    //
//                                    AAuthCode:String;
//
//                                    //加载用户信息出错信息
//                                    ADoLoadUserInfoError:String;
//                                    AResponseCode:Integer;
//                                    AIsSucc:Boolean);
//begin
//  {$IFDEF HAS_WXPAY}
//
//  //获取微信登录口令
//  Self.FWxOpenID:=AOpenID;
//  FMX.Types.Log.d('OrangeUI TfrmMain.DoWeiChatAuthLoginResult FOpenId:'+Self.FWxOpenID);
//  Self.FWxAuthToken:=AAccessToken;
//  FMX.Types.Log.d('OrangeUI TfrmMain.DoWeiChatAuthLoginResult FToken:'+Self.FWxAuthToken);
//
//  FLoginUser:='';
//  FLoginPassword:='';
//  FFbOpenId:='';
//  FFbAuthToken:='';
//  Self.FAlipayOpenId:='';
//  Self.FAlipayAuthToken:='';
//  Self.FAppleOpenId:='';
//  Self.FAppleAuthToken:='';
//  FLoginType:=Const_RegisterLoginType_WeiXin;
//
//
//
//  //防止取消微信登陆是显示多余的提示
//  if Trim(Self.FWxOpenID)<>'' then
//  begin
//      //判断是否存在该微信用户
//
//
//      //用户名称
//      FUserName:=ANickName;
//      FUserHeadPicFilePath:=AHeadImgLocalFilePath;
//
//
//      //三方账号登录是否需要完善手机号
//      if not GlobalIsThirdPartyNeedPhone then
//      begin
//          //已经存在该三方账号,则登录
//          ShowWaitingFrame(Self,'登录中...');
//          //微信登录
//          uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                                 DoLoginExecute,
//                                                 DoLoginExecuteEnd,
//                                                 'Login'
//                                                 );
//      end
//      else
//      begin
//          ShowWaitingFrame(Self,'登录中...');
//          //判断是否已经使用微信登录过
//          uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                             Self.DoIsThirdPartyAccountExecute,
//                                             Self.DoIsThirdPartyAccountExecuteEnd,
//                                             'IsThirdPartyAccount'
//                                             );
//      end;
//
//
//  end;
//  {$ENDIF HAS_WXPAY}
//end;

procedure TFrameLogin.lvThirdLoginClickItem(AItem: TSkinItem);
begin
//  //三方授权登录
//  if AItem.Name='weichat_login' then
//  begin
//      //微信授权登录
//      GlobalUserBindThirdPartyAccount.WeiChatAction(tpaatLogin);
//  end;
//
//  if AItem.Name='qq_login' then
//  begin
//
//  end;
//
//  if AItem.Name='facebook_login' then
//  begin
////      {$IFDEF HAS_FACEBOOK}
////
////      InitGlobalFBLoginManager(Const_Facebook_AppId);
////
////      GlobalFBLoginManager.FOnFBLoginSuccess:=DoFacebookLoginSuccess;
////      GlobalFBLoginManager.FOnFBLoginCancel:=DoFacebookLoginCancel;
////      GlobalFBLoginManager.FOnFBLoginError:=DoFacebookLoginError;
////
////      GlobalFBLoginManager.FBSDKLogin;
////
////      {$ENDIF HAS_FACEBOOK}
//      GlobalUserBindThirdPartyAccount.FacebookAction(tpaatLogin);//'login');
//  end;
//
//  if AItem.Name='twitter_login' then
//  begin
//
//  end;
//
//  if AItem.Name='alipay_login' then
//  begin
//      //支付宝授权登录
//      GlobalUserBindThirdPartyAccount.AlipayAction(tpaatLogin);//'login');
//  end;
//
//  if AItem.Name='apple_login' then
//  begin
//      //Apple授权登录
//      GlobalUserBindThirdPartyAccount.AppleAction(tpaatLogin);//'login');
//  end;


end;

procedure TFrameLogin.SetApp(AAppJson: ISuperObject);
begin

  GlobalManager.CompanyName:=AAppJson.S['company_name'];
  AppID:=IntToStr(AAppJson.I['fid']);

  Self.edtCompanyName.Text:=GlobalManager.CompanyName;//TFramePopupMenu(APopupMenuFrame).ModalResult;
  Self.btnCompanyName.Text:=GlobalManager.CompanyName;//TFramePopupMenu(APopupMenuFrame).ModalResult;


  //服务器
  GlobalManager.ServerHost:=AAppJson.S['server'];
  if AAppJson.I['server_port']>0 then
  begin
    //端口,端口不变
    GlobalManager.ServerPort:=AAppJson.I['server_port'];
  end;

  //保存
  GlobalManager.Save;



  //更新客户端连接
  frmMain.SyncServerSetting(GlobalManager.ServerHost,GlobalManager.ServerPort);





//  Self.edtCompanyName.Text:=TFramePopupMenu(APopupMenuFrame).ModalResult;
//  Self.edtAppID.Text:=TFramePopupMenu(APopupMenuFrame).ModalResultName;

//   if TFramePopupMenu(APopupMenuFrame).ModalResult='删除' then
//   begin
//     Self.lvData.Prop.Items.Remove(Self.lvData.Prop.InteractiveItem);
//
//     Self.SyncCount(False);
//
//     //保存草稿
//     SaveToLocal;

//   end;


end;

procedure TFrameLogin.tmrSendCaptchaCheckTimer(Sender: TObject);
begin
  Self.btnSendCaptcha.Tag := Self.btnSendCaptcha.Tag + 1;
  if Self.btnSendCaptcha.Tag > 60 then
  begin
    Self.btnSendCaptcha.Caption := '发送验证码';
    Self.btnSendCaptcha.Enabled := True;
    Self.btnSendCaptcha.Prop.IsPushed := False;

    tmrSendCaptchaCheck.Enabled := False;
  end
  else
  begin
    Self.btnSendCaptcha.Caption := '剩余' +
      IntToStr(60 - Self.btnSendCaptcha.Tag) + '秒';
    Self.btnSendCaptcha.Enabled := False;
    Self.btnSendCaptcha.Prop.IsPushed := True;
  end;

end;

procedure TFrameLogin.tteGetAccountAppListBegin(ATimerTask: TTimerTask);
begin
  ShowWaitingFrame('加载中...');
end;

procedure TFrameLogin.tteGetAccountAppListExecute(ATimerTask: TTimerTask);
begin
    try
        //出错
        TTimerTask(ATimerTask).TaskTag:=1;


        //保存
        TTimerTask(ATimerTask).TaskDesc:=
            SimpleCallAPI('get_account_app_list',
                          nil,
                          CenterInterfaceUrl+'program_framework/',
                          ['phone',
                          'user_type',
                          'filter_app_name'],
                          [Self.edtUser.Text,
                          APPUserType,
                          Const_FilterAPPName
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

procedure TFrameLogin.tteGetAccountAppListExecuteEnd(ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
  ASkinItem:TSkinItem;
  ACompanyNames:TStringDynArray;
  AAppIDs:TStringDynArray;
  I: Integer;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

//         ShowMessageBoxFrame(frmMain,'保存成功!');
//         ShowHintFrame(frmMain,'保存成功!');



//          if Self.lvData.Prop.Items.Count>0 then
//          begin
//            ShowMessageBoxFrame(nil,'列表中还有未提交的条码,请先保存');
//            Exit;
//          end;

        if ASuperObject.O['Data'].A['RecordList'].Length=0 then
        begin
          ShowMessageBoxFrame(nil,'未找到'+Const_FilterAPPName+'的授权');
          Exit;
        end;

        if ASuperObject.O['Data'].A['RecordList'].Length=1 then
        begin
          SetApp(ASuperObject.O['Data'].A['RecordList'].O[0]);
          Exit;
        end;


        //if ASuperObject.O[''] then
        SetLength(ACompanyNames,ASuperObject.O['Data'].A['RecordList'].Length);
        SetLength(AAppIDs,ASuperObject.O['Data'].A['RecordList'].Length);
        for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
        begin
          ACompanyNames[I]:=ASuperObject.O['Data'].A['RecordList'].O[I].S['company_name']
                              //加上应用名称
                              +'-'+ASuperObject.O['Data'].A['RecordList'].O[I].S['name'];
          AAppIDs[I]:=IntToStr(ASuperObject.O['Data'].A['RecordList'].O[I].I['fid']);
        end;


        //选择授权
        ShowFrame(TFrame(GlobalPopupMenuFrame),TFramePopupMenu,frmMain,nil,nil,DoMenuClickFromSelectAppIDPopupMenuFrame,Application,True,True,ufsefNone);
        GlobalPopupMenuFrame.Init('选择授权',
                                  ACompanyNames,
                                  AAppIDS,
                                  '',
                                  False,
                                  320,
                                  ASuperObject.O['Data'].A['RecordList']
                                  );



      end
      else
      begin
          //条码检测失败
          //ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);

//          //已经存在
//          //播放出错的声音
//          if FileExists(GetApplicationPath+'scan_fail.mp3') then
//          begin
//            Self.MediaPlayer1.FileName:=GetApplicationPath+'scan_fail.mp3';
//            Self.MediaPlayer1.Play;
//          end
//          else
//          begin
//            //ShowMessage('声音文件不存在');
//          end;
//
//          SyncCount(True,ASuperObject.S['Desc']);
//
      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin
      //网络异常
      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
    end;
  finally
    HideWaitingFrame;
  end;


end;

//procedure TFrameLogin.OnGetAlipayAuthLoginUrlExecute(
//  ATimerTask: TObject);
//begin
//  //出错
//  TTimerTask(ATimerTask).TaskTag:=1;
//
//  try
//
//    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('new_auth_login_url_by_app',
//                                                    nil,
//                                                    AlipayCenterInterfaceUrl,
//                                                    ['appid'
//                                                    ],
//                                                    [AppID
//                                                    ],
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
//end;
//
//procedure TFrameLogin.OnGetAlipayAuthLoginUrlExecuteEnd(
//  ATimerTask: TObject);
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
//        {$IFDEF HAS_ALIPAY}
//        if not GlobalAlipayMobilePay.AuthLogin(ASuperObject.O['Data'].S['AuthLoginUrl']) then
//        begin
//          ShowMessageBoxFrame(nil,Trans('发送请求给支付宝失败!'));
//        end;
//        {$ENDIF HAS_ALIPAY}
//
//      end
//      else
//      begin
//        //绑定失败
//        ShowMessageBoxFrame(nil,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;
//
//    end
//    else if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(nil,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//    end;
//  finally
////    HideWaitingFrame;
//  end;
//end;


procedure TFrameLogin.lblTestWeichatClick(Sender: TObject);
begin
//  {$IFDEF HAS_WXPAY}
//  GlobalWeiChat.FOpenID:='wx12345678';
//  GlobalWeiChat.FAccessToken:='token12345678';
//  GlobalWeiChat.FNickName:='微信测试78';
//  GlobalWeiChat.FHeadImgUrl:='http://www.orangeui.cn/download/testdownloadpicturemanager/TicketProduct2.png';
//  GlobalWeiChat.FHeadImgLocalFilePath:='C:\Users\Administrator\Documents\qq.jpg';
//
//  DoWeiChatAuthLoginResult(nil);
//  {$ENDIF}
end;

//procedure TFrameLogin.DoAlipayAuthLoginError(Sender: TObject);
//begin
//
//end;

//procedure TFrameLogin.DoAlipayAuthLoginResult(Sender: TObject;
//                                        //昵称
//                                        ANickName:String;
//                                        //支付宝用户ID
//                                        AUserId:String;
//                                        //获取用户信息的授权码
//                                        AAuthToken:String;
//                                        //头像下载链接
//                                        AHeadImgUrl:String;
//                                        //头像缓存在本地的路径
//                                        AHeadImgLocalFilePath:String;
//
//                                        //加载用户信息出错信息
//                                        ALoadUserInfoError:String;
////                                        //用户信息
////                                        AUserInfoJson:ISuperObject;
//
//                                        //授权登录返回
//                                        AAuthLoginResultJson:String;
//                                        AIsAuthLoginSucc:Boolean);
//begin
//  {$IFDEF HAS_ALIPAY}
//
//  //获取支付宝登录口令
//  Self.FAlipayOpenID:=AUserId;
//  FMX.Types.Log.d('OrangeUI TfrmMain.DoWeiChatAuthLoginResult FOpenId:'+Self.FWxOpenID);
//  Self.FAlipayAuthToken:=AAuthToken;
//  FMX.Types.Log.d('OrangeUI TfrmMain.DoWeiChatAuthLoginResult FToken:'+Self.FWxAuthToken);
//
//
//
//
//
//
//
//  FLoginUser:='';
//  FLoginPassword:='';
//  FFbOpenId:='';
//  FFbAuthToken:='';
//  Self.FWxOpenId:='';
//  Self.FWxAuthToken:='';
//  Self.FAppleOpenId:='';
//  Self.FAppleAuthToken:='';
//  FLoginType:=Const_RegisterLoginType_Alipay;
//
//
//
//
//
//  //防止取消支付宝登陆是显示多余的提示
//  if Trim(Self.FAlipayOpenID)<>'' then
//  begin
//      //判断是否存在该支付宝用户
//
//
//      //用户名称
//      FUserName:=ANickName;
//      //用户头像本地地址
//      FUserHeadPicFilePath:=AHeadImgLocalFilePath;
//
//
//
//      //三方账号登录是否需要完善手机号
//      if not GlobalIsThirdPartyNeedPhone then
//      begin
//          //已经存在该三方账号,则登录
//          ShowWaitingFrame(Self,'登录中...');
//          //支付宝登录
//          uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                                 DoLoginExecute,
//                                                 DoLoginExecuteEnd,
//                                                 'Login'
//                                                 );
//      end
//      else
//      begin
//          ShowWaitingFrame(Self,'登录中...');
//          //判断是否已经使用支付宝登录过
//          uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                             Self.DoIsThirdPartyAccountExecute,
//                                             Self.DoIsThirdPartyAccountExecuteEnd,
//                                             'IsThirdPartyAccount'
//                                             );
//      end;
//
//
//  end;
//  {$ENDIF HAS_ALIPAY}
//end;
//
//procedure TFrameLogin.DoAppleAuthLoginError(Sender: TObject; AError: string;
//  AErrorCode: Integer);
//begin
//  ShowMessageBoxFrame(nil,Trans(AError));
//end;
//
//procedure TFrameLogin.DoAppleAuthLoginResult(Sender: TObject; AUser,
//  AFamilyName, AMiddleName, AGivenName, ANickName, AEmail, APassword: string;
//  AAuthorizationCredential: Pointer);
//begin
//
//  //获取Apple登录口令
//  Self.FAppleOpenID:=AUser;
//  FMX.Types.Log.d('OrangeUI TfrmMain.DoAppleAuthLoginResult FOpenId:'+Self.FAppleOpenID);
//  Self.FAppleAuthToken:='';
//  FMX.Types.Log.d('OrangeUI TfrmMain.DoAppleAuthLoginResult FToken:'+Self.FAppleAuthToken);
//
//
//
//
//
//
//
//  FLoginUser:='';
//  FLoginPassword:='';
//  FFbOpenId:='';
//  FFbAuthToken:='';
//  FWxOpenId:='';
//  FWxAuthToken:='';
//  FAlipayOpenId:='';
//  FAlipayAuthToken:='';
//  FLoginType:=Const_RegisterLoginType_Apple;
//
//
//
//
//
//  //防止取消Apple登陆是显示多余的提示
//  if Trim(Self.FAppleOpenID)<>'' then
//  begin
//      //判断是否存在该Apple用户
//
//
//      //用户名称
//      FUserName:=AFamilyName+AMiddleName+AGivenName;
//      //用户头像本地地址
//      FUserHeadPicFilePath:='';
//
//
//
//      //三方账号登录是否需要完善手机号
//      if not GlobalIsThirdPartyNeedPhone then
//      begin
//          //已经存在该三方账号,则登录
//          ShowWaitingFrame(Self,'登录中...');
//          //Apple登录
//          uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                                 DoLoginExecute,
//                                                 DoLoginExecuteEnd,
//                                                 'Login'
//                                                 );
//      end
//      else
//      begin
//          ShowWaitingFrame(Self,'登录中...');
//          //判断是否已经使用Apple登录过
//          uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                             Self.DoIsThirdPartyAccountExecute,
//                                             Self.DoIsThirdPartyAccountExecuteEnd,
//                                             'IsThirdPartyAccount'
//                                             );
//      end;
//
//
//  end;
//
//end;
//
//procedure TFrameLogin.DoFacebookLoginCancel(Sender: TObject);
//begin
//  TThread.Synchronize(nil,
//  procedure
//  begin
//    FMX.Types.Log.d('OrangeUI -- TFrameLogin.DoFacebookLoginCancel');
//  end);
//end;
//
//procedure TFrameLogin.DoFacebookLoginError(Sender: TObject; AError: String);
//begin
//  TThread.Synchronize(nil,
//  procedure
//  begin
//    FMX.Types.Log.d('OrangeUI -- TFrameLogin.Facebook Error '+AError);
//  end);
//end;
//
//procedure TFrameLogin.DoFacebookLoginSuccess(Sender: TObject; AName, AGender, AUserID,
//  ALocal, AUrl, AEmail, AToken: String);
//begin
//  TThread.Synchronize(nil,
//  procedure
//  begin
//     FMX.Types.Log.d('OrangeUI -- TFrameLogin.Facebook AName '+AName);
////    Self.SkinFMXMemo1.Lines.Add('用户名:'+AName);
////    Self.SkinFMXMemo1.Lines.Add('性别:'+AGender);
////    Self.SkinFMXMemo1.Lines.Add('用户ID:'+AUserID);
////    Self.SkinFMXMemo1.Lines.Add('所在地:'+ALocal);
////    Self.SkinFMXMemo1.Lines.Add('头像链接:'+AUrl);
////    Self.SkinFMXMemo1.Lines.Add('邮箱:'+AEmail);
////    Self.SkinFMXMemo1.Lines.Add('Token:'+AToken);
////
////    Self.SkinFMXImage1.Prop.Picture.Url:=AUrl;
//
//    Self.edtUser.Text:=AName;
//
//    FLoginUser:='';
//    FLoginPassword:='';
//    FFbOpenId:=AUserID;
//    FFbAuthToken:=AToken;
//    Self.FWxOpenId:='';
//    Self.FWxAuthToken:='';
//    Self.FAlipayOpenId:='';
//    Self.FAlipayAuthToken:='';
//    Self.FAppleOpenId:='';
//    Self.FAppleAuthToken:='';
//    FLoginType:=Const_RegisterLoginType_FaceBook;
//
//    ShowWaitingFrame(frmMain,'登录中...');
//    //登录
//    uTimerTask.GetGlobalTimerThread.RunTempTask(
//        DoLoginExecute,
//        DoLoginExecuteEnd,
//        'Login'
//        );
//
//  end);
//
//end;

//procedure TFrameLogin.DoHide;
//begin
//
//end;

//procedure TFrameLogin.DoIsThirdPartyAccountExecute(ATimerTask: TObject);
//begin
//  //出错
//  TTimerTask(ATimerTask).TaskTag:=1;
//  try
//
//    TTimerTask(ATimerTask).TaskDesc:=
//      SimpleCallAPI('is_third_party_account_exist',
//                    nil,
//                    UserCenterInterfaceUrl,
//                    ['appid',
//                    'user_type',
//
//                    'fb_open_id',
//                    'fb_auth_token',
//
//                    'wx_open_id',
//                    'wx_auth_token',
//
//                    'alipay_open_id',
//                    'alipay_auth_token',
//
//                    'apple_open_id',
//                    'apple_auth_token'
//                    ],
//                    [AppID,
//                    APPUserType,
//                    FFbOpenId,
//                    FFbAuthToken,
//
//                    Self.FWxOpenId,
//                    Self.FWxAuthToken,
//
//                    Self.FAlipayOpenID,
//                    Self.FAlipayAuthToken,
//
//                    Self.FAppleOpenID,
//                    Self.FAppleAuthToken
//                    ],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//                    );
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
//procedure TFrameLogin.DoIsThirdPartyAccountExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//  I: Integer;
//begin
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//          if ASuperObject.O['Data'].I['is_exist']=1 then
//          begin
//              //已经存在该三方账号,则登录
//              ShowWaitingFrame(Self,'登录中...');
//              //微信登录
//              uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                                     DoLoginExecute,
//                                                     DoLoginExecuteEnd,
//                                                     'Login'
//                                                     );
//          end
//          else
//          begin
//              //不存在,注册,跳转到完善手机号码页面,进行手机验证
//              //注册          1
//              HideFrame;//(Self,hfcttBeforeShowFrame);
//              ShowFrame(TFrame(GlobalRegisterFrame),TFrameRegister,frmMain,nil,nil,nil,Application);
//              GlobalRegisterFrame.FrameHistroy:=CurrentFrameHistroy;
//              GlobalRegisterFrame.Clear(Self.FRegisterLoginType);
//              GlobalRegisterFrame.pnlToolBar.Caption:='手机验证';
//
//
//              GlobalRegisterFrame.FUserName:=FUserName;
//              GlobalRegisterFrame.FUserHeadPicFilePath:=Self.FUserHeadPicFilePath;
//              GlobalRegisterFrame.FWxOpenID:=FWxOpenID;
//              GlobalRegisterFrame.FWxAuthToken:=FWxAuthToken;
//              GlobalRegisterFrame.FAlipayOpenID:=FAlipayOpenID;
//              GlobalRegisterFrame.FAlipayAuthToken:=FAlipayAuthToken;
//              GlobalRegisterFrame.Load(FUserName,FUserHeadPicFilePath,
//                                      FWxOpenID,FWxAuthToken,
//                                      FAlipayOpenID,FAlipayAuthToken
//                                      );
//
//
//          end;
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
//
//end;

procedure TFrameLogin.lblForgetPasswordClick(Sender: TObject);
begin
  HideVirtualKeyboard;

  //隐藏
  HideFrame;//(Self,hfcttBeforeShowFrame);

  //忘记密码
  ShowFrame(TFrame(GlobalForgetPasswordFrame),TFrameForgetPassword,frmMain,nil,nil,nil,Application);
//  GlobalForgetPasswordFrame.FrameHistroy:=CurrentFrameHistroy;
  GlobalForgetPasswordFrame.Clear;

end;






end.
