//convert pas to utf8 by ¥

/// <summary>
///   <para>
///     列表框
///   </para>
///   <para>
///     List Box
///   </para>
/// </summary>
unit uSkinVirtualChartMapDrawer;


interface
{$R province_data.RES}

{$I FrameWork.inc}
{$I Version.inc}

uses
  Classes,
  SysUtils,
  uFuncCommon,
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  Controls,
  Types,//定义了TRectF

//  {$IF CompilerVersion>=30.0}
//  Types,//定义了TRectF
//  {$IFEND}
//
//  uBaseList,
//  uBaseLog,
//  DateUtils,
//
//  {$IFDEF VCL}
//  Messages,
//  ExtCtrls,
//  Controls,
//  {$ENDIF}
//  {$IFDEF FMX}
//  UITypes,
//  FMX.Types,
//  FMX.Controls,
//  FMX.Dialogs,
//  {$ENDIF}


  Math,
  StrUtils,
  DateUtils,
  uBaseSkinControl,
  uSkinItems,
  uDrawParam,
  uGraphicCommon,
  uSkinBufferBitmap,
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

  uBaseLog,
  {$IFDEF SKIN_SUPEROBJECT}
  uSkinSuperObject,
  {$ELSE}
  XSuperObject,
  //XSuperJson,
  {$ENDIF}
  //System.IOUtils,
//
//  {$IFDEF FMX}
//  uSkinFireMonkeyItemDesignerPanel,
//  {$ENDIF}
//
//  {$IFDEF OPENSOURCE_VERSION}
//  {$ELSE}
//  uSkinListViewType,
//  {$ENDIF}
  uSkinVirtualChartType,

//  uSkinControlGestureManager,
//  uSkinScrollControlType,
  uDrawPictureParam;


type
  TVirtualChartSeriesMapDrawData=class(TVirtualChartSeriesDrawData)
  public
    //不规则点
    FRegionPoints:array of TPointFArray;

    //轮廓
//    FAreaRectF:TRectF;
    FCenterPointF:TPointF;
//    FCenterPointF2:TPointF;

    {$IFDEF VCL}
    FPolygonRegions: array of HRGN;
    // 删除多边形句柄数组
    procedure DestroyPolygonRegions(APolygonRegions: array of HRGN);
    {$ENDIF}
    destructor Destroy;override;

  end;
  //贝塞尔线状图生成路径
  TVirtualChartSeriesMapDrawer=class(TVirtualChartSeriesDrawer)
  public
    FChinaJsonObj: ISuperObject;
    FProvinceJsonObj: ISuperObject;
    FMinX, FMaxX, FMinY, FMaxY: Double;
    FLastProvinceName: string;
    FScale: Double;
    FOffsetX, FOffsetY: Double;

//    FInitCalcControlSize:Double;
    // 从本地读取地图数据json
    procedure LoadLocalMapData();//ADataItem:TVirtualChartSeriesDataItem);
    function ConvertLatLongToXY_Calc(longitude, latitude: Extended; mapWidth, mapHeight: Single): TPointF;
    function ConvertLatLongToXY(longitude, latitude: Extended; mapWidth, mapHeight: Single; mapRange: string): TPointF;
    procedure CreateProvincePoints(Index: Integer; ADataItem:TVirtualChartSeriesDataItem; mapWidth, mapHeight: Single);
//    procedure DestroyPolygonRegions(APolygonRegions: array of HRGN);
    // 从资源文件读取字符
    function ReadResDataString(const AResName: string): string;

    // 从资源文件读取字符
//    function ReadResDataString(const AResName: string): string;
    // 加载地图
    procedure LoadChinaMapItems;
  public
    class function ChartType:TSkinChartType;override;

    constructor Create(AVirtualChartSeries:TVirtualChartSeries);override;
    destructor Destroy;override;

    function IsNeedPaintAxis:Boolean;override;
    //提示Item鼠标停靠状态改变的时候,相应的扇形也鼠标停靠
    procedure DoLegendListViewMouseOverItemChange(Sender:TObject);
//    //指定提示ListView的颜色
//    procedure DoLegendListViewPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
//      AItemDesignerPanel: {$IFDEF FMX}TSkinFMXItemDesignerPanel{$ELSE}TSkinItemDesignerPanel{$ENDIF}; AItem: TSkinItem;
//      AItemDrawRect: TRect);
    //获取这个数据项的颜色
    function GetLegendItemColorByValue(AValue:Double;AMaterial:TSkinVirtualChartDefaultMaterial):TDrawColor;
    function GetDataItemColor(ADataItem:TVirtualChartSeriesDataItem;AMaterial:TSkinVirtualChartDefaultMaterial):TDrawColor;override;
    function GetDataItemGradientColor1(ADataItem:TVirtualChartSeriesDataItem;AMaterial:TSkinVirtualChartDefaultMaterial):TDrawColor;override;
    //判断鼠标是否在Item里面
    function PtInItem(ADataItem:TVirtualChartSeriesDataItem;APoint:TPointF):Boolean;override;
    //生成路径绘制列表
    procedure GenerateDrawPathList(APathDrawRect:TRectF);override;
    //绘制Y轴分隔线，X轴刻度值
    function CustomPaint(ACanvas:TDrawCanvas;ASkinMaterial:TSkinControlMaterial;const ADrawRect:TRectF;APaintData:TPaintData;const APathDrawRect:TRectF):Boolean;override;
  end;


implementation


{ TVirtualChartSeriesMapDrawer }

