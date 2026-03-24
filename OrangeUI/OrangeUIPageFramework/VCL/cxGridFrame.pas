unit cxGridFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasePageFrame, uSkinWindowsControl, Math,
  Vcl.ExtCtrls,

  Clipbrd,
//  uFuncCommon,
  XSuperObject,
  uComponentType,
  uGraphicCommon,
  uBaseLog,
//  uRestInterfaceCall,
//  uManager,
//  uDatasetToJson,
//  uJsonToDataset,
  uOpenClientCommon,
  uOpenCommon,
//  uTimerTask,
//  SelectPopupForm,
//  GridSwitchPageFrame,
  uPageStructure,
  uBasePageStructure,
  uDataInterface,
  uRestInterfaceCall,
  uJsonToDataset,
  uDatasetToJson,
//  uDataInterface,
//  BaseEditPageFrame,
//  uTableCommonRestCenter,
//  EasyServiceCommonMaterialDataMoudle_VCL,

  uSkinButtonType, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uRestIntfMemTable, cxCheckBox,
  cxLabel;

type
  TFrameCxGrid = class(TFrame,IControlForPageFramework,IPageFrameworkListControl)
    DataSource1: TDataSource;
    RestMemTable1: TRestMemTable;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    procedure RestMemTable1AfterInsert(DataSet: TDataSet);
    procedure RestMemTable1BeforeDelete(DataSet: TDataSet);
    procedure RestMemTable1GetRestDatasetPage(Sender: TObject;
      var ACallAPIResult: Boolean; var ACode: Integer; var ADesc: string;
      var ADataJson: ISuperObject);
    procedure btnSaveGridClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cxGrid1DBTableView1CustomDrawIndicatorCell(
      Sender: TcxGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean);
    procedure cxGrid1DBTableView1FocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGrid1DBTableView1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure SetRowNumber(var Sender: TcxGridTableView; var AViewInfo: TcxCustomGridIndicatorItemViewInfo; ACanvas: TcxCanvas; var ADone: boolean);
    { Private declarations }
  protected
    FFieldControlSettingMap:TFieldControlSettingMap;
    //针对页面框架的控件接口
    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting;AFieldControlSettingMap:TObject):Boolean;
    //获取与设置自定义属性
    function GetPropJsonStr:String;
    procedure SetPropJsonStr(AJsonStr:String);
    //获取提交的值,是不是存在多个值
    function GetPostValue(ASetting:TFieldControlSetting;APageDataDir:String;ASetRecordFieldValueIntf:ISetRecordFieldValue;
                            var AErrorMessage:String):Variant;
    //设置值
    procedure SetControlValue(ASetting:TFieldControlSetting;APageDataDir:String;
                            AImageServerUrl:String;
                            AValue:Variant;AValueCaption:String;
                            //要设置多个值,整个字段的记录
                            AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue
                            );
//    //设置属性
//    function GetProp(APropName:String):Variant;
//    procedure SetProp(APropName:String;APropValue:Variant);
    procedure DoReturnFrame(AFromFrame:TFrame);virtual;
  public
    FOnFocusedRecordChange:TFocusedRecordChangeEvent;
    procedure SetOnFocusedRecordChange(AValue:TFocusedRecordChangeEvent);
//    procedure AddRecord(ARecordDataJson:ISuperObject);
//    procedure UpdateRecord(ARecordDataJson:ISuperObject);
    procedure SaveDataIntfResult(ALoadDataSetting:TLoadDataSetting;ADataIntfResult:TDataIntfResult);
    procedure DeleteRecord(ADataIntfResult:TDataIntfResult);
    //获取到选中的记录列表
    function GetSelectedRecordList:ISuperArray;
    //设置列表控件的值
    procedure SetListControlValue(ASetting:TFieldControlSetting;
                                  APageDataDir:String;
                                  AImageServerUrl:String;
                                  AValue:Variant;
                                  AValueCaption:String;
                                  //如果值是一个数组
                                  AValueArray:ISuperArray;
                                  AValueObject:TObject;
                                  //要设置多个值,整个字段的记录
                                  AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue;
                                  ALoadDataIntfResult:TDataIntfResult;
                                  ALoadDataIntfResult2:TDataIntfResult);

  protected
