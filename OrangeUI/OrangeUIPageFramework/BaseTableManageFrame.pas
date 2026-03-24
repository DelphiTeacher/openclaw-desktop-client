unit BaseTableManageFrame;

interface

{$I Framework.inc}

uses
  System.SysUtils, System.Variants, System.Classes,
  BasePageFrame, Math,
  UITypes,
  uFuncCommon,
    {$IFDEF SKIN_SUPEROBJECT}
    uSkinSuperObject,
    uSkinSuperJson,
    {$ELSE}
    XSuperObject,
    XSuperJson,
    {$ENDIF}
  uRestInterfaceCall,
  uManager,
  uDatasetToJson,
  uJsonToDataset,
  uOpenClientCommon,
  uOpenCommon,
  uGraphicCommon,
  uTimerTask,
  uPageStructure,
  uPageInstance,
  uBasePageStructure,
  uDataInterface,
  {$IFDEF VCL}
  Winapi.Windows, Winapi.Messages,
  SelectPopupForm,
  GridSwitchPageFrame,
//  UITypes,
  Controls,
  StdCtrls,
  ExtCtrls,
  cxGridFrame,
//  BaseEditPageFrame,
//  uTableCommonRestCenter,
  EasyServiceCommonMaterialDataMoudle_VCL,
  MessageBoxFrame_VCL, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxCheckBox, cxGrid,
  {$ENDIF}
  {$IFDEF FMX}
  FMX.Controls,
  FMX.Types,
  DBGridFrame,
  MessageBoxFrame,
  {$ENDIF}
  uBasePageFrame,
  Data.DB,
  uSkinButtonType, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRestIntfMemTable;

type
  {$IFDEF VCL}
  TFrameGridSwitchPage_BaseTableManagePage=class(TFrameGridSwitchPage)
    FPageInstance:TPageInstance;
    procedure btnFirstPageClick(Sender: TObject);override;
    procedure btnPriorPageClick(Sender: TObject);override;
    procedure btnNextPageClick(Sender: TObject);override;
    procedure btnLastPageClick(Sender: TObject);override;
    procedure btnRefreshClick(Sender: TObject);override;
    procedure edtPageIndexKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);override;
    procedure DoRestMemTableChange(Sender:TObject);//override;
  end;
  {$ENDIF}

  TFrameBaseTableManagePage = class(TFrameBaseEditPage)
    procedure RestMemTable1AfterInsert(DataSet: TDataSet);
    procedure RestMemTable1BeforeDelete(DataSet: TDataSet);
    procedure RestMemTable1GetRestDatasetPage(Sender: TObject;
      var ACallAPIResult: Boolean; var ACode: Integer; var ADesc: string;
      var ADataJson: ISuperObject);
    procedure btnSaveGridClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
//    procedure cxGrid1DBTableView1CellClick(Sender: TcxCustomGridTableView;
//      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
//      AShift: TShiftState; var AHandled: Boolean);
//    procedure btnSaveClick(Sender: TObject);
//    procedure cxGrid1DBTableView1CustomDrawIndicatorCell(
//      Sender: TcxGridTableView; ACanvas: TcxCanvas;
//      AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean);
//  private
//    procedure SetRowNumber(var Sender: TcxGridTableView; var AViewInfo: TcxCustomGridIndicatorItemViewInfo; ACanvas: TcxCanvas; var ADone: boolean);
    { Private declarations }
  protected
    FRecordListControlSettingMap:TFieldControlSettingMap;
    {$IFDEF VCL}
    FRecordListGridFrame:TFrameCxGrid;
    {$ENDIF}
    {$IFDEF FMX}
    FRecordListGridFrame:TFrameDBGrid;
    {$ENDIF}
    //初始页面这个数据结构
    procedure InitPage(APage:uPageStructure.TPage);override;
//    procedure InitPageEnd(APage:uPageStructure.TPage);override;

    procedure CustomAfterLoad;override;
//    //自定义字段
//    procedure InitFieldDefs;virtual;
//    //自定义表格列
//    procedure InitColumns;virtual;
    //表格添加记录时初始数据集字段值
    procedure CustomDatasetAfterInsert(Sender:TObject;ADataset:TDataset);virtual;
