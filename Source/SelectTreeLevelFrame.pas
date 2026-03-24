unit SelectTreeLevelFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  BaseParentFrame, System.Actions, FMX.ActnList, uDrawPicture, uSkinImageList,

  XSuperObject,
  uTimerTask,
  WaitingFrame,
  uUIFunction,
  uRestInterfaceCall,
  uOpenClientCommon,
  uManager,
  HintFrame,
  uFuncCommon,
  uFrameContext,
  uDatasetToJson,
  MessageBoxFrame,
  ParentItemStyleFrame_CheckBoxRight,
  ListItemStyleFrame_IconCaptionCheckBox,
  uSkinItemJsonHelper,
  EasyServiceCommonMaterialDataMoudle,

  uSkinScrollControlType, uSkinScrollBoxType, uSkinFireMonkeyScrollBox,
  uSkinButtonType, uSkinFireMonkeyButton, uSkinFireMonkeyControl,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinCustomListType,
  uSkinVirtualGridType, uSkinDBGridType, uSkinFireMonkeyDBGrid,
  uSkinVirtualListType, uSkinListBoxType, uSkinFireMonkeyListBox,
  uSkinCheckBoxType, uSkinFireMonkeyCheckBox, uSkinImageType,
  uSkinFireMonkeyImage, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinItemDesignerPanelType, uSkinFireMonkeyItemDesignerPanel, uDrawCanvas,
  uSkinItems, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Edit, FMX.Controls.Presentation, uSkinFireMonkeyEdit,
  uTimerTaskEvent, uSkinListViewType, uSkinFireMonkeyListView,
  uSkinTreeViewType, uSkinFireMonkeyTreeView;

type
  TFrameSelectTreeLevel = class(TFrameParent)
    pnlSearch: TSkinFMXPanel;
    edtQueryCondition: TSkinFMXEdit;
    ClearEditButton1: TClearEditButton;
    lvData: TSkinFMXTreeView;
    btnAdd: TSkinFMXButton;
    btnOK: TSkinFMXButton;
    SkinImageList1: TSkinImageList;
    procedure lvDataClickItem(AItem: TSkinItem);
    procedure btnOKClick(Sender: TObject);
    procedure lvDataNewListItemStyleFrameCacheInit(Sender: TObject;
      AListItemTypeStyleSetting: TListItemTypeStyleSetting;
      ANewListItemStyleFrameCache: TListItemStyleFrameCache);
    procedure btnReturnClick(Sender: TObject);
    procedure lvDataPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
      AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem;
      AItemDrawRect: TRect);
  private
    FRolePowerJsonArray:ISuperArray;
  public
    //是否可以返回上一个Frame
    function CanReturn:TFrameReturnActionType;override;

//    FPostJsonArray:ISuperArray;
    { Private declarations }
  public
    FSelectedCaptions:String;
    FSelectedValues:String;
    { Public declarations }
  public
    procedure Load(ACaption:String;
                    ARecordList:ISuperArray;
                    AIsMultiSelect:Boolean;
                    ASelectedCaptions:String;
                    ASelectedValues:String);

    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;

var
  GlobalSelectTreeLevelFrame: TFrameSelectTreeLevel;


implementation

{$R *.fmx}


{ TFrameSelectGoodsType }

procedure TFrameSelectTreeLevel.btnOKClick(Sender: TObject);
var
//  I: Integer;
//  J: Integer;
//  AParentItem,AChildItem:TSkinTreeViewItem;
  ASelectedList:TList;
  ASkinItem:TSkinItem;
  I: Integer;
  AIsAllSelected:Boolean;
begin
  inherited;

  FSelectedCaptions:='';
  FSelectedValues:='';

  //判断是不是全选
  AIsAllSelected:=True;
  for I := 0 to Self.lvData.Prop.Items.Count-1 do
  begin
    AIsAllSelected:=AIsAllSelected and Self.lvData.Prop.Items[I].Selected;
  end;
  if AIsAllSelected then
  begin
    HideFrame;
    ReturnFrame;
    Exit;
  end;


  ASelectedList:=Self.lvData.Prop.GetSelectedItems;
  try
    for I := 0 to ASelectedList.Count-1 do
    begin
      if FSelectedCaptions<>'' then
      begin
        FSelectedCaptions:=FSelectedCaptions+',';
        FSelectedValues:=FSelectedValues+',';
      end;

      FSelectedCaptions:=FSelectedCaptions+TSkinTreeViewItem(ASelectedList[I]).Caption;
      FSelectedValues:=FSelectedValues+TSkinTreeViewItem(ASelectedList[I]).Name;
    end;


  finally
    FreeAndNil(ASelectedList);
  end;
