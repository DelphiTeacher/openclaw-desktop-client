//convert pas to utf8 by ¥
unit ListItemStyleFrame_CaptionTopDetailBottom_AddDecButtonRight;

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
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit;


type
  //根基类
  TFrameListItemStyle_CaptionTopDetailBottom_AddDecButtonRight = class(TFrame,IFrameBaseListItemStyle)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    lblItemCaption: TSkinFMXLabel;
    lblItemDetail: TSkinFMXLabel;
    SkinFMXPanel1: TSkinFMXPanel;
    pnlRight: TSkinFMXPanel;
    edtCount: TSkinFMXEdit;
    btnInc1: TSkinFMXButton;
    btnDec1: TSkinFMXButton;
    procedure ItemDesignerPanelResize(Sender: TObject);
    procedure pnlRightResize(Sender: TObject);
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



{ TFrameListItemStyle_CaptionTopDetailBottom_AddDecButtonRight }

constructor TFrameListItemStyle_CaptionTopDetailBottom_AddDecButtonRight.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

function TFrameListItemStyle_CaptionTopDetailBottom_AddDecButtonRight.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

procedure TFrameListItemStyle_CaptionTopDetailBottom_AddDecButtonRight.ItemDesignerPanelResize(
  Sender: TObject);
begin
//  lblItemDetail.Height:=ItemDesignerPanel.Height*0.3;

end;

procedure TFrameListItemStyle_CaptionTopDetailBottom_AddDecButtonRight.pnlRightResize(
  Sender: TObject);
begin
  Self.btnDec1.Top:=(Self.pnlRight.Height-Self.btnDec1.Height)/2;
  Self.btnInc1.Top:=(Self.pnlRight.Height-Self.btnInc1.Height)/2;
  Self.edtCount.Top:=(Self.pnlRight.Height-Self.edtCount.Height)/2;
end;

initialization
  RegisterListItemStyle('CaptionTopDetailBottom_AddDecButtonRight',TFrameListItemStyle_CaptionTopDetailBottom_AddDecButtonRight);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_CaptionTopDetailBottom_AddDecButtonRight);

end.
