//convert pas to utf8 by ¥

unit PopupTreeMenuFrame;

interface

uses
  System.SysUtils,uFuncCommon, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, uSkinFireMonkeyControl, uSkinFireMonkeyPanel, uSkinFireMonkeyLabel,
  Math,

  HzSpell,
  uSkinFireMonkeyEdit,
  uSkinFireMonkeyMemo,
  uProcessNativeControlModalShowPanel,

  uFrameContext,
  uUIFunction,
  uVersion,
  uSkinItems,
//  uAppCommon,
  uBasePageStructure,
  uSkinItemJsonHelper,
//  uVirtualListDataController,
  uComponentType,
  uSkinBufferBitmap,
  uSkinLabelType,
  uDrawTextParam,
  WaitingFrame,
  MessageBoxFrame,
  uTimerTask,
  uSkinImageList,
  ParentItemStyleFrame_CaptionAutoSize_ExpandButtonRight,


  XSuperObject,
  XSuperJson,


  uSkinFireMonkeyItemDesignerPanel,
  uSkinFireMonkeyButton, FMX.Objects, uSkinMaterial, uSkinButtonType,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyVirtualList,
  uSkinFireMonkeyListBox, uSkinFireMonkeyCustomList, uSkinScrollControlType,
  uSkinCustomListType, uSkinVirtualListType, uSkinListBoxType, uBaseSkinControl,
  uSkinPanelType, uSkinRadioButtonType, uSkinFireMonkeyRadioButton,
  uSkinFireMonkeyPopup, uTimerTaskEvent, FMX.Edit, FMX.Controls.Presentation,
  uSkinTreeViewType, uSkinFireMonkeyTreeView, uSkinItemDesignerPanelType,
  uDrawCanvas, uSkinListViewType;



const
  Const_PopupTreeMenuWidth:Double=320;

type

  TIntegerArray=array of Integer;
  TFramePopupTreeMenu = class(TFrame,IFrameHistroyVisibleEvent)
    lbMenus: TSkinFMXTreeView;
    BackRectangle: TRectangle;
    procedure lbMenusClickItem(Sender: TSkinItem);
    procedure FrameResize(Sender: TObject);
    procedure BackRectangleClick(Sender: TObject);
    procedure lbMenusClickItemDesignerPanelChild(Sender: TObject;
      AItem: TBaseSkinItem; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
      AChild: TFmxObject);
    procedure lbMenusStayClick(Sender: TObject);
    procedure FrameClick(Sender: TObject);
  private
    //显示Frame
    procedure DoShow;
    //隐藏Frame
    procedure DoHide;
  private


    procedure Clear;
    procedure PrepareForShow(const ACaption:String;
                              AItemStyle:String;
                              AIsShowFilter:Boolean;
                              AWidth:Double=320);
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    //点击的菜单项的标题
    ModalResult:String;
    //点击的菜单项的Item.Name
    ModalResultName:String;
    ModalResultItem:TSkinItem;
    ModalResultDataJsonStr:String;
    ModalResultDataJson:ISuperObject;
    //选择的下标
    ModalResultIndex:Integer;
  public
    procedure HidePopupTreeMenu;

    { Public declarations }
  end;


var
  GlobalPopupTreeMenuFrame:TFramePopupTreeMenu;



implementation


{$R *.fmx}


{ TFramePopupTreeMenu }

procedure TFramePopupTreeMenu.BackRectangleClick(Sender: TObject);
begin
  //按空白区域则返回上一页
  if GetFrameHistory(Self)<>nil then GetFrameHistory(Self).OnReturnFrame:=nil;

  HidePopupTreeMenu;
end;

procedure TFramePopupTreeMenu.Clear;
begin
  ModalResult:='';
  ModalResultName:='';
  ModalResultItem:=nil;
  ModalResultDataJsonStr:='';
  ModalResultDataJson:=nil;
  ModalResultIndex:=-1;


//  FOnCustomLoadDataToUIEnd:=nil;


  //加载菜单项到ListBox
  Self.lbMenus.Prop.Items.BeginUpdate;
  try
    Self.lbMenus.Prop.Items.Clear(True);
  finally
    Self.lbMenus.Prop.Items.EndUpdate;
  end;


//  Self.lbItemCategory.Visible:=False;
end;

constructor TFramePopupTreeMenu.Create(AOwner: TComponent);
begin
  inherited;


//  //设置主题颜色
//  lblCaption.SelfOwnMaterialToDefault.DrawCaptionParam.DrawFont.Color:=SkinThemeColor;
//  pnlTopDevide.SelfOwnMaterialToDefault.BackColor.FillColor.Color:=SkinThemeColor;


//  Self.lbMenus.Prop.Items.Clear(True);


//  //记住默认宽度
//  MenuWidth:=Self.pnlPopupTreeMenu.Width;

  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);

//  ListDataController:=TListDataController.Create(nil);
end;

destructor TFramePopupTreeMenu.Destroy;
begin
//  FreeAndNil(ListDataController);
  inherited;
end;

procedure TFramePopupTreeMenu.DoHide;
begin
//  EnableMessageBoxFrameTopMost;
  if GlobalTopMostFrameList<>nil then
  begin
    GlobalTopMostFrameList.Remove(Self,False);
  end;


  //一定要放在隐藏WaitingFrame的后面
  //先隐藏WaitingFrame,再还原显示原生控件,免得WaitingFrame被盖住
  RestoreGlobalEditListAsPlatformType;
  RestoreGlobalMemoListAsPlatformType;
  ProcessNativeControlEndModalShow;
end;

procedure TFramePopupTreeMenu.DoShow;
begin
  //先隐藏原生控件,再显示WaitingFrame,避免WaitingFrame被盖住
  SetGlobalEditListAsStyleType;
  SetGlobalMemoListAsStyleType;
  ProcessNativeControlBeginModalShow;
