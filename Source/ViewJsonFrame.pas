unit ViewJsonFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uComponentType,
  uFuncCommon,
  uUIFunction,
  uGetDeviceInfo,

  Math,
  uManager,
  uTimerTask,
  uOpenCommon,
  uOpenClientCommon,
  uRestInterfaceCall,
  uFrameContext,
//  ClientModuleUnit1,
  WaitingFrame,
  MessageBoxFrame,
  SettingFrame,
  HintFrame,
  MultiSelectFrame,
  uDatasetToJson,
  uPageStructure,
  uPageInstance,
  uViewPictureListFrame,

  HZSpell,

  FMX.Platform,

  XSuperObject,
  XSuperJson,

  uBaseList,
  uSkinItems,
  uSkinListBoxType,
  uSkinListViewType,
//  SelectCarPartFrame,
  SelectMonthFrame,
  PopupMenuFrame,

//  CarRepairCommonMaterialDataMoudle,
  ListItemStyleFrame_IconCaption,
  ListItemStyleFrame_Caption_BottomDetail_IconRight,


  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, uSkinFireMonkeyButton, uSkinFireMonkeyLabel,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyVirtualList,
  uSkinFireMonkeyListBox, uSkinFireMonkeyControl,
  uSkinFireMonkeyItemDesignerPanel, uSkinFireMonkeyListView,
  uSkinFireMonkeyImage, uSkinFireMonkeyPanel, uSkinFireMonkeyMultiColorLabel,
  FMX.Edit, uSkinFireMonkeyEdit, uSkinFireMonkeyNotifyNumberIcon,
  uSkinFireMonkeyCheckBox, uSkinMaterial, uSkinButtonType,
  uSkinFireMonkeyCustomList, uSkinNotifyNumberIconType, uSkinCheckBoxType,
  uSkinMultiColorLabelType, uSkinImageType, uSkinLabelType,
  uSkinItemDesignerPanelType, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinPanelType, uSkinPageControlType,
  uSkinSwitchPageListPanelType, uSkinFireMonkeyPageControl,
  uSkinScrollBoxContentType, uSkinFireMonkeyScrollBoxContent,
  uSkinScrollBoxType, uSkinFireMonkeyScrollBox, FMX.ScrollBox, FMX.Memo,
  uSkinFireMonkeyMemo, uTimerTaskEvent, FMX.DateTimeCtrls,
  uSkinFireMonkeyDateEdit, uSkinCommonFrames, uDrawCanvas;


type
  TFrameViewJson = class(TFrame
//                          ,IFrameVirtualKeyboardAutoProcessEvent
                          )
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    lvData: TSkinFMXListView;
    btnOK: TSkinFMXButton;
//    procedure sbcClientResize(Sender: TObject);
//    procedure edtHourChange(Sender: TObject);
//    procedure edtHourChangeTracking(Sender: TObject);
//    procedure btnSelectRepairManClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
//    procedure tteViewJsonBegin(ATimerTask: TTimerTask);
//    procedure tteViewJsonExecute(ATimerTask: TTimerTask);
//    procedure tteViewJsonExecuteEnd(ATimerTask: TTimerTask);
    procedure btnReturnClick(Sender: TObject);
    procedure lvDataClickItem(AItem: TSkinItem);
    procedure lvDataNewListItemStyleFrameCacheInit(Sender: TObject;
      AListItemTypeStyleSetting: TListItemTypeStyleSetting;
      ANewListItemStyleFrameCache: TListItemStyleFrameCache);
//    procedure tteGetRepairCarOrderBegin(ATimerTask: TTimerTask);
//    procedure tteGetRepairCarOrderExecute(ATimerTask: TTimerTask);
//    procedure tteGetRepairCarOrderExecuteEnd(ATimerTask: TTimerTask);
//  private
//    //当前需要处理的控件
//    function GetCurrentPorcessControl(AFocusedControl:TControl):TControl;
//    function GetVirtualKeyboardControlParent:TControl;
  private
