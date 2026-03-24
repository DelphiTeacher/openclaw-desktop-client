unit MyFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uOpenCommon,
  uDrawCanvas,

  uSkinItems,
  uDrawPicture,

  uSkinMaterial,
  WaitingFrame,
  MessageBoxFrame,
  PopupMenuFrame,
  uDataSetToJson,
  uOpenClientCommon,
//  ShareScoreListFrame,
//  MyInvitationCodeFrame,
//  MyGameInfoFrame,
//  uMyVIPListPage,
//
//  uConst,
  uGraphicCommon,
  WebBrowserFrame,
//  ContentWebBrowserFrame,
  NoticeListFrame,
  UserSuggectionFrame,
  AboutUsFrame,
  ForgetPasswordFrame,
//  uBasePageFrame,
//  uPageFramework,
//  uRolePage,
//  MyFrame,
//  BaseProduct,
//  BaseClient,
//  BaseEmp,
//  BaseStock,
//  BaseDepart,
//  BuyVersionFrame,

  uManager,
  uTimerTask,
  uUIFunction,
  XSuperObject,
  XSuperJson,
  uFrameContext,
//  uDataSetToJson,
  uRestInterfaceCall,
  uBaseHttpControl,
  CommonImageDataMoudle,
  EasyServiceCommonMaterialDataMoudle,

  SettingFrame,
  UserInfoFrame,
  ChangeThemeFrame,
//  BaseFinanceSubject,

  uSkinFireMonkeyScrollControl, uSkinFireMonkeyVirtualList,
  uSkinFireMonkeyListBox, uSkinFireMonkeyControl, uSkinFireMonkeyPanel,
  uSkinFireMonkeyItemDesignerPanel, uSkinFireMonkeyLabel, uSkinFireMonkeyImage,
  uSkinFireMonkeyRoundImage, uSkinFireMonkeyCustomList, uSkinFireMonkeyListView,
  uSkinFireMonkeyButton, uSkinFireMonkeyNotifyNumberIcon, uSkinImageList,
  uSkinLabelType, uSkinPanelType, uSkinImageType, uSkinItemDesignerPanelType,
  uBaseSkinControl, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinButtonType, uSkinListBoxType,
//  CaptchaFrame,
//  GiftPackageCenterFrame,
  uSkinNotifyNumberIconType, FMX.Effects, System.Notification;

type
  TFrameMy = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    lblMy: TSkinFMXLabel;
    lvMy: TSkinFMXListView;
    idpItem3: TSkinFMXItemDesignerPanel;
    imgPicture: TSkinFMXImage;
    lblName: TSkinFMXLabel;
    btnSetting: TSkinFMXButton;
    idpMy: TSkinFMXItemDesignerPanel;
    imgUserHead: TSkinFMXImage;
    lblUserName: TSkinFMXLabel;
    lblUserDetail: TSkinFMXLabel;
    nniNumber: TSkinFMXNotifyNumberIcon;
    btnNotice: TSkinFMXButton;
    btnReturn: TSkinFMXButton;
    imgUserVip: TSkinFMXImage;
    imgMyItemBackground: TSkinFMXImage;
    SkinFMXImage2: TSkinFMXImage;
    pnlName: TSkinFMXPanel;
    imgSex: TSkinFMXImage;
    imgBackground: TSkinFMXImage;
    btnVIPType: TSkinFMXButton;
    SkinFMXPanel1: TSkinFMXPanel;
    lblDescript: TSkinFMXLabel;
    SkinFMXButton3: TSkinFMXButton;
    SkinFMXButton4: TSkinFMXButton;
    imgVIP: TSkinFMXImage;
    SkinFMXImage3: TSkinFMXImage;
    imgVIPSign: TSkinFMXImage;
    SkinFMXLabel1: TSkinFMXLabel;
    btnContinueBuy: TSkinFMXButton;
    lblPhone: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    lblProcess: TSkinFMXLabel;
    lblPower: TSkinFMXLabel;
    SkinFMXImage4: TSkinFMXImage;
    procedure lvMyClickItem(AItem: TSkinItem);
    procedure lvMyPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
      AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem;
      AItemDrawRect: TRect);
    procedure btnSettingClick(Sender: TObject);
    procedure nniNumberClick(Sender: TObject);
    procedure btnNoticeClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure lvMyResize(Sender: TObject);
    procedure btnButton1Click(Sender: TObject);
    procedure btnButton2Click(Sender: TObject);
    procedure btnButton4Click(Sender: TObject);
    procedure btnButton3Click(Sender: TObject);
    procedure btnFocusedClick(Sender: TObject);
    procedure btnFansClick(Sender: TObject);
    procedure btnAllClick(Sender: TObject);
    procedure btnVisitorsClick(Sender: TObject);
    procedure SkinFMXButton1Click(Sender: TObject);
    procedure pnlBtnResize(Sender: TObject);
    procedure pnlContentCountResize(Sender: TObject);
    procedure btnNewsClick(Sender: TObject);
    procedure btnCommunityClick(Sender: TObject);
    procedure btnPostesClick(Sender: TObject);
    procedure pnl4ButtonsResize(Sender: TObject);
    procedure SkinFMXButton4Click(Sender: TObject);
    procedure btnContinueBuyClick(Sender: TObject);
  private
//    //背景色(在Frame上绘制,Frame.OnPainting)
//    function GetFillColor:TDelphiColor;
//    function GetFormColor:TDelphiColor;
//  private
//    //当前登录的用户ID,用于重新登录时判断是否需要重新加载
//    FUserFID:String;
//
//    //用户当前积分
//    FUserScore:Double;
//
//    //从设置页面返回
//    procedure OnReturnFromSettingFrame(Frame:TFrame);
//    //从通知分类页面返回
//    procedure OnReturnFrameFromNoticeClassifyListFrame(Frame:TFrame);
//    //从我的钱包页面返回
//    procedure OnReturnFromWalletFrame(AFrame:TFrame);
//    //从我的积分页面返回
//    procedure OnReturnFromScoreFrame(AFrame:TFrame);
//    //从修改个人信息返回
//    procedure OnFromChangeUserInfoFrame(AFranme:TFrame);
//  private
//    //账户余额
//    procedure DoGetUserWalletExecute(ATimerTask:TObject);
//    procedure DoGetUserWalletExecuteEnd(ATimerTask:TObject);
//    //红包个数
//    procedure DoGetUserCouponListExecute(ATimerTask:TObject);
//    procedure DoGetUserCouponListExecuteEnd(ATimerTask:TObject);
//  private
//    //获取个人信息
//    procedure DoGetUserInfoExecute(ATimerTask:TObject);
//    procedure DoGetUserInfoExecuteEnd(ATimerTask:TObject);
//    //
//    procedure DoGetMyContentStatisticsExecute(ATimerTask:TObject);
//    procedure DoGetMyContentStatisticsExecuteEnd(ATimerTask:TObject);
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
  public
    //用户获取红包个数
//    procedure GetCouponCount;
  public
    //加载个人信息
    procedure Load;

//    //用户获取账户余额
//    procedure GetWallet;
//    //获取个人信息
//    procedure GetUserInfo;
    { Public declarations }
  end;



var
  GlobalMyFrame:TFrameMy;


implementation

uses
  LoginFrame,
  MainForm;

