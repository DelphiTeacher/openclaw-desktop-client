unit uMXUpgrades;

interface

uses
  Classes, SynCrtSock, Windows, uHttpRequestAPI, SynCommons, XSuperObject;

type
  PUpgradeVerItem = ^TUpgradeVerItem;
  TUpgradeVerItem = record
//    ID: Int64;
    Version: string;
    Info: string;
//    VerType: Integer;


    IsMustUpdate:Integer;
    ProgramName:string;
    Platform:String;
  end;
  TUpgradeVerItemDynArray = array of TUpgradeVerItem;

  PUpgradeFileItem = ^TUpgradeFileItem;
  TUpgradeFileItem = record
//    ID: int64;
    VerID: string;
    FileName: string;
//    Path: string;
    //要下载的文件名，压缩文件名
    FileKey: string;
//    FileType: Integer;
    Note: string;
  end;
  TUpgradeFileItemDynArray = array of TUpgradeFileItem;

  TMXUpgrade = class
  private
    FHttp: THttpRequestSvr;
    FProgressHandle: THandle;

    FCurrVer: TUpgradeVerItem;
    FSvrParam: THttpSvrParam;
    FAPIList: TStringList;
    FTargetExec: string;    // 更新目标程序

    FNewVers: TUpgradeVerItemDynArray;
    FFileItems:TUpgradeFileItemDynArray;
    FDownLoading: Boolean;
    FOnDownFinished: TNotifyEvent;
    FOnUpdated: TNotifyEvent;
    FUpdated: Boolean;
    FWorkPath: string;
    FExecFile: string;  // 升级完成调用执行
    FDirName: string;   // 目录名称
    FUseThreadDown: Boolean;

    function  CheckCacheFiles: Boolean;
    procedure DoDownFiles;
    procedure DoOnThreadFinsh(Sender: TObject);
    function GetCachePath: string;
    procedure InitHttp;

    function ReadSvrVers: Integer;
    function ReadSvrUpgradeFiles(const AIDList: string): integer;
    function UncompressFiles: Boolean;
    procedure WriteVerInfo;
    function GetExtractPath: string;
    function GetCurrVer: PUpgradeVerItem;
    function GetNewVerCount: Integer;
    //保存下载临时文件的临时目录
    function GetUserLocalPath: string;
//    function GetVersionPath: string;
    procedure SetUseThreadDown(const Value: Boolean);
    function GetWorkPath: string;
  protected
    procedure DoProcess(Sender: TObject; CurrentSize, ContentLength: DWORD; var
        ACancel: boolean);
    function GetVersInfo(AForceUpdate: PBoolean): string;
    function GetURL(const AName: string): string;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Init(const AParams: string);

    function GetUpdateInfo(ANeedUpdate: PBoolean): string;
    function GetUpgradeFiles: integer;
    procedure DownFiles;
    function  KillTarget: Boolean;

    function UpdateFiles: Boolean;
    property CachePath: string read GetCachePath;
    property ExtractPath: string read GetExtractPath;
    property DownLoading: Boolean read FDownLoading;
    property ProgressHandle: THandle read FProgressHandle write FProgressHandle;
    //更新到哪个目录中
    property WorkPath: string read GetWorkPath write FWorkPath;
    property ExecFile: string read FExecFile;
    //下载临时文件的临时文件名称
    property DirName: string read FDirName;

    property Updated: Boolean read FUpdated;
    property CurrVer: PUpgradeVerItem read GetCurrVer;
    property NewVerCount: Integer read GetNewVerCount;
    property UseThreadDown: Boolean read FUseThreadDown write SetUseThreadDown;
//    property VersionPath: string read GetVersionPath;
    property OnDownFinished: TNotifyEvent read FOnDownFinished write FOnDownFinished;
    property OnUpdated: TNotifyEvent read FOnUpdated write FOnUpdated;

  end;


 // procedure KillOtherSubProcess(AID: Cardinal; const AExeFileName: string);

implementation

uses
  SynCrossPlatformJSON, untCommFuns, SysUtils, uFileHashs,
  uUpgradeFileTransfers, SynZipFiles, TlHelp32, ZipForge, ShlObj, ShellAPI,
  uDataMessages, uLangRes;



const
  SAPI_Upgrade = 'Upgrade';
  SAPI_Version = 'Version';
  SAPI_DownFile = 'downfile';

