unit RegisterProtocolFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 

  uFileCommon,
  uFuncCommon,
  uComponentType,

  uOpenCommon,
  uBaseLog,
  uFrameContext,

  uUIFunction,
  uTimerTask,
  XSuperObject,
  uBaseHttpControl,
  uOpenClientCommon,
  uManager,
  uRestInterfaceCall,
  MessageBoxFrame,
  WaitingFrame,
  HintFrame,
  uConst,

  {$IFDEF ANDROID}
  FMX.WebBrowser.Android,
  {$ENDIF}

  uSkinFireMonkeyEdit,

  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uSkinFireMonkeyButton, uSkinFireMonkeyControl, uSkinFireMonkeyPanel,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, uSkinFireMonkeyMemo,
  uSkinFireMonkeyLabel, FMX.WebBrowser, uSkinButtonType, uSkinLabelType,
  uBaseSkinControl, uSkinPanelType;

type
  TFrameRegisterProtocol = class(TFrame)
    pnlBackground: TSkinFMXPanel;
    pnlClient: TSkinFMXPanel;
    pnlTop: TSkinFMXPanel;
    lblType: TSkinFMXLabel;
    pnlTopDevide: TSkinFMXPanel;
    btnClose: TSkinFMXButton;
    BtnSendMsgTest: TSkinFMXButton;
    pnlButton: TSkinFMXPanel;
    btnOK: TSkinFMXButton;
    btnNO: TSkinFMXButton;
    pnlContext: TSkinFMXPanel;
    FrameContext1: TFrameContext;
    procedure btnCloseClick(Sender: TObject);
    procedure BtnSendMsgTestClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnNOClick(Sender: TObject);
    procedure FrameContext1Show(Sender: TObject);
  private
    FWebBrowser: TWebBrowser;
    { Private declarations }
  public
    constructor Create(AOwer:TComponent);override;
    destructor Destroy;override;
  public
    procedure HideRegisterProtocol;
    //协议标题   协议内容的链接
    procedure Load(ATitle:String='';AUrl:String='');
    //给自己发送推送,测试推送是否正常
    procedure DoSendMsgTestExcute(ATimerTask:TObject);
    procedure DoSendMsgTestExcuteEnd(ATimerTask:TObject);
    { Public declarations }
  end;


var
  GlobalRegisterProtocolFrame:TFrameRegisterProtocol;

implementation

{$R *.fmx}

procedure TFrameRegisterProtocol.btnCloseClick(Sender: TObject);
begin
  RestoreGlobalEditListAsPlatformType;
  RestoreGlobalMemoListAsPlatformType;

  HideRegisterProtocol;
end;

procedure TFrameRegisterProtocol.btnOKClick(Sender: TObject);
begin
  //选择同意，保存变量，销毁页面
  GlobalManager.IsFirstStart:=False;
  GlobalManager.Save;

  HideRegisterProtocol;
  //FrameRegisterProtocol.Close;
end;

procedure TFrameRegisterProtocol.btnNOClick(Sender: TObject);
begin
  //选择拒绝，直接退出
  Application.Terminate;
end;

procedure TFrameRegisterProtocol.BtnSendMsgTestClick(Sender: TObject);
begin
  //自己发送推送测试是否成功
  ShowWaitingFrame(Self,'发送中...');
  uTimerTask.GetGlobalTimerThread.RunTempTask(DoSendMsgTestExcute,
                                              DoSendMsgTestExcuteEnd,
                                              'SendMsgTest');
end;

constructor TFrameRegisterProtocol.Create(AOwer: TComponent);
begin
  inherited;
  Self.lblType.SelfOwnMaterialToDefault.DrawCaptionParam.FontColor:=SkinThemeColor;
  Self.pnlTopDevide.SelfOwnMaterialToDefault.BackColor.FillColor.Color:=SkinThemeColor;
end;

destructor TFrameRegisterProtocol.Destroy;
begin
  uFuncCommon.FreeAndNil(FWebBrowser);

  inherited;
end;

procedure TFrameRegisterProtocol.DoSendMsgTestExcute(ATimerTask: TObject);
begin
  TTimerTask(ATimerTask).TaskTag := 1;
  try
