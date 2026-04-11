//convert pas to utf8 by ¥
//列表项样式选择器
unit uListItemStylePropertyDesigner;

interface

 {$I FrameWork.inc}

uses
  Classes,
  Math,
  SysConst,


  TypInfo,
  SysUtils,

  uLang,

  uSkinRegManager,
  uLanguage,
  uSkinMaterial,
  uComponentType,
  Types,
  uSkinItems,
  uSkinCustomListType,
  uSkinItemDesignerPanelType,
  uDrawCanvas,

//  Windows,
  uBaseLog,
  {$IFDEF FPC}
  LCLIntf,
  PropEdits,
  componenteditors,
  LazIDEIntf,
  {$ENDIF}
  {$IFNDEF FPC}
//  CommCtrl,
  DesignIntf,
  DesignMenus,
  DesignEditors,
  ColnEdit,
  VCLEditors,
  VCL.Graphics,
  VCL.Forms,

  UITypes,
  {$ENDIF}

  {$IFDEF FMX}
  //当为OrangeUI FMX控件时，所以预览效果需要画在FMX的画布上,但是要画在VCL画布上
  FMX.Graphics,
  FMX.Controls,
  FMX.Types,
  FMX.Utils,
  {$ENDIF}

  uGraphicCommon,
  uFuncCommon
  ;

type
  TListItemStyleProperty = class(TStringProperty, ICustomPropertyListDrawing)
  public const
    ItemHeight = 38;
  private
    { ICustomPropertyDrawing }
    procedure ListMeasureWidth(const Value: string; ACanvas: VCL.Graphics.TCanvas; var AWidth: Integer);
    procedure ListMeasureHeight(const Value: string; ACanvas: VCL.Graphics.TCanvas; var AHeight: Integer);
    procedure ListDrawValue(const Value: string; ACanvas: VCL.Graphics.TCanvas; const ARect: TRect; ASelected: Boolean);
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;


procedure Register;

implementation


procedure Register;
begin
  RegisterPropertyEditorProc(TypeInfo(String), TSkinItem, 'ItemStyle',TListItemStyleProperty);
  RegisterPropertyEditorProc(TypeInfo(String), TCustomListProperties, 'DefaultItemStyle',TListItemStyleProperty);
  RegisterPropertyEditorProc(TypeInfo(String), TCustomListProperties, 'HeaderItemStyle',TListItemStyleProperty);
  RegisterPropertyEditorProc(TypeInfo(String), TCustomListProperties, 'FooterItemStyle',TListItemStyleProperty);
  RegisterPropertyEditorProc(TypeInfo(String), TCustomListProperties, 'Item1ItemStyle',TListItemStyleProperty);
  RegisterPropertyEditorProc(TypeInfo(String), TCustomListProperties, 'Item2ItemStyle',TListItemStyleProperty);
  RegisterPropertyEditorProc(TypeInfo(String), TCustomListProperties, 'Item3ItemStyle',TListItemStyleProperty);
  RegisterPropertyEditorProc(TypeInfo(String), TCustomListProperties, 'Item4ItemStyle',TListItemStyleProperty);
  RegisterPropertyEditorProc(TypeInfo(String), TCustomListProperties, 'SearchBarItemStyle',TListItemStyleProperty);


//  RegisterPropertyEditorProc(TypeInfo(String), nil, 'DefaultItemStyle',TListItemStyleProperty);
//  RegisterPropertyEditorProc(TypeInfo(String), nil, 'HeaderItemStyle',TListItemStyleProperty);
//  RegisterPropertyEditorProc(TypeInfo(String), nil, 'FooterItemStyle',TListItemStyleProperty);
//  RegisterPropertyEditorProc(TypeInfo(String), nil, 'Item1ItemStyle',TListItemStyleProperty);
//  RegisterPropertyEditorProc(TypeInfo(String), nil, 'Item2ItemStyle',TListItemStyleProperty);
//  RegisterPropertyEditorProc(TypeInfo(String), nil, 'Item3ItemStyle',TListItemStyleProperty);
//  RegisterPropertyEditorProc(TypeInfo(String), nil, 'Item4ItemStyle',TListItemStyleProperty);
//  RegisterPropertyEditorProc(TypeInfo(String), nil, 'SearchBarItemStyle',TListItemStyleProperty);


end;



{ TListItemStyleProperty }

function TListItemStyleProperty.GetAttributes: TPropertyAttributes;
begin
  //值列表
  Result := [paValueList];
end;


function ListCompareByNameASC(Item1, Item2: Pointer): Integer;
begin
  Result:=0;
  if (TListItemStyleReg(Item1).Name>TListItemStyleReg(Item2).Name) then
  begin
    Result:=1;
  end
  else if (TListItemStyleReg(Item1).Name<TListItemStyleReg(Item2).Name) then
  begin
    Result:=-1;
  end;
end;


procedure TListItemStyleProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  // 排序做一下
  GetGlobalListItemStyleRegList.Sort(ListCompareByNameASC);
  //返回已经注册的所有的列表项样式名称
  for I := 0 to GetGlobalListItemStyleRegList.Count-1 do
  begin
    Proc(GetGlobalListItemStyleRegList[I].Name);
  end;

