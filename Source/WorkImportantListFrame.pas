unit WorkImportantListFrame;

interface


uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uComponentType,
  uFuncCommon,
  uUIFunction,
  uFrameContext,
  uFileCommon,
  uBaseHttpControl,
  uGetDeviceInfo,
  DateUtils,

//  Winapi.Windows,

  Math,
  StrUtils,
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
//  YieldTaskOrderInfoFrame,
//  SelectFilterFrame,
  SelectFilterDateAreaFrame,
  uOpenCommon,
  uOpenClientCommon,
//  uDownloadListItemStyleManager,
//  ListItemStyleFrame_WorkImportant,
  ListItemStyleFrame_FinishedProcessTask,
  ListItemStyleFrame_Page,
//  WorkImportantInfoFrame,
  HintFrame,
  ViewPictureListFrame,
  uViewPictureListFrame,
  SubCalendarFrame,
  ListItemStyleFrame_WorkImportant,
//  AddContentFrame,
//  CompleteWorkImportantFrame,
//  CompleteWorkImportantConfirmFrame,

  HZSpell,

  FMX.Platform,

  XSuperObject,
  XSuperJson,

  uBaseList,
  uSkinItems,
  uSkinListBoxType,
  uSkinListViewType,

  uPageStructure,

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
  uTimerTaskEvent, FMX.DateTimeCtrls, uSkinCommonFrames, uSkinFireMonkeyPopup;



type
  TFrameWorkImportantList = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    lvOrderList: TSkinFMXListView;
    idtDefault: TSkinFMXItemDesignerPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    lblItemCarPlateNumber: TSkinFMXLabel;
    lblItemContactsName: TSkinFMXLabel;
    lblItemCarType: TSkinFMXLabel;
    SkinFMXLabel4: TSkinFMXLabel;
    SkinFMXLabel5: TSkinFMXLabel;
    lblItemContactsPhone: TSkinFMXLabel;
    SkinFMXLabel6: TSkinFMXLabel;
    SkinFMXLabel8: TSkinFMXLabel;
    btnButton1: TSkinFMXButton;
    tteGetWorkImportantList: TTimerTaskEvent;
    lblItemSumMoney: TSkinFMXMultiColorLabel;
    lblItemCreateTime: TSkinFMXLabel;
    SkinFMXLabel3: TSkinFMXLabel;
    lblItemOrderState: TSkinFMXLabel;
    SkinFMXLabel7: TSkinFMXLabel;
    SkinFMXLabel9: TSkinFMXLabel;
    pnlFilter: TSkinFMXPanel;
    edtFilter: TSkinFMXEdit;
    msgboxCheckWorkImportant: TSkinMessageBox;
    tteCompleteWorkImportant: TTimerTaskEvent;
    idtDefault1: TSkinFMXItemDesignerPanel;
    SkinFMXLabel10: TSkinFMXLabel;
    SkinFMXLabel11: TSkinFMXLabel;
    SkinFMXLabel12: TSkinFMXLabel;
    SkinFMXLabel13: TSkinFMXLabel;
    SkinFMXLabel14: TSkinFMXLabel;
    SkinFMXLabel15: TSkinFMXLabel;
    SkinFMXLabel16: TSkinFMXLabel;
    SkinFMXLabel17: TSkinFMXLabel;
    SkinFMXLabel18: TSkinFMXLabel;
    SkinFMXLabel19: TSkinFMXLabel;
    SkinFMXButton1: TSkinFMXButton;
    SkinFMXMultiColorLabel1: TSkinFMXMultiColorLabel;
    SkinFMXLabel20: TSkinFMXLabel;
    SkinFMXLabel21: TSkinFMXLabel;
    SkinFMXLabel22: TSkinFMXLabel;
    SkinFMXLabel23: TSkinFMXLabel;
    SkinFMXLabel24: TSkinFMXLabel;
    btnButton2: TSkinFMXButton;
    SkinFMXButton2: TSkinFMXButton;
    lbOrderState: TSkinFMXListBox;
    ClearEditButton1: TClearEditButton;
    btnBatchEdit: TSkinFMXButton;
    pnlBottom: TSkinFMXPanel;
    btnBatchOK: TSkinFMXButton;
    btnDel: TSkinFMXButton;
    chkSelectedAllItem: TSkinFMXCheckBox;
    btnFilter: TSkinFMXButton;
    btnBatchCancel: TSkinFMXButton;
    btnSearch: TSkinFMXButton;
    lblSelectedCount: TSkinFMXLabel;
    pnlSumCount: TSkinFMXPanel;
    lblCount: TSkinFMXLabel;
    lblLoadedCount: TSkinFMXLabel;
    btnMore: TSkinFMXButton;
    popuAdd: TSkinFMXPopup;
    lbAddList: TSkinFMXListBox;
    tmrFilterChangeTracking: TTimer;
    pnlDateArea: TSkinFMXPanel;
    btnSelectDateArea: TSkinSelectDateAreaButton;
    pnlProcess: TSkinFMXPanel;
    cmbProcess: TSkinFMXComboBox;
    tteGetProcessList: TTimerTaskEvent;
    procedure tteGetWorkImportantListExecute(Sender: TTimerTask);
    procedure tteGetWorkImportantListExecuteEnd(Sender: TTimerTask);
    procedure btnReturnClick(Sender: TObject);
    procedure lvOrderListPullDownRefresh(Sender: TObject);
    procedure lvOrderListPullUpLoadMore(Sender: TObject);
    procedure lbOrderStateClickItem(AItem: TSkinItem);
    procedure lvOrderListClickItem(AItem: TSkinItem);
    procedure edtFilterChange(Sender: TObject);
    procedure edtFilterChangeTracking(Sender: TObject);
    procedure msgboxCheckWorkImportantCanModalResult(Sender: TObject;
                                                        AModalResult:String;
                                                        AModalResultName:String;
                                                        var AIsCanModalResult: Boolean);
    procedure msgboxCheckWorkImportantModalResult(Sender: TObject);
    procedure tteCompleteWorkImportantBegin(ATimerTask: TTimerTask);
    procedure tteCompleteWorkImportantExecute(ATimerTask: TTimerTask);
    procedure tteCompleteWorkImportantExecuteEnd(ATimerTask: TTimerTask);
    procedure lvOrderListPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
      AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem;
      AItemDrawRect: TRect);
    procedure lvOrderListClickItemDesignerPanelChild(Sender: TObject;
      AItem: TBaseSkinItem; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
      AChild: TFmxObject);
    procedure btnBatchEditClick(Sender: TObject);
    procedure btnBatchOKClick(Sender: TObject);
    procedure chkSelectedAllItemClick(Sender: TObject);
    procedure btnBatchCancelClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure edtFilterKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure lvOrderListNewListItemStyleFrameCacheInit(Sender: TObject;
      AListItemTypeStyleSetting: TListItemTypeStyleSetting;
      ANewListItemStyleFrameCache: TListItemStyleFrameCache);
    procedure lvDoorTypeClickItem(AItem: TSkinItem);
    procedure btnSwitchProcessClick(Sender: TObject);
    procedure cmbProcessChange(Sender: TObject);
    procedure btnMoreClick(Sender: TObject);
    procedure lbAddListClickItem(AItem: TSkinItem);
    procedure tmrFilterChangeTrackingTimer(Sender: TObject);
    procedure btnSelectDateAreaClick(Sender: TObject);
    procedure tteGetProcessListExecute(ATimerTask: TTimerTask);
    procedure tteGetProcessListExecuteEnd(ATimerTask: TTimerTask);
  protected
    FPageIndex:Integer;
//    FItemStylePage:TPage;
//    FFrameUseType:TFrameUseType;
//    FItemButtonCaption:String;

//    //报工状态
//    FFilterIsFinished:String;
//    FFilterFinishedStartDate:String;
//    FFilterFinishedEndDate:String;

//    FFilterStartDate:String;
//    FFilterEndDate:String;

    FSubCalendarFrame:TFrameSubCalendar;



    //包含验收员和验收日期,维修单号
    //FCompleteJson:ISuperObject;

    procedure Clear;

    procedure SyncSelectedCount;

//    //派工返回
//    procedure DoReturnFrameFromDispatchWork(AFrame:TFrame);
//
//    //领料返回
//    procedure DoReturnFrameFromPickMaterial(AFrame:TFrame);

    //选择过滤条件
    procedure DoReturnFrameFromSelectFilterFrame(AFrame:TFrame);

    procedure DoReturnFrameFromYieldTaskOrderInfoFrame(AFrame:TFrame);

    procedure DoReturnFrameFromCompleteWorkImportantConfirmFrame(AFrame:TFrame);

    procedure DoReturnFrameFromCompleteWorkImportantFrame(AFrame:TFrame);

    //上报异常的时候给内容加上岗位
    procedure DoCustomPostedContentJson(Sender:TObject;AContentJson:ISuperObject);

    function DoCustomCheckInput(Sender:TObject):Boolean;

    procedure DoReturnFrameFromSelectDateArea(AFromFrame:TFrame);
    procedure lvCalendarClickItem(Sender: TSkinItem);
    { Private declarations }
//  protected
//    function GetCustomExceptionProcessWhereSQL:String;virtual;
//    function GetCustomWhereSQL:String;virtual;
//    //获取不创建的字段列表
//    function GetHideFieldListCommaText:String;virtual;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    //FListItemStyle:String;
    //FListItemStylePage:TPage;
    procedure Load(
                    //页面使用的类型
                    //AFrameUseType:TFrameUseType;
                    //按钮
                    //AItemButtonCaption:String;
                    AFilterStartDate:String;
                    AFilterEndDate:String
                    );
    { Public declarations }
  end;


var
  GlobalWorkImportantListFrame:TFrameWorkImportantList;
//  //待处理工序列表
//  GlobalWorkImportantListFrame_Wait:TFrameWorkImportantList;
//  //异常单
//  GlobalWorkImportantListFrame_Error:TFrameWorkImportantList;
//  //生产进度
//  GlobalWorkImportantListFrame_Schedule:TFrameWorkImportantList;
//  //待领料工单列表
//  GlobalWaitPickOrderListFrame:TFrameWorkImportantList;
//  //待验收工单列表
//  GlobalWaitCheckOrderListFrame:TFrameWorkImportantList;
//  //车辆维修历史列表
//  GlobalCarRepairHistoryOrderListFrame:TFrameWorkImportantList;