//  //API对应的链接
//  SRoute_DownFile = 'upgrade/';
//  SRoute_ToolsUpgrade = 'tools/upgrade';
//  SRoute_ToolsVersion = 'tools/version';


type
  TDownloadWorkThread = class(TThread)
  private
    FOwner: TMXUpgrade;
    FContentLength : DWORD;
    FCurrentSize : DWORD;
    function FileValid(const AFileName, AHash: string): Boolean;
  protected
    procedure DoProcess(Sender: TObject; CurrentSize, ContentLength: DWORD; var ACancel: boolean);
    procedure Execute; override;
  public
    constructor Create(AOwner: TMXUpgrade);
  end;

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


constructor TMXUpgrade.Create;
begin
  inherited;
  FAPIList := TStringList.Create;
  FUseThreadDown := True;
end;

destructor TMXUpgrade.Destroy;
begin
  FAPIList.Free;
  if assigned(FHttp) then
    FHttp.Free;
  inherited;
end;

procedure TMXUpgrade.DownFiles;
var
  cDownThread: TDownloadWorkThread;
begin
  if Length(FFileItems) = 0 then
    Exit;

  if UseThreadDown then
  begin
    FDownLoading := True;
    cDownThread := TDownloadWorkThread.Create(Self);
    cDownThread.OnTerminate := DoOnThreadFinsh;
    cDownThread.Start;
  end
  else
  begin
    DoDownFiles;
    FDownLoading := False;
    if assigned(FOnDownFinished) then
      FOnDownFinished(Self);
  end;
end;

function TMXUpgrade.GetUpdateInfo(ANeedUpdate: PBoolean): string;
begin
  if not assigned(FHttp) then
    InitHttp;
  Result := '';
  /// Version 参数
  ///  verid = 当前的版本号
  ///  vertype = 当前的版本类型
  ///  http://192.168.0.103:4593/v1/tools/version?verid=2103130312&vertype=1
  if ReadSvrVers > 0 then
    Result := GetVersInfo(ANeedUpdate);
end;

function TMXUpgrade.GetUpgradeFiles: integer;
var
  cIDList: TStringBuilder;
  I: Integer;
  sIDList: string;
begin
  Result := 0;
  if Length(FNewVers) = 0 then
    Exit;

  //计算出要下载哪些版本
  cIDList := TStringBuilder.Create;
  try
    for I := 0 to High(FNewVers) do
    begin
//      cIDList.Append(FNewVers[i].ID);
      cIDList.Append(FNewVers[i].Version);
      cIDList.Append(',');
    end;
    cIDList.Length := cIDList.Length - 1;
    sIDList := cIDList.ToString;
  finally
    cIDList.Free;
  end;
  //读取要下载什么软件
  Result := ReadSvrUpgradeFiles(sIDList);
end;

function TMXUpgrade.GetURL(const AName: string): string;
var
  sRoute: string;
begin
  sRoute := FAPIList.Values[AName];
//  if (sRoute <> '') and (sRoute[1] <> '/') and (FSvrParam.APIPrefix <> '') then
//    sRoute := format('/%s/%s', [FSvrParam.APIPrefix, sRoute]);
  Result := sRoute;
end;

function TMXUpgrade.GetVersInfo(AForceUpdate: PBoolean): string;
  function FormatInfo(const s: string): string;
  var cStr: TStringBuilder;
    pCurr, pRow: PChar;
    sRow: string;
  begin
    cStr := TStringBuilder.Create;
    try
      pRow := PChar(s);
      pCurr := pRow;
      while pCurr^ <> #0 do
      begin
        case pCurr^ of
          #10:
          begin
            SetString(sRow, pRow, pCurr - pRow);
            cStr.Append(sRow);
            cStr.AppendLine;
            pRow := pCurr + 1;
          end;
        end;
        inc(pCurr);
      end;

      if (pCurr - pRow > 0) then
      begin
        SetString(sRow, pRow, pCurr - pRow);
        cStr.Append(sRow);
      end;

      Result := cStr.ToString;
    finally
      cStr.Free;
    end;

  end;
var
  bForceUpdate: Boolean;
  cInfo: TStringBuilder;
  I: Integer;
  sVer: string;
