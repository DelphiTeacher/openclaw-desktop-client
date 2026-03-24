unit BindPhoneNumberFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  EasyServiceCommonMaterialDataMoudle,

  uConst,
//  uCommonUtils,
  uFuncCommon,
  uRestInterfaceCall,
  uBaseHttpControl,
  uTimerTask,
  WaitingFrame,
  HintFrame,
  MessageBoxFrame,
  uOpenClientCommon,
  uOpenCommon,
  uFrameContext,

  uUIFunction,
  XSuperObject,
  XSuperJson,

  uManager,
  uMobileUtils,

  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uSkinFireMonkeyButton, FMX.Controls.Presentation, FMX.Edit,
  uSkinFireMonkeyEdit, uSkinFireMonkeyPanel, uSkinFireMonkeyScrollBoxContent,
  uSkinFireMonkeyControl, uSkinFireMonkeyScrollControl, uSkinFireMonkeyScrollBox,
  uSkinButtonType, uSkinPanelType, uSkinScrollBoxContentType,
  uSkinScrollControlType, uSkinScrollBoxType;

type
  TFrameBindPhoneNumber = class(TFrame)
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    SkinFMXPanel8: TSkinFMXPanel;
    edtNewNumber: TSkinFMXEdit;
    btnReg: TSkinFMXButton;
    SkinFMXPanel13: TSkinFMXPanel;
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
    procedure DoSendBindPhoneCaptchaExecute(ATimerTask:TObject);
    procedure DoSendBindPhoneCaptchaExecuteEnd(ATimerTask:TObject);

    //绑定手机号
    procedure DoBindPhoneNumberExecute(ATimerTask:TObject);
    procedure DoBindPhoneNumberExecuteEnd(ATimerTask:TObject);

//    //获取个人信息
//    procedure DoGetUserInfoExecute(ATimerTask:TObject);
//    procedure DoGetUserInfoExecuteEnd(ATimerTask:TObject);
    { Private declarations }
  public
    procedure Clear;
  public
    constructor Create(AOwner:TComponent);override;
    { Public declarations }
  end;


var
  GlobalBindPhoneNumberFrame:TFrameBindPhoneNumber;


implementation

{$R *.fmx}

uses
  MainForm,
  MainFrame,
  LoginFrame;

procedure TFrameBindPhoneNumber.btnRegClick(Sender: TObject);
begin

  if Self.edtNewNumber.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入手机号!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  if Self.edtCaptcha.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入验证码!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  ShowWaitingFrame(Self,'处理中...');
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                        DoBindPhoneNumberExecute,
                        DoBindPhoneNumberExecuteEnd,
                        'BindPhoneNumber');

end;

procedure TFrameBindPhoneNumber.btnReturnClick(Sender: TObject);
begin
  if IsRepeatClickReturnButton(Self) then Exit;

  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);
end;

procedure TFrameBindPhoneNumber.btnSendCaptchaClick(Sender: TObject);
begin
  HideVirtualKeyboard;


  if Self.edtNewNumber.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入手机号!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  if Not IsMobPhone(Self.edtNewNumber.Text) then
  begin
    ShowMessageBoxFrame(Self,'手机号码格式不正确!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;


  ShowWaitingFrame(Self,'发送中...');

  Self.btnSendCaptcha.Tag:=0;
  Self.btnSendCaptcha.Enabled:=False;

  uTimerTask.GetGlobalTimerThread.RunTempTask(
                 DoSendBindPhoneCaptchaExecute,
                 DoSendBindPhoneCaptchaExecuteEnd,
                 'SendBindPhoneCaptcha');
end;

procedure TFrameBindPhoneNumber.Clear;
begin

  Self.edtNewNumber.Text:='';
  Self.edtCaptcha.Text:='';
  Self.btnReturn.Visible:=True;

end;

//procedure TFrameBindPhoneNumber.DoGetUserInfoExecute(ATimerTask: TObject);
//begin
//  // 出错
//  TTimerTask(ATimerTask).TaskTag := 1;
//  try
//    TTimerTask(ATimerTask).TaskDesc :=SimpleCallAPI('get_my_info',
//                                                      nil,
//                                                      UserCenterInterfaceUrl,
//                                                      ['appid',
//                                                      'user_fid',
//                                                      'key'],
//                                                      [AppID,
//                                                      GlobalManager.User.fid,
//                                                      GlobalManager.User.key
//                                                      ]
//                                                      );
//    if TTimerTask(ATimerTask).TaskDesc <> '' then
//    begin
//      TTimerTask(ATimerTask).TaskTag := 0;
//    end;
//
//  except
//    on E: Exception do
//    begin
//      // 异常
//      TTimerTask(ATimerTask).TaskDesc := E.Message;
//    end;
//  end;
//
//end;
//
//procedure TFrameBindPhoneNumber.DoGetUserInfoExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//begin
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//        //获取用户信息成功
//
//        //刷新用户信息
//        GlobalManager.User.ParseFromJson(ASuperObject.O['Data'].A['User'].O[0]);
//
//
//      end
//      else
//      begin
//        //注册失败
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
//  end;
//
//end;

constructor TFrameBindPhoneNumber.Create(AOwner: TComponent);
begin
  inherited;

  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);

end;

procedure TFrameBindPhoneNumber.DoBindPhoneNumberExecute(
  ATimerTask: TObject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  try
    TTimerTask(ATimerTask).TaskDesc:=
          SimpleCallAPI('bind_phone_num',
                          nil,
                          UserCenterInterfaceUrl,
                          ['appid',
                          'key',
                          'user_fid',
                          'user_type',
                          'phone',
                          'captcha'],
                          [AppID,
                           GlobalManager.User.key,
                           GlobalManager.User.Fid,
                           Const_APPUserType,
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

procedure TFrameBindPhoneNumber.DoBindPhoneNumberExecuteEnd(
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

          //注册成功
          ShowHintFrame(nil,'绑定成功!');

          //获取用户信息,成功之后再返回
//          GlobalManager.User.ParseFromJson(ASuperObject.O['Data'].A['User'].O[0]);

          GlobalManager.User.phone:=Self.edtNewNumber.Text;

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

procedure TFrameBindPhoneNumber.DoSendBindPhoneCaptchaExecute(
  ATimerTask: TObject);
begin
  // 出错
  TTimerTask(ATimerTask).TaskTag := 1;
  try
    TTimerTask(ATimerTask).TaskDesc := SimpleCallAPI('send_bind_phone_num_captcha',
      nil, UserCenterInterfaceUrl,
      ['appid',
      'user_type',
      'phone'],
      [AppID,
      APPUserType,
      Self.edtNewNumber.Text],
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

procedure TFrameBindPhoneNumber.DoSendBindPhoneCaptchaExecuteEnd(
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

procedure TFrameBindPhoneNumber.tmrSendCaptchaCheckTimer(Sender: TObject);
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