//    procedure SyncButtonState;
    procedure AlignControls;
  private
    //
    FDataJson:ISuperObject;


//    //选择维修工返回
//
//    //为选择维修工获取数据
//    procedure DoGetDataForSelectRepairManPopupMenuFrame(ATimerTask: TTimerTask);
//    //选择维修工返回
//    procedure DoSelectRepairManFromMultiSelectFrame(AMultiSelectFrame:TFrame);
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    procedure Clear;

//    function SaveToJson:ISuperObject;
//    procedure DoLoadData(ADataJson:ISuperObject);
    procedure Load(ADataJson:ISuperObject);overload;
    procedure Sync(ADataJson:ISuperObject;ANeedDisplayColumns:String);overload;
    { Public declarations }
  end;


var
  GlobalViewJsonFrame:TFrameViewJson;


implementation

{$R *.fmx}

uses
  MainForm//,
//  AddNeedMaterialFrame
  ;


{ TFrameViewJson }

procedure TFrameViewJson.AlignControls;
begin
////  Self.pnlCarInfo.Height:=GetSuitControlContentHeight(pnlCarInfoLeft);
////  Self.pnlContactsInfo.Height:=GetSuitControlContentHeight(pnlContactsInfoLeft);
////
////  Self.pnlCarInfoLeft.Width:=Self.Width/2;
////  Self.pnlContactsInfoLeft.Width:=Self.Width/2;
//  if Self.lvData.Prop.Items.Count>0 then
//  begin
//    Self.pnlNeedItems.Height:=
//          Self.pnlNeedItemsHeader.Height
//          +Self.lvData.Prop.GetContentHeight
//          +10;
//  end
//  else
//  begin
//    Self.pnlNeedItems.Height:=
//          Self.pnlNeedItemsHeader.Height
//          +Self.lvData.Prop.ItemHeight
//          +10;
//  end;
//
//  Self.sbcClient.Height:=GetSuitScrollContentHeight(sbcClient);
//  if Self.pnlToolBar.Visible then
//  begin
//    //单独一页
//  end
//  else
//  begin
//    //内嵌一页
//    Height:=Self.lvData.Prop.CalcContentHeight;
//
//  end;
end;

procedure TFrameViewJson.btnOKClick(Sender: TObject);
//var
//  I: Integer;
begin
  //可以不需要指定维修工
//  for I := 0 to Self.lvData.Prop.Items.Count-1 do
//  begin
//    if Self.lvData.Prop.Items[I].Detail3='' then
//    begin
//      ShowMessageBoxFrame(Self,
//        '请给项目('+Self.lvData.Prop.Items[I].Caption+')选择维修工!');
//      Exit;
//    end;
//  end;


//  //调用派工接口
//  Self.tteViewJson.Run;

end;

procedure TFrameViewJson.btnReturnClick(Sender: TObject);
begin
  uUIFunction.ClearOnReturnFrameEvent(Self);

  HideFrame;//(Self);
  ReturnFrame;//(Self);
end;

//procedure TFrameViewJson.btnSelectRepairManClick(Sender: TObject);
//var
//  AFramePopupStyle:TFramePopupStyle;
//begin
//  //选择维修工
//  AFramePopupStyle.PopupWidth:=320;
//  AFramePopupStyle.PopupHeight:=frmMain.ClientHeight-80;
//  ShowFrame(TFrame(GlobalMultiSelectFrame),TFrameMultiSelect,frmMain,nil,nil,DoSelectRepairManFromMultiSelectFrame,
//              nil,True,True,
//              TUseFrameSwitchEffectType.ufsefNone,
//              //使用弹出风格
//              True,//False,//
//              @AFramePopupStyle);
////  GlobalMultiSelectFrame.Init('选择维修工','张三,李四,王五','');
//  GlobalMultiSelectFrame.Init('选择维修工',
//                              Self.DoGetDataForSelectRepairManPopupMenuFrame,//'张三,李四,王五',
//                              'RecordList',
//                              '姓名',
//                              Self.lvData.Prop.InteractiveItem.Detail3
//                              );
//
//end;