//    //初始页面这个数据结构
//    procedure InitPage(APage:uPageStructure.TPage);override;
//    procedure InitPageEnd(APage:uPageStructure.TPage);override;

//    procedure CustomAfterInit;override;
//    //自定义字段
//    procedure InitFieldDefs;virtual;
//    //自定义表格列
//    procedure InitColumns;virtual;
//    //表格添加记录时初始数据集字段值
//    procedure CustomDatasetAfterInsert(Sender:TObject;ADataset:TDataset);virtual;
////    //自定义调用接口获取数据的查询条件
////    function CustomGetRestDatasetPageCustomWhereKeyJson:String;virtual;
//
//    //页面保存结束事件
//    procedure DoPageInstanceAfterSaveRecord(Sender:TObject);override;
//
//    //处理页面实例自己的Action
//    procedure DoPageInstanceCustomProcessPageActionEvent(Sender:TObject;
//                                            AFromPageInstance:TPageInstance;
//                                            AAction:String;
//                                            var AIsProcessed:Boolean);override;
//  public
//    FRecordList:ISuperArray;
//    //分页控制控件
//    FGridSwitchPageFrame:TFrameGridSwitchPage;

  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    { Public declarations }
  end;




var
  FrameCxGrid: TFrameCxGrid;

function FindGridColumnByFieldName(AcxGridTableView:TcxGridDBTableView;AFieldName:String):TcxGridColumn;


implementation

{$R *.dfm}


function FindGridColumnByFieldName(AcxGridTableView:TcxGridDBTableView;AFieldName:String):TcxGridColumn;
var
  I:Integer;
begin
  Result:=nil;
  //先隐藏全部
  for I := 0 to AcxGridTableView.ColumnCount-1 do
  begin
//    AcxGridTableView.Columns[I].Visible:=False;
    if AcxGridTableView.Columns[I].DataBinding.FieldName=AFieldName then
    begin
      Result:=AcxGridTableView.Columns[I];
      Break;
    end;
  end;
end;


//procedure TFrameCxGrid.AddRecord(ARecordDataJson: ISuperObject);
//begin
//  //如果保存失败、更新的数据为空,那么不会返回DataJson
//  Self.RestMemTable1.Append;
//  try
//    uJsonToDataset.LoadRecordFromJson(Self.RestMemTable1,ARecordDataJson)
//  finally
//    Self.RestMemTable1.Post;
//  end;
//
//end;

procedure TFrameCxGrid.btnRefreshClick(Sender: TObject);
begin
  inherited;

  //刷新
  RestMemTable1.Refresh;

//  Self.FPageInstance.LoadData(FPageInstance.FLoadDataSetting);
end;

procedure TFrameCxGrid.btnSaveClick(Sender: TObject);
begin
  inherited;
//  //添加或者修改表格记录
//  Self.FPageInstance.FLoadDataSetting


end;

procedure TFrameCxGrid.btnSaveGridClick(Sender: TObject);
//var
//  ADesc:String;
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

constructor TFrameCxGrid.Create(AOwner: TComponent);
begin
  inherited;


//  FGridSwitchPageFrame:=TFrameGridSwitchPage.Create(Self);
//  FGridSwitchPageFrame.Parent:=Self;
//  FGridSwitchPageFrame.Align:=alBottom;
//  FGridSwitchPageFrame.Visible:=False;
//  FGridSwitchPageFrame.Load(RestMemTable1);


  Self.cxGrid1DBTableView1.OptionsView.NoDataToDisplayInfoText:='';
  Self.cxGrid1DBTableView1.OptionsCustomize.ColumnFiltering:=False;


  //表结构已经建好了,每次获取数据之后不需要重建了
  RestMemTable1.IsNeedReCreateFieldDefs:=False;


end;

//procedure TFrameCxGrid.CustomDatasetAfterInsert(Sender: TObject;
//  ADataset: TDataset);
//begin
//
//end;

//function TFrameBaseTableManagePage.CustomGetRestDatasetPageCustomWhereKeyJson: String;
//begin
//  Result:='';
//
//end;