//    //自定义调用接口获取数据的查询条件
//    function CustomGetRestDatasetPageCustomWhereKeyJson:String;virtual;
//
//    //页面保存结束事件
//    procedure DoPageInstanceAfterSaveRecord(Sender:TObject);override;

    //处理页面实例自己的Action
    procedure DoPageInstanceCustomProcessPageActionEvent(Sender:TObject;
                                                          AFromPageInstance:TPageInstance;
                                                          AAction:String;
                                                          AFieldControlSettingMap:TFieldControlSettingMap;
                                                          var AIsProcessed:Boolean);override;
    //获取创建子控件的父控件
    function GetPagePartLayoutParent(APagePart:String):TControl;override;

    procedure DoPageInstanceLoadDataTaskEnd(Sender:TObject;
                                           APageInstance:TPageInstance;
                                           ADataIntfResult: TDataIntfResult;
                                           ADataIntfResult2: TDataIntfResult);override;
    procedure DoModalResultExFromDeleteMesageBoxFrame(Sender:TObject;
                                                  AModalResult:String;
                                                  AModalResultName:String;
                                                  AInputEditText1:String;
                                                  AInputEditText2:String);

    //账号删除后删除对应本地文件
    function DoDeleteLocalFiles(ASelectedRecordList: ISuperArray): Boolean;virtual;

  public
    btnRefresh: TSkinButton;
    btnSaveGrid: TSkinButton;
    btnDelete: TSkinButton;
//    Splitter1: TSplitter;
//    FRecordList:ISuperArray;
    {$IFDEF VCL}
    //分页控制控件
    FGridSwitchPageFrame:TFrameGridSwitchPage_BaseTableManagePage;
    {$ENDIF}

  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    { Public declarations }
  end;




var
  FrameBaseTableManagePage: TFrameBaseTableManagePage;

function SaveDatasetToServer(AAppID:String;ADataset:TDataset;
                             ARecordList:ISuperArray;
                             AKeyFieldName:String;
                             ARestName:String;
                             AHasAppID:Boolean;
                             var ADesc:String):Boolean;

implementation

//{$R *.dfm}


function SaveDatasetToServer(AAppID:String;ADataset:TDataset;
                             ARecordList:ISuperArray;
                             AKeyFieldName:String;
                             ARestName:String;
                             AHasAppID:Boolean;
                             var ADesc:String):Boolean;
var
  AIsAdd:Boolean;
  ABookmark:TBookmark;
  ARecordJson:ISuperObject;
  ADataJson:ISuperObject;
  AKeyFieldValue:Variant;
begin
  //保存
  //遍历
  ABookmark:=ADataset.GetBookmark;
  ADataset.DisableControls;
  try
    ADataset.First;

    while not ADataset.Eof do
    begin

        if ADataset.FieldByName(AKeyFieldName).IsNull then
        begin
            //新添加的数据

            ARecordJson:=JsonFromRecord(ADataset,nil,False);

            //将页面记录保存到服务端
            if not SaveRecordToServer(InterfaceUrl,
                                      AAppID,
                                      '',
                                      '',
                                      ARestName,
                                      0,
                                      ARecordJson,
                                      //返回是否是新增的记录
                                      AIsAdd,
                                      ADesc,
                                      ADataJson,
                                      GlobalRestAPISignType,
                                      GlobalRestAPIAppSecret,
                                      AHasAppID) then
            begin
              Exit;
            end;

            ADataset.Edit;
            LoadRecordFromJson(ADataset,ADataJson);
            ADataset.Post;


        end
        else
        begin
            //修改的记录
            AKeyFieldValue:=ADataset.FieldByName(AKeyFieldName).AsVariant;
            ARecordJson:=LocateJsonArray(ARecordList,AKeyFieldName,AKeyFieldValue);

            if (ARecordJson<>nil) and not CompareRecordAndJsonIsSame(ADataset,ARecordJson) then
            begin
                ARecordJson:=JsonFromRecord(ADataset,nil,False);


                //将页面记录保存到服务端
                if not SaveRecordToServer(InterfaceUrl,
                                          AAppID,
                                          '',
                                          '',
                                          ARestName,
                                          AKeyFieldValue,
                                          ARecordJson,
                                          //返回是否是新增的记录
                                          AIsAdd,
                                          ADesc,
                                          ADataJson,
                                          GlobalRestAPISignType,
                                          GlobalRestAPIAppSecret,
                                          AHasAppID) then
                begin
                  Exit;
                end;


                ADataset.Edit;
                LoadRecordFromJson(ADataset,ADataJson);
                ADataset.Post;

            end;

        end;


        ADataset.Next;

    end;

    Result:=True;

  finally
    ADataset.EnableControls;
    ADataset.Bookmark:=ABookmark;
  end;

