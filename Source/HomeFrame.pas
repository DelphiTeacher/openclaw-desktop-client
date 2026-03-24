unit HomeFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uDrawCanvas, uSkinItems, uSkinButtonType, uSkinFireMonkeyButton,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit, FMX.Ani,

  uManager,
  uDrawPicture,
  uOpenClientCommon,
  CommonImageDataMoudle,

//  ClientTrack,
//  HomeMoreFrame,
  DateUtils,
  XSuperObject,
  uUIFunction,
  BaseReportFrame,
  BillListFrame,
  ViewBillFrame,
  EditBillFrame,
  EditMailFrame,
  LocationFrame,
  HTMLReportFrame,
  WorkImportantListFrame,
//  WaitAuditSummaryFrame,
//  SetCommonFunctionFrame,
  EasyServiceCommonMaterialDataMoudle,
//  ListItemStyleFrame_Bill,
  ListItemStyleFrame_IconCaption,
  ListItemStyleFrame_PopupMenuItem,
  ListItemStyleFrame_IconCaptionButton_DetailBottom,
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack,
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack_Notify,
  ListItemStyleFrame_IconTopCenterBackColor_CaptionBottomCenterBlack,
  ListItemStyleFrame_IconLeft_CaptionRightBottom_DetailRightTop,
  ListItemStyleFrame_IconLeftRoundBack_CaptionRightBottom_DetailRightTop,


  {$IFDEF ANDROID}
    Androidapi.Helpers, Androidapi.JNI.Webkit, Androidapi.JNI.Os,
    Androidapi.JNI.JavaTypes, Androidapi.JNI.GraphicsContentViewText,
  {$ENDIF}
  System.Permissions, // 动态权限单元
  CC.BaiduOCR,
  CC.BarcodeScanner,

  uSkinMultiColorLabelType, uSkinFireMonkeyMultiColorLabel, uSkinPanelType,
  uSkinFireMonkeyPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinFireMonkeyImage, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinFireMonkeyListView,
  uSkinFireMonkeyControl, uSkinImageType, uSkinRoundImageType,
  uSkinFireMonkeyRoundImage, uSkinMaterial, uSkinNotifyNumberIconType,
  uSkinFireMonkeyNotifyNumberIcon, uSkinScrollBoxContentType,
  uSkinFireMonkeyScrollBoxContent, uSkinScrollBoxType, uSkinFireMonkeyScrollBox,
  uSkinVirtualChartType, FMX.ListBox, uSkinFireMonkeyComboBox, uSkinListBoxType,
  uSkinFireMonkeyListBox, uSkinFireMonkeyPopup;

type
  TFrameHome = class(TFrame)
    btnRefrsh: TSkinFMXRoundImage;
    lvMain: TSkinFMXListView;
    dspMainTop: TSkinFMXItemDesignerPanel;
    pnlTop: TSkinFMXPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    lblAllTotal: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    SkinFMXLabel3: TSkinFMXLabel;
    SkinFMXLabel4: TSkinFMXLabel;
    todaySale: TSkinFMXLabel;
    todaysk: TSkinFMXLabel;
    AllYs: TSkinFMXLabel;
    dspMsg: TSkinFMXItemDesignerPanel;
    pnlMsg: TSkinFMXPanel;
    icoMsg: TSkinFMXImage;
    pnlMsg2: TSkinFMXPanel;
    pnlMsgHave: TSkinFMXPanel;
    icoMsgNext: TSkinFMXImage;
    pnlActionBar: TSkinFMXPanel;
    edtFind: TSkinFMXEdit;
    btnScan: TSkinFMXButton;
    bntMore: TSkinFMXButton;
    btnSetting: TSkinFMXButton;
    SkinFMXButton2: TSkinFMXButton;
    SkinFMXButton3: TSkinFMXButton;
    sbClient: TSkinFMXScrollBox;
    sbcContent: TSkinFMXScrollBoxContent;
    lblMsg: TSkinFMXLabel;
    SkinFMXVirtualChart1: TSkinFMXVirtualChart;
    pnlToolBar: TSkinFMXPanel;
    btnMore: TSkinFMXButton;
    popuAdd: TSkinFMXPopup;
    lbAddList: TSkinFMXListBox;
    imgUserHead: TSkinFMXImage;
    procedure bntMoreClick(Sender: TObject);
    procedure lvMainClickItem(AItem: TSkinItem);
    procedure SkinFMXButton4Click(Sender: TObject);
    procedure btnMoreClick(Sender: TObject);
    procedure lbAddListClickItem(AItem: TSkinItem);
  private
    //百度OCR
