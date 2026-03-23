//convert pas to utf8 by ¥
unit ListItemStyleFrame_IconNotice;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  EasyServiceCommonMaterialDataMoudle,
  uDrawCanvas,
  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinCheckBoxType,
  uSkinFireMonkeyCheckBox, uSkinButtonType, uSkinFireMonkeyButton,
  uSkinImageType, uSkinFireMonkeyImage;


type
  TFrameListItemStyle_IconNotice = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    chkOrderItemSelected: TSkinFMXCheckBox;
    SkinFMXPanel2: TSkinFMXPanel;
    lblOrderDetail: TSkinFMXLabel;
    SkinFMXPanel1: TSkinFMXPanel;
    imgItemIcon: TSkinFMXImage;
    lblOrderNoticeName: TSkinFMXLabel;
    lblOrderCreatetime: TSkinFMXLabel;
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



{ TFrameListItemStyleFrame_ExceptionNotice }

constructor TFrameListItemStyle_IconNotice.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_IconNotice.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

procedure TFrameListItemStyle_IconNotice.ItemDesignerPanelPrepareDrawItem(
  Sender: TObject; ACanvas: TDrawCanvas;
  AItemDesignerPanel: TSkinItemDesignerPanel; AItem: TSkinItem;
  AItemDrawRect: TRectF);
begin
  if AItem<>nil then
  begin
    Self.imgItemIcon.Visible:=AItem.Icon.IsEmpty;
  end;
end;

initialization
  RegisterListItemStyle('IconNotice',TFrameListItemStyle_IconNotice);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_IconNotice);

end.