//uses CommonImageDataMoudle;//  MainForm,
//  MainFrame,
//  uLang,
//  DelphiClientMainForm,
////  AddGroupFrame,
//  MyAttentionFrame,
//  MyPublishedFrame,
//  ContentListFrame,
//  VisitorFrame,
////  UserCouponFrame,
////  MyWalletFrame,
////  UserBalanceFrame,
//  MyScoreFrame,
////  SecurityAndPrivacyFrame,
//  ChangePasswordFrame,
//  MyBankCardListFrame,
////  PictureWallFrame,
////  MyInvitationCodeFrame,
//  RecvAddrListFrame,
//  SettingFrame,
//  UserInfoFrame,
//  UserSuggectionFrame,
////  MyCollectShopListFrame,
////  LookedShopListFrame,
//  LoginFrame,
////  IndianaFrame,
////  TelMainFrame,
////  MyStockRightFrame,
//  UserOrderListFrame,
//  NoticeClassifyListFrame;


{$R *.fmx}

{ TFrameMy }

procedure TFrameMy.btnButton1Click(Sender: TObject);
begin
  //剩下的这些功能要登录才能使用
//  if not GlobalManager.IsLogin then
//  begin
//    ShowLoginFrame(True);
//    Exit;
//  end;
//
//  //显示验证码页面
//  //隐藏
//  HideFrame();
//  //显示验证码明细页面
//  ShowFrame(TFrame(GlobalCaptchaFrame),TFrameCaptcha);
//  GlobalCaptchaFrame.Load;


//                //用户反馈
//                 //隐藏
//                 HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//                 //显示收藏列表
//                 ShowFrame(TFrame(GlobalUserSuggectionFrame),TFrameUserSuggection,frmMain,nil,nil,nil,Application);
//      //           GlobalUserSuggectionFrame.FrameHistroy:=CurrentFrameHistroy;
//                 GlobalUserSuggectionFrame.Add;
//

end;

procedure TFrameMy.btnButton2Click(Sender: TObject);
begin
//  if not GlobalManager.IsLogin then
//  begin
//    ShowLoginFrame(True);
//    Exit;
//  end;
//
//  //显示礼包中心
//  //隐藏
//  HideFrame();
//  //显示礼包中心页面
//  ShowFrame(TFrame(GlobalGiftPackageCenterFrame),TFrameGiftPackageCenter);
//  GlobalGiftPackageCenterFrame.Load;



//  frmMain.ScanQRCode;

end;

procedure TFrameMy.btnButton3Click(Sender: TObject);
begin
//  if not GlobalManager.IsLogin then
//  begin
//    ShowLoginFrame(True);
//    Exit;
//  end;
//
//  //显示积分页面
//  //隐藏
//  HideFrame();
//  //显示积分明细页面
//  ShowFrame(TFrame(GlobalMyScoreFrame),TFrameMyScore);
//  GlobalMyScoreFrame.Init;//(GlobalManager.User.score);
end;

procedure TFrameMy.btnButton4Click(Sender: TObject);
begin
  //frmMain.ScanQRCode;

  //
//  TfrmOrangeUIClientMain(frmMain).
//  ShowMyVIPListPage;
end;

procedure TFrameMy.btnCommunityClick(Sender: TObject);
begin
//  //未登录时调到登录页面
//  if not GlobalManager.IsLogin then
//  begin
//    //隐藏
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    //显示登录页面
//    ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
//    //清除输入框
//    GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
//  end
//  else
//  begin

//  if not GlobalManager.IsLogin then
//  begin
//    ShowLoginFrame(True);
//    Exit;
//  end;
//
//
//
//  HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//  ShowFrame(TFrame(GlobalMyPublishedFrame),TFrameMyPublished,frmMain,nil,nil,nil,Application);
//  GlobalMyPublishedFrame.Load('community');


//  end;

end;

procedure TFrameMy.btnContinueBuyClick(Sender: TObject);
begin
//  //续费
//  HideFrame;
//  ShowFrame(TFrame(GlobalBuyVersionFrame),TFrameBuyVersion);

end;

procedure TFrameMy.btnFansClick(Sender: TObject);
begin
//  //未登录时调到登录页面
//  if not GlobalManager.IsLogin then
//  begin
//    //隐藏
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    //显示登录页面
//    ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
////      GlobalLoginFrame.FrameHistroy:=CurrentFrameHistroy;
//    //清除输入框
//    GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
//  end
//  else
//  begin

//    if not GlobalManager.IsLogin then
//    begin
//      ShowLoginFrame(True);
//      Exit;
//    end;
//
//
//    //我的粉丝
//    HideFrame;//(GlobalMainFrame);
//    ShowFrame(TFrame(GlobalMyAttentionFrame),TFrameMyAttention,frmMain,nil,nil,nil,Application);
//    GlobalMyAttentionFrame.lbOrderState.Prop.Items.FindItemByCaption('粉丝').Selected:=True;
//    GlobalMyAttentionFrame.Load;


//  end;
end;

procedure TFrameMy.btnFocusedClick(Sender: TObject);
begin
//  //未登录时调到登录页面
//  if not GlobalManager.IsLogin then
//  begin
//    //隐藏
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    //显示登录页面
//    ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
////      GlobalLoginFrame.FrameHistroy:=CurrentFrameHistroy;
//    //清除输入框
//    GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
//  end
//  else
//  begin
//    //我的关注
//    HideFrame;//(GlobalMainFrame);
//    ShowFrame(TFrame(GlobalMyAttentionFrame),TFrameMyAttention,frmMain,nil,nil,nil,Application);
//    GlobalMyAttentionFrame.lbOrderState.Prop.Items.FindItemByCaption('关注').Selected:=True;
//    GlobalMyAttentionFrame.Load;
//  end;
end;

procedure TFrameMy.btnNewsClick(Sender: TObject);
begin
//  //未登录时调到登录页面
//  if not GlobalManager.IsLogin then
//  begin
//    //隐藏
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    //显示登录页面
//    ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
//    //清除输入框
//    GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
//  end
//  else
//  begin

//    if not GlobalManager.IsLogin then
//    begin
//      ShowLoginFrame(True);
//      Exit;
//    end;
//
//
//
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    ShowFrame(TFrame(GlobalMyPublishedFrame),TFrameMyPublished,frmMain,nil,nil,nil,Application);
//    GlobalMyPublishedFrame.Load('news');


//  end;

end;

procedure TFrameMy.btnNoticeClick(Sender: TObject);
begin
//  //未登录时调到登录页面
//  if not GlobalManager.IsLogin then
//  begin
//
//      //隐藏
//      HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//      //显示登录页面
//      ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
////      GlobalLoginFrame.FrameHistroy:=CurrentFrameHistroy;
//      //清除输入框
//      GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
//
//  end
//  else
//  begin
//      //通知中心
//      HideFrame;//(GlobalMainFrame);
//      ShowFrame(TFrame(GlobalNoticeClassifyListFrame),TFrameNoticeClassifyList,OnReturnFrameFromNoticeClassifyListFrame);
//      GlobalNoticeClassifyListFrame.Load;
//  end;

end;

procedure TFrameMy.btnPostesClick(Sender: TObject);
begin
//  //未登录时调到登录页面
//  if not GlobalManager.IsLogin then
//  begin
//    //隐藏
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    //显示登录页面
//    ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
//    //清除输入框
//    GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
//  end
//  else
//  begin

