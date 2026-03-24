unit uPageControls;

interface
{$IF DEFINED(ANDROID) OR DEFINED(IOS) OR DEFINED(MACOS) }
  {$DEFINE FMX}
{$IFEND}



//请在工程下放置FrameWork.inc
//或者在工程设置中配置FMX编译指令
//才可以正常编译此单元
{$IFNDEF FMX}
  {$IFNDEF VCL}
    {$I FrameWork.inc}
  {$ENDIF}
{$ENDIF}


uses
  SysUtils,
  Classes,
  UITypes,

  {$IFDEF FMX}
  FMX.StdCtrls,
  FMX.Types,
  FMX.Forms,
  FMX.Menus,
//  uSkinFireMonkeyComboEdit,
  {$ENDIF}

  {$IFDEF VCL}
  Controls,
  StdCtrls,
  Menus,
  Forms,
  ExtCtrls,
  Vcl.CheckLst,
  {$ENDIF}

  uDataInterface,
  uSkinItems,
  uFuncCommon,
  uGraphicCommon,
  uPageCommon,
  uSkinItemJsonHelper,
  uBasePageStructureControls,


  uSkinPageControlType,
  uSkinListViewType,
    {$IFDEF SKIN_SUPEROBJECT}
    uSkinSuperObject,
    uSkinSuperJson,
    {$ELSE}
    XSuperObject,
    XSuperJson,
    {$ENDIF}

  //组件
//  uGraphicCommon,
//  uTimerTask,
//  uTimerTaskEvent,

//  {$IFDEF FMX}
//  uFrameContext,
//  uSkinCommonFrames,
//  uSkinCalloutRectType,
//  {$ENDIF FMX}
//
//  uSkinAnimator,
//  uSkinImageList,
//  uSkinRegManager,
//  uDownloadPictureManager,
//  uSkinControlGestureManager,
//  uSkinControlPanDragGestureManager,
//  uSkinSwitchPageListControlGestureManager,


//  uVirtualListDataController,

  //控件
  uSkinCheckBoxType,
  uSkinSwitchType,
  uSkinRadioButtonType,
  uSkinLabelType,
  uSkinMultiColorLabelType,
  uSkinPanelType,
  uSkinDrawPanelType,
//  uSkinPageControlType,
  uSkinItemDesignerPanelType,
//  uSkinDirectUIParentType,
  uSkinImageType,
  uSkinFrameImageType,
  uSkinRoundImageType,
  uSkinImageListPlayerType,
  uSkinImageListViewerType,
  uSkinSwitchPageListPanelType,
//  uSkinCalloutRectType,

  uSkinEditType,
  uSkinComboBoxType,
  uSkinDateEditType,
  uSkinTimeEditType,
  uSkinPopupType,
  uSkinComboEditType,
  uSkinMemoType,

//  {$IFDEF FMX}
//  uSkinRoundRectType,
//  uProcessNativeControlModalShowPanel,
//  AddPictureListSubFrame,
//  {$ENDIF}


  uSkinNotifyNumberIconType,
  uSkinTrackBarType,
  uSkinSwitchBarType,
  uSkinProgressBarType,


  uSkinScrollBarType,

  uSkinScrollControlType,
  uSkinScrollControlCornerType,

  uSkinScrollBoxType,
  uSkinScrollBoxContentType,

  uSkinCustomListType,

//  uSkinVirtualListType,
  uSkinListBoxType,
//  uSkinListViewType,
  uSkinTreeViewType,

//  uSkinVirtualGridType,
  uSkinItemGridType,
  uSkinDBGridType,


  uSkinPullLoadPanelType,
//  uSkinRegExTagLabelViewType,
  uSkinVirtualChartType,



  {$IFDEF VCL}
  uSkinFormType,
//  uSkinFormPictureType,
//  uSkinFormColorType,
  uSkinWindowsEdit,
  uSkinWindowsMemo,
  {$ENDIF}


  {$IFDEF FMX}
  uSkinFireMonkeyButton,
  uSkinFireMonkeyLabel,
  uSkinFireMonkeyMultiColorLabel,
  uSkinFireMonkeyEdit,
  uSkinFireMonkeyComboBox,
  uSkinFireMonkeyDateEdit,
  uSkinFireMonkeyTimeEdit,
  uSkinFireMonkeyPopup,
  uSkinFireMonkeyComboEdit,
  uSkinFireMonkeyMemo,
  uSkinFireMonkeyPanel,
  uSkinFireMonkeyDrawPanel,
//  uSkinFireMonkeyDirectUIParent,
  uSkinFireMonkeyPageControl,
  uSkinFireMonkeyItemDesignerPanel,
  uSkinFireMonkeyImage,
  uSkinFireMonkeyRoundRect,
  uSkinFireMonkeyImageListPlayer,
  uSkinFireMonkeyImageListViewer,
  uSkinFireMonkeyRoundImage,
  uSkinFireMonkeyFrameImage,
  uSkinFireMonkeyTrackBar,
  uSkinFireMonkeySwitchBar,
  uSkinFireMonkeyProgressBar,
  uSkinFireMonkeyScrollBar,
  uSkinFireMonkeyPullLoadPanel,
  uSkinFireMonkeyScrollBox,
  uSkinFireMonkeyScrollBoxContent,
  uSkinFireMonkeyScrollControl,
  uSkinFireMonkeyScrollControlCorner,
  uSkinFireMonkeySwitchPageListPanel,

  uSkinFireMonkeyCustomList,
//  uSkinFireMonkeyVirtualList,
  uSkinFireMonkeyListBox,
  uSkinFireMonkeyListView,
  uSkinFireMonkeyTreeView,

//  uSkinFireMonkeyVirtualGrid,
  uSkinFireMonkeyItemGrid,
  uSkinFireMonkeyDBGrid,

  uSkinFireMonkeyRadioButton,
  uSkinFireMonkeyNotifyNumberIcon,
  uSkinFireMonkeyCheckBox,
//  uSkinFireMonkeyCalloutRect,
  uSkinFireMonkeySwitch,
  {$ENDIF}


//  uPageFramework,
//  BasePageFrame,
//  BaseListPageFrame,
//  BaseViewPageFrame,
//  BaseEditPageFrame;
  uSkinButtonType,



  uComponentType,
//  uSkinButtonType,
  uBasePageStructure,
  uPageInstance,
  uPageStructure;

type

  //选择日期范围的按钮
  TPageSelectDateAreaButton=class(TSkinSelectDateAreaButton)
  private
//    FEndDate: String;
//    FStartDate: String;
//    procedure SyncCaption;
//    procedure SetEndDate(const Value: String);
//    procedure SetStartDate(const Value: String);
  protected
    FFieldControlSettingMap:TFieldControlSettingMap;
    //针对页面框架的控件接口
    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting;AFieldControlSettingMap:TObject):Boolean;override;
    //获取提交的值
    function GetPostValue(ASetting:TFieldControlSetting;
                            APageDataDir:String;
                            //可以获取其他字段的值
                            ASetRecordFieldValueIntf:ISetRecordFieldValue;
                            var AErrorMessage:String):Variant;override;
    //设置值
    procedure SetControlValue(ASetting:TFieldControlSetting;
                            APageDataDir:String;
                            AImageServerUrl:String;
                            AValue:Variant;
                            AValueCaption:String;
                            //要设置多个值,整个字段的记录
                            AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue);override;
    procedure DoReturnFrame(AFromFrame:TFrame);override;
  public
    procedure Click;override;
//    property StartDate:String read FStartDate write SetStartDate;
//    property EndDate:String read FEndDate write SetEndDate;
  end;


  {$REGION 'TPagePopupMenu'}
  TPagePopupMenu=class(TPopupMenu,IControlForPageFramework)
  public
    FValues:TStringList;
    //针对页面框架的控件接口
    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting;AFieldControlSettingMap:TObject):Boolean;
    //获取与设置自定义属性
    function GetPropJsonStr:String;
    procedure SetPropJsonStr(AJsonStr:String);
    //获取提交的值
    function GetPostValue(ASetting:TFieldControlSetting;
                            APageDataDir:String;
                            //可以获取其他字段的值
                            ASetRecordFieldValueIntf:ISetRecordFieldValue;
                            var AErrorMessage:String):Variant;
    //设置值
    procedure SetControlValue(ASetting:TFieldControlSetting;
                            APageDataDir:String;
                            AImageServerUrl:String;
                            AValue:Variant;
                            AValueCaption:String;
                            //要设置多个值,整个字段的记录
                            AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue);
//    //设置属性
//    function GetProp(APropName:String):Variant;
//    procedure SetProp(APropName:String;APropValue:Variant);
    procedure DoReturnFrame(AFromFrame:TFrame);virtual;
  public
    FFieldControlSettingMap:TFieldControlSettingMap;
    procedure DoMenuItemClick(Sender:TObject);
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;

  {$ENDREGION}


  {$REGION 'TPageRadioGroup'}
  {$IFDEF VCL}
  TPageRadioGroup=class(TRadioGroup,IControlForPageFramework)
  public
    FValues:TStringList;
    //针对页面框架的控件接口
    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting;AFieldControlSettingMap:TObject):Boolean;
    //获取与设置自定义属性
    function GetPropJsonStr:String;
    procedure SetPropJsonStr(AJsonStr:String);
    //获取提交的值
    function GetPostValue(ASetting:TFieldControlSetting;
                            APageDataDir:String;
                            //可以获取其他字段的值
                            ASetRecordFieldValueIntf:ISetRecordFieldValue;
                            var AErrorMessage:String):Variant;
    //设置值
    procedure SetControlValue(ASetting:TFieldControlSetting;
                            APageDataDir:String;
                            AImageServerUrl:String;
                            AValue:Variant;
                            AValueCaption:String;
                            //要设置多个值,整个字段的记录
                            AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue);
