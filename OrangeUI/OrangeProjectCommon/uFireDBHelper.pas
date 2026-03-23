
//convert pas to utf8 by ¥
//UniDac数据库操作类,用于连接MSSQL//
unit uFireDBHelper;

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
  IniFiles,
  DB,
//  ADODB,
  SyncObjs,
//  ActiveX,
  uBaseLog,
  uFuncCommon,
  XSuperObject,

  StrUtils,
  uBaseDBHelper,
  uDataBaseConfig,
  uDatasetToJson,


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

  DateUtils,
  Variants//,
//  Messages
  ;



  //不使用kbmMWFireDacConnectionPool
//  {$DEFINE NOT_USE_kbmMWFireDacConnectionPool}


type
  TFireDBHelper=class(TBaseDBHelper)
  protected
    FQuery: TFDQuery;
    //连接池会赋给将连接赋给他
    FConnection: TFDConnection;
  public
    constructor Create;overload;override;
    destructor Destroy;override;
  public
//    {$IFDEF NOT_USE_kbmMWFireDacConnectionPool}
//    {$ELSE}
//    //可以设置
//    FFireDacConnectionPool:TkbmMWFireDacConnectionPool;
//    //要么使用连接池
//    FFireDacConnection:TkbmMWFireDacConnection;
//    constructor Create(AFireDacConnectionPool:TkbmMWFireDacConnectionPool);overload;
//    //为了兼容老代码而已,功能和GetConnectionFromPool一样
//    function GetFireDacConnectionFromPool:TkbmMWFireDacConnection;
//    {$ENDIF}

  public
    procedure Close;override;

    procedure StartTransaction;override;
    procedure CommitTransaction;override;
    procedure RollBackTransaction;override;


    function GetConnectionFromPool:TObject;override;
    procedure UnlockConnectionToPool;override;

    procedure SetConnection(const Value: TFDConnection);


    function Connect(ADataBaseConfig:TDataBaseConfig):Boolean;override;
    function Disconnect:Boolean;override;


    //检测数据库是否OK(MySql8小时断开一次连接)
    function CheckDBOK:Boolean;

    //数据库查询
    function Query:TDataset;override;
    function NewTempQuery:TDataset;override;
    //数据库连接
    property Connection:TFDConnection read FConnection write SetConnection;
    //查询
    function SelfQuery(AQueryString:String;
                        AParamNames:TStringDynArray=[];
                        AParamValues:TVariantDynArray=[];
                        AOperation:TSQLOperation=asoOpen;
                        AParamsCompleted:Boolean=False;
                        ACustomQueryDataSet:TDataSet=nil):Boolean;override;
  end;







implementation





{ TFireDBHelper }

function TFireDBHelper.Connect(ADataBaseConfig: TDataBaseConfig): Boolean;
var
  AConnection:TFDConnection;
begin
    //直连SQLServer时不再需要CoUnInitialize
  if (SameText(ADataBaseConfig.FDBType,'MSSQL') or SameText(ADataBaseConfig.FDBType,'MSSQL2000') or SameText(ADataBaseConfig.FDBType,'SQLSERVER') or SameText(ADataBaseConfig.FDBType,'SQLSERVER2000'))
    and (ADataBaseConfig.FSpecificOptions_Provider<>'prDirect') then
  begin
    {$IFDEF MSWINDOWS}
    CoInitialize(nil);
    {$ENDIF}
  end;
  try
      Result:=False;

      AConnection:=nil;
//      {$IFNDEF NOT_USE_kbmMWFireDacConnectionPool}
//      //用连接池的原始数据库
//      if (FFireDacConnectionPool<>nil) and (FFireDacConnectionPool.Database<>nil) then
//      begin
//        AConnection:=FFireDacConnectionPool.Database;
//      end
//      else if (FConnection<>nil) then
//      begin
//        AConnection:=FConnection;
//      end;
//      {$ELSE}
      if (FConnection<>nil) then
      begin
        AConnection:=FConnection;
      end;
