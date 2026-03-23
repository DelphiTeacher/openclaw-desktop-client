//convert pas to utf8 by ¥
unit ListItemStyleFrame_QueryRadioButton;

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
  uSkinRadioButtonType, uSkinFireMonkeyRadioButton, uSkinPanelType,
  uSkinFireMonkeyPanel;


type
  //根基类
  TFrameListItemStyle_QueryRadioButton = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    lblItemCaption: TSkinFMXLabel;
    rbtnQuery: TSkinFMXRadioButton;
    SkinFMXPanel1: TSkinFMXPanel;
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



{ TFrameListItemStyle_QueryRadioButton }

constructor TFrameListItemStyle_QueryRadioButton.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_QueryRadioButton.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;




initialization
  RegisterListItemStyle('QueryRadioButton',TFrameListItemStyle_QueryRadioButton);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_QueryRadioButton);

end.
