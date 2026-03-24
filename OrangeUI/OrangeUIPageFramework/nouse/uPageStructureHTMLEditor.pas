unit uPageStructureHTMLEditor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  Controls,

//  MailHTMLEditFrame,

  uFileCommon,
  uBasePageStructure,
  uComponentType,
  uPageStructure;

type
  TPageStructureHTMLEditor=class(TWinControl,IControlForPageFramework)
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
    //设置属性
    function GetProp(APropName:String):Variant;
    procedure SetProp(APropName:String;APropValue:Variant);
  end;




implementation



{ TPageStructureHTMLEditor }

function TPageStructureHTMLEditor.GetPostValue(ASetting: TFieldControlSetting;
  APageDataDir: String; ASetRecordFieldValueIntf: ISetRecordFieldValue;
  var AErrorMessage: String): Variant;
begin
//  Result:=HTMLSource;
end;

function TPageStructureHTMLEditor.GetProp(APropName: String): Variant;
begin
  Result:='';
end;

function TPageStructureHTMLEditor.GetPropJsonStr: String;
begin
  Result:='';
end;

function TPageStructureHTMLEditor.LoadFromFieldControlSetting(
  ASetting: TFieldControlSetting): Boolean;
begin
  Result:=True;
end;

procedure TPageStructureHTMLEditor.SetControlValue(
  ASetting: TFieldControlSetting; APageDataDir, AImageServerUrl: String;
  AValue: Variant; AValueCaption: String;
  AGetDataIntfResultFieldValueIntf: IGetDataIntfResultFieldValue);
begin
//  Self.HTMLSource:=AValue;
end;

procedure TPageStructureHTMLEditor.SetProp(APropName: String;
  APropValue: Variant);
begin

end;

procedure TPageStructureHTMLEditor.SetPropJsonStr(AJsonStr: String);
begin
  //
end;


initialization
  GetGlobalFrameworkComponentTypeClasses.Add('html_editor',TPageStructureHTMLEditor,'网页编辑器');

end.