//    //设置属性
//    function GetProp(APropName:String):Variant;
//    procedure SetProp(APropName:String;APropValue:Variant);
    procedure DoReturnFrame(AFromFrame:TFrame);virtual;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;
  {$ENDIF}

  {$ENDREGION}



  {$REGION 'TPageSkinListView'}
  TPageSkinListView=class(TSkinListView,IPageFrameworkListControl)
  private
  public
    FFieldControlSettingMap:TFieldControlSettingMap;

    //这是非常老的显示方式
    //默认列表项的绑定设置,比如{"ItemCaption":"工序","ItemDetail":"完成人员姓名"}'
    //表示Json中的工序字段赋给Item.Caption
    FDefaultListItemBindings:TListItemBindings;

//    FValueForm:String;

    //针对页面框架的控件接口
    //加入从FOptionsJsonArray中加入Item的功能
    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting;AFieldControlSettingMap:TObject):Boolean;override;
    procedure SetPropJsonStr(AJsonStr:String);override;
    //获取提交的值
    function GetPostValue(ASetting:TFieldControlSetting;APageDataDir:String;ASetRecordFieldValueIntf:ISetRecordFieldValue;
                            var AErrorMessage:String):Variant;override;
  public
    procedure SetOnFocusedRecordChange(AValue:TFocusedRecordChangeEvent);
//    procedure AddRecord(ARecordDataJson:ISuperObject);
//    procedure UpdateRecord(ARecordDataJson:ISuperObject);
    procedure SaveDataIntfResult(ALoadDataSetting:TLoadDataSetting;ADataIntfResult:TDataIntfResult);
    procedure DeleteRecord(ADataIntfResult:TDataIntfResult);
    //获取到选中的记录列表
    function GetSelectedRecordList:ISuperArray;
    //设置列表控件的值
    procedure SetListControlValue(ASetting:TFieldControlSetting;
                                  APageDataDir:String;
                                  AImageServerUrl:String;
                                  AValue:Variant;
                                  AValueCaption:String;
                                  //如果值是一个数组
                                  AValueArray:ISuperArray;
                                  AValueObject:TObject;
                                  //要设置多个值,整个字段的记录
                                  AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue;
                                  ALoadDataIntfResult:TDataIntfResult;
                                  ALoadDataIntfResult2:TDataIntfResult);virtual;
  public
    procedure DoSelectedItem(Sender:TObject;AItem:TSkinItem);
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;

  {$ENDREGION}


  {$REGION 'TPageSkinItemGrid'}
  TPageSkinItemGrid=class(TSkinItemGrid,IPageFrameworkListControl)
  private
  public
    FFieldControlSettingMap:TFieldControlSettingMap;

    //这是非常老的显示方式
    //默认列表项的绑定设置,比如{"ItemCaption":"工序","ItemDetail":"完成人员姓名"}'
    //表示Json中的工序字段赋给Item.Caption
    FDefaultListItemBindings:TListItemBindings;



    //针对页面框架的控件接口
    //加入从FOptionsJsonArray中加入Item的功能
    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting;AFieldControlSettingMap:TObject):Boolean;override;
    procedure SetPropJsonStr(AJsonStr:String);override;
//    //将数据添加到列表控件上
//    function AddSkinItemToListControl(ASkinVirtualList:TSkinCustomList;
//                                      ASuperObject:ISuperObject;
//                                      AValueObject:TObject;
//                                      AItemCaption:String='';
//                                      AItemName:String=''):TSkinItem;
  public
    procedure SetOnFocusedRecordChange(AValue:TFocusedRecordChangeEvent);
//    procedure AddRecord(ARecordDataJson:ISuperObject);
//    procedure UpdateRecord(ARecordDataJson:ISuperObject);
    procedure SaveDataIntfResult(ALoadDataSetting:TLoadDataSetting;ADataIntfResult:TDataIntfResult);
    procedure DeleteRecord(ADataIntfResult:TDataIntfResult);
    //获取到选中的记录列表
    function GetSelectedRecordList:ISuperArray;
    //设置列表控件的值
    procedure SetListControlValue(ASetting:TFieldControlSetting;
                                  APageDataDir:String;
                                  AImageServerUrl:String;
                                  AValue:Variant;
                                  AValueCaption:String;
                                  //如果值是一个数组
                                  AValueArray:ISuperArray;
                                  AValueObject:TObject;
                                  //要设置多个值,整个字段的记录
                                  AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue;
                                  ALoadDataIntfResult:TDataIntfResult;
                                  ALoadDataIntfResult2:TDataIntfResult);virtual;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;

  {$ENDREGION}



  {$REGION 'TPageSkinSelectedListView'}
  TPageSkinSelectedListView=class(TPageSkinListView)
  private
    FchkSelectedAll:{$IFDEF FMX}TSkinFMXCheckBox{$ELSE}TSkinWinCheckBox{$ENDIF};
    //可以选择的最大个数,0表示不限制
    FCanSelectedMaxCount:Integer;
    procedure FchkSelectedAllClick(Sender:TObject);
    procedure SyncSelectedStatus;
    procedure DoSelectedItemChange(Sender:TObject;AItem:TSkinItem);
  public
    //针对页面框架的控件接口
    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting;AFieldControlSettingMap:TObject):Boolean;override;
//    //获取与设置自定义属性
//    function GetPropJsonStr:String;override;
//    procedure SetPropJsonStr(AJsonStr:String);override;
    //获取提交的值
    function GetPostValue(ASetting:TFieldControlSetting;
                            APageDataDir:String;
                            //可以获取其他字段的值
                            ASetRecordFieldValueIntf:ISetRecordFieldValue;
                            var AErrorMessage:String):Variant;override;
    //设置值,已经实现了IPageFrameworkListControl接口，因此不需要这个方法了
    procedure SetControlValue(ASetting:TFieldControlSetting;
                            APageDataDir:String;
                            AImageServerUrl:String;
                            AValue:Variant;
                            AValueCaption:String;
                            //要设置多个值,整个字段的记录
                            AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue);override;
//    //设置属性
//    function GetProp(APropName:String):Variant;override;
//    procedure SetProp(APropName:String;APropValue:Variant);override;
  public
    //设置列表控件的值
    procedure SetListControlValue(ASetting:TFieldControlSetting;
                                  APageDataDir:String;
                                  AImageServerUrl:String;
                                  AValue:Variant;
                                  AValueCaption:String;
                                  //如果值是一个数组
                                  AValueArray:ISuperArray;
                                  AValueObject:TObject;
                                  //要设置多个值,整个字段的记录
                                  AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue;
                                  ALoadDataIntfResult:TDataIntfResult;
                                  ALoadDataIntfResult2:TDataIntfResult);override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;

  {$ENDREGION}


  {$REGION 'TPageCheckListBox'}
  {$IFDEF VCL}
  TPageCheckListBox=class(TCheckListBox,IControlForPageFramework)
    //针对页面框架的控件接口
    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting;AFieldControlSettingMap:TObject):Boolean;
    //获取与设置自定义属性
    function GetPropJsonStr:String;
    procedure SetPropJsonStr(AJsonStr:String);
    //获取提交的值
    function GetPostValue(ASetting:TFieldControlSetting;
                            APageDataDir:String;
                            //可以获取其他字段的值
                            ASetRecordFieldValueIntf:ISetRecordFieldValue;
                            var AErrorMessage:String):Variant;
    //设置值
    procedure SetControlValue(ASetting:TFieldControlSetting;
                            APageDataDir:String;
                            AImageServerUrl:String;
                            AValue:Variant;
                            AValueCaption:String;
                            //要设置多个值,整个字段的记录
                            AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue);
//    //设置属性
//    function GetProp(APropName:String):Variant;override;
//    procedure SetProp(APropName:String;APropValue:Variant);override;
    procedure DoReturnFrame(AFromFrame:TFrame);virtual;
  end;
  {$ENDIF}
  {$ENDREGION}




//加载APP的主页到PageControl
procedure LoadPageControlMenu(APageControl:TSkinPageControl;AMenus:ISuperArray);




implementation





procedure LoadPageControlMenu(APageControl:TSkinPageControl;AMenus:ISuperArray);
var
  I: Integer;
  ATabSheet:TSkinTabSheet;
begin

  APageControl.Prop.ClearPages;
  for I := 0 to AMenus.Length-1 do
  begin
    ATabSheet:=TSkinTabSheet.Create(APageControl);
//    ATabSheet.
    ATabSheet.Prop.PageControl:=APageControl;
    ATabSheet.Caption:=AMenus.O[I].S['caption'];
//    ATabSheet.Prop.Icon.Url:=GetImageUrl(AMenus.O[I].S['icon_pic_path']);
//    ATabSheet.Prop.PushedIcon.Url:=GetImageUrl(AMenus.O[I].S['pushed_icon_pic_path']);
    SetFrameName(ATabSheet);
  end;


end;

{ TPageSkinListView }

constructor TPageSkinListView.Create(AOwner:TComponent);
begin
  Inherited;
  FDefaultListItemBindings:=TListItemBindings.Create(TListItemBindingItem);

  Self.OnSelectedItem:=DoSelectedItem;
end;

destructor TPageSkinListView.Destroy;
begin
  FreeAndNil(FDefaultListItemBindings);
  Inherited;

end;


procedure TPageSkinListView.DoSelectedItem(Sender: TObject;
  AItem: TSkinItem);
var
  AErrorMessage:String;
begin
  if FFieldControlSettingMap<>nil then
  begin
    if FFieldControlSettingMap.Setting.value_from='SelectedItem.Caption' then
    begin
      FFieldControlSettingMap.Value:=GetPostValue(FFieldControlSettingMap.Setting,'',nil,AErrorMessage);
    end;
  end;
end;

procedure TPageSkinListView.SaveDataIntfResult(
  ALoadDataSetting: TLoadDataSetting; ADataIntfResult: TDataIntfResult);
begin

end;

procedure TPageSkinListView.SetListControlValue(ASetting: TFieldControlSetting;
  APageDataDir, AImageServerUrl: String; AValue: Variant; AValueCaption: String;
  AValueArray: ISuperArray; AValueObject: TObject;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue;
  ALoadDataIntfResult, ALoadDataIntfResult2: TDataIntfResult);
