unit WorkBenchFrame;

interface


uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  DateUtils,
  uComponentType,
  uFuncCommon,
  uUIFunction,
  uFrameContext,
  uFileCommon,
  uBaseHttpControl,
  uGetDeviceInfo,
//  HTMLReportFrame,
//  uBasePageFrame,
//  StorageFrame,

//  Winapi.Windows,

  Math,
  uManager,
  uTimerTask,
  uDrawCanvas,
  uRestInterfaceCall,
//  ClientModuleUnit1,
  uSkinItemJsonHelper,
  WaitingFrame,
  MessageBoxFrame,
  SettingFrame,
  PopupMenuFrame,
//  uPageFramework,
//  YieldTaskOrderInfoFrame,
//  SelectFilterFrame,
  uOpenCommon,
  uOpenClientCommon,
//  uDownloadListItemStyleManager,
//  ListItemStyleFrame_ProcessTaskOrder,
//  ListItemStyleFrame_FinishedProcessTask,
//  ListItemStyleFrame_Page,
  ListItemStyleFrame_Group,
//  ProcessTaskOrderInfoFrame,
  HintFrame,
//  BaseReportFrame,
//  ClientWarnningReportFrame,
//  SalesPerformanceReportFrame,
//  ClientStatisticsReportFrame,
//  ProcessTaskOrderListFrame,
//  OrderListFrame,
//  QualityCheckListFrame,
//  ExceptionProcessTaskOrderListFrame,
//  ProductInStockFrame,
//  PaymentEntryFrame,

  HZSpell,

  FMX.Platform,

  XSuperObject,
  XSuperJson,

  uBaseList,
  uSkinItems,
  uSkinListBoxType,
  uSkinListViewType,
//  WorkshopDelayFrame,

//  uPageStructure,
//
//  ProcessTaskManageFrame,

  EasyServiceCommonMaterialDataMoudle,
//  CarRepairCommonMaterialDataMoudle,


  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, uSkinFireMonkeyButton, uSkinFireMonkeyLabel,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyVirtualList,
  uSkinFireMonkeyListBox, uSkinFireMonkeyControl,
  uSkinFireMonkeyItemDesignerPanel, uSkinFireMonkeyListView,
  uSkinFireMonkeyImage, uSkinFireMonkeyPanel, uSkinFireMonkeyMultiColorLabel,
  FMX.Edit, uSkinFireMonkeyEdit, uSkinFireMonkeyNotifyNumberIcon,
  uSkinFireMonkeyCheckBox, uSkinMaterial, uSkinButtonType,
  uSkinFireMonkeyCustomList, uSkinNotifyNumberIconType, uSkinCheckBoxType,
  uSkinMultiColorLabelType, uSkinImageType, uSkinLabelType,
  uSkinItemDesignerPanelType, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinPanelType, uSkinPageControlType,
  uSkinSwitchPageListPanelType, uSkinFireMonkeyPageControl,
  uSkinScrollBoxContentType, uSkinFireMonkeyScrollBoxContent,
  uSkinScrollBoxType, uSkinFireMonkeyScrollBox, FMX.ScrollBox, FMX.Memo,
  uSkinFireMonkeyMemo, FMX.Objects, FMX.Layouts, FMX.ListBox,
  uSkinFireMonkeyComboBox, uDrawPicture, uSkinImageList, uSkinEditType,
  uTimerTaskEvent, FMX.DateTimeCtrls, uSkinCommonFrames;



type
  TFrameWorkBench = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    pnlSearchBar: TSkinFMXPanel;
    edtKeyword: TSkinFMXEdit;
    ClearEditButton1: TClearEditButton;
    btnSearch: TSkinFMXButton;
    lbFilterClassify: TSkinFMXListBox;
    imglistWorkBench: TSkinImageList;
    spnlContainer: TSkinFMXPanel;
    slstvOrder: TSkinFMXListView;
    procedure lbFilterClassifyClickItem(AItem: TSkinItem);
    procedure btnSearchClick(Sender: TObject);
    procedure ClearEditButton1Click(Sender: TObject);
    procedure edtKeywordKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtKeywordChangeTracking(Sender: TObject);
    procedure slstvOrderClickItem(AItem: TSkinItem);
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    procedure Load;

    function RefreshMenu(AOperationType:String;ASearchName:String):Boolean;

    { Public declarations }
  end;


implementation


