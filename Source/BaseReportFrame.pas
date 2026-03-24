unit BaseReportFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  BaseParentFrame, System.Actions, FMX.ActnList, uDrawPicture, uSkinImageList,
  uSkinScrollControlType, uSkinScrollBoxType, uSkinFireMonkeyScrollBox,

  uBaseLog,
  uUIFunction,
  uTimerTask,
  uPageStructure,
  uPageInstance,
  XSuperObject,
  MessageBoxFrame,
  uSkinItemJsonHelper,
  uOpenClientCommon,
  uRestInterfaceCall,
  uSortSettingFrame,
  PopupMenuFrame,
  SearchFrame,
  uManager,
  ListItemStyleFrame_Page,
  ListItemStyleFrame_BaseReportDetail,
  SelectFilterDateAreaFrame,
//  ListItemStyleFrame_Customer,
  PopupTreeMenuFrame,
  CommonImageDataMoudle,
  EasyServiceCommonMaterialDataMoudle,
  ListItemStyleFrame_CaptionTopDetailBottom,
  ListItemStyleFrame_CaptionAndMultiDetailsHorz_Accessory,
  ListItemStyleFrame_DefaultCenter_BottomBorderSelected,
  ListItemStyleFrame_DropDownButton_BottomBorderSelected,

  uSkinButtonType, uSkinFireMonkeyButton, uSkinFireMonkeyControl,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinItemDesignerPanelType, uSkinFireMonkeyItemDesignerPanel,
  uSkinCustomListType, uSkinVirtualListType, uSkinListBoxType,
  uSkinFireMonkeyListBox, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uDrawCanvas, uSkinItems,System.JSON, uSkinListViewType,
  uSkinFireMonkeyListView, uSkinFireMonkeyPopup, uSkinMultiColorLabelType,
  uSkinFireMonkeyMultiColorLabel, FMX.Edit, FMX.Controls.Presentation,
  uSkinFireMonkeyEdit, uTimerTaskEvent, uSkinVirtualGridType, uSkinItemGridType,
  uSkinFireMonkeyItemGrid;

type
  TFrameBaseReport = class(TFrameParent)
    lvData: TSkinFMXListBox;
    lvGroupByTypes: TSkinFMXListView;
    lvSummary: TSkinFMXListView;
    btnSort: TSkinFMXButton;
    btnFilter: TSkinFMXButton;
    btnMore: TSkinFMXButton;
    pnlDateArea: TSkinFMXPanel;
    btnSelectDateArea: TSkinSelectDateAreaButton;
    pnlBottomBar: TSkinFMXPanel;
    btnOK: TSkinFMXButton;
    lblSumMoney: TSkinFMXMultiColorLabel;
    pnlFilter: TSkinFMXPanel;
    edtFilter: TSkinFMXEdit;
    ClearEditButton1: TClearEditButton;
    btnScode: TSkinFMXButton;
    btnSearchEditCategory: TSkinFMXButton;
    btnSearchEditFilter: TSkinFMXButton;
    btnSearchEditSort: TSkinFMXButton;
    popuAdd: TSkinFMXPopup;
    lbAddList: TSkinFMXListBox;
    tteLoadData: TTimerTaskEvent;
    btnSearch: TSkinFMXButton;
    pnlSumCount: TSkinFMXPanel;
    lblCount: TSkinFMXLabel;
    lblLoadedCount: TSkinFMXLabel;
    tmrFilterChangeTracking: TTimer;
    btnClassify: TSkinFMXButton;
    pnlGroupByTypes: TSkinFMXPanel;
    SkinFMXButton1: TSkinFMXButton;
    procedure lvSummaryNewListItemStyleFrameCacheInit(Sender: TObject;
      AListItemTypeStyleSetting: TListItemTypeStyleSetting;
      ANewListItemStyleFrameCache: TListItemStyleFrameCache);virtual;
    procedure lvGroupByTypesClickItem(AItem: TSkinItem);
    procedure btnMoreClick(Sender: TObject);
    procedure btnSelectDateAreaClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure tteLoadDataExecute(ATimerTask: TTimerTask);
    procedure tteLoadDataExecuteEnd(ATimerTask: TTimerTask);
    procedure lvDataPullDownRefresh(Sender: TObject);
    procedure lvDataNewListItemStyleFrameCacheInit(Sender: TObject;
      AListItemTypeStyleSetting: TListItemTypeStyleSetting;
      ANewListItemStyleFrameCache: TListItemStyleFrameCache);virtual;
    procedure btnSearchClick(Sender: TObject);
    procedure edtFilterChangeTracking(Sender: TObject);
    procedure tmrFilterChangeTrackingTimer(Sender: TObject);
    procedure gridDataPullDownRefresh(Sender: TObject);
    procedure btnViewTypeClick(Sender: TObject);
    procedure btnClassifyClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
  protected
    procedure DoReturnFrameFromSelectDateArea(AFromFrame:TFrame);
    // 选择树形分类弹出框
    procedure DoMenuClickFromSelectClassifyPopupTreeMenuFrame(APopupMenuFrame: TFrame);

    procedure SetGroupByFrameBinding(AGroupByFrame:TFrameListItemStyle_CaptionAndMultiDetailsHorz_Accessory);
    { Private declarations }
    function GetReportName:String;virtual;

    function GetIsGroupBy:Boolean;virtual;
    function GetSummaryViewIsVisible:Boolean;virtual;
    //获取自定义查询条件
    function GetCustomWhereSQL:String;virtual;
    procedure PrepareForLoadDataToUI(ADataJson:ISuperObject);virtual;
    //获取不创建的字段列表
    function GetHideFieldListCommaText:String;virtual;
    function GetDefaultItemStyle:String;virtual;
    //获取底部统计的标题
    function GetBottomCountCaption(ASuperObject:ISuperObject):String;virtual;

    //给Json加一些字段
    procedure FixRecordDataJson(ARecordDataJson:ISuperObject);virtual;
  protected
    //表格视图新加的过程
    procedure PrepareForLoadDataToUI_GridView(ADataJson:ISuperObject);virtual;
    function GetHideColumnFieldListCommaText:String;virtual;
  public
    { Public declarations }
    FFieldList:ISuperArray;
    FItemStylePage:TPage;
    FFieldColumnHeaderFrame:TFrameListItemStyle_CaptionAndMultiDetailsHorz_Accessory;

    FPageIndex:Integer;
    FReportName:String;
    FGroupByType:String;
    //明细值,如果为空,则为汇总
    FGroupByValue:String;

    FDefaultItemStyle:String;
    FDefaultWhereSQL:String;