procedure TVirtualChartSeriesMapDrawer.LoadChinaMapItems;
var
  i: Integer;
  AProvinceJsonObj: ISuperObject;
  FeaturesArray: ISuperArray;
  ANowProvinceName: string;
  AMapItem:TVirtualChartSeriesDataItem;
  AOriginItem:TVirtualChartSeriesDataItem;
begin

  try
    FSeries.FMapItems.Clear;

    if Self.FSeries.FMapRange = 'china' then
    begin
      AProvinceJsonObj:=SO(ReadResDataString('CFGJson_china'));
    end
    else
    begin
      AProvinceJsonObj:=SO(ReadResDataString('CFGJson_' + Self.FSeries.FMapRange));
    end;

    FeaturesArray := AProvinceJsonObj.A['features'];
    for i := 0 to FeaturesArray.Length - 1 do
    begin
      ANowProvinceName:= FeaturesArray.O[i].O['properties'].S['name'];

      AMapItem:=FSeries.FMapItems.Add;
      AMapItem.Caption:=ANowProvinceName;
      AMapItem.Detail:= Self.FSeries.FMapRange;
      AMapItem.Detail1:= IntToStr(FeaturesArray.O[i].O['properties'].I['adcode']);
      AMapItem.Detail2:= FeaturesArray.O[i].O['properties'].S['level'];
      //父code
      AMapItem.Detail3:= IntToStr(FeaturesArray.O[i].O['properties'].O['parent'].I['adcode']);






      FreeAndNil(Self.FSeries.FMapItems[I].FDrawData);
      Self.FSeries.FMapItems[I].FDrawData:=TVirtualChartSeriesMapDrawData.Create;


      //找到对应的DataItem，赋值
      AOriginItem:=TVirtualChartSeriesDataItem(Self.FSeries.FDataItems.FindItemByCaption(AMapItem.Caption));
      //AMapItem.Caption是带省和市的
      if AOriginItem=nil then AOriginItem:=TVirtualChartSeriesDataItem(Self.FSeries.FDataItems.FindItemByCaption(ReplaceStr(AMapItem.Caption,'省','')));
      if AOriginItem=nil then AOriginItem:=TVirtualChartSeriesDataItem(Self.FSeries.FDataItems.FindItemByCaption(ReplaceStr(AMapItem.Caption,'市','')));
      if AOriginItem<>nil then
      begin
        AMapItem.Value:=AOriginItem.Value;
      end;


    end;

  finally

  end;

end;

function TVirtualChartSeriesMapDrawer.ReadResDataString(
  const AResName: string): string;
var
  cRes: TResourceStream;
  cStr: TStringStream;
begin
  Result := '';
  if System.findResource(HInstance, PChar(AResName), RT_RCDATA) = 0 then
    Exit;

  cRes := TResourceStream.Create(HInstance, AResName, RT_RCDATA);
  try
    cStr := TStringStream.Create('', TEncoding.UTF8);
    try
      cStr.LoadFromStream(cRes);
      Result := cStr.DataString;
    finally
      cStr.Free;
    end;
  finally
    cRes.Free;
  end;
end;

// 从资源文件加载地图json
procedure TVirtualChartSeriesMapDrawer.LoadLocalMapData();//ADataItem:TVirtualChartSeriesDataItem);
begin

  //if ADataItem.Detail = 'china' then
  if FSeries.FMapRange='china' then
  begin

    if not Assigned(FChinaJsonObj) then
    begin
      FChinaJsonObj:=SO(ReadResDataString('CFGJson_china'));
//      FChinaJsonObj:=SO(GetStringFromFile('D:\china.json',TEncoding.UTF8));
    end;

  end
  else
  begin

//    if ADataItem.Detail <> FLastProvinceName then
    if FSeries.FMapRange <> FLastProvinceName then
    begin
//      uBaseLog.HandleException(nil, ADataItem.Detail);
//      FProvinceJsonObj:=SO(ReadResDataString('CFGJson_' + ADataItem.Detail));
//      FLastProvinceName:= ADataItem.Detail;

      uBaseLog.HandleException(nil, FSeries.FMapRange);
      FProvinceJsonObj:=SO(ReadResDataString('CFGJson_' + FSeries.FMapRange));
      FLastProvinceName:=FSeries.FMapRange;
    end;

  end;

end;

function TVirtualChartSeriesMapDrawer.ConvertLatLongToXY_Calc(longitude,
  latitude: Extended; mapWidth, mapHeight: Single): TPointF;
var
  X, Y: Extended;
begin
  // 将经纬度坐标转换为平面坐标
  x := (mapWidth / 2) + (mapWidth / 360.0) * longitude;
  y := (mapHeight / 2) - (mapHeight / (2 * PI)) * ln((1 + sin(latitude * PI / 180)) / (1 - sin(latitude * PI / 180))) / 2;

  if X<FMinX then  FMinX:=X;
  if Y<FMinY then  FMinY:=Y;
  if X>FMaxX then  FMaxX:=X;
  if Y>FMaxY then  FMaxY:=Y;

  Result:=PointF(X,Y);
end;

// 将经纬度坐标转换为平面坐标
class function TVirtualChartSeriesMapDrawer.ChartType: TSkinChartType;
begin
  Result:=sctMap;

end;

function TVirtualChartSeriesMapDrawer.ConvertLatLongToXY(longitude, latitude: Extended; mapWidth, mapHeight: Single; mapRange: string): TPointF;
var
  x, y, x1, y1: Extended; // 使用 Extended 类型保存更高精度的浮点数
begin
  x := (mapWidth / 2) + (mapWidth / 360.0) * longitude;
  y := (mapHeight / 2) - (mapHeight / (2 * PI)) * ln((1 + sin(latitude * PI / 180)) / (1 - sin(latitude * PI / 180))) / 2;