//      {$ENDIF}





      if AConnection<>nil then
      begin
          try
              AConnection.Connected:=False;

              Self.DBType:=ADataBaseConfig.FDBType;

              if SameText(ADataBaseConfig.FDBType,'MSSQL') or SameText(ADataBaseConfig.FDBType,'MSSQL2000') or SameText(ADataBaseConfig.FDBType,'SQLSERVER') or SameText(ADataBaseConfig.FDBType,'SQLSERVER2000') then
              begin
                //微软的SQL SERVER
          //      //用直连模式可以不需要调用CoInitializeEx,但是有些东西会报错
          //      FFireDacConnectionPool.Database.SpecificOptions.Add('SQL Server.Provider=prDirect');
          //
          //      SpecificOptions.Strings = (
          //        'MySQL.UseUnicode=True'
          //        'SQL Server.Provider=prDirect')

    //            AConnection.SpecificOptions.Va

                  //    SpecificOptions.Strings = (
                  //      'MySQL.Charset=utf8mb4'
                  //      'MySQL.UseUnicode=True'
                  //      'SQL Server.Provider=prDirect')

//                  if ADataBaseConfig.FSpecificOptions_Provider='prDirect' then
//                  begin
//                    //在windows的service模式下设置直连会报错
//      //              {$IFDEF IS_WINDOWS_SERVICE}
//      //              AConnection.SpecificOptions.Values['Provider']:='prDirect';
//      //              {$ELSE}
//                    AConnection.SpecificOptions.Values['Provider']:=ADataBaseConfig.FSpecificOptions_Provider;//'prDirect';
//      //              {$ENDIF}
//                    AConnection.SpecificOptions.Values['NativeClientVersion']:=ADataBaseConfig.FSpecificOptions_NativeClientVersion;//'prDirect';
//                  end;
                  //Exception class Exception with message '"Charset" is not a valid option name for SQL Server UniProvider'. Process OpenPlatformServer_D11.exe (22380)
    //              AConnection.SpecificOptions.Values['Charset']:='utf16';
//                  AConnection.SpecificOptions.Values['UseUnicode']:='True';


                AConnection.DriverName:='MSSQL';
                with AConnection.Params do
                begin
                  Clear;
                  Add('Server=' + ADataBaseConfig.FDBHostName);
                  if ADataBaseConfig.FDBHostPort <> '' then
                    Add('Port=' + ADataBaseConfig.FDBHostPort);
                  Add('Database=' + ADataBaseConfig.FDBDataBaseName);
                  Add('User_Name=' + ADataBaseConfig.FDBUserName);
                  Add('Password=' + ADataBaseConfig.FDBPassword);
                  Add('OSAuthent=No');
                  Add('Mars=Yes');
                end;

              end
              else if SameText(ADataBaseConfig.FDBType,'SQLite') then
              begin
                //JournalMode=jmWAL
//                AConnection.SpecificOptions.Values['UseUnicode']:='True';
//                //允许SQLite多连接访问
////                {$IF CompilerVersion>33}
//                AConnection.SpecificOptions.Values['JournalMode']:='jmWAL';
////                {$ENDIF}
//                if not FileExists(ADataBaseConfig.FDBDataBaseName) then
//                begin
//                  AConnection.SpecificOptions.Values['ForceCreateDatabase']:='True';
//                end;
    //            AConnection.SpecificOptions.Values['EnableSharedCache']:='True';

    //            {$IFDEF MSWINDOWS}
    //            {$IFDEF CPUX64}
    //            AConnection.SpecificOptions.Values['Direct']:='True';//查询诊断的时候会卡
    //            {$ENDIF}
    //            {$ENDIF}

                //FireDac file is encrypted or is not a database
                AConnection.DriverName:='SQLite';
                AConnection.Params.Values['Database'] := ADataBaseConfig.FDBDataBaseName;
                AConnection.Params.Values['JournalMode'] := 'WAL';

//                with AConnection.Params do
//                begin
//                  Clear;
//                  Add('Database=' + ADataBaseConfig.FDBDataBaseName);
////                  if not FileExists(ADataBaseConfig.FDBDataBaseName) then
////                    Add('OpenMode=CreateUTF8');
//                  Add('StringFormat=Unicode');
////                  Add('Synchronous=Normal');
////                  Add('LockingMode=Normal');
////                  Add('SharedCache=False');
////                  Add('JournalMode=WAL');
////                  Add('PageSize=4096');
////                  Add('BusyTimeout=10000');
//                end;

              end
              else if (ADataBaseConfig.FDBType='') or SameText(ADataBaseConfig.FDBType,'MYSQL') then
              begin
                //默认是MYSQL
