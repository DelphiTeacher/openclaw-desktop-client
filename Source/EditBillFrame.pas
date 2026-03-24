unit EditBillFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uLang,

//  uGetDeviceInfo,
//  FMX.DeviceInfo,
  uOpenClientCommon,
  EasyServiceCommonMaterialDataMoudle,

  uOpenCommon,
  uFuncCommon,
//  uLanguage,
//  uCommonUtils,
//  uInterfaceClass,
  uRestInterfaceCall,
  uBaseHttpControl,
  uTimerTask,
  WaitingFrame,
  MessageBoxFrame,
//  uThirdPartyAccountAuth,
  AddPictureListSubFrame,
  uAddPictureListSubFrame,
  SelectAreaFrame,
  BillListFrame,

  uFrameContext,
  uUIFunction,
  XSuperObject,
  XSuperJson,

  uManager,
  uMobileUtils,
  HzSpell,

  uSkinFireMonkeyCheckBox, uSkinFireMonkeyLabel, FMX.Controls.Presentation,
  FMX.Edit, uSkinFireMonkeyEdit, uSkinFireMonkeyScrollBoxContent,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyScrollBox, uSkinFireMonkeyButton,
  uSkinFireMonkeyControl, uSkinFireMonkeyPanel, uSkinButtonType, uSkinPanelType,
  uSkinScrollBoxContentType, uSkinScrollControlType, uSkinScrollBoxType,
  FMX.ListBox, uSkinFireMonkeyComboBox, FMX.DateTimeCtrls,
  uSkinFireMonkeyDateEdit, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  uSkinFireMonkeyMemo;

type
  TFrameEditBill = class(TFrame)//, IFrameVirtualKeyboardAutoProcessEvent)
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    edtName: TSkinFMXEdit;
    btnSave: TSkinFMXButton;
    pnlEmpty1: TSkinFMXPanel;
    pnlEmpty: TSkinFMXPanel;
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    pnlEmpty3: TSkinFMXPanel;
    pnlPhone: TSkinFMXPanel;
    pnlEmpty4: TSkinFMXPanel;
    pnlName: TSkinFMXPanel;
    pnlInviterPhone: TSkinFMXPanel;
    edtInviterPhone: TSkinFMXEdit;
    pnlEmail: TSkinFMXPanel;
    edtPhone: TSkinFMXEdit;
    edtEmail: TSkinFMXEdit;
    SkinFMXPanel1: TSkinFMXPanel;
    edtCode: TSkinFMXEdit;
    SkinFMXPanel2: TSkinFMXPanel;
    cmbType: TSkinFMXComboBox;
    SkinFMXPanel3: TSkinFMXPanel;
    btnSelectArea: TSkinFMXButton;
    pnlCompleteDate: TSkinFMXPanel;
    detCompleteDate: TSkinFMXDateEdit;
    SkinFMXPanel4: TSkinFMXPanel;
    memAddr: TSkinFMXMemo;
    btnCancel: TSkinFMXButton;
    SkinFMXPanel5: TSkinFMXPanel;
    btnSelectContacts: TSkinFMXButton;
    procedure tmrSendCaptchaCheckTimer(Sender: TObject);
    procedure btnSendCaptchaClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure btnSelectAreaClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSelectContactsClick(Sender: TObject);
//  private
//    // 当前需要处理的控件
//    function GetCurrentPorcessControl(AFocusedControl: TControl): TControl;
//    function GetVirtualKeyboardControlParent: TControl;
  private
    // 注册用户
    procedure DoSaveBillExecute(ATimerTask: TObject);
    procedure DoSaveBillExecuteEnd(ATimerTask: TObject);
  private
    // 发送验证码
    procedure DoSendRegisterCaptchaExecute(ATimerTask: TObject);
    procedure DoSendRegisterCaptchaExecuteEnd(ATimerTask: TObject);
  private

    // 注册成功
    procedure OnModalResultFromRegisterSucc(Frame: TObject);
    { Private declarations }
  public
    FDataJson:ISuperObject;
//    FUserName:String;
//    FUserHeadPicFilePath:String;
//
//    FWxOpenID:String;
//    FWxAuthToken:String;
//
//    FAlipayOpenID:String;
//    FAlipayAuthToken:String;

