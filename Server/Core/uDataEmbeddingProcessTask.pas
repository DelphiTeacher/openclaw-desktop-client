unit uDataEmbeddingProcessTask;

interface

uses
  SysUtils,Classes,uTimerTask,


  uTableCommonRestCenter, 
  uGenTextEmbedding, 
  GenAI.Async.Promise,

  GenAI, GenAI.Types,

  uGlobal,
  uBaseLog,
  uDatasetToJson,
  XSuperObject
  ;



type
  TDataEmbeddingProcessTask = class(TBaseServiceThread)
  public
    procedure Execute; override;

  end;


function DoDataEmbeddingProcess(ADesc:String):Boolean;

implementation

uses
  RagServer;


function DoDataEmbeddingProcess(ADesc:String): Boolean;
var
  Client : IGenAI;
var
  I:Integer;
  ACode:Integer;
  ADataChunkJson:ISuperObject;
  ACollectionJson:ISuperObject;
  ADatasetJson:ISuperObject;
  Value1:TEmbeddings;
  AIntfItem:TCommonRestIntfItem;
  AWhereKeyJsonArray:ISuperArray;
  AVectorArray:ISuperArray;
  ARecordJson:ISuperObject;
  AEmbedding:TArray<Double>;
  AChunks:ISuperArray;
begin
  Result := False;



  // 从数据库的dataset_datas表中获取state为wait的记录，表示未向量化的文档片段，然后调用向量化模型，将文档片段转换为向量
  AIntfItem:=GlobalCommonRestIntfList.Find('dataset_datas');
  if AIntfItem=nil then
  begin
    // ADesc:='不存在dataset_collections接口';
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在dataset_datas接口');
    Exit;
  end;

  // 从数据库中查询需要重新处理的知识库数据集
  AWhereKeyJsonArray:=GetWhereConditionArray(['state'],['wait']);

  if not AIntfItem.GetRecord('',AWhereKeyJsonArray.AsJSON(),'','',ACode,ADesc,ADataChunkJson) then
  begin
    // 不存在，等久一点
    Exit;
  end;

  // 获取到所在的知识库，知识库中有所使用的向量模型
  AIntfItem:=GlobalCommonRestIntfList.Find('dataset_collections');
  if AIntfItem=nil then
  begin
    // ADesc:='不存在dataset_collections接口';
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在dataset_collections接口');
    Exit;
  end;
  if not AIntfItem.GetRecord('',GetWhereConditions(['_id'],[ADataChunkJson.S['collectionId']]),'','',ACode,ADesc,ACollectionJson) then
  begin
    // 不存在，等久一点
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在对应的collection');
    Exit;
  end;


  // 获取到所在的知识库，知识库中有所使用的向量模型
  AIntfItem:=GlobalCommonRestIntfList.Find('datasets');
  if AIntfItem=nil then
  begin
    // ADesc:='不存在dataset_collections接口';
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在datasets接口');
    Exit;
  end;
  if not AIntfItem.GetRecord('',GetWhereConditions(['_id'],[ACollectionJson.S['datasetId']]),'','',ACode,ADesc,ADatasetJson) then
  begin
    // 不存在，等久一点
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在对应的dataset');
    Exit;
  end;

  // 找到对应的模型，调用向量化模型
  uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute dataset '+ADatasetJson.S['vectormodel']);


  Client := TGenAI.Create('sk-5c2de62c553f41bdafa7357c390a0079');
  Client.BaseURL := 'https://dashscope.aliyuncs.com/compatible-mode/v1';

  // 向量化模型调用
  Value1 := Client.Embeddings.Create(
    procedure (Params: TEmbeddingsParams)
    begin
      Params.Input([ADataChunkJson.S['q']+ADataChunkJson.S['a']]);
      Params.Model(ADatasetJson.S['vectormodel']);
//      Params.Dimensions(1024);
      Params.EncodingFormat(TEncodingFormat.float);
    end);

  AEmbedding:=Value1.Data[0].Embedding;

  //保存到向量数据库中
  AVectorArray:=SA();
  // 插入一个向量
  ARecordJson:=SO();
  ARecordJson.S['team_id']:='test';
  ARecordJson.S['dataset_id']:='test';
  ARecordJson.S['collection_id']:='test';
  ARecordJson.S['model']:='text-embedding-v3';
//  AVectorArray:=SA();
//  for I := 0 to 1536-1 do
//  begin
//    if I<Length(AEmbedding) then
//    begin 
//      AVectorArray.F[I]:=AEmbedding[I];
//    end
//    else
//    begin
//      AVectorArray.F[I]:=0;
//    end;
//  end;
  AVectorArray:=DoubleArrayToJsonArray(AEmbedding); 
  ARecordJson.A['vector']:=AVectorArray;


  AChunks:=SA();
  AChunks.O[0]:=ARecordJson;
  GlobalRagServer.FVectorStore.Add(AChunks);





  Result := True;
end;

{ TDataEmbeddingProcessTask }

procedure TDataEmbeddingProcessTask.Execute;
var
  ADesc:String;
begin


  // do something here
  Sleep(10000);
  while not Terminated do
  begin

    if not DoDataEmbeddingProcess(ADesc) then
    begin
      SleepThread(5000);

    end;

  end;


end;


end.