//procedure TFrameViewJson.DoGetDataForSelectRepairManPopupMenuFrame(ATimerTask: TTimerTask);
//begin
//  try
//      //出错
//      TTimerTask(ATimerTask).TaskTag:=1;
//
//      TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI_TableCommonGetRecordList(
//          'Employee',
//          nil,
//          CommonRestCenterInterfaceUrl,
//          AppID,
//          GlobalManager.User.fid,
//          '',
//          1,
//          MaxInt,//返回全部数据
//          //条件,四个一组
//          [],
//          //排序,两个一组
//          ''
//          );
//
//      TTimerTask(ATimerTask).TaskTag:=0;
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
//end;

//function TFrameViewJson.Check: Boolean;
//begin
//end;

procedure TFrameViewJson.Clear;
begin


  Self.lvData.Prop.Items.BeginUpdate;
//  AStringList:=TStringList.Create;
  try
    Self.lvData.Prop.Items.Clear(True);
  finally
    Self.lvData.Prop.Items.EndUpdate;
  end;



////  IsEdit:=False;
//
//  FSelectedItemDataJsonStr:='';
//
////  Self.edtCardPlateNumber.Text:='';
////  Self.edtCarVIN.Text:='';
////
////  Self.edtEngineCode.Text:='';
////  Self.edtChassisCode.Text:='';
////
//  Self.btnSelectItem.Caption:='';
////  Self.btnSelectCarType.Caption:='';
////
////  Self.btnSelectCarColor.Caption:='';
////  Self.btnSelectBuyDate.Caption:='';
////  Self.detBuyDate.Date:=Now;
////  Self.detBuyDate.DateTimePicker.Date:=Now;
////  Self.detBuyDate.Visible:=False;
////
////  Self.edtMileage.Text:='';
////
//  Self.edtPrice.Text:='';
//  Self.edtHour.Text:='1';
//  Self.edtMoney.Text:='';
////  Self.edtContactsAddr.Text:='';
////  Self.btnSelectVIPType.Text:='';
////
////  Self.tbOilMark.Value:=0;

//  AlignControls;
end;

constructor TFrameViewJson.Create(AOwner: TComponent);
begin
  inherited;
//  if Not IsPadDevice then
//  begin
//    Self.lvData.Properties.ItemDesignerPanel:=Self.idpRepairItem1;
//    Self.lvData.Properties.ItemHeight:=105;
//  end
//  else
//  begin
//    Self.lvData.Properties.ItemDesignerPanel:=Self.idpRepairItem;
//    Self.lvData.Properties.ItemHeight:=80;
//  end;
//
//  AlignControls;
end;

destructor TFrameViewJson.Destroy;
begin
  inherited;
end;

procedure TFrameViewJson.Load(ADataJson: ISuperObject);
var
  I: Integer;
  AItem:TSkinItem;
  AParamNames:TStringDynArray;
  AParamValues:TVariantDynArray;
  AValueStr:String;
  AIndex:Integer;
  AListItemStyleReg:TListItemStyleReg;