//                AConnection.SpecificOptions.Values['Charset']:=ADataBaseConfig.FDBCharset;//GlobalDataBaseCharset;'utf8mb4';//
//                AConnection.SpecificOptions.Values['UseUnicode']:='True';

                with AConnection.Params do
                begin
                  Clear;
                  AConnection.DriverName:='MySQL';
                  Add('Server=' + ADataBaseConfig.FDBHostName);
                  if ADataBaseConfig.FDBHostPort <> '' then
                    Add('Port=' + ADataBaseConfig.FDBHostPort);
                  Add('Database=' + ADataBaseConfig.FDBDataBaseName);
                  Add('User_Name=' + ADataBaseConfig.FDBUserName);
                  Add('Password=' + ADataBaseConfig.FDBPassword);
                  Add('CharacterSet=' + ADataBaseConfig.FDBCharset);
                  Add('UseUnicode=True');
                end;

              end
              else if SameText(ADataBaseConfig.FDBType,'PostgreSQL') then
              begin

//                ($5418148, $5418148, #$D#$A, nil, 0, ',', '"', '=',
//                [soWriteBOM,soTrailingLineBreak,soUseLocale], (('MySQL.Charset=utf8mb4', nil), ('MySQL.UseUnicode=True', nil), ('', nil), ('', nil)), 2, 4, False, dupIgnore, False, (Uni.TSpecificOptionsHolder.ValuesChanged,$622EE98), (Uni.TFDConnectionSpecificOptions.ValuesChanging,$622EE98), False, [])
                //PostgreSQL

//                AConnection.SpecificOptions.Clear;
////                AConnection.SpecificOptions.Values['Charset']:=ADataBaseConfig.FDBCharset;//GlobalDataBaseCharset;'utf8mb4';//
////                AConnection.SpecificOptions.Values['UseUnicode']:='True';
//                if ADataBaseConfig.FDBSchema<>'' then
//                begin
//                  AConnection.SpecificOptions.values['schema']:=ADataBaseConfig.FDBSchema;
//                end;
                with AConnection.Params do
                begin
                  Clear;
                  AConnection.DriverName:='PG';
                  Add('Server=' + ADataBaseConfig.FDBHostName);
                  if ADataBaseConfig.FDBHostPort <> '' then
                    Add('Port=' + ADataBaseConfig.FDBHostPort);
                  Add('Database=' + ADataBaseConfig.FDBDataBaseName);
                  Add('User_Name=' + ADataBaseConfig.FDBUserName);
                  Add('Password=' + ADataBaseConfig.FDBPassword);
                  if ADataBaseConfig.FDBSchema <> '' then
                    Add('SearchPath=' + ADataBaseConfig.FDBSchema);
                  Add('CharacterSet=utf8');
                  Add('UseUnicode=True');
                end;

              end
              else
              begin

              end;


              uBaseLog.HandleException(nil,'TFireDBHelper.Connect '
                                            +'ProviderName='+AConnection.DriverName+' '
                                            +'Server='+ADataBaseConfig.FDBHostName+' '
                                            +'Port='+ADataBaseConfig.FDBHostPort+' '
                                            +'Username='+ADataBaseConfig.FDBUserName+' '
                                            +'Password='+ADataBaseConfig.FDBPassword+' '
                                            +'Database='+ADataBaseConfig.FDBDataBaseName+' '
                                            );

//              //连接数据库,MYSQL
//              AConnection.Server:=ADataBaseConfig.FDBHostName;
//              AConnection.Port:=StrToIntDef(ADataBaseConfig.FDBHostPort,0);
//              AConnection.Username:=ADataBaseConfig.FDBUserName;
//              AConnection.Password:=ADataBaseConfig.FDBPassword;
//              AConnection.Database:=ADataBaseConfig.FDBDataBaseName;