//procedure TFrameCxGrid.CustomAfterInit;
//var
//  I: Integer;
//  AColumn:TcxGridDBColumn;
////  AColumnSettingJson:ISuperObject;
//  AFieldControlSetting:TFieldControlSetting;
//begin
//  inherited;
//
//
//
//  //顶部工具栏控件
//
//
//  //初始表格列
//  if Self.cxGrid1DBTableView1.ColumnCount=0 then
//  begin
//
//      //初始字段
//      InitFieldDefs;
//
//
//      InitColumns;
////      if (Self.FColumnsSettingArray=nil) then
////      begin
////        Exit;
////      end;
//
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
//
//
////  //获取数据
////  RestMemTable1.Refresh;
//
//
//
////  //刷新数据
////  Self.FPageInstance.Refresh;
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
////  ACallAPIResult:=FPageInstance.FLoadDataIntfResult.Succ;
////  ADesc:=FPageInstance.FLoadDataIntfResult.Desc;
////  ADataJson:=FPageInstance.FLoadDataIntfResult.DataJson;
////
////
////  if FPageInstance.FLoadDataIntfResult.Succ then
////  begin
////    FRecordList:=FPageInstance.FLoadDataIntfResult.DataJson.A['RecordList'];
////    ACode:=SUCC;
////
//////    LoadDataFromJsonArray(Self.RestMemTable1,ADataIntfResult.DataJson.A['RecordList']);
//////    LoadDataJsonTokbmMemTable(Self.RestMemTable1,ADataIntfResult.DataJson,'RecordList');
////
////
//////    Self.RestMemTable1.LoadDataIntfResult(FPageInstance.FLoadDataIntfResult.DataJson);
////  end
////  else
////  begin
////      ACode:=FAIL;
////
////  end;
//
////  //刷新数据
////  Self.FPageInstance.LoadData;
//
//end;

procedure TFrameCxGrid.cxGrid1DBTableView1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  AText:String;
  AFieldName:String;
  AColumn:TcxGridDBColumn;
  APageInstance:TPageInstance;
  AFieldControlSettingMap:TFieldControlSettingMap;
begin
//  APageInstance:=TFieldControlSettingMapList(FFieldControlSettingMap.FSkinListIntf.GetObject).PageInstance;
  APageInstance:=FFieldControlSettingMap.FOwner.PageInstance;


  //保存当前单元格的值
  AColumn:=Self.cxGrid1DBTableView1.Columns[ACellViewInfo.Item.Index];
  AFieldName:=AColumn.DataBinding.FieldName;
  AFieldControlSettingMap:=APageInstance.FPagePartList.FindMap(AFieldName);


  //ColumnGetDisplayText
  AText:=Sender.DataController.GetDisplayText(ACellViewInfo.RecordViewInfo.Index,ACellViewInfo.Item.Index);
  if Assigned(AColumn.OnGetDisplayText) then
  begin
    AColumn.OnGetDisplayText(AColumn,ACellViewInfo.GridRecord,AText);
  end;


  AFieldControlSettingMap.Value:=AText;

  //点击的是哪一列
  APageInstance.DoCustomPageAction(Const_PageAction_ClickCell,AFieldControlSettingMap);





end;

procedure TFrameCxGrid.cxGrid1DBTableView1CustomDrawIndicatorCell(
  Sender: TcxGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxCustomGridIndicatorItemViewInfo; var ADone: Boolean);
begin
  inherited;

  SetRowNumber(Sender, AviewInfo, ACanvas, ADone);

end;

procedure TFrameCxGrid.cxGrid1DBTableView1FocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
var
  ARecordDataJson:ISuperObject;
begin
  //
  ARecordDataJson:=JsonFromRecord(Self.RestMemTable1);
//  Self.FPageInstance.LoadDataJsonToControls(ARecordDataJson);
  if Assigned(FOnFocusedRecordChange) then
  begin
    FOnFocusedRecordChange(Self,ARecordDataJson);
  end;
end;

procedure TFrameCxGrid.cxGrid1DBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  AStr:String;
begin
//  if(ssCtrl in Shift) then
//  begin
//    if( Key = Ord('C')) then
//    begin
//      //Ctrl + C
//      try
//        AStr := cxGrid1DBTableView1.Controller.FocusedRecord.DisplayTexts[cxGrid1DBTableView1.Controller.FocusedItem.Index];
//        Clipboard.AsText := AStr;
//      except
//      end;
//    end;
//  end;


end;