//    if not GlobalManager.IsLogin then
//    begin
//      ShowLoginFrame(True);
//      Exit;
//    end;
//
//
//
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    ShowFrame(TFrame(GlobalMyPublishedFrame),TFrameMyPublished,frmMain,nil,nil,nil,Application);
//    GlobalMyPublishedFrame.Load('circle');
//


//  end;

end;

procedure TFrameMy.btnReturnClick(Sender: TObject);
begin
  if IsRepeatClickReturnButton(Self) then Exit;

  HideFrame;
  ReturnFrame;
end;

procedure TFrameMy.btnSettingClick(Sender: TObject);
begin
//  //隐藏
//  HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//
//  //显示设置页面
//  ShowFrame(TFrame(GlobalSettingFrame),TFrameSetting,frmMain,nil,nil,OnReturnFromSettingFrame,Application);
//  GlobalSettingFrame.Load;
end;

procedure TFrameMy.btnVisitorsClick(Sender: TObject);
begin
//  //隐藏
//  HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//
//  //显示设置页面
//  ShowFrame(TFrame(GlobalVisitorFrame),TFrameVisitor,frmMain,nil,nil,nil,Application);
//  GlobalVisitorFrame.Load;
end;

constructor TFrameMy.Create(AOwner: TComponent);
begin
  inherited;
  //翻译的先注释
//  RecordSubControlsLang(Self);
//  TranslateSubControlsLang(Self);

//  Self.pnlToolBar.SelfOwnMaterialToDefault.BackColor.FillColor.Color:=SkinThemeColor;
//  Self.idpMy.SelfOwnMaterialToDefault.BackColor.FillColor.Color:=SkinThemeColor;

//  Self.lblNameDetail.SelfOwnMaterialToDefault.DrawCaptionParam.FontColor:=SkinThemeColor;
//  Self.nniNumber.SelfOwnMaterialToDefault.DrawCaptionParam.FontColor:=SkinThemeColor;
//
//  FUserScore:=0;
//
//  Self.imgMyRelese.Prop.Picture.SkinImageList:=dmCommonImageDataMoudle.imglistOthers;
//  Self.imgFunctionBackground.Prop.Picture.SkinImageList:=dmCommonImageDataMoudle.imglistOthers;


end;

//procedure TFrameMy.DoGetUserCouponListExecute(ATimerTask: TObject);
//begin
//  // 出错
//  TTimerTask(ATimerTask).TaskTag := 1;
//  try
//    TTimerTask(ATimerTask).TaskDesc :=SimpleCallAPI('get_my_coupon_list',
//                                                      nil,
//                                                      ShopCenterInterfaceUrl,
//                                                      ['appid',
//                                                      'user_fid',
//                                                      'key'],
//                                                      [AppID,
//                                                      GlobalManager.User.fid,
//                                                      GlobalManager.User.key
//                                                      ],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
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
//end;
//
//procedure TFrameMy.DoGetUserCouponListExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//  I: Integer;
//  AListBoxItem:TSkinListBoxItem;
//  ACouponObject:ISuperObject;
//  ADateTime:TDateTime;
//begin
//  if TTimerTask(ATimerTask).TaskTag=0 then
//  begin
//    ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//    if ASuperObject.I['Code']=200 then
//    begin
//      //获取成功
//
////      Self.lvMy.Prop.Items.FindItemByName('coupon').Detail:=
////                        IntToStr(ASuperObject.O['Data'].A['MyCouponList'].Length)+'个';
//
//    end
//    else
//    begin
//      //调用失败
//      ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//    end;
//
//  end
//  else if TTimerTask(ATimerTask).TaskTag=1 then
//  begin
//    //网络异常
//    ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//  end;
//
//end;

//procedure TFrameMy.DoGetMyContentStatisticsExecute(ATimerTask: TObject);
//begin
//  // 出错
//  TTimerTask(ATimerTask).TaskTag := 1;
//  try
//    TTimerTask(ATimerTask).TaskDesc :=SimpleCallAPI('get_my_content_statistics',
//                                                      nil,
//                                                      UserCenterInterfaceUrl,
//                                                      ['appid',
//                                                      'user_fid',
//                                                      'key'],
//                                                      [AppID,
//                                                      GlobalManager.User.fid,
//                                                      GlobalManager.User.key
//                                                      ],
//                                                      GlobalRestAPISignType,
//                                                      GlobalRestAPIAppSecret
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
//end;
//
//procedure TFrameMy.DoGetMyContentStatisticsExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//  AUserObject:ISuperObject;
//  APicListArr:ISuperArray;
//  aIndex:Integer;
//begin
//
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//        Self.lvMy.Prop.Items.BeginUpdate;
//        try
//          AUserObject:=ASuperObject.O['Data'].A['MyContentStatistics'].O[0];
//          btnFans.Caption:=AUserObject.I['focusedme'].ToString;
//          btnFocused.Caption:=AUserObject.I['myfocused'].ToString;
//          btnVisitors.Caption:=AUserObject.I['visitors'].ToString;
//          btnNews.Caption:=AUserObject.I['mynews'].ToString;
//          btnCommunity.Caption:=AUserObject.I['mycommunity'].ToString;
//          btnPostes.Caption:=AUserObject.I['postid'].ToString;
//
//          APicListArr:=ASuperObject.O['Data'].A['PicList'] ;
//
//          aIndex:= APicListArr.Length-1;
//          if aIndex>=0 then
//          begin
//            img1.Prop.Picture.Url:=GetImageUrl(APicListArr.O[aIndex].S['pic1_path'],itNone,False);
//            img1.Prop.Picture.PictureDrawType:=TPictureDrawType.pdtUrl;
//          end;
//          if aIndex>=1 then
//          begin
//            img2.Prop.Picture.Url:=GetImageUrl(APicListArr.O[aIndex-1].S['pic1_path'],itNone,False);
//            img2.Prop.Picture.PictureDrawType:=TPictureDrawType.pdtUrl;
//          end;
//          if aIndex>=2 then
//          begin
//            img3.Prop.Picture.Url:=GetImageUrl(APicListArr.O[aIndex-2].S['pic1_path'],itNone,False);
//            img3.Prop.Picture.PictureDrawType:=TPictureDrawType.pdtUrl;
//          end;
//        finally
//          Self.lvMy.Prop.Items.EndUpdate;
//        end;
//      end
//      else
//      begin
//        //调用失败
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
//    //HideWaitingFrame;
//  end;
//end;
//
//procedure TFrameMy.DoGetUserInfoExecute(ATimerTask: TObject);
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
//                                                      ],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
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
//end;
//
//procedure TFrameMy.DoGetUserInfoExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//  AUserObject:ISuperObject;
//begin
//
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
////        AUserObject:=ASuperObject.O['Data'].A['UserMoney'].O[0];
//        FUserScore:=ASuperObject.O['Data'].A['User'].O[0].F['score'];
//        Self.lvMy.Prop.Items.FindItemByName('score').Detail:=Format('%.2f',[FUserScore]);
//      end
//      else
//      begin
//        //调用失败
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
//end;
//
//procedure TFrameMy.DoGetUserWalletExecute(ATimerTask: TObject);
//begin
//  //出错
//  TTimerTask(ATimerTask).TaskTag:=1;
//
//  try
//    TTimerTask(ATimerTask).TaskDesc:=
//            SimpleCallAPI('get_user_money',
//                          nil,
//                          PayCenterInterfaceUrl,
//                          ['appid',
//                          'user_fid'
//                          ],
//                          [AppID,
//                          GlobalManager.User.fid
//                          ],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//                          );
//    if TTimerTask(ATimerTask).TaskDesc<>'' then
//    begin
//      TTimerTask(ATimerTask).TaskTag:=0;
//    end;
//
//  except
//    on E:Exception do
//   begin
//    //异常
//    TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
//
//end;
//
//procedure TFrameMy.DoGetUserWalletExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
//  AUserWalletObject:ISuperObject;
//begin
//
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//        AUserWalletObject:=ASuperObject.O['Data'].A['UserMoney'].O[0];
//
//        Self.lvMy.Prop.Items.FindItemByName('money').Detail6:=FloatToStr(GetJsonDoubleValue(AUserWalletObject,'money'));
//
//        Self.lvMy.Prop.Items.FindItemByName('money').Detail:=
//                                Format('%.2f',[GetJsonDoubleValue(AUserWalletObject,'money')])+'元';
//
//      end
//      else
//      begin
//        //调用失败
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
//end;