//              uBaseLog.HandleException(nil,'TFireDBHelper.Connect Set Connected:=True Begin '+AConnection.ConnectString);
              AConnection.Connected:=True;

//              //允许SQLite多连接访问
//              if SameText(ADataBaseConfig.FDBType,'SQLite') then
//              begin
//                AConnection.ExecSQL('PRAGMA journal_mode=WAL');
//              end;

//              AConnection.ExecSQL('INSERT INTO tbluser  (createtime,is_deleted,fid,login_user,password,name,role_fid,roles,appid)  VALUES  (''2024-11-02 20:06:37'',0,''C13294D24F484BE38BAC861D87B5DDC9'',''66'',''66'',''66'',0,'''',1041);SELECT * from tbluser where fid=''C13294D24F484BE38BAC861D87B5DDC9'' ');

              uBaseLog.HandleException(nil,'TFireDBHelper.Connect Set Connected:=True End');




              Result:=True;
          except
            on E:Exception do
            begin
              Self.LastExceptMessage:=E.Message;
//              ShowException('数据库连接错误，请确认正确参数配置并重启服务端');
              uBaseLog.HandleException(nil,'TFireDBHelper.Connect '+E.Message);
            end;
          end;

      end;




  finally
    //直连SQLServer时不再需要CoUnInitialize
    if (SameText(ADataBaseConfig.FDBType,'MSSQL') or SameText(ADataBaseConfig.FDBType,'MSSQL2000') or SameText(ADataBaseConfig.FDBType,'SQLSERVER') or SameText(ADataBaseConfig.FDBType,'SQLSERVER2000'))
      and (ADataBaseConfig.FSpecificOptions_Provider<>'prDirect') then
    begin
      {$IFDEF MSWINDOWS}
      CoUnInitialize();
      {$ENDIF}
    end;
  end;
end;

constructor TFireDBHelper.Create;
begin
  Inherited;
  FQuery:=TFDQuery.Create(nil);

end;

function TFireDBHelper.CheckDBOK: Boolean;
begin
  if not SelfQuery(
                    'SELECT 1',
                    [],
                    [],
                    asoOpen
                    ) then
  begin
    try
        if FConnection<>nil then
        begin
          FConnection.Close;
          FConnection.Open;
        end;
    except
      on E:Exception do
      begin
        uBaseLog.HandleException(E,'TFireDBHelper.CheckDBOK');
//        DoLog(E,'CheckDBOK');
      end;
    end;
  end;
end;

procedure TFireDBHelper.Close;
begin
  Inherited;

  if FQuery<>nil then
  begin
    Self.FQuery.Close;
  end;

end;

procedure TFireDBHelper.CommitTransaction;
begin
  Self.FConnection.Commit;
end;

//{$IFNDEF NOT_USE_kbmMWFireDacConnectionPool}
//constructor TFireDBHelper.Create(AFireDacConnectionPool:TkbmMWFireDacConnectionPool);
//begin
//  Create;
//
//  FFireDacConnectionPool:=AFireDacConnectionPool;
//end;
//{$ENDIF}

destructor TFireDBHelper.Destroy;
begin

  if FQuery<>nil then
  begin
    FQuery.Close;
    FQuery.Connection:=nil;
    FreeAndNil(FQuery);
  end;

  inherited;
end;

function TFireDBHelper.Disconnect: Boolean;
begin
  Result:=False;
  if (FConnection<>nil) then
  begin
    Self.FConnection.Connected:=False;
  end;
  Result:=True;
end;

procedure TFireDBHelper.UnlockConnectionToPool;
begin
//  {$IFNDEF NOT_USE_kbmMWFireDacConnectionPool}
//  if FFireDacConnection<>nil then
//  begin
//    Self.FFireDacConnection.UnlockConnection;
//    FFireDacConnection:=nil;
//    Self.Connection:=nil;
//  end;
//  {$ENDIF}

end;