//    //用户头像
//    FPetHeadPicFrame:TFrameAddPictureListSub;

    // 编辑报表名称
    FReportName:String;


    procedure DoReturnFrameFromSelectArea(AFrame:TFrame);

    procedure DoReturnFrameFromSelectContact(AFrame:TFrame);
  public
//    FrameHistroy:TFrameHistroy;
    procedure Clear;//(AText:String);  //参数没用到   外卖共用的登录界面跳到注册界面有传一个参数
    procedure Load(AReportName:String; ADataJson:ISuperObject);//(
//                  AUserName:String;
//                  AUserHeadPicFilePath:String;
//                  AWxOpenID:String;
//                  AWxAuthToken:String;
//
//                  AAlipayOpenID:String;
//                  AAlipayAuthToken:String
//                  );
  public
    constructor Create(AOwner:TComponent);override;
    { Public declarations }
  end;



var
  GlobalEditBillFrame: TFrameEditBill;

implementation

{$R *.fmx}

//uses
//  LoginFrame,
//  // FillUserInfoFrame,
////  SelectAreaFrame,
//  MainForm;

procedure TFrameEditBill.btnSaveClick(Sender: TObject);
begin
//  HideVirtualKeyboard;
//
//  if Trim(Self.edtName.Text) = '' then
//  begin
//    ShowMessageBoxFrame(Self, '请输入姓名!', '', TMsgDlgType.mtInformation,
//      ['确定'], nil);
//    Exit;
//  end;
//
//  if pnlPhone.Visible then
//  begin
//      //手机号
//      if Trim(Self.edtPhone.Text) = '' then
//      begin
//        ShowMessageBoxFrame(Self, '请输入手机号!', '', TMsgDlgType.mtInformation,
//          ['确定'], nil);
//        Exit;
//      end;
//
//      if Not IsMobPhone(Self.edtPhone.Text) then
//      begin
//        ShowMessageBoxFrame(Self, '手机号码格式不正确!', '', TMsgDlgType.mtInformation,
//          ['确定'], nil);
//        Exit;
//      end;
//  end
//  else
//  begin
//      //邮箱
//      if Trim(Self.edtEmail.Text) = '' then
//      begin
//        ShowMessageBoxFrame(Self, '请输入邮箱!', '', TMsgDlgType.mtInformation,
//          ['确定'], nil);
//        Exit;
//      end;
//
////      if Not IsMobPhone(Self.edtPhone.Text) then
////      begin
////        ShowMessageBoxFrame(Self, '手机号码格式不正确!', '', TMsgDlgType.mtInformation,
////          ['确定'], nil);
////        Exit;
////      end;
//
//  end;
//
//
//
//  if Trim(Self.edtCaptcha.Text) = '' then
//  begin
//    ShowMessageBoxFrame(Self, '请输入验证码!', '', TMsgDlgType.mtInformation,
//      ['确定'], nil);
//    Exit;
//  end;
//
//  if Trim(Self.edtPass.Text) = '' then
//  begin
//    ShowMessageBoxFrame(Self, '请输入密码!', '', TMsgDlgType.mtInformation,
//      ['确定'], nil);
//    Exit;
//  end;
//
//  if Trim(Self.edtRePass.Text) = '' then
//  begin
//    ShowMessageBoxFrame(Self, '请输入确认密码!', '', TMsgDlgType.mtInformation,
//      ['确定'], nil);
//    Exit;
//  end;
//
//
//  if Trim(Self.edtInviterPhone.Text)<>'' then
//  begin
//    if Not IsMobPhone(Self.edtInviterPhone.Text) then
//    begin
//      ShowMessageBoxFrame(Self, '邀请人的手机号码格式不正确!', '', TMsgDlgType.mtInformation,
//        ['确定'], nil);
//      Exit;
//    end;
//  end;
//
//
//  //先将图片保存到本地目录
//  Self.FPetHeadPicFrame.SaveToLocalTemp(70,'.png');


  ShowWaitingFrame(Self, '注册中...');

  uTimerTask.GetGlobalTimerThread.RunTempTask(DoSaveBillExecute,
    DoSaveBillExecuteEnd,
    'RegisterUser');

end;