begin
  Clear;


  FDataJson:=ADataJson;

  AddImageHttpServerUrlToPicPath(FDataJson,ImageHttpServerUrl);


  Self.lvData.Prop.Items.BeginUpdate;
  try

    Self.lvData.Prop.Items.Clear(True);


    ConvertJsonToArray(ADataJson,
                        AParamNames,
                        AParamValues);


    for I := 0 to Length(AParamNames)-1 do
    begin

          if VarIsNull(ADataJson.V[AParamNames[I]]) then
          begin
            AValueStr:='';
          end
          else
          begin
            AValueStr:=ADataJson.V[AParamNames[I]];
          end;

          //如果是图片字段,则不显示？
          if (
              (Pos('order_pic',AParamNames[I])>0)

          or (Pos('订单图片',AParamNames[I])>0)

              ) and (AValueStr='') then
          begin
            Continue;
          end;

          AItem:=Self.lvData.Prop.Items.Add;


    //      AItem.Caption:=AParamNames[I];
    //      if VarIsNull(AParamValues[I]) then
    //      begin
    //        AValueStr:='';
    //      end
    //      else
    //      begin
    //        AValueStr:=AParamValues[I];
    //      end;
    //      AItem.Detail:=AValueStr;//测试计算高度+'1werfygbedsgyewqbrfnjomdafesdayg8bjnmAKSDHOSLDJNAFFYHU';

          AItem.Caption:=AParamNames[I];


          //如果是图片字段
          if
              ('order_pic1_path'=AParamNames[I])
              or ('order_pic2_path'=AParamNames[I])
              or ('order_pic3_path'=AParamNames[I])
              or ('order_pic4_path'=AParamNames[I])
              or ('order_pic5_path'=AParamNames[I])

          or ('订单图片1'=AParamNames[I])
          or ('订单图片2'=AParamNames[I])
          or ('订单图片3'=AParamNames[I])
          or ('订单图片4'=AParamNames[I])
          or ('订单图片5'=AParamNames[I])
              then
          begin
              AItem.Icon.Url:=AValueStr;
              AItem.ItemType:=sitItem1;
              AItem.Height:=100;


          end
          else
          begin

              AItem.Detail:=AValueStr;//测试计算高度+'1werfygbedsgyewqbrfnjomdafesdayg8bjnmAKSDHOSLDJNAFFYHU';

          end;



          //Item的高度根据内容来设置Item的高度
          //AItem.Height:=



          //AListItemStyle:=lvOrderList.Prop.GetItemStyleByItemType(AListViewItem.ItemType);
          //设置Item的高度
          //AListItemStyleReg:=GlobalListItemStyleRegList.FindItemByName(AListItemStyle);
          AListItemStyleReg:=lvData.Prop.FDefaultItemStyleSetting.FListItemStyleReg;


          if (AListItemStyleReg<>nil)
            and (AListItemStyleReg.DefaultItemHeight<>0)
            and (AListItemStyleReg.DefaultItemHeight<>-1)
            and not AListItemStyleReg.IsAutoSize then
          begin
            AItem.Height:=AListItemStyleReg.DefaultItemHeight;
          end;

          if //AIsAutoSize or
              (AListItemStyleReg<>nil) //and AListItemStyleReg.IsAutoSize
              then
          begin
              //设置自动高度
              AItem.Height:=
                  lvData.Prop.CalcItemAutoSize(AItem,0).cy;
          end;



    end;

  finally
    Self.lvData.Prop.Items.EndUpdate;
  end;

  AlignControls;

end;

//function TFrameViewJson.GetCurrentPorcessControl(
//  AFocusedControl: TControl): TControl;
//begin
//  Result:=AFocusedControl;
//end;
//
//function TFrameViewJson.GetVirtualKeyboardControlParent: TControl;
//begin
//  Result:=Self;
//end;
//
//procedure TFrameViewJson.DoSelectRepairManFromMultiSelectFrame(
//  AMultiSelectFrame: TFrame);
//begin
////  ShowMessage('您选择的是 '+TFrameMultiSelect(AMultiSelectFrame).SelectedList.CommaText);
//  if Self.lvData.Prop.InteractiveItem<>nil then
//  begin
//    Self.lvData.Prop.InteractiveItem.Detail3:=TFrameMultiSelect(AMultiSelectFrame).SelectedList.CommaText;
//  end;
//end;
//
//procedure TFrameViewJson.edtHourChange(Sender: TObject);
//begin
//  SyncButtonState;
//end;
//
//procedure TFrameViewJson.edtHourChangeTracking(Sender: TObject);
//begin
//  SyncButtonState;
//end;

//procedure TFrameViewJson.Load(ADataJson: ISuperObject);
//begin
//  DoLoadData(ADataJson);
////  Self.tteGetRepairCarOrder.Run;
//end;

//procedure TFrameViewJson.idpRepairItemClick(Sender: TObject);
//begin
//
//end;

