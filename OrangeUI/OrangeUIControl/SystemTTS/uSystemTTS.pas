unit uSystemTTS;

interface


uses
  SysUtils,
  Classes,
  uBaseLog,
  SyncObjs,
  FMX.Types,
  FMX.Dialogs,
  FMX.Forms,

  uBaseSystemTTS,
  TextToSpeak,



  {$IFDEF SKIN_SUPEROBJECT}
  uSkinSuperObject,
  {$ELSE}
  XSuperObject,
  XSuperJson,
  {$ENDIF}


  uComponentType,
  uBaseList,
  uBasePageStructure,


//  TextToSpeak,

  {$IFDEF ANDROID}
  //需要引入的单元
//  FMX.Helpers.Android,
  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.Jni.JavaTypes,
  Androidapi.JNI.TTS,
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  SpeechLib_TLB,
  ActiveX,
  {$ENDIF}

  StrUtils;

type
  TSystemTTS=class;

  TSystemTTS=class(TBaseTTS,
                    IControlForPageFramework,
                    ISkinItemBindingControl)
  protected
    //针对页面框架的控件接口
    function LoadFromFieldControlSetting(ASetting:TFieldControlSetting;AFieldControlSettingMap:TObject):Boolean;
    //获取与设置自定义属性
    function GetPropJsonStr:String;
    procedure SetPropJsonStr(AJsonStr:String);
    //获取提交的值
    function GetPostValue(ASetting:TFieldControlSetting;APageDataDir:String;ASetRecordFieldValueIntf:ISetRecordFieldValue;
                            var AErrorMessage:String):Variant;
    //设置值
    procedure SetControlValue(ASetting:TFieldControlSetting;APageDataDir:String;AImageServerUrl:String;AValue:Variant;AValueCaption:String;
                            //要设置多个值,整个字段的记录
                            AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue);
//    //设置属性
//    function GetProp(APropName:String):Variant;
//    procedure SetProp(APropName:String;APropValue:Variant);
    procedure DoReturnFrame(AFromFrame:TFrame);virtual;

  protected
    FBindItemFieldName:String;
    function GetBindItemFieldName:String;
    function GetBindDataSourceName:String;
    procedure SetBindItemFieldName(AValue:String);
    procedure SetBindDataSourceName(AValue:String);
    function GetBindDataSource:TBindDataSource;
    procedure SetBindDataSource(AValue:TBindDataSource);
  published
    property BindItemFieldName:String read GetBindItemFieldName write SetBindItemFieldName;
  end;





  TTTS=class(TSystemTTS)

  end;





//var
//  GlobalSystemTTS:TSystemTTS;


implementation




{ TSystemTTS }


function TSystemTTS.GetBindDataSource: TBindDataSource;
begin
  Result:=nil;
end;

function TSystemTTS.GetBindDataSourceName: String;
begin
  Result:='';
end;

function TSystemTTS.GetBindItemFieldName: String;
begin
  Result:=FBindItemFieldName;
end;

function TSystemTTS.GetPropJsonStr:String;
var
  ASuperObject:ISuperObject;
begin
  ASuperObject:=TSuperObject.Create;

  ASuperObject.I['RepeatTimes']:=RepeatTimes;

  Result:=ASuperObject.AsJson;
  if Result='{}' then
  begin
    Result:='';
  end;
end;

procedure TSystemTTS.SetPropJsonStr(AJsonStr:String);
var
  ASuperObject:ISuperObject;
begin
  ASuperObject:=TSuperObject.Create(AJsonStr);

  if ASuperObject.Contains('RepeatTimes') then RepeatTimes:=ASuperObject.I['RepeatTimes'];
end;

function TSystemTTS.GetPostValue(ASetting:TFieldControlSetting;APageDataDir: String;ASetRecordFieldValueIntf:ISetRecordFieldValue;
                            var AErrorMessage:String): Variant;
begin
  Result:=FText;
end;


function TSystemTTS.LoadFromFieldControlSetting(ASetting: TFieldControlSetting;AFieldControlSettingMap:TObject): Boolean;
begin

end;


procedure TSystemTTS.SetBindDataSource(AValue: TBindDataSource);
begin

end;

procedure TSystemTTS.SetBindDataSourceName(AValue: String);
begin

end;

procedure TSystemTTS.SetBindItemFieldName(AValue: String);
begin
  FBindItemFieldName:=AValue;
end;

procedure TSystemTTS.SetControlValue(ASetting:TFieldControlSetting;APageDataDir, AImageServerUrl: String;AValue: Variant;AValueCaption:String;
                            //要设置多个值,整个字段的记录
                            AGetDataIntfResultFieldValueIntf:IGetDataIntfResultFieldValue);
begin
  Text:=AValue;
end;

////设置属性
//function TSystemTTS.GetProp(APropName:String):Variant;
//begin
//
//end;
//
//procedure TSystemTTS.SetProp(APropName:String;APropValue:Variant);
//begin
//
//end;

procedure TSystemTTS.DoReturnFrame(AFromFrame:TFrame);
begin

end;


initialization
  GetGlobalFrameworkComponentTypeClasses.Add('tts',TTTS,'语音播放');


end.
