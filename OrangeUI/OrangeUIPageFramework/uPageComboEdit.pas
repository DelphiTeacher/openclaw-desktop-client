unit uPageComboEdit;

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

  {$IFDEF FMX}
  FMX.Forms,
  uSkinFireMonkeyComboEdit,
  {$ENDIF}

  {$IFDEF VCL}
  Forms,
  StdCtrls,
  {$ENDIF}

  uComponentType,
  uSkinButtonType,
  uBasePageStructure,
  uPageStructure;

type
  {$IFDEF FMX}
  TSkinComboEdit=class(TSkinFMXComboEdit)
  end;
//  TPageComboEdit=class(TSkinComboEdit,IControlForPageFramework)
  {$ENDIF}

  TPageComboEdit=class({$IFDEF VCL}TCombobox{$ENDIF}{$IFDEF FMX}TSkinComboEdit{$ENDIF},IControlForPageFramework)
  public
    FValues:TStringList;
//    HelpText:String;
    //消息处理
//    procedure WMPaint(var Message:TWMPaint);message WM_PAINT;
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
    procedure DoReturnFrame(AFromFrame:TFrame);
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  end;





implementation


{ TPageComboEdit }

constructor TPageComboEdit.Create(AOwner: TComponent);
begin
  inherited;
  FValues:=TStringList.Create;
end;

destructor TPageComboEdit.Destroy;
begin
  FreeAndNil(FValues);
  inherited;
end;

function TPageComboEdit.GetPostValue(ASetting: TFieldControlSetting;
  APageDataDir: String; ASetRecordFieldValueIntf: ISetRecordFieldValue;
  var AErrorMessage: String): Variant;
//var
//  AStringList:TStringList;
begin

  {$IFDEF FMX}
  Result:=Inherited;//Self.Items[Self.ItemIndex];
  {$ENDIF}
  {$IFDEF VCL}
  if Self.ItemIndex=-1 then
  begin
    Result:='';
    Exit;
  end;
//      Result:=TComboBox(AFieldControlSettingMap.Component).Text;
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

//function TPageComboEdit.GetProp(APropName: String): Variant;
//begin
//
//end;

function TPageComboEdit.GetPropJsonStr: String;
begin

end;

function TPageComboEdit.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting;AFieldControlSettingMap:TObject): Boolean;
begin

  //标准控件
//  Self.Items.CommaText:=ASetting.options_caption;

  {$IFDEF FMX}
  Self.Prop.HelpText:=ASetting.input_prompt;
  Self.ContentMarginsRight:=40;
  {$ENDIF}
  {$IFDEF VCL}
  Self.TextHint:=ASetting.input_prompt;
  {$ENDIF}

  Items.Assign(ASetting.FOptionCaptions);

  FValues.Assign(ASetting.FOptionValues);
  Self.ItemIndex:=-1;
  //因为ItemIndex设置为了-1,但是内容没有清空
  Text:='';


//  if ASetting.text_font_size>0 then//高分屏下字体会变很大
//  begin
//    Self.Font.Size:=ASetting.text_font_size;
//  end;


  Result:=True;
end;

procedure TPageComboEdit.SetControlValue(ASetting: TFieldControlSetting;
  APageDataDir, AImageServerUrl: String; AValue: Variant; AValueCaption: String;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
//var
//  AStringList:TStringList;
begin
  {$IFDEF FMX}
  Self.ItemIndex:=Self.Items.IndexOf(AValue);
  {$ENDIF}
  {$IFDEF VCL}
  //TComboBox(AFieldControlSettingMap.Component).Text:=AValue;
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

//procedure TPageComboEdit.SetProp(APropName: String; APropValue: Variant);
//begin
//
//end;

procedure TPageComboEdit.SetPropJsonStr(AJsonStr: String);
begin

end;



procedure TPageComboEdit.DoReturnFrame(AFromFrame:TFrame);
begin

end;



//procedure TPageComboEdit.WMPaint(var Message: TWMPaint);
//var
//  ADC:HDC;
//  ACanvas:TCanvas;
////  ACanvas:TDrawCanvas;
//begin
//  Inherited;
//
//  //绘制提示文本
//  if (Text='') and (Self.HelpText<>'') then
//  begin
////    Canvas.
////    if Self.GetSkinControlType<>nil then
////    begin
//      ADC := GetDC(Handle);
//      try
//
//        ACanvas:=TCanvas.Create;
//        try
//          ACanvas.Handle:=ADC;
//          ACanvas.Font.Size:=Self.Font.Size;
//          ACanvas.Font.Color:=clGray;
//          ACanvas.TextOut(2,0,HelpText);
//
////        ACanvas:=CreateDrawCanvas('TSkinWinMemo.WMPaint');
////        if ACanvas<>nil then
////        begin
////          try
////            ACanvas.Prepare(DC);
////
////            FPaintData:=GlobalNullPaintData;
////            FPaintData.IsDrawInteractiveState:=True;
////            FPaintData.IsInDrawDirectUI:=False;
////            TSkinMemoDefaultType(Self.GetSkinControlType).CustomPaintHelpText(
////                  ACanvas,
////                  Self.GetCurrentUseMaterial,
////                  RectF(Self.GetClientRect.Left,Self.GetClientRect.Top,Self.GetClientRect.Right,Self.GetClientRect.Bottom),
////                  FPaintData);
////
////          finally
////            FreeAndNil(ACanvas);
////          end;
////        end;
//        finally
//          FreeAndNil(ACanvas);
//        end;
//
//      finally
//        ReleaseDC(Handle,ADC);
//      end;
////    end;
//
//  end;
//
//end;


initialization
  GetGlobalFrameworkComponentTypeClasses.Add('comboedit',TPageComboEdit,'下拉编辑框');

end.
