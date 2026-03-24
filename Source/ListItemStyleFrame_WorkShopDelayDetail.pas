//convert pas to utf8 by ¥
unit ListItemStyleFrame_WorkShopDelayDetail;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  EasyServiceCommonMaterialDataMoudle,
  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,
  uPageStructure,
  uDrawCanvas,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinCheckBoxType,
  uSkinFireMonkeyCheckBox, uSkinButtonType, uSkinFireMonkeyButton,
  uSkinMultiColorLabelType, uSkinFireMonkeyMultiColorLabel, uSkinImageType,
  uSkinFireMonkeyImage;


type
  TFrameListItemStyle_WorkShopDelayDetail = class(TFrame,IFrameBaseListItemStyle,IFrameBaseListItemStyle_Init)
    ItemDesignerPanel: TSkinFMXItemDesignerPanel;
    lblStyleHint: TSkinFMXLabel;
    SkinFMXLabel12: TSkinFMXLabel;
    SkinFMXLabel13: TSkinFMXLabel;
    lblStyle: TSkinFMXLabel;
    SkinFMXLabel17: TSkinFMXLabel;
    SkinFMXLabel18: TSkinFMXLabel;
    SkinFMXLabel20: TSkinFMXLabel;
    SkinFMXLabel22: TSkinFMXLabel;
    lblBillNO: TSkinFMXLabel;
    pnlClient: TSkinFMXPanel;
    chkItemSelected: TSkinFMXCheckBox;
    SkinFMXLabel1: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    lblDoorStructureHint: TSkinFMXLabel;
    lblDoorStructure: TSkinFMXLabel;
    imgError: TSkinFMXImage;
    labErrorHint: TSkinFMXLabel;
    lblCompleteTime: TSkinFMXLabel;
    SkinFMXLabel5: TSkinFMXLabel;
    pnlPageInstanceParent: TSkinFMXPanel;
    btnComplete: TSkinFMXButton;
    btnProcess: TSkinFMXButton;
    procedure ItemDesignerPanelPrepareDrawItem(Sender: TObject;
      ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinItemDesignerPanel;
      AItem: TSkinItem; AItemDrawRect: TRectF);
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



{ TFrameListItemStyleFrame_ReportDetail }

constructor TFrameListItemStyle_WorkShopDelayDetail.Create(AOwner: TComponent);
begin
  inherited;

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  ItemDesignerPanel.Align:=TAlignLayout.None;
end;

destructor TFrameListItemStyle_WorkShopDelayDetail.Destroy;
begin
  FreeAndNil(FPageInstance);
  inherited;
end;

function TFrameListItemStyle_WorkShopDelayDetail.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

procedure TFrameListItemStyle_WorkShopDelayDetail.Init(
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

procedure TFrameListItemStyle_WorkShopDelayDetail.ItemDesignerPanelPrepareDrawItem(
  Sender: TObject; ACanvas: TDrawCanvas;
  AItemDesignerPanel: TSkinItemDesignerPanel; AItem: TSkinItem;
  AItemDrawRect: TRectF);
begin
  //
end;

procedure TFrameListItemStyle_WorkShopDelayDetail.ItemDesignerPanelResize(
  Sender: TObject);
begin
  //拉伸后自动排列
  if FPageInstance<>nil then
  begin
    FPageInstance.FPagePartList.AlignControls;
  end;
end;

procedure TFrameListItemStyle_WorkShopDelayDetail.ItemDesignerPanelSetControlsValueEnd(
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

procedure TFrameListItemStyle_WorkShopDelayDetail.SetPage(APage: TObject);
begin
  FPage:=TPage(APage);
end;

initialization
  RegisterListItemStyle('WorkShopDelayDetail',
                      TFrameListItemStyle_WorkShopDelayDetail,
                      178,
                      True);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_WorkShopDelayDetail);

end.
