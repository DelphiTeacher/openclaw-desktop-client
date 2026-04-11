//convert pas to utf8 by ¥
unit uServiceManage;

interface

uses
  Classes,
  SysUtils,
  DateUtils,
  IniFiles,
  Types,
  UITypes,
  FMX.Forms,
  FMX.Graphics,
  uDrawTextParam,
  System.IOUtils,

  ComObj,
  ActiveX,

  uSkinItems,
  uSkinListViewType,

  StrUtils,
  uConst,
  Variants,
  IdURI,
  uBaseHttpControl,
  uDrawPicture,
  uOpenClientCommon,
//  uSkinMultiColorLabelType,
  uOpenCommon,
  uRestInterfaceCall,
  uCommandLineHelper,
//  IdHashSHA,
//  IdGlobal,
  System.Hash,
  uDatasetToJson,
  Winapi.WinSvc,
  Winapi.ShellApi,
  Winapi.TlHelp32,
  Windows,

  uLocalOpenClawHelper,
  OpenClawGateway,


//  uThumbCommon,
  uFuncCommon,
  uFileCommon,
  uBaseList,
//  uDataSetToJson,

  XSuperObject,
  XSuperJson
  ;


type
  //服务管理
  TServiceManager=class
  public
    FExecuteNodeCommand:TExecuteCommand;
    FIsServerStarted:Boolean;



    //判断openclaw gateway的进程是不是已经存在，如果已经存在，就不需要再启动了。
    //这个需要管理员权限运行
    function IsServerProcessExistsByDll(var ADesc:String):Boolean;
    function IsServerProcessExistsByWMI(var ADesc:String):Boolean;
    function IsServerRunning(var ADesc:String):Boolean;

    function StartServer(var ADesc:String):Boolean;
    //判断服务是不是已经启动了
    function IsServerStarted(var ADesc:String):Boolean;
    function WaitServerStarted(ATimeoutSeconds:Integer;var ADesc:String):Boolean;
    function StopServer(var ADesc:String):Boolean;

  end;


var
  GlobalServiceManager:TServiceManager;

implementation

//type
//  PROCESS_BASIC_INFORMATION = record
//    ExitStatus: Int64;
//    PebBaseAddress: Pointer;
//    AffinityMask: Int64;
//    BasePriority: Int64;
//    UniqueProcessId: Int64;
//    InheritedFromUniqueProcessId: Int64;
//  end;
//
//function NtQueryInformationProcess(ProcessHandle: THandle; ProcessInformationClass: DWord;
//  ProcessInformation: Pointer; ProcessInformationLength: ULONG; ReturnLength: PULONG): Int64; stdcall;
//  external 'ntdll.dll';
//
//function GetProcessCommandLine(APID: DWORD): String;
//var
//  AHandle: THandle;
//  ABasicInfo: PROCESS_BASIC_INFORMATION;
//  APEBAddress: Pointer;
//  AProcessParam: Pointer;
//  ACommandLineLength: DWORD;
//  AReturnLength: ULONG;
//  ACommandLinePtr: Pointer;
//  ATempBuffer: PWideChar;
//begin
//  Result := '';
//  AHandle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, APID);
//  if AHandle = 0 then
//    Exit;
//  try
//    if NtQueryInformationProcess(AHandle, 0, @ABasicInfo, SizeOf(ABasicInfo), @AReturnLength) = 0 then
//    begin
//      APEBAddress := ABasicInfo.PebBaseAddress;
//      if Assigned(APEBAddress) and ReadProcessMemory(AHandle, Pointer(Integer(APEBAddress) + 32),
//         @AProcessParam, SizeOf(Pointer), AReturnLength) then
//      begin
//        if Assigned(AProcessParam) and ReadProcessMemory(AHandle, Pointer(Integer(AProcessParam) + 80),
//           @ACommandLineLength, SizeOf(DWORD), AReturnLength) then
//        begin
//          if ReadProcessMemory(AHandle, Pointer(Integer(AProcessParam) + 88),
//             @ACommandLinePtr, SizeOf(Pointer), AReturnLength) then
//          begin
//            if Assigned(ACommandLinePtr) and (ACommandLineLength > 0) then
//            begin
//              ATempBuffer := AllocMem(ACommandLineLength);
//              try
//                if ReadProcessMemory(AHandle, ACommandLinePtr, ATempBuffer, ACommandLineLength, AReturnLength) then
//                begin
//                  Result := PWideChar(ATempBuffer);
//                end;
//              finally
//                FreeMem(ATempBuffer);
//              end;
//            end;
//          end;
//        end;
//      end;
//    end;
//  finally
//    CloseHandle(AHandle);
//  end;
//end;


