//convert pas to utf8 by
unit uLang;

interface

{$IF DEFINED(ANDROID) OR DEFINED(IOS) OR DEFINED(MACOS) }
  {$DEFINE FMX}
{$IFEND}


{$IFNDEF FMX}
  {$IFNDEF VCL}
    {$I FrameWork.inc}
  {$ENDIF}
{$ENDIF}



uses
//  {$IFDEF FMX}
//  //安卓服务中不能有FMX.***的单元。不然服务启动不成功
////  FMX.Types,
////  FMX.Forms,
////  FMX.Controls,
//  {$ENDIF}

//  {$IFDEF VCL}
//  Controls,
//  {$ENDIF}

  {$IFDEF MSWINDOWS}
    {$IFDEF DELPHIXE8}
    Winapi.Windows,
    {$ELSE}
    Windows,
    Forms,
    {$ENDIF}
  {$ENDIF}


  Classes,
  SysUtils,
  StrUtils;


const
  IID_ILangProcess:TGUID='{7893099B-0F42-4EFA-81ED-47F2278D9856}';





type
  //控件Parent的类,以及子控件的类型,用于遍历子控件
//  {$IFDEF VCL}
//    //在VCL下,父控件是WinControl,可以放子控件在里面
//    TParentControl=TWinControl;
//    TChildControl=TControl;
//  {$ENDIF}
//  {$IFDEF FMX}
//    TParentControl=TFmxObject;
//    TChildControl=TFmxObject;
//  {$ELSE}
//      {$IFDEF LINUX}
//      TControl=TObject;
//      TParentControl=TObject;
//      TChildControl=TObject;
//      TLang=TObject;
//      {$ENDIF}
//  {$ENDIF}
//
//
//  {$IFDEF MSWINDOWS}
//  {$ENDIF}





  //语言类型(中文,英文)
  TLangKind=(lkZH,
              lkEN,
              //?
              lkTag);

  //High(TLangKind)+1存放Tag
  TLangStrings=array[Low(TLangKind)..High(TLangKind)] of string;


//  {$IFDEF VCL}
  TLang = class//(TFmxObject)
  private
    FLang: string;
    FResources: TStrings;
    FOriginal: TStrings;
    FAutoSelect: Boolean;
    FFileName: string;
    FStoreInForm: Boolean;
    procedure SetLang(const Value: string);
    function GetLangStr(const Index: string): TStrings;
//  protected
//    { vcl }
//    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadResources(Stream: TStream);
    procedure WriteResources(Stream: TStream);
//    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent);// override;
    destructor Destroy; override;
  public
    procedure AddLang(const AName: string);
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    property Original: TStrings read FOriginal;
    property Resources: TStrings read FResources;
    property LangStr[const Index: string]: TStrings read GetLangStr;
  published
    property AutoSelect: Boolean read FAutoSelect write FAutoSelect default True;
    property FileName: string read FFileName write FFileName;
    property StoreInForm: Boolean read FStoreInForm write FStoreInForm default True;
    property Lang: string read FLang write SetLang;
  end;
//  {$ENDIF}


  TLangKindStringArray=array[Low(TLangKind)..High(TLangKind)] of string;


  ILangProcess=interface
    ['{7893099B-0F42-4EFA-81ED-47F2278D9856}']
    //记录多语言的索引
    procedure RecordControlLangIndex(APrefix:String;ALang:TLang;ACurLang:String);
    //翻译
    procedure TranslateControlLang(APrefix:String;ALang:TLang;ACurLang:String);
  end;







var
  //原多语言处理-已废弃
  LangStrings:array of TLangStrings;
  LangStringsCount:Integer;




var
  //多语言组件
  GlobalLang:TLang;
  //是否启用多语言
  IsEnableMultiLang:Boolean;


var
  LangKind:TLangKind;



//当前的语言,比如cn,en,jp等,用于保存到
function GlobalCurLang:String;