//    CCBaiduOCR1:TCCBaiduOCR;
//    procedure DoRequestPermissions(AResult: TProc<boolean>);
    procedure CCBaiduOCR1RecognizeResult(Sender: TObject; AOCRType: TCCBaiduOCRType; AErrorCode: Integer; AErrorMsg, AFilePath, AJosonResult: string; AIDCardInfo: TCCIDCardInfo; ABankCardInfo: TCCBankCardInfo);
//    procedure CCBaiduOCR1InitAccessTokenWithAkSkResult(Sender: TObject; AErrorCode: Integer; AErrorMsg, AToken: string);
    { Private declarations }
  private
    //二维码扫描
//    CCBarcodeScanner1:TCCBarcodeScanner;
//    procedure CCBarcodeScanner1ScanComletedCallbackEvent(Sender: TObject;
//      const ResultCode: Integer; const ResultString: string);
    procedure DoScanCodeResultEvent(Sender:TObject;AScanCode:String);
  public
    procedure Load;
    constructor Create(AOwner:TComponent);override;
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
  MainForm;

procedure TFrameHome.bntMoreClick(Sender: TObject);
begin
//  //更多
//  HideFrame;
//  ShowFrame(TFrame(GlobalHomeMoreFrame),TFrameHomeMore);
end;

type
TProtectedControl=class(TControl);

procedure TFrameHome.btnMoreClick(Sender: TObject);
//var
//  AButton:TControl;
begin

  frmMain.ScanQRCode(DoScanCodeResultEvent);

//  AButton:=TControl(Sender);
//
//  if Not Self.popuAdd.IsOpen then
//  begin
//    //设置弹出框绝对位置
//    Self.popuAdd.PlacementRectangle.Left:=
//          TProtectedControl(AButton.Parent).LocalToScreen(PointF(Self.btnMore.Position.X+Self.btnMore.Width,0)).X
//          -Self.popuAdd.Width
//          -5
////          -4
//          ;
//    Self.popuAdd.PlacementRectangle.Top:=
//          TProtectedControl(AButton.Parent).LocalToScreen(PointF(0,Self.pnlToolBar.Height)).Y
//          -10;
//    Self.popuAdd.IsOpen:=True;
//  end
//  else
//  begin
//    Self.popuAdd.IsOpen:=False;
//  end;



end;

constructor TFrameHome.Create(AOwner: TComponent);
begin
  inherited;

//  {$IFDEF ANDROID}
//  CCBaiduOCR1:=TCCBaiduOCR.Create(Self);
//  CCBaiduOCR1.OnInitAccessTokenWithAkSkResult:=CCBaiduOCR1InitAccessTokenWithAkSkResult;
//  CCBaiduOCR1.OnRecognizeResult:=CCBaiduOCR1RecognizeResult;
//  // 授权文件（安全模式）获取AccessToken
////  CCBaiduOCR1.initAccessTokenWithAkSk();
//  CCBaiduOCR1.initAccessTokenLicenseFile;
////  {
////    通过API Key / Secret Key获取AccessToken
////    此种身份验证方案使用AK/SK获得AccessToken。
////
////    虽然SDK对网络传输的敏感数据进行了二次加密，但由于AK/SK是明文填写在代码中，在移动设备中可能会存在AK/SK被盗取的风险。有安全考虑的开发者可使用第二种授权方案。
////  }
////  {
////    self.CCBaiduOCR1.initAccessTokenWithAkSk('3gCv6XGcIfOID70nerG5vECD',
////    'ot1Mwsfzy9oU9R5rkm1FoAmVAESPEVYO');
////  }
//
//
//  CCBarcodeScanner1:=TCCBarcodeScanner.Create(Self);
//  CCBarcodeScanner1.OnScanComletedCallbackEvent:=CCBarcodeScanner1ScanComletedCallbackEvent;
//
//  {$ENDIF}

end;

procedure TFrameHome.DoScanCodeResultEvent(Sender: TObject; AScanCode: String);
begin
  TThread.Synchronize(nil,procedure
  begin
    ShowMessage('扫码成功：'+AScanCode);
  end);
