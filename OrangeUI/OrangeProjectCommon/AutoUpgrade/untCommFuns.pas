unit untCommFuns;

///
/// 通用函数
///
/// Version 1.0
///
///
///
///

{$define USECRITICALSECTION}
interface

uses
  Classes, Windows, Variants;

type


  TIntList = class;

  TStrKeyValData = record
    Key: string;
    Val: string;
  end;

  TStrSplitReader = record
    LData: PChar;
    Split: Char;
    procedure Init(const s: string; ASplit: Char = ',');
    function Next(var AVal: string): Boolean;
    function NexTag: string;
  end;


  TTIntListEnumerator = class
  private
    FIndex: Integer;
    FDataSet: TIntList;
  public
    constructor Create(ADataSet: TIntList);
    function GetCurrent: integer;
    function MoveNext: Boolean;
    property Current: integer read GetCurrent;
  end;

  TIntList = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItems(Index: Integer): Integer;
    procedure SetItems(Index: Integer; const Value: Integer);

  public
    constructor Create;
    destructor Destroy; override;
    function  GetEnumerator: TTIntListEnumerator;

    procedure Clear;
    procedure Sort;
    procedure Add(AVal: integer);
    function IndexOf(AVal: integer): Integer;
    function Exists(AVal: Integer): Boolean;
    procedure Remove(AVal: integer);
    property Items[Index: Integer]: Integer read GetItems write SetItems; default;
    property Count: Integer read GetCount;
  end;

  TMutex = class
  {$ifdef USECRITICALSECTION}
  protected
    fLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
  {$endif}
  public
    procedure Enter;
    procedure Leave;
  end;


  TGetParamValFun = reference to function(const AName: string): string;

type
  // 字符读取选项
  TReadStrOptions = set of (
      rsoBrackets     //  包含括号， 括号为一个整体
      );

function IsSubStringVal(const ASub, AData: string; Split: Char = ','): Boolean;
function TryReadNextValue(var p: PWideChar; var AVal: string; Split: Char = ','; AOpts: TReadStrOptions = []): Boolean;
function TryReadSegmentValue(const s: string; Index: Integer; var AVal: string; Split: Char = '='): Boolean;
function ReadSegmentValue(const s: string; Index: Integer; Split: Char = '='): string;
function CharPos(ATag: Char; const s: string; AIndex: Integer = 1): Integer;
function ExtractSegmentValue(const s: string; ABeginTag, AEndTag: Char): string;

procedure DequotedStrBracket(var s: string);
function DequotedBracket(const s: string): string;

function ReadKeyValData(const AData: string; Split: Char = '='): TStrKeyValData;
function ParserStringToDate(s: String; out ADay: TDateTime): Boolean;
function ParserStringToDateTime(const s: String; out ADay: TDateTime): Boolean;
function ParserStringToTime(s: String; out ATime: TDateTime): Boolean;

function RectToString(const r: TRect): string;
function TryStrToRect(const s: string; var r: TRect): boolean;

function ReplaceParams(const s: string; AGetValFun: TGetParamValFun): string;
function FormatVarParams(const s: string; const ArgBoths: array of string): string;

// variant funs
function VarToFloat(const v:variant): Extended;
function VarToInt(const v: variant; ADefVal:integer = 0): Integer;
function VarToInt64(const v: variant; ADefVal:Int64 = 0): Int64;
function VarToBool(const v: variant; ADef:Boolean = False): boolean;
function v2s(const v: Variant; const ADef: string = ''): string; inline;

function iif(ATest: Boolean; const ATrue: Integer; const AFalse: Integer): Integer; overload;
function iif(ATest: Boolean; const ATrue: string; const AFalse: string = ''): string; overload; { do not localize }
function iif(ATest: Boolean; const ATrue: Boolean; const AFalse: Boolean): Boolean; overload;

//function StrPosI(const sub, data: string; beginidx: Integer = 1): Integer;
//function StrSameI(const s1, s2: string): boolean; inline;
function PCharToStr(s: PChar): string;


type
  TJoinOptStrOptions = set of (jsoBrackets, jsoOutBrackets);

function JoinOptStr(const s: string; const ALink, ASub: string; AOpts: TJoinOptStrOptions = []): string;
procedure JoinOptString(var s: string; const ALink, ASub: string; AOpts: TJoinOptStrOptions = []);
function IsJsonStr(const s: string): boolean;