end;

procedure TListItemStyleProperty.ListDrawValue(const Value: string;
  ACanvas: VCL.Graphics.TCanvas; const ARect: TRect; ASelected: Boolean);

  function FMXBitmapToVCLBitmap(const ABitmap: FMX.Graphics.TBitmap): VCL.Graphics.TBitmap;
  var
    Data: FMX.Graphics.TBitmapData;
    I: Integer;
  begin
    Result := VCL.Graphics.TBitmap.Create;
    Result.HandleType := bmDIB;
    Result.PixelFormat := pf32Bit;
    Result.SetSize(ABitmap.Width, ABitmap.Height);
    if ABitmap.Map(TMapAccess.Read, Data) then
    try
      for I := 0 to ABitmap.Height - 1 do
        Move(PAlphaColorArray(Data.Data)[I * (Data.Pitch div 4)], Result.ScanLine[I]^, Result.Width * 4);
    finally
      ABitmap.Unmap(Data);
    end;
  end;

var
  R: TRect;
  B: VCL.Graphics.TBitmap;
//  StyleBitmap: FMX.Graphics.TBitmap;
//  Clone: FMX.Controls.TControl;
////  Scene: IScene;
//  StyledControl: FMX.Controls.TStyledControl;
//  Style: TFmxObject;
//  BaseRect: TRectF;
//  FittingRect: TRectF;
  Preview: FMX.Graphics.TBitmap;
//  T: TFmxObject;
//  StyleName: string;
//  Scale: Single;
//  ADrawCanvas:TDrawCanvas;
//  AItemPaintData:TPaintData;
//  AItemDesignerPanel:TSkinItemDesignerPanel;
//  AListItemStyleReg:TListItemStyleReg;
begin
  try
    R := ARect;
//    if (Value <> '') then
//    begin
      ACanvas.FillRect(ARect);
//      Scene := nil;
//      Style := nil;
//      GetStyledControl(StyledControl, StyleName, Scene);

//      //根据Value获取ItemStyleFrame
//      AListItemStyleReg:=GetGlobalListItemStyleRegList.FindItemByName(Value);
//      if AListItemStyleReg=nil then Exit;


//      if StyledControl <> nil then
//      begin
//        // check
//        if Assigned(StyledControl.Scene) and Assigned(StyledControl.Scene.StyleBook) then
//          Style := StyledControl.Scene.StyleBook.Style
//        else
//          Style := nil;
//        Scene := StyledControl.Scene;
//
//        if StyledControl.Width > StyledControl.Height then
//          BaseRect := RectF(0, 0, 90, 50)
//        else
//          BaseRect := RectF(0, 0, 50, 90);
//      end
//      else if Scene <> nil then
//      begin
//        if Scene.StyleBook <> nil then
//          Style := Scene.StyleBook.Style;
//        if Scene.Canvas <> nil then
//        begin
//          if Scene.Canvas.Width > Scene.Canvas.Height then
//            BaseRect := RectF(0, 0, 90, 50)
//          else
//            BaseRect := RectF(0, 0, 50, 90);
//        end
//        else
//          BaseRect := RectF(0, 0, 90, 50)
//      end;
//
//      if (Style = nil) or (Style.FindStyleResource(Value) = nil) then
//        Style := TStyleManager.ActiveStyleForScene(Scene);

//      // create clone
//      if Style <> nil then
//      begin
//        Clone := FMX.Controls.TControl(Style.FindStyleResource(Value));
//        if Clone <> nil then
//        begin
//          if Scene = nil then
//            Scale := 1
//          else
//            Scale := Scene.GetSceneScale;

//          Preview := FMX.Graphics.TBitmap.Create(Trunc(50 * VCL.Forms.Application.MainForm.CurrentPPI / 96), Trunc(ItemHeight * VCL.Forms.Application.MainForm.CurrentPPI / 96));
          try
