//convert pas to utf8 by ¥
unit ListItemStyleFrame_IconTopCenter_TwoCaptionBottomCenterBlack;

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
  TFrameListItemStyle_IconTopCenter_TwoCaptionBottomCenterBlack = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    imgItemIcon: TSkinFMXImage;
    lblItemCaption: TSkinFMXLabel;
    SkinFMXLabel1: TSkinFMXLabel;
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




{ TFrameListItemStyle_IconTopCenter_TwoCaptionBottomCenterBlack }

constructor TFrameListItemStyle_IconTopCenter_TwoCaptionBottomCenterBlack.Create(
  AOwner: TComponent);
begin
  inherited;

  Self.imgItemIcon.Prop.Picture.Clear;
end;

function TFrameListItemStyle_IconTopCenter_TwoCaptionBottomCenterBlack.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

initialization
  RegisterListItemStyle('IconTopCenter_TwoCaptionBottomCenterBlack',TFrameListItemStyle_IconTopCenter_TwoCaptionBottomCenterBlack);


finalization
  UnRegisterListItemStyle(TFrameListItemStyle_IconTopCenter_TwoCaptionBottomCenterBlack);



end.
