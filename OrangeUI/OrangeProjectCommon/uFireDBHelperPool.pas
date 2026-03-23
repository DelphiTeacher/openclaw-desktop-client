//convert pas to utf8 by ¥
//Uni数据库操作类的线程池,用于连接MSSQL//
unit uFireDBHelperPool;


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
//  Windows,
  SysUtils,
  Classes,
//  Forms,
//  IniFiles,
//  DB,ADODB,
//  SyncObjs,


//  {$IFNDEF NOT_USE_kbmMWFireDacConnectionPool}
//  kbmMWCustomConnectionPool,
//  kbmMWCustomDataset,
//  kbmMWFireDac,
//  {$ENDIF}




//  uni,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,



  {$IFDEF MSWINDOWS}
  ActiveX,
  {$ENDIF}

  uBaseLog,
  uDatabaseConfig,
  uFireDBHelper,
  uObjectPool;


  //不使用kbmMWFireDacConnectionPool
//  {$DEFINE NOT_USE_kbmMWFireDacConnectionPool}


type
  TFireDBHelperPoolObject = class(TPoolObject)
  protected
    function CreateCustomObject: TObject; override;
  public
    FDBHelper:TFireDBHelper;
    //FMX,APP,一般不需要KBMMW的线程池控件
    FFireConnection:TFDConnection;
    {$IFDEF NOT_USE_kbmMWFireDacConnectionPool}
    {$ENDIF}
    destructor Destroy; override;
  end;



  TFireDBHelperPool=class(TObjectPool)
  protected
    function GetPoolItemClass: TPoolObjectClass; override;
  public
    FIsUseFireDacConnectionPool:Boolean;
    //FMX,APP,一般不需要KBMMW的线程池控件
    FDBConfig:TDatabaseConfig;
//    {$IFDEF NOT_USE_kbmMWFireDacConnectionPool}
//    {$ELSE}
//      //VCL,一般用于服务端,需要KBMMW的线程池组件
//      FFireDacConnectionPool:TkbmMWFireDacConnectionPool;
//    {$ENDIF}

  end;




function GetGlobalSQLDBHelperPool
//  (AFireDacConnectionPool:TkbmMWFireDacConnectionPool)
  :TFireDBHelperPool;
procedure FreeGlobalFireDBHelperPool;



implementation



var
  GlobalFireDBHelperPool: TFireDBHelperPool;

function GetGlobalSQLDBHelperPool
//  (AFireDacConnectionPool:TkbmMWFireDacConnectionPool)
  :TFireDBHelperPool;
begin
  if GlobalFireDBHelperPool=nil then
  begin
    GlobalFireDBHelperPool:=TFireDBHelperPool.Create(nil);
//    GlobalFireDBHelperPool.FFireDacConnectionPool:=AFireDacConnectionPool;
  end;
  Result:=GlobalFireDBHelperPool;
end;

procedure FreeGlobalFireDBHelperPool;
begin
  FreeAndNil(GlobalFireDBHelperPool);
end;









{ TFireDBHelperPool }

function TFireDBHelperPool.GetPoolItemClass: TPoolObjectClass;
begin
  Result:=TFireDBHelperPoolObject;
end;

{ TFireDBHelperPoolObject }

function TFireDBHelperPoolObject.CreateCustomObject: TObject;
var
//  AOptions:TStringList;
  AProviderName:String;
  AFireDBHelperPool:TFireDBHelperPool;

begin
  Result:=nil;

  AFireDBHelperPool:=TFireDBHelperPool(Self.Collection.Owner);


//  {$IFDEF FMX}
  if SameText(AFireDBHelperPool.FDBConfig.FDBType,'MSSQL') or SameText(AFireDBHelperPool.FDBConfig.FDBType,'MSSQL2000') or SameText(AFireDBHelperPool.FDBConfig.FDBType,'SQLSERVER') or SameText(AFireDBHelperPool.FDBConfig.FDBType,'SQLSERVER2000') then
  begin
    {$IFDEF MSWINDOWS}
    CoInitialize(nil);
    {$ENDIF}
  end;
//  {$ENDIF FMX}
  try

