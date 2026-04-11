unit RagServer;

interface

uses
  System.SysUtils,
  System.Classes,

  uGlobal,
  uTableCommonRestCenter,
  ServerDataBaseModule,

  VectorStore,
  PostgreSqlVectorStore,

  System.Generics.Collections;


type
  //Rag服务主类
  TRagServer = class(TComponent)

  public
    FVectorStore:TPostgreSqlVectorStore;
    procedure Init;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;


    procedure Start;
    procedure Stop;

  end;

var
  GlobalRagServer: TRagServer;




implementation

  { TRagServer }

constructor TRagServer.Create(AOwner: TComponent);
begin
  inherited;

  FVectorStore:=TPostgreSqlVectorStore.Create(nil);
  FVectorStore.FDBModule.DBConfigFileName:='RagCenterDBConfig.ini';
  FVectorStore.FDBModule.DBConfig.FDBDataBaseName:='rag_center';



  Init;
end;

destructor TRagServer.Destroy;
begin

  FreeAndNil(FVectorStore);
  Inherited;
end;

procedure TRagServer.Init;
var
  AIntfItem:TCommonRestIntfItem;
  ADataFlowAction:TDataFlowAction;
begin


  {$REGION '文件上传表'}
  //用户表的临时变量的增删改查接口
  AIntfItem:=TCommonRestIntfItem.Create(
    //名称
    'dataset_files',
    //名称
    '知识库文件上传表',
    //数据库连接
    GlobalVar.FDBModule,
    //表名
    'dataset_files',
    '',
//    'SELECT * FROM ( '
//      +' SELECT '
//      +' A.*, '
//      +' B.name as introducer_name,B.phone as introducer_phone '
//      +' FROM tbluser A '
//      +' LEFT JOIN tbluser B ON A.appid=B.appid and B.fid=A.bind_introducer_fid '
//      +' ) view_user ',
    '',
    //删除字段
    '',
    //主键字段
    '_id',
    //默认排序
    '',
    True);
  GlobalCommonRestIntfList.Add(AIntfItem);
  {$ENDREGION}



  {$REGION '文件的图片表'}
  //用户表的临时变量的增删改查接口
  AIntfItem:=TCommonRestIntfItem.Create(
    //名称
    'images',
    //名称
    '文件的图片表',
    //数据库连接
    GlobalVar.FDBModule,
    //表名
    'images',
    '',
//    'SELECT * FROM ( '
//      +' SELECT '
//      +' A.*, '
//      +' B.name as introducer_name,B.phone as introducer_phone '
//      +' FROM tbluser A '
//      +' LEFT JOIN tbluser B ON A.appid=B.appid and B.fid=A.bind_introducer_fid '
//      +' ) view_user ',
    '',
    //删除字段
    '',
    //主键字段
    '_id',
    //默认排序
    '',
    True);
  GlobalCommonRestIntfList.Add(AIntfItem);
  {$ENDREGION}

  

  {$REGION '知识库表'}
  AIntfItem:=TCommonRestIntfItem.Create(
    //名称
    'datasets',
    //名称
    '知识库',
    //数据库连接
    GlobalVar.FDBModule,
    //表名
    'datasets',
    '',
//    'SELECT * FROM ( '
//      +' SELECT '
//      +' A.*, '
//      +' B.name as introducer_name,B.phone as introducer_phone '
//      +' FROM tbluser A '
//      +' LEFT JOIN tbluser B ON A.appid=B.appid and B.fid=A.bind_introducer_fid '
//      +' ) view_user ',
    '',
    //删除字段
    '',
    //主键字段
    '_id',
    //默认排序
    'createtime DESC',
    True);
  GlobalCommonRestIntfList.Add(AIntfItem);
  {$ENDREGION}



  {$REGION '知识库数据集表'}
  AIntfItem:=TCommonRestIntfItem.Create(
    //名称
    'dataset_collections',
    //名称
    '知识库数据集表',
    //数据库连接
    GlobalVar.FDBModule,
    //表名
    'dataset_collections',
    '',
//    'SELECT * FROM ( '
//      +' SELECT '
//      +' A.*, '
//      +' B.name as introducer_name,B.phone as introducer_phone '
//      +' FROM tbluser A '
//      +' LEFT JOIN tbluser B ON A.appid=B.appid and B.fid=A.bind_introducer_fid '
//      +' ) view_user ',
    '',
    //删除字段
    '',
    //主键字段
    '_id',
    //默认排序
    'createtime DESC',
    True);
  GlobalCommonRestIntfList.Add(AIntfItem);
  {$ENDREGION}



  {$REGION '数据集解析文本内容表'}
  AIntfItem:=TCommonRestIntfItem.Create(
    //名称
    'buffer_rawtexts',
    //名称
    '知识库数据集表',
    //数据库连接
    GlobalVar.FDBModule,
    //表名
    'buffer_rawtexts',
    '',
//    'SELECT * FROM ( '
//      +' SELECT '
//      +' A.*, '
//      +' B.name as introducer_name,B.phone as introducer_phone '
//      +' FROM tbluser A '
//      +' LEFT JOIN tbluser B ON A.appid=B.appid and B.fid=A.bind_introducer_fid '
//      +' ) view_user ',
    '',
    //删除字段
    '',
    //主键字段
    '_id',
    //默认排序
    'createtime DESC',
    True);
  GlobalCommonRestIntfList.Add(AIntfItem);
  {$ENDREGION}



  {$REGION '知识库数据集分片表'}
  AIntfItem:=TCommonRestIntfItem.Create(
    //名称
    'dataset_datas',
    //名称
    '知识库数据集分片表',
    //数据库连接
    GlobalVar.FDBModule,
    //表名
    'dataset_datas',
    '',
//    'SELECT * FROM ( '
//      +' SELECT '
//      +' A.*, '
//      +' B.name as introducer_name,B.phone as introducer_phone '
//      +' FROM tbluser A '
//      +' LEFT JOIN tbluser B ON A.appid=B.appid and B.fid=A.bind_introducer_fid '
//      +' ) view_user ',
    '',
    //删除字段
    '',
    //主键字段
    '_id',
    //默认排序
    'createtime DESC',
    True);
  GlobalCommonRestIntfList.Add(AIntfItem);
  {$ENDREGION}


  {$REGION '系统模型表'}
  AIntfItem:=TCommonRestIntfItem.Create(
    //名称
    'system_models',
    //名称
    '系统模型表',
    //数据库连接
    GlobalVar.FDBModule,
    //表名
    'system_models',
    '',
//    'SELECT * FROM ( '
//      +' SELECT '
//      +' A.*, '
//      +' B.name as introducer_name,B.phone as introducer_phone '
//      +' FROM tbluser A '
//      +' LEFT JOIN tbluser B ON A.appid=B.appid and B.fid=A.bind_introducer_fid '
//      +' ) view_user ',
    '',
    //删除字段
    '',
    //主键字段
    '_id',
    //默认排序
    '',
    True);
  GlobalCommonRestIntfList.Add(AIntfItem);
  {$ENDREGION}




end;

procedure TRagServer.Start;
var
  ADesc:String;
begin
  GlobalVar.FDBModule.DoPrepareStart(ADesc);

  FVectorStore.Start;

  // 加载系统模型列表
//  LoadSystemModels(ADesc);

end;

procedure TRagServer.Stop;
begin
  GlobalVar.FDBModule.DoPrepareStop;  
end;

// initialization
//   GlobalRagServer:=TRagServer.Create(nil);
//   GlobalRagServer.FDBModule.DBConfigFileName:='RagCenterDBConfig.ini';
//   GlobalRagServer.FDBModule.DBConfig.FDBDataBaseName:='rag_center';

// finalization
//   FreeAndNil(GlobalRagServer);


end.