implementation


uses
  MainFrame,
//  CompletedWorkImportantListFrame,
  BaseReportFrame;
//  MainForm,
//  CheckWorkImportantFrame,
//  PickMaterialFrame,
//  DispatchWorkFrame
//  ;

{$R *.fmx}

procedure TFrameWorkImportantList.btnBatchCancelClick(Sender: TObject);
var
  I: Integer;
begin
  Self.btnBatchEdit.Visible:=True;
  Self.btnBatchCancel.Visible:=False;
  pnlBottom.Visible:=False;

  Self.lvOrderList.Prop.MultiSelect:=False;

  //先全部取消全选
  Self.lvOrderList.Prop.Items.BeginUpdate;
  try
    for I := 0 to Self.lvOrderList.Prop.Items.Count-1 do
    begin
      Self.lvOrderList.Prop.Items[I].Selected:=False;
      Self.lvOrderList.Prop.Items[I].IsBufferNeedChange:=True;
    end;
  finally
    Self.lvOrderList.Prop.Items.EndUpdate;
  end;



end;

procedure TFrameWorkImportantList.btnBatchEditClick(Sender: TObject);
var
  I: Integer;
begin
  Self.btnBatchEdit.Visible:=False;
  Self.btnBatchCancel.Visible:=False;
  pnlBottom.Visible:=True;



  Self.lvOrderList.Prop.MultiSelect:=True;


  //先全部取消全选
  Self.lvOrderList.Prop.Items.BeginUpdate;
  try
    for I := 0 to Self.lvOrderList.Prop.Items.Count-1 do
    begin
      Self.lvOrderList.Prop.Items[I].Selected:=False;
      Self.lvOrderList.Prop.Items[I].IsBufferNeedChange:=True;
    end;
  finally
    Self.lvOrderList.Prop.Items.EndUpdate;
  end;



//  //编辑、取消共用按钮
//  if Self.btnEdit.Caption='编辑' then
//  begin
//    if Self.lvOrderList.Prop.Items.Count>0 then
//    begin
//       Self.btnEdit.Caption:='完成';
//
//      Self.pnlBottom.Visible:=True;
//      Self.btnSetAllRead.Enabled:=True;
//      //编辑状态显示选中框
//      Self.chkOrderItemSelected.Visible:=True;
//    end;
//  end
//  else
//  begin
//    Self.btnEdit.Caption:='编辑';
//
//    Self.pnlBottom.Visible:=False;
//    Self.chkSelectedAllItem.Prop.Checked:=False;
//    Self.btnDel.Enabled:=False;
//
//    //非编辑状态不显示选中框
//    Self.chkOrderItemSelected.Visible:=False;
//
//    //恢复为未选中
//    for I := 0 to Self.lvOrderList.Prop.Items.Count-1 do
//    begin
//      if Self.lvOrderList.Prop.Items.Items[I].Checked then
//      begin
//        Self.lvOrderList.Prop.Items.Items[I].Checked:=False;
//      end;
//    end;
//  end;


end;

procedure TFrameWorkImportantList.btnBatchOKClick(Sender: TObject);
var
  I:Integer;
  AHasData:Boolean;
begin


//  Self.lvOrderList.Prop.MultiSelect:=False;


  AHasData:=False;
  Self.lvOrderList.Prop.Items.BeginUpdate;
  try
    for I := 0 to Self.lvOrderList.Prop.Items.Count-1 do
    begin
      Self.lvOrderList.Prop.Items[I].IsBufferNeedChange:=True;
      if Self.lvOrderList.Prop.Items[I].Selected then
      begin
        AHasData:=True;
        Break;
      end;
    end;
  finally
    Self.lvOrderList.Prop.Items.EndUpdate;
  end;


  if AHasData then
  begin
    Self.tteCompleteWorkImportant.Run;
  end;


//  Self.btnBatchEdit.Visible:=True;
//  Self.btnBatchCancel.Visible:=False;
//  pnlBottom.Visible:=False;


end;

procedure TFrameWorkImportantList.btnFilterClick(Sender: TObject);
begin
  //搜索
  HideFrame;
//  ShowFrame(TFrame(GlobalSelectFilterFrame),TFrameSelectFilter,DoReturnFrameFromSelectFilterFrame);
  ShowFrame(TFrame(GlobalSelectFilterDateAreaFrame),TFrameSelectFilterDateArea,DoReturnFrameFromSelectFilterFrame);

//  if Self.FFilterIsFinished='1' then
//  begin
//    //完成日期
//    GlobalSelectFilterDateAreaFrame.Load(
//                                Self.FFilterStartDate,
//                                FFilterEndDate//,
//                                //''
//                                );
//    GlobalSelectFilterDateAreaFrame.pnlToolBar.Caption:='选择完成日期';
//
//  end
//  else
//  begin
    //未完成
    //日期
    GlobalSelectFilterDateAreaFrame.Load(
                                btnSelectDateArea.StartDate,//FFilterStartDate,
                                btnSelectDateArea.EndDate//FFilterEndDate//,
                                //''
                                );

    GlobalSelectFilterDateAreaFrame.pnlToolBar.Caption:='选择日期';
//  end;

end;
type
  TProtectedControl=class(TControl);

procedure TFrameWorkImportantList.btnMoreClick(Sender: TObject);
var
  AButton:TControl;
begin
//  if not GlobalManager.IsLogin then
//  begin
//    ShowLoginFrame(True);
//    Exit;
//  end;


//  HideFrame;
//  ShowFrame(TFrame(GlobalAddContentFrame),TFrameAddContent,DoReturnFromAddContent);
//  GlobalAddContentFrame.Clear;
//  Exit;


  AButton:=TControl(Sender);

  if Not Self.popuAdd.IsOpen then
  begin
    //设置弹出框绝对位置
    Self.popuAdd.PlacementRectangle.Left:=
          TProtectedControl(AButton.Parent).LocalToScreen(PointF(AButton.Position.X+AButton.Width,0)).X
          -Self.popuAdd.Width
          -20
//          -4
          ;
    Self.popuAdd.PlacementRectangle.Top:=
          TProtectedControl(AButton.Parent).LocalToScreen(PointF(0,Self.pnlToolBar.Height)).Y
          -10;
    Self.popuAdd.IsOpen:=True;
  end
  else
  begin
    Self.popuAdd.IsOpen:=False;
  end;


end;

procedure TFrameWorkImportantList.btnReturnClick(Sender: TObject);
begin
  HideFrame(Self);
  ReturnFrame(Self);
end;

//查询
procedure TFrameWorkImportantList.btnSearchClick(Sender: TObject);
begin
  FPageIndex:=1;
  Self.tteGetWorkImportantList.Run;

//  Self.tteGetProcessTaskCount.Run;
end;

procedure TFrameWorkImportantList.btnSelectDateAreaClick(Sender: TObject);
begin
  //选择日期范围

  //搜索
  HideFrame;
  ShowFrame(TFrame(GlobalSelectFilterDateAreaFrame),TFrameSelectFilterDateArea,DoReturnFrameFromSelectDateArea);
  //完成日期
  GlobalSelectFilterDateAreaFrame.Load(
                              btnSelectDateArea.StartDate,
                              btnSelectDateArea.EndDate
                              );
  GlobalSelectFilterDateAreaFrame.pnlToolBar.Caption:='选择'+Self.pnlDateArea.Caption;

end;

procedure TFrameWorkImportantList.btnSwitchProcessClick(Sender: TObject);
begin
  //
end;

procedure TFrameWorkImportantList.chkSelectedAllItemClick(Sender: TObject);
begin
  //全选/全不选
  if Self.lvOrderList.Prop.Items.Count>0 then
  begin


      //编辑状态
      //全选/全不选
      if Not Self.lvOrderList.Prop.Items.IsSelectedAll then
      begin
        Self.lvOrderList.Prop.Items.SelectAll;
      end
      else
      begin
        Self.lvOrderList.Prop.Items.UnSelectAll;
      end;

      Self.chkSelectedAllItem.Prop.Checked:=
        (Self.lvOrderList.Prop.Items.Count>0)
        and Self.lvOrderList.Prop.Items.IsSelectedAll;

  //    //全选按钮状态与删除按钮状态同步
  //    if Self.chkSelectedAllItem.Prop.Checked then
  //    begin
  //      Self.btnDel.Enabled:=True;
  //    end
  //    else
  //    begin
  //      Self.btnDel.Enabled:=False;
  //    end;
      SyncSelectedCount;
  end
  else
  begin

  end;

end;

procedure TFrameWorkImportantList.Clear;
begin

  Self.lvOrderList.Prop.Items.BeginUpdate;
  try
    Self.lvOrderList.Prop.Items.Clear();
  finally
    Self.lvOrderList.Prop.Items.EndUpdate;
  end;



end;

procedure TFrameWorkImportantList.cmbProcessChange(Sender: TObject);
begin
  //换过了,要刷新一遍
  FPageIndex:=1;
  Self.tteGetWorkImportantList.Run;

end;

constructor TFrameWorkImportantList.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited;

//  if Not IsPadDevice then
//  begin
//    Self.lvOrderList.Properties.ItemDesignerPanel:=Self.idtDefault1;
//    Self.lvOrderList.Properties.ItemHeight:=131;
//  end
//  else
//  begin
//    Self.lvOrderList.Properties.ItemDesignerPanel:=Self.idtDefault;
//    Self.lvOrderList.Properties.ItemHeight:=90;
//  end;


  Self.lvOrderList.Prop.Items.BeginUpdate;
  try
    Self.lvOrderList.Prop.Items.Clear();
  finally
    Self.lvOrderList.Prop.Items.EndUpdate;
  end;


  pnlBottom.Visible:=False;


