//convert pas to utf8 by ¥
//数据库模块基类
unit uBaseDataBaseModule;

interface
{$IF DEFINED(ANDROID) OR DEFINED(IOS) OR DEFINED(MACOS) }
  {$DEFINE FMX}
{$IFEND}



//请在工程下放置FrameWork.inc
//或者在工程设置中配置FMX编译指令
//才可以正常编译此单元
{$IFNDEF FMX}
  {$IFNDEF VCL}
    {$I FrameWork.inc}
  {$ENDIF}
{$ENDIF}



uses
  System.SysUtils,
  System.Classes,

//  Vcl.Controls,
//  Vcl.StdCtrls,
//  Vcl.ExtCtrls,
//  uLang,
  {$IFDEF FMX}
//  FMX.Types,
  {$ENDIF}
//  {$IFDEF VCL}
//  ExtCtrls,
//  {$ENDIF}
//  StdCtrls,

//  Forms,
  uBaseLog,
  DateUtils,
//  XSuperObject,
  uBaseDBHelper,
  uBaseList,
  uFileCommon,
  uTimerTask,
  SyncObjs,
  Generics.Collections,

  uObjectPool,
  uSQLUpgradeItem,

    {$IFDEF SKIN_SUPEROBJECT}
    uSkinSuperObject,
    uSkinSuperJson,
    {$ELSE}
    XSuperObject,
    XSuperJson,
    {$ENDIF}

  {$IFDEF NOT_USE_kbmMWUNIDACConnectionPool}
  {$ELSE}
  //kbmMWUniDAC,
//  kbmMWCustomSQLMetaData, kbmMWMSSQLMetaData,
  //kbmMWCustomConnectionPool,
//  MySQLUniProvider,
//  SQLServerUniProvider,

  UniProvider, Data.DB, DBAccess, Uni,
  uUniDBHelper,
  uUniDBHelperPool,
  {$ENDIF}

  uDataBaseConfig;




type
  TDatabaseModuleStatus=record
    //最大个数
    MaxCount:Integer;
    //当前个数
    CurCount:Integer;
    //占用次数
    LockTimes:Integer;
    //释放次数
    UnlockTimes:Integer;

    //检测连接次数
    CheckConnectTimes:Integer;
    //连接连接数
    ConnectedTimes:Integer;
    //连接断开数
    DisconnectedTimes:Integer;
    //重连成功次数
    ReConnectedTimes:Integer;
  end;

  TBaseDatabaseModuleClass=class of TBaseDatabaseModule;
  TBaseDatabaseModule=class
  public
//    Name:String;

    //独享的数据库连接配置
    DBConfig: TDataBaseConfig;

//    //数据库类型,MYSQL,MSSQL等
//    DBType:String;

    //DBHelper池
    DBHelperPool:TObjectPool;
    FDBHelperPoolErrorMsg:String;


    //数据库配置文件名
    FDBConfigFileName:String;



    FStatus:TDatabaseModuleStatus;



    //是否已连接数据库,避免重复启动
    IsStarted:Boolean;

//    //数据库查询使用组件
//    DBHelper: TBaseDBHelper;
    procedure SetDBConfigFileName(const Value: String);

    procedure DoDBHelperPoolLockFailException(Sender: TObject; E: Exception);
  public
    function GetDBHelperFromPool(var ASQLDBHelper:TBaseDBHelper;var ADesc:String):Boolean;virtual;
    procedure FreeDBHelperToPool(ASQLDBHelper:TBaseDBHelper);virtual;
  public
    procedure tmrActiveMySQLPoolConnectionTimer(Sender: TObject);virtual;

    //准备启动
    function DoPrepareStart(var AError:String): Boolean;virtual;
    //准备停止
    function DoPrepareStop: Boolean;virtual;
    //获取数据库状态
    function GetStatus():TDatabaseModuleStatus;virtual;abstract;
    function GetStatusStr:String;
    function UpdateDataBase(ADBName:String;ASQLUpgradeList:TSQLUpgradeList;var ADesc:String):Boolean;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    //数据库配置文件名
    property DBConfigFileName: String read FDBConfigFileName write SetDBConfigFileName;
  end;

  TBaseDatabaseModuleList=class(TBaseList)
  private
    function GetItem(Index: Integer): TBaseDatabaseModule;
  public
    procedure SaveToJsonArray(AJsonArray:ISuperArray);
    procedure LoadFromJsonArray(AJsonArray:ISuperArray);
    function FindByName(AName:String):TBaseDatabaseModule;
    function FindByFid(fid:String):TBaseDatabaseModule;
    property Items[Index:Integer]:TBaseDatabaseModule read GetItem;default;
  end;





  //根据Hash的首字母分多个数据库
  THashDBModuleManager=class
  public
    FDBFileDir:String;
    FDBFileName:String;
    FLock:TCriticalSection;
    FDBModuleList:TBaseDatabaseModuleList;
    FDBModuleClass:TBaseDatabaseModuleClass;
    constructor Create(ADBFileName:String;ADBFileDir:String;ADBModuleClass:TBaseDatabaseModuleClass);
    destructor Destroy;override;
  public
    //根据Hash的首字母获取指定的数据库
    function GetDBModule(AHash:String;var ADesc:String):TBaseDatabaseModule;
