unit BasePageFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,



  uLang,
  HintFrame,
  uUIFunction,
  uOpenCommon,
  uFrameContext,
  uComponentType,
  uBasePageStructure,
  uPageStructure,
  uDataInterface,
  EasyServiceCommonMaterialDataMoudle,

  uSkinButtonType, uSkinFireMonkeyButton, uSkinFireMonkeyControl,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinScrollBoxContentType,
  uSkinFireMonkeyScrollBoxContent, uSkinScrollControlType, uSkinScrollBoxType,
  uSkinFireMonkeyScrollBox;



type
  TFrameBaseFMXPage = class(TFrame)//,IControlForPageFramework)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    pnlClient: TSkinFMXPanel;
    pnlBottombar: TSkinFMXPanel;
    FrameContext1: TFrameContext;
    sbClient: TSkinFMXScrollBox;
    sbcContent: TSkinFMXScrollBoxContent;
    procedure btnReturnClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);virtual;
    procedure FrameContext1Load(Sender: TObject);
  private
//    //加载数据时的参数
//    FLoadDataSetting:TLoadDataSetting;


//    //列表页面做为子控件
//    //IControlForPageFramework接口
//    //针对页面框架的控件接口
//    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting;AFieldControlSettingMap:TObject):Boolean;virtual;
//
//
//    //获取与设置自定义属性
//    function GetPropJsonStr:String;virtual;
//    procedure SetPropJsonStr(AJsonStr:String);virtual;
//
//    //获取提交的值
//    function GetPostValue(ASetting:TFieldControlSetting;APageDataDir:String;ASetRecordFieldValueIntf:ISetRecordFieldValue;
//                            var AErrorMessage:String):Variant;virtual;
//    //设置值
//    procedure SetControlValue(ASetting:TFieldControlSetting;APageDataDir:String;AImageServerUrl:String;AValue:Variant;
//                            AValueCaption:String;
//                            //要设置多个值,整个字段的记录
//                            AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue);virtual;
//    //设置属性
//    function GetProp(APropName:String):Variant;
//    procedure SetProp(APropName:String;APropValue:Variant);
    { Private declarations }
  protected
//    //获取创建子控件的父控件
//    function GetMainLayoutParent:TControl;virtual;
////    function GetMainLayoutParentMarginsTop:Double;virtual;
//
//
//    //获取创建子控件的父控件
//    function GetBottomToolbarLayoutParent:TControl;virtual;
////    function GetBottomToolbarLayoutParentMarginsTop:Double;virtual;
//
//
//    //自定义加载页面
//    function CustomInitPage//(APage:TPage;ALoadDataSetting:TLoadDataSetting)
//              :Boolean;virtual;

  protected
    //控件动作//
    //  //页面框架的操作
    //  //跳转到新增页面
    //  Const_PageAction_JumpToNewRecordPage='jump_to_new_record_page';
    //  //跳转到编辑页面
    //  Const_PageAction_JumpToEditRecordPage='jump_to_edit_record_page';
    //  //跳转到查看页面
    //  Const_PageAction_JumpToViewRecordPage='jump_to_view_record_page';
    //
    //
    //
    //  //跳转到主从新增页面
    //  Const_PageAction_JumpToNewMasterDetailRecordPage='jump_to_new_master_detail_record_page';
    //  //跳转到主从编辑页面
    //  Const_PageAction_JumpToEditMasterDetailRecordPage='jump_to_edit_master_detail_record_page';
    //  //跳转到主从查看页面
    //  Const_PageAction_JumpToViewMasterDetailRecordPage='jump_to_view_master_detail_record_page';
    //  //批量删除
    //  Const_PageAction_BatchDelRecord='batch_del_record';
    //  //批量保存
    //  Const_PageAction_BatchSaveRecord='batch_save_record';
    //  //搜索
    //  Const_PageAction_SearchRecordList='search_record_list';
    //  //删除
    //  Const_PageAction_DelRecord='del_record';
    //  //返回
    //  Const_PageAction_ReturnPage='return_page';
    //  //关闭页面
    //  Const_PageAction_ClosePage='close_page';
    //  //保存
    //  Const_PageAction_SaveRecord='save_record';
    //  //取消保存
    //  Const_PageAction_CancelSaveRecord='cancel_save_record';
    //  //保存并返回
    //  Const_PageAction_SaveRecordAndReturn='save_record_and_return';
    //  //保存新增并继续新增
    //  Const_PageAction_SaveRecordAndContinueAdd='save_record_and_continue_add';

    //