var
//  ASkinVirtualList:TSkinVirtualList;
  I: Integer;
  ASkinItem:TBaseSkinItem;
  ASkinItems:TSkinItems;
//  J: Integer;
  ASkinItemList:TList;
begin

//  if not AIsSetted and (AComponent is TSkinVirtualList) and (AFieldControlSettingMap.Setting.field_name='RecordList') then
//  begin
//      AIsSetted:=True;
//
//
//      ASkinVirtualList:=TSkinVirtualList(AComponent);
  Self.OnSelectedItem:=nil;

      if (AValueArray=nil) and (CopyString(AValue,1,1)='[') then
      begin
        AValueArray:=TSuperArray.Create(AValue);
      end;

      Self.Prop.Items.BeginUpdate;
      try

          //第一页要清空
          //TSkinRealSkinItemComponent对应的Item不需要清除
          if  (ALoadDataIntfResult<>nil) and (ALoadDataIntfResult.FLoadDataSetting<>nil) and (ALoadDataIntfResult.FLoadDataSetting.PageIndex>1) then
          begin
            //不清空
          end
          else
          begin
            //要清空
//            for I := 0 to Self.PageStructure.MainLayoutControlList.Count-1 do
//            begin
//
//            end;

            Self.Prop.Items.Clear(True);

          end;


//          //其他字段名
//          if AFieldControlSettingMap.Setting.other_field_names<>'' then
//          begin
//
//          end;




//          //字段名
//          AFieldControlSetting.field_name:='RecordList';
//          AFieldControlSetting.field_caption:='数据列表';





          //返回的是Json数组
          if (AValueArray<>nil) then
          begin

              //设计面板直接与Json字段进行绑定的,只需要设置Item.Json属性即可
              for I := 0 to AValueArray.Length-1 do
              begin
                AddSkinItemToListControl(Self,AValueArray.O[I],nil,'','',Self.FDefaultListItemBindings,Self.FFieldControlSettingMap);
              end;

          end;




          //返回的是TSkinItems
          if (AValueObject<>nil) and (AValueObject is TSkinItems) then
          begin
              ASkinItems:=TSkinItems(AValueObject);
              for I := 0 to ASkinItems.Count-1 do
              begin

                AddSkinItemToListControl(Self,nil,ASkinItems[I],'','',Self.FDefaultListItemBindings,Self.FFieldControlSettingMap);



  //                if ASkinItems[I] is TSkinPageStructureJsonItem then
  //                begin
  //                  ASkinItem:=TSkinPageStructureJsonItem.Create;
  //                  TSkinPageStructureJsonItem(ASkinItem).Json:=AValueArray.O[I];
  //                  Self.Prop.Items.Add(ASkinItem);
  //                end
  //                else
  //                begin
  //                  //直接赋值
  //                  ASkinItem:=TBaseSkinItem(Self.Prop.Items.Add);
  //                  ASkinItem.Assign(ASkinItems[I]);
  //                end;


              end;
          end;


      finally
        Self.Prop.Items.EndUpdate();
      end;

//  end;
  Self.OnSelectedItem:=DoSelectedItem;

end;

procedure TPageSkinListView.SetOnFocusedRecordChange(
  AValue: TFocusedRecordChangeEvent);
begin

end;

procedure TPageSkinListView.SetPropJsonStr(AJsonStr: String);
var
  APropJson:ISuperObject;
  ASuperObject:ISuperObject;
  AContentHeight:Double;

    //列表页面相关设置//
    //是否是默认的ListPage,
    //如果是就创建一个默认的ListView
//    is_simple_list_page:Integer;
    //列表页面是否需要添加记录按钮
    has_add_record_button:Integer;

    data_list_field_name:String;
    data_list_other_field_name:String;


    //默认列表项的显示风格,比如Default,SaleManage,等等
    default_list_item_style:String;

    //做为列表项样式时的默认值
    list_item_style_default_height:Double;
    list_item_style_autosize:Integer;
    list_item_style_default_width:Double;
begin
  inherited;

  APropJson:=SO(AJsonStr);


  if APropJson.B['AutoHeight'] and (APropJson.I['AutoHeightMax']>0) and (APropJson.I['AutoHeightMin']>0) then
  begin
    TFieldControlSettingMap(FFieldControlSettingMap).FIsUseSelfHeight:=True;
    AContentHeight:=Self.Prop.CalcContentHeight;

    if (APropJson.I['AutoHeightMax']>0) and (AContentHeight>ScreenScaleSizeInt(APropJson.I['AutoHeightMax'])) then
    begin
//      TFieldControlSettingMap(FFieldControlSettingMap).FHeight
      TFieldControlSettingMap(FFieldControlSettingMap).FHeight:=ScreenScaleSizeInt(APropJson.I['AutoHeightMax']);
    end
    else
    if (APropJson.I['AutoHeightMin']>0) and (AContentHeight<ScreenScaleSizeInt(APropJson.I['AutoHeightMin'])) then
    begin
      TFieldControlSettingMap(FFieldControlSettingMap).FHeight:=ScreenScaleSizeInt(APropJson.I['AutoHeightMin']);
    end
    else
    begin
      TFieldControlSettingMap(FFieldControlSettingMap).FHeight:=AContentHeight;
    end;


  end;



//  //做为列表项样式时的默认值
//  list_item_style_default_height:=AJson.F['list_item_style_default_height'];
//  list_item_style_autosize:=AJson.I['list_item_style_autosize'];
//  list_item_style_default_width:=AJson.F['list_item_style_default_width'];






end;

procedure TPageSkinListView.DeleteRecord(ADataIntfResult: TDataIntfResult);
begin

end;

function TPageSkinListView.GetPostValue(ASetting: TFieldControlSetting;
  APageDataDir: String; ASetRecordFieldValueIntf: ISetRecordFieldValue;
  var AErrorMessage: String): Variant;
begin
  if ASetting.value_from='' then
  begin
      Result:=Inherited;
  end
  else if ASetting.value_from='SelectedItem.Caption' then
  begin
      Result:='';
      if Self.Prop.SelectedItem<>nil then
      begin
        Result:=Self.Prop.SelectedItem.Caption;
      end;
  end;
end;

function TPageSkinListView.GetSelectedRecordList: ISuperArray;
var
  I: Integer;
begin
  Result:=TSuperArray.Create();
  for I := 0 to Self.Prop.Items.Count-1 do
  begin
    if Self.Prop.Items[I].Selected then
    begin
      Result.O[Result.Length]:=Self.Prop.Items[I].Json;
    end;
  end;
end;

function TPageSkinListView.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting;AFieldControlSettingMap:TObject): Boolean;
var
  I:Integer;
  AItem:TSkinItem;
  ASuperObject:ISuperObject;
//  AJsonItem:TSkinJsonItem;
    //默认列表项的绑定设置的json数组,比如{"ItemCaption":"name"}
    default_list_item_bindings:String;
  AOptionCaption:String;
begin
  Result:=Inherited;

  FFieldControlSettingMap:=TFieldControlSettingMap(AFieldControlSettingMap);


  if (TPageFieldControlSetting(ASetting).FPropJson<>nil) then
  begin
  //  //默认列表项的显示风格
  //  default_list_item_style:=AJson.S['default_list_item_style'];
    //默认列表项的绑定设置
    default_list_item_bindings:=TPageFieldControlSetting(ASetting).FPropJson.S['default_list_item_bindings'];

    if default_list_item_bindings<>'' then
    begin
      ASuperObject:=TSuperObject.Create(default_list_item_bindings);
      FDefaultListItemBindings.LoadFromJson(ASuperObject);
    end;
  end;




  //给控件设置值
  //判断AValue是否是字符串列表
  Self.Prop.Items.BeginUpdate;
  try
    Self.Prop.Items.Clear();
    for I := 0 to ASetting.FOptionValues.Count - 1 do
    begin

      ASuperObject:=nil;
      if (TFieldControlSettingMap(AFieldControlSettingMap).FOptionsJsonArray<>nil) then
      begin
        ASuperObject:=TFieldControlSettingMap(AFieldControlSettingMap).FOptionsJsonArray.O[I];
      end;
      AOptionCaption:='';
      if I<ASetting.FOptionCaptions.Count then
      begin
        AOptionCaption:=ASetting.FOptionCaptions[I];
      end;


      AItem:=AddSkinItemToListControl(Self,ASuperObject,nil,AOptionCaption,ASetting.FOptionValues[I],Self.FDefaultListItemBindings,Self.FFieldControlSettingMap);

//      if (TPageFieldControlSetting(ASetting).FPropJson<>nil)
//        and (TPageFieldControlSetting(ASetting).FPropJson.S['ItemClass']='TSkinJsonItem') then
//      begin
//        AItem:=TSkinJsonItem.Create;
//        Self.Prop.Items.Add(AItem);
//      end
//      else
//      begin
//        AItem:=TSkinItem(Self.Prop.Items.Add);
//        AItem.Caption:=ASetting.FOptionCaptions[I];
//        AItem.Name:=ASetting.FOptionValues[I];
//      end;
//
//      //  AFieldControlSetting.PropJson.S['ItemIconSkinImageListName']:='imgHeadList';
//      //  AFieldControlSetting.PropJson.I['ItemIconDefaultImageIndex']:=0;
//
//      //Item的默认图片，当URL为空的时候
//      if TPageFieldControlSetting(ASetting).PropJson<>nil then
//      begin
//        AItem.Icon.SkinImageListName:=TPageFieldControlSetting(ASetting).PropJson.S['ItemIconSkinImageListName'];
//        if TPageFieldControlSetting(ASetting).PropJson.Contains('ItemIconDefaultImageIndex') then
//        begin
//          AItem.Icon.DefaultImageIndex:=TPageFieldControlSetting(ASetting).PropJson.I['ItemIconDefaultImageIndex'];
//        end;
//
//      end;
//
//      if (TPageFieldControlSetting(ASetting).FOptionsJsonArray<>nil) then
//      begin
//        AItem.Json:=TPageFieldControlSetting(ASetting).FOptionsJsonArray.O[I];
//      end;

    end;

  finally
    Self.Prop.Items.EndUpdate;
  end;





  Result:=True;

