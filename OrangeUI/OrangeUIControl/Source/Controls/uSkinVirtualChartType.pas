//convert pas to utf8 by ¥

/// <summary>
///   <para>
///     列表框
///   </para>
///   <para>
///     List Box
///   </para>
/// </summary>
unit uSkinVirtualChartType;

interface
{$I FrameWork.inc}
{$I Version.inc}


uses
  Classes,
  SysUtils,
  uFuncCommon,
  Graphics,
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  {$IFDEF SKIN_SUPEROBJECT}
  uSkinSuperObject,
  {$ELSE}
  XSuperObject,
  //XSuperJson,
  {$ENDIF}
  //System.IOUtils,

  //{$IF DELPHIXE8}
  Types,//定义了TRectF
  //{$IFEND}

  uBaseList,
  uBaseLog,
  DateUtils,

  {$IFDEF VCL}
  Messages,
  ExtCtrls,
  Controls,
  {$ENDIF}
  {$IFDEF FMX}
  UITypes,
  FMX.Types,
  FMX.Controls,
  FMX.Dialogs,
  {$ENDIF}


  Math,
  uSkinAnimator,
  uBaseSkinControl,
  uSkinItems,
  uDrawParam,
  uGraphicCommon,
  uSkinBufferBitmap,
  uSkinRegManager,
  uDrawCanvas,
  uFileCommon,
  uComponentType,
  uDrawEngine,
  uBinaryTreeDoc,
  uDrawPicture,
  uSkinMaterial,
  uDrawTextParam,
  uDrawLineParam,
  uDrawRectParam,
  uBasePathData,
  uDrawPathParam,
  uSkinImageList,
  uSkinListLayouts,
  uSkinPanelType,
  uSkinCustomListType,
  uSkinVirtualListType,
  uSkinListBoxType,
  uSkinLabelType,
  uSkinItemDesignerPanelType,

  {$IFDEF FMX}
  uSkinFireMonkeyItemDesignerPanel,
  {$ENDIF}

  {$IFDEF OPENSOURCE_VERSION}
  {$ELSE}
  uSkinListViewType,
  {$ENDIF}

//  uSkinControlGestureManager,
//  uSkinScrollControlType,
  uDrawPictureParam;

const
  IID_ISkinVirtualChart:TGUID='{A9C74863-07FA-4F4E-9582-920D4019D37D}';




type
//  TSkinVirtualChartItems=class;
//  TSkinVirtualChartItemsClass=class of TSkinVirtualChartItems;
  TVirtualChartProperties=class;
  TSkinVirtualChartDefaultMaterial=class;
//  TSkinVirtualChartLayoutsManager=class;

  /// <summary>
  ///   <para>
  ///     列表项
  ///   </para>
  ///   <para>
  ///     ListItem
  ///   </para>
  /// </summary>
//  TSkinVirtualChartItem=TRealSkinItem;
  TVirtualChartSeriesDataItem=class;
  TVirtualChartSeriesDataItemClickEvent=procedure(Sender:TObject;ADataItem:TVirtualChartSeriesDataItem) of object;
  TVirtualChartPrepareDrawDataItemEvent=procedure(Sender:TObject;ADataItem:TVirtualChartSeriesDataItem) of object;
  TVirtualChartPrepareDrawSeriesItemEvent=procedure(Sender:TObject;ADataItem:TVirtualChartSeriesDataItem) of object;
  TVirtualChartGeneratedDrawPathEvent=procedure(Sender:TObject) of object;
  TVirtualChartGetPieInfoCaptionEvent=procedure(Sender:TObject;ADataItem:TVirtualChartSeriesDataItem;var ACaption:String) of object;
  TVirtualChartCustomDrawCategoryAxisEvent=procedure(Sender:TObject;
                                                      ACategoryAxisItem:TBaseSkinItem;
                                                      var AIsNeedDrawAxisLine:Boolean;
                                                      var AIsNeedDrawAxisCaption:Boolean;
                                                      var ADrawAxisLineRect:TRectF;
                                                      var ADrawAxisCaptionRect:TRectF;
                                                      var ADrawAxisCaption:String) of object;



  /// <summary>
  ///   <para>
  ///     列表框接口
  ///   </para>
  ///   <para>
  ///     Interface of VirtualChart
  ///   </para>
  /// </summary>
  ISkinVirtualChart=interface//(ISkinScrollControl)
  ['{A9C74863-07FA-4F4E-9582-920D4019D37D}']


    function GetVirtualChartProperties:TVirtualChartProperties;
    function GetOnClickDataItem:TVirtualChartSeriesDataItemClickEvent;
    function GetOnGeneratedDrawPath:TVirtualChartGeneratedDrawPathEvent;
    function GetOnGetPieInfoCaption:TVirtualChartGetPieInfoCaptionEvent;
    function GetOnPrepareDrawDataItem:TVirtualChartPrepareDrawDataItemEvent;
    function GetOnPrepareDrawSeriesItem:TVirtualListDrawItemEvent;
    function GetOnPrepareDrawLegendItem:TVirtualListDrawItemEvent;
    function GetOnCustomDrawCategoryAxis:TVirtualChartCustomDrawCategoryAxisEvent;

    property Properties:TVirtualChartProperties read GetVirtualChartProperties;
    property Prop:TVirtualChartProperties read GetVirtualChartProperties;

    property OnClickDataItem:TVirtualChartSeriesDataItemClickEvent read GetOnClickDataItem;
    property OnGeneratedDrawPath:TVirtualChartGeneratedDrawPathEvent read GetOnGeneratedDrawPath;
    property OnGetPieInfoCaption:TVirtualChartGetPieInfoCaptionEvent read GetOnGetPieInfoCaption;

    property OnPrepareDrawDataItem:TVirtualChartPrepareDrawDataItemEvent read GetOnPrepareDrawDataItem;
    property OnPrepareDrawSeriesItem:TVirtualListDrawItemEvent read GetOnPrepareDrawSeriesItem;
    property OnPrepareDrawLegendItem:TVirtualListDrawItemEvent read GetOnPrepareDrawLegendItem;
    property OnCustomDrawCategoryAxis:TVirtualChartCustomDrawCategoryAxisEvent read GetOnCustomDrawCategoryAxis;
  end;





//  //坐标上的某一项
//  TVirtualChartAxisDataItem=class(TRealSkinItem)
//
//  end;
//  TVirtualChartAxisDataItems=class(TSkinItems)
//  private
//    function GetItem(Index: Integer): TVirtualChartAxisDataItem;
//    procedure SetItem(Index: Integer; const Value: TVirtualChartAxisDataItem);
//  protected
////    function CreateBinaryObject(const AClassName:String=''):TInterfacedPersistent;override;
////    procedure InitSkinItemClass;override;
//    function GetDefaultSkinItemClass:TBaseSkinItemClass;override;
//  public
//    function Add:TVirtualChartAxisDataItem;overload;
//    function Insert(Index:Integer):TVirtualChartAxisDataItem;
//    property Items[Index:Integer]:TVirtualChartAxisDataItem read GetItem write SetItem;default;
//  end;
  //坐标类型
  TSkinChartAxisType=(
                      //
                      scatCategory,

                      scatValue

                      );
//  TVirtualChartAxis=class(TPersistent)
//  private
//    FItems:TVirtualChartAxisDataItems;
//    FAxisType: TSkinChartAxisType;
//    procedure SetItems(const Value: TVirtualChartAxisDataItems);
//  public
//    constructor Create;
//    destructor Destroy;override;
//    //FDataFieldName:String;
//    property AxisType:TSkinChartAxisType read FAxisType write FAxisType;
//    //这个坐标系是分类还是值
//    //数据列表，数据放Item.Json中即可
//    property Items:TVirtualChartAxisDataItems read FItems write SetItems;
//  end;




  TPointFArray = array of TPointF;



  TVirtualChartSeries=class;
  TVirtualChartSeriesDrawer=class;


  {$IFDEF MSWINDOWS}
  {$ELSE}
  HRGN=Integer;
  {$ENDIF}

  TVirtualChartSeriesDrawData=class
  public
    FValueDrawRect:TRectF;
  end;


  //图表项的数据项
  TVirtualChartSeriesDataItem=class(TRealSkinItem,IValueChangeEffect)
  public
    FOldValue:Double;
    FDisplayValue:Double;
    FValue:Double;
  protected
    /// <summary>
    ///   <para>
    ///     复制
    ///   </para>
    ///   <para>
    ///     Copy
    ///   </para>
    /// </summary>
    procedure AssignTo(Dest: TPersistent); override;

    /// <summary>
    ///   <para>
    ///     从文档节点中加载
    ///   </para>
    ///   <para>
    ///     Load from document node
    ///   </para>
    /// </summary>
    function LoadFromDocNode(ADocNode:TBTNode20_Class):Boolean;override;

    /// <summary>
    ///   <para>
    ///     保存到文档节点
    ///   </para>
    ///   <para>
    ///     Save to document node
    ///   </para>
    /// </summary>
    function SaveToDocNode(ADocNode:TBTNode20_Class):Boolean;override;

  public
    FValuePercent:Double;
    FDrawPercent:Double;
    FDrawPathActions:TPathActionCollection;
//  public
//    //扇形中心点的角度,-90,0,用于判断标题左边齐还是右对齐,-90~90之间是左对齐,其他情况是右对齐
//    FPieArcCenterAngle:Double;
//    //饼图圆弧的中心点
//    FPieArcCenterPoint:TPointF;
//    //中心点同角度的延伸线
//    FPieArcCenterExtendPoint:TPointF;
//    FPieArcCenterExtendHorzPoint:TPointF;
//    //扇形的起点角度,正上方为-90度,用于在FMX下判断鼠标是否在该扇形内
//    FPieStartAngle:Double;
//    FPieSweepAngle:Double;
//    //数据项标题的绘制矩形
//    FCaptionRect:TRectF;
//  public
//    //线状图的点
//    FLinePoint:TPointF;
//    //线状图的点圆,用于画圆,也用于判断鼠标在不在数据项里面
//    FLineDotRect:TRectF;
//  public
//    //柱子的矩形,用于在柱形图的时候判断鼠标是否在数据项里面
//    FBarDrawRect:TRectF;
//  public
//    //不规则点
//    FRegionPoints:array of TPointFArray;
//    FPolygonRegions: array of HRGN;

  public
    //绘制数据
    FDrawData:TVirtualChartSeriesDrawData;

  public
//  IValueChangeEffect=interface
//    ['{7669E95E-E3BA-493A-8FFA-6BF52526EB38}']
    function GetFrom:Double;
    function GetDest:Double;
    procedure SetCurrent(Value:Double);
//    procedure DoAnimate(ASkinAnimator:TSkinAnimator);
//    procedure DoAnimateBegin(ASkinAnimator:TSkinAnimator);
//    procedure DoAnimateEnd(ASkinAnimator:TSkinAnimator);

  public
//    // 删除多边形句柄数组
//    procedure DestroyPolygonRegions(APolygonRegions: array of HRGN);
    //判断鼠标是否在Item里面
    function PtInItem(APoint:TPointF):Boolean;override;
  private
    FIsValueChanged_ForAnimate:Boolean;
    FIsValueChanged_ForUpdate:Boolean;
    procedure SetValue(const AValue: Double);
  public
    procedure LoadFromJson(AJson:ISuperObject);override;
    procedure SaveToJson(AJson:ISuperObject);override;


    constructor Create(ACollection:TCollection);override;
    destructor Destroy;override;
  published
    //数据值
    property Value:Double read FValue write SetValue;
  end;
  TVirtualChartSeriesDataItems=class(TSkinItems)
  private
    function GetItem(Index: Integer): TVirtualChartSeriesDataItem;
    procedure SetItem(Index: Integer; const Value: TVirtualChartSeriesDataItem);
  protected
//    function GetDefaultSkinItemClass:TBaseSkinItemClass;override;
//    function CreateBinaryObject(const AClassName:String=''):TInterfacedPersistent;override;
//    procedure InitSkinItemClass;override;
    function GetDefaultSkinItemClass:TBaseSkinItemClass;override;
  public
    FSeries:TVirtualChartSeries;
    procedure BeginUpdate;override;
    //结束的时候启用动画
    procedure EndUpdate;override;//(AIsForce:Boolean=False);override;
    function Add:TVirtualChartSeriesDataItem;overload;
    function Insert(Index:Integer):TVirtualChartSeriesDataItem;
    property Items[Index:Integer]:TVirtualChartSeriesDataItem read GetItem write SetItem;default;
  end;





  TSkinChartType=(sctBar,

                  sctLine,
                  sctBezierLine,
                  sctPie,

                  //极坐标
                  //sctPolar,

                  //地图模式
                  sctMap
                  );

  TDataItemColorType=(dictDefault,
                      //使用相同的颜色
                      dictUseSameColor,
                      //使用不同的颜色
                      dictUseDiffColor,
                      //使用绘制参数的颜色
                      dictUseDrawParamColor
                      );


  //图表数据
  TVirtualChartSeries=class(TCollectionItem,ISkinItemBindingControl,IBindSkinItemArrayControl)
  private
    FDataItemColorType: TDataItemColorType;
//    FDataJsonArray: ISuperArray;
    FBindValueAxisFieldName: String;
    FEnabled: Boolean;
    procedure DoDataItemPropChange(Sender:TObject);
    procedure SetDataItems(const Value: TVirtualChartSeriesDataItems);
    function CustomPaint(ACanvas:TDrawCanvas;ASkinMaterial:TSkinControlMaterial;const ADrawRect:TRectF;APaintData:TPaintData):Boolean;virtual;
    procedure SetCaption(const Value: String);
    procedure SetChartType(const Value: TSkinChartType);
    procedure SetDrawColor(const Value: TDrawColor);
    procedure SetGradientDrawColor1(const Value: TDrawColor);
    procedure SetVisible(const Value: Boolean);
//    procedure SetDataJsonArray(const Value: ISuperArray);
    procedure SetBindValueAxisFieldName(const Value: String);
    procedure SetEnabled(const Value: Boolean);
  protected
    FBindDataSourceName:String;
    FBindDataSource:TBindDataSource;
    FBindItemFieldName:String;
    function GetBindItemFieldName:String;
    procedure SetBindItemFieldName(AValue:String);
    function GetBindDataSourceName:String;
    procedure SetBindDataSourceName(AValue:String);
    function GetBindDataSource:TBindDataSource;
    procedure SetBindDataSource(AValue:TBindDataSource);
//    procedure SyncBindDataSource;
  protected
    { IInterface }
//    function QueryInterface({$IFDEF FPC}constref{$ELSE}const{$ENDIF} IID: TGUID; out Obj): {$IFDEF LINUX}longint{$ELSE}HResult{$ENDIF}; virtual; {$IFDEF LINUX}cdecl{$ELSE}stdcall{$ENDIF};
//    function _AddRef: {$IFDEF LINUX}longint{$ELSE}Integer{$ENDIF}; virtual; {$IFDEF LINUX}cdecl{$ELSE}stdcall{$ENDIF};
//    function _Release: {$IFDEF LINUX}longint{$ELSE}Integer{$ENDIF}; virtual; {$IFDEF LINUX}cdecl{$ELSE}stdcall{$ENDIF};

    function QueryInterface({$IFDEF FPC}constref{$ELSE}const{$ENDIF} IID: TGUID; out Obj): {$IFDEF LINUX}HResult{$ELSE}HResult{$ENDIF}; virtual; {$IFDEF LINUX}stdcall{$ELSE}stdcall{$ENDIF};
    function _AddRef: {$IFDEF LINUX}HResult{$ELSE}Integer{$ENDIF}; virtual; {$IFDEF LINUX}stdcall{$ELSE}stdcall{$ENDIF};
    function _Release: {$IFDEF LINUX}HResult{$ELSE}Integer{$ENDIF}; virtual; {$IFDEF LINUX}stdcall{$ELSE}stdcall{$ENDIF};
  public
    //IBindSkinItemArrayControl接口
    //给控件赋数组
    procedure SetControlArrayByBindItemField(const AFieldName:String;
                                              const AFieldValue:ISuperArray;
                                              APropertyName:String;
                                              ABindItemFieldSetting:TBindItemFieldSetting;
                                              ASkinItem:TObject;
                                              AIsDrawItemInteractiveState:Boolean);
  public
    //给设计器使用的
    property BindDataSourceName:String read GetBindDataSourceName write SetBindDataSourceName;

  public
    function GetDisplayName:String;override;
  public
    //地图相关
    FMapRange: String; //地图区域范围
    procedure SetMapRange(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  public
//    FIsGeneratedDrawPathList:Boolean;
    FDataItems: TVirtualChartSeriesDataItems;
//    FDrawPathItems: TVirtualChartSeriesDataDrawPathItems;
    FDrawer:TVirtualChartSeriesDrawer;
    FPathDrawRect:TRectF;
    //用来处理鼠标事件的
    FListLayoutsManager:TSkinListLayoutsManager;
    //图表项的名称,比如统计是的金额还是数量
    FCaption: String;

//    //是图标序列的顺序
//    //比如折线图第一个是红色的，第二个折线图线条就需要是绿色的
//    FSameChartTypeIndex:Integer;

    FChartType: TSkinChartType;
    //极坐标的起始角度
    FStartAngle:Double;
    //极坐标的最大角度
    FStopAngle:Double;
    //是否显示
    FVisible:Boolean;

    FDrawColor:TDrawColor;
    FGradientDrawColor1:TDrawColor;

    FMapItems:TVirtualChartSeriesDataItems;
    FMapListLayoutsManager:TSkinListLayoutsManager;

    function GetMouseEventListLayoutsManager:TSkinListLayoutsManager;
  public
    FMinValue:Double;

    FSumValue:Double;
    FMaxValue:Double;


    procedure GetMinMaxValue(var AMinValue:Double;var AMaxValue:Double;var ASumValue:Double);
  public
    function GetDrawer:TVirtualChartSeriesDrawer;
    //生成列表项的绘制path
    procedure GenerateDrawPathList(const ADrawRect:TRectF);

    //是图标序列的顺序
    //比如折线图第一个是红色的，第二个折线图线条就需要是绿色的
    function GetSameChartTypeIndex:Integer;
    function GetSameChartTypeCount:Integer;

    procedure LoadByBindDataSource(ADataJsonArray:ISuperArray);

    procedure LoadFromJson(AJson:ISuperObject);
    procedure SaveToJson(AJson:ISuperObject);

//    property DataJsonArray:ISuperArray read FDataJsonArray write SetDataJsonArray;
  published
    property Enabled:Boolean read FEnabled write SetEnabled;
    property Visible:Boolean read FVisible write SetVisible;
    //图表项的名称,比如统计是的金额还是数量
    property Caption:String read FCaption write SetCaption;
    //图标类型
    property ChartType:TSkinChartType read FChartType write SetChartType;
    // 地图区域范围(中国还是省份)
    property MapRange:String read FMapRange write SetMapRange;
    //FDataFieldName:String;
    //数据列表，数据放Item.Json中即可
    property DataItems:TVirtualChartSeriesDataItems read FDataItems write SetDataItems;
    property DrawColor:TDrawColor read FDrawColor write SetDrawColor;
    //渐变色
    property GradientDrawColor1:TDrawColor read FGradientDrawColor1 write SetGradientDrawColor1;
//    property DrawPathItems:TVirtualChartSeriesDataDrawPathItems read FDrawPathItems;
    //数据项的颜色类型
    property DataItemColorType:TDataItemColorType read FDataItemColorType write FDataItemColorType;
    //数据来源字段
    property BindValueAxisFieldName:String read FBindValueAxisFieldName write SetBindValueAxisFieldName;
    property BindItemFieldName:String read FBindItemFieldName write SetBindItemFieldName;
  published
    property BindDataSource:TBindDataSource read FBindDataSource write SetBindDataSource;
  end;

  //图表数据列表
  TVirtualChartSeriesList=class(TCollection)
  private
    function GetItem(Index: Integer): TVirtualChartSeries;
    procedure SetItem(Index: Integer; const Value: TVirtualChartSeries);
  public
    FSkinVirtualChartIntf:ISkinVirtualChart;


//    FLineSeriesCount:Integer;
//    FPieSeriesCount:Integer;
//    FBarSeriesCount:Integer;

    function GetSameChartTypeCount(AChartType:TSkinChartType):Integer;

//    procedure DoChange;
    procedure Update(Item: TCollectionItem); override;


    procedure LoadFromJsonArray(AJsonArray:ISuperArray);
    procedure SaveToJsonArray(AJsonArray:ISuperArray);

    constructor Create(ItemClass: TCollectionItemClass;ASkinVirtualChartIntf:ISkinVirtualChart);

    function Add:TVirtualChartSeries;

    property Items[Index:Integer]:TVirtualChartSeries read GetItem write SetItem;default;
  end;






  /// <summary>
  ///   <para>
  ///     列表框属性
  ///   </para>
  ///   <para>
  ///     Properties of VirtualChart
  ///   </para>
  /// </summary>
  TVirtualChartProperties=class(TSkinControlProperties)
  protected
    FSkinVirtualChartIntf:ISkinVirtualChart;
  private
    FXAxisType: TSkinChartAxisType;
    FYAxisType: TSkinChartAxisType;
    FSeriesListViewVisible: Boolean;
    FLegendListViewVisible: Boolean;
//    FDataJsonArray: ISuperArray;
//    FBindValueAxisFieldName: String;
    FBindCategoryAxisFieldName: String;
    FIsManualValueAxis: Boolean;
//    procedure SetXAxis(const Value: TVirtualChartAxis);
//    procedure SetYAxis(const Value: TVirtualChartAxis);
//    procedure SetXAxis(const Value: TVirtualChartAxis);
//    procedure SetYAxis(const Value: TVirtualChartAxis);
    procedure SetSeriesList(const Value: TVirtualChartSeriesList);
    function GetAxisItems: TSkinListBoxItems;
    function GetYAxisItems: TSkinListBoxItems;
    procedure SetAxisItems(const Value: TSkinListBoxItems);
    procedure SetXAxisType(const Value: TSkinChartAxisType);
    procedure SetYAxisItems(const Value: TSkinListBoxItems);
    procedure SetYAxisType(const Value: TSkinChartAxisType);
    procedure SetSeriesListViewVisible(const Value: Boolean);
    procedure SetLegendListViewVisible(const Value: Boolean);
    procedure SetBindCategoryAxisFieldName(const Value: String);
//    procedure SetDataJsonArray(const Value: ISuperArray);
//    procedure SetBindValueAxisFieldName(const Value: String);

    //Y轴类型,默认是刻度
    property YAxisType:TSkinChartAxisType read FYAxisType write SetYAxisType;
  protected
    //获取分类名称
    function GetComponentClassify:String;override;

    procedure LoadFromJson(ASuperObject:ISuperObject);override;
    procedure SaveToJson(ASuperObject:ISuperObject);override;
  public
    constructor Create(ASkinControl:TControl);override;
    destructor Destroy;override;
  public
    FSumValue:Double;
    FMinValue:Double;
    FMaxValue:Double;

    //刻度宽度
    FCorStepValue:Double;
    //Y坐标的最小刻度
    FCorMinValue:Double;
    //Y坐标的最大刻度
    FCorMaxValue:Double;
    //有几个刻度
    FCorNumber:Integer;
//    FStep:Double;
    //是否已经生成了绘制参数
    FIsGeneratedDrawPathList:Boolean;

    FSeriesList: TVirtualChartSeriesList;
    //获取最大的值,用来计算柱状图的百分比
    procedure CalcMinMaxValueAndStep;
    //生成列表项的绘制path
    procedure GenerateSeriesDrawPathList(const ADrawRect:TRectF);
    //获取Path的绘制区域
    function GetPathDrawRect(ADrawRect:TRectF):TRectF;
    function GetPieInfoCaption(ADataItem:TVirtualChartSeriesDataItem;ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial):String;
  public
    //只是利用了它们俩做为了Items的容器,绘制的时候并没有用到
    FXAxisSkinListBox:TSkinListBox;
    FYAxisSkinListBox:TSkinListBox;

//    FXAxis: TVirtualChartAxis;
//    FYAxis: TVirtualChartAxis;

    procedure BeginUpdate;override;
    procedure EndUpdate;override;
  public
    {$IFDEF OPENSOURCE_VERSION}
    FLegendListView:TSkinListBox;
    {$ELSE}
    FLegendListView:TSkinListView;
    {$ENDIF}
    //饼图提示ListView的设计面板样式
    //默认的
    FLegendItemStyle:String;
    FLegendItemDesignerPanel:TSkinItemDesignerPanel;
    FLegendItemColorPanel:TSkinPanel;
    FLegendItemCaptionLabel:TSkinLabel;
    procedure CreateLegendItemDesignerPanel;


  public
    //当有多个Series的时候要在某一个位置显示这个ListView
    {$IFDEF OPENSOURCE_VERSION}
    FSeriesListView:TSkinListBox;
    {$ELSE}
    FSeriesListView:TSkinListView;
    {$ENDIF}
    //饼图提示ListView的设计面板样式
    //默认的
    FSeriesItemStyle:String;
    FSeriesItemDesignerPanel:TSkinItemDesignerPanel;
    FSeriesItemColorPanel:TSkinPanel;
    FSeriesItemCaptionLabel:TSkinLabel;
    procedure DoFSeriesListViewClickItem(ASkinItem:TSkinItem);
    //提示Item鼠标停靠状态改变的时候,相应的扇形也鼠标停靠
    procedure DoSeriesListViewMouseOverItemChange(Sender:TObject);
    procedure CreateSeriesItemDesignerPanel;
    procedure UpdateSeriesListView;

  public
    //弹出框是画上去的
    //弹出提示
    FTooltipItemStyle: String;
    FShowTooltip: Boolean;

    //弹出框
    FTooltipForm:TSkinPanel;
    //弹出框标题
    FTooltipCaptionLabel:TSkinLabel;


    {$IFDEF OPENSOURCE_VERSION}
    FTooltipListView:TSkinListBox;
    {$ELSE}
    FTooltipListView:TSkinListView;
    {$ENDIF}
    FLastTooltipDataItem:TVirtualChartSeriesDataItem;
    FTooltipItemDesignerPanel:TSkinItemDesignerPanel;

    //颜色项
    FTooltipItemColorPanel:TSkinPanel;
    //图表标题
    FTooltipSeriesCaptionLabel:TSkinLabel;
    //数据值
    FTooltipItemValueLabel:TSkinLabel;

    FTooltipItemDesignerPanelVisible:Boolean;
    procedure CreateTooltipItemDesignerPanel;
    procedure DoShowTooltip(ATooltipDataItem:TVirtualChartSeriesDataItem;X,Y:Double);

    
  public
    //动画管理
    FValueChangeEffectAnimator:TValueChangeEffectAnimator;
    procedure DoValueChangeEffectAnimatorAnimate(Sender:TObject);
    procedure StartAnimate;
  public
//    //X轴
//    property XAxis:TVirtualChartAxis read FXAxis write SetXAxis;
//    //X轴
//    property YAxis:TVirtualChartAxis read FYAxis write SetYAxis;
//    //提示窗体的样式
//    property TooltipItemStyle:String read FTooltipItemStyle write FTooltipItemStyle;

    //设置Value的值
//    procedure SetValueAxisValues(AValues:array of Double);

    procedure LoadByBindDataSource;

    //Y轴是通过计算自动添加的
    property YAxisItems:TSkinListBoxItems read GetYAxisItems write SetYAxisItems;


//    property DataJsonArray:ISuperArray read FDataJsonArray write SetDataJsonArray;
  published
    //X轴来源字段
    property BindCategoryAxisFieldName:String read FBindCategoryAxisFieldName write SetBindCategoryAxisFieldName;
    //手动设置Y轴的数值
    property IsManualValueAxis:Boolean read FIsManualValueAxis write FIsManualValueAxis;
    //X轴类型,默认是分类,Y轴默认是刻度
    property XAxisType:TSkinChartAxisType read FXAxisType write SetXAxisType;

    //X轴刻度列表
    property AxisItems:TSkinListBoxItems read GetAxisItems write SetAxisItems;

    //图表项列表
    property SeriesList:TVirtualChartSeriesList read FSeriesList write SetSeriesList;

    //是否需要提示
    property ShowTooltip:Boolean read FShowTooltip write FShowTooltip;
//    property LegendItemStyle:String read FLegendItemStyle write FLegendItemStyle;
    //弹出框的样式
//    property TooltipItemStyle:String read FTooltipItemStyle write FTooltipItemStyle;
    property SeriesListViewVisible:Boolean read FSeriesListViewVisible write SetSeriesListViewVisible;
  published
    //饼图介绍的ListView是否显示
    property LegendListViewVisible:Boolean read FLegendListViewVisible write SetLegendListViewVisible;
  end;













//
//  /// <summary>
//  ///   <para>
//  ///     列表项列表
//  ///   </para>
//  ///   <para>
//  ///     ListItem List
//  ///   </para>
//  /// </summary>
//  TSkinVirtualChartItems=class(TSkinItems)
//  private
//    function GetItem(Index: Integer): TSkinVirtualChartItem;
//    procedure SetItem(Index: Integer; const Value: TSkinVirtualChartItem);
//  protected
////    function CreateBinaryObject(const AClassName:String=''):TInterfacedPersistent;override;
////    procedure InitSkinItemClass;override;
//    function GetDefaultSkinItemClass:TBaseSkinItemClass;override;
//  public
//    function Add:TSkinVirtualChartItem;overload;
//    function Insert(Index:Integer):TSkinVirtualChartItem;
//    property Items[Index:Integer]:TSkinVirtualChartItem read GetItem write SetItem;default;
//  end;






//  /// <summary>
//  ///   <para>
//  ///     列表项逻辑
//  ///   </para>
//  ///   <para>
//  ///     ListItem Logic
//  ///   </para>
//  /// </summary>
//  TSkinVirtualChartLayoutsManager=class(TSkinVirtualListLayoutsManager)
//  end;

  //X坐标上刻度的位置
  TXAxisScalePositionType=(
                  xscptMiddle,
                  xscptLeft
                  );

  //多个柱子的时候的排列方式
  TBarsStackType=(bstQueue,//排队
                  bstOverride//覆盖
                  );

  TPieInfoCaptionType=(pictCaption,
                       pictPercent,
                       pictCaptionPercent,
                       pictCaption_CRLF_Percent,
                       pictValue,
                       pictCaptionValue,
                       pictCaption_CRLF_Value
  );
  /// <summary>
  ///   <para>
  ///     列表框素材基类
  ///   </para>
  ///   <para>
  ///     Base class of VirtualChart material
  ///   </para>
  /// </summary>
  {$I ComponentPlatformsAttribute.inc}
  TSkinVirtualChartDefaultMaterial=class(TSkinControlMaterial)
  private
    FDrawCaptionParam:TDrawTextParam;
    FBarColorParam: TDrawRectParam;
    FMapColorParam: TDrawPathParam;
//    FMapHasValueColorParam: TDrawPathParam;
    FDrawAxisLineParam: TDrawLineParam;
    FDrawAxisCaptionParam: TDrawTextParam;
    FBarSizePercent: Double;
    FPieRadiusPercent: Double;
    FPieColorParam: TDrawPathParam;
    FPieInnerSizePercent: Double;
    FLineColorParam: TDrawLineParam;
    FLineDotParam: TDrawPathParam;
    FLineDotRadius: Double;
//    FLegendListViewVisible: Boolean;
    FPieInfoVisible: Boolean;
    FPieInfoCaptionParam: TDrawTextParam;
    FBarsStackType: TBarsStackType;

    FYAxisCaptionWidth: Double;
    FXAxisCaptionHeight: Double;
    FMarginsLeft: Double;
    FMarginsTop: Double;
    FMarginsRight: Double;
    FMarginsBottom: Double;
    FXAxisScalePosition: TXAxisScalePositionType;
    FDrawAxisClientBackColorParam: TDrawRectParam;
    FIsDrawXAxisLine: Boolean;
    FIsDrawColLine: Boolean;
    FIsDrawRowLine: Boolean;
    FIsDrawColFirstLine: Boolean;
    FIsDrawRowFirstLine: Boolean;
    FIsFillLineChartArea: Boolean;
    FPieInfoExtendHorzLineLength: Integer;
    FPieInfoExtendLineLength: Integer;
    FBarOutRectParam: TDrawRectParam;
    FDrawValueParam: TDrawTextParam;
    FIsDrawValue: Boolean;
    FLegendItemCaptionParam: TDrawTextParam;
    FSeriesItemCaptionParam: TDrawTextParam;
    FMapCenterPointColorParam: TDrawRectParam;
    FPieInfoCaptionType: TPieInfoCaptionType;
    procedure SetBarColorParam(const Value: TDrawRectParam);
    procedure SetMapColorParam(const Value: TDrawPathParam);
//    procedure SetMapHasValueColorParam(const Value: TDrawPathParam);
    procedure SetDrawAxisLineParam(const Value: TDrawLineParam);
    procedure SetBarSizePercent(const Value: Double);
    procedure SetDrawAxisCaptionParam(const Value: TDrawTextParam);
    procedure SetPieRadiusPercent(const Value: Double);
    procedure SetPieColorParam(const Value: TDrawPathParam);
    procedure SetPieInnerRadiusPercent(const Value: Double);
    procedure SetLineColorParam(const Value: TDrawLineParam);
    procedure SetLineDotParam(const Value: TDrawPathParam);
    procedure SetPieInfoCaptionParam(const Value: TDrawTextParam);
    procedure SetBarsStackType(const Value: TBarsStackType);
    procedure SetPieInfoVisible(const Value: Boolean);
//    procedure SetLegendListViewVisible(const Value: Boolean);
    procedure SetDrawAxisClientBackColorParam(const Value: TDrawRectParam);
    procedure SetBarOutRectParam(const Value: TDrawRectParam);
    procedure SetDrawValueParam(const Value: TDrawTextParam);
    procedure SetLegendItemCaptionParam(const Value: TDrawTextParam);
    procedure SetSeriesItemCaptionParam(const Value: TDrawTextParam);
    procedure SetMapCenterPointColorParam(const Value: TDrawRectParam);
    procedure SetDrawCaptionParam(const Value: TDrawTextParam);
  public
    //多个柱状图、线状图，和饼图扇形的颜色数组
    FSeriesColorList:TDrawColorList;
    FSeriesGradientColor1List:TDrawColorList;
//    FSeriesColorArray:Array of TDrawColor;
//    FSeriesGradientColor1Array:Array of TDrawColor;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;


  public
    property LineDotParam: TDrawPathParam read FLineDotParam write SetLineDotParam;
    //点圈的半径
    property LineDotRadius:Double read FLineDotRadius write FLineDotRadius;
    //线状图
    property LineColorParam: TDrawLineParam read FLineColorParam write SetLineColorParam;


  public
    //饼图扇形的路径绘制参数
    property PieColorParam: TDrawPathParam read FPieColorParam write SetPieColorParam;


  published
    //地图块的填充色
    property MapColorParam: TDrawPathParam read FMapColorParam write SetMapColorParam;
  public
    property MapCenterPointColorParam: TDrawRectParam read FMapCenterPointColorParam write SetMapCenterPointColorParam;
//    property MapHasValueColorParam: TDrawPathParam read FMapHasValueColorParam write SetMapHasValueColorParam;
  published
    property DrawValueParam:TDrawTextParam read FDrawValueParam write SetDrawValueParam;
    property IsDrawValue:Boolean read FIsDrawValue write FIsDrawValue;
  published
    property DrawCaptionParam:TDrawTextParam read FDrawCaptionParam write SetDrawCaptionParam;

    //坐标相关
    property DrawAxisClientBackColorParam: TDrawRectParam read FDrawAxisClientBackColorParam write SetDrawAxisClientBackColorParam;


    //纵坐标刻度标题的宽度(一般的话,这个需要动态计算会好一点)
    property YAxisCaptionWidth:Double read FYAxisCaptionWidth write FYAxisCaptionWidth;
    //横坐标刻度标题的高度(一般的话,这个需要动态计算会好一点)
    property XAxisCaptionHeight:Double read FXAxisCaptionHeight write FXAxisCaptionHeight;
    //X坐标上刻度点的位置
    property XAxisScalePosition:TXAxisScalePositionType read FXAxisScalePosition write FXAxisScalePosition;

    //坐标刻度标题的文本绘制参数,要不要分X,Y坐标系
    property DrawAxisCaptionParam:TDrawTextParam read FDrawAxisCaptionParam write SetDrawAxisCaptionParam;
    //坐标线的颜色
    property DrawAxisLineParam:TDrawLineParam read FDrawAxisLineParam write SetDrawAxisLineParam;
    //是否需要画X刻度线
    property IsDrawXAxisLine:Boolean read FIsDrawXAxisLine write FIsDrawXAxisLine;
    //是否需要画垂直刻度线
    property IsDrawColLine:Boolean read FIsDrawColLine write FIsDrawColLine;
    property IsDrawRowLine:Boolean read FIsDrawRowLine write FIsDrawRowLine;
    property IsDrawColFirstLine:Boolean read FIsDrawColFirstLine write FIsDrawColFirstLine;
    property IsDrawRowFirstLine:Boolean read FIsDrawRowFirstLine write FIsDrawRowFirstLine;
    //是否需要填充线图的获取
    property IsFillLineChartArea:Boolean read FIsFillLineChartArea write FIsFillLineChartArea;
  published
    //边距,用于确定PathDrawRect
    property MarginsLeft:Double read FMarginsLeft write FMarginsLeft;
    property MarginsTop:Double read FMarginsTop write FMarginsTop;
    property MarginsRight:Double read FMarginsRight write FMarginsRight;
    property MarginsBottom:Double read FMarginsBottom write FMarginsBottom;


  published
    //柱子的路径绘制参数
    //柱子的路径绘制参数，放出来可以设置圆角
    property BarColorParam: TDrawRectParam read FBarColorParam write SetBarColorParam;
    property BarOutRectParam: TDrawRectParam read FBarOutRectParam write SetBarOutRectParam;

    //多个柱子的时候的排列方式
    property BarsStackType: TBarsStackType read FBarsStackType write SetBarsStackType;

    //柱子宽度的百分比
    property BarSizePercent: Double read FBarSizePercent write SetBarSizePercent;

  published
    //饼图半径占控件的百分比
    property PieRadiusPercent: Double read FPieRadiusPercent write SetPieRadiusPercent;
    //饼图内部空心圆的半径百分比
    property PieInnerRadiusPercent: Double read FPieInnerSizePercent write SetPieInnerRadiusPercent;
    //饼图说明是否需要显示
    property PieInfoVisible:Boolean read FPieInfoVisible write SetPieInfoVisible;
    //水平延长线的长度
    property PieInfoExtendHorzLineLength:Integer read FPieInfoExtendHorzLineLength write FPieInfoExtendHorzLineLength;
    property PieInfoExtendLineLength:Integer read FPieInfoExtendLineLength write FPieInfoExtendLineLength;
    //饼图说明的标题
    property PieInfoCaptionParam:TDrawTextParam read FPieInfoCaptionParam write SetPieInfoCaptionParam;
    property PieInfoCaptionType:TPieInfoCaptionType read FPieInfoCaptionType write FPieInfoCaptionType;

    property LegendItemCaptionParam:TDrawTextParam read FLegendItemCaptionParam write SetLegendItemCaptionParam;
    property SeriesItemCaptionParam:TDrawTextParam read FSeriesItemCaptionParam write SetSeriesItemCaptionParam;
  end;




  TVirtualChartSeriesDrawerClass=class of TVirtualChartSeriesDrawer;
  TVirtualChartSeriesDrawDataClass=class of TVirtualChartSeriesDrawData;
  TVirtualChartSeriesDrawerClassReg=class
    DrawerClass:TVirtualChartSeriesDrawerClass;
    DrawDataClass:TVirtualChartSeriesDrawDataClass;
  end;
  TVirtualChartSeriesDrawerClassRegList=class(TBaseList)
  public
    procedure RegisterDrawerClass(AValue:TVirtualChartSeriesDrawerClass;ADrawDataClass:TVirtualChartSeriesDrawDataClass);
    function Find(AChartType:TSkinChartType):TVirtualChartSeriesDrawerClassReg;
  end;



  //图表数据项绘制路径生成基类
  TVirtualChartSeriesDrawer=class
  public
    FSeries:TVirtualChartSeries;
    //整个图的大轮廓
    FSeriesDrawPathActions:TPathActionCollection;
    class function ChartType:TSkinChartType;virtual;abstract;

    //是否需要绘制坐标系
    function IsNeedPaintAxis:Boolean;virtual;
    //判断鼠标是否在Item里面
    function PtInItem(ADataItem:TVirtualChartSeriesDataItem;APoint:TPointF):Boolean;virtual;
    //获取Path的绘制区域
    function GetPathDrawRect(ADrawRect:TRectF):TRectF;virtual;
    //生成绘制的Path列表
    procedure GenerateDrawPathList(APathDrawRect:TRectF);virtual;abstract;
    //获取这个序列的颜色,柱状图，拆线图等同一序列各个数据项的颜色不变的。
    function GetSeriesColor(AMaterial:TSkinVirtualChartDefaultMaterial):TDrawColor;virtual;
    function GetSeriesGradientColor1(AMaterial:TSkinVirtualChartDefaultMaterial):TDrawColor;virtual;
    //获取这个数据项的颜色
    function GetDataItemColor(ADataItem:TVirtualChartSeriesDataItem;AMaterial:TSkinVirtualChartDefaultMaterial):TDrawColor;virtual;
    function GetDataItemGradientColor1(ADataItem:TVirtualChartSeriesDataItem;AMaterial:TSkinVirtualChartDefaultMaterial):TDrawColor;virtual;
    //绘制
    function CustomPaint(ACanvas:TDrawCanvas;
                          ASkinMaterial:TSkinControlMaterial;
                          const ADrawRect:TRectF;
                          APaintData:TPaintData;
                          const APathDrawRect:TRectF):Boolean;virtual;
  public
    constructor Create(AVirtualChartSeries:TVirtualChartSeries);virtual;
    destructor Destroy;override;
  end;





  TVirtualChartSeriesBarDrawData=class(TVirtualChartSeriesDrawData)
  public
    //柱子的矩形,用于在柱形图的时候判断鼠标是否在数据项里面
    FBarDrawRect:TRectF;
    FBarOutDrawRect:TRectF;
  end;
  //柱状图生成路径
  TVirtualChartSeriesBarDrawer=class(TVirtualChartSeriesDrawer)
  public
    class function ChartType:TSkinChartType;override;
//    //获取这个数据项的颜色
//    function GetDataItemColor(ADataItem:TVirtualChartSeriesDataItem;AMaterial:TSkinVirtualChartDefaultMaterial):TDrawColor;override;
//    function GetDataItemGradientColor1(ADataItem:TVirtualChartSeriesDataItem;AMaterial:TSkinVirtualChartDefaultMaterial):TDrawColor;override;
    procedure GenerateDrawPathList(APathDrawRect:TRectF);override;
    //绘制Y轴分隔线，X轴刻度值
    function CustomPaint(ACanvas:TDrawCanvas;
                          ASkinMaterial:TSkinControlMaterial;
                          const ADrawRect:TRectF;
                          APaintData:TPaintData;
                          const APathDrawRect:TRectF):Boolean;override;
  end;






  TVirtualChartSeriesLineDrawData=class(TVirtualChartSeriesDrawData)
  public
    //线状图的点
    FLinePoint:TPointF;
    //线状图的点圆,用于画圆,也用于判断鼠标在不在数据项里面
    FLineDotRect:TRectF;
    FBarRect:TRectF;
  end;
  //线状图生成路径
  TVirtualChartSeriesLineDrawer=class(TVirtualChartSeriesDrawer)
  public

    class function ChartType:TSkinChartType;override;
    //判断鼠标是否在Item里面
    function PtInItem(ADataItem:TVirtualChartSeriesDataItem;APoint:TPointF):Boolean;override;

    procedure GenerateLineDotList(APathDrawRect:TRectF);
    procedure GenerateAreaPathList(APathDrawRect:TRectF);virtual;
    procedure GenerateDrawPathList(APathDrawRect:TRectF);override;
//    function GetDataItemColor(ADataItem:TVirtualChartSeriesDataItem):TDelphiColor;override;
    //绘制Y轴分隔线，X轴刻度值
    function CustomPaint(ACanvas:TDrawCanvas;ASkinMaterial:TSkinControlMaterial;const ADrawRect:TRectF;APaintData:TPaintData;const APathDrawRect:TRectF):Boolean;override;
  end;




  TVirtualChartSeriesPieDrawData=class(TVirtualChartSeriesDrawData)
  public
    //扇形中心点的角度,-90,0,用于判断标题左边齐还是右对齐,-90~90之间是左对齐,其他情况是右对齐
    FPieArcCenterAngle:Double;
    //饼图圆弧的中心点
    FPieArcCenterPoint:TPointF;
    //中心点同角度的延伸线
    FPieArcCenterExtendPoint:TPointF;
    FPieArcCenterExtendHorzPoint:TPointF;
    //数据项标题的绘制矩形
    FCaptionRect:TRectF;
    //扇形的起点角度,正上方为-90度,用于在FMX下判断鼠标是否在该扇形内
    FPieStartAngle:Double;
    FPieSweepAngle:Double;
  end;

  //饼状图生成路径
  TVirtualChartSeriesPieDrawer=class(TVirtualChartSeriesDrawer)
  public
    //大半径
    FRadius:Double;
    //小半径,中空那个圆的半径
    FInnerRadius:Double;
    //圆心
    FCircleCenterPoint:TPointF;

    class function ChartType:TSkinChartType;override;
    function IsNeedPaintAxis:Boolean;override;
    //判断鼠标是否在Item里面
    function PtInItem(ADataItem:TVirtualChartSeriesDataItem;APoint:TPointF):Boolean;override;
    //提示Item鼠标停靠状态改变的时候,相应的扇形也鼠标停靠
    procedure DoLegendListViewMouseOverItemChange(Sender:TObject);
//    //指定提示ListView的颜色
//    procedure DoLegendListViewPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
//      AItemDesignerPanel: {$IFDEF FMX}TSkinFMXItemDesignerPanel{$ELSE}TSkinItemDesignerPanel{$ENDIF}; AItem: TSkinItem;
//      AItemDrawRect: TRect);

    //获取Path的绘制区域
    function GetPathDrawRect(ADrawRect:TRectF):TRectF;override;
    procedure GenerateDrawPathList(APathDrawRect:TRectF);override;
    function GetDataItemColor(ADataItem:TVirtualChartSeriesDataItem;AMaterial:TSkinVirtualChartDefaultMaterial):TDrawColor;override;
    //绘制Y轴分隔线，X轴刻度值
    function CustomPaint(ACanvas:TDrawCanvas;ASkinMaterial:TSkinControlMaterial;const ADrawRect:TRectF;APaintData:TPaintData;const APathDrawRect:TRectF):Boolean;override;
  end;





//  //极坐标图生成路径
//  TVirtualChartSeriesPolarDrawer=class(TVirtualChartSeriesDrawer)
//  public
//    //大半径
//    FRadius:Double;
//    //小半径,中空那个圆的半径
//    FInnerRadius:Double;
//    //圆心
//    FCircleCenterPoint:TPointF;
//
////    procedure DoLegendListViewPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
////      AItemDesignerPanel: {$IFDEF FMX}TSkinFMXItemDesignerPanel{$ENDIF}{$IFDEF VCL}TSkinItemDesignerPanel{$ENDIF}; AItem: TSkinItem;
////      AItemDrawRect: TRect);
//
////    //获取Path的绘制区域
////    function GetPathDrawRect(ADrawRect:TRectF):TRectF;override;
//    procedure GenerateDrawPathList(APathDrawRect:TRectF);override;
////    function GetDataItemColor(ADataItem:TVirtualChartSeriesDataItem):TDelphiColor;override;
////    //绘制Y轴分隔线，X轴刻度值
////    function CustomPaint(ACanvas:TDrawCanvas;ASkinMaterial:TSkinControlMaterial;const ADrawRect:TRectF;APaintData:TPaintData;const APathDrawRect:TRectF):Boolean;override;
//  end;








  TSkinVirtualChartDefaultType=class(TSkinControlType)
  protected
    FSkinVirtualChartIntf:ISkinVirtualChart;
  protected
    //绑定对象
    function CustomBind(ASkinControl:TControl):Boolean;override;
    //解除绑定
    procedure CustomUnBind;override;



    //鼠标事件//
    procedure CustomMouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Double);override;
    procedure CustomMouseUp(Button: TMouseButton; Shift: TShiftState;X, Y: Double);override;
    procedure CustomMouseMove(Shift: TShiftState; X, Y: Double);override;
    procedure CustomMouseEnter;override;
    procedure CustomMouseLeave;override;

    //绘制XY坐标轴,主要是刻度线
    procedure PaintAxis(ACanvas:TDrawCanvas;ASkinMaterial:TSkinControlMaterial;
                        const ADrawRect:TRectF;
                        APaintData:TPaintData;
                        const APathDrawRect:TRectF);

    function CustomPaint(ACanvas:TDrawCanvas;ASkinMaterial:TSkinControlMaterial;const ADrawRect:TRectF;APaintData:TPaintData):Boolean;override;
    //尺寸更改
    procedure SizeChanged;override;
  protected
    function GetSkinMaterial:TSkinVirtualChartDefaultMaterial;
  end;




  {$I ComponentPlatformsAttribute.inc}
  TSkinVirtualChart=class(TBaseSkinControl,ISkinVirtualChart,IBindSkinItemArrayControl)
  private


    FOnClickDataItem: TVirtualChartSeriesDataItemClickEvent;
    FOnGeneratedDrawPath: TVirtualChartGeneratedDrawPathEvent;
    FOnPrepareDrawDataItem: TVirtualChartPrepareDrawDataItemEvent;
    FOnCustomDrawCategoryAxis: TVirtualChartCustomDrawCategoryAxisEvent;
    FOnGetPieInfoCaption:TVirtualChartGetPieInfoCaptionEvent;

    function GetOnClickDataItem: TVirtualChartSeriesDataItemClickEvent;

    function GetVirtualChartProperties:TVirtualChartProperties;
    procedure SetVirtualChartProperties(Value:TVirtualChartProperties);
    function GetOnGeneratedDrawPath: TVirtualChartGeneratedDrawPathEvent;
    function GetOnGetPieInfoCaption:TVirtualChartGetPieInfoCaptionEvent;

    function GetOnPrepareDrawDataItem: TVirtualChartPrepareDrawDataItemEvent;
    function GetOnPrepareDrawLegendItem: TVirtualListDrawItemEvent;
    function GetOnPrepareDrawSeriesItem: TVirtualListDrawItemEvent;
    procedure SetOnPrepareDrawLegendItem(
      const Value: TVirtualListDrawItemEvent);
    procedure SetOnPrepareDrawSeriesItem(
      const Value: TVirtualListDrawItemEvent);
    function GetBindCategoryAxisFieldName: String;
    procedure SetBindCategoryAxisFieldName(const Value: String);
    function GetOnCustomDrawCategoryAxis: TVirtualChartCustomDrawCategoryAxisEvent;
  protected
    //获取控件属性类
    function GetPropertiesClassType:TPropertiesClassType;override;
    //皮肤素材更改通知事件
    procedure DoCustomSkinMaterialChange(Sender: TObject);override;
  public
    //IBindSkinItemArrayControl接口
    //给控件赋数组
    procedure SetControlArrayByBindItemField(const AFieldName:String;
                                              const AFieldValue:ISuperArray;
                                              APropertyName:String;
                                              ABindItemFieldSetting:TBindItemFieldSetting;
                                              ASkinItem:TObject;
                                              AIsDrawItemInteractiveState:Boolean);
  public
    procedure Loaded;override;
//    constructor Create(AOwner:TComponent);override;
//    destructor Destroy;override;

    function SelfOwnMaterialToDefault:TSkinVirtualChartDefaultMaterial;
    function CurrentUseMaterialToDefault:TSkinVirtualChartDefaultMaterial;
    function Material:TSkinVirtualChartDefaultMaterial;

    property Prop:TVirtualChartProperties read GetVirtualChartProperties write SetVirtualChartProperties;
  published

    property Caption;
    //X轴来源字段
    property BindCategoryAxisFieldName:String read GetBindCategoryAxisFieldName write SetBindCategoryAxisFieldName;

    //属性(必须在VertScrollBar和HorzScrollBar之前)
    property Properties:TVirtualChartProperties read GetVirtualChartProperties write SetVirtualChartProperties;

    property OnClickDataItem:TVirtualChartSeriesDataItemClickEvent read FOnClickDataItem write FOnClickDataItem;
    //生成了
    property OnGeneratedDrawPath:TVirtualChartGeneratedDrawPathEvent read GetOnGeneratedDrawPath write FOnGeneratedDrawPath;
    property OnGetPieInfoCaption:TVirtualChartGetPieInfoCaptionEvent read GetOnGetPieInfoCaption write FOnGetPieInfoCaption;
    property OnPrepareDrawDataItem:TVirtualChartPrepareDrawDataItemEvent read GetOnPrepareDrawDataItem write FOnPrepareDrawDataItem;
    property OnPrepareDrawSeriesItem:TVirtualListDrawItemEvent read GetOnPrepareDrawSeriesItem write SetOnPrepareDrawSeriesItem;
    property OnPrepareDrawLegendItem:TVirtualListDrawItemEvent read GetOnPrepareDrawLegendItem write SetOnPrepareDrawLegendItem;
    property OnCustomDrawCategoryAxis:TVirtualChartCustomDrawCategoryAxisEvent read GetOnCustomDrawCategoryAxis write FOnCustomDrawCategoryAxis;
  end;





  {$IFDEF VCL}
  TSkinWinVirtualChart=class(TSkinVirtualChart)
  end;
  {$ENDIF}
  {$IFDEF FMX}
  TSkinFMXVirtualChart=class(TSkinVirtualChart)
  end;
  {$ENDIF}









var
  GlobalChartDrawerClassRegList:TVirtualChartSeriesDrawerClassRegList;

procedure RegisterDrawerClass(AValue:TVirtualChartSeriesDrawerClass;ADrawDataClass:TVirtualChartSeriesDrawDataClass);

//判断点是否在扇形内
function PtInPie(ACircleCenterPoint:TPointF;
                APoint:TPointF;
                ADataItem:TVirtualChartSeriesDataItem;
                ARadius:Double;
                AStartAngle:Double;
                ASweepAngle:Double):Boolean;
//获取某一点与圆心的角度
//返回的是0~360,正上方为0
function GetAngle(ACircleCenterPoint:TPointF;APoint:TPointF):Double;


function GetChartTypeStr(AChartType:TSkinChartType):String;
function GetChartTypeByStr(AChartTypeStr:String):TSkinChartType;

function GetChartAxisTypeStr(AChartAxisType:TSkinChartAxisType):String;
function GetChartAxisTypeByStr(AChartAxisTypeStr:String):TSkinChartAxisType;
//  //坐标类型
//  =(
//                      //
//                      scatCategory,
//
//                      scatValue
//
//                      );

function CalcCorNumber( cormax:double;  var cormin:double; var cornumber:Integer;var keduwidth:Double//;var realmaxmoney: Double;var realminmoney: Double
):Boolean;


implementation


{$IFDEF OPENSOURCE_VERSION}
{$ELSE}
uses
  uSkinVirtualChartBezierLineDrawer,uSkinVirtualChartMapDrawer;
{$ENDIF}


function GetChartAxisTypeStr(AChartAxisType:TSkinChartAxisType):String;
begin
  Result:='';
  case AChartAxisType of
    scatCategory:
    begin
      Result:='Category';
    end;
    scatValue:
    begin
      Result:='Value';
    end;
  end;
end;

function GetChartAxisTypeByStr(AChartAxisTypeStr:String):TSkinChartAxisType;
begin
  Result:=scatCategory;
  if SameText(AChartAxisTypeStr,'Category') then
  begin
    Result:=scatCategory;
  end;
  if SameText(AChartAxisTypeStr,'Value') then
  begin
    Result:=scatValue;
  end;
end;


function GetChartTypeStr(AChartType:TSkinChartType):String;
begin
  Result:='';
  case AChartType of
    sctBar:
    begin
      Result:='Bar';
    end;
    sctLine:
    begin
      Result:='Line';
    end;
    sctBezierLine:
    begin
      Result:='BezierLine';
    end;
    sctPie:
    begin
      Result:='Pie';
    end;
    sctMap:
    begin
      Result:='Map';
    end;
  end;
end;

function GetChartTypeByStr(AChartTypeStr:String):TSkinChartType;
begin
  Result:=sctBar;
  if SameText(AChartTypeStr,'Bar') then
  begin
    Result:=sctBar;
  end
  else if SameText(AChartTypeStr,'Line') then
  begin
    Result:=sctLine;
  end
  else if SameText(AChartTypeStr,'BezierLine') then
  begin
    Result:=sctBezierLine;
  end
  else if SameText(AChartTypeStr,'Pie') then
  begin
    Result:=sctPie;
  end
  else if SameText(AChartTypeStr,'Map') then
  begin
    Result:=sctMap;
  end
  ;
end;

procedure RegisterDrawerClass(AValue:TVirtualChartSeriesDrawerClass;ADrawDataClass:TVirtualChartSeriesDrawDataClass);
begin
  if GlobalChartDrawerClassRegList=nil then
  begin
    GlobalChartDrawerClassRegList:=TVirtualChartSeriesDrawerClassRegList.Create();
  end;
  GlobalChartDrawerClassRegList.RegisterDrawerClass(AValue,ADrawDataClass);
end;

function log(n:Real):Real;
begin
    Result := Ln(n)/ln(10.0);
end;

function CalcCorNumber( cormax:double;  var cormin:double; var cornumber:Integer;var keduwidth:Double//;var realmaxmoney: Double;var realminmoney: Double
):Boolean;
var
         //realmaxmoney,
//         realminmoney,
         corstep, tmpstep, temp:double;
         tmp_cor_number:Integer;
         nummoney:Double;
         text:String;
         I:Integer;
begin
  Result:=False;

//        Log.d("yangbin---", "cormax:--" + cormax + "--cormin:--" + cormin + "--cornumber:--" + cornumber);
//        realmaxmoney = Double.valueOf(cormax);
//        realminmoney = Double.valueOf(cormin);




//        realmaxmoney := cormax;
//        realminmoney := cormin;



        if (cormax <= cormin) then
            Exit;

        corstep := (cormax - cormin) / cornumber;

//        if (Math.pow(10, (int) (Math.log(corstep) / Math.log(10))) = corstep) {
//            temp = Math.pow(10, (int) (Math.log(corstep) / Math.log(10)));
//        } else {
//            temp = Math.pow(10, ((int) (Math.log(corstep) / Math.log(10)) + 1));
//        }
        //(int) (Math.log(corstep) / Math.log(10))
        if (Math.Power(10, Floor(log(corstep) / log(10))) = corstep) then
        begin
            temp := Math.Power(10, Floor(log(corstep) / log(10)));
        end
        else
        begin
            temp := Math.Power(10, (Floor(log(corstep) / log(10)) + 1));
        end;




        tmpstep := corstep / temp;
        //选取规范步长
//        if (tmpstep >= 0 && tmpstep <= 0.1) {
//            tmpstep = 0.1;
//        } else if (tmpstep >= 0.100001 && tmpstep <= 0.2) {
//            tmpstep = 0.2;
//        } else if (tmpstep >= 0.200001 && tmpstep <= 0.25) {
//            tmpstep = 0.25;
//        } else if (tmpstep >= 0.250001 && tmpstep <= 0.5) {
//            tmpstep = 0.5;
//        } else {
//            tmpstep = 1;
//        }

        if (tmpstep >= 0) and (tmpstep <= 0.1) then
        begin
            tmpstep := 0.1;
        end
        else if (tmpstep >= 0.100001) and (tmpstep <= 0.2) then
        begin
            tmpstep := 0.2;
        end
        else if (tmpstep >= 0.200001) and (tmpstep <= 0.25) then
        begin
            tmpstep := 0.25;
        end
        else if (tmpstep >= 0.250001) and (tmpstep <= 0.5) then
        begin
            tmpstep := 0.5;
        end
        else
        begin
            tmpstep := 1;
        end;



        tmpstep := tmpstep * temp;
//        if ((int) (cormin / tmpstep) != (cormin / tmpstep)) {
//            if (cormin < 0) {
//                cormin = (-1) * Math.ceil(Math.abs(cormin / tmpstep)) * tmpstep;
//            } else {
//                cormin = (int) (Math.abs(cormin / tmpstep)) * tmpstep;
//            }
//
//        }
        if (Floor(cormin / tmpstep) <> (cormin / tmpstep)) then
        begin
            if (cormin < 0) then
            begin
                cormin := (-1) * Ceil(abs(cormin / tmpstep)) * tmpstep;
            end
            else
            begin
                cormin := Floor(abs(cormin / tmpstep)) * tmpstep;
            end;

        end;




//        if ((int) (cormax / tmpstep) != (cormax / tmpstep)) {
//            cormax = (int) (cormax / tmpstep + 1) * tmpstep;
//        }
        if (Floor(cormax / tmpstep) <> (cormax / tmpstep)) then
        begin
            cormax := Floor(cormax / tmpstep + 1) * tmpstep;
        end;

        //多出来的刻度,比如我要6个刻度，但是算出来只需要4个，那么多出来的会往底下减，原本从0开始的最小刻度，会变为负数
        tmp_cor_number := Ceil((cormax - cormin) / tmpstep);
//        if (tmp_cor_number < cornumber) {
//            extra_cor_number = cornumber - tmp_cor_number;
//            tmp_cor_number = cornumber;
//            if (extra_cor_number % 2 = 0) {
//                cormax = cormax + tmpstep * (int) (extra_cor_number / 2);
//            } else {
//                cormax = cormax + tmpstep * (int) (extra_cor_number / 2 + 1);
//            }
//            cormin = cormin - tmpstep * (int) (extra_cor_number / 2);
//        }
//        if (tmp_cor_number < cornumber) then
//        begin
//            extra_cor_number := cornumber - tmp_cor_number;
//            tmp_cor_number := cornumber;
//            if ((Floor(extra_cor_number) mod 2) = 0) then
//            begin
//                cormax := cormax + tmpstep * Floor(extra_cor_number / 2);
//            end
//            else
//            begin
//                cormax := cormax + tmpstep * Floor(extra_cor_number / 2 + 1);
//            end;
//            cormin := cormin - tmpstep * Floor(extra_cor_number / 2);
//        end;



        cornumber := tmp_cor_number;


        //打印日志
//        double nummoney = 0;
//        String text = "";
//        double keduwidth = (cormax - cormin) / cornumber;

//        nummoney := 0;
//        text := '';
        keduwidth := (cormax - cormin) / cornumber;

//        for (int i = 1; nummoney < realmaxmoney; i++) {
//            nummoney = keduwidth * i + cormin;
//            text = text + String.valueOf(nummoney) + "---";
//        }



//        i := 1;
//        while nummoney < cormax do//realmaxmoney do
//        begin
//          nummoney := keduwidth * i + cormin;
//          text:=text+FloatToStr(nummoney)+'---';
//          I:=I+1;
//        end;
//
//
//        uBaseLog.HandleException(nil,text);

//        Log.d("yangbin", "cormax---" + cormax + "--cormin--" + cormin + "--cornumber--" + cornumber +
//                        "\n您的坐标依次为:" + text
//        );


  Result:=True;
end;



{ TVirtualChartProperties }


procedure TVirtualChartProperties.CalcMinMaxValueAndStep;
var
  I,J: Integer;
  ASeriesMinValue,ASeriesMaxValue,ASeriesSumValue:Double;
//  keduwidth:Double;
//  keduwidth:Double;
//  realmaxmoney:Double;
//  realminmoney:Double;
  nummoney:Double;
  ADataItem:TVirtualChartSeriesDataItem;
  AIsFirst:Boolean;
//  AValues:array of Double;
begin
  //最小值默认是0
  FMinValue:=0;

  //总和
  FSumValue:=0;

  FMaxValue:=0;
//  FStep:=1;
  if Self.FSeriesList.Count>0 then
  begin
//    Self.FSeriesList[0].GetMinMaxValue(FMinValue,FMaxValue,FSumValue);

    AIsFirst:=True;
    for I := 0 to FSeriesList.Count-1 do
    begin
      if not Self.FSeriesList[I].Visible then continue;
      if not Self.FSeriesList[I].Enabled then continue;

      if AIsFirst then
      begin
        Self.FSeriesList[I].GetMinMaxValue(FMinValue,FMaxValue,FSumValue);
        AIsFirst:=False;
        Continue;
      end
      else
      begin
        Self.FSeriesList[I].GetMinMaxValue(ASeriesMinValue,ASeriesMaxValue,ASeriesSumValue);
      end;

      if ASeriesMinValue<FMinValue then
      begin
        FMinValue:=ASeriesMinValue;
      end;
      if ASeriesMaxValue>FMaxValue then
      begin
        FMaxValue:=ASeriesMaxValue;
      end;

      FSumValue:=FSumValue+ASeriesSumValue;

    end;

  end;


  if not Self.FIsManualValueAxis then
  begin

      FCorMinValue:=FMinValue;
      FCorMaxValue:=FMaxValue;
    //  cornumber:=6;
      CalcCorNumber(FCorMaxValue,FCorMinValue,FCorNumber,FCorStepValue);//,realmaxmoney,realminmoney);
      //keduwidth是计算出来的刻度宽度
    //  FCorStepValue:=keduwidth;



      //清除Y坐标系
      Self.YAxisItems.BeginUpdate;
      try
        Self.YAxisItems.Clear();

        nummoney := 0;
        i := 0;//1;
        while nummoney < FCorMaxValue do//realmaxmoney do
        begin
          nummoney := FCorStepValue * i + FCorMinValue;
    //      text:=text+FloatToStr(nummoney)+'---';
//          Self.YAxisItems.Insert(0).Caption:=FloatToStr(nummoney);
          //设置坐标轴的标题  用来查看的吧
          Self.YAxisItems.Add.Caption:=FloatToStr(nummoney);
//          Self.YAxisItems.Add.Caption:=FloatToStr(nummoney);
          I:=I+1;
        end;

    //    FMinValue:=keduwidth * 1 + ACorMinValue;
        FMinValue:=FCorMinValue;
        FMaxValue:=nummoney;
        FCorMaxValue:=nummoney;



      finally
        Self.YAxisItems.EndUpdate;
      end;

  end;



  //再计算百分比

  //需要最大值,计算出百分比
  for I := 0 to Self.FSeriesList.Count-1 do
  begin
    for J := 0 to FSeriesList[I].FDataItems.Count-1 do
    begin
        ADataItem:=FSeriesList[I].FDataItems[J];

        //占总的坐标最大值的百分比
        ADataItem.FDrawPercent:=0;
        if (FMaxValue-FMinValue)>0 then
        begin
          ADataItem.FDrawPercent:=
                (ADataItem.FDisplayValue-FMinValue)/(FMaxValue-FMinValue);
        end;


        //占自己Series的总和的百分比
        ADataItem.FValuePercent:=0;
        if FSeriesList[I].FSumValue>0 then
        begin
          ADataItem.FValuePercent:=
                ADataItem.FDisplayValue/FSeriesList[I].FSumValue;
        end;

    end;
  end;



end;

procedure TVirtualChartProperties.GenerateSeriesDrawPathList(const ADrawRect: TRectF);
var
  I: Integer;
  ASeries:TVirtualChartSeries;
  ALegendListView:TSkinListView;
//  ASameChartTypeIndex:Integer;
begin

  Self.CalcMinMaxValueAndStep;

//  FLineSeriesCount:=0;
//  FPieSeriesCount:=0;
//  FBarSeriesCount:=0;

//  ASameChartTypeIndex:=0;
//  for I := 0 to Self.Count-1 do
//  begin
//    if (Items[I].FChartType=sctBar)
//      or (Items[I].FChartType=sctMap) then
//    begin
//      Items[I].FSameChartTypeIndex:=ASameChartTypeIndex;
//      Inc(ASameChartTypeIndex);
//    end;
//  end;
//  FBarSeriesCount:=ASameChartTypeIndex;
//
//
//  ASameChartTypeIndex:=0;
//  for I := 0 to Self.Count-1 do
//  begin
//    if Items[I].FChartType=sctPie then
//    begin
//      Items[I].FSameChartTypeIndex:=ASameChartTypeIndex;
//      Inc(ASameChartTypeIndex);
//    end;
//  end;
//  FPieSeriesCount:=ASameChartTypeIndex;
//
//
//  ASameChartTypeIndex:=0;
//  for I := 0 to Self.Count-1 do
//  begin
//    if Items[I].FChartType=sctLine then
//    begin
//      Items[I].FSameChartTypeIndex:=ASameChartTypeIndex;
//      Inc(ASameChartTypeIndex);
//    end;
//  end;
//  FLineSeriesCount:=ASameChartTypeIndex;

  //先设置为隐藏，后面PieDrawer会根据条件来显示的
  ALegendListView:=FSkinVirtualChartIntf.Properties.FLegendListView;

  if ALegendListView<>nil then
  begin
    ALegendListView.Visible:=False;
//    ALegendListView.OnMouseOverItemChange:=nil;
//    ALegendListView.OnPrepareDrawItem:=nil;
  end;

  for I := 0 to Self.FSeriesList.Count-1 do
  begin
    FSeriesList[I].GenerateDrawPathList(ADrawRect);
  end;

  if Assigned(FSkinVirtualChartIntf.OnGeneratedDrawPath) then
  begin
    FSkinVirtualChartIntf.OnGeneratedDrawPath(FSkinVirtualChartIntf.Properties.FSkinControl);
  end;

  //绘制坐标轴,只需要画一次就可以了
  for I := 0 to FSkinVirtualChartIntf.Properties.FSeriesList.Count-1 do
  begin
    ASeries:=FSkinVirtualChartIntf.Properties.FSeriesList[I];
//    if (ASeries.FChartType=sctBar)
//      or (ASeries.FChartType=sctLine)
////      or (ASeries.FChartType=sctMap)
//
//      then
//    begin
    if ASeries.Visible and (ASeries.FDrawer<>nil) then
    begin
        if ASeries.FDrawer.IsNeedPaintAxis then
        begin
          Self.FYAxisSkinListBox.Prop.Items.BeginUpdate;
          try
            Self.FYAxisSkinListBox.SetBounds(Ceil(ASeries.FPathDrawRect.Left),Ceil(ASeries.FPathDrawRect.Top),Ceil(ASeries.FPathDrawRect.Width),Ceil(ASeries.FPathDrawRect.Height));
            Self.FYAxisSkinListBox.Prop.ItemHeight:=ASeries.FPathDrawRect.Height/(Self.FCorNumber);
            Self.FYAxisSkinListBox.Prop.ItemWidth:=ASeries.FPathDrawRect.Width;
          finally
            Self.FYAxisSkinListBox.Prop.Items.EndUpdate;
          end;
        end;
    end;
  end;

end;

procedure TVirtualChartProperties.BeginUpdate;
begin
  inherited;
  Self.FXAxisSkinListBox.Prop.Items.BeginUpdate;
  Self.FYAxisSkinListBox.Prop.Items.BeginUpdate;
  Self.SeriesList.BeginUpdate;
end;

constructor TVirtualChartProperties.Create(ASkinControl:TControl);
begin
  inherited Create(ASkinControl);
  if Not ASkinControl.GetInterface(IID_ISkinVirtualChart,Self.FSkinVirtualChartIntf) then
  begin
    ShowException('This Component Do not Support ISkinVirtualChart Interface');
  end
  else
  begin
//    FXAxis:=TVirtualChartAxis.Create;
//    FXAxis.FAxisType:=scatCategory;
//
//    FYAxis:=TVirtualChartAxis.Create;
//    FYAxis.FAxisType:=scatValue;

    FXAxisType:=scatCategory;

    FYAxisType:=scatValue;

    FSeriesList:=TVirtualChartSeriesList.Create(TVirtualChartSeries,Self.FSkinVirtualChartIntf);


    {$IFDEF OPENSOURCE_VERSION}
      //图表提示的ListView
      FLegendListView:=TSkinListBox.Create(nil);
    {$ELSE}
      //图表提示的ListView
      FLegendListView:=TSkinListView.Create(nil);
    {$ENDIF}
      FLegendListView.Parent:=TParentControl(Self.FSkinControl);
      FLegendListView.Visible:=False;
      {$IFDEF FMX}
      FLegendListView.Stored:=False;
      FLegendListView.Locked:=True;
      {$ENDIF}
      {$IFDEF VCL}
      FLegendListView.Material.FIsTransparent:=True;
      FLegendListView.Material.BackColor.FIsFill:=False;
      {$ENDIF}
      FLegendListView.Left:=10;
      FLegendListView.Top:=10;
      FLegendListView.Prop.ItemHeight:=26;
//      FLegendListView.Prop.ListLayoutsManager.SkinListIntf:=nil;
//      FreeAndNil(FLegendListView.Properties.FItems);
//      FLegendListView.OnPrepareDrawItem:=DoLegendListViewPrepareDrawItem;
//      FLegendListView.OnMouseOverItemChange:=DoLegendListViewMouseOverItemChange;
      CreateLegendItemDesignerPanel;
//      //测试显示
//      FLegendListView.Material.BackColor.FIsFill:=True;
//      FLegendListView.Material.BackColor.FillColor.FColor:=RedColor;




    {$IFDEF OPENSOURCE_VERSION}
      //图表的ListView
      FSeriesListView:=TSkinListBox.Create(nil);
    {$ELSE}
      //图表的ListView
      FSeriesListView:=TSkinListView.Create(nil);
    {$ENDIF}
      FSeriesListView.Parent:=TParentControl(Self.FSkinControl);
//      FSeriesListView.Align:=alTop;
      FSeriesListView.Visible:=False;
      {$IFDEF FMX}
      FSeriesListView.Stored:=False;
      FSeriesListView.Locked:=True;
      {$ENDIF}
      {$IFDEF VCL}
      FSeriesListView.Material.FIsTransparent:=True;
      FSeriesListView.Material.BackColor.FIsFill:=False;
      {$ENDIF}
      //水平放置的
      FSeriesListView.Prop.ItemLayoutType:=TItemLayoutType.iltHorizontal;
      FSeriesListView.Prop.ViewType:=lvtList;
      FSeriesListView.Prop.ItemHeight:=26;
      FSeriesListView.Top:=0;
      FSeriesListView.Height:=Ceil(FSeriesListView.Prop.ItemHeight);
      FSeriesListView.OnClickItem:=Self.DoFSeriesListViewClickItem;
      CreateSeriesItemDesignerPanel;






    //X轴
    FXAxisSkinListBox:=TSkinListBox.Create(nil);
    FXAxisSkinListBox.Parent:=TParentControl(Self.FSkinControl);
    FXAxisSkinListBox.Visible:=False;
    {$IFDEF FMX}
    FXAxisSkinListBox.Stored:=False;
    {$ENDIF}



    //Y轴
    FYAxisSkinListBox:=TSkinListBox.Create(nil);
    FYAxisSkinListBox.Parent:=TParentControl(Self.FSkinControl);
    FYAxisSkinListBox.Visible:=False;
    {$IFDEF FMX}
    FYAxisSkinListBox.Stored:=False;
    {$ENDIF}
    {$IFDEF VCL}
    FYAxisSkinListBox.Material.FIsTransparent:=True;
    FYAxisSkinListBox.Material.BackColor.FIsFill:=False;
    {$ENDIF}
    //不显示标题
    FYAxisSkinListBox.Material.DrawItemCaptionParam.FontColor:=NullColor;
    FYAxisSkinListBox.Material.DrawItemCaptionParam.FontSize:=0;



    FShowTooltip:=True;


    //创建弹出框
    CreateTooltipItemDesignerPanel;


    FValueChangeEffectAnimator:=TValueChangeEffectAnimator.Create(nil);
    FValueChangeEffectAnimator.OnAnimate:=Self.DoValueChangeEffectAnimatorAnimate;
    //页面切换效果的速度
//    FValueChangeEffectAnimator.Speed:=1.2;//3;//2;//20;//2;//2;//
    FValueChangeEffectAnimator.Speed:=3;//3;//2;//20;//2;//2;//
    //页面切换效果的移动次数
  //  FValueChangeEffectAnimator.EndTimesCount:=20;
    FValueChangeEffectAnimator.EndTimesCount:=10;
    //页面切换效果的类型
  //  FValueChangeEffectAnimator.TweenType:=TTweenType.Quadratic;
    FValueChangeEffectAnimator.TweenType:=TTweenType.Quartic;
//    FValueChangeEffectAnimator.TweenType:=TTweenType.Linear;
    FValueChangeEffectAnimator.EaseType:=TEaseType.easeOut;

//  TTweenType=(
//            Linear,     //：无缓动效果；
//            Quadratic,  //：二次方的缓动（t^2）；
//            Cubic,      //：三次方的缓动（t^3）；
//            Quartic,    //：四次方的缓动（t^4）；
//            Quintic,    //：五次方的缓动（t^5）；
//            Sinusoidal, //：正弦曲线的缓动（sin(t)）；
//            Exponential,//：指数曲线的缓动（2^t）；
//            Circular,   //：圆形曲线的缓动（sqrt(1-t^2)）；
//            Elastic,    //：指数衰减的正弦曲线缓动；
//            Back,       //：超过范围的三次方缓动（(s+1)*t^3 - s*t^2）；
//            Bounce,     //：指数衰减的反弹缓动。
//            InertialScroll//,//惯性滚动
//        );


    FSeriesListViewVisible:=True;

    FLegendListViewVisible:=True;

    FCorNumber:=6;
  end;
end;

procedure TVirtualChartProperties.CreateLegendItemDesignerPanel;
begin
//  if FLegendItemStyle='' then
//  begin
    FLegendItemDesignerPanel:=TSkinItemDesignerPanel.Create(nil);
    FLegendItemDesignerPanel.SkinControlType;
    FLegendItemDesignerPanel.SelfOwnMaterial;
    {$IFDEF FMX}
    FLegendItemDesignerPanel.Stored:=False;
    {$ENDIF}
    {$IFDEF VCL}
    FLegendItemDesignerPanel.Material.IsTransparent:=True;
    FLegendItemDesignerPanel.Material.BackColor.IsFill:=False;
    {$ENDIF}
//    FLegendItemDesignerPanel.Material.IsTransparent:=True;
//    FLegendItemDesignerPanel.Material.BackColor.FillColor.Color:=WhiteColor;
//    FLegendItemDesignerPanel.Material.BackColor.ShadowSize:=8;
//    FLegendItemDesignerPanel.Material.BackColor.IsRound:=True;
    FLegendItemDesignerPanel.Parent:=TParentControl(Self.FSkinControl);
    FLegendItemDesignerPanel.Visible:=False;
//    FLegendItemDesignerPanel.Padding.SetBounds(Ceil(FLegendItemDesignerPanel.Material.BackColor.ShadowSize),
//                                    Ceil(FLegendItemDesignerPanel.Material.BackColor.ShadowSize),
//                                    Ceil(FLegendItemDesignerPanel.Material.BackColor.ShadowSize),
//                                    Ceil(FLegendItemDesignerPanel.Material.BackColor.ShadowSize));
    FLegendItemDesignerPanel.Width:=150;
    FLegendItemDesignerPanel.Height:=24;




    //数据项的颜色,要圆形
    FLegendItemColorPanel:=TSkinPanel.Create(FLegendItemDesignerPanel);
    FLegendItemColorPanel.SkinControlType;
    FLegendItemColorPanel.SelfOwnMaterial;
    FLegendItemColorPanel.Parent:=FLegendItemDesignerPanel;
    FLegendItemColorPanel.BindItemFieldName:='ItemColor';
    {$IFDEF VCL}
    FLegendItemColorPanel.Material.IsTransparent:=True;
    {$ENDIF}
    {$IFDEF FMX}
    FLegendItemColorPanel.Material.IsTransparent:=False;
    {$ENDIF}
    FLegendItemColorPanel.Material.BackColor.IsFill:=True;
    FLegendItemColorPanel.Material.BackColor.IsRound:=True;
    FLegendItemColorPanel.Material.BackColor.RoundWidth:=-1;
    FLegendItemColorPanel.Material.BackColor.RoundHeight:=-1;
    FLegendItemColorPanel.Material.BackColor.Color:=RedColor;
//    FLegendItemColorPanel.Material.BackColor.ShadowSize:=3;
//    FLegendItemColorPanel.Material.BackColor.DrawRectSetting.Enabled:=True;
//    FLegendItemColorPanel.Material.BackColor.DrawRectSetting.SizeType:=dpstPixel;
//    FLegendItemColorPanel.Material.BackColor.DrawRectSetting.Height:=16;
//    FLegendItemColorPanel.Material.BackColor.DrawRectSetting.PositionVertType:=dppvtCenter;
//    FLegendItemColorPanel.Material.BackColor.DrawRectSetting.Width:=16;
//    FLegendItemColorPanel.Material.BackColor.DrawRectSetting.PositionHorzType:=dpphtCenter;
    FLegendItemColorPanel.SetBounds(0,0,32,20);
//    FLegendItemColorPanel.Align:=alLeft;
//    FLegendItemColorPanel.Width:=24;



    //分类
    FLegendItemCaptionLabel:=TSkinLabel.Create(FLegendItemDesignerPanel);
    FLegendItemCaptionLabel.SkinControlType;
    FLegendItemCaptionLabel.SelfOwnMaterial;
    FLegendItemCaptionLabel.Parent:=FLegendItemDesignerPanel;
//    FLegendItemCaptionLabel.Align:=alTop;
    FLegendItemCaptionLabel.BindItemFieldName:='ItemCaption';
    FLegendItemCaptionLabel.Material.IsTransparent:=True;
    FLegendItemCaptionLabel.Material.BackColor.FillColor.Color:=RedColor;
    FLegendItemCaptionLabel.Material.BackColor.IsFill:=False;
//    FLegendItemCaptionLabel.AlignWithMargins:=True;
//    FLegendItemCaptionLabel.Margins.SetBounds(5,5,5,5);
    FLegendItemCaptionLabel.Material.DrawCaptionParam.FontSize:=10;
    FLegendItemCaptionLabel.Material.DrawCaptionParam.FontVertAlign:=TFontVertAlign.fvaCenter;

    {$IFDEF VCL}
    FLegendItemCaptionLabel.Anchors:=[akLeft,akRight,akTop];
    {$ENDIF}
    {$IFDEF FMX}
    FLegendItemCaptionLabel.Anchors:=[TAnchorKind.akLeft,TAnchorKind.akRight,TAnchorKind.akTop];
    {$ENDIF}

    FLegendItemCaptionLabel.SetBounds(FLegendItemColorPanel.Left+FLegendItemColorPanel.Width+5,FLegendItemColorPanel.Top,FLegendItemDesignerPanel.Width-FLegendItemColorPanel.Width-5,20);
//    FLegendItemCaptionLabel.Prop.AutoSize:=True;
//    FLegendItemColorPanel.Align:=alClient;



//    //值
//    FTooltipItemValueLabel:=TSkinLabel.Create(FLegendItemDesignerPanel);
//    FTooltipItemValueLabel.SkinControlType;
//    FTooltipItemValueLabel.SelfOwnMaterial;
//    FTooltipItemValueLabel.Parent:=FLegendItemDesignerPanel;
////    FTooltipItemValueLabel.Align:=alTop;
//    FTooltipItemValueLabel.BindItemFieldName:='ItemDetail1';
//    FTooltipItemValueLabel.Material.IsTransparent:=True;
//    FTooltipItemValueLabel.Material.BackColor.FillColor.Color:=RedColor;
//    FTooltipItemValueLabel.Material.BackColor.IsFill:=False;
////    FTooltipItemValueLabel.AlignWithMargins:=True;
////    FTooltipItemValueLabel.Margins.SetBounds(5,5,5,5);
//    FTooltipItemValueLabel.Material.DrawCaptionParam.FontSize:=10;
//    FTooltipItemValueLabel.Material.DrawCaptionParam.FontHorzAlign:=TFontHorzAlign.fhaRight;
//    FTooltipItemValueLabel.Material.DrawCaptionParam.FontVertAlign:=TFontVertAlign.fvaCenter;
//    FTooltipItemValueLabel.Anchors:=[akLeft,akRight];
//    FTooltipItemValueLabel.SetBounds(FTooltipItemColorPanel.Left+FTooltipItemColorPanel.Width+5,FTooltipItemColorPanel.Top,FTooltipSeriesCaptionLabel.Width-FTooltipItemColorPanel.Width-5,24);
////    FTooltipItemValueLabel.Prop.AutoSize:=True;



//  end;

    FLegendListView.Prop.ItemDesignerPanel:=FLegendItemDesignerPanel;

end;

procedure TVirtualChartProperties.CreateSeriesItemDesignerPanel;
begin
//  if FSeriesItemStyle='' then
//  begin
    FSeriesItemDesignerPanel:=TSkinItemDesignerPanel.Create(nil);
    FSeriesItemDesignerPanel.SkinControlType;
    FSeriesItemDesignerPanel.SelfOwnMaterial;
    {$IFDEF FMX}
    FSeriesItemDesignerPanel.Stored:=False;
    {$ENDIF}
    {$IFDEF VCL}
    FSeriesItemDesignerPanel.Material.IsTransparent:=True;
    FSeriesItemDesignerPanel.Material.BackColor.IsFill:=False;
    {$ENDIF}
//    FSeriesItemDesignerPanel.Material.IsTransparent:=True;
//    FSeriesItemDesignerPanel.Material.BackColor.FillColor.Color:=WhiteColor;
//    FSeriesItemDesignerPanel.Material.BackColor.ShadowSize:=8;
//    FSeriesItemDesignerPanel.Material.BackColor.IsRound:=True;
    FSeriesItemDesignerPanel.Parent:=TParentControl(Self.FSkinControl);
    FSeriesItemDesignerPanel.Visible:=False;
//    FSeriesItemDesignerPanel.Padding.SetBounds(Ceil(FSeriesItemDesignerPanel.Material.BackColor.ShadowSize),
//                                    Ceil(FSeriesItemDesignerPanel.Material.BackColor.ShadowSize),
//                                    Ceil(FSeriesItemDesignerPanel.Material.BackColor.ShadowSize),
//                                    Ceil(FSeriesItemDesignerPanel.Material.BackColor.ShadowSize));
    FSeriesItemDesignerPanel.Width:=150;
    FSeriesItemDesignerPanel.Height:=24;




    //图表的颜色,要圆形
    FSeriesItemColorPanel:=TSkinPanel.Create(FSeriesItemDesignerPanel);
    FSeriesItemColorPanel.SkinControlType;
    FSeriesItemColorPanel.SelfOwnMaterial;
    FSeriesItemColorPanel.Parent:=FSeriesItemDesignerPanel;
    FSeriesItemColorPanel.BindItemFieldName:='ItemColor';
    {$IFDEF VCL}
    FSeriesItemColorPanel.Material.IsTransparent:=True;
    {$ENDIF}
    {$IFDEF FMX}
    FSeriesItemColorPanel.Material.IsTransparent:=False;
    {$ENDIF}
    FSeriesItemColorPanel.Material.BackColor.IsFill:=True;
    FSeriesItemColorPanel.Material.BackColor.IsRound:=True;
    FSeriesItemColorPanel.Material.BackColor.RoundWidth:=-1;
    FSeriesItemColorPanel.Material.BackColor.RoundHeight:=-1;
    FSeriesItemColorPanel.Material.BackColor.Color:=RedColor;
//    FSeriesItemColorPanel.Material.BackColor.ShadowSize:=3;
//    FSeriesItemColorPanel.Material.BackColor.DrawRectSetting.Enabled:=True;
//    FSeriesItemColorPanel.Material.BackColor.DrawRectSetting.SizeType:=dpstPixel;
//    FSeriesItemColorPanel.Material.BackColor.DrawRectSetting.Height:=16;
//    FSeriesItemColorPanel.Material.BackColor.DrawRectSetting.PositionVertType:=dppvtCenter;
//    FSeriesItemColorPanel.Material.BackColor.DrawRectSetting.Width:=16;
//    FSeriesItemColorPanel.Material.BackColor.DrawRectSetting.PositionHorzType:=dpphtCenter;
    FSeriesItemColorPanel.SetBounds(0,0,32,20);
//    FSeriesItemColorPanel.Align:=alLeft;
//    FSeriesItemColorPanel.Width:=24;
    FSeriesItemColorPanel.HitTest:=False;




    //分类
    FSeriesItemCaptionLabel:=TSkinLabel.Create(FSeriesItemDesignerPanel);
    FSeriesItemCaptionLabel.SkinControlType;
    FSeriesItemCaptionLabel.SelfOwnMaterial;
    FSeriesItemCaptionLabel.Parent:=FSeriesItemDesignerPanel;
//    FSeriesItemCaptionLabel.Align:=alTop;
    FSeriesItemCaptionLabel.BindItemFieldName:='ItemCaption';
    FSeriesItemCaptionLabel.Material.IsTransparent:=True;
    FSeriesItemCaptionLabel.Material.BackColor.FillColor.Color:=RedColor;
    FSeriesItemCaptionLabel.Material.BackColor.IsFill:=False;
//    FSeriesItemCaptionLabel.AlignWithMargins:=True;
//    FSeriesItemCaptionLabel.Margins.SetBounds(5,5,5,5);
    FSeriesItemCaptionLabel.Material.DrawCaptionParam.FontSize:=10;
    FSeriesItemCaptionLabel.Material.DrawCaptionParam.FontVertAlign:=TFontVertAlign.fvaCenter;

    {$IFDEF VCL}
    FSeriesItemCaptionLabel.Anchors:=[akLeft,akRight,akTop];
    {$ENDIF}
    {$IFDEF FMX}
    FSeriesItemCaptionLabel.Anchors:=[TAnchorKind.akLeft,TAnchorKind.akRight,TAnchorKind.akTop];
    {$ENDIF}

    FSeriesItemCaptionLabel.SetBounds(FSeriesItemColorPanel.Left+FSeriesItemColorPanel.Width+5,FSeriesItemColorPanel.Top,FSeriesItemDesignerPanel.Width-FSeriesItemColorPanel.Width-5,20);
//    FSeriesItemCaptionLabel.Prop.AutoSize:=True;
//    FSeriesItemColorPanel.Align:=alClient;
    FSeriesItemCaptionLabel.HitTest:=False;



//  end;

    Self.FSeriesListView.Prop.ItemDesignerPanel:=FSeriesItemDesignerPanel;

    
end;

procedure TVirtualChartProperties.CreateTooltipItemDesignerPanel;
begin
//  if FTooltipItemStyle='' then
//  begin


      FTooltipForm:=TSkinPanel.Create(nil);
      //设置素材
      FTooltipForm.SkinControlType;
      FTooltipForm.SelfOwnMaterial;
      FTooltipForm.Parent:=TParentControl(Self.FSkinControl);
      FTooltipForm.Visible:=False;
      {$IFDEF FMX}
      FTooltipForm.Stored:=False;
      FTooltipForm.Locked:=True;
      {$ENDIF}
      {$IFDEF VCL}
      FTooltipForm.Material.FIsTransparent:=True;
      FTooltipForm.Material.BackColor.FIsFill:=False;
      {$ENDIF}
      //背景透明
      {$IFDEF VCL}
      FTooltipForm.Material.FIsTransparent:=True;
      {$ENDIF}
      {$IFDEF FMX}
      FTooltipForm.Material.FIsTransparent:=False;
      FTooltipForm.Stored:=False;
      {$ENDIF}
//      FTooltipForm.Visible:=False;

      FTooltipForm.Material.BackColor.FIsFill:=True;
      FTooltipForm.Material.BackColor.FillColor.FColor:=WhiteColor;
      //稍微有点透明度,避免挡往下面
      FTooltipForm.Material.BackColor.FillColor.FAlpha:=180;
      //有阴影
      FTooltipForm.Material.BackColor.FShadowSize:=8;
      FTooltipForm.Material.BackColor.FIsRound:=True;

      //有边框
      FTooltipForm.Material.BackColor.FBorderWidth:=1;






      //图表项名称/坐标刻度
      FTooltipCaptionLabel:=TSkinLabel.Create(FTooltipForm);
      FTooltipCaptionLabel.SkinControlType;
      FTooltipCaptionLabel.SelfOwnMaterial;
      FTooltipCaptionLabel.Parent:=FTooltipForm;
//      FTooltipCaptionLabel.Align:=alTop;
//      FTooltipCaptionLabel.AlignWithMargins:=True;
//      FTooltipCaptionLabel.Margins.SetBounds(10,10,10,0);
      FTooltipCaptionLabel.Caption:='Category Caption';
  //    FTooltipCaptionLabel.Align:=alTop;
//      FTooltipCaptionLabel.BindItemFieldName:='ItemCaption';
      FTooltipCaptionLabel.Material.IsTransparent:=True;
      FTooltipCaptionLabel.Material.BackColor.FillColor.Color:=RedColor;
      FTooltipCaptionLabel.Material.BackColor.IsFill:=False;
      FTooltipCaptionLabel.Material.DrawCaptionParam.FontHorzAlign:=TFontHorzAlign.fhaLeft;
      FTooltipCaptionLabel.Material.DrawCaptionParam.FontVertAlign:=TFontVertAlign.fvaCenter;
  //    FTooltipCaptionLabel.AlignWithMargins:=True;
  //    FTooltipCaptionLabel.Margins.SetBounds(5,5,5,5);
      {$IFDEF VCL}
      FTooltipCaptionLabel.Material.DrawCaptionParam.FontSize:=8;
      FTooltipCaptionLabel.Anchors:=[akLeft,akRight];
//      FTooltipCaptionLabel.SetBounds(10,10,FTooltipItemDesignerPanel.Width-10-10,20);
      {$ENDIF}
      {$IFDEF FMX}
      FTooltipCaptionLabel.Material.DrawCaptionParam.FontSize:=10;
      FTooltipCaptionLabel.Anchors:=[TAnchorKind.akLeft,TAnchorKind.akRight];
      {$ENDIF}
      FTooltipCaptionLabel.Height:=24;




    {$IFDEF OPENSOURCE_VERSION}
      //FTooltipListView图表提示的ListView
      FTooltipListView:=TSkinListBox.Create(nil);
    {$ELSE}
      //FTooltipListView图表提示的ListView
      FTooltipListView:=TSkinListView.Create(nil);
    {$ENDIF}
      FTooltipListView.Parent:=TParentControl(FTooltipForm);
//      FTooltipListView.Align:=alClient;
//      FTooltipListView.AlignWithMargins:=True;
//      FTooltipListView.Margins.SetBounds(10,0,10,10);
      FTooltipListView.Visible:=True;
      {$IFDEF FMX}
      FTooltipListView.Stored:=False;
      FTooltipListView.Locked:=True;
      {$ENDIF}
      {$IFDEF VCL}
      FTooltipListView.Material.FIsTransparent:=True;
      FTooltipListView.Material.BackColor.FIsFill:=False;
      {$ENDIF}
//      FTooltipListView.Prop.ListLayoutsManager.SkinListIntf:=nil;
//      FreeAndNil(FTooltipListView.Properties.FItems);

      //设置素材
      FTooltipListView.SkinControlType;
      FTooltipListView.SelfOwnMaterial;
      FTooltipListView.Prop.ViewType:=TListViewType.lvtList;
      FTooltipListView.Prop.ItemWidth:=-1;
      FTooltipListView.Prop.ItemHeight:=26;
      FTooltipListView.Height:=100;//预设置一定的高度避免在Visible为False的情况下Height不够
//      //背景透明
//      {$IFDEF VCL}
//      FTooltipListView.Material.FIsTransparent:=True;
//      {$ENDIF}
//      {$IFDEF FMX}
//      FTooltipListView.Material.FIsTransparent:=False;
//      FTooltipListView.Stored:=False;
//      {$ENDIF}
//      //测试显示
//      FTooltipListView.Material.BackColor.FIsFill:=True;
//      FTooltipListView.Material.BackColor.FillColor.FColor:=RedColor;
//      //稍微有点透明度,避免挡往下面
//      FTooltipListView.Material.BackColor.FillColor.FAlpha:=150;
//      //有阴影
//      FTooltipListView.Material.BackColor.FShadowSize:=8;
//      FTooltipListView.Material.BackColor.FIsRound:=True;
//
//      //有边框
//      FTooltipListView.Material.BackColor.FBorderWidth:=1;








      FTooltipItemDesignerPanel:=TSkinItemDesignerPanel.Create(nil);
      FTooltipItemDesignerPanel.SkinControlType;
      FTooltipItemDesignerPanel.SelfOwnMaterial;

      {$IFDEF VCL}
      FTooltipItemDesignerPanel.Material.IsTransparent:=True;
      {$ENDIF}
      {$IFDEF FMX}
      FTooltipItemDesignerPanel.Material.IsTransparent:=False;
      FTooltipItemDesignerPanel.Stored:=False;
      {$ENDIF}

      FTooltipItemDesignerPanel.Material.BackColor.IsFill:=False;
//      FTooltipItemDesignerPanel.Material.BackColor.FillColor.Color:=WhiteColor;
//      FTooltipItemDesignerPanel.Material.BackColor.ShadowSize:=8;
//      FTooltipItemDesignerPanel.Material.BackColor.IsRound:=True;
//
//      FTooltipItemDesignerPanel.Material.BackColor.BorderWidth:=1;
////      FTooltipItemDesignerPanel.Parent:=TParentControl(Self.FSkinControl);
////      FTooltipItemDesignerPanel.Visible:=False;
//
//  //    FTooltipItemDesignerPanel.Padding.SetBounds(Ceil(FTooltipItemDesignerPanel.Material.BackColor.ShadowSize),
//  //                                    Ceil(FTooltipItemDesignerPanel.Material.BackColor.ShadowSize),
//  //                                    Ceil(FTooltipItemDesignerPanel.Material.BackColor.ShadowSize),
////  //                                    Ceil(FTooltipItemDesignerPanel.Material.BackColor.ShadowSize));
//      //设置弹出框的尺寸
//      FTooltipItemDesignerPanel.Width:=150;
//      {$IFDEF VCL}
//      FTooltipItemDesignerPanel.Height:=80;
//      {$ENDIF}
//      {$IFDEF FMX}
//      FTooltipItemDesignerPanel.Height:=60;
//      {$ENDIF}




//      //分类
//      FTooltipCaptionLabel:=TSkinLabel.Create(FTooltipItemDesignerPanel);
//      FTooltipCaptionLabel.SkinControlType;
//      FTooltipCaptionLabel.SelfOwnMaterial;
//      FTooltipCaptionLabel.Parent:=FTooltipItemDesignerPanel;
//  //    FTooltipCaptionLabel.Align:=alTop;
//      FTooltipCaptionLabel.BindItemFieldName:='ItemCaption';
//      FTooltipCaptionLabel.Material.FIsTransparent:=True;
//      FTooltipCaptionLabel.Material.BackColor.FFillColor.Color:=RedColor;
//      FTooltipCaptionLabel.Material.BackColor.FIsFill:=False;
//  //    FTooltipCaptionLabel.AlignWithMargins:=True;
//  //    FTooltipCaptionLabel.Margins.SetBounds(5,5,5,5);
//      FTooltipCaptionLabel.Material.DrawCaptionParam.FFontVertAlign:=TFontVertAlign.fvaCenter;
//      {$IFDEF VCL}
//      FTooltipCaptionLabel.Material.DrawCaptionParam.FFontSize:=8;
//      FTooltipCaptionLabel.Anchors:=[akLeft,akRight];
//      {$ENDIF}
//      {$IFDEF FMX}
//      FTooltipCaptionLabel.Material.DrawCaptionParam.FFontSize:=10;
//      FTooltipCaptionLabel.Anchors:=[TAnchorKind.akLeft,TAnchorKind.akRight];
//      {$ENDIF}
//      FTooltipCaptionLabel.SetBounds(FTooltipItemColorPanel.Left+FTooltipItemColorPanel.Width+5,
//                                      FTooltipItemColorPanel.Top,
//                                      100,//FTooltipSeriesCaptionLabel.Width-FTooltipItemColorPanel.Width-5,
//                                      FTooltipItemColorPanel.Height);
//  //    FTooltipCaptionLabel.Prop.AutoSize:=True;




      //数据项的颜色,要圆形
      FTooltipItemColorPanel:=TSkinPanel.Create(FTooltipItemDesignerPanel);
      FTooltipItemColorPanel.SkinControlType;
      FTooltipItemColorPanel.SelfOwnMaterial;
      FTooltipItemColorPanel.Parent:=FTooltipItemDesignerPanel;
      FTooltipItemColorPanel.BindItemFieldName:='ItemColor';
      {$IFDEF VCL}
      FTooltipItemColorPanel.Material.IsTransparent:=True;
      {$ENDIF}
      {$IFDEF FMX}
      FTooltipItemColorPanel.Material.IsTransparent:=False;
      {$ENDIF}
      FTooltipItemColorPanel.Material.BackColor.IsFill:=True;
      FTooltipItemColorPanel.Material.BackColor.IsRound:=True;
      FTooltipItemColorPanel.Material.BackColor.RoundWidth:=-1;
      FTooltipItemColorPanel.Material.BackColor.RoundHeight:=-1;
      FTooltipItemColorPanel.Material.BackColor.Color:=RedColor;
//      FTooltipItemColorPanel.Material.BackColor.ShadowSize:=3;
      FTooltipItemColorPanel.Material.BackColor.DrawRectSetting.Enabled:=True;
      FTooltipItemColorPanel.Material.BackColor.DrawRectSetting.SizeType:=dpstPixel;
      FTooltipItemColorPanel.Material.BackColor.DrawRectSetting.Height:=16;
      FTooltipItemColorPanel.Material.BackColor.DrawRectSetting.PositionVertType:=dppvtCenter;
      FTooltipItemColorPanel.Material.BackColor.DrawRectSetting.Width:=16;
      FTooltipItemColorPanel.Material.BackColor.DrawRectSetting.PositionHorzType:=dpphtCenter;
      FTooltipItemColorPanel.SetBounds(10,//左边距
                                      0,
                                      24,
                                      Ceil(Self.FTooltipListView.Prop.ItemHeight));
//      {$IFDEF VCL}
//      FTooltipItemColorPanel.SetBounds(10,//左边距
//                                      0,
//                                      24,24);
//      {$ENDIF}
//      {$IFDEF FMX}
//      FTooltipItemColorPanel.SetBounds(10,
//                                      0,
//                                      20,20);
//      {$ENDIF}



      //图表项名称
      FTooltipSeriesCaptionLabel:=TSkinLabel.Create(FTooltipItemDesignerPanel);
      FTooltipSeriesCaptionLabel.SkinControlType;
      FTooltipSeriesCaptionLabel.SelfOwnMaterial;
      FTooltipSeriesCaptionLabel.Parent:=FTooltipItemDesignerPanel;
  //    FTooltipSeriesCaptionLabel.Align:=alTop;
      FTooltipSeriesCaptionLabel.BindItemFieldName:='ItemCaption';
      FTooltipSeriesCaptionLabel.Material.IsTransparent:=True;
      FTooltipSeriesCaptionLabel.Material.BackColor.FillColor.Color:=RedColor;
      FTooltipSeriesCaptionLabel.Material.BackColor.IsFill:=False;
      FTooltipSeriesCaptionLabel.Material.DrawCaptionParam.FontHorzAlign:=TFontHorzAlign.fhaRight;
      FTooltipSeriesCaptionLabel.Material.DrawCaptionParam.FontVertAlign:=TFontVertAlign.fvaCenter;
  //    FTooltipSeriesCaptionLabel.AlignWithMargins:=True;
  //    FTooltipSeriesCaptionLabel.Margins.SetBounds(5,5,5,5);
      {$IFDEF VCL}
      FTooltipSeriesCaptionLabel.Material.DrawCaptionParam.FontSize:=8;
      FTooltipSeriesCaptionLabel.Anchors:=[akLeft,akRight];
      FTooltipSeriesCaptionLabel.SetBounds(10,10,50,20);
      {$ENDIF}
      {$IFDEF FMX}
      FTooltipSeriesCaptionLabel.Material.DrawCaptionParam.FontSize:=10;
      FTooltipSeriesCaptionLabel.Anchors:=[TAnchorKind.akLeft,TAnchorKind.akRight];
      FTooltipSeriesCaptionLabel.SetBounds(5,5,50,20);
      {$ENDIF}


      //值
      FTooltipItemValueLabel:=TSkinLabel.Create(FTooltipItemDesignerPanel);
      FTooltipItemValueLabel.SkinControlType;
      FTooltipItemValueLabel.SelfOwnMaterial;
      FTooltipItemValueLabel.Parent:=FTooltipItemDesignerPanel;
  //    FTooltipItemValueLabel.Align:=alTop;
      FTooltipItemValueLabel.BindItemFieldName:='ItemDetail';
      FTooltipItemValueLabel.Material.IsTransparent:=True;
      FTooltipItemValueLabel.Material.BackColor.FillColor.Color:=RedColor;
      FTooltipItemValueLabel.Material.BackColor.IsFill:=False;
  //    FTooltipItemValueLabel.AlignWithMargins:=True;
  //    FTooltipItemValueLabel.Margins.SetBounds(5,5,5,5);
      FTooltipItemValueLabel.Material.DrawCaptionParam.FontHorzAlign:=TFontHorzAlign.fhaRight;
      FTooltipItemValueLabel.Material.DrawCaptionParam.FontVertAlign:=TFontVertAlign.fvaCenter;
      {$IFDEF VCL}
      FTooltipItemValueLabel.Material.DrawCaptionParam.FontSize:=8;
      FTooltipItemValueLabel.Anchors:=[akLeft,akRight];
      {$ENDIF}
      {$IFDEF FMX}
      FTooltipItemValueLabel.Material.DrawCaptionParam.FontSize:=10;
      FTooltipItemValueLabel.Anchors:=[TAnchorKind.akLeft,TAnchorKind.akRight];
      {$ENDIF}
      FTooltipItemValueLabel.SetBounds(FTooltipSeriesCaptionLabel.Left+FTooltipSeriesCaptionLabel.Width+5,
                                        FTooltipSeriesCaptionLabel.Top,
                                        100,
                                        24);
  //    FTooltipItemValueLabel.Prop.AutoSize:=True;


      FTooltipItemDesignerPanel.Visible:=False;
      Self.FTooltipListView.Prop.ItemDesignerPanel:=FTooltipItemDesignerPanel;

//  end;

end;

destructor TVirtualChartProperties.Destroy;
begin

  FreeAndNil(FValueChangeEffectAnimator);

  FreeAndNil(FTooltipItemDesignerPanel);
  FreeAndNil(FTooltipListView);
  FreeAndNil(FTooltipForm);

  
  FreeAndNil(FLegendItemDesignerPanel);
//  FLegendListView.Properties.FItems:=nil;
  FreeAndNil(FLegendListView);

  
  FreeAndNil(FSeriesItemDesignerPanel);
  FreeAndNil(FSeriesListView);


//  FXAxisSkinListBox.Properties.FItems:=nil;
  FreeAndNil(FXAxisSkinListBox);

//  FYAxisSkinListBox.Properties.FItems:=nil;
  FreeAndNil(FYAxisSkinListBox);





//  FreeAndNil(FXAxis);
//  FreeAndNil(FYAxis);
  FreeAndNil(FSeriesList);


  inherited;
end;

procedure TVirtualChartProperties.DoFSeriesListViewClickItem(
  ASkinItem: TSkinItem);
begin
  Self.FSeriesList[ASkinItem.Index].Enabled:=not Self.FSeriesList[ASkinItem.Index].Enabled;
end;

procedure TVirtualChartProperties.DoSeriesListViewMouseOverItemChange(Sender: TObject);
begin
//  {$IFDEF OPENSOURCE_VERSION}
//  {$ELSE}
//  //提示Item鼠标停靠状态改变的时候,相应的扇形也鼠标停靠
//  if Self.FSeriesListView.Prop.MouseOverItem<>nil then
//  begin
//    Self.FSeriesList[0].GetMouseEventListLayoutsManager.MouseOverItem:=Self.FSeriesList[0].GetMouseEventListLayoutsManager.GetVisibleItem(Self.FSeriesListView.Prop.MouseOverItem.Index);
//  end
//  else
//  begin
//    Self.FSeriesList[0].GetMouseEventListLayoutsManager.MouseOverItem:=nil;
//  end;
//  {$ENDIF}

end;

procedure TVirtualChartProperties.DoShowTooltip(ATooltipDataItem: TVirtualChartSeriesDataItem; X, Y: Double);
var
  ANewLeft,ANewTop:Double;
  ASeries:TVirtualChartSeries;
  I: Integer;
  ASkinItem:TVirtualChartSeriesDataItem;
  ADataItem:TVirtualChartSeriesDataItem;
  AMaxCaptionWidth:Double;
  AMaxDetailWidth:Double;
  ATempWidth:Double;
begin

  if Self.FTooltipItemDesignerPanel=nil then
  begin
    Self.CreateTooltipItemDesignerPanel;
  end;



  if (Self.FTooltipItemDesignerPanel<>nil) then
  begin



      ASeries:=TVirtualChartSeriesDataItems(ATooltipDataItem.Owner).FSeries;


      if Self.FLastTooltipDataItem<>ATooltipDataItem then
      begin
        FLastTooltipDataItem:=ATooltipDataItem;




        //需要重新赋值
        //当前刻度赋值
        if ASeries.FChartType=sctMap then
        begin
          FTooltipCaptionLabel.Caption:=ATooltipDataItem.Caption;
        end
        else
        if (Self.FXAxisSkinListBox.Prop.Items.Count>0) and (ATooltipDataItem.Index<Self.FXAxisSkinListBox.Prop.Items.Count) then
        begin
          FTooltipCaptionLabel.Caption:=Self.FXAxisSkinListBox.Prop.Items[ATooltipDataItem.Index].Caption;
        end
        else
        begin
          //没有刻度
          FTooltipCaptionLabel.Caption:='';
        end;


        //图表名称
        //ATooltipDataItem.Caption:=ASeries.Caption;
//        Self.FTooltipSeriesCaptionLabel.Caption:=ASeries.Caption;


        //将同一刻度的DataItems都列举出来,放到DataItems中去
        AMaxCaptionWidth:=0;
        AMaxDetailWidth:=0;
        Self.FTooltipListView.Prop.Items.BeginUpdate;
        try
          Self.FTooltipListView.Prop.Items.Clear;

              //
              for I := 0 to Self.FSeriesList.Count-1 do
              begin
                if not Self.FSeriesList[I].Visible then Continue;
                if not Self.FSeriesList[I].Enabled then Continue;


                //找出同一刻度的所有DataItems,当一个Chart有多个Series的时候

//                if ATooltipDataItem.Index>=Self.FSeriesList[I].FDataItems.Count then Continue;
//                if ASeries.FChartType=sctMap then Continue;

                if ASeries.FChartType=sctMap then
                begin
                  //在地图下,不需要考虑多Series的情形
                  ADataItem:=ATooltipDataItem;
                end
                else
                begin
                  if ATooltipDataItem.Index>=Self.FSeriesList[I].FDataItems.Count then
                  begin
                    Continue;
                  end;
                  
                  ADataItem:=Self.FSeriesList[I].FDataItems[ATooltipDataItem.Index];
                end;

                ASkinItem:=TVirtualChartSeriesDataItem.Create(nil);
                if Self.FXAxisSkinListBox.Prop.Items.Count>0 then
                begin
                  ASkinItem.Caption:=Self.FSeriesList[I].Caption;
                end
                else
                begin
                  ASkinItem.Caption:=ADataItem.Caption;
                end;
                ASkinItem.Detail:=FloatToStr(ADataItem.FValue);
                ASkinItem.FColor.Color:=Self.FSeriesList[I].FDrawer.GetDataItemColor(ADataItem,TSkinVirtualChartDefaultMaterial(Self.FSkinControlIntf.GetCurrentUseMaterial)).FColor;
                Self.FTooltipListView.Prop.Items.Add(ASkinItem);

                ATempWidth:=GetStringWidth(ASkinItem.Caption,Self.FTooltipSeriesCaptionLabel.CurrentUseMaterialToDefault.DrawCaptionParam.FontSize);
                if ATempWidth>AMaxCaptionWidth then
                begin
                  AMaxCaptionWidth:=ATempWidth;
                end;

                ATempWidth:=GetStringWidth(ASkinItem.Detail,Self.FTooltipItemValueLabel.CurrentUseMaterialToDefault.DrawCaptionParam.FontSize);
                if ATempWidth>AMaxDetailWidth then
                begin
                  AMaxDetailWidth:=ATempWidth;
                end;

              end;


        finally
          Self.FTooltipListView.Prop.Items.EndUpdate;
          Self.FTooltipListView.Height:=Ceil(FTooltipListView.Prop.CalcContentHeight);
        end;



        //分类名称
        //ATooltipDataItem.Detail:=Self.AxisItems[ATooltipDataItem.Index].Caption;
//        Self.FTooltipCaptionLabel.Caption:=Self.AxisItems[ATooltipDataItem.Index].Caption;
//        Self.FTooltipCaptionLabel.Caption:=ATooltipDataItem.Caption;
        //值
        //ATooltipDataItem.Detail1:=FloatToStr(ATooltipDataItem.Value);
//        Self.FTooltipItemValueLabel.Caption:=FloatToStr(ATooltipDataItem.Value);
        //设置颜色
//        Self.T.Caption:=ASeries.Caption;

        //FTooltipItemDesignerPanel.Prop.SetControlsValueByItem(nil,ATooltipDataItem,False);




//
//        FTooltipItemColorPanel.Material.BackColor.FillColor.Color:=ASeries.FDrawer.GetDataItemColor(FLastTooltipDataItem);
//        Self.FTooltipItemDesignerPanel.Material.BackColor.BorderColor.Color:=ASeries.FDrawer.GetDataItemColor(FLastTooltipDataItem);
//
//        //计算宽度
//        FTooltipItemDesignerPanel.Width:=Ceil(10+24+5
//                                            +GetStringWidth(Self.FTooltipCaptionLabel.Caption,Self.FTooltipCaptionLabel.CurrentUseMaterialToDefault.DrawCaptionParam.FontSize)
//                                            +10
//                                            +GetStringWidth(FloatToStr(ATooltipDataItem.Value),FTooltipItemValueLabel.CurrentUseMaterialToDefault.DrawCaptionParam.FontSize)
//                                            +10+5);

        FTooltipSeriesCaptionLabel.SetBounds(FTooltipItemColorPanel.Left+FTooltipItemColorPanel.Width,
                                          FTooltipItemColorPanel.Top,
                                          Ceil(AMaxCaptionWidth),
                                          FTooltipItemColorPanel.Height);

        FTooltipItemValueLabel.SetBounds(FTooltipSeriesCaptionLabel.Left+FTooltipSeriesCaptionLabel.Width+10,
                                          FTooltipItemColorPanel.Top,
                                          Ceil(AMaxDetailWidth)+10,
                                          FTooltipItemColorPanel.Height);



        //计算出FTooltipListView的高度和宽度

//        FTooltipItemColorPanel.Material.BackColor.FillColor.Color:=ASeries.FDrawer.GetDataItemColor(FLastTooltipDataItem);
//        Self.FTooltipListView.Material.BackColor.BorderColor.Color:=ASeries.FDrawer.GetDataItemColor(FLastTooltipDataItem);


        //计算宽度
        FTooltipForm.Width:=Ceil(10//阴影
                                    +FTooltipItemColorPanel.Left
                                    +FTooltipItemColorPanel.Width//颜色图标
                                    +FTooltipSeriesCaptionLabel.Width//GetStringWidth(Self.FTooltipCaptionLabel.Caption,Self.FTooltipCaptionLabel.CurrentUseMaterialToDefault.DrawCaptionParam.FontSize)
                                    +10
                                    +FTooltipItemValueLabel.Width//GetStringWidth(FloatToStr(ATooltipDataItem.Value),FTooltipItemValueLabel.CurrentUseMaterialToDefault.DrawCaptionParam.FontSize)
                                    +10
                                    +10//阴影
                                    );

//        FTooltipForm.SetBounds(FTooltipItemColorPanel.Left+FTooltipItemColorPanel.Width+5,
//                                          FTooltipItemColorPanel.Top,
//                                          FTooltipItemDesignerPanel.Width-FTooltipItemValueLabel.Left-10,
//                                          24);

        if FTooltipCaptionLabel.Caption<>'' then
        begin
          FTooltipCaptionLabel.Visible:=True;

          Self.FTooltipCaptionLabel.SetBounds(10,10,FTooltipForm.Width-10*2,FTooltipCaptionLabel.Height);
          Self.FTooltipListView.SetBounds(10,
                                          FTooltipCaptionLabel.Top+FTooltipCaptionLabel.Height,
                                          FTooltipForm.Width-10*2,
                                          FTooltipListView.Height);

          FTooltipForm.Height:=10//阴影
                              +Self.FTooltipCaptionLabel.Height
                              +Ceil(FTooltipListView.Prop.CalcContentHeight)
                              +10
                              //阴影
                              +10;
        end
        else
        begin
          FTooltipCaptionLabel.Visible:=False;

          Self.FTooltipListView.SetBounds(10,
                                          10,
                                          FTooltipForm.Width-10*2,
                                          FTooltipListView.Height);

          FTooltipForm.Height:=10//阴影
                              +Ceil(FTooltipListView.Prop.CalcContentHeight)
                              //阴影
                              +10;
        end;


      end;


      ANewLeft:=(X+10);
      ANewTop:=(Y+10);


      //坐标轴不能被挡住,提示框也不能被控件盖往
      //不能太右边,会被控件盖住
      //默认是在鼠标的右下角的
      if ((ANewLeft+FTooltipForm.Width)>Self.FSkinControl.Width) then
      begin
        //处理方式,看看左边有没有空间
        ANewLeft:=X-FTooltipForm.Width-10;
      end;


      //不能太下面，会被控件盖住
      if ((ANewTop+FTooltipForm.Height)>Self.FSkinControl.Height) then
      begin
        //看看上面有没有空间,
        ANewTop:=(Y-FTooltipForm.Height-10);

      end;

      //位置移大一点再刷新，不然的话，刷新太频繁，看起来卡
      if (ABS(FTooltipForm.Left-ANewLeft)>3) or (ABS(FTooltipForm.Top-ANewTop)>3) then
      begin

        FTooltipForm.Left:=Ceil(ANewLeft);

        //不能与FSeriesListView重合
        if ANewTop<Self.FSeriesListView.Top+Self.FSeriesListView.Height then
        begin
          ANewTop:=Self.FSeriesListView.Top+Self.FSeriesListView.Height;
        end;
        
        FTooltipForm.Top:=Ceil(ANewTop);


        FTooltipItemDesignerPanelVisible:=True;

//        FTooltipForm.Visible:=True;
//        FTooltipForm.Invalidate;
        Invalidate;
      end;


  end;


end;

procedure TVirtualChartProperties.DoValueChangeEffectAnimatorAnimate(
  Sender: TObject);
begin
  //每个动画进度过程中都需要重新生成数据项的路径
  Self.FIsGeneratedDrawPathList:=False;
  Self.Invalidate;
end;

procedure TVirtualChartProperties.EndUpdate;
begin
  inherited;
  Self.FSeriesList.EndUpdate;
  Self.FXAxisSkinListBox.Prop.Items.EndUpdate;
  Self.FYAxisSkinListBox.Prop.Items.EndUpdate;
  //Properties.EndUpdate之后FIsChanging减1变为0
  if Self.FIsChanging=0 then
  begin
    //需要重新生成数据项的路径
    Self.FIsGeneratedDrawPathList:=False;
  end;
end;

//procedure TVirtualChartProperties.GenerateDrawPathList;
//var
//  I: Integer;
//begin
//  //先从简单的做，横排柱形
//
//
//
//
//  for I := 0 to Self.FSeriesList.Count-1 do
//  begin
//    Self.FSeriesList[I].GenerateDrawPathList();
//  end;
//
//
//end;

function TVirtualChartProperties.GetComponentClassify: String;
begin
  Result:='SkinVirtualChart';
end;

function TVirtualChartProperties.GetPathDrawRect(ADrawRect: TRectF): TRectF;
var
//  ADrawRect:TRectF;
//  AXAxisSkinListBox:TSkinListBox;
//  AYAxisSkinListBox:TSkinListBox;
  ASkinVirtualChartIntf:ISkinVirtualChart;
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin

  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(FSkinControlIntf.GetCurrentUseMaterial);


  ASkinVirtualChartIntf:=Self.FSkinVirtualChartIntf;
  Result:=ADrawRect;
//
//  AXAxisSkinListBox:=ASkinVirtualChartIntf.Properties.FXAxisSkinListBox;
////  AXAxisSkinListBox.Visible:=False;
//  AYAxisSkinListBox:=ASkinVirtualChartIntf.Properties.FYAxisSkinListBox;
////  AYAxisSkinListBox.Visible:=False;


//
//  AXAxisSkinListBox.Properties.ListLayoutsManager.SkinListIntf:=ASkinVirtualChartIntf.Properties.AxisItems;
//
//  FreeAndNil(AXAxisSkinListBox.Properties.FItems);
//  AXAxisSkinListBox.Properties.FItems:=ASkinVirtualChartIntf.Properties.FXAxis.FItems;
//
//
//
//
//  AYAxisSkinListBox.Properties.ListLayoutsManager.SkinListIntf:=ASkinVirtualChartIntf.Properties.FYAxis.FItems;
//
//  FreeAndNil(AYAxisSkinListBox.Properties.FItems);
//  AYAxisSkinListBox.Properties.FItems:=ASkinVirtualChartIntf.Properties.FYAxis.FItems;
//



//  //画出纵坐标系
//  {$IFDEF VCL}
//  AYAxisSkinListBox.AlignWithMargins:=True;
//  AYAxisSkinListBox.Align:=alLeft;
//  {$ENDIF}
//  {$IFDEF FMX}
//  AYAxisSkinListBox.Align:=TAlignLayout.Left;
//  {$ENDIF}
//  AYAxisSkinListBox.Margins.Left:=0;
//  AYAxisSkinListBox.Margins.Top:=100;
//  AYAxisSkinListBox.Margins.Right:=0;
//  AYAxisSkinListBox.Margins.Bottom:=0;
//  //水平排列的
//  AYAxisSkinListBox.Prop.ItemWidth:=-2;
//  if AYAxisSkinListBox.Prop.Items.Count>1 then
//  begin
//    AYAxisSkinListBox.Prop.ItemHeight:=1/AYAxisSkinListBox.Prop.Items.Count;
//  end
//  else
//  begin
//    AYAxisSkinListBox.Prop.ItemHeight:=1/AYAxisSkinListBox.Prop.Items.Count;
//  end;
//
//
//  //画出横坐标系
//  {$IFDEF VCL}
//  AXAxisSkinListBox.AlignWithMargins:=True;
//  AXAxisSkinListBox.Align:=alBottom;
//  {$ENDIF}
//  {$IFDEF FMX}
//  AYAxisSkinListBox.Align:=TAlignLayout.Bottom;
//  {$ENDIF}
//  AXAxisSkinListBox.Margins.Left:=100;
//  AXAxisSkinListBox.Margins.Top:=0;
//  AXAxisSkinListBox.Margins.Right:=0;
//  AXAxisSkinListBox.Margins.Bottom:=0;
//  //水平排列的
//  if AXAxisSkinListBox.Prop.Items.Count>1 then
//  begin
//    AXAxisSkinListBox.Prop.ItemCountPerLine:=AXAxisSkinListBox.Prop.Items.Count;
//  end
//  else
//  begin
//    AXAxisSkinListBox.Prop.ItemCountPerLine:=1;
//  end;


//  Result:=RectF(AYAxisSkinListBox.Width,
//                    AYAxisSkinListBox.Margins.Top,
//                    ASkinVirtualChartIntf.Properties.SkinControl.Width,
//                    AYAxisSkinListBox.Margins.Top+AYAxisSkinListBox.Height
//                    );

  Result:=RectF(ASkinVirtualChartDefaultMaterial.FMarginsLeft
                            //Y轴标题的宽度
                            +ASkinVirtualChartDefaultMaterial.FYAxisCaptionWidth,//最好能自动计算
                ASkinVirtualChartDefaultMaterial.FMarginsTop,

                ASkinVirtualChartIntf.Properties.SkinControl.Width
                            -ASkinVirtualChartDefaultMaterial.FMarginsRight,

                ASkinVirtualChartIntf.Properties.SkinControl.Height
                            -ASkinVirtualChartDefaultMaterial.FMarginsBottom
                            -ASkinVirtualChartDefaultMaterial.FXAxisCaptionHeight//X轴标题的高度
                );

   case ASkinVirtualChartDefaultMaterial.FXAxisScalePosition of
     xscptMiddle: ;
     xscptLeft:
     begin
       //给最右边的坐标刻度标题空出一点
       Result.Right:=Result.Right-30;
     end;
   end;


end;

function TVirtualChartProperties.GetPieInfoCaption(
  ADataItem: TVirtualChartSeriesDataItem;
  ASkinVirtualChartDefaultMaterial: TSkinVirtualChartDefaultMaterial): String;
begin
  case ASkinVirtualChartDefaultMaterial.FPieInfoCaptionType of
    pictCaption: Result:=ADataItem.Caption;
    pictPercent: Result:=FormatFloat('0.00',ADataItem.FValuePercent*100)+'%';
    pictCaptionPercent: Result:=ADataItem.Caption+':'+FormatFloat('0.00',ADataItem.FValuePercent*100)+'%';
    pictCaption_CRLF_Percent: Result:=ADataItem.Caption+#13#10+FormatFloat('0.00',ADataItem.FValuePercent*100)+'%';
    pictValue: Result:=FloatToStr(ADataItem.Value);
    pictCaptionValue: Result:=ADataItem.Caption+':'+FloatToStr(ADataItem.Value);
    pictCaption_CRLF_Value: Result:=ADataItem.Caption+#13#10+FloatToStr(ADataItem.Value);
  end;
  if Assigned(FSkinVirtualChartIntf.OnGetPieInfoCaption) then
  begin
    FSkinVirtualChartIntf.OnGetPieInfoCaption(Self.FSkinControl,ADataItem,Result);
  end;


end;

procedure TVirtualChartProperties.SaveToJson(ASuperObject: ISuperObject);
begin
  inherited;
//
//    //X轴类型,默认是分类,Y轴默认是刻度
//    property XAxisType:TSkinChartAxisType read FXAxisType write SetXAxisType;
//
//    //X轴刻度列表
//    property AxisItems:TSkinListBoxItems read GetAxisItems write SetAxisItems;
//
//    //图表项列表
//    property SeriesList:TVirtualChartSeriesList read FSeriesList write SetSeriesList;
//
//    //是否需要提示
//    property ShowTooltip:Boolean read FShowTooltip write FShowTooltip;
////    property LegendItemStyle:String read FLegendItemStyle write FLegendItemStyle;
//    //弹出框的样式
////    property TooltipItemStyle:String read FTooltipItemStyle write FTooltipItemStyle;
//    property SeriesListViewVisible:Boolean read FSeriesListViewVisible write SetSeriesListViewVisible;
//  published
//    //饼图介绍的ListView是否显示
//    property LegendListViewVisible:Boolean read FLegendListViewVisible write SetLegendListViewVisible;
  if XAxisType<>TSkinChartAxisType.scatCategory then
  begin
    ASuperObject.S['XAxisType']:=GetChartAxisTypeStr(XAxisType);
  end;
  AxisItems.SaveToJsonArray(ASuperObject.A['AxisItems']);
  SeriesList.SaveToJsonArray(ASuperObject.A['SeriesList']);
  if not ShowTooltip then ASuperObject.B['ShowTooltip']:=ShowTooltip;
  if not LegendListViewVisible then ASuperObject.B['LegendListViewVisible']:=LegendListViewVisible;
  if BindCategoryAxisFieldName<>'' then ASuperObject.S['BindCategoryAxisFieldName']:=BindCategoryAxisFieldName;

                
end;

function TVirtualChartProperties.GetAxisItems: TSkinListBoxItems;
begin
  Result:=FXAxisSkinListBox.Prop.Items;
end;

function TVirtualChartProperties.GetYAxisItems: TSkinListBoxItems;
begin
  Result:=FYAxisSkinListBox.Prop.Items;
end;

procedure TVirtualChartProperties.LoadByBindDataSource;
var
  I: Integer;
  ASkinItem:TSkinItem;
  ADataJsonArray:ISuperArray;
  ASkinItemBindingControlIntf:ISkinItemBindingControl;
begin
//  ASkinItemBindingControlIntf:ISkinItemBindingControl;  
  Self.FSkinControl.GetInterface(IID_ISkinItemBindingControl,ASkinItemBindingControlIntf);
  if (ASkinItemBindingControlIntf<>nil)
    and (ASkinItemBindingControlIntf.GetBindItemFieldName<>'')
    and (ASkinItemBindingControlIntf.GetBindDataSource<>nil)
    and (FBindCategoryAxisFieldName<>'') then
  begin
    ADataJsonArray:=ASkinItemBindingControlIntf.GetBindDataSource.GetValueArrayByBindItemField(ASkinItemBindingControlIntf.GetBindItemFieldName);
    Self.BeginUpdate;
    try
      //加载X坐标
      FXAxisSkinListBox.Prop.Items.Clear;
      for I := 0 to ADataJsonArray.Length-1 do
      begin
        ASkinItem:=FXAxisSkinListBox.Prop.Items.Add;
        ASkinItem.Caption:=ADataJsonArray.O[I].S[FBindCategoryAxisFieldName];
      end;

      //有多少图表，加载值坐标
      for I := 0 to Self.FSeriesList.Count-1 do
      begin
        if Self.FSeriesList[I].BindDataSource=nil then
        begin
          //没有单独给Series配置BindDataSouce,则使用Chart总的BindDataSource
          Self.FSeriesList[I].LoadByBindDataSource(ADataJsonArray);
        end;
      end;

    finally
      Self.EndUpdate;
    end;
  end;

end;

//function TVirtualChartProperties.GetInteractiveItem: TSkinItem;
//begin
//  Result:=TSkinItem(Inherited InteractiveItem);
//end;
//
//function TVirtualChartProperties.GetItems: TSkinVirtualChartItems;
//begin
//  Result:=TSkinVirtualChartItems(FItems);
//end;
//
//function TVirtualChartProperties.GetItemsClass: TBaseSkinItemsClass;
//begin
//  Result:=TSkinVirtualChartItems;
//end;
//
//function TVirtualChartProperties.GetListLayoutsManager: TSkinVirtualChartLayoutsManager;
//begin
//  Result:=TSkinVirtualChartLayoutsManager(Self.FListLayoutsManager);
//end;
//
//function TVirtualChartProperties.GetCustomListLayoutsManagerClass: TSkinCustomListLayoutsManagerClass;
//begin
//  Result:=TSkinVirtualChartLayoutsManager;
//end;
//
//procedure TVirtualChartProperties.SetItems(const Value: TSkinVirtualChartItems);
//begin
//  Inherited SetItems(Value);
//end;
//
//function TVirtualChartProperties.GetMouseDownItem: TSkinItem;
//begin
//  Result:=TSkinItem(Inherited MouseDownItem);
//end;
//
//function TVirtualChartProperties.GetMouseOverItem: TSkinItem;
//begin
//  Result:=TSkinItem(Inherited MouseOverItem);
//end;
//
//function TVirtualChartProperties.GetPanDragItem: TSkinItem;
//begin
//  Result:=TSkinItem(Inherited PanDragItem);
//end;
//
//function TVirtualChartProperties.GetSelectedItem: TSkinItem;
//begin
//  Result:=TSkinItem(Inherited SelectedItem);
//end;
//
//procedure TVirtualChartProperties.SetMouseDownItem(Value: TSkinItem);
//begin
//  Inherited MouseDownItem:=Value;
//end;
//
//procedure TVirtualChartProperties.SetMouseOverItem(Value: TSkinItem);
//begin
//  Inherited MouseOverItem:=Value;
//end;
//
//procedure TVirtualChartProperties.SetSelectedItem(Value: TSkinItem);
//begin
//  Inherited SelectedItem:=Value;
//end;

procedure TVirtualChartProperties.SetSeriesList(
  const Value: TVirtualChartSeriesList);
begin
  FSeriesList.Assign(Value);
end;

procedure TVirtualChartProperties.SetSeriesListViewVisible(
  const Value: Boolean);
begin
  if FSeriesListViewVisible<>Value then
  begin
    FSeriesListViewVisible := Value;
    if Self.FSeriesListView<>nil then
    begin
      Self.FSeriesListView.Visible:=False;
    end;
  end;
end;

//procedure TVirtualChartProperties.SetBindValueAxisFieldName(const Value: String);
//begin
//  FBindValueAxisFieldName := Value;
//end;

procedure TVirtualChartProperties.SetAxisItems(const Value: TSkinListBoxItems);
begin
  FXAxisSkinListBox.Prop.Items:=TSkinListBoxItems(Value);
end;

procedure TVirtualChartProperties.SetBindCategoryAxisFieldName(const Value: String);
var
  ASkinItemBindingControlIntf:ISkinItemBindingControl;
begin
  if FBindCategoryAxisFieldName<>Value then
  begin
    FBindCategoryAxisFieldName := Value;

    Self.FSkinControl.GetInterface(IID_ISkinItemBindingControl,ASkinItemBindingControlIntf);
    if ASkinItemBindingControlIntf.GetBindDataSource<>nil then
    begin
      ASkinItemBindingControlIntf.GetBindDataSource.SetControlFieldValue(FSkinControl);
    end;

  end;
end;

//procedure TVirtualChartProperties.SetDataJsonArray(const Value: ISuperArray);
//begin
//  FDataJsonArray := Value;
//end;

procedure TVirtualChartProperties.SetLegendListViewVisible(
  const Value: Boolean);
begin
  if FLegendListViewVisible<>Value then
  begin
    FLegendListViewVisible := Value;
    if Self.FLegendListView<>nil then
    begin
      Self.FLegendListView.Visible:=Value;//False;
    end;
  end;
end;

procedure TVirtualChartProperties.LoadFromJson(ASuperObject: ISuperObject);
begin
  inherited;

  if ASuperObject.Contains('XAxisType') then
  begin
    FXAxisType:=GetChartAxisTypeByStr(ASuperObject.S['XAxisType']);
  end;
  AxisItems.LoadFromJsonArray(ASuperObject.A['AxisItems']);
  SeriesList.LoadFromJsonArray(ASuperObject.A['SeriesList']);
  if ASuperObject.Contains('ShowTooltip') then
  begin
    FShowTooltip:=ASuperObject.B['ShowTooltip'];
  end;
  if ASuperObject.Contains('LegendListViewVisible') then
  begin
    FLegendListViewVisible:=ASuperObject.B['LegendListViewVisible'];
  end;
  if ASuperObject.Contains('BindCategoryAxisFieldName') then
  begin
    FBindCategoryAxisFieldName:=ASuperObject.S['BindCategoryAxisFieldName'];
  end;


end;

procedure TVirtualChartProperties.SetXAxisType(const Value: TSkinChartAxisType);
begin
  FXAxisType:=Value;
end;

procedure TVirtualChartProperties.SetYAxisItems(const Value: TSkinListBoxItems);
begin
  FYAxisSkinListBox.Prop.Items:=TSkinListBoxItems(Value);

end;

procedure TVirtualChartProperties.SetYAxisType(const Value: TSkinChartAxisType);
begin
  FYAxisType:=Value;
end;

procedure TVirtualChartProperties.StartAnimate;
var
  I: Integer;
  J: Integer;
  ASeries:TVirtualChartSeries;
  ADataItem:TVirtualChartSeriesDataItem;
begin
  for I := 0 to Self.SeriesList.Count-1 do
  begin
    ASeries:=Self.SeriesList[I];
    for J := 0 to ASeries.DataItems.Count-1 do
    begin
      ADataItem:=ASeries.DataItems[J];
      if ADataItem.FIsValueChanged_ForAnimate then
      begin
        ADataItem.FIsValueChanged_ForAnimate:=False;
        ADataItem.FDisplayValue:=ADataItem.FOldValue;
        FValueChangeEffectAnimator.AddEffect(ADataItem);
      end;
    end;
  end;
  //判断是否需要启用动画
  if FValueChangeEffectAnimator.FValueChangeEffectList.Count>0 then
  begin
    FValueChangeEffectAnimator.Run;
  end;
  

//    //开启动画,让FValue变成FNewValue
//    if (Owner<>nil)//从dfm加载的时候它为空
//      and (TVirtualChartSeriesDataItems(Self.Owner).FSeries<>nil)
//       and (TVirtualChartSeriesList(TVirtualChartSeriesDataItems(Self.Owner).FSeries.Collection)<>nil)
//      then
//    begin
//      TVirtualChartSeriesList(TVirtualChartSeriesDataItems(Self.Owner).FSeries.Collection).FSkinVirtualChartIntf.Properties.FValueChangeEffectAnimator.AddEffect(Self);
//    end
//    else
//    begin
//      FDisplayValue:=AValue;
//    end;


end;

procedure TVirtualChartProperties.UpdateSeriesListView;
var
  I:Integer;
  ASkinItem:TSkinItem;
  J: Integer;
begin

  //大于1个的时候才显示
  FSeriesListView.Visible:=(FSeriesList.Count>1) and FSeriesListViewVisible;
  if (FSeriesList.Count>1) then
  begin
    //并且根据Series来生成多个Item,这个时机在设计时最好也要能看到
    FSeriesListView.Prop.Items.BeginUpdate;
    try
      FSeriesListView.Prop.Items.Clear;
      for I := 0 to Self.FSeriesList.Count-1 do
      begin
        if not FSeriesList[I].Visible then Continue;

        ASkinItem:=FSeriesListView.Prop.Items.Add;
        ASkinItem.Caption:=FSeriesList[I].Caption;
        ASkinItem.Width:=GetStringWidth(ASkinItem.Caption,Self.FSkinVirtualChartIntf.Prop.FSeriesItemCaptionLabel.Material.DrawCaptionParam.FontSize)
                          +50;
        FSeriesList[I].GetDrawer;
        if FSeriesList[I].FDrawer<>nil then
        begin
          if FSeriesList[I].Enabled then
          begin
            ASkinItem.Color:=FSeriesList[I].FDrawer.GetSeriesColor( TSkinVirtualChartDefaultMaterial(FSkinControlIntf.GetCurrentUseMaterial) ).FColor;
          end
          else
          begin
            ASkinItem.Color:=GrayColor;
          end;
        end;
      end;
    finally
      FSeriesListView.Prop.Items.EndUpdate;
    end;
    //将SeriesListView顶部居中
//    FSeriesListView.Top:=0;
    FSeriesListView.Width:=Ceil(Self.FSeriesListView.Prop.CalcContentWidth);
  //  FSeriesListView.Height:=Ceil(FSeriesListView.Prop.ItemHeight);
    FSeriesListView.Left:=Ceil((FSkinControl.Width-FSeriesListView.Width) / 2);

    Self.FSeriesItemCaptionLabel.Material.DrawCaptionParam.Assign(TSkinVirtualChartDefaultMaterial(FSkinControlIntf.GetCurrentUseMaterial).SeriesItemCaptionParam);
  end;

end;

//procedure TVirtualChartProperties.SetXAxis(const Value: TVirtualChartAxis);
//begin
//  FXAxis.Assign(Value);
//end;
//
//procedure TVirtualChartProperties.SetYAxis(const Value: TVirtualChartAxis);
//begin
//  FYAxis.Assign(Value);
//end;

//procedure TVirtualChartProperties.SetPanDragItem(Value: TSkinItem);
//begin
//  Inherited PanDragItem:=Value;
//end;

{ TSkinVirtualChartDefaultType }

function TSkinVirtualChartDefaultType.CustomBind(ASkinControl:TControl):Boolean;
begin
  if Inherited CustomBind(ASkinControl) then
  begin
    if ASkinControl.GetInterface(IID_ISkinVirtualChart,Self.FSkinVirtualChartIntf) then
    begin
      Result:=True;
    end
    else
    begin
      ShowException('This Component Do not Support ISkinVirtualChart Interface');
    end;
  end;
end;

procedure TSkinVirtualChartDefaultType.CustomMouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Double);
var
  I: Integer;
begin
  inherited;

  for I := 0 to FSkinVirtualChartIntf.Properties.FSeriesList.Count-1 do
  begin
    FSkinVirtualChartIntf.Properties.FSeriesList[I].GetMouseEventListLayoutsManager.CustomMouseDown(Button,Shift,X,Y);
  end;

end;

procedure TSkinVirtualChartDefaultType.CustomMouseEnter;
var
  I: Integer;
begin
  inherited;

  for I := 0 to FSkinVirtualChartIntf.Properties.FSeriesList.Count-1 do
  begin
    FSkinVirtualChartIntf.Properties.FSeriesList[I].GetMouseEventListLayoutsManager.CustomMouseEnter;
  end;


end;

procedure TSkinVirtualChartDefaultType.CustomMouseLeave;
var
  I: Integer;
begin
  inherited;

  for I := 0 to FSkinVirtualChartIntf.Properties.FSeriesList.Count-1 do
  begin
    FSkinVirtualChartIntf.Properties.FSeriesList[I].GetMouseEventListLayoutsManager.CustomMouseLeave;
  end;


end;

procedure TSkinVirtualChartDefaultType.CustomMouseMove(Shift: TShiftState; X,
  Y: Double);
var
  I: Integer;
  ASeries:TVirtualChartSeries;
  AMouseOverDataItem:TVirtualChartSeriesDataItem;
begin
  inherited;

  AMouseOverDataItem:=nil;
  for I := 0 to FSkinVirtualChartIntf.Properties.FSeriesList.Count-1 do
  begin
    //设置数据项是否鼠标停靠
    ASeries:=FSkinVirtualChartIntf.Properties.FSeriesList[I];
    ASeries.GetMouseEventListLayoutsManager.CustomMouseMove(Shift,X,Y);
    if ASeries.GetMouseEventListLayoutsManager.MouseOverItem<>nil then
    begin
      AMouseOverDataItem:=TVirtualChartSeriesDataItem(
        ASeries.GetMouseEventListLayoutsManager.MouseOverItem.GetObject);
    end;
  end;

  if (AMouseOverDataItem<>nil) and Self.FSkinVirtualChartIntf.Properties.ShowTooltip then
  begin
      //显示数据项提示框
      Self.FSkinVirtualChartIntf.Properties.DoShowTooltip(AMouseOverDataItem,X,Y);
  end
  else
  begin
      //隐藏数据项提示框
      if Self.FSkinVirtualChartIntf.Properties.FTooltipItemDesignerPanel<>nil then
      begin
        Self.FSkinVirtualChartIntf.Properties.FTooltipItemDesignerPanelVisible:=False;
      end;

  end;

end;

procedure TSkinVirtualChartDefaultType.CustomMouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Double);
var
  I: Integer;
begin
  inherited;

  for I := 0 to FSkinVirtualChartIntf.Properties.FSeriesList.Count-1 do
  begin
    if (FSkinVirtualChartIntf.Properties.FSeriesList[I].GetMouseEventListLayoutsManager.MouseOverItem<>nil) then
    begin
      if Assigned(FSkinVirtualChartIntf.OnClickDataItem) then
      begin
        FSkinVirtualChartIntf.OnClickDataItem(Self,TVirtualChartSeriesDataItem(FSkinVirtualChartIntf.Properties.FSeriesList[I].GetMouseEventListLayoutsManager.MouseOverItem));
      end;
    end;

    FSkinVirtualChartIntf.Properties.FSeriesList[I].GetMouseEventListLayoutsManager.CustomMouseUp(Button,Shift,X,Y);


  end;

end;

procedure TSkinVirtualChartDefaultType.PaintAxis(ACanvas: TDrawCanvas;
  ASkinMaterial: TSkinControlMaterial; const ADrawRect: TRectF;
  APaintData: TPaintData; const APathDrawRect: TRectF);
var
  I: Integer;
var
//  ADrawRect:TRectF;
  X:Double;
  Y:Double;
  AXAxisSkinListBox:TSkinListBox;
  AYAxisSkinListBox:TSkinListBox;
  ASkinVirtualChartIntf:ISkinVirtualChart;
  ACaptionRect:TRectF;
  AItemWidth:Double;
  AItemHeight:Double;
var
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
//var
//  I:Integer;
var
  ADataItem:TVirtualChartSeriesDataItem;
  AItemEffectStates:TDPEffectStates;
  AOldColor:TDelphiColor;
  AItemCaptionWidth:Double;
  ALastItemCaptionDrawLeft:Double;
var AIsNeedDrawAxisLine:Boolean;
var AIsNeedDrawAxisCaption:Boolean;
var ADrawAxisLineRect:TRectF;
var ADrawAxisCaption:String;
//  AItemPaintData:TPaintData;
//var
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin

  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);
//  ASkinVirtualChartIntf:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf;
  ASkinVirtualChartIntf:=Self.FSkinVirtualChartIntf;

  AXAxisSkinListBox:=ASkinVirtualChartIntf.Properties.FXAxisSkinListBox;
  AYAxisSkinListBox:=ASkinVirtualChartIntf.Properties.FYAxisSkinListBox;


    case Self.FSkinVirtualChartIntf.Properties.FXAxisType of
      scatCategory:
      begin
          //正常状态


          //X坐标上刻度点的位置
          case ASkinVirtualChartDefaultMaterial.XAxisScalePosition of
            xscptLeft:
            begin
              //有从起点开始的,也有从中心点开始的
              AItemWidth:=APathDrawRect.Width / (AXAxisSkinListBox.Prop.Items.Count-1);
            end;
            xscptMiddle:
            begin
              //默认
              //有从起点开始的,也有从中心点开始的
              AItemWidth:=APathDrawRect.Width / AXAxisSkinListBox.Prop.Items.Count;
            end;
          end;
          AItemHeight:=APathDrawRect.Height / (AYAxisSkinListBox.Prop.Items.Count-1);




          //绘制Y轴的背景线
          //从下往上画
          Y:=APathDrawRect.Bottom;
          X:=APathDrawRect.Left;
          ALastItemCaptionDrawLeft:=0;
          //2000,1800,1600,1400,1200,1000
          for I := 0 to AYAxisSkinListBox.Prop.Items.Count-1 do
          begin
                  //正常状态
                  //绘制左边的刻度值,垂直居中,水平右对齐
                  ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontHorzAlign:=fhaRight;
                  ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontVertAlign:=fvaCenter;
                  //右边要空出一点
                  ACaptionRect:=RectF(0,
                                        Y-20,
                                        APathDrawRect.Left-5,
                                        Y+20);

//                  TVirtualChartCustomDrawCategoryAxisEvent=procedure(Sender:TObject;
//                                                                      ACategoryAxisItem:TBaseSkinItem;
//                                                                      var AIsNeedDrawAxisLine:Boolean;
//                                                                      var AIsNeedDrawAxisCaption:Boolean;
//                                                                      var ADrawAxisLineRect:TRectF;
//                                                                      var ADrawAxisCaptionRect:TRectF;
//                                                                      var ADrawAxisCaption:String
//                                                                      ) of object;
//
                  AIsNeedDrawAxisLine:=(I=AYAxisSkinListBox.Prop.Items.Count-1) and ASkinVirtualChartDefaultMaterial.FIsDrawRowFirstLine or ASkinVirtualChartDefaultMaterial.FIsDrawRowLine;
                  AIsNeedDrawAxisCaption:=True;
                  ADrawAxisLineRect:=RectF(APathDrawRect.Left,Y,APathDrawRect.Right,Y);
                  ADrawAxisCaption:=AYAxisSkinListBox.Prop.Items[I].Caption;


                  if Assigned(FSkinVirtualChartIntf.OnCustomDrawCategoryAxis) then
                  begin
                    FSkinVirtualChartIntf.OnCustomDrawCategoryAxis(Self.FSkinControl,
                                                                   AYAxisSkinListBox.Prop.Items[I],
                                                                   AIsNeedDrawAxisLine,
                                                                   AIsNeedDrawAxisCaption,
                                                                   ADrawAxisLineRect,
                                                                   ACaptionRect,
                                                                   ADrawAxisCaption
                                                                   );
                  end;


                  //画行线
                  if AIsNeedDrawAxisLine then
                  begin
//                      ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,APathDrawRect.Left,Y,APathDrawRect.Right,Y);
                      ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,ADrawAxisLineRect.Left,ADrawAxisLineRect.Top,ADrawAxisLineRect.Right,ADrawAxisLineRect.Bottom);
                  end;
                  //默认 Y轴为值                                                ADrawAxisLineRect
                  if AIsNeedDrawAxisCaption then
                  begin
                    ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam,ADrawAxisCaption,ACaptionRect);
                  end;

              //    Y:=Y+AYAxisSkinListBox.Prop.ListLayoutsManager.CalcItemHeight(AYAxisSkinListBox.Prop.Items[I]);
                  Y:=Y-APathDrawRect.Height / (AYAxisSkinListBox.Prop.Items.Count-1);


          end;



          //画X轴的刻度线
          Y:=APathDrawRect.Bottom;
          X:=APathDrawRect.Left;
          ALastItemCaptionDrawLeft:=0;
          for I := 0 to AXAxisSkinListBox.Prop.Items.Count-1 do
          begin

                  //画竖线,画列线
                  if (I=0) and ASkinVirtualChartDefaultMaterial.FIsDrawColFirstLine or ASkinVirtualChartDefaultMaterial.FIsDrawColLine then
                  begin
                    ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,X,APathDrawRect.Top,X,APathDrawRect.Bottom);
                  end;


                  //画刻度点的小竖线
                  //目前这个模式,刻度线画在DataItem的中心点
                  if ASkinVirtualChartDefaultMaterial.FIsDrawXAxisLine then
                  begin
                //    ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
                //                      X+AItemWidth/2,
                //                      APathDrawRect.Bottom,
                //                      X+AItemWidth/2,
                //                      APathDrawRect.Bottom+5);
                    ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
                                      X,
                                      APathDrawRect.Bottom,
                                      X,
                                      APathDrawRect.Bottom+5);
                    //画最后的刻度线
                    if I=AXAxisSkinListBox.Prop.Items.Count-1 then
                    begin
                      ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
                                        X+AItemWidth,
                                        APathDrawRect.Bottom,
                                        X+AItemWidth,
                                        APathDrawRect.Bottom+5);
                    end;
                  end;



                  //绘制左边的刻度值,垂直居中,水平右对齐
                  ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontHorzAlign:=fhaCenter;
                  ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontVertAlign:=fvaTop;



                  //上边要空出一点
                  //绘制刻度标题
                  if not ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.IsWordWrap then
                  begin
                    AItemCaptionWidth:=GetStringWidth(AXAxisSkinListBox.Prop.Items[I].Caption,ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.FontSize);
                  end
                  else
                  begin
                    AItemCaptionWidth:=AItemWidth;
                  end;
                  //绘制标题前需要判断能不能绘制的下,绘制不下则不绘制
              //    if (X+AItemWidth/2-ALastItemCaptionDrawLeft)>AItemCaptionWidth/2 then
                  if ((X-ALastItemCaptionDrawLeft)*2+AItemWidth)>=AItemCaptionWidth then
                  begin

                    case ASkinVirtualChartDefaultMaterial.XAxisScalePosition of
                      xscptLeft:
                      begin
                        //有从起点开始的,也有从中心点开始的
                        ACaptionRect.Left:=X-AItemCaptionWidth/2;
                      end;
                      xscptMiddle:
                      begin
                        //有从起点开始的,也有从中心点开始的
                        //AItemWidth:=APathDrawRect.Width / AXAxisSkinListBox.Prop.Items.Count;
                        ACaptionRect.Left:=X+(AItemWidth-AItemCaptionWidth)/2;
                      end;
                    end;



                    ACaptionRect.Top:=APathDrawRect.Bottom+5;//上面空出一点
                    ACaptionRect.Right:=ACaptionRect.Left+AItemCaptionWidth;
//                    ACaptionRect.Bottom:=APathDrawRect.Bottom+5+24;
                    ACaptionRect.Bottom:=APathDrawRect.Bottom+5+ASkinVirtualChartDefaultMaterial.FXAxisCaptionHeight;
                    ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam,AXAxisSkinListBox.Prop.Items[I].Caption,ACaptionRect);

                    ALastItemCaptionDrawLeft:=ACaptionRect.Right;

                  end;

              //    Y:=Y+AYAxisSkinListBox.Prop.ListLayoutsManager.CalcItemHeight(AYAxisSkinListBox.Prop.Items[I]);
                  X:=X+AItemWidth;
          end;







      end;
      scatValue:
      begin
          //值刻度在X轴上，很少用


          //X坐标上刻度点的位置
          case ASkinVirtualChartDefaultMaterial.XAxisScalePosition of
            xscptLeft:
            begin
              //有从起点开始的,也有从中心点开始的
              AItemHeight:=APathDrawRect.Height / (AXAxisSkinListBox.Prop.Items.Count-1);
            end;
            xscptMiddle:
            begin
              //默认
              //有从起点开始的,也有从中心点开始的
              AItemHeight:=APathDrawRect.Height / AXAxisSkinListBox.Prop.Items.Count;
            end;
          end;
          AItemWidth:=APathDrawRect.Width / (AYAxisSkinListBox.Prop.Items.Count-1);

          //绘制Y轴的背景线
          Y:=APathDrawRect.Bottom;
          X:=APathDrawRect.Left;
          ALastItemCaptionDrawLeft:=0;
          for I := 0 to AYAxisSkinListBox.Prop.Items.Count-1 do
          begin
              //水平画刻度
              //画竖线,画列线
              if ((I=0) and ASkinVirtualChartDefaultMaterial.FIsDrawColFirstLine) or ASkinVirtualChartDefaultMaterial.FIsDrawColLine then
              begin
                ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,X,APathDrawRect.Top,X,APathDrawRect.Bottom);
              end;

              //画刻度点的小竖线
              //目前这个模式,刻度线画在DataItem的中心点
              if ASkinVirtualChartDefaultMaterial.FIsDrawXAxisLine then
              begin
            //    ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
            //                      X+AItemWidth/2,
            //                      APathDrawRect.Bottom,
            //                      X+AItemWidth/2,
            //                      APathDrawRect.Bottom+5);
                ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
                                  X,
                                  APathDrawRect.Bottom,
                                  X,
                                  APathDrawRect.Bottom+5);
                //画最后的刻度线
                if I=AXAxisSkinListBox.Prop.Items.Count-1 then
                begin
                  ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
                                    X+AItemWidth,
                                    APathDrawRect.Bottom,
                                    X+AItemWidth,
                                    APathDrawRect.Bottom+5);
                end;
              end;



              //绘制左边的刻度值,垂直居中,水平右对齐
              ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontHorzAlign:=fhaCenter;
              ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontVertAlign:=fvaTop;



              //上边要空出一点
              //绘制刻度标题
              if not ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.IsWordWrap then
              begin
                AItemCaptionWidth:=GetStringWidth(AYAxisSkinListBox.Prop.Items[I].Caption,ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.FontSize);
              end
              else
              begin
                AItemCaptionWidth:=AItemWidth;//GetStringWidth(AYAxisSkinListBox.Prop.Items[I].Caption,ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam);
              end;
              //绘制标题前需要判断能不能绘制的下,绘制不下则不绘制
          //    if (X+AItemWidth/2-ALastItemCaptionDrawLeft)>AItemCaptionWidth/2 then
              if ((X-ALastItemCaptionDrawLeft)*2+AItemWidth)>=AItemCaptionWidth then
              begin

    //            case ASkinVirtualChartDefaultMaterial.XAxisScalePosition of
    //              xscptLeft:
    //              begin
                    //有从起点开始的,也有从中心点开始的
                    ACaptionRect.Left:=X-AItemCaptionWidth/2;
    //              end;
    //              xscptMiddle:
    //              begin
    //                //有从起点开始的,也有从中心点开始的
    //                //AItemWidth:=APathDrawRect.Width / AXAxisSkinListBox.Prop.Items.Count;
    //                ACaptionRect.Left:=X+(AItemWidth-AItemCaptionWidth)/2;
    //              end;
    //            end;



                ACaptionRect.Top:=APathDrawRect.Bottom+5;//上面空出一点
                ACaptionRect.Right:=ACaptionRect.Left+AItemCaptionWidth;
//                ACaptionRect.Bottom:=APathDrawRect.Bottom+5+24;
                ACaptionRect.Bottom:=APathDrawRect.Bottom+5++ASkinVirtualChartDefaultMaterial.FXAxisCaptionHeight;
                ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam,AYAxisSkinListBox.Prop.Items[I].Caption,ACaptionRect);

                ALastItemCaptionDrawLeft:=ACaptionRect.Right;

              end;

          //    Y:=Y+AYAxisSkinListBox.Prop.ListLayoutsManager.CalcItemHeight(AYAxisSkinListBox.Prop.Items[I]);
              X:=X+AItemWidth;

          end;





          //画分类轴的刻度线
          Y:=APathDrawRect.Bottom;
          X:=APathDrawRect.Left;
          ALastItemCaptionDrawLeft:=0;
          for I := AXAxisSkinListBox.Prop.Items.Count-1 downto 0 do
          begin


                  //绘制左边的刻度值,垂直居中,水平右对齐
                  ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontHorzAlign:=fhaRight;
                  ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontVertAlign:=fvaCenter;
                  //画行线
                  if ((I=AXAxisSkinListBox.Prop.Items.Count-1) and ASkinVirtualChartDefaultMaterial.FIsDrawRowFirstLine) or ASkinVirtualChartDefaultMaterial.FIsDrawRowLine then
                  begin
                      ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,APathDrawRect.Left,Y,APathDrawRect.Right,Y);
                  end;
                  //画最后的刻度线
                  if (I=0) and ASkinVirtualChartDefaultMaterial.FIsDrawRowLine then
                  begin
                    ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
                                      APathDrawRect.Left,
                                      Y-AItemHeight,
                                      APathDrawRect.Right,
                                      Y-AItemHeight);
                  end;
                  //默认 Y轴为值
                  //右边要空出一点

                  ACaptionRect:=RectF(0,
                                        Y-AItemHeight,
                                        APathDrawRect.Left-5,
                                        Y);

                  ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam,AXAxisSkinListBox.Prop.Items[I].Caption,ACaptionRect);

              //    Y:=Y+AXAxisSkinListBox.Prop.ListLayoutsManager.CalcItemHeight(AXAxisSkinListBox.Prop.Items[I]);
                  Y:=Y-AItemHeight;
          end;



      end;
    end;

end;

function TSkinVirtualChartDefaultType.CustomPaint(ACanvas: TDrawCanvas;
  ASkinMaterial: TSkinControlMaterial; const ADrawRect: TRectF;
  APaintData: TPaintData): Boolean;
var
  I: Integer;
  ASeries:TVirtualChartSeries;
  AItemPaintData:TPaintData;
  AItemDesignerPanel:TSkinItemDesignerPanel;
  ATooltipForm:TBaseSkinControl;
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin
  Inherited;
  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);

  if not FSkinVirtualChartIntf.Properties.FIsGeneratedDrawPathList then
  begin
    FSkinVirtualChartIntf.Properties.FIsGeneratedDrawPathList:=True;
    FSkinVirtualChartIntf.Properties.GenerateSeriesDrawPathList(ADrawRect);
  end;


  if Self.FSkinControlIntf.Caption <> '' then
  begin
    ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawCaptionParam,
//                        Self.FSkinLabelIntf.Prop.FPrefix+
                      Self.FSkinControlIntf.Caption,
                      ADrawRect);
  end;

    

//  AIsNeedPaintAxis:=False;
  if FSkinVirtualChartIntf.Properties.FSeriesList.Count>0 then
  begin
      //绘制坐标轴,只需要画一次就可以了
      for I := 0 to FSkinVirtualChartIntf.Properties.FSeriesList.Count-1 do
      begin
        ASeries:=FSkinVirtualChartIntf.Properties.FSeriesList[I];
    //    if (ASeries.FChartType=sctBar)
    //      or (ASeries.FChartType=sctLine)
    ////      or (ASeries.FChartType=sctMap)
    //
    //      then
    //    begin
        if ASeries.Visible and ASeries.Enabled and (ASeries.FDrawer<>nil) then
        begin
            if ASeries.FDrawer.IsNeedPaintAxis then
            begin
    //          AIsNeedPaintAxis:=True;
              //绘制ItemDesignerPanel的背景,背景色
              AItemPaintData:=GlobalNullPaintData;
              AItemPaintData.IsDrawInteractiveState:=True;
              AItemPaintData.IsInDrawDirectUI:=True;
              //绘制Y轴的ListBox
              FSkinVirtualChartIntf.Properties.FYAxisSkinListBox.SkinControlType.Paint(ACanvas,
                          FSkinVirtualChartIntf.Properties.FYAxisSkinListBox.CurrentUseMaterial,
                          ASeries.FPathDrawRect,
                          AItemPaintData
                          );
              PaintAxis(ACanvas,ASkinMaterial,ADrawRect,APaintData,ASeries.FPathDrawRect);
              //绘制背景,放在后面是因为刻度线
              ACanvas.DrawRect(ASkinVirtualChartDefaultMaterial.FDrawAxisClientBackColorParam,ASeries.FPathDrawRect);
              Break;
            end;

    //      end;
          Break;
        end;
      end;
  end
  else
  begin
      PaintAxis(ACanvas,ASkinMaterial,ADrawRect,APaintData,FSkinVirtualChartIntf.Properties.GetPathDrawRect(ADrawRect));
      //绘制背景,放在后面是因为刻度线
      ACanvas.DrawRect(ASkinVirtualChartDefaultMaterial.FDrawAxisClientBackColorParam,FSkinVirtualChartIntf.Properties.GetPathDrawRect(ADrawRect));
  end;

//  if AIsNeedPaintAxis then
//  begin
//    FSkinVirtualChartIntf.Properties.FSeriesList[0].FDrawer.PaintAxis(ACanvas,ASkinMaterial,ADrawRect,APaintData,ASeries.FPathDrawRect);
//  end;

  //绘制图表项列表
  for I := 0 to FSkinVirtualChartIntf.Properties.FSeriesList.Count-1 do
  begin
    ASeries:=FSkinVirtualChartIntf.Properties.FSeriesList[I];
    if ASeries.FVisible and ASeries.Enabled then
    begin
      ASeries.CustomPaint(ACanvas,ASkinMaterial,ADrawRect,APaintData);
    end;
  end;



  //绘制提示框
  if Self.FSkinVirtualChartIntf.Properties.FTooltipItemDesignerPanelVisible then
  begin
//    AItemDesignerPanel:=Self.FSkinVirtualChartIntf.Properties.FTooltipItemDesignerPanel;
//
//    //绘制ItemDesignerPanel的背景
//    AItemPaintData:=GlobalNullPaintData;
//    AItemPaintData.IsDrawInteractiveState:=True;
//    AItemPaintData.IsInDrawDirectUI:=True;
//    AItemDesignerPanel.SkinControlType.Paint(ACanvas,
//                          AItemDesignerPanel.SkinControlType.GetPaintCurrentUseMaterial,
//                          RectF(AItemDesignerPanel.Left,AItemDesignerPanel.Top,AItemDesignerPanel.Left+AItemDesignerPanel.Width,AItemDesignerPanel.Top+AItemDesignerPanel.Height),
//                          AItemPaintData);
//    //绘制ItemDesignerPanel的子控件
//    AItemPaintData:=GlobalNullPaintData;
//    AItemPaintData.IsDrawInteractiveState:=True;
//    AItemPaintData.IsInDrawDirectUI:=True;
//    AItemDesignerPanel.SkinControlType.DrawChildControls(ACanvas,
//                          //Self.FSkinCustomListIntf.Prop.GetPanDragItemDesignerPanelDrawRect,
//                          RectF(AItemDesignerPanel.Left,AItemDesignerPanel.Top,AItemDesignerPanel.Left+AItemDesignerPanel.Width,AItemDesignerPanel.Top+AItemDesignerPanel.Height),
//                          AItemPaintData,
//                          ADrawRect);
//

    ATooltipForm:=Self.FSkinVirtualChartIntf.Properties.FTooltipForm;

    //绘制ItemDesignerPanel的背景
    AItemPaintData:=GlobalNullPaintData;
    AItemPaintData.IsDrawInteractiveState:=True;
    AItemPaintData.IsInDrawDirectUI:=True;
    ATooltipForm.SkinControlType.Paint(ACanvas,
                          ATooltipForm.SkinControlType.GetPaintCurrentUseMaterial,
                          RectF(ATooltipForm.Left,ATooltipForm.Top,ATooltipForm.Left+ATooltipForm.Width,ATooltipForm.Top+ATooltipForm.Height),
                          AItemPaintData);
    //绘制ItemDesignerPanel的子控件
    AItemPaintData:=GlobalNullPaintData;
    AItemPaintData.IsDrawInteractiveState:=True;
    AItemPaintData.IsInDrawDirectUI:=True;
    ATooltipForm.SkinControlType.DrawChildControls(ACanvas,
                          //Self.FSkinCustomListIntf.Prop.GetPanDragItemDesignerPanelDrawRect,
                          RectF(ATooltipForm.Left,ATooltipForm.Top,ATooltipForm.Left+ATooltipForm.Width,ATooltipForm.Top+ATooltipForm.Height),
                          AItemPaintData,
                          ADrawRect);

  end;


end;

procedure TSkinVirtualChartDefaultType.CustomUnBind;
begin
  Inherited CustomUnBind;
  Self.FSkinVirtualChartIntf:=nil;
end;

function TSkinVirtualChartDefaultType.GetSkinMaterial: TSkinVirtualChartDefaultMaterial;
begin
  if Self.FSkinControlIntf.GetCurrentUseMaterial<>nil then
  begin
    Result:=TSkinVirtualChartDefaultMaterial(Self.FSkinControlIntf.GetCurrentUseMaterial);
  end
  else
  begin
    Result:=nil;
  end;
end;

procedure TSkinVirtualChartDefaultType.SizeChanged;
begin
  inherited;

  if (FSkinVirtualChartIntf<>nil)
    and (FSkinVirtualChartIntf.Properties<>nil)
    and (FSkinVirtualChartIntf.Properties.FSeriesList<>nil) then
  begin
    FSkinVirtualChartIntf.Properties.FIsGeneratedDrawPathList:=False;

    //将SeriesListView顶部居中
//    FSkinVirtualChartIntf.Properties.FSeriesListView.Top:=0;
    FSkinVirtualChartIntf.Properties.FSeriesListView.Width:=Ceil(Self.FSkinVirtualChartIntf.Properties.FSeriesListView.Prop.CalcContentWidth);
    FSkinVirtualChartIntf.Properties.FSeriesListView.Left:=Ceil((Self.FSkinControl.Width-FSkinVirtualChartIntf.Properties.FSeriesListView.Width) / 2);
    
  end;

end;

//{ TSkinVirtualChartItems }
//
//
//function TSkinVirtualChartItems.Add: TSkinVirtualChartItem;
//begin
//  Result:=TSkinVirtualChartItem(Inherited Add);
//end;
//
////procedure TSkinVirtualChartItems.InitSkinItemClass;
////begin
////  SkinItemClass:=TSkinVirtualChartItem;
////end;
//
//function TSkinVirtualChartItems.Insert(Index:Integer): TSkinVirtualChartItem;
//begin
//  Result:=TSkinVirtualChartItem(Inherited Insert(Index));
//end;
//
//procedure TSkinVirtualChartItems.SetItem(Index: Integer;const Value: TSkinVirtualChartItem);
//begin
//  Inherited Items[Index]:=Value;
//end;
//
////function TSkinVirtualChartItems.CreateBinaryObject(const AClassName:String=''): TInterfacedPersistent;
////begin
////  Result:=SkinItemClass.Create;//(Self);
////end;
//
//function TSkinVirtualChartItems.GetItem(Index: Integer): TSkinVirtualChartItem;
//begin
//  Result:=TSkinVirtualChartItem(Inherited Items[Index]);
//end;
//
//function TSkinVirtualChartItems.GetDefaultSkinItemClass: TBaseSkinItemClass;
//begin
//  Result:=TSkinVirtualChartItem;
//end;

{ TSkinVirtualChart }

function TSkinVirtualChart.Material:TSkinVirtualChartDefaultMaterial;
begin
  Result:=TSkinVirtualChartDefaultMaterial(SelfOwnMaterial);
end;

function TSkinVirtualChart.SelfOwnMaterialToDefault:TSkinVirtualChartDefaultMaterial;
begin
  Result:=TSkinVirtualChartDefaultMaterial(SelfOwnMaterial);
end;

//constructor TSkinVirtualChart.Create(AOwner: TComponent);
//begin
//  inherited;
//
//end;

function TSkinVirtualChart.CurrentUseMaterialToDefault:TSkinVirtualChartDefaultMaterial;
begin
  Result:=TSkinVirtualChartDefaultMaterial(CurrentUseMaterial);
end;

//destructor TSkinVirtualChart.Destroy;
//begin
//
//  inherited;
//end;

procedure TSkinVirtualChart.DoCustomSkinMaterialChange(Sender: TObject);
begin
  inherited;
  Self.Prop.FIsGeneratedDrawPathList:=False;
end;

function TSkinVirtualChart.GetBindCategoryAxisFieldName: String;
begin
  Result:=Self.Prop.BindCategoryAxisFieldName;
end;

function TSkinVirtualChart.GetOnClickDataItem: TVirtualChartSeriesDataItemClickEvent;
begin
  Result:=FOnClickDataItem;
end;

function TSkinVirtualChart.GetOnCustomDrawCategoryAxis: TVirtualChartCustomDrawCategoryAxisEvent;
begin
  Result := FOnCustomDrawCategoryAxis;
end;

function TSkinVirtualChart.GetOnGeneratedDrawPath: TVirtualChartGeneratedDrawPathEvent;
begin
  Result := FOnGeneratedDrawPath;
end;

function TSkinVirtualChart.GetOnGetPieInfoCaption: TVirtualChartGetPieInfoCaptionEvent;
begin
  Result := FOnGetPieInfoCaption;
end;


function TSkinVirtualChart.GetOnPrepareDrawDataItem: TVirtualChartPrepareDrawDataItemEvent;
begin
  Result := FOnPrepareDrawDataItem;
end;

function TSkinVirtualChart.GetOnPrepareDrawLegendItem: TVirtualListDrawItemEvent;
begin
  Result:=Self.Prop.FLegendListView.OnPrepareDrawItem;
end;

function TSkinVirtualChart.GetOnPrepareDrawSeriesItem: TVirtualListDrawItemEvent;
begin
  Result:=Self.Prop.FSeriesListView.OnPrepareDrawItem;
end;

function TSkinVirtualChart.GetPropertiesClassType: TPropertiesClassType;
begin
  Result:=TVirtualChartProperties;
end;

function TSkinVirtualChart.GetVirtualChartProperties: TVirtualChartProperties;
begin
  Result:=TVirtualChartProperties(Self.FProperties);
end;

procedure TSkinVirtualChart.Loaded;
begin
  inherited;
  Self.Properties.UpdateSeriesListView;
end;

procedure TSkinVirtualChart.SetBindCategoryAxisFieldName(const Value: String);
begin
  Self.Prop.BindCategoryAxisFieldName:=Value;
end;

procedure TSkinVirtualChart.SetControlArrayByBindItemField(
  const AFieldName: String; const AFieldValue: ISuperArray;
  APropertyName: String; ABindItemFieldSetting: TBindItemFieldSetting;
  ASkinItem: TObject; AIsDrawItemInteractiveState: Boolean);
begin
  //设置BindItemFieldName的时候会调用这个方法,但是设置BindCategoryAxisFieldName的时候呢？同样在这个方法中？
  //其实AFieldValue可以直接从BindDataSource中获取,何必这么麻烦？
  Self.Prop.LoadByBindDataSource;
end;

procedure TSkinVirtualChart.SetOnPrepareDrawLegendItem(
  const Value: TVirtualListDrawItemEvent);
begin
  Self.Prop.FLegendListView.OnPrepareDrawItem:=Value;
end;

procedure TSkinVirtualChart.SetOnPrepareDrawSeriesItem(
  const Value: TVirtualListDrawItemEvent);
begin
  Self.Prop.FSeriesListView.OnPrepareDrawItem:=Value;
end;

procedure TSkinVirtualChart.SetVirtualChartProperties(Value: TVirtualChartProperties);
begin
  Self.FProperties.Assign(Value);
end;






//{ TVirtualChartAxis }
//
//constructor TVirtualChartAxis.Create;
//begin
//  FItems:=TVirtualChartAxisDataItems.Create;
//
//end;
//
//destructor TVirtualChartAxis.Destroy;
//begin
//  FreeAndNil(FItems);
//  inherited;
//end;
//
//procedure TVirtualChartAxis.SetItems(const Value: TVirtualChartAxisDataItems);
//begin
//  FItems.Assign(Value);
//end;

{ TVirtualChartSeries }

constructor TVirtualChartSeries.Create(Collection: TCollection);
begin
  FDrawColor:=TDrawColor.Create('Color','图表颜色');
  FDrawColor.FColor:=DefaultColor;
  FDrawColor.StoredDefaultColor:=DefaultColor;

  FGradientDrawColor1:=TDrawColor.Create('GradientColor1','图表颜色');
  FGradientDrawColor1.FColor:=DefaultColor;
  FGradientDrawColor1.StoredDefaultColor:=DefaultColor;

  inherited Create(Collection);
  FDataItems:=TVirtualChartSeriesDataItems.Create();
  FDataItems.FSeries:=Self;

  FStopAngle:=360;
  FVisible:=True;
  FEnabled:=True;

//  FDrawPathItems:=TVirtualChartSeriesDataDrawPathItems.Create();
//  FSkinVirtualChartIntf:=ASkinVirtualChartIntf;
  FListLayoutsManager:=TSkinListLayoutsManager.Create(FDataItems);
  FListLayoutsManager.OnItemPropChange:=DoDataItemPropChange;

  FMapItems:=TVirtualChartSeriesDataItems.Create();
  FMapItems.FSeries:=Self;


  FMapListLayoutsManager:=TSkinListLayoutsManager.Create(FMapItems);
  FMapListLayoutsManager.OnItemPropChange:=DoDataItemPropChange;
end;

function TVirtualChartSeries.CustomPaint(ACanvas: TDrawCanvas;
  ASkinMaterial: TSkinControlMaterial; const ADrawRect: TRectF;
  APaintData: TPaintData): Boolean;
//  APathDrawRect:TRectF;
begin
  //生成需要绘制的Path列表
//  if not FIsGeneratedDrawPathList then
//  begin
//    FIsGeneratedDrawPathList:=True;
//    Self.GenerateDrawPathList(ADrawRect);
//  end;

  if Self.FDrawer<>nil then
  begin
    Self.FDrawer.CustomPaint(ACanvas,ASkinMaterial,ADrawRect,APaintData,FPathDrawRect);
  end;


end;

destructor TVirtualChartSeries.Destroy;
begin
  FreeAndNil(FListLayoutsManager);
  FreeAndNil(FDataItems);
  FreeAndNil(FDrawer);
  FreeAndNil(FDrawColor);
  FreeAndNil(FGradientDrawColor1);
//  FreeAndNil(FDrawPathItems);


  FreeAndNil(FMapItems);
  FreeAndNil(FMapListLayoutsManager);
  inherited;
end;

function TVirtualChartSeries.GetDisplayName: String;
begin
  Result:=Caption;
end;

procedure TVirtualChartSeries.DoDataItemPropChange(Sender: TObject);
begin
//  TVirtualChartSeriesList(Self.Collection).DoChange;

  //这里只是Item的MouseOver状态改变,不需要重新计算绘制路径
  //TVirtualChartSeriesList(Self.Collection).FSkinVirtualChartIntf.Properties.Invalidate;
  if Collection<>nil then
  begin
    TVirtualChartSeriesList(Self.Collection).Changed;
  end;

end;

procedure TVirtualChartSeries.GenerateDrawPathList(const ADrawRect:TRectF);
var
  I: Integer;
//  APathDrawRect:TRectF;
  ADrawerCalssReg:TVirtualChartSeriesDrawerClassReg;
begin
//  FDrawPathItems.Clear;
//  ADrawerCalssReg:=GlobalChartDrawerClassRegList.Find(FChartType);

  GetDrawer;
  
//  if (FDrawer=nil) or not (FDrawer is ADrawerCalssReg.DrawerClass) then
//  begin
//    FreeAndNil(FDrawer);
//    FDrawer:=ADrawerCalssReg.DrawerClass.Create(Self);
//
//    for I := 0 to Self.FDataItems.Count-1 do
//    begin
//      FreeAndNil(Self.FDataItems[I].FDrawData);
//      Self.FDataItems[I].FDrawData:=ADrawerCalssReg.DrawDataClass.Create;
//    end;
//
//  end;

//  GetDrawer;

//  case Self.ChartType of
//    sctBar:
//    begin
//      if (FDrawer=nil) or not (FDrawer is TVirtualChartSeriesBarDrawer) then
//      begin
//        FreeAndNil(FDrawer);
//        FDrawer:=TVirtualChartSeriesBarDrawer.Create(Self);
//      end;
//
//    end;
//    sctLine:
//    begin
//      if (FDrawer=nil) or not (FDrawer is TVirtualChartSeriesLineDrawer) then
//      begin
//        FreeAndNil(FDrawer);
//        FDrawer:=TVirtualChartSeriesLineDrawer.Create(Self);
//      end;
//
//    end;
//    sctBezierLine:
//    begin
//      if (FDrawer=nil) or not (FDrawer is TVirtualChartSeriesBezierLineDrawer) then
//      begin
//        FreeAndNil(FDrawer);
//        FDrawer:=TVirtualChartSeriesBezierLineDrawer.Create(Self);
//      end;
//
//    end;
//    sctPie:
//    begin
//      if (FDrawer=nil) or not (FDrawer is TVirtualChartSeriesPieDrawer) then
//      begin
//        FreeAndNil(FDrawer);
//        FDrawer:=TVirtualChartSeriesPieDrawer.Create(Self);
//      end;
//
//    end;
//    sctMap:
//    begin
//      if (FDrawer=nil) or not (FDrawer is TVirtualChartSeriesMapDrawer) then
//      begin
//        FreeAndNil(FDrawer);
//        FDrawer:=TVirtualChartSeriesMapDrawer.Create(Self);
//      end;
//
//    end;
//  end;

  if FDrawer<>nil then
  begin
    ADrawerCalssReg:=GlobalChartDrawerClassRegList.Find(FChartType);
    for I := 0 to Self.FDataItems.Count-1 do
    begin
      FreeAndNil(Self.FDataItems[I].FDrawData);
      Self.FDataItems[I].FDrawData:=ADrawerCalssReg.DrawDataClass.Create;
    end;

    FPathDrawRect:=FDrawer.GetPathDrawRect(ADrawRect);
//    if Self.DataItems.Count>0 then//去掉了，因为当Map模式的时候，DataItems为空也要能画MapItems
    begin
      FDrawer.GenerateDrawPathList(FPathDrawRect);
    end;
  end;

end;

function TVirtualChartSeries.GetDrawer: TVirtualChartSeriesDrawer;
var
  ADrawerCalssReg:TVirtualChartSeriesDrawerClassReg;
//  I: Integer;
begin
//  FDrawPathItems.Clear;
  if (FDrawer=nil) then// not (FDrawer is ADrawerCalssReg.DrawerClass) then
  begin
    ADrawerCalssReg:=GlobalChartDrawerClassRegList.Find(FChartType);
    if ADrawerCalssReg<>nil then
    begin
//      FreeAndNil(FDrawer);
      FDrawer:=ADrawerCalssReg.DrawerClass.Create(Self);

    end;

  end;
  Result:=FDrawer;
end;

procedure TVirtualChartSeries.GetMinMaxValue(var AMinValue:Double;var AMaxValue:Double;var ASumValue:Double);
var
  I: Integer;
begin
  AMinValue:=0;

  ASumValue:=0;
  AMaxValue:=0;
  if Self.FDataItems.Count>0 then
  begin
//    AMinValue:=FDataItems[0].Value;


    AMaxValue:=FDataItems[0].FValue;
    ASumValue:=FDataItems[0].FValue;


    for I := 1 to FDataItems.Count-1 do
    begin
      if FDataItems[I].FValue>AMaxValue then
      begin
        AMaxValue:=FDataItems[I].FValue;
      end;

      ASumValue:=ASumValue+FDataItems[I].FValue;

//      if FDataItems[I].Value<AMinValue then
//      begin
//        AMinValue:=FDataItems[I].Value;
//      end;
    end;

  end;

  FMinValue:=AMinValue;

  FSumValue:=ASumValue;
  FMaxValue:=AMaxValue;


end;

function TVirtualChartSeries.GetMouseEventListLayoutsManager: TSkinListLayoutsManager;
begin
  if Self.FChartType=sctMap then
  begin
    Result:=Self.FMapListLayoutsManager;
  end
  else
  begin
    Result:=Self.FListLayoutsManager;
  end;

end;

function TVirtualChartSeries.GetSameChartTypeCount: Integer;
begin
  Result:=TVirtualChartSeriesList(Collection).GetSameChartTypeCount(FChartType);
end;

function TVirtualChartSeries.GetSameChartTypeIndex: Integer;
var
  I:Integer;
begin
  Result:=-1;
  for I := 0 to Self.Collection.Count-1 do
  begin
    if TVirtualChartSeriesList(Collection).Items[I].Visible and (TVirtualChartSeriesList(Collection).Items[I].FChartType=Self.FChartType) then
    begin
      Inc(Result);
      if (Collection.Items[I]=Self) then
      begin
        Exit;
      end;
    end;
  end;

end;

procedure TVirtualChartSeries.LoadFromJson(AJson: ISuperObject);
begin
//    property Visible:Boolean read FVisible write SetVisible;
//    //图表项的名称,比如统计是的金额还是数量
//    property Caption:String read FCaption write SetCaption;
//    //图标类型
//    property ChartType:TSkinChartType read FChartType write SetChartType;
//    // 地图区域范围(中国还是省份)
//    property MapRange:String read FMapRange write SetMapRange;
//    //FDataFieldName:String;
//    //数据列表，数据放Item.Json中即可
//    property DataItems:TVirtualChartSeriesDataItems read FDataItems write SetDataItems;
//    property DrawColor:TDrawColor read FDrawColor write SetDrawColor;
//    //渐变色
//    property GradientDrawColor1:TDrawColor read FGradientDrawColor1 write SetGradientDrawColor1;
////    property DrawPathItems:TVirtualChartSeriesDataDrawPathItems read FDrawPathItems;
//    //数据项的颜色类型
//    property DataItemColorType:TDataItemColorType read FDataItemColorType write FDataItemColorType;
  if AJson.Contains('Visible') then FVisible:=AJson.B['Visible'];
  if AJson.Contains('Caption') then FCaption:=AJson.S['Caption'];
  if AJson.Contains('ChartType') then ChartType:=GetChartTypeByStr(AJson.S['ChartType']);
  if AJson.Contains('MapRange') then MapRange:=AJson.S['MapRange'];
  if AJson.Contains('DataItems') then DataItems.LoadFromJsonArray(AJson.A['DataItems']);
  if AJson.Contains('DrawColor') then DrawColor.LoadFromJson(AJson.O['DrawColor']);
  if AJson.Contains('GradientDrawColor1') then GradientDrawColor1.LoadFromJson(AJson.O['GradientDrawColor1']);
  if AJson.Contains('BindValueAxisFieldName') then FBindValueAxisFieldName:=AJson.S['BindValueAxisFieldName'];

end;

procedure TVirtualChartSeries.LoadByBindDataSource(ADataJsonArray:ISuperArray);
var
  I: Integer;
  ACaption:String;
  AJson:ISuperObject;
  ADataItem:TVirtualChartSeriesDataItem;
begin
  if (ADataJsonArray<>nil) and (FBindValueAxisFieldName<>'') and (TVirtualChartSeriesList(Collection).FSkinVirtualChartIntf.Prop.FBindCategoryAxisFieldName<>'') then


  Self.FDataItems.BeginUpdate;
  try
    //procedure TVirtualChartProperties.LoadByBindDataSource;
    FDataItems.Clear;
    for I := 0 to ADataJsonArray.Length-1 do
    begin
      AJson:=ADataJsonArray.O[I];

      //FBindCategoryAxisFieldName，比如客户
      ACaption:=AJson.S[TVirtualChartSeriesList(Collection).FSkinVirtualChartIntf.Prop.FBindCategoryAxisFieldName];
      //只更新
//      ADataItem:=TVirtualChartSeriesDataItem(Self.FDataItems.FindItemByCaption(ACaption));
//      if ADataItem=nil then
      ADataItem:=TVirtualChartSeriesDataItem(Self.FDataItems.Add);
      //判断ADataJsonArray中的元素是[1,2,3,4,5]
      //[{fieldname:1},{fieldname:2},{fieldname:3}]
      ADataItem.Caption:=ACaption;
      //FBindValueAxisFieldName，比如销售金额
      if AJson.Contains(FBindValueAxisFieldName) then
      begin
        ADataItem.Value:=ADataJsonArray.O[I].V[FBindValueAxisFieldName];
      end;

    end;
  finally
    Self.FDataItems.EndUpdate;
  end;
end;

procedure TVirtualChartSeries.SaveToJson(AJson: ISuperObject);
begin
  if not Visible then AJson.B['Visible']:=Visible;
  if Caption<>'' then AJson.S['Caption']:=Caption;
  AJson.S['ChartType']:=GetChartTypeStr(ChartType);
  if MapRange<>'' then AJson.S['MapRange']:=MapRange;
  DataItems.SaveToJsonArray(AJson.A['DataItems']);
  if DrawColor.IsNeedStored then DrawColor.SaveToJson(AJson.O['DrawColor']);
  if GradientDrawColor1.IsNeedStored then GradientDrawColor1.SaveToJson(AJson.O['GradientDrawColor1']);
  if BindValueAxisFieldName<>'' then AJson.S['BindValueAxisFieldName']:=BindValueAxisFieldName;
end;

procedure TVirtualChartSeries.SetCaption(const Value: String);
begin
  if FCaption<>Value then
  begin
    FCaption := Value;
    TVirtualChartSeriesList(Self.Collection).Changed;
  end;
end;

procedure TVirtualChartSeries.SetMapRange(const Value: string);
begin
  if FMapRange<>Value then
  begin
    FMapRange := Value;

//    if (FChartType = sctMap) and ((FMapRange = 'china') or (FMapRange.Length = 6)) then SetChinaMap;

    TVirtualChartSeriesList(Self.Collection).Changed;
  end;
end;


function TVirtualChartSeries.GetBindDataSourceName:String;
begin
  if FBindDataSource<>nil then
  begin
    FBindDataSourceName:=FBindDataSource.Name;
  end;
  Result:=FBindDataSourceName;
end;

function TVirtualChartSeries.GetBindItemFieldName: String;
begin
  Result:=FBindItemFieldName;
end;

procedure TVirtualChartSeries.SetBindDataSourceName(AValue:String);
begin
  if FBindDataSourceName<>AValue then
  begin
    FBindDataSourceName:=AValue;
  end;
end;

procedure TVirtualChartSeries.SetBindItemFieldName(AValue: String);
begin
  if FBindItemFieldName<>AValue then
  begin
    FBindItemFieldName:=AValue;

    if (FBindDataSource<>nil) then
    begin
      FBindDataSource.SetControlFieldValue(Self);
    end;

  end;
end;

function TVirtualChartSeries.GetBindDataSource:TBindDataSource;
begin
  Result:=FBindDataSource;
end;

procedure TVirtualChartSeries.SetBindDataSource(AValue:TBindDataSource);
begin
  if FBindDataSource<>AValue then
  begin
    if FBindDataSource<>nil then
    begin
      FBindDataSource.UnBindControl(Self);
      FBindDataSourceName:='';
    end;

    FBindDataSource:=AValue;

    if FBindDataSource<>nil then
    begin
      FBindDataSourceName:=FBindDataSource.Name;
      FBindDataSource.BindControl(Self);
    end;


  end;
end;

//procedure TVirtualChartSeries.AfterConstruction;
//begin
//  inherited;
////  if GetOwner <> nil then
////    GetOwner.GetInterface(IInterface, FOwnerInterface);
//end;

function TVirtualChartSeries._AddRef: Integer;
begin
//  if FOwnerInterface <> nil then
//    Result := FOwnerInterface._AddRef else
//    Result := -1;
end;

function TVirtualChartSeries._Release: Integer;
begin
//  if FOwnerInterface <> nil then
//    Result := FOwnerInterface._Release else
//    Result := -1;
end;

function TVirtualChartSeries.QueryInterface({$IFDEF FPC}constref{$ELSE}const{$ENDIF} IID: TGUID;
  out Obj): {$IFDEF LINUX}HResult{$ELSE}HResult{$ENDIF};
//const
//  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
end;

//function TVirtualChartSeries.QueryInterface(constref IID: TGUID; out Obj): LongInt;
//const
//  E_NOINTERFACE = HResult($80004002);
//begin
//  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
//end;

procedure TVirtualChartSeries.SetBindValueAxisFieldName(const Value: String);
begin
  if FBindValueAxisFieldName<>Value then
  begin
    FBindValueAxisFieldName := Value;
    TVirtualChartSeriesList(Self.Collection).Changed;

    if (FBindDataSource<>nil) then
    begin
      FBindDataSource.SetControlFieldValue(Self);
    end
    else
    begin

      //重新让DataSource绑定
      TVirtualChartSeriesList(Self.Collection).FSkinVirtualChartIntf.Prop.LoadByBindDataSource;
    end;

  end;
end;

procedure TVirtualChartSeries.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible := Value;
    TVirtualChartSeriesList(Self.Collection).Changed;
  end;
end;

procedure TVirtualChartSeries.SetChartType(const Value: TSkinChartType);
begin
  if FChartType <> Value then
  begin
    FChartType := Value;

    FreeAndNil(FDrawer);
    GetDrawer;

//    if (FChartType = sctMap) and ((FMapRange = 'china') or (FMapRange.Length = 6)) then SetChinaMap;

    TVirtualChartSeriesList(Self.Collection).Changed;
  end;
end;

procedure TVirtualChartSeries.SetControlArrayByBindItemField(const AFieldName: String; const AFieldValue: ISuperArray; APropertyName: String;
  ABindItemFieldSetting: TBindItemFieldSetting; ASkinItem: TObject; AIsDrawItemInteractiveState: Boolean);
begin
  //
  Self.LoadByBindDataSource(AFieldValue);
end;

//function TVirtualChartSeries.ReadResDataString(const AResName: string): string;
//var
//  cRes: TResourceStream;
//  cStr: TStringStream;
//begin
//  Result := '';
//  if System.findResource(HInstance, PChar(AResName), RT_RCDATA) = 0 then
//    Exit;
//
//  cRes := TResourceStream.Create(HInstance, AResName, RT_RCDATA);
//  try
//    cStr := TStringStream.Create('', TEncoding.UTF8);
//    try
//      cStr.LoadFromStream(cRes);
//      Result := cStr.DataString;
//    finally
//      cStr.Free;
//    end;
//  finally
//    cRes.Free;
//  end;
//end;

procedure TVirtualChartSeries.SetDrawColor(const Value: TDrawColor);
begin
  FDrawColor.Assign(Value);
end;

procedure TVirtualChartSeries.SetEnabled(const Value: Boolean);
begin
  if FEnabled<>Value then
  begin
    FEnabled := Value;
    TVirtualChartSeriesList(Self.Collection).Changed;
  end;
end;

procedure TVirtualChartSeries.SetGradientDrawColor1(const Value: TDrawColor);
begin
  FGradientDrawColor1.Assign(Value);
end;

procedure TVirtualChartSeries.SetDataItems(const Value: TVirtualChartSeriesDataItems);
begin
  FDataItems.Assign(Value);
end;

//procedure TVirtualChartSeries.SetDataJsonArray(const Value: ISuperArray);
//begin
//  FDataJsonArray := Value;
//end;

{ TVirtualChartSeriesList }

function TVirtualChartSeriesList.Add: TVirtualChartSeries;
begin
  Result:=TVirtualChartSeries(Inherited Add);
end;



constructor TVirtualChartSeriesList.Create(ItemClass: TCollectionItemClass;
  ASkinVirtualChartIntf: ISkinVirtualChart);
begin
  Inherited Create(ItemClass);
  FSkinVirtualChartIntf:=ASkinVirtualChartIntf;
end;

//procedure TVirtualChartSeriesList.DoChange;
//begin
//  FIsGeneratedDrawPathList:=False;
//
//
////  Self.FSkinVirtualChartIntf.Properties.Invalidate;
//
//end;

function TVirtualChartSeriesList.GetItem(Index: Integer): TVirtualChartSeries;
begin
  Result:=TVirtualChartSeries(Inherited Items[Index]);
end;

function TVirtualChartSeriesList.GetSameChartTypeCount(AChartType: TSkinChartType): Integer;
var
  I:Integer;
begin
  Result:=0;
  for I := 0 to Self.Count-1 do
  begin
    if Items[I].Visible and (Items[I].FChartType=AChartType) then
    begin
      Inc(Result);
    end;
  end;
end;

procedure TVirtualChartSeriesList.LoadFromJsonArray(AJsonArray: ISuperArray);
var
  I:Integer;
  ASeries:TVirtualChartSeries;
begin
  Self.BeginUpdate;
  try
    Clear;
    for I := 0 to AJsonArray.Length-1 do
    begin
      ASeries:=Self.Add;
      ASeries.LoadFromJson(AJsonArray.O[I]);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TVirtualChartSeriesList.SaveToJsonArray(AJsonArray: ISuperArray);
var
  I:Integer;
begin
  for I := 0 to Self.Count-1 do
  begin
    Items[I].SaveToJson(AJsonArray.O[I]);
  end;
end;

procedure TVirtualChartSeriesList.SetItem(Index: Integer;
  const Value: TVirtualChartSeries);
begin
  Inherited Items[Index]:=Value;
end;

procedure TVirtualChartSeriesList.Update(Item: TCollectionItem);
var
  I:Integer;
//  ASkinItem:TSkinItem;
  J: Integer;
begin
  inherited;

  if csLoading in Self.FSkinVirtualChartIntf.Properties.FSkinControl.ComponentState then Exit;

  
  //当DataItem的Value更改的时候，才需要重新生成整个Path
  //鼠标移动的时候,不至于生成整个Path吧
  for I := 0 to Self.Count-1 do
  begin
    if Items[I].DataItems<>nil then
    begin
      for J := 0 to Items[I].DataItems.Count-1 do
      begin
        if Items[I].DataItems[J].FIsValueChanged_ForUpdate then
        begin
          Items[I].DataItems[J].FIsValueChanged_ForUpdate:=False;
          Self.FSkinVirtualChartIntf.Properties.FIsGeneratedDrawPathList:=False;
        end;
      end;
    end;
  end;
  
//  FIsGeneratedDrawPathList:=False;


  if FSkinVirtualChartIntf<>nil then
  begin
    FSkinVirtualChartIntf.Properties.Invalidate;
  end;


  //大于1个的时候才显示
  FSkinVirtualChartIntf.Properties.UpdateSeriesListView;
//  FSkinVirtualChartIntf.Properties.FSeriesListView.Visible:=(FSkinVirtualChartIntf.Properties.FSeriesList.Count>1) and FSkinVirtualChartIntf.Properties.FSeriesListViewVisible;
//  //并且根据Series来生成多个Item,这个时机在设计时最好也要能看到
//  FSkinVirtualChartIntf.Properties.FSeriesListView.Prop.Items.BeginUpdate;
//  try
//    FSkinVirtualChartIntf.Properties.FSeriesListView.Prop.Items.Clear;
//    for I := 0 to Count-1 do
//    begin
//      ASkinItem:=FSkinVirtualChartIntf.Properties.FSeriesListView.Prop.Items.Add;
//      ASkinItem.Caption:=Items[I].Caption;
//      ASkinItem.Width:=GetStringWidth(ASkinItem.Caption,Self.FSkinVirtualChartIntf.Prop.FSeriesItemCaptionLabel.Material.DrawCaptionParam.FontSize)
//                        +50;
//      Items[I].GetDrawer;
//      if Items[I].FDrawer<>nil then
//      begin
//        ASkinItem.Color:=Items[I].FDrawer.GetSeriesColor( TSkinVirtualChartDefaultMaterial(FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial) ).FColor;
//      end;
//    end;
//  finally
//    FSkinVirtualChartIntf.Properties.FSeriesListView.Prop.Items.EndUpdate;
//  end;
//  //将SeriesListView顶部居中
//  FSkinVirtualChartIntf.Properties.FSeriesListView.Top:=0;
//  FSkinVirtualChartIntf.Properties.FSeriesListView.Width:=Ceil(Self.FSkinVirtualChartIntf.Properties.FSeriesListView.Prop.CalcContentWidth);
////  FSkinVirtualChartIntf.Properties.FSeriesListView.Height:=Ceil(FSkinVirtualChartIntf.Properties.FSeriesListView.Prop.ItemHeight);
//  FSkinVirtualChartIntf.Properties.FSeriesListView.Left:=(FSkinVirtualChartIntf.Properties.FSkinControl.Width-FSkinVirtualChartIntf.Properties.FSeriesListView.Width) div 2;

end;

//{ TVirtualChartAxisDataItems }
//
//
//
//function TVirtualChartAxisDataItems.Add: TVirtualChartAxisDataItem;
//begin
//  Result:=TVirtualChartAxisDataItem(Inherited Add);
//end;
//
////procedure TVirtualChartAxisDataItems.InitSkinItemClass;
////begin
////  SkinItemClass:=TVirtualChartAxisDataItem;
////end;
//
//function TVirtualChartAxisDataItems.Insert(Index:Integer): TVirtualChartAxisDataItem;
//begin
//  Result:=TVirtualChartAxisDataItem(Inherited Insert(Index));
//end;
//
//procedure TVirtualChartAxisDataItems.SetItem(Index: Integer;const Value: TVirtualChartAxisDataItem);
//begin
//  Inherited Items[Index]:=Value;
//end;
//
////function TVirtualChartAxisDataItems.CreateBinaryObject(const AClassName:String=''): TInterfacedPersistent;
////begin
////  Result:=SkinItemClass.Create;//(Self);
////end;
//
//function TVirtualChartAxisDataItems.GetItem(Index: Integer): TVirtualChartAxisDataItem;
//begin
//  Result:=TVirtualChartAxisDataItem(Inherited Items[Index]);
//end;
//
//function TVirtualChartAxisDataItems.GetDefaultSkinItemClass: TBaseSkinItemClass;
//begin
//  Result:=TVirtualChartAxisDataItem;
//end;

{ TVirtualChartSeriesDataItems }



function TVirtualChartSeriesDataItems.Add: TVirtualChartSeriesDataItem;
begin
  Result:=TVirtualChartSeriesDataItem(Inherited Add);
end;

//procedure TVirtualChartSeriesDataItems.InitSkinItemClass;
//begin
//  SkinItemClass:=TVirtualChartSeriesDataItem;
//end;

function TVirtualChartSeriesDataItems.Insert(Index:Integer): TVirtualChartSeriesDataItem;
begin
  Result:=TVirtualChartSeriesDataItem(Inherited Insert(Index));
end;

procedure TVirtualChartSeriesDataItems.SetItem(Index: Integer;const Value: TVirtualChartSeriesDataItem);
begin
  Inherited Items[Index]:=Value;
end;

procedure TVirtualChartSeriesDataItems.BeginUpdate;
begin
  inherited;

end;

//function TVirtualChartSeriesDataItems.CreateBinaryObject(const AClassName:String=''): TInterfacedPersistent;
//begin
//  Result:=SkinItemClass.Create;//(Self);
//end;

procedure TVirtualChartSeriesDataItems.EndUpdate;//(AIsForce: Boolean);
begin
  inherited;
  if Self.GetUpdateCount=0 then
  begin

  end;
end;

function TVirtualChartSeriesDataItems.GetItem(Index: Integer): TVirtualChartSeriesDataItem;
begin
  Result:=TVirtualChartSeriesDataItem(Inherited Items[Index]);
end;

function TVirtualChartSeriesDataItems.GetDefaultSkinItemClass: TBaseSkinItemClass;
begin
  Result:=TVirtualChartSeriesDataItem;
end;


//{ TVirtualChartSeriesDataDrawPathItem }
//
//constructor TVirtualChartSeriesDataDrawPathItem.Create;
//begin
//  FDrawPathActions:=TPathActionCollection.Create(TPathActionItem,nil,GlobalDrawPathDataClass);
//
//end;
//
//destructor TVirtualChartSeriesDataDrawPathItem.Destroy;
//begin
//  FreeAndNil(FDrawPathActions);
//  inherited;
//end;
//
//{ TVirtualChartSeriesDataDrawPathItems }
//
//
//
//function TVirtualChartSeriesDataDrawPathItems.Add: TVirtualChartSeriesDataDrawPathItem;
//begin
//  Result:=TVirtualChartSeriesDataDrawPathItem(Inherited Add);
//end;
//
////procedure TVirtualChartSeriesDataDrawPathItems.InitSkinItemClass;
////begin
////  SkinItemClass:=TVirtualChartSeriesDataDrawPathItem;
////end;
//
//function TVirtualChartSeriesDataDrawPathItems.Insert(Index:Integer): TVirtualChartSeriesDataDrawPathItem;
//begin
//  Result:=TVirtualChartSeriesDataDrawPathItem(Inherited Insert(Index));
//end;
//
//procedure TVirtualChartSeriesDataDrawPathItems.SetItem(Index: Integer;const Value: TVirtualChartSeriesDataDrawPathItem);
//begin
//  Inherited Items[Index]:=Value;
//end;
//
////function TVirtualChartSeriesDataDrawPathItems.CreateBinaryObject(const AClassName:String=''): TInterfacedPersistent;
////begin
////  Result:=SkinItemClass.Create;//(Self);
////end;
//
//function TVirtualChartSeriesDataDrawPathItems.GetItem(Index: Integer): TVirtualChartSeriesDataDrawPathItem;
//begin
//  Result:=TVirtualChartSeriesDataDrawPathItem(Inherited Items[Index]);
//end;
//
//function TVirtualChartSeriesDataDrawPathItems.GetDefaultSkinItemClass: TBaseSkinItemClass;
//begin
//  Result:=TVirtualChartSeriesDataDrawPathItem;
//end;

{ TVirtualChartSeriesDrawer }

constructor TVirtualChartSeriesDrawer.Create(AVirtualChartSeries: TVirtualChartSeries);
begin
  FSeries:=AVirtualChartSeries;
  FSeriesDrawPathActions:=TPathActionCollection.Create(TPathActionItem,nil,GlobalDrawPathDataClass);
end;

function TVirtualChartSeriesDrawer.CustomPaint(ACanvas: TDrawCanvas;
  ASkinMaterial: TSkinControlMaterial; const ADrawRect: TRectF;
  APaintData: TPaintData;const APathDrawRect:TRectF): Boolean;
begin

end;

destructor TVirtualChartSeriesDrawer.Destroy;
begin
  FreeAndNil(FSeriesDrawPathActions);

  inherited;
end;

function TVirtualChartSeriesDrawer.GetDataItemColor(ADataItem: TVirtualChartSeriesDataItem;AMaterial:TSkinVirtualChartDefaultMaterial): TDrawColor;
//var
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin
  if ADataItem.Color=0 then
  begin
      //数据项没有指定颜色
      case FSeries.FDataItemColorType of
        dictDefault,dictUseSameColor:
        begin

            if Self.FSeries.FDrawColor.FColor<>DefaultColor then
            begin
              Result:=Self.FSeries.FDrawColor;
            end
            else
            begin

              //默认颜色
        //      ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);

              //是图标序列的顺序
        //      Result:=AMaterial.FSeriesColorList[Self.FSeries.GetSameChartTypeIndex];
              Result:=AMaterial.FSeriesColorList[Self.FSeries.Index mod AMaterial.FSeriesColorList.Count];
            end;

        end;
        dictUseDiffColor:
        begin


              //默认颜色
        //      ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);

              //是图标序列的顺序
        //      Result:=AMaterial.FSeriesColorList[Self.FSeries.GetSameChartTypeIndex];
              Result:=AMaterial.FSeriesColorList[ADataItem.Index mod AMaterial.FSeriesColorList.Count];
        end;
      end;


  end
  else
  begin
      //数据项指定颜色
      Result:=ADataItem.FColor;
  end;
end;

function TVirtualChartSeriesDrawer.GetDataItemGradientColor1(ADataItem: TVirtualChartSeriesDataItem;AMaterial:TSkinVirtualChartDefaultMaterial): TDrawColor;
//var
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin
  if ADataItem.Color=0 then
  begin
    case FSeries.FDataItemColorType of
      dictDefault,dictUseSameColor:
      begin

        if Self.FSeries.FGradientDrawColor1.FColor<>DefaultColor then
        begin
          Result:=Self.FSeries.FGradientDrawColor1;
        end
        else
        begin

          //默认颜色
    //      ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);

          //是图标序列的顺序
    //      Result:=AMaterial.FSeriesGradientColor1List[Self.FSeries.GetSameChartTypeIndex];
          Result:=AMaterial.FSeriesGradientColor1List[Self.FSeries.Index mod AMaterial.FSeriesGradientColor1List.Count];
        end;

      end;
      dictUseDiffColor:
      begin


            //默认颜色
      //      ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);

            //是图标序列的顺序
      //      Result:=AMaterial.FSeriesColorList[Self.FSeries.GetSameChartTypeIndex];
            Result:=AMaterial.FSeriesGradientColor1List[ADataItem.Index mod AMaterial.FSeriesGradientColor1List.Count];
      end;
    end;



  end
  else
  begin
    //
    Result:=ADataItem.FColor;
  end;
end;

function TVirtualChartSeriesDrawer.GetPathDrawRect(ADrawRect: TRectF): TRectF;
//var
////  ADrawRect:TRectF;
////  AXAxisSkinListBox:TSkinListBox;
////  AYAxisSkinListBox:TSkinListBox;
//  ASkinVirtualChartIntf:ISkinVirtualChart;
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin
  Result:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.GetPathDrawRect(ADrawRect);
//  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);
//
//
//  ASkinVirtualChartIntf:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf;
//  Result:=ADrawRect;
////
////  AXAxisSkinListBox:=ASkinVirtualChartIntf.Properties.FXAxisSkinListBox;
//////  AXAxisSkinListBox.Visible:=False;
////  AYAxisSkinListBox:=ASkinVirtualChartIntf.Properties.FYAxisSkinListBox;
//////  AYAxisSkinListBox.Visible:=False;
//
//
////
////  AXAxisSkinListBox.Properties.ListLayoutsManager.SkinListIntf:=ASkinVirtualChartIntf.Properties.AxisItems;
////
////  FreeAndNil(AXAxisSkinListBox.Properties.FItems);
////  AXAxisSkinListBox.Properties.FItems:=ASkinVirtualChartIntf.Properties.FXAxis.FItems;
////
////
////
////
////  AYAxisSkinListBox.Properties.ListLayoutsManager.SkinListIntf:=ASkinVirtualChartIntf.Properties.FYAxis.FItems;
////
////  FreeAndNil(AYAxisSkinListBox.Properties.FItems);
////  AYAxisSkinListBox.Properties.FItems:=ASkinVirtualChartIntf.Properties.FYAxis.FItems;
////
//
//
//
////  //画出纵坐标系
////  {$IFDEF VCL}
////  AYAxisSkinListBox.AlignWithMargins:=True;
////  AYAxisSkinListBox.Align:=alLeft;
////  {$ENDIF}
////  {$IFDEF FMX}
////  AYAxisSkinListBox.Align:=TAlignLayout.Left;
////  {$ENDIF}
////  AYAxisSkinListBox.Margins.Left:=0;
////  AYAxisSkinListBox.Margins.Top:=100;
////  AYAxisSkinListBox.Margins.Right:=0;
////  AYAxisSkinListBox.Margins.Bottom:=0;
////  //水平排列的
////  AYAxisSkinListBox.Prop.ItemWidth:=-2;
////  if AYAxisSkinListBox.Prop.Items.Count>1 then
////  begin
////    AYAxisSkinListBox.Prop.ItemHeight:=1/AYAxisSkinListBox.Prop.Items.Count;
////  end
////  else
////  begin
////    AYAxisSkinListBox.Prop.ItemHeight:=1/AYAxisSkinListBox.Prop.Items.Count;
////  end;
////
////
////  //画出横坐标系
////  {$IFDEF VCL}
////  AXAxisSkinListBox.AlignWithMargins:=True;
////  AXAxisSkinListBox.Align:=alBottom;
////  {$ENDIF}
////  {$IFDEF FMX}
////  AYAxisSkinListBox.Align:=TAlignLayout.Bottom;
////  {$ENDIF}
////  AXAxisSkinListBox.Margins.Left:=100;
////  AXAxisSkinListBox.Margins.Top:=0;
////  AXAxisSkinListBox.Margins.Right:=0;
////  AXAxisSkinListBox.Margins.Bottom:=0;
////  //水平排列的
////  if AXAxisSkinListBox.Prop.Items.Count>1 then
////  begin
////    AXAxisSkinListBox.Prop.ItemCountPerLine:=AXAxisSkinListBox.Prop.Items.Count;
////  end
////  else
////  begin
////    AXAxisSkinListBox.Prop.ItemCountPerLine:=1;
////  end;
//
//
////  Result:=RectF(AYAxisSkinListBox.Width,
////                    AYAxisSkinListBox.Margins.Top,
////                    ASkinVirtualChartIntf.Properties.SkinControl.Width,
////                    AYAxisSkinListBox.Margins.Top+AYAxisSkinListBox.Height
////                    );
//
//  Result:=RectF(ASkinVirtualChartDefaultMaterial.FMarginsLeft
//                            +ASkinVirtualChartDefaultMaterial.FYAxisCaptionWidth,
//                ASkinVirtualChartDefaultMaterial.FMarginsTop,
//
//                ASkinVirtualChartIntf.Properties.SkinControl.Width
//                            -ASkinVirtualChartDefaultMaterial.FMarginsRight,
//
//                ASkinVirtualChartIntf.Properties.SkinControl.Height
//                            -ASkinVirtualChartDefaultMaterial.FMarginsBottom
//                            -ASkinVirtualChartDefaultMaterial.FXAxisCaptionHeight
//                );
//
//   case ASkinVirtualChartDefaultMaterial.FXAxisScalePosition of
//     xscptMiddle: ;
//     xscptLeft:
//     begin
//       //给最右边的坐标刻度标题空出一点
//       Result.Right:=Result.Right-30;
//     end;
//   end;
//

end;

function TVirtualChartSeriesDrawer.GetSeriesColor(AMaterial:TSkinVirtualChartDefaultMaterial): TDrawColor;
//var
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin
//  if ADataItem.Color=0 then
//  begin
//    //默认颜色
//    ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);

  if Self.FSeries.FDrawColor.FColor<>DefaultColor then
  begin
    Result:=Self.FSeries.FDrawColor;
  end
  else
  begin
    //是图标序列的顺序
//    Result:=AMaterial.FSeriesColorList[Self.FSeries.GetSameChartTypeIndex];
    Result:=AMaterial.FSeriesColorList[Self.FSeries.Index mod AMaterial.FSeriesColorList.Count];
  end;

//  end
//  else
//  begin
//    //
//    Result:=ADataItem.Color;
//  end;
//
end;

function TVirtualChartSeriesDrawer.GetSeriesGradientColor1(AMaterial:TSkinVirtualChartDefaultMaterial): TDrawColor;
//var
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin
//  if ADataItem.Color=0 then
//  begin
//    //默认颜色
//    ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);

  if Self.FSeries.FGradientDrawColor1.FColor<>DefaultColor then
  begin
    Result:=Self.FSeries.FGradientDrawColor1;
  end
  else
  begin
    //是图标序列的顺序
//    Result:=AMaterial.FSeriesColorList[Self.FSeries.GetSameChartTypeIndex];
    Result:=AMaterial.FSeriesGradientColor1List[Self.FSeries.Index mod AMaterial.FSeriesColorList.Count];
  end;

//  end
//  else
//  begin
//    //
//    Result:=ADataItem.Color;
//  end;
//
end;

function TVirtualChartSeriesDrawer.IsNeedPaintAxis: Boolean;
begin
  Result:=True;
end;


function TVirtualChartSeriesDrawer.PtInItem(ADataItem: TVirtualChartSeriesDataItem; APoint: TPointF): Boolean;
var
  ADrawData:TVirtualChartSeriesBarDrawData;
begin
  Result:=False;
  //有时候是矩形内的柱子里移上去就要有效果
  ADrawData:=TVirtualChartSeriesBarDrawData(ADataItem.FDrawData);
  if ADrawData<>nil then
  begin
    Result:=PtInRectF(ADrawData.FBarDrawRect,APoint);
  end;

end;

{ TVirtualChartSeriesBarDrawer }

class function TVirtualChartSeriesBarDrawer.ChartType: TSkinChartType;
begin
  Result:=sctBar;

end;

function TVirtualChartSeriesBarDrawer.CustomPaint(ACanvas: TDrawCanvas;
  ASkinMaterial: TSkinControlMaterial; const ADrawRect: TRectF;
  APaintData: TPaintData;const APathDrawRect:TRectF): Boolean;
var
  I: Integer;
  ADataItem:TVirtualChartSeriesDataItem;
  ADrawData:TVirtualChartSeriesBarDrawData;
  AItemEffectStates:TDPEffectStates;
  AOldColor:TDelphiColor;
  ASkinVirtualChartIntf:ISkinVirtualChart;
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin

  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);
  ASkinVirtualChartIntf:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf;

  Inherited;


  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);

  //绘制柱子
  for I := 0 to Self.FSeries.FDataItems.Count-1 do
  begin
    ADataItem:=Self.FSeries.FDataItems[I];
    ADrawData:=TVirtualChartSeriesBarDrawData(ADataItem.FDrawData);
    if ADrawData=nil then Break;


    //获取数据项的状态，是否鼠标停靠
    AItemEffectStates:=Self.FSeries.GetMouseEventListLayoutsManager.ProcessItemDrawEffectStates(ADataItem);
    ASkinVirtualChartDefaultMaterial.FBarColorParam.StaticEffectStates:=AItemEffectStates;


    AOldColor:=ASkinVirtualChartDefaultMaterial.FBarColorParam.FillColor.FColor;
    //获取数据项的柱子填充色
//    ASkinVirtualChartDefaultMaterial.FBarColorParam.FBrushKind:=TDRPBrushKind.drpbkGradient;
    ASkinVirtualChartDefaultMaterial.FBarColorParam.FillColor.FColor:=Self.GetDataItemColor(ADataItem,ASkinVirtualChartDefaultMaterial).Color;
    ASkinVirtualChartDefaultMaterial.FBarColorParam.FillColor.FAlpha:=Self.GetDataItemColor(ADataItem,ASkinVirtualChartDefaultMaterial).Alpha;
    ASkinVirtualChartDefaultMaterial.FBarColorParam.FillGradientColor1.FColor:=Self.GetDataItemGradientColor1(ADataItem,ASkinVirtualChartDefaultMaterial).Color;
    ASkinVirtualChartDefaultMaterial.FBarColorParam.FillGradientColor1.FAlpha:=Self.GetDataItemGradientColor1(ADataItem,ASkinVirtualChartDefaultMaterial).Alpha;


    //处理绘制参数的透明度
    ASkinVirtualChartDefaultMaterial.FBarColorParam.DrawAlpha:=
                  Ceil(ASkinVirtualChartDefaultMaterial.FBarColorParam.CurrentEffectAlpha*1);

    //外框
    ACanvas.DrawRect(ASkinVirtualChartDefaultMaterial.FBarOutRectParam,ADrawData.FBarOutDrawRect);

    //绘制柱子
//    ACanvas.DrawPath(ASkinVirtualChartDefaultMaterial.FBarColorParam,APathDrawRect,ADataItem.FDrawPathActions);
    ACanvas.DrawRect(ASkinVirtualChartDefaultMaterial.FBarColorParam,ADrawData.FBarDrawRect);

    if ASkinVirtualChartDefaultMaterial.IsDrawValue then
    begin
      //绘制值
      ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawValueParam,FloatToStr(ADataItem.FValue),ADrawData.FValueDrawRect);
    end;


    ASkinVirtualChartDefaultMaterial.FBarColorParam.FillColor.FColor:=AOldColor;

  end;
end;

procedure TVirtualChartSeriesBarDrawer.GenerateDrawPathList(APathDrawRect:TRectF);
var
  I: Integer;
  ADataItemRect:TRectF;
  ADataItemPathRect:TRectF;
  AVirtualChartSeriesList:TVirtualChartSeriesList;
  AXAxisSkinListBox:TSkinListBox;
//  ALegendListView:TSkinVirtualList;
  AAxisItemWidth:Double;
  AAxisItemHeight:Double;
  ADataItemLeft:Double;
  ADataItemTop:Double;
  ADataItemWidth:Double;
  ADataItemHeight:Double;
  ALeft:Double;
  ATop:Double;
  ADataItem:TVirtualChartSeriesDataItem;
//  APathActionItem:TPathActionItem;
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
  ABarSizePercent:Double;
  ABarSize:Double;
  ASeriesItemSpace:Double;
  ADrawData:TVirtualChartSeriesBarDrawData;
begin
  Inherited;



  AVirtualChartSeriesList:=TVirtualChartSeriesList(Self.FSeries.Collection);

  AXAxisSkinListBox:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FXAxisSkinListBox;
  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);


//  ALegendListView:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView;
//
//  if ALegendListView<>nil then
//  begin
//      ALegendListView.Visible:=False;
//      ALegendListView.OnMouseOverItemChange:=nil;
//      ALegendListView.OnPrepareDrawItem:=nil;
//  end;

  //取出柱子宽度的百分比
  ABarSizePercent:=0.5;
  if ASkinVirtualChartDefaultMaterial<>nil then
  begin
    ABarSizePercent:=ASkinVirtualChartDefaultMaterial.BarSizePercent;
  end;


  //横排的
  //生成Path列表
  //AAxisItemWidth:=AXAxisSkinListBox.Prop.CalcItemWidth(AXAxisSkinListBox.Prop.Items[I]);
  AAxisItemWidth:=APathDrawRect.Width / AXAxisSkinListBox.Prop.Items.Count;
  AAxisItemHeight:=APathDrawRect.Height / AXAxisSkinListBox.Prop.Items.Count;




  //然后生成柱子
  //需要最大值,计算出百分比
  ALeft:=0;
  ATop:=APathDrawRect.Height;
  for I := 0 to Self.FSeries.FDataItems.Count-1 do
  begin

      case TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FXAxisType of
        scatCategory:
        begin
            //默认,正常状态
            if ABarSizePercent<1 then
            begin
              ABarSize:=AAxisItemWidth*ABarSizePercent;
            end
            else
            begin
              ABarSize:=ABarSizePercent;
            end;

            ADataItem:=Self.FSeries.FDataItems[I];
            ADrawData:=TVirtualChartSeriesBarDrawData(ADataItem.FDrawData);
            if ADrawData=nil then Break;


            //算出百分比
            ADataItem.FDrawPercent:=0;
            if (TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FMaxValue-TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FMinValue)>0 then
            begin
              ADataItem.FDrawPercent:=(ADataItem.FDisplayValue-TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FMinValue)/(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FMaxValue-TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FMinValue);
            end;




            case ASkinVirtualChartDefaultMaterial.FBarsStackType of
              bstOverride:
              begin
                  ADataItemLeft:=(AAxisItemWidth-ABarSize)/2;//AAxisItemWidth*(1-ABarSizePercent)/2;
                  ADataItemWidth:=ABarSize;//AAxisItemWidth*ABarSizePercent;
              end;
              bstQueue:
              begin
                  ADataItemWidth:=ABarSize;//AAxisItemWidth*ABarSizePercent;//用作显示所有序列的宽度
                  //每个序列柱子间的间隔
                  ASeriesItemSpace:=0;
                  //20%空出来作为序列的间隔
                  if FSeries.GetSameChartTypeCount>1 then
                  begin
                    ASeriesItemSpace:=ADataItemWidth * 0.1 / (FSeries.GetSameChartTypeCount-1);
                  end;
                  //每个序列柱子的宽度
                  ADataItemWidth:=(ADataItemWidth - ASeriesItemSpace*(FSeries.GetSameChartTypeCount-1))
                                  / FSeries.GetSameChartTypeCount;
                  //左边距
                  ADataItemLeft:=(AAxisItemWidth-ABarSize)/2//AAxisItemWidth*(1-ABarSizePercent)/2
                                  +(Self.FSeries.GetSameChartTypeIndex)*ADataItemWidth
                                  +(Self.FSeries.GetSameChartTypeIndex)*ASeriesItemSpace;

              end;
            end;

            //数据项所在的大矩形-相对坐标
            ADataItemRect:=RectF(0,0,0,0);
            ADataItemRect.Left:=ALeft;
            ADataItemRect.Top:=0;
            ADataItemRect.Right:=ALeft+AAxisItemWidth;
            ADataItemRect.Bottom:=APathDrawRect.Height;



      //      ADataItem.FDrawPathActions.Clear;



            //柱子的相对坐标
            ADataItemPathRect.Left:=ADataItemRect.Left+ADataItemLeft;
            ADataItemPathRect.Top:=ADataItemRect.Top+APathDrawRect.Height*(1-ADataItem.FDrawPercent);
            ADataItemPathRect.Right:=ADataItemPathRect.Left+ADataItemWidth;
            ADataItemPathRect.Bottom:=ADataItemRect.Bottom;


      //      //生成柱子的Path
      //      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      //      APathActionItem.ActionType:=patAddRect;
      //      APathActionItem.X:=ADataItemPathRect.Left;
      //      //这个柱状图是从底部上来的
      //      APathActionItem.Y:=ADataItemPathRect.Top;
      //      APathActionItem.X1:=ADataItemPathRect.Right;
      //      APathActionItem.Y1:=ADataItemPathRect.Bottom;
      //
      //      //填充
      //      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      //      APathActionItem.ActionType:=patFillPath;



            //绝对坐标
            OffsetRectF(ADataItemPathRect,APathDrawRect.Left,APathDrawRect.Top);
            OffsetRectF(ADataItemRect,APathDrawRect.Left,APathDrawRect.Top);
            ADataItem.FItemRect:=ADataItemRect;
            ADataItem.FItemDrawRect:=ADataItemRect;
            ADrawData.FBarDrawRect:=ADataItemPathRect;


            //值的绘制矩形
            ADrawData.FValueDrawRect:=ADataItemPathRect;
            ADrawData.FValueDrawRect.Bottom:=ADrawData.FValueDrawRect.Top;
            ADrawData.FValueDrawRect.Top:=ADrawData.FValueDrawRect.Top-20;
            ADrawData.FValueDrawRect.Left:=ADrawData.FValueDrawRect.Left-20;
            ADrawData.FValueDrawRect.Right:=ADrawData.FValueDrawRect.Right+20;

            //外框
            ADrawData.FBarOutDrawRect:=ADataItemPathRect;
            ADrawData.FBarOutDrawRect.Top:=APathDrawRect.Top;






            //下一个Item的左边距
            ALeft:=ALeft+AAxisItemWidth;

        end;
        scatValue:
        begin

            //倒的来
            if ABarSizePercent<1 then
            begin
              ABarSize:=AAxisItemHeight*ABarSizePercent;
            end
            else
            begin
              ABarSize:=ABarSizePercent;
            end;

            ADataItem:=Self.FSeries.FDataItems[Self.FSeries.FDataItems.Count-1-I];
            ADrawData:=TVirtualChartSeriesBarDrawData(ADataItem.FDrawData);
            if ADrawData=nil then Break;


            //算出百分比
            ADataItem.FDrawPercent:=0;
            if (TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FMaxValue-TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FMinValue)>0 then
            begin
              ADataItem.FDrawPercent:=(ADataItem.FDisplayValue-TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FMinValue)/(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FMaxValue-TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FMinValue);
            end;


            //生成Path列表
            case ASkinVirtualChartDefaultMaterial.FBarsStackType of
              bstOverride:
              begin
                  ADataItemTop:=(AAxisItemHeight-ABarSize)/2;//AAxisItemHeight*(1-ABarSizePercent)/2;
                  ADataItemHeight:=ABarSize;//AAxisItemHeight*ABarSizePercent;
              end;
              bstQueue:
              begin
                  ADataItemHeight:=ABarSize;//(AAxisItemHeight-ABarSize)/2;//AAxisItemHeight*ABarSizePercent;//用作显示所有序列的宽度
                  //每个序列柱子间的间隔
                  ASeriesItemSpace:=0;
                  //20%空出来作为序列的间隔
                  if FSeries.GetSameChartTypeCount>1 then
                  begin
                    ASeriesItemSpace:=ADataItemHeight * 0.1 / (FSeries.GetSameChartTypeCount-1);
                  end;
                  //每个序列柱子的宽度
                  ADataItemHeight:=(ADataItemHeight - ASeriesItemSpace*(FSeries.GetSameChartTypeCount-1))
                                  / FSeries.GetSameChartTypeCount;
                  //左边距
                  ADataItemTop:=(AAxisItemHeight-ABarSize)/2//AAxisItemHeight*(1-ABarSizePercent)/2
                                  +(Self.FSeries.GetSameChartTypeIndex)*ADataItemHeight
                                  +(Self.FSeries.GetSameChartTypeIndex)*ASeriesItemSpace;

              end;
            end;

            //数据项所在的大矩形-相对坐标
            ADataItemRect:=RectF(0,0,0,0);
            ADataItemRect.Left:=ALeft;
            ADataItemRect.Top:=ATop-AAxisItemHeight;
            ADataItemRect.Right:=ALeft+APathDrawRect.Width;
            ADataItemRect.Bottom:=ATop;



      //      ADataItem.FDrawPathActions.Clear;



            //柱子的相对坐标
            ADataItemPathRect.Left:=ADataItemRect.Left;
            ADataItemPathRect.Top:=ADataItemRect.Top+ADataItemTop;
            ADataItemPathRect.Right:=ADataItemPathRect.Left+APathDrawRect.Width*ADataItem.FDrawPercent;
            ADataItemPathRect.Bottom:=ADataItemPathRect.Top+ADataItemHeight;


      //      //生成柱子的Path
      //      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      //      APathActionItem.ActionType:=patAddRect;
      //      APathActionItem.X:=ADataItemPathRect.Left;
      //      //这个柱状图是从底部上来的
      //      APathActionItem.Y:=ADataItemPathRect.Top;
      //      APathActionItem.X1:=ADataItemPathRect.Right;
      //      APathActionItem.Y1:=ADataItemPathRect.Bottom;
      //
      //      //填充
      //      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      //      APathActionItem.ActionType:=patFillPath;



            //绝对坐标
            OffsetRectF(ADataItemPathRect,APathDrawRect.Left,APathDrawRect.Top);
            OffsetRectF(ADataItemRect,APathDrawRect.Left,APathDrawRect.Top);
            ADataItem.FItemRect:=ADataItemRect;
            ADataItem.FItemDrawRect:=ADataItemRect;
            ADrawData.FBarDrawRect:=ADataItemPathRect;


            //值的绘制矩形
            ADrawData.FValueDrawRect:=ADataItemPathRect;
            ADrawData.FValueDrawRect.Left:=ADrawData.FValueDrawRect.Right;
            ADrawData.FValueDrawRect.Right:=ADrawData.FValueDrawRect.Left+300;

            //外框
            ADrawData.FBarOutDrawRect:=ADataItemPathRect;
            ADrawData.FBarOutDrawRect.Right:=APathDrawRect.Right;


            //下一个Item的左边距
            ATop:=ATop-AAxisItemHeight;


        end;

      end;



  end;


end;

//function TVirtualChartSeriesBarDrawer.GetDataItemColor(
//  ADataItem: TVirtualChartSeriesDataItem;
//  AMaterial: TSkinVirtualChartDefaultMaterial): TDrawColor;
//begin
//  case FSeries.FDataItemColorType of
//    dictDefault:
//    begin
//      Result:=Inherited;
//    end;
//    dictUseSameColor:
//    begin
//        if Self.FSeries.FDrawColor.FColor<>clDefault then
//        begin
//          Result:=Self.FSeries.FDrawColor;
//        end
//        else
//        begin
//
//          //默认颜色
//    //      ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);
//
//          //是图标序列的顺序
//    //      Result:=AMaterial.FSeriesColorList[Self.FSeries.GetSameChartTypeIndex];
//          Result:=AMaterial.FSeriesColorList[Self.FSeries.Index mod AMaterial.FSeriesColorList.Count];
//        end;
//    end;
//    dictUseDiffColor:
//    begin
//
//
//          //默认颜色
//    //      ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);
//
//          //是图标序列的顺序
//    //      Result:=AMaterial.FSeriesColorList[Self.FSeries.GetSameChartTypeIndex];
//          Result:=AMaterial.FSeriesColorList[ADataItem.Index mod AMaterial.FSeriesColorList.Count];
//    end;
//  end;
//
//end;
//
//function TVirtualChartSeriesBarDrawer.GetDataItemGradientColor1(
//  ADataItem: TVirtualChartSeriesDataItem;
//  AMaterial: TSkinVirtualChartDefaultMaterial): TDrawColor;
//begin
//  case FSeries.FDataItemColorType of
//    dictDefault:
//    begin
//      Result:=Inherited;
//    end;
//    dictUseSameColor:
//    begin
//        if Self.FSeries.FGradientDrawColor1.FColor<>clDefault then
//        begin
//          Result:=Self.FSeries.FGradientDrawColor1;
//        end
//        else
//        begin
//
//          //默认颜色
//    //      ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);
//
//          //是图标序列的顺序
//    //      Result:=AMaterial.FSeriesColorList[Self.FSeries.GetSameChartTypeIndex];
//          Result:=AMaterial.FSeriesGradientColor1List[Self.FSeries.Index mod AMaterial.FSeriesGradientColor1List.Count];
//        end;
//    end;
//    dictUseDiffColor:
//    begin
//
//
//          //默认颜色
//    //      ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);
//
//          //是图标序列的顺序
//    //      Result:=AMaterial.FSeriesColorList[Self.FSeries.GetSameChartTypeIndex];
//          Result:=AMaterial.FSeriesGradientColor1List[ADataItem.Index mod AMaterial.FSeriesGradientColor1List.Count];
//    end;
//  end;
//
//end;
//
//function TVirtualChartSeriesBarDrawer.GetDataItemColor(ADataItem: TVirtualChartSeriesDataItem): TDelphiColor;
//var
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
//begin
//  if ADataItem.Color=0 then
//  begin
//    //默认颜色
//    ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);
//    Result:=ASkinVirtualChartDefaultMaterial.BarColorParam.FillColor.Color;
//  end
//  else
//  begin
//    //
//    Result:=ADataItem.Color;
//  end;
//end;

{ TVirtualChartSeriesDataItem }

procedure TVirtualChartSeriesDataItem.AssignTo(Dest: TPersistent);
var
  DestObject:TVirtualChartSeriesDataItem;
begin
  if Dest is TVirtualChartSeriesDataItem then
  begin

    DestObject:=Dest as TVirtualChartSeriesDataItem;

    DestObject.FValue:=Self.FValue;

    //inherited里面已经有了DestObject.DoPropChange;
    inherited;

  end
  else
  begin
    inherited;
  end;

end;

constructor TVirtualChartSeriesDataItem.Create(ACollection:TCollection);
begin
  Inherited Create(ACollection);
  FDrawPathActions:=TPathActionCollection.Create(TPathActionItem,nil,GlobalDrawPathDataClass);

end;
//
//procedure TVirtualChartSeriesDataItem.DestroyPolygonRegions(
//  APolygonRegions: array of HRGN);
//var
//  i: Integer;
//begin
//  // 释放所有多边形区域的句柄数组
//  {$IFDEF MSWINDOWS}
//  for i := 0 to High(APolygonRegions) do
//  begin
//    if APolygonRegions[i] <> 0 then
//      DeleteObject(APolygonRegions[i]);
//  end;
//  {$ENDIF}
//end;

destructor TVirtualChartSeriesDataItem.Destroy;
begin
  FreeAndNil(FDrawPathActions);
  FreeAndNil(FDrawData);

//  // 释放地图多边形数组
//  DestroyPolygonRegions(FPolygonRegions);

  inherited;
end;

//procedure TVirtualChartSeriesDataItem.DoAnimate(ASkinAnimator: TSkinAnimator);
//begin
//
//end;
//
//procedure TVirtualChartSeriesDataItem.DoAnimateBegin(
//  ASkinAnimator: TSkinAnimator);
//begin
//
//end;
//
//procedure TVirtualChartSeriesDataItem.DoAnimateEnd(
//  ASkinAnimator: TSkinAnimator);
//begin
//
//end;

function TVirtualChartSeriesDataItem.GetDest: Double;
begin
  Result:=FValue;
end;

function TVirtualChartSeriesDataItem.GetFrom: Double;
begin
  Result:=FOldValue;
end;

function TVirtualChartSeriesDataItem.LoadFromDocNode(
  ADocNode: TBTNode20_Class): Boolean;
var
  I: Integer;
  ABTNode:TBTNode20;
begin
  Result:=False;

  Inherited LoadFromDocNode(ADocNode);

  for I := 0 to ADocNode.ChildNodes.Count - 1 do
  begin
    ABTNode:=ADocNode.ChildNodes[I];

    if ABTNode.NodeName='Value' then
    begin
//      FValue:=ABTNode.ConvertNode_Real64.Data;
//      FDisplayValue:=ABTNode.ConvertNode_Real64.Data;//因为有动画
      //或者 因为有动画
      Value:=ABTNode.ConvertNode_Real64.Data;
    end
    ;

  end;

  Result:=True;


end;

procedure TVirtualChartSeriesDataItem.LoadFromJson(AJson: ISuperObject);
begin
  inherited;
  FValue:=AJson.F['Value'];
end;

function TVirtualChartSeriesDataItem.PtInItem(APoint: TPointF): Boolean;
//var
//  APieDrawer:TVirtualChartSeriesPieDrawer;
begin

  Result:=False;


  //还没生成
  //if TVirtualChartSeriesDataItems(Self.Owner).FSeries.FDrawer=nil then
  if (Self.Owner=nil) or (TVirtualChartSeriesDataItems(Self.Owner).FSeries.FDrawer=nil) then
  begin
    Exit;
  end;

//  {$IFDEF VCL}
//  if (TVirtualChartSeriesDataItems(Self.Owner).FSeries.FChartType=sctPie)
//    or (TVirtualChartSeriesDataItems(Self.Owner).FSeries.FChartType=sctLine) then
//  begin
//    //饼图是扇形,需要用到GDI+的Region
//    Result:=Self.FDrawPathActions.FDrawPathData.IsInRegion(APoint);
//  end
//  else
//  begin
//    //有时候是矩形内的柱子里移上去就要有效果
//    Result:=PtInRect(FBarDrawRect,APoint);
//
//
//    //有时候是在整个矩形内就要有鼠标停靠效果
//  //  Result:=PtInRect(FItemDrawRect,APoint);
//  end;
//
//  {$ENDIF}
//  {$IFDEF FMX}

  //有时候是在整个矩形内就要有鼠标停靠效果
  Result:=TVirtualChartSeriesDataItems(Self.Owner).FSeries.FDrawer.PtInItem(Self,APoint);


//  //if (TVirtualChartSeriesDataItems(Self.Owner).FSeries.FChartType=sctPie) then
//  if (TVirtualChartSeriesDataItems(Self.Collection).FSeries.FChartType=sctPie) then
//  begin
//    //饼图是扇形,需要判断鼠标是否在扇形中
//    //Result:=Self.FDrawPathActions.FDrawPathData.IsInRegion(APoint);
//    //APieDrawer:=TVirtualChartSeriesPieDrawer(TVirtualChartSeriesDataItems(Self.Owner).FSeries.FDrawer);
//    APieDrawer:=TVirtualChartSeriesPieDrawer(TVirtualChartSeriesDataItems(Self.Collection).FSeries.FDrawer);
//    //判断鼠标是否在外扇形中
//    Result:=PtInPie(APieDrawer.FCircleCenterPoint,APoint,Self,APieDrawer.FRadius,Self.FPieStartAngle+90,Self.FPieSweepAngle);
//    if APieDrawer.FInnerRadius>0 then
//    begin
//      //判断鼠标是否在空心圆的内扇形中
//      if PtInPie(APieDrawer.FCircleCenterPoint,APoint,Self,APieDrawer.FInnerRadius,Self.FPieStartAngle+90,Self.FPieSweepAngle) then
//      begin
//        Result:=False;
//      end;
//    end;
//
//  end
//  //else if (TVirtualChartSeriesDataItems(Self.Owner).FSeries.FChartType=sctLine) then
//  else if (TVirtualChartSeriesDataItems(Self.Collection).FSeries.FChartType=sctLine)
//      or (TVirtualChartSeriesDataItems(Self.Collection).FSeries.FChartType=sctBezierLine) then
//  begin
//    //线状图,只需要判断鼠标是否在那个圆点上即可
//    Result:=PtInRectF(Self.FLineDotRect,APoint);
//  end
//  else
//  begin
//    //有时候是矩形内的柱子里移上去就要有效果
//    Result:=PtInRectF(FBarDrawRect,APoint);
//
//
//    //有时候是在整个矩形内就要有鼠标停靠效果
//  //  Result:=PtInRect(FItemDrawRect,APoint);
//  end;

//  {$ENDIF}


end;

function TVirtualChartSeriesDataItem.SaveToDocNode(
  ADocNode: TBTNode20_Class): Boolean;
var
  ABTNode:TBTNode20;
begin
  Result:=False;

  Inherited SaveToDocNode(ADocNode);

  ABTNode:=ADocNode.AddChildNode_Real64('Value');
  ABTNode.ConvertNode_Real64.Data:=FValue;

  Result:=True;


end;

procedure TVirtualChartSeriesDataItem.SaveToJson(AJson: ISuperObject);
begin
  inherited;
  AJson.F['Value']:=FValue;

end;

procedure TVirtualChartSeriesDataItem.SetCurrent(Value: Double);
begin
  FDisplayValue:=Value;
end;

procedure TVirtualChartSeriesDataItem.SetValue(const AValue: Double);
begin
  if FValue<>AValue then
  begin

    FOldValue:=FValue;
    FDisplayValue:=AValue;

    FValue := AValue;

    FIsValueChanged_ForAnimate:=True;
    FIsValueChanged_ForUpdate:=True;

//    //判断是否需要启用动画
//
//    //开启动画,让FValue变成FNewValue
//    if (Owner<>nil)//从dfm加载的时候它为空
//      and (TVirtualChartSeriesDataItems(Self.Owner).FSeries<>nil)
//       and (TVirtualChartSeriesList(TVirtualChartSeriesDataItems(Self.Owner).FSeries.Collection)<>nil)
//      then
//    begin
//      TVirtualChartSeriesList(TVirtualChartSeriesDataItems(Self.Owner).FSeries.Collection).FSkinVirtualChartIntf.Properties.FValueChangeEffectAnimator.AddEffect(Self);
//    end
//    else
//    begin
//      FDisplayValue:=AValue;
//    end;

    Self.DoPropChange();
  end;
end;

{ TSkinVirtualChartDefaultMaterial }

constructor TSkinVirtualChartDefaultMaterial.Create(AOwner: TComponent);
begin
  inherited;

  FDrawAxisClientBackColorParam:=CreateDrawRectParam('DrawAxisClientBackColorParam','客户区背景绘制参数');
  FDrawAxisClientBackColorParam.StaticIsFill:=False;


  FBarColorParam:=CreateDrawRectParam('BarColorParam','柱子的路径绘制参数');
  FBarColorParam.FillColor.FColor:={$IFDEF VCL}$00F79087{$ENDIF}{$IFDEF FMX}$FF8790F7{$ENDIF};//BlueColor;
  FBarColorParam.FIsFill:=True;
//  FBarColorParam.FillColor.Color:=BlueColor;
  FBarColorParam.IsControlParam:=False;






  //鼠标移上去渐变
//  Self.BarColorParam.DrawEffectSetting.MouseOverEffect.CommonEffectTypes:=[dpcetAlphaChange];
//  Self.BarColorParam.DrawEffectSetting.MouseOverEffect.Alpha:=230;
  Self.BarColorParam.DrawEffectSetting.MouseOverEffect.FEffectTypes:=[drpetFillColorChange];
//  Self.BarColorParam.DrawEffectSetting.MouseOverEffect.FillColor.Color:=RedColor;
//  Self.BarColorParam.DrawEffectSetting.MouseOverEffect.FillColorChangeType:=TColorChangeType.cctBrightness;
  Self.BarColorParam.DrawEffectSetting.MouseOverEffect.FillColorChangeType:=TColorChangeType.cctDarkness;
//  Self.BarColorParam.DrawEffectSetting.MouseOverEffect.IsFill:=True;
//  Self.BarColorParam.IsFill:=True;


  FBarOutRectParam:=CreateDrawRectParam('BarOutRectParam','柱子的外部路径绘制参数');
//  FBarOutRectParam.FillColor.Color:=BlueColor;
  FBarOutRectParam.IsControlParam:=False;





  FMapColorParam:=CreateDrawPathParam('MapColorParam','地图的路径绘制参数');
  FMapColorParam.FillColor.FColor:={$IFDEF VCL}$00F79087{$ENDIF}{$IFDEF FMX}$FF8790F7{$ENDIF};//BlueColor;
//  FMapColorParam.FillColor.Color:=BlueColor;
  FMapColorParam.IsControlParam:=False;
  //鼠标移上去渐变
//  Self.FMapColorParam.DrawEffectSetting.MouseOverEffect.CommonEffectTypes:=[dpcetAlphaChange];
//  Self.FMapColorParam.DrawEffectSetting.MouseOverEffect.Alpha:=230;
  Self.FMapColorParam.DrawEffectSetting.MouseOverEffect.FEffectTypes:=[dppetFillColorChange];
//  Self.FMapColorParam.DrawEffectSetting.MouseOverEffect.FillColor.Color:=RedColor;
//  Self.FMapColorParam.DrawEffectSetting.MouseOverEffect.FillColorChangeType:=TColorChangeType.cctBrightness;
  Self.FMapColorParam.DrawEffectSetting.MouseOverEffect.FillColorChangeType:=TColorChangeType.cctDarkness;
//  Self.FMapColorParam.DrawEffectSetting.MouseOverEffect.IsFill:=True;
//  Self.FMapColorParam.IsFill:=True;



//  FMapHasValueColorParam:=CreateDrawPathParam('MapHasValueColorParam','地图的路径绘制参数');
//  FMapHasValueColorParam.FillColor.FColor:={$IFDEF VCL}$00F79087{$ENDIF}{$IFDEF FMX}$FF8790F7{$ENDIF};//BlueColor;
////  FMapHasValueColorParam.FillColor.Color:=BlueColor;
//  FMapHasValueColorParam.IsControlParam:=False;
//  //鼠标移上去渐变
////  Self.FMapHasValueColorParam.DrawEffectSetting.MouseOverEffect.CommonEffectTypes:=[dpcetAlphaChange];
////  Self.FMapHasValueColorParam.DrawEffectSetting.MouseOverEffect.Alpha:=230;
//  Self.FMapHasValueColorParam.DrawEffectSetting.MouseOverEffect.FEffectTypes:=[dppetFillColorChange];
////  Self.FMapHasValueColorParam.DrawEffectSetting.MouseOverEffect.FillColor.Color:=RedColor;
////  Self.FMapHasValueColorParam.DrawEffectSetting.MouseOverEffect.FillColorChangeType:=TColorChangeType.cctBrightness;
//  Self.FMapHasValueColorParam.DrawEffectSetting.MouseOverEffect.FillColorChangeType:=TColorChangeType.cctDarkness;
////  Self.FMapHasValueColorParam.DrawEffectSetting.MouseOverEffect.IsFill:=True;
////  Self.FMapHasValueColorParam.IsFill:=True;





  FPieColorParam:=CreateDrawPathParam('PieColorParam','饼的路径绘制参数');
  FPieColorParam.FillColor.FColor:={$IFDEF VCL}$00F79087{$ENDIF}{$IFDEF FMX}$FF8790F7{$ENDIF};//BlueColor;
//  FPieColorParam.FillColor.Color:=BlueColor;
  FPieColorParam.IsControlParam:=False;

  //鼠标移上去渐变
//  Self.FPieColorParam.DrawEffectSetting.MouseOverEffect.CommonEffectTypes:=[];

//  //鼠标移上去变大一点
//  Self.FPieColorParam.DrawEffectSetting.MouseOverEffect.SizeChange:=5;
//  Self.FPieColorParam.DrawEffectSetting.MouseOverEffect.EffectTypes:=[dppetFillColorChange,dpcetPathRectSizeChange];
  Self.FPieColorParam.DrawEffectSetting.MouseOverEffect.FEffectTypes:=[dppetFillColorChange];


//  Self.FPieColorParam.DrawEffectSetting.MouseOverEffect.FillColor.Color:=RedColor;
//  Self.FPieColorParam.DrawEffectSetting.MouseOverEffect.FillColorChangeType:=TColorChangeType.cctBrightness;
  Self.FPieColorParam.DrawEffectSetting.MouseOverEffect.FillColorChangeType:=TColorChangeType.cctDarkness;
//  Self.FPieColorParam.DrawEffectSetting.MouseOverEffect.IsFill:=True;
//  Self.FPieColorParam.IsFill:=True;



  FBarSizePercent:=0.7;//当一个序列的时候百分比小一点
  //当多个序列的时候，百分比要大一些


  FDrawAxisLineParam:=CreateDrawLineParam('DrawAxisLineParam','坐标线的线条绘制参数');
  FDrawAxisLineParam.IsControlParam:=False;
  FDrawAxisLineParam.Color.FColor:=GrayColor;

  FDrawAxisCaptionParam:=CreateDrawTextParam('DrawAxisCaptionParam','坐标刻度标题的文本绘制参数');
  FDrawAxisCaptionParam.IsControlParam:=False;
  FDrawAxisCaptionParam.DrawFont.FontColor.FColor:=GrayColor;

  FDrawValueParam:=CreateDrawTextParam('DrawValueParam','值的文本绘制参数');
  FDrawValueParam.IsControlParam:=False;


  FDrawCaptionParam:=CreateDrawTextParam('DrawCaptionParam','标题的文本绘制参数');



  FPieRadiusPercent:=0.7;
  FPieInnerSizePercent:=0.4;


  FSeriesColorList:=TDrawColorList.Create;
  FSeriesColorList.Add(TDrawColor.Create());
  FSeriesColorList.Add(TDrawColor.Create());
  FSeriesColorList.Add(TDrawColor.Create());
  FSeriesColorList.Add(TDrawColor.Create());
  FSeriesColorList.Add(TDrawColor.Create());
  FSeriesColorList.Add(TDrawColor.Create());
  FSeriesColorList.Add(TDrawColor.Create());
  FSeriesColorList.Add(TDrawColor.Create());
  FSeriesColorList.Add(TDrawColor.Create());

  
  FSeriesColorList[0].Color:={$IFDEF VCL}$D97B5C{$ENDIF}{$IFDEF FMX}$FF5C7BD9{$ENDIF};
  FSeriesColorList[1].Color:={$IFDEF VCL}$80E09F{$ENDIF}{$IFDEF FMX}$FF9FE080{$ENDIF};
  FSeriesColorList[2].Color:={$IFDEF VCL}$60DCFF{$ENDIF}{$IFDEF FMX}$FFFFDC60{$ENDIF};
  FSeriesColorList[3].Color:={$IFDEF VCL}$7070FF{$ENDIF}{$IFDEF FMX}$FFFF7070{$ENDIF};
  FSeriesColorList[4].Color:={$IFDEF VCL}$F4D37E{$ENDIF}{$IFDEF FMX}$FF7ED3F4{$ENDIF};
  FSeriesColorList[5].Color:={$IFDEF VCL}$7DB240{$ENDIF}{$IFDEF FMX}$FF40B27D{$ENDIF};
  FSeriesColorList[6].Color:={$IFDEF VCL}$5A91FF{$ENDIF}{$IFDEF FMX}$FFFF915A{$ENDIF};
  FSeriesColorList[7].Color:={$IFDEF VCL}$C669A9{$ENDIF}{$IFDEF FMX}$FFA969C6{$ENDIF};
  FSeriesColorList[8].Color:={$IFDEF VCL}$E088FF{$ENDIF}{$IFDEF FMX}$FFFF88E0{$ENDIF};



  FSeriesGradientColor1List:=TDrawColorList.Create;
  FSeriesGradientColor1List.Add(TDrawColor.Create());
  FSeriesGradientColor1List.Add(TDrawColor.Create());
  FSeriesGradientColor1List.Add(TDrawColor.Create());
  FSeriesGradientColor1List.Add(TDrawColor.Create());
  FSeriesGradientColor1List.Add(TDrawColor.Create());
  FSeriesGradientColor1List.Add(TDrawColor.Create());
  FSeriesGradientColor1List.Add(TDrawColor.Create());
  FSeriesGradientColor1List.Add(TDrawColor.Create());
  FSeriesGradientColor1List.Add(TDrawColor.Create());


  FSeriesGradientColor1List[0].Color:={$IFDEF VCL}$D97B5C{$ENDIF}{$IFDEF FMX}$FF5C7BD9{$ENDIF};
  FSeriesGradientColor1List[1].Color:={$IFDEF VCL}$80E09F{$ENDIF}{$IFDEF FMX}$FF9FE080{$ENDIF};
  FSeriesGradientColor1List[2].Color:={$IFDEF VCL}$60DCFF{$ENDIF}{$IFDEF FMX}$FFFFDC60{$ENDIF};
  FSeriesGradientColor1List[3].Color:={$IFDEF VCL}$7070FF{$ENDIF}{$IFDEF FMX}$FFFF7070{$ENDIF};
  FSeriesGradientColor1List[4].Color:={$IFDEF VCL}$F4D37E{$ENDIF}{$IFDEF FMX}$FF7ED3F4{$ENDIF};
  FSeriesGradientColor1List[5].Color:={$IFDEF VCL}$7DB240{$ENDIF}{$IFDEF FMX}$FF40B27D{$ENDIF};
  FSeriesGradientColor1List[6].Color:={$IFDEF VCL}$5A91FF{$ENDIF}{$IFDEF FMX}$FFFF915A{$ENDIF};
  FSeriesGradientColor1List[7].Color:={$IFDEF VCL}$C669A9{$ENDIF}{$IFDEF FMX}$FFA969C6{$ENDIF};
  FSeriesGradientColor1List[8].Color:={$IFDEF VCL}$E088FF{$ENDIF}{$IFDEF FMX}$FFFF88E0{$ENDIF};


  FPieInfoVisible:=True;


  FPieInfoCaptionParam:=CreateDrawTextParam('PieInfoCaptionParam','饼图信息标题的文本绘制参数');
  FPieInfoCaptionParam.IsControlParam:=False;

  FLegendItemCaptionParam:=CreateDrawTextParam('LegendItemCaptionParam','信息标题的文本绘制参数');
  FLegendItemCaptionParam.IsControlParam:=False;


  FSeriesItemCaptionParam:=CreateDrawTextParam('SeriesItemCaptionParam','信息标题的文本绘制参数');
  FSeriesItemCaptionParam.IsControlParam:=False;



  FLineColorParam:=CreateDrawLineParam('LineColorParam','线状的线条绘制参数');
  FLineColorParam.IsControlParam:=False;
  FLineColorParam.PenDrawColor.FColor:={$IFDEF VCL}$00F79087{$ENDIF}{$IFDEF FMX}$FF8790F7{$ENDIF};//BlueColor;
  FLineColorParam.PenWidth:=2;



  FLineDotParam:=CreateDrawPathParam('LineDotParam','线点的路径绘制参数');
  FLineDotParam.IsControlParam:=False;
  FLineDotParam.PenDrawColor.FColor:={$IFDEF VCL}$00F79087{$ENDIF}{$IFDEF FMX}$FF8790F7{$ENDIF};//BlueColor;
  FLineDotParam.PenWidth:=2;
  FLineDotParam.FillColor.FColor:=WhiteColor;
  Self.FLineDotParam.DrawEffectSetting.MouseOverEffect.FEffectTypes:=[dpcetPathRectSizeChange];
  //鼠标移上去变大一点
  Self.FLineDotParam.DrawEffectSetting.MouseOverEffect.FSizeChange:=3;
  //折线图的填充渐变色
  FLineDotParam.FillGradientColor1.FColor:=NullColor;
  FLineDotParam.FillGradientColor1.FAlpha:=0;

  FLineDotRadius:=5;



  FMarginsLeft:=10;
  FMarginsTop:=10;
  FMarginsRight:=10;
  FMarginsBottom:=10;

  FYAxisCaptionWidth:=32;
  FXAxisCaptionHeight:=24;


  FIsDrawXAxisLine:=True;
  FIsDrawRowLine:=True;
  FIsDrawColFirstLine:=True;
  FIsDrawRowFirstLine:=True;

  FPieInfoExtendHorzLineLength:=20;
  FPieInfoExtendLineLength:=20;



  FMapCenterPointColorParam:=CreateDrawRectParam('MapCenterPointColorParam','地图中心点');
  FMapCenterPointColorParam.FillColor.FColor:=WhiteColor;
  FMapCenterPointColorParam.FIsRound:=True;
  FMapCenterPointColorParam.FRoundWidth:=-1;
  FMapCenterPointColorParam.FRoundHeight:=-1;
  FMapCenterPointColorParam.FIsFill:=True;
//  FMapCenterPointColorParam.FillColor.Color:=BlueColor;
  FMapCenterPointColorParam.IsControlParam:=False;


end;

destructor TSkinVirtualChartDefaultMaterial.Destroy;
begin

  FreeAndNil(FSeriesGradientColor1List);
  FreeAndNil(FSeriesColorList);

  FreeAndNil(FBarColorParam);
  FreeAndNil(FBarOutRectParam);
  FreeAndNil(FMapColorParam);
//  FreeAndNil(FMapHasValueColorParam);
  FreeAndNil(FPieColorParam);
  FreeAndNil(FDrawAxisLineParam);
  FreeAndNil(FDrawAxisCaptionParam);
  FreeAndNil(FLineColorParam);
  FreeAndNil(FLineDotParam);
  FreeAndNil(FPieInfoCaptionParam);
  FreeAndNil(FDrawAxisClientBackColorParam);

  FreeAndNil(FDrawValueParam);

  FreeAndNil(FLegendItemCaptionParam);
  FreeAndNil(FSeriesItemCaptionParam);

  FreeAndNil(FMapCenterPointColorParam);


  FreeAndNil(FDrawCaptionParam);

  inherited;
end;

procedure TSkinVirtualChartDefaultMaterial.SetBarSizePercent(const Value: Double);
begin
  if FBarSizePercent<>Value then
  begin
    FBarSizePercent := Value;
    DoChange;
  end;
end;

procedure TSkinVirtualChartDefaultMaterial.SetBarsStackType(
  const Value: TBarsStackType);
begin
  if FBarsStackType<>Value then
  begin
    FBarsStackType := Value;
    DoChange;
  end;
end;

procedure TSkinVirtualChartDefaultMaterial.SetDrawAxisCaptionParam(
  const Value: TDrawTextParam);
begin
  FDrawAxisCaptionParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetDrawAxisClientBackColorParam(
  const Value: TDrawRectParam);
begin
  FDrawAxisClientBackColorParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetPieInfoCaptionParam(
  const Value: TDrawTextParam);
begin
  FPieInfoCaptionParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetPieInfoVisible(
  const Value: Boolean);
begin
  if FPieInfoVisible<>Value then
  begin
    FPieInfoVisible := Value;
    DoChange;
  end;
end;

procedure TSkinVirtualChartDefaultMaterial.SetPieInnerRadiusPercent(
  const Value: Double);
begin
  if FPieInnerSizePercent<>Value then
  begin
    FPieInnerSizePercent := Value;
    DoChange;
  end;
end;

procedure TSkinVirtualChartDefaultMaterial.SetLegendItemCaptionParam(
  const Value: TDrawTextParam);
begin
  FLegendItemCaptionParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetSeriesItemCaptionParam(
  const Value: TDrawTextParam);
begin
  FSeriesItemCaptionParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetLineColorParam(
  const Value: TDrawLineParam);
begin
  FLineColorParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetLineDotParam(
  const Value: TDrawPathParam);
begin
  FLineDotParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetDrawAxisLineParam(
  const Value: TDrawLineParam);
begin
  FDrawAxisLineParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetDrawCaptionParam(
  const Value: TDrawTextParam);
begin
  FDrawCaptionParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetDrawValueParam(
  const Value: TDrawTextParam);
begin
  FDrawValueParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetMapCenterPointColorParam(const Value: TDrawRectParam);
begin
  FMapCenterPointColorParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetMapColorParam(
  const Value: TDrawPathParam);
begin
  FMapColorParam.Assign(Value);
end;

//procedure TSkinVirtualChartDefaultMaterial.SetMapHasValueColorParam(
//  const Value: TDrawPathParam);
//begin
//  FMapHasValueColorParam.Assign(Value);
//end;

procedure TSkinVirtualChartDefaultMaterial.SetBarColorParam(
  const Value: TDrawRectParam);
begin
  FBarColorParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetBarOutRectParam(
  const Value: TDrawRectParam);
begin
  FBarOutRectParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetPieColorParam(
  const Value: TDrawPathParam);
begin
  FPieColorParam.Assign(Value);
end;

procedure TSkinVirtualChartDefaultMaterial.SetPieRadiusPercent(
  const Value: Double);
begin
  if FPieRadiusPercent<>Value then
  begin
    FPieRadiusPercent := Value;
    DoChange;
  end;
end;

//procedure TSkinVirtualChartDefaultMaterial.SetLegendListViewVisible(
//  const Value: Boolean);
//begin
//  if FLegendListViewVisible<>Value then
//  begin
//    FLegendListViewVisible := Value;
//    DoChange;
//  end;
//end;

{ TVirtualChartSeriesPieDrawer }

function ExPandLine(pt1:TPointF; pt2:TPointF; nLen:Double;var OutPt:TPointF):Boolean;
var
  k,b,zoom:Double;
begin
	if (pt1.x - pt2.x = 0) then
	begin
		OutPt.x := pt1.x;
		if (pt1.y - pt2.y > 0) then
		begin
			OutPt.y := pt2.y - nLen;
		end
		else
		begin
			OutPt.y := pt2.y + nLen;
		end;
	end
	else if (pt1.y - pt2.y = 0) then
	begin
		OutPt.y := pt1.y;
		if (pt1.x - pt2.x > 0) then
		begin
			OutPt.x := pt2.x - nLen;
		end
		else
		begin
			OutPt.x := pt2.x + nLen;
		end;
	end
	else
	begin
	  k := 0.0;
	  b := 0.0;
		k := (pt1.y - pt2.y)/(pt1.x-pt2.x);
		b := pt1.y - k * pt1.x;
	  zoom := 0.0;
		zoom := nLen/sqrt((pt2.x-pt1.x)*(pt2.x-pt1.x)+(pt2.y-pt1.y)*(pt2.y-pt1.y));

		if (k > 0) then
		begin
			if (pt1.x-pt2.x > 0) then
			begin
				OutPt.x := pt2.x - zoom * (pt1.x-pt2.x);
				OutPt.y := k*OutPt.x + b;
			end
			else
			begin
				OutPt.x := pt2.x + zoom * (pt2.x-pt1.x);
				OutPt.y := k*OutPt.x + b;
			end;
		end
		else
		begin
			if (pt1.x-pt2.x > 0) then
			begin
				OutPt.x := pt2.x - zoom * (pt1.x-pt2.x) ;
				OutPt.y := k*OutPt.x + b;
			end
			else
			begin
				OutPt.x := pt2.x + zoom * (pt2.x - pt1.x);
				OutPt.y := k*OutPt.x + b;
			end
		end
	end;
	Result:=True;
end;



class function TVirtualChartSeriesPieDrawer.ChartType: TSkinChartType;
begin
  Result:=sctPie;
end;

//function TVirtualChartSeriesPieDrawer.CustomPaint(ACanvas: TDrawCanvas;
//  ASkinMaterial: TSkinControlMaterial; const ADrawRect: TRectF;
//  APaintData: TPaintData; const APathDrawRect: TRectF): Boolean;
//var
//  I: Integer;
//var
////  ADrawRect:TRectF;
//  X:Double;
//  Y:Double;
//  AXAxisSkinListBox:TSkinListBox;
//  AYAxisSkinListBox:TSkinListBox;
//  ASkinVirtualChartIntf:ISkinVirtualChart;
////  ACaptionRect:TRectF;
////  AItemWidth:Double;
//var
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
////var
////  I:Integer;
//var
//  ADataItem:TVirtualChartSeriesDataItem;
//  AItemEffectStates:TDPEffectStates;
//  ADataItemColor:TDelphiColor;
//  AOldColor:TDelphiColor;
//  AItemCaptionWidth:Double;
//  ALastItemCaptionDrawLeft:Double;
//  ALastItemCaptionDrawRect:TRectF;
////  AItemPaintData:TPaintData;
////var
////  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
//begin
//
//  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);
//  ASkinVirtualChartIntf:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf;
//
////  AXAxisSkinListBox:=ASkinVirtualChartIntf.Properties.FXAxisSkinListBox;
////  AYAxisSkinListBox:=ASkinVirtualChartIntf.Properties.FYAxisSkinListBox;
//
//
//
//
////  //绘制Y轴的背景线
////
//////  ADrawLineParam:=TDrawLineParam.Create('','');
////  Y:=APathDrawRect.Top;
////  for I := 0 to AYAxisSkinListBox.Prop.Items.Count-1 do
////  begin
////    //画行线
////    ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,APathDrawRect.Left,Y,APathDrawRect.Right,Y);
////    //绘制左边的刻度值,垂直居中,水平右对齐
////    ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontHorzAlign:=fhaRight;
////    ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontVertAlign:=fvaCenter;
////    //右边要空出一点
////    ACaptionRect:=RectF(0,Y-20,APathDrawRect.Left-5,Y+20);
////    ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam,AYAxisSkinListBox.Prop.Items[I].Caption,ACaptionRect);
////
//////    Y:=Y+AYAxisSkinListBox.Prop.ListLayoutsManager.CalcItemHeight(AYAxisSkinListBox.Prop.Items[I]);
////    Y:=Y+APathDrawRect.Height / (AYAxisSkinListBox.Prop.Items.Count-1);
////  end;
////
//////  FreeAndNil(ADrawLineParam);
//
//
//
//
//
////
////  //画X轴的刻度线
////  X:=APathDrawRect.Top;
////  AItemWidth:=APathDrawRect.Width / (AXAxisSkinListBox.Prop.Items.Count);
////  ALastItemCaptionDrawLeft:=0;
////  for I := 0 to AXAxisSkinListBox.Prop.Items.Count-1 do
////  begin
////
////
////    //画刻度线
////    //目前这个模式,刻度线画在DataItem的中心点
////    ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
////                      X+AItemWidth/2,
////                      APathDrawRect.Bottom,
////                      X+AItemWidth/2,
////                      APathDrawRect.Bottom+5);
////
////
////
////    //绘制左边的刻度值,垂直居中,水平右对齐
////    ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontHorzAlign:=fhaCenter;
////    ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontVertAlign:=fvaTop;
////
////
////
////    //上边要空出一点
////    //绘制刻度标题
////    AItemCaptionWidth:=GetStringWidth(AXAxisSkinListBox.Prop.Items[I].Caption,ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.FontSize);
////
////    //绘制标题前需要判断能不能绘制的下,绘制不下则不绘制
////    if (X+AItemWidth/2-ALastItemCaptionDrawLeft)>AItemCaptionWidth/2 then
////    begin
////      ACaptionRect.Left:=X+(AItemWidth-AItemCaptionWidth)/2;
////      ACaptionRect.Top:=APathDrawRect.Bottom+5;
////      ACaptionRect.Right:=ACaptionRect.Left+AItemCaptionWidth;
////      ACaptionRect.Bottom:=APathDrawRect.Bottom+5+24;
////      ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam,AXAxisSkinListBox.Prop.Items[I].Caption,ACaptionRect);
////
////      ALastItemCaptionDrawLeft:=ACaptionRect.Right;
////
////    end;
////
//////    Y:=Y+AYAxisSkinListBox.Prop.ListLayoutsManager.CalcItemHeight(AYAxisSkinListBox.Prop.Items[I]);
////    X:=X+AItemWidth;
////
////
////  end;
//
//
//
//  Inherited;
//
//
//
//  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);
//  ALastItemCaptionDrawRect:=RectF(0,0,0,0);
//
//  //绘制柱子
//  for I := 0 to Self.FSeries.FDataItems.Count-1 do
//  begin
//    ADataItem:=Self.FSeries.FDataItems[I];
//
//
//    //给数据项加上状态
//    AItemEffectStates:=Self.FSeries.GetMouseEventListLayoutsManager.ProcessItemDrawEffectStates(ADataItem);
//    ASkinVirtualChartDefaultMaterial.FPieColorParam.StaticEffectStates:=AItemEffectStates;
//    AOldColor:=ASkinVirtualChartDefaultMaterial.FPieColorParam.FillColor.FColor;
//    ADataItemColor:=Self.GetDataItemColor(ADataItem);
//    ASkinVirtualChartDefaultMaterial.FPieColorParam.FillColor.FColor:=ADataItemColor;
//
//
//    //处理绘制参数的透明度
//    ASkinVirtualChartDefaultMaterial.FPieColorParam.DrawAlpha:=Ceil(ASkinVirtualChartDefaultMaterial.FPieColorParam.CurrentEffectAlpha*1);
//
////    AItemPaintData:=GlobalNullPaintData;
////    AItemPaintData.IsDrawInteractiveState:=True;
////    ProcessParamEffectStates(ASkinVirtualChartDefaultMaterial.FPieColorParam,
////                                1,
////                                AItemEffectStates,
////                                AItemPaintData
////                                );
//
//    ACanvas.DrawPath(ASkinVirtualChartDefaultMaterial.FPieColorParam,APathDrawRect,ADataItem.FDrawPathActions);
//
//
//    ASkinVirtualChartDefaultMaterial.FPieColorParam.FillColor.FColor:=AOldColor;
//
//
//    if (ASkinVirtualChartDefaultMaterial.PieInfoVisible) then
//    begin
//
//
////        if (ADataItem.FPieArcCenterAngle>=-90) and (ADataItem.FPieArcCenterAngle<90) then
////        begin
////          //标题在右边的,用标题矩形的左上角进行判断，是不是在上一个数据项的标题里
////          if PtInRect(ALastItemCaptionDrawRect,ADataItem.FCaptionRect.TopLeft) then
////          begin
////            Continue;
////          end;
////        end
////        else
////        begin
////          //标题在左边的,用标题矩形的右下角进行判断，是不是在上一个数据项的标题里
////          if PtInRect(ALastItemCaptionDrawRect,ADataItem.FCaptionRect.BottomRight) then
////          begin
////            Continue;
////          end;
////
////        end;
//        if IntersectRect(ALastItemCaptionDrawRect,TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FCaptionRect) then
//        begin
//          Continue;
//        end;
//        ALastItemCaptionDrawRect:=TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FCaptionRect;
//
//
//
//
//        //画上线条,标注出数据项标题
//        //画刻度线
//        //目前这个模式,刻度线画在DataItem的中心点
//        AOldColor:=ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam.PenDrawColor.FColor;
//        ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam.PenDrawColor.FColor:=ADataItemColor;
//        ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
//                          TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FPieArcCenterPoint.X,
//                          TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FPieArcCenterPoint.Y,
//                          TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FPieArcCenterExtendPoint.X,
//                          TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FPieArcCenterExtendPoint.Y);
//        //如果是-90~0~90度,那么横线向右延伸
//        //如果是90~180~-90度之间,那么横线向左延伸
//        ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
//                          TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FPieArcCenterExtendPoint.X,
//                          TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FPieArcCenterExtendPoint.Y,
//                          TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FPieArcCenterExtendHorzPoint.X,
//                          TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FPieArcCenterExtendHorzPoint.Y);
//
//        ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam.PenDrawColor.FColor:=AOldColor;
//
//
//        //画刻度标题
//
//        //上边要空出一点
//        //绘制刻度标题
//        //绘制标题前需要判断能不能绘制的下,绘制不下则不绘制
//        if (TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FPieArcCenterAngle>=-90) and (TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FPieArcCenterAngle<90) then
//        begin
//          //横线往右
//          //字体左对齐
//          ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontHorzAlign:=fhaLeft;
//        end
//        else
//        begin
//          //横线往左
//          //字体右对齐
//          ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontHorzAlign:=fhaRight;
//        end;
//        ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam,ADataItem.Caption,TVirtualChartSeriesPieDrawData(ADataItem.FDrawData).FCaptionRect);
//
//
//
//    end;
//
//
////    Exit;
//  end;
//
//
//  //画上说明
//
//
//end;
function TVirtualChartSeriesPieDrawer.CustomPaint(ACanvas: TDrawCanvas;
  ASkinMaterial: TSkinControlMaterial; const ADrawRect: TRectF;
  APaintData: TPaintData; const APathDrawRect: TRectF): Boolean;
var
  I: Integer;
var
//  ADrawRect:TRectF;
  X:Double;
  Y:Double;
  AXAxisSkinListBox:TSkinListBox;
  AYAxisSkinListBox:TSkinListBox;
  ASkinVirtualChartIntf:ISkinVirtualChart;
//  ACaptionRect:TRectF;
//  AItemWidth:Double;
var
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
  ADrawData:TVirtualChartSeriesPieDrawData;
//var
//  I:Integer;
var
  ADataItem:TVirtualChartSeriesDataItem;
  AItemEffectStates:TDPEffectStates;
  ADataItemColor:TDelphiColor;
  AOldColor:TDelphiColor;
  AItemCaptionWidth:Double;
  ALastItemCaptionDrawLeft:Double;
  ALastItemCaptionDrawRect:TRectF;
//  AItemPaintData:TPaintData;
//var
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin

  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);
  ASkinVirtualChartIntf:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf;

//  AXAxisSkinListBox:=ASkinVirtualChartIntf.Properties.FXAxisSkinListBox;
//  AYAxisSkinListBox:=ASkinVirtualChartIntf.Properties.FYAxisSkinListBox;




//  //绘制Y轴的背景线
//
////  ADrawLineParam:=TDrawLineParam.Create('','');
//  Y:=APathDrawRect.Top;
//  for I := 0 to AYAxisSkinListBox.Prop.Items.Count-1 do
//  begin
//    //画行线
//    ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,APathDrawRect.Left,Y,APathDrawRect.Right,Y);
//    //绘制左边的刻度值,垂直居中,水平右对齐
//    ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontHorzAlign:=fhaRight;
//    ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontVertAlign:=fvaCenter;
//    //右边要空出一点
//    ACaptionRect:=RectF(0,Y-20,APathDrawRect.Left-5,Y+20);
//    ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam,AYAxisSkinListBox.Prop.Items[I].Caption,ACaptionRect);
//
////    Y:=Y+AYAxisSkinListBox.Prop.ListLayoutsManager.CalcItemHeight(AYAxisSkinListBox.Prop.Items[I]);
//    Y:=Y+APathDrawRect.Height / (AYAxisSkinListBox.Prop.Items.Count-1);
//  end;
//
////  FreeAndNil(ADrawLineParam);





//
//  //画X轴的刻度线
//  X:=APathDrawRect.Top;
//  AItemWidth:=APathDrawRect.Width / (AXAxisSkinListBox.Prop.Items.Count);
//  ALastItemCaptionDrawLeft:=0;
//  for I := 0 to AXAxisSkinListBox.Prop.Items.Count-1 do
//  begin
//
//
//    //画刻度线
//    //目前这个模式,刻度线画在DataItem的中心点
//    ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
//                      X+AItemWidth/2,
//                      APathDrawRect.Bottom,
//                      X+AItemWidth/2,
//                      APathDrawRect.Bottom+5);
//
//
//
//    //绘制左边的刻度值,垂直居中,水平右对齐
//    ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontHorzAlign:=fhaCenter;
//    ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.StaticFontVertAlign:=fvaTop;
//
//
//
//    //上边要空出一点
//    //绘制刻度标题
//    AItemCaptionWidth:=GetStringWidth(AXAxisSkinListBox.Prop.Items[I].Caption,ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam.FontSize);
//
//    //绘制标题前需要判断能不能绘制的下,绘制不下则不绘制
//    if (X+AItemWidth/2-ALastItemCaptionDrawLeft)>AItemCaptionWidth/2 then
//    begin
//      ACaptionRect.Left:=X+(AItemWidth-AItemCaptionWidth)/2;
//      ACaptionRect.Top:=APathDrawRect.Bottom+5;
//      ACaptionRect.Right:=ACaptionRect.Left+AItemCaptionWidth;
//      ACaptionRect.Bottom:=APathDrawRect.Bottom+5+24;
//      ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FDrawAxisCaptionParam,AXAxisSkinListBox.Prop.Items[I].Caption,ACaptionRect);
//
//      ALastItemCaptionDrawLeft:=ACaptionRect.Right;
//
//    end;
//
////    Y:=Y+AYAxisSkinListBox.Prop.ListLayoutsManager.CalcItemHeight(AYAxisSkinListBox.Prop.Items[I]);
//    X:=X+AItemWidth;
//
//
//  end;



  Inherited;



  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);
  ALastItemCaptionDrawRect:=RectF(0,0,0,0);

  //绘制柱子
  for I := 0 to Self.FSeries.FDataItems.Count-1 do
  begin
    ADataItem:=Self.FSeries.FDataItems[I];
    ADrawData:=TVirtualChartSeriesPieDrawData(ADataItem.FDrawData);
    if ADrawData=nil then Break;


    //给数据项加上状态
    AItemEffectStates:=Self.FSeries.GetMouseEventListLayoutsManager.ProcessItemDrawEffectStates(ADataItem);
    ASkinVirtualChartDefaultMaterial.FPieColorParam.StaticEffectStates:=AItemEffectStates;
    AOldColor:=ASkinVirtualChartDefaultMaterial.FPieColorParam.FillColor.FColor;
    ADataItemColor:=Self.GetDataItemColor(ADataItem,ASkinVirtualChartDefaultMaterial).FColor;
    ASkinVirtualChartDefaultMaterial.FPieColorParam.FillColor.FColor:=ADataItemColor;


    //处理绘制参数的透明度
    ASkinVirtualChartDefaultMaterial.FPieColorParam.DrawAlpha:=Ceil(ASkinVirtualChartDefaultMaterial.FPieColorParam.CurrentEffectAlpha*1);

//    AItemPaintData:=GlobalNullPaintData;
//    AItemPaintData.IsDrawInteractiveState:=True;
//    ProcessParamEffectStates(ASkinVirtualChartDefaultMaterial.FPieColorParam,
//                                1,
//                                AItemEffectStates,
//                                AItemPaintData
//                                );

    ACanvas.DrawPath(ASkinVirtualChartDefaultMaterial.FPieColorParam,APathDrawRect,ADataItem.FDrawPathActions);


    ASkinVirtualChartDefaultMaterial.FPieColorParam.FillColor.FColor:=AOldColor;


    if (ASkinVirtualChartDefaultMaterial.PieInfoVisible) then
    begin


//        if (ADataItem.FPieArcCenterAngle>=-90) and (ADataItem.FPieArcCenterAngle<90) then
//        begin
//          //标题在右边的,用标题矩形的左上角进行判断，是不是在上一个数据项的标题里
//          if PtInRect(ALastItemCaptionDrawRect,ADataItem.FCaptionRect.TopLeft) then
//          begin
//            Continue;
//          end;
//        end
//        else
//        begin
//          //标题在左边的,用标题矩形的右下角进行判断，是不是在上一个数据项的标题里
//          if PtInRect(ALastItemCaptionDrawRect,ADataItem.FCaptionRect.BottomRight) then
//          begin
//            Continue;
//          end;
//
//        end;

          //注释掉了,如果有交集就不绘制,免的挡住   这里最好有个选择，看重叠多少面积吧
//        if IntersectRectF(ALastItemCaptionDrawRect,ADrawData.FCaptionRect) then
//        begin
//          Continue;
//        end;
        ALastItemCaptionDrawRect:=ADrawData.FCaptionRect;




        //画上线条,标注出数据项标题
        //画刻度线
        //目前这个模式,刻度线画在DataItem的中心点
        AOldColor:=ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam.PenDrawColor.FColor;
        ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam.PenDrawColor.FColor:=ADataItemColor;
        ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
                          ADrawData.FPieArcCenterPoint.X,
                          ADrawData.FPieArcCenterPoint.Y,
                          ADrawData.FPieArcCenterExtendPoint.X,
                          ADrawData.FPieArcCenterExtendPoint.Y);
        //如果是-90~0~90度,那么横线向右延伸
        //如果是90~180~-90度之间,那么横线向左延伸
        ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam,
                          ADrawData.FPieArcCenterExtendPoint.X,
                          ADrawData.FPieArcCenterExtendPoint.Y,
                          ADrawData.FPieArcCenterExtendHorzPoint.X,
                          ADrawData.FPieArcCenterExtendHorzPoint.Y);

        ASkinVirtualChartDefaultMaterial.FDrawAxisLineParam.PenDrawColor.FColor:=AOldColor;


        //画刻度标题

        //上边要空出一点
        //绘制刻度标题
        //绘制标题前需要判断能不能绘制的下,绘制不下则不绘制
        if (ADrawData.FPieArcCenterAngle>=-90) and (ADrawData.FPieArcCenterAngle<90) then
        begin
          //横线往右
          //字体左对齐
          ASkinVirtualChartDefaultMaterial.FPieInfoCaptionParam.StaticFontHorzAlign:=fhaLeft;
        end
        else
        begin
          //横线往左
          //字体右对齐
          ASkinVirtualChartDefaultMaterial.FPieInfoCaptionParam.StaticFontHorzAlign:=fhaRight;
        end;
        ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.FPieInfoCaptionParam,
                        ASkinVirtualChartIntf.Prop.GetPieInfoCaption(ADataItem,ASkinVirtualChartDefaultMaterial),ADrawData.FCaptionRect);



    end;


//    Exit;
  end;


  //画上说明


end;


procedure TVirtualChartSeriesPieDrawer.GenerateDrawPathList(APathDrawRect: TRectF);
var
  I: Integer;
//  ADataItemRect:TRectF;
//  ADataItemPathRect:TRectF;
  AVirtualChartSeriesList:TVirtualChartSeriesList;
  ALegendListView:TSkinVirtualList;
//  AItemWidth:Double;
  AStartAngle:Double;
  ADataItem:TVirtualChartSeriesDataItem;
//TVirtualChartSeriesPieDrawData(ADataItem.FDrawData)
  ADrawData:TVirtualChartSeriesPieDrawData;
  APathActionItem:TPathActionItem;
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
//  ABarSizePercent:Double;
  AMinValue,AMaxValue,ASumValue:Double;
  ARad:Double;
  ACos:Double;
  AItemCaptionWidth:Double;
  AItemCaptionHeight:Double;
  AOffset:Double;
  ASkinItem:TSkinItem;
  ASkinVirtualChartIntf:ISkinVirtualChart;
begin
  Inherited;



  AVirtualChartSeriesList:=TVirtualChartSeriesList(Self.FSeries.Collection);

  ALegendListView:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView;
  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);
  ASkinVirtualChartIntf:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf;


  if TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListViewVisible then
  begin
//      ALegendListView.Prop.ListLayoutsManager.SkinListIntf:=Self.FSeries.FDataItems;
//      ALegendListView.Prop.FItems:=Self.FSeries.FDataItems;
      //添加Item
      ALegendListView.Prop.Items.BeginUpdate;
      try
        ALegendListView.Prop.Items.Clear;
        for I := 0 to Self.FSeries.FDataItems.Count-1 do
        begin
          ASkinItem:=TSkinItem(ALegendListView.Prop.Items.Add);
          ASkinItem.Color:=GetDataItemColor(TVirtualChartSeriesDataItem(Self.FSeries.FDataItems[I]),
                      TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial)
                      ).Color;
          ASkinItem.Caption:=Self.FSeries.FDataItems[I].Caption;
        end;

      finally
        ALegendListView.Prop.Items.EndUpdate;
      end;

      ALegendListView.Visible:=True;
      TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendItemCaptionLabel.Material.DrawCaptionParam.Assign(ASkinVirtualChartDefaultMaterial.LegendItemCaptionParam);


//      //设置提示区的位置
//      //默认在最左边,从上到下排列
//      {$IFDEF VCL}
//      ALegendListView.Align:=alLeft;
//      {$ENDIF}
//      {$IFDEF FMX}
//      ALegendListView.Align:=TAlignLayout.Left;
//      {$ENDIF}

//      ALegendListView.Visible:=True;
//      if TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendItemDesignerPanel=nil then
//      begin
//        TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.CreateLegendItemDesignerPanel;
//      end;
//      if TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendItemStyle<>'' then
//      begin
//        ALegendListView.Prop.DefaultItemStyle:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendItemStyle;
//      end
//      else
//      begin
//        ALegendListView.Prop.ItemDesignerPanel:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendItemDesignerPanel;
//      end;
//      ALegendListView.Prop.ItemHeight:=26;
//      {$IFDEF VCL}
//      ALegendListView.AlignWithMargins:=True;
//      ALegendListView.Margins.SetBounds(10,10,0,10);
//      {$ENDIF}
//      {$IFDEF FMX}
//      ALegendListView.Margins.Left:=10;
//      ALegendListView.Margins.Top:=10;
//      ALegendListView.Margins.Right:=0;
//      ALegendListView.Margins.Bottom:=10;
//      {$ENDIF}
//      ALegendListView.OnPrepareDrawItem:=DoLegendListViewPrepareDrawItem;
      ALegendListView.OnMouseOverItemChange:=DoLegendListViewMouseOverItemChange;


      ALegendListView.Width:=Ceil(ALegendListView.Prop.CalcContentWidth);
      ALegendListView.Height:=Ceil(ALegendListView.Prop.CalcContentHeight);

      //默认放在左下角
      //放在左下角
      ALegendListView.Top:=TControl(ALegendListView.Parent).Height-ALegendListView.Height-10;

  end
  else
  begin
      ALegendListView.Visible:=False;
      ALegendListView.OnMouseOverItemChange:=nil;
      ALegendListView.OnPrepareDrawItem:=nil;
  end;


  FSeries.GetMinMaxValue(AMinValue,AMaxValue,ASumValue);


  //然后生成柱子
  //需要最大值,计算出百分比
  AStartAngle:=0;
  for I := 0 to Self.FSeries.FDataItems.Count-1 do
  begin
      ADataItem:=Self.FSeries.FDataItems[I];
      ADrawData:=TVirtualChartSeriesPieDrawData(ADataItem.FDrawData);
      if ADrawData=nil then Break;


      ADataItem.FDrawPercent:=0;
      if ASumValue>0 then
      begin
        ADataItem.FDrawPercent:=ADataItem.FDisplayValue/ASumValue;
      end;

//      //提示,不能直接这样赋值,不然DataItem的颜色被改过来了
//      ADataItem.Color:=Self.GetDataItemColor(ADataItem);


      //横排的
      //生成Path列表
      //AItemWidth:=AXAxisSkinListBox.Prop.CalcItemWidth(AXAxisSkinListBox.Prop.Items[I]);
      //AItemWidth:=APathDrawRect.Width / AXAxisSkinListBox.Prop.Items.Count;

//      //数据项所在的大矩形-相对坐标
//      ADataItemRect:=RectF(0,0,0,0);
//      ADataItemRect.Left:=ALeft;
//      ADataItemRect.Top:=0;
//      ADataItemRect.Right:=ALeft+AItemWidth;
//      ADataItemRect.Bottom:=APathDrawRect.Height;
//
//
//
//
//      //下一个Item的左边距
//      ALeft:=ALeft+AItemWidth;



      ADataItem.FDrawPathActions.Clear;


//      ADataItemPathRect.Left:=ADataItemRect.Left+AItemWidth*(1-ABarSizePercent)/2;
//      ADataItemPathRect.Top:=ADataItemRect.Top+APathDrawRect.Height*(1-ADataItem.FDrawPercent);
//      ADataItemPathRect.Right:=ADataItemPathRect.Left+AItemWidth*ABarSizePercent;
//      ADataItemPathRect.Bottom:=ADataItemRect.Bottom;

      if ASkinVirtualChartDefaultMaterial.FPieInnerSizePercent=0 then
      begin
          //没有内环
          //生成饼的Path
          APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
          //饼
          APathActionItem.ActionType:=patAddPie;
          APathActionItem.X:=0;
          APathActionItem.Y:=0;
          APathActionItem.X1:=APathDrawRect.Width;
          APathActionItem.Y1:=APathDrawRect.Height;

          APathActionItem.StartAngle:=AStartAngle-90;
          APathActionItem.SweepAngle:=ADataItem.FDrawPercent*360;
      end
      else
      begin
          //有内环
          //圆环
          //外环
          APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
          APathActionItem.ActionType:=patAddArc;
          APathActionItem.X:=0;
          APathActionItem.Y:=0;
          APathActionItem.X1:=APathDrawRect.Width;
          APathActionItem.Y1:=APathDrawRect.Height;

          APathActionItem.StartAngle:=AStartAngle-90;
          APathActionItem.SweepAngle:=ADataItem.FDrawPercent*360;
          //内环
          AOffset:=(APathDrawRect.Width-(APathDrawRect.Width/ASkinVirtualChartDefaultMaterial.FPieRadiusPercent)*ASkinVirtualChartDefaultMaterial.FPieInnerSizePercent)/2;
          APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
          APathActionItem.ActionType:=patAddArc;
          APathActionItem.X:=AOffset;
          APathActionItem.Y:=AOffset;
          APathActionItem.X1:=APathDrawRect.Width-AOffset;
          APathActionItem.Y1:=APathDrawRect.Height-AOffset;
          //要反方向画,不然填充不了扇形
          APathActionItem.StartAngle:=AStartAngle-90+ADataItem.FDrawPercent*360;
          APathActionItem.SweepAngle:=-ADataItem.FDrawPercent*360;
      end;

      ADrawData.FPieStartAngle:=AStartAngle-90;
      ADrawData.FPieSweepAngle:=ADataItem.FDrawPercent*360;



      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      APathActionItem.ActionType:=patClose;

      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      APathActionItem.ActionType:=patStop;


      //填充
      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      APathActionItem.ActionType:=patFillPath;

//      //获取区域,用于判断鼠标是否停靠
//      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
//      APathActionItem.ActionType:=patGetRegion;



        //圆弧中心点计算出来，这个位置要用来绘制数据标题
  //      ARad:=Math.DegToRad(AAngle);
  //      ARad:=Math.CycleToRad(AAngle);
  //      ARad:=Math.GradToRad(AAngle);
        ADrawData.FPieArcCenterAngle:=(AStartAngle-90+ADataItem.FDrawPercent*360/2);//中心点的坐标,所以角度要除以2
        ARad:=ADrawData.FPieArcCenterAngle*PI/180;

        //x都是弧度
        ACos:=Cos(ARad);
        ADrawData.FPieArcCenterPoint.X := FCircleCenterPoint.X + FRadius * ACos;
        ADrawData.FPieArcCenterPoint.Y := FCircleCenterPoint.Y + FRadius * Sin(ARad);


        //延伸线的点算出来
        ExPandLine(FCircleCenterPoint,ADrawData.FPieArcCenterPoint,ASkinVirtualChartDefaultMaterial.FPieInfoExtendLineLength,ADrawData.FPieArcCenterExtendPoint);

        AItemCaptionWidth:=GetStringWidth(ASkinVirtualChartIntf.Prop.GetPieInfoCaption(ADataItem,ASkinVirtualChartDefaultMaterial),ASkinVirtualChartDefaultMaterial.FPieInfoCaptionParam.FontSize);
        AItemCaptionHeight:=GetStringHeight(ASkinVirtualChartIntf.Prop.GetPieInfoCaption(ADataItem,ASkinVirtualChartDefaultMaterial),ASkinVirtualChartDefaultMaterial.FPieInfoCaptionParam.FontSize);

        //延伸线横出来的点算出来
        if (ADrawData.FPieArcCenterAngle>=-90) and (ADrawData.FPieArcCenterAngle<90) then
        begin
          //横线往右
          ADrawData.FPieArcCenterExtendHorzPoint:=ADrawData.FPieArcCenterExtendPoint;
          ADrawData.FPieArcCenterExtendHorzPoint.X:=ADrawData.FPieArcCenterExtendHorzPoint.X+ASkinVirtualChartDefaultMaterial.FPieInfoExtendHorzLineLength;

          ADrawData.FCaptionRect.Left:=ADrawData.FPieArcCenterExtendHorzPoint.X
                                        //标题前空出一点
                                        +5;
          ADrawData.FCaptionRect.Right:=ADrawData.FCaptionRect.Left
                                        +AItemCaptionWidth;
        end
        else
        begin
          //横线往左
          ADrawData.FPieArcCenterExtendHorzPoint:=ADrawData.FPieArcCenterExtendPoint;
          ADrawData.FPieArcCenterExtendHorzPoint.X:=ADrawData.FPieArcCenterExtendHorzPoint.X-ASkinVirtualChartDefaultMaterial.FPieInfoExtendHorzLineLength;

          //
          ADrawData.FCaptionRect.Right:=ADrawData.FPieArcCenterExtendHorzPoint.X
                                        //标题前空出一点
                                        -8;
          ADrawData.FCaptionRect.Left:=ADrawData.FCaptionRect.Right
                                        -AItemCaptionWidth;

        end;
        ADrawData.FCaptionRect.Top:=ADrawData.FPieArcCenterExtendPoint.Y-AItemCaptionHeight/2;
        ADrawData.FCaptionRect.Bottom:=ADrawData.FPieArcCenterExtendPoint.Y+AItemCaptionHeight/2;






        AStartAngle:=AStartAngle+ADataItem.FDrawPercent*360;

  //      //绝对坐标
  //      OffsetRect(ADataItemPathRect,APathDrawRect.Left,APathDrawRect.Top);
  //      OffsetRect(ADataItemRect,APathDrawRect.Left,APathDrawRect.Top);
  //      ADataItem.FItemRect:=ADataItemRect;
  //      ADataItem.FItemDrawRect:=ADataItemRect;
  //      ADataItem.FBarDrawRect:=ADataItemPathRect;




  end;


end;

function TVirtualChartSeriesPieDrawer.GetDataItemColor(
  ADataItem: TVirtualChartSeriesDataItem;AMaterial:TSkinVirtualChartDefaultMaterial): TDrawColor;
var
  AColorIndex:Integer;
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin
  if ADataItem.Color=0 then
  begin
    //默认颜色
    ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);
    AColorIndex:=ADataItem.Index mod ASkinVirtualChartDefaultMaterial.FSeriesColorList.Count;
    Result:=ASkinVirtualChartDefaultMaterial.FSeriesColorList[AColorIndex];
  end
  else
  begin
    //
    Result:=ADataItem.FColor;
  end;
end;

function TVirtualChartSeriesPieDrawer.GetPathDrawRect(ADrawRect: TRectF): TRectF;
var
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin
  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);

  //取最小的长度
  if ADrawRect.Width>ADrawRect.Height then
  begin
    FRadius:=ADrawRect.Height*ASkinVirtualChartDefaultMaterial.FPieRadiusPercent/2;
    FInnerRadius:=ADrawRect.Height*ASkinVirtualChartDefaultMaterial.FPieInnerSizePercent/2;
  end
  else
  begin
    FRadius:=ADrawRect.Width*ASkinVirtualChartDefaultMaterial.FPieRadiusPercent/2;
    FInnerRadius:=ADrawRect.Width*ASkinVirtualChartDefaultMaterial.FPieInnerSizePercent/2;
  end;

  Result.Left:=ADrawRect.Left+(ADrawRect.Width-FRadius*2)/2;
  Result.Top:=ADrawRect.Top+(ADrawRect.Height-FRadius*2)/2;
  Result.Right:=Result.Left+FRadius*2;
  Result.Bottom:=Result.Top+FRadius*2;

  FCircleCenterPoint.X:=Result.Left+Self.FRadius;
  FCircleCenterPoint.Y:=Result.Top+Self.FRadius;

end;

function TVirtualChartSeriesPieDrawer.IsNeedPaintAxis: Boolean;
begin
  Result:=False;
end;

function TVirtualChartSeriesPieDrawer.PtInItem(ADataItem: TVirtualChartSeriesDataItem; APoint: TPointF): Boolean;
var
  ADrawData:TVirtualChartSeriesPieDrawData;
begin
  Result:=False;
  //饼图是扇形,需要判断鼠标是否在扇形中
  //Result:=Self.FDrawPathActions.FDrawPathData.IsInRegion(APoint);
  //APieDrawer:=TVirtualChartSeriesPieDrawer(TVirtualChartSeriesDataItems(Self.Owner).FSeries.FDrawer);
  ADrawData:=TVirtualChartSeriesPieDrawData(ADataItem.FDrawData);
  if ADrawData<>nil then
  begin
    //判断鼠标是否在外扇形中
    Result:=PtInPie(Self.FCircleCenterPoint,APoint,ADataItem,Self.FRadius,ADrawData.FPieStartAngle+90,ADrawData.FPieSweepAngle);
    if Self.FInnerRadius>0 then
    begin
      //判断鼠标是否在空心圆的内扇形中
      if PtInPie(Self.FCircleCenterPoint,APoint,ADataItem,Self.FInnerRadius,ADrawData.FPieStartAngle+90,ADrawData.FPieSweepAngle) then
      begin
        Result:=False;
      end;
    end;
  end;

end;


procedure TVirtualChartSeriesPieDrawer.DoLegendListViewMouseOverItemChange(Sender: TObject);
begin
  {$IFDEF OPENSOURCE_VERSION}
  {$ELSE}
  //提示Item鼠标停靠状态改变的时候,相应的扇形也鼠标停靠
  if TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView.Prop.MouseOverItem<>nil then
  begin
//    Self.FSeries.GetMouseEventListLayoutsManager.MouseOverItem:=Self.FSeries.GetMouseEventListLayoutsManager.GetVisibleItem(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView.Prop.MouseOverItem.Index);
    Self.FSeries.GetMouseEventListLayoutsManager.MouseOverItem:=Self.FSeries.GetMouseEventListLayoutsManager.GetVisibleItem(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView.Prop.MouseOverItem.Index);
  end
  else
  begin
    Self.FSeries.GetMouseEventListLayoutsManager.MouseOverItem:=nil;
  end;
  {$ENDIF}

end;

//procedure TVirtualChartSeriesPieDrawer.DoLegendListViewPrepareDrawItem(
//  Sender: TObject; ACanvas: TDrawCanvas;
//  AItemDesignerPanel: {$IFDEF FMX}TSkinFMXItemDesignerPanel{$ELSE}TSkinItemDesignerPanel{$ENDIF}; AItem: TSkinItem;
//  AItemDrawRect: TRect);
//var
//  ADataItem:TVirtualChartSeriesDataItem;
//  ASeries:TVirtualChartSeries;
////  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
//begin
//  //AItem为DataItem
//  if AItem is TVirtualChartSeriesDataItem then
//  begin
//    ADataItem:=TVirtualChartSeriesDataItem(AItem);
//    ASeries:=TVirtualChartSeriesDataItems(ADataItem.Owner).FSeries;
//    TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendItemColorPanel.Material.BackColor.FillColor.FColor:=
//  //    AItem.Color;
//      ASeries.FDrawer.GetDataItemColor(TVirtualChartSeriesDataItem(AItem),
//                      TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial)
//                      ).Color;
//  end
//  else
//  begin
//
//  end;
//
//end;


function GetAngle(ACircleCenterPoint:TPointF;APoint:TPointF):Double;
var
  x,y:Double;
  xC,yC:Double;
  distance:Double;
  xD:Double;
  mySin:Double;
  degree:Double;
begin
    Result:=0;

    x:=APoint.X;
    y:=APoint.Y;


    xC:=ACircleCenterPoint.X;
    yC:=ACircleCenterPoint.Y;


    // 计算控件距离圆心距离
    //CGFloat distance = sqrt(pow((x - xC), 2) + pow(y - yC, 2));
    distance:=Sqrt(Power(x-xC,2)+Power(y - yC,2));

//    CGFloat xD = (x - xC);
    xD := (x - xC);
//    CGFloat mySin = fabs(xD) / distance;
    mySin := abs(xD) / distance;
//    CGFloat degree;
    if (APoint.x < ACircleCenterPoint.x) then
    begin
        if (APoint.y < ACircleCenterPoint.y) then
        begin
//            degree := 360 - Math.asin(mySin) / PI * 180;
            degree := 360 - Math.ArcSin(mySin) / PI * 180;
        end
        else
        begin
            degree := Math.ArcSin(mySin) / PI * 180 + 180;
        end;
    end
    else
    begin
        if (APoint.y < ACircleCenterPoint.y) then
        begin
            degree := Math.ArcSin(mySin) / PI * 180;
        end
        else
        begin
            degree := 180 - Math.ArcSin(mySin) / PI * 180;
        end;
    end;
//    return degree;

    Result:=degree;


end;


function PtInPie(ACircleCenterPoint:TPointF;
                APoint:TPointF;
                ADataItem:TVirtualChartSeriesDataItem;
                ARadius:Double;
                AStartAngle:Double;
                ASweepAngle:Double): Boolean;
var
  ADistance:Double;
  AAngle:Double;
begin
  Result:=False;

  //先判断与圆心的距离,如果超了,肯定不在里面
  ADistance:=Sqrt(Power(ACircleCenterPoint.X-APoint.X,2)+Power(ACircleCenterPoint.Y-APoint.Y,2));
  if ADistance>ARadius then
  begin
    Exit;
  end;

  //再判断与圆心的角度,如果在扇形中,则在里面
  AAngle:=GetAngle(ACircleCenterPoint,APoint);
//  OutputDebugString('AAngle:'+FloatToStr(AAngle)+' AStartAngle:'+FloatToStr(AStartAngle)+' ASweepAngle:'+FloatToStr(ASweepAngle));

  if (AAngle>=AStartAngle) and (AAngle<=AStartAngle+ASweepAngle) then
  begin
    Result:=True;
  end;

end;

{ TVirtualChartSeriesLineDrawer }

class function TVirtualChartSeriesLineDrawer.ChartType: TSkinChartType;
begin
  Result:=sctLine;
end;

function TVirtualChartSeriesLineDrawer.CustomPaint(ACanvas: TDrawCanvas;
  ASkinMaterial: TSkinControlMaterial; const ADrawRect: TRectF;
  APaintData: TPaintData; const APathDrawRect: TRectF): Boolean;
var
  I: Integer;
var
//  ADrawRect:TRectF;
  X:Double;
  Y:Double;
  AXAxisSkinListBox:TSkinListBox;
  AYAxisSkinListBox:TSkinListBox;
  ASkinVirtualChartIntf:ISkinVirtualChart;
  ACaptionRect:TRectF;
  AItemWidth:Double;
var
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
//var
//  I:Integer;
var
  ADataItem:TVirtualChartSeriesDataItem;
  AItemEffectStates:TDPEffectStates;
  AOldColor:TDelphiColor;
  AOldAlpha:Byte;
  AOldIsFill:Boolean;
  AItemCaptionWidth:Double;
  ALastItemCaptionDrawLeft:Double;
  ADrawData:TVirtualChartSeriesLineDrawData;
//  AItemPaintData:TPaintData;
//var
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin

  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);
  ASkinVirtualChartIntf:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf;



//  PaintAxis(ACanvas,ASkinMaterial,ADrawRect,APaintData,APathDrawRect);


  Inherited;



  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);


  //绘制整个轮廓的背景色
  if ASkinVirtualChartDefaultMaterial.IsFillLineChartArea then
  begin
    AOldColor:=ASkinVirtualChartDefaultMaterial.FLineDotParam.FillColor.FColor;
    AOldIsFill:=ASkinVirtualChartDefaultMaterial.FLineDotParam.IsFill;
    AOldAlpha:=ASkinVirtualChartDefaultMaterial.FLineDotParam.FillColor.FAlpha;

    //渐变加透明度
    ASkinVirtualChartDefaultMaterial.FLineDotParam.FillColor.FColor:=Self.GetSeriesColor(ASkinVirtualChartDefaultMaterial).FColor;
    ASkinVirtualChartDefaultMaterial.FLineDotParam.FillColor.FAlpha:=50;
    ASkinVirtualChartDefaultMaterial.FLineDotParam.FIsFill:=True;
    ACanvas.DrawPath(ASkinVirtualChartDefaultMaterial.FLineDotParam,APathDrawRect,Self.FSeriesDrawPathActions);

    ASkinVirtualChartDefaultMaterial.FLineDotParam.FillColor.FColor:=AOldColor;
    ASkinVirtualChartDefaultMaterial.FLineDotParam.FIsFill:=AOldIsFill;
    ASkinVirtualChartDefaultMaterial.FLineDotParam.FillColor.FAlpha:=AOldAlpha;
  end;


  //不能超出区域
  ACanvas.SetClip(APathDrawRect);

  //绘制线条
  for I := 0 to Self.FSeries.FDataItems.Count-1 do
  begin
    ADataItem:=Self.FSeries.FDataItems[I];
    ADrawData:=TVirtualChartSeriesLineDrawData(ADataItem.FDrawData);
    if ADrawData=nil then Break;

    if I+1<Self.FSeries.FDataItems.Count then
    begin
      AOldColor:=ASkinVirtualChartDefaultMaterial.FLineColorParam.Color.FColor;

      ASkinVirtualChartDefaultMaterial.FLineColorParam.Color.FColor:=Self.GetSeriesColor(ASkinVirtualChartDefaultMaterial).FColor;
      ACanvas.DrawLine(ASkinVirtualChartDefaultMaterial.FLineColorParam,
                       APathDrawRect.Left+ADrawData.FLinePoint.X,
                       APathDrawRect.Top+ADrawData.FLinePoint.Y,
                       APathDrawRect.Left+TVirtualChartSeriesLineDrawData(Self.FSeries.FDataItems[I+1].FDrawData).FLinePoint.X,
                       APathDrawRect.Top+TVirtualChartSeriesLineDrawData(Self.FSeries.FDataItems[I+1].FDrawData).FLinePoint.Y
                        );

      ASkinVirtualChartDefaultMaterial.FLineColorParam.Color.FColor:=AOldColor;
    end;
    

    //给数据项加上状态
    AItemEffectStates:=Self.FSeries.GetMouseEventListLayoutsManager.ProcessItemDrawEffectStates(ADataItem);
    ASkinVirtualChartDefaultMaterial.FLineDotParam.StaticEffectStates:=AItemEffectStates;
//    ASkinVirtualChartDefaultMaterial.FBarColorParam.FillColor.FColor:=Self.GetDataItemColor(ADataItem);
//
//
//    //处理绘制参数的透明度
//    ASkinVirtualChartDefaultMaterial.FBarColorParam.DrawAlpha:=Ceil(ASkinVirtualChartDefaultMaterial.FBarColorParam.CurrentEffectAlpha*1);

//    AItemPaintData:=GlobalNullPaintData;
//    AItemPaintData.IsDrawInteractiveState:=True;
//    ProcessParamEffectStates(ASkinVirtualChartDefaultMaterial.FBarColorParam,
//                                1,
//                                AItemEffectStates,
//                                AItemPaintData
//                                );


    //在点上绘制小圆圈
    AOldColor:=ASkinVirtualChartDefaultMaterial.FBarColorParam.FillColor.FColor;

    ASkinVirtualChartDefaultMaterial.FLineDotParam.PenColor.FColor:=Self.GetSeriesColor(ASkinVirtualChartDefaultMaterial).FColor;
    ACanvas.DrawPath(ASkinVirtualChartDefaultMaterial.FLineDotParam,APathDrawRect,ADataItem.FDrawPathActions);


    ASkinVirtualChartDefaultMaterial.FBarColorParam.FillColor.FColor:=AOldColor;

  end;
  ACanvas.ResetClip;

end;


//{ TVirtualChartSeriesPolarDrawer }
//
//procedure TVirtualChartSeriesPolarDrawer.GenerateDrawPathList(APathDrawRect: TRectF);
//var
//  I: Integer;
////  ADataItemRect:TRectF;
////  ADataItemPathRect:TRectF;
//  AVirtualChartSeriesList:TVirtualChartSeriesList;
//  ALegendListView:TSkinVirtualList;
////  AItemWidth:Double;
//  AStartAngle:Double;
//  ADataItem:TVirtualChartSeriesDataItem;
//  APathActionItem:TPathActionItem;
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
////  ABarSizePercent:Double;
//  AMinValue,AMaxValue,ASumValue:Double;
//  ARad:Double;
//  ACos:Double;
//  AItemCaptionWidth:Double;
//  AItemCaptionHeight:Double;
//  AOffset:Double;
//begin
//  Inherited;
//
//
//
//  AVirtualChartSeriesList:=TVirtualChartSeriesList(Self.FSeries.Collection);
//
//  ALegendListView:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView;
//  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);
//
//
//  if ASkinVirtualChartDefaultMaterial.FLegendListViewVisible then
//  begin
//      ALegendListView.Prop.ListLayoutsManager.SkinListIntf:=Self.FSeries.FDataItems;
//      ALegendListView.Prop.FItems:=Self.FSeries.FDataItems;
//
//      ALegendListView.Visible:=True;
//      //设置提示区的位置
//      //默认在最左边,从上到下排列
//      {$IFDEF VCL}
//      ALegendListView.Align:=alLeft;
//      {$ENDIF}
//      {$IFDEF FMX}
//      ALegendListView.Align:=TAlignLayout.Left;
//      {$ENDIF}
//
//      ALegendListView.Visible:=True;
//      if TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendItemDesignerPanel=nil then
//      begin
//        TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.CreateLegendItemDesignerPanel;
//      end;
//      ALegendListView.Prop.ItemDesignerPanel:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendItemDesignerPanel;
//      ALegendListView.Prop.ItemHeight:=26;
//      {$IFDEF VCL}
//      ALegendListView.AlignWithMargins:=True;
//      ALegendListView.Margins.SetBounds(10,10,0,10);
//      {$ENDIF}
//      {$IFDEF FMX}
//      ALegendListView.Margins.Left:=10;
//      ALegendListView.Margins.Top:=10;
//      ALegendListView.Margins.Right:=0;
//      ALegendListView.Margins.Bottom:=10;
//      {$ENDIF}
////      ALegendListView.OnPrepareDrawItem:=DoLegendListViewPrepareDrawItem;
//      ALegendListView.OnMouseOverItemChange:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.DoLegendListViewMouseOverItemChange;
//  end
//  else
//  begin
//      ALegendListView.Visible:=False;
//      ALegendListView.OnMouseOverItemChange:=nil;
//      ALegendListView.OnPrepareDrawItem:=nil;
//  end;
//
//
//  FSeries.GetMinMaxValue(AMinValue,AMaxValue,ASumValue);
//
//
//  //然后生成柱子
//  //需要最大值,计算出百分比
//  AStartAngle:=0;
//  for I := 0 to Self.FSeries.FDataItems.Count-1 do
//  begin
//      ADataItem:=Self.FSeries.FDataItems[I];
//
//
//      ADataItem.FDrawPercent:=0;
//      if ASumValue>0 then
//      begin
//        ADataItem.FDrawPercent:=ADataItem.Value/ASumValue;
//      end;
//
////      //提示,不能直接这样赋值,不然DataItem的颜色被改过来了
////      ADataItem.Color:=Self.GetDataItemColor(ADataItem);
//
//
//      //横排的
//      //生成Path列表
//      //AItemWidth:=AXAxisSkinListBox.Prop.CalcItemWidth(AXAxisSkinListBox.Prop.Items[I]);
//      //AItemWidth:=APathDrawRect.Width / AXAxisSkinListBox.Prop.Items.Count;
//
////      //数据项所在的大矩形-相对坐标
////      ADataItemRect:=RectF(0,0,0,0);
////      ADataItemRect.Left:=ALeft;
////      ADataItemRect.Top:=0;
////      ADataItemRect.Right:=ALeft+AItemWidth;
////      ADataItemRect.Bottom:=APathDrawRect.Height;
////
////
////
////
////      //下一个Item的左边距
////      ALeft:=ALeft+AItemWidth;
//
//
//
//      ADataItem.FDrawPathActions.Clear;
//
//
////      ADataItemPathRect.Left:=ADataItemRect.Left+AItemWidth*(1-ABarSizePercent)/2;
////      ADataItemPathRect.Top:=ADataItemRect.Top+APathDrawRect.Height*(1-ADataItem.FDrawPercent);
////      ADataItemPathRect.Right:=ADataItemPathRect.Left+AItemWidth*ABarSizePercent;
////      ADataItemPathRect.Bottom:=ADataItemRect.Bottom;
//
//      if ASkinVirtualChartDefaultMaterial.FPieInnerSizePercent=0 then
//      begin
//          //没有内环
//          //生成饼的Path
//          APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
//          //饼
//          APathActionItem.ActionType:=patAddPie;
//          APathActionItem.X:=0;
//          APathActionItem.Y:=0;
//          APathActionItem.X1:=APathDrawRect.Width;
//          APathActionItem.Y1:=APathDrawRect.Height;
//
//          APathActionItem.StartAngle:=AStartAngle-90;
//          APathActionItem.SweepAngle:=ADataItem.FDrawPercent*360;
//      end
//      else
//      begin
//          //有内环
//          //圆环
//          //外环
//          APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
//          APathActionItem.ActionType:=patAddArc;
//          APathActionItem.X:=0;
//          APathActionItem.Y:=0;
//          APathActionItem.X1:=APathDrawRect.Width;
//          APathActionItem.Y1:=APathDrawRect.Height;
//
//          APathActionItem.StartAngle:=AStartAngle-90;
//          APathActionItem.SweepAngle:=ADataItem.FDrawPercent*360;
//          //内环
//          AOffset:=(APathDrawRect.Width-(APathDrawRect.Width/ASkinVirtualChartDefaultMaterial.FPieRadiusPercent)*ASkinVirtualChartDefaultMaterial.FPieInnerSizePercent)/2;
//          APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
//          APathActionItem.ActionType:=patAddArc;
//          APathActionItem.X:=AOffset;
//          APathActionItem.Y:=AOffset;
//          APathActionItem.X1:=APathDrawRect.Width-AOffset;
//          APathActionItem.Y1:=APathDrawRect.Height-AOffset;
//          //要反方向画,不然填充不了扇形
//          APathActionItem.StartAngle:=AStartAngle-90+ADataItem.FDrawPercent*360;
//          APathActionItem.SweepAngle:=-ADataItem.FDrawPercent*360;
//      end;
//
//      ADataItem.FPieStartAngle:=AStartAngle-90;
//      ADataItem.FPieSweepAngle:=ADataItem.FDrawPercent*360;
//
//
//      //填充
//      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
//      APathActionItem.ActionType:=patFillPath;
//
////      //获取区域,用于判断鼠标是否停靠
////      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
////      APathActionItem.ActionType:=patGetRegion;
//
//
//
//        //圆弧中心点计算出来，这个位置要用来绘制数据标题
//  //      ARad:=Math.DegToRad(AAngle);
//  //      ARad:=Math.CycleToRad(AAngle);
//  //      ARad:=Math.GradToRad(AAngle);
//        ADataItem.FPieArcCenterAngle:=(AStartAngle-90+ADataItem.FDrawPercent*360/2);//中心点的坐标,所以角度要除以2
//        ARad:=ADataItem.FPieArcCenterAngle*PI/180;
//
//        //x都是弧度
//        ACos:=Cos(ARad);
//        ADataItem.FPieArcCenterPoint.X := FCircleCenterPoint.X + FRadius * ACos;
//        ADataItem.FPieArcCenterPoint.Y := FCircleCenterPoint.Y + FRadius * Sin(ARad);
//
//
//        //延伸线的点算出来
//        ExPandLine(FCircleCenterPoint,ADataItem.FPieArcCenterPoint,20,ADataItem.FPieArcCenterExtendPoint);
//
//        AItemCaptionWidth:=GetStringWidth(ADataItem.Caption,ASkinVirtualChartDefaultMaterial.FPieInfoCaptionParam.FontSize);
//        AItemCaptionHeight:=GetStringHeight(ADataItem.Caption,ASkinVirtualChartDefaultMaterial.FPieInfoCaptionParam.FontSize);
//
//        //延伸线横出来的点算出来
//        if (ADataItem.FPieArcCenterAngle>=-90) and (ADataItem.FPieArcCenterAngle<90) then
//        begin
//          //横线往右
//          ADataItem.FPieArcCenterExtendHorzPoint:=ADataItem.FPieArcCenterExtendPoint;
//          ADataItem.FPieArcCenterExtendHorzPoint.X:=ADataItem.FPieArcCenterExtendHorzPoint.X+20;
//
//          ADataItem.FCaptionRect.Left:=ADataItem.FPieArcCenterExtendHorzPoint.X
//                                        //标题前空出一点
//                                        +5;
//          ADataItem.FCaptionRect.Right:=ADataItem.FCaptionRect.Left
//                                        +AItemCaptionWidth;
//        end
//        else
//        begin
//          //横线往左
//          ADataItem.FPieArcCenterExtendHorzPoint:=ADataItem.FPieArcCenterExtendPoint;
//          ADataItem.FPieArcCenterExtendHorzPoint.X:=ADataItem.FPieArcCenterExtendHorzPoint.X-20;
//
//          //
//          ADataItem.FCaptionRect.Right:=ADataItem.FPieArcCenterExtendHorzPoint.X
//                                        //标题前空出一点
//                                        -8;
//          ADataItem.FCaptionRect.Left:=ADataItem.FCaptionRect.Right
//                                        -AItemCaptionWidth;
//
//        end;
//        ADataItem.FCaptionRect.Top:=ADataItem.FPieArcCenterExtendPoint.Y-AItemCaptionHeight/2;
//        ADataItem.FCaptionRect.Bottom:=ADataItem.FPieArcCenterExtendPoint.Y+AItemCaptionHeight/2;
//
//
//
//
//
//
//        AStartAngle:=AStartAngle+ADataItem.FDrawPercent*360;
//
//  //      //绝对坐标
//  //      OffsetRect(ADataItemPathRect,APathDrawRect.Left,APathDrawRect.Top);
//  //      OffsetRect(ADataItemRect,APathDrawRect.Left,APathDrawRect.Top);
//  //      ADataItem.FItemRect:=ADataItemRect;
//  //      ADataItem.FItemDrawRect:=ADataItemRect;
//  //      ADataItem.FBarDrawRect:=ADataItemPathRect;
//
//
//
//
//  end;
//
//
//end;
//

procedure TVirtualChartSeriesLineDrawer.GenerateAreaPathList(APathDrawRect: TRectF);
var
  I: Integer;
//  ADataItemRect:TRectF;
//  ADataItemPathRect:TRectF;
  AVirtualChartSeriesList:TVirtualChartSeriesList;
  AXAxisSkinListBox:TSkinListBox;
  ALegendListView:TSkinVirtualList;
  AItemWidth:Double;
  ALeft:Double;
  ADataItem:TVirtualChartSeriesDataItem;
  APathActionItem:TPathActionItem;
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
  ADrawData:TVirtualChartSeriesLineDrawData;
begin

  AVirtualChartSeriesList:=TVirtualChartSeriesList(Self.FSeries.Collection);

  AXAxisSkinListBox:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FXAxisSkinListBox;
  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);

  //计算出外部轮廓
  FSeriesDrawPathActions.Clear;
  //左下角起点
  APathActionItem:=TPathActionItem(FSeriesDrawPathActions.Add);
  APathActionItem.ActionType:=patMoveTo;
  APathActionItem.X:=0;
  APathActionItem.Y:=APathDrawRect.Height;

  for I := 0 to Self.FSeries.FDataItems.Count-1 do
  begin
    ADataItem:=Self.FSeries.FDataItems[I];
    ADrawData:=TVirtualChartSeriesLineDrawData(ADataItem.FDrawData);
    if ADrawData=nil then Break;

    APathActionItem:=TPathActionItem(FSeriesDrawPathActions.Add);
    APathActionItem.ActionType:=patLineTo;
    APathActionItem.X:=ADrawData.FLinePoint.X;
    APathActionItem.Y:=ADrawData.FLinePoint.Y;

  end;


  //右下角点
  APathActionItem:=TPathActionItem(FSeriesDrawPathActions.Add);
  APathActionItem.ActionType:=patLineTo;
  APathActionItem.X:=APathDrawRect.Width;
  APathActionItem.Y:=APathDrawRect.Height;


  //回到起点
  APathActionItem:=TPathActionItem(FSeriesDrawPathActions.Add);
  APathActionItem.ActionType:=patLineTo;
  APathActionItem.X:=0;
  APathActionItem.Y:=APathDrawRect.Height;



  //填充
  APathActionItem:=TPathActionItem(FSeriesDrawPathActions.Add);
  APathActionItem.ActionType:=patFillPath;


end;

procedure TVirtualChartSeriesLineDrawer.GenerateDrawPathList(
  APathDrawRect: TRectF);
//var
//  I: Integer;
////  ADataItemRect:TRectF;
////  ADataItemPathRect:TRectF;
//  AVirtualChartSeriesList:TVirtualChartSeriesList;
//  AXAxisSkinListBox:TSkinListBox;
//  ALegendListView:TSkinVirtualList;
//  AItemWidth:Double;
//  ALeft:Double;
//  ADataItem:TVirtualChartSeriesDataItem;
//  APathActionItem:TPathActionItem;
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
//  ADrawData:TVirtualChartSeriesLineDrawData;
begin
  Inherited;

//  AVirtualChartSeriesList:=TVirtualChartSeriesList(Self.FSeries.Collection);
//
//  AXAxisSkinListBox:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FXAxisSkinListBox;
//  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);

//  ALegendListView:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView;
//
//  if ALegendListView<>nil then
//  begin
//    ALegendListView.Visible:=False;
//    ALegendListView.OnMouseOverItemChange:=nil;
//    ALegendListView.OnPrepareDrawItem:=nil;
//  end;


  GenerateLineDotList(APathDrawRect);
  GenerateAreaPathList(APathDrawRect);

end;

procedure TVirtualChartSeriesLineDrawer.GenerateLineDotList(APathDrawRect: TRectF);
var
  I: Integer;
//  ADataItemRect:TRectF;
//  ADataItemPathRect:TRectF;
  AVirtualChartSeriesList:TVirtualChartSeriesList;
  AXAxisSkinListBox:TSkinListBox;
  ALegendListView:TSkinVirtualList;
  AItemWidth:Double;
  ALeft:Double;
  ADataItem:TVirtualChartSeriesDataItem;
  APathActionItem:TPathActionItem;
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
  ADrawData:TVirtualChartSeriesLineDrawData;
  AProperties:TVirtualChartProperties;
begin


  AVirtualChartSeriesList:=TVirtualChartSeriesList(Self.FSeries.Collection);

  AProperties:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties;
  AXAxisSkinListBox:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FXAxisSkinListBox;
  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);


  //横排的
  //生成Path列表
  //AItemWidth:=AXAxisSkinListBox.Prop.CalcItemWidth(AXAxisSkinListBox.Prop.Items[I]);

  case ASkinVirtualChartDefaultMaterial.XAxisScalePosition of
    xscptLeft:
    begin
      //有从起点开始的,也有从中心点开始的
      AItemWidth:=APathDrawRect.Width / (AXAxisSkinListBox.Prop.Items.Count-1);
    end;
    xscptMiddle:
    begin
      //有从起点开始的,也有从中心点开始的
      AItemWidth:=APathDrawRect.Width / AXAxisSkinListBox.Prop.Items.Count;
    end;
  end;



  //需要最大值,计算出百分比
  ALeft:=0;
  for I := 0 to Self.FSeries.FDataItems.Count-1 do
  begin
      ADataItem:=Self.FSeries.FDataItems[I];
      ADrawData:=TVirtualChartSeriesLineDrawData(ADataItem.FDrawData);
      if ADrawData=nil then Break;


      ADataItem.FDrawPercent:=0;
      if (AProperties.FMaxValue-AProperties.FMinValue)>0 then
      begin
//        ADataItem.FDrawPercent:=
//              (ADataItem.FDisplayValue-AProperties.FMinValue)
//                /(AProperties.FMaxValue-AProperties.FMinValue);
        ADataItem.FDrawPercent:=
              (ADataItem.FDisplayValue-AProperties.FCorMinValue)
                /(AProperties.FCorMaxValue-AProperties.FCorMinValue);
      end;





//      //数据项所在的大矩形-相对坐标
//      ADataItemRect:=RectF(0,0,0,0);
//      ADataItemRect.Left:=ALeft;
//      ADataItemRect.Top:=0;
//      ADataItemRect.Right:=ALeft+AItemWidth;
//      ADataItemRect.Bottom:=APathDrawRect.Height;

      case ASkinVirtualChartDefaultMaterial.XAxisScalePosition of
        xscptLeft:
        begin
          //有从起点开始的,也有从中心点开始的
          ADrawData.FLinePoint.X:=ALeft;
        end;
        xscptMiddle:
        begin
          //有从起点开始的,也有从中心点开始的
          ADrawData.FLinePoint.X:=ALeft+AItemWidth/2;
        end;
      end;
      ADrawData.FLinePoint.Y:=APathDrawRect.Height*(1-ADataItem.FDrawPercent);



      ADrawData.FBarRect.Left:=APathDrawRect.Left+ALeft-AItemWidth/2;
      ADrawData.FBarRect.Top:=APathDrawRect.Top;
      ADrawData.FBarRect.Right:=APathDrawRect.Left+ALeft+AItemWidth/2;
      ADrawData.FBarRect.Bottom:=APathDrawRect.Bottom;

      //下一个Item的左边距
      ALeft:=ALeft+AItemWidth;



      ADataItem.FDrawPathActions.Clear;


//      ADataItemPathRect.Left:=ADataItemRect.Left+AItemWidth*(1-ABarSizePercent)/2;
//      ADataItemPathRect.Top:=ADataItemRect.Top+APathDrawRect.Height*(1-ADataItem.FDrawPercent);
//      ADataItemPathRect.Right:=ADataItemPathRect.Left+AItemWidth*ABarSizePercent;
//      ADataItemPathRect.Bottom:=ADataItemRect.Bottom;


      //生成圈的Path
      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      APathActionItem.ActionType:=patAddEllipse;
      APathActionItem.X:=ADrawData.FLinePoint.X-ASkinVirtualChartDefaultMaterial.FLineDotRadius;
      //这个柱状图是从底部上来的
      APathActionItem.Y:=ADrawData.FLinePoint.Y-ASkinVirtualChartDefaultMaterial.FLineDotRadius;
      APathActionItem.X1:=ADrawData.FLinePoint.X+ASkinVirtualChartDefaultMaterial.FLineDotRadius;
      APathActionItem.Y1:=ADrawData.FLinePoint.Y+ASkinVirtualChartDefaultMaterial.FLineDotRadius;

      ADrawData.FLineDotRect.Left:=APathDrawRect.Left+APathActionItem.X;
      ADrawData.FLineDotRect.Top:=APathDrawRect.Top+APathActionItem.Y;
      ADrawData.FLineDotRect.Right:=APathDrawRect.Left+APathActionItem.X1;
      ADrawData.FLineDotRect.Bottom:=APathDrawRect.Top+APathActionItem.Y1;


//      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
//      APathActionItem.ActionType:=patGetRegion;


      //填充
      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      APathActionItem.ActionType:=patFillPath;

      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      APathActionItem.ActionType:=patDrawPath;




//      //绝对坐标
//      OffsetRect(ADataItemPathRect,APathDrawRect.Left,APathDrawRect.Top);
//      OffsetRect(ADataItemRect,APathDrawRect.Left,APathDrawRect.Top);
//      ADataItem.FItemRect:=ADataItemRect;
//      ADataItem.FItemDrawRect:=ADataItemRect;
//      ADataItem.FBarDrawRect:=ADataItemPathRect;



  end;


end;

function TVirtualChartSeriesLineDrawer.PtInItem(ADataItem: TVirtualChartSeriesDataItem; APoint: TPointF): Boolean;
var
  ADrawData:TVirtualChartSeriesLineDrawData;
begin
  Result:=False;
  //线状图,只需要判断鼠标是否在那个圆点上即可
  ADrawData:=TVirtualChartSeriesLineDrawData(ADataItem.FDrawData);
  if ADrawData<>nil then
  begin
//  Result:=PtInRect(ADrawData.FLineDotRect,APoint);
    Result:=PtInRectF(ADrawData.FBarRect,APoint);
  end;
end;

//function TVirtualChartSeriesLineDrawer.GetDataItemColor(ADataItem: TVirtualChartSeriesDataItem): TDelphiColor;
//var
//  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
//begin
//  if ADataItem.Color=0 then
//  begin
//    //默认颜色
//    ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial);
//    Result:=ASkinVirtualChartDefaultMaterial.BarColorParam.FillColor.Color;
//  end
//  else
//  begin
//    //
//    Result:=ADataItem.Color;
//  end;
//
//
//end;


{ TVirtualChartSeriesDrawerClassRegList }

function TVirtualChartSeriesDrawerClassRegList.Find(
  AChartType: TSkinChartType): TVirtualChartSeriesDrawerClassReg;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Count-1 do
  begin
    if TVirtualChartSeriesDrawerClassReg(Items[I]).DrawerClass.ChartType=AChartType then
    begin
      Result:=TVirtualChartSeriesDrawerClassReg(Items[I]);
      Break;
    end;
  end;
end;

procedure TVirtualChartSeriesDrawerClassRegList.RegisterDrawerClass(
  AValue: TVirtualChartSeriesDrawerClass;ADrawDataClass:TVirtualChartSeriesDrawDataClass);
var
  AReg:TVirtualChartSeriesDrawerClassReg;
begin
  AReg:=TVirtualChartSeriesDrawerClassReg.Create;
  AReg.DrawerClass:=AValue;
  AReg.DrawDataClass:=ADrawDataClass;
  Add(AReg);
end;

initialization
  RegisterClasses([TSkinVirtualChart]);
  //图表视图
  RegisterSkinControlStyle('SkinVirtualChart',TSkinVirtualChartDefaultType,TSkinVirtualChartDefaultMaterial,TVirtualChartProperties,Const_Default_ComponentType,True);


  RegisterDrawerClass(TVirtualChartSeriesBarDrawer,TVirtualChartSeriesBarDrawData);
  RegisterDrawerClass(TVirtualChartSeriesLineDrawer,TVirtualChartSeriesLineDrawData);
  RegisterDrawerClass(TVirtualChartSeriesPieDrawer,TVirtualChartSeriesPieDrawData);
  RegisterDrawerClass(TVirtualChartSeriesBezierLineDrawer,TVirtualChartSeriesBezierLineDrawData);
  RegisterDrawerClass(TVirtualChartSeriesMapDrawer,TVirtualChartSeriesMapDrawData);


finalization
  FreeAndNil(GlobalChartDrawerClassRegList);

end.