//function TFrameMy.GetFillColor: TDelphiColor;
//begin
//  Result:=uGraphicCommon.SkinThemeColor;
//
//end;
//
//function TFrameMy.GetFormColor: TDelphiColor;
//begin
//  Result:=uGraphicCommon.SkinThemeColor;
//end;

//procedure TFrameMy.GetCouponCount;
//begin
//  uTimerTask.GetGlobalTimerThread.RunTempTask(
//                  DoGetUserCouponListExecute,
//                  DoGetUserCouponListExecuteEnd);
//end;

//procedure TFrameMy.GetUserInfo;
//begin
//  if GlobalManager.IsLogin then
//  begin
//    //用户积分在用户表中有个积分字段
//    uTimerTask.GetGlobalTimerThread.RunTempTask(
//                 DoGetUserInfoExecute,
//                 DoGetUserInfoExecuteEnd,
//                 'GetUserInfo');
//  end;
//end;
//
//procedure TFrameMy.GetWallet;
//begin
//  if GlobalManager.IsLogin then
//  begin
//    uTimerTask.GetGlobalTimerThread.RunTempTask(
//               DoGetUserWalletExecute,
//               DoGetUserWalletExecuteEnd,
//               'GetUserWallet');
//  end;
//end;

procedure TFrameMy.Load;
var
  I: Integer;
  AMenuJson:ISuperObject;
begin
//  Self.lvMy.Prop.Items.FindItemByCaption('角色权限').Visible:=(GlobalManager.EmployeeJson.S['权限']='管理员');

//  FUserFID:=GlobalManager.User.fid;
//
//
//  //未登录时要隐藏的项
//  //隐藏
//  if not GlobalManager.IsLogin then
//  begin
//      Self.nniNumber.Prop.Number:=0;
//
////      Self.btnNotice.Visible:=False;
////      Self.btnSetting.Visible:=False;
//
//
//
////      for I := 0 to Self.lvMy.Prop.Items.Count-1 do
////      begin
////        if Self.lvMy.Prop.Items[I].ItemType=sitItem4 then
////        begin
////          Self.lvMy.Prop.Items[I].Visible:=False;
////        end;
////
//////        if Self.lvMy.Prop.Items[I].ItemType=sitItem3 then
//////        begin
//////          if (Self.lvMy.Prop.Items[I].Caption = '积分夺宝')
//////          OR (Self.lvMy.Prop.Items[I].Caption = '邀请好友')
//////          OR (Self.lvMy.Prop.Items[I].Caption = '我的贡献') then
//////          begin
//////            Self.lvMy.Prop.Items[I].Visible:=False;
//////          end;
//////        end;
////
////        if Self.lvMy.Prop.Items[I].ItemType=sitDefault then
////        begin
////          Self.lvMy.Prop.Items[I].Visible:=True;
////        end;
////      end;
//
//
//
//
////      Self.lvMy.Prop.Items.FindItemByCaption('邀请好友').Visible:=False;
//      //头像
////      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Icon.ImageIndex:=0;
//      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Icon.ImageIndex:=-1;
//      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Icon.Url:=
//        GlobalManager.User.GetHeadPicUrl;
//      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Icon.IsClipRound:=True;
//      //姓名
//      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Caption:='立即登录';
//      //手机号
//      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Detail:='请先登录>';//'登录后可享受更多特权';
//      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Detail1:='';
//
//      btnFans.Caption:='0';
//      btnFocused.Caption:='0';
//      btnVisitors.Caption:='0';
//      btnNews.Caption:='0';
//      btnCommunity.Caption:='0';
//      btnPostes.Caption:='0';
//
//      lvMy.Prop.Items.FindItemByName('pic').Visible:=False;
//
//
//      imgUserVip.Visible:=False;
//
//      imgSex.Visible:=False;
//
//
//
//
//  end
//  //登录后要显示的项
//  else
//  begin
//
////      Self.btnNotice.Visible:=True;
////      Self.btnSetting.Visible:=True;
//
//      Self.nniNumber.Prop.Number:=GlobalManager.User.notice_unread_count;
//
//
//
////      for I := 0 to Self.lvMy.Prop.Items.Count-1 do
////      begin
////        if Self.lvMy.Prop.Items[I].ItemType=sitItem4 then
////        begin
////            Self.lvMy.Prop.Items[I].Visible:=False;//True;
////        end;
////
////        if Self.lvMy.Prop.Items[I].ItemType=sitItem3 then
////        begin
//////          OR (Self.lvMy.Prop.Items[I].Caption = '积分夺宝')
////
//////          if (Self.lvMy.Prop.Items[I].Caption = '邀请好友') then
//////          begin
//////            Self.lvMy.Prop.Items[I].Visible:=True;
//////          end;
//////
//////          if (Self.lvMy.Prop.Items[I].Caption = '我的贡献') then
//////          begin
//////            Self.lvMy.Prop.Items[I].Visible:=True;
//////          end;
////
//////          if (Self.lvMy.Prop.Items[I].Caption = '积分夺宝') then
//////          begin
//////            Self.lvMy.Prop.Items[I].Visible:=False;
//////          end;
////
////        end;
////
////        if Self.lvMy.Prop.Items[I].ItemType=sitDefault then
////        begin
////          Self.lvMy.Prop.Items[I].Visible:=False;
////        end;
////      end;
//
//
//
////      Self.lvMy.Prop.Items.FindItemByCaption('邀请好友').Visible:=True;


      //姓名
      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Caption:=
        GlobalManager.User.Name;
      //公司
      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Detail:=
        GlobalManager.User.Phone;
//      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Detail1:=
//        GlobalManager.EmployeeJson.S['权限'];
//      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Detail2:=
//        GlobalManager.EmployeeJson.S['岗位'];
      //头像
      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Icon.ImageIndex:=-1;
      //默认头像
      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Icon.SkinImageList:=dmCommonImageDataMoudle.imgHeadList;
      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Icon.DefaultImageIndex:=0;
      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Icon.PictureDrawType:=pdtUrl;

      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Icon.Url:=GetImageUrl(GlobalManager.User.head_pic_path,itNone);
//        GlobalManager.User.GetHeadPicUrl;
      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Icon.IsClipRound:=True;



