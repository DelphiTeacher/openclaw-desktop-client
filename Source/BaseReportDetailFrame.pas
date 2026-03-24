unit BaseReportDetailFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  BaseReportFrame, uDrawCanvas, uSkinItems, uTimerTaskEvent,


  StrUtils,
  uBaseLog,
  uManager,
  uOpenCommon,
  uUIFunction,
  uTimerTask,
  uPageStructure,
  uPageInstance,
  XSuperObject,
  MessageBoxFrame,
  uSkinItemJsonHelper,
  uOpenClientCommon,

  uRestInterfaceCall,
  uSortSettingFrame,
  uViewPictureListFrame,
  ListItemStyleFrame_Page,
  ListItemStyleFrame_BaseReportDetail,
  SelectFilterDateAreaFrame,
  EasyServiceCommonMaterialDataMoudle,
  ListItemStyleFrame_CaptionTopDetailBottom,
  ListItemStyleFrame_CaptionAndMultiDetailsHorz_Accessory,


  uSkinFireMonkeyImage,
  uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel,
  uSkinFireMonkeyPopup, uSkinListBoxType, uSkinFireMonkeyListBox, FMX.Edit,
  FMX.Controls.Presentation, uSkinFireMonkeyEdit, uSkinMultiColorLabelType,
  uSkinFireMonkeyMultiColorLabel, uSkinButtonType, uSkinScrollControlType,
  uSkinCustomListType, uSkinVirtualListType, uSkinListViewType,
  uSkinFireMonkeyListView, uSkinFireMonkeyButton, uSkinFireMonkeyControl,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinVirtualGridType, uSkinItemGridType, uSkinFireMonkeyItemGrid;