// 辅助函数：通过进程ID获取命令行参数
function GetProcessCommandLine(const ProcessId: DWORD): string;
type
  PPROCESS_BASIC_INFORMATION = ^PROCESS_BASIC_INFORMATION;
  PROCESS_BASIC_INFORMATION = packed record
    ExitStatus: DWORD;
    PebBaseAddress: Pointer;
    AffinityMask: DWORD;
    BasePriority: DWORD;
    UniqueProcessId: DWORD;
    InheritedFromUniqueProcessId: DWORD;
  end;

  TQueryInformationProcess = function(
    ProcessHandle: THandle;
    ProcessInformationClass: DWORD;
    ProcessInformation: Pointer;
    ProcessInformationLength: DWORD;
    ReturnLength: PDWORD
  ): DWORD; stdcall;

var
  hProcess: THandle;
  QueryInfo: TQueryInformationProcess;
  pbi: PROCESS_BASIC_INFORMATION;
  ReturnLength: DWORD;
  PebAddress: Pointer;
  ProcessParameters: Pointer;
  CommandLineLength: WORD;
  CommandLineBuffer: PWideChar;
  ReadBytes: SIZE_T;
  NTDLL: HMODULE;
begin
  Result := '';

  // 打开进程
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, ProcessId);
  if hProcess = 0 then
    Exit;

  try
    // 加载 NTDLL
    NTDLL := GetModuleHandle('ntdll.dll');
    if NTDLL = 0 then
      Exit;

    // 获取 NtQueryInformationProcess 函数地址
    @QueryInfo := GetProcAddress(NTDLL, 'NtQueryInformationProcess');
    if not Assigned(QueryInfo) then
      Exit;

    // 查询进程基本信息
    if QueryInfo(hProcess, 0, @pbi, SizeOf(pbi), @ReturnLength) = 0 then
    begin
      PebAddress := pbi.PebBaseAddress;

      // 读取 PEB 中的 ProcessParameters
      if ReadProcessMemory(hProcess, Pointer(NativeUInt(PebAddress) + $20),
                           @ProcessParameters, SizeOf(Pointer), ReadBytes) then
      begin
        // 读取命令行参数长度和缓冲区
        // RTL_USER_PROCESS_PARAMETERS 结构体在 x86 和 x64 中偏移不同
        {$IFDEF WIN64}
        // 64位系统的偏移
        if ReadProcessMemory(hProcess, Pointer(NativeUInt(ProcessParameters) + $70),
                             @CommandLineLength, SizeOf(WORD), ReadBytes) then
        begin
          if ReadProcessMemory(hProcess, Pointer(NativeUInt(ProcessParameters) + $78),
                               @CommandLineBuffer, SizeOf(Pointer), ReadBytes) then
          begin
            SetLength(Result, CommandLineLength div SizeOf(WideChar));
            ReadProcessMemory(hProcess, CommandLineBuffer,
                             PChar(Result), CommandLineLength, ReadBytes);
          end;
        end;
        {$ELSE}
        // 32位系统的偏移
        if ReadProcessMemory(hProcess, Pointer(NativeUInt(ProcessParameters) + $40),
                             @CommandLineLength, SizeOf(WORD), ReadBytes) then
        begin
          if ReadProcessMemory(hProcess, Pointer(NativeUInt(ProcessParameters) + $44),
                               @CommandLineBuffer, SizeOf(Pointer), ReadBytes) then
          begin
            SetLength(Result, CommandLineLength div SizeOf(WideChar));
            ReadProcessMemory(hProcess, CommandLineBuffer,
                             PChar(Result), CommandLineLength, ReadBytes);
          end;
        end;
        {$ENDIF}
      end;
    end;
  finally
    CloseHandle(hProcess);
  end;