//    procedure PrepareDBModules(var ADesc:String);
  end;


  TActiveMySQLPoolConnectionThread=class(TBaseServiceThread)
  protected
    FDatabaseModule:TBaseDatabaseModule;
    procedure Execute;override;
  public
    constructor Create(ACreateSuspended:Boolean;ADatabaseModule:TBaseDatabaseModule);
  end;




var
  GlobalDatabaseModuleClass:TBaseDatabaseModuleClass;
var
  GlobalDBModule:TBaseDatabaseModule;



implementation





{ TBaseDatabaseModule }

constructor TBaseDatabaseModule.Create;
begin
  DBConfig := TDataBaseConfig.Create;
end;

destructor TBaseDatabaseModule.Destroy;
begin
  FreeAndNil(DBConfig);
  FreeAndNil(DBHelperPool);

  inherited;
end;

procedure TBaseDatabaseModule.DoDBHelperPoolLockFailException(Sender: TObject;
  E: Exception);
begin
  FDBHelperPoolErrorMsg:=E.Message;
end;

function TBaseDatabaseModule.DoPrepareStart(var AError: String): Boolean;
begin


end;

function TBaseDatabaseModule.DoPrepareStop: Boolean;
begin

end;

procedure TBaseDatabaseModule.FreeDBHelperToPool(ASQLDBHelper: TBaseDBHelper);
begin


  ASQLDBHelper.UnlockConnectionToPool;
  Self.DBHelperPool.FreeCustomObject(ASQLDBHelper);

  //归还次数
  Inc(FStatus.UnLockTimes);


end;

function TBaseDatabaseModule.GetDBHelperFromPool(var ASQLDBHelper: TBaseDBHelper; var ADesc: String): Boolean;
begin
  Result:=False;

  Self.DBHelperPool.OnLockFail:=Self.DoDBHelperPoolLockFailException;


  ASQLDBHelper:=TBaseDBHelper(Self.DBHelperPool.GetCustomObject);
  if ASQLDBHelper<>nil then
  begin
      ASQLDBHelper.DBType:=DBConfig.FDBType;


      //从数据库连接池中取出可用链接
      if (ASQLDBHelper.GetConnectionFromPool = nil) then
      begin
        ADesc:=('服务端无可用的数据库连接');
        Exit;
      end;


      //3分钟测试检测一下连接,ES和SQLITE不需要
      if ( SameText(DBConfig.FDBType,'MYSQL') or SameText(DBConfig.FDBType,'MSSQL') )
        and (DateUtils.SecondsBetween(ASQLDBHelper.FLastUseTime,Now)>3*60) then
      begin


          //2分钟测试检测一下连接
          Inc(FStatus.CheckConnectTimes);
          if not ASQLDBHelper.SelfQuery('SELECT 1') then
          begin


              //连接失败
              Inc(FStatus.DisconnectedTimes);


              {$IFDEF NOT_USE_kbmMWUNIDACConnectionPool}
              {$ELSE}
              if TUniDBHelper(ASQLDBHelper).FUnidacConnection.Database.Connected then
              begin
                //重连成功
                Inc(FStatus.ReConnectedTimes);
              end;
              {$ENDIF}



          end
          else
          begin
              //已连接
              Inc(FStatus.ConnectedTimes);
          end;

      end;
      ASQLDBHelper.FLastUseTime:=Now;


      //使用次数
      Inc(FStatus.LockTimes);

      Result:=True;
  end
  else
  begin
      ADesc:=FDBHelperPoolErrorMsg;
  end;