procedure TFrameCxGrid.DeleteRecord(ADataIntfResult:TDataIntfResult);
begin
  if Self.RestMemTable1.Locate('fid',ADataIntfResult.DataJson.I['fid'],[]) then
  begin
    Self.RestMemTable1.Delete;
  end;
end;

destructor TFrameCxGrid.Destroy;
begin

  inherited;
end;

procedure TFrameCxGrid.DoReturnFrame(AFromFrame: TFrame);
begin

end;

function TFrameCxGrid.GetPostValue(ASetting: TFieldControlSetting;
  APageDataDir: String; ASetRecordFieldValueIntf: ISetRecordFieldValue;
  var AErrorMessage: String): Variant;
begin
  Result:='';
end;

//function TFrameCxGrid.GetProp(APropName: String): Variant;
//begin
//
//end;

function TFrameCxGrid.GetPropJsonStr: String;
begin

end;

function TFrameCxGrid.GetSelectedRecordList: ISuperArray;
var
  I:Integer;
  ASelectedRecordIndex:Integer;
  ASuperObject:ISuperObject;
  ABookmark:TBookmark;
begin
  Result:=TSuperArray.Create();
  ABookmark:=Self.RestMemTable1.Bookmark;
  try

      for I := 0 to Self.cxGrid1DBTableView1.Controller.SelectedRecordCount-1 do
      begin
        ASelectedRecordIndex:=Self.cxGrid1DBTableView1.Controller.SelectedRecords[I].RecordIndex;
    //    AFID:=StrToInt(Self.cxGrid1DBTableView1.DataController.GetDisplayText(ASelectedIndex,AFIDColumn.Index));
    //    ASuperArray.I[I]:=AFID;
        RestMemTable1.RecNo:=ASelectedRecordIndex+1;
        ASuperObject:=JsonFromRecord(RestMemTable1);
        Result.O[Result.Length]:=ASuperObject;
      end;

  finally
    Self.RestMemTable1.Bookmark:=ABookmark;
  end;

end;

function TFrameCxGrid.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting;AFieldControlSettingMap:TObject): Boolean;
var
  ACode:Integer;
  ADesc:String;
  ADataJson:ISuperObject;
var
  I: Integer;
  AColumn:TcxGridDBColumn;
//  AColumnSettingJson:ISuperObject;
  AFieldControlSetting:TFieldControlSetting;
  APage:TPage;
begin

      APage:=TPageFieldControlSettingList(ASetting.Collection).FOwner;
      FFieldControlSettingMap:=TFieldControlSettingMap(AFieldControlSettingMap);


      //获取字段列表
//      if not SimpleCallAPI('get_field_list',
//                           nil,
//                           TableRestCenterInterfaceUrl,
//                          ['appid',
//                          'rest_name'
//                          ],
//                          [AppID,
//                          APage.DataInterface.Name//FRestName
//                          ],
//                          ACode,
//                          ADesc,
//                          ADataJson,
//                          GlobalRestAPISignType,
//                          GlobalRestAPIAppSecret
//                          ) or (ACode<>SUCC) then
//      begin
//        ShowMessage(ADesc);
//        Exit;
//      end;
      if not APage.DataInterface.GetFieldList(AppID,ADesc,ADataJson) then
      begin
        uBaseLog.HandleException(nil,'TFrameCxGrid.LoadFromFieldControlSetting 获取字段列表失败 '+ADesc);
        raise Exception.Create('TFrameCxGrid.LoadFromFieldControlSetting '+ADesc);
        Exit;
      end;



      //if ADataJson.A['RecordList'] then
      LoadMemTableFeildDefsByFieldDefArray(Self.RestMemTable1,ADataJson.A['FieldList']);

      //创建所有的列
      Self.cxGrid1DBTableView1.DataController.CreateAllItems();





      //将需要编辑的字段显示出来,不需要的字段隐藏掉
      for I := 0 to Self.cxGrid1DBTableView1.ColumnCount-1 do
      begin
        AColumn:=Self.cxGrid1DBTableView1.Columns[I];

        AFieldControlSetting:=APage.MainLayoutControlList.FindByFieldName(AColumn.DataBinding.FieldName);
