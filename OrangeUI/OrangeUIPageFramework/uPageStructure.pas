//convert pas to utf8 by ¥
unit uPageStructure;



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
  Classes,
  SysUtils,
  Types,
  DB,

  {$IFDEF VCL}
  Controls,
  ExtCtrls,
  StdCtrls,
  Graphics,
  Dialogs,
  Messages,
  Windows,
  Vcl.CheckLst,
  Menus,
  Forms,
  {$ENDIF}

  {$IFDEF FMX}
  FMX.Controls,
  FMX.Types,
  FMX.Dialogs,
  FMX.Edit,
  FMX.ComboEdit,
  FMX.ListBox,
  FMX.StdCtrls,
  FMX.Memo,
  FMX.Graphics,
  FMX.Forms,
  FMX.Menus,
  HintFrame,
  MessageBoxFrame,
  WaitingFrame,
  uUIFunction,
  uSkinCommonFrames,
//  System.IOUtils,
  System.Math.Vectors,
  System.UIConsts,
  UITypes,
  System.Net.URLClient,
  {$ENDIF}

//  {$IFDEF VCL}
//  Forms,
//  Controls,
//  {$ENDIF}


//  uLang,
//  uSkinBufferBitmap,
//  uDrawParam,
  uOpenCommon,
  uPageCommon,
//  uGraphicCommon,
//  uSkinItems,
//  uSkinMaterial,
//  uSkinListLayouts,
//  uSkinListViewType,
//  uComponentType,
//  uSkinRegManager,
  uBaseList,
  uBaseLog,
  IdURI,
  Math,
  Variants,
//  uDrawPicture,
  uDataBaseConfig,
  System.IOUtils,

  RTLConsts,
  TypInfo,
  System.Json,


  {$IF CompilerVersion <= 21.0} // Delphi 2010以前
  SuperObject,
  superobjecthelper,
  {$ELSE}
    {$IFDEF SKIN_SUPEROBJECT}
    uSkinSuperObject,
    {$ELSE}
    XSuperObject,
    XSuperJson,
    {$ENDIF}
  {$IFEND}


  IniFiles,
//  uOpenCommon,
//  uBaseSkinControl,
//  uDrawTextParam,
//  uDrawPictureParam,
//  uDrawRectParam,
  uBaseDBHelper,
//  uSkinPageControl,
//  uBasePageStructure,
  uRestDatabaseConfig,
//  uSkinVirtualListType,
//  uSkinItemDesignerPanelType,
//  uSkinVirtualGridType,
  uDataInterface,
//  uTableCommonRestCenter,
//  uLang,
//  uComponentType,
//  uSkinItemJsonHelper,
  uBasePageStructure,
//  uFrameContext,
//  uBasePageStructureControls,

//  uSkinButtonType,
//  uSkinPageControlType,
//  uSkinCustomListType,
//  uSkinPanelType,
//  uSkinImageType,
//  uSkinLabelType,
//  uSkinMemoType,
//  uSkinEditType,
//  uSkinCheckBoxType,
//  uSkinRadioButtonType,
//  uSkinDateEditType,
//  uSkinTimeEditType,
//  uSkinVirtualChartType,

  {$IFDEF FMX}
//  uSkinFireMonkeyButton,
//  uSkinFireMonkeyLabel,
//  uSkinFireMonkeyMultiColorLabel,
//  uSkinFireMonkeyEdit,
//  uSkinFireMonkeyComboBox,
//  uSkinFireMonkeyDateEdit,
//  uSkinFireMonkeyTimeEdit,
//  uSkinFireMonkeyPopup,
//  uSkinFireMonkeyComboEdit,
//  uSkinFireMonkeyMemo,
//  uSkinFireMonkeyPanel,
//  uSkinFireMonkeyDrawPanel,
////  uSkinFireMonkeyDirectUIParent,
//  uSkinFireMonkeyPageControl,
//  uSkinFireMonkeyItemDesignerPanel,
//  uSkinFireMonkeyImage,
//  uSkinFireMonkeyRoundRect,
//  uSkinFireMonkeyImageListPlayer,
//  uSkinFireMonkeyImageListViewer,
//  uSkinFireMonkeyRoundImage,
//  uSkinFireMonkeyFrameImage,
//  uSkinFireMonkeyTrackBar,
//  uSkinFireMonkeySwitchBar,
//  uSkinFireMonkeyProgressBar,
//  uSkinFireMonkeyScrollBar,
//  uSkinFireMonkeyPullLoadPanel,
//  uSkinFireMonkeyScrollBox,
//  uSkinFireMonkeyScrollBoxContent,
//  uSkinFireMonkeyScrollControl,
//  uSkinFireMonkeyScrollControlCorner,
//  uSkinFireMonkeySwitchPageListPanel,
//
//  uSkinFireMonkeyCustomList,
////  uSkinFireMonkeyVirtualList,
//  uSkinFireMonkeyListBox,
//  uSkinFireMonkeyListView,
//  uSkinFireMonkeyTreeView,
//
////  uSkinFireMonkeyVirtualGrid,
//  uSkinFireMonkeyItemGrid,
//  uSkinFireMonkeyDBGrid,
//
//  uSkinFireMonkeyRadioButton,
//  uSkinFireMonkeyNotifyNumberIcon,
//  uSkinFireMonkeyCheckBox,
////  uSkinFireMonkeyCalloutRect,
//  uSkinFireMonkeySwitch,
  {$ENDIF}

//  uSkinCommonFrames,
//  uTimerTask,
  DateUtils,
//  XSuperObject,
  uFuncCommon,
  uFileCommon,
//  uBaseHttpControl,
  uRestInterfaceCall,
//  uRestDatabaseConfig,
  uBaseHttpControl,


  uDatasetToJson,


//  uUrlPicture,
  System.Net.Mime,
  //System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent,


//  uDrawCanvas,
  uAPPCommon,
  uOpenClientCommon,

//  uSkinListLayouts,


//  uBaseDataBaseModule,
//  uFMXUnidacDataBaseModule,

  StrUtils,
  uTimerTaskEvent,
  uTimerTask;






Const
  SUCC=200;
  FAIL=400;


const
  //组件设计时的尺寸
  COMPONENT_DESIGN_SIZE=48;


const
  //接口类型
  //通用接口
  Const_IntfType_TableCommonRest='table_common_rest';


const
  //编辑页面输入Panel的默认素材
  Const_ControlStyle_EditPageInputPanelDefault='EditPageInputPanelDefault';
  //编辑页面输入Label的默认素材
  Const_ControlStyle_EditPageHintLabelDefult='EditPageHintLabelDefault';


  {$REGION '页面框架的页面类型'}
const
  //页面框架的页面类型
  //列表页面
  Const_PageType_ListPage='list_page';
  //表格管理页面
  Const_PageType_TableManagePage='table_manage_page';
  //编辑页面
  Const_PageType_EditPage='edit_page';
  //查看页面
  Const_PageType_ViewPage='view_page';



  //自定义页面
  Const_PageType_CustomPage='custom_page';
  //树型列表页面
  Const_PageType_TreeListPage='tree_list_page';
  //主从编辑页面
  Const_PageType_MasterDetailEditPage='master_detail_edit_page';
  //主从查看页面
  Const_PageType_MasterDetailViewPage='master_detail_view_page';
  {$ENDREGION '页面框架的页面类型'}


  {$REGION '页面框架的页面区域'}
const
  //页面框架的页面区域
  //主区域
  Const_PagePart_Main='';
  Const_PagePart_Grid='grid';
  //搜索栏
  Const_PagePart_SearchBar='search_bar';
  //顶部工具栏
  Const_PagePart_TopToolbar='top_toolbar';
  //表格中的行操作区
  Const_PagePart_RowOperBar='row_oper_bar';
  //底部工具栏
  Const_PagePart_BottomToolbar='bottom_toolbar';
//  //其他
//  Const_PagePart_Other='other';
//  //列表页面的默认设计面板
//  Const_PagePart_DefaultItemDesignerPanel='default_item_designer_panel';
  {$ENDREGION '页面框架的页面区域'}


  {$REGION '页面框架的操作'}
const
  //页面框架的操作
  //跳转到新增页面
  Const_PageAction_JumpToNewRecordPage='jump_to_new_record_page';
  //跳转到编辑页面
  Const_PageAction_JumpToEditRecordPage='jump_to_edit_record_page';
  //跳转到自定义页面
  Const_PageAction_JumpToPage='jump_to_page';
  //跳转到查看页面
  Const_PageAction_JumpToViewRecordPage='jump_to_view_record_page';
  //跳转到主从新增页面
  Const_PageAction_JumpToNewMasterDetailRecordPage='jump_to_new_master_detail_record_page';
  //跳转到主从编辑页面
  Const_PageAction_JumpToEditMasterDetailRecordPage='jump_to_edit_master_detail_record_page';
  //跳转到主从查看页面
  Const_PageAction_JumpToViewMasterDetailRecordPage='jump_to_view_master_detail_record_page';


  //批量删除
  Const_PageAction_BatchDelRecord='batch_del_record';
  //批量保存
  Const_PageAction_BatchSaveRecord='batch_save_record';
  //搜索
  Const_PageAction_LoadData='load_data';
  //批量删除
  Const_PageAction_DeleteRecordList='delete_record_list';
  //新建
  Const_PageAction_AddRecord='add_record';
  //编辑
  Const_PageAction_EditRecord='edit_record';
  //取消
  Const_PageAction_CancelAddEditRecord='cancel_add_edit_record';
  //删除
  Const_PageAction_DelRecord='del_record';
  //返回
  Const_PageAction_ReturnPage='return_page';
  //关闭页面
  Const_PageAction_ClosePage='close_page';
  //保存
  Const_PageAction_SaveRecord='save_record';
  //取消保存
  Const_PageAction_CancelSaveRecord='cancel_save_record';
  //保存并返回
  Const_PageAction_SaveRecordAndReturn='save_record_and_return';
  //保存新增并继续新增
  Const_PageAction_SaveRecordAndContinueAdd='save_record_and_continue_add';
  //点击单元格
  Const_PageAction_ClickCell='click_cell';
  Const_PageAction_AfterSaveRecord='after_save_record';
  Const_PageAction_AfterCancelAddRecord='after_cancel_add_record';
  Const_PageAction_AfterCancelEditRecord='after_cancel_edit_record';


  Const_PageAction_SelectDateArea='select_date_area';
  Const_PageAction_ValueChange='value_change';
  Const_PageAction_ReturnFrame='return_frame';
  {$ENDREGION '页面框架的页面区域'}


  {$REGION '页面布局类型'}
const
  //页面布局-自动
  Const_PageAlignType_Auto='auto';
  //页面布局-手动
  Const_PageAlignType_Manual='manual';
  {$ENDREGION '页面布局类型'}


const
  IID_ITextSettings:TGUID='{FD99635D-D8DB-4E26-B36F-97D3AABBCCB3}';
  IID_IPageFrameworkListControl:TGUID='{394D81FC-D810-4948-BC9C-745226A3CF0D}';
  IID_IPageFrameworkSelectDataFrame:TGUID='{D3542802-2B4A-4C38-BAB4-3FFF3D3D42B7}';
  IID_IPageFrameworkFrame:TGUID='{7A6945A9-CE17-4B08-AADA-643085DFF5C9}';

type
  TPageList=class;
  TPage=class;
  TLayoutSetting=class;
//  TPageInstance=class;
//  TFieldControlSettingMap=class;
//  TPageInstance=class;
//  TFieldControlSettingMapList=class;
  //列表控件
  TFocusedRecordChangeEvent=procedure(Sender:TObject;ARecordDataJson:ISuperObject) of object;


//  //创建好的Frame，要实现这个接口，返回PageInstance，来操作
//  IPageFrameworkFrame=interface
//    ['{7A6945A9-CE17-4B08-AADA-643085DFF5C9}']
//    function GetPageInstance:TPageInstance;
//  end;
//
//
//  //页面框架选择页面，返回选择的数据
//  IPageFrameworkSelectDataFrame=interface
//    ['{D3542802-2B4A-4C38-BAB4-3FFF3D3D42B7}']
//    //告诉页面,我要用选择模式了,你准备好数据
//    procedure SetSelectDataMode(AFieldControlSettingMap:TFieldControlSettingMap);
//    //获取当前选择的数据
//    function GetSelectedData(AFieldControlSettingMap:TFieldControlSettingMap):TDataIntfResult;
//    //告诉页面,选择模式我用完了
//    procedure SetNoSelectDataMode;
//  end;


  //支持页面框架的列表控件接口
  IPageFrameworkListControl=interface
    ['{394D81FC-D810-4948-BC9C-745226A3CF0D}']

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
                                  ALoadDataIntfResult2:TDataIntfResult);
  end;

  //处理页面实例自己的Action
  TCustomProcessPageActionEvent=procedure(Sender:TObject;
                                            AFromPageInstance:TObject;
                                            AAction:String;
                                            AFieldControlSettingMap:TObject;
                                            var AIsProcessed:Boolean) of object;





  //因为我Json用的是XSuperObject
  //但是XSuperObject编译成C++Builder会编译不过,
  //而且很多控件包中都包含了XSuperObject,
  //所以要从控件包中独立出来,做一个Helper
//  TFieldControlSettingHelper=class helper for TFieldControlSetting
  TPageFieldControlSetting=class(TFieldControlSetting)
  private
    function GetPropJson: ISuperObject;
//    procedure SetPropJson(const Value: ISuperObject);
  public
    FPropJson:ISuperObject;
    LayoutSetting:TLayoutSetting;
    function SaveToJson(AJson:ISuperObject):Boolean;
    function LoadFromJson(AJson:ISuperObject):Boolean;

    //只保留更改过的字段
    function SaveToUpdateJson(AJson:ISuperObject;AOldSetting:TFieldControlSetting;var AIsChanged:Boolean):Boolean;

    constructor Create(ACollection: TCollection);override;
    destructor Destroy;override;

    property PropJson:ISuperObject read GetPropJson;// write SetPropJson;
  end;


  TPageFieldControlSettingList=class(TFieldControlSettingList)
  protected
    function GetItem(Index: Integer): TPageFieldControlSetting;
  public
    property Items[Index:Integer]:TPageFieldControlSetting read GetItem;default;
  public
    function FindBySavedComponent(ASavedComponent: TComponent):TPageFieldControlSetting;
    function FindByFid(AFid: Integer):TPageFieldControlSetting;
    function FindByControlType(AControlType: String):TPageFieldControlSetting;
    function FindByName(AName: String):TPageFieldControlSetting;
    function FindByFieldName(AFieldName: String):TPageFieldControlSetting;
    function Add:TPageFieldControlSetting;overload;
    procedure Clear(AIsNeedFree:Boolean);overload;
  public
    FOwner:TPage;
    constructor Create(ItemClass: TCollectionItemClass;AOwner:TPage);
  end;



  {$REGION '程序模板TProgramTemplate'}
  //程序模板
  TProgramTemplate=class
  private
    tteGetPage: TTimerTaskEvent;
    FOnGetPageExecuteEnd:TTimerTaskNotify;
    procedure tteGetPageBegin(ATimerTask: TTimerTask);
    procedure tteGetPageExecute(ATimerTask: TTimerTask);
    //加载好页面结构,打开
    procedure tteGetPageExecuteEnd(ATimerTask: TTimerTask);
  public
    fid:Integer;
    appid:Integer;
    user_fid:String;


    name:String;
    caption:String;
    description:String;

//    //接口列表
//    DataIntfList:TDataInterfaceList;


    //页面列表
    PageList:TPageList;

    //数据库模块列表
    DataBaseConfigList:TRestDataBaseConfigList;
    FJson:ISuperObject;
  public
    IsLoaded:Boolean;
    FLoadedProgramDir:String;
//    FInterfaceUrl:String;
  public
    constructor Create;
    destructor Destroy;override;
  public
    function LoadFromFile(AJsonFilePath:String):Boolean;
    function SaveToFile(AJsonFilePath:String):Boolean;

    function LoadFromJson(AJson:ISuperObject):Boolean;
    function SaveToJson(AJson:ISuperObject):Boolean;

//    procedure LoadFromLocal;
//    procedure SaveToLocal;
    function GetProgramTemplateDir:String;
  public
    //是否是从本地加载的,还是从网络加载的？

//    function IsLocal:Boolean;

    procedure Clear;
    function NewPage(APageName:String):TPage;

    //从本地加载
    procedure LoadFromLocal();

    //从服务器加载程序模板
    function LoadFromServer(AInterfaceUrl:String;
                            AAppID:String;
                            AProgramTemplateName:String;
                            var ADesc:String):Boolean;

    function SaveToServer(AInterfaceUrl:String;var ADesc:String):Boolean;
    //加载页面,根根Program,Function,PageType
    function LoadPage(AProgram:String;
                      AFunction:String;
                      APageType:String;
                      //可以为空
                      APageName:String;
                      APlatform:String;
                      AOnGetPageExecuteEnd: TTimerTaskNotify):Boolean;overload;
    //加载页面,根据PageFID
    function LoadPage(APageFID:Integer;
                      AOnGetPageExecuteEnd: TTimerTaskNotify):Boolean;overload;

    //保存
    procedure SaveToLocal;
//  public
//    //添加数据库连接
//    procedure AddDatabaseConfigToServer(ADatabaseConfig:TDatabaseConfig);
//    //测试数据库连接
//    procedure TestConnectDatabaseConfigToServer(ADatabaseConfig:TDatabaseConfig);



//    //保存到服务端
//    procedure SaveToServer(AInterfaceUrl:String;
//                            AAppID:String;
//                            AProgramTemplateName:String;
//                            var ADesc:String):Boolean;
  end;
  {$ENDREGION}







  {$REGION '开放平台的程序设置TBaseOpenPlatformFramework'}
//  //需要显示页面
//  TNeedShowPageEvent=procedure(Sender:TObject;
//                                  AFromPageInstance:TPageInstance;
//                                  AFromFieldControlSettingMap:TFieldControlSettingMap;
////                                  AToPageFID:Integer;
//                                  AToPage:TPage;
////                                  ALoadDataSetting:TLoadDataSetting;
//                                  //返回
//                                  AOnReturnFrame:TReturnFromFrameEvent;
//                                  var AIsProcessed:Boolean) of object;

  //开放平台的程序设置
  TBaseOpenPlatformFramework=class(TComponent)
  public
//    FOnNeedShowPage: TNeedShowPageEvent;
    FOnCustomProcessPageAction: TCustomProcessPageActionEvent;
    FDataIntfServerUrl: String;
    FOpenPlatformImageUrl: String;
    FOpenPlatformAppID: String;
    FAppID: String;
    FProgramTemplateName: String;
    FDataIntfImageUrl: String;
    FPlatform: String;
    FMainPageName: String;
    FOpenPlatformServerUrl: String;
//    FOnProcessPageAction: TOnCustomProcessPageActionEvent;
  public
    FProgramTemplate:TProgramTemplate;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    function Load(AIniFilePath:String):Boolean;
    procedure Save(AIniFilePath:String);
  public
//    procedure DoReturnFrame(AFromFrame:TFrame);virtual;
//    function ShowPage(APageName:String;
//                      //返回
//                      AOnReturnFrame:TReturnFromFrameEvent;
//                      AFromPageInstance:TObject):TFrame;virtual;abstract;
//    //显示一个页面
//    procedure DoNeedShowPage(Sender:TObject;
//                                  AFromPageInstance:TPageInstance;
//                                  AFromFieldControlSettingMap:TFieldControlSettingMap;
////                                  AToPageFID:Integer;
//                                  AToPage:TPage;
////                                  ALoadDataSetting:TLoadDataSetting;
//                                  //返回
//                                  AOnReturnFrame:TReturnFromFrameEvent;
//                                  var AIsProcessed: Boolean);virtual;
    //处理自定义的动作,可能是执行一段代码，可能是显示一个页面
    procedure DoCustomProcessPageAction(Sender:TObject;
                                        APageInstance:TObject;
                                        AAction:String;
                                        AFieldControlSettingMap:TObject;
                                        var AIsProcessed:Boolean);virtual;
  published
    //用于加载页面结构//
    //开放平台的APPID,用于获取程序信息,页面结构,
    //默认是1000
    property OpenPlatformAppID:String read FOpenPlatformAppID write FOpenPlatformAppID;
    //开放平台的服务器,
    //默认是http://www.orangeui.cn:10000/
    property OpenPlatformServerUrl:String read FOpenPlatformServerUrl write FOpenPlatformServerUrl;
    //开放平台图片下载的服务器,
    //页面结构中的图片
    //默认是http://www.orangeui.cn:10001/
    property OpenPlatformImageUrl:String read FOpenPlatformImageUrl write FOpenPlatformImageUrl;

  published
    //应用的APPID,
    //比如是1010,医院测试
    property AppID:String read FAppID write FAppID;

    //程序模板的名称,
    //比如hospitcal医院应用
    property ProgramTemplateName:String read FProgramTemplateName write FProgramTemplateName;


    //只设置名称,能简单一点
    //主页的名称,如果为空,那么就显示默认的主页,
    //比如是hospital_office_status
    property MainPageName:String read FMainPageName write FMainPageName;
    //平台,比如web,pc,app
    property Platform:String read FPlatform write FPlatform;

  published
    //应用服务器,应用数据自己的服务器
    //http://www.orangeui.cn:10000/
    property DataIntfServerUrl:String read FDataIntfServerUrl write FDataIntfServerUrl;
    //图片下载服务器
    //http://www.orangeui.cn:10001/
    property DataIntfImageUrl:String read FDataIntfImageUrl write FDataIntfImageUrl;

//    //自定义的页面显示事件
//    property OnNeedShowPage:TNeedShowPageEvent read FOnNeedShowPage write FOnNeedShowPage;
    //自定义的页面返回事件
    property OnCustomProcessPageAction:TCustomProcessPageActionEvent read FOnCustomProcessPageAction write FOnCustomProcessPageAction;

//    property OnProcessPageAction:TOnCustomProcessPageActionEvent read FOnProcessPageAction write FOnProcessPageAction;
  end;
  {$ENDREGION '开放平台的程序设置TBaseOpenPlatformFramework'}





  {$REGION '页面区域的控件布局TLayoutSetting'}
  //页面区域的控件布局
  TLayoutSetting=class
  public
//    FPagePart:String;
    align:String;

    //main/bottom_toolbar
    name:String;

    //排列类型,auto,manual
    align_type:String;


    //控件排几列,一般是一列
    col_count:Integer;
    //控件的宽度,-1表示页面宽度
    col_width:double;
    //控件的高度
    row_height:double;
    //控件的间隔
    row_space:double;



    //提示文本的宽度
    hint_label_width:double;
//    //字体设置,TEdit.TextSetting
//    hint_label_text_font_name:String;
//    hint_label_text_font_size:Integer;
//    hint_label_text_font_color:String;
//    hint_label_text_vert_align:String;
//    hint_label_text_horz_align:String;
//    hint_label_text_style:String;
//    hint_label_text_wordwrap:Integer;

    //控件的左边距
    margins_left:double;
    margins_top:double;
    margins_right:double;
    margins_bottom:double;


    //内容是否水平居中
    is_content_horz_center:integer;

    procedure Clear;
    constructor Create;virtual;

    function LoadFromJson(AJson:ISuperObject):Boolean;
    function SaveToJson(AJson:ISuperObject):Boolean;

  end;
  TLayoutSettingList=class(TBaseList)
  private
    function GetItem(Index: Integer): TLayoutSetting;
  public
    function Find(APagePart:String):TLayoutSetting;
    property Items[Index:Integer]:TLayoutSetting read GetItem;default;
  end;
  {$ENDREGION '页面区域的控件布局TLayoutSetting'}




  {$REGION '列表项的属性和数据字段的绑定TListItemBindingItem'}
  //列表项的属性和数据字段的绑定
  {"ItemCaption":"name","ItemDetail":"desc"}
  TListItemBindingItem=class(TCollectionItem)
  private
    Fitem_field_name: String;
    Fdata_field_name: String;
  published
    //Item的属性,比如ItemCaption,ItemDetail,ItemIcon等
    property item_field_name:String read Fitem_field_name write Fitem_field_name;
    //比如Name,Sex,Age,数据记录的字段
    property data_field_name:String read Fdata_field_name write Fdata_field_name;
  end;
  TListItemBindings=class(TCollection)
  private
    function GetItem(Index: Integer): TListItemBindingItem;
  public
    function Add:TListItemBindingItem;
    property Items[Index:Integer]:TListItemBindingItem read GetItem;default;
  public
    procedure LoadFromJson(AJson:ISuperObject);
    procedure SaveToJson(AJson:ISuperObject);
  end;
  {$ENDREGION '列表项的属性和数据字段的绑定TListItemBindingItem'}



  {$REGION '页面的结构TPage'}
  //自定义检测每个控件输入的值,也可以自定义返回值
  TOnCustomCheckControlInputValueEvent=procedure(Sender:TObject;
                                                  APageInstance:TObject;
                                                  AControlMap:TObject;
                                                  var AInputValue:Variant;
                                                  //是否可以提交
                                                  var AIsCanPost:Boolean);

  //自定义提交的参数
  TOnCustomPostJsonEvent=procedure(Sender:TObject;
                                    APageInstance:TObject;
                                    APostJson:ISuperObject;
                                    //检测每个参数是否合格
                                    //是否可以提交
                                    var AIsCanPost:Boolean
                                    ) of object;

  //自定义调用加载数据的接口
  TOnCustomCallLoadDataIntfEvent=procedure(Sender:TObject;
                                          APageInstance:TObject;
                                          var ALoadDataSetting:TLoadDataSetting;
                                          ALoadDataIntfResult:TDataIntfResult) of object;
  //自定义调用保存数据的接口
  TOnCustomCallSaveDataIntfEvent=procedure(Sender:TObject;
                                          APageInstance:TObject;
                                          var ASaveDataSetting:TSaveDataSetting;
                                          ASaveDataIntfResult:TDataIntfResult;
                                          var AIsNeedCallDefault:Boolean) of object;
  //页面自定义加载数据到界面上的事件
  TPageLoadedDataToUIEvent=procedure(Sender:TObject;
                                     APage:TPage;
                                     APageInstance:TObject;
                                     ALoadDataSetting:TLoadDataSetting;
                                     ALoadDataIntfResult:TDataIntfResult;
                                     ALoadDataIntfResult2:TDataIntfResult) of object;


  //页面的结构
  TPage=class(TComponent)
  private