//  Self.cmbProcess.OnChange:=nil;
//  try
////    Self.cmbProcess.Items.Clear;
//    //先加入自己的岗位
//    Self.cmbProcess.Items.CommaText:=GlobalManager.EmployeeJson.S['岗位'];
//
//    //看看操作员有没有查看其他岗位的权限
//
////    if GlobalManager.HasPower('允许查看全部岗位的工作重点') then
////    begin
////
////      //再加入所有的岗位
////      for I := 0 to GlobalManager.ProcessArray.Length-1 do
////      begin
////        Self.cmbProcess.Items.Add(GlobalManager.ProcessArray.O[I].S['值的值']);
////      end;
////
////    end;
//
//    Self.cmbProcess.ItemIndex:=0;
//  finally
//    Self.cmbProcess.OnChange:=cmbProcessChange;
//  end;


//  //看看操作员有没有查看其他岗位的权限
//  //添加其他岗位
//  if GlobalManager.HasPower('允许查看全部岗位的工作重点') then
//  begin
//    tteGetProcessList.Run();
//  end;


  FSubCalendarFrame:=TFrameSubCalendar.Create(Self);
  FSubCalendarFrame.Parent:=Self;
  FSubCalendarFrame.Align:=TAlignLayout.Top;
  FSubCalendarFrame.pnlToolBar.Visible:=False;
  FSubCalendarFrame.Height:=80;
  FSubCalendarFrame.Load(StartOfTheWeek(Now),EndOfTheWeek(Now));
  FSubCalendarFrame.lvCalendar.OnClickItem:=lvCalendarClickItem;


//  FSubCalendarFrame.Height:=FSubCalendarFrame.lvCalendar.Height;

////  FSubCalendarFrame.lb


//  FListItemStylePage:=TPage.Create(nil);

//  FilterOrderState:='(''待派'',''已派工'')';

//  LoadDoorTypeToListView(GlobalManager.DoorTypeArray,Self.lvDoorType);
end;

destructor TFrameWorkImportantList.Destroy;
begin
//  FreeAndNil(FListItemStylePage);

  inherited;
end;

//procedure TFrameWorkImportantList.DoReturnFrameFromDispatchWork(AFrame: TFrame);
//begin
//  //刷新
//  Self.lvOrderList.Prop.StartPullDownRefresh;
//
//  //派工之后还要领料,不需要删除
////  //派工成功,返回
////  Self.lvOrderList.Prop.Items.Remove(Self.lvOrderList.Prop.InteractiveItem);
//end;
//
//procedure TFrameWorkImportantList.DoReturnFrameFromPickMaterial(AFrame: TFrame);
//begin
//  //刷新
//  Self.lvOrderList.Prop.StartPullDownRefresh;
//
//
//  //领料成功,返回
//  //Self.lvOrderList.Prop.Items.Remove(Self.lvOrderList.Prop.InteractiveItem);
//end;

function TFrameWorkImportantList.DoCustomCheckInput(Sender: TObject): Boolean;
begin
  Result:=True;
end;

procedure TFrameWorkImportantList.DoCustomPostedContentJson(Sender: TObject;
  AContentJson: ISuperObject);
begin
  //在完成的工作重点中加入工序
  AContentJson.S['big_type']:='工作重点';
//  AContentJson.S['process']:=GlobalManager.CurrentProcess;
  AContentJson.I['is_best']:=1;
  AContentJson.S['user_name']:=GlobalManager.User.name;
  AContentJson.S['createtime']:=StdDateTimeToStr(Now);

end;

procedure TFrameWorkImportantList.DoReturnFrameFromCompleteWorkImportantConfirmFrame(
  AFrame: TFrame);
begin
  Self.FPageIndex:=1;
  Self.tteGetWorkImportantList.Run();
end;

procedure TFrameWorkImportantList.DoReturnFrameFromCompleteWorkImportantFrame(
  AFrame: TFrame);
begin
  Self.FPageIndex:=1;
  Self.tteGetWorkImportantList.Run();
end;

procedure TFrameWorkImportantList.DoReturnFrameFromSelectDateArea(
  AFromFrame: TFrame);
begin
  btnSelectDateArea.StartDate:=TFrameSelectFilterDateArea(AFromFrame).FStartDate;
  btnSelectDateArea.EndDate:=TFrameSelectFilterDateArea(AFromFrame).FEndDate;

  //刷新
  Self.FPageIndex:=1;
  Self.tteGetWorkImportantList.Run();

end;

procedure TFrameWorkImportantList.DoReturnFrameFromSelectFilterFrame(
  AFrame: TFrame);
begin
  //
//  GlobalSelectFilterFrame//

//
//  if Self.FFilterIsFinished='1' then
//  begin
//    //完成日期
//    FFilterFinishedStartDate:=GlobalSelectFilterDateAreaFrame.FStartDate;
//    FFilterFinishedEndDate:=GlobalSelectFilterDateAreaFrame.FEndDate;
//
//  end
//  else
//  begin

//    //未完成
//    //日期
//    FFilterStartDate:=GlobalSelectFilterDateAreaFrame.FStartDate;
//    FFilterEndDate:=GlobalSelectFilterDateAreaFrame.FEndDate;

//  end;

  Self.tteGetWorkImportantList.Run();
//
//  if GlobalMainFrame.FProcessTaskManageFrame<>nil then
//  begin
//    Self.tteGetProcessTaskCount.Run;
//  end;

end;

procedure TFrameWorkImportantList.DoReturnFrameFromYieldTaskOrderInfoFrame(
  AFrame: TFrame);
begin
//  if (Self.lvOrderList.Prop.SelectedItem<>nil)
//    and (Self.lvOrderList.Prop.SelectedItem.Json<>nil) then
//  begin
//    Self.lvOrderList.Prop.SelectedItem.Json.S['ifError']:=TFrameYieldTaskOrderInfo(AFrame).FYieldTaskOrder.S['ifError'];
//    Self.lvOrderList.Prop.SelectedItem.IsBufferNeedChange:=True;
//    Self.lvOrderList.Invalidate;
//  end;
  
end;

procedure TFrameWorkImportantList.edtFilterChange(Sender: TObject);
begin
  //输入跟踪事件,重新过滤
//  if Self.edtFilter.Text = '' then
//  begin
//    FPageIndex:=1;
//    Self.tteGetWorkImportantList.Run;
//  end;

end;

procedure TFrameWorkImportantList.edtFilterChangeTracking(Sender: TObject);
begin
  tmrFilterChangeTracking.Enabled:=False;
  tmrFilterChangeTracking.Enabled:=True;
//  //输入跟踪事件,重新过滤
//  if Self.edtFilter.Text = '' then
//  begin
//    FPageIndex:=1;
//    Self.tteGetWorkImportantList.Run;
//
//    if GlobalMainFrame.FProcessTaskManageFrame<>nil then
//    begin
//      Self.tteGetProcessTaskCount.Run;
//    end;
//  end;
end;

procedure TFrameWorkImportantList.edtFilterKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    FPageIndex:=1;
    Self.tteGetWorkImportantList.Run;

//    if GlobalMainFrame.FProcessTaskManageFrame<>nil then
//    begin
//      Self.tteGetProcessTaskCount.Run;
//    end;
  end;
end;

//function TFrameWorkImportantList.GetCustomExceptionProcessWhereSQL: String;
//begin
//  Result:='';
////  if FFilterIsFinished='2' then
////  begin
//    if GlobalManager.EmployeeJson.S['权限']<>'管理员' then
//    begin
//      //报工工人只能看到自己上报的异常单
//      Result:=Result+' AND [异常上报工序]='''
//                              //+GlobalManager.EmployeeJson.S['岗位']
//                              +GlobalManager.CurrentProcess//Self.cmbProcess.Text
//                              +''' ';
//    end;
////  end;
//end;
//
//function TFrameWorkImportantList.GetCustomWhereSQL: String;
//begin
////    //报工状态
////    FFilterIsFinished:String;
////    FFilterFinishedStartDate:String;
////    FFilterFinishedEndDate:String;
////
////    FFilterStartDate:String;
////    FFilterEndDate:String;
//
//  Result:=' AND [工序]='''
//              //+GlobalManager.EmployeeJson.S['岗位']
//              +GlobalManager.CurrentProcess
//              +''' ';
//
//  if FFilterIsFinished='0' then
//  begin
//    Result:=Result+' AND [工序状态]=''待处理'' ';
//  end
//  else if FFilterIsFinished='1' then
//  begin
//    Result:=Result+' AND [工序状态]=''已完成'' ';
//  end
//  else if FFilterIsFinished='2' then
//  begin
//    Result:=Result+' AND [工序状态]=''异常'' ';
//    Result:=Result+GetCustomExceptionProcessWhereSQL;
////    if GlobalManager.EmployeeJson.S['权限']<>'管理员' then
////    begin
////      //报工工人只能看到自己上报的异常单
////      Result:=Result+' AND [异常上报工序]='''+GlobalManager.EmployeeJson.S['岗位']+''' ';
////    end;
//  end;
//
//  if FFilterFinishedStartDate<>'' then
//  begin
//    Result:=Result+' AND [完成日期]>='''+FFilterFinishedStartDate+''' ';
//  end;
//  if FFilterFinishedEndDate<>'' then
//  begin
//    Result:=Result+' AND [完成日期]<='''+FFilterFinishedEndDate+''' ';
//  end;
//
//  if FFilterStartDate<>'' then
//  begin
//    Result:=Result+' AND [日期]>='''+FFilterStartDate+''' ';
//  end;
//  if FFilterEndDate<>'' then
//  begin
//    Result:=Result+' AND [日期]<='''+FFilterEndDate+''' ';
//  end;
//
//  if Self.edtFilter.Text<>'' then
//  begin
//    Result:=Result+' AND [关键字]='''+Self.edtFilter.Text+''' ';
//  end;
//
//
//  //这个条件不知道为什么在苹果手机上不行，先改SQL语句试下，从SQL语句中去掉这个条件
//  if Self.lvDoorType.Visible
//    and (Self.lvDoorType.Prop.SelectedItem<>nil)
//    and (Self.lvDoorType.Prop.SelectedItem.Caption<>'全部') then
//  begin
//    Result:=Result+' AND [门类型]='+QuotedStr(Self.lvDoorType.Prop.SelectedItem.Caption)+' ';
//  end;
//
//end;
//
//function TFrameWorkImportantList.GetHideFieldListCommaText: String;
//begin
//  Result:='物品编码';
//end;