{$R *.fmx}

uses
  MainForm,
  MainFrame;


procedure TFrameWorkBench.Load;
begin
  Self.RefreshMenu('show_all','');
end;

//刷新菜单
function TFrameWorkBench.RefreshMenu(AOperationType: String; ASearchName: String): Boolean;
var
  I:Integer;
  J:Integer;
  AItem:TSkinItem;
  ALastVisibleDetail:String;
begin

  //显示全部菜单
  if AOperationType  = 'show_all' then
  begin

    for I := 0 to Self.slstvOrder.Properties.items.Count-1 do
    begin
//      AItem:=Self.slstvOrder.Properties.items[I];
//      AItem.Visible:=(AItem.ItemType=sitDefault)
//                      //当前用户是否有该菜单项的权限
//                      and GlobalManager.HasPower(AItem.Caption);
//      (GlobalManager.EmployeeJson.S['权限']='管理员')
//                                                    or (GlobalManager.EmployeeJson.S['权限']<>'管理员')
//                                                        and ((Self.slstvOrder.Properties.items[I].Detail='sc') or (Self.slstvOrder.Properties.items[I].Detail='dd'));
    end;

  end;

  //搜索某个菜单
  if AOperationType  = 'search' then
  begin

    for I := 0 to Self.slstvOrder.Properties.items.Count-1 do
    begin
      AItem:=Self.slstvOrder.Properties.items[I];

      if Pos(ASearchName,AItem.Caption) > 0 then
      begin
//        Self.slstvOrder.Properties.items[I].Visible:=GlobalManager.HasPower(AItem.Caption);
//        (GlobalManager.EmployeeJson.S['权限']='管理员')
//                                                    or (GlobalManager.EmployeeJson.S['权限']<>'管理员')
//                                                        and ((Self.slstvOrder.Properties.items[I].Detail='sc') or (Self.slstvOrder.Properties.items[I].Detail='dd'));
      end
      else
      begin
        AItem.Visible:=False;
      end;

    end;

  end;

  //过滤出某组菜单
  if AOperationType  = 'filter' then
  begin

    for I := 0 to Self.slstvOrder.Properties.items.Count-1 do
    begin
      AItem:=Self.slstvOrder.Properties.items[I];
      if AItem.Detail = ASearchName then
      begin
//        AItem.Visible:=GlobalManager.HasPower(AItem.Caption);
//        (GlobalManager.EmployeeJson.S['权限']='管理员')
//                                                    or (GlobalManager.EmployeeJson.S['权限']<>'管理员')
//                                                        and ((Self.slstvOrder.Properties.items[I].Detail='sc') or (Self.slstvOrder.Properties.items[I].Detail='dd'));
      end
      else
      begin
        AItem.Visible:=False;
      end;
    end;

  end;


  //显示分隔项
  for I := 0 to Self.slstvOrder.Properties.items.Count-1 do
  begin
    AItem:=Self.slstvOrder.Properties.items[I];
    if (AItem.ItemType=sitSpace) or (AItem.ItemType=sitHeader) then
    begin
        AItem.Visible:=False;

        for J := 0 to Self.slstvOrder.Properties.items.Count-1 do
        begin
          if (Self.slstvOrder.Properties.items[J].ItemType=sitDefault)
          and (Self.slstvOrder.Properties.items[J].Visible) then
          begin
            if AItem.Detail=Self.slstvOrder.Properties.items[J].Detail then
            begin
              AItem.Visible:=True;
              Break;
            end;

          end;

        end;

    end;

  end;

end;

//搜索菜单
procedure TFrameWorkBench.btnSearchClick(Sender: TObject);
begin
  if Self.edtKeyword.Text <> '' then
  begin
    Self.RefreshMenu('search',Self.edtKeyword.Text);
  end;
end;

//按钮清空搜索
procedure TFrameWorkBench.ClearEditButton1Click(Sender: TObject);
begin
  Self.edtKeyword.Text:='';
  Self.lbFilterClassifyClickItem(lbFilterClassify.Prop.SelectedItem);
end;

constructor TFrameWorkBench.Create(AOwner: TComponent);
begin
  inherited;
end;

//手动清空搜索
procedure TFrameWorkBench.edtKeywordChangeTracking(Sender: TObject);
begin
  if Self.edtKeyword.Text = '' then
  begin
    Self.lbFilterClassifyClickItem(lbFilterClassify.Prop.SelectedItem);
  end;
