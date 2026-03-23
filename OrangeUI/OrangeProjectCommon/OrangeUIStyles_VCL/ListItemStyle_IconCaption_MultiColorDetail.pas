unit ListItemStyle_IconCaption_MultiColorDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,

  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,

  Graphics, Controls, Forms, Dialogs, uSkinLabelType,
  uSkinImageType, uSkinWindowsControl, uSkinItemDesignerPanelType,
  ImgList, uDrawPicture, uSkinImageList, uSkinButtonType,
  uSkinMultiColorLabelType;

type
  TFrameListItemStyle_IconCaption_MultiColorDetail = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinWinItemDesignerPanel;
    imgItemIcon: TSkinWinImage;
    lblItemCaption: TSkinWinLabel;
    lblItemDetail: TSkinWinMultiColorLabel;
    procedure ItemDesignerPanelResize(Sender: TObject);
  private
    { Private declarations }
  public
    function GetItemDesignerPanel:TSkinItemDesignerPanel;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrameListItemStyle_IconCaption_MultiColorDetail }

function TFrameListItemStyle_IconCaption_MultiColorDetail.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;


procedure TFrameListItemStyle_IconCaption_MultiColorDetail.ItemDesignerPanelResize(
  Sender: TObject);
begin
//  imgItemIcon.Width:=imgItemIcon.Height;
  //»√Caption∫Õdetailæ”÷–
//  Self.lblItemCaption.Top:=(Self.ItemDesignerPanel.Height-Self.lblItemCaption.Height-Self.lblItemDetail.Height) div 2;
//  Self.lblItemDetail.Top:=Self.lblItemCaption.Top+Self.lblItemCaption.Height;
end;

initialization
  RegisterListItemStyle('IconCaption_MultiColorDetail',TFrameListItemStyle_IconCaption_MultiColorDetail);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_IconCaption_MultiColorDetail);

end.