//  if mapRange = 'china' then
//  begin
//    longitude:=65;
//    latitude:=123;
//  end
//  else
//  begin
//    longitude:=65;
//    latitude:=123;
//  end;
//
//  x1 := (mapWidth / 2) + (mapWidth / 360.0) * longitude;
//  y1 := (mapHeight / 2) - (mapHeight / (2 * PI)) * ln((1 + sin(latitude * PI / 180)) / (1 - sin(latitude * PI / 180))) / 2;
//
//  if mapRange = 'china' then
//    Result := Point(Round((x-X1)*5), Round(ABS(y-Y1)*5))
//  else
//    Result := Point(Round((x-X1)*5), Round(ABS(y-Y1)*5));


//  Result := Point(Round((x - FMinX) * FScale + FOffsetX), Round((y - FMinY) * FScale + FOffsetY));
//  Result := PointF((x - FMinX) * FScale + FOffsetX, (y - FMinY) * FScale + FOffsetY);
  Result := PointF(x,y);

end;

constructor TVirtualChartSeriesMapDrawer.Create(AVirtualChartSeries:TVirtualChartSeries);
begin
  inherited Create(AVirtualChartSeries);
end;

// 创建传入省份的边界点数组
procedure TVirtualChartSeriesMapDrawer.CreateProvincePoints(Index: Integer; ADataItem:TVirtualChartSeriesDataItem; mapWidth, mapHeight: Single);
var
  FeaturesArray, CoordinatesArray, AreaArray, AreaItemArray: ISuperArray;
//  ANowProvinceCode: Integer; //省份代码
  ANowProvinceName: string;  //省份名称
  Points: array of TPoint;
  i, j, k: Integer;
  Lat, Long: Double;
  Region: HRGN;
  APointF:TPointF;
  jsonmapWidth, jsonmapHeight: Single;
  ADrawData:TVirtualChartSeriesMapDrawData;
  AMapScale:Double;
  AControlSize:Double;
begin

  try
    ADrawData:=TVirtualChartSeriesMapDrawData(ADataItem.FDrawData);

    if ADataItem.FDrawData=nil then Exit;
    

    // 获取features数组
    if ADataItem.Detail = 'china' then
      FeaturesArray := FChinaJsonObj.A['features']
    else
      FeaturesArray := FProvinceJsonObj.A['features'];
    AMapScale:=1;
    AControlSize:=Min(mapWidth,mapHeight);
    if Index = 0 then
    begin
      // 先遍历一遍取出转换后的经纬度最大最小值
      for i := 0 to FeaturesArray.Length - 1 do
      begin
        CoordinatesArray:= FeaturesArray.O[i].O['geometry'].A['coordinates'];

        for j := 0 to CoordinatesArray.Length - 1 do
        begin
          AreaArray:= CoordinatesArray.A[j];
          AreaItemArray:= AreaArray.A[0];

          for k := 0 to AreaItemArray.Length - 1 do
          begin
            Long := AreaItemArray.A[k].F[0];
            Lat := AreaItemArray.A[k].F[1];

            //将计算出来的X,Y保存起来
//            APointF:=ConvertLatLongToXY_Calc(Long, Lat, Min(mapWidth,mapHeight), Min(mapWidth,mapHeight));
            APointF:=ConvertLatLongToXY_Calc(Long, Lat, AControlSize,AControlSize);
//            //缓存下来 速度没有差别 一开始能填进去，后面数据更新不了了
//            AreaItemArray.A[k].F[2]:=APointF.X;
//            AreaItemArray.A[k].F[3]:=APointF.Y;
          end;

        end;

      end;

      //(FMaxX - FMinX)水平宽度
      //(FMaxY - FMinY)垂直高度
      // 计算缩放比例(选择较小的那一个)
      FScale := Min(AControlSize / (FMaxX - FMinX), AControlSize / (FMaxY - FMinY)) * 1.1;


      // 计算绘制偏移量
      FOffsetX := Round((mapWidth - (FMaxX - FMinX) * FScale) / 2) ;
      FOffsetY := Round((mapHeight - (FMaxY - FMinY) * FScale) / 2) ;


//      FInitCalcControlSize:=AControlSize;
//      if mapWidth>mapHeight then
//      begin
//        FOffsetX:=FOffsetX+(mapWidth-mapHeight)/2;
//      end
//      else
//      begin
//        FOffsetY:=FOffsetY+(mapHeight-mapWidth)/2;
//      end;

//
//      FChinaJsonObj.F['Width']:=mapWidth;
//      FChinaJsonObj.F['Height']:=mapHeight;
//
//      FChinaJsonObj.F['MaxX']:=FMaxX;
//      FChinaJsonObj.F['MinX']:=FMinX;
//
//      FChinaJsonObj.F['MaxY']:=FMaxY;
//      FChinaJsonObj.F['MinY']:=FMinY;
//
//      FChinaJsonObj.SaveTo('D:\china.json');
    end;
    //AMapScale:=AControlSize/FInitCalcControlSize;



