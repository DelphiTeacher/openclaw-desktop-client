unit ListItemStyle_RPAClientState;

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
  TFrameListItemStyle_RPAClientState = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinWinItemDesignerPanel;
    imgItemIcon: TSkinWinImage;
    lblItemCaption: TSkinWinLabel;
    lblItemDetail1: TSkinWinMultiColorLabel;
    lblItemDetail: TSkinWinMultiColorLabel;
    lblItemDetail2: TSkinWinMultiColorLabel;
    btnStartTask: TSkinButton;
    procedure ItemDesignerPanelResize(Sender: TObject);
  private
    { Private declarations }
  public
    function GetItemDesignerPanel:TSkinItemDesignerPanel;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrameListItemStyle_RPAClientState }

function TFrameListItemStyle_RPAClientState.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;


procedure TFrameListItemStyle_RPAClientState.ItemDesignerPanelResize(
  Sender: TObject);
begin
//  imgItemIcon.Width:=imgItemIcon.Height;
  //»√Caption∫Õdetailæ”÷–
//  Self.lblItemCaption.Top:=(Self.ItemDesignerPanel.Height-Self.lblItemCaption.Height-Self.lblItemDetail.Height) div 2;
//  Self.lblItemDetail.Top:=Self.lblItemCaption.Top+Self.lblItemCaption.Height;

//  Self.btnStartTask.Top:=(Self.ItemDesignerPanel.Height-Self.btnStartTask.Height) div 2;
end;

initialization
  RegisterListItemStyle('RPAClientState',TFrameListItemStyle_RPAClientState);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_RPAClientState);

end.