begin
  Result := '';
  if Length(FNewVers) = 0 then
    Exit;

  bForceUpdate := False;
  cInfo := TStringBuilder.Create;
  try
    for I := Length(FNewVers) - 1 downto 0 do
    begin
      sVer := FNewVers[i].Version;
//      if CharPos('*', sVer) > 0 then
//        bForceUpdate := True;

      if FNewVers[i].IsMustUpdate=1 then
      begin
        bForceUpdate := True;
      end;


      cInfo.Append('ver:');
      cInfo.Append(sVer);
      cInfo.AppendLine;
      cInfo.Append('---------------------');
      cInfo.AppendLine;
      cInfo.Append(FormatInfo(FNewVers[i].Info));
      cInfo.AppendLine;
      cInfo.AppendLine;
    end;
    Result := cInfo.ToString;
  finally
    cInfo.Free;
  end;

  if assigned(AForceUpdate) and not (AForceUpdate^) then
    AForceUpdate^ := bForceUpdate;
end;

function TMXUpgrade.GetWorkPath: string;
begin
  Result := FWorkPath;
  if FWorkPath = '' then
    Result := ExtractFilePath(ParamStr(0));
end;

procedure TMXUpgrade.Init(const AParams: string);
  procedure AddDefRoute(const AName, ARoute: string);
  begin
    if FAPIList.IndexOfName(AName) = -1 then
      FAPIList.Values[AName] := ARoute;
  end;
var
  vDatas: Variant;
  rAPIList: PJSONVariantData;
  I: Integer;
begin
  vDatas := JSONVariant(AParams);
//  FCurrVer.ID := VarToInt64(vDatas.id);
  FCurrVer.Version := v2s(vDatas.version);
//  FCurrVer.VerType := VarToInt(vDatas.vertype);
  FCurrVer.ProgramName := v2s(vDatas.program_name);
  FCurrVer.Platform := v2s(vDatas.platform);

  FSvrParam.Addr := v2s(vDatas.svraddr);
  FSvrParam.Port := VarToInt(vDatas.svrport);
  FSvrParam.IsSSL := VarToBool(vDatas.isssl, true);
//  FSvrParam.APIPrefix := v2s(vDatas.svrapi, 'v1');
//  FSvrParam.FileListAPIPrefix := v2s(vDatas.svrfilelistapi, 'v1');
  FTargetExec := v2s(vDatas.targetexec);
  FWorkPath := v2s(vDatas.workpath);
  FExecFile := v2s(vDatas.execfile);
  FDirName := v2s(vDatas.dirname);
//  if FDirName = '' then FDirName := 'MXSearcher';
//  if FExecFile = '' then FExecFile := 'MXSearcher.exe';
//  //用来拼接口地址的吗？
//  rAPIList := JSONVariantDataSafe(vDatas.apilist, jvArray);
//  if rAPIList.Kind = jvArray then
//    for I := 0 to rAPIList.Count - 1 do
//      FAPIList.Add(v2s(rAPIList.Item[i]));
//
//  AddDefRoute(SAPI_Version, SRoute_ToolsVersion);
//  AddDefRoute(SAPI_Upgrade, SRoute_ToolsUpgrade);
//  AddDefRoute(SAPI_Downfile, SRoute_DownFile);

  AddDefRoute(SAPI_Version, v2s(vDatas.svrapi, 'v1'));
  AddDefRoute(SAPI_Upgrade, v2s(vDatas.svrfilelistapi, 'v1'));
  AddDefRoute(SAPI_Downfile, v2s(vDatas.svrdownloadapi, 'v1'));
end;

procedure TMXUpgrade.InitHttp;
var
  I: Integer;
  sName: string;
  sRoute: string;
begin
  if not assigned(FHttp) then
    FHttp.Free;

  FHttp := THttpRequestSvr.Create(Self);
  FHttp.Init(FSvrParam);
  for I := 0 to FAPIList.Count - 1 do
  begin
    sName := FAPIList.Names[i];
    sRoute := FAPIList.ValueFromIndex[i];
    if (sName<> '') and (sRoute <> '') then
      FHttp.APIAddrs[sName] := sRoute;
  end;
end;

function TMXUpgrade.ReadSvrVers: Integer;
var
  rDynArr: TDynArray;
  rItem: TUpgradeVerItem;
//  rVerResp: Variant;
//  rVerData: Variant;
//  rVerDatas: TJSONVariantData;
  I: Integer;
