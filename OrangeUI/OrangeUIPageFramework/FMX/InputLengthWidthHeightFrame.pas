unit InputLengthWidthHeightFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 

  uBasePageStructure,
  uComponentType,
  uPageStructure,

  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit,
  uSkinFireMonkeyControl, uSkinLabelType, uSkinFireMonkeyLabel;

type
  TFrameInputLengthWidthHeight = class(TFrame,IControlForPageFramework)
    SkinFMXLabel4: TSkinFMXLabel;
    edtHeight: TSkinFMXEdit;
    SkinFMXLabel3: TSkinFMXLabel;
    edtWidth: TSkinFMXEdit;
    SkinFMXLabel2: TSkinFMXLabel;
    edtLength: TSkinFMXEdit;
  private
    { Private declarations }
  protected
    //针对页面框架的控件接口
    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting):Boolean;
    //获取与设置自定义属性
    function GetPropJsonStr:String;
    procedure SetPropJsonStr(AJsonStr:String);
    //获取提交的值,是不是存在多个值
    function GetPostValue(ASetting:TFieldControlSetting;APageDataDir:String;ASetRecordFieldValueIntf:ISetRecordFieldValue;
                            var AErrorMessage:String):Variant;
    //设置值
    procedure SetControlValue(ASetting:TFieldControlSetting;APageDataDir:String;
                            AImageServerUrl:String;
                            AValue:Variant;AValueCaption:String;
                            //要设置多个值,整个字段的记录
                            AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue
                            );
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

{ TFrameInputLengthWidthHeight }

function TFrameInputLengthWidthHeight.GetPostValue(ASetting:TFieldControlSetting;APageDataDir: String;
  ASetRecordFieldValueIntf: ISetRecordFieldValue;
                            var AErrorMessage:String): Variant;
begin
  Result:='';
end;

function TFrameInputLengthWidthHeight.GetPropJsonStr: String;
begin
  Result:='';
end;

function TFrameInputLengthWidthHeight.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting): Boolean;
begin
  Result:=True;
end;

procedure TFrameInputLengthWidthHeight.SetControlValue(ASetting:TFieldControlSetting;APageDataDir,
  AImageServerUrl: String; AValue: Variant;AValueCaption:String;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
begin

end;

procedure TFrameInputLengthWidthHeight.SetPropJsonStr(AJsonStr: String);
begin

end;

end.