end;

function TBaseDatabaseModule.GetStatusStr: String;
var
  ALog:String;
  ASumCurCount:Integer;
  ADatabaseModuleStatus:TDatabaseModuleStatus;
begin
    ALog:='';
    ADatabaseModuleStatus:=Self.GetStatus;
    //      Self.gridDatabasePool.Cells[1,I+1]:=IntToStr(ADatabaseModuleStatus.MaxCount);
          ALog:=ALog+'最大数:'+IntToStr(ADatabaseModuleStatus.MaxCount)+#9;
    //      Self.gridDatabasePool.Cells[2,I+1]:=IntToStr(ADatabaseModuleStatus.CurCount);
          ALog:=ALog+'当前数:'+IntToStr(ADatabaseModuleStatus.CurCount)+#9;
          ASumCurCount:=ASumCurCount+ADatabaseModuleStatus.CurCount;

    //      Self.gridDatabasePool.Cells[3,I+1]:=IntToStr(ADatabaseModuleStatus.LockTimes);
          ALog:=ALog+'使用次数:'+IntToStr(ADatabaseModuleStatus.LockTimes)+#9;
    //      Self.gridDatabasePool.Cells[4,I+1]:=IntToStr(ADatabaseModuleStatus.UnlockTimes);
          ALog:=ALog+'归还次数:'+IntToStr(ADatabaseModuleStatus.UnlockTimes)+#9;
    //      Self.gridDatabasePool.Cells[5,I+1]:=IntToStr(ADatabaseModuleStatus.CheckConnectTimes);
          ALog:=ALog+'检测连接状态次数:'+IntToStr(ADatabaseModuleStatus.CheckConnectTimes)+#9;
    //      Self.gridDatabasePool.Cells[6,I+1]:=IntToStr(ADatabaseModuleStatus.ConnectedTimes);
          ALog:=ALog+'连接成功次数:'+IntToStr(ADatabaseModuleStatus.ConnectedTimes)+#9;
    //      Self.gridDatabasePool.Cells[7,I+1]:=IntToStr(ADatabaseModuleStatus.DisconnectedTimes);
          ALog:=ALog+'连接断开次数:'+IntToStr(ADatabaseModuleStatus.DisconnectedTimes)+#9;
    //      Self.gridDatabasePool.Cells[8,I+1]:=IntToStr(ADatabaseModuleStatus.ReConnectedTimes);
          ALog:=ALog+'重连成功次数:'+IntToStr(ADatabaseModuleStatus.ReConnectedTimes)+#13#10;

    Result:=ALog;
end;

procedure TBaseDatabaseModule.SetDBConfigFileName(const Value: String);
begin
  if FDBConfigFileName<>Value then
  begin
      FDBConfigFileName := Value;

      DBConfig.Clear;

      if FDBConfigFileName<>'' then
      begin
          if FileExists(GetApplicationPath+FDBConfigFileName) then
          begin
              //加载数据库配置文件
              DBConfig.Load(FDBConfigFileName);
          end
          else
          begin
              //使用手动设置
              uBaseLog.HandleException(nil,'TBaseDatabaseModule.SetDBConfigFileName '+FDBConfigFileName+' not found!');
              //AError:='数据库配置文件'+DBConfigFileName+' 不存在!';
              //Exit;
          end;
      end;
  end;
end;


procedure TBaseDatabaseModule.tmrActiveMySQLPoolConnectionTimer(
  Sender: TObject);
begin

end;

function TBaseDatabaseModule.UpdateDataBase(ADBName:String;ASQLUpgradeList:TSQLUpgradeList;var ADesc:String):Boolean;
var
  ANowDatabaseVer:String;
  ANewDatabaseVer:String;
  ANeedUpdateSQL:String;
  ASQLDBHelper:TBaseDBHelper;
  I: Integer;