end;

//输入框回车
procedure TFrameWorkBench.edtKeywordKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Self.btnSearchClick(nil);
  end;
end;

//切换菜单
procedure TFrameWorkBench.lbFilterClassifyClickItem(AItem: TSkinItem);
var
  I:Integer;
begin

  if AItem.Caption = '首页' then
  begin
    Self.RefreshMenu('show_all','');
  end;

  if AItem.Caption = '订单' then
  begin
    Self.RefreshMenu('filter','dd');
  end;

  if AItem.Caption = '生产' then
  begin
    Self.RefreshMenu('filter','sc');
  end;

  if AItem.Caption = '销售' then
  begin
    Self.RefreshMenu('filter','xs');
  end;

  if AItem.Caption = '仓库' then
  begin
    Self.RefreshMenu('filter','ck');
  end;

  if AItem.Caption = '财务' then
  begin
    Self.RefreshMenu('filter','cw');
  end;

  if AItem.Caption = '品质' then
  begin
    Self.RefreshMenu('filter','pz');
  end;

end;

procedure TFrameWorkBench.slstvOrderClickItem(AItem: TSkinItem);
//var
//  ABasePageFrame:TFrameBasePage;
begin


//  if AItem.Caption='订单管理' then
//  begin
//    HideFrame;
//    ShowFrame(TFrame(GlobalOrderListFrame),TFrameOrderList);
//    GlobalOrderListFrame.Load();
//  end;
//
//  if AItem.Caption='品质管理' then
//  begin
////    ABasePageFrame:=TFrameBasePage(uPageFramework.GlobalOpenPlatformFramework.ShowPage('quality_check_edit'));
////    ABasePageFrame.FPageInstance.DoCustomPageAction(Const_PageAction_AddRecord);
////    ABasePageFrame:=TFrameBasePage(uPageFramework.GlobalOpenPlatformFramework.ShowPage('QualityCheckList'));
//    //
//    HideFrame;
//    ShowFrame(TFrame(GlobalQualityCheckListFrame),TFrameQualityCheckList);
//    GlobalQualityCheckListFrame.Load();
//  end;
//
//  if AItem.Caption='品质报表' then
//  begin
//    HideFrame;
//    ShowFrame(TFrame(GlobalHTMLReportFrame),TFrameHTMLReport);
////    ShowFrame(TFrame(GlobalSalesPerformanceReportFrame),TFrameSalesPerformanceReport);
////    GlobalHTMLReportFrame
////    GlobalHTMLReportFrame
////      .Load('品质报表',
////                            '日',
//////                            '',//'2020-01-01',
//////                            '',//'2020-12-31',
////                            FormatDateTime('YYYY-MM-DD',StartOfTheMonth(Now)),
////                            FormatDateTime('YYYY-MM-DD',EndOfTheMonth(Now)),
////                            GlobalMainFrame.FConsoleFrame.DoJumpToReportDetailPage);
//  end;
//
//  if AItem.Caption='车间报工' then
//  begin
//    HideFrame;
////    ShowFrame(TFrame(GlobalMainFrame.FProcessTaskManageFrame),TFrameProcessTaskManage);
////    if GlobalMainFrame.FProcessTaskManageFrame.FUserFID<>GlobalManager.User.fid then GlobalMainFrame.FProcessTaskManageFrame.Load;
////    GlobalMainFrame.FProcessTaskManageFrame.pnlToolBar.Caption:='车间报工';
////    GlobalMainFrame.FProcessTaskManageFrame.btnReturn.Visible:=True;
////    GlobalMainFrame.FProcessTaskManageFrame.pcMain.Prop.Orientation:=toNone;
////    GlobalMainFrame.FProcessTaskManageFrame.pcMain.Prop.ActivePage:=GlobalMainFrame.FProcessTaskManageFrame.tsWait;
////    GlobalMainFrame.FProcessTaskManageFrame.pcMainChange(nil);
////    GlobalMainFrame.FProcessTaskManageFrame.FProcessTaskOrderListFrame_Wait.btnBatchEditClick(nil);
//    ShowFrame(TFrame(GlobalProcessTaskOrderListFrame_Wait),TFrameProcessTaskOrderList);
//    GlobalProcessTaskOrderListFrame_Wait.Load('车间报工',
//                                              //TFrameUseType.futViewList,
//                                              '0',
//                                              '',
//                                              '',
//                                              '',
//                                              //下单日期默认今天之前
//                                              FormatDateTime('YYYY-MM-DD',Now));
//    if GlobalManager.FCurrentDoorType='标门' then
//    begin
//      //标门报工需要管控数量 ，不能批量报工 。
//      GlobalProcessTaskOrderListFrame_Wait.btnBatchEdit.Visible:=False;
//    end
//    else
//    begin
//      //非标门
//      GlobalProcessTaskOrderListFrame_Wait.btnBatchEdit.Visible:=True;
//      GlobalProcessTaskOrderListFrame_Wait.btnBatchEditClick(nil);
//    end;
//    //查看今日已完工
//    GlobalProcessTaskOrderListFrame_Wait.btnMore.Visible:=True;
//
//  end;
//
//  if AItem.Caption='生产进度' then
//  begin
//
////    if GlobalManager.EmployeeJson.S['权限'] <> '管理员' then
////    begin
////      ShowMessage('当前功能只限管理员使用！');
////    end
////    else
////    begin
//      HideFrame;
////      ShowFrame(TFrame(GlobalMainFrame.FProcessTaskManageFrame),TFrameProcessTaskManage);
////      if GlobalMainFrame.FProcessTaskManageFrame.FUserFID<>GlobalManager.User.fid then GlobalMainFrame.FProcessTaskManageFrame.Load;
////      GlobalMainFrame.FProcessTaskManageFrame.pnlToolBar.Caption:='生产进度';
////      GlobalMainFrame.FProcessTaskManageFrame.btnReturn.Visible:=True;
////      GlobalMainFrame.FProcessTaskManageFrame.pcMain.Prop.Orientation:=toNone;
////      GlobalMainFrame.FProcessTaskManageFrame.pcMain.Prop.ActivePage:=GlobalMainFrame.FProcessTaskManageFrame.tsSchedule;
////      GlobalMainFrame.FProcessTaskManageFrame.pcMainChange(nil);
////    end;
//    ShowFrame(TFrame(GlobalProcessTaskOrderListFrame_Schedule),TFrameProcessTaskOrderList);
//    GlobalProcessTaskOrderListFrame_Schedule.Load('生产进度',
//                                          //TFrameUseType.futViewList,
//                                          '',
//                                          '',
//                                          '',
//                                          '',
//                                          '');
//    GlobalProcessTaskOrderListFrame_Schedule.btnBatchEdit.Visible:=False;
//    GlobalProcessTaskOrderListFrame_Schedule.lvOrderList.Prop.DefaultItemStyle:='ProcessTaskSchedule';
//    GlobalProcessTaskOrderListFrame_Schedule.lvOrderList.Prop.ItemHeight:=120;
//
//  end;
//
//  if AItem.Caption='异常分析' then
//  begin
//
//    HideFrame;
////    ShowFrame(TFrame(GlobalMainFrame.FProcessTaskManageFrame),TFrameProcessTaskManage);
////    if GlobalMainFrame.FProcessTaskManageFrame.FUserFID<>GlobalManager.User.fid then GlobalMainFrame.FProcessTaskManageFrame.Load;
////    GlobalMainFrame.FProcessTaskManageFrame.pnlToolBar.Caption:='异常分析';
////    GlobalMainFrame.FProcessTaskManageFrame.btnReturn.Visible:=True;
////    GlobalMainFrame.FProcessTaskManageFrame.pcMain.Prop.Orientation:=toNone;
////    GlobalMainFrame.FProcessTaskManageFrame.pcMain.Prop.ActivePage:=GlobalMainFrame.FProcessTaskManageFrame.tsError;
////    GlobalMainFrame.FProcessTaskManageFrame.pcMainChange(nil);
//    ShowFrame(TFrame(GlobalExceptionProcessTaskOrderListFrame),TFrameExceptionProcessTaskOrderList);
//    GlobalExceptionProcessTaskOrderListFrame.Load('异常分析',
//                                                //TFrameUseType.futViewList,
//                                                '2',
//                                                '',
//                                                '',
//                                                '',
//                                                '');
//    GlobalExceptionProcessTaskOrderListFrame.btnBatchEdit.Visible:=False;
//  end;
//
//
//  if AItem.Caption='销售业绩' then
//  begin
//    if GlobalManager.FCurrentDoorType='标门' then
//    begin
//        //标门
//        HideFrame;
//        ShowFrame(TFrame(GlobalHTMLReportFrame),TFrameHTMLReport);
//  //      ShowFrame(TFrame(GlobalSalesPerformanceReportFrame),TFrameSalesPerformanceReport);
//    //    GlobalHTMLReportFrame
////        GlobalHTMLReportFrame
////          .Load('销售业绩报表(根据发货)',
////                                '接单员',
////                                FormatDateTime('YYYY-MM-DD',StartOfTheMonth(Now)),
////                                FormatDateTime('YYYY-MM-DD',EndOfTheMonth(Now)),
////                                GlobalMainFrame.FConsoleFrame.DoJumpToReportDetailPage);
//
//    end
//    else
//    begin
//        //非标门
//        HideFrame;
//    //    ShowFrame(TFrame(GlobalHTMLReportFrame),TFrameHTMLReport);
//        ShowFrame(TFrame(GlobalSalesPerformanceReportFrame),TFrameSalesPerformanceReport);
//    //    GlobalHTMLReportFrame
//
////        GlobalSalesPerformanceReportFrame.FHTMLReportFrame
////          .Load('销售业绩报表(根据已审接单)',
////                                '接单员',
////                                FormatDateTime('YYYY-MM-DD',StartOfTheMonth(Now)),
////                                FormatDateTime('YYYY-MM-DD',EndOfTheMonth(Now)),
////                                GlobalMainFrame.FConsoleFrame.DoJumpToReportDetailPage);
//
//    end;
//  end;
//
////  if AItem.Caption='客户统计' then
////  begin
////    if GlobalManager.FCurrentDoorType='标门' then
////    begin
////        HideFrame;
////        ShowFrame(TFrame(GlobalHTMLReportFrame),TFrameHTMLReport);
////        GlobalHTMLReportFrame.Load('客户统计报表(根据发货)','客户',
////    //                                                            '',
////    //                                                            '',
////                                                                FormatDateTime('YYYY-MM-DD',StartOfTheMonth(Now)),
////                                                                FormatDateTime('YYYY-MM-DD',EndOfTheMonth(Now)),
////                                                             GlobalMainFrame.FConsoleFrame.DoJumpToReportDetailPage);
////    end
////    else
////    begin
////        HideFrame;
////        ShowFrame(TFrame(GlobalClientStatisticsReportFrame),TFrameClientStatisticsReport);
////        GlobalClientStatisticsReportFrame.FHTMLReportFrame.Load('客户统计报表(根据已审接单)','客户',
////    //                                                            '',
////    //                                                            '',
////                                                                FormatDateTime('YYYY-MM-DD',StartOfTheMonth(Now)),
////                                                                FormatDateTime('YYYY-MM-DD',EndOfTheMonth(Now)),
////                                                                GlobalMainFrame.FConsoleFrame.DoJumpToReportDetailPage);
////    end;
////  end;
//
//  if AItem.Caption='客户预警' then
//  begin
//    HideFrame;
//    ShowFrame(TFrame(GlobalClientWarnningReportFrame),TFrameClientWarnningReport);
//    GlobalClientWarnningReportFrame.Load('客户预警报表','','','','','','Default');
//  end;
//
//
//  if AItem.Caption='成品入库' then
//  begin
//    HideFrame;
//    ShowFrame(TFrame(GlobalProductInStockFrame),TFrameProductInStock);
//    GlobalProductInStockFrame.Load();
//  end;
//  if AItem.Caption='仓库库存' then
//  begin
//    HideFrame;
//    ShowFrame(TFrame(GlobalStorageFrame),TFrameStorage);
//    GlobalStorageFrame.Load('仓库库存报表','','',
//                                            '',
//                                            '',
//                                            '',
//                                            '');
////    GlobalStorageFrame.btnViewType.Visible:=True;
//  end;
//
//  if AItem.Caption='货款管理' then
//  begin
//    HideFrame;
//    ShowFrame(TFrame(GlobalPaymentEntryFrame),TFramePaymentEntry);
//    GlobalPaymentEntryFrame.Load();
//  end;
//
//  if AItem.Caption='车间延期' then
//  begin
//    HideFrame;
//    ShowFrame(TFrame(GlobalWorkshopDelayFrame),TFrameWorkshopDelay);
//    GlobalWorkshopDelayFrame.Load();
//  end;

end;


end.
