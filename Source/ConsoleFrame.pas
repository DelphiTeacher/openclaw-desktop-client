unit ConsoleFrame;

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
//  uBasePageFrame,

//  Winapi.Windows,

  Math,
  DateUtils,
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
  SelectFilterFrame,
  uOpenCommon,
  uSkinBufferBitmap,
  uOpenClientCommon,
//  uDownloadListItemStyleManager,
//  ListItemStyleFrame_ProcessTaskOrder,
//  ListItemStyleFrame_FinishedProcessTask,
//  ListItemStyleFrame_Page,
//  RecvMoneyReportDetailFrame,
//  ProcessTaskOrderInfoFrame,
  HintFrame,
  HTMLReportFrame,
//  SkinChartReportFrame,
//  ViewJsonFrame,
//  OrderInfoFrame,
//  StorageFrame,
//  ProductStorageReportDetailFrame,

  HZSpell,

  FMX.Platform,

  XSuperObject,
  XSuperJson,

  uBaseList,
  uSkinItems,
  uSkinListBoxType,
  uSkinListViewType,
  uGraphicCommon,

//  uPageStructure,
//  uPageFramework,
//  FMX.Controls.iOS,

  uDatasetToJson,
//  StockInfoFrame,
//  ProductInStoreHTMLReportFrame,


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
  TFrameConsole = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    spnlContainer: TSkinFMXPanel;
    slstvConsole: TSkinFMXListView;
    tteGetConsoleData: TTimerTaskEvent;
    pnlCurrentProcess: TSkinFMXPanel;
    cmbCurrentProcess: TSkinFMXComboBox;
    lblCurrentProcess: TSkinFMXLabel;
    cmbCurrentDoorType: TSkinFMXComboBox;
    procedure slstvConsoleClickItem(AItem: TSkinItem);
    procedure tteGetConsoleDataExecute(ATimerTask: TTimerTask);
    procedure tteGetConsoleDataExecuteEnd(ATimerTask: TTimerTask);
    procedure slstvConsolePullDownRefresh(Sender: TObject);
    procedure cmbCurrentProcessChange(Sender: TObject);
    procedure cmbCurrentDoorTypeChange(Sender: TObject);
  private
    procedure SyncPower;
    { Private declarations }
  public
    procedure DoReportDetailPageClickItem(AItem:TSkinItem);
    //跳转到报表明细页面
    procedure DoJumpToReportDetailPage(Sender:TObject;
                                      AReportName:String;
                                      AGroupByType:String;
                                      AGroupByValue:String;
                                      AStartDate:String;
                                      AEndDate:String;
                                      ADefaultWhereSQL:String);
    procedure LoadProcess;
    procedure Load;
    constructor Create(AOwner:TComponent);override;
    { Public declarations }
  end;


implementation


{$R *.fmx}

uses
  MainForm,
  MainFrame,
  BaseReportFrame,
  BaseReportDetailFrame;


procedure TFrameConsole.cmbCurrentProcessChange(Sender: TObject);
begin
  //
//  GlobalManager.FCurrentProcess:=Self.cmbCurrentProcess.Text;
  Self.pnlCurrentProcess.Width:=uSkinBufferBitmap.GetStringWidth(Self.cmbCurrentProcess.Text,14)+24;
  GlobalManager.SaveUserConfig;
end;

procedure TFrameConsole.cmbCurrentDoorTypeChange(Sender: TObject);
begin
//  GlobalManager.FCurrentDoorType:=Self.cmbCurrentDoorType.Text;
  Self.cmbCurrentDoorType.Width:=uSkinBufferBitmap.GetStringWidth(Self.cmbCurrentDoorType.Text,14)+24;
  GlobalManager.SaveUserConfig;
  Self.tteGetConsoleData.Run;
end;

constructor TFrameConsole.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TFrameConsole.DoJumpToReportDetailPage(Sender: TObject; AReportName,
  AGroupByType, AGroupByValue: String;
  AStartDate:String;
  AEndDate:String;
  ADefaultWhereSQL:String);
//var
//  ABasePageFrame:TFrameBasePage;
//  AWhereKeyJson:ISuperObject;
//  ADefaultItemStyle:String;
begin
//  if AReportName='品质报表' then
//  begin
//    //初始的查询条件
////    AWhereKeyJson:=uDatasetToJson.GetWhereConditions([AGroupByType],[]);
//
//    //初始的加载数据
//
//    ABasePageFrame:=TFrameBasePage(uPageFramework.GlobalOpenPlatformFramework.ShowPage('QualityCheckList'));
//  end
//  else
//  begin

