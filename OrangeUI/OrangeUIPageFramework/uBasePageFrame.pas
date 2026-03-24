unit uBasePageFrame;

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
  SysUtils, Variants, Classes,

  {$IFDEF FMX}
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.ExtCtrls,
  FMX.Dialogs,
  UITypes,
  FMX.Types,
  EasyServiceCommonMaterialDataMoudle,
  {$ENDIF}

  {$IFDEF VCL}
  Messages,
  Windows,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  Dialogs,
  EasyServiceCommonMaterialDataMoudle_VCL,
  {$ENDIF}
  Math,

  uFrameContext,
  uComponentType,
  uFuncCommon,
    {$IFDEF SKIN_SUPEROBJECT}
    uSkinSuperObject,
    uSkinSuperJson,
    {$ELSE}
    XSuperObject,
    XSuperJson,
    {$ENDIF}
  uRestInterfaceCall,
//  uManager,
  uDatasetToJson,
//  uJsonToDataset,
  uOpenClientCommon,
  uOpenCommon,
  uTimerTask,
  uGraphicCommon,
  uUIFunction,
  uPageInstance,
//  SelectPopupForm,

//  GridSwitchPageFrame,

  uPageStructure,
  uBasePageStructure,
  uDataInterface,
  BasePageFrame,

  uSkinScrollBoxType,
  uSkinScrollControlType,
  uSkinScrollBoxContentType,
  uSkinButtonType;

type
  TFrameBaseBasePage={$IFDEF FMX}TFrameBaseFMXPage{$ENDIF}{$IFDEF VCL}TFrameBaseVCLPage{$ENDIF};
  TFrameBasePage = class(TFrameBaseBasePage,IFrameHistroyReturnEvent,IPageFrameworkFrame)
    //前面不能加修饰，什么private,public,protected
    procedure FrameResize(Sender: TObject);override;
    { Private declarations }
  protected
    function GetPageInstance:TPageInstance;
    //可以覆盖创建自己的TPage
    function CreatePage:TPage;virtual;
    //可以覆盖创建自己的TPageInstance
    function CreatePageInstance:TPageInstance;virtual;

    //初始页面这个数据结构
    procedure InitPage(APage:uPageStructure.TPage);virtual;

    //是否可以返回上一个Frame
    function CanReturn:TFrameReturnActionType;

    procedure Init;
  protected
    //获取创建子控件的父控件
    function GetPagePartLayoutParent(APagePart:String):TControl;virtual;
    procedure DoPagePartLayoutParentResize(Sender:TObject);


    //自定义初始结束,在这里可以访问控件
    procedure CustomAfterLoad;virtual;

    //自定义初始控件,比如ListView
    procedure CustomInitFieldControl(AControl:TComponent;AFieldControlSettingMap:TFieldControlSettingMap);virtual;

    //页面保存结束事件
    procedure DoPageInstanceAfterSaveRecord(Sender:TObject);virtual;
    procedure DoPageInstanceCancelAddRecord(Sender:TObject);virtual;
    procedure DoPageInstanceCancelEditRecord(Sender:TObject);virtual;

    //页面调用加载数据接口结束
    procedure DoPageInstanceLoadDataTaskEnd(Sender:TObject;
                                   APageInstance:TPageInstance;
                                   ADataIntfResult: TDataIntfResult;
                                   ADataIntfResult2: TDataIntfResult);virtual;
    //页面加载数据到控件结束
    procedure DoPageInstanceLoadDataToControlsEnd(Sender:TObject;AFieldControlSettingMapList:TFieldControlSettingMapList);virtual;
    //自定义提交的Json
    procedure DoPageInstanceCustomPostDataJson(Sender:TObject;APostDataJson:ISuperObject);virtual;


    //页面保存时自定义获取控件的值的事件
    procedure DoPageInstanceCustomGetFieldControlPostValue(Sender:TObject;
                                            AFieldControlSettingMap:TFieldControlSettingMap;
                                            APageDataDir:String;
                                            ASetRecordFieldValueIntf:ISetRecordFieldValue;
                                            var AValue:Variant;
                                            var AErrorMessage:String);virtual;
    //处理页面实例自己的Action
    procedure DoPageInstanceCustomProcessPageActionEvent(Sender:TObject;
                                            AFromPageInstance:TPageInstance;
                                            AAction:String;
                                            AFieldControlSettingMap:TFieldControlSettingMap;
                                            var AIsProcessed:Boolean);virtual;

  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public

    //页面控件列表
    FPage:uPageStructure.TPage;
    FPageIsSelfOwn:Boolean;

    FPageInstance:TPageInstance;

    FOnPageInstanceAfterSaveRecord:TNotifyEvent;
    FOnPageInstanceCancelAddRecord:TNotifyEvent;
    FOnPageInstanceCancelEditRecord:TNotifyEvent;
    FOnPageInstanceCustomPostDataJson:TCustomPostDataJsonEvent;

    procedure LoadPage(APage:TPage;AFromPageInstance:TPageInstance);overload;

    property PageInstance:TPageInstance read FPageInstance;
  public
    procedure DoPageStructureLoaded(Sender:TObject);
    procedure LoadPage(APageName:String);overload;
    { Public declarations }
  end;



  TFrameBaseListPage=class(TFrameBasePage)
  protected
    function CreatePageInstance:TPageInstance;override;
    procedure CustomAfterLoad;override;
  end;

  //带滚动功能
  TFrameBaseScrollPage=class(TFrameBasePage)
    //前面不能加修饰，什么private,public,protected
    procedure FrameResize(Sender: TObject);override;
  private
    { Private declarations }
  protected
