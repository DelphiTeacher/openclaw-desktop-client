//convert pas to utf8 by ¥
unit ListItemStyleFrame_QualityCheck;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uGraphicCommon,
  uSkinItems,
  uSkinBufferBitmap,
  XSuperObject,
  uPageStructure,
  uSkinItemJsonHelper,
  BaseListItemStyleFrame,
  ListItemStyleFrame_Comment,
  EasyServiceCommonMaterialDataMoudle,


  uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinImageType, uSkinFireMonkeyImage,
  uSkinMultiColorLabelType, uSkinFireMonkeyMultiColorLabel, uSkinButtonType,
  uSkinFireMonkeyButton, uDrawCanvas, uDrawPicture, uSkinImageList,
  uSkinScrollControlType, uSkinCustomListType, uSkinVirtualListType,
  uSkinListBoxType, uSkinFireMonkeyListBox, uSkinMaterial,
  FMX.Controls.Presentation, uSkinPanelType, uSkinFireMonkeyPanel,
  uSkinImageListViewerType, uSkinFireMonkeyImageListViewer, uSkinRoundImageType,
  uSkinFireMonkeyRoundImage, uSkinListViewType, uSkinRegExTagLabelViewType;

type
  TFrameQualityCheckListItemStyle = class(TFrameBaseListItemStyle,IFrameBaseListItemStyle,IFrameBaseListItemStyle_Init)
    imgItemIcon: TSkinFMXImage;
    btnFocus: TSkinFMXButton;
    pnlButtons: TSkinFMXPanel;
    btnTransmit: TSkinFMXButton;
    btnLikeState: TSkinFMXButton;
    btnComment: TSkinFMXButton;
    btnFocused: TSkinFMXButton;
    btnFavState: TSkinFMXButton;
    lblDelete: TSkinFMXLabel;
    btnReadCount: TSkinFMXButton;
    lblItemDetail: TSkinFMXLabel;
    SkinFMXMultiColorLabel1: TSkinFMXLabel;
    SkinFMXButton2: TSkinFMXButton;
    SkinFMXLabel11: TSkinFMXLabel;
    SkinFMXLabel12: TSkinFMXLabel;
    SkinFMXLabel15: TSkinFMXLabel;
    SkinFMXLabel16: TSkinFMXLabel;
    SkinFMXLabel17: TSkinFMXLabel;
    SkinFMXLabel18: TSkinFMXLabel;
    SkinFMXLabel19: TSkinFMXLabel;
    SkinFMXLabel20: TSkinFMXLabel;
    SkinFMXLabel21: TSkinFMXLabel;
    SkinFMXLabel22: TSkinFMXLabel;
    SkinFMXLabel23: TSkinFMXLabel;
    lblBillNO: TSkinFMXLabel;
    lblProcess: TSkinFMXLabel;
    lblProcessHint: TSkinFMXLabel;
    lblItemCaptionHint: TSkinFMXLabel;
    btnPicCount: TSkinFMXButton;
    SkinFMXLabel4: TSkinFMXLabel;
    SkinFMXLabel5: TSkinFMXLabel;
    imgItemBigPic2: TSkinFMXRoundImage;
    imgItemBigPic3: TSkinFMXRoundImage;
    imgItemBigPic: TSkinFMXRoundImage;
    pnlPageInstanceParent: TSkinFMXPanel;
    SkinFMXLabel6: TSkinFMXLabel;
    SkinFMXLabel7: TSkinFMXLabel;
    SkinFMXLabel8: TSkinFMXLabel;
    SkinFMXLabel9: TSkinFMXLabel;
    pnlProcessedInfo: TSkinFMXPanel;
    imgProcessedItemBigPic: TSkinFMXRoundImage;
    imgProcessedItemBigPic2: TSkinFMXRoundImage;
    imgProcessedItemBigPic3: TSkinFMXRoundImage;
    lblProcessedResult: TSkinFMXHintLabel;
    lblProcessedCorrectAndPreventAction: TSkinFMXHintLabel;
    SkinFMXPanel1: TSkinFMXPanel;
    SkinFMXLabel3: TSkinFMXLabel;
    lblProcessedEmp: TSkinFMXLabel;
    SkinFMXLabel14: TSkinFMXLabel;
    lblProcessedTime: TSkinFMXLabel;
    SkinFMXPanel2: TSkinFMXPanel;
    lblGroupHint: TSkinFMXLabel;
    lblGroup: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    SkinFMXLabel1: TSkinFMXLabel;
    SkinFMXLabel10: TSkinFMXLabel;
    lblProcessedState: TSkinFMXLabel;
    btnProcess: TSkinFMXButton;
    procedure lbCommentListGetItemBufferCacheTag(Sender: TObject;
      AItem: TSkinItem; var ACacheTag: Integer);
    procedure ItemDesignerPanelPrepareDrawItem(Sender: TObject;
      ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinItemDesignerPanel;
      AItem: TSkinItem; AItemDrawRect: TRectF);
    procedure pnlPageInstanceParentResize(Sender: TObject);
    procedure ItemDesignerPanelSetControlsValueEnd(Sender: TObject;
      AItem: TSkinItem);
  private
    { Private declarations }
  public
    FPage:TPage;
    FPageInstance:TPageInstance;
    procedure Init(AListItemStyleReg:TListItemStyleReg);
    procedure SetPage(APage:TObject);
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    { Public declarations }
  end;



