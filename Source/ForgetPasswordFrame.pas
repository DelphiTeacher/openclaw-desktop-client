//convert pas to utf8 by ¥

unit ForgetPasswordFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uMobileUtils,

  uOpenCommon,
  uOpenClientCommon,
  uConst,
  uLang,
  WaitingFrame,
  MessageBoxFrame,

  FMX.Consts,

  uManager,
  uTimerTask,
  uUIFunction,
  uFuncCommon,
//  uCommonUtils,
  uRestInterfaceCall,
//  uOpenClientCommon,

//  uInterfaceClass,

  XSuperObject,
  XSuperJson,
  uFrameContext,
  uBaseHttpControl,

  EasyServiceCommonMaterialDataMoudle,

  uSkinFireMonkeyButton, FMX.Controls.Presentation, FMX.Edit,
  uSkinFireMonkeyEdit, uSkinFireMonkeyPanel,
  uSkinFireMonkeyScrollBoxContent, uSkinFireMonkeyControl,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyScrollBox, RegisterFrame,
  uSkinScrollBoxContentType, uSkinScrollControlType, uSkinScrollBoxType,
  uSkinButtonType, uBaseSkinControl, uSkinPanelType;

type
  TFrameForgetPassword = class(TFrame)//,IFrameVirtualKeyboardAutoProcessEvent)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    SkinFMXPanel3: TSkinFMXPanel;
    SkinFMXPanel4: TSkinFMXPanel;
    edtPhone: TSkinFMXEdit;
    SkinFMXPanel5: TSkinFMXPanel;
    edtCaptcha: TSkinFMXEdit;
    btnSendCaptcha: TSkinFMXButton;
    SkinFMXPanel6: TSkinFMXPanel;
    btnNext: TSkinFMXButton;
    tmrSendCaptchaCheck: TTimer;
    btnClearUser: TSkinFMXButton;
    btnClearCapcha: TSkinFMXButton;
    procedure btnReturnClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnSendCaptchaClick(Sender: TObject);
    procedure tmrSendCaptchaCheckTimer(Sender: TObject);
    procedure btnClearUserClick(Sender: TObject);
    procedure btnClearCapchaClick(Sender: TObject);
    procedure edtPhoneChangeTracking(Sender: TObject);
//  private
//    //当前需要处理的控件
//    function GetCurrentPorcessControl(AFocusedControl:TControl):TControl;
//    function GetVirtualKeyboardControlParent:TControl;
  private
    FAccount:String;
    FCaptcha:String;

    procedure DoSendCaptchaExecute(ATimerTask:TObject);
    procedure DoSendCaptchaExecuteEnd(ATimerTask:TObject);
  private
    procedure DoCheckCaptchaExecute(ATimerTask:TObject);
    procedure DoCheckCaptchaExecuteEnd(ATimerTask:TObject);
    { Private declarations }
  public
//    FrameHistroy:TFrameHistroy;

    constructor Create(AOwner:TComponent);override;

  public
    procedure Clear;
    { Public declarations }
  end;


var
  GlobalForgetPasswordFrame:TFrameForgetPassword;

implementation

uses
  MainForm,
  ResetPasswordFrame;


{$R *.fmx}

procedure TFrameForgetPassword.btnClearUserClick(Sender: TObject);
begin
  Self.edtPhone.Text:='';
end;

procedure TFrameForgetPassword.btnNextClick(Sender: TObject);
begin
  HideVirtualKeyboard;



//  if Const_APPLoginType=Const_RegisterLoginType_PhoneNum then
  if LangKind=lkZH then
  begin
      //中国,手机号
      if Self.edtPhone.Text='' then
      begin
        ShowMessageBoxFrame(Self,Trans('请输入手机号!'),'',TMsgDlgType.mtInformation,['确定'],nil);
        Exit;
      end;
      if Not IsMobPhone(Self.edtPhone.Text) then
      begin
        ShowMessageBoxFrame(Self,Trans('输入的手机号不合法!'),'',TMsgDlgType.mtInformation,['确定'],nil);
        Exit;
      end;
  end
  else
  begin
      //国外,邮箱
      if Self.edtPhone.Text='' then
      begin
        ShowMessageBoxFrame(Self,Trans('请输入用户名!'),'',TMsgDlgType.mtInformation,['确定'],nil);
        Exit;
      end;
      if Not CheckEmail(Self.edtPhone.Text) then
      begin
        if Not IsMobPhone(Self.edtPhone.Text) then
        begin
          ShowMessageBoxFrame(Self,Trans('输入的用户名不合法!'),'',TMsgDlgType.mtInformation,['确定'],nil);
          Exit;
        end;
      end;
  end;


  if Self.edtCaptcha.Text='' then
  begin
    ShowMessageBoxFrame(Self,Trans('请输入验证码!'),'',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;



  ShowWaitingFrame(Self,Trans('验证中...'));


  FAccount:=Trim(Self.edtPhone.Text);
  FCaptcha:=Trim(Self.edtCaptcha.Text);


  uTimerTask.GetGlobalTimerThread.RunTempTask(DoCheckCaptchaExecute,
                                              DoCheckCaptchaExecuteEnd,
                                              'CheckCaptcha');


end;

procedure TFrameForgetPassword.btnReturnClick(Sender: TObject);
begin
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self.FrameHistroy);