procedure TFrameWorkImportantList.lbAddListClickItem(AItem: TSkinItem);
begin
  Self.popuAdd.IsOpen:=False;

//  if AItem.Caption='今日已完工' then
//  begin
//    //Self.btnBatchEditClick(nil);
//
//    //今日已完成
//    ShowFrame(TFrame(GlobalCompletedWorkImportantListFrame),TFrameCompletedWorkImportantList);
////    GlobalCompletedWorkImportantListFrame.pnlToolBar.Visible:=False;
//    GlobalCompletedWorkImportantListFrame.btnMore.Visible:=False;
//    GlobalCompletedWorkImportantListFrame.btnBatchEdit.Visible:=False;
//    GlobalCompletedWorkImportantListFrame.lvOrderList.Properties.DefaultItemStyle:='WorkImportant';
////      GlobalCompletedWorkImportantListFrame.FFilterIsBest:='1';
////    if AIsFirstCreate  or (GlobalCompletedWorkImportantListFrame.FUserFID<>GlobalManager.User.fid) then
////    begin
//      GlobalCompletedWorkImportantListFrame.Load('今日已完工',
//                                                    //TFrameUseType.futViewList,
//                                                    '1',
//                                                    FormatDateTime('YYYY-MM-DD',Now),//'',//
//                                                    FormatDateTime('YYYY-MM-DD',Now),//'',//
//                                                    '',
//                                                    '');
////    end;
//
//
//  end;

end;

procedure TFrameWorkImportantList.lbOrderStateClickItem(AItem: TSkinItem);
begin
//  FilterOrderState:=AItem.Name;
//  Self.lvOrderList.Prop.StartPullDownRefresh;
end;

procedure TFrameWorkImportantList.Load(
//                                          ACaption:String;
                                          //AFrameUseType:TFrameUseType;
                                          //AItemButtonCaption:String;
                                          //AFilterCar:String
//                                          AFilterIsFinished:String;
//                                          AFilterFinishedStartDate:String;
//                                          AFilterFinishedEndDate:String;
                                          AFilterStartDate:String;
                                          AFilterEndDate:String
                                          );
var
  ADesc:String;
  ARecordDataJson:ISuperObject;
  ARecordList:ISuperArray;
  I: Integer;
  AListViewItem:TSkinItem;
begin

  Clear;

//  FFrameUseType:=AFrameUseType;


//  FUserFID:=GlobalManager.User.fid;
//
//
//  Self.lvDoorType.Visible:=(lvDoorType.Prop.Items.Count>0) and (GlobalManager.FCurrentDoorType<>'标门');


//  Self.pnlToolbar.Caption:=ACaption;

//  FItemButtonCaption:=GlobalManager.EmployeeJson.S['岗位'];//AItemButtonCaption;
//  Self.cmbProcess.Items.CommaText:=GlobalManager.EmployeeJson.S['岗位'];//
//  if Self.cmbProcess.Items.Count>0 then
//  begin
//    Self.cmbProcess.ItemIndex:=0;
//  end;


//  FFilterIsFinished:=AFilterCar;
//  FFilterIsFinished:=AFilterIsFinished;
//  FFilterFinishedStartDate:=AFilterFinishedStartDate;
//  FFilterFinishedEndDate:=AFilterFinishedEndDate;

//  FFilterStartDate:=AFilterStartDate;
//  FFilterEndDate:=AFilterEndDate;

  btnSelectDateArea.StartDate:=AFilterStartDate;
  btnSelectDateArea.EndDate:=AFilterEndDate;

  ARecordList:=SA();

  ARecordDataJson:=SO();
  ARecordDataJson.S['caption']:='7:10分开早会';
  ARecordDataJson.S['content']:='召齐部门所有人';
  ARecordDataJson.S['createtime']:=StdDateTimeToStr(Now);
  ARecordList.O[ARecordList.Length]:=ARecordDataJson;


  ARecordDataJson:=SO();
  ARecordDataJson.S['caption']:='9:00部门巡视';
  ARecordDataJson.S['createtime']:=StdDateTimeToStr(Now);
  ARecordList.O[ARecordList.Length]:=ARecordDataJson;



          Self.lvOrderList.Prop.Items.BeginUpdate;
          try

            //给图片加上图片服务器
//            AddImageHttpServerUrlToPicPath(ASuperObject.O['Data'].A['RecordList'],ImageHttpServerUrl);

            for I := 0 to ARecordList.Length-1 do
            begin
              ARecordDataJson:=ARecordList.O[I];


              AListViewItem:=TJsonSkinItem.Create;//Self.lvOrderList.Prop.Items.Add;
              Self.lvOrderList.Prop.Items.Add(AListViewItem);
              AListViewItem.Json:=ARecordDataJson;
              AListViewItem.AutoSizeHeight:=True;

//
//              //AListItemStyle:=lvOrderList.Prop.GetItemStyleByItemType(AListViewItem.ItemType);
//              //设置Item的高度
//              //AListItemStyleReg:=GlobalListItemStyleRegList.FindItemByName(AListItemStyle);
//              AListItemStyleReg:=lvOrderList.Prop.FDefaultItemStyleSetting.FListItemStyleReg;
//
//
//              if (AListItemStyleReg<>nil)
//                and (AListItemStyleReg.DefaultItemHeight<>0)
//                and (AListItemStyleReg.DefaultItemHeight<>-1)
//                and not AListItemStyleReg.IsAutoSize then
//              begin
//                AListViewItem.Height:=AListItemStyleReg.DefaultItemHeight;
//              end;
//
//              if //AIsAutoSize or
//                  (AListItemStyleReg<>nil) and AListItemStyleReg.IsAutoSize then
//              begin
//                  //设置自动高度
//                  AListViewItem.Height:=
//                      lvOrderList.Prop.CalcItemAutoSize(AListViewItem).cy;
//              end;


//              AListViewItem.Caption:=AWorkImportant.S['车牌号'];
//
//              AListViewItem.Detail:=AWorkImportant.S['车辆品牌']+' '+AWorkImportant.S['车型'];
//
//              AListViewItem.Detail1:=AWorkImportant.S['联系人'];
//              AListViewItem.Detail2:=AWorkImportant.S['联系电话'];
//
//              AListViewItem.Detail3:=Format('%.2f',[AWorkImportant.F['合计费用']]);
//              AListViewItem.Detail4:=AWorkImportant.S['进厂日期'];
//              AListViewItem.Detail5:=AWorkImportant.S['维修进度'];
//              AListViewItem.Detail6:=AWorkImportant.S['维修单号'];
//
//
//              AListViewItem.SubItems.Add(FItemButtonCaption);

//              if AWorkImportant.S['维修进度']='待派' then
//              begin
//                AListViewItem.SubItems.Add('派工');
//              end
//              else if AWorkImportant.S['维修进度']='已派工' then
//              begin
//                AListViewItem.SubItems.Add('领料');
//              end
//              else
//              begin
//                AListViewItem.SubItems.Add('查看');
//              end;

            end;

          finally
            Self.lvOrderList.Prop.Items.EndUpdate();
          end;


//          for I := 0 to Self.lvOrderList.Prop.Items.Count-1 do
//          begin
//            Self.lvOrderList.Prop.Items[I].DoPropChange(Self.lvOrderList.Prop.Items[I]);
//          end;
          Self.lvOrderList.Prop.SetItemsAutoSize;

//  for I := 0 to 2 do

//        AFrame.lblItemCaption.StaticCaption:=ADataJson.S['caption'];
//      if ADataJson.S['content']<>'' then
//      begin
//        AFrame.lblItemDetail.StaticCaption:='备注:'+ADataJson.S['content'];
//      end
//      else
//      begin
//        AFrame.lblItemDetail.StaticCaption:='';
//      end;
//
//
//      if ADataJson.I['is_best']=0 then
//      begin
//         //未完成
//        AFrame.chkIndex.StaticCaption:=IntToStr(AItem.Index+1);//FloatToStr(ADataJson.F['orderno']);
//        AFrame.chkIndex.Properties.StaticChecked:=False;
//
//        AFrame.lblItemCaption.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Black;
//        AFrame.lblItemCaption.Material.DrawCaptionParam.FontStyle:=[];
//
//        //如果日期是当天,岗位是自己的岗位,那么需要有完成的按钮，否则就不显示
//        AFrame.btnComplete.Visible:=//(Self.FFilterStartDate=Self.FFilterEndDate)
//  //                                  and (Self.FFilterStartDate=FormatDateTime('YYYY-MM-DD',Now))
//                                    //and
//                                    (Copy(ADataJson.S['createtime'],1,10)=FormatDateTime('YYYY-MM-DD',Now))
//                                    and (ADataJson.S['process']=GlobalManager.CurrentProcess);
//


//  case FFrameUseType of
//    futManage:
//    begin
//      Self.btnReturn.Visible:=False;
//      Self.lbOrderState.Visible:=True;
//    end;
//    futSelectList:
//    begin
//      Self.btnReturn.Visible:=True;
//      Self.lbOrderState.Visible:=False;
//
//    end;
//    futViewList:
//    begin
//      Self.btnReturn.Visible:=True;
//      Self.lbOrderState.Visible:=False;
//    end;
//  end;


//  if GlobalManager.WorkImportantListItemStyle<>'' then
//  begin
//    Self.lvOrderList.Prop.FDefaultItemStyleSetting.FStyleRootUrl:=ImageHttpServerUrl+'/Upload/'
//                                        +'list_item_style/door_manage/'+'WorkImportantList/';
//    Self.lvOrderList.Prop.FDefaultItemStyleSetting.FStyle:=GlobalManager.WorkImportantListItemStyle;
//    Self.lvOrderList.Prop.FDefaultItemStyleSetting.IsUseUrlStyle:=True;
//  end;


//  //加载
//  Self.lvOrderList.Prop.StartPullDownRefresh;
end;

procedure TFrameWorkImportantList.lvCalendarClickItem(Sender: TSkinItem);
begin
  TSkinItem(Sender).Selected:=True;

  Self.btnSelectDateArea.StartDate:=Sender.Detail1;
  Self.btnSelectDateArea.EndDate:=Sender.Detail1;