//  end
//  else
//  begin
//
//      Self.Prop.Items.BeginUpdate;
//      try
//
//        for I := 0 to TPageFieldControlSetting(ASetting).FOptionsJsonArray.Length - 1 do
//        begin
//          AItem:=TSkinItem(Self.Prop.Items.Add);
//          AItem.Caption:=ASetting.FOptionCaptions[I];
//          AItem.Name:=ASetting.FOptionValues[I];
//        end;
//
//      finally
//        Self.Prop.Items.EndUpdate;
//      end;
//
//  end;

end;



{ TPageSkinItemGrid }

constructor TPageSkinItemGrid.Create(AOwner:TComponent);
begin
  Inherited;
  FDefaultListItemBindings:=TListItemBindings.Create(TListItemBindingItem);


end;

destructor TPageSkinItemGrid.Destroy;
begin
  FreeAndNil(FDefaultListItemBindings);
  Inherited;

end;


procedure TPageSkinItemGrid.SaveDataIntfResult(
  ALoadDataSetting: TLoadDataSetting; ADataIntfResult: TDataIntfResult);
begin

end;

//function TPageSkinItemGrid.AddSkinItemToListControl(
//  ASkinVirtualList: TSkinCustomList;
//  ASuperObject: ISuperObject;
//  AValueObject:TObject;
//  AItemCaption:String;
//  AItemName:String):TSkinItem;
//var
//  J:Integer;
//  ASkinItem:TSkinItem;
//  AValue:Variant;
//  ASetting:TPageFieldControlSetting;
//begin
//  if ASuperObject<>nil then
//  begin
//
//      ASetting:=TPageFieldControlSetting(FFieldControlSettingMap.Setting);
//
//
//
//      if (Self.FDefaultListItemBindings.Count=0) then
//      begin
//
//          if (ASetting.FPropJson<>nil)
//            and (ASetting.FPropJson.S['ItemClass']='TSkinJsonItem') then
//          begin
//            ASkinItem:=TSkinJsonItem.Create;
//            Self.Prop.Items.Add(ASkinItem);
//
//          end
//          else
//          begin
//            ASkinItem:=TSkinItem(Self.Prop.Items.Add);
//            ASkinItem.Caption:=AItemCaption;//ASetting.FOptionCaptions[I];
//          end;
//          //定位选项用
//          ASkinItem.Name:=AItemName;//ASetting.FOptionValues[I];
//
//          //  AFieldControlSetting.PropJson.S['ItemIconSkinImageListName']:='imgHeadList';
//          //  AFieldControlSetting.PropJson.I['ItemIconDefaultImageIndex']:=0;
//
//
////          if (TPageFieldControlSetting(ASetting).FOptionsJsonArray<>nil) then
////          begin
//            ASkinItem.Json:=ASuperObject;
////          end;
//
////            //设有设置Item属性与字段的对应,那就是使用JsonSkinItem
////            ASkinItem:=TSkinPageStructureJsonItem.Create;
////            TSkinPageStructureJsonItem(ASkinItem).Json:=ASuperObject;
////            ASkinVirtualList.Prop.Items.Add(ASkinItem);
//
//
//      end
//      else
//      begin
//
//
//            ASkinItem:=TSkinItem(ASkinVirtualList.Prop.Items.Add);
//            ASkinItem.Json:=ASuperObject;
//
//            //会不会慢
//            for J := 0 to Self.FDefaultListItemBindings.Count-1 do
//            begin
//              AValue:=ASuperObject.V[Self.FDefaultListItemBindings[J].data_field_name];
//
//              if AValue=Null then
//              begin
//                AValue:='';
//              end;
//
//              ASkinItem.SetValueByBindItemField(
//                                                Self.FDefaultListItemBindings[J].item_field_name,
//                                                AValue,
//                                                '',//Self.GetPageDataDir,
//                                                GlobalMainProgramSetting.DataIntfImageUrl
//                                                );
//            end;
//
//      end;
//
//
//
//  end;
//
//
//
//  if (AValueObject<>nil) and (AValueObject is TBaseSkinItem) then
//  begin
//      if AValueObject is TSkinPageStructureJsonItem then
//      begin
//        ASkinItem:=TSkinPageStructureJsonItem.Create;
//        ASkinItem.Assign(TSkinItem(AValueObject));
//        Self.Prop.Items.Add(ASkinItem);
//      end
//      else
//      begin
//        //直接赋值
//        ASkinItem:=TSkinItem(Self.Prop.Items.Add);
//        ASkinItem.Assign(TSkinItem(AValueObject));
//        ASkinItem.Json:=TSkinItem(AValueObject).Json;
//      end;
//
//  end;
//
//
//  //Item的默认图片，当URL为空的时候
//  if ASetting.PropJson<>nil then
//  begin
//    ASkinItem.Icon.SkinImageListName:=ASetting.PropJson.S['ItemIconSkinImageListName'];
//    if ASetting.PropJson.Contains('ItemIconDefaultImageIndex') then
//    begin
//      ASkinItem.Icon.DefaultImageIndex:=ASetting.PropJson.I['ItemIconDefaultImageIndex'];
//    end;
//
//  end;
//
//
//  Result:=ASkinItem;
//
//end;

procedure TPageSkinItemGrid.SetListControlValue(ASetting: TFieldControlSetting;
  APageDataDir, AImageServerUrl: String; AValue: Variant; AValueCaption: String;
  AValueArray: ISuperArray; AValueObject: TObject;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue;
  ALoadDataIntfResult, ALoadDataIntfResult2: TDataIntfResult);
var
//  ASkinVirtualList:TSkinVirtualList;
  I: Integer;
  ASkinItem:TBaseSkinItem;
  ASkinItems:TSkinItems;
//  J: Integer;
  ASkinItemList:TList;
begin

//  if not AIsSetted and (AComponent is TSkinVirtualList) and (AFieldControlSettingMap.Setting.field_name='RecordList') then
//  begin
//      AIsSetted:=True;
//
//
//      ASkinVirtualList:=TSkinVirtualList(AComponent);
      Self.Prop.Items.BeginUpdate;
      try

          //第一页要清空
          //TSkinRealSkinItemComponent对应的Item不需要清除
//          if Self.FLoadDataSetting.PageIndex<=1 then
          if  (ALoadDataIntfResult<>nil) and (ALoadDataIntfResult.FLoadDataSetting<>nil) and (ALoadDataIntfResult.FLoadDataSetting.PageIndex<=1) then
          begin
            //不清空
          end
          else
          begin
            //要清空
//            for I := 0 to Self.PageStructure.MainLayoutControlList.Count-1 do
//            begin
//
//            end;

            Self.Prop.Items.Clear(True);

          end;


//          //其他字段名
//          if AFieldControlSettingMap.Setting.other_field_names<>'' then
//          begin
//
//          end;




//          //字段名
//          AFieldControlSetting.field_name:='RecordList';
//          AFieldControlSetting.field_caption:='数据列表';





          //返回的是Json数组
          if (AValueArray<>nil) then
          begin

              //设计面板直接与Json字段进行绑定的,只需要设置Item.Json属性即可
              for I := 0 to AValueArray.Length-1 do
              begin
                AddSkinItemToListControl(Self,AValueArray.O[I],nil,'','',Self.FDefaultListItemBindings,Self.FFieldControlSettingMap);
              end;

          end;




          //返回的是TSkinItems
          if (AValueObject<>nil) and (AValueObject is TSkinItems) then
          begin
              ASkinItems:=TSkinItems(AValueObject);
              for I := 0 to ASkinItems.Count-1 do
              begin

                AddSkinItemToListControl(Self,nil,ASkinItems[I],'','',Self.FDefaultListItemBindings,Self.FFieldControlSettingMap);



  //                if ASkinItems[I] is TSkinPageStructureJsonItem then
  //                begin
  //                  ASkinItem:=TSkinPageStructureJsonItem.Create;
  //                  TSkinPageStructureJsonItem(ASkinItem).Json:=AValueArray.O[I];
  //                  Self.Prop.Items.Add(ASkinItem);
  //                end
  //                else
  //                begin
  //                  //直接赋值
  //                  ASkinItem:=TBaseSkinItem(Self.Prop.Items.Add);
  //                  ASkinItem.Assign(ASkinItems[I]);
  //                end;


              end;
          end;


      finally
        Self.Prop.Items.EndUpdate();
      end;

//  end;

end;

procedure TPageSkinItemGrid.SetOnFocusedRecordChange(
  AValue: TFocusedRecordChangeEvent);
begin

end;

procedure TPageSkinItemGrid.SetPropJsonStr(AJsonStr: String);
var
  APropJson:ISuperObject;
  ASuperObject:ISuperObject;
  AContentHeight:Double;

    //列表页面相关设置//
    //是否是默认的ListPage,
    //如果是就创建一个默认的ItemGrid
//    is_simple_list_page:Integer;
    //列表页面是否需要添加记录按钮
    has_add_record_button:Integer;

    data_list_field_name:String;
    data_list_other_field_name:String;


    //默认列表项的显示风格,比如Default,SaleManage,等等
    default_list_item_style:String;

    //做为列表项样式时的默认值
    list_item_style_default_height:Double;
    list_item_style_autosize:Integer;
    list_item_style_default_width:Double;
begin
  inherited;

  APropJson:=SO(AJsonStr);


  if APropJson.B['AutoHeight'] and (APropJson.I['AutoHeightMax']>0) and (APropJson.I['AutoHeightMin']>0) then
  begin
    TFieldControlSettingMap(FFieldControlSettingMap).FIsUseSelfHeight:=True;
    AContentHeight:=Self.Prop.CalcContentHeight;

    if (APropJson.I['AutoHeightMax']>0) and (AContentHeight>ScreenScaleSizeInt(APropJson.I['AutoHeightMax'])) then
    begin