//      //性别
//      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Pic.ImageIndex:=-1;
//      if GlobalManager.User.sex=0 then
//      begin
//        Self.lvMy.Prop.Items.FindItemByType(sitItem1).Pic.ImageIndex:=0;
//      end else
//      begin
//        Self.lvMy.Prop.Items.FindItemByType(sitItem1).Pic.ImageIndex:=1;
//      end;
//      //id
////      if GlobalManager.User.fid<>'' then
////      begin
////        Self.lvMy.Prop.Items.FindItemByType(sitItem1).Detail1:=GlobalManager.User.phone;//'ID:'+GlobalManager.User.fid;
////      end;
//      if GlobalManager.User.phone<>'' then
//      begin
//        //手机号
//        Self.lvMy.Prop.Items.FindItemByType(sitItem1).Detail1:=//'点击查看个人主页或编辑个人资料';
//          GlobalManager.User.Phone;
//      end
//      else
//      begin
//        //邮箱
//        Self.lvMy.Prop.Items.FindItemByType(sitItem1).Detail1:=
//          GlobalManager.User.email;
//      end;
//      Self.lvMy.Prop.Items.FindItemByType(sitItem1).Detail:='个人主页>';//'点击查看个人主页或编辑个人资料';
//
//
//
////      Self.GetWallet;
//
////      Self.GetCouponCount;
//
//      //获取个人信息  包含积分
////      Self.GetUserInfo;
//
//
//
//    imgSex.Visible:=True;
//
//    //判断是否显示认证图标
//    if GlobalManager.User.isvip=1 then
//    begin
//      imgUserVip.Visible:=True;
//    end
//    else if GlobalManager.User.isvip=0 then
//    begin
//      imgUserVip.Visible:=False;
//    end;
//
//
//    //ShowWaitingFrame(frmMain,Trans('获取中...'));
//    //
//    uTimerTask.GetGlobalTimerThread.RunTempTask(
//        DoGetMyContentStatisticsExecute,
//        DoGetMyContentStatisticsExecuteEnd,
//        'get_my_content_statistics'
//        );
//  end;
//
//
//
//  //发布时先去掉
////  pnlBtn.Visible:=False;
////  Self.lvMy.Prop.Items.FindItemByType(sitItem1).Height:=100;
//  if Self.lvMy.Prop.Items.FindItemByCaption('照片墙')<>nil then
//  begin
//    Self.lvMy.Prop.Items.FindItemByCaption('照片墙').Visible:=False;
//  end;
////  if Self.lvMy.Prop.Items.FindItemByType(sitHeader)<>nil then
////  begin
////    Self.lvMy.Prop.Items.FindItemByType(sitHeader).Visible:=False;
////  end;
////  if Self.lvMy.Prop.Items.FindItemByCaption('我的任务')<>nil then
////  begin
////    Self.lvMy.Prop.Items.FindItemByCaption('我的任务').Visible:=False;
////  end;
//
//
////  //根据服务端设置来显示与隐藏
////  //是否需要这个菜单
////  if (Self.lvMy.Prop.Items.FindItemByCaption('我的股份')<>nil)
////    and (GlobalManager.AppJson<>nil)
////    and GlobalManager.AppJson.Contains('menu_list')
////    and (LocateJsonArray(GlobalManager.AppJson.A['menu_list'],'caption','我的股份')<>nil)
////    then
////  begin
////    AMenuJson:=LocateJsonArray(GlobalManager.AppJson.A['menu_list'],'caption','我的股份');
////    Self.lvMy.Prop.Items.FindItemByCaption('我的股份').Visible:=(AMenuJson.I['visible']=1);
////  end;
////
////
////  //默认头像
////  Self.lvMy.Prop.Items.FindItemByType(sitHeader).Icon.ImageIndex:=0;
////  Self.lbMenu.Prop.Items.FindItemByType(sitHeader).Icon.PictureDrawType:=
////    TPictureDrawType.pdtUrl;
//

end;

procedure TFrameMy.lvMyClickItem(AItem: TSkinItem);
//var
//  ABasePageFrame:TFrameBasePage;
begin
// if AItem.Caption = '同步资料' then
//    btnUpBaseInfoClick(btnUpBaseInfo)
// else if  AItem.Caption = '同步库存'  then
//    btnSyncStorehouseClick(btnSyncStorehouse)
// else if  AItem.Caption = '打印配置'  then
//    btnPrintDeviceClick(btnPrintDevice)
// else if AItem.Caption = '版本更新'  then
//    btnCheckVersionClick( btnCheckVersion)
// else if AItem.Caption = '录单配置' then
//    btnBillHeadSetClick(btnBillHeadSet)
// else if AItem.Caption = '身份信息' then
//    btnMobileInfoClick(btnMobileInfo)
// else if  AItem.Caption = '注销退出' then
//    btnExitClick(btnExit)
// else
        if AItem.ItemType=sitItem1 then
        begin
           //调到我的账户与安全页面
           //隐藏
           HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
           //显示个人信息页面
           ShowFrame(TFrame(GlobalUserInfoFrame),TFrameUserInfo);//,frmMain,nil,nil,nil,Application);
//           GlobalUserInfoFrame.FrameHistroy:=CurrentFrameHistroy;
           GlobalUserInfoFrame.Load(GlobalManager.User);

           GlobalUserInfoFrame.Sync;
        end;
  if AItem.Caption='关于我们' then
  begin
    //隐藏
    HideFrame(CurrentFrame,hfcttBeforeShowFrame);

    //关于我们
    ShowFrame(TFrame(GlobalAboutUsFrame),TFrameAboutUs);//,frmMain,nil,nil,nil,Application);
//    GlobalAboutUsFrame.FrameHistroy:=CurrentFrameHistroy;
    GlobalAboutUsFrame.Load('','','','');
  end;
  if AItem.Caption='设置密码' then
  begin
    //隐藏
    HideFrame;//(Self,hfcttBeforeShowFrame);

    //忘记密码
    ShowFrame(TFrame(GlobalForgetPasswordFrame),TFrameForgetPassword);//,frmMain,nil,nil,nil,Application);
  //  GlobalForgetPasswordFrame.FrameHistroy:=CurrentFrameHistroy;
    GlobalForgetPasswordFrame.Clear;
    GlobalForgetPasswordFrame.edtPhone.Text:=GlobalManager.User.phone;
    GlobalForgetPasswordFrame.pnlToolBar.Caption:='设置密码';
  end;

  if AItem.Caption='意见反馈' then
  begin
      //隐藏
      HideFrame(CurrentFrame,hfcttBeforeShowFrame);

     //显示收藏列表
     ShowFrame(TFrame(GlobalUserSuggectionFrame),TFrameUserSuggection);//,frmMain,nil,nil,nil,Application);
//     GlobalUserSuggectionFrame.FrameHistroy:=CurrentFrameHistroy;
     GlobalUserSuggectionFrame.Add;
//    //员工或管理员跳转到意见列表界面  酒店经理跳转到添加意见界面
//    if uManager.GlobalManager.User.is_hotel_manager=1 then
//    begin
//      //添加意见反馈
//      ShowFrame(TFrame(GlobalAddUserSuggestionFrame),TFrameAddUserSuggestion,frmMain,nil,nil,nil,Application);
//      GlobalAddUserSuggestionFrame.FrameHistroy:=CurrentFrameHistroy;
//      GlobalAddUserSuggestionFrame.Clear;
//    end
//    else
//    begin
//      //意见列表
//      ShowFrame(TFrame(GlobalUserSuggestionListFrame),TFrameUserSuggestionList,frmMain,nil,nil,nil,Application);
//      GlobalUserSuggestionListFrame.FrameHistroy:=CurrentFrameHistroy;
//      GlobalUserSuggestionListFrame.Load;
//    end;

  end;
  if  AItem.Caption = '设置' then
  begin
    //设置
    HideFrame;
    ShowFrame(TFrame(GlobalSettingFrame),TFrameSetting);

  end;
  if  AItem.Caption = '切换主题' then
  begin
    HideFrame;
    ShowFrame(TFrame(GlobalChangeThemeFrame),TFrameChangeTheme);
    GlobalChangeThemeFrame.Load;
  end;
  if  AItem.Caption = '角色权限' then
  begin
