unit ReportMenuFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uUIFunction,
  uOpenClientCommon,

//  ManageHistory,
//
//  ProductBuyReport,
//  ProductBuyOrderReport,
//  HTMLReportFrame,
//  BuyOrderMx,
//  BuyMx,
//  StoreHouseStatus,
//  StoreHouseBatchExpDate,
//  StoreHouseAnalyseFrame,
//  StoreHouseTakingBillFrame,
//  StoreHouseTransferBillFrame,
//  StoreHouseDismountBillFrame,
//  BuyOrderBillFrame,
//  BuyBillFrame,
//  BuyPayBillFrame,
////  BuyPayBillFrame,
//
//
//  BossReport,
//  ClientsArAp,
//  CashBackReprot,
//  AccountMx,
//  StateOfOperation,
//  BalanceSheet,
//  ClientTradeAnalyse,
//  SaleCommission,
//  FeeBillFrame,
//  WithdrawTransferFrame,
//  ProfitAnalyse,
//  EmpSaleReport,
//
//
//
//  ProductSellHistory,
//

//  uBasePageFrame,
//  BasePageFrame,
//  uPageStructure,
//  uPageFramework,
  HTMLReportFrame,
  EasyServiceCommonMaterialDataMoudle,
  uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel,
  ListItemStyleFrame_GroupHeader,
  ListItemStyleFrame_GroupFooter,
  ListItemStyleFrame_IconTopCenter_CaptionBottomCenterBlack,

  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uDrawCanvas, uSkinItems, uSkinFireMonkeyControl, uSkinScrollControlType,
  uSkinCustomListType, uSkinVirtualListType, uSkinListViewType,
  uSkinFireMonkeyListView, uSkinListBoxType, uSkinFireMonkeyListBox,
  uSkinButtonType, uSkinFireMonkeyButton, uSkinPanelType, uSkinFireMonkeyPanel;

type
  TFrameReportMenu = class(TFrame)
    reportList: TSkinFMXListView;
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    lbOrderState: TSkinFMXListBox;
    procedure reportListClickItem(AItem: TSkinItem);
    procedure reportListPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
      AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem;
      AItemDrawRect: TRect);  private
    { Private declarations }
  public
    //跳转到报表明细页面
    procedure DoJumpToReportDetailPage(Sender:TObject;
                                      AReportName:String;
                                      AGroupByType:String;
                                      AGroupByValue:String;
                                      AStartDate:String;
                                      AEndDate:String;
                                      ADefaultWhereSQL:String);
    procedure Load;
    { Public declarations }
  end;

implementation

{$R *.fmx}

//uses
//  Main;

procedure TFrameReportMenu.DoJumpToReportDetailPage(Sender: TObject;
  AReportName, AGroupByType, AGroupByValue, AStartDate, AEndDate: String;
                                    ADefaultWhereSQL:String);
begin
  //
end;

procedure TFrameReportMenu.Load;
begin

end;

procedure TFrameReportMenu.reportListClickItem(AItem: TSkinItem);
var
  AFrame:TFrame;
begin
  if AItem.ItemType=sitDefault then
  begin
    HideFrame;
    ShowFrame(TFrame(GlobalHTMLReportFrame),TFrameHTMLReport);
    GlobalHTMLReportFrame.Load(AItem.Caption,
                              '客户',
                              '',//AFilterStartDate,//'2020-01-01',
                              '',//AFilterEndDate,//'2020-12-31',
                              nil);
  end;