end;

procedure TFramePopupTreeMenu.FrameClick(Sender: TObject);
begin
  //没有点击到列表项
  HidePopupTreeMenu;
end;

procedure TFramePopupTreeMenu.FrameResize(Sender: TObject);
//var
//  AMenuCount:Integer;
begin

//  //计算需要一屏能显示几个菜单项
//  AMenuCount:=Self.lbMenus.Prop.ListLayoutsManager.GetVisibleItemsCount;
//  if AMenuCount>0 then
//  begin
//      //有数据
//      if Self.lbMenus.Prop.GetContentHeight+lblCaption.Height+Self.edtFilter.Height>Height then
//      begin
//        //超出高度了,看看能显示得下几个菜单项
//        AMenuCount:=Floor(
//                          (Height
//                            -Self.lblCaption.Height
//                            -Self.edtFilter.Height
//                            -40//要留空的区域
//                            )
//                            / Self.lbMenus.Prop.ItemHeight
//                         );
//        //至少显示一个菜单项
//        if AMenuCount<=0 then
//        begin
//          AMenuCount:=1;
//        end;
//      end;
//  end
//  else
//  begin
//      //没有数据,保持高度,不然难看
//      AMenuCount:=5;
//  end;
//
//
//  Self.pnlPopupTreeMenu.Height:=Self.pnlTopDevide.Height
//                            +AMenuCount*Self.lbMenus.Prop.ItemHeight;
//  if Self.lblCaption.Visible then
//  begin
//    Self.pnlPopupTreeMenu.Height:=Self.pnlPopupTreeMenu.Height+Self.lblCaption.Height;
//  end;
//  if Self.edtFilter.Visible then
//  begin
//    Self.pnlPopupTreeMenu.Height:=Self.pnlPopupTreeMenu.Height+Self.edtFilter.Height;
//  end;
end;

procedure TFramePopupTreeMenu.HidePopupTreeMenu;
begin

  //隐藏弹出框
  HideFrame;//(Self,hfcttBeforeReturnFrame,ufsefNone);
  ReturnFrame(Self);
end;

procedure TFramePopupTreeMenu.lbMenusClickItem(Sender: TSkinItem);
begin
  if IsRepeatClickReturnButton(Self) then Exit;



end;

procedure TFramePopupTreeMenu.lbMenusClickItemDesignerPanelChild(Sender: TObject;
  AItem: TBaseSkinItem; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
  AChild: TFmxObject);
var
  ANowItem:TSkinItem;
begin

  if (AChild.Name='imgGroupExpanded') or (AChild.Name='lblGroupName') then
  begin
    TSkinTreeViewItem(AItem).Expanded:=not TSkinTreeViewItem(AItem).Expanded;
  end
  else
  begin
    //选择的菜单项
    ANowItem:= TSkinItem(AItem);
    ANowItem.Selected:=True;
    ModalResult:= ANowItem.Caption;
    ModalResultName:= ANowItem.Name;
    ModalResultDataJsonStr:= ANowItem.DataJsonStr;
    ModalResultDataJson:=nil;
    if GetItemJsonObject(ANowItem)<>nil then
    begin
      ModalResultDataJson:=GetItemJsonObject(ANowItem).Json;
    end;
    ModalResultIndex:=ANowItem.Index;
    ModalResultItem:=ANowItem;

    HidePopupTreeMenu;
  end;

end;

procedure TFramePopupTreeMenu.lbMenusStayClick(Sender: TObject);
begin
  if Self.lbMenus.Prop.MouseOverItem=nil then
  begin
    //没有点击到列表项
    HidePopupTreeMenu;
  end;
end;

procedure TFramePopupTreeMenu.PrepareForShow(const ACaption: String;
                                          AItemStyle:String;
                                          AIsShowFilter:Boolean;
                                          AWidth:Double);
begin


//  //避免被MessageBox挡住
//  DisableMessageBoxFrameTopMost;
  if (GlobalTopMostFrameList<>nil) and (GlobalTopMostFrameList.IndexOf(Self)=-1) then
  begin
    GlobalTopMostFrameList.Add(Self);
  end;



//  FFilter:='';
//  Self.edtFilter.OnChange:=nil;
//  Self.edtFilter.OnChangeTracking:=nil;
//  Self.edtFilter.Text:='';
//  Self.edtFilter.Visible:=AIsShowFilter;
//  //恢复事件
//  Self.edtFilter.OnChange:=Self.edtFilterChange;
//  Self.edtFilter.OnChangeTracking:=edtFilterChangeTracking;
//
//
//
//
//  //标题
//  Self.lblCaption.Caption:=ACaption;
//  //恢复默认状态
////  Self.lblCaption.Height:=60;
//  Self.pnlTopDevide.Visible:=True;
//  Self.lblCaption.Visible:=True;
//  Self.pnlPopupTreeMenu.Width:=300;//MenuWidth;
////  SetProp(0,0);
//  //标题为空时不显示标题及分割线
//  if ACaption='' then
//  begin
////    Self.lblCaption.Height:=0;
//    Self.lblCaption.Visible:=False;
//    Self.pnlTopDevide.Visible:=False;
//  end;
//
//
//
//  Self.pnlPopupTreeMenu.Width:=AWidth;
//

  //DefaultTypeItemStyle这个功能是先设置好ItemMaterial，而不是使用设计面板
//  Self.lbMenus.SelfOwnMaterialToDefault.DefaultTypeItemStyle:=AItemStyle;


  Self.lbMenus.Prop.DefaultItemStyle:=AItemStyle;
  Self.lbMenus.Prop.ParentTypeItemStyle:='';




end;

end.