//    //初始页面这个数据结构
//    procedure InitPage(APage:uPageStructure.TPage);override;
    //获取创建子控件的父控件
    function GetPagePartLayoutParent(APagePart:String):TControl;override;
    procedure CustomAfterLoad;override;
  public
    {$IFDEF VCL}
    procedure sbHomeMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure sbHomeMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    {$ENDIF}
  public
    {$IFDEF VCL}
    sbClient: TScrollBox;
    {$ENDIF}
//    {$IFDEF FMX}
//    sbClient: TSkinScrollBox;
//    sbcContent:TSkinScrollBoxContent;
//    {$ENDIF}
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;

  TFrameBaseEditPage=class(TFrameBaseScrollPage)

  end;

  TFrameBaseViewPage=class(TFrameBaseScrollPage)

  end;



implementation

//{$R *.dfm}


//procedure TFrameBasePage.btnCancelClick(Sender: TObject);
//begin
//  //取消
//  if Self.FPageInstance.FLoadDataSetting.IsAddRecord then
//  begin
//    Self.FPageInstance.CancelAddRecord;
//  end;
//  if Self.FPageInstance.FLoadDataSetting.IsEditRecord then
//  begin
//    Self.FPageInstance.CancelEditRecord;
//  end;
//
//  SyncButtonState;
//end;
//
//procedure TFrameBasePage.btnEditClick(Sender: TObject);
//begin
////  //编辑记录
////  Self.FPageInstance.FLoadDataSetting.IsAddRecord:=False;
////  Self.FPageInstance.FLoadDataSetting.IsEditRecord:=True;
////
//////  Self.FPageInstance.MainControlMapList.ClearValue;
//
//  Self.FPageInstance.BeginEditRecord();
//
//  SyncButtonState;
//
//end;
//
//procedure TFrameBasePage.btnNewClick(Sender: TObject);
//begin
//
////  Self.FPageInstance.FLoadDataSetting.IsAddRecord:=True;
////  Self.FPageInstance.MainControlMapList.ClearValue;
//  Self.FPageInstance.BeginAddRecord();
//
//  SyncButtonState;
//end;
//
//procedure TFrameBasePage.btnSaveClick(Sender: TObject);
//begin
////  //保存添加/修改
////  Self.FPageInstance.DoSaveRecordAction(False);
////
////  Self.FPageInstance.FLoadDataSetting.IsAddRecord:=False;
////  Self.FPageInstance.FLoadDataSetting.IsEditRecord:=False;
////
//
//  Self.FPageInstance.SaveRecord;
//
//  SyncButtonState;
//end;

function TFrameBasePage.CanReturn: TFrameReturnActionType;
begin
  Result:=TFrameReturnActionType.fratReturnAndFree;
end;

constructor TFrameBasePage.Create(AOwner: TComponent);
begin
  inherited;

  SetFrameName(Self);

  //GlobalMainProgramSetting.AppID:=AppID;



  //页面控件列表
  FPage:=CreatePage;
  FPageIsSelfOwn:=True;


  //页面实例
  FPageInstance:=CreatePageInstance;
  FPageInstance.PageStructure:=FPage;
  //自定义控件
  FPageInstance.FOnCustomInitFieldControl:=Self.CustomInitFieldControl;