implementation

uses
  SysUtils;



function StrPosI(const sub, data: string; beginidx: Integer = 1): Integer;
var
  pData: PChar;
  pStart: PChar;
begin
  Result := 0;
  if sub = '' then
    Exit;

  pData := PChar(data);
  pStart := pData;
  if (beginidx <= 1) or (beginidx < integer(StrLen(pStart))) then
  begin
    if beginidx > 1 then
      inc(pStart, beginidx - 1);

    pStart := TextPos(pStart, PChar(sub));
    if assigned(pStart) then
      Result := pStart - pData + 1;
  end;
end;

function StrSameI(const s1, s2: string): boolean;
begin
  Result := SameText(s1, s2);
end;

function PCharToStr(s: PChar): string;
begin
  if Assigned(s) then Result := s
  else Result := '';
end;


function JoinOptStr(const s: string; const ALink, ASub: string; AOpts: TJoinOptStrOptions = []): string;
var
  bAddRightBrackets: Boolean;
  l, r: string;
  d: string;
begin
  // 链接 SQL 条件语句

  l := Trim(s);
  r := Trim(ASub);
  bAddRightBrackets := (r <> '') and (AOpts * [jsoBrackets] <> []);
  if bAddRightBrackets then
    r := format('(%s)', [r]);

  if l = '' then d := r
  else if r = '' then d := l
  else d := format('%s %s %s', [l, ALink, r]);

  if (d <> '') and (AOpts * [jsoOutBrackets] <> []) then
  begin
    if (l <> '') or not bAddRightBrackets then
      d := format('(%s)', [d]);
  end;

  Result := d;
end;

procedure JoinOptString(var s: string; const ALink, ASub: string; AOpts: TJoinOptStrOptions = []);
begin
  s := JoinOptStr(s, ALink, ASub, AOpts);
end;

function SortIntComp(Item1, Item2: Pointer): Integer;
begin
  Result := integer(Item1) - integer(Item2);
end;

function ReplaceParams(const s: string; AGetValFun: TGetParamValFun): string;
type
  TCharType = (ctNone, ctBof, ctEof, ctStr, ctLeftBK, ctRightBK, ctQuote);

  function CharToType(c: char): TCharType; inline;
  begin
    case c of
      '[': Result := ctLeftBK;
      ']': Result := ctRightBK;
      #39: Result := ctQuote;
      #0 : Result := ctEof;
      else Result := ctStr;
    end;
  end;

var
  cStr: TStringBuilder;
  iLen, iCur, iPlace: integer;
  ipt, ict: TCharType;
  iBKCnt: integer;
begin
  iLen := Length(s);
  if iLen < 2 then
  begin
    Result := s;
    Exit;
  end;

  iBKCnt := 0;
  iPlace := 1;
  cStr := TStringBuilder.Create;
  try
    ipt := CharToType(s[1]);
    if ipt = ctLeftBK then inc(iBKCnt)
    else if ipt in [ctRightBK] then ipt := ctStr;

    for iCur := 2 to iLen + 1 do
    begin
      ict := ctNone;
      case CharToType(s[iCur]) of
        ctLeftBK:
        begin
          if ipt <> ctQuote then
          begin
            inc(iBKCnt);
            if iBkCnt = 1 then
              ict := ctLeftBK;
          end;
        end;
        ctRightBK:
        begin
          if ipt =  ctLeftBK then
          begin
            dec(iBKCnt);
            if iBKCnt = 0 then ict := ctRightBK;
          end;
        end;
        ctQuote:
        begin
          if ipt in [ctStr, ctRightBK] then ict := ctQuote
          else if ipt = ctQuote then ict := ctStr;
        end;
        ctEof : ict := ctEof;
        ctStr : if (ipt <> ctLeftBK) and (ipt in [ctStr, ctRightBk]) then ict := ctStr;
      end;
      if ipt = ctRightBK then iPlace := iCur;

      case ict of
        ctLeftBK:
        begin
          if iCur - iPlace > 0 then
            cStr.Append(s, iPlace - 1, iCur - iPlace);
          iPlace := iCur;
          ipt := ict;
        end;
        ctRightBK:
        begin
          if iCur - iPlace - 1 > 0 then
            cStr.Append(AGetValFun(Copy(s, iPlace + 1, iCur - iPlace - 1)));
          iPlace := iCur;
          ipt := ict;
        end;
        ctStr,
        ctQuote: ipt := ict;
        ctEof : if (ipt <> ctRightBK) and (iCur - iPlace > 0) then
                  cStr.Append(s, iPlace - 1, iCur - iPlace);
      end;
    end;
    Result := cStr.ToString;
  finally
    cStr.free;
  end;
