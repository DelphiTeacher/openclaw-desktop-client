//convert pas to utf8 by ¥

unit CustomAIModelSettingFrame;

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

  uOpenClawHelper,

  EasyServiceCommonMaterialDataMoudle,

  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit,
  uSkinFireMonkeyScrollBoxContent,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyScrollBox, uSkinFireMonkeyButton,
  uSkinFireMonkeyControl, uSkinFireMonkeyPanel, uSkinScrollBoxContentType,
  uSkinScrollControlType, uSkinScrollBoxType, uSkinButtonType, uBaseSkinControl,
  uSkinPanelType, FMX.ListBox, uSkinFireMonkeyComboBox;

type
  TFrameCustomAIModelSetting = class(TFrame)//,IFrameVirtualKeyboardAutoProcessEvent)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    SkinFMXPanel2: TSkinFMXPanel;
    edtCustomBaseUrl: TSkinFMXEdit;
    SkinFMXPanel6: TSkinFMXPanel;
    SkinFMXPanel7: TSkinFMXPanel;
    edtCustomAPIKey: TSkinFMXEdit;
    SkinFMXPanel8: TSkinFMXPanel;
    edtCustomModelID: TSkinFMXEdit;
    SkinFMXPanel13: TSkinFMXPanel;
    SkinFMXPanel1: TSkinFMXPanel;
    SkinFMXPanel3: TSkinFMXPanel;
    cmbAuthChoice: TSkinComboBox;
    SkinFMXPanel4: TSkinFMXPanel;
    btnReg: TSkinFMXButton;
    procedure btnReturnClick(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
//  private
//    //当前需要处理的控件
//    function GetCurrentPorcessControl(AFocusedControl:TControl):TControl;
//    function GetVirtualKeyboardControlParent:TControl;
  private
//    FOldPass:String;
//    FPassword:String;
//    FRePassword:String;

    FIsInstallDaemon:Boolean;
    procedure DoCustomAIModelSettingExecute(ATimerTask:TObject);
    procedure DoCustomAIModelSettingExecuteEnd(ATimerTask:TObject);

    //如果是初始配置,则配置完之后，跳回到主页面
    procedure OnCustomAIModelSettingMessageBoxModalResult(Sender: TObject);
    { Private declarations }
  public
//    FrameHistroy:TFrameHistroy;
    constructor Create(AOwner:TComponent);override;
  public
    procedure Load(AIsInstallDaemon:Boolean);
    { Public declarations }
  end;

var
  GlobalCustomAIModelSettingFrame:TFrameCustomAIModelSetting;

implementation

uses
  MainForm,
  LoginFrame;

{$R *.fmx}

procedure TFrameCustomAIModelSetting.btnRegClick(Sender: TObject);
begin
  HideVirtualKeyboard;




//  if Self.edtOldPass.Text='' then
//  begin
//    ShowMessageBoxFrame(Self,'请输入原密码!','',TMsgDlgType.mtInformation,['确定'],nil);
//    Exit;
//  end;
//  if (Length(Self.edtPass.Text)<6) or (Length(Self.edtPass.Text)>18) then
//  begin
//    ShowMessageBoxFrame(Self,'密码为6~18位数字或字母!','',TMsgDlgType.mtInformation,['确定'],nil);
//    Exit;
//  end;
  if Self.edtCustomBaseUrl.Text='' then
  begin
    ShowMessageBoxFrame(Self,Self.edtCustomBaseUrl.Prop.HelpText+'!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;
  if Self.edtCustomAPIKey.Text='' then
  begin
    ShowMessageBoxFrame(Self,Self.edtCustomAPIKey.Prop.HelpText+'!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;
  if Self.edtCustomModelID.Text='' then
  begin
    ShowMessageBoxFrame(Self,Self.edtCustomModelID.Prop.HelpText+'!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;
//  if Self.edtRePass.Text<>Self.edtPass.Text then
//  begin
//    ShowMessageBoxFrame(Self,'两次密码不一致!','',TMsgDlgType.mtInformation,['确定'],nil);
//    Exit;
//  end;



//  ShowWaitingFrame(Self,'更新中...');


  GlobalOpenClawHelper.FAuthChoice:='custom-api-key';
  GlobalOpenClawHelper.FCustomBaseUrl:=Trim(Self.edtCustomBaseUrl.Text);
  GlobalOpenClawHelper.FCustomApiKey:=Trim(Self.edtCustomAPIKey.Text);
  GlobalOpenClawHelper.FCustomModelId:=Trim(Self.edtCustomModelID.Text);
  GlobalOpenClawHelper.FCustomCompatibility:='openai';


//  FOldPass:=Trim(Self.edtOldPass.Text);
//  FPassword:=Trim(Self.edtPass.Text);
//  FRePassword:=Trim(Self.edtRePass.Text);

//  GlobalOpenClawHelper.ApplyModelSettingByCommand;

  ShowWaitingFrame('更新中...');
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                                           DoCustomAIModelSettingExecute,
                                           DoCustomAIModelSettingExecuteEnd,
                                           'CustomAIModelSetting');


end;

procedure TFrameCustomAIModelSetting.btnReturnClick(Sender: TObject);
begin
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);

end;

procedure TFrameCustomAIModelSetting.Load(AIsInstallDaemon:Boolean);
begin
  FIsInstallDaemon:=AIsInstallDaemon;

  Self.edtCustomBaseUrl.Text:=GlobalOpenClawHelper.FCustomBaseUrl;
  Self.edtCustomAPIKey.Text:=GlobalOpenClawHelper.FCustomApiKey;
  Self.edtCustomModelID.Text:=GlobalOpenClawHelper.FCustomModelId;

  Self.sbClient.VertScrollBar.Prop.Position:=0;

end;

constructor TFrameCustomAIModelSetting.Create(AOwner: TComponent);
begin
  inherited;
  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);
end;

procedure TFrameCustomAIModelSetting.DoCustomAIModelSettingExecute(ATimerTask: TObject);
var
  ADesc:String;
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  try
//    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('change_password',
//                                                    nil,
//                                                    UserCenterInterfaceUrl,
//                                                    ['appid',
//                                                    'user_type',
//                                                    'user_fid',
//                                                    'old_password',
//                                                    'password',
//                                                    'repassword'
//                                                    ],
//                                                    [AppID,
//                                                    APPUserType,
//                                                    GlobalManager.User.fid,
//                                                    FOldPass,
//                                                    FPassword,
//                                                    FRePassword],
//                                                    GlobalRestAPISignType,
//                                                    GlobalRestAPIAppSecret
//                                                    );

    ADesc:='';
    if GlobalOpenClawHelper.ApplyModelSettingByCommand(ADesc) then
    begin
      TTimerTask(ATimerTask).TaskTag:=0;
      TTimerTask(ATimerTask).TaskDesc:='更新成功！';
    end
    else
    begin
      TTimerTask(ATimerTask).TaskDesc:='更新失败!';
    end;

//    if TTimerTask(ATimerTask).TaskDesc<>'' then
//    begin
//      TTimerTask(ATimerTask).TaskTag:=0;
//    end;

  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;
end;

procedure TFrameCustomAIModelSetting.DoCustomAIModelSettingExecuteEnd(ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//          //密码修改成功
//          ShowHintFrame(nil,'密码修改成功!');
//
//
//          //直接返回即可,因为自动登陆使用LoginKey,而不再使用密码
//          HideFrame;//(Self,hfcttBeforeReturnFrame);
//          ReturnFrame;//(Self);
//



          ShowMessageBoxFrame(Self,'更新成功!','',TMsgDlgType.mtInformation,['确定'],OnCustomAIModelSettingMessageBoxModalResult);



//          //退出重新登录
//          //重新登录
//
//
//
//
////          frmMain.Logout;
////
////
//////          HideFrame;//();
//////          //显示登录
//////          ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
//////          GlobalLoginFrame.FrameHistroy:=CurrentFrameHistroy;
////          ShowLoginFrame(False);
////          //清除密码输入框
////          GlobalLoginFrame.ClearPass;
//
//
//      end
//      else
//      begin
//        //密码修改失败
//        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin
      //网络异常
      ShowMessageBoxFrame(Self,'更新失败!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
    end;
  finally
    HideWaitingFrame;
  end;
end;

//function TFrameCustomAIModelSetting.GetCurrentPorcessControl(
//  AFocusedControl: TControl): TControl;
//begin
//  Result:=AFocusedControl;
//end;
//
//function TFrameCustomAIModelSetting.GetVirtualKeyboardControlParent: TControl;
//begin
//  Result:=Self;
//end;

procedure TFrameCustomAIModelSetting.OnCustomAIModelSettingMessageBoxModalResult(
  Sender: TObject);
begin
//  HideFrame;//(Self,hfcttBeforeReturnFrame);
//  ReturnFrame;//(Self);
  //配置好的话，返回到MainFrame
  if FIsInstallDaemon then
  begin
    HideFrame;
    ReturnFrame;
  end;
end;

end.

