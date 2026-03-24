//convert pas to utf8 by ¥
unit ListItemStyleFrame_ProcessTaskOrder;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  EasyServiceCommonMaterialDataMoudle,
  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,
  uPageStructure,
  uPageInstance,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinCheckBoxType,
  uSkinFireMonkeyCheckBox, uSkinButtonType, uSkinFireMonkeyButton,
  uSkinMultiColorLabelType, uSkinFireMonkeyMultiColorLabel, uSkinImageType,
  uSkinFireMonkeyImage, uSkinRoundImageType, uSkinFireMonkeyRoundImage;


type
  TFrameListItemStyle_ProcessTaskOrder = class(TFrame,IFrameBaseListItemStyle,IFrameBaseListItemStyle_Init)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    SkinFMXLabel10: TSkinFMXLabel;
    SkinFMXLabel11: TSkinFMXLabel;
    SkinFMXLabel12: TSkinFMXLabel;
    SkinFMXLabel13: TSkinFMXLabel;
    lblStyle: TSkinFMXLabel;
    SkinFMXLabel15: TSkinFMXLabel;
    SkinFMXLabel16: TSkinFMXLabel;
    SkinFMXLabel17: TSkinFMXLabel;
    SkinFMXLabel18: TSkinFMXLabel;
    SkinFMXLabel19: TSkinFMXLabel;
    btnComplete: TSkinFMXButton;
    SkinFMXMultiColorLabel1: TSkinFMXMultiColorLabel;
    SkinFMXLabel20: TSkinFMXLabel;
    SkinFMXLabel21: TSkinFMXLabel;
    SkinFMXLabel22: TSkinFMXLabel;
    SkinFMXLabel23: TSkinFMXLabel;
    lblBillNO: TSkinFMXLabel;
    SkinFMXButton2: TSkinFMXButton;
    pnlClient: TSkinFMXPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    SkinFMXLabel3: TSkinFMXLabel;
    SkinFMXLabel4: TSkinFMXLabel;
    SkinFMXLabel5: TSkinFMXLabel;
    imgError: TSkinFMXImage;
    labErrorHint: TSkinFMXLabel;
    lblCompleteTime: TSkinFMXLabel;
    chkItemSelected: TSkinFMXCheckBox;
    pnlPageInstanceParent: TSkinFMXPanel;
    imgItemBigPic: TSkinFMXRoundImage;
    imgItemBigPic2: TSkinFMXRoundImage;
    imgItemBigPic3: TSkinFMXRoundImage;
    procedure ItemDesignerPanelResize(Sender: TObject);
    procedure ItemDesignerPanelSetControlsValueEnd(Sender: TObject;
      AItem: TSkinItem);
  private
    { Private declarations }
  public
    FPage:TPage;
    FPageInstance:TPageInstance;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    function GetItemDesignerPanel:TSkinItemDesignerPanel;virtual;
    procedure Init(AListItemStyleReg:TListItemStyleReg);
    procedure SetPage(APage:TObject);
    { Public declarations }
  end;


implementation

{$R *.fmx}



{ TFrameListItemStyleFrame_ProcessTaskOrder }

constructor TFrameListItemStyle_ProcessTaskOrder.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

destructor TFrameListItemStyle_ProcessTaskOrder.Destroy;
begin
  FreeAndNil(FPageInstance);

  inherited;
end;

function TFrameListItemStyle_ProcessTaskOrder.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

procedure TFrameListItemStyle_ProcessTaskOrder.Init(
  AListItemStyleReg: TListItemStyleReg);
var
  AError:String;
begin
  if FPage<>nil then
  begin
    FPageInstance:=TPageInstance.Create(Self);
    FPageInstance.PageStructure:=FPage;
    if not FPageInstance.CreateControls(Self,
                                       Self.pnlPageInstanceParent,
                                       '',
                                       '',
                                       False,
                                       AError
                                       ) then
    begin
      Exit;
    end;
  end;

end;

procedure TFrameListItemStyle_ProcessTaskOrder.ItemDesignerPanelResize(
  Sender: TObject);
begin
  //拉伸后自动排列
  if FPageInstance<>nil then
  begin
    FPageInstance.FPagePartList.AlignControls;
  end;

end;

procedure TFrameListItemStyle_ProcessTaskOrder.ItemDesignerPanelSetControlsValueEnd(
  Sender: TObject; AItem: TSkinItem);
var
  I: Integer;
begin
  //赋值后自动计算尺寸并排列
  if FPageInstance<>nil then
  begin
    for I := 0 to FPageInstance.MainControlMapList.Count-1 do
    begin
      FPageInstance.MainControlMapList[I].AutoSize;
    end;
    FPageInstance.FPagePartList.AlignControls;
    Self.pnlPageInstanceParent.Height:=
      FPageInstance.MainControlMapList.FLayoutList.FListLayoutsManager.CalcContentHeight;
  end;

end;

procedure TFrameListItemStyle_ProcessTaskOrder.SetPage(APage: TObject);
begin
  FPage:=TPage(APage);
end;

initialization
  RegisterListItemStyle('ProcessTaskOrder',TFrameListItemStyle_ProcessTaskOrder,89,True);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_ProcessTaskOrder);

end.