end;

//procedure TFrameHome.CCBaiduOCR1InitAccessTokenWithAkSkResult(Sender: TObject; AErrorCode: Integer; AErrorMsg, AToken: string);
//begin
//  {$IFDEF ANDROID}
//  if AErrorCode = 0 then
//  begin
////    ShowMessage('获取token成功!' + #13#10 + AToken);
//  end
//  else
//  begin
//    ShowMessage('获取token失败!' + #13#10 + AErrorMsg);
//  end;
//  {$ENDIF}
//
//end;

procedure TFrameHome.CCBaiduOCR1RecognizeResult(Sender: TObject; AOCRType: TCCBaiduOCRType; AErrorCode: Integer; AErrorMsg, AFilePath, AJosonResult: string; AIDCardInfo: TCCIDCardInfo; ABankCardInfo: TCCBankCardInfo);
begin

  TThread.Synchronize(nil,procedure
  begin
    ShowMessage('识别成功：'+AJosonResult);
  end);

//  uResultForm.ShowForm(AOCRType, AErrorCode, AErrorMsg, AFilePath, AJosonResult, AIDCardInfo, ABankCardInfo,
//    procedure(AResult: TModalResult)
//    begin
//
//    end);

end;

//procedure TFrameHome.DoRequestPermissions(AResult: TProc<boolean>);
//begin
//{$IFDEF ANDROID}
//  PermissionsService.RequestPermissions([JStringToString(TJManifest_permission.JavaClass.CAMERA), JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE), JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE)],
//    procedure(const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray)
//    begin
//      if (Length(AGrantResults) = 3) then // 为什么为3？因为只申请了3个权限，返回肯定判断3个
//      begin
//        // 三个全选都允许了,才能拍照
//        if (AGrantResults[0] = TPermissionStatus.Granted) and (AGrantResults[1] = TPermissionStatus.Granted) and (AGrantResults[2] = TPermissionStatus.Granted) then
//        begin
//          if assigned(AResult) then
//          begin
//            AResult(true);
//          end;
//        end
//        else
//        begin
//          AResult(false);
//        end;
//
//      end;
//    end);
//{$ENDIF}
//end;


//procedure TFrameHome.CCBarcodeScanner1ScanComletedCallbackEvent(Sender: TObject;
//  const ResultCode: Integer; const ResultString: string);
//begin
//  ShowMessage(ResultString);
//end;

procedure TFrameHome.lbAddListClickItem(AItem: TSkinItem);
begin
  Self.popuAdd.IsOpen:=False;

end;

procedure TFrameHome.Load;
begin
  //

  //头像
  Self.imgUserHead.Properties.Picture.ImageIndex:=-1;
  //默认头像
  Self.imgUserHead.Properties.Picture.SkinImageList:=dmCommonImageDataMoudle.imgHeadList;
  Self.imgUserHead.Properties.Picture.DefaultImageIndex:=0;
  Self.imgUserHead.Properties.Picture.PictureDrawType:=pdtUrl;

  Self.imgUserHead.Properties.Picture.Url:=GetImageUrl(GlobalManager.User.head_pic_path,itNone);
  Self.imgUserHead.Properties.Picture.IsClipRound:=True;
end;

procedure TFrameHome.lvMainClickItem(AItem: TSkinItem);
//var
//  ACustomerDataJson:ISuperObject;
//  ACustomerDataJsonArray:ISuperArray;
//var
//  AReportName:String;
//  AFilterStartDate:String;
//  AFilterEndDate:String;
begin