implementation



{$R *.fmx}


constructor TFrameQualityCheckListItemStyle.Create(AOwner: TComponent);
begin
  inherited;
//  Self.imgItemBigPic.Prop.Picture.Clear;
  //Self.imgItemBigPic.Material.IsDrawClipRound:=False;

  lblItemCaption.Text:='';

end;

destructor TFrameQualityCheckListItemStyle.Destroy;
begin

  FreeAndNil(FPageInstance);
  inherited;
end;

procedure TFrameQualityCheckListItemStyle.Init(
  AListItemStyleReg: TListItemStyleReg);
var
  AError:String;
begin
  if FPage<>nil then
  begin
    FPageInstance:=TPageInstance.Create(Self);
    FPageInstance.PageStructure:=FPage;
    if not FPageInstance.CreateControls(Self,
                                       Self.pnlPageInstanceParent,
                                       '',
                                       '',
                                       False,
                                       AError
                                       ) then
    begin
      Exit;
    end;
  end;


end;

procedure TFrameQualityCheckListItemStyle.ItemDesignerPanelPrepareDrawItem(
  Sender: TObject; ACanvas: TDrawCanvas;
  AItemDesignerPanel: TSkinItemDesignerPanel; AItem: TSkinItem;
  AItemDrawRect: TRectF);
var
//  I: Integer;
  AItemDataJson:ISuperObject;
//  APic1Width:Integer;
//  APic1Height:Integer;
//  APicCount:Integer;
//  APicturesHeight:Double;
  AContentHeight:Double;