//  FPageInstance.OnLoadDataTaskEnd:=DoLoadDataTaskEnd;
  //保存记录之后,需要刷新数据,需要添加数据到原列表等
  Self.FPageInstance.FOnAfterSaveRecord:=DoPageInstanceAfterSaveRecord;
  Self.FPageInstance.FOnCancelAddRecord:=DoPageInstanceCancelAddRecord;
  Self.FPageInstance.FOnCancelEditRecord:=DoPageInstanceCancelEditRecord;
  Self.FPageInstance.FOnCustomGetFieldControlPostValue:=DoPageInstanceCustomGetFieldControlPostValue;
  Self.FPageInstance.FOnCustomProcessPageAction:=DoPageInstanceCustomProcessPageActionEvent;

  Self.FPageInstance.OnLoadDataTaskEnd:=DoPageInstanceLoadDataTaskEnd;
  Self.FPageInstance.FonLoadDataToControlsEnd:=DoPageInstanceLoadDataToControlsEnd;
  Self.FPageInstance.FOnCustomPostDataJson:=DoPageInstanceCustomPostDataJson;


//  Self.pnlBottombar.Height:=ScreenScaleSizeInt(Self.pnlBottombar.Height);

end;


function TFrameBasePage.CreatePage: TPage;
begin
  Result:=uPageStructure.TPage.Create(nil);
end;

function TFrameBasePage.CreatePageInstance: TPageInstance;
begin
  Result:=TPageInstance.Create(Self);
end;

destructor TFrameBasePage.Destroy;
begin
  if FPageIsSelfOwn then
  begin
    FreeAndNil(FPage);
  end;
  FreeAndNil(FPageInstance);
  inherited;
end;

procedure TFrameBasePage.DoPageInstanceCustomGetFieldControlPostValue(Sender: TObject;
  AFieldControlSettingMap: TFieldControlSettingMap; APageDataDir: String;
  ASetRecordFieldValueIntf: ISetRecordFieldValue; var AValue: Variant;
  var AErrorMessage: String);
begin

end;

procedure TFrameBasePage.DoPageInstanceCustomPostDataJson(Sender: TObject;
  APostDataJson: ISuperObject);
begin
  if Assigned(FOnPageInstanceCustomPostDataJson) then
  begin
    FOnPageInstanceCustomPostDataJson(Sender,APostDataJson);
  end;
end;

procedure TFrameBasePage.DoPageInstanceCustomProcessPageActionEvent(
  Sender: TObject; AFromPageInstance: TPageInstance; AAction: String; AFieldControlSettingMap:TFieldControlSettingMap;
  var AIsProcessed: Boolean);
begin

end;

procedure TFrameBasePage.DoPageInstanceLoadDataTaskEnd(Sender: TObject;
                                   APageInstance:TPageInstance;
                                   ADataIntfResult: TDataIntfResult;
                                   ADataIntfResult2: TDataIntfResult);
begin
  //
end;

procedure TFrameBasePage.DoPageInstanceLoadDataToControlsEnd(Sender: TObject;
  AFieldControlSettingMapList: TFieldControlSettingMapList);
begin

end;

procedure TFrameBasePage.DoPagePartLayoutParentResize(Sender: TObject);
var
  APagePart:TFieldControlSettingMapList;
begin
//      FPageInstance.FPagePartList[I].AlignControls();
  if FPageInstance<>nil then
  begin
    APagePart:=FPageInstance.FPagePartList.FindByParent(Sender);
    if APagePart<>nil then
    begin
      APagePart.AlignControls;
    end;

  end;

end;

procedure TFrameBasePage.DoPageStructureLoaded(Sender:TObject);
begin
  InitPage(FPage);
  LoadPage(FPage,nil);
end;

procedure TFrameBasePage.DoPageInstanceAfterSaveRecord(Sender: TObject);
begin
  //
  if Assigned(FOnPageInstanceAfterSaveRecord) then
  begin
    FOnPageInstanceAfterSaveRecord(Self);
  end;
end;

procedure TFrameBasePage.DoPageInstanceCancelAddRecord(Sender: TObject);
begin
  if Assigned(FOnPageInstanceCancelAddRecord) then
  begin
    FOnPageInstanceCancelAddRecord(Self);
  end;

end;

procedure TFrameBasePage.DoPageInstanceCancelEditRecord(Sender: TObject);
begin
  if Assigned(FOnPageInstanceCancelEditRecord) then
  begin
    FOnPageInstanceCancelEditRecord(Self);
  end;

end;

//function TFrameBasePage.CustomGetRestDatasetPageCustomWhereKeyJson: String;
//begin
//  Result:='';
//end;