//        ParamsList :TStringList;
//        ParamsJson:TJSONObject;
//        strCurrentParentid,
//        CCLASSID,
//        PClassID  ,
//        EClassID   ,
//        IClassID   ,
//        DID  ,
//        SClassID   ,
//        ACLASSID,
//        BeginDate  ,
//        EndDate,
//        isZero,
//        billtypelist,//strCallSerialCode,
//        sApiPath :string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
//    function BeforeLoadData:Boolean;dynamic;
//    function LoadData:Boolean;dynamic;
//    function LoadDataV2:boolean;dynamic;
//    function AfterLoadData:Boolean;dynamic;
//    procedure DoOpen;dynamic;
    procedure Load(AReportName:String;
                    AGroupByType:String;
                    AGroupByValue:String;
                    AStartDate:String;
                    AEndDate:String;
                    ADefaultWhereSQL:String;
                    ADefaultItemStyle:String);virtual;
  end;



  //汇总报表
  TFrameBaseReportSummary=class(TFrameBaseReport)
    procedure lvDataNewListItemStyleFrameCacheInit(Sender: TObject;
      AListItemTypeStyleSetting: TListItemTypeStyleSetting;
      ANewListItemStyleFrameCache: TListItemStyleFrameCache);override;
    procedure PrepareForLoadDataToUI(ADataJson:ISuperObject);override;

  end;



//  //明细报表
//  TFrameBaseReportDetail=class(TFrameBaseReport)
//    procedure lvDataNewListItemStyleFrameCacheInit(Sender: TObject;
//      AListItemTypeStyleSetting: TListItemTypeStyleSetting;
//      ANewListItemStyleFrameCache: TListItemStyleFrameCache);override;
//    procedure PrepareForLoadDataToUI(ADataJson:ISuperObject);override;
//    function GetDefaultItemStyle:String;override;
//
//  end;



var
  GlobalBaseReportFrame: TFrameBaseReport;
//  GlobalBaseReportSummaryFrame: TFrameBaseReportSummary;
//  GlobalBaseReportDetailFrame: TFrameBaseReportDetail;
  //单据状态的图标列表
  GlobalBillStateImageList:TSkinImageList;

//根据字段列表创建控件
procedure LoadPageByFieldList(APage:TPage;AFieldList:ISuperArray;AHideFieldListCommaText:String);
procedure HideControlInItemDesignerPanelByPage(APage:TPage;AItemDesignerPanel:TSkinItemDesignerPanel);

implementation


//uses SystemCommon,WaitingFrame,HintFrame,main,uClientDM,DimConst;
{$R *.fmx}


procedure LoadPageByFieldList(APage:TPage;AFieldList:ISuperArray;AHideFieldListCommaText:String);
var
  I: Integer;
  APageFieldControlSetting:TPageFieldControlSetting;
  AHideFieldList:TStringList;
  AFirstPicIndex:Integer;
begin
  AHideFieldList:=TStringList.Create;
  try
      AHideFieldList.CommaText:=AHideFieldListCommaText;

      AFirstPicIndex:=-1;


      //自动列数
      APage.MainLayoutSetting.col_count:=-1;
      APage.LoadFromFieldList(AFieldList,AHideFieldList);


//      APageFieldControlSetting:=APage.MainLayoutControlList.Add;
//      APageFieldControlSetting.name:='解决方案';
//      APageFieldControlSetting.field_name:='解决方案';
//      APageFieldControlSetting.field_caption:='解决方案';
//      APageFieldControlSetting.control_type:='label';
//      APageFieldControlSetting.has_caption_label:=1;
//      APageFieldControlSetting.width:=200;//宽度是应该自定义的

//      APageFieldControlSetting:=APage.MainLayoutControlList.Add;
//      APageFieldControlSetting.name:='门架延期原因';
//      APageFieldControlSetting.field_name:='门架延期原因';
//      APageFieldControlSetting.field_caption:='门架延期原因';
//      APageFieldControlSetting.control_type:='label';
//      APageFieldControlSetting.has_caption_label:=1;
//      APageFieldControlSetting.text_vert_align:='center';
//      APageFieldControlSetting.width:=200;//宽度是应该自定义的


      APage.MainLayoutSetting.row_space:=5;
      APage.MainLayoutSetting.row_height:=24;

//      //加上分隔线
//      for I := 0 to APage.MainLayoutControlList.Count-1 do
//      begin
//          APageFieldControlSetting:=APage.MainLayoutControlList[I];
//          //字体变红色
//          //装配延期原因='测试',表面延期原因='测试',配套延期原因='测试',门面延期原因='测试',门架延期原因='测试'
//          if (APageFieldControlSetting.field_name='装配延期原因')
//            or (APageFieldControlSetting.field_name='表面延期原因')
//            or (APageFieldControlSetting.field_name='配套延期原因')
//            or (APageFieldControlSetting.field_name='门面延期原因')
//            or (APageFieldControlSetting.field_name='门架延期原因')
//            or (APageFieldControlSetting.field_name='解决方案')
//            then
//          begin
//            APageFieldControlSetting:=APage.MainLayoutControlList.Add;
//            APageFieldControlSetting.control_type:='label';
//            APageFieldControlSetting.has_caption_label:=0;
//            APageFieldControlSetting.width:=-2;
//            APageFieldControlSetting.height:=1;
//            APageFieldControlSetting.is_autosize:=0;
//
//            APageFieldControlSetting.Index:=AFirstPicIndex;
//          end;
//
//      end;


      for I := 0 to APage.MainLayoutControlList.Count-1 do
      begin
          APageFieldControlSetting:=APage.MainLayoutControlList[I];

          //默认
          APageFieldControlSetting.is_autosize:=1;
          APageFieldControlSetting.height:=26;


          //自定义
          //如果是图片,则用Image控件
          if

             (APageFieldControlSetting.field_name='pic1_path')
            or (APageFieldControlSetting.field_name='pic2_path')
            or (APageFieldControlSetting.field_name='pic3_path')
            or (APageFieldControlSetting.field_name='pic4_path')
            or (APageFieldControlSetting.field_name='pic5_path')
            or (APageFieldControlSetting.field_name='pic6_path')
            or (APageFieldControlSetting.field_name='pic7_path')
            or (APageFieldControlSetting.field_name='pic8_path')
            or (APageFieldControlSetting.field_name='pic9_path')

            or (Pos('pic1_path',APageFieldControlSetting.field_name)>0)
            or (Pos('pic2_path',APageFieldControlSetting.field_name)>0)
            or (Pos('pic3_path',APageFieldControlSetting.field_name)>0)
            or (Pos('pic4_path',APageFieldControlSetting.field_name)>0)
            or (Pos('pic5_path',APageFieldControlSetting.field_name)>0)


             then
          begin
            if AFirstPicIndex=-1 then
            begin
              AFirstPicIndex:=I;
            end;

            APageFieldControlSetting.control_type:='image';
            APageFieldControlSetting.has_caption_label:=0;
            APageFieldControlSetting.picture_is_autofit:=0;
            APageFieldControlSetting.picture_is_stretch:=7;
            APageFieldControlSetting.width:=100;
            APageFieldControlSetting.height:=100;
            APageFieldControlSetting.is_autosize:=1;
          end;

          if APageFieldControlSetting.control_type='label' then
          begin
            APageFieldControlSetting.control_style:='WhiteBackCaptionVertCenter';
            APageFieldControlSetting.input_panel_style:='GrayBackAndBorderMaterial';
          end;

          //如果有订单图片详情,则放在图片中
          if
             (APageFieldControlSetting.field_name='订单图片1备注')
            or (APageFieldControlSetting.field_name='订单图片2备注')
            or (APageFieldControlSetting.field_name='订单图片3备注')
            or (APageFieldControlSetting.field_name='订单图片4备注')
            or (APageFieldControlSetting.field_name='订单图片5备注') then
          begin
              APageFieldControlSetting.has_caption_label:=0;