//    ADefaultItemStyle:='';
//    {$IFDEF MSWINDOWS}
//    //在Windows下面的测试
//    if AReportName='品质报表' then
//    begin
//      //在Windows下面的测试
//      AGroupByType:='日';
//      AGroupByValue:='2022-03-04';
//      ADefaultItemStyle:='QualityCheck';
//    end;
//    //在Windows下面的测试
//    if AReportName='成品库存报表' then
//    begin
//      //在Windows下面的测试
//      AGroupByType:='仓库';
//      AGroupByValue:='成品仓库';
//      ADefaultItemStyle:='Product';
//    end;
//    {$ENDIF}
//    if AReportName='收款报表' then
//    begin
//      HideFrame;
//      ShowFrame(TFrame(GlobalRecvMoneyReportDetailFrame),TFrameRecvMoneyReportDetail);
//      GlobalRecvMoneyReportDetailFrame.Load(AReportName,AGroupByType,AGroupByValue,AStartDate,AEndDate,ADefaultWhereSQL,ADefaultItemStyle);
//      Exit;
//    end;
//
//    //跳转到单据详情
//    if (GlobalManager.FCurrentDoorType='标门')
//      and (AReportName='成品库存报表') then
//    begin
//      ADefaultItemStyle:='Product';
//      HideFrame;
//      ShowFrame(TFrame(GlobalProductStorageReportDetailFrame),TFrameProductStorageReportDetail);
//      GlobalProductStorageReportDetailFrame.Load(AReportName,AGroupByType,AGroupByValue,AStartDate,AEndDate,ADefaultWhereSQL,ADefaultItemStyle);
//      Exit;
//    end;
//
//
//    HideFrame;
//    ShowFrame(TFrame(GlobalBaseReportDetailFrame),TFrameBaseReportDetail);
//    GlobalBaseReportDetailFrame.Load(AReportName,AGroupByType,AGroupByValue,AStartDate,AEndDate,ADefaultWhereSQL,ADefaultItemStyle);
//    GlobalBaseReportDetailFrame.lvData.OnClickItem:=Self.DoReportDetailPageClickItem;

//  end;
end;

procedure TFrameConsole.DoReportDetailPageClickItem(AItem: TSkinItem);
begin
//    if (Copy(AItem.Json.S['单据编码'],2,2)='RW')
//       or (GlobalBaseReportDetailFrame.FReportName='报工报表')
//        or (GlobalBaseReportDetailFrame.FReportName='下单报表') then
//    begin
//      //生产任务单详情
//      //显示工单详情
//      HideFrame;
//      ShowFrame(TFrame(GlobalYieldTaskOrderInfoFrame),TFrameYieldTaskOrderInfo);
//      GlobalYieldTaskOrderInfoFrame.Load(AItem.Json);
//    end
//    else
//    begin
//      //订单详情
//      //查看订单详情
//      HideFrame;
//      ShowFrame(TFrame(GlobalOrderInfoFrame),TFrameOrderInfo,nil);//DoReturnFrameFromYieldTaskOrderInfoFrame);
//      GlobalOrderInfoFrame.Load(AItem.Json,GlobalBaseReportDetailFrame.FReportName);
//
//    end;

end;

procedure TFrameConsole.Load;
begin
  LoadProcess;

  Self.SyncPower;

  Self.tteGetConsoleData.Run;
end;

procedure TFrameConsole.LoadProcess;
var
  ASupportDoorTypes:String;
begin

  Self.cmbCurrentProcess.OnChange:=nil;
  try
      Self.cmbCurrentProcess.Items.CommaText:=GlobalManager.EmployeeJson.S['岗位'];
//      if Self.cmbCurrentProcess.Items.IndexOf(GlobalManager.CurrentProcess)<>-1 then
//      begin
//          //存在
//          if Self.cmbCurrentProcess.Items.Count>1 then
//          begin
//            Self.cmbCurrentProcess.ItemIndex:=Self.cmbCurrentProcess.Items.IndexOf(GlobalManager.CurrentProcess);
//          end;
//      end
//      else
//      begin
//          //不存在
//          GlobalManager.FCurrentProcess:='';
//      end;
      Self.pnlCurrentProcess.Visible:=(Self.cmbCurrentProcess.Items.Count>1);
      Self.cmbCurrentProcess.Visible:=(Self.cmbCurrentProcess.Items.Count>1);