procedure TFrameEditBill.btnSelectAreaClick(Sender: TObject);
begin
  HideFrame;
  //选择区域
  ShowFrame(TFrame(GlobalSelectAreaFrame),TFrameSelectArea,DoReturnFrameFromSelectArea);
//  GlobalSelectAreaFrame.Init(FDataJson.S['省'],FDataJson.S['市'],FDataJson.S['区']);
////  ACustomerDataJson.S['省']:='浙江省';
////  ACustomerDataJson.S['市']:='宁波市';
////  ACustomerDataJson.S['区']:='鄞州区';
  GlobalSelectAreaFrame.Init('浙江省','宁波市','鄞州区');
end;

// 选择联系人
procedure TFrameEditBill.btnSelectContactsClick(Sender: TObject);
begin
  HideFrame;
  ShowFrame(TFrame(GlobalBillListFrame),TFrameBillList,DoReturnFrameFromSelectContact);
  //设置列表项样式
  GlobalBillListFrame.lvData.Properties.DefaultItemStyle:='Bill';

  //设置字段显示绑定
  GlobalBillListFrame.lvData.Properties.DefaultItemStyleConfig.Text:=
    'lblCaption.BindItemFieldName:=''客户名称'';'+#13#10
    +'lblDetail.BindItemFieldName:=''公司电话'';'+#13#10
    +'lblDetail1.BindItemFieldName:=''详细地址'';'+#13#10
    ;
  //静态加载数据
  GlobalBillListFrame.Load('客户');

  GlobalBillListFrame.FSelectMode:=True;
end;

procedure TFrameEditBill.btnSendCaptchaClick(Sender: TObject);
begin
//  HideVirtualKeyboard;
//
//  if Self.pnlPhone.Visible then
//  begin
//      //手机号
//      if Self.edtPhone.Text = '' then
//      begin
//        ShowMessageBoxFrame(Self, '请输入手机号!', '', TMsgDlgType.mtInformation,
//          ['确定'], nil);
//        Exit;
//      end;
//
//      if Not IsMobPhone(Self.edtPhone.Text) then
//      begin
//        ShowMessageBoxFrame(Self, '手机号码格式不正确!', '', TMsgDlgType.mtInformation,
//          ['确定'], nil);
//        Exit;
//      end;
//
//  end
//  else
//  begin
//      //邮箱
//      if Self.edtEmail.Text = '' then
//      begin
//        ShowMessageBoxFrame(Self, '请输入邮箱地址!', '', TMsgDlgType.mtInformation,
//          ['确定'], nil);
//        Exit;
//      end;
//
////      if Not IsEmail(Self.edtPhone.Text) then
////      begin
////        ShowMessageBoxFrame(Self, '邮箱地址格式不正确!', '', TMsgDlgType.mtInformation,
////          ['确定'], nil);
////        Exit;
////      end;
//
//  end;
//
//
//
//
//  ShowWaitingFrame(Self, '发送中...');
//
//  Self.btnSendCaptcha.Tag := 0;
//  Self.btnSendCaptcha.Enabled := False;
//
//  uTimerTask.GetGlobalTimerThread.RunTempTask(DoSendRegisterCaptchaExecute,
//    DoSendRegisterCaptchaExecuteEnd,
//    'SendRegisterCaptcha');

end;

procedure TFrameEditBill.Clear;//(AText:String);
begin
//  //用户头像
//  FPetHeadPicFrame.Init(
//                        '',
//                        [],
//                        [],
//                        True,//要裁剪
//                        100,
//                        100,
//                        1     //最多1张
//                        );
//


  Self.edtName.Text := '';
  Self.edtPhone.Text := '';
  Self.edtEmail.Text := '';
//  Self.edtCaptcha.Text := '';
//  Self.edtPass.Text := '';
//  Self.edtRePass.Text := '';
//  Self.edtInviterPhone.Text := '';


  Self.pnlPhone.Visible:=(LangKind=lkZH);


  Self.pnlEmail.Visible:=(LangKind<>lkZH);

  Self.detCompleteDate.DateTime:=0;


  Self.sbClient.VertScrollBar.Prop.Position := 0;
end;

constructor TFrameEditBill.Create(AOwner: TComponent);
begin
  inherited;

