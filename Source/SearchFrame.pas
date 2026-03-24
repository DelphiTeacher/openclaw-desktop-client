unit SearchFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uSkinButtonType, uSkinFireMonkeyButton, FMX.Controls.Presentation, FMX.Edit,

  uSkinBufferBitmap,
  uOpenCommon,

  uBaseHttpControl,

  uUIFunction,
  uManager,
  uTimerTask,

  uSkinControlGestureManager,

  uDrawCanvas,
  WaitingFrame,
  SearchConditionFrame,

  uSkinItems,

  XSuperObject,
  uRestInterfaceCall,

  MessageBoxFrame,


  CommonImageDataMoudle,
  EasyServiceCommonMaterialDataMoudle,



  uSkinFireMonkeyEdit, uSkinFireMonkeyControl, uSkinPanelType,
  uSkinFireMonkeyPanel, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinFireMonkeyListView,
  uSkinItemDesignerPanelType, uSkinFireMonkeyItemDesignerPanel, uSkinLabelType,
  uSkinFireMonkeyLabel;

type
  TFrameSearch = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    edtSearch: TSkinFMXEdit;
    btnReturn: TSkinFMXButton;
    btnSearch: TSkinFMXButton;
    lvSearchList: TSkinFMXListView;
    idpHis: TSkinFMXItemDesignerPanel;
    lblHisSearch: TSkinFMXLabel;
    btnDel: TSkinFMXButton;
    idpItem: TSkinFMXItemDesignerPanel;
    lblName: TSkinFMXLabel;
    btnFilter: TSkinFMXButton;
    idpSearch: TSkinFMXItemDesignerPanel;
    btnAdvancedSearch: TSkinFMXButton;
    procedure btnReturnClick(Sender: TObject);
    procedure lvSearchListPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
      AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem;
      AItemDrawRect: TRect);
    procedure lvSearchListClickItem(AItem: TSkinItem);
    procedure btnSearchClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
  private
//    FSearchList:TStringList;
//    FHisSearchList:TStringList;
    { Private declarations }
  public
//    FFilterString:String;
//    //搜索关键字
//    FKeyWords:String;
//    //是否搜索
//    FIsSearch:Boolean;
//    //清空
//    procedure Clear;
//
//    //加载热门搜索
//    procedure Load(ACaption:String;
//                   ASearchList:TStringList;
//                   AHisSearchList:TStringList;
//                   AFilterString:String);

  public
//    FrameHistroy:TFrameHistroy;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    { Public declarations }
  end;

var
  GlobalSearchFrame:TFrameSearch;

implementation

{$R *.fmx}
//uses
//  MainForm,
//  MainFrame,
////  HomeFrame,
//  ShopListFrame;

procedure TFrameSearch.btnDelClick(Sender: TObject);
begin
//  //清空历史记录
//  FHisSearchList.Clear;
//  GlobalManager.Save;
//  Load(Self.edtSearch.Prop.HelpText,
//        FSearchList,
//        FHisSearchList,
//        Self.FFilterString);
end;

procedure TFrameSearch.btnFilterClick(Sender: TObject);
begin
  //高级搜索
  HideFrame;
  ShowFrame(TFrame(GlobalSearchConditionFrame),TFrameSearchCondition);
end;

procedure TFrameSearch.btnReturnClick(Sender: TObject);
begin
//  Self.FIsSearch:=False;
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self.FrameHistroy);
end;

procedure TFrameSearch.btnSearchClick(Sender: TObject);
begin
//  Self.FIsSearch:=True;
//
//
//
//  if FFilterString='home' then
//  begin
//    //显示店铺列表
//    HideFrame;//(Self,hfcttBeforeShowFrame);
//
//    ShowFrame(TFrame(GlobalShopListFrame),TFrameShopList);
////    GlobalShopListFrame.FrameHistroy:=CurrentFrameHistroy;
//    GlobalShopListFrame.InitView; //放在LoadShopList前面
//    GlobalShopListFrame.LoadShopList('',Self.edtSearch.Text,True);
//  end;
//
//  if FFilterString='shoplist' then
//  begin
//    Self.FKeyWords:=Self.edtSearch.Text;
//    //返回
//    HideFrame;//(Self,hfcttBeforeReturnFrame);
//    ReturnFrame;//(Self.FrameHistroy);
//  end;
//
//  if (Self.edtSearch.Text<>'') and  (FHisSearchList.IndexOf(Self.edtSearch.Text)=-1) then
//  begin
//    //添加到搜索历史
//    FHisSearchList.Insert(0,Self.edtSearch.Text);
//    //保存
//    GlobalManager.SaveUserConfig;
//  end;

  Self.edtSearch.Text:= '';
  HideFrame;
  ReturnFrame;

end;

//procedure TFrameSearch.Clear;
//begin
////  Self.lvSearchList.Prop.Items.Clear(True);
////  FKeyWords:='';
////  Self.FIsSearch:=False;
//end;

constructor TFrameSearch.Create(AOwner: TComponent);
begin
  inherited;
//  FSearchList:=TStringList.Create;
//  FHisSearchList:=TStringList.Create;
end;

destructor TFrameSearch.Destroy;
begin
//  FreeAndNil(FSearchList);
//  FreeAndNil(FHisSearchList);
  inherited;