//        AColumnSettingJson:=LocateJsonArray(FColumnsSettingArray,'field_name',AColumn.DataBinding.FieldName);
//        if AColumnSettingJson=nil then
//        begin
//          AColumn.Visible:=False;
//          Continue;
//        end;
        if AFieldControlSetting=nil then
        begin
          AColumn.Visible:=False;
          Continue;
        end;

//        AColumn.Visible:=(AColumnSettingJson.I['visible']=1);
//        AColumn.Editing:=(AColumnSettingJson.I['readonly']=0);
//        AColumn.Width:=AColumnSettingJson.I['Width'];
//        AColumn.Caption:=AColumnSettingJson.S['caption'];
        AColumn.Visible:=(AFieldControlSetting.col_visible=1);
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


      end;




      for I := 0 to APage.MainLayoutControlList.Count-1 do
      begin
        AFieldControlSetting:=APage.MainLayoutControlList[I];
        if (AFieldControlSetting.field_name<>'') and (AFieldControlSetting.col_visible=1) then
        begin
          AColumn:=Self.cxGrid1DBTableView1.GetColumnByFieldName(AFieldControlSetting.field_name);
          if AColumn=nil then
          begin
            //如果列不存在,则创建
            AColumn:=Self.cxGrid1DBTableView1.CreateColumn;
            AColumn.DataBinding.FieldName:=AFieldControlSetting.field_name;
//            AColumn.Caption:=AFieldControlSetting.field_caption;
//            AColumn.Width:=AFieldControlSetting.col_width;
//            AColumn.Visible:=True;
          end;



  //        AColumn.Visible:=(AColumnSettingJson.I['visible']=1);
  //        AColumn.Editing:=(AColumnSettingJson.I['readonly']=0);
  //        AColumn.Width:=AColumnSettingJson.I['Width'];
  //        AColumn.Caption:=AColumnSettingJson.S['caption'];

          //
          AColumn.Visible:=(AFieldControlSetting.col_visible=1);
          AColumn.Editing:=(AFieldControlSetting.readonly=0);
          AColumn.Width:=Ceil(AFieldControlSetting.col_Width);
          AColumn.Caption:=AFieldControlSetting.field_caption;
        //设置顺序,单独脱离出来,不然这个循环的顺序就不对了
  //      AColumn.Index:=AFieldControlSetting.Index;

          if AFieldControlSetting.control_type='checkbox' then
          begin
            AColumn.PropertiesClass:=TcxCheckBoxProperties;
            TcxCheckBoxProperties(AColumn.Properties).NullStyle:=nssUnchecked;
            TcxCheckBoxProperties(AColumn.Properties).ValueChecked:=1;
          end;



        end;

      end;



      //设置顺序,单独脱离出来
//      AColumn.Index:=AFieldControlSetting.Index;
      for I := 0 to APage.MainLayoutControlList.Count-1 do
      begin
        AFieldControlSetting:=APage.MainLayoutControlList[I];
        if AFieldControlSetting.col_visible=1 then
        begin
          AColumn:=Self.cxGrid1DBTableView1.GetColumnByFieldName(AFieldControlSetting.field_name);
          if AColumn<>nil then
          begin
            AColumn.Index:=AFieldControlSetting.Index;
          end;
        end;

      end;


end;

//procedure TFrameCxGrid.DoPageInstanceAfterSaveRecord(
//  Sender: TObject);
//begin
//  inherited;
//
//  //如果保存失败、更新的数据为空,那么不会返回DataJson
//  if Self.FPageInstance.FSaveDataIntfResult.DataJson<>nil then
//  begin
//    if Self.FPageInstance.FLoadDataSetting.IsAddRecord then
//    begin
//      Self.RestMemTable1.Append;
//    end
//    else
//    begin
//      Self.RestMemTable1.Edit;
//    end;
//    try
//      uJsonToDataset.LoadRecordFromJson(Self.RestMemTable1,Self.FPageInstance.FSaveDataIntfResult.DataJson)
//    finally
//      Self.RestMemTable1.Post;
//    end;
//  end;
//end;
//
//procedure TFrameCxGrid.InitColumns;
//begin
//  //创建所有的列
//  Self.cxGrid1DBTableView1.DataController.CreateAllItems();
//
//
//end;
//
//procedure TFrameCxGrid.InitFieldDefs;
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
//
//procedure TFrameCxGrid.InitPage(APage: uPageStructure.TPage);
//begin
//  inherited;
//  //初始页面结构
//  FPage.page_type:=Const_PageType_TableManagePage;
//end;
//
//procedure TFrameCxGrid.InitPageEnd(APage: uPageStructure.TPage);
//begin
//  inherited;
//
//  //删除ListView控件
//  if Self.FPage.MainLayoutControlList.FindByFieldName('RecordList')<>nil then
//  begin
//    Self.FPage.MainLayoutControlList.FindByFieldName('RecordList').Free;
//  end;
//
//end;