type
  TFrameBaseReportDetail = class(TFrameBaseReport)
    lvDoorType: TSkinFMXListView;
    procedure lvDataNewListItemStyleFrameCacheInit(Sender: TObject;
      AListItemTypeStyleSetting: TListItemTypeStyleSetting;
      ANewListItemStyleFrameCache: TListItemStyleFrameCache);
    procedure lvDoorTypeClickItem(AItem: TSkinItem);
    procedure lvDataPullUpLoadMore(Sender: TObject);
    procedure edtFilterKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure lvDataClickItemDesignerPanelChild(Sender: TObject;
      AItem: TBaseSkinItem; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
      AChild: TFmxObject);
    procedure gridDataPullUpLoadMore(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure PrepareForLoadDataToUI(ADataJson:ISuperObject);override;
    function GetDefaultItemStyle:String;override;
    //获取自定义查询条件
    function GetCustomWhereSQL:String;override;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

var
//  FrameBaseReportDetail: TFrameBaseReportDetail;
  GlobalBaseReportDetailFrame: TFrameBaseReportDetail;

function GetBottomBarSummaryCaption(ASuperObject:ISuperObject):String;

implementation

{$R *.fmx}


function GetBottomBarSummaryCaption(ASuperObject:ISuperObject):String;
var
  I:Integer;
  AValueStr:String;
  ARecordJson:ISuperObject;
begin
  Result:='';
  //返回多少汇总Summary
  if ASuperObject.O['Data'].Contains('Summary') then
  begin
    for I := 0 to ASuperObject.O['Data'].A['Summary'].Length-1 do
    begin
      ARecordJson:=ASuperObject.O['Data'].A['Summary'].O[I];

      if ARecordJson.S['name']<>'记录数' then
      begin
        AValueStr:='';
        if not VarIsNull(ARecordJson.V['value']) then
        begin
          AValueStr:=FloatToStr(ARecordJson.F['value']);
        end;

        if Result<>'' then
        begin
          Result:=Result+' ';
        end;
        Result:=Result+ARecordJson.S['name']+':'+AValueStr;
      end;


    end;
  end;

end;


constructor TFrameBaseReportDetail.Create(AOwner: TComponent);
begin
  inherited;

  if lvDoorType.Visible then
  begin
//    LoadDoorTypeToListView(GlobalManager.DoorTypeArray,Self.lvDoorType);
  end;


end;

procedure TFrameBaseReportDetail.edtFilterKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;

//  if Key = vkReturn then
//  begin
//    FPageIndex:=1;
//    Self.tteLoadData.Run();
//  end;

end;

function TFrameBaseReportDetail.GetCustomWhereSQL: String;
begin
  Result:=Inherited;
  if Self.lvDoorType.Visible
    and (Self.lvDoorType.Prop.SelectedItem<>nil)
    and (Self.lvDoorType.Prop.SelectedItem.Caption<>'全部') then
  begin
    Result:=Result+' AND [门类型]='+QuotedStr(Self.lvDoorType.Prop.SelectedItem.Caption)+' ';
  end;
end;

function TFrameBaseReportDetail.GetDefaultItemStyle: String;
begin
  Result:=Inherited;
  if Self.FDefaultItemStyle='' then
  begin
    Result:='BaseReportDetail';
  end;

end;

procedure TFrameBaseReportDetail.gridDataPullUpLoadMore(Sender: TObject);
begin
  inherited;
  FPageIndex:=FPageIndex+1;
  Self.tteLoadData.Run();


end;

procedure TFrameBaseReportDetail.lvDataClickItemDesignerPanelChild(
  Sender: TObject; AItem: TBaseSkinItem;
  AItemDesignerPanel: TSkinFMXItemDesignerPanel; AChild: TFmxObject);
var
  AIndex:Integer;
  ABindItemFieldName:String;
begin
  inherited;

  //点击图片,查看大图
  if AChild is TSkinFMXImage then
  begin
      ABindItemFieldName:=TSkinFMXImage(AChild).BindItemFieldName;
      if Pos('order_pic',ABindItemFieldName)>0 then//'order_pic1_path'
      begin

          AIndex:=0;
          if Pos('2',ABindItemFieldName)>0 then AIndex:=1;
          if Pos('3',ABindItemFieldName)>0 then AIndex:=2;
          if Pos('4',ABindItemFieldName)>0 then AIndex:=3;
          if Pos('5',ABindItemFieldName)>0 then AIndex:=4;



          //查看图片详情
          //查看照片信息
          HideFrame;//(CurrentFrame);
          //查看照片信息
          ShowFrame(TFrame(GlobalViewPictureListFrame),TFrameViewPictureList);//,frmMain,nil,nil,nil);
          GlobalViewPictureListFrame.Init('订单图片',
                                          nil,
                                          0,
                                          //原图URL
                                          nil
                                          );
//          if TSkinItem(AItem).Json.S['order_pic1_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(ReplaceStr(TSkinItem(AItem).Json.S['order_pic1_path'],THUMB_FILE_PREFIX,''),''),
//              TSkinItem(AItem).Json.S['订单图片1备注']
//              );
//          end;
//          if TSkinItem(AItem).Json.S['order_pic2_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(ReplaceStr(TSkinItem(AItem).Json.S['order_pic2_path'],THUMB_FILE_PREFIX,''),''),
//              TSkinItem(AItem).Json.S['订单图片2备注']
//              );
//          end;
//          if TSkinItem(AItem).Json.S['order_pic3_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(ReplaceStr(TSkinItem(AItem).Json.S['order_pic3_path'],THUMB_FILE_PREFIX,''),''),
//              TSkinItem(AItem).Json.S['订单图片3备注']
//              );
//          end;
//          if TSkinItem(AItem).Json.S['order_pic4_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(ReplaceStr(TSkinItem(AItem).Json.S['order_pic4_path'],THUMB_FILE_PREFIX,''),''),
//              TSkinItem(AItem).Json.S['订单图片4备注']
//              );
//          end;
//          if TSkinItem(AItem).Json.S['order_pic5_path']<>'' then
//          begin
//            GlobalViewPictureListFrame.AddPicture(GetImageUrl(ReplaceStr(TSkinItem(AItem).Json.S['order_pic5_path'],THUMB_FILE_PREFIX,''),''),
//              TSkinItem(AItem).Json.S['订单图片5备注']
//              );
//          end;
          GlobalViewPictureListFrame.ShowPicture('订单图片',AIndex);


      end;

  end;
end;

procedure TFrameBaseReportDetail.lvDataNewListItemStyleFrameCacheInit(
  Sender: TObject; AListItemTypeStyleSetting: TListItemTypeStyleSetting;
  ANewListItemStyleFrameCache: TListItemStyleFrameCache);
var
//  APageFrame:TFrameListItemStyle_Page;
//  AReportDetailFrame:TFrameListItemStyle_BaseReportDetail;
//  AItemDesignerPanel:TSkinItemDesignerPanel;
  AFrameBaseListItemStyle_InitIntf:IFrameBaseListItemStyle_Init;
begin
  inherited;

//  AItemDesignerPanel:=nil;
  if ANewListItemStyleFrameCache.FItemStyleFrame.GetInterface(IID_IFrameBaseListItemStyle_Init,AFrameBaseListItemStyle_InitIntf) then
  begin

    AFrameBaseListItemStyle_InitIntf.SetPage(FItemStylePage);
    //隐藏已经在设计面板上拖好的字段
    //在FItemStylePage中将已经绑定的字段隐藏
//    if AItemDesignerPanel<>nil then
//    begin
      HideControlInItemDesignerPanelByPage(Self.FItemStylePage,ANewListItemStyleFrameCache.FItemStyleFrameIntf.ItemDesignerPanel);
//    end;

  end;
//  if ANewListItemStyleFrameCache.FItemStyleFrame is TFrameListItemStyle_Page then
//  begin
//    APageFrame:=TFrameListItemStyle_Page(ANewListItemStyleFrameCache.FItemStyleFrame);
//    APageFrame.FPage:=FItemStylePage;
//    //需要了TFrameListItemStyle_Page.Init之前
//
//    //设置绑定
//
//    AItemDesignerPanel:=APageFrame.ItemDesignerPanel;
//  end;
//
//
//  if ANewListItemStyleFrameCache.FItemStyleFrame is TFrameListItemStyle_BaseReportDetail then
//  begin
//    AReportDetailFrame:=TFrameListItemStyle_BaseReportDetail(ANewListItemStyleFrameCache.FItemStyleFrame);
//    AReportDetailFrame.FPage:=FItemStylePage;
//    //需要了TFrameListItemStyle_Page.Init之前
//
//    //设置绑定
//
//    AItemDesignerPanel:=AReportDetailFrame.ItemDesignerPanel;
//  end;
//
//
//  //隐藏已经在设计面板上拖好的字段
//  //在FItemStylePage中将已经绑定的字段隐藏
//  if AItemDesignerPanel<>nil then
//  begin
//    HideControlInItemDesignerPanelByPage(Self.FItemStylePage,AItemDesignerPanel);
//  end;



end;


procedure TFrameBaseReportDetail.lvDataPullUpLoadMore(Sender: TObject);
begin
  inherited;
  FPageIndex:=FPageIndex+1;
  Self.tteLoadData.Run();

end;

procedure TFrameBaseReportDetail.lvDoorTypeClickItem(AItem: TSkinItem);
begin
  inherited;
  Self.FPageIndex:=1;
  Self.tteLoadData.Run();

end;

procedure TFrameBaseReportDetail.PrepareForLoadDataToUI(ADataJson:ISuperObject);
begin
  inherited;
  Self.lvData.Prop.DefaultItemStyle:='';//清一下列表项样式Frame缓存
  if (GetDefaultItemStyle='') then
  begin
    //是分组
    SetGroupByFrameBinding(FFieldColumnHeaderFrame);
    FFieldColumnHeaderFrame.Repaint;
    Self.lvData.Prop.DefaultItemStyle:='CaptionAndMultiDetailsHorz_Accessory';
    FFieldColumnHeaderFrame.Visible:=True;
  end
  else
  begin
    //是明细
    Self.lvData.Prop.DefaultItemStyle:=GetDefaultItemStyle;
    Self.lvData.Prop.ItemHeight:=200;

    FFieldColumnHeaderFrame.Visible:=False;


    //根据字段,创建PageStructure
    if FItemStylePage=nil then
    begin
      FItemStylePage:=TPage.Create(Self);
    end;
    LoadPageByFieldList(FItemStylePage,Self.FFieldList,GetHideFieldListCommaText);

  end;

end;

end.