end;

function FormatVarParams(const s: string; const ArgBoths: array of string): string;
var
  i: Integer;
  iCnt: integer;
  rNames: array of string;
  rValues: array of string;
begin
  /// 格式化参数
  assert(Length(ArgBoths) mod 2 = 0, '输入的参数必须是成对，名称，值，名称2，值2...');
  iCnt := Length(ArgBoths) div 2;
  if iCnt = 0 then
  begin
    Result := s;
    Exit;
  end;

  SetLength(rNames, iCnt);
  SetLength(rValues, iCnt);
  for i := 0 to iCnt - 1 do
  begin
    rNames[i] := ArgBoths[i * 2];
    rValues[i] := ArgBoths[i * 2 + 1];
  end;

  Result := ReplaceParams(s,
        function(const AName: string): string
        var i, idx: integer;
        begin
          idx := -1;
          for i := 0 to iCnt - 1 do
            if SameText(rNames[i], AName) then
            begin
              idx := i;
              break;
            end;
          if idx >= 0 then Result := rValues[i]
          else Result := AName;
        end);
end;


function VarToFloat(const v:variant): Extended;
var
  code: Integer;
  sVal: string;
begin
  case VarType(v) of
    varSingle, varDouble, varCurrency:
      Result := v;
    varSmallInt, varInteger, varBoolean, varShortInt,
    varByte, varWord, varLongWord, varInt64, varUInt64:
      Result := v;
    varOleStr, varString,varUString:
    begin
      sVal := VarToStrDef(v, '0');
      Val(sVal, Result, code);
      // code <> 0 只有部分转换
    end;
    varNull:
      Result := 0.0;

    else
    begin
      sVal := VarToStrDef(v, '0');
      Val(sVal, Result, code);
      // code <> 0 只有部分转换
    end;
  end;
end;

function IsSubStringVal(const ASub, AData: string; Split: Char = ','): Boolean;
var
  pData: PChar;
  pVal: PChar;
