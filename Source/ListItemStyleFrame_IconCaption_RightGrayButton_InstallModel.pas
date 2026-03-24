//convert pas to utf8 by ¥
unit ListItemStyleFrame_IconCaption_RightGrayButton_InstallModel;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,


  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,


  BaseListItemStyleFrame, uSkinImageType, uSkinFireMonkeyImage, uSkinLabelType,
  uSkinFireMonkeyLabel, uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uDrawPicture, uSkinImageList;

type
  TFrameIconCaption_RightGrayButton_InstallModelListItemStyle = class(TFrameBaseListItemStyle)
    imgItemIcon: TSkinFMXImage;
    lblItemDetail: TSkinFMXLabel;
    imglistExpanded: TSkinImageList;
    imgAccessory: TSkinFMXImage;
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



procedure TFrameIconCaption_RightGrayButton_InstallModelListItemStyle.ItemDesignerPanelResize(
  Sender: TObject);
begin
  inherited;

  //图标的尺寸保持正方形
  Self.imgItemIcon.Width:=Self.imgItemIcon.Height;

end;

initialization
  RegisterListItemStyle('IconCaption_RightGrayButton_InstallModel',TFrameIconCaption_RightGrayButton_InstallModelListItemStyle);

finalization
  UnRegisterListItemStyle(TFrameIconCaption_RightGrayButton_InstallModelListItemStyle);


end.
