unit ChangePhoneNumberFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  EasyServiceCommonMaterialDataMoudle,

//  uCommonUtils,
  uFuncCommon,
  uRestInterfaceCall,

  uBaseHttpControl,
  uTimerTask,
  WaitingFrame,
  MessageBoxFrame,
  uOpenClientCommon,
  uOpenCommon,

  uConst,
  uUIFunction,
  XSuperObject,
  XSuperJson,
  HintFrame,

  uManager,
  uMobileUtils,

  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uSkinFireMonkeyButton, FMX.Controls.Presentation, FMX.Edit,
  uSkinFireMonkeyEdit, uSkinFireMonkeyPanel, uSkinFireMonkeyScrollBoxContent,
  uSkinFireMonkeyControl, uSkinFireMonkeyScrollControl, uSkinFireMonkeyScrollBox,
  uSkinButtonType, uSkinPanelType, uSkinScrollBoxContentType,
  uSkinScrollControlType, uSkinScrollBoxType;

type
  TFrameChangePhoneNumber = class(TFrame)
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    SkinFMXPanel2: TSkinFMXPanel;
    edtOldPhoneNumber: TSkinFMXEdit;
    SkinFMXPanel6: TSkinFMXPanel;
    SkinFMXPanel7: TSkinFMXPanel;
    edtOldPassword: TSkinFMXEdit;
    SkinFMXPanel8: TSkinFMXPanel;
    edtNewNumber: TSkinFMXEdit;
    btnReg: TSkinFMXButton;
    SkinFMXPanel13: TSkinFMXPanel;
    SkinFMXPanel1: TSkinFMXPanel;
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    pnlVerification: TSkinFMXPanel;
    edtCaptcha: TSkinFMXEdit;
    btnSendCaptcha: TSkinFMXButton;
    tmrSendCaptchaCheck: TTimer;
    SkinFMXPanel3: TSkinFMXPanel;
    procedure btnSendCaptchaClick(Sender: TObject);
    procedure tmrSendCaptchaCheckTimer(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
  private

    //获取验证码
    procedure DoSendChangePhoneCaptchaExecute(ATimerTask:TObject);
    procedure DoSendChangePhoneCaptchaExecuteEnd(ATimerTask:TObject);

    //更换手机号
    procedure DoChangePhoneNumberExecute(ATimerTask:TObject);
    procedure DoChangePhoneNumberExecuteEnd(ATimerTask:TObject);
    { Private declarations }
  public
    procedure Clear;
    { Public declarations }
  end;




var
  GlobalChangePhoneNumberFrame:TFrameChangePhoneNumber;


implementation

{$R *.fmx}

uses
  MainForm,
  MainFrame,
  LoginFrame;



procedure TFrameChangePhoneNumber.btnRegClick(Sender: TObject);
begin
  if Self.edtOldPhoneNumber.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入原来的手机号!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  if Self.edtOldPassword.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入原来的密码!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  if Self.edtNewNumber.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入新的手机号!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  if Self.edtCaptcha.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入验证码!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  ShowWaitingFrame(Self,'处理中...');
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                        DoChangePhoneNumberExecute,
                        DoChangePhoneNumberExecuteEnd,
                        'ChangePhoneNumber');

end;

procedure TFrameChangePhoneNumber.btnReturnClick(Sender: TObject);
begin
  if IsRepeatClickReturnButton(Self) then Exit;

  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);
end;

procedure TFrameChangePhoneNumber.btnSendCaptchaClick(Sender: TObject);
begin
  HideVirtualKeyboard;

  if Self.edtOldPassword.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入原来的手机号!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  if Not IsMobPhone(Self.edtOldPhoneNumber.Text) then
  begin
    ShowMessageBoxFrame(Self,'旧手机号码格式不正确!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  if Self.edtOldPassword.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入原来的密码!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;


  if Self.edtNewNumber.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入新的手机号!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;




  if Not IsMobPhone(Self.edtNewNumber.Text) then
  begin
    ShowMessageBoxFrame(Self,'新手机号码格式不正确!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;



  ShowWaitingFrame(Self,'发送中...');

  Self.btnSendCaptcha.Tag:=0;
  Self.btnSendCaptcha.Enabled:=False;

  uTimerTask.GetGlobalTimerThread.RunTempTask(
                 DoSendChangePhoneCaptchaExecute,
                 DoSendChangePhoneCaptchaExecuteEnd,
                 'SendChangePhoneCaptcha');
end;

procedure TFrameChangePhoneNumber.Clear;
begin

  Self.edtOldPhoneNumber.Text:='';
  Self.edtOldPassword.Text:='';
  Self.edtNewNumber.Text:='';
  Self.edtCaptcha.Text:='';

end;

procedure TFrameChangePhoneNumber.DoChangePhoneNumberExecute(
  ATimerTask: TObject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  try
    TTimerTask(ATimerTask).TaskDesc:=
        SimpleCallAPI('change_phone_num',
                      nil,
                      UserCenterInterfaceUrl,
                      ['appid',
                      'key',
                      'user_type',
                      'old_phone',
                      'old_password',
                      'new_phone',
                      'captcha'],
                      [AppID,
                       GlobalManager.User.key,
                       Const_AppUserType,
                       Trim(Self.edtOldPhoneNumber.Text),
                       Trim(Self.edtOldPassword.Text),
                       Trim(Self.edtNewNumber.Text),
                       Trim(Self.edtCaptcha.Text)
                      ],
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

procedure TFrameChangePhoneNumber.DoChangePhoneNumberExecuteEnd(
  ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

          //更换成功
          ShowHintFrame(nil,'更换成功!');

          //获取用户信息,成功之后再返回
//          GlobalManager.User.ParseFromJson(ASuperObject.O['Data'].A['User'].O[0]);

          HideFrame;//();
          ReturnFrame;//();

      end
      else
      begin
        //注册失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
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

procedure TFrameChangePhoneNumber.DoSendChangePhoneCaptchaExecute(
  ATimerTask: TObject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  try
    TTimerTask(ATimerTask).TaskDesc:=
          SimpleCallAPI('send_change_phone_num_captcha',
                        nil,
                        UserCenterInterfaceUrl,
                        ['appid',
                        'key',
                        'user_type',
                        'old_phone',
                        'old_password',
                        'new_phone'],
                        [AppID,
                         GlobalManager.User.key,
                         Const_AppUserType,
                         Trim(Self.edtOldPhoneNumber.Text),
                         Trim(Self.edtOldPassword.Text),
                         Trim(Self.edtNewNumber.Text)
                        ],
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

procedure TFrameChangePhoneNumber.DoSendChangePhoneCaptchaExecuteEnd(
  ATimerTask: TObject);
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
        //发送验证码失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
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

procedure TFrameChangePhoneNumber.tmrSendCaptchaCheckTimer(Sender: TObject);
begin
  Self.btnSendCaptcha.Tag:=Self.btnSendCaptcha.Tag+1;
  if Self.btnSendCaptcha.Tag>60 then
  begin
    Self.btnSendCaptcha.Caption:='发送验证码';
    Self.btnSendCaptcha.Enabled:=True;
    Self.btnSendCaptcha.Prop.IsPushed:=False;

    tmrSendCaptchaCheck.Enabled:=False;
  end
  else
  begin
    Self.btnSendCaptcha.Caption:='剩余'+IntToStr(60-Self.btnSendCaptcha.Tag)+'秒';
    Self.btnSendCaptcha.Enabled:=False;
    Self.btnSendCaptcha.Prop.IsPushed:=True;
  end;
end;

end.