end;

procedure TFrameBaseTableManagePage.btnDeleteClick(Sender: TObject);
begin
  inherited;

//  //删除
//  Self.RestMemTable1.Delete;

end;

procedure TFrameBaseTableManagePage.btnRefreshClick(Sender: TObject);
begin
  inherited;

//  //刷新
//  RestMemTable1.Refresh;

//  Self.FPageInstance.LoadData(FPageInstance.FLoadDataSetting);
end;

//procedure TFrameBaseTableManagePage.btnSaveClick(Sender: TObject);
//begin
//  inherited;
////  //添加或者修改表格记录
////  Self.FPageInstance.FLoadDataSetting
//
//
//end;

procedure TFrameBaseTableManagePage.btnSaveGridClick(Sender: TObject);
var
  ADesc:String;
begin
  inherited;
//  //全部保存
//  if not SaveDatasetToServer(AppID,
//                              Self.RestMemTable1,
//                              Self.FRecordList,
//                              FPage.DataInterface.FKeyFieldName,
//                              FPage.DataInterface.Name,//FRestName,
//                              FPage.DataInterface.FHasAppID,
//                              ADesc) then
//  begin
//    ShowMessage(ADesc);
//    Exit;
//  end;

end;

constructor TFrameBaseTableManagePage.Create(AOwner: TComponent);
begin
  inherited;

//  btnRefresh:=TSkinWinButton;
//  btnSaveGrid:=TSkinWinButton;
//  btnDelete:=TSkinWinButton;
//  Splitter1: TSplitter;

  {$IFDEF VCL}
  FGridSwitchPageFrame:=TFrameGridSwitchPage_BaseTableManagePage.Create(Self);
  FGridSwitchPageFrame.Parent:=Self;
  FGridSwitchPageFrame.Align:=alBottom;
  FGridSwitchPageFrame.Visible:=False;
  FGridSwitchPageFrame.FPageInstance:=Self.FPageInstance;
  {$ENDIF}
//  FGridSwitchPageFrame.Load(RestMemTable1);
//
//
//  Self.cxGrid1DBTableView1.OptionsView.NoDataToDisplayInfoText:='';
//
//
//  //表结构已经建好了,每次获取数据之后不需要重建了
//  RestMemTable1.IsNeedReCreateFieldDefs:=False;


//  Self.pnlClient.Color:=clRed;
//  Self.pnlClient.ParentColor:=False;
//  Self.pnlClient.ParentBackground:=False;
//
//  Self.sbClient.Color:=clRed;

  {$IFDEF VCL}
  Self.pnlClient.Align:=alBottom;
  {$ENDIF}
  {$IFDEF FMX}
  Self.pnlClient.Align:=TAlignLayout.Bottom;
  {$ENDIF}
end;

procedure TFrameBaseTableManagePage.CustomDatasetAfterInsert(Sender: TObject;
  ADataset: TDataset);
begin

end;

//function TFrameBaseTableManagePage.CustomGetRestDatasetPageCustomWhereKeyJson: String;
//begin
//  Result:='';
//
//end;

procedure TFrameBaseTableManagePage.CustomAfterLoad;
//var
//  I: Integer;
//  AColumn:TcxGridDBColumn;
////  AColumnSettingJson:ISuperObject;
//  AFieldControlSetting:TFieldControlSetting;
begin

  inherited;

  //将输入区的高度设置为合适的内容高度即可
  Self.pnlClient.Height:=ControlSize(Self.PageInstance.MainControlMapList.FLayoutList.FListLayoutsManager.CalcContentHeight)+20;


  Self.FRecordListControlSettingMap:=Self.FPageInstance.FPagePartList.FindMap('RecordList');

  if FRecordListControlSettingMap<>nil then
  begin
    {$IFDEF VCL}
    if FRecordListControlSettingMap.Component is TFrameCxGrid then
    begin

      FRecordListGridFrame:=TFrameCxGrid(FRecordListControlSettingMap.Component);

//      Self.FGridSwitchPageFrame.Load(FRecordListGridFrame.RestMemTable1);

    end;
    {$ENDIF}
    {$IFDEF FMX}
    if FRecordListControlSettingMap.Component is TFrameDBGrid then
    begin

      FRecordListGridFrame:=TFrameDBGrid(FRecordListControlSettingMap.Component);

