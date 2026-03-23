unit uLogWriter;

interface

type
  TLogWriteKind = (lkErr, lkWarn, lkHint, lkTick, lkCalc, lkFieldChange, lkDebug);
  TLogWriteKinds = set of TLogWriteKind;
  TLogWriteOptions = set of (lwoTimestamp, lwoExistsHeader);

  TLogHookEvent = procedure (const AUnit: string; ALine: integer; AKind:TLogWriteKind; const msg: string) of object;

  LogWriter = class
  private
  public
    class procedure AllowConsolsView;
    class procedure SetLevel(ACallback: TLogHookEvent; AKind: TLogWriteKinds; AllowConsolsView: boolean = False);
    class procedure Add(const AUnit: string; ALine: integer; AKind:TLogWriteKind; const s: string; AOpts: TLogWriteOptions = [lwoTimestamp]); overload; static;

    class procedure Add(AKind:TLogWriteKind; const s: string; AOpts: TLogWriteOptions = [lwoTimestamp]);overload; static;
    class procedure AddFmt(AKind:TLogWriteKind; const s: string; const args: array of const; AOpts: TLogWriteOptions = [lwoTimestamp]); static;
    class procedure Add(const s: string; AOpts: TLogWriteOptions = [lwoTimestamp]);overload; static;
    class procedure Add(const fmt: string; const args: array of const; AOpts:TLogWriteOptions = [lwoTimestamp]); overload; static;
    class procedure Add(const arrs: array of string; AOpts: TLogWriteOptions = [lwoTimestamp]);overload; static;

    class procedure Err(const AName: string; const AMsg: string = ''); overload;
    class procedure Err(const AName: string; const afmt: string; const args: array of const); overload;
    class procedure Msg(const s: string = ''); overload;
    class procedure Msg(const afmt: string; const args: array of const); overload;
    class procedure Warn(const s: string = ''); overload;
    class procedure Warn(const afmt: string; const args: array of const); overload;
  end;

var
  gListOpenTimeCount: cardinal;
  gLogMsgLevel: Integer = {$ifdef Debug} ord(lkDebug) {$else} ord(lkWarn) {$endif};

const
  CONSTNAMES_Kind: array [TLogWriteKind] of string = ('ERROR', 'WARN', 'HINT', 'TICK', 'CALC', 'FIELD', 'DEBUG');

  function LogKindActive(AKind: TLogWriteKind): boolean; inline;
  function GetLogPath: string;
  function GetObjID: Cardinal;

implementation
uses
  SysUtils, StrUtils, Windows, Forms;

var
  _AllowConsole: Boolean = false;
  _DebugObjID: Cardinal = 0;
  LogTag: string = '';
  LogFileName: string = '';
  _MsgMaxID: Cardinal = 0;
  _Callback: TLogHookEvent = nil;
  _ValidMsgKinds: TLogWriteKinds = [lkErr, lkWarn];


function GetObjID: Cardinal;
begin
  inc(_DebugObjID);
  Result := _DebugObjID;
end;

function LogKindActive(AKind: TLogWriteKind): boolean;
begin
  Result := (ord(AKind) <= gLogMsgLevel);
end;

function GetUserPath: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

function GetLogPath: string;
begin
  result := GetUserPath + 'log\';
end;

function GetLogFileName(ADate: TDateTime): string;
var
  sPath: string;
  sTag :string;
begin
  sTag := FormatDateTime('yyyymmdd', ADate);
  if sTag <> LogTag then
  begin
    LogTag := sTag;
    sPath := GetUserPath + 'log\' + FormatDateTime('yyyymm', ADate);
    LogFileName := sPath + '\' + FormatDateTime('yyyymmdd', ADate) + '.log';
    if not DirectoryExists(sPath) then
      if not ForceDirectories(sPath) then
        LogFileName := '';
  end;

  Result := LogFileName
end;

function GetTimestampStr: string;
begin
  Result := FormatDateTime('hh:mm:ss.zzz', Now);
end;