//    //设置
//    ARoleJson:=SO('{"RowNumber":1,"fid":5,"appid":1016,"name":"\u5382\u957F",'
//                      +'"descript":"\u9664\u9500\u552E\uFF0C\u8D22\u52A1\uFF0C\u91D1\u989D\u4E0D\u663E\u793A\uFF0C\u5176\u5B83\u90FD\u8981\u4E14\u53EF\u4EE5\u64CD\u4F5C",'
//                      +'"orderno":0,"createtime":"2022-09-27 09:00:00","is_deleted":0}');
//    ShowFrame(TFrame(GlobalSetRolePowerFrame),TFrameSetRolePower);
//    GlobalSetRolePowerFrame.Load(ARoleJson);

//    ABasePageFrame:=TFrameBasePage(uPageFramework.GlobalOpenPlatformFramework.ShowPage('RoleList'));
  end;


  if AItem.Caption='退出登录' then
  begin

    //退出登录
    frmMain.Logout;

    ShowLoginFrame();
    GlobalLoginFrame.btnReturn.Visible:=False;

  end;

// if  AItem.Caption = '商品管理' then
// begin
//     HideFrame;//(Self,hfcttBeforeShowFrame);
//     ShowFrame(TFrame(fmBaseProduct),TfmBaseProduct,Application.MainForm,nil,nil,nil,Application);
//     fmBaseProduct.FrameHistroy:=CurrentFrameHistroy;
//     fmBaseProduct.strCurrParentId := '000000';
//     fmBaseProduct.isChange := '';
//     fmBaseProduct.DoOpen;
// end
// else if  AItem.Caption = '往来单位' then
// begin
//     HideFrame;//(Self,hfcttBeforeShowFrame);
//     ShowFrame(TFrame(fmBaseClient),TfmBaseClient,Application.MainForm,nil,nil,nil,Application);
//     fmBaseClient.FrameHistroy:=CurrentFrameHistroy;
//     fmBaseClient.strCurrParentId := '000000';
//     fmBaseClient.isChange:= '';
//     fmBaseClient.DoOpen;
// end
// else if  AItem.Caption = '职员管理' then
// begin
//     HideFrame;//(self, hfcttBeforeShowFrame);
//    ShowFrame(TFrame(fmBaseEmp), TfmBaseEmp, Application.MainForm, nil, nil, nil,
//      Application);
////    fmBaseEmp.FrameHistroy := CurrentFrameHistroy;
////    fmBaseEmp.AOnModalResult := DoEmpSelectResult;
//    fmBaseEmp.strParantId := '000000';
//    fmBaseEmp.isReportQuery := False;
//    fmBaseEmp.DoOpen;
// end
// else if  AItem.Caption = '部门管理' then
// begin
//     HideFrame;//(self, hfcttBeforeShowFrame);
//    ShowFrame(TFrame(fmBaseDepart), TfmBaseDepart, Application.MainForm, nil, nil, nil,
//      Application);
////    fmBaseDepart.FrameHistroy := CurrentFrameHistroy;
////    fmBaseDepart.AOnModalResult := DoEmpSelectResult;
//    fmBaseDepart.strParantId := '000000';
//    fmBaseDepart.isReportQuery := False;
//    fmBaseDepart.DoOpen;
// end
// else if  AItem.Caption = '仓库管理' then
// begin
//     HideFrame;//(self, hfcttBeforeShowFrame);
//    ShowFrame(TFrame(fmBaseStock), TfmBaseStock, Application.MainForm, nil, nil, nil,
//      Application);
////    fmBaseStock.FrameHistroy := CurrentFrameHistroy;
////    fmBaseStock.AOnModalResult := DoEmpSelectResult;
//    fmBaseStock.strParantId := '000000';
//    fmBaseStock.isReportQuery := False;
//    fmBaseStock.DoOpen;
// end
// else if  AItem.Caption = '财务科目' then
// begin
//     HideFrame;//(self, hfcttBeforeShowFrame);
//    ShowFrame(TFrame(fmBaseFinanceSubject), TfmBaseFinanceSubject, Application.MainForm, nil, nil, nil,
//      Application);
////    fmBaseFinanceSubject.FrameHistroy := CurrentFrameHistroy;
////    fmBaseFinanceSubject.AOnModalResult := DoEmpSelectResult;
//    fmBaseFinanceSubject.strParantId := '000000';
//    fmBaseFinanceSubject.isReportQuery := False;
//    fmBaseFinanceSubject.DoOpen;
// end
// ;