end;

function TServiceManager.IsServerProcessExistsByDll(var ADesc: String): Boolean;
var
  ASnapshot: THandle;
  AProcessEntry32: TProcessEntry32W;
  ACommandLine: String;
begin
  Result := False;
  ADesc := '';
  //  ┃  帮我完善uServiceManage.pas中的IsServerProcessExists方法，实现的思路为在windows下面遍历所有exe为node.exe的进程，然后判断它的参数中是否存在openclaw和gateway，如果存在这样一个进程，返回为True，否则为False.
  {$IFDEF MSWINDOWS}
  ASnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if ASnapshot = INVALID_HANDLE_VALUE then
  begin
    ADesc := 'Failed to create process snapshot';
    Exit;
  end;

  try
    AProcessEntry32.dwSize := SizeOf(TProcessEntry32W);
    if Process32FirstW(ASnapshot, AProcessEntry32) then
    begin
      repeat
        if SameText(AProcessEntry32.szExeFile, 'node.exe') then
        begin
          ACommandLine := GetProcessCommandLine(AProcessEntry32.th32ProcessID);
          if (Pos('openclaw', LowerCase(ACommandLine)) > 0) and (Pos('gateway', LowerCase(ACommandLine)) > 0) then
          begin
            Result := True;
            Exit;
          end;
        end;
      until not Process32NextW(ASnapshot, AProcessEntry32);
    end;
  finally
    CloseHandle(ASnapshot);
  end;
  {$ENDIF}
end;

function TServiceManager.IsServerProcessExistsByWMI(var ADesc: String): Boolean;
var
  WMIService: OleVariant;
  Processes: OleVariant;
  Process: OleVariant;
  EnumProcesses: IEnumVariant;
  Value: LongWord;
  CommandLine: string;
  ProcessName: string;
begin
  Result := False;

  // 初始化COM
  CoInitialize(nil);
  try
    try
      // 连接到WMI服务
//      WMIService := ComObj.GetObject('winmgmts:\\.\root\cimv2');
      WMIService := CreateOleObject('WbemScripting.SWbemLocator');
      WMIService := WMIService.ConnectServer('.', 'root\cimv2');
      // 查询所有进程
      Processes := WMIService.ExecQuery('SELECT Name, CommandLine FROM Win32_Process WHERE Name = "node.exe"');

      EnumProcesses := IUnknown(Processes._NewEnum) as IEnumVariant;

      // 遍历每个进程
      while EnumProcesses.Next(1, Process, Value) = 0 do
      begin
        ProcessName := Process.Name;
        CommandLine := Process.CommandLine;

        // 检查命令行参数
        if (VarIsNull(CommandLine) = False) then
        begin
          CommandLine := LowerCase(CommandLine);

          if //(Pos('openclaw', CommandLine) > 0) and
             (Pos('gateway', CommandLine) > 0) then
          begin
            Result := True;
            Break;
          end;
        end;
      end;
    except
      // 处理异常
      Result := False;
    end;
  finally
    CoUninitialize;
  end;
end;


function TServiceManager.IsServerRunning(var ADesc: String): Boolean;
begin
  Result:=False;
  //服务进程已经启动了
  if IsServerProcessExistsByWMI(ADesc) then
  begin
    Result:=True;
    Exit;
  end;
end;

function TServiceManager.IsServerStarted(var ADesc: String): Boolean;
var
  I:Integer;
