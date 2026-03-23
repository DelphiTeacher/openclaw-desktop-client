//convert pas to utf8 by ¥
unit ListItemStyleFrame_DefaultCenter_BottomBorderSelected;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uSkinItems,
  uSkinBufferBitmap,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel;


type
  //根基类
  TFrameListItemStyle_DefaultCenter_BottomBorderSelected = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    lblItemCaption: TSkinFMXLabel;
    pnlBottomLine: TSkinFMXPanel;
    procedure ItemDesignerPanelCalcItemSize(Sender: TObject; AItem: TSkinItem;
      AItemDrawRect: TRectF; var AItemSize: TSizeF);
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



{ TFrameListItemStyle_DefaultCenter_BottomBorderSelected }

constructor TFrameListItemStyle_DefaultCenter_BottomBorderSelected.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_DefaultCenter_BottomBorderSelected.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

procedure TFrameListItemStyle_DefaultCenter_BottomBorderSelected.ItemDesignerPanelCalcItemSize(
  Sender: TObject; AItem: TSkinItem; AItemDrawRect: TRectF;
  var AItemSize: TSizeF);
begin
  //自动计算列表项的宽度
  AItemSize.Width:=uSkinBufferBitmap.CalcStringWidth(Self.lblItemCaption.Caption,Self.ItemDesignerPanel.Height,Self.lblItemCaption.Material.DrawCaptionParam);
end;

initialization
  RegisterListItemStyle('DefaultCenter_BottomBorderSelected',TFrameListItemStyle_DefaultCenter_BottomBorderSelected);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_DefaultCenter_BottomBorderSelected);
  UnRegisterListItemStyle(TFrameListItemStyle_DefaultCenter_BottomBorderSelected);

end.