//    procedure DoReturnFrameAction(Sender:TObject);
//    //保存成功事件
//    procedure DoEditPageInstanceSaveRecordSucc(Sender:TObject);
  public
////    //页面结构的引用
////    PageStructure:TPage;
//    //页面的实例
//    PageInstance:TPageInstance;
//    function CreatePageInstance:TPageInstance;virtual;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
//  public
//    //加载页面结构,并调用一次获取数据接口(在ShowFrame后的FrameContext.OnLoad事件中)
//    function LoadPage(APage:TPage//;
//                      //ALoadDataSetting:TLoadDataSetting
//                      ):Boolean;virtual;
////    function SyncData(ALoadDataSetting:TLoadDataSetting):Boolean;virtual;
////    function Load(AFunction:String;
////                  APageType:String;
////                  APageName:String;
////                  APlatform:String):Boolean;

    { Public declarations }
  end;



implementation

{$R *.fmx}

{ TFrameBasePage }

procedure TFrameBaseFMXPage.btnReturnClick(Sender: TObject);
begin
  if GetFrameHistory(Self)<>nil then GetFrameHistory(Self).OnReturnFrame:=nil;

  DoHideFrame(Self);
  DoReturnFrame(Self);
end;

constructor TFrameBaseFMXPage.Create(AOwner: TComponent);
begin
  inherited;

//  PageInstance:=CreatePageInstance;

end;

//function TFrameBaseFMXPage.CreatePageInstance: TPageInstance;
//begin
//  //页面的实例
//  Result:=TPageInstance.Create(Self);
//
//end;
//
//function TFrameBaseFMXPage.CustomInitPage//(APage: TPage;
//  //ALoadDataSetting: TLoadDataSetting)
//  : Boolean;
//begin
//
//end;

//procedure TFrameBasePage.DoEditPageInstanceSaveRecordSucc(Sender: TObject);
//begin
//  //返回上一页
//  ShowHintFrame(nil,Trans('保存成功'));
//  HideFrame;
//  ReturnFrame;
//
//end;

destructor TFrameBaseFMXPage.Destroy;
begin
//  FreeAndNil(PageInstance);
  inherited;
end;

procedure TFrameBaseFMXPage.FrameContext1Load(Sender: TObject);
begin
//  //调用接口,获取数据,显示在界面上
//  PageInstance.LoadData();

end;

procedure TFrameBaseFMXPage.FrameResize(Sender: TObject);
begin
//  if PageInstance<>nil then
//  begin
//    PageInstance.MainControlMapList.AlignControls;//(0,GetMainLayoutParentMarginsTop);
//    PageInstance.BottomToolbarControlMapList.AlignControls;//(0,GetBottomToolbarLayoutParentMarginsTop);
//  end;

end;

//function TFrameBaseFMXPage.GetBottomToolbarLayoutParent: TControl;
//begin
//  Result:=nil;
//end;
//
////function TFrameBasePage.GetBottomToolbarLayoutParentMarginsTop: Double;
////begin
////  Result:=0;
////end;
//
//function TFrameBaseFMXPage.GetMainLayoutParent: TControl;
//begin
//  Result:=Self.pnlClient;
//end;
//
//function TFrameBasePage.GetMainLayoutParentMarginsTop: Double;
//begin
//  Result:=Self.pnlToolBar.Height;
//end;

