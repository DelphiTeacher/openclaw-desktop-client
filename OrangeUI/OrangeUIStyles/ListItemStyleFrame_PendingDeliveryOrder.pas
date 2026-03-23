//convert pas to utf8 by ¥
unit ListItemStyleFrame_PendingDeliveryOrder;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uSkinItems,
  uUIFunction,
  uSkinVirtualListType,
  uSkinCustomListType,
  EasyServiceCommonMaterialDataMoudle,

  uDrawCanvas,
  uSkinBufferBitmap,
  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinButtonType, uSkinFireMonkeyButton,
  uSkinImageType, uSkinFireMonkeyImage, uSkinMultiColorLabelType,
  uSkinFireMonkeyMultiColorLabel, FMX.Controls.Presentation;


type
  //根基类
  TFrameListItemStyle_PendingDeliveryOrder = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    btnButton1: TSkinFMXButton;
    pnlVertLine: TSkinFMXPanel;
    SkinFMXPanel2: TSkinFMXPanel;
    imgCreateTime: TSkinFMXImage;
    lblCreateTime: TSkinFMXLabel;
    lblCarPlate: TSkinFMXLabel;
    pnlSick: TSkinFMXPanel;
    lblSick: TSkinFMXLabel;
    SkinFMXLabel10: TSkinFMXLabel;
    SkinFMXPanel4: TSkinFMXPanel;
    SkinFMXLabel6: TSkinFMXLabel;
    lblSendPhone: TSkinFMXLabel;
    pnlRiderName: TSkinFMXPanel;
    SkinFMXLabel4: TSkinFMXLabel;
    lblRiderName: TSkinFMXLabel;
    pnlSendAddr: TSkinFMXPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    lblSendAddr: TSkinFMXLabel;
    pnlRecvAddr: TSkinFMXPanel;
    SkinFMXLabel3: TSkinFMXLabel;
    lblRecvAddr: TSkinFMXLabel;
    pnlMemo: TSkinFMXPanel;
    SkinFMXLabel7: TSkinFMXLabel;
    lblMemo: TSkinFMXLabel;
    SkinFMXImage1: TSkinFMXImage;
    pnlSceneAddr: TSkinFMXPanel;
    SkinFMXLabel2: TSkinFMXLabel;
    lblSceneAddr: TSkinFMXLabel;
    pnlVertLine2: TSkinFMXPanel;
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



{ TFrameListItemStyle_PendingDeliveryOrder }

constructor TFrameListItemStyle_PendingDeliveryOrder.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_PendingDeliveryOrder.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

procedure TFrameListItemStyle_PendingDeliveryOrder.ItemDesignerPanelPrepareDrawItem(
  Sender: TObject; ACanvas: TDrawCanvas;
  AItemDesignerPanel: TSkinItemDesignerPanel; AItem: TSkinItem;
  AItemDrawRect: TRectF);
var
  AHeight:Double;
Const
  LineHeight=30;
begin
  AHeight:=uSkinBufferBitmap.CalcStringHeight(Self.lblSick.Text,lblSick.Width,lblSick.Material.DrawCaptionParam);
  if (AHeight>0) and (AHeight<LineHeight) then AHeight:=LineHeight;
  Self.pnlSick.Height:=AHeight;

  if (Self.lblSceneAddr.Text<>'') and (Self.lblSceneAddr.Text<>Self.lblSendAddr.Text) then
  begin
    AHeight:=uSkinBufferBitmap.CalcStringHeight(Self.lblSceneAddr.Text,lblSceneAddr.Width,lblSceneAddr.Material.DrawCaptionParam);
    if (AHeight>0) and (AHeight<LineHeight) then AHeight:=LineHeight;
    Self.pnlSceneAddr.Height:=AHeight;

  end
  else
  begin
    Self.pnlSceneAddr.Height:=0;
  end;

  AHeight:=uSkinBufferBitmap.CalcStringHeight(Self.lblSendAddr.Text,lblSendAddr.Width,lblSendAddr.Material.DrawCaptionParam);
  if (AHeight>0) and (AHeight<LineHeight) then AHeight:=LineHeight;
  Self.pnlSendAddr.Height:=AHeight;

  if Self.pnlSceneAddr.Height>0 then
  begin
    Self.pnlVertLine.Top:=Self.pnlSceneAddr.Top+18;
    Self.pnlVertLine.Height:=Self.pnlSendAddr.Top-Self.pnlVertLine.Top;
    Self.pnlVertLine.Visible:=True;
  end
  else
  begin
    Self.pnlVertLine.Visible:=False;
  end;


  AHeight:=uSkinBufferBitmap.CalcStringHeight(Self.lblRecvAddr.Text,lblRecvAddr.Width,lblRecvAddr.Material.DrawCaptionParam);
  if (AHeight<LineHeight) then AHeight:=LineHeight;
  Self.pnlRecvAddr.Height:=AHeight;



  AHeight:=uSkinBufferBitmap.CalcStringHeight(Self.lblMemo.Text,lblMemo.Width,lblMemo.Material.DrawCaptionParam);
  if (AHeight>0) and (AHeight<LineHeight) then AHeight:=LineHeight;
  Self.pnlMemo.Height:=AHeight;


  Self.pnlVertLine2.Top:=Self.pnlSendAddr.Top+18;
  Self.pnlVertLine2.Height:=Self.pnlRecvAddr.Top-Self.pnlVertLine2.Top;


//  AItem.Height:=Self.btnButton1.Top+btnButton1.Height+20;
  AItem.Height:=GetSuitControlContentHeight(ItemDesignerPanel);
  //Self.pnlRiderName.Top+pnlRiderName.Height+20;
end;

procedure TFrameListItemStyle_PendingDeliveryOrder.ItemDesignerPanelResize(
  Sender: TObject);
begin
//  lblItemDetail.Height:=ItemDesignerPanel.Height*0.3;

end;

initialization
  RegisterListItemStyle('PendingDeliveryOrder',TFrameListItemStyle_PendingDeliveryOrder);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_PendingDeliveryOrder);

end.