//    for I := 0 to Self.lvData.Prop.Items.Count-1 do
//    begin
//      AParentItem:=TSkinTreeViewItem(Self.lvData.Prop.Items[I]);
//
////      if AParentItem.Selected then
////      begin
//        ASuperObject:=SO();
//        ASuperObject.S['power_fid']:=AParentItem.Json.S['fid'];
//        ASuperObject.I['role_fid']:=FRoleJson.I['fid'];
//        ASuperObject.S['value']:=IntToStr(Ord(AParentItem.Selected));
//        ASuperArray.O[ASuperArray.Length]:=ASuperObject;
////      end;
//
//
//    end;

  HideFrame;
  ReturnFrame;
end;

procedure TFrameSelectTreeLevel.btnReturnClick(Sender: TObject);
begin
  uUIFunction.ClearOnReturnFrameEvent(Self);
  inherited;

end;

function TFrameSelectTreeLevel.CanReturn: TFrameReturnActionType;
begin
  Result:=TFrameReturnActionType.fratDefault;
end;

constructor TFrameSelectTreeLevel.Create(AOwner: TComponent);
begin
  inherited;

  Self.lvData.Prop.Items.BeginUpdate;
  try
    Self.lvData.Prop.Items.Clear();
  finally
    Self.lvData.Prop.Items.EndUpdate;
  end;

end;

destructor TFrameSelectTreeLevel.Destroy;
begin

  inherited;
end;

procedure TFrameSelectTreeLevel.Load(ACaption:String;ARecordList:ISuperArray;AIsMultiSelect:Boolean;ASelectedCaptions:String;ASelectedValues:String);
var
  I:Integer;
  AItem:TSkinItem;
  ARecordJson:ISuperObject;
  AChildRecordJson:ISuperObject;
  AParentLevelCode:String;
  AParentListViewItem:TSkinTreeViewItem;
  AListViewItem:TSkinTreeViewItem;
//  AChildListViewItem:TSkinTreeViewItem;
//  AListItemStyleReg:TListItemStyleReg;
  J: Integer;
//  AParentSelected:Boolean;
  ALevel: Integer;
  ASelectedList:TStringList;
begin

  Self.pnlToolBar.Caption:=ACaption;
  Self.lvData.Prop.MultiSelect:=AIsMultiSelect;
  Self.btnOK.Visible:=AIsMultiSelect;

          Self.lvData.Prop.Items.BeginUpdate;
          try

            Self.lvData.Prop.Items.ClearItemsByType(sitDefault);

            //加载第一层
            for ALevel := 0 to 6 do
            begin

              for I := 0 to ARecordList.Length-1 do
              begin

                ARecordJson:=ARecordList.O[I];
                //001
                if Length(ARecordJson.S['等级编码']) div 3 = ALevel+1 then
                begin


                    //找找有没有上一层的,有上一层的建在上一层里面,没有的话,直接建在最外层
                    if ALevel=0 then
                    begin
                      //加载第一层
                      AListViewItem:=Self.lvData.Prop.Items.Add;//TSkinTreeViewItem.Create;//Self.lvOrderList.Prop.Items.Add;
                    end
                    else
                    begin
                      //001001的上一级是001
                      AParentLevelCode:=Copy(ARecordJson.S['等级编码'],1,Length(ARecordJson.S['等级编码'])-3);
                      AParentListViewItem:=TSkinTreeViewItem(Self.lvData.Prop.Items.FindItemByDetail1(AParentLevelCode));
                      if AParentListViewItem=nil then
                      begin
                        Continue;
                      end;
                      AListViewItem:=AParentListViewItem.Childs.Add;
                    end;
  //                  Self.lvData.Prop.Items.Add(AListViewItem);
                    AListViewItem.Json:=ARecordJson;
                    AListViewItem.Caption:=ARecordJson.S['类别'];
                    AListViewItem.Name:=ARecordJson.S['类别编码'];
                    AListViewItem.Detail1:=ARecordJson.S['等级编码'];
//                    AListViewItem.Selected:=(ARolePowerJson<>nil) and (ARolePowerJson.S['value']='1');