//      TFieldControlSettingMap(FFieldControlSettingMap).FHeight
      TFieldControlSettingMap(FFieldControlSettingMap).FHeight:=ScreenScaleSizeInt(APropJson.I['AutoHeightMax']);
    end
    else
    if (APropJson.I['AutoHeightMin']>0) and (AContentHeight<ScreenScaleSizeInt(APropJson.I['AutoHeightMin'])) then
    begin
      TFieldControlSettingMap(FFieldControlSettingMap).FHeight:=ScreenScaleSizeInt(APropJson.I['AutoHeightMin']);
    end
    else
    begin
      TFieldControlSettingMap(FFieldControlSettingMap).FHeight:=AContentHeight;
    end;


  end;



//  //做为列表项样式时的默认值
//  list_item_style_default_height:=AJson.F['list_item_style_default_height'];
//  list_item_style_autosize:=AJson.I['list_item_style_autosize'];
//  list_item_style_default_width:=AJson.F['list_item_style_default_width'];






end;

procedure TPageSkinItemGrid.DeleteRecord(ADataIntfResult: TDataIntfResult);
begin

end;

function TPageSkinItemGrid.GetSelectedRecordList: ISuperArray;
var
  I: Integer;
begin
  Result:=TSuperArray.Create();
  for I := 0 to Self.Prop.Items.Count-1 do
  begin
    if Self.Prop.Items[I].Selected then
    begin
      Result.O[Result.Length]:=Self.Prop.Items[I].Json;
    end;
  end;
end;

function TPageSkinItemGrid.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting;AFieldControlSettingMap:TObject): Boolean;
var
  I:Integer;
  AItem:TSkinItem;
  ASuperObject:ISuperObject;
//  AJsonItem:TSkinJsonItem;
    //默认列表项的绑定设置的json数组,比如{"ItemCaption":"name"}
    default_list_item_bindings:String;
  APage:TPage;
  AColumn:TSkinItemGridColumn;
  AFieldControlSetting:TFieldControlSetting;
begin
  Result:=Inherited;


  APage:=TPageFieldControlSettingList(ASetting.Collection).FOwner;
  FFieldControlSettingMap:=TFieldControlSettingMap(AFieldControlSettingMap);



  if (TPageFieldControlSetting(ASetting).FPropJson<>nil) then
  begin
  //  //默认列表项的显示风格
  //  default_list_item_style:=AJson.S['default_list_item_style'];
    //默认列表项的绑定设置
    default_list_item_bindings:=TPageFieldControlSetting(ASetting).FPropJson.S['default_list_item_bindings'];


    ASuperObject:=TSuperObject.Create(default_list_item_bindings);
    FDefaultListItemBindings.LoadFromJson(ASuperObject);
  end;




  Self.Prop.Columns.BeginUpdate;
  try
      for I := 0 to APage.MainLayoutControlList.Count-1 do
      begin
        AFieldControlSetting:=APage.MainLayoutControlList[I];
        if (AFieldControlSetting.field_name<>'') and (AFieldControlSetting.col_visible=1) then
        begin
          AColumn:=Self.Prop.Columns.Add;
//          if AColumn=nil then
//          begin
//            //如果列不存在,则创建
//            AColumn:=Self.cxGrid1DBTableView1.CreateColumn;
//            AColumn.DataBinding.FieldName:=AFieldControlSetting.field_name;
////            AColumn.Caption:=AFieldControlSetting.field_caption;
////            AColumn.Width:=AFieldControlSetting.col_width;
////            AColumn.Visible:=True;
//          end;
          AColumn.BindItemFieldName:=AFieldControlSetting.field_name;
//          AColumn.BindDataSourceName:=AFieldControlSetting.data_source_name;


  //        AColumn.Visible:=(AColumnSettingJson.I['visible']=1);
  //        AColumn.Editing:=(AColumnSettingJson.I['readonly']=0);
  //        AColumn.Width:=AColumnSettingJson.I['Width'];
  //        AColumn.Caption:=AColumnSettingJson.S['caption'];

          //
          AColumn.Visible:=(AFieldControlSetting.col_visible=1);
//          AColumn.Editing:=(AFieldControlSetting.readonly=0);
          AColumn.Width:=AFieldControlSetting.col_Width;
          AColumn.Caption:=AFieldControlSetting.field_caption;
        //设置顺序,单独脱离出来,不然这个循环的顺序就不对了
  //      AColumn.Index:=AFieldControlSetting.Index;

//          if AFieldControlSetting.control_type='checkbox' then
//          begin
//            AColumn.PropertiesClass:=TcxCheckBoxProperties;
//            TcxCheckBoxProperties(AColumn.Properties).NullStyle:=nssUnchecked;
//            TcxCheckBoxProperties(AColumn.Properties).ValueChecked:=1;
//          end;



        end;

      end;



      //设置顺序,单独脱离出来
//      AColumn.Index:=AFieldControlSetting.Index;
//      for I := 0 to APage.MainLayoutControlList.Count-1 do
//      begin
//        AFieldControlSetting:=APage.MainLayoutControlList[I];
//        if AFieldControlSetting.col_visible=1 then
//        begin
//          AColumn:=Self.Prop.Columns.Find(AFieldControlSetting.field_name);
//          if AColumn<>nil then
//          begin
//            AColumn.Index:=AFieldControlSetting.Index;
//          end;
//        end;
//
//      end;

  finally
    Self.Prop.Columns.EndUpdate;
  end;



  //给控件设置值
  //判断AValue是否是字符串列表
  Self.Prop.Items.BeginUpdate;
  try
    Self.Prop.Items.Clear();
    for I := 0 to ASetting.FOptionValues.Count - 1 do
    begin

      ASuperObject:=nil;
      if (TFieldControlSettingMap(AFieldControlSettingMap).FOptionsJsonArray<>nil) then
      begin
        ASuperObject:=TFieldControlSettingMap(AFieldControlSettingMap).FOptionsJsonArray.O[I];
      end;
      AItem:=AddSkinItemToListControl(Self,ASuperObject,nil,ASetting.FOptionCaptions[I],ASetting.FOptionValues[I],Self.FDefaultListItemBindings,Self.FFieldControlSettingMap);

//      if (TPageFieldControlSetting(ASetting).FPropJson<>nil)
//        and (TPageFieldControlSetting(ASetting).FPropJson.S['ItemClass']='TSkinJsonItem') then
//      begin
//        AItem:=TSkinJsonItem.Create;
//        Self.Prop.Items.Add(AItem);
//      end
//      else
//      begin
//        AItem:=TSkinItem(Self.Prop.Items.Add);
//        AItem.Caption:=ASetting.FOptionCaptions[I];
//        AItem.Name:=ASetting.FOptionValues[I];
//      end;
//
//      //  AFieldControlSetting.PropJson.S['ItemIconSkinImageListName']:='imgHeadList';
//      //  AFieldControlSetting.PropJson.I['ItemIconDefaultImageIndex']:=0;
//
//      //Item的默认图片，当URL为空的时候
//      if TPageFieldControlSetting(ASetting).PropJson<>nil then
//      begin
//        AItem.Icon.SkinImageListName:=TPageFieldControlSetting(ASetting).PropJson.S['ItemIconSkinImageListName'];
//        if TPageFieldControlSetting(ASetting).PropJson.Contains('ItemIconDefaultImageIndex') then
//        begin
//          AItem.Icon.DefaultImageIndex:=TPageFieldControlSetting(ASetting).PropJson.I['ItemIconDefaultImageIndex'];
//        end;
//
//      end;
//
//      if (TPageFieldControlSetting(ASetting).FOptionsJsonArray<>nil) then
//      begin
//        AItem.Json:=TPageFieldControlSetting(ASetting).FOptionsJsonArray.O[I];
//      end;

    end;

  finally
    Self.Prop.Items.EndUpdate;
  end;


  //加载表格列




  Result:=True;

//  end
//  else
//  begin
//
//      Self.Prop.Items.BeginUpdate;
//      try
//
//        for I := 0 to TPageFieldControlSetting(ASetting).FOptionsJsonArray.Length - 1 do
//        begin
//          AItem:=TSkinItem(Self.Prop.Items.Add);
//          AItem.Caption:=ASetting.FOptionCaptions[I];
//          AItem.Name:=ASetting.FOptionValues[I];
//        end;
//
//      finally
//        Self.Prop.Items.EndUpdate;
//      end;
//
//  end;

end;



{ TPageSkinSelectedListView }


constructor TPageSkinSelectedListView.Create(AOwner: TComponent);
var
  AControlTypeName:String;
  APanel:TPanel;
begin
  inherited;

  APanel:=TPanel.Create(Self);
  APanel.Parent:=Self;

  APanel.Align:={$IFDEF FMX}TAlignLayout.Bottom{$ELSE}alBottom{$ENDIF};
  APanel.Height:=40;
  {$IFDEF VCL}
  APanel.ParentBackground:=False;
  APanel.Color:=WhiteColor;
  APanel.AlignWithMargins:=True;
  APanel.Margins.SetBounds(1,1,1,1);
  APanel.BevelOuter:=TBevelCut.bvNone;
  {$ENDIF}

  FchkSelectedAll:={$IFDEF FMX}TSkinFMXCheckBox{$ELSE}TSkinWinCheckBox{$ENDIF}.Create(Self);
  FchkSelectedAll.Parent:=APanel;//Self;
  {$IFDEF VCL}
  FchkSelectedAll.Align:=alBottom;
  {$ENDIF}
  FchkSelectedAll.Caption:='全选/全不选';
  FchkSelectedAll.Prop.IsAutoChecked:=False;
  FchkSelectedAll.ComponentTypeUseKind:=TComponentTypeUseKind.ctukName;
  FchkSelectedAll.ComponentTypeName:='Color';
  FchkSelectedAll.SkinControlType;

  FchkSelectedAll.MaterialUseKind:=TMaterialUseKind.mukRefByStyleName;
  FchkSelectedAll.MaterialName:='Default';
  {$IFDEF VCL}
  FchkSelectedAll.AlignWithMargins:=True;
  FchkSelectedAll.Margins.SetBounds(9,0,0,0);
  {$ENDIF}

  FchkSelectedAll.Height:=40;

