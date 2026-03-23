//convert pas to utf8 by ¥
unit ListItemStyleFrame_IconLeftRoundBack_CaptionRightBottom_DetailRightTop;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,


  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,


  BaseListItemStyleFrame, uSkinImageType, uSkinFireMonkeyImage, uSkinLabelType,
  uSkinFireMonkeyLabel, uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uDrawPicture, uSkinImageList,
  uSkinCheckBoxType, uSkinFireMonkeyCheckBox, uSkinPanelType,
  uSkinFireMonkeyPanel;

type
  TFrameIconLeftRoundBack_CaptionRightBottom_DetailRightTopListItemStyle = class(TFrameBaseListItemStyle)
    imgItemIcon: TSkinFMXImage;
    lblItemDetail: TSkinFMXLabel;
    lblItemDetail1: TSkinFMXLabel;
    imgAccessory: TSkinFMXImage;
    imglistExpanded: TSkinImageList;
    pnlSelected: TSkinFMXPanel;
    chkItemSelected: TSkinFMXCheckBox;
    procedure ItemDesignerPanelResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.fmx}

//uses
//  uSkinCustomListType;



procedure TFrameIconLeftRoundBack_CaptionRightBottom_DetailRightTopListItemStyle.ItemDesignerPanelResize(
  Sender: TObject);
begin
  inherited;

  //图标的尺寸保持正方形
  Self.imgItemIcon.Width:=Self.imgItemIcon.Height;

  //平分
  Self.lblItemDetail.Height:=Self.ItemDesignerPanel.Height/2;
  Self.lblItemCaption.Height:=Self.ItemDesignerPanel.Height/2;
end;

initialization
  RegisterListItemStyle('IconLeftRoundBack_CaptionRightBottom_DetailRightTop',TFrameIconLeftRoundBack_CaptionRightBottom_DetailRightTopListItemStyle);

finalization
  UnRegisterListItemStyle(TFrameIconLeftRoundBack_CaptionRightBottom_DetailRightTopListItemStyle);


end.
