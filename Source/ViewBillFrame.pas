unit ViewBillFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uSkinButtonType, FMX.Edit, FMX.Controls.Presentation, uSkinFireMonkeyEdit,

  uUIFunction,
  ViewJsonFrame,
  DetailsViewJsonFrame,
  BaseParentFrame,
  XSuperObject,
  uFuncCommon,
  uDataSetToJson,
  CommonImageDataMoudle,
  EasyServiceCommonMaterialDataMoudle,
  ListItemStyleFrame_CaptionGrayCenter_BottomBorderSelected,

  BillListFrame,

  FMX.DateTimeCtrls, uSkinFireMonkeyDateEdit, uSkinCheckBoxType,
  uSkinFireMonkeyCheckBox, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinScrollBoxContentType, uSkinFireMonkeyScrollBoxContent, System.Actions,
  FMX.ActnList, uDrawPicture, uSkinImageList, uSkinScrollControlType,
  uSkinScrollBoxType, uSkinFireMonkeyScrollBox, uSkinFireMonkeyButton,
  uSkinFireMonkeyControl, uSkinPanelType, uSkinFireMonkeyPanel, uDrawCanvas,
  uSkinItems, uSkinCustomListType, uSkinVirtualListType, uSkinListBoxType,
  uSkinFireMonkeyListBox, uSkinFireMonkeyPopup, uSkinListViewType,
  uSkinFireMonkeyListView, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinFireMonkeyPageControl,
  uSkinPageControlType;

