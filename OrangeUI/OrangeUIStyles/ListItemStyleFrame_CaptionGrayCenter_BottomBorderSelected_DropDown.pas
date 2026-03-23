//convert pas to utf8 by ¥
unit ListItemStyleFrame_CaptionGrayCenter_BottomBorderSelected_DropDown;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uDrawCanvas,
  uSkinItems,
  uSkinBufferBitmap,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinButtonType, uSkinFireMonkeyButton;


type
  //根基类
  TFrameListItemStyle_CaptionGrayCenter_BottomBorderSelected_DropDown = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    lblItemCaption: TSkinFMXLabel;
    pnlBottomLine: TSkinFMXPanel;
    btnDropDown: TSkinFMXButton;
    procedure ItemDesignerPanelCalcItemSize(Sender: TObject; AItem: TSkinItem;
      AItemDrawRect: TRectF; var AItemSize: TSizeF);
    procedure ItemDesignerPanelResize(Sender: TObject);
    procedure ItemDesignerPanelPrepareDrawItem(Sender: TObject;
      ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinItemDesignerPanel;
      AItem: TSkinItem; AItemDrawRect: TRectF);
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
  public
    function GetItemDesignerPanel:TSkinItemDesignerPanel;virtual;
    { Public declarations }
  end;


implementation

{$R *.fmx}



{ TFrameListItemStyle_CaptionGrayCenter_BottomBorderSelected_DropDown }

constructor TFrameListItemStyle_CaptionGrayCenter_BottomBorderSelected_DropDown.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_CaptionGrayCenter_BottomBorderSelected_DropDown.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

procedure TFrameListItemStyle_CaptionGrayCenter_BottomBorderSelected_DropDown.ItemDesignerPanelCalcItemSize(
  Sender: TObject; AItem: TSkinItem; AItemDrawRect: TRectF;
  var AItemSize: TSizeF);
begin
  //自动计算列表项的宽度
  AItemSize.Width:=uSkinBufferBitmap.CalcStringWidth(Self.lblItemCaption.Caption,
                                                      Self.ItemDesignerPanel.Height,
                                                      Self.lblItemCaption.Material.DrawCaptionParam);
  if Self.btnDropDown.Visible then
  begin
    AItemSize.Width:=AItemSize.Width+Self.btnDropDown.Width;
  end;

end;

procedure TFrameListItemStyle_CaptionGrayCenter_BottomBorderSelected_DropDown.ItemDesignerPanelPrepareDrawItem(
  Sender: TObject; ACanvas: TDrawCanvas;
  AItemDesignerPanel: TSkinItemDesignerPanel; AItem: TSkinItem;
  AItemDrawRect: TRectF);
begin
  if Self.btnDropDown.Visible then
  begin
    Self.lblItemCaption.Left:=(Self.ItemDesignerPanel.Width-Self.lblItemCaption.Width-Self.btnDropDown.Width)/2;
    Self.btnDropDown.Left:=Self.lblItemCaption.Left+Self.lblItemCaption.Width;
  end
  else
  begin
    Self.lblItemCaption.Left:=(Self.ItemDesignerPanel.Width-Self.lblItemCaption.Width)/2;
  end;

end;

procedure TFrameListItemStyle_CaptionGrayCenter_BottomBorderSelected_DropDown.ItemDesignerPanelResize(
  Sender: TObject);
begin
  if Self.btnDropDown.Visible then
  begin
    Self.lblItemCaption.Left:=(Self.ItemDesignerPanel.Width-Self.lblItemCaption.Width-Self.btnDropDown.Width)/2;
    Self.btnDropDown.Left:=Self.lblItemCaption.Left+Self.lblItemCaption.Width;
  end
  else
  begin
    Self.lblItemCaption.Left:=(Self.ItemDesignerPanel.Width-Self.lblItemCaption.Width)/2;
  end;
end;

initialization
  RegisterListItemStyle('CaptionGrayCenter_BottomBorderSelected_DropDown',TFrameListItemStyle_CaptionGrayCenter_BottomBorderSelected_DropDown);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_CaptionGrayCenter_BottomBorderSelected_DropDown);
  UnRegisterListItemStyle(TFrameListItemStyle_CaptionGrayCenter_BottomBorderSelected_DropDown);

end.