//
//                    //加载第二层
//                    AParentSelected:=True;
//                    for J := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
//                    begin
//                      AChildRecordJson:=ASuperObject.O['Data'].A['RecordList'].O[J];
//
//                      if AChildRecordJson.S['parent_fid']=ARecordJson.S['fid'] then
//                      begin
//
//                        AChildListViewItem:=AListViewItem.Childs.Add;//TSkinTreeViewItem.Create;
//  //                      AListViewItem.Childs.Add(AChildListViewItem);
//                        AChildListViewItem.Json:=AChildRecordJson;
//                        AChildListViewItem.Caption:=AChildRecordJson.S['name'];
//
//                        ARolePowerJson:=LocateJsonArray(Self.FRolePowerJsonArray,'power_fid',AChildRecordJson.S['fid']);
//
//                        AChildListViewItem.Selected:=(ARolePowerJson<>nil) and (ARolePowerJson.S['value']='1');
//
//                        AParentSelected:=AParentSelected and AChildListViewItem.Selected;
//                      end;
//
//                    end;
//                    if AListViewItem.Childs.Count>0 then
//                    begin
//                      AListViewItem.Selected:=AParentSelected;
//                    end;



                end;


              end;



            end;

            if Self.lvData.Prop.MultiSelect then
            begin
                //多选
                //加载是否勾选
                ASelectedList:=SplitString(Self.FSelectedValues);
                try
                  for I := 0 to ASelectedList.Count-1 do
                  begin
                    AListViewItem:=Self.lvData.Prop.Items.FindItemByName(ASelectedList[I]);
                    if AListViewItem<>nil then
                    begin
                      AListViewItem.Selected:=True;

                      AListViewItem.SetAllChildSelected(True);
                    end;
                  end;
                finally
                  FreeAndNil(ASelectedList);
                end;
                if Self.lvData.Prop.MultiSelect then Self.lvData.Prop.SetSelectedByAllChildSelected;
            end
            else
            begin
                //单选
                Self.lvData.Prop.SelectedItem:=Self.lvData.Prop.Items.FindItemByName(Self.FSelectedValues);
            end;


          finally
            Self.lvData.Prop.Items.EndUpdate();
          end;

//          Self.lvData.Prop.Items.BeginUpdate;
//          try
//            for ALevel := 0 to 5 do
//            begin
//
//              for I := 0 to ARecordList.Length-1 do
//              begin
//
//                ARecordJson:=ARecordList.O[I];
//                //001
//                if Length(ARecordJson.S['等级编码']) div 3 = I+1 then
//                begin
//
//
//                    //找找有没有上一层的,有上一层的建在上一层里面,没有的话,直接建在最外层
//                    if ALevel=0 then
//                    begin
//                      //加载第一层
//                      AListViewItem:=Self.lvData.Prop.Items.Add;//TSkinTreeViewItem.Create;//Self.lvOrderList.Prop.Items.Add;
//                    end
//                    else
//                    begin
//                      //001001的上一级是001
//                      AParentLevelCode:=Copy(ARecordJson.S['等级编码'],1,I*3);
//                      AParentListViewItem:=Self.lvData.Prop.Items.FindItemByName(AParentLevelCode);
//                      if AParentListViewItem=nil then
//                      begin
//                        Continue;
//                      end;
//                    end;
//  //                  Self.lvData.Prop.Items.Add(AListViewItem);
//                    AListViewItem.Json:=ARecordJson;
//                    AListViewItem.Caption:=ARecordJson.S['类别'];
//                    AListViewItem.Name:=ARecordJson.S['类别编码'];
////                    AListViewItem.Selected:=(ARolePowerJson<>nil) and (ARolePowerJson.S['value']='1');
//
////
////                    //加载第二层
////                    AParentSelected:=True;
////                    for J := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
////                    begin
////                      AChildRecordJson:=ASuperObject.O['Data'].A['RecordList'].O[J];
////
////                      if AChildRecordJson.S['parent_fid']=ARecordJson.S['fid'] then
////                      begin
////
////                        AChildListViewItem:=AListViewItem.Childs.Add;//TSkinTreeViewItem.Create;
////  //                      AListViewItem.Childs.Add(AChildListViewItem);
////                        AChildListViewItem.Json:=AChildRecordJson;
////                        AChildListViewItem.Caption:=AChildRecordJson.S['name'];
////
////                        ARolePowerJson:=LocateJsonArray(Self.FRolePowerJsonArray,'power_fid',AChildRecordJson.S['fid']);
////
////                        AChildListViewItem.Selected:=(ARolePowerJson<>nil) and (ARolePowerJson.S['value']='1');
////
////                        AParentSelected:=AParentSelected and AChildListViewItem.Selected;
////                      end;
////
////                    end;
////                    if AListViewItem.Childs.Count>0 then
////                    begin
////                      AListViewItem.Selected:=AParentSelected;
////                    end;
//
//
//
//                end;
//
//
//              end;
//
//
//
//            end;
//
//
//          finally
//            Self.lvData.Prop.Items.EndUpdate();
//          end;