//    try
//      if not AFireDBHelperPool.FIsUseFireDacConnectionPool {$IFDEF NOT_USE_kbmMWFireDacConnectionPool}or True{$ENDIF} then
//      begin



              //使用自己的线程池,不使用Kbmmw的

              //FMX,APP,一般不需要KBMMW的线程池控件
              //FMX下,用Connection
              FFireConnection:=TFDConnection.Create(nil);
              FDBHelper:=TFireDBHelper.Create;//(AFireDBHelperPool.FFireDacConnectionPool);
              FDBHelper.SetConnection(FFireConnection);

        //        AUniConnection.Server:=ADataBaseConfig.FDBHostName;
        //        AUniConnection.Port:=StrToInt(ADataBaseConfig.FDBHostPort);
        //        AUniConnection.Username:=ADataBaseConfig.FDBUserName;
        //        AUniConnection.Password:=ADataBaseConfig.FDBPassword;
        //        AUniConnection.Database:=ADataBaseConfig.FDBDataBaseName;

        //      //数据库服务器
        //      FFireConnection.Server:=AFireDBHelperPool.FDBConfig.FDBHostName;
        //      //数据库端口
        //      FFireConnection.Port:=StrToInt(AFireDBHelperPool.FDBConfig.FDBHostPort);
        //      //数据库用户名
        //      FFireConnection.Username:=AFireDBHelperPool.FDBConfig.FDBUserName;
        //      //数据库密码
        //      FFireConnection.Password:=AFireDBHelperPool.FDBConfig.FDBPassword;
        //
        //      //数据库
        //      FFireConnection.Database:=AFireDBHelperPool.FDBConfig.FDBDataBaseName;






    //          AProviderName:=AFireDBHelperPool.FDBConfig.FDBType;
    //          if SameText(AFireDBHelperPool.FDBConfig.FDBType,'MSSQL') then
    //          begin
    //            //微软的SQL SERVER
    //            AProviderName:='SQL Server';
    //          end;
    //
    //          FFireConnection.ConnectString:='Provider Name='+AProviderName+';'//MySQL
    //                                        +'User ID='+AFireDBHelperPool.FDBConfig.FDBUserName+';'//root
    //                                        +'Password='+AFireDBHelperPool.FDBConfig.FDBPassword+';'//138575wangneng
    //                                        +'Data Source='+AFireDBHelperPool.FDBConfig.FDBHostName+';'//www.orangeui.cn
    //                                        +'Database='+AFireDBHelperPool.FDBConfig.FDBDataBaseName+';'//alipay
    //                                        +'Port='+AFireDBHelperPool.FDBConfig.FDBHostPort+';'//3306
    //                                        +'Login Prompt=False;';
    //
    //          if SameText(AFireDBHelperPool.FDBConfig.FDBType,'MYSQL') then
    //          begin
    //            FFireConnection.ConnectString:=FFireConnection.ConnectString
    //                                        +';'
    //                                        +'Use Unicode=True;'
    //                                        +'Character Set='+AFireDBHelperPool.FDBConfig.FDBCharset+';'//utf8mb4
    //          end;
    //
    //          FFireConnection.Connected:=True;

                FDBHelper.Connect(AFireDBHelperPool.FDBConfig);





        //      AOptions:=TStringList.Create;
        //      AOptions.StrictDelimiter:=True;
        //      AOptions.Delimiter:=';';
        //      AOptions.DelimitedText:=FFireConnection.ConnectString;
        //      AOptions.Values['Character Set']:=AFireDBHelperPool.FDBConfig.FDBCharset;
        //      FFireConnection.ConnectString:=AOptions.DelimitedText;
        //      FreeAndNil(AOptions);
//          {$ELSE}
//      end
//      else
//      begin
//
//            {$IFDEF NOT_USE_kbmMWFireDacConnectionPool}
//            {$ELSE}
//            //VCL,一般用于服务端,需要KBMMW的线程池组件
//            //VCL下,用POOL
//            FDBHelper:=TFireDBHelper.Create(AFireDBHelperPool.FFireDacConnectionPool);
//            {$ENDIF}
//
////          {$ENDIF}
//      end;
      Result:=FDBHelper;


//    except
//      on E:Exception do
//      begin
//        uBaseLog.HandleException(E,'TFireDBHelperPoolObject.CreateCustomObject');
//      end;
//    end;
  finally
//    {$IFDEF FMX}
    if SameText(AFireDBHelperPool.FDBConfig.FDBType,'MSSQL') or SameText(AFireDBHelperPool.FDBConfig.FDBType,'MSSQL2000') or SameText(AFireDBHelperPool.FDBConfig.FDBType,'SQLSERVER') or SameText(AFireDBHelperPool.FDBConfig.FDBType,'SQLSERVER2000') then
    begin
      {$IFDEF MSWINDOWS}
      CoUninitialize();
      {$ENDIF}
    end;
    {$IFDEF NOT_USE_kbmMWFireDacConnectionPool}
    {$ENDIF}
//    {$ENDIF FMX}
  end;
end;


destructor TFireDBHelperPoolObject.Destroy;
begin
  FreeAndNil(FFireConnection);
  {$IFDEF NOT_USE_kbmMWFireDacConnectionPool}
  {$ENDIF}

  inherited;
end;

end.



