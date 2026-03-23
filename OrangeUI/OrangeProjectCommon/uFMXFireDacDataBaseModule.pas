//
unit uFMXFireDacDataBaseModule;

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
  {$IFDEF VCL}
  ExtCtrls,
  {$ENDIF}
//  StdCtrls,

//  Forms,
  uBaseLog,
//  XSuperObject,
  uBaseDBHelper,
  uFireDBHelper,
  uBaseList,
  uFileCommon,
  Generics.Collections,

  uDataBaseConfig,
  uBaseDataBaseModule,
//  DataBaseConfigForm,
//  uTableCommonRestCenter,

  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,


//  UniProvider,
//  DBAccess, Uni,
  //kbmMWFireDac,
//  kbmMWCustomSQLMetaData, kbmMWMSSQLMetaData,
  //kbmMWCustomConnectionPool,
//  SQLiteUniProvider,
//  MySQLUniProvider,
//  SQLServerUniProvider,
//  Data.DB
  uFireDBHelperPool
  ;




type
  //FireMonkey平台下FireDac数据库访问模块
  TFMXFireDacDatabaseModule = class(TBaseDatabaseModule)
  private
//    FSQLiteUniProvider:TSQLiteUniProvider;
//    FMySQLUniProvider:TMySQLUniProvider;
//    FSQLServerUniProvider:TSQLServerUniProvider;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  public
    //是否已连接数据库,避免重复启动
    IsStarted:Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
  public
    //在服务启动的时候,会调用它们,确保数据库能连接成功
    //准备启动
    function DoPrepareStart(var AError:String): Boolean;override;
    //准备停止
    function DoPrepareStop: Boolean;override;

  public
  end;
  TDatabaseModule=TFMXFireDacDatabaseModule;




implementation





{ TFMXFireDacDatabaseModule }

constructor TFMXFireDacDatabaseModule.Create;
begin
  Inherited Create;

//  FSQLiteUniProvider:=TSQLiteUniProvider.Create(nil);
//  FMySQLUniProvider:=TMySQLUniProvider.Create(nil);
//  FSQLServerUniProvider:=TSQLServerUniProvider.Create(nil);

  FDPhysSQLiteDriverLink1:=TFDPhysSQLiteDriverLink.Create(nil);
  FDGUIxWaitCursor1:=TFDGUIxWaitCursor.Create(nil);



  //数据库连接池
  DBHelperPool:=TFireDBHelperPool.Create(nil);
  TFireDBHelperPool(DBHelperPool).FDBConfig:=DBConfig;
  TFireDBHelperPool(DBHelperPool).FIsUseFireDacConnectionPool:=False;

end;

destructor TFMXFireDacDatabaseModule.Destroy;
begin
  FreeAndNil(DBHelperPool);

  FreeAndNil(FDPhysSQLiteDriverLink1);
  FreeAndNil(FDGUIxWaitCursor1);

//  FreeAndNil(FSQLiteUniProvider);
//  FreeAndNil(FMySQLUniProvider);
//  FreeAndNil(FSQLServerUniProvider);
  Inherited;
end;

function TFMXFireDacDatabaseModule.DoPrepareStart(var AError:String): Boolean;
var
//  AOptions:TStringList;
  ADBHelper:TBaseDBHelper;
begin
  Result:=False;

  Inherited;


  if not IsStarted then
  begin
      if DBConfigFileName<>'' then
      begin
          if FileExists(GetApplicationPath+DBConfigFileName) then
          begin
              //加载数据库配置文件
              DBConfig.Load(DBConfigFileName);
          end
          else
          begin
              //使用手动设置
              uBaseLog.HandleException(nil,'TFMXFireDacDatabaseModule.DoPrepareStart '+DBConfigFileName+' not found!');
              AError:='数据库配置文件'+DBConfigFileName+' 不存在!';
              Exit;
          end;
      end;




      if not DBConfig.IsEmpty then
      begin


          //从连接池中取一个DBHelper
          if not Self.GetDBHelperFromPool(ADBHelper,AError) then
          begin
            Exit;
          end;
          try

              //有数据库配置,需要连接
              //测试连接
              if not ADBHelper.Connect(DBConfig) then
              begin
                  AError:='数据库'+DBConfig.FDBDataBaseName+' 连接失败!';
                  Exit;
              end;

          finally
            Self.FreeDBHelperToPool(ADBHelper);
          end;


      end
      else
      begin
        //raise Exception.Create('TFMXFireDacDatabaseModule.DoPrepareStart DBConfig is empty!');
      end;

  end;
  Result := True;

  IsStarted:=True;
end;

function TFMXFireDacDatabaseModule.DoPrepareStop: Boolean;
begin
  Result:=False;

  IsStarted:=False;



  Result := True;
end;



initialization
  GlobalDatabaseModuleClass:=TFMXFireDacDatabaseModule;




end.