begin
  //升级
  ANowDatabaseVer:='';
  ANewDatabaseVer:='';
  //检查数据库并更新
  ADesc:='';
  if not Self.GetDBHelperFromPool(ASQLDBHelper,ADesc) then
  begin
    Exit;
  end;
  try

//                                      +'INSERT INTO tblversion (name,version) SELECT  WHERE NOT EXISTS (SELECT * FROM tblversion); ',

      if SameText(Self.DBConfig.FDBType,'MSSQL')
        or SameText(Self.DBConfig.FDBType,'MSSQL2000')
        or SameText(Self.DBConfig.FDBType,'SQLSERVER')
        or SameText(Self.DBConfig.FDBType,'SQLSERVER2000') then
      begin
        //判断是否存在版本信息表，不存在就创建
        ASQLDBHelper.SelfQuery('if not exists (select * from sysobjects where id = object_id(''tblversion'') and OBJECTPROPERTY(id, ''IsUserTable'') = 1) '
                                +' CREATE TABLE tblversion(name varchar(150),version varchar(50)); ',
                                     [],[],asoExec);
      end
      else
      begin
        //SQLite
        ASQLDBHelper.SelfQuery('CREATE TABLE IF NOT EXISTS tblversion(name varchar(150),version varchar(50)); ',
                                     [],[],asoExec);
      end;

      //查询数据库版本号
      if not ASQLDBHelper.SelfQuery('SELECT * FROM tblversion WHERE name=:name;',
                                   ['name'],
                                   [ADBName],
                                   asoOpen) then
      begin
        //数据库连接失败或异常
        ADesc := ADesc + #13#10 + '查tblversion时' + '数据库连接失败或异常' + ' ' + ASQLDBHelper.LastExceptMessage;
        Exit;
      end
      else
      begin

          if not ASQLDBHelper.Query.Eof then
          begin
            //存在
            ANowDatabaseVer:= ASQLDBHelper.Query.FieldByName('version').Value;
          end
          else
          begin
            //不存在
            //这个时间点刚加的数据库自动更新功能
            ANowDatabaseVer:='2024-06-06 17:06:00';
            ANeedUpdateSQL:='insert into tblversion (name,version) values( '+QuotedStr(ADBName)+','+QuotedStr(ANowDatabaseVer)+');';
            if not ASQLDBHelper.SelfQuery(ANeedUpdateSQL, [], [], asoExec) then
            begin
              //数据库连接失败或异常
              ADesc := ADesc + #13#10 + '插入tblversion时' + '数据库连接失败或异常' + ' ' + ASQLDBHelper.LastExceptMessage;
              Exit;
            end;
          end;


          for I := 0 to ASQLUpgradeList.Count-1 do
          begin
            if TSQLUpgradeItem(ASQLUpgradeList[I]).ver > ANowDatabaseVer then
            begin
                ANeedUpdateSQL:=ASQLUpgradeList[I].SQL;
                if SameText(Self.DBConfig.FDBType,'MSSQL')
                  or SameText(Self.DBConfig.FDBType,'MSSQL2000')
                  or SameText(Self.DBConfig.FDBType,'SQLSERVER')
                  or SameText(Self.DBConfig.FDBType,'SQLSERVER2000')
                  and (ASQLUpgradeList[I].SQLServerSQL<>'') then
                begin
                  ANeedUpdateSQL:=ASQLUpgradeList[I].SQLServerSQL;
                end
                else if SameText(Self.DBConfig.FDBType,'MYSQL')
                  and (ASQLUpgradeList[I].MysqlSQL<>'') then
                begin
                  ANeedUpdateSQL:=ASQLUpgradeList[I].MysqlSQL;
                end
                else if SameText(Self.DBConfig.FDBType,'SQLite')
                  and (ASQLUpgradeList[I].SQLiteSQL<>'') then
                begin
                  ANeedUpdateSQL:=ASQLUpgradeList[I].SQLiteSQL;
                end;

                ANeedUpdateSQL:=ANeedUpdateSQL;//+#13#10+'update tblversion set version = '+QuotedStr(TSQLUpgradeItem(ASQLUpgradeList[I]).ver)+';';
                if not ASQLDBHelper.SelfQuery(ANeedUpdateSQL, [], [], asoExec) then
                begin
                  //数据库连接失败或异常
                  ADesc := ADesc + #13#10 + '执行更新脚本时' + '数据库连接失败或异常' + ' ' + ASQLDBHelper.LastExceptMessage;
                  //Exit; 数据库更新不建议把服务启动中断
                end;

                ANeedUpdateSQL:='update tblversion set version = '+QuotedStr(TSQLUpgradeItem(ASQLUpgradeList[I]).ver)+';';
                if not ASQLDBHelper.SelfQuery(ANeedUpdateSQL, [], [], asoExec) then
                begin
                  //数据库连接失败或异常
                  ADesc := ADesc + #13#10 + '更新tblversion时' + '数据库连接失败或异常' + ' ' + ASQLDBHelper.LastExceptMessage;
                  //Exit; 数据库更新不建议把服务启动中断
                end;


            end;
          end;

      end;

  finally
    Self.FreeDBHelperToPool(ASQLDBHelper);
  end;
