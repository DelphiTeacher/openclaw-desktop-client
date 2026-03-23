unit ListItemStyle_RPATaskDaySummary;

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
  TFrameListItemStyle_RPATaskDaySummary = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinWinItemDesignerPanel;
    imgItemIcon: TSkinWinImage;
    lblItemCaption: TSkinWinLabel;
    lblItemDetail1: TSkinWinMultiColorLabel;
    lblItemDetail: TSkinWinMultiColorLabel;
    lblItemDetail2: TSkinWinMultiColorLabel;
    procedure ItemDesignerPanelResize(Sender: TObject);
  private
    { Private declarations }
  public
    function GetItemDesignerPanel:TSkinItemDesignerPanel;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrameListItemStyle_RPATaskDaySummary }

function TFrameListItemStyle_RPATaskDaySummary.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;


procedure TFrameListItemStyle_RPATaskDaySummary.ItemDesignerPanelResize(
  Sender: TObject);
begin
//  imgItemIcon.Width:=imgItemIcon.Height;
  //»√Caption∫Õdetailæ”÷–
//  Self.lblItemCaption.Top:=(Self.ItemDesignerPanel.Height-Self.lblItemCaption.Height-Self.lblItemDetail.Height) div 2;
//  Self.lblItemDetail.Top:=Self.lblItemCaption.Top+Self.lblItemCaption.Height;
end;

initialization
  RegisterListItemStyle('RPATaskDaySummary',TFrameListItemStyle_RPATaskDaySummary);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_RPATaskDaySummary);

end.