//  if AItem.Caption='设置' then
//  begin
//    //隐藏
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//
//    //显示设置页面
//    ShowFrame(TFrame(GlobalSettingFrame),TFrameSetting,frmMain,nil,nil,OnReturnFromSettingFrame,Application);
//    GlobalSettingFrame.Load;
//  end
//  //未登录时调到登录页面
//  else if not GlobalManager.IsLogin then
//  begin
//
//        //隐藏
//        HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//        //显示登录页面
//        ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
////        GlobalLoginFrame.FrameHistroy:=CurrentFrameHistroy;
//        //清除输入框
//        GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
//
//  end
//  else
//  begin
//        if AItem.ItemType=sitItem1 then
//        begin
//           //调到我的账户与安全页面
//           //隐藏
//           HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//           //显示个人信息页面
//           ShowFrame(TFrame(GlobalUserInfoFrame),TFrameUserInfo,frmMain,nil,nil,OnFromChangeUserInfoFrame,Application);
////           GlobalUserInfoFrame.FrameHistroy:=CurrentFrameHistroy;
//           GlobalUserInfoFrame.Load(GlobalManager.User);
//
//           GlobalUserInfoFrame.Sync;
//        end;
//
//        if AItem.Caption='收货地址' then
//        begin
//          //跳转到收货地址列表
//           //隐藏
//           HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//           //显示收货地址列表
//           ShowFrame(TFrame(GlobalRecvAddrListFrame),TFrameRecvAddrList,frmMain,nil,nil,nil,Application);
////           GlobalRecvAddrListFrame.FrameHistroy:=CurrentFrameHistroy;
////           GlobalRecvAddrListFrame.Clear;
//           GlobalRecvAddrListFrame.Load(
//                                    '收货地址',
//                                    futManage,
//                                    -1
//                                    );
//        end;
//
//
//        if AItem.Name='my_bankcard' then
//        begin
//          //查看银行卡列表
//          HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//          ShowFrame(TFrame(GlobalMyBankCardListFrame),TFrameMyBankCardList);//,frmMain,nil,nil,OnReturnFrameBankCardList,Application);
//      //    GlobalMyBankCardListFrame.FrameHistroy:=CurrentFrameHistroy;
//          GlobalMyBankCardListFrame.Load('我的银行卡',futManage,0);
//        end;
//
//
//        //收藏
//        if AItem.Name='my_favourited' then
//        begin
//          HideFrame;
//          GlobalContentListFrame:=nil;
//          ShowFrame(TFrame(GlobalContentListFrame),TFrameContentList,frmMain, nil,nil,nil,Application);
//          GlobalContentListFrame.Clear;
//          GlobalContentListFrame.pnlToolBar.Caption:=AItem.Caption;
//          GlobalContentListFrame.FFilterWhoFavourited:=GlobalManager.User.fid;
//          GlobalContentListFrame.FFilterFavUserFID:='';
//          GlobalContentListFrame.Load;
//        end;
//        //浏览
//        if AItem.Name='my_read' then
//        begin
//          HideFrame;
//          GlobalContentListFrame:=nil;
//          ShowFrame(TFrame(GlobalContentListFrame),TFrameContentList,frmMain, nil,nil,nil,Application);
//          GlobalContentListFrame.Clear;
//          GlobalContentListFrame.btnClear.Visible:=True;
//          GlobalContentListFrame.pnlToolBar.Caption:=AItem.Caption;
//          GlobalContentListFrame.FFilterWhoReaded:=GlobalManager.User.fid;
//          GlobalContentListFrame.FFilterFavUserFID:='';
//          GlobalContentListFrame.Load;
//        end;
//
//
//        if AItem.Caption='我的订单' then
//        begin
//             //隐藏
//             HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//            ShowFrame(TFrame(GlobalUserOrderListFrame),TFrameUserOrderList,frmMain,nil,nil,nil,Application);
//            GlobalUserOrderListFrame.FTitle:='一公里';
////            GlobalUserOrderListFrame.FHelpText:=Const_RegisterLoginType_PhoneNum;
//            GlobalUserOrderListFrame.Init;
//            GlobalUserOrderListFrame.btnReturn.Visible:=True;
//        end;
//
//
//
//    //    if AItem.Caption='我的足迹' then
//    //    begin
//    //       //隐藏
//    //       HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    //       //显示收藏列表
//    //       ShowFrame(TFrame(GlobalLookedShopListFrame),TFrameLookedShopList,frmMain,nil,nil,nil,Application);
//    //       GlobalLookedShopListFrame.FrameHistroy:=CurrentFrameHistroy;
//    //       GlobalLookedShopListFrame.Init;
//    //    end;
//
//        if AItem.Name='add_content_center_group' then
//        begin
////           //隐藏
////           HideFrame;
////           //创建圈子
////           ShowFrame(TFrame(GlobalAddGroupFrame),TFrameAddGroup,frmMain,nil,nil,nil,Application);
////           GlobalAddGroupFrame.Load('ContentCenter','圈');
//        end;
//
//
//        if AItem.Caption='意见反馈' then
//        begin
//           //隐藏
//           HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//           //显示意见反馈
//           ShowFrame(TFrame(GlobalUserSuggectionFrame),TFrameUserSuggection,frmMain,nil,nil,nil,Application);
////           GlobalUserSuggectionFrame.FrameHistroy:=CurrentFrameHistroy;
//           GlobalUserSuggectionFrame.Add;
//        end;
//
//        if AItem.Caption='等级权限' then
//        begin
//          //隐藏
//          HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//          //显示意见反馈网页界面
//          ShowFrame(TFrame(GlobalWebBrowserFrame),TFrameWebBrowser);
//          GlobalWebBrowserFrame.LoadUrl(
//                                        Const_OpenWebRoot+'/level/level.html?'
//                                        +'appid='+IntToStr(AppID),
//                                        '等级权限'
//                                        );
//        end;
//
////         if AItem.Caption='隐私安全' then
////        begin
////           //隐藏
////           HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
////           //显示隐私安全
////           ShowFrame(TFrame(GlobalSecurityAndPrivacyFrame),TSecurityAndPrivacy);
////           //GlobalSecurityAndPrivacyFrame.Show;
////        end;
//
//        if AItem.Caption='邀请好友' then
//        begin
//           //隐藏
//           HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//           //显示邀请好友
//           ShowFrame(TFrame(GlobalMyInvitationCodeFrame),TFrameMyInvitationCode);
//           GlobalMyInvitationCodeFrame.Load;
//        end;
//
//        if AItem.Caption='游戏角色' then
//        begin
//           //隐藏
//           HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//           //显示邀请好友
//           ShowFrame(TFrame(GlobalMyGameInfoFrame),TMyGameInfoFrame);
//           GlobalMyGameInfoFrame.Load;
//        end;
//
//
////        if AItem.Caption='红包' then
////        begin
////           //显示红包界面
////           //隐藏
////           HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
////           //显示个人信息页面
////           ShowFrame(TFrame(GlobalUserCouponFrame),TFrameUserCoupon,frmMain,nil,nil,nil,Application);
////           GlobalUserCouponFrame.FrameHistroy:=CurrentFrameHistroy;
////           GlobalUserCouponFrame.Load;
////        end;
////
////        if AItem.Caption='钱包' then
////        begin
////          //显示钱包页面
////          //隐藏
////          HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
////          //显示个人信息页面
////          ShowFrame(TFrame(GlobalUserBalanceFrame),TFrameUserBalance,frmMain,nil,nil,OnReturnFromWalletFrame,Application);
////          GlobalUserBalanceFrame.FrameHistroy:=CurrentFrameHistroy;
////          GlobalUserBalanceFrame.Init(StrToFloat(AItem.Detail6));
////        end;
//
////        if AItem.Caption='积分充值' then
////        begin
////          //显示积分页面
////          //隐藏
////          HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
////          //显示积分明细页面
////          ShowFrame(TFrame(GlobalMyScoreFrame),TFrameMyScore,frmMain,nil,nil,OnReturnFromScoreFrame,Application);
////          GlobalMyScoreFrame.FrameHistroy:=CurrentFrameHistroy;
////          GlobalMyScoreFrame.Init(StrToFloat(AItem.Detail));
////        end;
//
//        if AItem.Caption='积分明细' then
//        begin
//          //显示积分明细页面
//          //隐藏
//    //      HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    //
//    //      ShowFrame(TFrame(GlobalUserScoreListFrame),TFrameUserScoreList,frmMain,nil,nil,nil,Application);
//    //      GlobalUserScoreListFrame.FrameHistroy:=CurrentFrameHistroy;
//    //      GlobalUserScoreListFrame.Clear;
//    //      GlobalUserScoreListFrame.Load('积分明细','');
//        end;
//
//        if AItem.Caption='充值提现' then
//        begin
//          //显示充值提现页面
//          //隐藏
//    //      HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    //
//    //      ShowFrame(TFrame(GlobalUserScoreListFrame),TFrameUserScoreList,frmMain,nil,nil,nil,Application);
//    //      GlobalUserScoreListFrame.FrameHistroy:=CurrentFrameHistroy;
//    //      GlobalUserScoreListFrame.Clear;
//    //      GlobalUserScoreListFrame.Load('积分明细','');
//        end;
//
////        if AItem.Caption='积分夺宝' then
////        begin
////          //显示积分夺宝页面
////          //隐藏
////          HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
////
////          ShowFrame(TFrame(GlobalIndianaFrame),TFrameIndiana,frmMain,nil,nil,OnReturnFromScoreFrame,Application);
////          GlobalIndianaFrame.FrameHistroy:=CurrentFrameHistroy;
////          GlobalIndianaFrame.Load(FUserScore);
////        end;
//
////        if AItem.Caption='邀请好友' then
////        begin
////           //隐藏
////          HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
////
////          //显示我的邀请码
////          ShowFrame(TFrame(GlobalMyInvitationCodeFrame),TFrameMyInvitationCode,frmMain,nil,nil,nil,Application);
////          GlobalMyInvitationCodeFrame.FrameHistroy:=CurrentFrameHistroy;
////          GlobalMyInvitationCodeFrame.Load;
////        end;
////
////        if AItem.Caption='我的贡献' then
////        begin
////          HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
////          //显示我的下级列表
////          ShowFrame(TFrame(GlobalShareScoreListFrame),TFrameShareScoreList,frmMain,nil,nil,nil,Application);
////          GlobalShareScoreListFrame.FrameHistroy:=CurrentFrameHistroy;
////          GlobalShareScoreListFrame.Load;
////        end;
//
//
////        if AItem.Caption='我的股份' then
////        begin
////          //隐藏
////          HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
////          //显示我的股份
////          ShowFrame(TFrame(GlobalMyStockRightFrame),TFrameMyStockRight,frmMain,nil,nil,OnReturnFromScoreFrame,Application);
////          GlobalMyStockRightFrame.Load;
////        end;
//
//
////        if AItem.Caption='亿诚通讯' then
////        begin
////          //隐藏
////          HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
////          //显示我的股份
////          ShowFrame(TFrame(GlobalTelMainFrame),TFrameTelMain,frmMain,nil,nil,nil,Application);
////          GlobalTelMainFrame.Load;
////        end;
//
//
//  end;
//
//
////  if AItem.Caption='密码修改' then
////  begin
////    //隐藏
////    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
////
////    //修改密码
////    ShowFrame(TFrame(GlobalChangePasswordFrame),TFrameChangePassword,frmMain,nil,nil,nil,Application);
////    GlobalChangePasswordFrame.FrameHistroy:=CurrentFrameHistroy;
////    GlobalChangePasswordFrame.Clear;
////
////  end;


