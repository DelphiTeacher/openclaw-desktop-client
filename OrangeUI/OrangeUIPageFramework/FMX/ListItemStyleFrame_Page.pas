//convert pas to utf8 by ¥
unit ListItemStyleFrame_Page;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

//  EasyServiceCommonMaterialDataMoudle,
  uDrawCanvas,
  uSkinItems,
  uSkinVirtualListType,
  uSkinCustomListType,
  uPageStructure,
  uPageInstance,

  uSkinFireMonkeyControl, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinCheckBoxType,
  uSkinFireMonkeyCheckBox, uSkinButtonType, uSkinFireMonkeyButton;


type
  TFrameListItemStyle_Page = class(TFrame,IFrameBaseListItemStyle,IFrameBaseListItemStyle_Init)
  private
    procedure ItemDesignerPanelResize(Sender:TObject);virtual;
    procedure ItemDesignerPanelPrepareDrawItem(Sender: TObject;
      ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinItemDesignerPanel;
      AItem: TSkinItem; AItemDrawRect: TRectF);virtual;
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    FPage:TPage;
    FPageInstance:TPageInstance;
    ItemDesignerPanel:TSkinItemDesignerPanel;
    function GetItemDesignerPanel:TSkinItemDesignerPanel;virtual;
    procedure Init(AListItemStyleReg:TListItemStyleReg);
    procedure SetPage(APage:TObject);
    { Public declarations }
  end;


implementation

{$R *.fmx}



{ TFrameListItemStyleFrame_Page }

constructor TFrameListItemStyle_Page.Create(AOwner: TComponent);
begin
  inherited;



  //找到Page,创建控件

  //ListBox在绘制的时候会对ItemDesignerPanel进行SetSize,
  //避免Client拉伸不了
  //ItemDesignerPanel.Align:=TAlignLayout.None;
end;

destructor TFrameListItemStyle_Page.Destroy;
begin
  FreeAndNil(FPageInstance);
  inherited;
end;

function TFrameListItemStyle_Page.GetItemDesignerPanel: TSkinItemDesignerPanel;
begin
  Result:=ItemDesignerPanel;
end;

procedure TFrameListItemStyle_Page.Init(AListItemStyleReg: TListItemStyleReg);
var
  AError:String;
  AParent:TControl;
begin
  if (AListItemStyleReg.DataObject<>nil) and (AListItemStyleReg.DataObject is TPage) then
  begin
    //将Page中的控件创建在ItemDesignerPanel上面
    FPage:=TPage(AListItemStyleReg.DataObject);
    AParent:=Self;
  end
  else
  begin
    //FPage在OnNewListItemStyleFrameCache中赋值
    ItemDesignerPanel:=TSkinItemDesignerPanel.Create(Self);
    ItemDesignerPanel.Parent:=Self;
    ItemDesignerPanel.SelfOwnMaterial;
    ItemDesignerPanel.SkinControlType;
    AParent:=ItemDesignerPanel;

    //加个测试背景
    ItemDesignerPanel.Material.IsTransparent:=False;
    ItemDesignerPanel.Material.BackColor.IsFill:=True;
//    ItemDesignerPanel.Material.BackColor.FillColor.Color:=TAlphaColorRec.Red;
  end;
  FPageInstance:=TPageInstance.Create(Self);
  FPageInstance.PageStructure:=FPage;
  if not FPageInstance.CreateControls(Self,
                                     AParent,
                                     '',
                                     '',
                                     False,
                                     AError
                                     ) then
  begin
    Exit;
  end;
  //连设计面板都是设计好的,直接使用Frame上的设计面板即可
  if (AListItemStyleReg.DataObject<>nil) and (AListItemStyleReg.DataObject is TPage) then
  begin
    ItemDesignerPanel:=TSkinItemDesignerPanel(FPageInstance.MainControlMapList.Items[0].Component);
  end;

  ItemDesignerPanel.OnResize:=ItemDesignerPanelResize;
  ItemDesignerPanel.OnPrepareDrawItem:=ItemDesignerPanelPrepareDrawItem;
end;

procedure TFrameListItemStyle_Page.ItemDesignerPanelPrepareDrawItem(
  Sender: TObject; ACanvas: TDrawCanvas;
  AItemDesignerPanel: TSkinItemDesignerPanel; AItem: TSkinItem;
  AItemDrawRect: TRectF);
var
  I: Integer;
begin
  if FPageInstance<>nil then
  begin
    for I := 0 to FPageInstance.MainControlMapList.Count-1 do
    begin
      FPageInstance.MainControlMapList[I].AutoSize;
    end;
    FPageInstance.FPagePartList.AlignControls;
  end;
end;

procedure TFrameListItemStyle_Page.ItemDesignerPanelResize(Sender: TObject);
begin
  if FPageInstance<>nil then
  begin
    FPageInstance.FPagePartList.AlignControls;
  end;
end;

procedure TFrameListItemStyle_Page.SetPage(APage: TObject);
begin
  FPage:=TPage(APage);
end;

initialization
  RegisterListItemStyle('PageStructure',TFrameListItemStyle_Page);

finalization
  UnRegisterListItemStyle(TFrameListItemStyle_Page);

end.