procedure TFrameCxGrid.RestMemTable1AfterInsert(DataSet: TDataSet);
begin
  inherited;
//  CustomDatasetAfterInsert(Self,DataSet);

end;

procedure TFrameCxGrid.RestMemTable1BeforeDelete(
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

procedure TFrameCxGrid.RestMemTable1GetRestDatasetPage(
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

procedure TFrameCxGrid.SaveDataIntfResult(ALoadDataSetting:TLoadDataSetting;ADataIntfResult: TDataIntfResult);
begin

  if ADataIntfResult.DataJson<>nil then
  begin
    if ALoadDataSetting.IsAddRecord then
    begin
      Self.RestMemTable1.Append;
    end
    else
    begin
      Self.RestMemTable1.Edit;
    end;
    try
      uJsonToDataset.LoadRecordFromJson(Self.RestMemTable1,ADataIntfResult.DataJson)
    finally
      Self.RestMemTable1.Post;
    end;
  end;

end;

procedure TFrameCxGrid.SetControlValue(ASetting: TFieldControlSetting;
  APageDataDir, AImageServerUrl: String; AValue: Variant; AValueCaption: String;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
begin
  //是Json数组

end;

procedure TFrameCxGrid.SetListControlValue(ASetting: TFieldControlSetting;
  APageDataDir, AImageServerUrl: String; AValue: Variant; AValueCaption: String;
  AValueArray: ISuperArray; AValueObject: TObject;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue;
                                  ALoadDataIntfResult:TDataIntfResult;
                                  ALoadDataIntfResult2:TDataIntfResult);
begin
  uBaseLog.HandleException(nil,'TFrameCxGrid.SetListControlValue Begin');

  if ALoadDataIntfResult<>nil then
  begin
    Self.RestMemTable1.LoadDataIntfResult(ALoadDataIntfResult.DataJson);
  end;

  uBaseLog.HandleException(nil,'TFrameCxGrid.SetListControlValue End');

//  FPageInstance.FLoadDataSetting.Clear;
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

procedure TFrameCxGrid.SetOnFocusedRecordChange(
  AValue: TFocusedRecordChangeEvent);
begin
  FOnFocusedRecordChange:=AValue;
end;

//procedure TFrameCxGrid.SetProp(APropName: String; APropValue: Variant);
//begin
//
//end;

procedure TFrameCxGrid.SetPropJsonStr(AJsonStr: String);
var
  APropJson:ISuperObject;
begin

//  AFieldControlSetting.PropJson.I['IsDisplayIndicator']:=1;
//  AFieldControlSetting.PropJson.I['is_row_has_checkbox']:=1;
//  AFieldControlSetting.PropJson.I['is_can_multi_select']:=1;

  APropJson:=SO(AJsonStr);
  if APropJson.Contains('IsDisplayIndicator') then
  begin
    //显示序号

//    Self.cxGrid1DBTableView1.OptionsView.GroupByBox := False;
    Self.cxGrid1DBTableView1.OptionsView.Indicator := APropJson.B['IsDisplayIndicator'];
    Self.cxGrid1DBTableView1.OptionsView.IndicatorWidth := 50;
  end;

  if APropJson.Contains('IsRowHasCheckbox') then
  begin
    if APropJson.B['IsRowHasCheckbox'] then
    begin
      //每行是否需要勾选框
      Self.cxGrid1DBTableView1.OptionsSelection.CheckBoxVisibility:=[cbvDataRow,cbvGroupRow,cbvColumnHeader];
    end
    else
    begin
      //每行是否需要勾选框
      Self.cxGrid1DBTableView1.OptionsSelection.CheckBoxVisibility:=[];
    end;
  end;


  if APropJson.Contains('IsCanMultiSelect') then
  begin
    //可以多选
    Self.cxGrid1DBTableView1.OptionsSelection.MultiSelect:=APropJson.B['IsCanMultiSelect'];
    Self.cxGrid1DBTableView1.OptionsSelection.CellMultiSelect:=APropJson.B['IsCanMultiSelect'] and APropJson.B['IsCanCellSelect'];
  end;

  if APropJson.Contains('IsCanCellSelect') then
  begin
    //可以选中单元格
    Self.cxGrid1DBTableView1.OptionsSelection.CellSelect:=APropJson.B['IsCanCellSelect'];
  end;


  if APropJson.Contains('DataRowHeight') then
  begin
    //可以选中单元格
    Self.cxGrid1DBTableView1.OptionsView.DataRowHeight:=APropJson.I['DataRowHeight'];
  end;

end;

procedure TFrameCxGrid.SetRowNumber(var Sender: TcxGridTableView;
  var AViewInfo: TcxCustomGridIndicatorItemViewInfo; ACanvas: TcxCanvas;
  var ADone: boolean);
var
  AIndicatorViewInfo: TcxGridIndicatorRowItemViewInfo;
  ATextRect: TRect;
  AFont: TFont;
  AFontTextColor, AColor: TColor;
  procedure DrawIndicatorImage(ACanvas: TcxCanvas;
    const R: TRect; AKind: TcxIndicatorKind);
  var
    X, Y: Integer;
  begin
    if AKind = ikNone then Exit;
    X := (R.Left + R.Right - cxLookAndFeelPainters.cxIndicatorImages.Width);
    Y := (R.Top + R.Bottom - cxLookAndFeelPainters.cxIndicatorImages.Height) div 2;
    cxLookAndFeelPainters.cxIndicatorImages.Draw(ACanvas.Canvas, X, Y, Ord(AKind) - 1);
  end;
begin
  try
    AFont := ACanvas.Font;
    AColor := clBtnFace;
    AFontTextColor := clWindowText;
    if (AViewInfo is TcxGridIndicatorHeaderItemViewInfo) then begin
      ATextRect := AViewInfo.Bounds;
      InflateRect(ATextRect, -1, -1);
      Sender.LookAndFeelPainter.DrawHeader(ACanvas, AViewInfo.Bounds,
        ATextRect, [], cxBordersAll, cxbsNormal, taCenter, TcxAlignmentVert.vaCenter,
        False, False, '序号', AFont, AFontTextColor, AColor);
      ADone := True;
    end;
    if not (AViewInfo is TcxGridIndicatorRowItemViewInfo) then
      Exit;
    ATextRect := AViewInfo.ContentBounds;
    AIndicatorViewInfo := AViewInfo as TcxGridIndicatorRowItemViewInfo;
    InflateRect(ATextRect, -1, -1);
    if Sender.DataController.RecordCount > 0 then begin
      if (AIndicatorViewInfo.GridRecord<>nil) and AIndicatorViewInfo.GridRecord.Selected then
        AFontTextColor := clRed
      else
        AFontTextColor := clWindowText;
    end;
    Sender.LookAndFeelPainter.DrawHeader(ACanvas, AViewInfo.ContentBounds,
      ATextRect, [], [bBottom, bLeft, bRight], cxbsNormal, taCenter, TcxAlignmentVert.vaCenter,
      False, False, IntToStr(AIndicatorViewInfo.GridRecord.Index + 1),
      AFont, AFontTextColor, AColor);
    ADone := True;
  except
  end;
  DrawIndicatorImage(ACanvas, ATextRect, AIndicatorViewInfo.IndicatorKind);


end;


//procedure TFrameCxGrid.UpdateRecord(ARecordDataJson: ISuperObject);
//begin
//  //如果保存失败、更新的数据为空,那么不会返回DataJson
//  Self.RestMemTable1.Edit;
//  try
//    uJsonToDataset.LoadRecordFromJson(Self.RestMemTable1,ARecordDataJson)
//  finally
//    Self.RestMemTable1.Post;
//  end;
//
//
//end;

initialization
  GetGlobalFrameworkComponentTypeClasses.Add('cxgrid',TFrameCxGrid,'CX表格');
  GetGlobalFrameworkComponentTypeClasses.Add('DBGrid',TFrameCxGrid,'DB表格');


end.