//  Self.FPageIndex:=1;
//  Self.tteGetWorkImportantList.Run();
end;

procedure TFrameWorkImportantList.lvDoorTypeClickItem(AItem: TSkinItem);
begin
  Self.FPageIndex:=1;
  Self.tteGetWorkImportantList.Run();
end;

procedure TFrameWorkImportantList.lvOrderListClickItem(AItem: TSkinItem);
//var
//  AWaitPostWorkImportant:ISuperObject;
begin
//  AWaitPostWorkImportant:=TSuperObject.Create(Self.lvOrderList.Prop.InteractiveItem.DataJsonStr);

//  if Self.btnBatchEdit.Visible then
//  begin
      //非批处理模式

//      //显示工单详情
//      HideFrame;
//      ShowFrame(TFrame(GlobalYieldTaskOrderInfoFrame),TFrameYieldTaskOrderInfo,DoReturnFrameFromYieldTaskOrderInfoFrame);
//      GlobalYieldTaskOrderInfoFrame.Load(AItem.Json);

//  end
//  else
//  begin
//      //
//
//
//  end;
//

end;

procedure TFrameWorkImportantList.lvOrderListClickItemDesignerPanelChild(
  Sender: TObject; AItem: TBaseSkinItem;
  AItemDesignerPanel: TSkinFMXItemDesignerPanel; AChild: TFmxObject);
//var
//  AWaitPostWorkImportant:ISuperObject;
//  ASenderButton:TSkinFMXButton;
//  AContentJson:ISuperObject;
//  AIndex:Integer;
//var
//  APicPathList:TStringList;
//  ABindItemFieldName:String;
begin
//  if AChild.Name='btnComplete' then
//  begin
//      //完成
//      HideFrame(Self);
//
//      ShowFrame(TFrame(GlobalAddContentFrame),TFrameCompleteWorkImportant,DoReturnFrameFromCompleteWorkImportantFrame);
//      GlobalAddContentFrame.Load(cptProblem);
//      GlobalAddContentFrame.edtCaption.Text:=TSkinItem(AItem).Json.S['caption'];
//      GlobalAddContentFrame.pnlCaption.Enabled:=False;//不能编辑这个东西
//
//      GlobalAddContentFrame.pnlToolBar.Caption:='完成工作重点';
//      GlobalAddContentFrame.btnOK.Caption:='提交';
////      GlobalAddContentFrame.pnlCaption.Visible:=False;
//      GlobalAddContentFrame.pnlTags.Visible:=False;
//      GlobalAddContentFrame.pnlSelectBigType.Visible:=False;
//      GlobalAddContentFrame.pnlTopics.Visible:=False;
//      GlobalAddContentFrame.pnlSelectContentType.Visible:=False;
//      GlobalAddContentFrame.imgVideoUpLoad.Visible:=False;
//      GlobalAddContentFrame.imgCamera.Visible:=False;
//      GlobalAddContentFrame.pnlBottom.Visible:=False;
////      GlobalAddContentFrame.Fbill_no:=FYieldTaskOrder.S['单据编码'];
//
//
//    //  //加入选择需要协助处理的工序列表,可以多选
//    //  GlobalAddContentFrame.btnSelectCustom.Visible:=True;
//    //  GlobalAddContentFrame.btnSelectCustom.Visible:=True;
////      cptProblem:
////      begin
////        Self.pnlToolBar.Caption:='问题上报';
////        Self.pnlCaption.Visible:=True;
////
////        Self.btnSelectBigType.Caption:= '工序异常';
////        Self.btnSelectBigType.TagString:= 'yieldtask_process_task_exception';
////
////        Self.pnlSelectContentType.Visible:=True;
////
////      end;
//
//      GlobalAddContentFrame.OnCustomPostedContentJson:=Self.DoCustomPostedContentJson;
//      GlobalAddContentFrame.OnCustomCheckInput:=DoCustomCheckInput;
//
//
//
////      Self.lvOrderList.Prop.InteractiveItem.Selected:=True;
////      AWaitPostWorkImportant:=Self.lvOrderList.Prop.InteractiveItem.Json;
////      ASenderButton:=TSkinFMXButton(AChild);
//
//
//
//    //  if ASenderButton.Caption='查看' then
//    //  begin
//    //    //显示工单详情
//    //    HideFrame(CurrentFrame);
//    //    ShowFrame(TFrame(GlobalWorkImportantInfoFrame),TFrameWorkImportantInfo);
//    //    GlobalWorkImportantInfoFrame.Clear;
//    //    GlobalWorkImportantInfoFrame.Load(AWaitPostWorkImportant);
//    //  end;
//    //
//    //  if ASenderButton.Caption='派工' then
//    //  begin
//    //      //在待派工单列表中选择某一单
//    //      HideFrame(CurrentFrame);
//    //      ShowFrame(TFrame(GlobalDispatchWorkFrame),TFrameDispatchWork,DoReturnFrameFromDispatchWork);
//    //      GlobalDispatchWorkFrame.Clear;
//    //      GlobalDispatchWorkFrame.Load(AWaitPostWorkImportant);
//    //  end;
//    //
//    //  if ASenderButton.Caption='领料' then
//    //  begin
//    //      //在待领料单列表中选择某一单
//    //      HideFrame(CurrentFrame);
//    //      ShowFrame(TFrame(GlobalPickMaterialFrame),TFramePickMaterial,DoReturnFrameFromPickMaterial);
//    //      GlobalPickMaterialFrame.Clear;
//    //      GlobalPickMaterialFrame.Load(AWaitPostWorkImportant);
//    //  end;
//
////      if ASenderButton.Caption='完成' then
////      begin
//
//
//
////          Self.tteCompleteWorkImportant.Run;
//
////          //在待验收单列表中选择某一单
////          //显示修改维修项目的对话框
////          if GlobalCheckWorkImportantFrame=nil then
////          begin
////            GlobalCheckWorkImportantFrame:=TFrameCheckWorkImportant.Create(Application);
////            GlobalCheckWorkImportantFrame.pnlToolBar.Visible:=False;
////          end;
////          GlobalCheckWorkImportantFrame.Clear;
////          GlobalCheckWorkImportantFrame.Height:=GlobalCheckWorkImportantFrame.sbcClient.Height;
////
////          //加载数据
////          GlobalCheckWorkImportantFrame.LoadFromJson(AWaitPostWorkImportant);
////
////          msgboxCheckWorkImportant.CustomControl:=GlobalCheckWorkImportantFrame;
//
////          msgboxCheckWorkImportant.Msg:='确认完成'+GlobalManager.EmployeeJson.S['岗位']+'吗?';
////          msgboxCheckWorkImportant.ShowMessageBox;
//
//
////        if GlobalManager.FCurrentDoorType='标门' then
////        begin
////  //      if (GlobalManager.GetSysMemory('管控左右数量')='是') or (GlobalManager.GetSysMemory('报工需要确认')='是') then
////  //      begin
////          HideFrame;
////          ShowFrame(TFrame(GlobalCompleteWorkImportantConfirmFrame),TFrameCompleteWorkImportantConfirm,DoReturnFrameFromCompleteWorkImportantConfirmFrame);
////          GlobalCompleteWorkImportantConfirmFrame.Load(AWaitPostWorkImportant);
////          Exit;
////  //      end;
////        end
////        else
////        begin
////          Self.tteCompleteWorkImportant.Run;
////        end;
//
//
//
////      end;
//
//  end;

//  //点击图片显示大图
//  if (AChild.Name='imgItemBigPic') or (AChild.Name='imgItemBigPic2') or (AChild.Name='imgItemBigPic3') then
//  begin
//          AIndex:=0;
//          if AChild.Name='imgItemBigPic2' then
//          begin
//            AIndex:=1;
//          end;
//          if AChild.Name='imgItemBigPic3' then
//          begin
//            AIndex:=2;
//          end;
//
//          AContentJson:=TSkinItem(AItem).Json;
//          //查看图片详情
//          //查看照片信息
//          HideFrame;//(CurrentFrame);
//          //查看照片信息
//          ShowFrame(TFrame(GlobalViewPictureListFrame),TFrameViewPictureList);//,frmMain,nil,nil,nil);
//          GlobalViewPictureListFrame.Init('异常照片',
//                nil,
//                0,
//                //原图URL
//                nil
//                );
//          if AContentJson.S['pic1_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(AContentJson.S['pic1_path'],''));
//          end;
//          if AContentJson.S['pic2_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(AContentJson.S['pic2_path'],''));
//          end;
//          if AContentJson.S['pic3_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(AContentJson.S['pic3_path'],''));
//          end;
//          if AContentJson.S['pic4_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(AContentJson.S['pic4_path'],''));
//          end;
//          if AContentJson.S['pic5_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(AContentJson.S['pic5_path'],''));
//          end;
//          if AContentJson.S['pic6_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(AContentJson.S['pic6_path'],''));
//          end;
//          if AContentJson.S['pic7_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(AContentJson.S['pic7_path'],''));
//          end;
//          if AContentJson.S['pic8_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(AContentJson.S['pic8_path'],''));
//          end;
//          if AContentJson.S['pic9_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(AContentJson.S['pic9_path'],''));
//          end;
//          GlobalViewPictureListFrame.ShowPicture('异常照片',AIndex);
//
//  end;
//
//  //点击图片,查看大图
//  if AChild is TSkinFMXImage then
//  begin
//      ABindItemFieldName:=TSkinFMXImage(AChild).BindItemFieldName;
//      if Pos('order_pic',ABindItemFieldName)>0 then//'order_pic1_path'
//      begin
//
//          //判断当前点击的是第几张图片
//          AIndex:=0;
//          if Pos('2',ABindItemFieldName)>0 then AIndex:=1;
//          if Pos('3',ABindItemFieldName)>0 then AIndex:=2;
//          if Pos('4',ABindItemFieldName)>0 then AIndex:=3;
//          if Pos('5',ABindItemFieldName)>0 then AIndex:=4;
//
//
//
//          //查看图片详情
//          //查看照片信息
//          HideFrame;//(CurrentFrame);
//          //查看照片信息
//          ShowFrame(TFrame(GlobalViewPictureListFrame),TFrameViewPictureList);//,frmMain,nil,nil,nil);
//          GlobalViewPictureListFrame.Init('订单图片',
//                                          nil,
//                                          0,
//                                          //原图URL
//                                          nil
//                                          );
//          if TSkinItem(AItem).Json.S['order_pic1_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(
//              uPageStructure.GetImageUrl(ReplaceStr(TSkinItem(AItem).Json.S['order_pic1_path'],THUMB_FILE_PREFIX,''),''),
//              TSkinItem(AItem).Json.S['订单图片1备注']
//              );
//          end;
//          if TSkinItem(AItem).Json.S['order_pic2_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(uPageStructure.GetImageUrl(ReplaceStr(TSkinItem(AItem).Json.S['order_pic2_path'],THUMB_FILE_PREFIX,''),''),
//              TSkinItem(AItem).Json.S['订单图片2备注']
//              );
//          end;
//          if TSkinItem(AItem).Json.S['order_pic3_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(uPageStructure.GetImageUrl(ReplaceStr(TSkinItem(AItem).Json.S['order_pic3_path'],THUMB_FILE_PREFIX,''),''),
//              TSkinItem(AItem).Json.S['订单图片3备注']
//              );
//          end;
//          if TSkinItem(AItem).Json.S['order_pic4_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(uPageStructure.GetImageUrl(ReplaceStr(TSkinItem(AItem).Json.S['order_pic4_path'],THUMB_FILE_PREFIX,''),''),
//              TSkinItem(AItem).Json.S['订单图片4备注']
//              );
//          end;
//          if TSkinItem(AItem).Json.S['order_pic5_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(uPageStructure.GetImageUrl(ReplaceStr(TSkinItem(AItem).Json.S['order_pic5_path'],THUMB_FILE_PREFIX,''),''),
//              TSkinItem(AItem).Json.S['订单图片5备注']
//              );
//          end;
//          GlobalViewPictureListFrame.ShowPicture('订单图片',AIndex);
//
//
//      end;
//
//  end;


  if AChild.Name='chkItemSelected' then
  begin
    AItem.Selected:= not AItem.Selected;

    //更新选择的数量
    SyncSelectedCount;

  end;
