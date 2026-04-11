program testConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Classes,
  kbmMWGlobal,
  System.SysUtils,
  DocumentReader,
  NativePDFDocumentReader,
  TokenTextSplitter,
  RagServer,
  uTestUnit in 'uTestUnit.pas',
  VectorStore in 'VectorStore.pas',
  PostgreSqlVectorStore in 'PostgreSqlVectorStore.pas',
  AIModels in 'AIModels.pas',
  uGlobal in 'uGlobal.pas';

var
  ADesc:String;
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }

    WriteLn('Hello World!');

    // 启动Rag服务
    GlobalRagServer:=TRagServer.Create(nil);
    GlobalVar.FDBModule.DBConfigFileName:='RagCenterDBConfig.ini';
    GlobalVar.FDBModule.DBConfig.FDBDataBaseName:='rag_center';
    GlobalRagServer.Start;


    // 创建知识库
//    testAddDatasetToDB(ADesc);
//    WriteLn('testAddDatasetToDB '+ADesc);



    // 上传文档
//     testUploadFile('D:\DelphiRAG\Source\Server\Core\spring_ai_alibaba_quickstart.pdf',ADesc);

    // 添加数据集
//     testCreateCollectionByFile('549897af-f275-4042-a0d5-cef9caecb4c0','34bfb23e-4d11-44df-bd55-07283a6d1697',ADesc);


    // 分片、向量化
//    testProcessDatasetCollectionTask(ADesc);


    //
//   testPostgreSqlVectorStore(ADesc);



    // 模型管理
    // 添加模型
//    SaveSystemModels();
//    LoadSystemModels(ADesc);


    // 处理向量化
//    testDataEmbeddingProcessTask(ADesc);



    // 知识库搜索功能




    ReadLn;



    
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