end;

procedure TFrameForgetPassword.btnSendCaptchaClick(Sender: TObject);
var
  ATimerTask:TTimerTask;
begin
  HideVirtualKeyboard;


//  if Const_APPLoginType=Const_RegisterLoginType_PhoneNum then
  if LangKind=lkZH then
  begin
      //中国,手机号
      if Trim(Self.edtPhone.Text)='' then
      begin
        ShowMessageBoxFrame(Self,Trans('请输入手机号!'),'',TMsgDlgType.mtInformation,['确定'],nil);
        Exit;
      end;
      if Not IsMobPhone(Self.edtPhone.Text) then
      begin
        ShowMessageBoxFrame(Self,Trans('输入的手机号不合法!'),'',TMsgDlgType.mtInformation,['确定'],nil);
        Exit;
      end;
  end
  else
  begin
      //国外,邮箱
      if Trim(Self.edtPhone.Text)='' then
      begin
        ShowMessageBoxFrame(Self,Trans('请输入用户名!'),'',TMsgDlgType.mtInformation,['确定'],nil);
        Exit;
      end;
      if Not CheckEmail(Self.edtPhone.Text) then
      begin
        if Not IsMobPhone(Self.edtPhone.Text) then
        begin
          ShowMessageBoxFrame(Self,Trans('输入的用户名不合法!'),'',TMsgDlgType.mtInformation,['确定'],nil);
          Exit;
        end;
      end;
  end;



  ShowWaitingFrame(Self,Trans('发送中...'));

  Self.btnSendCaptcha.Tag:=0;
  Self.btnSendCaptcha.Enabled:=False;


  //发送验证码
  FAccount:=Trim(Self.edtPhone.Text);


  uTimerTask.GetGlobalTimerThread.RunTempTask(
                  DoSendCaptchaExecute,
                  DoSendCaptchaExecuteEnd,
                  'SendCaptcha'
                  );

end;

procedure TFrameForgetPassword.Clear;
begin
  Self.edtPhone.Text:='';
  Self.edtCaptcha.Text:='';

  Self.tmrSendCaptchaCheck.Enabled:=False;

  //恢复正常状态
  Self.btnSendCaptcha.Caption:=Trans('获取验证码');
  Self.btnSendCaptcha.Enabled:=True;
  Self.btnSendCaptcha.Prop.IsPushed:=True;

  Self.sbClient.VertScrollBar.Prop.Position:=0;

end;

constructor TFrameForgetPassword.Create(AOwner: TComponent);
begin
  inherited;
  //清除按钮隐藏
  Self.btnClearUser.Visible:=False;
  Self.btnClearCapcha.Visible:=False;
  //设置验证码的状态
  Self.btnSendCaptcha.Prop.IsPushed:=True;
  Self.btnSendCaptcha.Enabled:=False;

  if LangKind=lkZH then
  begin
        //中国,手机号
//      Self.edtPhone.TextPrompt:=Trans('用户名');
//      if Const_APPLoginType=Const_RegisterLoginType_PhoneNum then
//      begin
        Self.edtPhone.TextPrompt:=Trans('手机号');
//      end;
  end
  else
  begin
      //国外,用户名/邮箱
      Self.edtPhone.TextPrompt:=Trans('邮箱');
  end;



  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);

end;