//      Self.lblCurrentProcess.Visible:=(Self.cmbCurrentProcess.Items.Count>1);
//      Self.lblCurrentProcess.Position.X:=
//          Width-cmbCurrentProcess.Width-cmbCurrentProcess.Margins.Left-cmbCurrentProcess.Margins.Right
//          -lblCurrentProcess.Width;
      Self.pnlCurrentProcess.Width:=
        uSkinBufferBitmap.GetStringWidth(Self.cmbCurrentProcess.Text,14)+24
//        +Self.lblCurrentProcess.Width
        +20;
  finally
    Self.cmbCurrentProcess.OnChange:=cmbCurrentProcessChange;
  end;


  Self.cmbCurrentDoorType.OnChange:=nil;
  try
//      ASupportDoorTypes:=GlobalManager.GetSysMemory('支持门类型');

      Self.cmbCurrentDoorType.Items.CommaText:=ASupportDoorTypes;//GlobalManager.GetSysMemory('支持门类型');

      if Self.cmbCurrentDoorType.Items.IndexOf(GlobalManager.FCurrentDoorType)<>-1 then
      begin
          //存在
          if Self.cmbCurrentDoorType.Items.Count>1 then
          begin
            Self.cmbCurrentDoorType.ItemIndex:=Self.cmbCurrentDoorType.Items.IndexOf(GlobalManager.FCurrentDoorType);
          end;
      end
      else
      begin
          //不存在
          if Self.cmbCurrentDoorType.Items.Count>0 then
          begin
            GlobalManager.FCurrentDoorType:=Self.cmbCurrentDoorType.Items[0];
          end
          else
          begin
            GlobalManager.FCurrentDoorType:='非标门';
          end;

//          if Pos(',',ASupportDoorTypes)=0 then
//          begin
//            //只支持一种
//            GlobalManager.FCurrentDoorType:=ASupportDoorTypes;
//          end
//          else
//          begin
//            GlobalManager.FCurrentDoorType:='非标门';
//          end;
      end;


//      Self.pnlCurrentDoorType.Visible:=(Self.cmbCurrentDoorType.Items.Count>1);
      Self.cmbCurrentDoorType.Visible:=(Self.cmbCurrentDoorType.Items.Count>1);
//      Self.lblCurrentDoorType.Visible:=(Self.cmbCurrentDoorType.Items.Count>1);
//      Self.lblCurrentDoorType.Position.X:=
//          Width-cmbCurrentDoorType.Width-cmbCurrentDoorType.Margins.Left-cmbCurrentDoorType.Margins.Right
//          -lblCurrentDoorType.Width;
      Self.cmbCurrentDoorType.Width:=uSkinBufferBitmap.GetStringWidth(Self.cmbCurrentDoorType.Text,14)+24;
  finally
    Self.cmbCurrentDoorType.OnChange:=cmbCurrentDoorTypeChange;
  end;



end;

procedure TFrameConsole.slstvConsoleClickItem(AItem: TSkinItem);
var
  AReportName:String;
  AFilterStartDate:String;
  AFilterEndDate:String;
begin
//  if AItem.Caption='今日异常' then
//  begin
//    ShowMessage('今日异常' + AItem.Detail);
//  end;

//  ShowMessage(AItem.Caption + AItem.Detail);

  if AItem.ItemType=sitSpace then Exit;


  AReportName:='';
  if (AItem.Caption='今日下单') or (AItem.Caption='本月下单') then
  begin
    AReportName:='下单报表';
  end;
  if (AItem.Caption='今日录单') or (AItem.Caption='本月录单') then
  begin
    AReportName:='录单报表';
  end;
  if (AItem.Caption='今日审单') or (AItem.Caption='本月审单') then
  begin
    AReportName:='审单报表';
  end;
  if (AItem.Caption='今日价审') or (AItem.Caption='本月价审') then
  begin
    AReportName:='价审报表';
  end;
  if (AItem.Caption='今日技审') or (AItem.Caption='本月技审') then
  begin
    AReportName:='技审报表';
  end;
  if (AItem.Caption='今日入库') or (AItem.Caption='本月入库') then
  begin
    AReportName:='入库报表';
  end;
  if (AItem.Caption='今日发货') or (AItem.Caption='本月发货') then
  begin
    AReportName:='发货报表';
  end;
  if (AItem.Caption='今日收款') or (AItem.Caption='本月收款') then
  begin
    AReportName:='收款报表';
  end;
  if (AItem.Caption='成品库存') then
  begin
      AReportName:='成品库存报表';