//  vVerItem: Variant;
  ASuperObject:ISuperObject;
  vVerItem: ISuperObject;
begin
  rDynArr.Init(TypeInfo(TUpgradeVerItemDynArray), FNewVers);
  rDynArr.Clear;
  /// Version 参数
  ///  verid = 当前的版本号
  ///  vertype = 当前的版本类型
  ///  http://192.168.0.103:4593/v1/tools/version?verid=2103130312&vertype=1

//  if FHttp.Get(SAPI_Version, ['verid', FCurrVer.ID, 'vertype', FCurrVer.VerType]) = 200 then
  if FHttp.Get(SAPI_Version, []) = 200 then
  begin



    //'[{"id":2310171501,"ver":"3.10.1017","info":"1.浼樺寲5.0鍟嗗搧閾炬帴"}]'
//    rVerResp.Init(UTF8ToString(FHttp.OutData));
//    rVerResp := JSONVariant(UTF8ToString(FHttp.OutData));

    ASuperObject:=SO(UTF8ToString(FHttp.OutData));

//  //用来拼接口地址的吗？
//  rAPIList := JSONVariantDataSafe(vDatas.apilist, jvArray);
//  if rAPIList.Kind = jvArray then
//    for I := 0 to rAPIList.Count - 1 do
//      FAPIList.Add(v2s(rAPIList.Item[i]));

//    rVerData:=JSONVariantDataSafe(rVerResp.Data,jvObject);
//    rVerDatas:=JSONVariantDataSafe(rVerData.RecordList,jvArray);
//
//    for I := 0 to rVerDatas.Count - 1 do
//    begin
//      vVerItem := rVerDatas.Item[i];
//      rItem.ID := VarToInt64(vVerItem.id);
//      rItem.Version := v2s(vVerItem.ver);
//      rItem.Info := v2s(vVerItem.info);
//      rItem.VerType := FCurrVer.VerType;
//      rDynArr.Add(rItem);
//    end;

    for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length - 1 do
    begin
      vVerItem := ASuperObject.O['Data'].A['RecordList'].O[i];
//      rItem.ID := vVerItem.I['fid'];
      rItem.Version := vVerItem.S['version'];
      rItem.Info := vVerItem.S['update_log'];
      rItem.IsMustUpdate := vVerItem.I['is_must_update'];

//      rItem.VerType := FCurrVer.VerType;

      rItem.ProgramName := vVerItem.S['program_name'];
      rItem.Platform := vVerItem.S['platform'];


      rDynArr.Add(rItem);
    end;


  end;

  Result := rDynArr.Count;
end;

function TMXUpgrade.UpdateFiles: Boolean;
begin
  Result := False;
  if not CheckCacheFiles or not KillTarget then
    Exit;

  UncompressFiles;
  WriteVerInfo;
  Result := True;
end;

function FindUpgradeFileItem(const A,B): integer;
begin
  Result := -1;
  if SameText(TUpgradeFileItem(A).FileName, TUpgradeFileItem(b).FileName) then
    Result := 0;
end;

function TMXUpgrade.CheckCacheFiles: Boolean;
var
  I: Integer;
  sHash: string;
  sOrgKey: string;
  sSrcFile: string;
begin
  Result := True;
  for I := 0 to Length(FFileItems) - 1 do
  begin
    sOrgKey := FFileItems[i].FileKey;
    sSrcFile := CachePath + sOrgKey;
    if not FileExists(sSrcFile) then
    begin
      Result := FAlse;
      Break;
    end;

//    sHash := GetFileHashOfMd5(sSrcFile);
//    if not SameText(sOrgKey, sHash) then
//    begin
//      Result := False;
//      Break;
//    end;
  end;
end;

procedure TMXUpgrade.DoDownFiles;
var
  bExits: Boolean;
  I: Integer;
  sFileKey: string;
  sFileName: string;
  sHash: string;
  rDownParam: TUpgradeSvr;