//  if AItem.ItemType=sitDefault then
//  begin
//
//
//
//    //查看报表
//    if (AItem.Caption='经营历程') or (AItem.Caption='经营概况') then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmManageHistory),TfmManageHistory,fmMain,nil,nil,nil,Application);
//       fmManageHistory.FrameHistroy:=CurrentFrameHistroy;
////       fmManageHistory.DoOpen;
//    end;
//
//
//
//    //查看报表
//    if AItem.Caption='进货统计' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmProductBuyReport),TfmProductBuyReport,fmMain,nil,nil,nil,Application);
//             fmProductBuyReport.FrameHistroy:=CurrentFrameHistroy;
//       fmProductBuyReport.DoOpen;
//    end;
//    if AItem.Caption='进货明细' then
//    begin
////      HideFrame;//(Self,hfcttBeforeShowFrame);
////     ShowFrame(TFrame(fmProductBuyReport),TfmProductBuyReport,fmMain,nil,nil,nil,Application);
////           fmProductBuyReport.FrameHistroy:=CurrentFrameHistroy;
//      //明细不需要分组
////      AppID:=1012;
////      DoorManageInterfaceUrl:='http://www.orangeui.cn:10050/door_manage/';
////      AFrame:=TFrameBasePage(GlobalOpenPlatformFramework.ShowPage('list_report_detail',nil,nil));
//
//        HideFrame;//(self, hfcttBeforeShowFrame);
//        ShowFrame(TFrame(fmBuyMx), TfmBuyMx);//, fmMain, nil, nil, nil,Application);
//        fmBuyMx.FrameHistroy := CurrentFrameHistroy;
//        fmBuyMx.pnlActionBar.Caption:='进货明细表';
////        fmBuyMx.s_class_id := SClassID;
////        cdsData.RecNo :=  lstBaseInfo.Prop.InteractiveItem.Tag;
////        fmBuyMx.lblArYe.Text := totaltostr(cdsData.FieldByName('qty').AsFloat);
////        fmBuyMx.lblApye.Text := totaltostr(cdsData.FieldByName('taxtotal').AsFloat);
////        fmBuyMx.BeginDate := self.BeginDate;
////        fmBuyMx.EndDate := self.EndDate;
////        fmBuyMx.p_class_id :=cdsData.FieldByName('p_class_id').AsString;
////        fmBuyMx.DoOpen;
//         fmBuyMx.AfterLoadData;
//
////         fmBuyMx.pnlSummary.Align:=TAlignLayout.Bottom;
////         fmBuyMx.lvSummary.Material.BackColor.IsRound:=False;
////         fmBuyMx.lvSummary.Margins.Left:=0;
////         fmBuyMx.lvSummary.Margins.Right:=0;
////         fmBuyMx.pnlDevide1.Visible:=False;
////         fmBuyMx.pnlDateArea.Visible:=True;
////         fmBuyMx.SkinFMXPanel2.Visible:=False;
////         //隐藏汇总
////         fmBuyMx.lvGroupByTypes.Visible:=False;
////         //批定列表项的设计面板
////         fmBuyMx.lstBaseInfo.Prop.DefaultItemStyle:='Report_Buy_BillProductDetail';
////         //统计值不一样，通过接口返回即可
//
//
//
//    end;
//    if AItem.Caption='进货走势' then
//    begin
//        AppID:=1012;
//        DoorManageInterfaceUrl:='http://www.orangeui.cn:10050/door_manage/';
//        HideFrame;
//        ShowFrame(TFrame(GlobalHTMLReportFrame),TFrameHTMLReport);
//        GlobalHTMLReportFrame.Load('下单报表','客户','2020-01-01','2020-12-31',DoJumpToReportDetailPage);
//        GlobalHTMLReportFrame.pnlToolBar.Caption:='进货走势';
//    end;
//    if AItem.Caption='进货订单统计' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmProductBuyOrderReport),TfmProductBuyOrderReport,fmMain,nil,nil,nil,Application);
//             fmProductBuyOrderReport.FrameHistroy:=CurrentFrameHistroy;
//       fmProductBuyOrderReport.DoOpen;
//    end;
//    if AItem.Caption='进货订单列表' then
//    begin
//        //wn
//        //跳转到报表明细
//        HideFrame;//(self, hfcttBeforeShowFrame);
//        ShowFrame(TFrame(GlobalBuyOrderBillFrame), TfmBuyOrderBill);//, fmMain, nil, nil, nil,Application);
//        GlobalBuyOrderBillFrame.FrameHistroy := CurrentFrameHistroy;
////        fmBuyOrderMx.s_class_id := SClassID;
////        cdsData.RecNo :=  lstBaseInfo.Prop.InteractiveItem.Tag;
////        fmBuyOrderMx.lblArYe.Text := totaltostr(cdsData.FieldByName('qty').AsFloat);
////        fmBuyOrderMx.lblApye.Text := totaltostr(cdsData.FieldByName('taxtotal').AsFloat);
////        fmBuyOrderMx.BeginDate := self.BeginDate;
////        fmBuyOrderMx.EndDate := self.EndDate;
////        fmBuyOrderMx.p_class_id :=cdsData.FieldByName('p_class_id').AsString;
////        fmBuyOrderMx.DoOpen;
//        //测试数据
//        GlobalBuyOrderBillFrame.AfterLoadData;
//
//
//
//    end;
//    if AItem.Caption='进货单列表' then
//    begin
//        //wn
//        HideFrame;//(self, hfcttBeforeShowFrame);
//        ShowFrame(TFrame(GlobalBuyBillFrame), TfmBuyBill);//, fmMain, nil, nil, nil,Application);
//        GlobalBuyBillFrame.FrameHistroy := CurrentFrameHistroy;
//        GlobalBuyBillFrame.AfterLoadData;
//
//    end;
//
//    if AItem.Caption='进货退货单列表' then
//    begin
//        //wn
//        HideFrame;//(self, hfcttBeforeShowFrame);
//        ShowFrame(TFrame(GlobalBuyPayBillFrame), TfmBuyPayBill);//, fmMain, nil, nil, nil,Application);
//        GlobalBuyPayBillFrame.FrameHistroy := CurrentFrameHistroy;
//        GlobalBuyPayBillFrame.AfterLoadData;
//
//    end;
//
//
//    if AItem.Caption='付款单列表' then
//    begin
//      //付款单列表
//
//        //wn
//        HideFrame;//(self, hfcttBeforeShowFrame);
//        ShowFrame(TFrame(GlobalBuyPayBillFrame), TfmBuyPayBill);//, fmMain, nil, nil, nil,Application);
//        GlobalBuyPayBillFrame.FrameHistroy := CurrentFrameHistroy;
//        GlobalBuyPayBillFrame.AfterLoadData;
//    end;
//
//
//
//
//
//
//
//
//
//    if AItem.Caption='库存查询' then
//    begin
//       HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmStoreHouseStatus),TfmStoreHouseStatus,fmMain,nil,nil,nil,Application);
//             fmStoreHouseStatus.FrameHistroy:=CurrentFrameHistroy;
//       fmStoreHouseStatus.DoOpen;
//    end;
//    if AItem.Caption='进销存汇总表' then
//    begin
//      HideFrame;
//      ShowFrame(TFrame(GlobalStoreHouseAnalyseFrame),TfmStoreHouseAnalyse);
//      GlobalStoreHouseAnalyseFrame.AfterLoadData;
//
//    end;
//    if AItem.Caption='保质期查询' then
//    begin
//       HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmStoreHouseBatchExpDate),TfmStoreHouseBatchExpDate,fmMain,nil,nil,nil,Application);
//             fmStoreHouseBatchExpDate.FrameHistroy:=CurrentFrameHistroy;
//       fmStoreHouseBatchExpDate.DoOpen;
//    end;
//    if AItem.Caption='盘点单列表' then
//    begin
//      HideFrame;
//      ShowFrame(TFrame(GlobalStoreHouseTakingBillFrame),TfmStoreHouseTakingBill);
//      GlobalStoreHouseTakingBillFrame.AfterLoadData;
//    end;
//    if AItem.Caption='调拔单列表' then
//    begin
//      HideFrame;
//      ShowFrame(TFrame(GlobalStoreHouseTransferBillFrame),TfmStoreHouseTransferBill);
//      GlobalStoreHouseTransferBillFrame.AfterLoadData;
//    end;
//    if AItem.Caption='拆装单列表' then
//    begin
//      HideFrame;
//      ShowFrame(TFrame(GlobalStoreHouseDismountBillFrame),TfmStoreHouseDismountBill);
//      GlobalStoreHouseDismountBillFrame.AfterLoadData;
//    end;
//    if AItem.Caption='其他入库列表' then
//    begin
//
//
//    end;
//    if AItem.Caption='其他出库列表' then
//    begin
//
//
//    end;
//    if AItem.Caption='成本调整单列表' then
//    begin
//
//
//    end;
//    if AItem.Caption='库存明细表' then
//    begin
//
//
//    end;
//
//
//
//
//
//
//
//    if AItem.Caption='老板报表' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmBossReport),TfmBossReport,fmMain,nil,nil,nil,Application);
//             fmBossReport.FrameHistroy:=CurrentFrameHistroy;
//       fmBossReport.DoOpen;
//    end;
//    if AItem.Caption='应收应付' then
//    begin
//       HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmClientsArAp),TfmClientsArAp,fmMain,nil,nil,nil,Application);
//             fmClientsArAp.FrameHistroy:=CurrentFrameHistroy;
//       fmClientsArAp.DoOpen;
//    end;
//    if AItem.Caption='资金余额' then
//    begin
//       HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmCashBackReprot),TfmCashBackReprot,fmMain,nil,nil,nil,Application);
//             fmCashBackReprot.FrameHistroy:=CurrentFrameHistroy;
//       fmCashBackReprot.DoOpen;
//    end;
//    if AItem.Caption='资金流水账' then
//    begin
//        //wn
//        HideFrame;//(self, hfcttBeforeShowFrame);
//        ShowFrame(TFrame(fmAccountMx), TfmAccountMx, fmMain, nil, nil, nil,Application);
//        fmAccountMx.FrameHistroy := CurrentFrameHistroy;
////        cdsData.RecNo :=  lstBaseInfo.Prop.InteractiveItem.Tag;
////        fmAccountMx.ACLASSID := cdsData.FieldByName('A_Class_id').AsString;
////        fmAccountMx.lblAccountName.Text :=  cdsData.FieldByName('a_name').AsString;
////        fmAccountMx.lblAllYe.Text := totaltostr(cdsData.FieldByName('total').AsFloat);
////        fmAccountMx.DoOpen;
//    end;
//    if AItem.Caption='经营状况表' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmStateOfOperation),TfmStateOfOperation,fmMain,nil,nil,nil,Application);
//             fmStateOfOperation.FrameHistroy:=CurrentFrameHistroy;
//       fmStateOfOperation.DoOpen;
//    end;
//    if AItem.Caption='资产负债表' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmBalanceSheet),TfmBalanceSheet,fmMain,nil,nil,nil,Application);
//             fmBalanceSheet.FrameHistroy:=CurrentFrameHistroy;
//       fmBalanceSheet.DoOpen;
//    end;
//    if AItem.Caption='收款分析' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmProfitAnalyse),TfmProfitAnalyse,fmMain,nil,nil,nil,Application);
//             fmProfitAnalyse.FrameHistroy:=CurrentFrameHistroy;
//       fmProfitAnalyse.DoOpen;
//    end;
//    if AItem.Caption='客户交易分析' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmClientTradeAnalyse),TfmClientTradeAnalyse,fmMain,nil,nil,nil,Application);
//             fmClientTradeAnalyse.FrameHistroy:=CurrentFrameHistroy;
////       fmClientTradeAnalyse.DoOpen;
//        //测试加载数据
//        fmClientTradeAnalyse.AfterLoadData;
//    end;
//    if AItem.Caption='职员业绩表' then
//    begin
//      HideFrame;//(Self,hfcttBeforeShowFrame);
//     ShowFrame(TFrame(fmEmpSaleReport),TfmEmpSaleReport,fmMain,nil,nil,nil,Application);
//           fmEmpSaleReport.FrameHistroy:=CurrentFrameHistroy;
//     fmEmpSaleReport.DoOpen;
//    end;
//    if AItem.Caption='销售提成' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmSaleCommission),TfmSaleCommission,fmMain,nil,nil,nil,Application);
//             fmSaleCommission.FrameHistroy:=CurrentFrameHistroy;
////       fmSaleCommission.DoOpen;
//        //测试加载数据
//        fmSaleCommission.AfterLoadData;
//    end;
//    if AItem.Caption='费用单列表' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(GlobalFeeBillFrame),TfmFeeBill,fmMain,nil,nil,nil,Application);
//             GlobalFeeBillFrame.FrameHistroy:=CurrentFrameHistroy;
////       GlobalFeeBillFrame.DoOpen;
//        //测试加载数据
//        GlobalFeeBillFrame.AfterLoadData;
//    end;
//    if AItem.Caption='会计凭证列表' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(GlobalWithdrawTransferFrame),TfmWithdrawTransfer,fmMain,nil,nil,nil,Application);
//             GlobalWithdrawTransferFrame.FrameHistroy:=CurrentFrameHistroy;
////       GlobalWithdrawTransferFrame.DoOpen;
//        //测试加载数据
//        GlobalWithdrawTransferFrame.AfterLoadData;
//    end;
//    if AItem.Caption='提现转账单列表' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(GlobalWithdrawTransferFrame),TfmWithdrawTransfer,fmMain,nil,nil,nil,Application);
//             GlobalWithdrawTransferFrame.FrameHistroy:=CurrentFrameHistroy;
////       GlobalWithdrawTransferFrame.DoOpen;
//        //测试加载数据
//        GlobalWithdrawTransferFrame.AfterLoadData;
//    end;
//
//
//
//    if AItem.Caption='历史销售' then
//    begin
//        HideFrame;//(Self,hfcttBeforeShowFrame);
//       ShowFrame(TFrame(fmProductSellHistory),TfmProductSellHistory,fmMain,nil,nil,nil,Application);
//             fmProductSellHistory.FrameHistroy:=CurrentFrameHistroy;
////       GlobalProductSellHistoryFrame.DoOpen;
//        //测试加载数据
//        fmProductSellHistory.AfterLoadData;
//    end;
//
//
//
//
//
//  end;
end;

procedure TFrameReportMenu.reportListPrepareDrawItem(Sender: TObject;
  ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
  AItem: TSkinItem; AItemDrawRect: TRect);
//var
//  AFrame:TFrameListItemStyle_IconTopCenter_CaptionBottomCenterBlack;
begin
//  //
//  if AItem.ItemType=sitDefault then
//  begin
//    AFrame:=TFrameListItemStyle_IconTopCenter_CaptionBottomCenterBlack(AItemDesignerPanel.Parent);
//
//    AFrame.ItemDesignerPanel.Material.BackColor.IsFill:=True;
//    AFrame.ItemDesignerPanel.Material.IsTransparent:=False;
//  end;

end;

end.