//function TFrameBaseFMXPage.GetPostValue(ASetting: TFieldControlSetting;
//  APageDataDir: String; ASetRecordFieldValueIntf: ISetRecordFieldValue;
//  var AErrorMessage: String): Variant;
//begin
//
//end;
//
//function TFrameBaseFMXPage.GetProp(APropName: String): Variant;
//begin
//
//end;
//
//function TFrameBaseFMXPage.GetPropJsonStr: String;
//begin
//
//end;

//function TFrameBasePage.Load(AFunction, APageType, APageName,
//  APlatform: String): Boolean;
//begin
////  GlobalMainProgram.ShowPage(AFunction,APageType,APageName,APlatform);
//
//
//end;
//
//function TFrameBaseFMXPage.LoadFromFieldControlSetting(
//  ASetting: TFieldControlSetting;AFieldControlSettingMap:TObject): Boolean;
//begin
//  Self.pnlToolBar.Visible:=False;
//end;
//
//function TFrameBaseFMXPage.LoadPage(APage: TPage): Boolean;
//var
//  AError:String;
//begin
//  Result:=False;
//
////  FLoadDataSetting:=ALoadDataSetting;
//
//
//  if APage<>PageInstance.PageStructure then
//  begin
//      //页面标题
//      Self.pnlToolBar.Caption:=APage.Caption;
//      PageInstance.PageStructure:=APage;
//
//
//      if GetMainLayoutParent<>nil then
//      begin
//          //创建主控件列表
//          PageInstance.CreateControls(Self,
//                                      GetMainLayoutParent,
//                                      Const_PagePart_Main,
//                                      APage.GetPageDataDir,
//                                      False,
//                                      AError
//                                      );
//          PageInstance.MainControlMapList.AlignControls;//(0,GetMainLayoutParentMarginsTop);
//      end;
//
//
//
//    //  //设置父控件的高度
//    //  SetSuitScrollContentHeight(pnlClient);
//
//
//
//      if GetBottomToolbarLayoutParent<>nil then
//      begin
//          //创建底部工具栏控件列表
//          PageInstance.CreateControls(Self,GetBottomToolbarLayoutParent,
//                                      Const_PagePart_BottomToolbar,
//                                      APage.GetPageDataDir,
//                                      False,
//                                      AError
//                                      );
//          PageInstance.BottomToolbarControlMapList.AlignControls;//(0,GetBottomToolbarLayoutParentMarginsTop);
//      end;
//
////      Self.pnlBottomToolbar.Visible:=(APage.BottomToolbarLayoutControlList.Count>0);
//
//
//    //  //创建底部工具栏的控件列表
//    //  PageInstance.CreateControls(Self.pnlBottomToolbar,Const_PagePart_BottomToolbar);
//    //  //设置父控件的高度
//    //  SetSuitScrollContentHeight(pnlBottomToolbar);
//    //
//    //
//    //  //设置滚动框的高度
//    //  SetSuitScrollContentHeight(sbcClient);
//
//
//      CustomInitPage;//(APage,ALoadDataSetting);
//
//
//
//      //清除数据
//      PageInstance.MainControlMapList.ClearValue;
//
//
//  end;
//
//
//
//
//  Result:=True;
//
//end;
//
//procedure TFrameBaseFMXPage.SetControlValue(ASetting: TFieldControlSetting;
//  APageDataDir, AImageServerUrl: String; AValue: Variant; AValueCaption: String;
//  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
//begin
//
//end;
//
//procedure TFrameBaseFMXPage.SetProp(APropName: String; APropValue: Variant);
//begin
//
//end;
//
//procedure TFrameBaseFMXPage.SetPropJsonStr(AJsonStr: String);
//begin
//
//end;

//function TFrameBasePage.SyncData(ALoadDataSetting: TLoadDataSetting): Boolean;
//begin
//  Result:=False;
//  //调用接口,获取数据,显示在界面上
//  PageInstance.LoadData(ALoadDataSetting);
//  Result:=True;
//
//end;

end.