begin
  rDownParam.Addr := FSvrParam.Addr;
  rDownParam.port := FSvrParam.Port;
  rDownParam.IsSSL := FSvrParam.IsSSL;
  rDownParam.API := GetURL(SAPI_DownFile);
  if not DirectoryExists(CachePath) then
    ForceDirectories(CachePath);

  for I := 0 to Length(FFileItems) - 1 do
  begin
    bExits := False;
    sFileKey := UpperCase(FFileItems[i].FileKey);
    sFileName :=  CachePath + sFileKey;
    if FileExists(sFileName) then
    begin
      sHash := UpperCase(GetFileHashOfMd5(sFileName));
      bExits := SameStr(sFileKey, sHash);
      if not bExits then
        DeleteFile(sFileName);
    end;
    ///v1/upgrade/
    if not bExits then
    begin
      try
      DownloadFile(rDownParam, sFileKey, sFileName, DoProcess);
      except on e: Exception do
        ;
      end;
    end;
  end;
end;

procedure TMXUpgrade.DoOnThreadFinsh(Sender: TObject);
begin
  FDownLoading := False;
  if assigned(FOnDownFinished) then
    FOnDownFinished(Self);
end;

procedure TMXUpgrade.DoProcess(Sender: TObject; CurrentSize, ContentLength:
    DWORD; var ACancel: boolean);
begin
  //FContentLength := ContentLength;
  //FCurrentSize := CurrentSize;
  if FProgressHandle <> 0 then
    PostMessage(FProgressHandle, UM_FileTraffic, 0, Round(CurrentSize/ContentLength * 100));
end;

function TMXUpgrade.GetCachePath: string;
begin
  Result := GetUserLocalPath + 'upgrade\' ;
end;

function TMXUpgrade.GetCurrVer: PUpgradeVerItem;
begin
  Result := @FCurrVer;
end;

function TMXUpgrade.GetExtractPath: string;
begin
  Result := WorkPath + 'extfiles\';
end;

function TMXUpgrade.GetNewVerCount: Integer;
begin
  Result := Length(FNewVers);
end;

function TMXUpgrade.GetUserLocalPath: string;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0 .. MaxChar] of char;
  sPath: string;
begin
  SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, SHGFP_TYPE_CURRENT, @path[0]);
  sPath := path;
  sPath := sPath + '\' + DirName + '\';

  if not DirectoryExists(sPath) then
    ForceDirectories(sPath);
  Result := sPath;
end;

//function TMXUpgrade.GetVersionPath: string;
//var
//  sUserPath: string;
//begin
//  ///
//  ///  每个目录独立版本
//  ///    版本信息记录在用户数据目录下
//  ///
//
//  sUserPath := WorkPath + 'UserData\';
//  if not DirectoryExists(sUserPath) then
//    if not ForceDirectories(sUserPath) then
//      raise Exception.Create(SMSG_CreateDirFailed + sUserPath);
//
//  Result := sUserPath;
//end;

function TMXUpgrade.KillTarget: Boolean;
var
  pData:PChar;
  sName: string;
begin
  Result := True;
  if FTargetExec = '' then
    Exit;

  pData := PChar(FTargetExec);
  while TryReadNextValue(pData, sName) do
  begin
    if KillTask(sName) <> 0 then
    begin
      Result := False;
      Break;
    end;
  end;

  if Result then
  begin
    Sleep(3000); // 需要等待被杀的进程完全结束
  end;
end;

function TMXUpgrade.ReadSvrUpgradeFiles(const AIDList: string): integer;
var
  rArr: TDynArray;
  rFileDatas: TJSONVariantData;
  I: Integer;
  idx: Integer;
  rFile: TUpgradeFileItem;
//  vItem: Variant;
  ASuperObject:ISuperObject;
  vItem: ISuperObject;

begin
  Result := 0;
  rArr.Init(TypeInfo(TUpgradeFileItemDynArray), FFileItems);
  rArr.Clear;
  ///
  ///  API 参数
  ///     verlist --  多个版本ID使用逗号分隔
  ///
  ///  eg. http://192.168.0.103:4593/v1/tools/upgrade?verlist=2103130313
//  if FHttp.Get(SAPI_Upgrade, ['verlist', AIDList]) <> 200 then
//    Exit;

  if FHttp.Get(SAPI_Upgrade, []) <> 200 then
    Exit;

  //'[{"id":521,"verid":2310171501,"filename":"MXFacebookManager.exe","path":"","filekey":"534A66B5CD6EC0FF7608DF4D2D929D06","filetype":0,"note":""}]'
//  rFileDatas.Init(UTF8ToString(FHttp.OutData));

  ASuperObject:=SO(UTF8ToString(FHttp.OutData));