end;

procedure TFrameWorkImportantList.lvOrderListNewListItemStyleFrameCacheInit(
  Sender: TObject; AListItemTypeStyleSetting: TListItemTypeStyleSetting;
  ANewListItemStyleFrameCache: TListItemStyleFrameCache);
var
  AFrame:TFrameWorkImportantListItemStyle;
begin
  if ANewListItemStyleFrameCache.FItemStyleFrame is TFrameWorkImportantListItemStyle then
  begin
    AFrame:=TFrameWorkImportantListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame);

//    AFrame.lblItemCaption.BindItemFieldName:='caption';
//    AFrame..BindItemFieldName:='caption';

//    AFrame.FPage:=FItemStylePage;
//
//
//    //隐藏已经在设计面板上拖好的字段
//    //在FItemStylePage中将已经绑定的字段隐藏
//    HideControlInItemDesignerPanelByPage(Self.FItemStylePage,AFrame.ItemDesignerPanel);
//
  end;
end;

procedure TFrameWorkImportantList.lvOrderListPrepareDrawItem(Sender: TObject;
  ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
  AItem: TSkinItem; AItemDrawRect: TRect);
//var
////  btnComplete:TSkinButton;
////  imgError:TSkinImage;
////  chkItemSelected:TSkinCheckBox;
////  labErrorHint:TSkinLabel;
////  lblBillNO:TSkinLabel;
////  lblCompleteTime:TSkinLabel;
//
////  lblSchedule:TSkinLabel;
////  pnlDetail:TSkinPanel;
////  lblError:TSkinLabel;
//  AFrame:TFrameListItemStyle_WorkImportant;
var
  ADataJson:ISuperObject;
  AFrame:TFrameWorkImportantListItemStyle;
begin

  if AItemDesignerPanel=nil then
  begin
    Exit;
  end;

  ADataJson:=AItem.Json;

  if AItemDesignerPanel.Parent is TFrameWorkImportantListItemStyle then
  begin
      AFrame:=TFrameWorkImportantListItemStyle(AItemDesignerPanel.Parent);


      AFrame.lblItemCaption.StaticCaption:=ADataJson.S['caption'];
      if ADataJson.S['content']<>'' then
      begin
        AFrame.lblItemDetail.StaticCaption:='备注:'+ADataJson.S['content'];
      end
      else
      begin
        AFrame.lblItemDetail.StaticCaption:='';
      end;


      if ADataJson.I['is_best']=0 then
      begin
         //未完成
        AFrame.chkIndex.StaticCaption:=IntToStr(AItem.Index+1);//FloatToStr(ADataJson.F['orderno']);
        AFrame.chkIndex.Properties.StaticChecked:=False;

        AFrame.lblItemCaption.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Black;
        AFrame.lblItemCaption.Material.DrawCaptionParam.FontStyle:=[];

        //如果日期是当天,岗位是自己的岗位,那么需要有完成的按钮，否则就不显示
        AFrame.btnComplete.Visible:=//(Self.FFilterStartDate=Self.FFilterEndDate)
  //                                  and (Self.FFilterStartDate=FormatDateTime('YYYY-MM-DD',Now))
                                    //and
                                    (Copy(ADataJson.S['createtime'],1,10)=FormatDateTime('YYYY-MM-DD',Now))
                                    and (ADataJson.S['process']=GlobalManager.CurrentProcess);


        AFrame.imgCompleted.Visible:=False;
        AFrame.lblCreateDate.Visible:=False;

      end
      else
      begin
        //已完成
        AFrame.chkIndex.StaticCaption:='';
        AFrame.chkIndex.Properties.StaticChecked:=True;

        AFrame.lblItemCaption.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Gray;
        AFrame.lblItemCaption.Material.DrawCaptionParam.FontStyle:=[TFontStyle.fsStrikeOut];


        AFrame.btnComplete.Visible:=False;
        AFrame.imgCompleted.Visible:=True;

        AFrame.lblCreateDate.Visible:=True;
//        //谁完成的
//        if ADataJson.S['user_fid']=GlobalManager.User.fid then
//        begin
          //自己完成的
          AFrame.lblCreateDate.Caption:=Copy(ADataJson.S['createtime'],6,11);
//        end
//        else
//        begin
//          //别人完成的
//          AFrame.lblCreateDate.Caption:=ADataJson.S['user_name']+' '+Copy(ADataJson.S['createtime'],6,11);
//        end;


      end;

  end;

//  if AItemDesignerPanel.Parent is TFrameListItemStyle_WorkImportant then
//  begin
//    AFrame:=TFrameListItemStyle_WorkImportant(AItemDesignerPanel.Parent);
//
////    btnComplete:=TSkinButton(AItemDesignerPanel.Parent.FindComponent('btnComplete'));
////    imgError:=TSkinImage(AItemDesignerPanel.Parent.FindComponent('imgError'));
////    chkItemSelected:=TSkinCheckBox(AItemDesignerPanel.Parent.FindComponent('chkItemSelected'));
////    labErrorHint:=TSkinLabel(AItemDesignerPanel.Parent.FindComponent('labErrorHint'));
////    lblBillNO:=TSkinLabel(AItemDesignerPanel.Parent.FindComponent('lblBillNO'));
////    lblCompleteTime:=TSkinLabel(AItemDesignerPanel.Parent.FindComponent('lblCompleteTime'));
//
////    lblSchedule:=TSkinLabel(AItemDesignerPanel.Parent.FindComponent('lblSchedule'));
////    pnlDetail:=TSkinPanel(AItemDesignerPanel.Parent.FindComponent('pnlDetail'));
////    lblError:=TSkinLabel(AItemDesignerPanel.Parent.FindComponent('lblError'));
//
//
//    if AFrame.btnComplete<>nil then
//    begin
//      AFrame.btnComplete.Caption:=GlobalManager.CurrentProcess;//Self.cmbProcess.Text;//FItemButtonCaption;
////      AFrame.btnComplete.Visible:=(btnBatchEdit.Visible and not AItem.Json.B['完成否']);
//      AFrame.btnComplete.Visible:=(GlobalManager.CurrentProcess<>'') and (Self.FFilterIsFinished='0');//(not AItem.Json.B['完成否']);
//    end;
//
//    if AFrame.lblCompleteTime<>nil then
//    begin
//      AFrame.lblCompleteTime.Visible:=(Self.FFilterIsFinished='1');//(AItem.Json.B['完成否']);
//    end;
//
//    if AItem.Json.S['ifError'] = '1' then
//    begin
//      if AFrame.lblBillNO<>nil then
//      begin
//        if AItem.Json.S['ErrorReply'] = '1' then
//        begin
//          AFrame.lblBillNO.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Orange;
//        end
//        else
//        begin
//          AFrame.lblBillNO.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Red;
//        end;
//        AFrame.lblBillNO.Material.DrawCaptionParam.FontStyle:=[TFontStyle.fsBold];
//      end;
//    end
//    else
//    begin
//      if AFrame.lblBillNO<>nil then
//      begin
//        AFrame.lblBillNO.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Black;
//        AFrame.lblBillNO.Material.DrawCaptionParam.FontStyle:=[];
//      end;
//    end;
//    if AFrame.imgError<>nil then AFrame.imgError.Visible:=AItem.Json.S['ifError'] = '1';
//    if AFrame.labErrorHint<>nil then AFrame.labErrorHint.Visible:=AItem.Json.S['ifError'] = '1';
//
//    if AFrame.chkItemSelected<>nil then AFrame.chkItemSelected.Visible:=not btnBatchEdit.Visible and Self.pnlBottom.Visible;
//    if AFrame.chkItemSelected.Visible then
//    begin
//      AFrame.lblBillNO.Left:=AFrame.chkItemSelected.Left+AFrame.chkItemSelected.Width+10;
//    end
//    else
//    begin
//      AFrame.lblBillNO.Left:=AFrame.chkItemSelected.Left;
//    end;
//
//
//    AFrame.imgItemBigPic.Visible:=AItem.Json.S['pic1_path']<>'';
//    AFrame.imgItemBigPic2.Visible:=AItem.Json.S['pic2_path']<>'';
//    AFrame.imgItemBigPic3.Visible:=AItem.Json.S['pic3_path']<>'';
//
//    AFrame.imgItemBigPic.Position.Y:=
//          AFrame.pnlPageInstanceParent.Position.Y
//          +AFrame.pnlPageInstanceParent.Height
//          +5;
//    AFrame.imgItemBigPic2.Position.Y:=AFrame.imgItemBigPic.Position.Y;
//    AFrame.imgItemBigPic3.Position.Y:=AFrame.imgItemBigPic.Position.Y;
//
//
//
//
//
////    if (lblBillNO<>nil)
////      and (lblSchedule<>nil)
////      and (pnlDetail<>nil)
////      and (lblError<>nil) then
////    begin
////      lblBillNO.Position.Y:=0;
////      lblSchedule.Position.Y:=
////              lblSchedule.Margins.Top
////              +lblBillNO.Position.Y
////              +lblBillNO.Height;
////      pnlDetail.Position.Y:=
////              pnlDetail.Margins.Top
////              +lblSchedule.Position.Y
////              +lblSchedule.Height;
////      lblError.Position.Y:=
////              lblError.Margins.Top
////              +pnlDetail.Position.Y
////              +pnlDetail.Height;
////    end;
//
//
//
//    //      //编辑状态显示选中框
//  //      Self.chkOrderItemSelected.Visible:=True;
//
//  //  Self.btnButton1.Visible:=False;
//  //  Self.SkinFMXButton1.Visible:=False;
//  //
//  //  Self.btnButton2.Visible:=False;
//  //  Self.SkinFMXButton2.Visible:=False;
//  //
//  //  if AItem.Detail5='待派' then
//  //  begin
//  //    Self.btnButton1.Caption:='派工';
//  //    Self.SkinFMXButton1.Caption:='派工';
//  //
//  //    Self.btnButton1.Visible:=True;
//  //    Self.SkinFMXButton1.Visible:=True;
//  //
//  //
//  //    SkinFMXLabel22.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Orange;
//  //    lblItemOrderState.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Orange;
//  //  end
//  //  else
//  //  if AItem.Detail5='已派工' then
//  //  begin
//  //
//  //    Self.btnButton2.Caption:='领料';
//  //    Self.SkinFMXButton2.Caption:='领料';
//  //
//  //    Self.btnButton2.Visible:=True;
//  //    Self.SkinFMXButton2.Visible:=True;
//  //
//  //
//  //    Self.btnButton1.Caption:='验收';
//  //    Self.SkinFMXButton1.Caption:='验收';
//  //
//  //    Self.btnButton1.Visible:=True;
//  //    Self.SkinFMXButton1.Visible:=True;
//  //
//  //
//  //    SkinFMXLabel22.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Red;
//  //    lblItemOrderState.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Red;
//  //  end
//  //  else
//  //  begin
//  //
//  //    SkinFMXLabel22.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Blue;
//  //    lblItemOrderState.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Blue;
//  //  end;
//
//
//  end;