//    jsonmapWidth:=FChinaJsonObj.F['Width'];
//    jsonmapHeight:=FChinaJsonObj.F['Height'];
//
////      AMapScale:=(mapWidth/jsonmapWidth);
//    AMapScale := Min((mapWidth/jsonmapWidth),(mapHeight/jsonmapHeight));
//
//
//    FMaxX:=FChinaJsonObj.F['MaxX']*AMapScale;
//    FMinX:=FChinaJsonObj.F['MinX']*AMapScale;
//
//    FMaxY:=FChinaJsonObj.F['MaxY']*AMapScale;
//    FMinY:=FChinaJsonObj.F['MinY']*AMapScale;
//
//    //(FMaxX - FMinX)水平宽度
//    //(FMaxY - FMinY)垂直高度
//    // 计算缩放比例(选择较小的那一个)
//    FScale := Min(mapWidth / (FMaxX - FMinX), mapHeight / (FMaxY - FMinY)) ;//* 0.9;
//    // 计算绘制偏移量
//    FOffsetX := Round((mapWidth - (FMaxX - FMinX) * FScale) / 2);
//    FOffsetY := Round((mapHeight - (FMaxY - FMinY) * FScale) / 2);


    // 遍历每个省市 计算出轮廓的平面坐标数据
    for i := 0 to FeaturesArray.Length - 1 do
    begin
//      ANowProvinceCode:= FeaturesArray.O[i].O['properties'].I['adcode'];
      ANowProvinceName:= FeaturesArray.O[i].O['properties'].S['name'];

      if ANowProvinceName = ADataItem.Caption then
      begin
        uBaseLog.HandleException(nil, IntToStr(i+1) + '、' + ANowProvinceName);

        CoordinatesArray:= FeaturesArray.O[i].O['geometry'].A['coordinates'];

        SetLength(ADrawData.FRegionPoints, CoordinatesArray.Length);
        {$IFDEF VCL}
        SetLength(ADrawData.FPolygonRegions, CoordinatesArray.Length);
        {$ENDIF}

        // 遍历当前省的边界数组
        for j := 0 to CoordinatesArray.Length - 1 do
        begin
          AreaArray:= CoordinatesArray.A[j];
          AreaItemArray:= AreaArray.A[0];

          SetLength(ADrawData.FRegionPoints[j], AreaItemArray.Length);

          SetLength(Points, AreaItemArray.Length);

          for k := 0 to AreaItemArray.Length - 1 do
          begin
            Long := AreaItemArray.A[k].F[0];
            Lat := AreaItemArray.A[k].F[1];

            // 将地理坐标转换为平面坐标
//            APointF := ConvertLatLongToXY(Long, Lat, mapWidth, mapHeight, ADataItem.Detail);
            APointF := ConvertLatLongToXY(Long, Lat, AControlSize, AControlSize, ADataItem.Detail);
//            Points[k] := Point(0,0);
//            Points[k] := PointF(Rou(Points[k].x - FMinX) * FScale + FOffsetX, (Points[k].y - FMinY) * FScale + FOffsetY);
//            //直接取缓存
//            APointF:=PointF(AreaItemArray.A[k].F[2]*AMapScale,AreaItemArray.A[k].F[3]*AMapScale);
            Points[k] := Point(Round((APointF.x - FMinX) * FScale + FOffsetX), Round((APointF.y - FMinY) * FScale + FOffsetY));

            ADrawData.FRegionPoints[j][k]:=PointF((APointF.x - FMinX) * FScale + FOffsetX, (APointF.y - FMinY) * FScale + FOffsetY);
          end;


          //计算出轮廓
//          ADrawData.FAreaRectF:=CalcAreaRect(ADrawData.FRegionPoints[j]);

          //直接使用数据里面的center
          APointF:=ConvertLatLongToXY(FeaturesArray.O[i].O['properties'].A['center'].F[0], FeaturesArray.O[i].O['properties'].A['center'].F[1], AControlSize, AControlSize, ADataItem.Detail);
          ADrawData.FCenterPointF := PointF(Round((APointF.x - FMinX) * FScale + FOffsetX), Round((APointF.y - FMinY) * FScale + FOffsetY));



          //计算出轮廓的中心点
//          ADrawData.FCenterPointF:=GetGravityPoint(ADrawData.FRegionPoints[j]);
//
//          ADrawData.FCenterPointF2:=PointF((ADrawData.FAreaRectF.Left+ADrawData.FAreaRectF.Right)/2,(ADrawData.FAreaRectF.Top+ADrawData.FAreaRectF.Bottom)/2);


          {$IFDEF VCL}
          // 创建多边形区域添加到区域句柄数组 不耗时
          Region := CreatePolygonRgn(Points[0], Length(Points), WINDING);
//          SetLength(ADrawData.FPolygonRegions, Length(ADrawData.FPolygonRegions) + 1);
//          ADrawData.FPolygonRegions[High(ADrawData.FPolygonRegions)] := Region;
          ADrawData.FPolygonRegions[j] := Region;
          {$ENDIF}

        end;

        //


      end;

    end;

  finally
  end;

end;

//procedure TVirtualChartSeriesMapDrawer.DestroyPolygonRegions(APolygonRegions: array of HRGN);
//var
//  i: Integer;
//begin
//  {$IFDEF VCL}
//  // 释放所有多边形区域的句柄数组
//  for i := 0 to High(APolygonRegions) do
//  begin
//    if APolygonRegions[i] <> 0 then
//    begin
//      DeleteObject(APolygonRegions[i]);
//      APolygonRegions[i]:=0;
//    end;
//  end;
//  {$ENDIF}
//end;

procedure TVirtualChartSeriesMapDrawer.GenerateDrawPathList(
  APathDrawRect: TRectF);
var
  I, J, K: Integer;
  ADataItemRect:TRectF;
  ADataItemPathRect:TRectF;
  AVirtualChartSeriesList:TVirtualChartSeriesList;
  AXAxisSkinListBox:TSkinListBox;
  ALegendListView:TSkinVirtualList;
  AAxisItemWidth:Double;
  ADataItemLeft:Double;
  ADataItemWidth:Double;
  ALeft:Double;
  ADataItem:TVirtualChartSeriesDataItem;
  APathActionItem:TPathActionItem;
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
//  ABarSizePercent:Double;
  ASeriesItemSpace:Double;
  Region: HRGN;
  ADrawData:TVirtualChartSeriesMapDrawData;
  AStartTime:TDateTime;
  AVaule:Double;
  ASkinItem:TRealSkinItem;