//  ACustomerDataJsonArray:=SA();
//
//  ACustomerDataJson:=SO();
//  ACustomerDataJson.S['客户编号']:='kh001';
//  ACustomerDataJson.S['客户名称']:='宁波金贸通软件';
//  ACustomerDataJson.S['主要联系人']:='23068859@qq.com';
//  ACustomerDataJson.S['最近联系时间']:='9小时前';
//  ACustomerDataJson.S['国家']:='CN';
////  ACustomerDataJson.S['客户名称']:='宁波金贸通软件';
////  ACustomerDataJson.S['业务日期']:='2021/10/15';
////  ACustomerDataJson.S['销售机会']:='暂无';
////  ACustomerDataJson.S['合同订单编号']:='2021-10-15-0001';
////  ACustomerDataJson.S['合同订单标题']:='我们';
////  ACustomerDataJson.S['省']:='浙江省';
////  ACustomerDataJson.S['市']:='宁波市';
////  ACustomerDataJson.S['区']:='鄞州区';
////  ACustomerDataJson.S['地址']:='鄞州区';
//  ACustomerDataJsonArray.O[ACustomerDataJsonArray.Length]:=ACustomerDataJson;
//
//
//  ACustomerDataJson:=SO();
//  ACustomerDataJson.S['客户编号']:='kh002';
//  ACustomerDataJson.S['客户名称']:='inter-vion';
//  ACustomerDataJson.S['主要联系人']:='k.archicinska@inter-vion.com';
//  ACustomerDataJson.S['最近联系时间']:='19小时前';
//  ACustomerDataJson.S['国家']:='JP';
////  ACustomerDataJson.S['业务日期']:='2021/10/15';
////  ACustomerDataJson.S['销售机会']:='暂无';
////  ACustomerDataJson.S['合同订单编号']:='2021-10-15-0001';
////  ACustomerDataJson.S['合同订单标题']:='我们';
////  ACustomerDataJson.S['省']:='浙江省';
////  ACustomerDataJson.S['市']:='宁波市';
////  ACustomerDataJson.S['区']:='鄞州区';
////  ACustomerDataJson.S['地址']:='鄞州区';
//  ACustomerDataJsonArray.O[ACustomerDataJsonArray.Length]:=ACustomerDataJson;
//
//
//  ACustomerDataJson:=SO();
//  ACustomerDataJson.S['客户编号']:='kh003';
//  ACustomerDataJson.S['客户名称']:='Noor handels GmbH';
//  ACustomerDataJson.S['主要联系人']:='Max Enders - NOOR Handels GmbH';
//  ACustomerDataJson.S['最近联系时间']:='18小时前';
//  ACustomerDataJson.S['国家']:='GB';
////  ACustomerDataJson.S['业务日期']:='2021/10/15';
////  ACustomerDataJson.S['销售机会']:='暂无';
////  ACustomerDataJson.S['合同订单编号']:='2021-10-15-0001';
////  ACustomerDataJson.S['合同订单标题']:='我们';
////  ACustomerDataJson.S['省']:='浙江省';
////  ACustomerDataJson.S['市']:='宁波市';
////  ACustomerDataJson.S['区']:='鄞州区';
////  ACustomerDataJson.S['地址']:='鄞州区';
//  ACustomerDataJsonArray.O[ACustomerDataJsonArray.Length]:=ACustomerDataJson;






  if AItem.Caption='列表页面' then
  begin
    HideFrame;
    ShowFrame(TFrame(GlobalBillListFrame),TFrameBillList);
    //设置列表项样式
    GlobalBillListFrame.lvData.Properties.DefaultItemStyle:='Bill';
    //设置字段显示绑定
//    GlobalBillListFrame.lvData.Properties.DefaultItemStyleConfig.Text:=
//      'lblCaption.BindItemFieldName:=''客户名称'';'+#13#10
//      +'lblDetail.BindItemFieldName:=''主要联系人'';'+#13#10
//      +'lblDetail1.BindItemFieldName:=''最近联系时间'';'+#13#10
//      ;
    //设置字段显示绑定
    GlobalBillListFrame.lvData.Properties.DefaultItemStyleConfig.Text:=
      'lblCaption.BindItemFieldName:=''客户名称'';'+#13#10
      +'lblDetail.BindItemFieldName:=''公司电话'';'+#13#10
      +'lblDetail1.BindItemFieldName:=''详细地址'';'+#13#10
      ;
    //列表项自定义字段列表
    GlobalBillListFrame.FItemStyleFieldList.Add('客户编号');
    GlobalBillListFrame.FItemStyleFieldList.Add('客户类型');
    GlobalBillListFrame.FItemStyleFieldList.Add('业务员');
    //静态加载数据
    GlobalBillListFrame.Load('客户');//DataList(ACustomerDataJsonArray);

    GlobalBillListFrame.FSelectMode:=False;
  end;

  if AItem.Caption='详情页面' then
  begin
    HideFrame;
    ShowFrame(TFrame(GlobalViewBillFrame),TFrameViewBill);
  //  GlobalBaseReportFrame.Load('');