//      Self.FGridSwitchPageFrame.Load(FRecordListGridFrame.RestMemTable1);

    end;
    {$ENDIF}

  end;


  //将表格创建在Frame中
//  Self.FPageInstance.CreateControls()


//  //初始表格列
//  if Self.cxGrid1DBTableView1.ColumnCount=0 then
//  begin
//
////      //初始字段
////      InitFieldDefs;
//
//
//      InitColumns;
//      if (Self.FColumnsSettingArray=nil) then
//      begin
//        Exit;
//      end;

//      //将需要编辑的字段显示出来
//      for I := 0 to Self.cxGrid1DBTableView1.ColumnCount-1 do
//      begin
//        AColumn:=Self.cxGrid1DBTableView1.Columns[I];
//
//        AFieldControlSetting:=Self.FPage.MainLayoutControlList.FindByFieldName(AColumn.DataBinding.FieldName);
////        AColumnSettingJson:=LocateJsonArray(FColumnsSettingArray,'field_name',AColumn.DataBinding.FieldName);
////        if AColumnSettingJson=nil then
////        begin
////          AColumn.Visible:=False;
////          Continue;
////        end;
//        if AFieldControlSetting=nil then
//        begin
//          AColumn.Visible:=False;
//          Continue;
//        end;
//
////        AColumn.Visible:=(AColumnSettingJson.I['visible']=1);
////        AColumn.Editing:=(AColumnSettingJson.I['readonly']=0);
////        AColumn.Width:=AColumnSettingJson.I['Width'];
////        AColumn.Caption:=AColumnSettingJson.S['caption'];
//        AColumn.Visible:=(AFieldControlSetting.col_visible=1);
//        AColumn.Editing:=(AFieldControlSetting.readonly=0);
//        AColumn.Width:=Ceil(AFieldControlSetting.col_Width);
//        AColumn.Caption:=AFieldControlSetting.field_caption;
//      //设置顺序,单独脱离出来,不然这个循环的顺序就不对了
////      AColumn.Index:=AFieldControlSetting.Index;
//
//        if AFieldControlSetting.control_type='checkbox' then
//        begin
//          AColumn.PropertiesClass:=TcxCheckBoxProperties;
//          TcxCheckBoxProperties(AColumn.Properties).NullStyle:=nssUnchecked;
//          TcxCheckBoxProperties(AColumn.Properties).ValueChecked:=1;
//        end;
//
//
//      end;
//
//      //设置顺序,单独脱离出来
////      AColumn.Index:=AFieldControlSetting.Index;
//      for I := 0 to Self.FPage.MainLayoutControlList.Count-1 do
//      begin
//        AFieldControlSetting:=Self.FPage.MainLayoutControlList[I];
//        if AFieldControlSetting.col_visible=1 then
//        begin
//          AColumn:=Self.cxGrid1DBTableView1.GetColumnByFieldName(AFieldControlSetting.field_name);
//          if AColumn<>nil then
//          begin
//            AColumn.Index:=AFieldControlSetting.Index;
//          end;
//        end;
//
//      end;
//
//  end;


//  //获取数据
//  RestMemTable1.Refresh;



//  //刷新数据
//  Self.FPageInstance.Refresh;
//  FPageInstance.FLoadDataSetting.Clear;


  FPageInstance.FLoadDataSetting.PageIndex:=1;//Self.RestMemTable1.PageIndex;
  FPageInstance.FLoadDataSetting.PageSize:=100;//Self.RestMemTable1.PageSize;

//  FPageInstance.FLoadDataSetting.CustomWhereKeyJson:=Self.GetLoadDataCustomKeyJsonStr;//GetWhereKeyJson(['Zgdm','is_deleted'],[GlobalManager.User.fid,0]);

  FPageInstance.LoadData();



//  RestMemTable1.EmptyDataSet;
//
//  if ADataIntfResult.Succ then
//  begin
//    FRecordList:=ADataIntfResult.DataJson.A['RecordList'];
//
////    LoadDataFromJsonArray(Self.RestMemTable1,ADataIntfResult.DataJson.A['RecordList']);
////    LoadDataJsonTokbmMemTable(Self.RestMemTable1,ADataIntfResult.DataJson,'RecordList');
//
//
//    Self.RestMemTable1.LoadDataIntfResult(ADataIntfResult.DataJson,False);
//  end;