//            Preview.BitmapScale := VCL.Forms.Application.MainForm.CurrentPPI / 96;
//            Clone := AListItemStyleReg.FrameClass.Create(nil);//FMX.Controls.TControl(Clone.Clone(nil));
//            try
//              //绑定
////              T := Clone.FindStyleResource('text');
////              if (T <> nil) and (T is TText) then
////              begin
////                if Pos('label', Style.StyleName) = 0 then
////                  TText(T).Text := 'Label'
////                else
////                  TText(T).Text := '';
////              end;
////
////              FittingRect := BaseRect;
////              if not SameValue(Clone.FixedSize.Height, 0) then
////                FittingRect.Height := Clone.FixedSize.Height;
////              if not SameValue(Clone.FixedSize.Width, 0) then
////                FittingRect.Width := Clone.FixedSize.Width;
////
////              Clone.SetBounds(0, 0, FittingRect.Width, FittingRect.Height);
////              Clone.SetNewScene(Scene);
//              AItemDesignerPanel:=(Clone as IFrameBaseListItemStyle).ItemDesignerPanel;
////              StyleBitmap := AItemDesignerPanel.MakeScreenshot;
//              StyleBitmap:=FMX.Graphics.TBitmap.Create(Ceil(AItemDesignerPanel.Width * VCL.Forms.Application.MainForm.CurrentPPI / 96),Ceil(AItemDesignerPanel.Height * VCL.Forms.Application.MainForm.CurrentPPI / 96));
//              StyleBitmap.BitmapScale := VCL.Forms.Application.MainForm.CurrentPPI / 96;
//              StyleBitmap.Canvas.BeginScene;
//              ADrawCanvas:=CreateDrawCanvas('');
//              ADrawCanvas.Prepare(StyleBitmap.Canvas);
//              try
//                ADrawCanvas.Clear(TAlphaColorRec.White,RectF(0, 0, StyleBitmap.Width, StyleBitmap.Height));
//
//                //绘制ItemDesignerPanel的子控件
//                AItemPaintData:=GlobalNullPaintData;
//                AItemPaintData.IsDrawInteractiveState:=True;
//                AItemPaintData.IsInDrawDirectUI:=True;
//
//                AItemDesignerPanel.SkinControlType.Paint(ADrawCanvas,
//                                      AItemDesignerPanel.SkinControlType.GetPaintCurrentUseMaterial,
//                                      RectF(0, 0, StyleBitmap.Width, StyleBitmap.Height),
//                                      AItemPaintData);
//
//
//                AItemDesignerPanel.SkinControlType.DrawChildControls(ADrawCanvas,
//                                      RectF(0, 0, StyleBitmap.Width, StyleBitmap.Height),
//                                      AItemPaintData,
//                                      RectF(0, 0, StyleBitmap.Width, StyleBitmap.Height));
//
//                StyleBitmap.SaveToFile('D:\'+Value+'.png');
//              finally
//                FreeAndNil(ADrawCanvas);
//                StyleBitmap.Canvas.EndScene;
//              end;
//
//
////              Clone.SetNewScene(nil);
//            finally
//              Clone.Free;
//            end;
              Preview:=MakeListItemStyleFrameSnapshot(Value,TAlphaColorRec.White);



//            FittingRect.Fit(RectF(0, 0, Preview.Width, Preview.Height));
//            if Preview.Canvas.BeginScene then
//            try
////              // background
////              Clone := FMX.Controls.TControl(Style.FindStyleResource('backgroundstyle'));
////              if Assigned(Clone) then
////              begin
////                Clone := FMX.Controls.TControl(Clone.Clone(nil));
////                try
////                  Clone.SetBounds(0, 0, 400, 400);
////                  Clone.SetNewScene(Scene);
////                  Clone.PaintTo(Preview.Canvas, Clone.LocalRect);
////                  Clone.SetNewScene(nil);
////                finally
////                  Clone.Free;
////                end;
////              end
////              else
////                Preview.Canvas.Clear($FFBaBaBa);
////              // Style
////              Preview.Canvas.SetMatrix(TMatrix.CreateScaling(1/ Scale, 1/Scale));
//              Preview.Canvas.DrawBitmap(StyleBitmap, RectF(0, 0, StyleBitmap.Width, StyleBitmap.Height), FittingRect, 1);
//            finally
//              Preview.Canvas.EndScene;
//            end;

//            try
              B := FMXBitmapToVCLBitmap(Preview);
              try
                ACanvas.Draw(R.Left+5, R.Top+20, B);
//                Inc(R.Left, B.Width + 4);
                Inc(R.Left, R.Width + 4);       //不画标题了，自己画
              finally
                B.Free;
              end;
//            finally
//              StyleBitmap.Free;
//            end;

          finally
            Preview.Free;
          end;
//        end;
//      end;
//    end;
  finally
    //画上样式名称
//    ACanvas.Font.Color:=clBlack;
    ACanvas.Font.Color:=clWhite;
//    ACanvas.TextOut(ARect.Left,ARect.Bottom-20,Value);
    ACanvas.TextOut(ARect.Left,ARect.Top,Value);

    //画上分隔线
    ACanvas.Pen.Color:=clGray;
    ACanvas.Pen.Style:=TPenStyle.psSolid;
    ACanvas.MoveTo(ARect.Right,ARect.Bottom-1);
    ACanvas.LineTo(ARect.Left,ARect.Bottom-1);
    //默认绘制
    DefaultPropertyListDrawValue(Value, ACanvas, R, ASelected);

  end;
end;

procedure TListItemStyleProperty.ListMeasureHeight(const Value: string;
  ACanvas: VCL.Graphics.TCanvas; var AHeight: Integer);
var
  Preview:FMX.Graphics.TBitmap;
begin
  Preview:=MakeListItemStyleFrameSnapshot(Value,TAlphaColorRec.White);

  if Preview<>nil then
  begin
    AHeight:=Preview.Height+20+5;//上面20画样式名称,底下留5显示边框
  end
  else
  begin
    AHeight := Round(ItemHeight * VCL.Forms.Application.MainForm.CurrentPPI / 96);

  end;

  FreeAndNil(Preview);


end;

procedure TListItemStyleProperty.ListMeasureWidth(const Value: string;
  ACanvas: VCL.Graphics.TCanvas; var AWidth: Integer);
begin
  //
end;

end.