//    //列表页面的静态列表项列表
//    FDataSkinItems: TSkinItems;


//    FBottomToolbarLayoutControlList: TFieldControlSettingList;
    FMainLayoutControlList: TPageFieldControlSettingList;

//    FOnCustomCallSaveDataIntf: TOnCustomCallSaveDataIntfEvent;
//    FOnCustomCallLoadDataIntf: TOnCustomCallLoadDataIntfEvent;
//    FOnLoadedDataToUI: TPageLoadedDataToUIEvent;

//    procedure SetDataSkinItems(const Value: TSkinItems);
//    procedure SetBottomToolbarLayoutControlList(
//      const Value: TFieldControlSettingList);
    procedure SetMainLayoutControlList(const Value: TPageFieldControlSettingList);
    procedure SetDataIntfClass(const Value: String);
    procedure SetDataIntfClass2(const Value: String);
//    function GetDataInterface: TDataInterface;
//    function GetDataInterface2: TDataInterface;
//    procedure SetDefaultListItemBindings(const Value: TListItemBindings);
  public
    //程序模板
    ProgramTemplate:TProgramTemplate;
//    //接口,主接口
//    FDataInterface:TDataInterface;
//    //接口2,用于调用第二个存储过程,专门用于医院界面设计器
//    FDataInterface2:TDataInterface;
//

    //是否使用默认的uOpenClientCommon中的InterfaceUrl
    FIsUseDefaultImageHttpServerUrl:Boolean;
    FImageHttpServerUrl:String;

//    //服务端
//    DataServer:TDataServer;
//    //功能模块
//    DataFunction:TDataFunction;
  public


    //所属的程序模块
    program_template_fid:Integer;
    //有个名字好记好懂
    program_template_name:String;


    //所调用的接口
//    data_intf_fid:Integer;
    //有个名字好记好懂
    data_intf_name:String;
    data_intf_class:String;
    data_intf_setting:String;//Json字符串
    data_intf_orderby:String;//排序
    data_intf_key_field:String;//接口返回记录的主键

    //所调用的接口
//    data_intf_fid2:Integer;
    //有个名字好记好懂
    data_intf_name2:String;
    data_intf_class2:String;
    data_intf_setting2:String;//Json字符串
    data_intf_orderby2:String;//排序


    //所属的功能
    function_fid:Integer;
    //有个名字好记好懂
    function_name:String;



  public
    //页面的数据库字段
    fid:Integer;
    Fappid:Integer;
    fuser_fid:String;

    //页面的名称
    //name:String;
    //页面的标题
    caption:String;


    //排列布局类型,
    //manual手动布局,
    //auto自动布局,框架页面一般是自动布局
    align_type:String;


    //页面类型,list_page,edit_page,view_page,custom_page,list_item_style
    page_type:String;
    //平台,web,pc,app,wxapp
    platform:String;

    createtime:String;
    updatetime:String;
    FIsNeedDownload:Boolean;

  public
    //为医院设计器加的
    //设计器里设计时的宽度和高度
    design_width:Double;
    design_height:Double;


    //页面刷新间隔
    refresh_seconds:Integer;


    //每页记录数
    load_data_pagesize:Integer;
    //加载接口1需要的参数,Json
    //[{"name":"fid","value_from":"local_data_source","value_key":"office_fid"},{"name":"appid","value_from":"const","value":1010}]
    load_data_params:String;
    //保存接口1所需要的参数,Json
    save_data_params:String;


    //加载接口2需要的参数,Json
    //[{"name":"fid","value_from":"local_data_source","value_key":"office_fid"},{"name":"appid","value_from":"const","value":1010}]
    load_data_params2:String;
    //保存接口2所需要的参数,Json
    save_data_params2:String;

    //建记录的页面名称
    edit_record_page_name:String;
  public
    //列表页面，或者界面控件布局//
    //每行列表项的列数
    item_col_count:Integer;
    //每列列表项的宽度
    item_col_width:Integer;
    //列表项的行高
    item_height:Integer;



//
//    //列表页面相关设置//
//    //是否是默认的ListPage,
//    //如果是就创建一个默认的ListView
////    is_simple_list_page:Integer;
//    //列表页面是否需要添加记录按钮
//    has_add_record_button:Integer;
//
//    data_list_field_name:String;
//    data_list_other_field_name:String;
//
//
//
//    //默认列表项的显示风格,比如Default,SaleManage,等等
//    default_list_item_style:String;
//    //默认列表项的绑定设置的json数组,比如{"ItemCaption":"name"}
//    default_list_item_bindings:String;
//
//
//    //做为列表项样式时的默认值
//    list_item_style_default_height:Double;
//    list_item_style_autosize:Integer;
//    list_item_style_default_width:Double;



//    //是否有搜索框
//    has_search_bar:Integer;
//    //是否有过滤栏
//    has_filter_bar:Integer;


  public
//    //默认列表项的绑定设置,比如{"ItemCaption":"工序","ItemDetail":"完成人员姓名"}'
//    //表示Json中的工序赋给Item.Caption
//    FDefaultListItemBindings:TListItemBindings;


    //主控件排列布局设置
    MainLayoutSetting:TLayoutSetting;
    //底部工具栏的布局设置
    BottomToolbarLayoutSetting:TLayoutSetting;
    //顶部工具栏的布局设置
    TopToolbarLayoutSetting:TLayoutSetting;

    //其他区域的布局设置
    FLayoutSettingList:TLayoutSettingList;

    FRecordListFieldControlSetting:TPageFieldControlSetting;

//    //加载需要的参数
//    LoadDataParamsJsonArray:ISuperArray;
//    //保存所需要的参数
//    SaveDataParamsJsonArray:ISuperArray;

    IsLoaded:Boolean;
    FLoadedJsonFilePath:String;


    //是否需要通用的编辑按钮
    FIsNeedCommonEditButton:Boolean;
//    //列表页面的表格列列表
//    PageColumns:TPageColumns;
    //脚本
    FScriptList:TStringList;
    FScriptLanguage:String;
    FJson:ISuperObject;
    FStructureJson:ISuperObject;
    FDataObject:TObject;
  public
//    //列表页面属性//
//    //编辑页面结构
//    EditPage:TPage;
//    //查看页面结构
//    ViewPage:TPage;
//
//
//    //列表页面时点击Item跳转的页面
//    ClickItemJumpPage:TPage;



    procedure AssignTo(Dest: TPersistent); override;

//    //在页面Frame创建之前,Load一下,因为有些数据需要在登录之后才能获取的到，比如服务端接口呀
//    procedure DelayLoad;virtual;
//    procedure CustomDelayLoad;virtual;

    //初始列表页面所需要的控件ListView
    procedure LoadLayoutControlListEnd;virtual;

    procedure DoCreateControlsEnd(APageInstance:TObject);virtual;

    //控件点击,弹出页面,然后返回调用的事件
    procedure DoReturnFrameFromFieldControlSettingMapClick(AFieldControlSettingMap:TObject;AFromFrame:TFrame);virtual;
    //  //返回
    //  Const_PageAction_ReturnPage='return_page';
    //处理页面实例自己的Action
    procedure DoCustomPageAction(APageInstance:TObject;AAction:String;AFieldControlSettingMap:TObject;var AIsProcessed:Boolean);virtual;
    //控件点击事件
    procedure DoPageLayoutControlClick(Sender:TObject;APageLayoutControlMap:TObject);virtual;
    //控件的值的更改事件,比如改了一个控件的值,就要改另一个控件或者其他操作
    procedure DoPageLayoutControlValueChange(Sender:TObject;APageLayoutControlMap:TObject);virtual;

//    //调用接口,返回数据
//    procedure CallLoadDataIntf(APageInstance:TObject;
//                                  //APageStructure:TPage;
//                                  //接口
//                                  //ADataInterface:TDataInterface;
//                                  //接口返回值
//                                  ALoadDataIntfResult:TDataIntfResult;
//                                  ALoadDataIntfResult2:TDataIntfResult;
//                                  //页面的加载设置
//                                  ALoadDataSetting:TLoadDataSetting//;
//                                  //页面的加载参数
//                                  //ALoadDataParams:String
//                                  );virtual;


    //调用接口,保存数据
    procedure CallSaveDataIntf(APageInstance:TObject;
                                  //APageStructure:TPage;
                                  //接口
                                  //ADataInterface:TDataInterface;
                                  //接口返回值
                                  ASaveDataIntfResult:TDataIntfResult;
                                  //页面的加载设置
                                  ASaveDataSetting:TSaveDataSetting;
                                  //页面的加载参数
                                  //ALoadDataParams:String;
                                          var AIsNeedCallDefault:Boolean
                                  );virtual;

  public
    OnLoaded:TNotifyEvent;
    procedure DoLoaded;
    procedure DoLoadPageStructureExecute(ATimerTask:TObject);
    procedure DoLoadPageStructureExecuteEnd(ATimerTask:TObject);
    procedure StartLoadPageStructureThread;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    procedure ClearFid;
//    //创建页面实例到控件上
//    function CreatePageInstalceTo(AOwner:TComponent;AParent:TParentControl;var AError:String):TObject;
  public
    //存放页面图片以及其他数据的地方
    function GetPageParentDir:String;
    function GetPageDataDir:String;

    //从服务端接口获取页面结构
    function LoadFromServer(AInterfaceUrl:String;
                            AAppID:String;
                            //根据PageFID
                            //APageFID:Integer;

                            //根据ProgramTemplateName和PageName
                            AProgramTemplateName:String;
                            //根据FunctionName和PageType
                            AFunctionName:String;
                            APageType:String;
                            APlatform:String;
                            APageName:String;
                            //是否使用缓存
                            AIsCanUseCache:Boolean;
                            var ADesc:String;
                            var AIsUsedCache:Boolean):Boolean;overload;

    function DownloadJsScriptFile(APageName:String):Boolean;

    //加载页面结构和脚本
    function LoadDataFromLocal(
                            var ADesc:String):Boolean;overload;
    function LoadDataFromServer(
                            var ADesc:String):Boolean;overload;

    //保存到服务端
//    function SaveToServer(AInterfaceUrl:String;
//                            AAppID:String;
//                            AProgramTemplateName:String;
//                            AFunctionName:String;
//                            APageType:String;
//                            APlatform:String;
//                            APageName:String;
//                            var ADesc:String):Boolean;overload;


    procedure LoadFromFile(AJsonFilePath:String);
    procedure SaveToFile(AJsonFilePath:String);


    //仅加载和保存TPage,不保存接口、控件结构等
    function LoadFromJson(AJson:ISuperObject):Boolean;
    function SaveToJson(AJson:ISuperObject):Boolean;

    //仅保存索引
    function LoadFromIndexJson(AJson:ISuperObject):Boolean;
    function SaveToIndexJson(AJson:ISuperObject):Boolean;


    function GetUserSetting(AUserFID:String;var ADataJson:ISuperObject):Boolean;

    //加载和保存Page,保存接口,保存控件列表等,全部保存
    function LoadPageStructureFromJson(ASuperObject:ISuperObject):Boolean;
    function SavePageStructureToJson(ASuperObject:ISuperObject;var ADesc:String):Boolean;

    //保存到服务端
    function SavePageJsonToServer(APageJson:ISuperObject;APageStructureJson:ISuperObject;var ADesc:String):Boolean;
    function SaveToServer(var ADesc:String):Boolean;
//    function SaveDataToServer(APageJsonFile:String;var ADesc:String):Boolean;
    function SaveScriptToServer(AScriptLanguage:String;var ADesc:String):Boolean;

    procedure ChangeName(ANewName:String);


//    //保存子组件到页面
//    function SaveSubControlsToServer(AInterfaceUrl:String;
//                                    AAppID:String;
//                                    AParent:TControl;
//                                    APageDataDir:String;
//                                    //可以为空
//                                    APageInstance:TPageInstance;
//                                    AImageHttpServerUrl:String;
//                                    AOldFieldControlSettingList:TPageFieldControlSettingList;
//                                    var ANewFieldControlSettingList:TPageFieldControlSettingList;
//                                    var ANeedAddFieldControlSettingList:TList;
//                                    var ADesc:String):Boolean;
    //从Json中创建相应的控件列表,用于门业报表中复杂多样的明细样式
//    procedure CreateFromJson(AJson:ISuperObject);
    procedure LoadFromFieldList(AFieldList:ISuperArray;AHideFieldList:TStringList);
//    procedure LoadFromFieldStringList(AFieldList:TStringList;AHideFieldList:TStringList);


    //检测用户参数是否完整
    function CheckUserSettingIsFull(AUserPageSettingJson:ISuperObject;var ADesc:String):Boolean;


//    //接口,主接口
//    property DataInterface:TDataInterface read GetDataInterface;
//    //接口2,用于调用第二个存储过程,专门用于医院界面设计器
//    property DataInterface2:TDataInterface read GetDataInterface2;
//
//    //页面自定义加载数据到界面上的事件
//    property OnLoadedDataToUI:TPageLoadedDataToUIEvent read FOnLoadedDataToUI write FOnLoadedDataToUI;
//



  public
    //从页面文件创建控件实例
//    function CreatePageDesignerControlByPage():TControl;
    function CreatePageDesignerControlByFMX(AFMXFile:String):TControl;
    //保存控件为fmx文件
    procedure SaveControlToFMXStream(APageDesignerControl:TControl;AFMXOutputStream:TStream);
    procedure SaveControlToFMXFile(APageDesignerControl:TControl;AFMXFile:String);
//    procedure SaveControlToJson(APageDesignerControl:TControl;var AJson:ISuperObject);
//    procedure SaveControlToJsonFile(APageDesignerControl:TControl;AJsonFile:String);



  published
//    //静态列表数据
//    property DataSkinItems:TSkinItems read FDataSkinItems write SetDataSkinItems;

    property DataIntfClass:String read data_intf_class write SetDataIntfClass;
    property DataIntfClass2:String read data_intf_class2 write SetDataIntfClass2;
//    //列表页面时的静态列表项
//    property DefaultListItemBindings:TListItemBindings read FDefaultListItemBindings write SetDefaultListItemBindings;

    //页面的控件列表(编辑页面)
    property MainLayoutControlList:TPageFieldControlSettingList read FMainLayoutControlList write SetMainLayoutControlList;
    property StaticMainLayoutControlList:TPageFieldControlSettingList read FMainLayoutControlList write FMainLayoutControlList;
//    //页面其他区域的控件(一些按钮)
//    property BottomToolbarLayoutControlList:TFieldControlSettingList read FBottomToolbarLayoutControlList write SetBottomToolbarLayoutControlList;

//    //自定义调用加载数据的接口
//    property OnCustomCallLoadDataIntf:TOnCustomCallLoadDataIntfEvent read FOnCustomCallLoadDataIntf write FOnCustomCallLoadDataIntf;
//    //自定义调用保存数据的接口
//    property OnCustomCallSaveDataIntf:TOnCustomCallSaveDataIntfEvent read FOnCustomCallSaveDataIntf write FOnCustomCallSaveDataIntf;


  end;
  TPageList=class(TBaseList)
  private
    function GetItem(Index: Integer): TPage;
  public
    FProgramTemplate:TProgramTemplate;
    function Find(AFunction:String;
                  APageType:String;
                  APageName:String;
                  APlatform:String):TPage;overload;
    function Find(APageName:String):TPage;overload;
    function Find(APageFID:Integer):TPage;overload;
    property Items[Index:Integer]:TPage read GetItem;default;


    //保存页面索引到数据
    procedure SaveIndexToJsonArray(ASuperArray:ISuperArray);
    procedure LoadIndexFromJsonArray(ASuperArray:ISuperArray);


    procedure SaveIndexToFile(AJsonFilePath:String);
    procedure LoadIndexFromFile(AJsonFilePath:String);
  end;
  {$ENDREGION '页面的结构TPage'}




var
  //主程序设置
  GlobalMainProgramSetting:TBaseOpenPlatformFramework;
  GlobalProgramTemplate:TProgramTemplate;




implementation

var
  //主程序设置
  FInnterGlobalMainProgramSetting:TBaseOpenPlatformFramework;