begin
  Inherited;


  AVirtualChartSeriesList:=TVirtualChartSeriesList(Self.FSeries.Collection);

  AXAxisSkinListBox:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FXAxisSkinListBox;
  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.SkinControlIntf.GetCurrentUseMaterial);


  ALegendListView:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView;

//  if ALegendListView<>nil then
//  begin
//      ALegendListView.Visible:=False;
//      ALegendListView.OnMouseOverItemChange:=nil;
//      ALegendListView.OnPrepareDrawItem:=nil;
//  end;


  if TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.LegendListViewVisible then
  begin
      //显示LegendListView，并添加好区间
      ALegendListView.Prop.Items.BeginUpdate;
      try
        ALegendListView.Prop.Items.Clear;
        //根据计算出来的区间来添加Item
        AVaule:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FCorMinValue;
        if TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FCorStepValue>0 then
        begin

          while AVaule<=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FCorMaxValue do
          begin
            ASkinItem:=TRealSkinItem(ALegendListView.Prop.Items.Insert(0));
            //标题
            ASkinItem.Caption:=FloatToStr(AVaule)+'-'+FloatToStr(AVaule+TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FCorStepValue-1);
            //颜色
            ASkinItem.FColor.FColor:=GetLegendItemColorByValue(AVaule,ASkinVirtualChartDefaultMaterial).Color;
            ASkinItem.FColor.FAlpha:=GetLegendItemColorByValue(AVaule,ASkinVirtualChartDefaultMaterial).Alpha;
            //区间存哪里?
            //步长
            AVaule:=AVaule+TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FCorStepValue;
          end;

        end;
      finally
        ALegendListView.Prop.Items.EndUpdate;
      end;
      ALegendListView.Visible:=True;


      ALegendListView.Visible:=True;



      //      ALegendListView.OnPrepareDrawItem:=DoLegendListViewPrepareDrawItem;
      ALegendListView.OnMouseOverItemChange:=DoLegendListViewMouseOverItemChange;
      TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendItemCaptionLabel.Material.DrawCaptionParam.Assign(ASkinVirtualChartDefaultMaterial.LegendItemCaptionParam);


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



  Self.LoadChinaMapItems;

  // 从资源文件加载地图json
  LoadLocalMapData();//Self.FSeries.FDataItems[0]);

  FMinX:=MaxInt;
  FMinY:=MaxInt;
  FMaxX:=0;
  FMaxY:=0;

  FLastProvinceName:= '';

  FScale:= 0;
  FOffsetX:= 0;
  FOffsetY:= 0;

  AStartTime:=Now;
  //然后生成柱子
  //需要最大值,计算出百分比
  ALeft:=0;
  for I := 0 to Self.FSeries.FMapItems.Count-1 do
  begin
      ADataItem:=Self.FSeries.FMapItems[I];


      ADrawData:=TVirtualChartSeriesMapDrawData(ADataItem.FDrawData);

//      {$IFDEF VCL}
//      // 先删除原来的区域数组
//      DestroyPolygonRegions(ADrawData.FPolygonRegions);
//      {$ENDIF}

      //要保持一定的比例,不然会压缩,保持正方型
      CreateProvincePoints(I, ADataItem, APathDrawRect.Width, APathDrawRect.Height);
//      CreateProvincePoints(I, ADataItem, APathDrawRect.Width, APathDrawRect.Width);//APathDrawRect.Height);
//      CreateProvincePoints(I, ADataItem, Min(APathDrawRect.Width, APathDrawRect.Height), Min(APathDrawRect.Width, APathDrawRect.Height));//APathDrawRect.Height);

//      if ADataItem.Caption='北京市' then
//      begin
//        //设置经纬度列表
////        SetLength(ADataItem.FRegionPoints,1);
////        SetLength(ADataItem.FRegionPoints[0],3);
////        ADataItem.FRegionPoints[0][0]:=PointF(50,0);
////        ADataItem.FRegionPoints[0][1]:=PointF(0,50);
////        ADataItem.FRegionPoints[0][2]:=PointF(100,50);
//
//      end;

      //添加省份
//      if ADataItem.Caption='北京市' then
//      begin
//        //设置经纬度列表
//        SetLength(ADataItem.FRegionPoints,1);
//        SetLength(ADataItem.FRegionPoints[0],4);
//        ADataItem.FRegionPoints[0][0]:=PointF(0,0);
//        ADataItem.FRegionPoints[0][1]:=PointF(100,0);
//        ADataItem.FRegionPoints[0][2]:=PointF(100,20);
//        ADataItem.FRegionPoints[0][3]:=PointF(0,20);
//      end;


      //========================================================================

      ADataItem.FDrawPathActions.Clear;

      //填充
      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      APathActionItem.ActionType:=patStart;

      for J := 0 to Length(ADrawData.FRegionPoints) -1 do
      begin
        APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
        APathActionItem.ActionType:=patAddPolygon;
        APathActionItem.SetPoints(ADrawData.FRegionPoints[J]);
      end;


//      //起点
//      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
//      APathActionItem.ActionType:=patMoveTo;
//      APathActionItem.X:=ADataItem.FRegionPoints[0].X;
//      APathActionItem.Y:=ADataItem.FRegionPoints[0].Y;
//
//
//      for J := 1 to Length(ADataItem.FRegionPoints)-1 do
//      begin
//        APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
//        APathActionItem.ActionType:=patLineTo;
//        APathActionItem.X:=ADataItem.FRegionPoints[I].X;
//        APathActionItem.Y:=ADataItem.FRegionPoints[I].Y;
//      end;


      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      APathActionItem.ActionType:=patStop;