//  if rFileDatas.Kind = jvArray then
//  begin
//    rArr.Compare := FindUpgradeFileItem;
//    for I := 0 to rFileDatas.Count - 1 do
//    begin
//      vItem := rFileDatas.Item[i];
//      rFile.ID := VarToInt64(vItem.id);
//      rFile.VerID := VarToInt64(vItem.verid);
//      rFile.FileName := v2s(vItem.filename);
//      rFile.Path := v2s(vItem.path);
//      rFile.FileKey := v2s(vItem.filekey);
//      rFile.FileType := VarToInt(vItem.filetype);
//      rFile.Note := v2s(vItem.note);
//
//      ///
//      ///  相同文件取版本最大的那个文件
//      ///
//      idx := rArr.Find(rFile);
//      if idx = -1 then
//        rArr.Add(rFile)
//      else if FFileItems[idx].VerID < rFile.VerID then
//        FFileItems[idx] := rFile;
//    end;
//  end;



    rArr.Compare := FindUpgradeFileItem;
    for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length - 1 do
    begin
      vItem := ASuperObject.O['Data'].A['RecordList'].O[i];
//      rFile.ID := vItem.I['fid'];
      rFile.VerID := vItem.S['version'];
      rFile.FileName := vItem.S['filename'];
//      rFile.Path := vItem.S['path'];
      rFile.FileKey := vItem.S['filekey'];
//      rFile.FileType := vItem.I['filetype'];
      rFile.Note := vItem.S['note'];

      ///
      ///  相同文件取版本最大的那个文件
      ///
      idx := rArr.Find(rFile);
      if idx = -1 then
        rArr.Add(rFile)
      else if FFileItems[idx].VerID < rFile.VerID then
        FFileItems[idx] := rFile;
    end;


  Result := rArr.Count;
end;

procedure TMXUpgrade.SetUseThreadDown(const Value: Boolean);
begin
  FUseThreadDown := Value;
end;

function TMXUpgrade.UncompressFiles: Boolean;
var
  I: Integer;
  cArchiver : TZipForge;
  sExtPath: string;
begin
  sExtPath := WorkPath;

  cArchiver := TZipForge.Create(nil);
  try
    for I := 0 to length(FFileItems) - 1 do
    begin
      cArchiver.FileName := CachePath + FFileItems[i].FileKey;
      cArchiver.OpenArchive(fmOpenRead);
      cArchiver.BaseDir := sExtPath;
      cArchiver.ExtractFiles('*.*');
      cArchiver.CloseArchive;
    end;
  finally
    cArchiver.Free;
  end;
  Result := True;
end;

procedure TMXUpgrade.WriteVerInfo;
  procedure SaveToFile(const AFileName: string; const AData: RawByteString);
  var cFile: TFileStream;
  begin
    cFile := TFileStream.Create(AFileName, fmCreate);
    try
      cFile.Write(PByteArray(AData)[0], Length(AData));
    finally
      cFile.Free;
    end;
  end;
var
  idx: Integer;
  I: Integer;
  sFileName: string;
  sDataVer: RawByteString;
begin
  idx := 0;
  for I := 1 to Length(FNewVers) - 1 do
//    if FNewVers[idx].ID < FNewVers[i].ID then
    if FNewVers[idx].Version < FNewVers[i].Version then
      idx := i;
  FCurrVer := FNewVers[idx];


//  sDataVer := JSONEncode(['id', FCurrVer.ID,
//                      'ver', FCurrVer.Version,
//                      'info', FCurrVer.Info,
//                      'vertype', FCurrVer.VerType
//                      ]);
//  sFileName := VersionPath + 'current' + IntToStr(FCurrVer.VerType) + '.ver';

  //就是记录一下当前的版本号而已
  sDataVer := JSONEncode([//'id', FCurrVer.ID,
                      'ver', FCurrVer.Version,
                      'info', FCurrVer.Info,
                      //'vertype', FCurrVer.VerType
                      'program_name', FCurrVer.ProgramName,
                      'platform', FCurrVer.Platform
                      ]);
  sFileName := WorkPath + 'current_' + FCurrVer.ProgramName + '.ver';

  SaveToFile(sFileName, sDataVer);
end;

constructor TDownloadWorkThread.Create(AOwner: TMXUpgrade);
begin
  inherited Create(True);  // 手工启动
  FOwner := AOwner;
