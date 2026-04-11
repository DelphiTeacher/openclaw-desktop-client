unit SpExecuteDosCommand;

interface

uses
  Windows, SysUtils;


function SpExecuteDosCommand(CommandLine, WorkDir: string; out OutputString: string): Cardinal;
// 执行一个DOS文件，等待其终止并记录输出。
// CommandLine param可以是一个带有参数的文件名，例如。CMD.exe /c dir D:\mp3
// 不要在命令行中使用管道和重定向（|, >, <）。
// 由Stephane Wierzbicki移植自JclSysUtils.InternalExecute


implementation

function SpExecuteDosCommand(CommandLine, WorkDir: string; out OutputString: string): Cardinal;
const
  BufferSize = 255;
  NativeLineFeed = Char(#10);
  NativeCarriageReturn = Char(#13);
  NativeCrLf = string(#13#10);
var
  Buffer: array [0 .. BufferSize] of AnsiChar;
  TempOutput: string;
  PipeBytesRead: Cardinal;
  function MuteCRTerminatedLines(const RawOutput: string): string;
  const
    Delta = 1024;
  var
    BufPos, OutPos, LfPos, EndPos: integer;
    C: Char;
  begin
    SetLength(result, length(RawOutput));
    OutPos := 1;
    LfPos := OutPos;
    EndPos := OutPos;
    for BufPos := 1 to length(RawOutput) do
    begin
      if OutPos >= length(result) - 2 then
        SetLength(result, length(result) + Delta);
      C := RawOutput[BufPos];
      case C of
        NativeCarriageReturn:
          OutPos := LfPos;
        NativeLineFeed:
          begin
            OutPos := EndPos;
            result[OutPos] := NativeCarriageReturn;
            inc(OutPos);
            result[OutPos] := C;
            inc(OutPos);
            EndPos := OutPos;
            LfPos := OutPos;
          end;
      else
        result[OutPos] := C;
        inc(OutPos);
        EndPos := OutPos;
      end;
    end;
    SetLength(result, OutPos - 1);
  end;
  function CharIsReturn(const C: Char): Boolean;
  begin
    result := (C = NativeLineFeed) or (C = NativeCarriageReturn);
  end;
  procedure ProcessLine(LineEnd: integer);
  begin
    if (TempOutput[LineEnd] <> NativeCarriageReturn) then
    begin
      while (LineEnd > 0) and CharIsReturn(TempOutput[LineEnd]) do
        Dec(LineEnd);
    end;
  end;
  procedure ProcessBuffer;
  begin
    Buffer[PipeBytesRead] := #0;
    TempOutput := TempOutput + string(Buffer);
  end;

// outsourced from Win32ExecAndRedirectOutput
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  SecurityAttr: TSecurityAttributes;
  PipeRead, PipeWrite: THandle;
  PWorkDirChar: PChar;
begin
  result := $FFFFFFFF;
  SecurityAttr.nLength := Sizeof(SecurityAttr);
  SecurityAttr.lpSecurityDescriptor := nil;
  SecurityAttr.bInheritHandle := True;
  if not CreatePipe(PipeRead, PipeWrite, @SecurityAttr, 0) then
  begin
    result := GetLastError;
    Exit;
  end;
  FillChar(StartupInfo, Sizeof(TStartupInfo), #0);
  StartupInfo.cb := Sizeof(TStartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
  StartupInfo.wShowWindow := SW_HIDE;
  StartupInfo.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
  StartupInfo.hStdOutput := PipeWrite;
  StartupInfo.hStdError := PipeWrite;
  if WorkDir = '' then
    PWorkDirChar := nil
  else
    PWorkDirChar := PChar(WorkDir);
  if CreateProcess(nil, PChar(CommandLine), nil, nil, True, NORMAL_PRIORITY_CLASS, nil, PWorkDirChar, StartupInfo, ProcessInfo) then
  begin
    CloseHandle(PipeWrite);
    while ReadFile(PipeRead, Buffer, BufferSize, PipeBytesRead, nil) and (PipeBytesRead > 0) do
      ProcessBuffer;
    if (WaitForSingleObject(ProcessInfo.hProcess, INFINITE) = WAIT_OBJECT_0) and not GetExitCodeProcess(ProcessInfo.hProcess, result) then
      result := $FFFFFFFF;
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
  end
  else
    CloseHandle(PipeWrite);
  CloseHandle(PipeRead);
  if TempOutput <> '' then
    OutputString := OutputString + MuteCRTerminatedLines(TempOutput);
end;
end.