//    TTimerTask(ATimerTask).TaskDesc :=SimpleCallAPI('push_message_to_user',
//                                                      nil,
//                                                      PushManageInterfaceUrl,
//                                                      ['appid',
//                                                      'user_fid',
//                                                      'key',
//                                                      'recv_user_fid',
//                                                      'title',
//                                                      'message',
//                                                      'custom_data_json'],
//                                                      [AppID,
//                                                       GlobalManager.User.fid,
//                                                       GlobalManager.User.key,
//                                                       GlobalManager.User.fid, //接收者  自己发给自己
//                                                       '推送测试',
//                                                       '推送设置检测成功,设置没问题',
//                                                       '{"notice_sub_type":"test_push_msg"}'],
//                                                      GlobalRestAPISignType,
//                                                      GlobalRestAPIAppSecret
//                                                      );
    TTimerTask(ATimerTask).TaskDesc :=SimpleCallAPI('notice_user',
                                    nil,
                                    UserCenterInterfaceUrl,
                                    ['appid',
                                    'user_fid',
                                    'key',
                                    'sender_fid',
                                    'recver_fid',
                                    'notice_classify',
                                    'notice_sub_type',
                                    'caption',
                                    'content',
                                    'custom_data_json',
                                    'is_need_push',
                                    'is_need_sms'],
                                    [AppID,
                                    GlobalManager.User.fid,//发给被关注的人
                                    GlobalManager.User.key,
                                    '',//表示是系统发送给你的通知
                                    GlobalManager.User.fid,
                                    Const_NoticeCalssify_Other,
                                    Const_NoticeSubCalssify_Exception,
                                    '推送测试',
                                    '如果您能收到推送，则说明设置没问题',
                                    '{"notice_sub_type":"test_push_msg"}',
                                    '1',
                                    '0']);
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

procedure TFrameRegisterProtocol.DoSendMsgTestExcuteEnd(ATimerTask: TObject);
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

procedure TFrameRegisterProtocol.FrameContext1Show(Sender: TObject);
begin
  //

end;

procedure TFrameRegisterProtocol.HideRegisterProtocol;
begin
  if GlobalTopMostFrameList<>nil then
  begin
    GlobalTopMostFrameList.Remove(Self,False);
  end;

  GlobalRegisterProtocolFrame.Visible:=False;
//  try
//    try
//      uFuncCommon.FreeAndNil(GlobalRegisterProtocolFrame);
//    except
//      on E:Exception do
//      begin
//        uBaseLog.HandleException(E,'TFrameRegisterProtocol.HideRegisterProtocol')
//      end;
//    end;
//  finally
//    GlobalRegisterProtocolFrame:=nil;
//  end;
end;

procedure TFrameRegisterProtocol.Load(ATitle:String='';AUrl:String='');
var
  HtmlLocalFileCodePath:String;
begin

  Self.pnlButton.Visible:=True;
  Self.btnClose.Visible:=False;


  if (GlobalTopMostFrameList<>nil) and (GlobalTopMostFrameList.IndexOf(Self)=-1) then
  begin
    GlobalTopMostFrameList.Add(Self);
  end;


  SetGlobalEditListAsStyleType;
  SetGlobalMemoListAsStyleType;

  //标题说明
  Self.lblType.Caption:=ATitle;
  if ATitle='' then Self.lblType.Caption:='传情APP注册协议';

  {$IFDEF ANDROID}
  {$IFDEF VER310}
  FMX.WebBrowser.Android.WebBrowserSystemStatusBarHeight:=
        uComponentType.SystemStatusBarHeight;
  {$ENDIF}
  {$ENDIF}

  if FWebBrowser=nil then
  begin
    FWebBrowser:=TWebBrowser.Create(Self);
    FWebBrowser.Parent:=Self.pnlContext;
    FWebBrowser.Align:=TAlignLayout.{$IF CompilerVersion >= 34.0}{$ELSE}al{$ENDIF}Client;
    //不缓存
    FWebBrowser.EnableCaching:=False;

    FWebBrowser.Visible:=True;
  end;

  //加载HTML文件
  HtmlLocalFileCodePath:=AUrl;
  if AUrl=''then
  begin
    HtmlLocalFileCodePath:=Const_OpenWebRoot+'/apps/'+(AppID)+'/ShopRegisterProtocol.html';
  end;
  Self.FWebBrowser.Navigate(HtmlLocalFileCodePath);



end;

end.