//      if i=0 then
      begin
      //填充
      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      APathActionItem.ActionType:=patFillPath;
      end;

      //填充
      APathActionItem:=TPathActionItem(ADataItem.FDrawPathActions.Add);
      APathActionItem.ActionType:=patDrawPath;


  end;

  uBaseLog.HandleException(nil, '==========【地图轮廓创建完毕,耗时：'+IntToStr(MilliSecondsBetween(Now,AStartTime))+'ms】==========');
  //1001
  //去掉计算,只需要328ms,计算需要700ms
  //去掉读取res,只需要0ms,读取需要328ms,
end;


destructor TVirtualChartSeriesMapDrawer.Destroy;
begin
  inherited;
end;

procedure TVirtualChartSeriesMapDrawer.DoLegendListViewMouseOverItemChange(Sender: TObject);
var
  I:Integer;
  AStepIndex:Integer;
  ACorStep:Double;
  ACorNumber:Integer;
begin
  //在这个区间的都高亮显示
  //不一定要有这种效果
  //区间存哪里?
  //步长
//  AVaule:=AVaule+TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FCorStepValue;
  AStepIndex:=-1;
  if TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView.Prop.MouseOverItem<>nil then
  begin
    AStepIndex:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView.Prop.MouseOverItem.Index;
  end;
  ACorStep:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FCorStepValue;
  ACorNumber:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FCorNumber;
  if ACorStep>0 then
  begin
    for I := 0 to FSeries.DataItems.Count-1 do
    begin
      if (AStepIndex<>-1)
        and ((FSeries.DataItems[I].Value)>=(ACorNumber-AStepIndex)*ACorStep)
        and ((FSeries.DataItems[I].Value)<(ACorNumber-AStepIndex+1)*ACorStep) then
      begin
        //这里要能同时设置多个为MouseOver状态,所以要改动
//        Self.FSeries.FListLayoutsManager.MouseOverItem:=FSeries.DataItems[I];
        FSeries.DataItems[I].FIsMouseOver:=True;
      end
      else
      begin
        FSeries.DataItems[I].FIsMouseOver:=False;
      end;
    end;
    //刷新一下
    TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Prop.Invalidate;
  end;

//  {$IFDEF OPENSOURCE_VERSION}
//  {$ELSE}
//  //提示Item鼠标停靠状态改变的时候,相应的扇形也鼠标停靠
//  if TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView.Prop.MouseOverItem<>nil then
//  begin
//    Self.FSeries.FListLayoutsManager.MouseOverItem:=Self.FSeries.FListLayoutsManager.GetVisibleItem(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendListView.Prop.MouseOverItem.Index);
//  end
//  else
//  begin
//    Self.FSeries.FListLayoutsManager.MouseOverItem:=nil;
//  end;
//  {$ENDIF}

end;

//procedure TVirtualChartSeriesMapDrawer.DoLegendListViewPrepareDrawItem(
//  Sender: TObject; ACanvas: TDrawCanvas;
//  AItemDesignerPanel: {$IFDEF FMX}TSkinFMXItemDesignerPanel{$ELSE}TSkinItemDesignerPanel{$ENDIF}; AItem: TSkinItem;
//  AItemDrawRect: TRect);
//var
//  ADataItem:TVirtualChartSeriesDataItem;
//  ASeries:TVirtualChartSeries;
////  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
//begin
//  //AItem为DataItem
////  if AItem is TVirtualChartSeriesDataItem then
////  begin
////    ADataItem:=TVirtualChartSeriesDataItem(AItem);
////    ASeries:=TVirtualChartSeriesDataItems(ADataItem.Owner).FSeries;
////    TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FLegendItemColorPanel.Material.BackColor.FillColor.FColor:=
////  //    AItem.Color;
////      ASeries.FDrawer.GetDataItemColor(TVirtualChartSeriesDataItem(AItem),
////                      TSkinVirtualChartDefaultMaterial(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Properties.FSkinControlIntf.GetCurrentUseMaterial)
////                      ).Color;
////  end
////  else
////  begin
////
////  end;
//
//end;



function TVirtualChartSeriesMapDrawer.GetDataItemColor(
  ADataItem: TVirtualChartSeriesDataItem;
  AMaterial: TSkinVirtualChartDefaultMaterial): TDrawColor;
var
  AValueAlpha:Byte;
begin
  Result:=Inherited;

//    if (ADataItem.Value>0) then
//    begin
//      //有值和无值的颜色区分一下
//      Result:=AMaterial.FSeriesColorList[1 mod AMaterial.FSeriesColorList.Count];
//    end;


  //首先,得看有几个区间
//  if (Self.FSeries.FSumValue>0) then
//  begin
    AValueAlpha:=0;


    if (ADataItem.Value>0) then
    begin
        //有值和无值的透明度要明显区分一下
        Result.StaticAlpha:=150;//基础

        //再根据透明度，或者饱和度还是什么亮度来计算出各个区间的颜色
        AValueAlpha:=Ceil(ADataItem.Value/Self.FSeries.FSumValue*255);
    end
    else
    begin
        //有值和无值的透明度要明显区分一下
        Result.StaticAlpha:=50;//基础

    end;


    if AValueAlpha+Result.FAlpha>255 then
    begin
      Result.StaticAlpha:=255;
    end
    else
    begin
      Result.StaticAlpha:=AValueAlpha+Result.FAlpha;
    end;

//  end;

end;