procedure TFrameViewJson.Sync(ADataJson: ISuperObject;ANeedDisplayColumns:String);
var
  I: Integer;
  AItem:TSkinItem;
//  ASuperObject:ISuperObject;
//  AStringList:TStringList;
//  AParamNames:TStringDynArray;
//  AParamValues:TVariantDynArray;
  AValueStr:String;
  AIndex:Integer;
  ANeedDisplayColumnsList:TStringList;
  ANeedHideColumnsList:TStringList;
  AListItemStyleReg:TListItemStyleReg;
begin
//  Clear;


  FDataJson:=ADataJson;

  AddImageHttpServerUrlToPicPath(FDataJson,ImageHttpServerUrl);


  ANeedDisplayColumnsList:=nil;
  Self.lvData.Prop.Items.BeginUpdate;
//  if ANeedDisplayColumns<>'' then
//  begin
//    ANeedDisplayColumnsList:=TStringList.Create;
//  end;
  ANeedDisplayColumnsList:=TStringList.Create;
  ANeedHideColumnsList:=TStringList.Create;
  try
//    if ANeedDisplayColumns<>'' then
//    begin
      ANeedDisplayColumnsList.CommaText:=ANeedDisplayColumns;
//    end;
//    if not GlobalManager.HasPower('允许查看金额') then
//    begin
//      ANeedHideColumnsList.CommaText:=GlobalManager.GetSysMemory('不允许操作员查看的字段');
//    end;
//    for I := 0 to ANeedHideColumnsList.Count-1 do
//    begin
//      AIndex:=ANeedDisplayColumnsList.IndexOf(ANeedHideColumnsList[I]);
//      if AIndex<>-1 then
//      begin
//        ANeedDisplayColumnsList.Delete(AIndex);
//      end;
//
//    end;



//    Self.lvData.Prop.Items.Clear(True);


//    ConvertJsonToArray(ADataJson,
//                        AParamNames,
//                        AParamValues,
//                        ANeedDisplayColumnsList);


//    for I := 0 to Length(AParamNames)-1 do
    for I := 0 to ANeedDisplayColumnsList.Count-1 do
    begin
      if ADataJson.Contains(ANeedDisplayColumnsList[I]) then
      begin

          if VarIsNull(ADataJson.V[ANeedDisplayColumnsList[I]]) then
          begin
            AValueStr:='';
          end
          else
          begin
            AValueStr:=ADataJson.V[ANeedDisplayColumnsList[I]];
          end;

          //如果是图片字段
          if (
              (Pos('order_pic',ANeedDisplayColumnsList[I])>0)

          or (Pos('订单图片,',ANeedDisplayColumnsList[I])>0)
 
          ) and (AValueStr='') then
          begin
            Continue;
          end;

          AItem:=Self.lvData.Prop.Items.Add;


    //      AItem.Caption:=AParamNames[I];
    //      if VarIsNull(AParamValues[I]) then
    //      begin
    //        AValueStr:='';
    //      end
    //      else
    //      begin
    //        AValueStr:=AParamValues[I];
    //      end;
    //      AItem.Detail:=AValueStr;//测试计算高度+'1werfygbedsgyewqbrfnjomdafesdayg8bjnmAKSDHOSLDJNAFFYHU';

          AItem.Caption:=ANeedDisplayColumnsList[I];


          //如果是图片字段
          if
              ('order_pic1_path'=ANeedDisplayColumnsList[I])
              or ('order_pic2_path'=ANeedDisplayColumnsList[I])
              or ('order_pic3_path'=ANeedDisplayColumnsList[I])
              or ('order_pic4_path'=ANeedDisplayColumnsList[I])
              or ('order_pic5_path'=ANeedDisplayColumnsList[I])

          or ('订单图片1'=ANeedDisplayColumnsList[I])
          or ('订单图片2'=ANeedDisplayColumnsList[I])
          or ('订单图片3'=ANeedDisplayColumnsList[I])
          or ('订单图片4'=ANeedDisplayColumnsList[I])
          or ('订单图片5'=ANeedDisplayColumnsList[I])

           then
          begin
              AItem.Icon.Url:=AValueStr;
              AItem.ItemType:=sitItem1;
              AItem.Height:=100;




          end
          else
          begin

              AItem.Detail:=AValueStr;//测试计算高度+'1werfygbedsgyewqbrfnjomdafesdayg8bjnmAKSDHOSLDJNAFFYHU';

          end;
          


          //Item的高度根据内容来设置Item的高度
          //AItem.Height:=



          //AListItemStyle:=lvOrderList.Prop.GetItemStyleByItemType(AListViewItem.ItemType);
          //设置Item的高度
          //AListItemStyleReg:=GlobalListItemStyleRegList.FindItemByName(AListItemStyle);
          AListItemStyleReg:=lvData.Prop.FDefaultItemStyleSetting.FListItemStyleReg;


          if (AListItemStyleReg<>nil)
            and (AListItemStyleReg.DefaultItemHeight<>0)
            and (AListItemStyleReg.DefaultItemHeight<>-1)
            and not AListItemStyleReg.IsAutoSize then
          begin
            AItem.Height:=AListItemStyleReg.DefaultItemHeight;
          end;

          if //AIsAutoSize or
              (AListItemStyleReg<>nil) //and AListItemStyleReg.IsAutoSize
              then
          begin
              //设置自动高度
              AItem.Height:=
                  lvData.Prop.CalcItemAutoSize(AItem,0).cy;
          end;



      end;
    end;