class procedure LogWriter.SetLevel(ACallback: TLogHookEvent; AKind:
    TLogWriteKinds; AllowConsolsView: boolean = False);
begin
  _ValidMsgKinds := AKind;
  _Callback := ACallback;
  if AllowConsolsView then
    _AllowConsole := AllocConsole;
end;

class procedure LogWriter.Add(const s: string; AOpts: TLogWriteOptions = [lwoTimestamp]);
begin
  Add(lkHint, s, AOpts);
end;

class procedure LogWriter.Add(const fmt: string; const args: array of const;
    AOpts: TLogWriteOptions = [lwoTimestamp]);
begin
  Add(Format(fmt, args), AOpts);
end;

class procedure LogWriter.Add(const arrs: array of string;
  AOpts: TLogWriteOptions);
var
  cStr: TStringBuilder;
  I: Integer;
begin
  cStr := TStringBuilder.Create;
  try
    for I := 0 to High(arrs) do
    begin
      cStr.Append(#9);
      cStr.Append(arrs[i]);
      cStr.AppendLine;
    end;

    add(cStr.ToString, AOpts);
  finally
    cStr.Free;
  end;
end;

class procedure LogWriter.Err(const AName, afmt: string;
  const args: array of const);
begin
  Err(AName, Format(afmt, args));
end;

class procedure LogWriter.Err(const AName, AMsg: string);
var
  cStr: TStringBuilder;
begin
  cStr := TStringBuilder.Create;
  try
    cStr.Append('#');
    cStr.Append(CONSTNAMES_Kind[lkErr]);
    cStr.Append(':  ');
    cStr.Append(AName);
    if AMsg <> '' then
    begin
      cStr.AppendLine;
      cStr.Append(AMsg);
      cStr.Replace(#13#10, #13#10#9);
      cStr.AppendLine;
    end;

    Add(lkErr, cStr.ToString, [lwoExistsHeader]);
  finally
    cStr.Free;
  end;
end;

class procedure LogWriter.Msg(const afmt: string; const args: array of const);
begin
  msg(format(afmt, args));
end;

class procedure LogWriter.Msg(const s: string);
begin
  Add(lkHint, s);
end;

class procedure LogWriter.Warn(const s: string = '');
begin
  Add(lkWarn, s);
end;
class procedure LogWriter.Warn(const afmt: string; const args: array of const);
begin
  Warn(format(afmt, args));
end;

function FilterMsg(const s: string): boolean;
begin
  Result := (Pos('等空闲了', s) > 0) or
            (Pos('该任务CompanySearch_ByGroupLink状态', s) > 0);
end;

class procedure LogWriter.Add(const AUnit: string; ALine: integer;
    AKind:TLogWriteKind; const s: string; AOpts: TLogWriteOptions =
    [lwoTimestamp]);
{$ifdef debug}
var
  sData: string;
{$endif}
begin
  if Assigned(_Callback) and (AKind in _ValidMsgKinds) then
    _Callback(AUnit, ALine, AKind, s);
  if _AllowConsole then
  begin
    if not FilterMsg(s) then
      Writeln(Format('%5d  %s : %s', [_MsgMaxID, CONSTNAMES_Kind[AKind], s]));
  end;

  {$ifdef debug}
  sData := Format('%5d  %s : %s', [_MsgMaxID, CONSTNAMES_Kind[AKind], s]);
  OutputDebugString(PChar(sData));
  {$endif}
end;

class procedure LogWriter.Add( AKind: TLogWriteKind; const s: string;
  AOpts: TLogWriteOptions);
begin
  LogWriter.Add('Log', 1, AKind, s, AOpts);
end;

class procedure LogWriter.AddFmt(AKind:TLogWriteKind; const s: string;
    const args: array of const; AOpts: TLogWriteOptions);
begin
  Add(AKind, format(s, args), AOpts);
end;


class procedure LogWriter.AllowConsolsView;
begin
  if not _AllowConsole then
    _AllowConsole := AllocConsole;

end;

initialization

finalization
  if _AllowConsole then FreeConsole;
  


end.
