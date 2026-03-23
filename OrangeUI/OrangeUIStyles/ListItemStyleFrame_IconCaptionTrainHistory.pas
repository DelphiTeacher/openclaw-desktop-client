//convert pas to utf8 by ¥
unit ListItemStyleFrame_IconCaptionTrainHistory;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType, uSkinImageType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinFireMonkeyImage, uSkinPanelType, uSkinFireMonkeyPanel;


type
  //根基类
  TFrameListItemStyle_IconCaptionTrainHistory = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    imgItemIcon: TSkinFMXImage;
    SkinFMXPanel1: TSkinFMXPanel;
    SkinFMXPanel2: TSkinFMXPanel;
    SkinFMXPanel3: TSkinFMXPanel;
    labTrainName: TSkinFMXLabel;
    labTrainTime: TSkinFMXLabel;
    SkinFMXLabel1: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    imgHasReport: TSkinFMXImage;
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

constructor TFrameListItemStyle_IconCaptionTrainHistory.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_IconCaptionTrainHistory.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

initialization
  RegisterListItemStyle('IconCaptionTrainHistory',TFrameListItemStyle_IconCaptionTrainHistory);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_IconCaptionTrainHistory);

end.