//  FPetHeadPicFrame:=TFrameAddPictureListSub.Create(AOwner);
//  //要设置Name,不然会报错
//  SetFrameName(FPetHeadPicFrame);
////  FPetHeadPicFrame.Parent:=Self;//.pnlHeader;
////  FPetHeadPicFrame.Align:=TAlignLayout.Top;
//  FPetHeadPicFrame.Parent:=Self.pnlHeader;
//  FPetHeadPicFrame.Align:=TAlignLayout.HorzCenter;
//  FPetHeadPicFrame.Width:=FPetHeadPicFrame.lvPictures.Prop.ItemWidth+8;
//  FPetHeadPicFrame.pnlToolBar.Visible:=False;
//  FPetHeadPicFrame.lvPictures.Align:=TAlignLayout.Client;
//  FPetHeadPicFrame.lvPictures.Margins.Left:=0;
//
//  Self.pnlHeader.Visible:=False;
//

  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);

  Self.detCompleteDate.DateTime:=0;
end;

procedure TFrameEditBill.DoSaveBillExecute(ATimerTask: TObject);
var
  AServerResponse:String;
//  ARegisterType:String;
//var
//  AHttpControl: THttpControl;
begin
  // 出错
  TTimerTask(ATimerTask).TaskTag := 1;
  try



//    //上传用户头像
//    if not Self.FPetHeadPicFrame.Upload(
//        ImageHttpServerUrl+'/upload'
//                         +'?appid='+(AppID)
//                         +'&filename='+'%s'
//                         +'&filedir='+'userhead_pic'
//                         +'&fileext='+'.png',
//        AServerResponse) then
//    begin
//      TTimerTask(ATimerTask).TaskDesc:=AServerResponse;
//      Exit;
//    end;
//
//
//    if Self.pnlPhone.Visible then
//    begin
//      ARegisterType:=Const_RegisterLoginType_PhoneNum;
//    end
//    else
//    begin
//      ARegisterType:=Const_RegisterLoginType_Email;
//    end;

//
//    TTimerTask(ATimerTask).TaskDesc := SimpleCallAPI(
//      'register_user',
//      nil,
//      UserCenterInterfaceUrl,
//      ['appid',
//      'user_type',
//      'register_type',
//      'phone',
//      'email',
//      'captcha',
//      'name',
//      'password',
//      'inviter_phone',
//
//      'head_pic_path',
//
//      'wx_union_id',
//      'wx_open_id',
//      'wx_auth_token',
//
//      'alipay_open_id',
//      'alipay_auth_token',
//
//      'third_party_username',
//      'third_party_userhead'
//      ],
//      [AppID,
//      APPUserType,
//      ARegisterType,
//      Self.edtPhone.Text,
//      Self.edtEmail.Text,
//      Self.edtCaptcha.Text,
//      Self.edtName.Text,
//      Self.edtPass.Text,
//      Self.edtInviterPhone.Text,
//
//
//      FPetHeadPicFrame.GetServerFileName(0),//如果不存在,不会发生越界错误
//
//      GlobalUserBindThirdPartyAccount.FWxUnionID,
//      GlobalUserBindThirdPartyAccount.FWxOpenID,
//      GlobalUserBindThirdPartyAccount.FWxAuthToken,
//
//      GlobalUserBindThirdPartyAccount.FAlipayOpenID,
//      GlobalUserBindThirdPartyAccount.FAlipayAuthToken,
//
//      GlobalUserBindThirdPartyAccount.FUserName,
//      GlobalUserBindThirdPartyAccount.FUserHeadUrl
//      ],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//                                        );

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


//  // 出错
//  TTimerTask(ATimerTask).TaskTag := 1;
//  AHttpControl := TSystemHttpControl.Create;
//  try
//    try
//      TTimerTask(ATimerTask).TaskDesc := SimpleCallAPI(
//        'register_user',
//        AHttpControl,
//        InterfaceUrl,
//        ['appid', 'name','name_s', 'phone', 'captcha',
//        'password', 'repassword', 'province', 'city', 'area', 'phone_imei',
//        'phone_uuid', 'phone_type', 'bind_code', 'introducer_phone'],
//        [AppID, FName, UpperCase(GetHzPy(FName)), FPhone, FCaptcha, FPassword, FRePassword, FProvince,
//        FCity, FArea, GetIMEI, GetUUID, GetPhoneType, FBindCode,
//        FIntroducerPhone],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret);
//
//      if TTimerTask(ATimerTask).TaskDesc <> '' then
//      begin
//        TTimerTask(ATimerTask).TaskTag := 0;
//      end;
//
//    except
//      on E: Exception do
//      begin
//        // 异常
//        TTimerTask(ATimerTask).TaskDesc := E.Message;
//      end;
//    end;
//  finally
//    FreeAndNil(AHttpControl);
//  end;