procedure ObjectBinaryToJson(const Input: TStream;AJson:ISuperObject);
var
  NestingLevel: Integer;
  Reader: TReader;
  Writer: TWriter;
  ObjectName, PropName: string;
  UTF8Idents: Boolean;
  MemoryStream: TMemoryStream;
  LFormatSettings: TFormatSettings;

  procedure WriteIndent;
  var
    Buf: TBytes;
    I: Integer;
  begin
    Buf := TBytes.Create($20, $20);
    for I := 1 to NestingLevel do Writer.Write(Buf, Length(Buf));
  end;

  procedure WriteTBytes(S: TBytes);
  begin
    Writer.Write(S, Length(S));
  end;

  procedure WriteAsciiStr(const S: String);
  var
    Buf: TBytes;
    I: Integer;
  begin
    SetLength(Buf, S.Length);
    for I := Low(S) to High(S) do
      Buf[I-Low(S)] := Byte(S[I]);
    Writer.Write(Buf, Length(Buf));
  end;

  procedure WriteByte(const B: Byte);
  begin
    Writer.Write(B, 1);
  end;

  procedure WriteUTF8Str(const S: string);
  var
    Ident: TBytes; // UTF8String;
  begin
    Ident := TEncoding.UTF8.GetBytes(S);

    if not UTF8Idents and (Length(Ident) > S.Length) then
      UTF8Idents := True;
    WriteTBytes(Ident);
  end;

  procedure NewLine;
  begin
    WriteAsciiStr(sLineBreak);
    WriteIndent;
  end;

  procedure ConvertValue; forward;

  procedure ConvertHeader;
  var
    ClassName: string;
    Flags: TFilerFlags;
    Position: Integer;
  begin
    Reader.ReadPrefix(Flags, Position);
    ClassName := Reader.ReadStr;
    ObjectName := Reader.ReadStr;
    WriteIndent;
    if ffInherited in Flags then
      WriteAsciiStr('inherited ')
    else if ffInline in Flags then
      WriteAsciiStr('inline ')
    else
      WriteAsciiStr('object ');
    if ObjectName <> '' then
    begin
      WriteUTF8Str(ObjectName);
      WriteAsciiStr(': ');
    end;
    WriteUTF8Str(ClassName);
    if ffChildPos in Flags then
    begin
      WriteAsciiStr(' [');
      WriteAsciiStr(IntToStr(Position));
      WriteAsciiStr(']');
    end;

    if ObjectName = '' then
      ObjectName := ClassName;  // save for error reporting

    WriteAsciiStr(sLineBreak);
  end;

  procedure ConvertBinary;
  const
    BytesPerLine = 32;
  var
    MultiLine: Boolean;
    I: Integer;
    Count: Integer;
    Buffer: TBytes; // array[0..BytesPerLine - 1] of AnsiChar;
    Text: TBytes; // array[0..BytesPerLine * 2 - 1] of AnsiChar;
  begin
    SetLength(Buffer, BytesPerLine);
    SetLength(Text, BytesPerLine*2+1);

    Reader.ReadValue;
    WriteAsciiStr('{');
    Inc(NestingLevel);
    Reader.Read(Count, SizeOf(Count));
    MultiLine := Count >= BytesPerLine;
    while Count > 0 do
    begin
      if MultiLine then NewLine;
      if Count >= 32 then I := 32 else I := Count;
      Reader.Read(Buffer, I);
      BinToHex(Buffer, 0, Text, 0, I);
      Writer.Write(Text, I * 2);
      Dec(Count, I);
    end;
    Dec(NestingLevel);
    WriteAsciiStr('}');
  end;

  procedure ConvertProperty; forward;

  procedure ConvertValue;
  const
    LineLength = 64;
  var
    I, J, K, L: Integer;
    S: String;
    W: String;
    LineBreak: Boolean;
  begin
    case Reader.NextValue of
      vaList:
        begin
          Reader.ReadValue;
          WriteAsciiStr('(');
          Inc(NestingLevel);
          while not Reader.EndOfList do
          begin
            NewLine;
            ConvertValue;
          end;
          Reader.ReadListEnd;
          Dec(NestingLevel);
          WriteAsciiStr(')');
        end;
      vaInt8, vaInt16, vaInt32:
        WriteAsciiStr(IntToStr(Reader.ReadInteger));
      vaExtended, vaDouble:
        WriteAsciiStr(FloatToStrF(Reader.ReadFloat, ffFixed, 16, 18, LFormatSettings));
      vaSingle:
        WriteAsciiStr(FloatToStr(Reader.ReadSingle, LFormatSettings) + 's');
      vaCurrency:
        WriteAsciiStr(FloatToStr(Reader.ReadCurrency * 10000, LFormatSettings) + 'c');
      vaDate:
        WriteAsciiStr(FloatToStr(Reader.ReadDate, LFormatSettings) + 'd');
      vaWString, vaUTF8String:
        begin
          W := Reader.ReadString;
          L := High(W);
          if L = High('') then WriteAsciiStr('''''') else
          begin
            I := Low(W);
            Inc(NestingLevel);
            try
              if L > LineLength then NewLine;
              K := I;
              repeat
                LineBreak := False;
                if (W[I] >= ' ') and (W[I] <> '''') and (Ord(W[i]) <= 127) then
                begin
                  J := I;
                  repeat
                    Inc(I)
                  until (I > L) or (W[I] < ' ') or (W[I] = '''') or
                    ((I - K) >= LineLength) or (Ord(W[i]) > 127);
                  if ((I - K) >= LineLength) then LineBreak := True;
                  WriteAsciiStr('''');
                  while J < I do
                  begin
                    WriteByte(Byte(W[J]));
                    Inc(J);
                  end;
                  WriteAsciiStr('''');
                end else
                begin
                  WriteAsciiStr('#');
                  WriteAsciiStr(IntToStr(Ord(W[I])));
                  Inc(I);
                  if ((I - K) >= LineLength) then LineBreak := True;
                end;
                if LineBreak and (I <= L) then
                begin
                  WriteAsciiStr(' +');
                  NewLine;
                  K := I;
                end;
              until I > L;
            finally
              Dec(NestingLevel);
            end;
          end;
        end;
      vaString, vaLString:
        begin
          S := Reader.ReadString;
          L := High(S);
          if L = High('') then WriteAsciiStr('''''') else
          begin
            I := Low(S);
            Inc(NestingLevel);
            try
              if L > LineLength then NewLine;
              K := I;
              repeat
                LineBreak := False;
                if (S[I] >= ' ') and (S[I] <> '''') then
                begin
                  J := I;
                  repeat
                    Inc(I)
                  until (I > L) or (S[I] < ' ') or (S[I] = '''') or
                    ((I - K) >= LineLength);
                  if ((I - K) >= LineLength) then
                  begin
                    LIneBreak := True;

//                    if ByteType(S, I) = mbTrailByte then Dec(I);
                  end;
                  WriteAsciiStr('''');

                  WriteAsciiStr(S.Substring(J-Low(S), I-J));
                  WriteAsciiStr('''');
                end else
                begin
                  WriteAsciiStr('#');
                  WriteAsciiStr(IntToStr(Ord(S[I])));
                  Inc(I);
                  if ((I - K) >= LineLength) then LineBreak := True;
                end;
                if LineBreak and (I <= L) then
                begin
                  WriteAsciiStr(' +');
                  NewLine;
                  K := I;
                end;
              until I > L;
            finally
              Dec(NestingLevel);
            end;
          end;
        end;
      vaIdent, vaFalse, vaTrue, vaNil, vaNull:
        WriteUTF8Str(Reader.ReadIdent);
      vaBinary:
        ConvertBinary;
      vaSet:
        begin
          Reader.ReadValue;
          WriteAsciiStr('[');
          I := 0;
          while True do
          begin
            S := Reader.ReadStr;
            if S = '' then Break;
            if I > 0 then WriteAsciiStr(', ');
            WriteUtf8Str(S);
            Inc(I);
          end;
          WriteAsciiStr(']');
        end;
      vaCollection:
        begin
          Reader.ReadValue;
          WriteAsciiStr('<');
          Inc(NestingLevel);
          while not Reader.EndOfList do
          begin
            NewLine;
            WriteAsciiStr('item');
            if Reader.NextValue in [vaInt8, vaInt16, vaInt32] then
            begin
              WriteAsciiStr(' [');
              ConvertValue;
              WriteAsciiStr(']');
            end;
            WriteAsciiStr(sLineBreak);
            Reader.CheckValue(vaList);
            Inc(NestingLevel);
            while not Reader.EndOfList do
              ConvertProperty;
            Reader.ReadListEnd;
            Dec(NestingLevel);
            WriteIndent;
            WriteAsciiStr('end');
          end;
          Reader.ReadListEnd;
          Dec(NestingLevel);
          WriteAsciiStr('>');
        end;
      vaInt64:
        WriteAsciiStr(IntToStr(Reader.ReadInt64));
    else
      raise EReadError.CreateResFmt(@sPropertyException,
        [ObjectName, DotSep, PropName, IntToStr(Ord(Reader.NextValue))]);
    end;
  end;

  procedure ConvertProperty;
  begin
    WriteIndent;
    PropName := Reader.ReadStr;  // save for error reporting
    WriteUTF8Str(PropName);
    WriteAsciiStr(' = ');
    ConvertValue;
    WriteAsciiStr(sLineBreak);
  end;

  procedure ConvertObject;
  begin
    //二进制格式，转txt

    //这部分是声明
    ConvertHeader;
    //层级
    Inc(NestingLevel);

    //写入属性
    while not Reader.EndOfList do
      ConvertProperty;
    Reader.ReadListEnd;

    //写入子控件
    while not Reader.EndOfList do
      ConvertObject;
    Reader.ReadListEnd;

    Dec(NestingLevel);
    WriteIndent;
    WriteAsciiStr('end' + sLineBreak);
  end;

begin
  NestingLevel := 0;
  UTF8Idents := False;
  Reader := TReader.Create(Input, 4096);
  LFormatSettings := TFormatSettings.Create('en-US'); // do not localize
  LFormatSettings.DecimalSeparator := '.';
  try
    MemoryStream := TMemoryStream.Create;
    try
      Writer := TWriter.Create(MemoryStream, 4096);
      try
        Reader.ReadSignature;
        ConvertObject;
      finally
        Writer.Free;
      end;

//      if UTF8Idents then
//        Output.Write(TEncoding.UTF8.GetPreamble[0], 3);
//      Output.Write(MemoryStream.Memory^, MemoryStream.Size);

    finally
      MemoryStream.Free;
    end;
  finally
    Reader.Free;
  end;
end;





function GetImageUrl(APicPath:String;
                      AImageHttpServerUrl:String//;
                      //AImageType:TImageType=itNone;
                      //AIsThumb:Boolean=False
                      ):String;
var
  ATempIndex:Integer;
begin
  Result:='';
//  if APicPath='' then
//  begin
//      case AImageType of
//        itNone: ;
//        itUserHead:
//        begin
//          Result:=GetDefaultUserHeadUrl;
//        end;
//      end;
//  end
//  else
//  begin
      if (Pos('http:',LowerCase(APicPath))>0)
        or (Pos('https:',LowerCase(APicPath))>0) then
      begin
          Result:=APicPath;
      end
      else
      begin
          APicPath:=AImageHttpServerUrl+'/'+ReplaceStr(APicPath,'\','/');


//          {$IF CompilerVersion > 21.0} // XE or older
//          if AIsThumb then
//          begin
//            //处理下  改成缩略图的路径    原图占内存太大了
//            ATempIndex:=APicPath.LastIndexOf('/');
//            APicPath:=APicPath.Substring(0,ATempIndex+1)
//                          +'thumb_'
//                          +APicPath.Substring(ATempIndex+1);
////            APicPath:=ExtractFilePath(APicPath)+'thumb_'+ExtractFileName(APicPath);
//          end;
//          {$IFEND}

          Result:=APicPath;
      end;
//  end;
end;



////给图片字段加上链接
//procedure AddImageHttpServerUrlToPicPath(AJsonArray:ISuperArray;AImageHttpServerUrl:String);
//var
//  I: Integer;
//begin
//  for I := 0 to AJsonArray.Length-1 do
//  begin
//    AddImageHttpServerUrlToPicPath(AJsonArray.O[I],AImageHttpServerUrl);
//  end;
//end;
//


{ TPage }

procedure TPage.AssignTo(Dest: TPersistent);
var
  ADest:TPage;
  I: Integer;
  AFieldControlSetting:TFieldControlSetting;
begin
  if (Dest<>nil) and (Dest is TPage) then
  begin
      ADest:=TPage(Dest);

      //程序模板
      ADest.ProgramTemplate:=ProgramTemplate;


  //    //服务端
  //    DataServer:TDataServer;


//      //接口
//      if ADest.DataInterface<>nil then
//      begin
//        ADest.DataInterface.Assign(DataInterface);
//      end;
//      if ADest.DataInterface2<>nil then
//      begin
//        ADest.DataInterface2.Assign(DataInterface2);
//      end;


  //    //功能模块
  //    DataFunction:TDataFunction;
  //    //页面
  //    Page:TPage;





      ADest.fid:=fid;
      ADest.Fappid:=Self.Fappid;
      ADest.Fuser_fid:=Self.Fuser_fid;





      //所属的程序模块
      ADest.program_template_fid:=program_template_fid;
      ADest.program_template_name:=program_template_name;


      //所调用的接口
//      ADest.data_intf_fid:=data_intf_fid;
      ADest.data_intf_name:=data_intf_name;


      //所调用的接口
//      ADest.data_intf_fid2:=data_intf_fid2;
      ADest.data_intf_name2:=data_intf_name2;



      //所属的功能
      ADest.function_fid:=function_fid;
      ADest.function_name:=function_name;




      //页面的名称
      ADest.name:=name;
      //页面的标题
      ADest.caption:=caption;


      //排列布局类型,
      //manual手动布局,
      //auto自动布局
      ADest.align_type:=align_type;


      //页面类型
      ADest.page_type:=page_type;
      //平台
      ADest.platform:=platform;


      ADest.design_width:=design_width;
      ADest.design_height:=design_height;


      ADest.refresh_seconds:=refresh_seconds;






      //加载接口1需要的参数
      ADest.load_data_params:=load_data_params;
      //保存接口1所需要的参数
      ADest.save_data_params:=save_data_params;


      //加载接口2需要的参数
      ADest.load_data_params2:=load_data_params2;
      //保存接口2所需要的参数
      ADest.save_data_params2:=save_data_params2;





//      //默认列表项的显示风格
//      ADest.default_list_item_style:=default_list_item_style;
//      //默认列表项的绑定设置
//      ADest.default_list_item_bindings:=default_list_item_bindings;




      ADest.MainLayoutControlList.Clear();
      for I := 0 to Self.MainLayoutControlList.Count-1 do
      begin
        AFieldControlSetting:=TFieldControlSetting.Create(ADest.MainLayoutControlList);
        AFieldControlSetting.Assign(MainLayoutControlList[I]);
  //      ADest.MainLayoutControlList.Add(AFieldControlSetting);
      end;


//      ADest.BottomToolbarLayoutControlList.Clear();
//      for I := 0 to Self.BottomToolbarLayoutControlList.Count-1 do
//      begin
//        AFieldControlSetting:=TFieldControlSetting.Create(ADest.BottomToolbarLayoutControlList);
//        AFieldControlSetting.Assign(BottomToolbarLayoutControlList[I]);
//  //      ADest.BottomToolbarLayoutControlList.Add(AFieldControlSetting);
//      end;




      //列表页面，或者界面控件布局//
      //每行列数
      ADest.item_col_count:=item_col_count;
      //每列宽度
      ADest.item_col_width:=item_col_width;
      //行高
      ADest.item_height:=item_height;




      //列表页面相关设置//
      //是否是默认的ListPage,
      //如果是就创建一个默认的ListView
//      ADest.is_simple_list_page:=is_simple_list_page;
//      //列表页面是否需要添加记录按钮
//      ADest.has_add_record_button:=has_add_record_button;


//      ADest.FDataSkinItems.Assign(FDataSkinItems);




//      //做为列表项样式时的默认值
//      ADest.list_item_style_default_height:=list_item_style_default_height;
//      ADest.list_item_style_autosize:=list_item_style_autosize;
//      ADest.list_item_style_default_width:=list_item_style_default_width;




  end;

end;

//procedure TPage.CallLoadDataIntf(APageInstance: TObject;
//  //APageStructure: TPage;
//  //ADataInterface: TDataInterface;
//  ALoadDataIntfResult: TDataIntfResult;
//  ALoadDataIntfResult2: TDataIntfResult;
//  ALoadDataSetting: TLoadDataSetting//;
//  //ALoadDataParams: String
//  );
//begin
//      if Assigned(Self.OnCustomCallLoadDataIntf) then
//      begin
//          //自定义调用接口
//          Self.OnCustomCallLoadDataIntf(Self,
//                                        APageInstance,
//                                        ALoadDataSetting,
//                                        ALoadDataIntfResult
//                                        );
//      end
//      else
//      begin
//          //调用接口
//          if (Self.DataInterface<>nil) and not Self.DataInterface.IsEmpty then
//          begin
//              APageInstance.CallLoadDataIntf(Self,
//                                            Self.DataInterface,
//                                            ALoadDataIntfResult,
//                                            ALoadDataSetting,
//                                            //加入,合并,WhereKeyJson
//                                            Self.load_data_params
//                                            );
//          end
//          else
//          begin
//              ALoadDataIntfResult.Desc:='接口不能为空!';
//              uBaseLog.HandleException(nil,'TPageInstance.DoLoadDataTaskExecute 接口不能为空');
//              raise Exception.Create('接口不能为空');
//          end;
//      end;
//
//
//
//
//      //调用接口2
//      if (Self.DataInterface2<>nil) and (not Self.DataInterface2.IsEmpty) then
//      begin
//          APageInstance.CallLoadDataIntf(Self,
//                                          Self.DataInterface2,
//                                          ALoadDataIntfResult2,
//                                          ALoadDataSetting,
//                                          //加入,合并,加入WhereKeyJson
//                                          Self.load_data_params2
//                                          );
//      end
//      else
//      begin
//          //接口2可以为空
////          uBaseLog.HandleException(nil,'TPageInstance.DoLoadDataTaskExecute 接口2为空');
//      end;
//
//
//
//      //如果是编辑页面,那么要获取下拉框的选项值
//      //将options_page_value_field_name,options_page_caption_field_name
//      //的值取出来,放入options_value,options_caption
//      //options_caption	nvarchar(255)	选项的标题,用于显示,比如男,女
//      //options_value	nvarchar(255)	选项的值,用于保存到数据,比如male,female
//      //options_is_multi_select	int	是否支持多选
//      //
//      //options_page_fid	int	选择选项的列表页面fid,它里面包含数据接口
//      //options_page_value_field_name	nvarchar(45)	选择选项列表页面的值字段
//      //options_page_caption_field_name	nvarchar(45)	选择选项列表页面的标题字段
//      //options_has_empty	int	是否拥有空的选项
//      //options_empty_value	nvarchar(45)
//      //options_empty_caption	nvarchar(45)
//      //获取页面结构,然后获取页面数据列表
////      for I := 0 to Self.PageStructure.MainLayoutControlList.Count-1 do
////      begin
////        if Self.PageStructure.MainLayoutControlList[I].options_page_fid>0 then
////        begin
////          //需要取页面的数据
////
////        end;
////      end;
//end;

procedure TPage.CallSaveDataIntf(APageInstance: TObject;
  ASaveDataIntfResult: TDataIntfResult;
  ASaveDataSetting: TSaveDataSetting;var AIsNeedCallDefault:Boolean);
begin
//          if Assigned(Self.OnCustomCallSaveDataIntf) then
//          begin
//             Self.OnCustomCallSaveDataIntf(Self,
//                                            APageInstance,
//                                            ASaveDataSetting,
//                                            ASaveDataIntfResult
//                                            );
//              if ASaveDataIntfResult.Succ then
//              begin
////                  TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
//              end;
//
//          end
//          else
//          begin
//
//              //将接口保存到数据库
//              if Self.DataInterface.SaveData(ASaveDataSetting,ASaveDataIntfResult) then
//    //          SaveRecordToServer(GlobalMainProgramSetting.DataServerUrl,
//    //                                GlobalMainProgramSetting.AppID,
//    //                                0,
//    //                                '',
//    //                                Self.PageStructure.DataInterface.Name,
//    //                                Self.FCurrentRecordDataIntfResult.DataJson.I['fid'],
//    //                                ARecordDataJson,
//    //                                AIsAdd,
//    //                                ADesc,
//    //                                ADataJson)
//    //
//    //                                then
//              begin
//    //              //保存成功,要取出新增记录的fid
//    //              if AIsAdd then
//    //              begin
//    //                FPage.DataInterface.fid:=ADataJson.I['fid'];
//    //              end;
////                  TTimerTask(ATimerTask).TaskDesc:=FSaveDataIntfResult.Desc;
////                  TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
//              end
//              else
//              begin
//            //      ShowMessage(ADesc);
////                  TTimerTask(ATimerTask).TaskDesc:=FSaveDataIntfResult.Desc;
//                  Exit;
//              end;
//
//          end;


end;

procedure TPage.ChangeName(ANewName: String);
var
  ADesc:String;
begin
  uPageCommon.change_page_file_name(Self.GetPageParentDir,IntToStr(fid),name,ANewName,ADesc);
  Self.name:=ANewName;
  if (FJson<>nil) then
  begin
    FJson.S['name']:=ANewName;
  end;

end;

function TPage.CheckUserSettingIsFull(AUserPageSettingJson:ISuperObject;var ADesc: String): Boolean;
var
  ACode:Integer;
  I: Integer;
  AControlJson:ISuperObject;
begin
  Result:=False;
  ADesc:='';
  //如果页面有参数需要,有组件需要输入，但是没有输入,则必须提示出来
  if (Self.FStructureJson.A['controls'].Length=0) then
  begin
    Result:=True;
    Exit;
  end;

  if AUserPageSettingJson=nil then
  begin
    ADesc:='参数未设置';
    Exit;
  end;


  //判断有没有都输入
  for I := 0 to Self.FStructureJson.A['controls'].Length-1 do
  begin
    AControlJson:=Self.FStructureJson.A['controls'].O[I];
    if not AUserPageSettingJson.Contains(AControlJson.S['name'])
      or (VarToStr(AUserPageSettingJson.V[AControlJson.S['name']])='') then
    begin
      if ADesc<>'' then ADesc:=ADesc+',';
      ADesc:=ADesc+AControlJson.S['name']+'未设置';
    end;
  end;

  Result:=(ADesc='');


end;

procedure TPage.ClearFid;
var
  I:Integer;
begin
  Self.fid:=0;

//  Self.data_intf_fid:=0;
  Self.data_intf_name:='';

//  Self.data_intf_fid2:=0;
  Self.data_intf_name2:='';

//  if Self.DataInterface<>nil then Self.DataInterface.fid:=0;
//  if Self.DataInterface2<>nil then Self.DataInterface2.fid:=0;

  for I := 0 to Self.MainLayoutControlList.Count-1 do
  begin
    MainLayoutControlList[I].ClearFid;
  end;

//  for I := 0 to Self.BottomToolbarLayoutControlList.Count-1 do
//  begin
//    BottomToolbarLayoutControlList[I].ClearFid;
//  end;

end;

constructor TPage.Create(AOwner: TComponent);
begin
  inherited;

  //设计器里设计时的宽度和高度
  design_width:=300;
  design_height:=500;

//  FDataSkinItems:=TSkinItems.Create;



//  ProgramTemplate:=TProgramTemplate.Create;
//  DataServer:=TDataServer.Create;
//  DataInterface:=TDataInterface.Create;
//  DataFunction:=TDataFunction.Create;
//  Page:=TPage.Create;



//  FDefaultListItemBindings:=TListItemBindings.Create(TListItemBindingItem);



//  //列表页面的表格列列表
//  PageColumns:=TPageColumns.Create;





  //页面的控件列表
  FMainLayoutControlList:=TPageFieldControlSettingList.Create(TPageFieldControlSetting,Self);
//  //页面其他区域的控件
//  FBottomToolbarLayoutControlList:=TFieldControlSettingList.Create;




  FLayoutSettingList:=TLayoutSettingList.Create;

  //主控件排列设置
  MainLayoutSetting:=TLayoutSetting.Create;
  MainLayoutSetting.name:='main';
//  MainLayoutSetting.FPagePart:=Const_PagePart_Main;
  MainLayoutSetting.align_type:=Const_PageAlignType_Auto;
  FLayoutSettingList.Add(MainLayoutSetting);



  //底部工具栏的设置
  BottomToolbarLayoutSetting:=TLayoutSetting.Create;
  BottomToolbarLayoutSetting.name:=Const_PagePart_BottomToolbar;//'bottom_toolbar';
  BottomToolbarLayoutSetting.align_type:=Const_PageAlignType_Auto;
  BottomToolbarLayoutSetting.col_width:=120;
//  BottomToolbarLayoutSetting.row_height:=-2;
  BottomToolbarLayoutSetting.row_height:=32;
  BottomToolbarLayoutSetting.row_space:=6;
  BottomToolbarLayoutSetting.margins_top:=6;
//  BottomToolbarLayoutSetting.FPagePart:=Const_PagePart_BottomToolbar;
  FLayoutSettingList.Add(BottomToolbarLayoutSetting);


  //顶部工具栏的设置
  TopToolbarLayoutSetting:=TLayoutSetting.Create;
  TopToolbarLayoutSetting.name:=Const_PagePart_TopToolbar;//'top_toolbar';
  TopToolbarLayoutSetting.align_type:=Const_PageAlignType_Auto;
  TopToolbarLayoutSetting.col_width:=120;
//  TopToolbarLayoutSetting.row_height:=-2;
  TopToolbarLayoutSetting.row_height:=32;
  TopToolbarLayoutSetting.row_space:=6;
  TopToolbarLayoutSetting.margins_top:=6;
//  TopToolbarLayoutSetting.hint_label_width:=100;
//  TopToolbarLayoutSetting.FPagePart:=Const_PagePart_TopToolbar;
  FLayoutSettingList.Add(TopToolbarLayoutSetting);






  data_intf_key_field:='fid';


//  //加载需要的参数
//  LoadDataParamsJsonArray:=TSuperArray.Create;
//  //保存所需要的参数
//  SaveDataParamsJsonArray:=TSuperArray.Create;


//  if (Self.data_intf_class='') and (GlobalDataInterfaceClass<>nil) then
//  begin
//      FDataInterface:=GlobalDataInterfaceClass.Create;
//    //  if DataInterface is TCommonRestIntfItem then
//    //  begin
//    //
//    //  end;
//
//
//      FDataInterface2:=GlobalDataInterfaceClass.Create;
//        //TCommonRestIntfItem.Create(nil);
//  end
//  else
//  begin
//      //Raise Exception.Create('GlobalDataInterfaceClass不能为空');
//  end;


  //是否使用默认的uOpenClientCommon中的InterfaceUrl
  FIsUseDefaultImageHttpServerUrl:=True;


//  //做为列表项样式时的默认值
//  list_item_style_default_height:=-1;
//  list_item_style_autosize:=0;
//  list_item_style_default_width:=-1;

  FIsNeedCommonEditButton:=True;


  //脚本
  FScriptList:=TStringList.Create;

  FStructureJson:=SO();
end;

function TPage.SaveScriptToServer(AScriptLanguage:String;var ADesc: String): Boolean;
var
  I: Integer;
  AControlRecordJson:ISuperObject;
  ASuperArray:ISuperArray;
  ADataIntfJson:ISuperObject;
var
  AIsAdd:Boolean;
  ACode:Integer;
  ADataJson:ISuperObject;
  APostStream:TMemoryStream;
  AResponseStream:TStringStream;
//  AMultipartFormData:TMultipartFormData;
  AUpdateRecordJson:ISuperObject;
begin
  uBaseLog.HandleException(nil,'TPage.SaveScriptToServer Begin');

  if AScriptLanguage='python' then
  begin
//    {$IFDEF FMX}
    //备份文件
    if FileExists(GetPageDataDir+Self.name+'.py') then
    begin
      ForceDirectories(GetPageDataDir+'backup\');
  //    System.IOUtils.TFile.Move(GetPageDataDir+Self.name+'.json',GetPageDataDir+'backup\'+Self.name+' '+FormatDateTime('YYYY-MM-DD HH-MM-SS-ZZZ',Now)+'.json');
      System.IOUtils.TFile.Copy(GetPageDataDir+Self.name+'.py',GetPageDataDir+'backup\'+Self.name+' '+FormatDateTime('YYYY-MM-DD HH-MM-SS-ZZZ',Now)+'.py');
    end;
//    {$ENDIF}


    //保存成文件
    Self.FScriptList.SaveToFile(Self.GetPageDataDir+Self.name+'.py',TEncoding.UTF8);

    AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
    APostStream:=TMemoryStream.Create;
    try
      APostStream.LoadFromFile(Self.GetPageDataDir+Self.name+'.py');
      APostStream.Position:=0;

//      AMultipartFormData:=TMultipartFormData.Create;
//      AMultipartFormData.AddFile('page_code',Self.GetPageDataDir+Self.name+'.py');
//
//      AMultipartFormData.Stream.Position:=0;
      if not SimpleCallAPI('save_page_code2',
                    nil,
                    uOpenClientCommon.InterfaceUrl+'program_framework/',
                    [
                    'key','program_fid','page_name','file_name'
                    ],
                    [
                    GlobalBaseManager.User.key,Self.program_template_fid,Self.Name,Self.Name+'.py'
                    ],
                    ACode,
                    ADesc,
                    ADataJson,
                    GlobalRestAPISignType,
                    GlobalRestAPIAppSecret,
                    True,
                    APostStream//AMultipartFormData.Stream
                    ) or (ACode<>SUCC) then
      begin
        Exit;
      end;

    finally
//      FreeAndNil(AMultipartFormData);
      FreeAndNil(AResponseStream);
      FreeAndNil(APostStream);
    end;
  end;



  if AScriptLanguage='javascript' then
  begin
//    {$IFDEF FMX}
    //备份文件
    if FileExists(GetPageDataDir+Self.name+'.js') then
    begin
      ForceDirectories(GetPageDataDir+'backup\');
  //    System.IOUtils.TFile.Move(GetPageDataDir+Self.name+'.json',GetPageDataDir+'backup\'+Self.name+' '+FormatDateTime('YYYY-MM-DD HH-MM-SS-ZZZ',Now)+'.json');
      System.IOUtils.TFile.Copy(GetPageDataDir+Self.name+'.js',GetPageDataDir+'backup\'+Self.name+' '+FormatDateTime('YYYY-MM-DD HH-MM-SS-ZZZ',Now)+'.js');
    end;
//    {$ENDIF}


    //保存成文件
    Self.FScriptList.SaveToFile(Self.GetPageDataDir+Self.name+'.js',TEncoding.UTF8);


    AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
    APostStream:=TMemoryStream.Create;

//    AMultipartFormData:=TMultipartFormData.Create;
//    AMultipartFormData.AddFile('page_code',Self.GetPageDataDir+Self.name+'.js');
//
//
//    AMultipartFormData.Stream.Position:=0;
    try
      APostStream.LoadFromFile(Self.GetPageDataDir+Self.name+'.py');
      APostStream.Position:=0;

      if not SimpleCallAPI('save_page_code2',
                    nil,
                    uOpenClientCommon.InterfaceUrl+'program_framework/',
                    [
                    'key','program_fid','page_name','file_name'
                    ],
                    [
                    GlobalBaseManager.User.key,Self.program_template_fid,Self.Name,Self.Name+'.js'
                    ],
                    ACode,
                    ADesc,
                    ADataJson,
                    GlobalRestAPISignType,
                    GlobalRestAPIAppSecret,
                    True,
                    APostStream//AMultipartFormData.Stream
                    ) or (ACode<>SUCC) then
      begin
        Exit;
      end;

    finally
//      FreeAndNil(AMultipartFormData);
      FreeAndNil(APostStream);
      FreeAndNil(AResponseStream);
    end;
  end;


  //保存页面的脚本类型
//  if AScriptLanguage<>FScriptLanguage then
//  begin
    FScriptLanguage:=AScriptLanguage;

    AUpdateRecordJson:=SO();
    AUpdateRecordJson.S['script_language']:=FScriptLanguage;
    //保存修改时间,以便不需要每次都更新脚本
    AUpdateRecordJson.S['updatetime']:=StdDateTimeToStr(Now);

    if SaveRecordToServer(InterfaceUrl,
                            AppID,
                            GlobalBaseManager.User.fid,
                            GlobalBaseManager.User.key,
                            'page',
                            Self.fid,
                            AUpdateRecordJson,
                            //返回是否是新增的记录
                            AIsAdd,
                            ADesc,
                            ADataJson,
                            '',
                            '') then
    begin
      if FJson<>nil then
      begin
        FJson.S['script_language']:=FScriptLanguage;
      end;
    end
    else
    begin
  //    ShowMessage(ADesc);
      Exit;
    end;

//  end;


  Result:=True;
  uBaseLog.HandleException(nil,'TPage.SaveScriptToServer End');

end;

procedure TPage.SaveControlToFMXFile(APageDesignerControl: TControl;
  AFMXFile: String);
var
  AFMXOutputStream:TMemoryStream;
begin
  AFMXOutputStream:=TMemoryStream.Create;
  try
    SaveControlToFMXStream(APageDesignerControl,AFMXOutputStream);
    AFMXOutputStream.SaveToFile(AFMXFile);
  finally
    FreeAndNil(AFMXOutputStream);
  end;

end;

procedure TPage.SaveControlToFMXStream(APageDesignerControl:TControl;AFMXOutputStream:TStream);
var
  S: TMemoryStream;
  W: TWriter;
  I: Integer;
//  T: TMemoryStream;
begin
  S := TMemoryStream.Create;
//  T := TMemoryStream.Create;
  try
    W := TWriter.Create(S, 1024);
    try
      W.Root := APageDesignerControl;

      W.WriteSignature;
      W.WriteComponent(APageDesignerControl);

//      for I := 0 to APageDesignerControl.ComponentCount - 1 do
//      begin
//        W.WriteSignature;
//        W.WriteComponent(TComponent(APageDesignerControl.Components[I]));
//      end;
      W.WriteListEnd;
    finally
      W.Free;
    end;
    S.Position:=0;
    ObjectBinaryToText(S, AFMXOutputStream);
    //T.SaveToFile(AFMXFile);
  finally
    S.Free;
//    T.Free;
  end;
end;

//procedure TPage.SaveControlToJsonFile(APageDesignerControl:TControl;AJsonFile:String);
//var
//  AJson:ISuperObject;
//begin
//  Self.SaveControlToJson(APageDesignerControl,AJson);
//  SaveStringToFile(AJson.AsJSON,AJsonFile,TEncoding.UTF8);
//
//end;
//
//procedure TPage.SaveControlToJson(APageDesignerControl: TControl;
//  var AJson: ISuperObject);
////var
////  AFMXOutputStream:TStream;
//begin
////  AFMXOutputStream:=TMemoryStream.Create;
////  try
////    SaveControlToFMXStream(APageDesignerControl,AFMXOutputStream);
////    AFMXOutputStream.Position:=0;
////    ObjectBinaryToJson(AFMXOutputStream, AJson);
////  finally
////    FreeAndNil(AFMXOutputStream);
////  end;
//
//
////  //会报错,如果属性是nil，则保存失败
////  AJson:=APageDesignerControl.AsJSONObject;
//
//
//
//end;

function TPage.CreatePageDesignerControlByFMX(AFMXFile:String):TControl;
begin
  //判断是form还是Frame,这得根据pas文件来决定吧
  //先用Frame来测试吧
  //Result:=TFrame.Create(nil);

end;
//
////从页面文件创建控件实例
//function TPage.CreatePageDesignerControlByPage():TControl;
//var
//  I: Integer;
//  AError:String;
//  AComponent:TControl;
//  APageDataDir:String;
//  APageInstance:TPageInstance;
//  APageDesignControl:TPageDesignPanel;
//begin
//  uBaseLog.HandleException(nil,'TFramePageDesign.LoadPage');
//
////  FPage:=APage;
//
//  APageInstance:=TPageInstance.Create(nil);
//  APageInstance.PageStructure:=Self;
//
//
//
//
//
//  APageDesignControl:=TPageDesignPanel.Create(nil);
//  APageDesignControl.Parent:=nil;
//  APageDesignControl.Width:=320;
//  APageDesignControl.Height:=480;
//  //不能移动,只能右下移动大小
//  //APageDesignControl.OnMouseDown:=DoPageLayoutMouseDown;
//
//
//  APageDesignControl.FPage:=Self;
//  APageDesignControl.Name:=Self.name;
//
//
////  //清除控件
////  for I := Self.FPageDesignControl.ControlsCount-1 downto 0 do
////  begin
////    AComponent:=Self.FPageDesignControl.Controls[I];
////
////    AComponent.Parent:=nil;
////    AComponent.Visible:=False;
////    FreeAndNil(AComponent);
////  end;
//
//  //页面数据所在的路径
//  APageDataDir:=Self.GetPageDataDir;
//
//
//  //设置页面设计时尺寸
//  if BiggerDouble(Self.design_width,0)
//    and BiggerDouble(Self.design_height,0) then
//  begin
//    APageDesignControl.Width:=Self.design_width+APageDesignControl.Padding.Left*2;
//    APageDesignControl.Height:=Self.design_height+APageDesignControl.Padding.Bottom*2;
//  end
//  else
//  begin
//    //默认尺寸
//    APageDesignControl.Width:=320+APageDesignControl.Padding.Left*2;
//    APageDesignControl.Height:=480+APageDesignControl.Padding.Bottom*2;
//  end;
//
//
//  //将所有控件的状态设置为设计时
//
//  //创建控件在FPageDesignControl上面
//  APageInstance.CreateControls(
//          APageDesignControl,
//          APageDesignControl,
//          '',
//          APageDataDir,
//          //是否是设计时
//          True,
//          AError
//          );
//
//
//  //设计时
////  FPageDesignControl.SetDesign(True);
//
//  Result:=APageDesignControl;
//
//end;
//

function TPage.LoadDataFromLocal(var ADesc: String): Boolean;
var
  I:Integer;
  ASuperObject:ISuperObject;
  AFieldControlSetting:TFieldControlSetting;
begin
//      if not SimpleCallAPI(
//                          'get_record2',
//                          nil,
//                          InterfaceUrl+'tablecommonrest/',
//                          ConvertToStringDynArray([
//                                                  'key',
//                                                  'rest_name',
//                                                  'fid'
//                                                  ]),
//                          ConvertToVariantDynArray([
//                                                  GlobalBaseManager.user.key,
//                                                  'page_no_function',
//                                                  fid
//                                                  ]),
//                          ACode,
//                          ADesc,
//                          ADataJson,
//                          GlobalRestAPISignType,
//                          GlobalRestAPIAppSecret) or (ACode<>SUCC) then
//      begin
//        Exit;
//      end;

  Result:=False;

  ASuperObject:=SO(GetStringFromFile(Self.GetPageDataDir+name+'.json',TEncoding.UTF8));
  FStructureJson:=ASuperObject;
  //控件列表
  Self.MainLayoutControlList.Clear;
  for I := 0 to ASuperObject.A['controls'].Length-1 do
  begin

      AFieldControlSetting:=MainLayoutControlList.Add;
      if not TPageFieldControlSetting(AFieldControlSetting).LoadFromJson(ASuperObject.A['controls'].O[I]) then
      begin
        //Exit;
      end;
//      MainLayoutControlList.Add(AFieldControlSetting);
  end;




    //  //工具栏的控件列表
    //  Self.BottomToolbarLayoutControlList.Clear;
    //  for I := 0 to ASuperObject.A['controls'].Length-1 do
    //  begin
    //
    //      if ASuperObject.A['other_page_part_controls'].O[I].S['page_part']=Const_PagePart_BottomToolbar then
    //      begin
    //          AFieldControlSetting:=TFieldControlSetting.Create(BottomToolbarLayoutControlList);
    //          if not AFieldControlSetting.LoadFromJson(ASuperObject.A['other_page_part_controls'].O[I]) then
    //          begin
    //            Exit;
    //          end;
    //
    ////          BottomToolbarLayoutControlList.Add(AFieldControlSetting);
    //      end;
    //  end;


  //MainLayoutControlList.LoadFromJson后面
  //控件列表加载结束事件
  LoadLayoutControlListEnd;

  //下载界面Json和代码
  //如果下载失败,那就是服务端不支持python格式的下载，改kbmmw的代码即可
//     //wn kbmMWHTTPUtils.pas 添加下载Python脚本的功能
//     Add('PY','text/plain',true);

//  if Self.FScriptLanguage='python' then
//  begin
    if FileExists(Self.GetPageDataDir+name+'.py') then
    begin
      Self.FScriptList.LoadFromFile(Self.GetPageDataDir+name+'.py',TEncoding.UTF8);
      Self.FScriptLanguage:='python';
    end;

//  end;


  //下载界面Json和代码
  if Self.FScriptLanguage='javascript' then
  begin
      Self.FScriptList.LoadFromFile(Self.GetPageDataDir+name+'.js',TEncoding.UTF8);
      Self.FScriptLanguage:='javascript';
  end;


//  ANetHttpClient:=TNetHTTPClient.Create(nil);
//  AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
//  try
//    //http://127.0.0.1:10060/programs/11/page1/page1.json
//    ANetHttpClient.Get(InterfaceUrl+'programs/'+IntToStr(Self.program_template_fid)+'/'+name+'/'+name+'.js',AResponseStream);
//
//    //Internal Server Error
//    //不存在
//    if TStringStream(AResponseStream).DataString<>'Internal Server Error' then
//    begin
//      AResponseStream.Position:=0;
//      TStringStream(AResponseStream).SaveToFile(Self.GetPageDataDir+name+'.js');
//
//      Self.FScriptList.LoadFromFile(Self.GetPageDataDir+name+'.js',TEncoding.UTF8);
//      Self.FScriptLanguage:='javascript';
//
//
//      //判断有没有引用其他页面,有的话也一并下载
//      //import public
//      //import login
//
//
//    end;
//
//  finally
//    FreeAndNil(ANetHttpClient);
//    FreeAndNil(AResponseStream);
//  end;

  Result:=True;


end;

function TPage.LoadDataFromServer(var ADesc: String): Boolean;
var
  I:Integer;
  ACode:Integer;
  AUrl:String;
  ADataJson:ISuperObject;
  AResponseStream:TStringStream;
  ASuperObject:ISuperObject;
  ANetHttpClient:TNetHttpClient;
  AHTTPResponse:IHTTPResponse;
  AFieldControlSetting:TFieldControlSetting;
begin
//      if not SimpleCallAPI(
//                          'get_record2',
//                          nil,
//                          InterfaceUrl+'tablecommonrest/',
//                          ConvertToStringDynArray([
//                                                  'key',
//                                                  'rest_name',
//                                                  'fid'
//                                                  ]),
//                          ConvertToVariantDynArray([
//                                                  GlobalBaseManager.user.key,
//                                                  'page_no_function',
//                                                  fid
//                                                  ]),
//                          ACode,
//                          ADesc,
//                          ADataJson,
//                          GlobalRestAPISignType,
//                          GlobalRestAPIAppSecret) or (ACode<>SUCC) then
//      begin
//        Exit;
//      end;

  Result:=False;


  //下载界面Json和代码
  ANetHttpClient:=TNetHTTPClient.Create(nil);
  AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
  try
    try
      //http://127.0.0.1:10060/programs/11/page1/page1.json
//      AUrl:=InterfaceUrl+'programs/'+IntToStr(Self.program_template_fid)+'/'+name+'/'+name+'.json';
      AUrl:=InterfaceUrl+'program_framework/get_page_file?'
          +UnionUrlParams(['key','program_fid','page_name','file_name'],
                          [GlobalBaseManager.User.key,program_template_fid,Name,Name+'.json']);
      uBaseLog.HandleException(nil,'TPage.LoadDataFromServer begin download page json:'+AUrl);


      AHTTPResponse:=ANetHttpClient.Get(AUrl,AResponseStream);

      //'File pool not specified.'
      AResponseStream.Position:=0;
      TMemoryStream(AResponseStream).SaveToFile(Self.GetPageDataDir+name+'.json'+'.response');
      AResponseStream.Position:=0;

      //不存在  Internal Server Error 'HTTP/1.1 404 Not Found'#$D#$A'Cache-Control:no-cache,no-'
      if (AHTTPResponse.StatusCode=200)
        and (TStringStream(AResponseStream).DataString<>'Internal Server Error')
        and (Copy(TStringStream(AResponseStream).DataString,1,1)='{') then
      begin
        AResponseStream.Position:=0;
        TMemoryStream(AResponseStream).SaveToFile(Self.GetPageDataDir+name+'.json');
        ASuperObject:=SO(AResponseStream.DataString);
        FStructureJson:=ASuperObject;
        //控件列表
        Self.MainLayoutControlList.Clear;
        for I := 0 to ASuperObject.A['controls'].Length-1 do
        begin

            AFieldControlSetting:=MainLayoutControlList.Add;
            if not TPageFieldControlSetting(AFieldControlSetting).LoadFromJson(ASuperObject.A['controls'].O[I]) then
            begin
              //Exit;
            end;
      //      MainLayoutControlList.Add(AFieldControlSetting);
        end;
      end;




    //  //工具栏的控件列表
    //  Self.BottomToolbarLayoutControlList.Clear;
    //  for I := 0 to ASuperObject.A['controls'].Length-1 do
    //  begin
    //
    //      if ASuperObject.A['other_page_part_controls'].O[I].S['page_part']=Const_PagePart_BottomToolbar then
    //      begin
    //          AFieldControlSetting:=TFieldControlSetting.Create(BottomToolbarLayoutControlList);
    //          if not AFieldControlSetting.LoadFromJson(ASuperObject.A['other_page_part_controls'].O[I]) then
    //          begin
    //            Exit;
    //          end;
    //
    ////          BottomToolbarLayoutControlList.Add(AFieldControlSetting);
    //      end;
    //  end;


      //MainLayoutControlList.LoadFromJson后面
      //控件列表加载结束事件
      LoadLayoutControlListEnd;
    except
      on E:Exception do
      begin
        uBaseLog.HandleException(E,'TPage.LoadDataFromServer download page json error:'+AUrl);
      end;
    end;

  finally
    FreeAndNil(ANetHttpClient);
    FreeAndNil(AResponseStream);
  end;


  //下载界面Json和代码
  //如果下载失败,那就是服务端不支持python格式的下载，改kbmmw的代码即可
//     //wn kbmMWHTTPUtils.pas 添加下载Python脚本的功能
//     Add('PY','text/plain',true);

  if Self.FScriptLanguage='python' then
  begin
      ANetHttpClient:=TNetHTTPClient.Create(nil);
      AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
      try
        try

          //http://127.0.0.1:10060/programs/11/page1/page1.json
//          AUrl:=InterfaceUrl+'programs/'+IntToStr(Self.program_template_fid)+'/'+name+'/'+name+'.py';
          AUrl:=InterfaceUrl+'program_framework/get_page_file?'
              +UnionUrlParams(['key','program_fid','page_name','file_name'],
                              [GlobalBaseManager.User.key,program_template_fid,Name,Name+'.py']);


          uBaseLog.HandleException(nil,'TPage.LoadDataFromServer begin download page python:'+AUrl);
          AHTTPResponse:=ANetHttpClient.Get(AUrl,AResponseStream);


          AResponseStream.Position:=0;
          TMemoryStream(AResponseStream).SaveToFile(Self.GetPageDataDir+name+'.py'+'.response');
          AResponseStream.Position:=0;


          //Internal Server Error
          //不存在
          if (AHTTPResponse.StatusCode=200) and (TStringStream(AResponseStream).DataString<>'Internal Server Error') then
          begin
            AResponseStream.Position:=0;
            TStringStream(AResponseStream).SaveToFile(Self.GetPageDataDir+name+'.py');

            Self.FScriptList.LoadFromFile(Self.GetPageDataDir+name+'.py',TEncoding.UTF8);
            Self.FScriptLanguage:='python';
          end;
        except
          on E:Exception do
          begin
            uBaseLog.HandleException(E,'TPage.LoadDataFromServer download page python error:'+AUrl);
          end;
        end;

      finally
        FreeAndNil(ANetHttpClient);
        FreeAndNil(AResponseStream);
      end;
  end;


  //下载界面Json和代码
  if Self.FScriptLanguage='javascript' then
  begin
    if DownloadJsScriptFile(name) then
    begin
      Self.FScriptList.LoadFromFile(Self.GetPageDataDir+name+'.js',TEncoding.UTF8);
      Self.FScriptLanguage:='javascript';
    end;
  end;


//  ANetHttpClient:=TNetHTTPClient.Create(nil);
//  AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
//  try
//    //http://127.0.0.1:10060/programs/11/page1/page1.json
//    ANetHttpClient.Get(InterfaceUrl+'programs/'+IntToStr(Self.program_template_fid)+'/'+name+'/'+name+'.js',AResponseStream);
//
//    //Internal Server Error
//    //不存在
//    if TStringStream(AResponseStream).DataString<>'Internal Server Error' then
//    begin
//      AResponseStream.Position:=0;
//      TStringStream(AResponseStream).SaveToFile(Self.GetPageDataDir+name+'.js');
//
//      Self.FScriptList.LoadFromFile(Self.GetPageDataDir+name+'.js',TEncoding.UTF8);
//      Self.FScriptLanguage:='javascript';
//
//
//      //判断有没有引用其他页面,有的话也一并下载
//      //import public
//      //import login
//
//
//    end;
//
//  finally
//    FreeAndNil(ANetHttpClient);
//    FreeAndNil(AResponseStream);
//  end;

  Result:=True;
end;

procedure TPage.LoadFromFieldList(AFieldList: ISuperArray;AHideFieldList:TStringList);
var
  AJsonNameArray:TStringDynArray;
  I: Integer;
  APageFieldControlSetting:TPageFieldControlSetting;
begin
  //获取有哪些字段
  Self.FMainLayoutControlList.Clear;
  for I := 0 to AFieldList.Length-1 do
  begin
    if AHideFieldList.IndexOf(AFieldList.O[I].S['name'])=-1 then
    begin
      APageFieldControlSetting:=Self.FMainLayoutControlList.Add;
      APageFieldControlSetting.name:=AFieldList.O[I].S['name'];
      APageFieldControlSetting.field_name:=AFieldList.O[I].S['name'];
      APageFieldControlSetting.field_caption:=AFieldList.O[I].S['name'];
      APageFieldControlSetting.control_type:='label';
      APageFieldControlSetting.has_caption_label:=1;
      APageFieldControlSetting.width:=200;//宽度是应该自定义的
    end;
  end;


end;

//procedure TPage.CreateFromJson(AJson: ISuperObject);
//var
//  AJsonNameArray:TStringDynArray;
//  I: Integer;
//  APageFieldControlSetting:TPageFieldControlSetting;
//begin
//  //获取有哪些字段
//  AJsonNameArray:=GetJsonNameArray(AJson);
//
//
//  for I := 0 to Length(AJsonNameArray)-1 do
//  begin
//    APageFieldControlSetting:=Self.FMainLayoutControlList.Add;
//    APageFieldControlSetting.field_name:=AJsonNameArray[I];
//    APageFieldControlSetting.control_type:='label';
//    APageFieldControlSetting.has_caption_label:=1;
//    APageFieldControlSetting.width:=200;//宽度是应该自定义的
//  end;
//
//
//
//end;

//function TPage.CreatePageInstalceTo(AOwner:TComponent;AParent: TParentControl;var AError:String): TObject;
//begin
//  Result:=TPageInstance.Create(AOwner);
//  Result.PageStructure:=Self;
//  Result.CreateControls(AOwner,
//                        AParent,
//                        '',
//                        Self.GetPageDataDir,
//                        False,
//                        AError
//                        );
//end;

//procedure TPage.CustomDelayLoad;
//begin
//end;

destructor TPage.Destroy;
begin

//  FreeAndNil(FDefaultListItemBindings);

//  FreeAndNil(ProgramTemplate);
//  FreeAndNil(DataServer);


//  FreeAndNil(FDataInterface);
//
//  FreeAndNil(FDataInterface2);


//  FreeAndNil(DataFunction);
//  FreeAndNil(Page);


//  FreeAndNil(MainLayoutSetting);
//  FreeAndNil(BottomToolbarLayoutSetting);
//  FreeAndNil(TopToolbarLayoutSetting);
  FreeAndNil(FLayoutSettingList);




  //列表页面的表格列列表
//  FreeAndNil(PageColumns);
  //页面的控件列表
  FreeAndNil(FMainLayoutControlList);
//  //页面其他区域的控件
//  FreeAndNil(FBottomToolbarLayoutControlList);


//  FreeAndNil(FDataSkinItems);


  FreeAndNil(FScriptList);

  inherited;
end;

procedure TPage.DoCreateControlsEnd(APageInstance: TObject);
begin
  //
end;

procedure TPage.DoCustomPageAction(APageInstance:TObject;AAction: String;
  AFieldControlSettingMap: TObject; var AIsProcessed: Boolean);
begin
  //
end;

procedure TPage.DoLoaded;
begin
  //加载成功
  if Assigned(OnLoaded) then
  begin
    OnLoaded(Self);
  end;

end;

procedure TPage.DoLoadPageStructureExecute(ATimerTask: TObject);
var
  AError:String;
  AIsUsedCache:Boolean;
begin
  TTimerTask(ATimerTask).TaskTag:=TASK_FAIL;


  //从服务器加载页面结构
  //调用接口获取页面结构,同步到页面中去
  //从开放平台获取页面的结构
  uBaseLog.HandleException(nil,'TPage.DoLoadPageStructureExecute');

//  if GlobalMainProgramSetting.FProgramTemplate.IsLocal then
//  begin
//      Self.LoadFromFile(GlobalMainProgramSetting.FProgramTemplate.FLoadedProgramDir+Name+'.json');
//
//  end
//  else
//  begin
      if not Self.LoadFromServer(GlobalMainProgramSetting.OpenPlatformServerUrl,
                                  GlobalMainProgramSetting.OpenPlatformAppID,
                                  GlobalMainProgramSetting.ProgramTemplateName,
                                  '',
                                  '',
                                  GlobalMainProgramSetting.Platform,
                                  Name,
                                  True,
                                  AError,
                                  AIsUsedCache
                                  ) then
      begin
        uBaseLog.HandleException(nil,'TPage.DoLoadPageStructureExecute '+AError);

        TTimerTask(ATimerTask).TaskDesc:=AError;
    //        ShowMessage(AError);
        Exit;
      end;
//  end;


  TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;


end;

procedure TPage.DoLoadPageStructureExecuteEnd(ATimerTask: TObject);
begin
  try
    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin

        DoLoaded;

//
//        //加载工程
//        Self.DoLoadProgramTemplate(Self.FCurrentProject.FProgramTemplate);

//        uBaseLog.HandleException(nil,'TfrmViewMain.tteLoadMainPageExecuteEnd LoadMainPageEnd');
//        LoadMainPageEnd;

//      end
//      else
//      begin
//        //登录失败
//        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;

    end
    else if TTimerTask(ATimerTask).TaskDesc<>'' then
    begin
        //网络异常
  //      ShowMessageBoxFrame(Self,TTimerTask(ATimerTask).TaskDesc);
  //      ShowHintFrame(Self,TTimerTask(ATimerTask).TaskDesc);

        uBaseLog.HandleException(nil,'TPage.DoLoadPageStructureExecuteEnd '+TTimerTask(ATimerTask).TaskDesc);
        //加载主页失败,继续获取
//        Self.tmrLoadMainPage.Enabled:=True;

    end
    else //if TTimerTask(ATimerTask).TaskTag=1 then
    begin
        //网络异常
  //      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!');
  //      ShowHintFrame(Self,'网络异常,请检查您的网络连接!');


        uBaseLog.HandleException(nil,'TPage.DoLoadPageStructureExecuteEnd '+'网络异常,请检查您的网络连接!');
        //加载主页失败,继续获取
//        Self.tmrLoadMainPage.Enabled:=True;

    end;
  finally
//    HideWaitingFrame;
  end;

end;

procedure TPage.DoPageLayoutControlClick(Sender: TObject;
  APageLayoutControlMap: TObject);
begin

end;

procedure TPage.DoPageLayoutControlValueChange(Sender: TObject;
  APageLayoutControlMap: TObject);
begin

end;

procedure TPage.DoReturnFrameFromFieldControlSettingMapClick(AFieldControlSettingMap: TObject; AFromFrame: TFrame);
//var
//  AFrameIntf:IPageFrameworkFrame;
begin
//  //从编辑页面返回,建议重新刷新下数据
//  if (AFromFrame<>nil) then
//  begin
//    if AFromFrame.GetInterface(IID_IPageFrameworkFrame,AFrameIntf) then
//    begin
//      if AFrameIntf.GetPageInstance.PageStructure.page_type=Const_PageType_EditPage then
//      begin
//        AFieldControlSettingMap.GetPageInstance.LoadData();
//      end;
//    end;
//  end;

end;

function TPage.DownloadJsScriptFile(APageName: String):Boolean;
var
  I:Integer;
  AImportPageName:String;
  AResponseStream:TStringStream;
  ANetHttpClient:TNetHttpClient;
  AScriptList:TStringList;
  AUrl:String;
  AHTTPResponse:IHTTPResponse;
begin
  Result:=False;
  //下载界面Json和代码
  ANetHttpClient:=TNetHTTPClient.Create(nil);
  AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
  AScriptList:=TStringList.Create;
  try
    //http://127.0.0.1:10060/programs/11/page1/page1.json
    //AUrl:=InterfaceUrl+'programs/'+IntToStr(Self.program_template_fid)+'/'+APageName+'/'+APageName+'.js';
    AUrl:=InterfaceUrl+'program_framework/get_page_file?'
        +UnionUrlParams(['key','program_fid','page_name','file_name'],
                        [GlobalBaseManager.User.key,program_template_fid,Name,Name+'.js']);

    AHTTPResponse:=ANetHttpClient.Get(AUrl,AResponseStream);

    //Internal Server Error
    //不存在
    if (AHTTPResponse.StatusCode=200) and (TStringStream(AResponseStream).DataString<>'Internal Server Error') then
    begin
      AResponseStream.Position:=0;
      TStringStream(AResponseStream).SaveToFile(Self.GetPageDataDir+APageName+'.js');

      AScriptList.LoadFromFile(Self.GetPageDataDir+APageName+'.js',TEncoding.UTF8);

      //判断有没有引用其他页面,有的话也一并下载
      //import public
      //import login
      for I := 0 to AScriptList.Count-1 do
      begin
        if LowerCase(Copy(AScriptList[I],1,Length('import ')))='import ' then
        begin
          //导入其他库
          AImportPageName:=Trim(Copy(AScriptList[I],Length('import ')+1,MaxInt));
          DownloadJsScriptFile(AImportPageName);
        end;
      end;


      Result:=True;
    end;

  finally
    FreeAndNil(AScriptList);
    FreeAndNil(ANetHttpClient);
    FreeAndNil(AResponseStream);
  end;

end;

function TPage.LoadPageStructureFromJson(ASuperObject: ISuperObject): Boolean;
var
  I: Integer;
  AControlRecordJson:ISuperObject;
  AFieldControlSetting:TFieldControlSetting;
begin
  uBaseLog.HandleException(nil,'TPage.LoadPageStructureFromJson');


  Result:=LoadFromJson(ASuperObject);
  if not Result then Exit;




  //主要的接口
//  FreeAndNil(Self.DataInterface);
//  if ASuperObject.O['data_interface'].S['type']=Const_IntfType_TableCommonRest then
//  begin
//    DataInterface:=TCommonRestIntfItem.Create(nil);
//    if (DataInterface<>nil) and not DataInterface.LoadFromJson(ASuperObject.O['data_interface']) then
//    begin
//      Exit;
//    end;
////  end;
//
//
//    //接口2
//    if (DataInterface2<>nil) and not DataInterface2.LoadFromJson(ASuperObject.O['data_interface2']) then
//    begin
//      Exit;
//    end;



  //控件列表
  Self.MainLayoutControlList.Clear;
  for I := 0 to ASuperObject.A['controls'].Length-1 do
  begin

      AFieldControlSetting:=MainLayoutControlList.Add;
      if not TPageFieldControlSetting(AFieldControlSetting).LoadFromJson(ASuperObject.A['controls'].O[I]) then
      begin
        Exit;
      end;


      

//      MainLayoutControlList.Add(AFieldControlSetting);
  end;




//  //工具栏的控件列表
//  Self.BottomToolbarLayoutControlList.Clear;
//  for I := 0 to ASuperObject.A['controls'].Length-1 do
//  begin
//
//      if ASuperObject.A['other_page_part_controls'].O[I].S['page_part']=Const_PagePart_BottomToolbar then
//      begin
//          AFieldControlSetting:=TFieldControlSetting.Create(BottomToolbarLayoutControlList);
//          if not AFieldControlSetting.LoadFromJson(ASuperObject.A['other_page_part_controls'].O[I]) then
//          begin
//            Exit;
//          end;
//
////          BottomToolbarLayoutControlList.Add(AFieldControlSetting);
//      end;
//  end;


  //MainLayoutControlList.LoadFromJson后面
  //控件列表加载结束事件
  LoadLayoutControlListEnd;





  Result:=True;
end;
//
//function TPage.GetDataInterface: TDataInterface;
//var
//  ASuperObject:ISuperObject;
//begin
//  if FDataInterface=nil then
//  begin
//    if GlobalDataInterfaceClassRegList.Find(Self.data_intf_class)<>nil then
//    begin
//      FDataInterface:=GlobalDataInterfaceClassRegList.Find(Self.data_intf_class).Create;
//      ASuperObject:=TSuperObject.Create(Self.data_intf_setting);
//      FDataInterface.LoadFromJson(ASuperObject);
//      FDataInterface.Name:=Self.data_intf_name;
//      FDataInterface.FKeyFieldName:=data_intf_key_field;
//    end;
//  end;
//  Result:=Self.FDataInterface;
//end;
//
//function TPage.GetDataInterface2: TDataInterface;
//var
//  ASuperObject:ISuperObject;
//begin
//  if FDataInterface2=nil then
//  begin
//    if GlobalDataInterfaceClassRegList.Find(data_intf_class2)<>nil then
//    begin
//      FDataInterface2:=GlobalDataInterfaceClassRegList.Find(data_intf_class2).Create;
//      ASuperObject:=TSuperObject.Create(Self.data_intf_setting2);
//      FDataInterface2.LoadFromJson(ASuperObject);
//      FDataInterface2.Name:=Self.data_intf_name2;
//    end;
//  end;
//  Result:=Self.FDataInterface2;
//end;

function TPage.GetPageDataDir: String;
begin
  if (Self.FLoadedJsonFilePath<>'') then
  begin
    Result:=ExtractFilePath(FLoadedJsonFilePath);
    Exit;
  end;

  Result:=GetApplicationPath+'programs'+PathDelim;

  if (Self.ProgramTemplate<>nil) then
  begin
    Result:=Result+IntToStr(Self.ProgramTemplate.fid)+PathDelim;
  end
////  else if program_template_name<>'' then
////  begin
////    Result:=Result+Self.program_template_name+PathDelim;
////  end;
  else
  begin
    Result:=Result+IntToStr(Self.program_template_fid)+PathDelim;
  end;

  Result:=Result+Self.name+PathDelim;

  ForceDirectories(Result);

end;

function TPage.GetPageParentDir: String;
begin
  if (Self.FLoadedJsonFilePath<>'') then
  begin
    Result:=ExtractFilePath(FLoadedJsonFilePath);
    Exit;
  end;

  Result:=GetApplicationPath+'programs'+PathDelim;

//  if (Self.ProgramTemplate<>nil) then
//  begin
//    Result:=ProgramTemplate.GetProgramTemplateDir;
//  end
////  else if program_template_name<>'' then
////  begin
////    Result:=Result+Self.program_template_name+PathDelim;
////  end;
//  else
//  begin
    Result:=Result+IntToStr(Self.program_template_fid)+PathDelim;
//  end;


end;

function TPage.GetUserSetting(AUserFID: String;var ADataJson:ISuperObject): Boolean;
var
//  ADataJson:ISuperObject;
  ALoadDataSetting:TLoadDataSetting;
  ADataInterface:TDataInterface;
  ADataIntfResult:TDataIntfResult;
begin

  Result:=False;
  ADataJson:=nil;

  //获取
  ADataInterface:=GlobalDataInterfaceClass.Create;
  ADataInterface.Name:='page_user_setting';
  ADataIntfResult:=TDataIntfResult.Create;
  ALoadDataSetting:=TLoadDataSetting.Create;
  ALoadDataSetting.AppID:=AppID;

//  if GlobalManager.FIsOfflineMode then
//  begin
//    ALoadDataSetting.WhereKeyJson:=GetWhereKeyJson(['page_fid'],[APage.fid]);
//  end
//  else
//  begin
    ALoadDataSetting.WhereKeyJson:=GetWhereKeyJson(['user_fid','page_fid'],[AUserFID,Self.fid]);
//  end;

  try
      if not ADataInterface.GetDataDetail(ALoadDataSetting,ADataIntfResult) then
      begin
        uBaseLog.HandleException(nil,'TFrameEditUser.tteInitExecute 获取数据page_user_setting '+ADataIntfResult.Desc);
//        Exit;
      end;

      ADataJson:=ADataIntfResult.DataJson;
  finally
    FreeAndNil(ADataInterface);
    FreeAndNil(ADataIntfResult);
    FreeAndNil(ALoadDataSetting);
  end;

//  if ADataJson=nil then
//  begin
////    AUserPageSettingValueJson:=SO();
//  end
//  else
//  begin
//    AUserPageSettingValueJson:=SO(ADataJson.S['setting_json']);
//  end;

  Result:=True;
end;

function TPage.LoadFromServer(AInterfaceUrl:String;
                              AAppID:String;
                              //APageFID:Integer;
                              AProgramTemplateName:String;
                              AFunctionName:String;
                              APageType:String;
                              APlatform:String;
                              APageName:String;
                              AIsCanUseCache:Boolean;
                              var ADesc:String;
                              var AIsUsedCache:Boolean): Boolean;
var
  ACode: Integer;
  ADataJson:ISuperObject;
var
  I: Integer;
  AControlRecordJson:ISuperObject;
  AFieldControlSetting:TFieldControlSetting;
  ACacheFilePath:String;
  ANetHttpClient:TNetHTTPClient;
  AResponseStream:TMemoryStream;
begin
  Result:=False;
  ADesc:='';

  ADataJson:=nil;

  AIsUsedCache:=False;



  if (AProgramTemplateName<>'') and ((APageName<>'') or (AFunctionName<>'')) then
  begin
  end
//  else
//  if APageFID>0 then
//  begin
//      //直接通过fid加载页面结构
//      //不存在fid,表示要新增该记录
//      if not SimpleCallAPI(
//                          'get_page_info',
//                          nil,
//                          AInterfaceUrl+'program_framework/',
//                          ['appid',
//                          'user_fid',
//                          'key',
//
//                          'page_fid'
//                          ],
//                          [
//                          AAppID,
//                          0,
//                          '',
//                          APageFID
//                          ],
//                          ACode,
//                          ADesc,
//                          ADataJson,
//                          GlobalRestAPISignType,
//                          GlobalRestAPIAppSecret) then
//      begin
//        Exit;
//      end;
//  end
  else
  begin
      ADesc:='请指定页面!';
      Exit;
  end;



  ACacheFilePath:=GetApplicationPath
                      +AProgramTemplateName+'_'
                      +AFunctionName+'_'
                      +APageType+'_'
                      +APlatform+'_'
                      +APageName
                      +'.json';
  if AIsCanUseCache and FileExists(ACacheFilePath) then
  begin
      ADataJson:=TSuperObject.ParseFile(ACacheFilePath{$IF CompilerVersion <= 21.0},True{$IFEND});

      AIsUsedCache:=True;

  end
  else
  begin
      //不存在fid,表示要新增该记录
//      if not SimpleCallAPI(
//                          'get_page_structure',
//                          nil,
//                          AInterfaceUrl+'program_framework/',
//                          ConvertToStringDynArray(['appid',
//                                                  'user_fid',
//                                                  'key',
//
//                                                  'program_template_name',
//                                                  'function_name',
//                                                  'page_type',
//                                                  'platform',
//                                                  'page_name'//可以忽略
//                                                  ]),
//                          ConvertToVariantDynArray([
//                                                  AAppID,
//                                                  GlobalBaseManager.User.fid,
//                                                  GlobalBaseManager.User.key,
//                                                  AProgramTemplateName,
//                                                  AFunctionName,
//                                                  APageType,
//                                                  APlatform,
//                                                  APageName
//                                                  ]),
//                          ACode,
//                          ADesc,
//                          ADataJson,
//                          GlobalRestAPISignType,
//                          GlobalRestAPIAppSecret
//
//                          ) or (ACode<>SUCC) then
//      begin
//        Exit;
//      end;


      if AIsCanUseCache then
      begin
        ADataJson.SaveTo(ACacheFilePath);
      end;


  end;

  if ADataJson<>nil then
  begin
    //加载页面数据和结构
    Self.LoadPageStructureFromJson(ADataJson);
  end;



  Result:=True;

end;

procedure TPage.LoadLayoutControlListEnd;
var
  I: Integer;
//  APropJson:ISuperObject;
  AFieldControlSetting:TPageFieldControlSetting;
var
  ASuperObject:ISuperObject;
  ALayoutSetting:TLayoutSetting;
//  I: Integer;
//  AListItemBindingItem:TListItemBindingItem;
begin


  //判断工具栏的按钮是否存在，新建、编辑、保存、取消
//  if Self.BottomToolbarLayoutControlList.FindByName('btnAdd')=nil then
  if (Self.MainLayoutControlList.FindByName('btnNewRecord')=nil) and FIsNeedCommonEditButton then
  begin
      AFieldControlSetting:=MainLayoutControlList.Add;
//      AFieldControlSetting.appid:=AAppID;
//      AFieldControlSetting.user_fid:=AUserFID;
//      AFieldControlSetting.page_fid:=APageRecordDataJson.I['fid'];
      AFieldControlSetting.visible:=1;
      AFieldControlSetting.col_visible:=0;
      AFieldControlSetting.hittest:=1;
      AFieldControlSetting.enabled:=1;
      AFieldControlSetting.is_no_post:=1;
      AFieldControlSetting.name:='btnNewRecord';
      AFieldControlSetting.field_caption:='新增';
      AFieldControlSetting.value:='新增';
      AFieldControlSetting.control_type:='button';
      AFieldControlSetting.action:=Const_PageAction_AddRecord;
      AFieldControlSetting.orderno:=1;
      {$IFDEF VCL}
      AFieldControlSetting.page_part:=Const_PagePart_BottomToolbar;
      AFieldControlSetting.control_style:='Default';
      {$ENDIF}
      {$IFDEF FMX}
      AFieldControlSetting.page_part:=Const_PagePart_TopToolbar;
      AFieldControlSetting.control_style:='TransparentWhiteCaption';
      AFieldControlSetting.align:='right';
      AFieldControlSetting.width:=60;
      if (Self.page_type=Const_PageType_ListPage) then
      begin
        //如果当前是手机列表页面,那么跳转到编辑页面
        //打开添加记录页面
        AFieldControlSetting.action:=Const_PageAction_JumpToNewRecordPage;
      end;
      {$ENDIF}



      AFieldControlSetting:=MainLayoutControlList.Add;
//      AFieldControlSetting.appid:=AAppID;
//      AFieldControlSetting.user_fid:=AUserFID;
//      AFieldControlSetting.page_fid:=APageRecordDataJson.I['fid'];
      AFieldControlSetting.visible:=1;
      AFieldControlSetting.col_visible:=0;
      AFieldControlSetting.hittest:=1;
      AFieldControlSetting.enabled:=1;
      AFieldControlSetting.is_no_post:=1;
      AFieldControlSetting.name:='btnEditRecord';
      AFieldControlSetting.field_caption:='编辑';
//      AFieldControlSetting.value:='编辑';
      AFieldControlSetting.control_type:='button';
      AFieldControlSetting.action:=Const_PageAction_EditRecord;
      AFieldControlSetting.orderno:=1;
      {$IFDEF VCL}
      AFieldControlSetting.page_part:=Const_PagePart_BottomToolbar;
      AFieldControlSetting.control_style:='Default';
      {$ENDIF}
      {$IFDEF FMX}
      AFieldControlSetting.page_part:=Const_PagePart_TopToolbar;
      AFieldControlSetting.control_style:='TransparentWhiteCaption';
      AFieldControlSetting.align:='right';
      AFieldControlSetting.width:=60;
      if (Self.page_type=Const_PageType_ListPage) then//列表页面不需要编辑
      begin
        AFieldControlSetting.visible:=0;
      end;
      {$ENDIF}


      if (Self.page_type=Const_PageType_TableManagePage) then
      begin
        AFieldControlSetting:=MainLayoutControlList.Add;
  //      AFieldControlSetting.appid:=AAppID;
  //      AFieldControlSetting.user_fid:=AUserFID;
  //      AFieldControlSetting.page_fid:=APageRecordDataJson.I['fid'];
        AFieldControlSetting.visible:=1;
        AFieldControlSetting.col_visible:=0;
        AFieldControlSetting.hittest:=1;
        AFieldControlSetting.enabled:=1;
        AFieldControlSetting.is_no_post:=1;
        AFieldControlSetting.name:='btnDeleteRecord';
        AFieldControlSetting.field_caption:='删除';
  //      AFieldControlSetting.value:='删除';
        AFieldControlSetting.control_type:='button';
        AFieldControlSetting.page_part:=Const_PagePart_BottomToolbar;
        AFieldControlSetting.action:=Const_PageAction_DelRecord;
        AFieldControlSetting.orderno:=1;
        AFieldControlSetting.control_style:='Default2';
      end;


      AFieldControlSetting:=MainLayoutControlList.Add;
//      AFieldControlSetting.appid:=AAppID;
//      AFieldControlSetting.user_fid:=AUserFID;
//      AFieldControlSetting.page_fid:=APageRecordDataJson.I['fid'];
      AFieldControlSetting.visible:=1;
      AFieldControlSetting.col_visible:=0;
      AFieldControlSetting.hittest:=1;
      AFieldControlSetting.enabled:=1;
      AFieldControlSetting.is_no_post:=1;
      AFieldControlSetting.name:='btnSaveRecord';
      AFieldControlSetting.field_caption:='保存';
//      AFieldControlSetting.value:='保存';
      AFieldControlSetting.control_type:='button';
      AFieldControlSetting.action:=Const_PageAction_SaveRecord;
      AFieldControlSetting.orderno:=1;
      {$IFDEF VCL}
      AFieldControlSetting.page_part:=Const_PagePart_BottomToolbar;
      AFieldControlSetting.control_style:='Default';
      {$ENDIF}
      {$IFDEF FMX}
      AFieldControlSetting.page_part:=Const_PagePart_TopToolbar;
      AFieldControlSetting.control_style:='TransparentWhiteCaption';
      AFieldControlSetting.align:='right';
      AFieldControlSetting.width:=60;
      if (Self.page_type=Const_PageType_ListPage) then//手机列表页面不需要编辑
      begin
        AFieldControlSetting.visible:=0;
      end;
      {$ENDIF}



      AFieldControlSetting:=MainLayoutControlList.Add;
//      AFieldControlSetting.appid:=AAppID;
//      AFieldControlSetting.user_fid:=AUserFID;
//      AFieldControlSetting.page_fid:=APageRecordDataJson.I['fid'];
      AFieldControlSetting.visible:=1;
      AFieldControlSetting.col_visible:=0;
      AFieldControlSetting.hittest:=1;
      AFieldControlSetting.enabled:=1;
      AFieldControlSetting.is_no_post:=1;
      AFieldControlSetting.name:='btnCancelRecord';
      AFieldControlSetting.field_caption:='取消';
//      AFieldControlSetting.value:='取消';
      AFieldControlSetting.control_type:='button';
      AFieldControlSetting.action:=Const_PageAction_CancelAddEditRecord;
      AFieldControlSetting.orderno:=1;
      {$IFDEF VCL}
      AFieldControlSetting.page_part:=Const_PagePart_BottomToolbar;
      AFieldControlSetting.control_style:='Default2';
      {$ENDIF}
      {$IFDEF FMX}
      AFieldControlSetting.page_part:=Const_PagePart_TopToolbar;
      AFieldControlSetting.control_style:='TransparentWhiteCaption';
      AFieldControlSetting.align:='right';
      AFieldControlSetting.width:=60;
      if (Self.page_type=Const_PageType_ListPage) then//手机列表页面不需要取消
      begin
        AFieldControlSetting.visible:=0;
      end;
      {$ENDIF}



  end;





  //如果是表格页面,并且不存在表格控件,那么自动创建一个表格控件项
  if (Self.page_type=Const_PageType_TableManagePage) and (Self.MainLayoutControlList.FindByName('btnLoadData')=nil) then
  begin
      AFieldControlSetting:=MainLayoutControlList.Add;
//      AFieldControlSetting.appid:=AAppID;
//      AFieldControlSetting.user_fid:=AUserFID;
//      AFieldControlSetting.page_fid:=APageRecordDataJson.I['fid'];
      AFieldControlSetting.visible:=1;
      AFieldControlSetting.col_visible:=0;
      AFieldControlSetting.hittest:=1;
      AFieldControlSetting.enabled:=1;
      AFieldControlSetting.is_no_post:=1;
      AFieldControlSetting.name:='btnLoadData';
      AFieldControlSetting.field_caption:='刷新';
//      AFieldControlSetting.value:='刷新';
      AFieldControlSetting.control_type:='button';
      AFieldControlSetting.page_part:=Const_PagePart_TopToolbar;
      AFieldControlSetting.action:=Const_PageAction_LoadData;
      AFieldControlSetting.orderno:=1;
      AFieldControlSetting.control_style:='Default';

//
//      AFieldControlSetting:=MainLayoutControlList.Add;
////      AFieldControlSetting.appid:=AAppID;
////      AFieldControlSetting.user_fid:=AUserFID;
////      AFieldControlSetting.page_fid:=APageRecordDataJson.I['fid'];
//      AFieldControlSetting.visible:=1;
//      AFieldControlSetting.col_visible:=0;
//      AFieldControlSetting.hittest:=1;
//      AFieldControlSetting.enabled:=1;
//      AFieldControlSetting.is_no_post:=1;
//      AFieldControlSetting.name:='btnDeleteRecordList';
//      AFieldControlSetting.field_caption:='删除';
////      AFieldControlSetting.value:='删除';
//      AFieldControlSetting.control_type:='button';
//      AFieldControlSetting.page_part:=Const_PagePart_TopToolbar;
//      AFieldControlSetting.action:=Const_PageAction_DeleteRecordList;
//      AFieldControlSetting.orderno:=1;
//      AFieldControlSetting.control_style:='Default';
//



//      AFieldControlSetting:=MainLayoutControlList.Add;
////      AFieldControlSetting.appid:=AAppID;
////      AFieldControlSetting.user_fid:=AUserFID;
////      AFieldControlSetting.page_fid:=APageRecordDataJson.I['fid'];
//      AFieldControlSetting.visible:=1;
//      AFieldControlSetting.col_visible:=0;
//      AFieldControlSetting.hittest:=1;
//      AFieldControlSetting.enabled:=1;
//      AFieldControlSetting.is_no_post:=1;
//      AFieldControlSetting.name:='btnTest';
//      AFieldControlSetting.field_caption:='测试';
//      AFieldControlSetting.value:='测试';
//      AFieldControlSetting.control_type:='cxgrid';
//      AFieldControlSetting.page_part:=Const_PagePart_TopToolbar;
//      AFieldControlSetting.action:='';
//      AFieldControlSetting.orderno:=1;
//      AFieldControlSetting.control_style:='Default';



      AFieldControlSetting:=MainLayoutControlList.Add;
      FRecordListFieldControlSetting:=AFieldControlSetting;
      //字段名
      AFieldControlSetting.name:='gridData';
      AFieldControlSetting.field_name:='RecordList';
      AFieldControlSetting.field_caption:='数据列表';


      //默认的动作
      //点击编辑列表项
      AFieldControlSetting.action:='';
      AFieldControlSetting.page_part:=Const_PagePart_Grid;

      //对齐方式
      AFieldControlSetting.align:='Client';
      //是否可以响应点击
      AFieldControlSetting.hittest:=1;
      //是否启用
      AFieldControlSetting.enabled:=1;


      //是否显示
      AFieldControlSetting.visible:=1;
      AFieldControlSetting.col_visible:=0;

      AFieldControlSetting.has_caption_label:=0;


      //控件类型,要与HTML等通用
      AFieldControlSetting.control_type:='dbgrid';
      AFieldControlSetting.is_no_post:=0;


      ALayoutSetting:=TLayoutSetting.Create;
      ALayoutSetting.name:=Const_PagePart_Grid;
      ALayoutSetting.align_type:=Const_PageAlignType_Manual;
      Self.FLayoutSettingList.Add(ALayoutSetting);

  end;





  //如果是列表页面,并且不存在列表控件,那么自动创建一个列表控件项
  if (Self.page_type=Const_PageType_ListPage) and (Self.MainLayoutControlList.FindByName('lvData')=nil) then//and (is_simple_list_page=1) then
  begin
//      if MainLayoutControlList.FindByControlType('listview')=nil then
//      begin
          AFieldControlSetting:=MainLayoutControlList.Add;
          FRecordListFieldControlSetting:=AFieldControlSetting;

          //字段名
          AFieldControlSetting.name:='lvData';
          AFieldControlSetting.field_name:='RecordList';
          AFieldControlSetting.field_caption:='数据列表';
//          //控件风格
//          AFieldControlSetting.control_style:String;


          //默认的动作
          //点击编辑列表项
          AFieldControlSetting.action:=Const_PageAction_JumpToEditRecordPage;



      //    //控件所在的页面位置
      //    page_part:String;

      //    //所属页面的FID
      //    page_fid:Integer;
      //    //父控件的id
      //    parent_control_fid:Integer;
      //    //本地时使用
      //    parent_control_name:String;


      //    //控件属性
      //    x:double;
      //    y:double;
      //    width:double;
      //    height:double;
      //
      //    //边距
      //    margins:String;
      //
      //
      //    //拉伸模式
      //    anchors:String;
          //对齐方式
          AFieldControlSetting.align:='Client';
          //是否可以响应点击
          AFieldControlSetting.hittest:=1;
          //是否启用
          AFieldControlSetting.enabled:=1;


          //是否显示
          AFieldControlSetting.visible:=1;
          AFieldControlSetting.col_visible:=0;

          AFieldControlSetting.has_caption_label:=0;


          //控件类型,要与HTML等通用
          AFieldControlSetting.control_type:='listview';
//          //控件名,一定要,因为有些控件并不一定有FieldName
//          AFieldControlSetting.name:='lvData';
//          //标题
//          AFieldControlSetting.caption:='数据列表';





          //    //值,Label的Caption,
          //    value:String;
//          if default_list_item_style='' then
//          begin
//            default_list_item_style:='Default';
//            if default_list_item_bindings='' then
//            begin
//              //默认值,没有默认的话,列表页面内容出不来
//              default_list_item_bindings:='{"ItemCaption":"name"}';
//            end;
//          end;
           AFieldControlSetting.PropJson.S['DefaultItemStyle']:='Default';
           AFieldControlSetting.PropJson.S['default_list_item_bindings']:='{"ItemCaption":"name"}';



          //列表框的默认参数
//          APropJson:=TSuperObject.Create;
//          AFieldControlSetting.PropJson.S['DefaultItemStyle']:=Self.default_list_item_style;
          if Self.item_col_count>0 then
          begin
            AFieldControlSetting.PropJson.I['ColCount']:=Self.item_col_count;
          end;
          if Self.item_height>0 then
          begin
            AFieldControlSetting.PropJson.I['ItemHeight']:=Self.item_height;
          end;
          AFieldControlSetting.prop:=AFieldControlSetting.PropJson.AsJSON;



//          ASuperObject:=TSuperObject.Create(default_list_item_bindings);
//          FDefaultListItemBindings.LoadFromJson(ASuperObject);
//          Self.FDefaultListItemBindings.Clear;
//          if ASuperObject.Contains('ItemCaption') then
//          begin
//            //列表项属性与数据字段的绑定
//            AListItemBindingItem:=Self.FDefaultListItemBindings.Add;
//            AListItemBindingItem.item_field_name:='ItemCaption';
//            AListItemBindingItem.data_field_name:=ASuperObject.S['ItemCaption'];
//          end;



//          //存在添加按钮
//          if Self.has_add_record_button=1 then


//      end;
  end;


  IsLoaded:=True;
end;

//procedure TPage.DelayLoad;
//begin
//  if not IsLoaded then
//  begin
//    CustomDelayLoad;
//    IsLoaded:=True;
//  end;
//end;

procedure TPage.LoadFromFile(AJsonFilePath: String);
var
  ASuperObject:ISuperObject;
begin
  ASuperObject:=TSuperObject.Create(GetStringFromFile(AJsonFilePath,TEncoding.UTF8));
  LoadPageStructureFromJson(ASuperObject);

  FLoadedJsonFilePath:=AJsonFilePath;
end;

function TPage.LoadFromIndexJson(AJson: ISuperObject): Boolean;
begin
  Result:=False;

  //页面的名称
  name:=AJson.S['name'];
  //页面的标题
  caption:=AJson.S['caption'];


  Result:=True;

end;

function TPage.LoadFromJson(AJson: ISuperObject): Boolean;
var
  ASuperObject:ISuperObject;
begin
  Result:=False;

  try


      fid:=AJson.I['fid'];
      Self.Fappid:=AJson.I['appid'];
      Self.Fuser_fid:=AJson.S['user_fid'];


      //所属的程序模块
      program_template_fid:=AJson.I['program_template_fid'];
      program_template_name:=AJson.S['program_template_name'];


      //所调用的接口
//      data_intf_fid:=AJson.I['data_intf_fid'];
      data_intf_name:=AJson.S['data_intf_name'];

      //所调用的接口
//      data_intf_fid2:=AJson.I['data_intf_fid2'];
      data_intf_name2:=AJson.S['data_intf_name2'];


      //所属的功能
      function_fid:=AJson.I['function_fid'];
      function_name:=AJson.S['function_name'];

      //页面的名称
      name:=AJson.S['name'];
      //页面的标题
      caption:=AJson.S['caption'];


      //排列布局类型,
      //manual手动布局,
      //auto自动布局
      align_type:=AJson.S['align_type'];


      //页面类型
      page_type:=AJson.S['type'];
      platform:=AJson.S['platform'];



      design_width:=AJson.F['design_width'];
      design_height:=AJson.F['design_height'];


      refresh_seconds:=AJson.I['refresh_seconds'];

      FScriptLanguage:=AJson.S['script_language'];

      //加载接口1需要的参数
      load_data_params:=AJson.S['load_data_params'];
      //保存接口1所需要的参数
      save_data_params:=AJson.S['save_data_params'];
    //  Self.LoadDataParamsJsonArray:=TSuperArray.Create(AJson.S['load_data_params']);
    //  Self.SaveDataParamsJsonArray:=TSuperArray.Create(AJson.S['save_data_params']);



      //加载接口2需要的参数
      load_data_params2:=AJson.S['load_data_params2'];
      //保存接口2所需要的参数
      save_data_params2:=AJson.S['save_data_params2'];
    //  Self.LoadDataParamsJsonArray2:=TSuperArray.Create(AJson.S['load_data_params2']);
    //  Self.SaveDataParamsJsonArray2:=TSuperArray.Create(AJson.S['save_data_params2']);

      createtime:=AJson.S['createtime'];
      updatetime:=AJson.S['updatetime'];


//      //默认列表项的显示风格
//      default_list_item_style:=AJson.S['default_list_item_style'];
//      //默认列表项的绑定设置
//      default_list_item_bindings:=AJson.S['default_list_item_bindings'];
//      //做为列表项样式时的默认值
//      list_item_style_default_height:=AJson.F['list_item_style_default_height'];
//      list_item_style_autosize:=AJson.I['list_item_style_autosize'];
//      list_item_style_default_width:=AJson.F['list_item_style_default_width'];
//
//
//
//
//      ASuperObject:=TSuperObject.Create(default_list_item_bindings);
//      FDefaultListItemBindings.LoadFromJson(ASuperObject);


      

      //主控件排列设置
      MainLayoutSetting.LoadFromJson(AJson);


      BottomToolbarLayoutSetting.LoadFromJson(AJson);
      TopToolbarLayoutSetting.LoadFromJson(AJson);


      FJson:=AJson;


      Result:=True;
  except
    on E:Exception do
    begin
      uBaseLog.HandleException(E,'TPage.LoadFromJson');
    end;
  end;
end;

procedure TPage.SaveToFile(AJsonFilePath: String);
var
  ADesc:String;
  ASuperObject:ISuperObject;
begin
  ASuperObject:=TSuperObject.Create();
  SavePageStructureToJson(ASuperObject,ADesc);
  SaveStringToFile(//ASuperObject.AsJSON,
                    formatJson(UTFStrToUnicode(ASuperObject.AsJSON)),
                    AJsonFilePath,TEncoding.UTF8);
end;

function TPage.SaveToIndexJson(AJson: ISuperObject): Boolean;
begin
  Result:=False;

  //页面的名称
  AJson.S['name']:=name;
  //页面的标题
  AJson.S['caption']:=caption;

  Result:=True;

end;

function TPage.SaveToJson(AJson: ISuperObject): Boolean;
var
  ASuperObject:ISuperObject;
begin
  Result:=False;


  try


      //页面的名称
      AJson.S['name']:=name;
      //页面的标题
      AJson.S['caption']:=caption;


      //排列布局类型,
      //manual手动布局,
      //auto自动布局
      AJson.S['align_type']:=align_type;


      //页面类型
      AJson.S['type']:=page_type;
      AJson.S['platform']:=platform;



      if fid<>0 then AJson.I['fid']:=fid;
      AJson.I['appid']:=Self.Fappid;
      AJson.S['user_fid']:=Self.Fuser_fid;



      //所属的程序模块
      if program_template_fid<>0 then AJson.I['program_template_fid']:=program_template_fid;
      if program_template_name<>'' then AJson.S['program_template_name']:=program_template_name;


      //所调用的接口
//      if data_intf_fid<>0 then AJson.I['data_intf_fid']:=data_intf_fid;
      if data_intf_name<>'' then AJson.S['data_intf_name']:=data_intf_name;



      //所调用的接口
//      if data_intf_fid2<>0 then AJson.I['data_intf_fid2']:=data_intf_fid2;
      if data_intf_name2<>'' then AJson.S['data_intf_name2']:=data_intf_name2;



      //所属的功能
      if function_fid<>0 then AJson.I['function_fid']:=function_fid;
      if function_name<>'' then AJson.S['function_name']:=function_name;


      AJson.F['design_width']:=design_width;
      AJson.F['design_height']:=design_height;

      AJson.I['refresh_seconds']:=refresh_seconds;


    //    //加载接口1需要的参数
    //    load_data_params:String;
    //    //保存接口1所需要的参数
    //    save_data_params:String;
      if load_data_params<>'' then AJson.S['load_data_params']:=load_data_params;//Self.LoadDataParamsJsonArray.AsJSON;
      if save_data_params<>'' then AJson.S['save_data_params']:=save_data_params;//Self.SaveDataParamsJsonArray.AsJSON;


    //    //加载接口2需要的参数
    //    load_data_params2:String;
    //    //保存接口2所需要的参数
    //    save_data_params2:String;
      if load_data_params2<>'' then AJson.S['load_data_params2']:=load_data_params2;//Self.LoadDataParamsJsonArray2.AsJSON;
      if save_data_params2<>'' then AJson.S['save_data_params2']:=save_data_params2;//Self.SaveDataParamsJsonArray2.AsJSON;



//      //默认列表项的显示风格
//      if default_list_item_style<>'' then AJson.S['default_list_item_style']:=default_list_item_style;



//      ASuperObject:=TSuperObject.Create();
//      FDefaultListItemBindings.SaveToJson(ASuperObject);
//      default_list_item_bindings:=ASuperObject.AsJson;
//      //默认列表项的绑定设置
//      if default_list_item_bindings<>'' then AJson.S['default_list_item_bindings']:=default_list_item_bindings;




      //主控件排列设置
      MainLayoutSetting.SaveToJson(AJson);


      BottomToolbarLayoutSetting.SaveToJson(AJson);
      TopToolbarLayoutSetting.SaveToJson(AJson);

      //保存组件列表



//      //做为列表项样式时的默认值
//      AJson.F['list_item_style_default_height']:=list_item_style_default_height;
//      AJson.I['list_item_style_autosize']:=list_item_style_autosize;
//      AJson.F['list_item_style_default_width']:=list_item_style_default_width;



      Result:=True;
  except
    on E:Exception do
    begin
      uBaseLog.HandleException(E,'TPage.SaveToJson');
    end;
  end;
end;

function TPage.SaveToServer(var ADesc: String): Boolean;
var
  APageJson:ISuperObject;
var
//  AIsAdd:Boolean;
  ACode:Integer;
//  ADataJson:ISuperObject;
//  ASuperObject:ISuperObject;
begin
  APageJson:=SO();
  APageJson.S['createtime']:=StdDateTimeToStr(Now);
  Result:=SavePageStructureToJson(APageJson,ADesc);



  SavePageJsonToServer(APageJson,APageJson,ADesc);


end;

//function TPage.SaveDataToServer(APageJsonFile:String;var ADesc: String): Boolean;
//var
//  ACode:Integer;
//  ADataJson:ISuperObject;
//  AResponseStream:TStringStream;
//  AMultipartFormData:TMultipartFormData;
//  ASuperObject:ISuperObject;
//begin
//  try
//    AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
//
//    AMultipartFormData:=TMultipartFormData.Create;
//    AMultipartFormData.AddFile('page_json',APageJsonFile);
//
//    //  AMultipartFormData.AddFile('upfile','C:\腾讯云.mp4','video/mp4');
//    //  AMultipartFormData.Stream;
//    //  AMultipartFormData.AddFile();
//
////    NetHTTPClient1.Post('http://yq.6nq.com/tencent_xugc/upload.php',
////                            AMultipartFormData,
////                            AResponseStream);
//
//
//    if not SimpleCallAPI('save_page_data',
//                  nil,
//                  uOpenClientCommon.InterfaceUrl+'program_framework/',
//                  [
//                  'key','program_fid','page_name'
//                  ],
//                  [
//                  GlobalBaseManager.User.key,Self.program_template_fid,Self.Name
//                  ],
//                  ACode,
//                  ADesc,
//                  ADataJson,
//                  GlobalRestAPISignType,
//                  GlobalRestAPIAppSecret,
//                  True,
//                  AMultipartFormData.Stream
//                  ) then
//    begin
//      Exit;
//    end;
//
//
//
//
////    Self.Memo1.Lines.Add(AResponseStream.DataString);
//
//    ASuperObject:=TSuperObject.Create(AResponseStream.DataString);
//    if ASuperObject.I['Code']=200 then
//    begin
////      Self.Memo1.Lines.Add(ASuperObject.O['Data'].S['MediaUrl']);
////      AVideoUrl:=ASuperObject.O['Data'].S['MediaUrl'];
////      AVideoFileId:=ASuperObject.O['Data'].S['FileId'];
////
////      AVideoUploadSucc:=True;
//
//
//    end;
//
//  finally
//    FreeAndNil(AMultipartFormData);
//    FreeAndNil(AResponseStream);
//  end;
//
//end;

//procedure TPage.SetBottomToolbarLayoutControlList(
//  const Value: TFieldControlSettingList);
//begin
//  FBottomToolbarLayoutControlList.Assign(Value);
//end;

procedure TPage.SetDataIntfClass(const Value: String);
begin
  data_intf_class := Value;
//  FreeAndNil(Self.FDataInterface);
end;

procedure TPage.SetDataIntfClass2(const Value: String);
begin
  data_intf_class2 := Value;
//  FreeAndNil(Self.FDataInterface2);
end;

//procedure TPage.SetDataSkinItems(const Value: TSkinItems);
//begin
//  FDataSkinItems.Assign(Value);
//end;

//procedure TPage.SetDefaultListItemBindings(const Value: TListItemBindings);
//begin
//  FDefaultListItemBindings.Assign(Value);
//end;

procedure TPage.SetMainLayoutControlList(const Value: TPageFieldControlSettingList);
begin
  FMainLayoutControlList.Assign(Value);
end;

procedure TPage.StartLoadPageStructureThread;
begin

  GetGlobalTimerThread.RunTempTask(Self.DoLoadPageStructureExecute,Self.DoLoadPageStructureExecuteEnd);
end;

function TPage.SavePageJsonToServer(APageJson: ISuperObject;APageStructureJson:ISuperObject;
  var ADesc: String): Boolean;
var
  AIsAdd:Boolean;
  ACode:Integer;
  ADataJson:ISuperObject;
  APostStream:TMemoryStream;
  AResponseStream:TStringStream;
//  AMultipartFormData:TMultipartFormData;
begin
  Result:=False;
  //先将页面保存到数据库
  //将页面记录保存到服务端
  if SaveRecordToServer(InterfaceUrl,
                          AppID,
                          GlobalBaseManager.User.fid,
                          GlobalBaseManager.User.key,
                          'page',
                          Self.fid,
                          APageJson,
                          //返回是否是新增的记录
                          AIsAdd,
                          ADesc,
                          ADataJson,
                          '',
                          '') then
  begin
    //保存成功,要取出新增记录的fid
    if AIsAdd then
    begin
      Self.fid:=ADataJson.I['fid'];
      Self.LoadFromJson(ADataJson);
    end;
  end
  else
  begin
    ShowMessage(ADesc);
    Exit;
  end;


//  {$IFDEF FMX}
  //备份文件
  if FileExists(GetPageDataDir+Self.name+'.json') then
  begin
    ForceDirectories(GetPageDataDir+'backup\');
//    System.IOUtils.TFile.Move(GetPageDataDir+Self.name+'.json',GetPageDataDir+'backup\'+Self.name+' '+FormatDateTime('YYYY-MM-DD HH-MM-SS-ZZZ',Now)+'.json');
    System.IOUtils.TFile.Copy(GetPageDataDir+Self.name+'.json',GetPageDataDir+'backup\'+Self.name+' '+FormatDateTime('YYYY-MM-DD HH-MM-SS-ZZZ',Now)+'.json');
  end;
//  {$ENDIF}


  //保存成文件
  SaveStringToFile(formatJson(UTFStrToUnicode(APageStructureJson.AsJSON)),Self.GetPageDataDir+Self.name+'.json',TEncoding.UTF8);

  AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
  APostStream:=TMemoryStream.Create;

//  AMultipartFormData:=TMultipartFormData.Create;
//  AMultipartFormData.AddFile('page_json',GetPageDataDir+Self.name+'.json');
  try
    APostStream.LoadFromFile(GetPageDataDir+Self.name+'.json');

    //  AMultipartFormData.AddFile('upfile','C:\腾讯云.mp4','video/mp4');
    //  AMultipartFormData.Stream;
    //  AMultipartFormData.AddFile();

//    NetHTTPClient1.Post('http://yq.6nq.com/tencent_xugc/upload.php',
//                            AMultipartFormData,
//                            AResponseStream);

//    AMultipartFormData.Stream.Position:=0;

    if not SimpleCallAPI('save_page_data2',
                  nil,
                  uOpenClientCommon.InterfaceUrl+'program_framework/',
                  [
                  'key','program_fid','page_name'
                  ],
                  [
                  GlobalBaseManager.User.key,Self.program_template_fid,Self.Name
                  ],
                  ACode,
                  ADesc,
                  ADataJson,
                  GlobalRestAPISignType,
                  GlobalRestAPIAppSecret,
                  True,
                  APostStream//AMultipartFormData.Stream
                  ) or (ACode<>SUCC) then
    begin
      Exit;
    end;

    Result:=True;

  finally
//    FreeAndNil(AMultipartFormData);
    FreeAndNil(APostStream);
    FreeAndNil(AResponseStream);
  end;
end;

function TPage.SavePageStructureToJson(ASuperObject: ISuperObject;var ADesc:String): Boolean;
var
  I: Integer;
  AControlRecordJson:ISuperObject;
  ASuperArray:ISuperArray;
  ADataIntfJson:ISuperObject;
begin


  Result:=SaveToJson(ASuperObject);
  if not Result then Exit;




//  //保存接口
//  if (DataInterface<>nil) and not DataInterface.IsEmpty then
//  begin
//    ADataIntfJson:=TSuperObject.Create();
//    ASuperObject.O['data_interface']:=ADataIntfJson;
//    DataInterface.SaveToJson(ASuperObject.O['data_interface']);
//  end;
//
//
//  //保存接口2
//  if (DataInterface2<>nil) and not DataInterface2.IsEmpty then
//  begin
//    ADataIntfJson:=TSuperObject.Create();
//    ASuperObject.O['data_interface2']:=ADataIntfJson;
//    DataInterface2.SaveToJson(ASuperObject.O['data_interface2']);
//  end;




  //保存控件列表
  ASuperArray:=TSuperArray.Create;
  ASuperObject.A['controls']:=ASuperArray;

  for I := 0 to Self.MainLayoutControlList.Count-1 do
  begin
      AControlRecordJson:=TSuperObject.Create;

      if not TPageFieldControlSetting(MainLayoutControlList[I]).SaveToJson(AControlRecordJson) then
      begin
        Exit;
      end;

      ASuperArray.O[I]:=AControlRecordJson;
  end;


  Result:=True;

end;



{ TLayoutSetting }

procedure TLayoutSetting.Clear;
begin

  Self.align_type:=Const_PageAlignType_Auto;
  col_width:=-1;
  col_count:=1;
  row_height:=50;
  {$IFDEF FMX}
  hint_label_width:=80;
  {$ENDIF}
  {$IFDEF VCL}
  hint_label_width:=120;
  {$ENDIF}
end;

constructor TLayoutSetting.Create;
begin
  Clear;
end;

function TLayoutSetting.LoadFromJson(AJson: ISuperObject): Boolean;
begin

  Result:=False;

  //排列类型,auto,manual
  align_type:=AJson.S[name+'_'+'align_type'];


  //控件排几列
  col_count:=AJson.I[name+'_'+'col_count'];
  //控件的宽度
  col_width:=AJson.F[name+'_'+'col_width'];
  //控件的高度
  row_height:=AJson.F[name+'_'+'row_height'];
  //控件的间隔
  row_space:=AJson.F[name+'_'+'row_space'];



  //提示文本的宽度
  hint_label_width:=AJson.F[name+'_'+'hint_label_width'];


  //控件的左边距
  margins_left:=AJson.F[name+'_'+'margins_left'];
  margins_top:=AJson.F[name+'_'+'margins_top'];
  margins_right:=AJson.F[name+'_'+'margins_right'];
  margins_bottom:=AJson.F[name+'_'+'margins_bottom'];


  Result:=True;


end;

function TLayoutSetting.SaveToJson(AJson: ISuperObject): Boolean;
begin

  Result:=False;

  //排列类型,auto,manual
  if align_type<>'' then AJson.S[name+'_'+'align_type']:=align_type;


  //控件排几列
  if col_count<>0 then AJson.I[name+'_'+'col_count']:=col_count;
  //控件的宽度
  if col_width<>0 then AJson.F[name+'_'+'col_width']:=col_width;
  //控件的高度
  if row_height<>0 then AJson.F[name+'_'+'row_height']:=row_height;
  //控件的间隔
  if row_space<>0 then AJson.F[name+'_'+'row_space']:=row_space;



  //提示文本的宽度
  if hint_label_width<>0 then AJson.F[name+'_'+'hint_label_width']:=hint_label_width;


  //控件的左边距
  if margins_left<>0 then AJson.F[name+'_'+'margins_left']:=margins_left;
  if margins_top<>0 then AJson.F[name+'_'+'margins_top']:=margins_top;
  if margins_right<>0 then AJson.F[name+'_'+'margins_right']:=margins_right;
  if margins_bottom<>0 then AJson.F[name+'_'+'margins_bottom']:=margins_bottom;


  Result:=True;

end;


{ TLayoutSettingList }

function TLayoutSettingList.Find(APagePart: String): TLayoutSetting;
var
  I: Integer;
begin
  Result:=nil;


  if APagePart='' then
  begin
    APagePart:='main';
  end;

  for I := 0 to Count-1 do
  begin
    if Items[I].name=APagePart then
    begin
      Result:=Items[I];
      Break;
    end;
  end;


end;

function TLayoutSettingList.GetItem(Index: Integer): TLayoutSetting;
begin
  Result:=TLayoutSetting(Inherited Items[Index]);
end;

{ TProgramTemplate }

procedure TProgramTemplate.tteGetPageBegin(ATimerTask: TTimerTask);
begin
  {$IFDEF FMX}
  ShowWaitingFrame(nil,'页面加载中...');
  {$ENDIF}
end;

procedure TProgramTemplate.tteGetPageExecute(ATimerTask: TTimerTask);
var
  ADesc:String;
  APage:TPage;
  AIsUsedCache:Boolean;
begin
  ATimerTask.TaskTag:=TASK_FAIL;
  try
      APage:=TPage(ATimerTask.TaskObject);


      if APage.LoadFromServer(
                              GlobalMainProgramSetting.OpenPlatformServerUrl,
                              GlobalMainProgramSetting.OpenPlatformAppID,
                              //APage.fid,
                              APage.program_template_name,
                              APage.function_name,
                              APage.page_type,
                              APage.platform,
                              APage.name,
                              False,
                              ADesc,
                              AIsUsedCache
                              ) then
      begin
        ATimerTask.TaskTag:=TASK_SUCC;
      end;

      ATimerTask.TaskDesc:=ADesc;


  except
    on E:Exception do
    begin
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
      uBaseLog.HandleException(E,'TFrameMain.tteGetProgramTemplateExecute');
    end;
  end;

end;

procedure TProgramTemplate.tteGetPageExecuteEnd(ATimerTask: TTimerTask);
//var
//  APage:TPage;
begin
  if Assigned(FOnGetPageExecuteEnd) then
  begin
    FOnGetPageExecuteEnd(ATimerTask);
  end;


//  try
//    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
//    begin
////      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
////      if ASuperObject.I['Code']=200 then
////      begin
//
//        APage:=TPage(ATimerTask.TaskObject);
//
//        //加载工程
//        //Self.DoLoadPage(APage);
//
//
////      end
////      else
////      begin
////        //登录失败
////        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
////      end;
//
//    end
//    else if TTimerTask(ATimerTask).TaskDesc<>'' then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(nil,TTimerTask(ATimerTask).TaskDesc);
//    end
//    else //if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(nil,'网络异常,请检查您的网络连接!');
//    end;
//  finally
//    HideWaitingFrame;
//  end;
end;

//procedure TProgramTemplate.AddDatabaseConfigToServer(ADatabaseConfig: TDatabaseConfig);
//var
//  AIsAdd:Boolean;
//  ADesc:String;
//  ADataJson:ISuperObject;
//  ARecordJson:ISuperObject;
//begin
//  ARecordJson:=SO();
//  ADatabaseConfig.SaveToJson(ARecordJson);
//  //将页面记录保存到服务端
//  if not SaveRecordToServer(FInterfaceUrl,
//                            appid,
//                            '',
//                            '',
//                            'database_config',
//                            0,
//                            ARecordJson,
//                            //返回是否是新增的记录
//                            AIsAdd,
//                            ADesc,
//                            ADataJson,
//                            GlobalRestAPISignType,
//                            GlobalRestAPIAppSecret,
//                            True) then
//  begin
//    Exit;
//  end;
//end;

procedure TProgramTemplate.Clear;
begin

    fid:=0;
    appid:=0;
    user_fid:='';


    name:='';
    caption:='';
    description:='';

//    //接口列表
//    DataIntfList:TDataInterfaceList;


    //页面列表
    PageList.Clear();

    IsLoaded:=False;
    FLoadedProgramDir:='';

end;

constructor TProgramTemplate.Create;
begin
  PageList:=TPageList.Create();
  PageList.FProgramTemplate:=Self;

//  DataBaseModuleList:=TBaseDataBaseModuleList.Create;
  DataBaseConfigList:=TRestDataBaseConfigList.Create();

  tteGetPage:=TTimerTaskEvent.Create(nil);
  tteGetPage.OnBegin:=Self.tteGetPageBegin;
  tteGetPage.OnExecute:=Self.tteGetPageExecute;
  Self.tteGetPage.OnExecuteEnd:=tteGetPageExecuteEnd;

end;

destructor TProgramTemplate.Destroy;
begin
  FreeAndNil(PageList);
//  FreeAndNil(DataBaseModuleList);
  FreeAndNil(DataBaseConfigList);

  FreeAndNil(tteGetPage);

  inherited;
end;

function TProgramTemplate.GetProgramTemplateDir: String;
begin
//  Result:=GetApplicationPath;
  Result:=GetApplicationPath+'programs'+PathDelim+IntToStr(Self.fid)+PathDelim;
  if Self.FLoadedProgramDir<>'' then
  begin
    Result:=ExtractFilePath(FLoadedProgramDir);
  end;
end;

//function TProgramTemplate.IsLocal: Boolean;
//begin
//  Result:=(FLoadedProgramDir<>'');
//end;

function TProgramTemplate.LoadFromFile(AJsonFilePath: String): Boolean;
var
  ASuperObject:ISuperObject;
begin
  if not FileExists(AJsonFilePath) then
  begin
    AJsonFilePath:=AJsonFilePath+'program.json';
  end;
  if FileExists(AJsonFilePath) then
  begin
    FLoadedProgramDir:=ExtractFilePath(AJsonFilePath);
    ASuperObject:=TSuperObject.Create(GetStringFromFile(AJsonFilePath,TEncoding.UTF8));
    Self.LoadFromJson(ASuperObject);



    //页面列表呢?
    //页面列表保存在同级目录的pages.json中
    if FileExists(ExtractFilePath(AJsonFilePath)+'pages.json') then
    begin
      Self.PageList.LoadIndexFromFile(ExtractFilePath(AJsonFilePath)+'pages.json');
    end;

  end;
end;

function TProgramTemplate.LoadFromJson(AJson: ISuperObject): Boolean;
var
  I: Integer;
  APage:TPage;
//var
//  ADataIntfListArray:ISuperArray;
//  I: Integer;
//  ADataIntfListJson:ISuperObject;
begin
  Result:=False;

  fid:=AJson.I['fid'];
  Self.appid:=AJson.I['appid'];
  user_fid:=AJson.V['user_fid'];


  name:=AJson.S['name'];
  caption:=AJson.S['caption'];
  description:=AJson.S['description'];



  //Self.PageList.Clear();
  PageList.LoadIndexFromJsonArray(AJson.A['page_list']);

//  for I := 0 to AJson.A['page_list'].Length-1 do
//  begin
//    APage:=TPage.Create;
//
//  end;
  DataBaseConfigList.LoadFromJsonArray(AJson.A['database_list']);

//  ADataIntfListArray:=TSuperArray.Create;
//  AJson.A['data_intf_list']:=ADataIntfListArray;
//  for I := 0 to Self.DataIntfList.Count-1 do
//  begin
//    ADataIntfListJson:=TSuperObject.Create;
//    DataIntfList[I].SaveToJson(ADataIntfListJson);
//    ADataIntfListArray.O[I]:=ADataIntfListJson;
//  end;

  IsLoaded:=True;

  FJson:=AJson;
  Result:=True;

end;

procedure TProgramTemplate.LoadFromLocal;
var
  ASubDirs: TArray<string>;
  I: Integer;
  APageName:String;
  APageStructure:TPage;
  APageJsonStr:String;
  APageJson:ISuperObject;
begin
  PageList.Clear(True);
  ASubDirs := TDirectory.GetDirectories(Self.GetProgramTemplateDir);
  for I := 0 to Length(ASubDirs)-1 do
  begin
    APageName:=ExtractFileName(ASubDirs[i]);
    if not FileExists(ASubDirs[i]+PathDelim+APageName+'.json') then
    begin
      continue;
    end;

    APageJsonStr:=GetStringFromFile(ASubDirs[i]+PathDelim+APageName+'.json',TEncoding.UTF8);
    APageJson:=SO(APageJsonStr);
    
    if APageJson.I['is_deleted']=1 then
    begin
      continue;
    end;
    
//    try
      APageStructure:=TPage.Create(nil);
      APageStructure.ProgramTemplate:=Self;
      if not APageStructure.LoadFromJson(APageJson) then
      begin
        uBaseLog.HandleException(nil,'TProgramTemplate.LoadFromLocal PageName:'+APageName+' APageStructure.LoadFromJson Fail '+APageJsonStr);
        FreeAndNil(APageStructure);
        Continue;
      end;
      Self.PageList.Add(APageStructure);
//    except
//      on E:Exception do
//      begin
//        uBaseLog.HandleException(E,'TProgramTemplate.LoadFromLocal '+APageName+' APageStructure.LoadFromJson '+APageJsonStr);
//      end;
//    end;

  end;
end;

function TProgramTemplate.LoadFromServer(AInterfaceUrl: String;
  AAppID: String;
  AProgramTemplateName: String;
  var ADesc:String): Boolean;
var
  ACode: Integer;
  ADataJson:ISuperObject;
var
  I: Integer;
  APageStructure:TPage;
  ALocalPageJson:ISuperObject;
begin
  Result:=False;
  ADesc:='';

//  FInterfaceUrl:=AInterfaceUrl;



  PageList.Clear(True);


  //不存在fid,表示要新增该记录
  if not SimpleCallAPI(
                      'get_record',
                      nil,
                      AInterfaceUrl+'tablecommonrest/',
                      ConvertToStringDynArray(['appid',
                                              'user_fid',
                                              'key',

                                              'rest_name',
                                              'where_key_json'
                                              ]),
                      ConvertToVariantDynArray([
                                              AAppID,
                                              GlobalBaseManager.user.fid,
                                              GlobalBaseManager.user.key,
                                              'program_template',
                                              GetWhereConditions(['appid','name'],
                                                                [AAppID,AProgramTemplateName])
                                              ]),
                      ACode,
                      ADesc,
                      ADataJson,
                      GlobalRestAPISignType,
                      GlobalRestAPIAppSecret) or (ACode<>SUCC) then
  begin
    Exit;
  end;

//  if ACode<>SUCC then
//  begin
//    ShowMessage(ADesc);
//  end;


  //加载程序模板
  Self.LoadFromJson(ADataJson);

  //本地临时目录
//  FLoadedProgramDir:=GetApplicationPath+'programs'+PathDelim+AProgramTemplateName+PathDelim;
//  ForceDirectories(FLoadedProgramDir);


  //加载程序模板的所有功能和页面
  if not SimpleCallAPI(
                      'get_record_list',
                      nil,
                      AInterfaceUrl+'tablecommonrest/',
                      ConvertToStringDynArray(['appid',
                                              'user_fid',
                                              'key',
                                              'rest_name',
                                              'pageindex',
                                              'pagesize',
                                              'where_key_json',
                        //                      'where_sql',
                                              'order_by'
                                              ]),
                      ConvertToVariantDynArray([
                                              AAppID,
                                              GlobalBaseManager.user.fid,
                                              GlobalBaseManager.user.key,
                                              'page_no_function',
                                              1,
                                              MaxInt,
                                              GetWhereConditions(['program_template_fid'],
                                                                [fid]),
                        //                      ' AND (program_template_name='+QuotedStr(AProgramTemplateName)+' OR '+'page_program_template_name='+QuotedStr(AProgramTemplateName)+') ',
                                              'orderno ASC,createtime ASC'
                                              ]),
                      ACode,
                      ADesc,
                      ADataJson,
                      GlobalRestAPISignType,
                      GlobalRestAPIAppSecret) or (ACode<>SUCC) then
  begin
    Exit;
  end;



  //保存成文件
  SaveStringToFile(formatJson(UTFStrToUnicode(ADataJson.AsJSON)),Self.GetProgramTemplateDir+'pagelist'+'.json',TEncoding.UTF8);


  for I := 0 to ADataJson.A['RecordList'].Length-1 do
  begin
    APageStructure:=TPage.Create(nil);
    APageStructure.ProgramTemplate:=Self;


    APageStructure.LoadFromJson(ADataJson.A['RecordList'].O[I]);


    if FileExists(APageStructure.GetPageDataDir+'record'+'.json') then
    begin
        //与本地进行比对,如果更新时间一致,没有必要重新下载机器人脚本,提高启动速度
        ALocalPageJson:=SO(GetStringFromFile(APageStructure.GetPageDataDir+'record'+'.json',TEncoding.UTF8));
        if (ALocalPageJson.S['updatetime']<>ADataJson.A['RecordList'].O[I].S['updatetime']) or (ADataJson.A['RecordList'].O[I].S['updatetime']='') then
        begin
          APageStructure.FIsNeedDownload:=True;
        end;


    end;
    //将这个json保存到本地,以方便下次比对
    SaveStringToFile(formatJson(UTFStrToUnicode(ADataJson.A['RecordList'].O[I].AsJSON)),APageStructure.GetPageDataDir+'record'+'.json',TEncoding.UTF8);

    Self.PageList.Add(APageStructure);
  end;



  Result:=True;


end;

function TProgramTemplate.LoadPage(APageFID: Integer;AOnGetPageExecuteEnd: TTimerTaskNotify): Boolean;
var
  APage:TPage;
begin
  Result:=False;

  //当找不到了,怎么办?从服务端加载
  APage:=Self.PageList.Find(APageFID);
  if APage=nil then
  begin
    APage:=TPage.Create(nil);
    Self.PageList.Add(APage);

    APage.ProgramTemplate:=Self;

    APage.fid:=APageFID;

  end;
  if not APage.IsLoaded then
  begin
      //加载
      FOnGetPageExecuteEnd:=AOnGetPageExecuteEnd;
      Self.tteGetPage.TaskObject:=APage;
      Self.tteGetPage.Run();
//  end
//  else
//  begin
//      //激活
//      Self.DoShowPageFrame(APage);

  end;

  Result:=True;

  
end;

function TProgramTemplate.NewPage(APageName:String): TPage;
begin
  Result:=TPage.Create(nil);

  //初始好
  Result.name:=APageName;//'new_page';
  Result.caption:='新建页面';

//  if Result.DataInterface<>nil then Result.DataInterface.intf_type:=Const_IntfType_TableCommonRest;
  Result.data_intf_class:=Const_IntfType_TableCommonRest;

  Result.platform:='pc';


  Result.page_type:=Const_PageType_ViewPage;

  Result.program_template_fid:=Self.fid;
  Result.program_template_name:=Self.name;

  Result.IsLoaded:=True;


  Result.ProgramTemplate:=Self;
  Self.PageList.Add(Result);

end;

function TProgramTemplate.LoadPage(AProgram, AFunction, APageType, APageName, APlatform: String;
                                    AOnGetPageExecuteEnd: TTimerTaskNotify):Boolean;
var
  APage:TPage;
begin
  Result:=False;

  //当找不到了,怎么办?从服务端加载
  APage:=Self.PageList.Find(AFunction,APageType,APageName,APlatform);
  if APage=nil then
  begin
    APage:=TPage.Create(nil);
    Self.PageList.Add(APage);

    APage.ProgramTemplate:=Self;

    APage.program_template_name:=AProgram;
    APage.function_name:=AFunction;
    APage.page_type:=APageType;
    APage.platform:=APlatform;
    APage.name:=APageName;

  end;
  if not APage.IsLoaded then
  begin
      //加载
      FOnGetPageExecuteEnd:=AOnGetPageExecuteEnd;
      Self.tteGetPage.TaskObject:=APage;
      Self.tteGetPage.Run();
//  end
//  else
//  begin
//      //激活
//      Self.DoShowPageFrame(APage);

  end;

  Result:=True;

end;

procedure TProgramTemplate.SaveToLocal;
begin
  if FLoadedProgramDir<>'' then
  begin
    Self.SaveToFile(FLoadedProgramDir);
  end;

end;

function TProgramTemplate.SaveToFile(AJsonFilePath: String): Boolean;
var
  ASuperObject:ISuperObject;
begin
  Result:=False;

  ASuperObject:=TSuperObject.Create;
  Self.SaveToJson(ASuperObject);

  AJsonFilePath:=AJsonFilePath+'program.json';

  SaveStringToFile(//ASuperObject.AsJSON,
                    formatJson(UTFStrToUnicode(ASuperObject.AsJSON)),
                    AJsonFilePath,TEncoding.UTF8);


  //页面列表呢?
  //页面列表保存在同级目录的pages.json中

  Self.PageList.SaveIndexToFile(ExtractFilePath(AJsonFilePath)+'pages.json');



  Result:=True;
end;

function TProgramTemplate.SaveToJson(AJson: ISuperObject): Boolean;
//var
//  I: Integer;
//  APageJson:ISuperObject;
//  ADataInterface:TDataInterface;
//  ADataIntfListArray:ISuperArray;
begin
  Result:=False;


  if fid<>0 then AJson.I['fid']:=fid;
  AJson.I['appid']:=Self.appid;


  AJson.V['user_fid']:=user_fid;


  AJson.S['name']:=name;
  AJson.S['caption']:=caption;
  AJson.S['description']:=description;

  PageList.SaveIndexToJsonArray(AJson.A['page_list']);


  DataBaseConfigList.SaveToJsonArray(AJson.A['database_list']);

//  for I := 0 to PageList.Count-1 do
//  begin
//    APageJson:=SO();
//    SaveToIndexJson();
////    APageJson.S['name']:=PageList[I].Name;
////    APageJson.S['caption']:=PageList[I].Caption;
//    AJson.A['page_list'].O[AJson.A['page_list'].Length]:=APageJson;
//  end;

//  DataIntfList.Clear();
//  for I := 0 to AJson.A['data_intf_list'].Length-1 do
//  begin
//    ADataInterface:=TDataInterface.Create;
//    ADataInterface.LoadFromJson(AJson.A['data_intf_list'].O[I]);
//    Self.DataIntfList.Add(ADataInterface);
//  end;


  Result:=True;

end;

function TProgramTemplate.SaveToServer(AInterfaceUrl: String;
  var ADesc: String): Boolean;
begin
  //

end;

//procedure TProgramTemplate.LoadFromLocal;
//var
//  ASuperObject:ISuperObject;
//begin
//  if FileExists(GetApplicationPath+'programs\'+name+'\'+'program.json') then
//  begin
//    ASuperObject:=TSuperObject.Create(GetStringFromFile(GetApplicationPath+'program.json',TEncoding.UTF8));
//
//    Self.LoadFromJson(ASuperObject)
//  end;
//end;
//
//procedure TProgramTemplate.SaveToLocal;
//var
//  ASuperObject:ISuperObject;
//begin
//  ASuperObject:=TSuperObject.Create;
//  Self.SaveToJson(ASuperObject);
//  SaveStringToFile(ASuperObject.AsJSON,GetApplicationPath+'programs\'+name+'\'+'program.json',TEncoding.UTF8);
//end;





{ TPageFieldControlSetting }

constructor TPageFieldControlSetting.Create(ACollection: TCollection);
begin
  inherited;
  LayoutSetting:=TLayoutSetting.Create;

end;

destructor TPageFieldControlSetting.Destroy;
begin
  FreeAndNil(LayoutSetting);
  inherited;
end;

function TPageFieldControlSetting.GetPropJson: ISuperObject;
begin
  if FPropJson=nil then
  begin
    if Self.prop='' then
    begin
      Self.prop:='{}';
    end;
    FPropJson:=SO(Self.prop);
  end;
  Result:=FPropJson;
end;

function TPageFieldControlSetting.LoadFromJson(AJson: ISuperObject): Boolean;
begin
  Result:=False;

  try

      fid:=AJson.I['fid'];
      Self.appid:=AJson.I['appid'];


      //所属页面的FID
      page_fid:=AJson.I['page_fid'];
      //布局的FID
    //  layout_fid:=AJson.I['layout_fid'];
      control_style:=AJson.S['control_style'];


      //父控件的id
      parent_control_fid:=AJson.I['parent_control_fid'];
      parent_control_name:=AJson.S['parent_control_name'];



      name:=AJson.S['name'];
      control_type:=AJson.S['control_type'];


      field_name:=AJson.S['field_name'];
      data_source_name:=AJson.S['data_source_name'];
      action:=AJson.S['action'];
      field_caption:=AJson.S['field_caption'];

      value:=AJson.S['value'];
      if AJson.Contains('visible') then
      begin
        visible:=AJson.I['visible'];
      end
      else
      begin
        visible:=1;
      end;

      if AJson.Contains('hittest') then
      begin
        hittest:=AJson.I['hittest'];
      end
      else
      begin
        hittest:=1;
      end;

      if AJson.Contains('enabled') then
      begin
        enabled:=AJson.I['enabled'];
      end
      else
      begin
        enabled:=1;
      end;


      x:=AJson.F['x'];
      y:=AJson.F['y'];
      width:=AJson.F['width'];
      height:=AJson.F['height'];
      margins:=AJson.S['margins'];


      anchors:=AJson.S['anchors'];
      align:=AJson.S['align'];


      back_color:=AJson.S['back_color'];
      border_color:=AJson.S['border_color'];
      border_width:=AJson.F['border_width'];
      border_edges:=AJson.S['border_edges'];

      back_round_width:=AJson.F['back_round_width'];
      back_corners:=AJson.S['back_corners'];


      text_font_name:=AJson.S['text_font_name'];
      text_font_size:=AJson.I['text_font_size'];
      text_font_color:=AJson.S['text_font_color'];
      text_vert_align:=AJson.S['text_vert_align'];
      text_horz_align:=AJson.S['text_horz_align'];
      text_style:=AJson.S['text_style'];
      text_wordwrap:=AJson.I['text_wordwrap'];



      //图片是否拉伸
      picture_is_stretch:=AJson.I['picture_is_stretch'];
      //图片是否自适应
      picture_is_autofit:=AJson.I['picture_is_autofit'];
      picture_vert_align:=AJson.S['picture_vert_align'];
      picture_horz_align:=AJson.S['picture_horz_align'];



  //    //图片路径
  //    pic_path:String;
      //图片上传到什么目录
      image_kind:=AJson.S['image_kind'];
      image_is_need_clip:=AJson.I['image_is_need_clip'];//	int	图片是否需要裁剪
      image_clip_width:=AJson.I['image_clip_width'];//	int	裁剪图片的宽度
      image_clip_height:=AJson.I['image_clip_height'];//	int	裁剪图片的高度
      image_max_count:=AJson.I['image_max_count'];//	int	最多支持添加几张图片,0表示默认1
      //image_upload_url	nvarchar(255)	上传图片的接口地址,
      //比如：http://www.orangeui.cn:10011/upload?appid=1003&filename=%s&filedir=repair_car_order_pic&fileext=.jpg
      other_field_names:=AJson.S['other_field_names'];//	nvarchar(45)	图片宽度的字段名,比如pic1_width,创建这个控件，在选择好图片之后赋宽度给它
      other_field_controlprops:=AJson.S['other_field_controlprops'];//	nvarchar(45)	图片宽度的字段名,比如pic1_width,创建这个控件，在选择好图片之后赋宽度给它




      has_caption_label:=AJson.I['has_caption_label'];
      has_caption_label_caption:=AJson.I['has_caption_label_caption'];
      caption_label_caption:=AJson.S['caption_label_caption'];



      input_format:=AJson.S['input_format'];//	nvarchar(45)	输入格式要求，保存的时候要使用,相关的控件是edit,comboedit
      //		number,只允许输入数字
      //		email,必须是email
      //		phone,必须是手机号
      input_prompt:=AJson.S['input_prompt'];//	nvarchar(255)	输入提示,比如请输入密码
      input_max_length:=AJson.I['input_max_length'];//	int	输入字符串的最大长度
      input_read_only:=AJson.I['input_read_only'];//	int	是否只读






      options_value:=AJson.S['options_value'];
      options_caption:=AJson.S['options_caption'];
      options_is_multi_select:=AJson.I['options_is_multi_select'];//	int	是否支持多选

      options_page_fid:=AJson.I['options_page_fid'];//	int	选择选项的列表页面fid,它里面包含数据接口
      options_page_name:=AJson.S['options_page_name'];//	int	选择选项的列表页面fid,它里面包含数据接口
      options_page_value_field_name:=AJson.S['options_page_value_field_name'];//	nvarchar(45)	选择选项列表页面的值字段
      options_page_caption_field_name:=AJson.S['options_page_caption_field_name'];//	nvarchar(45)	选择选项列表页面的标题字段
      options_has_empty:=AJson.I['options_has_empty'];//	int	是否拥有空的选项
      options_empty_value:=AJson.S['options_empty_value'];//	nvarchar(45)
      options_empty_caption:=AJson.S['options_empty_caption'];//	nvarchar(45)
      options_caption_field_name:=AJson.S['options_caption_field_name'];//	nvarchar(45)//在编辑页面和查看页面能直接取到值的标题



      page_part:=AJson.S['page_part'];



      bind_listitem_data_type:=AJson.S['bind_listitem_data_type'];
      prop:=AJson.S['prop'];
//      prop:=AJson;

      orderno:=AJson.F['orderno'];
      is_deleted:=AJson.I['is_deleted'];



      control_page_fid:=AJson.I['control_page_fid'];
      control_page_name:=AJson.S['control_page_name'];



//      jump_to_page_program:=AJson.S['jump_to_page_program'];//	nvarchar(255)	跳转到指定的页面的程序模板name,比如ycliving
//      jump_to_page_function:=AJson.S['jump_to_page_function'];//	nvarchar(255)	跳转到指定的页面的功能name,比如shop_goods_manage
//      jump_to_page_type:=AJson.S['jump_to_page_type'];//	nvarchar(255)	跳转到指定的页面的页面类型,list_page
//
//      jump_to_page_fid:=AJson.I['jump_to_page_fid'];//	int	跳转到指定的页面的页面fid,比较直接
      jump_to_page_name:=AJson.S['jump_to_page_name'];//	nvarchar(255)	跳转到指定的页面的页面name,比如goods_list_page



      Result:=True;
  except
    on E:Exception do
    begin
      uBaseLog.HandleException(E,'TFieldControlSetting.LoadFromJson');
    end;
  end;
end;

function TPageFieldControlSetting.SaveToJson(AJson: ISuperObject): Boolean;
var
  APropJson:ISuperObject;
begin
  Result:=False;


  AJson.S['name']:=name;
  AJson.S['control_type']:=control_type;


  if fid<>0 then AJson.I['fid']:=fid;
  if appid<>0 then AJson.I['appid']:=Self.appid;


  //所属页面的FID
  if page_fid<>0 then AJson.I['page_fid']:=page_fid;
  //布局的FID
//  if layout_fid<>0 then AJson.I['layout_fid']:=layout_fid;

  if control_style<>'' then AJson.S['control_style']:=control_style;


  //父控件的id
  if parent_control_fid<>0 then AJson.I['parent_control_fid']:=parent_control_fid;
  if parent_control_name<>'' then AJson.S['parent_control_name']:=parent_control_name;




  if field_name<>'' then AJson.S['field_name']:=field_name;
  if data_source_name<>'' then AJson.S['data_source_name']:=data_source_name;
  if action<>'' then AJson.S['action']:=action;


  if value<>'' then AJson.S['value']:=value;
  //if visible=0 then
  AJson.I['visible']:=visible;
  //if hittest=0 then
  AJson.I['hittest']:=hittest;
  //if enabled=0 then
  AJson.I['enabled']:=enabled;


  AJson.F['x']:=x;
  AJson.F['y']:=y;
  AJson.F['width']:=width;
  AJson.F['height']:=height;
  if (margins<>'') and (margins<>'0,0,0,0') then AJson.S['margins']:=margins;


  if anchors<>'' then AJson.S['anchors']:=anchors;
  if (align<>'') and (align<>'None') then AJson.S['align']:=align;


  if back_color<>'' then AJson.S['back_color']:=back_color;
  if border_color<>'' then AJson.S['border_color']:=border_color;
  if border_width<>0 then AJson.F['border_width']:=border_width;
  if border_edges<>'' then AJson.S['border_edges']:=border_edges;


  if back_round_width<>0 then AJson.F['back_round_width']:=back_round_width;
  if back_corners<>'' then AJson.S['back_corners']:=back_corners;



  if text_font_name<>'' then AJson.S['text_font_name']:=text_font_name;
  if text_font_size<>0 then AJson.I['text_font_size']:=text_font_size;

  //if (text_font_color<>'') and (text_font_color<>'FF000000') then
  AJson.S['text_font_color']:=text_font_color;

  if (text_vert_align<>'') and (text_vert_align<>'Top') then AJson.S['text_vert_align']:=text_vert_align;
  if (text_horz_align<>'') and (text_horz_align<>'Left') then AJson.S['text_horz_align']:=text_horz_align;
  if text_style<>'' then AJson.S['text_style']:=text_style;
  if text_wordwrap<>0 then AJson.I['text_wordwrap']:=text_wordwrap;



  if picture_is_stretch<>0 then AJson.I['picture_is_stretch']:=picture_is_stretch;
  if picture_is_autofit<>0 then AJson.I['picture_is_autofit']:=picture_is_autofit;
  if (picture_vert_align<>'') and (picture_vert_align<>'Top') then AJson.S['picture_vert_align']:=picture_vert_align;
  if (picture_horz_align<>'') and (picture_horz_align<>'Left') then AJson.S['picture_horz_align']:=picture_horz_align;



//    //图片路径
//    pic_path:String;
  if image_kind<>'' then AJson.S['image_kind']:=image_kind;//	int	图片是否需要裁剪
  if image_is_need_clip<>0 then AJson.I['image_is_need_clip']:=image_is_need_clip;//	int	图片是否需要裁剪
  if image_clip_width<>0 then AJson.I['image_clip_width']:=image_clip_width;//	int	裁剪图片的宽度
  if image_clip_height<>0 then AJson.I['image_clip_height']:=image_clip_height;//	int	裁剪图片的高度
  if image_max_count<>0 then AJson.I['image_max_count']:=image_max_count;//	int	最多支持添加几张图片,0表示默认1
  //image_upload_url	nvarchar(255)	上传图片的接口地址,
  //比如：http://www.orangeui.cn:10011/upload?appid=1003&filename=%s&filedir=repair_car_order_pic&fileext=.jpg
  if other_field_names<>'' then AJson.S['other_field_names']:=other_field_names;//	nvarchar(45)	图片宽度的字段名,比如pic1_width,创建这个控件，在选择好图片之后赋宽度给它
  if other_field_controlprops<>'' then AJson.S['other_field_controlprops']:=other_field_controlprops;//	nvarchar(45)	图片宽度的字段名,比如pic1_width,创建这个控件，在选择好图片之后赋宽度给它




  if has_caption_label<>0 then AJson.I['has_caption_label']:=has_caption_label;
  if has_caption_label_caption<>0 then AJson.I['has_caption_label_caption']:=has_caption_label_caption;
  if caption_label_caption<>'' then AJson.S['caption_label_caption']:=caption_label_caption;


  if input_format<>'' then AJson.S['input_format']:=input_format;//	nvarchar(45)	输入格式要求，保存的时候要使用,相关的控件是edit,comboedit
  //		number,只允许输入数字
  //		email,必须是email
  //		phone,必须是手机号
  if input_prompt<>'' then AJson.S['input_prompt']:=input_prompt;//	nvarchar(255)	输入提示,比如请输入密码
  if input_max_length<>0 then AJson.I['input_max_length']:=input_max_length;//	int	输入字符串的最大长度
  if input_read_only<>0 then AJson.I['input_read_only']:=input_read_only;//	int	是否只读




  if options_value<>'' then AJson.S['options_value']:=options_value;
  if options_caption<>'' then AJson.S['options_caption']:=options_caption;

  if options_page_fid<>0 then AJson.I['options_page_fid']:=options_page_fid;//	int	选择选项的列表页面fid,它里面包含数据接口
  if options_page_name<>'' then AJson.S['options_page_name']:=options_page_name;//	int	选择选项的列表页面fid,它里面包含数据接口
  if options_page_value_field_name<>'' then AJson.S['options_page_value_field_name']:=options_page_value_field_name;//	nvarchar(45)	选择选项列表页面的值字段
  if options_page_caption_field_name<>'' then AJson.S['options_page_caption_field_name']:=options_page_caption_field_name;//	nvarchar(45)	选择选项列表页面的标题字段
  if options_has_empty<>0 then AJson.I['options_has_empty']:=options_has_empty;//	int	是否拥有空的选项
  if options_empty_value<>'' then AJson.S['options_empty_value']:=options_empty_value;//	nvarchar(45)
  if options_empty_caption<>'' then AJson.S['options_empty_caption']:=options_empty_caption;//	nvarchar(45)

  if options_caption_field_name<>'' then AJson.S['options_caption_field_name']:=options_caption_field_name;




  if page_part<>'' then AJson.S['page_part']:=page_part;



  if bind_listitem_data_type<>'' then AJson.S['bind_listitem_data_type']:=bind_listitem_data_type;

  if prop<>'' then
  begin
    AJson.S['prop']:=prop;
    //直接将prop中的Json保存到根Json中
    APropJson:=SO(prop);
    MergeJson(APropJson,AJson,True,True,[]);
  end;

  if orderno<>0 then AJson.F['orderno']:=orderno;
  if is_deleted<>0 then AJson.I['is_deleted']:=is_deleted;


  //子页面
  if control_page_fid<>0 then AJson.I['control_page_fid']:=control_page_fid;
  if control_page_name<>'' then AJson.S['control_page_name']:=control_page_name;




//  if jump_to_page_program<>'' then AJson.S['jump_to_page_program']:=jump_to_page_program;//	nvarchar(255)	跳转到指定的页面的程序模板name,比如ycliving
//  if jump_to_page_function<>'' then AJson.S['jump_to_page_function']:=jump_to_page_function;//	nvarchar(255)	跳转到指定的页面的功能name,比如shop_goods_manage
//  if jump_to_page_type<>'' then AJson.S['jump_to_page_type']:=jump_to_page_type;//	nvarchar(255)	跳转到指定的页面的页面类型,list_page
//
//  if jump_to_page_fid<>0 then AJson.I['jump_to_page_fid']:=jump_to_page_fid;//	int	跳转到指定的页面的页面fid,比较直接
  if jump_to_page_name<>'' then AJson.S['jump_to_page_name']:=jump_to_page_name;//	nvarchar(255)	跳转到指定的页面的页面name,比如goods_list_page



  Result:=True;
end;

function TPageFieldControlSetting.SaveToUpdateJson(AJson: ISuperObject;AOldSetting: TFieldControlSetting;var AIsChanged:Boolean): Boolean;
begin
  Result:=False;
  AIsChanged:=False;


//  if fid<>0 then
  AJson.I['fid']:=fid;
//  if appid<>0 then
  AJson.I['appid']:=Self.appid;


  //所属页面的FID
//  if page_fid<>0 then
  if page_fid<>AOldSetting.page_fid then
  begin
    AIsChanged:=True;
    AJson.I['page_fid']:=page_fid;
  end;
  //布局的FID
//  if layout_fid<>0 then AJson.I['layout_fid']:=layout_fid;


  //父控件的id
//  if parent_control_fid<>0 then
  if parent_control_fid<>AOldSetting.parent_control_fid then
  begin
    AIsChanged:=True;
    AJson.I['parent_control_fid']:=parent_control_fid;
  end;


  if parent_control_name<>AOldSetting.parent_control_name then
  begin
    AIsChanged:=True;
    AJson.S['parent_control_name']:=parent_control_name;
  end;




  if name<>AOldSetting.name then
  begin
    AIsChanged:=True;
    AJson.S['name']:=name;
  end;
  if control_type<>AOldSetting.control_type then
  begin
    AIsChanged:=True;
    AJson.S['control_type']:=control_type;
  end;

  if field_name<>AOldSetting.field_name then
  begin
    AIsChanged:=True;
    AJson.S['field_name']:=field_name;
  end;


  if value<>AOldSetting.value then
  begin
    AIsChanged:=True;
    AJson.S['value']:=value;
  end;
  if visible<>AOldSetting.visible then
  begin
    AIsChanged:=True;
    AJson.I['visible']:=visible;
  end;
  if hittest<>AOldSetting.hittest then
  begin
    AIsChanged:=True;
    AJson.I['hittest']:=hittest;
  end;
  if enabled<>AOldSetting.enabled then
  begin
    AIsChanged:=True;
    AJson.I['enabled']:=enabled;
  end;


  if x<>AOldSetting.x then
  begin
    AIsChanged:=True;
    AJson.F['x']:=x;
  end;
  if y<>AOldSetting.y then
  begin
    AIsChanged:=True;
    AJson.F['y']:=y;
  end;
  if width<>AOldSetting.width then
  begin
    AIsChanged:=True;
    AJson.F['width']:=width;
  end;
  if height<>AOldSetting.height then
  begin
    AIsChanged:=True;
    AJson.F['height']:=height;
  end;
  if margins<>AOldSetting.margins then
  begin
    AIsChanged:=True;
    AJson.S['margins']:=margins;
  end;


  if anchors<>AOldSetting.anchors then
  begin
    AIsChanged:=True;
    AJson.S['anchors']:=anchors;
  end;
  if align<>AOldSetting.align then
  begin
    AIsChanged:=True;
    AJson.S['align']:=align;
  end;


  if back_color<>AOldSetting.back_color then
  begin
    AIsChanged:=True;
    AJson.S['back_color']:=back_color;
  end;
  if border_color<>AOldSetting.border_color then
  begin
    AIsChanged:=True;
    AJson.S['border_color']:=border_color;
  end;
  if border_width<>AOldSetting.border_width then
  begin
    AIsChanged:=True;
    AJson.F['border_width']:=border_width;
  end;
  if border_edges<>AOldSetting.border_edges then
  begin
    AIsChanged:=True;
    AJson.S['border_edges']:=border_edges;
  end;


  if back_round_width<>AOldSetting.back_round_width then
  begin
    AIsChanged:=True;
    AJson.F['back_round_width']:=back_round_width;
  end;
  if back_corners<>AOldSetting.back_corners then
  begin
    AIsChanged:=True;
    AJson.S['back_corners']:=back_corners;
  end;



  if text_font_name<>AOldSetting.text_font_name then
  begin
    AIsChanged:=True;
    AJson.S['text_font_name']:=text_font_name;
  end;
  if text_font_size<>AOldSetting.text_font_size then
  begin
    AIsChanged:=True;
    AJson.I['text_font_size']:=text_font_size;
  end;
  if text_font_color<>AOldSetting.text_font_color then
  begin
    AIsChanged:=True;
    AJson.S['text_font_color']:=text_font_color;
  end;
  if text_vert_align<>AOldSetting.text_vert_align then
  begin
    AIsChanged:=True;
    AJson.S['text_vert_align']:=text_vert_align;
  end;
  if text_horz_align<>AOldSetting.text_horz_align then
  begin
    AIsChanged:=True;
    AJson.S['text_horz_align']:=text_horz_align;
  end;
  if text_style<>AOldSetting.text_style then
  begin
    AIsChanged:=True;
    AJson.S['text_style']:=text_style;
  end;
  if text_wordwrap<>AOldSetting.text_wordwrap then
  begin
    AIsChanged:=True;
    AJson.I['text_wordwrap']:=text_wordwrap;
  end;



  if picture_is_stretch<>AOldSetting.picture_is_stretch then
  begin
    AIsChanged:=True;
    AJson.I['picture_is_stretch']:=picture_is_stretch;
  end;
  if picture_is_autofit<>AOldSetting.picture_is_autofit then
  begin
    AIsChanged:=True;
    AJson.I['picture_is_autofit']:=picture_is_autofit;
  end;
  if picture_vert_align<>AOldSetting.picture_vert_align then
  begin
    AIsChanged:=True;
    AJson.S['picture_vert_align']:=picture_vert_align;
  end;
  if picture_horz_align<>AOldSetting.picture_horz_align then
  begin
    AIsChanged:=True;
    AJson.S['picture_horz_align']:=picture_horz_align;
  end;


  if has_caption_label<>AOldSetting.has_caption_label then
  begin
    AIsChanged:=True;
    AJson.I['has_caption_label']:=has_caption_label;
  end;
  if has_caption_label_caption<>AOldSetting.has_caption_label_caption then
  begin
    AIsChanged:=True;
    AJson.I['has_caption_label_caption']:=has_caption_label_caption;
  end;
  if caption_label_caption<>AOldSetting.caption_label_caption then
  begin
    AIsChanged:=True;
    AJson.S['caption_label_caption']:=caption_label_caption;
  end;


  if bind_listitem_data_type<>AOldSetting.bind_listitem_data_type then
  begin
    AIsChanged:=True;
    AJson.S['bind_listitem_data_type']:=bind_listitem_data_type;
  end;

  if prop<>AOldSetting.prop then
  begin
    AIsChanged:=True;
    AJson.S['prop']:=prop;
  end;

  if orderno<>AOldSetting.orderno then
  begin
    AIsChanged:=True;
    AJson.F['orderno']:=orderno;
  end;
  if is_deleted<>AOldSetting.is_deleted then
  begin
    AIsChanged:=True;
    AJson.I['is_deleted']:=is_deleted;
  end;





  //除了fid和appid还有别的改过了
  //AIsChanged:=(GetJsonCount(AJson)>2);


  Result:=True;


end;



{ TPageFieldControlSettingList }

function TPageFieldControlSettingList.Add: TPageFieldControlSetting;
begin
  Result:=TPageFieldControlSetting(Inherited Add);
end;

procedure TPageFieldControlSettingList.Clear(AIsNeedFree: Boolean);
begin

end;

constructor TPageFieldControlSettingList.Create(ItemClass: TCollectionItemClass;
  AOwner: TPage);
begin
  Inherited Create(ItemClass);
  FOwner:=AOwner;
end;

function TPageFieldControlSettingList.FindByControlType(
  AControlType: String): TPageFieldControlSetting;
begin
  Result:=TPageFieldControlSetting(Inherited FindByControlType(AControlType));
end;

function TPageFieldControlSettingList.FindByFid(
  AFid: Integer): TPageFieldControlSetting;
begin
  Result:=TPageFieldControlSetting(Inherited FindByFid(AFid));
end;

function TPageFieldControlSettingList.FindByFieldName(
  AFieldName: String): TPageFieldControlSetting;
begin
  Result:=TPageFieldControlSetting(Inherited FindByFieldName(AFieldName));
end;

function TPageFieldControlSettingList.FindByName(
  AName: String): TPageFieldControlSetting;
begin
  Result:=TPageFieldControlSetting(Inherited FindByName(AName));
end;

function TPageFieldControlSettingList.FindBySavedComponent(
  ASavedComponent: TComponent): TPageFieldControlSetting;
begin
  Result:=TPageFieldControlSetting(Inherited FindBySavedComponent(ASavedComponent));
end;

function TPageFieldControlSettingList.GetItem(
  Index: Integer): TPageFieldControlSetting;
begin
  Result:=TPageFieldControlSetting(Inherited GetItem(Index));
end;


{ TPageList }

function TPageList.Find(AFunction:String;
                                  APageType:String;
                                  APageName:String;
                                  APlatform:String): TPage;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Count-1 do
  begin
    if (AFunction<>'')
        and (APageType<>'')
        and SameText(Items[I].function_name,AFunction)
         and SameText(Items[I].page_type,APageType)
      or (APageName<>'') and SameText(Items[I].name,APageName)
      then
    begin
      Result:=Items[I];
      Break;
    end;
  end;
end;

function TPageList.Find(APageFID: Integer): TPage;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Count-1 do
  begin
    if (APageFID=Items[I].fid) then
    begin
      Result:=Items[I];
      Break;
    end;
  end;
end;

function TPageList.Find(APageName: String): TPage;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Count-1 do
  begin
    if SameText(APageName,Items[I].Name) then
    begin
      Result:=Items[I];
      Break;
    end;
  end;

end;

function TPageList.GetItem(Index: Integer): TPage;
begin
  Result:=TPage(Inherited Items[Index]);
end;

procedure TPageList.LoadIndexFromFile(AJsonFilePath: String);
var
  ASuperObject:ISuperObject;
begin
  ASuperObject:=TSuperObject.Create(GetStringFromFile(AJsonFilePath,TEncoding.UTF8));
  Self.LoadIndexFromJsonArray(ASuperObject.A['pages']);
end;

procedure TPageList.LoadIndexFromJsonArray(ASuperArray: ISuperArray);
var
  I: Integer;
  APage:TPage;
begin
  Clear;
  for I := 0 to ASuperArray.Length-1 do
  begin
    APage:=TPage.Create(nil);
    APage.ProgramTemplate:=FProgramTemplate;
    APage.LoadFromIndexJson(ASuperArray.O[I]);
    Self.Add(APage);
  end;
end;

procedure TPageList.SaveIndexToFile(AJsonFilePath: String);
var
  ASuperObject:ISuperObject;
begin
  ASuperObject:=TSuperObject.Create();
  Self.SaveIndexToJsonArray(ASuperObject.A['pages']);
  SaveStringToFile(//ASuperObject.AsJSON,
                  formatJson(UTFStrToUnicode(ASuperObject.AsJSON)),
                  AJsonFilePath,TEncoding.UTF8);
end;

procedure TPageList.SaveIndexToJsonArray(ASuperArray: ISuperArray);
var
  I: Integer;
  ASuperObject:ISuperObject;
begin
  for I := 0 to Self.Count-1 do
  begin
    ASuperObject:=TSuperObject.Create();
    Items[I].SaveToIndexJson(ASuperObject);
    ASuperArray.O[I]:=ASuperObject;
  end;
end;



{ TBaseOpenPlatformFramework }


constructor TBaseOpenPlatformFramework.Create(AOwner:TComponent);
begin
  Inherited;

  FProgramTemplate:=TProgramTemplate.Create;

  GlobalProgramTemplate:=FProgramTemplate;

  //开放平台的APPID,用于获取程序信息,页面结构,默认是1000
  OpenPlatformAppID:='1000';
  //开放平台的服务器,默认是http://www.orangeui.cn:10000/
  OpenPlatformServerUrl:='http://www.orangeui.cn:10000/';
  OpenPlatformImageUrl:='http://www.orangeui.cn:10001/';


//  ProgramTemplate:=TProgramTemplate.Create;

  GlobalMainProgramSetting:=Self;
end;

destructor TBaseOpenPlatformFramework.Destroy;
begin
  GlobalMainProgramSetting:=nil;
  GlobalProgramTemplate:=nil;
  FreeAndNil(FProgramTemplate);

//  FreeAndNil(ProgramTemplate);
  inherited;
end;

procedure TBaseOpenPlatformFramework.DoCustomProcessPageAction(Sender: TObject;
  APageInstance: TObject;
  AAction: String;
  AFieldControlSettingMap:TObject;
  var AIsProcessed: Boolean);
begin
  //自定义返回的事件
  if Assigned(Self.OnCustomProcessPageAction) then
  begin
    Self.OnCustomProcessPageAction(Self,APageInstance,AAction,AFieldControlSettingMap,AIsProcessed);
//  end
//  else
//  begin
//    {$IFDEF FMX}
//    HideFrame;
//    ReturnFrame;
//    {$ENDIF}
  end;

end;

//procedure TBaseOpenPlatformFramework.DoReturnFrame(AFromFrame: TFrame);
//begin
//  //
//end;

//procedure TBaseOpenPlatformFramework.DoNeedShowPage(Sender: TObject;
//  AFromPageInstance:TPageInstance;
//  AFromFieldControlSettingMap:TFieldControlSettingMap;
//  //AToPageFID: Integer;
//  AToPage: TPage;
//  AOnReturnFrame: TReturnFromFrameEvent;
//  var AIsProcessed: Boolean);
//begin
//          if Assigned(Self.OnNeedShowPage) then
//          begin
//            Self.OnNeedShowPage(Self,
//                                AFromPageInstance,
//                                AFromFieldControlSettingMap,
////                                                    AToPageFID,
//                                                    AToPage,
////                                                    ALoadDataSetting,
//                                                    AOnReturnFrame,AIsProcessed
//                                                    );
//          end;
//
//end;

function TBaseOpenPlatformFramework.Load(AIniFilePath:String):Boolean;
var
  AIniFile:TIniFile;
begin
  Result:=False;

//  if FileExists(GetApplicationPath+'program.ini') then
//  begin
      AIniFile:=TIniFile.Create(AIniFilePath//GetApplicationPath+'program.ini'
                                {$IFNDEF MSWINDOWS},TEncoding.UTF8{$ENDIF});
      try

         //程序模板从哪个服务端获取
        //    //开放平台的APPID,用于获取程序信息,页面结构,默认是1000
        //    OpenPlatformAppID:Integer;
        //    //开放平台的服务器,默认是http://www.orangeui.cn:10000/
        //    OpenPlatformServerUrl:String;
        //    //开放平台图片下载的服务器,默认是http://www.orangeui.cn:10001/
        //    OpenPlatformImageUrl:String;
          Self.OpenPlatformAppID:=AIniFile.ReadString('','OpenPlatformAppID','1000');
          Self.OpenPlatformServerUrl:=AIniFile.ReadString('','OpenPlatformServerUrl','http://www.orangeui.cn:10000/');
          Self.OpenPlatformImageUrl:=AIniFile.ReadString('','OpenPlatformImageUrl','http://www.orangeui.cn:10001/');



        //    //应用的APPID,比如是1010
        //    AppID:Integer;
        //
        //    //程序模板的名称,比如hospitcal
        //    ProgramTemplateName:String;
        //    //主页的名称,如果为空,那么就显示默认的主页,比如是hospital_office_status
        //    MainPageName:String;
        //    //平台,比如web,pc,app
        //    Platform:String;


          Self.AppID:=AIniFile.ReadString('','AppID','');
          Self.ProgramTemplateName:=AIniFile.ReadString('','ProgramTemplateName','');
          Self.MainPageName:=AIniFile.ReadString('','MainPageName','');
          Self.Platform:=AIniFile.ReadString('','Platform','');
          //应用数据从哪个服务端获取
          Self.DataIntfServerUrl:=AIniFile.ReadString('','DataServerUrl','');
          Self.DataIntfImageUrl:=AIniFile.ReadString('','DataImageUrl','');



      finally
        FreeAndNil(AIniFile);
      end;

      Result:=True;
//  end;

end;

procedure TBaseOpenPlatformFramework.Save(AIniFilePath:String);
var
  AIniFile:TIniFile;
begin
  AIniFile:=TIniFile.Create(
                          AIniFilePath//GetApplicationPath+'program.ini'
                          {$IFNDEF MSWINDOWS},TEncoding.UTF8{$ENDIF});


//    //开放平台的APPID,用于获取程序信息,页面结构,默认是1000
//    OpenPlatformAppID:Integer;
//    //开放平台的服务器,默认是http://www.orangeui.cn:10000
//    OpenPlatformServerUrl:String;
//    //开放平台图片下载的服务器,默认是http://www.orangeui.cn:10001
//    OpenPlatformImageUrl:String;
//  Self.OpenPlatformAppID:=AIniFile.ReadInteger('','OpenPlatformAppID',1000);
//  Self.OpenPlatformServerUrl:=AIniFile.ReadString('','OpenPlatformServerUrl','http://www.orangeui.cn:10000/');
//  Self.OpenPlatformImageUrl:=AIniFile.ReadString('','OpenPlatformImageUrl','http://www.orangeui.cn:10001/');

  AIniFile.WriteString('','OpenPlatformAppID',Self.OpenPlatformAppID);
  AIniFile.WriteString('','OpenPlatformServerUrl',Self.OpenPlatformServerUrl);
  AIniFile.WriteString('','OpenPlatformImageUrl',Self.OpenPlatformImageUrl);



//    //应用的APPID,比如是1010
//    AppID:Integer;
//
//    //程序模板的名称,比如hospitcal
//    ProgramTemplateName:String;
//    //主页的名称,如果为空,那么就显示默认的主页,比如是hospital_office_status
//    MainPageName:String;
//    //平台,比如web,pc,app
//    Platform:String;
  AIniFile.WriteString('','AppID',Self.AppID);
  AIniFile.WriteString('','ProgramTemplateName',Self.ProgramTemplateName);
  AIniFile.WriteString('','MainPageName',Self.MainPageName);
  AIniFile.WriteString('','Platform',Self.Platform);



  AIniFile.WriteString('','DataServerUrl',Self.DataIntfServerUrl);
  AIniFile.WriteString('','DataImageUrl',Self.DataIntfImageUrl);




//  AIniFile.WriteString('','DBType',Self.FDBType);
//
//  AIniFile.WriteString('','DBHostName',Self.FDBHostName);
//  AIniFile.WriteString('','DBHostPort',Self.FDBHostPort);
//  AIniFile.WriteString('','DBUserName',Self.FDBUserName);
//  AIniFile.WriteString('','DBPassword',Self.FDBPassword);
//  AIniFile.WriteString('','DBDataBaseName',Self.FDBDataBaseName);
//  AIniFile.WriteString('','DBCharset',Self.FDBCharset);


  FreeAndNil(AIniFile);

end;


{ TListItemBindings }

function TListItemBindings.Add: TListItemBindingItem;
begin
  Result:=TListItemBindingItem(Inherited Add);
end;

function TListItemBindings.GetItem(Index: Integer): TListItemBindingItem;
begin
  Result:=TListItemBindingItem(Inherited Items[Index]);
end;

procedure TListItemBindings.LoadFromJson(AJson: ISuperObject);
var
  AJsonNameArray:TStringDynArray;
  I: Integer;
  AListItemBindingItem:TListItemBindingItem;
begin
  Clear;

  AJsonNameArray:=GetJsonNameArray(AJson);
  for I := 0 to Length(AJsonNameArray)-1 do
  begin
    //列表项属性与数据字段的绑定
    AListItemBindingItem:=Self.Add;
    AListItemBindingItem.item_field_name:=AJsonNameArray[I];
    AListItemBindingItem.data_field_name:=AJson.S[AJsonNameArray[I]];
  end;


//  Self.FDefaultListItemBindings.Clear;
//  if ASuperObject.Contains('ItemCaption') then
//  begin
//    //列表项属性与数据字段的绑定
//    AListItemBindingItem:=Self.FDefaultListItemBindings.Add;
//    AListItemBindingItem.item_field_name:='ItemCaption';
//    AListItemBindingItem.data_field_name:=ASuperObject.S['ItemCaption'];
//  end;

end;

procedure TListItemBindings.SaveToJson(AJson: ISuperObject);
var
  I: Integer;
begin
  for I := 0 to Count-1 do
  begin
    AJson.S[Items[I].item_field_name]:=Items[I].data_field_name;
  end;
end;



initialization
  GlobalMainProgramSetting:=TBaseOpenPlatformFramework.Create(nil);
  FInnterGlobalMainProgramSetting:=GlobalMainProgramSetting;




finalization
  FreeAndNil(FInnterGlobalMainProgramSetting);



end.
