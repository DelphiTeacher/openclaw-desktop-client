unit uTestUnit;

interface


uses
  Classes,
  SysUtils,
  uFuncCommon,
  XSuperObject,
  DocumentReader,
  NativePDFDocumentReader,
  TokenTextSplitter,
  UploadFile,
  uDatasetCollectionProcessTask,
  uTableCommonRestCenter,
  uDataEmbeddingProcessTask,
  VectorStore,
  PostgreSqlVectorStore,
  uGenTextEmbedding,
  RagServer;




function testSpliter(var ADesc:String):Boolean;
// 测试添加知识库到数据库
function testAddDatasetToDB(var ADesc:String):Boolean;

// 上传文件
function testUploadFile(AFilePath:String;var ADesc:String):Boolean;

// 上传文件并创建一个数据集
function testCreateCollectionByFile(AFileId:String;ADatasetId:String;var ADesc:String):Boolean;


// 测试文档解析分片
function testProcessDatasetCollectionTask(var ADesc:String):Boolean;


// 测试PG的VectorStore
function testPostgreSqlVectorStore(var ADesc:String):Boolean;


// 测试文档向量化
function testDataEmbeddingProcessTask(var ADesc:String):Boolean;


implementation


// 测试PG的VectorStore
function testPostgreSqlVectorStore(var ADesc:String):Boolean;
var
  AVectorStore:TPostgreSqlVectorStore;
  ARecordJson:ISuperObject;
  AVectorArray:ISuperArray;
  I: Integer;
  AChunks:ISuperArray;
  ASearchRequest:TSearchRequest;
  ASearchResultList:TSearchResultList;
begin
  //
  AVectorStore:=TPostgreSqlVectorStore.Create(nil);
  AVectorStore.FDBModule.DBConfigFileName:='RagCenterDBConfig.ini';
  AVectorStore.FDBModule.DBConfig.FDBDataBaseName:='rag_center';
  //连接数据库
  AVectorStore.Start;

  // 插入一个向量
  ARecordJson:=SO();
  ARecordJson.S['team_id']:='test';
  ARecordJson.S['dataset_id']:='test';
  ARecordJson.S['collection_id']:='test';
  ARecordJson.S['model']:='text-embedding-v3';
  AVectorArray:=SA();
  for I := 0 to 1024-1 do
  begin
    AVectorArray.F[I]:=0;
  end;
  ARecordJson.A['vector']:=AVectorArray;


  AChunks:=SA();
  AChunks.O[0]:=ARecordJson;
  AVectorStore.Add(AChunks);


  // 看看返回的向量字段类型，在Unidac中是怎么样的一个数据库字段类型


  // 测试向量搜索
  ASearchRequest.Vector:=DoubleJsonArrayToArray(AVectorArray);
  ASearchResultList:=AVectorStore.SimilaritySearch(ASearchRequest);


  ASearchResultList.Free;

  AVectorStore.Free; 

end;


function testDataEmbeddingProcessTask(var ADesc:String):Boolean;
begin
  DoDataEmbeddingProcess(ADesc);
end;

function testProcessDatasetCollectionTask(var ADesc:String):Boolean;
begin
  ProcessDatasetCollectionTask();
end;


function testUploadFile(AFilePath:String;var ADesc:String):Boolean;
var
  ADataJson:ISuperObject;
  AMemoryStream:TMemoryStream;
begin
  AMemoryStream:=TMemoryStream.Create;
  try
    AMemoryStream.LoadFromFile(AFilePath);
    AMemoryStream.Position:=0;

    UploadFile.ProcessUploadFileStream(ExtractFileName(AFilePath),AMemoryStream,'dataset',ADesc,ADataJson);
  finally
    AMemoryStream.Free;
  end;
end;

function testCreateCollectionByFile(AFileId:String;ADatasetId:String;var ADesc:String):Boolean;
var
  ACode:Integer;
  // ADesc:String;
  ADataJson:ISuperObject;
  AStringStream:TStringStream;
  ARecordJson:ISuperObject;

  AIntfItem:TCommonRestIntfItem;
begin
  ARecordJson:=SO();
//  ARecordJson.S['_id']:=CreateGUIDString();
  ARecordJson.S['teamId']:='1044';
  ARecordJson.S['tmbId']:='admin';
  ARecordJson.S['datasetId']:=ADatasetId;
  ARecordJson.S['type']:='file';
  ARecordJson.S['name']:='spring_ai_alibaba_quickstart.pdf';
  ARecordJson.B['forbid']:=False;
  // 分片设置
  ARecordJson.S['trainingType']:='chunk';
  ARecordJson.S['chunkSettingMode']:='auto';
  ARecordJson.S['chunkSplitMode']:='size';
  ARecordJson.I['chunkSize']:=1024;
  ARecordJson.I['indexSize']:=1024;
  
  ARecordJson.S['fileId']:=AFileId;
  ARecordJson.S['state']:='wait';
  

  AIntfItem:=GlobalCommonRestIntfList.Find('dataset_collections');
  if AIntfItem=nil then
  begin
    ADesc:='不存在dataset_collections接口';
    Exit;
  end;
  //新增
  AIntfItem.AddRecord(AIntfItem.DBModule,
                      nil,
                      '',
                      ARecordJson,
                      nil,
                      ACode,
                      ADesc,
                      ADataJson
                      );



end;


function testAddDatasetToDB(var ADesc:String):Boolean;
var
  ACode:Integer;
  // ADesc:String;
  ADataJson:ISuperObject;
  AStringStream:TStringStream;
  ARecordJson:ISuperObject;

  AIntfItem:TCommonRestIntfItem;
begin
  ARecordJson:=SO();
//  ARecordJson.S['_id']:=CreateGUIDString();
  ARecordJson.S['teamId']:='1044';
  ARecordJson.S['tmbId']:='admin';
  ARecordJson.S['type']:='file';
  ARecordJson.S['status']:='activate';
  ARecordJson.S['vectorModel']:='text-embedding-v3';
  ARecordJson.S['intro']:='test';

  AIntfItem:=GlobalCommonRestIntfList.Find('datasets');
  if AIntfItem=nil then
  begin
    ADesc:='不存在datasets接口';
    Exit;
  end;
  //新增
  AIntfItem.AddRecord(AIntfItem.DBModule,
                      nil,
                      '',
                      ARecordJson,
                      nil,
                      ACode,
                      ADesc,
                      ADataJson
                      );

end;


function testSpliter(var ADesc:String):Boolean;
var
  I:Integer;
  pdfreader:TNativePDFDocumentReader;
  parseResult:TParseDocumentResult;
  spliter:TTokenTextSplitter;
  spliterResult:TStringList;begin
  // 测试PDF文档的解析
  pdfreader:= TNativePDFDocumentReader.Create;
  parseResult:=pdfreader.Read('D:\DelphiRAG\Source\Win32\Debug\spring_ai_alibaba_quickstart.pdf');
  WriteLn(parseResult.MarkdownContent);

  // 文档分片
  spliter:=TTokenTextSplitter.Create();
  spliterResult:=spliter.Split(parseResult.MarkdownContent);
  for i := 0 to spliterResult.Count-1 do
  begin
    WriteLn('------------分片'+IntToStr(i+1)+'--------------');
    WriteLn(spliterResult[i]);
  end;
  spliter.Free;
  spliterResult.Free;



  pdfreader.Free;
  parseResult.Free;

end;


end.