end;

{ TActiveMySQLPoolConnectionThread }

constructor TActiveMySQLPoolConnectionThread.Create(
  ACreateSuspended:Boolean;ADatabaseModule: TBaseDatabaseModule);
begin
  FDatabaseModule:=ADatabaseModule;
  Inherited Create(ACreateSuspended);
end;

procedure TActiveMySQLPoolConnectionThread.Execute;
begin
  while not Self.Terminated do
  begin
    uBaseLog.HandleException(nil, 'TActiveMySQLPoolConnectionThread.Execute');

    //十分钟检测一次
    SleepThread(2*60*1000);

    FDatabaseModule.tmrActiveMySQLPoolConnectionTimer(nil);

  end;

end;


{ TBaseDatabaseModuleList }

function TBaseDatabaseModuleList.FindByName(AName: String): TBaseDatabaseModule;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Self.Count-1 do
  begin
    if Items[I].DBConfig.FName=AName then
    begin
      Result:=Items[I];
      Break;
    end;
  end;
end;

function TBaseDatabaseModuleList.FindByFID(fid: String): TBaseDatabaseModule;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Self.Count-1 do
  begin
    if Items[I].DBConfig.fid=fid then
    begin
      Result:=Items[I];
      Break;
    end;
  end;
end;

function TBaseDatabaseModuleList.GetItem(Index: Integer): TBaseDatabaseModule;
begin
  Result:=TBaseDatabaseModule(Inherited Items[Index]);
end;

procedure TBaseDatabaseModuleList.LoadFromJsonArray(AJsonArray: ISuperArray);
var
  I: Integer;
  ADatabaseModule:TBaseDatabaseModule;
begin
  Clear;
  for I := 0 to AJsonArray.Length-1 do
  begin
    ADatabaseModule:=GlobalDatabaseModuleClass.Create;
    ADatabaseModule.DBConfig.LoadFromJson(AJsonArray.O[I]);
    Self.Add(ADatabaseModule);
  end;


end;

procedure TBaseDatabaseModuleList.SaveToJsonArray(AJsonArray: ISuperArray);
var
  I: Integer;
  ADatabaseModule:TBaseDatabaseModule;
begin
  for I := 0 to Count-1 do
  begin
    ADatabaseModule:=TBaseDatabaseModule(Items[I]);
    ADatabaseModule.DBConfig.SaveToJson(AJsonArray.O[I]);
  end;


end;



{ THashDBModuleManager }

constructor THashDBModuleManager.Create(ADBFileName:String;ADBFileDir:String;ADBModuleClass:TBaseDatabaseModuleClass);
begin
  FDBFileName:=ADBFileName;
  FDBFileDir:=ADBFileDir;
  FDBModuleList:=TBaseDatabaseModuleList.Create;
  FDBModuleClass:=ADBModuleClass;
  FLock:=TCriticalSection.Create;

end;

destructor THashDBModuleManager.Destroy;
begin
  FreeAndNil(FLock);
  FreeAndNil(FDBModuleList);
  inherited;
end;

function THashDBModuleManager.GetDBModule(AHash: String;var ADesc:String): TBaseDatabaseModule;
var
  ASQLDBHelper:TBaseDBHelper;
  ADBModule:TBaseDatabaseModule;
  ATableBackFix:String;