//    for I := 0 to FDataJson.A['RepairCarOrderItemViewList'].Length-1 do
//    begin
//      ASuperObject:=FDataJson.A['RepairCarOrderItemViewList'].O[I];
//      AItem:=Self.lvData.Prop.Items.Add;
//      AItem.DataJsonStr:=ASuperObject.AsJson;
//
//      AItem.Caption:=ASuperObject.S['名称'];
//      AItem.Detail:=Format('%.2f',[ASuperObject.F['工时单价']]);
//      AItem.Detail1:=FloatToStr(ASuperObject.F['工时']);
//      AItem.Detail2:=Format('%.2f',[ASuperObject.F['金额']]);
//
//      //维修工
//      AStringList.Clear;
//      if ASuperObject.S['维修工']<>'' then AStringList.Add(ASuperObject.S['维修工']);
//      if ASuperObject.S['维修工2']<>'' then AStringList.Add(ASuperObject.S['维修工2']);
//      if ASuperObject.S['维修工3']<>'' then AStringList.Add(ASuperObject.S['维修工3']);
//      if ASuperObject.S['维修工4']<>'' then AStringList.Add(ASuperObject.S['维修工4']);
//      if ASuperObject.S['维修工5']<>'' then AStringList.Add(ASuperObject.S['维修工5']);
//
//      AItem.Detail3:=AStringList.CommaText;
//    end;
  finally
    Self.lvData.Prop.Items.EndUpdate;
//    if ANeedDisplayColumns<>'' then
//    begin
      FreeAndNil(ANeedDisplayColumnsList);
      FreeAndNil(ANeedHideColumnsList);
//    end;
  end;

  AlignControls;
end;


procedure TFrameViewJson.lvDataClickItem(AItem: TSkinItem);
var
  AIndex:Integer;
  I: Integer;
begin
  if AItem.ItemType=sitItem1 then
  begin
      //是图片
      //点击查看大图

      //查看图片详情
      //查看照片信息
      HideFrame;//(CurrentFrame);
      //查看照片信息
      ShowFrame(TFrame(GlobalViewPictureListFrame),TFrameViewPictureList);//,frmMain,nil,nil,nil);
      GlobalViewPictureListFrame.Init('图片',
                                      nil,
                                      0,
                                      //原图URL
                                      nil
                                      );
      AIndex:=-1;
      for I := 0 to Self.lvData.Prop.Items.Count-1 do
      begin
        if Self.lvData.Prop.Items[I].ItemType=sitItem1 then
        begin
          GlobalViewPictureListFrame.AddPicture(Self.lvData.Prop.Items[I].Icon.Url);
          if Self.lvData.Prop.Items[I]=AItem then
          begin
            AIndex:=GlobalViewPictureListFrame.imglistPlayer.PictureList.Count-1;
          end;
        end;
      end;

      if AIndex=-1 then
      begin
        AIndex:=0;
      end;
      GlobalViewPictureListFrame.ShowPicture('图片',AIndex);
  end;