end;

procedure TDownloadWorkThread.DoProcess(Sender: TObject; CurrentSize,
    ContentLength: DWORD; var ACancel: boolean);
begin
  FContentLength := ContentLength;
  FCurrentSize := CurrentSize;
  if FOwner.FProgressHandle <> 0 then
    PostMessage(FOwner.FProgressHandle, UM_FileTraffic, 0, Round(FCurrentSize/FContentLength * 100));
end;

procedure TDownloadWorkThread.Execute;
var
  bExits: Boolean;
  I: Integer;
  sFileKey: string;
  sFileName: string;
  rDownParam: TUpgradeSvr;
//  rOssParam: TUpgradeSvr;
//  sOssFileName: string;

begin
  FreeOnTerminate:= True;

  rDownParam.Addr := FOwner.FSvrParam.Addr;
  rDownParam.port := FOwner.FSvrParam.Port;
  rDownParam.IsSSL := FOwner.FSvrParam.IsSSL;
  rDownParam.API := FOwner.GetURL(SAPI_DownFile);
  if not DirectoryExists(FOwner.CachePath) then
    ForceDirectories(FOwner.CachePath);

  for I := 0 to Length(FOwner.FFileItems) - 1 do
  begin
    while self.Terminated do
      Break;

    sFileKey := FOwner.FFileItems[i].FileKey;
    sFileName :=  FOwner.CachePath + sFileKey;

    bExits := FileValid(sFileName, sFileKey);


    // Oss 下载
    ///v1/upgrade/
    //((104, 2108251727, 'MXSearcher.exe', '', '7E40CF94B91F8E28AC4E12A24B69EF3B', 0, ''),
    // (13, 2103171550, 'MXFatcher.exe', '', '6B9ABEE97D0FB006BC68EF630A06B642', 0, ''),
    // (102, 2108241507, 'cef91.dir', '', '545CF8C5295CABFAC7E571D278AAA2AE', 0, ''))
    // ('mxsearch.laifuyun.com', 443, True, '/v1/upgrade/')
    // https://puc.oss-cn-hangzhou.aliyuncs.com/mxsstatic/2108241507.545CF8C5295CABFAC7E571D278AAA2AE.cef91.dir.pack
    // https://mxsstaitc.fumamx.com/mxsstatic/755C5BA2-D401-41b7-A0FE-7DC7F4BAFF86.png
//    rOssParam.Addr := 'mxsstaitc.fumamx.com';
//    rOssParam.port := 443;
//    rOssParam.IsSSL := True;
//    rOssParam.API := '/mxsstatic/';
//
//    //'2310171501.534A66B5CD6EC0FF7608DF4D2D929D06.MXFacebookManager.exe.pack'
//    sOssFileName := Format('%d.%s.%s.pack', [FOwner.FFileItems[i].VerID, FOwner.FFileItems[i].FileKey, FOwner.FFileItems[i].FileName]);
//    if not bExits then
//    begin
//      try
//        DownloadFile(rOssParam, sOssFileName, sFileName, DoProcess);
//        bExits := FileValid(sFileName, sFileKey);
//      except on e: Exception do ;
//      end;
//    end;
//
//    // 通用文件没带版本号
//    if not bExits then
//    begin
//      sOssFileName := Format('%s.%s.pack', [FOwner.FFileItems[i].FileKey, FOwner.FFileItems[i].FileName]);
//      try
//        DownloadFile(rOssParam, sOssFileName, sFileName, DoProcess);
//        bExits := FileValid(sFileName, sFileKey);
//      except on e: Exception do ;
//      end;
//    end;
//
//    // MXSearcher 服务器
//    if not bExits then
//    begin
      try
        DownloadFile(rDownParam, FOwner.FFileItems[i].VerID+'/'+sFileKey, sFileName, DoProcess);
      except on e: Exception do
        ;
      end;
//    end;
  end;
end;

function TDownloadWorkThread.FileValid(const AFileName, AHash: string): Boolean;
var
  bValid: Boolean;
  sHash: string;
begin
  bValid := False;
  if FileExists(AFileName) then
  begin
    sHash := UpperCase(GetFileHashOfMd5(AFileName));
    bValid := SameStr(AHash, sHash);
    if not bValid then
      DeleteFile(AFileName);
  end;
  Result := bValid;
end;

end.

