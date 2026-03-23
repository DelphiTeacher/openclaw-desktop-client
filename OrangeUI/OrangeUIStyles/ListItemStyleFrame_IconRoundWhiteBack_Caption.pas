//convert pas to utf8 by ¥
unit ListItemStyleFrame_IconRoundWhiteBack_Caption;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  EasyServiceCommonMaterialDataMoudle,
  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinCheckBoxType,
  uSkinFireMonkeyCheckBox, uSkinButtonType, uSkinFireMonkeyButton,
  uSkinImageType, uSkinFireMonkeyImage;


type
  TFrameListItemStyle_IconRoundWhiteBack_Caption = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    lblItemCaption: TSkinFMXLabel;
    imgItemIcon: TSkinFMXImage;
    procedure ItemDesignerPanelResize(Sender: TObject);
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



{ TFrameListItemStyleFrame_IconRoundWhiteBack_Caption }

constructor TFrameListItemStyle_IconRoundWhiteBack_Caption.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_IconRoundWhiteBack_Caption.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;




procedure TFrameListItemStyle_IconRoundWhiteBack_Caption.ItemDesignerPanelResize(
  Sender: TObject);
begin
  Self.imgItemIcon.Width:=Self.imgItemIcon.Height;
end;

initialization
  RegisterListItemStyle('IconRoundWhiteBack_Caption',TFrameListItemStyle_IconRoundWhiteBack_Caption);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_IconRoundWhiteBack_Caption);

end.