//  ACallAPIResult:=FPageInstance.FLoadDataIntfResult.Succ;
//  ADesc:=FPageInstance.FLoadDataIntfResult.Desc;
//  ADataJson:=FPageInstance.FLoadDataIntfResult.DataJson;
//
//
//  if FPageInstance.FLoadDataIntfResult.Succ then
//  begin
//    FRecordList:=FPageInstance.FLoadDataIntfResult.DataJson.A['RecordList'];
//    ACode:=SUCC;
//
////    LoadDataFromJsonArray(Self.RestMemTable1,ADataIntfResult.DataJson.A['RecordList']);
////    LoadDataJsonTokbmMemTable(Self.RestMemTable1,ADataIntfResult.DataJson,'RecordList');
//
//
////    Self.RestMemTable1.LoadDataIntfResult(FPageInstance.FLoadDataIntfResult.DataJson);
//  end
//  else
//  begin
//      ACode:=FAIL;
//
//  end;

//  //刷新数据
//  Self.FPageInstance.LoadData;

end;

//procedure TFrameBaseTableManagePage.cxGrid1DBTableView1CellClick(
//  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
//  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
////var
////  ARecordDataJson:ISuperObject;
//begin
////  inherited;
////
////  ARecordDataJson:=JsonFromRecord(Self.RestMemTable1);
////  Self.FPageInstance.LoadDataJsonToControls(ARecordDataJson);
//
//end;
//
//procedure TFrameBaseTableManagePage.cxGrid1DBTableView1CustomDrawIndicatorCell(
//  Sender: TcxGridTableView; ACanvas: TcxCanvas;
//  AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean);
//begin
//  inherited;
//
////  SetRowNumber(Sender, AviewInfo, ACanvas, ADone);
//
//end;

destructor TFrameBaseTableManagePage.Destroy;
begin

  inherited;
end;

procedure TFrameBaseTableManagePage.DoModalResultExFromDeleteMesageBoxFrame(
  Sender: TObject; AModalResult, AModalResultName, AInputEditText1,
  AInputEditText2: String);
var
  ASelectedRecordList:ISuperArray;
  I: Integer;
begin

  if AModalResultName='ok' then
  begin
      //批量删除
      //获取到选中的记录列表
      ASelectedRecordList:=FRecordListGridFrame.GetSelectedRecordList;

      for I := 0 to ASelectedRecordList.Length-1 do
      begin
        //删除
//        AFromPageInstance.LoadCurrentRecordDataJsonToControls(ASelectedRecordList.O[I]);
        //调用接口,获取数据,显示在界面上
        Self.FPageInstance.FCurrentRecordDataIntfResult.DataType:=ldtJson;
        Self.FPageInstance.FCurrentRecordDataIntfResult.Succ:=True;
        Self.FPageInstance.FCurrentRecordDataIntfResult.Desc:='数据加载成功';
        Self.FPageInstance.FCurrentRecordDataIntfResult.DataJson:=ASelectedRecordList.O[I];
        Self.FPageInstance.DataInterface.DelData(FPageInstance.FLoadDataSetting,
            Self.FPageInstance.FCurrentRecordDataIntfResult,
            Self.FPageInstance.FDelDataIntfResult
            );

      end;

      //账号删除完毕后删除账号对应本地文件
      DoDeleteLocalFiles(ASelectedRecordList);

      //再刷新一下
      Self.FPageInstance.LoadData();

  end;

end;

function TFrameBaseTableManagePage.DoDeleteLocalFiles(
  ASelectedRecordList: ISuperArray): Boolean;
begin
  //
end;

procedure TFrameBaseTableManagePage.DoPageInstanceCustomProcessPageActionEvent(Sender:TObject;
                                                          AFromPageInstance:TPageInstance;
                                                          AAction:String;
                                                          AFieldControlSettingMap:TFieldControlSettingMap;
                                                          var AIsProcessed:Boolean);
begin
  if SameText(AAction,Const_PageAction_DelRecord) then
  begin

      //弹出对话框
      ShowMessageBoxFrame(nil,'确认删除？','',TMsgDlgType.mtInformation,OK_CANCEL_CAPTIONS,
                                            nil,nil,''
                                            ,ConvertToStringDynArray(OK_CANCEL_NAMES),
                                            nil,0,
                                            DoModalResultExFromDeleteMesageBoxFrame
                                            );



      AIsProcessed:=True;
      Exit;
  end;

  inherited;

