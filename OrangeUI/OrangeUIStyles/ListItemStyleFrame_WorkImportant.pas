//convert pas to utf8 by ¥
unit ListItemStyleFrame_WorkImportant;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  Math,
  uSkinItems,
  uDrawCanvas,
  uSkinVirtualListType,
  uSkinCustomListType,
  uSkinBufferBitmap,
//  EasyServiceCommonMaterialDataMoudle,

  BaseListItemStyleFrame, uSkinImageType, uSkinFireMonkeyImage, uSkinLabelType,
  uSkinFireMonkeyLabel, uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinPanelType, uSkinFireMonkeyPanel,
  uSkinCheckBoxType, uSkinFireMonkeyCheckBox, uSkinButtonType,
  uSkinFireMonkeyButton;

type
  TFrameWorkImportantListItemStyle = class(TFrameBaseListItemStyle)
    imgCompleted: TSkinFMXImage;
    chkIndex: TSkinFMXCheckBox;
    btnComplete: TSkinFMXButton;
    lblItemDetail: TSkinFMXLabel;
    lblCreateDate: TSkinFMXLabel;
    procedure ItemDesignerPanelResize(Sender: TObject);
    procedure ItemDesignerPanelCalcItemSize(Sender: TObject; AItem: TSkinItem;
      AItemDrawRect: TRectF; var AItemSize: TSizeF);
    procedure ItemDesignerPanelPrepareDrawItem(Sender: TObject;
      ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinItemDesignerPanel;
      AItem: TSkinItem; AItemDrawRect: TRectF);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.fmx}

//uses
//  uSkinCustomListType;



procedure TFrameWorkImportantListItemStyle.ItemDesignerPanelCalcItemSize(
  Sender: TObject; AItem: TSkinItem; AItemDrawRect: TRectF;
  var AItemSize: TSizeF);
begin
  inherited;

  lblItemCaption.Height:=uSkinBufferBitmap.CalcStringHeight(Self.lblItemCaption.Text,lblItemCaption.Width,Self.lblItemCaption.Material.DrawCaptionParam)
                          +5;
  AItem.Tag:=Ceil(lblItemCaption.Height);

  if Self.lblItemDetail.Text<>'' then
  begin
    lblItemDetail.Height:=uSkinBufferBitmap.CalcStringHeight(Self.lblItemDetail.Text,lblItemDetail.Width,Self.lblItemDetail.Material.DrawCaptionParam)
                          +5;
    AItem.Tag1:=Ceil(lblItemDetail.Height);
  end;

  AItemSize.cy:=lblItemCaption.Top
                +lblItemCaption.Height

                +lblItemDetail.Height
                //底部留一点出来
                ;

  if Self.lblCreateDate.Visible then
  begin
    AItemSize.cy:=AItemSize.cy+Self.lblCreateDate.Height;
  end;

end;

procedure TFrameWorkImportantListItemStyle.ItemDesignerPanelPrepareDrawItem(
  Sender: TObject; ACanvas: TDrawCanvas;
  AItemDesignerPanel: TSkinItemDesignerPanel; AItem: TSkinItem;
  AItemDrawRect: TRectF);
var
  ATop:Double;
begin
  inherited;

  lblItemCaption.Height:=AItem.Tag;

  ATop:=lblItemCaption.Top+lblItemCaption.Height+5;

  if Self.lblItemDetail.Text<>'' then
  begin
    lblItemDetail.Top:=ATop;
    lblItemDetail.Height:=AItem.Tag1;

    ATop:=lblItemDetail.Top+Self.lblItemDetail.Height+5;
  end;

  if Self.lblCreateDate.Visible then
  begin
    lblCreateDate.Top:=ATop;
  end;

end;

procedure TFrameWorkImportantListItemStyle.ItemDesignerPanelResize(
  Sender: TObject);
begin
  inherited;

//  //图标的尺寸保持正方形
//  Self.imgItemIcon.Width:=Self.imgItemIcon.Height;

end;

initialization
  RegisterListItemStyle('WorkImportant',TFrameWorkImportantListItemStyle);

finalization
  UnRegisterListItemStyle(TFrameWorkImportantListItemStyle);


end.