end;

procedure TFrameMy.lvMyPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
  AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem;
  AItemDrawRect: TRect);
begin
//  if (AItem.ItemType=sitItem4) and (AItem.Caption='钱包') then
//  begin
//    Self.lblNameDetail.SelfOwnMaterialToDefault.DrawCaptionParam.FontColor:=
//                                                TAlphaColorRec.Dodgerblue;//$FF33A7FA;
//  end;
//
//  if (AItem.ItemType=sitItem4) and (AItem.Caption='红包') then
//  begin
//    Self.lblNameDetail.SelfOwnMaterialToDefault.DrawCaptionParam.FontColor:=
//                                                TAlphaColorRec.Orangered;
//  end;
//
//  if (AItem.ItemType=sitItem4) and (AItem.Caption='金币') then
//  begin
//    Self.lblNameDetail.SelfOwnMaterialToDefault.DrawCaptionParam.FontColor:=
//                                                TAlphaColorRec.Gold;
//  end;
end;

procedure TFrameMy.lvMyResize(Sender: TObject);
begin

//  img1.Width:=(frmMain.Width-30) /3;
//  img2.Width:=(frmMain.Width-30) /3;
//  img3.Width:=(frmMain.Width-30) /3;
//
//  lvMy.Prop.Items.FindItemByName('pic').Height:=img1.Width+40;
end;

procedure TFrameMy.nniNumberClick(Sender: TObject);
begin
//  HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//
//  //消息通知列表
//  ShowFrame(TFrame(GlobalNoticeClassifyListFrame),TFrameNoticeClassifyList,frmMain,nil,nil,OnReturnFrameFromNoticeClassifyListFrame,Application);
////  GlobalNoticeClassifyListFrame.FrameHistroy:=CurrentFrameHistroy;
//  GlobalNoticeClassifyListFrame.Load;
end;

//procedure TFrameMy.OnFromChangeUserInfoFrame(AFranme: TFrame);
//begin
//  Load;
//end;
//
//procedure TFrameMy.OnReturnFrameFromNoticeClassifyListFrame(Frame: TFrame);
//begin
//  Self.nniNumber.Prop.Number:=GlobalManager.User.notice_unread_count;
//end;
//
//procedure TFrameMy.OnReturnFromScoreFrame(AFrame: TFrame);
//begin
////  //重新获取用户积分  余额
////  GetUserInfo;
////  GetWallet;
//end;
//
//procedure TFrameMy.OnReturnFromSettingFrame(Frame: TFrame);
//begin
//  //返回时刷新我的页面
//  Self.Load;
//end;
//
//procedure TFrameMy.OnReturnFromWalletFrame(AFrame: TFrame);
//begin
////  GetWallet;
//end;

procedure TFrameMy.pnl4ButtonsResize(Sender: TObject);
begin
//  btnButton1.Width:=trunc(pnl4Buttons.Width)/4;
//  btnButton3.Width:=trunc(pnl4Buttons.Width)/4;
//  btnButton4.Width:=trunc(pnl4Buttons.Width)/4;
//  btnButton2.Width:=trunc(pnl4Buttons.Width)/4;


end;

procedure TFrameMy.pnlBtnResize(Sender: TObject);
begin
//  btnFans.Width:=trunc(pnlBtn.Width)/3;
//  btnFocused.Width:=trunc(pnlBtn.Width)/3;
//  btnVisitors.Width:=trunc(pnlBtn.Width)/3;

end;

procedure TFrameMy.pnlContentCountResize(Sender: TObject);
begin

//  btnNews.Width:=trunc(pnlContentCount.Width)/3;
//  btnCommunity.Width:=trunc(pnlContentCount.Width)/3;
//  btnPostes.Width:=trunc(pnlContentCount.Width)/3;

end;

procedure TFrameMy.SkinFMXButton1Click(Sender: TObject);
begin
//  //未登录时调到登录页面
//  if not GlobalManager.IsLogin then
//  begin
//    //隐藏
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    //显示登录页面
//    ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
//    //清除输入框
//    GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
//  end
//  else
//  begin
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    ShowFrame(TFrame(GlobalPictureWallFrame),TFramePictureWall,frmMain,nil,nil,nil,Application);
//    GlobalPictureWallFrame.Load;
//  end;
end;

procedure TFrameMy.SkinFMXButton4Click(Sender: TObject);
begin
  HideFrame;
  ShowFrame(TFrame(GlobalNoticeListFrame),TFrameNoticeList);
end;

procedure TFrameMy.btnAllClick(Sender: TObject);
begin
//  //未登录时调到登录页面
//  if not GlobalManager.IsLogin then
//  begin
//    //隐藏
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    //显示登录页面
//    ShowFrame(TFrame(GlobalLoginFrame),TFrameLogin,frmMain,nil,nil,nil,Application);
//    //清除输入框
//    GlobalLoginFrame.Clear;//(Const_RegisterLoginType_PhoneNum);
//  end
//  else
//  begin


//    if not GlobalManager.IsLogin then
//    begin
//      ShowLoginFrame(True);
//      Exit;
//    end;
//
//
//
//    HideFrame;//(GlobalMainFrame,hfcttBeforeShowFrame);
//    ShowFrame(TFrame(GlobalMyPublishedFrame),TFrameMyPublished,frmMain,nil,nil,nil,Application);
//    GlobalMyPublishedFrame.Load('news');



//  end;
end;

end.

