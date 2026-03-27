//convert pas to utf8 by ¥
unit ListItemStyleFrame_AIModelConfig;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinMultiColorLabelType, uSkinFireMonkeyMultiColorLabel, uSkinImageType,
  uSkinFireMonkeyImage, uSkinPanelType, uSkinFireMonkeyPanel, uSkinButtonType,
  uSkinNotifyNumberIconType, uSkinFireMonkeyNotifyNumberIcon, uSkinCheckBoxType;


type
  //根基类
  TFrameListItemStyle_AIModelConfig = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    imgItemIcon: TSkinFMXImage;
    lblItemCaption: TSkinFMXLabel;
    lblItemDetail: TSkinFMXLabel;
    SkinFMXPanel1: TSkinFMXPanel;
    SkinFMXPanel2: TSkinFMXPanel;
    SkinFMXPanel3: TSkinFMXPanel;
    SkinFMXPanel4: TSkinFMXPanel;
    lblContextSize: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    lblToolCall: TSkinFMXLabel;
    SkinFMXLabel4: TSkinFMXLabel;
    lblVisual: TSkinFMXLabel;
    SkinFMXLabel6: TSkinFMXLabel;
    SkinCheckBox1: TSkinCheckBox;
    btnTest: TSkinButton;
    btnConfig: TSkinButton;
    procedure SkinFMXPanel1Resize(Sender: TObject);
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



{ TFrameBaseListItemStyle }

constructor TFrameListItemStyle_AIModelConfig.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_AIModelConfig.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;




procedure TFrameListItemStyle_AIModelConfig.SkinFMXPanel1Resize(
  Sender: TObject);
begin
  Self.btnTest.Position.Y:=(Self.SkinFMXPanel1.Height-Self.btnTest.Height) / 2;
  Self.btnConfig.Position.Y:=(Self.SkinFMXPanel1.Height-Self.btnConfig.Height) / 2;
end;

initialization
  RegisterListItemStyle('AIModelConfig',TFrameListItemStyle_AIModelConfig);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_AIModelConfig);

end.