procedure TFrameForgetPassword.DoCheckCaptchaExecute(ATimerTask: TObject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;

  try
    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('check_forget_password_captcha',
                                                  nil,
                                                  UserCenterInterfaceUrl,
                                                  ['appid',
                                                   'user_type',
                                                  'phone',
                                                  'captcha'],
                                                  [AppID,
                                                  APPUserType,
                                                  FAccount,
                                                  FCaptcha],
                                        GlobalRestAPISignType,
                                        GlobalRestAPIAppSecret
                                                  );

    if TTimerTask(ATimerTask).TaskDesc<>'' then
    begin
      TTimerTask(ATimerTask).TaskTag:=0;
    end;


  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;
end;

procedure TFrameForgetPassword.DoCheckCaptchaExecuteEnd(ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

        //验证码检查成功
        //下一步
        //隐藏
        HideFrame;//(Self,hfcttBeforeShowFrame);

        //重置密码
        ShowFrame(TFrame(GlobalResetPasswordFrame),TFrameResetPassword,frmMain,nil,nil,nil,Application);
//        GlobalResetPasswordFrame.FrameHistroy:=CurrentFrameHistroy;
        GlobalResetPasswordFrame.Load(FAccount,FCaptcha);

      end
      else
      begin
        //验证码检查失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin
      //网络异常
      ShowMessageBoxFrame(Self,Trans('网络异常,请检查您的网络连接!'),TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
    end;
  finally
    HideWaitingFrame;
  end;

end;

procedure TFrameForgetPassword.DoSendCaptchaExecute(ATimerTask: TObject);
begin

  try
    //出错
    TTimerTask(ATimerTask).TaskTag:=1;

    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('send_forget_password_captcha',
                                                    nil,
                                                    UserCenterInterfaceUrl,
                                                    ['appid',
                                                     'user_type',
                                                     'account'],
                                                      [AppID,
                                                       APPUserType,
                                                      FAccount],
                                        GlobalRestAPISignType,
                                        GlobalRestAPIAppSecret
                                                      );
    if TTimerTask(ATimerTask).TaskDesc<>'' then
    begin
      TTimerTask(ATimerTask).TaskTag:=0;
    end;

  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;

end;

procedure TFrameForgetPassword.DoSendCaptchaExecuteEnd(ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

        //发送验证码成功
        tmrSendCaptchaCheck.Enabled:=True;

      end
      else
      begin

        Self.btnSendCaptcha.Enabled:=True;
        Self.btnSendCaptcha.Tag:=61;
        //验证码发送失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin
      Self.btnSendCaptcha.Enabled:=True;

      //网络异常
      ShowMessageBoxFrame(Self,Trans('网络异常,请检查您的网络连接!'),TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
    end;
  finally
    HideWaitingFrame;
  end;
end;

procedure TFrameForgetPassword.edtPhoneChangeTracking(Sender: TObject);
begin
  if Self.edtPhone.Text<>'' then
  begin
    Self.btnClearUser.Visible:=True;
    //判断是不是邮箱
    if CheckEmail(Self.edtPhone.Text)=True then
    begin
      Self.btnSendCaptcha.Prop.IsPushed:=False;
      Self.btnSendCaptcha.Enabled:=True;
    end
    else
    begin
      //如果是手机号码登录
      if IsMobPhone(Self.edtPhone.Text)=True then
      begin
        Self.btnSendCaptcha.Prop.IsPushed:=False;
        Self.btnSendCaptcha.Enabled:=True;
      end
      else
      begin
        Self.btnSendCaptcha.Prop.IsPushed:=True;
        Self.btnSendCaptcha.Enabled:=False;
      end;
    end;

  end
  else
  begin
    Self.btnClearUser.Visible:=False;
    Self.btnSendCaptcha.Prop.IsPushed:=True;
    Self.btnSendCaptcha.Enabled:=False;
  end;
end;

//function TFrameForgetPassword.GetCurrentPorcessControl(AFocusedControl: TControl): TControl;
//begin
//  Result:=AFocusedControl;
//end;
//
//function TFrameForgetPassword.GetVirtualKeyboardControlParent: TControl;
//begin
//  Result:=Self;
//end;

procedure TFrameForgetPassword.btnClearCapchaClick(Sender: TObject);
begin
  Self.edtCaptcha.Text:='';
end;

procedure TFrameForgetPassword.tmrSendCaptchaCheckTimer(Sender: TObject);
begin
  Self.btnSendCaptcha.Tag:=Self.btnSendCaptcha.Tag+1;
  if Self.btnSendCaptcha.Tag>60 then
  begin
    Self.btnSendCaptcha.Caption:=Trans('重新发送');
    Self.btnSendCaptcha.Enabled:=True;
    Self.btnSendCaptcha.Prop.IsPushed:=False;

    tmrSendCaptchaCheck.Enabled:=False;

  end
  else
  begin
    Self.btnSendCaptcha.Caption:=//'已发送'+
                                  IntToStr(60-Self.btnSendCaptcha.Tag)
//                                  +'秒'
                                  ;
    Self.btnSendCaptcha.Enabled:=False;
    Self.btnSendCaptcha.Prop.IsPushed:=True;
  end;

end;





end.









