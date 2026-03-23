unit uMobileDragDropManager;

interface

uses
  Classes,
  SysUtils,
  Types,
  UITypes,
  FMX.Types,
  FMX.Forms,
  FMX.Graphics,
  FMX.Objects,
  FMX.Controls,
  FMX.StdCtrls;


type
  TMobileDragDropManager=class
  private
    FDragControl:TControl;
    FDragSource:TObject;//可以是控件,也可以是Item
    FDragImage:TImage;
    FControlFormOriginRect:TRectF;
    FMouseFormOriginPt:TPointF;
  public
    FIsStartedDrag:Boolean;
    procedure FormMouseMove(AForm:TForm;Shift: TShiftState; AFormX, AFormY: Single);
    procedure FormMouseUp(AForm:TForm;Shift: TShiftState; AFormX, AFormY: Single);

    //开始拖拽
    procedure BeginInternalDrag(const Source: TObject; const ABitmap: TObject;const ARoot:TCommonCustomForm;AControl:TControl;X,Y:Double;AControlRect:TRectF);
    //结束拖拽
    procedure StopDrag();

    destructor Destroy;override;
  end;


var
  GloalMobileDragDropManager:TMobileDragDropManager;


implementation

{ TMobileDragDropManager }

procedure TMobileDragDropManager.BeginInternalDrag(const Source, ABitmap: TObject;const ARoot:TCommonCustomForm;AControl:TControl;X,Y:Double;AControlRect:TRectF);
begin
  FDragSource:=Source;
  FDragControl:=AControl;

  FDragImage:=TImage.Create(nil);
  FDragImage.HitTest:=False;
  FDragImage.Bitmap.Assign(TBitmap(ABitmap));
//  FDragImage.WrapMode:=TImageWrapMode.Stretch;
  FDragImage.WrapMode:=TImageWrapMode.Fit;

  //确定图片在Form中位置

  //鼠标绝对位置,后面要根据鼠标移动，来计算出偏移
  FMouseFormOriginPt:=AControl.LocalToAbsolute(PointF(X,Y));

  //确定出图片的位置
  FControlFormOriginRect:=AControl.LocalToAbsolute(AControlRect);


  FDragImage.Position.X:=FControlFormOriginRect.Left;
  FDragImage.Position.Y:=FControlFormOriginRect.Top;
  FDragImage.Width:=AControlRect.Width;
  FDragImage.Height:=AControlRect.Height;


  FDragImage.Parent:=ARoot;


  FIsStartedDrag:=True;
end;

destructor TMobileDragDropManager.Destroy;
begin

  inherited;
end;

procedure TMobileDragDropManager.FormMouseMove(AForm:TForm;Shift: TShiftState; AFormX, AFormY: Single);
var
  Obj: IControl;
  P:TPointF;
  AMousePos:TPointF;
  ScreenMousePos:TPointF;
var
  D: TDragObject;
  Operation: TDragOperation;
begin
  if not FIsStartedDrag then Exit;
  
  FDragImage.Position.X:=FControlFormOriginRect.Left+(AFormX-FMouseFormOriginPt.X);
  FDragImage.Position.Y:=FControlFormOriginRect.Top+(AFormY-FMouseFormOriginPt.Y);


  AMousePos := PointF(AFormX, AFormY);
  ScreenMousePos := AForm.ClientToScreen(AMousePos);
  Obj := AForm.ObjectAtPoint(ScreenMousePos);
  if Obj <> nil then
  begin
    //响应它的DragDrop方法
    P := Obj.ScreenToLocal(ScreenMousePos);

    Fillchar(D, SizeOf(D), 0);
    D.Source := FDragSource;
    Obj.DragOver(D,P,Operation);
  end;



end;

procedure TMobileDragDropManager.FormMouseUp(AForm:TForm;Shift: TShiftState; AFormX, AFormY: Single);
var
  Obj: IControl;
  P:TPointF;
  AMousePos:TPointF;
  ScreenMousePos:TPointF;
var
  D: TDragObject;
begin
  if not FIsStartedDrag then Exit;

  AMousePos := PointF(AFormX, AFormY);
  ScreenMousePos := AForm.ClientToScreen(AMousePos);
  Obj := AForm.ObjectAtPoint(ScreenMousePos);
  if Obj <> nil then
  begin
    //响应它的DragDrop方法
    P := Obj.ScreenToLocal(ScreenMousePos);

    Fillchar(D, SizeOf(D), 0);
    D.Source := FDragSource;
    Obj.DragDrop(D,P);
  end;

  StopDrag();
end;

procedure TMobileDragDropManager.StopDrag();
var
  Obj: IControl;
  P:TPointF;
  AMousePos:TPointF;
  ScreenMousePos:TPointF;
begin
  IControl(FDragControl).DragEnd;

  FIsStartedDrag:=False;
  FreeAndNil(FDragImage);
end;

initialization
  GloalMobileDragDropManager:=TMobileDragDropManager.Create;

finalization
  FreeAndNil(GloalMobileDragDropManager);

end.
