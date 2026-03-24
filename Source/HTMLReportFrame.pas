unit HTMLReportFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uDrawCanvas, uSkinItems, uSkinScrollControlType, uSkinCustomListType,

  WebBrowserFrame,
  XSuperObject,
  uFuncCommon,
  uFileCommon,
  StrUtils,
  uOpenClientCommon,
  uTimerTask,
  uRestInterfaceCall,
//  uManager,
  uUIFunction,
  uBaseLog,
  uFrameContext,
  EasyServiceCommonMaterialDataMoudle,
//  SelectFilterFrame,
  IDURI,
  System.NetEncoding,
  uPayAPIParam,
  SelectFilterDateAreaFrame,
  uManager,

  uSkinVirtualListType, uSkinListBoxType, uSkinFireMonkeyListBox,
  uSkinButtonType, uSkinFireMonkeyButton, uSkinFireMonkeyControl,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinListViewType,
  uSkinFireMonkeyListView, uTimerTaskEvent, FMX.Edit, FMX.Controls.Presentation,
  uSkinFireMonkeyEdit, uSkinMaterial, uSkinImageListPlayerType,
  uSkinFireMonkeyImageListPlayer, uDrawPicture, uSkinImageList;

type
  //groupby_type=%E5%AE%A2%E6%88%B7&report_name=TakeOrderBill&group_value_of_detail=%E7%99%BE%E6%AD%8C%E9%97%A8%E4%B8%9A
  TJumpToDetailPageEvent=procedure(Sender:TObject;
                                    AReportName:String;
                                    AGroupByType:String;
                                    AGroupByValue:String;
                                    AStartDate:String;
                                    AEndDate:String;
                                    ADefaultWhereSQL:String) of object;
  TFrameHTMLReport = class(TFrame,IFrameHistroyReturnEvent)
    lvGroupByTypes: TSkinFMXListView;
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    lbOrderState: TSkinFMXListBox;
    tteLoadData: TTimerTaskEvent;
    pnlDateArea: TSkinFMXPanel;
    btnSelectDateArea: TSkinSelectDateAreaButton;
    tmrJump: TTimer;
    FrameContext1: TFrameContext;
    imglistWaiting: TSkinImageList;
    imgWaiting: TSkinFMXImageListPlayer;
    procedure tteLoadDataExecute(ATimerTask: TTimerTask);
    procedure tteLoadDataExecuteEnd(ATimerTask: TTimerTask);
    procedure btnReturnClick(Sender: TObject);
    procedure lvGroupByTypesClickItem(AItem: TSkinItem);
    procedure btnSelectDateAreaClick(Sender: TObject);
    procedure tmrJumpTimer(Sender: TObject);
    procedure FrameContext1Show(Sender: TObject);
    procedure FrameContext1Hide(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure tteLoadDataBegin(ATimerTask: TTimerTask);
  private
    FJumpUrl:String;

    function GetCustomWhereSQL:String;virtual;
    procedure DoReturnFrameFromSelectDateArea(AFromFrame:TFrame);
    procedure WebBrowserFrameDidStartLoad(ASender: TObject);
    procedure WebBrowserFrameShouldStartLoadWithRequest(ASender: TObject; const URL: string);

    //跳转到明细页面
    procedure JumpToDetailPage(ASummaryUrl:String);

    //是否可以返回上一个Frame
    function CanReturn:TFrameReturnActionType;
    { Private declarations }
  public
    FReportName:String;
    FGroupByType:String;
    FWebBrowserFrame:TFrameWebBrowser;
    FDefaultWhereSQL:String;
    FOnJumpToDetailPage:TJumpToDetailPageEvent;
    constructor Create(AOwner:TComponent);override;
    procedure LoadDataToUI(AJson:ISuperObject;AGroupByType:String);overload;
    procedure Load(AReportName:String;
                  AGroupByType:String;
                  AFilterStartDate:String;
                  AFilterEndDate:String;
                  AOnJumpToDetailPage:TJumpToDetailPageEvent);overload;

    { Public declarations }
  end;


var
  GlobalHTMLReportFrame:TFrameHTMLReport;


implementation

{$R *.fmx}

{ TFrameHTMLReport }

procedure TFrameHTMLReport.btnReturnClick(Sender: TObject);
begin
  HideFrame();
  ReturnFrame();

end;

procedure TFrameHTMLReport.btnSelectDateAreaClick(Sender: TObject);
begin
  //选择日期范围

//  //搜索
//  HideFrame;
//  ShowFrame(TFrame(GlobalSelectFilterFrame),TFrameSelectFilter,DoReturnFrameFromSelectDateArea);
//  //完成日期
//  GlobalSelectFilterFrame.Load(
//                              btnSelectDateArea.StartDate,
//                              btnSelectDateArea.EndDate,
//                              ''
//                              );
//  GlobalSelectFilterFrame.pnlToolBar.Caption:='选择'+Self.pnlDateArea.Caption;

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

function TFrameHTMLReport.CanReturn: TFrameReturnActionType;
begin
  //如果返回频繁释放,会导致下次网页显示不出来
  Result:=TFrameReturnActionType.fratDefault;//fratReturnAndFree;

end;

constructor TFrameHTMLReport.Create(AOwner: TComponent);
begin
  inherited;
  FWebBrowserFrame:=TFrameWebBrowser.Create(Self);
  FWebBrowserFrame.Parent:=Self;
  FWebBrowserFrame.Align:=TAlignLayout.Client;
  FWebBrowserFrame.pnlToolBar.Visible:=False;
  FWebBrowserFrame.FOnWebBrowserDidStartLoad:=WebBrowserFrameDidStartLoad;
  FWebBrowserFrame.FOnWebBrowserShouldStartLoadWithRequest:=WebBrowserFrameShouldStartLoadWithRequest;
  FWebBrowserFrame.DoShow;

  Self.lvGroupByTypes.Prop.Items.BeginUpdate;
  try
    Self.lvGroupByTypes.Prop.Items.Clear;
  finally
    Self.lvGroupByTypes.Prop.Items.EndUpdate;
  end;

end;

procedure TFrameHTMLReport.DoReturnFrameFromSelectDateArea(AFromFrame: TFrame);
begin
  btnSelectDateArea.StartDate:=TFrameSelectFilterDateArea(AFromFrame).FStartDate;
  btnSelectDateArea.EndDate:=TFrameSelectFilterDateArea(AFromFrame).FEndDate;
  Self.tteLoadData.Run(True);
end;

procedure TFrameHTMLReport.FrameContext1Hide(Sender: TObject);
begin
  Application.FormFactor.Orientations := [TFormOrientation.Portrait, TFormOrientation.InvertedPortrait];
  Application.MainForm.FormFactor.Orientations := [TFormOrientation.Portrait, TFormOrientation.InvertedPortrait];

end;

procedure TFrameHTMLReport.FrameContext1Show(Sender: TObject);
begin
  Application.FormFactor.Orientations := [TFormOrientation.Portrait, TFormOrientation.InvertedPortrait, TFormOrientation.Landscape, TFormOrientation.InvertedLandscape];
  Application.MainForm.FormFactor.Orientations := [TFormOrientation.Portrait, TFormOrientation.InvertedPortrait, TFormOrientation.Landscape, TFormOrientation.InvertedLandscape];

end;

procedure TFrameHTMLReport.FrameResize(Sender: TObject);
begin
  //
  if Width>Height then
  begin
    //横屏了
    Self.pnlDateArea.Parent:=Self.pnlToolBar;
    Self.pnlDateArea.Align:=TAlignLayout.Left;
    Self.pnlDateArea.Width:=(Self.Width-Self.btnReturn.Width)/2;

    Self.lvGroupByTypes.Parent:=Self.pnlToolBar;
    Self.lvGroupByTypes.Align:=TAlignLayout.Client;
    Self.lvGroupByTypes.Width:=pnlDateArea.Width;

  end
  else
  begin
    Self.pnlDateArea.Align:=TAlignLayout.Top;
    Self.pnlDateArea.Height:=45;
    Self.pnlDateArea.Parent:=Self;
    Self.pnlDateArea.Margins.Left:=0;

    Self.lvGroupByTypes.Align:=TAlignLayout.Top;
    Self.lvGroupByTypes.Height:=45;
    Self.lvGroupByTypes.Parent:=Self;
  end;
end;

function TFrameHTMLReport.GetCustomWhereSQL: String;
begin
  Result:=FDefaultWhereSQL;

end;

procedure TFrameHTMLReport.JumpToDetailPage(ASummaryUrl: String);
var
  AIndex:Integer;
  AParams:String;
  AInterfaceParameters:TInterfaceParameters;
begin
  //跳转到明细页面
  //取出参数
//  {$IFDEF MSWINDOWS}
//  ASummaryUrl:='file:///data/user/0/com.ggggcexx.doormanage/files/doorCharts/ReportDetail.html?'
//              +'groupby_type='+TNetEncoding.URL.Encode('客户')
//              +'&report_name='+TNetEncoding.URL.Encode(Self.FReportName)
//              +'&group_value_of_detail='+TNetEncoding.URL.Encode('金凯德')
////              +'&group_value_of_detail='+TNetEncoding.URL.Encode('吴雄')
//              ;
//  if FReportName='收款报表' then
//  begin
//    ASummaryUrl:='file:///data/user/0/com.ggggcexx.doormanage/files/doorCharts/ReportDetail.html?'
//                +'groupby_type='+TNetEncoding.URL.Encode('客户')
//                +'&report_name='+TNetEncoding.URL.Encode(Self.FReportName)
//                +'&group_value_of_detail='+TNetEncoding.URL.Encode('比特福')
////                +'&group_value_of_detail='+TNetEncoding.URL.Encode('吴雄')
//                ;
//  end;
//  {$ENDIF}
  //  ASummaryUrl:=TIDUri.URLDecode(ASummaryUrl);
  ASummaryUrl:=TNetEncoding.URL.URLDecode(ASummaryUrl);
  AIndex:=Pos('?',ASummaryUrl);
  if AIndex<=0 then
  begin
    Exit;
  end;

//  AParams:=Pos(ASummaryUrl,AIndex+1,MaxInt);
  AInterfaceParameters:=ParseUrlQueryParameters(ASummaryUrl);
  try
    if Assigned(FOnJumpToDetailPage) then
    begin
      FOnJumpToDetailPage(Self,
                          AInterfaceParameters.ItemValueByName('report_name'),
                          AInterfaceParameters.ItemValueByName('groupby_type'),
                          AInterfaceParameters.ItemValueByName('group_value_of_detail'),
                          Self.btnSelectDateArea.StartDate,
                          Self.btnSelectDateArea.EndDate,
                          Self.FDefaultWhereSQL
                          );
    end;
  finally
    FreeAndNil(AInterfaceParameters);
  end;


end;

procedure TFrameHTMLReport.LoadDataToUI(AJson: ISuperObject;AGroupByType:String);
var
  AHTML:String;
  ASkinItem:TSkinItem;
  I: Integer;
  AGroupByTypeJson:ISuperObject;
  AFileName:String;
begin

  //支持哪些分组
//  if Self.lvGroupByTypes.Prop.Items.Count=0 then
//  begin
    Self.lvGroupByTypes.Prop.Items.BeginUpdate;
    try
      Self.lvGroupByTypes.Prop.Items.Clear;
      //加载分组
      for I := 0 to AJson.O['Data'].A['GroupByTypes'].Length-1 do
      begin
        AGroupByTypeJson:=AJson.O['Data'].A['GroupByTypes'].O[I];
        ASkinItem:=Self.lvGroupByTypes.Prop.Items.Add;
        ASkinItem.Caption:=AGroupByTypeJson.S['name'];
        ASkinItem.Selected:=(ASkinItem.Caption=AGroupByType);
        if AJson.O['Data'].A['GroupByTypes'].Length>1 then
        begin
          ASkinItem.width:=1/AJson.O['Data'].A['GroupByTypes'].Length;
        end
        else
        begin
          ASkinItem.width:=-2;
        end;
      end;
    finally
      Self.lvGroupByTypes.Prop.Items.EndUpdate;
    end;
//  end;


  if not FileExists(GetApplicationPath+'doorCharts'+PathDelim+'doorCharts.html') then
  begin
    ShowMessage('报表文件不存在');
    Exit;
  end;

  //会释放WebBrowser,再重建WebBrowser,可能会导致问题,先不重建
  FWebBrowserFrame.LoadUrl({$IFDEF MSWINDOWS}{$ELSE}'file:///'+{$ENDIF}GetApplicationPath+'doorCharts'+PathDelim+'doorCharts.html','',True,False);

  //多次之后就显示不来的问题
  FWebBrowserFrame.FWebBrowser.SetBounds(0,0,FWebBrowserFrame.Width,FWebBrowserFrame.Height);



//  //读取模板
//  AHTML:=GetStringFromFile(GetApplicationPath+'doorCharts'+PathDelim+'doorCharts.html',TEncoding.UTF8);
//
//
//
//
//  //修改模板变量
//
//  //测试模式，改为本地模式取本地数据
//  AHTML:=ReplaceStr(AHTML,QuotedStr('test'),QuotedStr('local'));
//  //写入本地数据
//  AHTML:=ReplaceStr(AHTML,'$local_data_json_str',AJson.AsJSON());
//  AHTML:=ReplaceStr(AHTML,'$Fgroupby_type',AGroupByType);
//  AHTML:=ReplaceStr(AHTML,'$Freport_name',FReportName);
//
//  AFileName:='doorCharts_instance_'+CreateGUIDString+'.html';
//  SaveStringToFile(AHTML,GetApplicationPath+'doorCharts'+PathDelim+AFileName,TEncoding.UTF8);
//
//  //会释放WebBrowser,再重建WebBrowser,可能会导致问题,先不重建
//  FWebBrowserFrame.LoadUrl({$IFDEF MSWINDOWS}{$ELSE}'file:///'+{$ENDIF}GetApplicationPath+'doorCharts'+PathDelim+AFileName,'',True,False);
//
//  //多次之后就显示不来的问题
//  FWebBrowserFrame.FWebBrowser.SetBounds(0,0,FWebBrowserFrame.Width,FWebBrowserFrame.Height);
//


end;

procedure TFrameHTMLReport.Load(AReportName:String;
                                AGroupByType:String;
                                AFilterStartDate:String;
                                AFilterEndDate:String;
                                AOnJumpToDetailPage:TJumpToDetailPageEvent);
begin
  FDefaultWhereSQL:='';
  FReportName:=AReportName;
  FGroupByType:=AGroupByType;
  btnSelectDateArea.StartDate:=AFilterStartDate;
  btnSelectDateArea.EndDate:=AFilterEndDate;
  FOnJumpToDetailPage:=AOnJumpToDetailPage;
  Self.pnlToolBar.Caption:=AReportName;
  Self.tteLoadData.Run(True);
end;

procedure TFrameHTMLReport.lvGroupByTypesClickItem(AItem: TSkinItem);
begin
  FGroupByType:=Self.lvGroupByTypes.Prop.SelectedItem.Caption;
  Self.tteLoadData.Run(True);
//  Load(AReportName:String;
//                  AGroupByType:String;
//                  AFilterStartDate:String;
//                  AFilterEndDate:String;
//                  AOnJumpToDetailPage:TJumpToDetailPageEvent);overload;
end;

procedure TFrameHTMLReport.tmrJumpTimer(Sender: TObject);
begin
  Self.tmrJump.Enabled:=False;

  //跳转到报表明细页面
  JumpToDetailPage(FJumpURL);

end;

procedure TFrameHTMLReport.tteLoadDataBegin(ATimerTask: TTimerTask);
begin
  imgWaiting.Visible:=True;
  imgWaiting.Prop.ImageListAnimated:=True;
end;

procedure TFrameHTMLReport.tteLoadDataExecute(ATimerTask: TTimerTask);
var
  ADesc:String;
  AIsUsedCache:Boolean;
begin
  uBaseLog.HandleException(nil,'TFrameHTMLReport.tteLoadDataExecute Begin');

//  try
//      //出错
//      TTimerTask(ATimerTask).TaskTag:=1;
////  btnSelectDateArea.StartDate:=AFilterStartDate;
////  btnSelectDateArea.EndDate:=AFilterEndDate;
//
//       TTimerTask(ATimerTask).TaskDesc :=SimpleCallAPI('get_main_summary_report',
//                                                  nil,
//                                                  //DoorManageInterfaceUrl,
////                                                  'http://www.orangeui.cn:10050/door_manage/',
//                                                  'http://127.0.0.1:10050/door_manage/',
//                                                  ['appid',
//                                                  'user_fid',
//                                                  'key',
//                                                  'report_name',
//                                                  'groupby_type',
//                                                  'filter_start_date',
//                                                  'filter_end_date',
//                                                  'pageindex',
//                                                  'pagesize',
//                                                  'orderby',
//                                                  'is_groupby',
//                                                  'group_value_of_detail',
//                                                  'power',
////                                                  'compressed'
//                                                  'custom_where_sql',
//                                                  'door_type'
//                                                  ],
//                                                  [AppID,
//                                                  GlobalManager.User.fid,
//                                                  GlobalManager.User.key,
//                                                  FReportName,//'TakeOrderBill',
//                                                  FGroupByType,//Self.lvGroupByTypes.Prop.SelectedItem.Caption,//'日',
//                                                  btnSelectDateArea.StartDate,
//                                                  btnSelectDateArea.EndDate,
//                                                  1,
//                                                  100,
//                                                  '',
//                                                  '1',
//                                                  '',
//                                                  GlobalManager.EmployeeJson.S['权限'],
////                                                  1
//                                                  GetCustomWhereSQL,
//                                                  GlobalManager.FCurrentDoorType
//                                                  ],
//                                                  GlobalRestAPISignType,
//                                                  GlobalRestAPIAppSecret
//                                                  );
//
//    if TTimerTask(ATimerTask).TaskDesc<>'' then
//    begin
//      TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
//      //太快了不好,估计webbroser都没有创建好
////      Sleep(500);
//    end;
//
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
  uBaseLog.HandleException(nil,'TFrameHTMLReport.tteLoadDataExecute End');
end;

procedure TFrameHTMLReport.tteLoadDataExecuteEnd(ATimerTask: TTimerTask);
var
//  I: Integer;
//  AListViewItem:TJsonSkinItem;
  ASuperObject:ISuperObject;
//  AProcessTaskOrder:ISuperObject;
//  AListItemStyle:String;
//  AListItemStyleReg:TListItemStyleReg;
begin
  uBaseLog.HandleException(nil,'TFrameHTMLReport.tteLoadDataExecuteEnd Begin');
  try

      if not FileExists(GetApplicationPath+'doorCharts'+PathDelim+'doorCharts.html') then
      begin
        ShowMessage('报表文件不存在');
        Exit;
      end;

      //会释放WebBrowser,再重建WebBrowser,可能会导致问题,先不重建
      FWebBrowserFrame.LoadUrl({$IFDEF MSWINDOWS}{$ELSE}'file:///'+{$ENDIF}GetApplicationPath+'doorCharts'+PathDelim+'doorCharts.html','',True,False);

      //多次之后就显示不来的问题
      FWebBrowserFrame.FWebBrowser.SetBounds(0,0,FWebBrowserFrame.Width,FWebBrowserFrame.Height);

//    LoadDataToUI(ASuperObject,FGroupByType);

//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//        LoadDataToUI(ASuperObject,FGroupByType);
//
//      end
//      else
//      begin
//        //获取订单列表失败
//        ShowMessage(ASuperObject.S['Desc']);
//      end;
//
//    end
////    else if TTimerTask(ATimerTask).TaskTag=2 then
////    begin
////      //图片上传失败
////      ShowMessageBoxFrame(Self,'图片上传失败!','',TMsgDlgType.mtInformation,['确定'],nil);
////    end
//    else if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      //网络异常
//      //ShowMessage('网络异常,请检查您的网络连接!'+TTimerTask(ATimerTask).TaskDesc);
//      ShowMessage('网络异常,请检查您的网络连接!');
//    end;
  finally
    imgWaiting.Visible:=False;
    imgWaiting.Prop.ImageListAnimated:=False;
  end;


  uBaseLog.HandleException(nil,'TFrameHTMLReport.tteLoadDataExecuteEnd End');
end;

procedure TFrameHTMLReport.WebBrowserFrameDidStartLoad(ASender: TObject);
begin
  //ReportDetail.html?groupby_type=客户&report_name=TakeOrderBill&group_value_of_detail=百歌门业
  //groupby_type=%E5%AE%A2%E6%88%B7&report_name=TakeOrderBill&group_value_of_detail=%E7%99%BE%E6%AD%8C%E9%97%A8%E4%B8%9A
  //file:///data/user/0/com.ggggcexx.doormanage/files/doorCharts/ReportDetail.html?groupby_type=%E5%AE%A2%E6%88%B7&report_name=TakeOrderBill&group_value_of_detail=%E7%99%BE%E6%AD%8C%E9%97%A8%E4%B8%9A
  uBaseLog.HandleException(nil,'TFrameHTMLReport.WebBrowserFrameDidStartLoad '+FWebBrowserFrame.FWebBrowser.URL);
  if Pos('ReportDetail.html',FWebBrowserFrame.FWebBrowser.URL)>0 then
  begin
    FWebBrowserFrame.FWebBrowser.Stop;

    FJumpUrl:=FWebBrowserFrame.FWebBrowser.URL;
    tmrJump.Enabled:=False;
    tmrJump.Enabled:=True;


  end;


end;

procedure TFrameHTMLReport.WebBrowserFrameShouldStartLoadWithRequest(
  ASender: TObject; const URL: string);
begin
  //ReportDetail.html?groupby_type=客户&report_name=TakeOrderBill&group_value_of_detail=百歌门业
  //groupby_type=%E5%AE%A2%E6%88%B7&report_name=TakeOrderBill&group_value_of_detail=%E7%99%BE%E6%AD%8C%E9%97%A8%E4%B8%9A
  //file:///data/user/0/com.ggggcexx.doormanage/files/doorCharts/ReportDetail.html?groupby_type=%E5%AE%A2%E6%88%B7&report_name=TakeOrderBill&group_value_of_detail=%E7%99%BE%E6%AD%8C%E9%97%A8%E4%B8%9A
  uBaseLog.HandleException(nil,'TFrameHTMLReport.WebBrowserFrameShouldStartLoadWithRequest '+URL);
  if Pos('ReportDetail.html',URL)>0 then
  begin
    FWebBrowserFrame.FWebBrowser.Stop;

    FJumpUrl:=URL;
    tmrJump.Enabled:=False;
    tmrJump.Enabled:=True;

  end;

end;

end.