end;

procedure TFrameBaseTableManagePage.DoPageInstanceLoadDataTaskEnd(
  Sender: TObject; APageInstance: TPageInstance; ADataIntfResult,
  ADataIntfResult2: TDataIntfResult);
begin
  inherited;

  {$IFDEF VCL}
  Self.FGridSwitchPageFrame.DoRestMemTableChange(nil);
  {$ENDIF}
end;

//procedure TFrameBaseTableManagePage.DoPageInstanceAfterSaveRecord(
//  Sender: TObject);
//begin
//  inherited;
//
////  //如果保存失败、更新的数据为空,那么不会返回DataJson
////  if Self.FPageInstance.FSaveDataIntfResult.DataJson<>nil then
////  begin
////    if Self.FPageInstance.FLoadDataSetting.IsAddRecord then
////    begin
////      Self.RestMemTable1.Append;
////    end
////    else
////    begin
////      Self.RestMemTable1.Edit;
////    end;
////    try
////      uJsonToDataset.LoadRecordFromJson(Self.RestMemTable1,Self.FPageInstance.FSaveDataIntfResult.DataJson)
////    finally
////      Self.RestMemTable1.Post;
////    end;
////  end;
//end;

function TFrameBaseTableManagePage.GetPagePartLayoutParent(
  APagePart: String): TControl;
begin
  if APagePart=Const_PagePart_Grid then
  begin
    Result:=Self;
  end
  else
  begin
    Result:=Inherited;
  end;
end;

//procedure TFrameBaseTableManagePage.InitColumns;
//begin
//  //创建所有的列
//  Self.cxGrid1DBTableView1.DataController.CreateAllItems();
//
//
//end;

//procedure TFrameBaseTableManagePage.InitFieldDefs;
//var
//  ACode:Integer;
//  ADesc:String;
//  ADataJson:ISuperObject;
//begin
//  //获取字段列表
//  if not SimpleCallAPI('get_field_list',
//                       nil,
//                       TableRestCenterInterfaceUrl,
//                      ['appid',
//                      'rest_name'
//                      ],
//                      [AppID,
//                      FPage.DataInterface.Name//FRestName
//                      ],
//                      ACode,
//                      ADesc,
//                      ADataJson,
//                      GlobalRestAPISignType,
//                      GlobalRestAPIAppSecret
//                      ) or (ACode<>SUCC) then
//  begin
//    ShowMessage(ADesc);
//    Exit;
//  end;
//
//  //if ADataJson.A['RecordList'] then
//  LoadMemTableFeildDefsByFieldDefArray(Self.RestMemTable1,ADataJson.A['FieldList']);
//
//
//
//end;

procedure TFrameBaseTableManagePage.InitPage(APage: uPageStructure.TPage);
begin
  inherited;
  //初始页面结构
  FPage.page_type:=Const_PageType_TableManagePage;


  //将按钮放在上面去

end;

//procedure TFrameBaseTableManagePage.InitPageEnd(APage: uPageStructure.TPage);
//begin
//  inherited;
//
////  //删除ListView控件
////  if Self.FPage.MainLayoutControlList.FindByFieldName('RecordList')<>nil then
////  begin
////    Self.FPage.MainLayoutControlList.FindByFieldName('RecordList').Free;
////  end;
//
//end;

procedure TFrameBaseTableManagePage.RestMemTable1AfterInsert(DataSet: TDataSet);
begin
  inherited;
  CustomDatasetAfterInsert(Self,DataSet);

end;

procedure TFrameBaseTableManagePage.RestMemTable1BeforeDelete(
  DataSet: TDataSet);
//var
//  AIsAdd:Boolean;
//  ADesc:String;
//  ARecordJson:ISuperObject;
//  ADataJson:ISuperObject;
//  AKeyFieldValue:Variant;
begin

  inherited;