//      HideFrame;
//      ShowFrame(TFrame(GlobalProductInStoreHTMLReportFrame),TFrameProductInStoreHTMLReport);
//      if GlobalManager.FCurrentDoorType='标门' then
//      begin
//        //默认的分组字段
//        GlobalProductInStoreHTMLReportFrame.Load(AReportName,
//                                                '仓库',
//                                                '',//'2020-01-01',
//                                                '',//'2020-12-31',
//                                                DoJumpToReportDetailPage);
//      end
//      else
//      begin
//        GlobalProductInStoreHTMLReportFrame.Load(AReportName,
//                                                '客户',
//                                                '',//'2020-01-01',
//                                                '',//'2020-12-31',
//                                                DoJumpToReportDetailPage);
//      end;
//      GlobalProductInStoreHTMLReportFrame.FDefaultWhereSQL:='';
//      Exit;
//
  end;
  if (AItem.Caption='待排产') then
  begin
    AReportName:='待排产报表';
  end;
  if (AItem.Caption='生产中') then
  begin
    AReportName:='生产中报表';
  end;
  if (AItem.Caption='加急订单') then
  begin
    AReportName:='加急订单报表';
  end;
  if (AItem.Caption='生产延期') then
  begin
    AReportName:='生产延期报表';
  end;
  if (AItem.Caption='今日异常') or (AItem.Caption='本月异常') then
  begin
    AReportName:='异常单报表';
  end;
  if (AItem.Caption='今日报工') or (AItem.Caption='本月报工') then
  begin
    AReportName:='报工报表';
  end;



  if AReportName='' then
  begin
    AReportName:=AItem.Caption;
    AReportName:=ReplaceStr(AReportName,'今日','');
    AReportName:=ReplaceStr(AReportName,'本月','');
    AReportName:=AReportName+'报表';
  end;


  if AReportName='' then
  begin