end;

procedure TFrameEditBill.DoSaveBillExecuteEnd(ATimerTask: TObject);
var
  ASuperObject: ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag = 0 then
    begin
      ASuperObject := TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code'] = 200 then
      begin

//        // 注册成功
//
//        ShowMessageBoxFrame(frmMain, '注册成功!', '', TMsgDlgType.mtInformation,
//          ['确定'], OnModalResultFromRegisterSucc);


//            //注册用户的接口返回格式改了
//            GlobalManager.User.ParseFromJson(ASuperObject.O['Data']);
//
//            //保存用户登录key,用于下次自动登陆
//            GlobalManager.LastLoginKey:=ASuperObject.O['Data'].S['login_key'];

//            //登录状态
//            uManager.GlobalManager.IsLogin:=True;
//            //保存上次登陆的用户名密码
//            uManager.GlobalManager.Save;
//            //保存这次登录的用户信息
//            uManager.GlobalManager.SaveLastLoginInfo;




//            //登陆成功,统一使用,显示主页MainFrame
//            frmMain.DoCallLoginAPISucc(False,True);



//            // 注册成功
//            if (APPUserType=utClient) or (APPUserType=utRider) then
//            begin
//
//                //注册成功之后，进入主界面
//      //          uFuncCommon.FreeAndNil(GlobalMainFrame);
//                GlobalManager.IsLogin:=True;
//                //显示主界面
//                ShowFrame(TFrame(GlobalMainFrame),TFrameMain,frmMain,nil,nil,nil,Application,True,True,ufsefNone);
//                GlobalMainFrame.FrameHistroy:=CurrentFrameHistroy;
//                GlobalMainFrame.Login;
//
//      //          ShowMessageBoxFrame(frmMain, '注册成功!', '', TMsgDlgType.mtInformation,
//      //            ['确定'], OnModalResultFromRegisterSucc);
//            end;



//            if APPUserType=utShop then
//            begin
//              {$IFDEF SHOP_APP}
//              //刚注册,显示开店页面
//              HideFrame;//(Self,hfcttBeforeShowFrame);
//              ShowFrame(TFrame(GlobalOpenShopFillInfoFrame),TFrameOpenShopFillInfo,frmMain,nil,nil,nil,Application);
//              GlobalOpenShopFillInfoFrame.FrameHistroy:=CurrentFrameHistroy;
//              GlobalOpenShopFillInfoFrame.Clear;
//              {$ENDIF}
//            end;
//
//            if APPUserType=utClient then
//            begin
//              {$IFDEF CLIENT_APP}
//              //显示主页面,但要更新我的信息
//              HideFrame;//(Self,hfcttBeforeShowFrame);
//              ShowFrame(TFrame(GlobalMainFrame),TFrameMain);
//              GlobalMainFrame.FrameHistroy:=CurrentFrameHistroy;
//              GlobalMainFrame.pcMain.Prop.ActivePage:=GlobalMainFrame.tsMy;
//              GlobalMainFrame.FMyFrame.Load;
//              {$ENDIF}
//            end;



        // GlobalManager.User.ParseFromJson(ASuperObject.O['Data'].A['User'].O[0]);
        // //显示实名认证界面
        // HideFrame;//(Self,hfcttBeforeShowFrame);
        // //显示实名认证界面
        // ShowFrame(TFrame(GlobalFillUserInfoFrame),TFrameFillUserInfo,frmMain,nil,nil,nil,Application);
        // GlobalFillUserInfoFrame.FPageIndex:=0;
        // GlobalFillUserInfoFrame.FrameHistroy:=CurrentFrameHistroy;
        // GlobalFillUserInfoFrame.Clear;

      end
      else
      begin
        // 注册失败
        ShowMessageBoxFrame(Self, ASuperObject.S['Desc'], '',
          TMsgDlgType.mtInformation, ['确定'], nil);
      end;

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