begin
//  ATableBackFix:=Copy(AHash,1,2);
  //只取一位首字母
//  ATableBackFix:=Copy(AHash,1,1);

  //写死,先只用一个
  ATableBackFix:='0';

  Result:=Self.FDBModuleList.FindByName(ATableBackFix);
  if Result=nil then
  begin
    FLock.Enter;
    try

      //进来之后,再找一次
      Result:=Self.FDBModuleList.FindByName(ATableBackFix);
      if Result<>nil then Exit;


      ForceDirectories(FDBFileDir);

      //不存在,则新建
      Result:=FDBModuleClass.Create;
      Result.DBConfig.FName:=ATableBackFix;

      Result.DBConfig.FDBType:='SQLITE';
      Result.DBConfig.FDBHostName:='';
      Result.DBConfig.FDBHostPort:='';
      Result.DBConfig.FDBUserName:='';
      Result.DBConfig.FDBPassword:='';
      Result.DBConfig.FMaxConnections:=1;
      Result.DBConfig.FDBDataBaseName:=FDBFileDir+FDBFileName+'_'+Result.DBConfig.FName+'.db';
      Result.DBHelperPool.MaxCustomObjects:=1;
      Result.DoPrepareStart(ADesc);


      //执行下建库的脚本

      //检查数据库并更新
      ADesc:='';
      if not Result.GetDBHelperFromPool(ASQLDBHelper,ADesc) then
      begin
        Exit;
      end;
      try

        //判断是否存在版本信息表，不存在就创建
        if not ASQLDBHelper.SelfQuery('CREATE TABLE IF NOT EXISTS tblhash_fid_map("hash" varchar[50] NOT NULL,"fid" varchar[50] NOT NULL,PRIMARY KEY ("hash")); ',
                                     [],
                                     [],
                                     asoExec) then
        begin
          //数据库连接失败或异常
          ADesc := '判断是否存在版本信息表时' + '数据库连接失败或异常' + ' ' + ASQLDBHelper.LastExceptMessage;
          Exit;
        end;

      finally
        Result.FreeDBHelperToPool(ASQLDBHelper);
      end;


      Self.FDBModuleList.Add(Result);
    finally
      FLock.Leave;
    end;

  end;
end;

//procedure THashDBModuleManager.PrepareDBModules(var ADesc: String);
//begin
//  Self.GetDBModule('0',ADesc);
//  Self.GetDBModule('1',ADesc);
//  Self.GetDBModule('2',ADesc);
//  Self.GetDBModule('3',ADesc);
//  Self.GetDBModule('4',ADesc);
//  Self.GetDBModule('5',ADesc);
//  Self.GetDBModule('6',ADesc);
//  Self.GetDBModule('7',ADesc);
//  Self.GetDBModule('8',ADesc);
//  Self.GetDBModule('9',ADesc);
//  Self.GetDBModule('A',ADesc);
//  Self.GetDBModule('B',ADesc);
//  Self.GetDBModule('C',ADesc);
//  Self.GetDBModule('D',ADesc);
//  Self.GetDBModule('E',ADesc);
//  Self.GetDBModule('F',ADesc);
//  Self.GetDBModule('G',ADesc);
//  Self.GetDBModule('H',ADesc);
//  Self.GetDBModule('I',ADesc);
//  Self.GetDBModule('J',ADesc);
//  Self.GetDBModule('K',ADesc);
//  Self.GetDBModule('L',ADesc);
//  Self.GetDBModule('M',ADesc);
//  Self.GetDBModule('N',ADesc);
//  Self.GetDBModule('O',ADesc);
//  Self.GetDBModule('P',ADesc);
//  Self.GetDBModule('Q',ADesc);
//  Self.GetDBModule('R',ADesc);
//  Self.GetDBModule('S',ADesc);
//  Self.GetDBModule('T',ADesc);
//  Self.GetDBModule('U',ADesc);
//  Self.GetDBModule('V',ADesc);
//  Self.GetDBModule('W',ADesc);
//  Self.GetDBModule('X',ADesc);
//  Self.GetDBModule('Y',ADesc);
//  Self.GetDBModule('Z',ADesc);
//end;

end.
