//convert pas to utf8 by ¥
unit ParentItemStyleFrame_CaptionAutoSize_ExpandButtonRight;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uDrawPicture, uSkinImageList, uSkinImageType, uSkinFireMonkeyImage;


type
  TFrameParentItemStyle_CaptionAutoSize_ExpandButtonRight = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    imgGroupExpanded: TSkinFMXImage;
    lblGroupName: TSkinFMXLabel;
    imglistExpanded: TSkinImageList;
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



{ TFrameParentItemStyle_CaptionAutoSize_ExpandButtonRight }

constructor TFrameParentItemStyle_CaptionAutoSize_ExpandButtonRight.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameParentItemStyle_CaptionAutoSize_ExpandButtonRight.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;




initialization
  RegisterListItemStyle('ParentItem_CaptionAutoSize_ExpandButtonRight',TFrameParentItemStyle_CaptionAutoSize_ExpandButtonRight);


finalization
  UnRegisterListItemStyle(TFrameParentItemStyle_CaptionAutoSize_ExpandButtonRight);

end.