//              APageFieldControlSetting.is_autosize:=0;
              APageFieldControlSetting.align:='Bottom';
              APageFieldControlSetting.control_style:='BackBlackOpacityCaptionWhiteVertCenter';
              if (APageFieldControlSetting.field_name='订单图片1备注') then
              begin
                APageFieldControlSetting.parent_control_name:='order_pic1_path';
              end;
              if (APageFieldControlSetting.field_name='订单图片2备注') then
              begin
                APageFieldControlSetting.parent_control_name:='order_pic2_path';
              end;
              if (APageFieldControlSetting.field_name='订单图片3备注') then
              begin
                APageFieldControlSetting.parent_control_name:='order_pic3_path';
              end;
              if (APageFieldControlSetting.field_name='订单图片4备注') then
              begin
                APageFieldControlSetting.parent_control_name:='order_pic4_path';
              end;
              if (APageFieldControlSetting.field_name='订单图片5备注') then
              begin
                APageFieldControlSetting.parent_control_name:='order_pic5_path';
              end;
          end;



          //字体变红色
          //异常内容单独占一行
          if (APageFieldControlSetting.field_name='异常内容') then
          begin
            APageFieldControlSetting.is_autosize:=0;
            APageFieldControlSetting.has_caption_label:=0;
            APageFieldControlSetting.width:=-2;
            APageFieldControlSetting.text_font_color:='FFFF0000';
            APageFieldControlSetting.text_font_size:=14;
            APageFieldControlSetting.control_style:='';


            APageFieldControlSetting.is_autosize:=1;
            APageFieldControlSetting.text_wordwrap:=1;
          end;


          //字体变红色
          //装配延期原因='测试',表面延期原因='测试',配套延期原因='测试',门面延期原因='测试',门架延期原因='测试'
          if (APageFieldControlSetting.field_name='装配延期原因')
            or (APageFieldControlSetting.field_name='表面延期原因')
            or (APageFieldControlSetting.field_name='配套延期原因')
            or (APageFieldControlSetting.field_name='门面延期原因')
            or (APageFieldControlSetting.field_name='门架延期原因')
            or (APageFieldControlSetting.field_name='解决方案')
            then
          begin
            //APageFieldControlSetting创建的时候,control_style默认是Default
            //需要能换行
            APageFieldControlSetting.control_style:='RedBackCaptionVertCenter';

//            APageFieldControlSetting.control_style:='';
//            APageFieldControlSetting.is_autosize:=0;
////            APageFieldControlSetting.has_caption_label:=0;
            APageFieldControlSetting.width:=-2;
//            APageFieldControlSetting.back_color:='FFFF0000';
//            APageFieldControlSetting.text_font_color:='FFFF0000';
//            APageFieldControlSetting.text_font_size:=14;
//            APageFieldControlSetting.control_style:='';


            APageFieldControlSetting.is_autosize:=1;
            APageFieldControlSetting.text_wordwrap:=1;

//            APageFieldControlSetting.width:=-2;
//            APageFieldControlSetting.is_autosize:=0;
    ////        APageFieldControlSetting.has_caption_label:=0;
    //        APageFieldControlSetting.width:=-2;
    //        APageFieldControlSetting.text_font_color:='FFFF0000';
    //        APageFieldControlSetting.text_font_size:=14;
    ////        APageFieldControlSetting.control_style:='';
    //
    ////        //自适应高度
    ////        APageFieldControlSetting.is_autosize:=1;
    ////        //可以换行
    ////        APageFieldControlSetting.text_wordwrap:=1;
    ////        APageFieldControlSetting.text_vert_align:='center';
          end;




      end;


      //如果有图片,则在图片前面加入高度为1,宽度为-2的控件,用于将图片换行
      if AFirstPicIndex<>-1 then
      begin
        APageFieldControlSetting:=APage.MainLayoutControlList.Add;
        APageFieldControlSetting.control_type:='label';
        APageFieldControlSetting.has_caption_label:=0;
        APageFieldControlSetting.width:=-2;
        APageFieldControlSetting.height:=1;
        APageFieldControlSetting.is_autosize:=0;

        APageFieldControlSetting.Index:=AFirstPicIndex;
      end;





  finally
    FreeAndNil(AHideFieldList);
  end;
end;

procedure HideControlInItemDesignerPanelByPage(APage:TPage;AItemDesignerPanel:TSkinItemDesignerPanel);
var
  I: Integer;
  AItemBindingControlItem:TItemBindingControlItem;
  APageFieldControlSetting:TPageFieldControlSetting;
begin
    AItemDesignerPanel.Prop.SyncSkinItemBindingControls(AItemDesignerPanel);
    AItemDesignerPanel.Prop.FIsSyncedSkinItemBindingControls:=False;
    for I := AItemDesignerPanel.Prop.FItemBindingControlList.Count-1 downto 0 do
    begin
      AItemBindingControlItem:=AItemDesignerPanel.Prop.FItemBindingControlList[I];
      APageFieldControlSetting:=APage.MainLayoutControlList.FindByFieldName(AItemBindingControlItem.FSkinItemBindingControlIntf.GetBindItemFieldName);
//      if APageFieldControlSetting<>nil then
//      begin
//        APageFieldControlSetting.visible:=0;
//      end;
      APageFieldControlSetting.Free;
    end;

end;

{ TfmBaseReport }

//function TfmBaseReport.AfterLoadData: Boolean;
//var
//  AListBoxItem: TSkinListBoxItem;
//begin
// if cdsdata.RecordCount =0  then exit;
// try
//  lstBaseInfo.Properties.Items.BeginUpdate;
//  cdsData.First;
//  with cdsData do
//  begin
//    while not eof do
//    begin
//      AListBoxItem := Self.lstBaseInfo.Properties.Items.Add;
//      AListBoxItem.Tag := cdsData.RecNo;
//
//
//
//      next;
//    end;
//  end;
// finally
//  lstBaseInfo.Properties.Items.EndUpdate();
// end;
// Result := true;
//end;
//
//function TfmBaseReport.BeforeLoadData: Boolean;
//begin
// ParamsList.Clear;
// ParamsJson:=TJSONObject.Create;
//// strCallSerialCode := '';
// lstBaseInfo.Properties.Items.Clear();
// cdsData.Close;
// Result := true;
//end;


type
  TProtectedControl=class(TControl);