end;

//procedure TFrameSearch.Load(ACaption:String;
//                            ASearchList: TStringList;
//                            AHisSearchList:TStringList;
//                            AFilterString:String);
//var
//  AListViewItem:TSkinListViewItem;
//  ASearchIndex:Integer;
//  AWidth:Double;
//  I: Integer;
//  AHisSearchIndex:Integer;
//  J: Integer;
//begin
//  Self.lvSearchList.Prop.Items.Clear(True);
//
//  Self.FHisSearchList:=AHisSearchList;
//
//  Self.FSearchList:=ASearchList;
//
//  Self.FFilterString:=AFilterString;
//  if ACaption=Self.edtSearch.Prop.HelpText then
//  begin
//    Self.edtSearch.Text:='';
//  end
//  else
//  begin
//    Self.edtSearch.Text:=ACaption;
//  end;
//
//  //加载热门搜索历史
//  Self.lvSearchList.Prop.Items.BeginUpdate;
//  try
//
//    if AHisSearchList.Count>=1 then
//    begin
//      AListViewItem:=Self.lvSearchList.Prop.Items.Add;
//      AListViewItem.Accessory:=satNone;
//      AListViewItem.ItemType:=sitItem1;
//      AListViewItem.Width:=-2;
//      AListViewItem.Caption:='历史搜索';
//
//      AHisSearchIndex:=Self.lvSearchList.Prop.Items.FindItemByCaption('历史搜索').Index;
//
//      for J := 0 to AHisSearchList.Count-1 do
//      begin
//        AListViewItem:=Self.lvSearchList.Prop.Items.Insert(AHisSearchIndex+1);
////        Self.FHisSearchList.Add(AHisSearchList[J]);
//
//        AListViewItem.ItemType:=sitDefault;
//        AListViewItem.Caption:=AHisSearchList[J];
//
//        AWidth:=uSkinBufferBitMap.GetStringWidth(AHisSearchList[J],12);
//        if AWidth<=150 then
//        begin
//          AListViewItem.Width:=AWidth+10;
//        end
//        else
//        begin
//          AListViewItem.Width:=150;
//        end;
//
//        Inc(AHisSearchIndex);
//      end;
//
//    end;
//
//
//    AListViewItem:=Self.lvSearchList.Prop.Items.Add;
//    AListViewItem.Accessory:=satMore;
//    AListViewItem.ItemType:=sitItem1;
//    AListViewItem.Width:=-2;
//    AListViewItem.Caption:='热门搜索';
//
//
//    ASearchIndex:=Self.lvSearchList.Prop.Items.FindItemByCaption('热门搜索').Index;
//
//
//    for I := 0 to ASearchList.Count-1 do
//    begin
//      AListViewItem:=Self.lvSearchList.Prop.Items.Insert(ASearchIndex+1);
//      AListViewItem.ItemType:=sitDefault;
//      AListViewItem.Caption:=ASearchList[I];
//
//      AWidth:=uSkinBufferBitMap.GetStringWidth(ASearchList[I],12);
//      if AWidth<=150 then
//      begin
//        AListViewItem.Width:=AWidth+10;
//      end
//      else
//      begin
//        AListViewItem.Width:=150;
//      end;
//
//      Inc(ASearchIndex);
//    end;
//  finally
//    Self.lvSearchList.Prop.Items.EndUpdate();
//  end;
//
//
//
////  Self.SetLvSearchList(ASearchList);
//
//end;

procedure TFrameSearch.lvSearchListClickItem(AItem: TSkinItem);
begin
  if AItem.ItemType=sitDefault then
  begin
//    Self.edtSearch.Text:=AItem.Caption;
//
//    FKeyWords:=AItem.Caption;
//    Self.FIsSearch:=True;
//
//    if GlobalManager.ShopSearchHistoryList.IndexOf(AItem.Caption)=-1 then
//    begin
//      //添加到搜索历史
//      GlobalManager.ShopSearchHistoryList.Insert(0,AItem.Caption);
//      //保存
//      GlobalManager.SaveUserConfig;
//    end;
//
////    if FHisSearchList.IndexOf(AItem.Caption)=-1 then
////    begin
////      //添加到搜索历史
////      FHisSearchList.Insert(0,AItem.Caption);
////      //保存
////      GlobalManager.SaveUserConfig;
////    end;
//
//    //显示店铺列表
//    HideFrame;//(Self,hfcttBeforeShowFrame);
//
//    ShowFrame(TFrame(GlobalShopListFrame),TFrameShopList);
////    GlobalShopListFrame.FrameHistroy:=CurrentFrameHistroy;
//    GlobalShopListFrame.LoadShopList('',Self.FKeyWords,True);
  end;

  if AItem.ItemType=sitFooter then
  begin
    HideFrame;
    ShowFrame(TFrame(GlobalSearchConditionFrame),TFrameSearchCondition);
  end;

end;

procedure TFrameSearch.lvSearchListPrepareDrawItem(Sender: TObject;
  ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
  AItem: TSkinItem; AItemDrawRect: TRect);
begin
//  if AItem.Accessory=satNone then
//  begin
//    Self.btnDel.Visible:=True;
//  end
//  else
//  begin
//    Self.btnDel.Visible:=False;
//  end;
end;

end.