//function TVirtualChartSeriesMapDrawer.GetDataItemColorByValue(AValue: Double;
//  AMaterial: TSkinVirtualChartDefaultMaterial): TDrawColor;
//begin
//  //判断AValue在第几层级来确定颜色的深度
//  //if AValue then
//  //根据占比就能算的出来
//  //占比：AValue/Self.FSeries.FSumValue
//end;

function TVirtualChartSeriesMapDrawer.GetDataItemGradientColor1(
  ADataItem: TVirtualChartSeriesDataItem;
  AMaterial: TSkinVirtualChartDefaultMaterial): TDrawColor;
begin
  Result:=Inherited;

end;

function TVirtualChartSeriesMapDrawer.GetLegendItemColorByValue(AValue: Double;
  AMaterial: TSkinVirtualChartDefaultMaterial): TDrawColor;
var
  AValueAlpha:Byte;
begin
  Result:=GetSeriesColor(AMaterial);

  //首先,得看有几个区间
  if (Self.FSeries.FSumValue>0) then
  begin
    Result.StaticAlpha:=50;
    AValueAlpha:=0;
    if (AValue>0) then
    begin
      //再根据透明度，或者饱和度还是什么亮度来计算出各个区间的颜色
      AValueAlpha:=Ceil(AValue/Self.FSeries.FSumValue*255);
    end;
    if AValueAlpha+Result.FAlpha>255 then
    begin
      Result.StaticAlpha:=255;
    end
    else
    begin
      Result.StaticAlpha:=AValueAlpha+Result.FAlpha;
    end;

  end;

end;

function TVirtualChartSeriesMapDrawer.IsNeedPaintAxis: Boolean;
begin
  Result:=False;
end;

function TVirtualChartSeriesMapDrawer.PtInItem(ADataItem: TVirtualChartSeriesDataItem; APoint: TPointF): Boolean;
var
  I:Integer;
  ARgn:HRgn;
  tempPoints:array of TPoint;
  ADrawData:TVirtualChartSeriesMapDrawData;
begin
  Result:=False;
//  //线状图,只需要判断鼠标是否在那个圆点上即可
//  //Result:=PtInRect(ADataItem.FLineDotRect,APoint);
//  Result:=False;
//  SetLength(tempPoints,Length(ADataItem.FRegionPoints));
//  for I := 0 to Length(ADataItem.FRegionPoints)-1 do
//  begin
//    tempPoints[I]:=Point(Ceil(ADataItem.FRegionPoints[I].X),Ceil(ADataItem.FRegionPoints[I].Y));
//  end;
//
////  { PolyFill() Modes }
////  {$EXTERNALSYM ALTERNATE}
////  ALTERNATE = 1;
////  {$EXTERNALSYM WINDING}
////  WINDING = 2;
////  {$EXTERNALSYM POLYFILL_LAST}
////  POLYFILL_LAST = 2;
//
//  ARgn:=CreatePolygonRgn(tempPoints[0],Length(tempPoints),WINDING);
//  if PtInRegion(ARgn,Ceil(APoint.X),Ceil(APoint.Y)) then
//  begin
//    Result:=True;
//  end;
//  DeleteObject(ARgn);

  //============================================================================
  ADrawData:=TVirtualChartSeriesMapDrawData(ADataItem.FDrawData);

  if ADrawData<>nil then
  begin
    {$IFDEF VCL}
    for i := 0 to High(ADrawData.FPolygonRegions) do
    begin
      if PtInRegion(ADrawData.FPolygonRegions[i], Ceil(APoint.X), Ceil(APoint.Y)) then
      begin
        Result:=True;
      end;
    end;
    {$ELSE}
    Result:=ADataItem.FDrawPathActions.FDrawPathData.IsVisible(TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf.Prop.SkinControl.Canvas,APoint);
//    if Result then
//    begin
//      Result:=False;
//    end;
    {$ENDIF}
  end;

end;

function TVirtualChartSeriesMapDrawer.CustomPaint(ACanvas: TDrawCanvas;
  ASkinMaterial: TSkinControlMaterial; const ADrawRect: TRectF;
  APaintData: TPaintData; const APathDrawRect: TRectF): Boolean;
var
  I: Integer;
  ADataItem:TVirtualChartSeriesDataItem;
  AItemEffectStates:TDPEffectStates;
  AOldColor:TDelphiColor;
  AOldAlpha:Byte;
  AMapCenterRectF:TRectF;
  AMapCaptionRectF:TRectF;
//  AOldHasValueColor:TDelphiColor;
//  AOldHasValueAlpha:Byte;
  ASkinVirtualChartIntf:ISkinVirtualChart;
  ADrawData:TVirtualChartSeriesMapDrawData;
  ASkinVirtualChartDefaultMaterial:TSkinVirtualChartDefaultMaterial;
begin

  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);
  ASkinVirtualChartIntf:=TVirtualChartSeriesList(Self.FSeries.Collection).FSkinVirtualChartIntf;

  Inherited;


  ASkinVirtualChartDefaultMaterial:=TSkinVirtualChartDefaultMaterial(ASkinMaterial);

  //绘制轮廓
  for I := 0 to FSeries.FMapItems.Count-1 do
  begin
    ADataItem:=FSeries.FMapItems[I];

    ADrawData:=TVirtualChartSeriesMapDrawData(ADataItem.FDrawData);

    //获取数据项的状态，是否鼠标停靠
    AItemEffectStates:=Self.FSeries.FListLayoutsManager.ProcessItemDrawEffectStates(ADataItem);
    ASkinVirtualChartDefaultMaterial.MapColorParam.StaticEffectStates:=AItemEffectStates;


    AOldColor:=ASkinVirtualChartDefaultMaterial.MapColorParam.FillColor.FColor;
    AOldAlpha:=ASkinVirtualChartDefaultMaterial.MapColorParam.FillColor.FAlpha;
    //获取数据项的柱子填充色
    ASkinVirtualChartDefaultMaterial.MapColorParam.FillColor.FColor:=GetDataItemColor(ADataItem,ASkinVirtualChartDefaultMaterial).FColor;
    ASkinVirtualChartDefaultMaterial.MapColorParam.FillColor.FAlpha:=GetDataItemColor(ADataItem,ASkinVirtualChartDefaultMaterial).FAlpha;