//  FchkSelectedAll.SelfOwnMaterial;
//  FchkSelectedAll.SelfOwnMaterial.Assign(FindGlobalMaterialByStyleName(
//                                                            FchkSelectedAll.Properties.GetComponentClassify,
//                                                            'Default',
//                                                            AControlTypeName
//                                                            ));
//  FchkSelectedAll.SelfOwnMaterial.IsTransparent:=False;
//  FchkSelectedAll.SelfOwnMaterial.BackColor.IsFill:=False;
//  FchkSelectedAll.SelfOwnMaterial.BackColor.FillColor.Color:=WhiteColor;

  FchkSelectedAll.OnClick:=FchkSelectedAllClick;

  Self.OnSelectedItem:=Self.DoSelectedItemChange;

  Self.Prop.FClientMarginBottom:=FchkSelectedAll.Height;

end;

destructor TPageSkinSelectedListView.Destroy;
begin

  inherited;
end;

procedure TPageSkinSelectedListView.DoSelectedItemChange(Sender:TObject;AItem: TSkinItem);
begin
  SyncSelectedStatus;
end;

procedure TPageSkinSelectedListView.FchkSelectedAllClick(Sender: TObject);
var
  I: Integer;
begin
  if FCanSelectedMaxCount=0 then
  begin
      //不限制选择数量
//      if Self.Prop.Items.SelectedCount=Self.Prop.Items.Count then
      if FchkSelectedAll.Prop.Checked then
      begin
        //已经全选了,执行取消全选
        Self.Prop.Items.UnSelectAll;
      end
      else
      begin
        //全选
        Self.Prop.Items.SelectAll;
      end;
  end
  else
  begin
      //限制选择数量

  end;

  SyncSelectedStatus;
end;


function TPageSkinSelectedListView.GetPostValue(ASetting: TFieldControlSetting;
  APageDataDir: String; ASetRecordFieldValueIntf: ISetRecordFieldValue;
  var AErrorMessage: String): Variant;
var
  I:Integer;
  AValue:String;
begin
  AValue:='';

  Self.Prop.Items.BeginUpdate;
  try

    for I := 0 to Self.Prop.Items.Count - 1 do
    begin
      if Self.Prop.Items[I].Selected then
      begin
        if AValue<>'' then
        begin
          AValue:=AValue+',';
        end;
        AValue:=AValue+Self.Prop.Items[I].Name;
      end;
    end;

  finally
    Self.Prop.Items.EndUpdate;
  end;
  Result:=AValue;
end;

function TPageSkinSelectedListView.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting;AFieldControlSettingMap:TObject): Boolean;
var
  I:Integer;
  AItem:TSkinItem;
//  AJsonItem:TSkinJsonItem;
begin
  Result:=Inherited;

//  if TPageFieldControlSetting(ASetting).FOptionsJsonArray=nil then
//  begin




//  //设置选择群成员的列表框
//  Self.Prop.DefaultItemStyle:='IconCaptionLeft_DetailRight';
  Self.SelfOwnMaterialToDefault.DrawItemDevideParam.FillColor.Color:=$EDEDED;
////  Self.SelfOwnMaterialToDefault.DrawItemDevideParam.FillColor.Color:=clRed;
//  Self.Prop.EnableAutoPullDownRefreshPanel:=False;
//  Self.Prop.EnableAutoPullUpLoadMorePanel:=False;
//  Self.Prop.ItemHeight:=32;
//  Self.Prop.ItemWidth:=-1;
//  Self.Prop.ViewType:=lvtList;
////  Self.OnPrepareDrawItem:=GroupMembersListBox_PrepareDrawItem;
////  Self.OnClickItemDesignerPanelChild:=GroupMembersListBox_ClickItemDesignerPanelChild;
//
  Self.Material.BackColor.BorderWidth:=1;
  Self.Material.BackColor.BorderColor.Color:=$00EDEDED;
////  Self.Material.BackColor.BorderColor.Color:=clRed;
////  Self.Prop.VertScrollBarShowType:=TScrollBarShowType.sbstAlwaysCoverShow;
//  Self.Prop.VertScrollBarShowType:=TScrollBarShowType.sbstAlwaysCoverShow;
  Self.VertScrollBar.Material.BackColor.IsFill:=False;


  Result:=True;

//  end
//  else
//  begin
//
//      Self.Prop.Items.BeginUpdate;
//      try
//
//        for I := 0 to TPageFieldControlSetting(ASetting).FOptionsJsonArray.Length - 1 do
//        begin
//          AItem:=TSkinItem(Self.Prop.Items.Add);
//          AItem.Caption:=ASetting.FOptionCaptions[I];
//          AItem.Name:=ASetting.FOptionValues[I];
//        end;
//
//      finally
//        Self.Prop.Items.EndUpdate;
//      end;
//
//  end;


  SyncSelectedStatus;

end;

procedure TPageSkinSelectedListView.SetControlValue(
  ASetting: TFieldControlSetting; APageDataDir, AImageServerUrl: String;
  AValue: Variant; AValueCaption: String;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
var
  I:Integer;
  AValues:TStringList;
begin
  //要去掉继承的
//  inherited;

  AValues:=TStringList.Create;
  Self.Prop.Items.BeginUpdate;
  try
    AValues.CommaText:=AValue;

    for I := 0 to Self.Prop.Items.Count - 1 do
    begin
      Self.Prop.Items[I].Selected:=(AValues.IndexOf(Self.Prop.Items[I].Name)<>-1);
    end;

  finally
    FreeAndNil(AValues);
    Self.Prop.Items.EndUpdate;
  end;


  SyncSelectedStatus;

end;

procedure TPageSkinSelectedListView.SetListControlValue(
  ASetting: TFieldControlSetting; APageDataDir, AImageServerUrl: String;
  AValue: Variant; AValueCaption: String; AValueArray: ISuperArray;
  AValueObject: TObject;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue;
  ALoadDataIntfResult, ALoadDataIntfResult2: TDataIntfResult);
var
  I:Integer;
  AValues:TStringList;
begin

  AValues:=TStringList.Create;
  Self.Prop.Items.BeginUpdate;
  try
    AValues.CommaText:=AValue;

    for I := 0 to Self.Prop.Items.Count - 1 do
    begin
      Self.Prop.Items[I].Selected:=(AValues.IndexOf(Self.Prop.Items[I].Name)<>-1);
    end;

  finally
    FreeAndNil(AValues);
    Self.Prop.Items.EndUpdate;
  end;


  SyncSelectedStatus;

end;

procedure TPageSkinSelectedListView.SyncSelectedStatus;
var
  ACaption:String;
begin
  if FCanSelectedMaxCount=0 then
  begin
      //不限制选择数量
      if (Self.Prop.Items.SelectedCount>0) and (Self.Prop.Items.SelectedCount=Self.Prop.Items.Count) then
      begin
        //已经全选了
//        Self.Caption:='全不选';
        Self.FchkSelectedAll.Prop.Checked:=True;
      end
      else
      begin
        //当前没有全选
//        Self.Caption:='全选';

        //
        Self.FchkSelectedAll.Prop.Checked:=False;
      end;

//      //全不选
//      if (Self.Prop.Items.SelectedCount=0) or (Self.Prop.Items.SelectedCount<=Self.Prop.Items.Count) then
//      begin
//        Self.FchkSelectedAll.Prop.Checked:=False;
//      end;

  end
  else
  begin

  end;
end;

//procedure TPageSkinSelectedListView.SetControlValue(ASetting: TFieldControlSetting;
//  APageDataDir, AImageServerUrl: String; AValue: Variant; AValueCaption: String;
//  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
//var
//  I:Integer;
//  AValues:TStringList;
//begin
//
//  AValues:=TStringList.Create;
//  Self.Prop.Items.BeginUpdate;
//  try
//    AValues.CommaText:=AValue;
//
//    for I := 0 to Self.Prop.Items.Count - 1 do
//    begin
//      Self.Prop.Items[I].Selected:=(AValues.IndexOf(Self.Prop.Items[I].Name)<>-1);
//    end;
//
//  finally
//    FreeAndNil(AValues);
//    Self.Prop.Items.EndUpdate;
//  end;
//
//end;
{ TPagePopupMenu }

constructor TPagePopupMenu.Create(AOwner: TComponent);
begin
  inherited;
  FValues:=TStringList.Create;
end;

destructor TPagePopupMenu.Destroy;
begin
  FreeAndNil(FValues);
  inherited;
end;

procedure TPagePopupMenu.DoMenuItemClick(Sender: TObject);
var
  AMenuItemIndex:Integer;
  AAction:String;
begin
  {$IFDEF VCL}
  //
  AMenuItemIndex:=Self.Items.IndexOf(TMenuItem(Sender));

  //TMenuItem(Sender).Tag;
  AAction:=Self.FValues[AMenuItemIndex];
//  Self.
//  TFieldControlSettingMapList(Self.FFieldControlSettingMap.FSkinListIntf.GetObject).PageInstance.DoCustomPageAction(AAction,nil);
  Self.FFieldControlSettingMap.FOwner.PageInstance.DoCustomPageAction(AAction,nil);
  {$ENDIF}
  {$IFDEF FMX}
  //
  AMenuItemIndex:=TMenuItem(Sender).Index;//Self.Items.IndexOf(TMenuItem(Sender));

  //TMenuItem(Sender).Tag;
  AAction:=Self.FValues[AMenuItemIndex];
//  Self.
//  TFieldControlSettingMapList(Self.FFieldControlSettingMap.FSkinListIntf.GetObject).PageInstance.DoCustomPageAction(AAction,nil);
  Self.FFieldControlSettingMap.FOwner.PageInstance.DoCustomPageAction(AAction,nil);
  {$ENDIF}
end;

procedure TPagePopupMenu.DoReturnFrame(AFromFrame: TFrame);
begin

end;

function TPagePopupMenu.GetPostValue(ASetting: TFieldControlSetting;
  APageDataDir: String; ASetRecordFieldValueIntf: ISetRecordFieldValue;
  var AErrorMessage: String): Variant;
//var
//  AStringList:TStringList;
begin
  Result:='';
//  if Self.ItemIndex=-1 then
//  begin
//    Result:='';
//    Exit;
//  end;
//
//  {$IFDEF FMX}
//  Result:=Self.Items[Self.ItemIndex];
//  {$ENDIF}
//  {$IFDEF VCL}
////      Result:=TPopupMenu(AFieldControlSettingMap.Component).Text;
////  AStringList:=TStringList.Create;
////  try
////    AStringList.CommaText:=ASetting.options_value;
////    Result:=AStringList[Self.ItemIndex];
////  finally
////    FreeAndNil(AStringList);
////  end;
//  Result:=FValues[Self.ItemIndex];
//  {$ENDIF}

end;

//function TPagePopupMenu.GetProp(APropName: String): Variant;
//begin
//
//end;

function TPagePopupMenu.GetPropJsonStr: String;
begin

end;

function TPagePopupMenu.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting;AFieldControlSettingMap:TObject): Boolean;
var
  AMenuItem:TMenuItem;
  ACaptions:TStringList;
  I: Integer;