//  if not Dataset.FieldByName(FPage.DataInterface.FKeyFieldName).IsNull then
//  begin
//
//    //记录下删除的主键
//    AKeyFieldValue:=Dataset.FieldByName(FPage.DataInterface.FKeyFieldName).AsVariant;
//    ARecordJson:=LocateJsonArray(FRecordList,FPage.DataInterface.FKeyFieldName,AKeyFieldValue);
//    //标记为已删除
//    ARecordJson.I[FPage.DataInterface.FDeletedFieldName]:=1;
//
//
//    //直接删除
//    //将页面记录保存到服务端
//    if not SaveRecordToServer(InterfaceUrl,
//                              AppID,
//                              '',
//                              '',
//                              FPage.DataInterface.Name,//FRestName,
//                              AKeyFieldValue,
//                              ARecordJson,
//                              AIsAdd,
//                              ADesc,
//                              ADataJson,
//                              GlobalRestAPISignType,
//                              GlobalRestAPIAppSecret,
//                              FPage.DataInterface.FHasAppID
//                              ) then
//    begin
//      Exit;
//    end;
//
//  end;

end;

procedure TFrameBaseTableManagePage.RestMemTable1GetRestDatasetPage(
  Sender: TObject; var ACallAPIResult: Boolean; var ACode: Integer;
  var ADesc: string; var ADataJson: ISuperObject);
begin
  inherited;
////  FPageInstance.FLoadDataSetting.Clear;
//  FPageInstance.FLoadDataSetting.PageIndex:=Self.RestMemTable1.PageIndex;
//  FPageInstance.FLoadDataSetting.PageSize:=Self.RestMemTable1.PageSize;
//
//  FPageInstance.FLoadDataSetting.CustomWhereKeyJson:=Self.GetCustomKeyJsonStr;//GetWhereKeyJson(['Zgdm','is_deleted'],[GlobalManager.User.fid,0]);
//
//  FPageInstance.LoadData();
//
////  RestMemTable1.EmptyDataSet;
////
////  if ADataIntfResult.Succ then
////  begin
////    FRecordList:=ADataIntfResult.DataJson.A['RecordList'];
////
//////    LoadDataFromJsonArray(Self.RestMemTable1,ADataIntfResult.DataJson.A['RecordList']);
//////    LoadDataJsonTokbmMemTable(Self.RestMemTable1,ADataIntfResult.DataJson,'RecordList');
////
////
////    Self.RestMemTable1.LoadDataIntfResult(ADataIntfResult.DataJson,False);
////  end;
//
//  ACallAPIResult:=FPageInstance.FLoadDataIntfResult.Succ;
//  ADesc:=FPageInstance.FLoadDataIntfResult.Desc;
//  ADataJson:=FPageInstance.FLoadDataIntfResult.DataJson;
//
//
//  if FPageInstance.FLoadDataIntfResult.Succ then
//  begin
//    FRecordList:=FPageInstance.FLoadDataIntfResult.DataJson.A['RecordList'];
//    ACode:=SUCC;
//
////    LoadDataFromJsonArray(Self.RestMemTable1,ADataIntfResult.DataJson.A['RecordList']);
////    LoadDataJsonTokbmMemTable(Self.RestMemTable1,ADataIntfResult.DataJson,'RecordList');
//
//
////    Self.RestMemTable1.LoadDataIntfResult(FPageInstance.FLoadDataIntfResult.DataJson);
//  end
//  else
//  begin
//      ACode:=FAIL;
//
//  end;


end;