end;

procedure TFrameViewJson.lvDataNewListItemStyleFrameCacheInit(Sender: TObject;
  AListItemTypeStyleSetting: TListItemTypeStyleSetting;
  ANewListItemStyleFrameCache: TListItemStyleFrameCache);
begin

  if ANewListItemStyleFrameCache.FItemStyleFrame is TFrameIconCaptionListItemStyle then
  begin
    TFrameIconCaptionListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).imgItemIcon.Align:=TAlignLayout.Right;
    TFrameIconCaptionListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).imgItemIcon.Margins.Right:=10;

    TFrameIconCaptionListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).lblItemCaption.Margins.Left:=10;
    TFrameIconCaptionListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).lblItemCaption.Material.DrawCaptionParam.FontSize:=14;

    TFrameIconCaptionListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).ItemDesignerPanel.Material.BackColor.IsFill:=True;
    TFrameIconCaptionListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame).ItemDesignerPanel.Material.IsTransparent:=False;
  end;
  
end;

//function TFrameViewJson.SaveToJson: ISuperObject;
//var
//  I: Integer;
//  AStringList:TStringList;
//  AChildObject:ISuperObject;
//  ARepairItemJson:ISuperObject;
//begin
//  Result:=TSuperObject.Create();
//
//  Result.S['维修单号']:=Self.FDataJson.S['维修单号'];
//  Result.A['维修单项目派工列表']:=TSuperArray.Create;
//  AStringList:=TStringList.Create;
//  try
//    for I := 0 to Self.lvData.Prop.Items.Count-1 do
//    begin
//      ARepairItemJson:=TSuperObject.Create(Self.lvData.Prop.Items[I].DataJsonStr);
//
//      AChildObject:=TSuperObject.Create();
//      AChildObject.S['编码']:=ARepairItemJson.S['编码'];
//      AChildObject.S['维修单号']:=ARepairItemJson.S['维修单号'];
//
//      AStringList.CommaText:=Self.lvData.Prop.Items[I].Detail3;
//      //没有选,也要传进去,因为要清掉
//      if AStringList.Count>0 then
//        AChildObject.S['维修工']:=AStringList[0]
//      else
//        AChildObject.S['维修工']:='';
//      if AStringList.Count>1 then
//        AChildObject.S['维修工2']:=AStringList[1]
//      else
//        AChildObject.S['维修工2']:='';
//      if AStringList.Count>2 then
//        AChildObject.S['维修工3']:=AStringList[2]
//      else
//        AChildObject.S['维修工3']:='';
//      if AStringList.Count>3 then
//        AChildObject.S['维修工4']:=AStringList[3]
//      else
//        AChildObject.S['维修工4']:='';
//      if AStringList.Count>4 then
//        AChildObject.S['维修工5']:=AStringList[4]
//      else
//        AChildObject.S['维修工5']:='';
//
//
//      Result.A['RepairCarOrderItemViewList'].O[I]:=AChildObject;
//
//    end;
//  finally
//    FreeAndNil(AStringList);
//  end;
//end;
//
//procedure TFrameViewJson.sbcClientResize(Sender: TObject);
//begin
//  Self.AlignControls;
//end;

//procedure TFrameViewJson.Select(ACaption, ADataJsonStr: String);
//var
//  ASuperObject:ISuperObject;
//begin
//  Self.btnSelectItem.Caption:=ACaption;
//  FSelectedItemDataJsonStr:=ADataJsonStr;
//
//  ASuperObject:=TSuperObject.Create(FSelectedItemDataJsonStr);
//
//  //能自动带入工时单价
//  //判断所需要使用的价格,以及类型
//  //常用工时单价
//  Self.edtPrice.Text:=FloatToStr(ASuperObject.F['工时单价']);
//  SyncButtonState;
//
//end;