type
  TFrameViewBill = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    btnClear: TSkinFMXButton;
    pnlMostTopBar: TSkinFMXPanel;
    SkinFMXPanel2: TSkinFMXPanel;
    sbClient: TSkinFMXScrollBox;
    sbcContent: TSkinFMXScrollBoxContent;
    SkinFMXPanel4: TSkinFMXPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    edtBeginDate: TSkinFMXDateEdit;
    SkinFMXLabel2: TSkinFMXLabel;
    edtEndDate: TSkinFMXDateEdit;
    btnMore: TSkinFMXButton;
    popuAdd: TSkinFMXPopup;
    lbAddList: TSkinFMXListBox;
    pnlBottomBar: TSkinFMXPanel;
    btnQuery: TSkinFMXButton;
    SkinFMXButton2: TSkinFMXButton;
    lvGroupByTypes: TSkinFMXListView;
    lvData: TSkinFMXListView;
    dspDataView: TSkinFMXItemDesignerPanel;
    pnlTitle: TSkinFMXPanel;
    pnlData: TSkinFMXPanel;
    lblTitle: TSkinFMXLabel;
    lblTitleHint: TSkinFMXLabel;
    pnlDataItem1: TSkinFMXPanel;
    SkinFMXLabel5: TSkinFMXLabel;
    SkinFMXLabel6: TSkinFMXLabel;
    pnlDataItem2: TSkinFMXPanel;
    SkinFMXLabel7: TSkinFMXLabel;
    SkinFMXLabel8: TSkinFMXLabel;
    pnlDataItem3: TSkinFMXPanel;
    SkinFMXLabel9: TSkinFMXLabel;
    SkinFMXLabel10: TSkinFMXLabel;
    pnlDataItem4: TSkinFMXPanel;
    SkinFMXLabel11: TSkinFMXLabel;
    SkinFMXLabel12: TSkinFMXLabel;
    pcMain: TSkinFMXPageControl;
    tsDetails: TSkinTabSheet;
    tsFollowRecords: TSkinTabSheet;
    tsContacts: TSkinTabSheet;
    tsSaleDetails: TSkinTabSheet;
    tsOrderDetails: TSkinTabSheet;
    SkinFMXPanel1: TSkinFMXPanel;
    btnAddRecord: TSkinFMXButton;
    SkinFMXPanel3: TSkinFMXPanel;
    btnAddContact: TSkinFMXButton;
    SkinFMXPanel5: TSkinFMXPanel;
    SkinFMXButton3: TSkinFMXButton;
    SkinFMXPanel6: TSkinFMXPanel;
    SkinFMXButton4: TSkinFMXButton;
    pnlGroupByTypes: TSkinFMXPanel;
    procedure btnReturnClick(Sender: TObject);
    procedure lvGroupByTypesClickItem(AItem: TSkinItem);
    procedure btnMoreClick(Sender: TObject);
    procedure lbAddListClickItem(AItem: TSkinItem);
    procedure SkinFMXButton2Click(Sender: TObject);
    procedure pnlDataResize(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure btnAddContactClick(Sender: TObject);
    procedure tsDetailsClick(Sender: TObject);
    procedure sbClientVertScrollBarChange(Sender: TObject);
  private
    FDataJson:ISuperObject;

    //跟进记录明细数据
    FFollowRecordJsonArray:ISuperArray;

    //跟进记录页面
    FFollowRecordFrame:TFrameParent;
    //详情页面
    FDetailFrame:TFrameDetailsViewJson;
    // 联系人界面
    FContactsFrame:TFrameBillList;
    { Private declarations }
  public
    // 当前查询的用户AUTOID
    FUserAUTOID:String;

    // 联系人列表是否可点击查看
    FContactEnable:Boolean;

  public
    //顶部需要显示的主表字段列表
    FMasterVisibleFields:TStringList;
    //详情需要显示的主表字段列表
    FDetailVisibleFields:TStringList;

    // 报表名称 客户/联系人
    FReportName:String;

    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    procedure Load(AReportName:String; ADataJson:ISuperObject);
    { Public declarations }
  end;

  //详情界面
  TFrameViewBillContact=class(TFrameViewBill)

  end;

var
  GlobalViewBillFrame:TFrameViewBill;

  // 联系人详情界面
  GlobalViewBillContactFrame:TFrameViewBillContact;

implementation

{$R *.fmx}

uses
  EditBillFrame;

type
TProtectedControl=class(TControl);


procedure TFrameViewBill.btnMoreClick(Sender: TObject);
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
          -5
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

procedure TFrameViewBill.btnReturnClick(Sender: TObject);
begin
  HideFrame;
  ReturnFrame;
end;

constructor TFrameViewBill.Create(AOwner: TComponent);
var
  I: Integer;
  AFollowRecordJson:ISuperObject;
begin
  inherited;

  FContactEnable:= True;

  for I := 0 to Self.lvGroupByTypes.Prop.Items.Count-1 do
  begin
    Self.lvGroupByTypes.Prop.Items[I].AutoSizeWidth:=True;
  end;


//  FDataJson:=SO();
//  FDataJson.S['AUTOID']:='1';
//  FDataJson.S['客户']:='kh001';
//  FDataJson.S['业务日期']:='2021/10/15';
//  FDataJson.S['销售机会']:='暂无';
//  FDataJson.S['合同订单编号']:='2021-10-15-0001';
//  FDataJson.S['合同订单标题']:='我们';


  FFollowRecordJsonArray:=SA();
  //跟进记录明细数据
  AFollowRecordJson:=SO();
  AFollowRecordJson.S['日期']:='2021/10/15';
  AFollowRecordJson.S['方式']:='Whatsapp';
  AFollowRecordJson.S['意向']:='有意向';
  FFollowRecordJsonArray.O[FFollowRecordJsonArray.Length]:=AFollowRecordJson;

  AFollowRecordJson:=SO();
  AFollowRecordJson.S['日期']:='2021/08/11';
  AFollowRecordJson.S['方式']:='Email';
  AFollowRecordJson.S['意向']:='有意向';
  FFollowRecordJsonArray.O[FFollowRecordJsonArray.Length]:=AFollowRecordJson;

  FMasterVisibleFields:=TStringList.Create;
  FDetailVisibleFields:=TStringList.Create;
end;

destructor TFrameViewBill.Destroy;
begin
  FreeAndNil(FMasterVisibleFields);
  FreeAndNil(FDetailVisibleFields);

  inherited;
end;

procedure TFrameViewBill.lbAddListClickItem(AItem: TSkinItem);
begin
  Self.popuAdd.IsOpen:=False;

end;

procedure TFrameViewBill.Load(AReportName:String; ADataJson: ISuperObject);
var
  I:Integer;
  AItem:TSkinItem;
  AValueStr:String;
//  AParamNames:TStringDynArray;
//  AParamValues:TVariantDynArray;
  AListItemStyleReg:TListItemStyleReg;
begin

  FReportName:=AReportName;
  FDataJson:= ADataJson;

  Self.lvData.Prop.Items.BeginUpdate;
  try

    Self.lvData.Prop.Items.Clear(True);


//    ConvertJsonToArray(ADataJson,
//                        AParamNames,
//                        AParamValues);

    //不要所有字段都显示出来
//    for I := 0 to Length(AParamNames)-1 do
    for I := 0 to FMasterVisibleFields.Count-1 do
    begin
//
//    //顶部需要显示的主表字段列表
//    FMasterVisibleFields:TStringList;
//    //详情需要显示的主表字段列表
//    FDetailVisibleFields:TStringList;
//      if FMasterVisibleFields.IndexOf(AParamNames[I])=-1 then
//      begin
//        continue;
//      end;

          if VarIsNull(ADataJson.V[FMasterVisibleFields[I]]) then
          begin
            AValueStr:='';
          end
          else
          begin
            AValueStr:=ADataJson.V[FMasterVisibleFields[I]];
          end;
          AItem:=Self.lvData.Prop.Items.Add;
          AItem.Caption:=FMasterVisibleFields[I]+'：';
          if FMasterVisibleFields[I]='CustomerID' then
          begin
            AItem.FItemStyleConfig.Add('lblDetail.SelfOwnMaterial.DrawCaptionParam.FontColor:=Blue;');
          end;


          AItem.Detail:=AValueStr;//测试计算高度+'1werfygbedsgyewqbrfnjomdafesdayg8bjnmAKSDHOSLDJNAFFYHU';


//          //AListItemStyle:=lvOrderList.Prop.GetItemStyleByItemType(AListViewItem.ItemType);
//          //设置Item的高度
//          //AListItemStyleReg:=GlobalListItemStyleRegList.FindItemByName(AListItemStyle);
//          AListItemStyleReg:=lvData.Prop.FDefaultItemStyleSetting.FListItemStyleReg;
//
//
//          if (AListItemStyleReg<>nil)
//            and (AListItemStyleReg.DefaultItemHeight<>0)
//            and (AListItemStyleReg.DefaultItemHeight<>-1)
//            and not AListItemStyleReg.IsAutoSize then
//          begin
//            AItem.Height:=AListItemStyleReg.DefaultItemHeight;
//          end;
//
//          if //AIsAutoSize or
//              (AListItemStyleReg<>nil) //and AListItemStyleReg.IsAutoSize
//              then
//          begin
//              //设置自动高度
//              AItem.Height:=
//                  lvData.Prop.CalcItemAutoSize(AItem,0).cy;
//          end;

    end;

    // 列表加载完后添加数据概览项
    AItem:=Self.lvData.Prop.Items.Add;
    AItem.ItemType:= sitFooter;
    AItem.Height:= 90;

  finally
    Self.lvData.Prop.Items.EndUpdate;
  end;

  Self.lvData.Height:=Self.lvData.Prop.CalcContentHeight;

  Self.lvGroupByTypes.Prop.Items[1].Selected:=True;
  lvGroupByTypesClickItem(Self.lvGroupByTypes.Prop.Items[1]);
end;

procedure TFrameViewBill.lvGroupByTypesClickItem(AItem: TSkinItem);
var
  AFollowRecordJson:ISuperObject;
begin
  //切换子Frame
  if AItem.Caption='跟进记录' then
  begin

//      if FFollowRecordFrame=nil then
//      begin
//        FFollowRecordFrame:=TFrameBillList.Create(Self);
//        SetFrameName(FFollowRecordFrame);
//        FFollowRecordFrame.pnlToolBar.Visible:=False;
//        FFollowRecordFrame.Parent:=tsFollowRecords;
//        FFollowRecordFrame.Align:=TAlignLayout.Client;
//        TFrameBillList(FFollowRecordFrame).pnlType.Visible:=False;
//        TFrameBillList(FFollowRecordFrame).pnlSumCount.Visible:=False;
//        TFrameBillList(FFollowRecordFrame).lvData.Prop.VertScrollBarShowType:=sbstNone;
//      end;
//      TFrameBillList(FFollowRecordFrame).LoadDataList(FFollowRecordJsonArray);
//      FFollowRecordFrame.Visible:=True;

//      tsFollowRecords.Height:= 0;
//      Self.pcMain.Height:= tsFollowRecords.Height;
//      Self.sbcContent.Height:=GetSuitScrollContentHeight(sbcContent);
//      //重新按顺序排列控件
//      AlignControls(lvData,lvGroupByTypes,tsFollowRecords);

    Self.pcMain.Prop.ActivePage:= tsFollowRecords;

  end
  else
  if AItem.Caption='详情' then
  begin

      if FDetailFrame=nil then
      begin
        FDetailFrame:=TFrameDetailsViewJson.Create(Self);
        SetFrameName(FDetailFrame);
        FDetailFrame.pnlToolBar.Visible:=False;
        FDetailFrame.Parent:=tsDetails;
        FDetailFrame.Align:=TAlignLayout.Client;
        FDetailFrame.lvData.Prop.VertScrollBarShowType:=sbstNone;
      end;
      // 拷贝主表已显示字段作为详情过滤字段
      FDetailFrame.FDetailVisibleFields.Assign(FMasterVisibleFields);

      FDetailFrame.Load(FReportName, FDataJson);
      FDetailFrame.Visible:=True;

      tsDetails.Height:= FDetailFrame.lvData.Prop.CalcContentHeight + FDetailFrame.pnlBottomBar.Height;
      Self.pcMain.Height:= tsDetails.Height;
      //tsDetails.Position.Y:=Self.lvGroupByTypes.Position.Y;
      Self.sbcContent.Height:=GetSuitScrollContentHeight(sbcContent);
      //重新按顺序排列控件
      AlignControls(lvData,pnlGroupByTypes,pcMain);

      Self.pcMain.Prop.ActivePage:= tsDetails;

  end
  else
  if AItem.Caption='联系人' then
  begin

    if FContactsFrame=nil then
    begin
      FContactsFrame:=TFrameBillList.Create(Self);
      SetFrameName(FContactsFrame);
      FContactsFrame.pnlToolBar.Visible:=False;
      FContactsFrame.pnlType.Visible:=False;
      FContactsFrame.pnlSumCount.Visible:=False;
      FContactsFrame.Parent:=tsContacts;
      FContactsFrame.Align:=TAlignLayout.Client;
      FContactsFrame.lvData.Prop.VertScrollBarShowType:=sbstNone;
      FContactsFrame.lvData.HitTest:= FContactEnable;
      FContactsFrame.lvData.Properties.DefaultItemStyleConfig.Text:=
        'lblCaption.BindItemFieldName:=''姓名'';'+#13#10
        +'lblDetail.BindItemFieldName:=''电话'';'+#13#10
        +'lblDetail1.BindItemFieldName:=''手机'';'+#13#10
        ;
    end;

    FContactsFrame.Load('联系人');
    FContactsFrame.FUserAUTOID:= IntToStr(FDataJson.I['AUTOID']);
    FContactsFrame.FSelectMode:=False;
    FContactsFrame.Visible:=True;

    tsContacts.Height:= FContactsFrame.lvData.Prop.CalcContentHeight + FContactsFrame.pnlBottomBar.Height + 100;
    Self.pcMain.Height:= tsContacts.Height;
    Self.sbcContent.Height:=GetSuitScrollContentHeight(sbcContent);
    //重新按顺序排列控件
    AlignControls(lvData,pnlGroupByTypes,pcMain);

    Self.pcMain.Prop.ActivePage:=tsContacts;

  end
  else
  if AItem.Caption='合同订单产品明细' then
  begin
    Self.pcMain.Prop.ActivePage:=tsOrderDetails;
  end
  else
  if AItem.Caption='销售出库明细' then
  begin
    Self.pcMain.Prop.ActivePage:=tsSaleDetails;
  end
  else
  begin
      {//先隐藏其他明细页面
      if FDetailFrame<>nil then FDetailFrame.Visible:=False;
      //先隐藏其他明细页面
      if FFollowRecordFrame<>nil then FFollowRecordFrame.Visible:=False;}

  end;


end;

// 切换子表分页
procedure TFrameViewBill.pcMainChange(Sender: TObject);
begin

  // 跟进记录
  if Self.pcMain.Prop.ActivePage=tsFollowRecords then
  begin

  end;

  // 详情
  if Self.pcMain.Prop.ActivePage=tsDetails then
  begin

  end;

  // 联系人
  if Self.pcMain.Prop.ActivePage=tsContacts then
  begin

  end;

  // 合同订单产品明细
  if Self.pcMain.Prop.ActivePage=tsOrderDetails then
  begin

  end;

  // 销售出库明细
  if Self.pcMain.Prop.ActivePage=tsSaleDetails then
  begin

  end;

end;

procedure TFrameViewBill.pnlDataResize(Sender: TObject);
begin
  Self.pnlDataItem1.Width:= Self.pnlData.Width/4;
  Self.pnlDataItem2.Width:= Self.pnlData.Width/4;
  Self.pnlDataItem3.Width:= Self.pnlData.Width/4;
  Self.pnlDataItem4.Width:= Self.pnlData.Width/4;
end;

procedure TFrameViewBill.sbClientVertScrollBarChange(Sender: TObject);
begin
  //如果lvGroupByTypes被挡往了,就顶在
  if sbClient.VertScrollBar.Prop.Position>Self.pnlGroupByTypes.Top then
  begin
    Self.lvGroupByTypes.Align:=TAlignLayout.None;
    Self.lvGroupByTypes.Parent:=Self;
    Self.lvGroupByTypes.Top:=Self.pnlToolBar.Top+pnlToolBar.Height;
  end
  else
  begin
    Self.lvGroupByTypes.Parent:=pnlGroupByTypes;
    Self.lvGroupByTypes.Align:=TAlignLayout.Top;
  end;

end;

procedure TFrameViewBill.SkinFMXButton2Click(Sender: TObject);
begin
  HideFrame;
  ShowFrame(TFrame(GlobalEditBillFrame),TFrameEditBill);
  GlobalEditBillFrame.Load('客户',FDataJson);

end;

procedure TFrameViewBill.tsDetailsClick(Sender: TObject);
begin

end;

// 新增联系人
procedure TFrameViewBill.btnAddContactClick(Sender: TObject);
begin
  HideFrame;
  ShowFrame(TFrame(GlobalEditBillFrame),TFrameEditBill);
//  GlobalEditBillFrame.Load(FDataJson);
end;

end.