begin

  inherited;


  AItemDataJson:=AItem.Json;

  Self.pnlPageInstanceParent.Height:=
      Self.FPageInstance.MainControlMapList.FLayoutList.FListLayoutsManager.CalcContentHeight;


  //备注
  if lblItemCaption.Caption<>'' then
  begin
    AContentHeight:=
            uSkinBufferBitmap.GetStringHeight(lblItemCaption.Caption,
                RectF(0,0,Self.lblItemCaption.Width,MaxInt),
                Self.lblItemCaption.Material.DrawCaptionParam);
    Self.lblItemCaption.Height:=AContentHeight;


  end
  else
  begin
    //没有文本内容
    AContentHeight:=0;
    Self.lblItemCaption.Height:=Self.lblItemCaptionHint.Height;
  end;

  lblItemCaption.Top:=Self.pnlPageInstanceParent.Top+Self.pnlPageInstanceParent.Height+5;
  lblItemCaptionHint.Top:=Self.pnlPageInstanceParent.Top+Self.pnlPageInstanceParent.Height+5;


  Self.imgItemBigPic.Visible:=AItemDataJson.S['pic1_path']<>'';
  Self.imgItemBigPic2.Visible:=AItemDataJson.S['pic2_path']<>'';
  Self.imgItemBigPic3.Visible:=AItemDataJson.S['pic3_path']<>'';

  Self.imgItemBigPic.Position.Y:=
        Self.lblItemCaption.Position.Y
        +Self.lblItemCaption.Height
        +5;
  Self.imgItemBigPic2.Position.Y:=Self.imgItemBigPic.Position.Y;
  Self.imgItemBigPic3.Position.Y:=Self.imgItemBigPic.Position.Y;

  if Self.imgItemBigPic.Visible then
  begin
    Self.pnlProcessedInfo.Top:=Self.imgItemBigPic.Top+Self.imgItemBigPic.Height+5;
  end
  else
  begin
    Self.pnlProcessedInfo.Top:=Self.lblItemCaption.Top+Self.lblItemCaption.Height+5;
  end;


  //判断是不是已经处理
  Self.pnlProcessedInfo.Visible:=AItemDataJson.B['已处理否'];
  if AItemDataJson.B['已处理否'] then
  begin
    Self.btnProcess.Visible:=False;
    Self.lblProcessedState.Caption:='已处理';
    Self.lblProcessedState.Material.DrawCaptionParam.FontColor:=SkinThemeColor;
    Self.imgProcessedItemBigPic.Visible:=AItemDataJson.S['processed_pic1_path']<>'';
    Self.imgProcessedItemBigPic2.Visible:=AItemDataJson.S['processed_pic2_path']<>'';
    Self.imgProcessedItemBigPic3.Visible:=AItemDataJson.S['processed_pic3_path']<>'';


    Self.imgProcessedItemBigPic.Position.Y:=
          Self.lblProcessedCorrectAndPreventAction.Position.Y
          +Self.lblProcessedCorrectAndPreventAction.Height
          +5;
    Self.imgProcessedItemBigPic2.Position.Y:=Self.imgProcessedItemBigPic.Position.Y;
    Self.imgProcessedItemBigPic3.Position.Y:=Self.imgProcessedItemBigPic.Position.Y;


    if Self.imgProcessedItemBigPic.Visible then
    begin
      Self.pnlProcessedInfo.Height:=Self.imgProcessedItemBigPic.Top+Self.imgProcessedItemBigPic.Height+5;
    end
    else
    begin
      Self.pnlProcessedInfo.Height:=Self.lblProcessedCorrectAndPreventAction.Top+Self.lblProcessedCorrectAndPreventAction.Height+5;
    end;
  end
  else
  begin
    Self.btnProcess.Visible:=True;
    Self.lblProcessedState.Caption:='未处理';
    Self.lblProcessedState.Material.DrawCaptionParam.FontColor:=TAlphaColorRec.Red;
  end;


end;

procedure TFrameQualityCheckListItemStyle.ItemDesignerPanelSetControlsValueEnd(
  Sender: TObject; AItem: TSkinItem);
var
  I: Integer;
begin
  inherited;
  //赋值后自动计算尺寸并排列
  if FPageInstance<>nil then
  begin
    for I := 0 to FPageInstance.MainControlMapList.Count-1 do
    begin
      FPageInstance.MainControlMapList[I].AutoSize;
    end;
    FPageInstance.FPagePartList.AlignControls;
    Self.pnlPageInstanceParent.Height:=
      FPageInstance.MainControlMapList.FLayoutList.FListLayoutsManager.CalcContentHeight;
  end;

end;

procedure TFrameQualityCheckListItemStyle.lbCommentListGetItemBufferCacheTag(
  Sender: TObject; AItem: TSkinItem; var ACacheTag: Integer);
begin
  ACacheTag:=Integer(AItem);
end;

procedure TFrameQualityCheckListItemStyle.pnlPageInstanceParentResize(
  Sender: TObject);
begin
  inherited;
  //拉伸后自动排列
  if FPageInstance<>nil then
  begin
    FPageInstance.FPagePartList.AlignControls;
  end;

end;

procedure TFrameQualityCheckListItemStyle.SetPage(APage: TObject);
begin
  FPage:=TPage(APage);
end;

initialization
  RegisterListItemStyle('QualityCheck',
                        TFrameQualityCheckListItemStyle,
                        241,
                        True);


finalization
  UnRegisterListItemStyle(TFrameQualityCheckListItemStyle);

end.
