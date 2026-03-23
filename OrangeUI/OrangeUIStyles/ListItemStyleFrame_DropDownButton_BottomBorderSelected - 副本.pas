//convert pas to utf8 by ¥
unit ListItemStyleFrame_DropDownButton_BottomBorderSelected;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinButtonType, uSkinFireMonkeyButton;


type
  //根基类
  TFrameListItemStyle_DropDownButton_BottomBorderSelected = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    btnItemCaption: TSkinFMXButton;
    pnlBottomLine: TSkinFMXPanel;
    SkinFMXButton1: TSkinFMXButton;
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



{ TFrameListItemStyle_DropDownButton_BottomBorderSelected }

constructor TFrameListItemStyle_DropDownButton_BottomBorderSelected.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_DropDownButton_BottomBorderSelected.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;




initialization
//  RegisterListItemStyle('BaseSelected',TFrameListItemStyle_DropDownButton_BottomBorderSelected);
  RegisterListItemStyle('DropDownButton_BottomBorderSelected',TFrameListItemStyle_DropDownButton_BottomBorderSelected);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_DropDownButton_BottomBorderSelected);
  UnRegisterListItemStyle(TFrameListItemStyle_DropDownButton_BottomBorderSelected);

end.
