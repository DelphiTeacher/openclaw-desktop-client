unit uWinUtils;

///
///  Windows 平台相关功能
///

interface

function KillTask(AExeFileName: string): integer;
procedure KillOtherSubProcess(AID: Cardinal; const AExeFileName: string);

implementation

uses
  Windows, TlHelp32, SysUtils;


function KillProcessID(pid: cardinal): Integer;
const
  PROCESS_TERMINATE=$0001;
var
  hd: THandle;
begin
  Result := 0;
  if pid = 0 then
    Exit;
  hd := OpenProcess(PROCESS_TERMINATE, BOOL(0), pid);
  try
    // 结果 = 0 杀进程失败
    if hd <> 0 then
      if integer(TerminateProcess(hd, 0)) = 0 then
        Result := 1;
  finally
    CloseHandle(hd);
  end;
end;

function KillTask(AExeFileName: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  bLoop: BOOL;
  hSnapshot: THandle;
  pid: cardinal;
  rEntry: TProcessEntry32;
begin
  result := 0;
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    rEntry.dwSize := Sizeof(rEntry);
    bLoop := Process32First(hSnapshot, rEntry);

    while integer(bLoop) <> 0 do
    begin
      if SameText(ExtractFileName(rEntry.szExeFile), AExeFileName) then
      begin
        pid := rEntry.th32ProcessID;
        KillProcessID(pid);
      end;
      bLoop := Process32Next(hSnapshot, rEntry);
    end;
  finally
    CloseHandle(hSnapshot);
  end;
end;


procedure KillOtherSubProcess(AID: Cardinal; const AExeFileName: string);
const
  PROCESS_TERMINATE=$0001;
var
  bIsValid: Boolean;
  bLoop: BOOL;
  hSnapshot: THandle;
  pid: cardinal;
  rEntry: TProcessEntry32;
begin
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then
    Exit;

  try
    rEntry.dwSize := Sizeof(rEntry);
    bLoop := Process32First(hSnapshot, rEntry);
    while integer(bLoop) <> 0 do
    begin
      bIsValid := (rEntry.th32ProcessID = AID) or
                   (rEntry.th32ParentProcessID = AID) or
                   not SameText(ExtractFileName(rEntry.szExeFile), AExeFileName);

      if not bIsValid then
      begin
        pid := rEntry.th32ProcessID;
        KillProcessID(pid);
      end;
      bLoop := Process32Next(hSnapshot, rEntry);
    end;
  finally
    CloseHandle(hSnapshot);
  end;
end;


end.
