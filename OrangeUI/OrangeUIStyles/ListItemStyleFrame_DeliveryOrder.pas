//convert pas to utf8 by ¥
unit ListItemStyleFrame_DeliveryOrder;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinButtonType, uSkinFireMonkeyButton,
  uSkinImageType, uSkinFireMonkeyImage, uSkinMultiColorLabelType,
  uSkinFireMonkeyMultiColorLabel, FMX.Controls.Presentation;


type
  //根基类
  TFrameListItemStyle_DeliveryOrder = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    btnRiderArrive: TSkinFMXButton;
    SkinFMXPanel1: TSkinFMXPanel;
    SkinFMXPanel2: TSkinFMXPanel;
    SkinFMXImage1: TSkinFMXImage;
    lblCreateTime: TSkinFMXLabel;
    lblCarPlate: TSkinFMXLabel;
    SkinFMXPanel3: TSkinFMXPanel;
    SkinFMXLabel9: TSkinFMXLabel;
    SkinFMXLabel10: TSkinFMXLabel;
    SkinFMXPanel4: TSkinFMXPanel;
    SkinFMXLabel6: TSkinFMXLabel;
    SkinFMXLabel5: TSkinFMXLabel;
    SkinFMXPanel5: TSkinFMXPanel;
    SkinFMXLabel4: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    SkinFMXPanel6: TSkinFMXPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    lblSendAddr: TSkinFMXLabel;
    SkinFMXPanel7: TSkinFMXPanel;
    SkinFMXLabel3: TSkinFMXLabel;
    lblRecvAddr: TSkinFMXLabel;
    SkinFMXPanel8: TSkinFMXPanel;
    SkinFMXLabel7: TSkinFMXLabel;
    lblMemo: TSkinFMXLabel;
    procedure ItemDesignerPanelResize(Sender: TObject);
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



{ TFrameListItemStyle_DeliveryOrder }

constructor TFrameListItemStyle_DeliveryOrder.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_DeliveryOrder.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

procedure TFrameListItemStyle_DeliveryOrder.ItemDesignerPanelResize(
  Sender: TObject);
begin
//  lblItemDetail.Height:=ItemDesignerPanel.Height*0.3;

end;

initialization
  RegisterListItemStyle('DeliveryOrder',TFrameListItemStyle_DeliveryOrder);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_DeliveryOrder);

end.