begin
  Result:=False;
  ADesc:='';

  if FIsServerStarted then
  begin
    Result:=True;
    Exit;
  end;



  //当命令行打印出这几行时，就表示服务已经启动了
  //09:51:32 [canvas] host mounted at http://127.0.0.1:18789/__openclaw__/canvas/ (root C:\Users\Administrator\.openclaw\canvas)
  //09:51:33 [heartbeat] started
  //09:51:33 [health-monitor] started (interval: 300s, startup-grace: 60s, channel-connect-grace: 120s)
  //09:51:33 [gateway] agent model: custom-dashscope-aliyuncs-com/qwen3.5-plus
  //09:51:33 [gateway] listening on ws://127.0.0.1:18789, ws://[::1]:18789 (PID 13528)
  //09:51:33 [gateway] log file: C:\Users\ADMINI~1\AppData\Local\Temp\openclaw\openclaw-2026-03-22.log
  //09:51:33 [browser/server] Browser control listening on http://127.0.0.1:18791/ (auth=token)
  if Self.FExecuteNodeCommand=nil then Exit;

  for I := 0 to FExecuteNodeCommand.FCommandLineOutputHelper.FLogList.Count-1 do
  begin
    if Pos('Browser control listening on',FExecuteNodeCommand.FCommandLineOutputHelper.FLogList[I])>0 then
    begin
      FIsServerStarted:=True;
      Result:=True;
      Exit;
    end;

  end;

end;

function TServiceManager.StartServer(var ADesc:String):Boolean;
begin
  Result:=False;

  //获取node是否已经安装
  FExecuteNodeCommand:=TExecuteCommand.Create(nil);

  FExecuteNodeCommand.FTag:='';
  FExecuteNodeCommand.FPipeUseTypes:=[putReadFromStdout,putWriteToStdin];
//  FExecuteNodeCommand.FOnGetData:=Self.DoGetDataEvent;
//  FExecuteNodeCommand.FOnGetCommandLineOutput:=Self.DoGetCommandLineOutput;

  {$IFDEF MSWINDOWS}
  FExecuteNodeCommand.FProgramFilePath:=GetApplicationPath+'node'+PathDelim+'node.exe';
  FExecuteNodeCommand.FCommandLine:='node';
  FExecuteNodeCommand.FParams:='"'+GetApplicationPath+'openclaw'+PathDelim+'openclaw.mjs"'+' gateway';
  FExecuteNodeCommand.FWorkDir:='';
  {$ENDIF}



//   {$IFDEF LINUX}
//   FExecuteNodeCommand.FProgramFilePath:='/usr/bin/python3';
//   FExecuteNodeCommand.FCommandLine:='python3';
// //  FExecuteNodeCommand.FProgramFilePath:='/usr/bin/python';
// //  FExecuteNodeCommand.FCommandLine:='python';
//   FExecuteNodeCommand.FParams:='python_convert_word/convert_word_main.py';
//   FExecuteNodeCommand.FWorkDir:='';      82067801  82067803
//   {$ENDIF}

  //v20.9.0

  //运行命令
  //运行程序并读取数据
  if not FExecuteNodeCommand.Execute(False,ADesc) then
  begin

    ADesc:=ADesc+'未安装NodeJs!请安装,如果您已安装请将nodejs安装目录添加到系统环境变量中的Path中'+#13#10;
//      Exit;
  end;

  Result:=True;


end;

function TServiceManager.StopServer(var ADesc: String): Boolean;
begin
  //停止openclaw进程
  Result:=False;

  FIsServerStarted:=False;

  if FExecuteNodeCommand=nil then
  begin
    ADesc:='未启动服务!';
    Exit;
  end;

  //停止进程
  FExecuteNodeCommand.StopProcess();


  FreeAndNil(FExecuteNodeCommand);
end;

function TServiceManager.WaitServerStarted(ATimeoutSeconds: Integer;
  var ADesc: String): Boolean;
var
  AStartTime:TDateTime;
begin
  Result:=False;
  AStartTime:=Now();

  while DateUtils.SecondsBetween(Now(),AStartTime)<ATimeoutSeconds do
  begin
    //判断服务有没有启动，有没有配置成功
    if GlobalServiceManager.IsServerStarted(ADesc) then
    begin
      Result:=True;
      Exit;
    end;
    Sleep(1000);
  end;

  ADesc:='服务启动超时';

end;

initialization
  GlobalServiceManager:=TServiceManager.Create;

finalization
  FreeAndNil(GlobalServiceManager);

end.
