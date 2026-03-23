//convert pas to utf8 by ¥
unit ListItemStyleFrame_ItemSelectedRight;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uDrawPicture, uSkinImageList, uSkinImageType, uSkinFireMonkeyImage,
  uSkinCheckBoxType, uSkinFireMonkeyCheckBox;


type
  TFrameListItemStyleFrame_ItemSelectedRight = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    imgItemSelected: TSkinFMXImage;
    lblItemName: TSkinFMXLabel;
    imglistSelected: TSkinImageList;
    SkinFMXCheckBox1: TSkinFMXCheckBox;
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
  public
    function GetItemDesignerPanel:TSkinItemDesignerPanel;
    { Public declarations }
  end;


implementation

{$R *.fmx}



{ TFrameListItemStyleFrame_ItemSelectedRight }

constructor TFrameListItemStyleFrame_ItemSelectedRight.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyleFrame_ItemSelectedRight.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;




initialization
  RegisterListItemStyle('ListItemStyleFrame_ItemSelectedRight',TFrameListItemStyleFrame_ItemSelectedRight);


finalization
  UnRegisterListItemStyle(TFrameListItemStyleFrame_ItemSelectedRight);

end.