procedure TFrameBasePage.CustomInitFieldControl(AControl: TComponent;
  AFieldControlSettingMap: TFieldControlSettingMap);
begin

end;

procedure TFrameBasePage.CustomAfterLoad;
begin
end;

//procedure TFrameBasePage.FormKeyDown(Sender: TObject; var Key: Word;
//  Shift: TShiftState);
//begin
//  inherited;
//
//  if Key=13 then
//  begin
//
////    //如果有选中,按回车表示确定选中
////    if Assigned(OnSelectRecord) then
////    begin
////      OnSelectRecord(Sender,Self.RestMemTable1);
////    end;
////
////    HidePopup;
//
//
//      Key:=0;
//  end;
//end;

procedure TFrameBasePage.FrameResize(Sender: TObject);
//var
//  I: Integer;
begin
//  if FPageInstance<>nil then
//  begin
//    for I := 0 to FPageInstance.FPagePartList.Count-1 do
//    begin
//      FPageInstance.FPagePartList[I].AlignControls();
//    end;
//  end;

end;

//function TFrameBasePage.GetBottomToolbarLayoutParent: TControl;
//begin
//  Result:=Self.pnlBottombar;
//end;

//function TFrameBasePage.GetBottomToolbarLayoutParentMarginsTop: Double;
//begin
//
//end;

//function TFrameBasePage.GetLoadDataCustomKeyJsonStr: String;
//begin
//  Result:='';
////  Result:=FWhereKeyJsonStr;
//end;

function TFrameBasePage.GetPageInstance: TPageInstance;
begin
  Result:=FPageInstance;
end;

function TFrameBasePage.GetPagePartLayoutParent(APagePart:String): TControl;
begin
  if APagePart=Const_PagePart_BottomToolbar then
  begin
    Result:=Self.pnlBottombar;
  end
  else if APagePart=Const_PagePart_TopToolbar then
  begin
    Result:=Self.pnlToolbar;
  end
  else if (APagePart=Const_PagePart_Main) or (APagePart='main') then
  begin
    Result:=Self.pnlClient;
  end
  else
  begin
    raise Exception.Create('不存在PagePart为'+APagePart+'的父控件');
  end;
end;

//function TFrameBasePage.GetTopToolbarLayoutParent: TControl;
//begin
//  Result:=Self.pnlToolbar;
//end;

//function TFrameBasePage.GetMainLayoutParentMarginsTop: Double;
//begin
//  Result:=0;
//end;

procedure TFrameBasePage.InitPage(APage:uPageStructure.TPage);
begin

//  //初始页面结构
//  FPage.page_type:=Const_PageType_ListPage;




end;

procedure TFrameBasePage.LoadPage(APageName:String);
begin
  Self.FPage.OnLoaded:=DoPageStructureLoaded;
  Self.FPage.Name:=APageName;
  Self.FPage.StartLoadPageStructureThread;
end;

//procedure TFrameBasePage.InitPageEnd(APage: uPageStructure.TPage);
//begin
//
//end;
type
  TProtectedControl=class(TControl)

  end;

procedure TFrameBasePage.LoadPage(APage: TPage;AFromPageInstance:TPageInstance);
var
  ADesc:String;
  I: Integer;
  ALayoutSetting:TLayoutSetting;
  APagePartLayoutParent:TControl;
  APagePart:TFieldControlSettingMapList;
begin
  if FPage<>APage then
  begin
    FPageIsSelfOwn:=False;
    FreeAndNil(FPage);
    FPage:=APage;
    FPageInstance.PageStructure:=FPage;
  end;

  FPageInstance.FFromPageInstance:=AFromPageInstance;
  {$IFDEF FMX}
  Self.pnlToolBar.Caption:=APage.caption;
  {$ENDIF}



  //控件列表加载结束事件
  if not FPage.IsLoaded then FPage.LoadLayoutControlListEnd;


  for I := 0 to Self.FPage.FLayoutSettingList.Count-1 do
  begin
    ALayoutSetting:=Self.FPage.FLayoutSettingList[I];
    APagePartLayoutParent:=Self.GetPagePartLayoutParent(ALayoutSetting.name);
    TProtectedControl(APagePartLayoutParent).OnResize:=Self.DoPagePartLayoutParentResize;
    //创建输入区控件
    if not Self.FPageInstance.CreateControls(Self,TParentControl(APagePartLayoutParent),ALayoutSetting.name,'',False,ADesc,True) then
    begin
      ShowMessage(ADesc);
      Exit;
    end;
    APagePart:=Self.FPageInstance.FPagePartList.Find(ALayoutSetting.name);
    APagePart.AlignControls();

    {$IFDEF FMX}
      //在FMX下面，如果pnlToolbar里面没有控件，那还是需要显示的
    if not SameText(ALayoutSetting.name,Const_PagePart_TopToolbar) then
    {$ENDIF}
      //在VCL下面，如果pnlToolbar里面没有控件，那就隐藏
      TParentControl(APagePartLayoutParent).Visible:=
            (APagePart.FLayoutList.FListLayoutsManager.GetVisibleItemsCount>0);

    if ALayoutSetting.align<>'' then
    begin
      TParentControl(APagePartLayoutParent).Align:=uGraphicCommon.GetAlign(ALayoutSetting.align);
    end;


  end;