procedure TFrameBaseReport.btnClassifyClick(Sender: TObject);
begin
  inherited;

  if not btnClassify.Prop.IsPushed then
  begin
    btnClassify.Prop.IsPushed:=True;

    ShowFrame(TFrame(GlobalPopupTreeMenuFrame),TFramePopupTreeMenu,Application.MainForm,nil,nil,DoMenuClickFromSelectClassifyPopupTreeMenuFrame,Application,True,False,ufsefNone);
    GlobalPopupTreeMenuFrame.Position.Y:=Self.pnlToolBar.Height;
    GlobalPopupTreeMenuFrame.lbMenus.Height:=GlobalPopupTreeMenuFrame.lbMenus.Prop.CalcContentHeight;
  end
  else
  begin

    btnClassify.Prop.IsPushed:=False;
    GlobalPopupTreeMenuFrame.HidePopupTreeMenu;

  end;
//  //设置
//  ShowFrame(TFrame(GlobalPopupMenuFrame),TFramePopupMenu,Application.MainForm,nil,nil,nil,Application,True,True,ufsefNone);
//  GlobalPopupMenuFrame.Init('扫描入库模式',['普通通式','重复扫描计数模式']);

end;

procedure TFrameBaseReport.btnFilterClick(Sender: TObject);
begin
  inherited;
  HideFrame;
  ShowFrame(TFrame(GlobalSearchFrame),TFrameSearch);

end;

procedure TFrameBaseReport.btnMoreClick(Sender: TObject);
var
  AButton:TControl;
begin
  inherited;


  AButton:=TControl(Sender);

  if Not Self.popuAdd.IsOpen then
  begin
    //设置弹出框绝对位置
    Self.popuAdd.PlacementRectangle.Left:=
          TProtectedControl(AButton.Parent).LocalToScreen(PointF(Self.btnMore.Position.X+Self.btnMore.Width,0)).X
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

procedure TFrameBaseReport.btnSearchClick(Sender: TObject);
begin
  inherited;
  Self.FPageIndex:=1;
  Self.tteLoadData.Run();
end;

procedure TFrameBaseReport.btnSelectDateAreaClick(Sender: TObject);
begin
  inherited;
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

procedure TFrameBaseReport.btnSortClick(Sender: TObject);
begin
  inherited;
//  HideFrame;
//  ShowFrame(TFrame(GlobalSortSettingFrame),TFrameSortSetting);
//  GlobalSortSettingFrame.Init('排序设置','数量,金额,毛利,客户,制单日期','');
end;

procedure TFrameBaseReport.btnViewTypeClick(Sender: TObject);
begin
  inherited;
//  Self.btnViewType.Prop.IsPushed:=not Self.btnViewType.Prop.IsPushed;
//
//
//  if Self.btnViewType.Prop.IsPushed then
//  begin
//    //表格视图
//    Self.gridData.Align:=TAlignLayout.Client;
//    Self.gridData.Visible:=True;
//
//    Self.lvData.Visible:=False;
//
//    if FReportName<>'' then
//    begin
//      GlobalManager.UserUISettingJson.O[FReportName].S['view_type']:='grid';
//      GlobalManager.SaveUserConfig;
//    end;
//  end
//  else
//  begin
//    //列表视图
//    Self.lvData.Align:=TAlignLayout.Client;
//    Self.lvData.Visible:=True;
//
//    Self.gridData.Visible:=False;
//
//    if FReportName<>'' then
//    begin
//      GlobalManager.UserUISettingJson.O[FReportName].S['view_type']:='list';
//      GlobalManager.SaveUserConfig;
//    end;
//  end;
end;

constructor TFrameBaseReport.Create(AOwner: TComponent);
//var
//  ADrawPicture:TDrawPicture;
begin
  inherited;
//  ParamsList := TStringList.Create;



//  //单据状态的图标列表
//  if GlobalBillStateImageList=nil then
//  begin
//    GlobalBillStateImageList:=TSkinImageList.Create(Application);
//    ADrawPicture:=GlobalBillStateImageList.PictureList.Add;
//    ADrawPicture.FileName:='已完成.png';
//    ADrawPicture.ImageName:='已完成';
//
//    ADrawPicture:=GlobalBillStateImageList.PictureList.Add;
//    ADrawPicture.FileName:='已审核.png';
//    ADrawPicture.ImageName:='已审核';
//
//    ADrawPicture:=GlobalBillStateImageList.PictureList.Add;
//    ADrawPicture.FileName:='已执行.png';
//    ADrawPicture.ImageName:='已执行';
//
//    ADrawPicture:=GlobalBillStateImageList.PictureList.Add;
//    ADrawPicture.FileName:='已终止.png';
//    ADrawPicture.ImageName:='已终止';
//
//    ADrawPicture:=GlobalBillStateImageList.PictureList.Add;
//    ADrawPicture.FileName:='已过期.png';
//    ADrawPicture.ImageName:='已过期';
//
//    ADrawPicture:=GlobalBillStateImageList.PictureList.Add;
//    ADrawPicture.FileName:='已过账.png';
//    ADrawPicture.ImageName:='已过账';
//
//    ADrawPicture:=GlobalBillStateImageList.PictureList.Add;
//    ADrawPicture.FileName:='未过期.png';
//    ADrawPicture.ImageName:='未过期';
//
//    ADrawPicture:=GlobalBillStateImageList.PictureList.Add;
//    ADrawPicture.FileName:='草稿.png';
//    ADrawPicture.ImageName:='草稿';
//
//  end;
//
//
//
//  FFieldColumnHeaderFrame:=TFrameListItemStyle_CaptionAndMultiDetailsHorz_Accessory.Create(Self);
//  FFieldColumnHeaderFrame.Parent:=Self;
//  FFieldColumnHeaderFrame.Align:=TAlignLayout.Top;
//  FFieldColumnHeaderFrame.Position.Y:=Self.lvData.Top;
//  FFieldColumnHeaderFrame.Height:=40;
//
//  FFieldColumnHeaderFrame.ItemDesignerPanel.Align:=TAlignLayout.Client;
//  FFieldColumnHeaderFrame.ItemDesignerPanel.Visible:=True;
//  FFieldColumnHeaderFrame.imgAccessory.Prop.Picture.SkinImageList:=nil;
//  FFieldColumnHeaderFrame.Visible:=False;


//  Self.gridData.Visible:=False;
//  Self.btnViewType.Visible:=False;

end;

destructor TFrameBaseReport.Destroy;
begin
//  ParamsList.Free;
  inherited;
end;

//procedure TfmBaseReport.DoOpen;
//begin
// if not BeforeLoadData then exit;
// if UseApiV2 then
//  LoadDataV2
// else
//  loaddata;
// //if not AfterLoadData then exit;
//end;

procedure TFrameBaseReport.DoMenuClickFromSelectClassifyPopupTreeMenuFrame(
  APopupMenuFrame: TFrame);
begin
  //
  btnClassify.Prop.IsPushed:=False;

end;

procedure TFrameBaseReport.DoReturnFrameFromSelectDateArea(AFromFrame: TFrame);
begin
  btnSelectDateArea.StartDate:=TFrameSelectFilterDateArea(AFromFrame).FStartDate;
  btnSelectDateArea.EndDate:=TFrameSelectFilterDateArea(AFromFrame).FEndDate;

  //刷新
  Self.FPageIndex:=1;
  Self.tteLoadData.Run(True);

