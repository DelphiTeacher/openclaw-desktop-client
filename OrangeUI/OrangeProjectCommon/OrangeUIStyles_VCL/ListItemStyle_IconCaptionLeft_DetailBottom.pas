unit ListItemStyle_IconCaptionLeft_DetailBottom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,

  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,
  EasyServiceCommonMaterialDataMoudle_VCL,

  Graphics, Controls, Forms, Dialogs, uSkinLabelType,
  uSkinImageType, uSkinWindowsControl, uSkinItemDesignerPanelType,
  ImgList, uDrawPicture, uSkinImageList, uSkinButtonType, uSkinCheckBoxType;

type
  TFrameListItemStyle_IconCaptionLeft_DetailBottom = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinWinItemDesignerPanel;
    imgItemIcon: TSkinWinImage;
    imgItemCaption: TSkinWinLabel;
    imgRefresh: TSkinWinImage;
    imglistDelete: TSkinImageList;
    btnDelete: TSkinWinButton;
    chkSelected: TSkinWinCheckBox;
    lblDetail: TSkinWinLabel;
  private
    { Private declarations }
  public
    function GetItemDesignerPanel:TSkinItemDesignerPanel;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrameListItemStyle_IconCaptionLeft_DetailBottom }

function TFrameListItemStyle_IconCaptionLeft_DetailBottom.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;


initialization
  RegisterListItemStyle('IconCaptionLeft_DetailBottom',TFrameListItemStyle_IconCaptionLeft_DetailBottom);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_IconCaptionLeft_DetailBottom);

end.