//procedure TFrameViewJson.SyncButtonState;
////var
////  ANumber:Double;
////  APrice:Double;
//begin
////  ANumber:=0;
////  if TryStrToFloat(Self.edtHour.Text,ANumber) then
////  begin
////
////  end;
////  Self.btnDec.Enabled:=ANumber>1;
////
////  //更新金额
////  if TryStrToFloat(Self.edtHour.Text,ANumber)
////    and TryStrToFloat(Self.edtPrice.Text,APrice) then
////  begin
////    Self.edtMoney.Text:=FloatToStr(ANumber*APrice);
////  end;
//end;

//procedure TFrameViewJson.tteViewJsonBegin(ATimerTask: TTimerTask);
//begin
//  ShowWaitingFrame(Self,'保存中...');
//end;
//
//procedure TFrameViewJson.tteViewJsonExecute(ATimerTask: TTimerTask);
//var
//  AParamJson:ISuperObject;
//begin
//  try
//    //出错
//    TTimerTask(ATimerTask).TaskTag:=1;
//
//
//    AParamJson:=Self.SaveToJson;
//
//    TTimerTask(ATimerTask).TaskDesc:=
//        SimpleCallAPI('repair_car_dispatch_work',
//                      nil,
//                      CarglCenterInterfaceUrl,
//                      ['appid','user_fid','key','param_json_str'],
//                      [AppID,
//                      GlobalManager.User.fid,
//                      '',
//                      AParamJson.AsJson],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//                      );
//
//
//      TTimerTask(ATimerTask).TaskTag:=0;
//
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
//end;
//
//procedure TFrameViewJson.tteViewJsonExecuteEnd(ATimerTask: TTimerTask);
//var
//  ASuperObject:ISuperObject;
//begin
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//
//        ShowHintFrame(Self,'派工成功!');
//
//        HideFrame(Self);
//        ReturnFrame(Self);
//
//      end
//      else
//      begin
//        //派工失败
//        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;
//
//    end
//    else if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//    end;
//  finally
//    HideWaitingFrame;
//  end;
//end;
//
//procedure TFrameViewJson.tteGetRepairCarOrderBegin(ATimerTask: TTimerTask);
//begin
//  ShowWaitingFrame(Self,'加载中...');
//
//end;
//
//procedure TFrameViewJson.tteGetRepairCarOrderExecute(
//  ATimerTask: TTimerTask);
//begin
//  try
//      //出错
//      TTimerTask(ATimerTask).TaskTag:=1;
//
//      TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI(
//          'get_record',
//          nil,
//          CommonRestCenterInterfaceUrl,
//          ['appid',
//          'user_fid',
//          'key',
//          'rest_name',
//          'where_key_json'],
//          [
//          AppID,
//          GlobalManager.User.fid,
//          '',
//          'RepairCarOrderView',
//          GetWhereConditions(['维修单号'],[Self.FDataJson.S['维修单号']])
//          ],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//          );
//
//      TTimerTask(ATimerTask).TaskTag:=0;
//
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
//
//end;
//
//procedure TFrameViewJson.tteGetRepairCarOrderExecuteEnd(
//  ATimerTask: TTimerTask);
//var
//  ASuperObject:ISuperObject;
//begin
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//        Self.FDataJson:=ASuperObject.O['Data'];
//
//        Self.DoLoadData(FDataJson);
//
//      end
//      else
//      begin
//        //获取订单详情失败
//        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;
//
//    end
////    else if TTimerTask(Sender).TaskTag=2 then
////    begin
////      //图片上传失败
////      ShowMessageBoxFrame(Self,'图片上传失败!','',TMsgDlgType.mtInformation,['确定'],nil);
////    end
//    else if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//    end;
//  finally
//    HideWaitingFrame;
//  end;
//
//
//end;

end.