end;

procedure TFrameWorkImportantList.lvOrderListPullDownRefresh(
  Sender: TObject);
begin
  FPageIndex:=1;
  Self.tteGetWorkImportantList.Run;

//  if GlobalMainFrame.FProcessTaskManageFrame<>nil then
//  begin
//    Self.tteGetProcessTaskCount.Run;
//  end;
end;

procedure TFrameWorkImportantList.lvOrderListPullUpLoadMore(
  Sender: TObject);
begin
  FPageIndex:=FPageIndex+1;
  Self.tteGetWorkImportantList.Run;

//  if GlobalMainFrame.FProcessTaskManageFrame<>nil then
//  begin
//    Self.tteGetProcessTaskCount.Run;
//  end;
end;

procedure TFrameWorkImportantList.msgboxCheckWorkImportantCanModalResult(
  Sender: TObject;
  AModalResult:String;
  AModalResultName:String;
  var AIsCanModalResult: Boolean);
begin
//  //是否可以关闭对话框
//  if SameText(TFrameMessageBox(Sender).ModalResultName,'ok') then
//  begin
//    //检查参数
//    if not GlobalCheckWorkImportantFrame.Check then
//    begin
//      //检查不通过,不关闭对话框
//      AIsCanModalResult:=False;
//    end
//    else
//    begin
//      //检查通过,可以关闭对话框了
//    end;
//  end;
end;

procedure TFrameWorkImportantList.msgboxCheckWorkImportantModalResult(
  Sender: TObject);
begin
  //关闭了对话框
  if SameText(TFrameMessageBox(Sender).ModalResultName,'ok') then
  begin
    //调用验收接口
    //Self.FCompleteJson:=GlobalCheckWorkImportantFrame.SaveToJson;
    Self.tteCompleteWorkImportant.Run;
  end;
end;

procedure TFrameWorkImportantList.SyncSelectedCount;
var
  ASelectedCount:Integer;
begin
  ASelectedCount:=Self.lvOrderList.Prop.Items.SelectedCount;
  Self.lblSelectedCount.Caption:='已选'+IntToStr(ASelectedCount)+'条';
  Self.lblSelectedCount.Visible:=pnlBottom.Visible;// and (ASelectedCount>0);
end;

procedure TFrameWorkImportantList.tmrFilterChangeTrackingTimer(
  Sender: TObject);
begin

  FPageIndex:=1;
  Self.tteGetWorkImportantList.Run();

  tmrFilterChangeTracking.Enabled:=False;

end;

procedure TFrameWorkImportantList.tteCompleteWorkImportantBegin(
  ATimerTask: TTimerTask);
begin
  //
  ShowWaitingFrame(Self,'保存中...');
end;

procedure TFrameWorkImportantList.tteCompleteWorkImportantExecute(
  ATimerTask: TTimerTask);
var
  I: Integer;
  ASuperObject:ISuperObject;
  ASuperArray:ISuperArray;
  APostStream:TStringStream;
begin
  try
    ATimerTask.TaskTag:=TASK_FAIL;

    ASuperArray:=TSuperArray.Create();
    for I := 0 to Self.lvOrderList.Prop.Items.Count-1 do
    begin
      if Self.lvOrderList.Prop.Items[I].Selected then
      begin
        ASuperObject:=TSuperObject.Create();
        ASuperObject.S['bill_no']:=Self.lvOrderList.Prop.Items[I].Json.S['单据编码'];
        ASuperObject.I['number']:=Self.lvOrderList.Prop.Items[I].Json.I['数量'];
        ASuperArray.O[ASuperArray.Length]:=ASuperObject;
      end;

    end;


//    TTimerTask(ATimerTask).TaskDesc:=
//        SimpleCallAPIPostString('arrange_yieldtask_bill',
//                      nil,
//                      DoorManageInterfaceUrl,
//                      ['appid','user_fid','key',
//                      'bill_no',
//                      'action'],
//                      [AppID,
//                      GlobalManager.User.fid,
//                      '',
//                      '1RW-21-2-01',
//                      'new'
//                      ],
//                      GlobalRestAPISignType,
//                      GlobalRestAPIAppSecret
//                      );



    TTimerTask(ATimerTask).TaskDesc:=
        SimpleCallAPIPostString('batch_complete_process_task',
                      nil,
                      DoorManageInterfaceUrl,
                      ['appid','user_fid','key',
                      //'bill_no',
                      'process',
                      //'number',
                      'remark','pic1_path'],
                      [AppID,
                      GlobalManager.User.fid,
                      '',

                      //生产任务单号
                      //Self.lvOrderList.Prop.InteractiveItem.Json.S['单据编码'],
                      GlobalManager.CurrentProcess,//Self.cmbProcess.Text,//GlobalManager.EmployeeJson.S['岗位'],
                      //Self.lvOrderList.Prop.InteractiveItem.Json.I['数量'],
                      '',
                      ''
                      ],
                      GlobalRestAPISignType,
                      GlobalRestAPIAppSecret,
                      True,
                      ASuperArray.AsJSON
                      );





      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;


  except
    on E:Exception do
    begin
      ATimerTask.TaskDesc:=E.Message;
    end;
  end;
end;

procedure TFrameWorkImportantList.tteCompleteWorkImportantExecuteEnd(
  ATimerTask: TTimerTask);
var
  ASkinItem:TSkinItem;
  ASuperObject:ISuperObject;
  I: Integer;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

        ShowHintFrame(Self,'保存成功!');


        Self.lvOrderList.Prop.Items.BeginUpdate;
        try
          for I := Self.lvOrderList.Prop.Items.Count-1 downto 0 do
          begin
            if (Self.lvOrderList.Prop.Items[I].Selected) and (Self.Parent.Name <> 'tsError') then
            begin
              Self.lvOrderList.Prop.Items.Remove(Self.lvOrderList.Prop.Items[I]);
            end;
          end;
        finally
          Self.lvOrderList.Prop.Items.EndUpdate();
        end;



//        btnBatchCancelClick(nil);

//        //找到该工单,然后删除
//        ASkinItem:=Self.lvOrderList.Prop.Items.FindItemByDetail6(
//            Self.FCompleteJson.S['维修单号']);
//
//        if ASkinItem<>nil then
//        begin
//          Self.lvOrderList.Prop.Items.Remove(ASkinItem);
//        end;

//        HideFrame(Self);
//        ReturnFrame(Self);

      end
      else
      begin
        //验收失败
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

procedure TFrameWorkImportantList.tteGetProcessListExecute(
  ATimerTask: TTimerTask);
//var
//  ADesc:String;
//  AIsUsedCache:Boolean;
begin

  try
      //出错
      TTimerTask(ATimerTask).TaskTag:=1;


       TTimerTask(ATimerTask).TaskDesc :=SimpleCallAPI('get_work_important_process_list',
                                                  nil,
                                                  DoorManageInterfaceUrl,
                                                  ['appid',
                                                  'user_fid',
                                                  'key'
                                                  ],
                                                  [AppID,
                                                  GlobalManager.User.fid,
                                                  GlobalManager.User.key
                                                  ],
                                                  GlobalRestAPISignType,
                                                  GlobalRestAPIAppSecret
                                                  );

    if TTimerTask(ATimerTask).TaskDesc<>'' then
    begin
      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
    end;

  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;