//原多语言处理-已废弃
procedure RegLangString(const ALangTag:String;const ALangKind:TLangKind;const ALangString:String);overload;
procedure RegLangString(const ALangTag:String;const ALangStrings:Array of String);overload;
function FindLangStringIndex(const ALangTag:String):Integer;
function GetLangString(const ALangTag:String;const ALangKind:TLangKind):String;overload;
function GetLangString(const ALangStrings:Array of String):String;overload;




//新多语言处理
//记录多语言的索引到ALang
procedure RecordLangIndex(ALang:TLang;
                          AIndex:String;
                          ARecLang:String;
                          ARecLangIndexValue:String);
//从ALang获取索引的翻译
function GetLangValue(ALang:TLang;
                      AIndex:String;
                      ACurLang:String):String;
//记录语言索引并获取翻译,二合一
function RecAndTrans(ALang:TLang;
                      AIndex:String;
                      ARecLang:String;
                      ARecLangIndexValue:String;
                      ATransLang:String):String;

//记录语言索引到中文并获取翻译,二合一
function Trans(AIndex:String):String;



{$IFDEF MSWINDOWS}
function GetWindowsLanguage: string;
function GetWindowsLanguage1(LCTYPE: LCTYPE {type of information}): string;
{$ENDIF MSWINDOWS}


implementation


{$IFDEF MSWINDOWS}
function GetWindowsLanguage: string;
var
  WinLanguage: array [0..50] of char;
begin
  VerLanguageName(GetSystemDefaultLangID, WinLanguage, 50);
  Result := StrPas(WinLanguage);
end;