procedure TFrameEditBill.DoReturnFrameFromSelectArea(AFrame: TFrame);
begin
  Self.btnSelectArea.Caption:=TFrameSelectArea(AFrame).FSelectedProvince
                              +TFrameSelectArea(AFrame).FSelectedCity
                              +TFrameSelectArea(AFrame).FSelectedArea;
end;

procedure TFrameEditBill.DoReturnFrameFromSelectContact(AFrame:TFrame);
begin
  Self.btnSelectContacts.Caption:= TFrameBillList(AFrame).FSelectedUserJson.S['客户名称'];
end;

procedure TFrameEditBill.DoSendRegisterCaptchaExecute(ATimerTask: TObject);
begin
//  // 出错
//  TTimerTask(ATimerTask).TaskTag := 1;
//    try
//
//      if Self.pnlPhone.Visible then
//      begin
//        //发验证码给手机
//        TTimerTask(ATimerTask).TaskDesc := SimpleCallAPI(
//            'send_register_captcha',
//            nil,
//            UserCenterInterfaceUrl,
//            ['appid',
//            'user_type',
//            'account'],
//            [AppID,
//            APPUserType,
//            Self.edtPhone.Text],
//            GlobalRestAPISignType,
//            GlobalRestAPIAppSecret);
//      end
//      else
//      begin
//        //发验证码给邮箱
//        TTimerTask(ATimerTask).TaskDesc := SimpleCallAPI(
//            'send_register_captcha',
//            nil,
//            UserCenterInterfaceUrl,
//            ['appid',
//            'user_type',
//            'account'],
//            [AppID,
//            APPUserType,
//            Self.edtEmail.Text],
//            GlobalRestAPISignType,
//            GlobalRestAPIAppSecret);
//      end;
//
//      if TTimerTask(ATimerTask).TaskDesc <> '' then
//      begin
//        TTimerTask(ATimerTask).TaskTag := 0;
//      end;
//
//    except
//      on E: Exception do
//      begin
//        // 异常
//        TTimerTask(ATimerTask).TaskDesc := E.Message;
//      end;
//    end;
end;

procedure TFrameEditBill.DoSendRegisterCaptchaExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject: ISuperObject;
begin

//  try
//    if TTimerTask(ATimerTask).TaskTag = 0 then
//    begin
//      ASuperObject := TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code'] = 200 then
//      begin
//        // 发送验证码成功
//        tmrSendCaptchaCheck.Enabled := True;
//      end
//      else
//      begin
//        //按钮恢复默认状态
//        Self.btnSendCaptcha.Enabled := True;
//        Self.btnSendCaptcha.Tag := 61;
//        // 发送验证码失败
//        ShowMessageBoxFrame(Self, ASuperObject.S['Desc'], '',
//          TMsgDlgType.mtInformation, ['确定'], nil);
//      end;
//
//    end
//    else if TTimerTask(ATimerTask).TaskTag = 1 then
//    begin
//      // 网络异常
//      ShowMessageBoxFrame(Self, '网络异常,请检查您的网络连接!', TTimerTask(ATimerTask)
//        .TaskDesc, TMsgDlgType.mtInformation, ['确定'], nil);
//      //按钮恢复默认状态
//      tmrSendCaptchaCheck.Enabled := True;
//      Self.btnSendCaptcha.Tag := 61;
//    end;
//  finally
//    HideWaitingFrame;
//  end;
end;

//function TFrameEditBill.GetCurrentPorcessControl(AFocusedControl: TControl)
//  : TControl;
//begin
//  Result := AFocusedControl;
//end;
//
//function TFrameEditBill.GetVirtualKeyboardControlParent: TControl;
//begin
//  Result := Self;
//end;

procedure TFrameEditBill.Load(AReportName:String; ADataJson:ISuperObject);//(AUserName, AUserHeadPicFilePath, AWxOpenID,
//  AWxAuthToken: String;
//  AAlipayOpenID:String;
//  AAlipayAuthToken:String);
//var
//  ANames:TStringDynArray;
//  AUrls:TStringDynArray;
begin
  FReportName:=AReportName;
  FDataJson:=ADataJson;