//    AOldHasValueColor:=ASkinVirtualChartDefaultMaterial.MapHasValueColorParam.FillColor.FColor;
//    AOldHasValueAlpha:=ASkinVirtualChartDefaultMaterial.MapHasValueColorParam.FillColor.FAlpha;
//    //获取数据项的柱子填充色
////    ASkinVirtualChartDefaultMaterial.MapHasValueColorParam.FillColor.FColor:=GetDataItemColor(ADataItem,ASkinVirtualChartDefaultMaterial).FColor;
//    ASkinVirtualChartDefaultMaterial.MapHasValueColorParam.FillColor.FAlpha:=GetDataItemColor(ADataItem,ASkinVirtualChartDefaultMaterial).FAlpha;




//    if ADataItem.Value>0 then
//    begin
////      //不需要渐变作用
////      ASkinVirtualChartDefaultMaterial.MapColorParam.FBrushKind:=TDRPBrushKind.drpbkFill;
//
////      //处理绘制参数的透明度
////      ASkinVirtualChartDefaultMaterial.MapHasValueColorParam.DrawAlpha:=
////                    Ceil(ASkinVirtualChartDefaultMaterial.MapHasValueColorParam.CurrentEffectAlpha*1);
//
//
//
//
//      //绘制轮廓
//      ACanvas.DrawPath(ASkinVirtualChartDefaultMaterial.MapHasValueColorParam,APathDrawRect,ADataItem.FDrawPathActions);
//    end
//    else
//    begin
//      //需要渐变作用
//      ASkinVirtualChartDefaultMaterial.MapHasValueColorParam.FBrushKind:=TDRPBrushKind.drpbkGradient;


//      //处理绘制参数的透明度
//      ASkinVirtualChartDefaultMaterial.MapColorParam.DrawAlpha:=
//                    Ceil(ASkinVirtualChartDefaultMaterial.MapColorParam.CurrentEffectAlpha*1);




      //绘制轮廓
      ACanvas.DrawPath(ASkinVirtualChartDefaultMaterial.MapColorParam,APathDrawRect,ADataItem.FDrawPathActions);


//    end;






    ASkinVirtualChartDefaultMaterial.MapColorParam.FillColor.FColor:=AOldColor;
    ASkinVirtualChartDefaultMaterial.MapColorParam.FillColor.FAlpha:=AOldAlpha;

//    ASkinVirtualChartDefaultMaterial.MapHasValueColorParam.FillColor.FColor:=AOldHasValueColor;
//    ASkinVirtualChartDefaultMaterial.MapHasValueColorParam.FillColor.FAlpha:=AOldHasValueAlpha;

  end;

//
//  //绘制中心点
//  for I := 0 to FSeries.FMapItems.Count-1 do
//  begin
//    ADataItem:=FSeries.FMapItems[I];
//
//    ADrawData:=TVirtualChartSeriesMapDrawData(ADataItem.FDrawData);
//
//
//    //绘制中心点 圆的矩形即可
//    AMapCenterRectF:=RectF(ADrawData.FCenterPointF.X-4,ADrawData.FCenterPointF.Y-4,ADrawData.FCenterPointF.X+4,ADrawData.FCenterPointF.Y+4);
//    ACanvas.DrawRect(ASkinVirtualChartDefaultMaterial.MapCenterPointColorParam,AMapCenterRectF);
//
////    //旁边注上标题,判断是不是中心点计算错了
////    AMapCaptionRectF:=RectF(ADrawData.FCenterPointF.X-50,ADrawData.FCenterPointF.Y+8,ADrawData.FCenterPointF.X+50,ADrawData.FCenterPointF.Y+28);
////    ACanvas.DrawText(ASkinVirtualChartDefaultMaterial.DrawValueParam,ADataItem.Caption,AMapCaptionRectF);
//
////    //绘制中心点 圆的矩形即可
////    AMapCenterRectF:=RectF(ADrawData.FCenterPointF2.X-4,ADrawData.FCenterPointF2.Y-4,ADrawData.FCenterPointF2.X+4,ADrawData.FCenterPointF2.Y+4);
////    ACanvas.DrawRect(ASkinVirtualChartDefaultMaterial.MapCenterPointColorParam,AMapCenterRectF);
//
//
//  end;

end;


{ TVirtualChartSeriesMapDrawData }

{$IFDEF VCL}

procedure TVirtualChartSeriesMapDrawData.DestroyPolygonRegions(
  APolygonRegions: array of HRGN);
var
  i: Integer;
begin
  // 释放所有多边形区域的句柄数组
  for i := 0 to High(APolygonRegions) do
  begin
    if APolygonRegions[i] <> 0 then
    begin
      DeleteObject(APolygonRegions[i]);
    end;
  end;
end;
{$ENDIF}

destructor TVirtualChartSeriesMapDrawData.Destroy;
begin
  {$IFDEF VCL}
  // 释放地图多边形数组
  DestroyPolygonRegions(FPolygonRegions);
  {$ENDIF}

  inherited;
end;

end.