end;

procedure TFrameBaseReport.edtFilterChangeTracking(Sender: TObject);
begin
  inherited;

  tmrFilterChangeTracking.Enabled:=False;
  tmrFilterChangeTracking.Enabled:=True;

end;

procedure TFrameBaseReport.FixRecordDataJson(ARecordDataJson: ISuperObject);
begin

end;

function TFrameBaseReport.GetBottomCountCaption(ASuperObject: ISuperObject): String;
begin
  Result:='共'+FloatToStr(ASuperObject.O['Data'].I['SumCount'])+'条';
end;

function TFrameBaseReport.GetCustomWhereSQL: String;
begin
  Result:=FDefaultWhereSQL;
  if edtFilter.Text<>'' then
  begin
    Result:=Result+' AND [关键字]='+QuotedStr(edtFilter.Text)+' ';
  end;
end;

function TFrameBaseReport.GetDefaultItemStyle: String;
begin
  Result:=FDefaultItemStyle;
end;

function TFrameBaseReport.GetIsGroupBy: Boolean;
begin
  Result:=FGroupByValue='';
end;

function TFrameBaseReport.GetReportName: String;
begin
  Result:=FReportName;
end;

function TFrameBaseReport.GetSummaryViewIsVisible: Boolean;
begin
  Result:=GetIsGroupBy;
end;

procedure TFrameBaseReport.gridDataPullDownRefresh(Sender: TObject);
begin
  inherited;
  FPageIndex:=1;
  Self.tteLoadData.Run();

end;

procedure TFrameBaseReport.Load(AReportName, AGroupByType, AGroupByValue,
  AStartDate, AEndDate: String;
  ADefaultWhereSQL:String;
                    ADefaultItemStyle:String);
begin
  FDefaultWhereSQL:='';
  FFieldList:=nil;
  Self.lvData.Prop.Items.BeginUpdate;
  try
    Self.lvData.Prop.Items.Clear();
  finally
    Self.lvData.Prop.Items.EndUpdate();
  end;

//  Self.gridData.Prop.Columns.BeginUpdate;
//  Self.gridData.Prop.Items.BeginUpdate;
//  try
//    Self.gridData.Prop.Items.Clear();
//    Self.gridData.Prop.Columns.Clear();
//  finally
//    Self.gridData.Prop.Columns.EndUpdate();
//    Self.gridData.Prop.Items.EndUpdate();
//  end;

  FReportName:=AReportName;
  FGroupByType:=AGroupByType;
  FGroupByValue:=AGroupByValue;
  btnSelectDateArea.StartDate:=AStartDate;
  btnSelectDateArea.EndDate:=AEndDate;

  FDefaultItemStyle:=ADefaultItemStyle;
  FDefaultWhereSQL:=ADefaultWhereSQL;

  Self.pnlToolBar.Caption:=AReportName;
  if AGroupByValue<>'' then
  begin
    Self.pnlToolBar.Caption:=AReportName+'-'+AGroupByValue;
  end;
  

  Self.pnlFilter.Visible:=False;
  Self.pnlBottomBar.Visible:=False;
  Self.lvSummary.Visible:=(AGroupByValue='');
  Self.lvGroupByTypes.Visible:=(AGroupByValue='');



//  if (FReportName<>'')
//    and GlobalManager.UserUISettingJson.Contains(AReportName)
//    and (GlobalManager.UserUISettingJson.O[AReportName].S['view_type']='grid') then
//  begin
//    //表格模式
//    Self.btnViewType.Prop.IsPushed:=True;
//
//    Self.gridData.Align:=TAlignLayout.Client;
//    Self.gridData.Visible:=True;
//    Self.lvData.Visible:=False;
//  end
//  else
//  begin
//    //列表模式
//    Self.btnViewType.Prop.IsPushed:=False;
//
//    Self.gridData.Visible:=False;
//    Self.lvData.Visible:=True;
//  end;



  FPageIndex:=1;
  Self.tteLoadData.Run();


end;

//function TfmBaseReport.LoadData: Boolean;
//var
// strResult :string;
//begin
//{ if (ParamsList.Count = 0) and (strCallSerialCode = '')  then exit;
//   ShowWaitingFrame(self,'正在查询,请稍候....');
//
//   TThread.CreateAnonymousThread(
//   procedure begin
//    if (ParamsList.Count > 0) and (strCallSerialCode = '') then
//     strResult := DoQuery(ParamsList)
//     else
//     begin
//      strResult := ClientDM.C_S_C(strCallSerialCode);
//     end;
//
//     TThread.Synchronize(nil,
//        procedure begin
//          HideWaitingFrame;
//          if strResult = ''  then exit;
//           JsonToDataSet(strResult,cdsData);
//           cdsData.Open;
//           if cdsData.RecordCount > 0  then
//            Afterloaddata
//            else
//            begin
//             ShowHintFrame(fmMain,'暂无数据！',3);
//            end;
//        end);
//   end).Start;   }
//end;
//
//function TfmBaseReport.LoadDataV2: boolean;
//var
// strResult :string;
//begin
// if (ParamsJson.Count = 0) and (sApiPath = '')  then exit;
//   ShowWaitingFrame(self,'正在查询,请稍候....');
//   TThread.CreateAnonymousThread(
//   procedure begin
//    strResult := DoQueryV2(ParamsJson,sApiPath);
//    ParamsJson.Free;
//     TThread.Synchronize(nil,
//        procedure begin
//          HideWaitingFrame;
//          if strResult = ''  then exit;
//           if JsonToDataSet(strResult,cdsData) then
//           begin
//             cdsData.Open;
//             if cdsData.RecordCount > 0  then
//              Afterloaddata;
//           end
//            else
//            begin
//             ShowHintFrame(fmMain,'暂无数据！',3);
//            end;
//        end);
//   end).Start;
//end;

procedure TFrameBaseReport.lvDataNewListItemStyleFrameCacheInit(Sender: TObject;
  AListItemTypeStyleSetting: TListItemTypeStyleSetting;
  ANewListItemStyleFrameCache: TListItemStyleFrameCache);
var
  AGroupByFrame:TFrameListItemStyle_CaptionAndMultiDetailsHorz_Accessory;
begin
  inherited;
  //是分组还是明细
  if (ANewListItemStyleFrameCache.FItemStyleFrame is TFrameListItemStyle_CaptionAndMultiDetailsHorz_Accessory) then
  begin
    //是分组,水平模式
    //绑定字段
    AGroupByFrame:=TFrameListItemStyle_CaptionAndMultiDetailsHorz_Accessory(ANewListItemStyleFrameCache.FItemStyleFrame);
    SetGroupByFrameBinding(AGroupByFrame);
  end;
end;

procedure TFrameBaseReport.lvDataPullDownRefresh(Sender: TObject);
begin
  inherited;
  FPageIndex:=1;
  Self.tteLoadData.Run();
end;

procedure TFrameBaseReport.lvGroupByTypesClickItem(AItem: TSkinItem);
begin
  inherited;