function TFireDBHelper.GetConnectionFromPool: TObject;
begin
//  {$IFNDEF NOT_USE_kbmMWFireDacConnectionPool}
//  if FFireDacConnectionPool<>nil then
//  begin
//    //有连接池,要从连接池中区域链接
//    FFireDacConnection:=TkbmMWFireDacConnection(FFireDacConnectionPool.GetBestConnection(True, 0, nil, 10000));
//    if FFireDacConnection <> nil then
//    begin
//      Self.Connection:=FFireDacConnection.Database;
//    end;
//    Result:=FFireDacConnection;
//  end
//  else
//  begin
//    Result:=Self.Connection;
//  end;
//  {$ENDIF}
//  //在FMX平台下,没有连接池,不需要获取

end;


//{$IFNDEF NOT_USE_kbmMWFireDacConnectionPool}
//function TFireDBHelper.GetFireDacConnectionFromPool: TkbmMWFireDacConnection;
//begin
//  Result:=TkbmMWFireDacConnection(GetConnectionFromPool);
//end;
//{$ENDIF}

function TFireDBHelper.Query: TDataset;
begin
  Result:=FQuery;
end;

function TFireDBHelper.NewTempQuery: TDataset;
begin
  Result:=TFDQuery.Create(nil);
  TFDQuery(Result).Connection:=FConnection;
end;

procedure TFireDBHelper.RollBackTransaction;
begin
  Self.FConnection.Rollback;
end;

function TFireDBHelper.SelfQuery(AQueryString: String;
                                AParamNames: TStringDynArray;
                                AParamValues: TVariantDynArray;
                                AOperation: TSQLOperation;
                                AParamsCompleted:Boolean;
                                ACustomQueryDataSet:TDataSet): Boolean;
var
  I: Integer;
  AQuery:TFDQuery;

  AIndex:Integer;
  AValueStr:String;
  ATempQuerySQL:String;
//  StartTime,EndTime:TDateTime;
//  sParams : String;
begin
  Result:=False;



  if Length(AParamNames)<>Length(AParamValues) then
  begin
    FLastExceptMessage:='参数与值的个数不匹配 '+AQueryString;
    uBaseLog.HandleError(nil,'TnbUniDBHelper.SelfQuery '+FLastExceptMessage+' '+AQueryString);
    Exit;
  end;
  


//  sParams := '';
//  StartTime:=Now;
  if ACustomQueryDataSet=nil then
  begin
    //自己的FQuery
    AQuery:=TFDQuery(FQuery);
  end
  else
  begin
    //创建临时的Query
    AQuery:=TFDQuery(ACustomQueryDataSet);
  end;


  if SameText(Self.DBType,'SQLite') then  Self.Lock;

  if SameText(Self.DBType,'MSSQL') or SameText(Self.DBType,'MSSQL2000') then
  begin
    {$IFDEF MSWINDOWS}
    CoInitialize(nil);
    {$ENDIF}
    if (Pos('IFNULL',AQueryString)>0)
      or (Pos('ifnull',AQueryString)>0)
      or (Pos('last_insert_id()',AQueryString)>0) then
    begin
      AQueryString:=ReplaceStr(AQueryString,'IFNULL','ISNULL');
      AQueryString:=ReplaceStr(AQueryString,'ifnull','ifnull');
      AQueryString:=ReplaceStr(AQueryString,'last_insert_id()','@@identity');
    end;

  end;
  if SameText(Self.DBType,'PostgreSQL') then
  begin
    if (Pos('IFNULL',AQueryString)>0)
      or (Pos('ifnull',AQueryString)>0)
      or (Pos('last_insert_id()',AQueryString)>0) then
    begin
      AQueryString:=ReplaceStr(AQueryString,'IFNULL','COALESCE');
      AQueryString:=ReplaceStr(AQueryString,'ifnull','COALESCE');
      AQueryString:=ReplaceStr(AQueryString,'last_insert_id()','@@identity');
    end;

  end;

  try

        try

            if (FConnection<>nil) and Not Self.FConnection.Connected then
            begin
              Self.FConnection.Connected:=True;
            end;
            if (FConnection<>nil) and Self.FConnection.Connected then
            begin
