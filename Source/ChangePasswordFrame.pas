//convert pas to utf8 by ¥

unit ChangePasswordFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  HintFrame,
  WaitingFrame,
  MessageBoxFrame,
  uRestInterfaceCall,
//  uOpenClientCommon,
//  uInterfaceClass,
  uOpenCommon,

  uManager,
  uOpenClientCommon,
  uTimerTask,
  uUIFunction,
  XSuperObject,
  XSuperJson,
  uFrameContext,
  uBaseHttpControl,

  EasyServiceCommonMaterialDataMoudle,

  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit,
  uSkinFireMonkeyScrollBoxContent,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyScrollBox, uSkinFireMonkeyButton,
  uSkinFireMonkeyControl, uSkinFireMonkeyPanel, uSkinScrollBoxContentType,
  uSkinScrollControlType, uSkinScrollBoxType, uSkinButtonType, uBaseSkinControl,
  uSkinPanelType;

type
  TFrameChangePassword = class(TFrame)//,IFrameVirtualKeyboardAutoProcessEvent)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    SkinFMXPanel2: TSkinFMXPanel;
    edtOldPass: TSkinFMXEdit;
    SkinFMXPanel6: TSkinFMXPanel;
    SkinFMXPanel7: TSkinFMXPanel;
    edtPass: TSkinFMXEdit;
    SkinFMXPanel8: TSkinFMXPanel;
    edtRePass: TSkinFMXEdit;
    btnReg: TSkinFMXButton;
    SkinFMXPanel13: TSkinFMXPanel;
    SkinFMXPanel1: TSkinFMXPanel;
    procedure btnReturnClick(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
//  private
//    //当前需要处理的控件
//    function GetCurrentPorcessControl(AFocusedControl:TControl):TControl;
//    function GetVirtualKeyboardControlParent:TControl;
  private
    FOldPass:String;
    FPassword:String;
    FRePassword:String;


    procedure DoChangePasswordExecute(ATimerTask:TObject);
    procedure DoChangePasswordExecuteEnd(ATimerTask:TObject);

    procedure OnChangePasswordMessageBoxModalResult(Sender: TObject);
    { Private declarations }
  public
//    FrameHistroy:TFrameHistroy;
    constructor Create(AOwner:TComponent);override;
  public
    procedure Clear;
    { Public declarations }
  end;

var
  GlobalChangePasswordFrame:TFrameChangePassword;

implementation

uses
  MainForm,
  LoginFrame;

{$R *.fmx}

procedure TFrameChangePassword.btnRegClick(Sender: TObject);
begin
  HideVirtualKeyboard;




//  if Self.edtOldPass.Text='' then
//  begin
//    ShowMessageBoxFrame(Self,'请输入原密码!','',TMsgDlgType.mtInformation,['确定'],nil);
//    Exit;
//  end;
  if (Length(Self.edtPass.Text)<6) or (Length(Self.edtPass.Text)>18) then
  begin
    ShowMessageBoxFrame(Self,'密码为6~18位数字或字母!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;
  if Self.edtPass.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入新密码!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;
  if Self.edtRePass.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入确认密码!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;
  if Self.edtRePass.Text<>Self.edtPass.Text then
  begin
    ShowMessageBoxFrame(Self,'两次密码不一致!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;



  ShowWaitingFrame(Self,'修改密码中...');



  FOldPass:=Trim(Self.edtOldPass.Text);
  FPassword:=Trim(Self.edtPass.Text);
  FRePassword:=Trim(Self.edtRePass.Text);

  uTimerTask.GetGlobalTimerThread.RunTempTask(
                                           DoChangePasswordExecute,
                                           DoChangePasswordExecuteEnd,
                                           'ChangePassword');

end;

procedure TFrameChangePassword.btnReturnClick(Sender: TObject);
begin
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);

end;

procedure TFrameChangePassword.Clear;
begin
  Self.edtOldPass.Text:='';
  Self.edtPass.Text:='';
  Self.edtRePass.Text:='';

  Self.sbClient.VertScrollBar.Prop.Position:=0;

end;

constructor TFrameChangePassword.Create(AOwner: TComponent);
begin
  inherited;
  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);
end;

procedure TFrameChangePassword.DoChangePasswordExecute(ATimerTask: TObject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  try
    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('change_password',
                                                    nil,
                                                    UserCenterInterfaceUrl,
                                                    ['appid',
                                                    'user_type',
                                                    'user_fid',
                                                    'old_password',
                                                    'password',
                                                    'repassword'
                                                    ],
                                                    [AppID,
                                                    APPUserType,
                                                    GlobalManager.User.fid,
                                                    FOldPass,
                                                    FPassword,
                                                    FRePassword],
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

procedure TFrameChangePassword.DoChangePasswordExecuteEnd(ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin
          //密码修改成功
          ShowHintFrame(nil,'密码修改成功!');


          //直接返回即可,因为自动登陆使用LoginKey,而不再使用密码
          HideFrame;//(Self,hfcttBeforeReturnFrame);
          ReturnFrame;//(Self);




          //ShowMessageBoxFrame(Self,'密码修改成功!','',TMsgDlgType.mtInformation,['确定'],OnChangePasswordMessageBoxModalResult);

          //退出重新登录
          //重新登录




//          frmMain.Logout;
//
//
////          HideFrame;//();
////          //显示登录
////          ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
////          GlobalLoginFrame.FrameHistroy:=CurrentFrameHistroy;
//          ShowLoginFrame(False);
//          //清除密码输入框
//          GlobalLoginFrame.ClearPass;


      end
      else
      begin
        //密码修改失败
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

//function TFrameChangePassword.GetCurrentPorcessControl(
//  AFocusedControl: TControl): TControl;
//begin
//  Result:=AFocusedControl;
//end;
//
//function TFrameChangePassword.GetVirtualKeyboardControlParent: TControl;
//begin
//  Result:=Self;
//end;

procedure TFrameChangePassword.OnChangePasswordMessageBoxModalResult(
  Sender: TObject);
begin
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);

end;

end.