//  Self.FUserName:=AUserName;
//  Self.FUserHeadPicFilePath:=AUserHeadPicFilePath;
//
//  Self.FWxOpenID:=AWxOpenID;
//  Self.FWxAuthToken:=AWxAuthToken;
//
//  Self.FAlipayOpenID:=AAlipayOpenID;
//  Self.FAlipayAuthToken:=AAlipayAuthToken;


//  Self.edtName.Text:=GlobalUserBindThirdPartyAccount.FUserName;
//
//
//  //用户头像
//  if GlobalUserBindThirdPartyAccount.FUserHeadPicFilePath<>'' then
//  begin
//      SetLength(ANames,0);
//      SetLength(AUrls,0);
//
////      SetLength(ANames,1);
////      SetLength(AUrls,1);
////      if AUserHeadPicFilePath<>'' then
////      begin
////        ANames[0]:=AUserHeadPicFilePath;
////        AUrls[0]:=AUserHeadPicFilePath;
////      end;
//
//
//      FPetHeadPicFrame.Init(
//                            '',
//                            ANames,
//                            AUrls,
//                            True, //裁剪
//                            100,
//                            100,
//                            1     //最多1张
//                            );
//
//      FPetHeadPicFrame.AddPicture(GlobalUserBindThirdPartyAccount.FUserHeadPicFilePath);
//  end;
//
//
//  Self.pnlPhone.Visible:=(LangKind=lkZH);
//  Self.pnlEmail.Visible:=(LangKind<>lkZH);
//

  if FReportName = '客户' then
  begin

    Self.edtCode.Text:= FDataJson.S['客户编号'];
    Self.edtName.Text:= FDataJson.S['客户名称'];
    Self.btnSelectArea.Caption:= FDataJson.S['国家地区'];
    Self.edtPhone.Text:= FDataJson.S['公司电话'];

  end
  else
  begin

    Self.edtCode.Text:= FDataJson.S['AUTOID'];
    Self.edtName.Text:= FDataJson.S['姓名'];
    Self.edtPhone.Text:= FDataJson.S['手机'];

  end;

end;

//procedure TFrameEditBill.Load(ABindCode: String; AIntroducerPhone: String);
//begin
//
//  FBindCode := ABindCode;
//  FIntroducerPhone := AIntroducerPhone;
//
//end;

procedure TFrameEditBill.OnModalResultFromRegisterSucc(Frame: TObject);
begin

//  // 注册成功
//
//  // 显示登录界面
//  HideFrame;//(Self, hfcttBeforeShowFrame);
//  // 显示登陆界面
//  ShowFrame(TFrame(GlobalLoginFrame), TFrameLogin, frmMain, nil, nil, nil,Application);
//  GlobalLoginFrame.FrameHistroy := CurrentFrameHistroy;

//  // 在登录页面输入用户名密码
//  GlobalLoginFrame.edtUser.Text := FPhone;
//  GlobalLoginFrame.edtPass.Text := FPassword;

end;

procedure TFrameEditBill.btnReturnClick(Sender: TObject);
begin
//  if IsRepeatClickReturnButton(Self) then Exit;
//
//  //按钮恢复默认
//  Self.btnSendCaptcha.Tag := 61;

  HideFrame;//(Self, hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);
end;

procedure TFrameEditBill.btnCancelClick(Sender: TObject);
begin
  HideFrame;
  ReturnFrame;
end;

procedure TFrameEditBill.tmrSendCaptchaCheckTimer(Sender: TObject);
begin
//  Self.btnSendCaptcha.Tag := Self.btnSendCaptcha.Tag + 1;
//  if Self.btnSendCaptcha.Tag > 60 then
//  begin
//    Self.btnSendCaptcha.Caption := '发送验证码';
//    Self.btnSendCaptcha.Enabled := True;
//    Self.btnSendCaptcha.Prop.IsPushed := False;
//
//    tmrSendCaptchaCheck.Enabled := False;
//  end
//  else
//  begin
//    Self.btnSendCaptcha.Caption := '剩余' +
//      IntToStr(60 - Self.btnSendCaptcha.Tag) + '秒';
//    Self.btnSendCaptcha.Enabled := False;
//    Self.btnSendCaptcha.Prop.IsPushed := True;
//  end;
end;

end.

