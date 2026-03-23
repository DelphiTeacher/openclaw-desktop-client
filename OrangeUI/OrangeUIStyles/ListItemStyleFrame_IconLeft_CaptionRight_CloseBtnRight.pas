//convert pas to utf8 by ¥
unit ListItemStyleFrame_IconLeft_CaptionRight_CloseBtnRight;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  EasyServiceCommonMaterialDataMoudle,
  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinCheckBoxType,
  uSkinFireMonkeyCheckBox, uSkinButtonType, uSkinFireMonkeyButton,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit,
  uSkinMultiColorLabelType, uSkinFireMonkeyMultiColorLabel, uDrawPicture,
  uSkinImageList, uSkinImageType, uSkinFireMonkeyImage;


type
  //桑拿项目房态
  TFrameListItemStyle_IconLeft_CaptionRight_CloseBtnRight = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    lbCaption: TSkinFMXLabel;
    btnDelete: TSkinFMXButton;
    imgItemIcon: TSkinFMXImage;
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
  public
    function GetItemDesignerPanel:TSkinItemDesignerPanel;virtual;
    { Public declarations }
  end;


implementation

{$R *.fmx}



{ TFrameListItemStyleFrame_IconLeft_CaptionRight_CloseBtnRight }

constructor TFrameListItemStyle_IconLeft_CaptionRight_CloseBtnRight.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;



end;

function TFrameListItemStyle_IconLeft_CaptionRight_CloseBtnRight.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;




initialization
  RegisterListItemStyle('IconLeft_CaptionRight_CloseBtnRight',TFrameListItemStyle_IconLeft_CaptionRight_CloseBtnRight);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_IconLeft_CaptionRight_CloseBtnRight);

end.