//                HandleException(nil,'TFireDBHelper.SelfQuery '+AQueryString);
                ATempQuerySQL:=AQueryString;

                AQuery.Close;
                AQuery.SQL.Clear;
                AQuery.Connection:=Self.FConnection;
                AQuery.SQL.Text:=TransSelectSQL(AQueryString,DBType);
                //AQuery.Prepare;
                if Not AParamsCompleted then
                begin
                  for I:=Length(AParamNames)-1 downto 0 do
                  begin
                    if AParamNames[I]<>'' then
                    begin
                        AQuery.Params.ParamByName(AParamNames[I]).Value:=AParamValues[I];


                        //f,保存到日志文件中去
                        try
                            AIndex:=Pos(':'+AParamNames[I],ATempQuerySQL);
                            AValueStr:=VarToStr(AParamValues[I]);
                            case VarType(AParamValues[I]) of
                                varString, varUString:
                                begin
                                  AValueStr:=QuotedStr(AValueStr);
                                end
                                else
                                begin

                                end;
                            end;
                    
                            if AIndex>0 then
                            begin
                              ATempQuerySQL:=Copy(ATempQuerySQL,1,AIndex-1)
                                              +AValueStr
                                              +Copy(ATempQuerySQL,AIndex+Length(AParamNames[I])+1{:的长度},MaxInt);
                            end;
                        except
                           //避免出错
                        end;


                    end;
                  end;
                end;


                if Length(AParamNames)>0 then
                begin
                    HandleException(nil,'TFireDBHelper.SelfQuery '+ATempQuerySQL);

//                    if (Pos('INSERT',UpperCase(ATempQuerySQL))>0)
//                      or (Pos('UPDATE',UpperCase(ATempQuerySQL))>0)
//                      or (Pos('DELETE',UpperCase(ATempQuerySQL))>0) then
//                    begin
//                      GetGlobalDBLog.HandleException(nil,'TFireDBHelper.SelfQuery '+ATempQuerySQL);
//                    end;
                end
                else
                begin
                    HandleException(nil,'TFireDBHelper.SelfQuery '+AQueryString);
                end;


                case AOperation of
                  asoOpen: AQuery.Open;
                  asoExec:
                  begin
                      //AQuery.Prepare;
                      AQuery.ExecSql;
                  end;
                end;
                Result:=True;


            end
            else
            begin
                FLastExceptMessage:='数据库未连接';
                uBaseLog.HandleError(nil,'TFireDBHelper.SelfQuery '+FLastExceptMessage+' '+AQueryString);
            end;
        except
          on E: Exception do
          begin
            Result:=False;
            //'Lost connection to MySQL server during query'#$D#$A'Error on data reading from the connection:'#$D#$A'你的主机中的软件中止了一个已建立的连接。.'#$D#$A'Socket Error Code: 10053($2745)'
            FLastExceptMessage:=E.Message;
            //      DoLog(E,'SelfQuery');
            uBaseLog.HandleException(E,'TFireDBHelper.SelfQuery '+E.Message
                                        //上次使用时间,跟踪MYSQL是否在10分钟之内就断开连接了
                                        +' '+FormatDateTime('YYYY-MM-DD HH:MM:SS:ZZZ',Self.FLastUseTime)
                                        +' '+AQueryString);

            //是否需要要将connection的connected设置为False
            if (Copy(E.Message,1,Length('Lost connection'))='Lost connection') and (FConnection<>nil) then
            begin
              try
                Self.FConnection.Connected:=False;
                Self.FConnection.Connected:=True;
                uBaseLog.HandleException(nil,'TFireDBHelper.SelfQuery 数据库重连成功');
              finally

              end;
            end;


          end;
        end;

  finally
    if SameText(Self.DBType,'SQLite') then  Self.UnLock;
    if SameText(Self.DBType,'MSSQL') or SameText(Self.DBType,'MSSQL2000') then
    begin
      {$IFDEF MSWINDOWS}
      CoUnInitialize();
      {$ENDIF}
    end;
  end;
end;

//procedure TFireDBHelper.ReCreateConnection;
//begin
//
//end;

procedure TFireDBHelper.SetConnection(const Value: TFDConnection);
begin
  if FConnection<>Value then
  begin
    FConnection := Value;

    if FQuery<>nil then
    begin
      FQuery.Connection:=FConnection;
    end;

  end;
end;

procedure TFireDBHelper.StartTransaction;
begin
  Self.FConnection.StartTransaction;
end;

end.