//  //wn
//  //切换汇总方式
//  Self.FGroupByType:=AItem.Caption;
//  Self.FPageIndex:=1;
//  Self.tteLoadData.Run();




end;

procedure TFrameBaseReport.lvSummaryNewListItemStyleFrameCacheInit(Sender: TObject;
  AListItemTypeStyleSetting: TListItemTypeStyleSetting;
  ANewListItemStyleFrameCache: TListItemStyleFrameCache);
var
  AFrame:TFrameListItemStyle_CaptionTopDetailBottom;
begin
  inherited;
//  //统计数据的样式
//  if ANewListItemStyleFrameCache.FItemStyleFrame is TFrameListItemStyle_CaptionTopDetailBottom then
//  begin
//
//    AFrame:=TFrameListItemStyle_CaptionTopDetailBottom(ANewListItemStyleFrameCache.FItemStyleFrame);
//    AFrame.lblItemCaption.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Gray;
//    AFrame.lblItemCaption.Material.DrawCaptionParam.FontSize:=14;
//    AFrame.lblItemCaption.Align:=TAlignLayout.Top;
//    AFrame.lblItemCaption.Height:=24;
//
//    AFrame.lblItemDetail.Material.DrawCaptionParam.FontColor:=$FFF57868;
//    AFrame.lblItemDetail.Material.DrawCaptionParam.FontSize:=26;
//    AFrame.lblItemDetail.Align:=TAlignLayout.Client;
//  end;

end;

procedure TFrameBaseReport.PrepareForLoadDataToUI(ADataJson:ISuperObject);
begin
  Self.lvData.Prop.DefaultItemStyle:='';//清一下列表项样式Frame缓存
  if Self.GetIsGroupBy or (GetDefaultItemStyle='') then
  begin
    //是分组
    SetGroupByFrameBinding(FFieldColumnHeaderFrame);
    FFieldColumnHeaderFrame.Repaint;
    Self.lvData.Prop.DefaultItemStyle:='CaptionAndMultiDetailsHorz_Accessory';
    FFieldColumnHeaderFrame.Visible:=True;
  end
  else
  begin
    //是明细
    Self.lvData.Prop.DefaultItemStyle:=GetDefaultItemStyle;

    FFieldColumnHeaderFrame.Visible:=False;
  end;



end;

procedure TFrameBaseReport.PrepareForLoadDataToUI_GridView(
  ADataJson: ISuperObject);
//var
//  I:Integer;
//  AColumn:TSkinItemGridColumn;
//  AHideFieldList:TStringList;
begin

//  AHideFieldList:=TStringList.Create;
//  AHideFieldList.CommaText:=GetHideColumnFieldListCommaText;
//
//
//  //表格视图
////  Self.gridData.Prop.Columns.BeginUpdate;
//  try
//    Self.gridData.Prop.Columns.Clear;
//
//    if FFieldList<>nil then
//    begin
//        for I := 0 to FFieldList.Length-1 do
//        begin
//          //不在隐藏的字段中
//          if AHideFieldList.IndexOf(FFieldList.O[I].S['name'])<>-1 then Continue;
//
//
//          AColumn:=Self.gridData.Prop.Columns.Add;
//          AColumn.BindItemFieldName:=FFieldList.O[I].S['name'];
//          AColumn.Caption:=FFieldList.O[I].S['name'];
////          AColumn.AutoSize:=True;
//        end;
//    end;
//  finally
////    Self.gridData.Prop.Columns.EndUpdate;
//    FreeAndNil(AHideFieldList);
//  end;

end;

procedure TFrameBaseReport.SetGroupByFrameBinding(
  AGroupByFrame: TFrameListItemStyle_CaptionAndMultiDetailsHorz_Accessory);
begin
  if FFieldList<>nil then
  begin


    AGroupByFrame.lblDetail.Visible:=False;
    AGroupByFrame.lblDetail1.Visible:=False;
    AGroupByFrame.lblDetail2.Visible:=False;
    AGroupByFrame.lblDetail3.Visible:=False;
    AGroupByFrame.lblDetail4.Visible:=False;
    {"name":"\u5BA2\u6237","size":40,"precision":0,"field_type":1,"data_type":"string"}
    if FFieldList.Length>0 then
    begin
      AGroupByFrame.lblCaption.BindItemFieldName:=FFieldList.O[0].S['name'];
      AGroupByFrame.lblCaption.Caption:=FFieldList.O[0].S['name'];
    end;
    if FFieldList.Length>1 then
    begin
      AGroupByFrame.lblDetail.Visible:=True;
      AGroupByFrame.lblDetail.BindItemFieldName:=FFieldList.O[1].S['name'];
      AGroupByFrame.lblDetail.Caption:=FFieldList.O[1].S['name'];
    end;
    if FFieldList.Length>2 then
    begin
      AGroupByFrame.lblDetail1.Visible:=True;
      AGroupByFrame.lblDetail1.BindItemFieldName:=FFieldList.O[2].S['name'];
      AGroupByFrame.lblDetail1.Caption:=FFieldList.O[2].S['name'];
    end;
    if FFieldList.Length>3 then
    begin
      AGroupByFrame.lblDetail2.Visible:=True;
      AGroupByFrame.lblDetail2.BindItemFieldName:=FFieldList.O[3].S['name'];
      AGroupByFrame.lblDetail2.Caption:=FFieldList.O[3].S['name'];
    end;
    if FFieldList.Length>4 then
    begin
      AGroupByFrame.lblDetail3.Visible:=True;
      AGroupByFrame.lblDetail3.BindItemFieldName:=FFieldList.O[4].S['name'];
      AGroupByFrame.lblDetail3.Caption:=FFieldList.O[4].S['name'];
    end;
    if FFieldList.Length>5 then
    begin
      AGroupByFrame.lblDetail4.Visible:=True;
      AGroupByFrame.lblDetail4.BindItemFieldName:=FFieldList.O[5].S['name'];
      AGroupByFrame.lblDetail4.Caption:=FFieldList.O[5].S['name'];
    end;
    AGroupByFrame.ItemDesignerPanelResize(nil);
  end;


end;

procedure TFrameBaseReport.tmrFilterChangeTrackingTimer(Sender: TObject);
begin
  inherited;

  FPageIndex:=1;
  Self.tteLoadData.Run();

  tmrFilterChangeTracking.Enabled:=False;
end;

procedure TFrameBaseReport.tteLoadDataExecute(ATimerTask: TTimerTask);
var
  ADesc:String;
  ACustomWhereSQL:String;