//procedure TFrameBaseTableManagePage.SetRowNumber(var Sender: TcxGridTableView;
//  var AViewInfo: TcxCustomGridIndicatorItemViewInfo; ACanvas: TcxCanvas;
//  var ADone: boolean);
//var
//  AIndicatorViewInfo: TcxGridIndicatorRowItemViewInfo;
//  ATextRect: TRect;
//  AFont: TFont;
//  AFontTextColor, AColor: TColor;
//  procedure DrawIndicatorImage(ACanvas: TcxCanvas;
//    const R: TRect; AKind: TcxIndicatorKind);
//  var
//    X, Y: Integer;
//  begin
//    if AKind = ikNone then Exit;
//    X := (R.Left + R.Right - cxLookAndFeelPainters.cxIndicatorImages.Width);
//    Y := (R.Top + R.Bottom - cxLookAndFeelPainters.cxIndicatorImages.Height) div 2;
//    cxLookAndFeelPainters.cxIndicatorImages.Draw(ACanvas.Canvas, X, Y, Ord(AKind) - 1);
//  end;
//begin
//  try
//    AFont := ACanvas.Font;
//    AColor := clBtnFace;
//    AFontTextColor := clWindowText;
//    if (AViewInfo is TcxGridIndicatorHeaderItemViewInfo) then begin
//      ATextRect := AViewInfo.Bounds;
//      InflateRect(ATextRect, -1, -1);
//      Sender.LookAndFeelPainter.DrawHeader(ACanvas, AViewInfo.Bounds,
//        ATextRect, [], cxBordersAll, cxbsNormal, taCenter, TcxAlignmentVert.vaCenter,
//        False, False, '序号', AFont, AFontTextColor, AColor);
//      ADone := True;
//    end;
//    if not (AViewInfo is TcxGridIndicatorRowItemViewInfo) then
//      Exit;
//    ATextRect := AViewInfo.ContentBounds;
//    AIndicatorViewInfo := AViewInfo as TcxGridIndicatorRowItemViewInfo;
//    InflateRect(ATextRect, -1, -1);
//    if Sender.DataController.RecordCount > 0 then begin
//      if (AIndicatorViewInfo.GridRecord<>nil) and AIndicatorViewInfo.GridRecord.Selected then
//        AFontTextColor := clRed
//      else
//        AFontTextColor := clWindowText;
//    end;
//    Sender.LookAndFeelPainter.DrawHeader(ACanvas, AViewInfo.ContentBounds,
//      ATextRect, [], [bBottom, bLeft, bRight], cxbsNormal, taCenter, TcxAlignmentVert.vaCenter,
//      False, False, IntToStr(AIndicatorViewInfo.GridRecord.Index + 1),
//      AFont, AFontTextColor, AColor);
//    ADone := True;
//  except
//  end;
//  DrawIndicatorImage(ACanvas, ATextRect, AIndicatorViewInfo.IndicatorKind);
//
//
//end;
{$IFDEF VCL}
{ TFrameGridSwitchPage_BaseTableManagePage }

procedure TFrameGridSwitchPage_BaseTableManagePage.btnFirstPageClick(
  Sender: TObject);
begin
//  inherited;
  FPageInstance.FLoadDataSetting.PageIndex:=1;
  Self.edtPageIndex.Text:=IntToStr(FPageInstance.FLoadDataSetting.PageIndex);
  FPageInstance.LoadData();
end;

procedure TFrameGridSwitchPage_BaseTableManagePage.btnLastPageClick(
  Sender: TObject);
begin
//  inherited;
  FPageInstance.FLoadDataSetting.PageIndex:=FPageInstance.FLoadDataSetting.PageCount;
  Self.edtPageIndex.Text:=IntToStr(FPageInstance.FLoadDataSetting.PageIndex);
  FPageInstance.LoadData();
end;

procedure TFrameGridSwitchPage_BaseTableManagePage.btnNextPageClick(
  Sender: TObject);
begin
//  inherited;
  FPageInstance.FLoadDataSetting.PageIndex:=FPageInstance.FLoadDataSetting.PageIndex+1;
  Self.edtPageIndex.Text:=IntToStr(FPageInstance.FLoadDataSetting.PageIndex);
  FPageInstance.LoadData();
end;

procedure TFrameGridSwitchPage_BaseTableManagePage.btnPriorPageClick(
  Sender: TObject);
begin
//  inherited;
  FPageInstance.FLoadDataSetting.PageIndex:=FPageInstance.FLoadDataSetting.PageIndex-1;
  Self.edtPageIndex.Text:=IntToStr(FPageInstance.FLoadDataSetting.PageIndex);
  FPageInstance.LoadData();
end;

procedure TFrameGridSwitchPage_BaseTableManagePage.btnRefreshClick(
  Sender: TObject);
begin
//  inherited;
  FPageInstance.LoadData();
end;

procedure TFrameGridSwitchPage_BaseTableManagePage.DoRestMemTableChange(
  Sender: TObject);
begin
//  inherited;

  Self.edtPageIndex.Text:=IntToStr(FPageInstance.FLoadDataSetting.PageIndex);
  Self.cmbPageSize.Text:=IntToStr(FPageInstance.FLoadDataSetting.PageSize);

  Self.lblPageCount.Caption:=IntToStr(FPageInstance.FLoadDataSetting.PageCount);

end;

procedure TFrameGridSwitchPage_BaseTableManagePage.edtPageIndexKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//  inherited;

  if Key=13 then
  begin
    FPageInstance.FLoadDataSetting.PageIndex:=StrToInt(Self.edtPageIndex.Text);
    FPageInstance.LoadData();
  end;

end;
{$ENDIF}

end.