end;

procedure TFrameWorkImportantList.tteGetProcessListExecuteEnd(
  ATimerTask: TTimerTask);
var
  I: Integer;
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

          //DoScanResultEvent是在线程中执行的。
          Self.cmbProcess.OnChange:=nil;
          try
        //    Self.cmbProcess.Items.Clear;
            //先加入自己的岗位
            //Self.cmbProcess.Items.CommaText:=GlobalManager.EmployeeJson.S['岗位'];

            //看看操作员有没有查看其他岗位的权限
        //    if GlobalManager.HasPower('允许查看全部岗位的工作重点') then
        //    begin
        //
        //      //再加入所有的岗位
        //      for I := 0 to GlobalManager.ProcessArray.Length-1 do
        //      begin
        //        Self.cmbProcess.Items.Add(GlobalManager.ProcessArray.O[I].S['值的值']);
        //      end;
        //
        //    end;

            for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
            begin
              if Self.cmbProcess.Items.IndexOf(ASuperObject.O['Data'].A['RecordList'].O[I].S['工作岗位'])=-1 then
              begin
                Self.cmbProcess.Items.Add(ASuperObject.O['Data'].A['RecordList'].O[I].S['工作岗位']);
              end;
            end;


            //Self.cmbProcess.ItemIndex:=0;
          finally
            Self.cmbProcess.OnChange:=cmbProcessChange;
          end;

          Self.pnlProcess.Visible:=(Self.cmbProcess.Items.Count>0);

      end
      else
      begin
        //获取订单列表失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin
      //网络异常
      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
    end;
  finally

  end;

end;

procedure TFrameWorkImportantList.tteGetWorkImportantListExecute(
  Sender: TTimerTask);
//var
//  ADesc:String;
//  AIsUsedCache:Boolean;
begin

  try
      //出错
      TTimerTask(Sender).TaskTag:=1;


       TTimerTask(Sender).TaskDesc :=SimpleCallAPI('get_process_work_important_list',
                                                  nil,
                                                  DoorManageInterfaceUrl,
                                                  ['appid',
                                                  'user_fid',
                                                  'key',
                                                  'process',
                                                  'filter_start_date',
                                                  'filter_end_date',
                                                  'pageindex',
                                                  'pagesize',
                                                  'power'
                                                  ],
                                                  [AppID,
                                                  GlobalManager.User.fid,
                                                  GlobalManager.User.key,
                                                  cmbProcess.Text,//GlobalManager.CurrentProcess,
                                                  btnSelectDateArea.StartDate,//FFilterStartDate,//'',//btnSelectDateArea.StartDate,
                                                  btnSelectDateArea.EndDate,//FFilterEndDate,//'',//btnSelectDateArea.EndDate,
                                                  FPageIndex,
                                                  20,
                                                  GlobalManager.EmployeeJson.S['权限']
                                                  ],
                                                  GlobalRestAPISignType,
                                                  GlobalRestAPIAppSecret
                                                  );

    if TTimerTask(Sender).TaskDesc<>'' then
    begin
      TTimerTask(Sender).TaskTag:=TASK_SUCC;
    end;

  except
    on E:Exception do
    begin
      //异常
      TTimerTask(Sender).TaskDesc:=E.Message;
    end;
  end;
end;

procedure TFrameWorkImportantList.tteGetWorkImportantListExecuteEnd(
  Sender: TTimerTask);
var
  I: Integer;
  AListViewItem:TJsonSkinItem;
  ASuperObject:ISuperObject;
  AWorkImportant:ISuperObject;
  AListItemStyle:String;
  AListItemStyleReg:TListItemStyleReg;
begin
  try
    if TTimerTask(Sender).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(Sender).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

          Self.lvOrderList.Prop.Items.BeginUpdate;
          try
            if FPageIndex=1 then
            begin
              Self.lvOrderList.Prop.Items.ClearItemsByType(sitDefault);

//              //根据字段,创建PageStructure
//              if FItemStylePage=nil then
//              begin
//                FItemStylePage:=TPage.Create(Self);
//                LoadPageByFieldList(FItemStylePage,ASuperObject.O['Data'].A['FieldList'],GetHideFieldListCommaText);
//              end;

            end;

            //给图片加上图片服务器
//            AddImageHttpServerUrlToPicPath(ASuperObject.O['Data'].A['RecordList'],ImageHttpServerUrl);

            for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
            begin
              AWorkImportant:=ASuperObject.O['Data'].A['RecordList'].O[I];


              AListViewItem:=TJsonSkinItem.Create;//Self.lvOrderList.Prop.Items.Add;
              Self.lvOrderList.Prop.Items.Add(AListViewItem);
              AListViewItem.Json:=AWorkImportant;
              AListViewItem.AutoSizeHeight:=True;

//
//              //AListItemStyle:=lvOrderList.Prop.GetItemStyleByItemType(AListViewItem.ItemType);
//              //设置Item的高度
//              //AListItemStyleReg:=GlobalListItemStyleRegList.FindItemByName(AListItemStyle);
//              AListItemStyleReg:=lvOrderList.Prop.FDefaultItemStyleSetting.FListItemStyleReg;
//
//
//              if (AListItemStyleReg<>nil)
//                and (AListItemStyleReg.DefaultItemHeight<>0)
//                and (AListItemStyleReg.DefaultItemHeight<>-1)
//                and not AListItemStyleReg.IsAutoSize then
//              begin
//                AListViewItem.Height:=AListItemStyleReg.DefaultItemHeight;
//              end;
//
//              if //AIsAutoSize or
//                  (AListItemStyleReg<>nil) and AListItemStyleReg.IsAutoSize then
//              begin
//                  //设置自动高度
//                  AListViewItem.Height:=
//                      lvOrderList.Prop.CalcItemAutoSize(AListViewItem).cy;
//              end;


//              AListViewItem.Caption:=AWorkImportant.S['车牌号'];
//
//              AListViewItem.Detail:=AWorkImportant.S['车辆品牌']+' '+AWorkImportant.S['车型'];
//
//              AListViewItem.Detail1:=AWorkImportant.S['联系人'];
//              AListViewItem.Detail2:=AWorkImportant.S['联系电话'];
//
//              AListViewItem.Detail3:=Format('%.2f',[AWorkImportant.F['合计费用']]);
//              AListViewItem.Detail4:=AWorkImportant.S['进厂日期'];
//              AListViewItem.Detail5:=AWorkImportant.S['维修进度'];
//              AListViewItem.Detail6:=AWorkImportant.S['维修单号'];
//
//
//              AListViewItem.SubItems.Add(FItemButtonCaption);

//              if AWorkImportant.S['维修进度']='待派' then
//              begin
//                AListViewItem.SubItems.Add('派工');
//              end
//              else if AWorkImportant.S['维修进度']='已派工' then
//              begin
//                AListViewItem.SubItems.Add('领料');
//              end
//              else
//              begin
//                AListViewItem.SubItems.Add('查看');
//              end;

            end;

          finally
            Self.lvOrderList.Prop.Items.EndUpdate();
          end;


//          for I := 0 to Self.lvOrderList.Prop.Items.Count-1 do
//          begin
//            Self.lvOrderList.Prop.Items[I].DoPropChange(Self.lvOrderList.Prop.Items[I]);
//          end;
          Self.lvOrderList.Prop.SetItemsAutoSize;

          //显示出共几条记录
//          Self.lblCount.Caption:='共'+FloatToStr(ASuperObject.O['Data'].A['Summary'].O[0].F['value'])+'条数据';
          Self.lblCount.Caption:='共'+FloatToStr(ASuperObject.O['Data'].I['SumCount'])+'条数据';
          Self.lblLoadedCount.Caption:='已加载'+FloatToStr(Self.lvOrderList.Prop.Items.Count)+'条';


          {if FFilterIsFinished = '0' then
          begin
            GlobalMainFrame.FProcessTaskManageFrame.tswait.caption:= '待处理（' + ASuperObject.O['Data'].S['uncomplete_count'] + '）';
//            GlobalMainFrame.FProcessTaskManageFrame.tsTodayFinished.caption:= '已完成';
//            GlobalMainFrame.FProcessTaskManageFrame.tsError.caption:= '异常单';
          end;

          if FFilterIsFinished = '1' then
          begin
//            GlobalMainFrame.FProcessTaskManageFrame.tswait.caption:= '待处理';
            GlobalMainFrame.FProcessTaskManageFrame.tsTodayFinished.caption:= '已完成（' + ASuperObject.O['Data'].S['complete_count'] + '）';
//            GlobalMainFrame.FProcessTaskManageFrame.tsError.caption:= '异常单';
          end;

          if FFilterIsFinished = '2' then
          begin
//            GlobalMainFrame.FProcessTaskManageFrame.tswait.caption:= '待处理';
//            GlobalMainFrame.FProcessTaskManageFrame.tsTodayFinished.caption:= '已完成';
            GlobalMainFrame.FProcessTaskManageFrame.tsError.caption:= '异常单（' + ASuperObject.O['Data'].S['err_count'] + '）';
          end;}

      end
      else
      begin
        //获取订单列表失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
      end;

    end
//    else if TTimerTask(Sender).TaskTag=2 then
//    begin
//      //图片上传失败
//      ShowMessageBoxFrame(Self,'图片上传失败!','',TMsgDlgType.mtInformation,['确定'],nil);
//    end
    else if TTimerTask(Sender).TaskTag=1 then
    begin
      //网络异常
      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(Sender).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
    end;
  finally
    HideWaitingFrame;


    if FPageIndex>1 then
    begin
        if (TTimerTask(Sender).TaskTag=TASK_SUCC) and (ASuperObject.O['Data'].A['RecordList'].Length>0) then
        begin
          Self.lvOrderList.Prop.StopPullUpLoadMore('加载成功!',0,True);
        end
        else
        begin
          Self.lvOrderList.Prop.StopPullUpLoadMore('下面没有了!',600,False);
        end;
    end
    else
    begin
        Self.lvOrderList.Prop.StopPullDownRefresh('刷新成功!',600);
        Self.lvOrderList.VertScrollBar.Prop.Position:=0;
    end;


  end;

end;

end.