{********************************************************************}
{ another code:
{********************************************************************}

function GetWindowsLanguage1(LCTYPE: LCTYPE {type of information}): string;
var
  Buffer : PChar;
  Size : integer;
begin
  Size := GetLocaleInfo (LOCALE_USER_DEFAULT, LCType, nil, 0);
  GetMem(Buffer, Size);
  try
    GetLocaleInfo (LOCALE_USER_DEFAULT, LCTYPE, Buffer, Size);
    Result := string(Buffer);
  finally
    FreeMem(Buffer);
  end;
end;


//Caption := GetWindowsLanguage1(LOCALE_SABBREVLANGNAME);
//(*
//LOCALE_ILANGUAGE { language id }
//LOCALE_SLANGUAGE { localized name of language }
//LOCALE_SENGLANGUAGE { English name of language }
//LOCALE_SABBREVLANGNAME { abbreviated language name }
//LOCALE_SNATIVELANGNAME { native name of language }
//*)
{$ENDIF MSWINDOWS}


function GetLangString(const ALangStrings:Array of String):String;overload;
begin
  Result:=ALangStrings[0];
  
  if Ord(LangKind)>Length(ALangStrings)-1 then
  begin
    Result:=ALangStrings[Ord(LangKind)];
  end;
end;







function GetLangValue(ALang:TLang;AIndex:String;ACurLang:String):String;
begin
  Result:='';
  {$IFDEF LINUX}
  {$ELSE}
  //存在索引
  if ALang.Original.IndexOf(AIndex)<>-1 then
  begin
    //存在语言
    if ALang.Resources.IndexOf(ACurLang)<>-1 then
    begin
      //获取翻译
      Result:=ALang.LangStr[ACurLang].Values[AIndex];
    end;
  end;
  {$ENDIF}
end;


//记录语言索引到中文并获取翻译,二合一
function Trans(AIndex:String):String;
begin
  Result:=AIndex;//
//          RecAndTrans(GlobalLang,
//                      AIndex,
//                      'cn',
//                      AIndex,
//                      GlobalCurLang);
end;


//记录并翻译语言索引
function RecAndTrans(
                    ALang:TLang;
                    AIndex:String;
                    ARecLang:String;
                    ARecLangIndexValue:String;
                    ATransLang:String):String;
begin
  if IsEnableMultiLang then
  begin
    RecordLangIndex(ALang,AIndex,ARecLang,ARecLangIndexValue);

    Result:=GetLangValue(ALang,
                         AIndex,
                         ATransLang
                          );
  end;

  if not IsEnableMultiLang or (Result='') then
  begin
    Result:=ARecLangIndexValue;
  end;
end;

procedure RecordLangIndex(ALang:TLang;AIndex:String;ARecLang:String;ARecLangIndexValue:String);
begin
  {$IFDEF MSWINDOWS}
  //不存在索引
  if ALang.Original.IndexOf(AIndex)=-1 then
  begin
    //添加索引
    ALang.Original.Add(AIndex);

    //不存在语言
    if ALang.Resources.IndexOf(ARecLang)=-1 then
    begin
      //添加语言
      ALang.AddLang(ARecLang);
    end;

    //添加翻译
    ALang.LangStr[ARecLang].Values[AIndex]:=ARecLangIndexValue;
  end;
  {$ENDIF}
end;

function FindLangStringIndex(const ALangTag:String):Integer;
var
  I: Integer;
begin
  Result:=-1;
  if ALangTag<>'' then
  begin
    for I := 0 to LangStringsCount-1 do
    begin
      if LangStrings[I][lkTag]=ALangTag then
      begin
        Result:=I;
        Break;
      end;
    end;
  end;
end;

procedure RegLangString(const ALangTag:String;const ALangStrings:Array of String);overload;
begin
  if (ALangTag<>'') then
  begin
    if FindLangStringIndex(ALangTag)=-1 then
    begin
      if LangStringsCount<Length(LangStrings) then
      begin
        LangStrings[LangStringsCount][lkTag]:=ALangTag;
        LangStrings[LangStringsCount][lkZH]:=ALangStrings[0];
        LangStrings[LangStringsCount][lkEN]:=ALangStrings[1];
        LangStringsCount:=LangStringsCount+1;
      end
      else
      begin
      end;

    end;
  end;
end;

procedure RegLangString(const ALangTag:String;const ALangKind:TLangKind;const ALangString:String);
begin
  if (ALangTag<>'') and (Trim(ALangString)<>'') then
  begin
    if FindLangStringIndex(ALangTag)=-1 then
    begin
      if LangStringsCount<Length(LangStrings) then
      begin
        LangStrings[LangStringsCount][lkTag]:=ALangTag;
        LangStrings[LangStringsCount][ALangKind]:=ALangString;
        LangStringsCount:=LangStringsCount+1;
      end
      else
      begin
      end;

    end;
  end;
end;

function GetLangString(const ALangTag:String;const ALangKind:TLangKind):String;
var
  AIndex: Integer;
begin
  if ALangTag<>'' then
  begin
    AIndex:=FindLangStringIndex(ALangTag);
    if AIndex<>-1 then
    begin
      Result:=LangStrings[AIndex][ALangKind];
    end;
  end;
end;

//{$IFDEF VCL}

{ TLang }

function ReadString(S: TStream): string;
var
  L: Integer;
begin
  L := 0;
  S.Read(L, SizeOf(L));
  SetLength(Result, L);
  S.Read(Pointer(Result)^, L * 2);
end;

procedure WriteString(S: TStream; const Value: string);
var
  L: Integer;
begin
  L := Length(Value);
  S.Write(L, SizeOf(L));
  S.Write(Pointer(Value)^, L * 2);
end;

constructor TLang.Create(AOwner: TComponent);
begin
  FOriginal := TStringList.Create;
  FResources := TStringList.Create;
  FAutoSelect := True;
  FStoreInForm := True;
end;

destructor TLang.Destroy;
var
  I: Integer;
  AObject:TObject;
begin
  for I := 0 to FResources.Count - 1 do
  begin
    AObject:=TStrings(FResources.Objects[I]);
    FreeAndNil(AObject);//.DisposeOf;
  end;
  FreeAndNil(FResources);
  FreeAndNil(FOriginal);
  inherited;
end;

//procedure TLang.Loaded;
//var
//  LocaleSvc: IFMXLocaleService;
//begin
//  inherited;
//  if not FFileName.IsEmpty then
//    if FileExists(FFileName) then
//      LoadFromFile(FFileName);
//  if FAutoSelect and TPlatformServices.Current.SupportsPlatformService(IFMXLocaleService, LocaleSvc) then
//    FLang := LocaleSvc.GetCurrentLangID;
//  if FLang <> '' then
//    LoadLangFromStrings(LangStr[FLang]);
//end;
//
//procedure TLang.DefineProperties(Filer: TFiler);
//begin
//  inherited;
//  Filer.DefineBinaryProperty('ResourcesBin', ReadResources, WriteResources, StoreInForm and (FResources.Count > 0));
//end;

procedure TLang.ReadResources(Stream: TStream);
var
  len: Cardinal;
  I: Integer;
  N: string;
  Str: TStrings;
begin
  FOriginal.Text := ReadString(Stream);
  Stream.Read(len, 4);
  for I := 0 to len - 1 do
  begin
    N := ReadString(Stream);
    Str := TStringList.Create;
//    TStringList(Str).Sorted := True;
    TStringList(Str).CaseSensitive := True;
    Str.Text := ReadString(Stream);
    FResources.AddObject(N, Str);
  end;
end;

procedure TLang.WriteResources(Stream: TStream);
var
  len: Cardinal;
  I: Integer;
begin
  WriteString(Stream, FOriginal.Text);
  len := FResources.Count;
  Stream.Write(len, 4);
  for I := 0 to len - 1 do
  begin
    WriteString(Stream, FResources[I]);
    WriteString(Stream, TStrings(FResources.Objects[I]).Text);
  end;
end;

procedure TLang.LoadFromFile(const AFileName: string);
var
  S: TFileStream;
begin
  if FileExists(AFileName) then
  begin
    S := TFileStream.Create(AFileName, fmOpenRead);
    try
      ReadResources(S);
    finally
      S.Free;
    end;
  end;
end;

procedure TLang.SaveToFile(const AFileName: string);
var
  S: TFileStream;
begin
  S := TFileStream.Create(AFileName, fmCreate);
  try
    WriteResources(S);
  finally
    S.Free;
  end;
end;

procedure TLang.AddLang(const AName: string);
var
  Idx: Integer;
  Str: TStrings;
begin
  Idx := FResources.IndexOf(AName);
  if Idx < 0 then
  begin
    Str := TStringList.Create;
//    TStringList(Str).Sorted := True;
    TStringList(Str).CaseSensitive := True;
    FResources.AddObject(AName, Str);
  end;
end;

function TLang.GetLangStr(const Index: string): TStrings;
var
  Idx: Integer;
begin
  Idx := FResources.IndexOf(Index);
  if Idx >= 0 then
    Result := TStrings(FResources.Objects[Idx])
  else
    Result := nil;
end;

procedure TLang.SetLang(const Value: string);
begin
  FLang := Value;
//  if not(csLoading in ComponentState) then
//  begin
//    if FLang = 'en' then
//      ResetLang
//    else
//      LoadLangFromStrings(LangStr[FLang]);
//  end;
end;
//{$ENDIF VCL}

function GlobalCurLang:String;
begin
  case LangKind of
    lkZH:Result:='cn';
    lkEN:Result:='en';
  end;
end;

initialization
  SetLength(LangStrings,2048);


  {$IFDEF LINUX}
  {$ELSE}
  GlobalLang:=TLang.Create(nil);
  {$ENDIF}


//  //当前的语言
//  GlobalCurLang:='cn';
  //chinese
  LangKind:=TLangKind.lkZH;


  {$IFDEF MSWINDOWS}
  if GetWindowsLanguage<>'中文(简体，中国)' then
  begin
//    //当前的语言
//    GlobalCurLang:='en';
    //中文
    LangKind:=TLangKind.lkEN;
  end;
  {$ENDIF}






finalization
  SetLength(LangStrings,0);
  FreeAndNil(GlobalLang);

end.