begin
  inherited;
  //加载数据

  try
      //出错
      TTimerTask(ATimerTask).TaskTag:=1;
       ACustomWhereSQL:=GetCustomWhereSQL;
       TTimerTask(ATimerTask).TaskDesc :=SimpleCallAPI('get_main_summary_report',
                                                  nil,
                                                  DoorManageInterfaceUrl,
                                                  ['appid',
                                                  'user_fid',
                                                  'key',
                                                  'report_name',
                                                  'groupby_type',
                                                  'filter_start_date',
                                                  'filter_end_date',
                                                  'pageindex',
                                                  'pagesize',
                                                  'orderby',
                                                  'is_groupby',
                                                  'group_value_of_detail',
                                                  'power',
                                                  'custom_where_sql',
                                                  'door_type'
//                                                  'compressed'
                                                  ],
                                                  [AppID,
                                                  GlobalManager.User.fid,
                                                  '',//GlobalManager.User.key,
                                                  GetReportName,//'TakeOrderBill',
                                                  FGroupByType,//Self.lvGroupByTypes.Prop.SelectedItem.Caption,//'日',
                                                  btnSelectDateArea.StartDate,
                                                  btnSelectDateArea.EndDate,
                                                  Self.FPageIndex,
                                                  100,
                                                  '',
                                                  Ord(Self.GetIsGroupBy),//'1',//是否汇总
                                                  FGroupByValue,//'',
                                                  GlobalManager.EmployeeJson.S['权限'],
                                                  ACustomWhereSQL,
                                                  ''
//                                                  1
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

function TFrameBaseReport.GetHideColumnFieldListCommaText: String;
begin
  Result:='';
end;

function TFrameBaseReport.GetHideFieldListCommaText: String;
begin
  Result:='';
end;

procedure TFrameBaseReport.tteLoadDataExecuteEnd(ATimerTask: TTimerTask);
var
  I: Integer;
  AListViewItem:TSkinItem;
//  AGridRow:TSkinJsonVirtualGridRow;
  ASuperObject:ISuperObject;
  ARecordJson:ISuperObject;
  AListItemStyle:String;
  AListItemStyleReg:TListItemStyleReg;
  AValueStr:String;
begin
  uBaseLog.HandleException(nil,'TfmBaseReport.tteLoadDataExecuteEnd Begin');
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin
          uBaseLog.HandleException(nil,'TfmBaseReport.tteLoadDataExecuteEnd 1');

          Self.lvData.Prop.Items.BeginUpdate;
          Self.lvGroupByTypes.Prop.Items.BeginUpdate;
          Self.lvSummary.Prop.Items.BeginUpdate;

//          if Self.btnViewType.Visible then
//          begin
//            Self.gridData.Prop.Items.BeginUpdate;
//            Self.gridData.Prop.Columns.BeginUpdate;
//          end;
          try


            if FPageIndex=1 then
            begin
                Self.lvData.Prop.Items.ClearItemsByType(sitDefault);

//                if Self.btnViewType.Visible then
//                begin
//                  Self.gridData.Prop.Items.Clear;
//                end;



                uBaseLog.HandleException(nil,'TfmBaseReport.tteLoadDataExecuteEnd 2');
                //返回多少分组
                Self.lvGroupByTypes.Prop.Items.ClearItemsByType(sitDefault);
                if ASuperObject.O['Data'].Contains('GroupByTypes') then
                begin
                  for I := 0 to ASuperObject.O['Data'].A['GroupByTypes'].Length-1 do
                  begin
                    ARecordJson:=ASuperObject.O['Data'].A['GroupByTypes'].O[I];
                    AListViewItem:=Self.lvGroupByTypes.Prop.Items.Add;
                    AListViewItem.Caption:=ARecordJson.S['name'];
                    AListViewItem.Selected:=ARecordJson.B['ItemSelected'];
                    if ASuperObject.O['Data'].A['GroupByTypes'].Length>1 then
                    begin
                      AListViewItem.Width:=1/ASuperObject.O['Data'].A['GroupByTypes'].Length;
                    end
                    else
                    begin
                      AListViewItem.width:=-2;
                    end;
                  end;
                end;
                Self.lvGroupByTypes.Visible:=ASuperObject.O['Data'].A['GroupByTypes'].Length>0;





                uBaseLog.HandleException(nil,'TfmBaseReport.tteLoadDataExecuteEnd 3');
                Self.lvSummary.Prop.Items.ClearItemsByType(sitDefault);
                //返回多少汇总Summary
                if ASuperObject.O['Data'].Contains('Summary') then
                begin
                  for I := 0 to ASuperObject.O['Data'].A['Summary'].Length-1 do
                  begin
                    ARecordJson:=ASuperObject.O['Data'].A['Summary'].O[I];
                    AListViewItem:=Self.lvSummary.Prop.Items.Add;
                    AListViewItem.Caption:=ARecordJson.S['name'];
                    AValueStr:='';
                    if not VarIsNull(ARecordJson.V['value']) then
                    begin
                      AValueStr:=FloatToStr(ARecordJson.F['value']);
                    end;
                    AListViewItem.Detail:=AValueStr;
                    if ASuperObject.O['Data'].A['Summary'].Length>1 then
                    begin
                      AListViewItem.Width:=1/ASuperObject.O['Data'].A['Summary'].Length;
                    end
                    else
                    begin
                      AListViewItem.width:=-2;
                    end;
                  end;
                end;

                //必须大于1才行
                Self.lvSummary.Visible:=(ASuperObject.O['Data'].A['Summary'].Length>1) and Self.GetSummaryViewIsVisible;

            end;



            uBaseLog.HandleException(nil,'TfmBaseReport.tteLoadDataExecuteEnd 4');
            //字段列表
            FFieldList:=ASuperObject.O['Data'].A['FieldList'];


//            //加载表格标题列
//            if Self.btnViewType.Visible then
//            begin
//              PrepareForLoadDataToUI_GridView(ASuperObject.O['Data']);
//            end;

            //列表视图
            //设置列表项样式等准备
            Self.PrepareForLoadDataToUI(ASuperObject.O['Data']);






            uBaseLog.HandleException(nil,'TfmBaseReport.tteLoadDataExecuteEnd 5');

            //给图片加上图片服务器
            AddImageHttpServerUrlToPicPath(ASuperObject.O['Data'].A['RecordList'],ImageHttpServerUrl);



            //添加列表项
            for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
            begin
              ARecordJson:=ASuperObject.O['Data'].A['RecordList'].O[I];




              AListViewItem:=TJsonSkinItem.Create;//Self.lvData.Prop.Items.Add;
              Self.lvData.Prop.Items.Add(AListViewItem);
              AListViewItem.Json:=ARecordJson;

              FixRecordDataJson(ARecordJson);




              //测试
//              AListViewItem:=Self.lvData.Prop.Items.Add;
//              TSkinItem(AListViewItem).Caption:=ARecordJson.S['单据编码'];

              //AListItemStyle:=lvData.Prop.GetItemStyleByItemType(AListViewItem.ItemType);
              //设置Item的高度
              //AListItemStyleReg:=GlobalListItemStyleRegList.FindItemByName(AListItemStyle);
              AListItemStyleReg:=lvData.Prop.FDefaultItemStyleSetting.FListItemStyleReg;


              if (AListItemStyleReg<>nil)
                and (AListItemStyleReg.DefaultItemHeight<>0)
                and (AListItemStyleReg.DefaultItemHeight<>-1)
                and not AListItemStyleReg.IsAutoSize then
              begin
                AListViewItem.Height:=AListItemStyleReg.DefaultItemHeight;
              end;

              if //AIsAutoSize or
                  (AListItemStyleReg<>nil) and AListItemStyleReg.IsAutoSize then
              begin
                  //设置自动高度
                  AListViewItem.Height:=
                      lvData.Prop.CalcItemAutoSize(AListViewItem).cy;
              end;


//              if Self.btnViewType.Visible then
//              begin
//                //表格视图
//                AGridRow:=TSkinJsonVirtualGridRow.Create;//Self.lvData.Prop.Items.Add;
//                Self.gridData.Prop.Items.Add(AGridRow);
//                AGridRow.Json:=ARecordJson;
//              end;

            end;




          finally
            Self.lvData.Prop.Items.EndUpdate();
            Self.lvGroupByTypes.Prop.Items.EndUpdate;
            Self.lvSummary.Prop.Items.EndUpdate;

//            if Self.btnViewType.Visible then
//            begin
//              Self.gridData.Prop.Columns.EndUpdate();
//              Self.gridData.Prop.Items.EndUpdate(True);
//            end;
          end;




          //显示出共几条记录
          Self.pnlSumCount.Visible:=ASuperObject.O['Data'].Contains('SumCount');
          Self.lblCount.Caption:=Self.GetBottomCountCaption(ASuperObject);






          Self.lblLoadedCount.Caption:='已加载'+FloatToStr(Self.lvData.Prop.Items.Count)+'条';

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
//    HideWaitingFrame;


    if FPageIndex>1 then
    begin
        if (TTimerTask(ATimerTask).TaskTag=TASK_SUCC) and (ASuperObject.O['Data'].A['RecordList'].Length>0) then
        begin
          Self.lvData.Prop.StopPullUpLoadMore('加载成功!',0,True);
//          if Self.btnViewType.Visible then Self.gridData.Prop.StopPullUpLoadMore('加载成功!',0,True);
        end
        else
        begin
          Self.lvData.Prop.StopPullUpLoadMore('下面没有了!',600,False);
//          if Self.btnViewType.Visible then Self.gridData.Prop.StopPullUpLoadMore('下面没有了!',600,False);
        end;
    end
    else
    begin
        Self.lvData.Prop.StopPullDownRefresh('刷新成功!',600);
        Self.lvData.VertScrollBar.Prop.Position:=0;

//        if Self.btnViewType.Visible then Self.gridData.Prop.StopPullDownRefresh('刷新成功!',600);
//        if Self.btnViewType.Visible then Self.gridData.VertScrollBar.Prop.Position:=0;
    end;



    uBaseLog.HandleException(nil,'TfmBaseReport.tteLoadDataExecuteEnd End');
  end;
end;

{ TFrameBaseReportSummary }

procedure TFrameBaseReportSummary.lvDataNewListItemStyleFrameCacheInit(
  Sender: TObject; AListItemTypeStyleSetting: TListItemTypeStyleSetting;
  ANewListItemStyleFrameCache: TListItemStyleFrameCache);
begin
  inherited;

end;

procedure TFrameBaseReportSummary.PrepareForLoadDataToUI(ADataJson:ISuperObject);
begin
  inherited;
  Self.lvData.Prop.DefaultItemStyle:='';//清一下列表项样式Frame缓存
//  if (FGroupByValue='') or (GetDefaultItemStyle='') then
//  begin
    //是分组
    SetGroupByFrameBinding(FFieldColumnHeaderFrame);
    FFieldColumnHeaderFrame.Repaint;
    Self.lvData.Prop.DefaultItemStyle:='CaptionAndMultiDetailsHorz_Accessory';
    FFieldColumnHeaderFrame.Visible:=True;
//  end
//  else
//  begin
//    //是明细
//    Self.lvData.Prop.DefaultItemStyle:=GetDefaultItemStyle;
//
//    FFieldColumnHeaderFrame.Visible:=False;
//  end;


end;

//{ TFrameBaseReportDetail }
//
//function TFrameBaseReportDetail.GetDefaultItemStyle: String;
//begin
////  Result:='PageStructure';
//  Result:='BaseReportDetail';
//end;
//
//procedure TFrameBaseReportDetail.lvDataNewListItemStyleFrameCacheInit(
//  Sender: TObject; AListItemTypeStyleSetting: TListItemTypeStyleSetting;
//  ANewListItemStyleFrameCache: TListItemStyleFrameCache);
//var
//  APageFrame:TFrameListItemStyle_Page;
//  AReportDetailFrame:TFrameListItemStyle_BaseReportDetail;
//  AItemDesignerPanel:TSkinItemDesignerPanel;
//begin
//  inherited;
//
//  AItemDesignerPanel:=nil;
//  if ANewListItemStyleFrameCache.FItemStyleFrame is TFrameListItemStyle_Page then
//  begin
//    APageFrame:=TFrameListItemStyle_Page(ANewListItemStyleFrameCache.FItemStyleFrame);
//    APageFrame.FPage:=FItemStylePage;
//    //需要了TFrameListItemStyle_Page.Init之前
//
//    //设置绑定
//
//    AItemDesignerPanel:=APageFrame.ItemDesignerPanel;
//  end;
//
//
//  if ANewListItemStyleFrameCache.FItemStyleFrame is TFrameListItemStyle_BaseReportDetail then
//  begin
//    AReportDetailFrame:=TFrameListItemStyle_BaseReportDetail(ANewListItemStyleFrameCache.FItemStyleFrame);
//    AReportDetailFrame.FPage:=FItemStylePage;
//    //需要了TFrameListItemStyle_Page.Init之前
//
//    //设置绑定
//
//    AItemDesignerPanel:=AReportDetailFrame.ItemDesignerPanel;
//  end;
//
//
//  //隐藏已经在设计面板上拖好的字段
//  //在FItemStylePage中将已经绑定的字段隐藏
//  if AItemDesignerPanel<>nil then
//  begin
//    HideControlInItemDesignerPanelByPage(Self.FItemStylePage,AItemDesignerPanel);
//  end;
//
//
//end;
//
//procedure TFrameBaseReportDetail.PrepareForLoadDataToUI(ADataJson:ISuperObject);
//begin
//  inherited;
//  Self.lvData.Prop.DefaultItemStyle:='';//清一下列表项样式Frame缓存
//  if (GetDefaultItemStyle='') then
//  begin
//    //是分组
//    SetGroupByFrameBinding(FFieldColumnHeaderFrame);
//    FFieldColumnHeaderFrame.Repaint;
//    Self.lvData.Prop.DefaultItemStyle:='CaptionAndMultiDetailsHorz_Accessory';
//    FFieldColumnHeaderFrame.Visible:=True;
//  end
//  else
//  begin
//    //是明细
//    Self.lvData.Prop.DefaultItemStyle:=GetDefaultItemStyle;
//    Self.lvData.Prop.ItemHeight:=200;
//
//    FFieldColumnHeaderFrame.Visible:=False;
//
//
//    //根据字段,创建PageStructure
//    if FItemStylePage=nil then
//    begin
//      FItemStylePage:=TPage.Create(Self);
//    end;
//    LoadPageByFieldList(FItemStylePage,Self.FFieldList);
//
//  end;
//
//end;

end.