//  //创建输入区控件
//  if not Self.FPageInstance.CreateControls(Self,TWinControl(GetMainLayoutParent),Const_PagePart_Main,'',False,ADesc,True) then
//  begin
//    ShowMessage(ADesc);
//    Exit;
//  end;
//  FPageInstance.MainControlMapList.AlignControls();
//
//
//
//  //创建底部工具栏控件
//  if not Self.FPageInstance.CreateControls(Self,TWinControl(GetBottomToolbarLayoutParent),Const_PagePart_BottomToolbar,'',False,ADesc,True) then
//  begin
//    ShowMessage(ADesc);
//    Exit;
//  end;
//  FPageInstance.BottomToolbarControlMapList.AlignControls();
//
//
//
//  //创建顶部工具栏控件
//  if not Self.FPageInstance.CreateControls(Self,TWinControl(GetTopToolbarLayoutParent),Const_PagePart_TopToolbar,'',False,ADesc,True) then
//  begin
//    ShowMessage(ADesc);
//    Exit;
//  end;
//  FPageInstance.TopToolbarControlMapList.AlignControls();


  //初始其他
  Self.CustomAfterLoad;





  Self.FPageInstance.SyncButtonState;

//  Self.SyncButtonState;

end;

//procedure TFrameBasePage.SetPageName(const Value: String);
//begin
//  if FPageName<>Value then
//  begin
//    FPageName := Value;
//    FPage.Name:=FPageName;
//  end;
//end;

procedure TFrameBasePage.Init;//(ACaption:String;AHasAppID:Boolean;
//                                  ARestName: String;
//                                  AWhereKeyJsonStr:String;
//                                  AKeyFieldName:String;
//                                  ADeletedFieldName:String;
//                                  AColumnsSettingArray:ISuperArray;
//                                  APage:TPage);
var
  ADesc:String;
//var
//  I: Integer;
////  AColumnSettingJson:ISuperObject;
//  AFieldControlSetting:TFieldControlSetting;
begin

//  Caption:=ACaption;
//
//  FHasAppID:=AHasAppID;
//  FRestName:=ARestName;
//  FWhereKeyJsonStr:=AWhereKeyJsonStr;
//  FKeyFieldName:=AKeyFieldName;
//  FDeletedFieldName:=ADeletedFieldName;
//  FColumnsSettingArray:=AColumnsSettingArray;



  //初始页面结构
  InitPage(FPage);

//  FPage.DelayLoad;

  //MainLayoutControlList.LoadFromJson后面
  //控件列表加载结束事件
//  FPage.LoadLayoutControlListEnd;


//  InitPageEnd(FPage);


  LoadPage(FPage,nil);

end;

//procedure TFrameBasePage.SyncButtonState;
//begin
//
////  Self.btnNew.Enabled:=not (Self.FPageInstance.FLoadDataSetting.IsAddRecord or Self.FPageInstance.FLoadDataSetting.IsEditRecord);
////
////  Self.btnEdit.Enabled:=not (Self.FPageInstance.FLoadDataSetting.IsAddRecord or Self.FPageInstance.FLoadDataSetting.IsEditRecord);
////
////  Self.btnSave.Enabled:=Self.FPageInstance.FLoadDataSetting.IsAddRecord
////                        or Self.FPageInstance.FLoadDataSetting.IsEditRecord;
////
////  Self.btnCancel.Enabled:=Self.FPageInstance.FLoadDataSetting.IsAddRecord
////                        or Self.FPageInstance.FLoadDataSetting.IsEditRecord;
////
////
////  Self.btnNew.Invalidate;
////  Self.btnEdit.Invalidate;
////  Self.btnSave.Invalidate;
////  Self.btnCancel.Invalidate;
//
//
////  Self.pnlInput.Enabled:=
//  Self.FPageInstance.MainControlMapList.SetReadOnly(not Self.FPageInstance.FLoadDataSetting.IsAddRecord
//                                                    and not Self.FPageInstance.FLoadDataSetting.IsEditRecord);
//  Self.FPageInstance.SyncButtonState;
//end;