//    ShowMessage('未知报表');
    Exit;
  end;


  AFilterStartDate:='';
  AFilterEndDate:='';
  if Pos('今日',AItem.Caption)>0 then
  begin
    AFilterStartDate:=FormatDateTime('YYYY-MM-DD',Now);
    AFilterEndDate:=FormatDateTime('YYYY-MM-DD',Now);
  end;
  if Pos('本月',AItem.Caption)>0 then
  begin
    AFilterStartDate:=FormatDateTime('YYYY-MM-DD',StartOfTheMonth(Now));
    AFilterEndDate:=FormatDateTime('YYYY-MM-DD',EndOfTheMonth(Now));
  end;



  HideFrame;
  ShowFrame(TFrame(GlobalHTMLReportFrame),TFrameHTMLReport);
  GlobalHTMLReportFrame.Load(AReportName,
                            '客户',
                            AFilterStartDate,//'2020-01-01',
                            AFilterEndDate,//'2020-12-31',
                            DoJumpToReportDetailPage);
  GlobalHTMLReportFrame.FDefaultWhereSQL:='';
  if (AItem.Caption='今日报工') or (AItem.Caption='本月报工') then
  begin
    GlobalHTMLReportFrame.FGroupByType:='完成日期';
    GlobalHTMLReportFrame.FDefaultWhereSQL:=' AND [工序]='''+GlobalManager.CurrentProcess+''' '
                                            +' AND [工序状态]=''已完成'' ';
  end;


//  //测试图表控件
//  HideFrame;
//  ShowFrame(TFrame(GlobalSkinChartReportFrame),TFrameSkinChartReport);
//  GlobalSkinChartReportFrame.Load(AReportName,
//                            '客户',
//                            AFilterStartDate,//'2020-01-01',
//                            AFilterEndDate,//'2020-12-31',
//                            DoJumpToReportDetailPage);
//  GlobalSkinChartReportFrame.FDefaultWhereSQL:='';
//  if (AItem.Caption='今日报工') or (AItem.Caption='本月报工') then
//  begin
//    GlobalSkinChartReportFrame.FGroupByType:='完成日期';
//    GlobalSkinChartReportFrame.FDefaultWhereSQL:=' AND [工序]='''+GlobalManager.CurrentProcess+''' '
//                                            +' AND [工序状态]=''已完成'' ';
//  end;








//  HideFrame;
//  ShowFrame(TFrame(fmBaseReport),TfmBaseReport);
//  fmBaseReport.Load('下单报表','客户','','','','Default');
end;

//下拉刷新
procedure TFrameConsole.slstvConsolePullDownRefresh(Sender: TObject);
begin
  Self.tteGetConsoleData.Run;
end;

procedure TFrameConsole.SyncPower;
var
  I: Integer;
  ASkinItem:TSkinItem;
  APowerName:String;
begin
  Self.slstvConsole.Prop.Items.BeginUpdate;
  try
    for I := 0 to Self.slstvConsole.Prop.Items.Count-1 do
    begin
      ASkinItem:=Self.slstvConsole.Prop.Items[I];

//      if (ASkinItem.Caption<>'今日报工') and (ASkinItem.Caption<>'本月报工') then
//      begin
//        ASkinItem.Visible:=(GlobalManager.EmployeeJson.S['权限']='管理员');
//      end;
      APowerName:=ASkinItem.Caption;
      APowerName:=Replacestr(APowerName,'今日','');
      APowerName:=Replacestr(APowerName,'本月','');
      APowerName:=APowerName+'报表';
      ASkinItem.Visible:=GlobalManager.HasPower(APowerName);

    end;
  finally
    Self.slstvConsole.Prop.Items.EndUpdate()
  end;


end;

procedure TFrameConsole.tteGetConsoleDataExecute(ATimerTask: TTimerTask);
begin

  TTimerTask(ATimerTask).TaskTag:=TASK_FAIL;
  try
    TTimerTask(ATimerTask).TaskDesc:=
        SimpleCallAPI('get_main_summary',
                      nil,
                      DoorManageInterfaceUrl,
                      ['appid',
                      'user_fid',
                      'process',
                      'door_type'
                      ],
                      [AppID,
                      GlobalManager.User.fid,
                      GlobalManager.CurrentProcess,//GlobalManager.EmployeeJson.S['岗位']
                      GlobalManager.FCurrentDoorType//GlobalManager.EmployeeJson.S['岗位']
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

procedure TFrameConsole.tteGetConsoleDataExecuteEnd(ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
  I:Integer;
  ASkinItem:TSkinItem;
  ALastItemIndex:Integer;
begin
  try

    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

        ALastItemIndex:=0;
        for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
        begin

          ASkinItem:=Self.slstvConsole.Prop.Items.FindItemByCaption(ASuperObject.O['Data'].A['RecordList'].O[I].S['caption']);
          if ASkinItem <> nil then
          begin
              ASkinItem.Detail:=ASuperObject.O['Data'].A['RecordList'].O[I].I['value'].ToString;
              ALastItemIndex:=ASkinItem.Index;
          end
          else
          begin
              //添加不存在的项
              ASkinItem:=Self.slstvConsole.Prop.Items.Add;//Insert(ALastItemIndex);
              ASkinItem.Caption:=ASuperObject.O['Data'].A['RecordList'].O[I].S['caption'];
              ASkinItem.Detail:=ASuperObject.O['Data'].A['RecordList'].O[I].I['value'].ToString;
              //颜色
              if ASuperObject.O['Data'].A['RecordList'].O[I].S['value_color']<>'' then
              begin
                ASkinItem.Color:=ColorNameToColor(ASuperObject.O['Data'].A['RecordList'].O[I].S['value_color']);
              end;


          end;


        end;


//        //添加不存在的项
//        for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
//        begin
//
//          ASkinItem:=Self.slstvConsole.Prop.Items.FindItemByCaption(ASuperObject.O['Data'].A['RecordList'].O[I].S['caption']);
//          if ASkinItem = nil then
//          begin
//            ASkinItem:=Self.slstvConsole.Prop.Items.Add;
//            ASkinItem.Caption:=ASuperObject.O['Data'].A['RecordList'].O[I].S['caption'];
//            ASkinItem.Detail:=ASuperObject.O['Data'].A['RecordList'].O[I].I['value'].ToString;
//          end;
//
//
//        end;


        SyncPower;


      end
      else
      begin
        //获取订单详情失败
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
    Self.slstvConsole.Prop.StopPullDownRefresh('刷新成功!',600);
  end;
end;

end.