begin

  FFieldControlSettingMap:=TFieldControlSettingMap(AFieldControlSettingMap);

  //标准控件
//  Self.Items.CommaText:=ASetting.options_caption;
//  Items.Assign(ASetting.FOptionCaptions);
  FValues.Assign(ASetting.FOptionValues);
//  Self.ItemIndex:=-1;


  ACaptions:=TStringList.Create;
  try
    ACaptions.Assign(ASetting.FOptionCaptions);
    for I := 0 to ACaptions.Count-1 do
    begin
      AMenuItem:=TMenuItem.Create(Self);

      {$IFDEF VCL}
      AMenuItem.Caption:=ACaptions[I];
      {$ENDIF}
      {$IFDEF FMX}
      AMenuItem.Text:=ACaptions[I];
      {$ENDIF}

      AMenuItem.OnClick:=Self.DoMenuItemClick;
      AMenuItem.Tag:=I;

      {$IFDEF VCL}
      Self.Items.Add(AMenuItem);
      {$ENDIF}
      {$IFDEF FMX}
      AMenuItem.Parent:=Self;
      {$ENDIF}

    end;

  finally
    FreeAndNil(ACaptions);
  end;


  Result:=True;
end;

procedure TPagePopupMenu.SetControlValue(ASetting: TFieldControlSetting;
  APageDataDir, AImageServerUrl: String; AValue: Variant; AValueCaption: String;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
//var
//  AStringList:TStringList;
begin

//  {$IFDEF FMX}
//  Self.ItemIndex:=Self.Items.IndexOf(AValue);
//  {$ENDIF}
//  {$IFDEF VCL}
//  //TPopupMenu(AFieldControlSettingMap.Component).Text:=AValue;
////  AStringList:=TStringList.Create;
////  try
////    AStringList.CommaText:=ASetting.options_value;
////    Self.ItemIndex:=AStringList.IndexOf(AValue);
////  finally
////    FreeAndNil(AStringList);
////  end;
//    Self.ItemIndex:=FValues.IndexOf(AValue);
//  {$ENDIF}

end;

//procedure TPagePopupMenu.SetProp(APropName: String; APropValue: Variant);
//begin
//
//end;

procedure TPagePopupMenu.SetPropJsonStr(AJsonStr: String);
begin

end;


{$IFDEF VCL}
{ TPageRadioGroup }

constructor TPageRadioGroup.Create(AOwner: TComponent);
begin
  inherited;
  FValues:=TStringList.Create;

end;

destructor TPageRadioGroup.Destroy;
begin
  FreeAndNil(FValues);
  inherited;
end;

function TPageRadioGroup.GetPostValue(ASetting: TFieldControlSetting;
  APageDataDir: String; ASetRecordFieldValueIntf: ISetRecordFieldValue;
  var AErrorMessage: String): Variant;
//var
//  AStringList:TStringList;
begin
  if Self.ItemIndex=-1 then
  begin
    Result:='';
    Exit;
  end;

  {$IFDEF FMX}
  Result:=Self.Items[Self.ItemIndex];
  {$ENDIF}
  {$IFDEF VCL}
//      Result:=TRadioGroup(AFieldControlSettingMap.Component).Text;
//  AStringList:=TStringList.Create;
//  try
//    AStringList.CommaText:=ASetting.options_value;
//    Result:=AStringList[Self.ItemIndex];
//  finally
//    FreeAndNil(AStringList);
//  end;
  Result:=FValues[Self.ItemIndex];
  {$ENDIF}

end;

//function TPageRadioGroup.GetProp(APropName: String): Variant;
//begin
//
//end;

function TPageRadioGroup.GetPropJsonStr: String;
begin

end;

function TPageRadioGroup.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting;AFieldControlSettingMap:TObject): Boolean;
begin
  Self.Caption:=ASetting.field_caption;

  //标准控件
//  Self.Items.CommaText:=ASetting.options_caption;

  Items.Assign(ASetting.FOptionCaptions);
  FValues.Assign(ASetting.FOptionValues);

  Self.ItemIndex:=-1;

  if TPageFieldControlSetting(ASetting).PropJson.I['Columns']>0 then
  begin
    Self.Columns:=TPageFieldControlSetting(ASetting).PropJson.I['Columns'];
  end;

  Result:=True;
end;

procedure TPageRadioGroup.SetControlValue(ASetting: TFieldControlSetting;
  APageDataDir, AImageServerUrl: String; AValue: Variant; AValueCaption: String;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
//var
//  AStringList:TStringList;
begin
  {$IFDEF FMX}
  Self.ItemIndex:=Self.Items.IndexOf(AValue);
  {$ENDIF}
  {$IFDEF VCL}
  //TRadioGroup(AFieldControlSettingMap.Component).Text:=AValue;
//  AStringList:=TStringList.Create;
//  try
//    AStringList.CommaText:=ASetting.options_value;
//    Self.ItemIndex:=AStringList.IndexOf(AValue);
//  finally
//    FreeAndNil(AStringList);
//  end;
    Self.ItemIndex:=FValues.IndexOf(AValue);
  {$ENDIF}

end;

//procedure TPageRadioGroup.SetProp(APropName: String; APropValue: Variant);
//begin
//
//end;

procedure TPageRadioGroup.SetPropJsonStr(AJsonStr: String);
begin

end;

procedure TPageRadioGroup.DoReturnFrame(AFromFrame:TFrame);
begin

end;





{ TPageCheckListBox }

function TPageCheckListBox.GetPostValue(ASetting: TFieldControlSetting;
  APageDataDir: String; ASetRecordFieldValueIntf: ISetRecordFieldValue;
  var AErrorMessage: String): Variant;
var
  I:Integer;
  AValue:String;
begin
  AValue:='';

  Self.Items.BeginUpdate;
  try

    for I := 0 to Self.Items.Count - 1 do
    begin
      if Self.Checked[I] then
      begin
        if AValue<>'' then
        begin
          AValue:=AValue+',';
        end;
        AValue:=AValue+ASetting.FOptionValues[I];
      end;
    end;

  finally
    Self.Items.EndUpdate;
  end;
  Result:=AValue;


end;

function TPageCheckListBox.GetPropJsonStr: String;
begin

end;

function TPageCheckListBox.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting; AFieldControlSettingMap: TObject): Boolean;
var
  I:Integer;
//  AJsonItem:TSkinJsonItem;
begin
  Result:=False;

//  if TPageFieldControlSetting(ASetting).FOptionsJsonArray=nil then
//  begin

  //给控件设置值
  //判断AValue是否是字符串列表
  Self.Items.BeginUpdate;
  try
    Items.Clear;
    for I := 0 to ASetting.FOptionValues.Count - 1 do
    begin
      Self.Items.Add(ASetting.FOptionCaptions[I]);
    end;

  finally
    Self.Items.EndUpdate;
  end;

  Result:=True;

//  end
//  else
//  begin
//
//      Self.Prop.Items.BeginUpdate;
//      try
//
//        for I := 0 to TPageFieldControlSetting(ASetting).FOptionsJsonArray.Length - 1 do
//        begin
//          AItem:=TSkinItem(Self.Prop.Items.Add);
//          AItem.Caption:=ASetting.FOptionCaptions[I];
//          AItem.Name:=ASetting.FOptionValues[I];
//        end;
//
//      finally
//        Self.Prop.Items.EndUpdate;
//      end;
//
//  end;


end;

