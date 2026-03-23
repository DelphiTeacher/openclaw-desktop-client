//convert pas to utf8 by ¥
unit ListItemStyleFrame_IconTopCenterBackColor_CaptionBottomCenterBlack;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,


  uGraphicCommon,
  uSkinItems,
  uSkinBufferBitmap,
  uSkinCustomListType,
//  BaseListItemStyleFrame,
//
//
//  ListItemStyleFrame_Base,
  uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinImageType, uSkinFireMonkeyImage,
  uDrawPicture, uSkinImageList;

type
  TFrameListItemStyle_IconTopCenterBackColor_CaptionBottomCenterBlack = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    imgItemIcon: TSkinFMXImage;
    lblItemCaption: TSkinFMXLabel;
  private
    { Private declarations }
  public
    function GetItemDesignerPanel:TSkinItemDesignerPanel;
  public
    constructor Create(AOwner:TComponent);override;
    { Public declarations }
  end;


implementation

{$R *.fmx}




{ TFrameListItemStyle_IconTopCenterBackColor_CaptionBottomCenterBlack }

constructor TFrameListItemStyle_IconTopCenterBackColor_CaptionBottomCenterBlack.Create(
  AOwner: TComponent);
begin
  inherited;

  if not GlobalIsMakeListItemStyleFrameSnapshot then
  begin
    Self.imgItemIcon.Prop.Picture.Clear;
  end;
end;

function TFrameListItemStyle_IconTopCenterBackColor_CaptionBottomCenterBlack.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

initialization
  RegisterListItemStyle('IconTopCenterBackColor_CaptionBottomCenterBlack',TFrameListItemStyle_IconTopCenterBackColor_CaptionBottomCenterBlack);


finalization
  UnRegisterListItemStyle(TFrameListItemStyle_IconTopCenterBackColor_CaptionBottomCenterBlack);



end.