//    GlobalViewBillFrame.Load(ACustomerDataJson);
  end;

  if AItem.Caption='编辑页面' then
  begin


    HideFrame;
    ShowFrame(TFrame(GlobalEditBillFrame),TFrameEditBill);
//    GlobalEditBillFrame.Load(ACustomerDataJson);
  end;


  if AItem.Caption='写邮件' then
  begin
    HideFrame;
    ShowFrame(TFrame(GlobalEditMailFrame),TFrameEditMail);
    GlobalEditMailFrame.Load(nil);
  end;

  if AItem.Caption='名片识别' then
  begin
//    HideFrame;
//    ShowFrame(TFrame(GlobalEditMailFrame),TFrameEditMail);
//    GlobalEditMailFrame.Load(nil);
//    Self.DoRequestPermissions(
//      procedure(AResult: boolean)
//      begin
//        if AResult then
//        begin
//          CCBaiduOCR1.TagString := 'ocr_general_basic';
//          CCBaiduOCR1.ocr_general_basic;
//        end
//        else
//        begin
//          ShowMessage('权限未允许！');
//        end;
//      end);
//    frmMain.StartBaiduOCR(CCBaiduOCR1RecognizeResult);
  end;


  if AItem.Caption='二维码扫描' then
  begin
//      CCBarcodeScanner1.SdkConfig.Scan_Title := '二维码扫描';
//      CCBarcodeScanner1.SdkConfig.Scan_Tips := '将二维码放入框内，即可自动扫描';
//      CCBarcodeScanner1.SdkConfig.Vibrate := True;
//      CCBarcodeScanner1.SdkConfig.PlayVoice := True;
//      CCBarcodeScanner1.SdkConfig.ToastResult := True;
//      CCBarcodeScanner1.SdkConfig.ShowScanFromPhotoButton := True;
//      CCBarcodeScanner1.SdkConfig.Flashlight := True;
//
//    {$IFDEF ANDROID}
//      self.DoRequestPermissions(
//        procedure(AResult: Boolean)
//        begin
//          if AResult then
//          begin
//            self.CCBarcodeScanner1.StartScan(); // 结果在事件中返回
//          end
//          else
//          begin
//            ShowMessage('权限未允许！');
//          end;
//        end);
//    {$ENDIF}
//    {$IFDEF IOS}
//      self.CCBarcodeScanner1.StartScan();
//    {$ENDIF}
    frmMain.ScanQRCode(DoScanCodeResultEvent);

  end;




  if AItem.Caption='签到' then
  begin
    //签到
    HideFrame;
    ShowFrame(TFrame(GlobalLocationFrame),TFrameLocation);
    GlobalLocationFrame.Load;

  end;


  if AItem.Caption='今日日程' then
  begin
    //今日日程
    HideFrame;
    ShowFrame(TFrame(GlobalWorkImportantListFrame),TFrameWorkImportantList);
    GlobalWorkImportantListFrame.Load(FormatDateTime('YYYY-MM-DD',Now),FormatDateTime('YYYY-MM-DD',Now));

  end;


  if AItem.Caption='报表' then
  begin

//    AFilterStartDate:='';
//    AFilterEndDate:='';
//    AFilterStartDate:=FormatDateTime('YYYY-MM-DD',StartOfTheMonth(Now));
//    AFilterEndDate:=FormatDateTime('YYYY-MM-DD',EndOfTheMonth(Now));

    HideFrame;
    ShowFrame(TFrame(GlobalHTMLReportFrame),TFrameHTMLReport);
    GlobalHTMLReportFrame.Load('下单报表',
                              '客户',
                              '',//AFilterStartDate,//'2020-01-01',
                              '',//AFilterEndDate,//'2020-12-31',
                              nil);

  end;




//  if AItem.Caption='待审单据' then
//  begin
//    HideFrame;
//    ShowFrame(TFrame(GlobalWaitAuditSummaryFrame),TFrameWaitAuditSummary);
//  end;
//  if AItem.Caption='客户跟进' then
//  begin
//    HideFrame;
//    ShowFrame(TFrame(fmClientTrack),TfmClientTrack);
//    fmClientTrack.AfterLoadData;
//  end;
end;

procedure TFrameHome.SkinFMXButton4Click(Sender: TObject);
begin
//  HideFrame;
//  ShowFrame(TFrame(GlobalSetCommonFunctionFrame),TFrameSetCommonFunction);
end;

end.