procedure TPageCheckListBox.SetControlValue(ASetting: TFieldControlSetting;
  APageDataDir, AImageServerUrl: String; AValue: Variant; AValueCaption: String;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
var
  I:Integer;
  AValues:TStringList;
begin

  AValues:=TStringList.Create;
  Self.Items.BeginUpdate;
  try
    AValues.CommaText:=AValue;

    for I := 0 to Self.Items.Count - 1 do
    begin
      Self.Checked[I]:=(AValues.IndexOf(ASetting.FOptionValues[I])<>-1);
    end;

  finally
    FreeAndNil(AValues);
    Self.Items.EndUpdate;
  end;

end;

procedure TPageCheckListBox.SetPropJsonStr(AJsonStr: String);
begin

end;

procedure TPageCheckListBox.DoReturnFrame(AFromFrame:TFrame);
begin

end;


{$ENDIF}

{ TPageSelectDateAreaButton }

procedure TPageSelectDateAreaButton.Click;
var
  AIsProcessed:Boolean;
  ASuperObject:ISuperObject;
begin
  inherited;
  //跳转到选择日期范围的页面
  //GlobalMainProgramSetting.ShowPage();
  AIsProcessed:=False;
  ASuperObject:=TSuperObject.Create();
//  ASuperObject.S['StartDate']:=FormatDateTime('YYYY-MM-DD',FStartDate);
//  ASuperObject.S['EndDate']:=FormatDateTime('YYYY-MM-DD',FEndDate);
  ASuperObject.S['StartDate']:=FStartDate;
  ASuperObject.S['EndDate']:=FEndDate;
  FFieldControlSettingMap.FValue:=ASuperObject.AsJSON;
  GlobalMainProgramSetting.DoCustomProcessPageAction(Self,
                                                      nil,
                                                      'select_date_area',
                                                      FFieldControlSettingMap,
                                                      AIsProcessed
                                                      );
end;

procedure TPageSelectDateAreaButton.DoReturnFrame(AFromFrame: TFrame);
var
  APageSavedValueIntf:IPageSavedValue;
begin
  //inherited;
  //找到PageInstance,从PageInstance中获取值
  if not AFromFrame.GetInterface(IID_IPageSavedValue,APageSavedValueIntf) then
  begin
    raise Exception.Create('AFromFrame is not support IPageSavedValue');
  end;

  SetControlValue(nil,'','',APageSavedValueIntf.GetSavedValue.AsJSON,'',nil);
  Self.FFieldControlSettingMap.Value:=APageSavedValueIntf.GetSavedValue.AsJSON;
end;

function TPageSelectDateAreaButton.GetPostValue(ASetting: TFieldControlSetting;
  APageDataDir: String; ASetRecordFieldValueIntf: ISetRecordFieldValue;
  var AErrorMessage: String): Variant;
begin
  Result:=FStartDate;

  if (ASetRecordFieldValueIntf<>nil) and (ASetting.other_field_names<>'') then
  begin
    ASetRecordFieldValueIntf.SetFieldValue(ASetting.other_field_names,FEndDate);
  end;
end;

function TPageSelectDateAreaButton.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting; AFieldControlSettingMap: TObject): Boolean;
begin
  Inherited;
  FFieldControlSettingMap:=TFieldControlSettingMap(AFieldControlSettingMap);



end;

procedure TPageSelectDateAreaButton.SetControlValue(
  ASetting: TFieldControlSetting; APageDataDir, AImageServerUrl: String;
  AValue: Variant; AValueCaption: String;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
var
  ASuperObject:ISuperObject;
begin
  ASuperObject:=TSuperObject.Create(AValue);


//  StartDate:=StdStrToDate(ASuperObject.S['StartDate']);
//  EndDate:=StdStrToDate(ASuperObject.S['EndDate']);

  StartDate:=ASuperObject.S['StartDate'];
  EndDate:=ASuperObject.S['EndDate'];

end;



initialization

  {$IFDEF FMX}
  GetGlobalFrameworkComponentTypeClasses.Add('button',TSkinButton,'按钮');
  GetGlobalFrameworkComponentTypeClasses.Add('label',TSkinLabel,'文本');
  GetGlobalFrameworkComponentTypeClasses.Add('panel',TSkinPanel,'面板');
  GetGlobalFrameworkComponentTypeClasses.Add('image',TSkinImage,'图片');
  GetGlobalFrameworkComponentTypeClasses.Add('item_designer_panel',TSkinItemDesignerPanel,'列表项设计面板');
  GetGlobalFrameworkComponentTypeClasses.Add('checkbox',TSkinCheckBox,'复选框');
  GetGlobalFrameworkComponentTypeClasses.Add('radio_button',TSkinRadioButton,'单选框');

  GetGlobalFrameworkComponentTypeClasses.Add('edit',TSkinEdit,'编辑框');
  GetGlobalFrameworkComponentTypeClasses.Add('memo',TSkinMemo,'备注框');
  GetGlobalFrameworkComponentTypeClasses.Add('roll_label',TSkinRollLabel,'滑动文本');
  GetGlobalFrameworkComponentTypeClasses.Add('test_component',TComponent,'测试组件');
  GetGlobalFrameworkComponentTypeClasses.Add('dateedit',TSkinDateEdit,'日期框');
  GetGlobalFrameworkComponentTypeClasses.Add('timeedit',TSkinTimeEdit,'时间框');
  {$ENDIF}



  {$IFDEF VCL}
  GetGlobalFrameworkComponentTypeClasses.Add('button',TSkinButton,'按钮');
  GetGlobalFrameworkComponentTypeClasses.Add('label',TSkinLabel,'文本');
  GetGlobalFrameworkComponentTypeClasses.Add('panel',TSkinPanel,'面板');
  GetGlobalFrameworkComponentTypeClasses.Add('image',TSkinImage,'图片');
  GetGlobalFrameworkComponentTypeClasses.Add('item_designer_panel',TSkinItemDesignerPanel,'列表项设计面板');
  GetGlobalFrameworkComponentTypeClasses.Add('listview',TPageSkinListView,'列表视图');
  GetGlobalFrameworkComponentTypeClasses.Add('checkbox',TPageCheckBox,'复选框');
  GetGlobalFrameworkComponentTypeClasses.Add('radio_button',TSkinRadioButton,'单选框');

//  GetGlobalFrameworkComponentTypeClasses.Add('edit',TSkinEdit,'编辑框');
//  GetGlobalFrameworkComponentTypeClasses.Add('memo',TSkinMemo,'备注框');

//  GetGlobalFrameworkComponentTypeClasses.Add('edit',TSkinEdit,'编辑框');
//  GetGlobalFrameworkComponentTypeClasses.Add('memo',TSkinMemo,'备注框');

  GetGlobalFrameworkComponentTypeClasses.Add('edit',TPageEdit,'编辑框');
  GetGlobalFrameworkComponentTypeClasses.Add('memo',TPageMemo,'备注框');

  GetGlobalFrameworkComponentTypeClasses.Add('roll_label',TSkinRollLabel,'滑动文本');
  GetGlobalFrameworkComponentTypeClasses.Add('test_component',TComponent,'测试组件');
//  GetGlobalFrameworkComponentTypeClasses.Add('dateedit',TSkinDateEdit,'日期框');
//  GetGlobalFrameworkComponentTypeClasses.Add('timeedit',TSkinTimeEdit,'时间框');
//  GetGlobalFrameworkComponentTypeClasses.Add('combobox',TSkinComboBox,'下拉框');
  GetGlobalFrameworkComponentTypeClasses.Add('combobox',TPageComboBox,'下拉框');
  GetGlobalFrameworkComponentTypeClasses.Add('radio_group',TPageRadioGroup,'分组单选框');
//  GetGlobalFrameworkComponentTypeClasses.Add('comboedit',TSkinComboEdit,'下拉编辑框');
//  GetGlobalFrameworkComponentTypeClasses.Add('listbox',TSkinListBox,'列表框');//统一使用ListView
  GetGlobalFrameworkComponentTypeClasses.Add('check_listbox',TPageCheckListBox,'可勾选列表');
  {$ENDIF}

//  GetGlobalFrameworkComponentTypeClasses.Add('listitem',TSkinRealSkinItemComponent,'列表项');
//  GetGlobalFrameworkComponentTypeClasses.Add('regex_tag_label_view',TSkinRegExTagLabelView,'正则表达式标签文本');

//  GetGlobalFrameworkComponentTypeClasses.Add('list_page',TSkinComboEdit,'下拉编辑框');
//  GetGlobalFrameworkComponentTypeClasses.Add('button_group',TSkinButtonGroup);
//  GetGlobalFrameworkComponentTypeClasses.Add('multi_color_label',TSkinMultiColorLabel);
//  GetGlobalFrameworkComponentTypeClasses.Add('Switch',TSkinSwitch);
//  GetGlobalFrameworkComponentTypeClasses.Add('DrawPanel',TSkinDrawPanel);
//  GetGlobalFrameworkComponentTypeClasses.Add('RoundRect',TSkinRoundRect);
//  GetGlobalFrameworkComponentTypeClasses.Add('TabSheet',TSkinTabSheet);
//  GetGlobalFrameworkComponentTypeClasses.Add('PageControl',TSkinPageControl);
//  GetGlobalFrameworkComponentTypeClasses.Add('TrackBar',TSkinTrackBar);
//  GetGlobalFrameworkComponentTypeClasses.Add('SwitchBar',TSkinSwitchBar);
//  GetGlobalFrameworkComponentTypeClasses.Add('ProgressBar',TSkinProgressBar);
//  GetGlobalFrameworkComponentTypeClasses.Add('ScrollBar',TSkinScrollBar);
//  GetGlobalFrameworkComponentTypeClasses.Add('ScrollBox',TSkinScrollBox);
//  GetGlobalFrameworkComponentTypeClasses.Add('SwitchPageListPanel',TSkinSwitchPageListPanel);
//  GetGlobalFrameworkComponentTypeClasses.Add('NotifyNumberIcon',TSkinNotifyNumberIcon);
//  GetGlobalFrameworkComponentTypeClasses.Add('FrameImage',TSkinFrameImage);
//  GetGlobalFrameworkComponentTypeClasses.Add('RoundImage',TSkinRoundImage);
//  GetGlobalFrameworkComponentTypeClasses.Add('ImageListPlayer',TSkinImageListPlayer);
//  GetGlobalFrameworkComponentTypeClasses.Add('ImageListViewer',TSkinImageListViewer);
//  GetGlobalFrameworkComponentTypeClasses.Add('treeview',TSkinTreeView);
//  GetGlobalFrameworkComponentTypeClasses.Add('itemgrid',TSkinItemGrid);
//  GetGlobalFrameworkComponentTypeClasses.Add('dbgrid',TSkinDBGrid);
  GetGlobalFrameworkComponentTypeClasses.Add('chart',TSkinVirtualChart,'图表');





  GetGlobalFrameworkComponentTypeClasses.Add('listview',TPageSkinListView,'列表视图');
  GetGlobalFrameworkComponentTypeClasses.Add('combobox',TPageComboBox,'下拉框');
  GetGlobalFrameworkComponentTypeClasses.Add('itemgrid',TPageSkinItemGrid,'表格');
  GetGlobalFrameworkComponentTypeClasses.Add('selected_listview',TPageSkinSelectedListView,'可选列表视图');
  GetGlobalFrameworkComponentTypeClasses.Add('popupmenu',TPagePopupMenu,'弹出菜单');
  GetGlobalFrameworkComponentTypeClasses.Add('select_date_area_button',TPageSelectDateAreaButton,'选择日期范围按钮');



end.