end;

procedure TFrameSelectTreeLevel.lvDataClickItem(AItem: TSkinItem);
//var
//  I: Integer;
//  ASelected:Boolean;
begin
  inherited;

  if Self.lvData.Prop.MultiSelect then
  begin
      TSkinTreeViewItem(AItem).SetAllChildSelected(AItem.Selected);
    //  TSkinTreeViewItem(AItem).Parent.SetSelectedByAllChildSelected;
      Self.lvData.Prop.SetSelectedByAllChildSelected;
    //  if TSkinTreeViewItem(AItem).IsParent then
    //  begin
    //    //子节点都保持一致
    //    for I := 0 to TSkinTreeViewItem(AItem).Childs.Count-1 do
    //    begin
    //      TSkinTreeViewItem(AItem).Childs[I].Selected:=AItem.Selected;
    //    end;
    //  end
    //  else
    //  begin
    //      ASelected:=AItem.Selected;
    //      if not AItem.Selected then
    //      begin
    //        TSkinTreeViewItem(AItem).Parent.Selected:=False;
    //      end
    //      else
    //      begin
    //        for I := 0 to TSkinTreeViewItem(AItem).Parent.Childs.Count-1 do
    //        begin
    //          ASelected:=ASelected and TSkinTreeViewItem(AItem).Parent.Childs[I].Selected;
    //        end;
    //        TSkinTreeViewItem(AItem).Parent.Selected:=ASelected;
    //      end;
    //  end;
  end
  else
  begin
      FSelectedCaptions:=TSkinTreeViewItem(AItem).Caption;
      FSelectedValues:=TSkinTreeViewItem(AItem).Name;
      HideFrame;
      ReturnFrame;
  end;

end;

procedure TFrameSelectTreeLevel.lvDataNewListItemStyleFrameCacheInit(
  Sender: TObject; AListItemTypeStyleSetting: TListItemTypeStyleSetting;
  ANewListItemStyleFrameCache: TListItemStyleFrameCache);
begin
  inherited;

  if ANewListItemStyleFrameCache.FItemStyleFrame is TFrameParentItemStyle_CheckBoxRight then
  begin
    TFrameParentItemStyle_CheckBoxRight(ANewListItemStyleFrameCache.FItemStyleFrame).chkSelected.HitTest:=False;
    TFrameParentItemStyle_CheckBoxRight(ANewListItemStyleFrameCache.FItemStyleFrame).chkSelected.Visible:=Self.lvData.Prop.MultiSelect;
  end;

  if ANewListItemStyleFrameCache.FItemStyleFrame is TFrameIconCaptionCheckBoxListItemStyle then
  begin
    TFrameIconCaptionCheckBoxListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).imgItemIcon.Visible:=False;
    TFrameIconCaptionCheckBoxListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).cbIsSelected.Visible:=Self.lvData.Prop.MultiSelect;
//    TFrameIconCaptionCheckBoxListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).ItemDesignerPanel.Prop.ItemIconBindingControl:=nil;
//    TFrameIconCaptionCheckBoxListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).imgItemIcon.BindItemFieldName:='';
//    TFrameIconCaptionCheckBoxListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).imgItemIcon.Prop.Picture.Clear;
//    TFrameIconCaptionCheckBoxListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).imgItemIcon.Prop.Picture.SkinImageList:=Self.SkinImageList1;
//    TFrameIconCaptionCheckBoxListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).imgItemIcon.Prop.Picture.ImageIndex:=0;

  end;

end;

procedure TFrameSelectTreeLevel.lvDataPrepareDrawItem(Sender: TObject;
  ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
  AItem: TSkinItem; AItemDrawRect: TRect);
begin
  inherited;

  if not Self.lvData.Prop.MultiSelect then
  begin
    if AItemDesignerPanel.Parent is TFrameParentItemStyle_CheckBoxRight then
    begin
      TFrameParentItemStyle_CheckBoxRight(AItemDesignerPanel.Parent).chkSelected.Visible:=AItem.Selected;
    end;

    if AItemDesignerPanel.Parent is TFrameIconCaptionCheckBoxListItemStyle then
    begin
      TFrameIconCaptionCheckBoxListItemStyle(AItemDesignerPanel.Parent).cbIsSelected.Visible:=AItem.Selected;
    end;
  end;

end;

end.