{ TFrameBaseScrollPage }

procedure TFrameBaseScrollPage.CustomAfterLoad;
begin
  inherited;

  {$IFDEF FMX}
  Self.sbcContent.Height:=
    ControlSize(FPageInstance.MainControlMapList.FLayoutList.FListLayoutsManager.CalcContentHeight);
  {$ENDIF}
end;

{$IFDEF VCL}
procedure TFrameBaseScrollPage.sbHomeMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  //自已处理鼠标滚动
  sbClient.VertScrollBar.Position := sbClient.VertScrollBar.Position + 25 ;
  Handled:=True;

end;

procedure TFrameBaseScrollPage.sbHomeMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  APosition:integer;
begin
  //自已处理鼠标滚动
  APosition := sbClient.VertScrollBar.Position - 25 ;
  if sbClient.VertScrollBar.Position < 0 then APosition := 0;
  sbClient.VertScrollBar.Position := APosition;
  Handled:=True;

end;
{$ENDIF}

procedure TFrameBaseScrollPage.FrameResize(Sender: TObject);
begin
  inherited;

  {$IFDEF FMX}
  Self.sbcContent.Height:=
    ControlSize(FPageInstance.MainControlMapList.FLayoutList.FListLayoutsManager.CalcContentHeight)
    //底部留点空隙
    +20;
  {$ENDIF}

end;

function TFrameBaseScrollPage.GetPagePartLayoutParent(APagePart:String): TControl;
begin
  Result:=nil;
  if (APagePart='') or (APagePart=Const_PagePart_Main) or (APagePart='main') then
  begin
    {$IFDEF FMX}
    Result:=Self.sbcContent;
    {$ENDIF}
    {$IFDEF VCL}
    Result:=Self.sbClient;
    {$ENDIF}
  end
  else
  begin
    Result:=Inherited;
  end;
end;

//procedure TFrameBaseScrollPage.InitPage(APage: uPageStructure.TPage);
//begin
//  Inherited;
//
//  //初始页面结构
//  FPage.page_type:=Const_PageType_EditPage;
//
//end;

constructor TFrameBaseScrollPage.Create(AOwner:TComponent);
begin
  Inherited;

  {$IFDEF VCL}
  sbClient:=TScrollBox.Create(Self);
  sbClient.Parent:=Self.pnlClient;
  sbClient.Align:=alClient;
//    Align = alClient
  sbClient.BevelOuter := bvNone;
  sbClient.BorderStyle := bsNone;
//  sbClient.Color := clRed;
  sbClient.Color := clWhite;
  sbClient.Padding.Left := 10;
  sbClient.Padding.Top := 5;
  sbClient.Padding.Bottom := 5;
  sbClient.ParentColor := False;
//    TabOrder = 2
  sbClient.OnMouseWheelDown:=Self.sbHomeMouseWheelDown;
  sbClient.OnMouseWheelUp:=Self.sbHomeMouseWheelUp;
  {$ENDIF}


  {$IFDEF FMX}
//  sbClient:=TSkinScrollBox.Create(Self);
  sbClient.Visible:=True;


//  sbClient.Parent:=Self.pnlClient;
//  sbClient.Align:=TAlignLayout.Client;
//  sbClient.SkinControlType;
//  sbClient.SelfOwnMaterial;
//  sbClient.Prop.VertScrollBarShowType:=sbstAutoCoverShow;
//  sbClient.VertScrollBar;
//  sbClient.HorzScrollBar;
//
//  sbcContent:=TSkinScrollBoxContent.Create(Self);
//  sbcContent.Parent:=Self.sbClient;
//  sbcContent.Align:=TAlignLayout.None;


  {$ENDIF}


end;

destructor TFrameBaseScrollPage.Destroy;
begin
  Inherited;

end;

{ TFrameBaseListPage }

function TFrameBaseListPage.CreatePageInstance: TPageInstance;
begin
  Result:=TListPageInstance.Create(Self);
end;

procedure TFrameBaseListPage.CustomAfterLoad;
begin
  Inherited;
  //刷新数据
  Self.FPageInstance.LoadData();
end;



end.