begin
  Result := False;
  if (ASub = '') or (AData = '') then
    Exit;

  pData := PChar(AData);
  pVal := StrPos(pData, PChar(ASub));
  Result := assigned(pVal) and
            ((pData = pVal) or ((pVal - 1)^ = Split)) and
            CharInSet((pVal + Length(ASub))^, [Split, #0]);
end;


function ReadNextValue(var p: PWideChar; Split: Char = ','): string;
var s: PWideChar;
begin
  if p^ = Split then
  begin
    inc(P);
    Result := '';
  end
  else if p^ <> #0 then
  begin
    s := p;
    while (p^ <> #0) and (p^ <> Split) do Inc(P);
    SetString(Result, s, p - s);
    if p^ = Split then
      inc(p);
  end
  else
    Result := '';
end;

function TryReadNextValue(var p: PWideChar; var AVal: string; Split: Char = ',';
    AOpts: TReadStrOptions = []): Boolean;
begin
  Result := False;
  //while (p^ <> #0) and (p^ = Split) do Inc(P);
  if (p <> nil) and (p^ <> #0) then
  begin
    AVal := ReadNextValue(p, Split);
    Result := True;
  end;
end;

function TryReadSegmentValue(const s: string; Index: Integer; var AVal:
    string; Split: Char = '='): Boolean;
var
  iCnt: Integer;
  p: PChar;
  sDump: string;
begin
  p := PChar(s);
  iCnt := 0;
  while (iCnt < Index) and TryReadNextValue(p, sDump, Split) do
    inc(iCnt);
  Result := (iCnt = Index) and TryReadNextValue(p, AVal, Split);
end;

function ReadSegmentValue(const s: string; Index: Integer; Split: Char = '='): string;
begin
  if not TryReadSegmentValue(s, Index, Result, Split) then
    Result := '';
end;

function CharPos(ATag: Char; const s: string; AIndex: Integer = 1): Integer;
var
  I: Integer;
begin
  Result := 0;
  if AIndex < 1 then AIndex := 1;
  for I := AIndex to Length(s) do
    if s[i] = ATag then
    begin
      Result := i;
      Break;
    end;
end;

function ExtractSegmentValue(const s: string; ABeginTag, AEndTag: Char): string;
var
  iBegin: Integer;
  iEnd: Integer;
begin
  iBegin := CharPos(ABeginTag, s);
  iEnd := CharPos(AEndTag, s, iBegin + 1);
  Result := '';
  if (iBegin > 0) and (iEnd > iBegin) then
    Result := Copy(s, iBegin + 1, iEnd - iBegin - 1);
end;

function ReadKeyValData(const AData: string; Split: Char = '='): TStrKeyValData;
var
  idx: Integer;
  I: Integer;
  iLen: Integer;
begin
  idx := 0;
  iLen := Length(AData);
  for I := 1 to iLen do
    if AData[i] = Split then
    begin
      idx := i;
      Break;
    end;

  if idx > 0 then
  begin
    Result.Key := Copy(AData, 1, i-1);
    Result.Val := Copy(AData, i + 1, iLen);
  end
  else
  begin
    Result.Key := '';
    Result.Val := AData;
  end;
end;


function GetCharPlace(c: Char; const s: string; off: Integer = 1): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := off to Length(s) do
    if s[i] = c then
    begin
      Result := i;
      Break;
    end;
end;


function ParserStringToDate(s: String; out ADay: TDateTime): Boolean;
var
  rV:array [0..2] of Integer;
  iCnt, iCurVal, iOff, iSplit, iLen: Integer;
  rCurDate: TSystemTime;
  I: Integer;
begin
  Result := False;
  s := Trim(s);
  if TryStrToDate(s, ADay) then
  begin
    Result := True;
    Exit;
  end;

  iLen := Length(s);
  iOff := 1;
  iCnt := 0;
  while iOff <= iLen do
  begin
    iSplit := 0;
    for i := iOff to iLen do
      if (s[i] = '-') or (s[i] = '/') then
      begin
        iSplit := i;
        Break;
      end;
    if iSplit = 0 then
      iSplit := iLen + 1;

    if not TryStrToInt(Copy(s, iOff, iSplit - iOff), iCurVal) then
    begin
      iCnt := 0;
      Break;
    end;

    rV[iCnt] := iCurVal;
    inc(iCnt);
    iOff := iSplit + 1;
  end;

  if iCnt = 3 then
  begin
    if rV[0] < 100 then rV[0] := 2000 + rV[0];
    Result := TryEncodeDate(rV[0], rV[1], rV[2], ADay)
  end
  else if iCnt > 0 then
  begin
    GetLocalTime(rCurDate);
    if iCnt = 1 then
      Result := TryEncodeDate(rCurDate.wYear, rCurDate.wMonth, rV[0], ADay)
    else if iCnt = 2 then
      Result := TryEncodeDate(rCurDate.wYear, rV[0], rV[1], ADay)
  end;
end;

function ParserStringToTime(s: String; out ATime: TDateTime): Boolean;
var
  rV:array [0..4] of Integer;
  rS: array [0..4] of string;
  i, iCnt, iCurVal: Integer;
  v: string;
  p: PChar;
begin
  if s = '' then
    Exit(False);

  if TryStrToDate(s, ATime) then
  begin
    Result := True;
    Exit;
  end;

  s := Trim(s);
  p := PChar(s);
  iCnt := 0;
  while TryReadNextValue(p, v, ':') do
  begin
    rS[iCnt] := v;
    inc(iCnt);
  end;
  // 秒处理
  if (rS[2] <> '') and (Length(rs[2]) > 2 ) then
  begin
    rs[3] := Copy(rs[2], 4, MaxInt);
    rs[2] := Copy(rs[2], 1, 2);
  end;

  for I := 0 to 4 do
  begin
    rv[i] := 0;
    if (rs[i] <> '') and TryStrToInt(rs[i], iCurVal) then
      rv[i] := iCurVal;
  end;

  Result := TryEncodeTime(rv[0], rv[1], rv[2], rv[3], ATime)
end;

function ParserStringToDateTime(const s: String; out ADay: TDateTime): Boolean;
var
  iSpace: Integer;
  dDate, dTime: TDateTime;
  sDate: string;
  sTime: string;
begin
  Result := False;
  sDate := Trim(s);
  sTime := '';
  iSpace := GetCharPlace(' ', s);
  if iSpace = 0 then
    iSpace := GetCharPlace('T', s);

  if (Length(s) > 3) and (s[3] = ':') then
  begin
    Result := ParserStringToTime(s, ADay);
    Exit;
  end;

  if (iSpace > 0) then
  begin
    sDate := Trim(Copy(s, 1, iSpace - 1));
    sTime := Trim(Copy(s, iSpace + 1, MaxInt));
  end;

  if (sDate <> '') and ParserStringToDate(sDate, dDate) then
  begin
    dTime := EncodeTime(0, 0, 0, 0);
    if (sTime = '') or ParserStringToTime(sTime, dTime) then
    begin
      ADay := dDate + dTime;
      Result := True;
    end;
  end;
end;

{ TStrSplitReader }

procedure TStrSplitReader.Init(const s: string; ASplit: Char = ',');
begin
  LData := PChar(s);
  Split := ASplit;
end;

function TStrSplitReader.Next(var AVal: string): Boolean;
begin
  Result := TryReadNextValue(LData, AVal, Split);
end;

function TStrSplitReader.NexTag: string;
begin
  if not Next(Result) then
    Result := '';
end;

function VarToBool(const v: variant; ADef:Boolean = False): boolean;
var
  s: string;
begin
  Result := ADef;
  case VarType(v) of
    varBoolean: Result := v;
    varInteger: Result := v > 0;
    varString: begin
      s := v;
      if s <> '' then
        Result := CharInSet(UpCase(s[1]), ['T', 'Y']);
    end;
    else begin
      s := VarToStrDef(v, '');
      if s <> '' then
        Result := CharInSet(UpCase(s[1]), ['T', 'Y']);
    end;

  end;
end;

function RectToString(const r: TRect): string;
begin
  Result := format('%d,%d,%d,%d', [r.Left, r.Top, r.Right, r.Bottom]);
end;

function TryStrToRect(const s: string; var r: TRect): boolean;
var
  p: PChar;
begin
  Result := False;
  if s = '' then Exit;
  p := PChar(s);
  r.Left := StrToIntDef(ReadNextValue(p, ','), -1);
  r.Top := StrToIntDef(ReadNextValue(p, ','), -1);
  r.Right := StrToIntDef(ReadNextValue(p, ','), -1);
  r.Bottom := StrToIntDef(ReadNextValue(p, ','), -1);

  Result := (r.Bottom > r.Top) and
            (r.Right > r.Left);
end;

procedure DequotedStrBracket(var s: string);
var
  len: Integer;
  b,e: integer;
  bInStr: Boolean;
  i: Integer;
  iBkCnt: Integer;
begin
  // 移除外围括号
  len := Length(s);
  if len < 2 then Exit;

  b := 0;
  if s[1] = '(' then b := 1
  else if s[1] = ' ' then
  begin
    for i := 2 to len - 1 do
    begin
      case s[i] of
        '(': begin b := i; Break; end;
        ' ': ; // 跳过
        else break;
      end;
    end;
  end;
  if b = 0 then Exit;

  e := 0;
  if s[len] = ')' then e := len
  else if s[len] = ' ' then
  begin
    for i := len - 1 downto b + 1 do
    begin
      case s[i] of
        ')': begin e := i; Break; end;
        ' ': ; // 跳过
        else break;
      end;
    end;
  end;

  // (a)
  // 1, 3
  if (b = 0) or (b >= e) then Exit;

  // 检查括号对齐
  iBkCnt := 0;
  bInStr := False;
  for i := b to e - 1 do
  begin
    case s[i] of
      #39: bInStr := not bInStr;
      '(': if not bInStr then inc(iBkCnt);
      ')':
      begin
        if not bInStr then
        begin
          dec(iBkCnt);
          if iBkCnt = 0 then Break;
        end;
      end;
    end;
  end;

  if (iBkCnt = 1) and (b > 0) then
    s := Copy(s, b, e - b - 1);
end;

function DequotedBracket(const s: string): string;
begin
  // 退去外围括号
  Result := s;
  DequotedStrBracket(Result);
end;

function VarToInt(const v: variant; ADefVal:integer = 0): Integer;
var
  iVal64: int64;
begin
  case VarType(v) of
    varSmallInt, varInteger, varShortInt,
    varByte, varWord, varLongWord:
    begin
      Result := v;
    end;
    varInt64, varUInt64:
    begin
      iVal64 := v;
      Result := integer(iVal64);
    end;
    varSingle, varDouble, varCurrency:
    begin
      Result := Trunc(v);
    end;
    varBoolean:
    begin
      if v then Result := 1
      else Result := 0;
    end;
    varEmpty, varNull: Result := ADefVal;
    else
    begin
      Result := StrToIntDef(VarToStrDef(v, ''), ADefVal)
    end;
  end;
end;

function VarToInt64(const v: variant; ADefVal:int64 = 0): int64;
begin
  case VarType(v) of
    varSmallInt, varInteger, varShortInt,
    varByte, varWord, varLongWord, varInt64, varUInt64:
    begin
      Result := v;
    end;
    varSingle, varDouble, varCurrency:
    begin
      Result := Trunc(v);
    end;
    varBoolean:
    begin
      if v then Result := 1
      else Result := 0;
    end;
    varEmpty, varNull: Result := ADefVal;
    else
    begin
      Result := StrToInt64Def(VarToStrDef(v, ''), ADefVal)
    end;
  end;
end;


function v2s(const v: Variant; const ADef: string = ''): string;
begin
  Result := VarToStrDef(v, ADef);
end;


function iif(ATest: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if ATest then begin
    Result := ATrue;
  end else begin
    Result := AFalse;
  end;
end;

function iif(ATest: Boolean; const ATrue: string; const AFalse: string): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if ATest then begin
    Result := ATrue;
  end else begin
    Result := AFalse;
  end;
end;

function iif(ATest: Boolean; const ATrue: Boolean; const AFalse: Boolean): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if ATest then begin
    Result := ATrue;
  end else begin
    Result := AFalse;
  end;
end;

function IsJsonStr(const s: string): boolean;
begin
  Result := (s <> '') and ((s[1] = '{') or (s[1] = '['));
end;

procedure TIntList.Clear;
begin
  FItems.Clear;
end;

constructor TIntList.Create;
begin
  FItems := TList.Create;
end;

destructor TIntList.Destroy;
begin
  FItems.free;
  inherited;
end;

function TIntList.Exists(AVal: Integer): Boolean;
begin
  Result := IndexOf(AVal) >= 0;
end;

procedure TIntList.Add(AVal: integer);
begin
  FItems.Add(Pointer(AVal));
end;

function TIntList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TIntList.GetEnumerator: TTIntListEnumerator;
begin
  Result :=  TTIntListEnumerator.Create(Self);
end;

function TIntList.GetItems(Index: Integer): Integer;
begin
  Result := Integer(FItems[Index]);
end;

function TIntList.IndexOf(AVal: integer): Integer;
begin
  Result := FItems.IndexOf(Pointer(AVal)) ;
end;

procedure TIntList.Remove(AVal: integer);
var
  idx: Integer;
begin
  idx := IndexOf(AVal);
  if idx >= 0 then
    FItems.Delete(idx);
end;

procedure TIntList.SetItems(Index: Integer; const Value: Integer);
begin
  FItems[Index] := Pointer(Value);
end;

procedure TIntList.Sort;
begin
  FItems.Sort(SortIntComp);
end;

{ TTIntListEnumerator }

constructor TTIntListEnumerator.Create(ADataSet: TIntList);
begin
  inherited Create;
  FIndex := -1;
  FDataSet := ADataSet;
end;

function TTIntListEnumerator.GetCurrent: integer;
begin
  Result := FDataSet[FIndex];
end;

function TTIntListEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < FDataSet.Count - 1;
  if Result then
    Inc(FIndex);
end;

{ TMutex }

{$ifndef USECRITICALSECTION}
procedure TMutex.Enter;
begin
  TMonitor.Enter(self);
end;

procedure TMutex.Leave;
begin
  TMonitor.Exit(self);
end;

{$else}
constructor TMutex.Create;
begin
  InitializeCriticalSection(fLock);
end;

destructor TMutex.Destroy;
begin
  DeleteCriticalSection(fLock);
end;

procedure TMutex.Enter;
begin
  EnterCriticalSection(fLock);
end;

procedure TMutex.Leave;
begin
  LeaveCriticalSection(fLock);
end;
{$endif}

end.
