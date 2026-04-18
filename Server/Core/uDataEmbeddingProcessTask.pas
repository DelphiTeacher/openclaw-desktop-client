//convert pas to utf8 by ¥
unit uDataEmbeddingProcessTask;

interface

uses
  SysUtils,Classes,uTimerTask,


  uTableCommonRestCenter, 
  uGenTextEmbedding, 
  GenAI.Async.Promise,

  GenAI, GenAI.Types,

  uGlobalVar,
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
  ADataJson:ISuperObject;
  ADataChunkJson:ISuperObject;
  ACollectionJson:ISuperObject;
  ADatasetJson:ISuperObject;
  Value1:TEmbeddings;
  ADatasetDatasIntfItem:TCommonRestIntfItem;
  AIntfItem:TCommonRestIntfItem;
  AWhereKeyJsonArray:ISuperArray;
  AVectorArray:ISuperArray;
  ARecordJson:ISuperObject;
  AEmbedding:TArray<Double>;
  AChunks:ISuperArray;
  AVectorDataId:Integer;
  AVectorModelJson:ISuperObject;
begin
  Result := False;



  // 从数据库的dataset_datas表中获取state为wait的记录，表示未向量化的文档片段，然后调用向量化模型，将文档片段转换为向量
  ADatasetDatasIntfItem:=GlobalCommonRestIntfList.Find('dataset_datas');
  if ADatasetDatasIntfItem=nil then
  begin
    // ADesc:='不存在dataset_collections接口';
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在dataset_datas接口');
    Exit;
  end;

  // 从数据库中查询需要重新处理的知识库数据集
  AWhereKeyJsonArray:=GetWhereConditionArray(['state'],['wait']);

  if not ADatasetDatasIntfItem.GetRecord('',AWhereKeyJsonArray.AsJSON(),'','',ACode,ADesc,ADataChunkJson) then
  begin
    // 不存在，等久一点
    Exit;
  end;

//  // 获取到所在的知识库，知识库中有所使用的向量模型
//  AIntfItem:=GlobalCommonRestIntfList.Find('dataset_collections');
//  if AIntfItem=nil then
//  begin
//    // ADesc:='不存在dataset_collections接口';
//    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在dataset_collections接口');
//    Exit;
//  end;
//  if not AIntfItem.GetRecord('',GetWhereConditions(['_id'],[ADataChunkJson.S['collectionId']]),'','',ACode,ADesc,ACollectionJson) then
//  begin
//    // 不存在，等久一点
//    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在对应的collection');
//    Exit;
//  end;


  // 获取到所在的知识库，知识库中有所使用的向量模型
  AIntfItem:=GlobalCommonRestIntfList.Find('datasets');
  if AIntfItem=nil then
  begin
    // ADesc:='不存在dataset_collections接口';
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在datasets接口');
    Exit;
  end;
  if not AIntfItem.GetRecord('',GetWhereConditions(['_id'],[ADataChunkJson.S['datasetId']]),'','',ACode,ADesc,ADatasetJson) then
  begin
    // 不存在，等久一点
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在对应的dataset');
    Exit;
  end;

  // 找到对应的模型，调用向量化模型
  uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute dataset '+ADatasetJson.S['vectormodel']);


//  Client := TGenAI.Create('sk-5c2de62c553f41bdafa7357c390a0079');
//  Client.BaseURL := 'https://dashscope.aliyuncs.com/compatible-mode/v1';

  AVectorModelJson:=LocateJsonArray(GlobalVar.embeddingModelMap,'name',ADatasetJson.S['vectormodel']);

  //如果为空，则使用oneapi的接口
  if AVectorModelJson.S['requestUrl']='' then
  begin
    AVectorModelJson.S['requestUrl']:='https://dashscope.aliyuncs.com/compatible-mode/v1';
  end;
  if AVectorModelJson.S['requestAuth']='' then
  begin
    AVectorModelJson.S['requestAuth']:='sk-5c2de62c553f41bdafa7357c390a0079';
  end;

  Client := TGenAI.Create(AVectorModelJson.S['requestAuth']);
  Client.BaseURL := AVectorModelJson.S['requestUrl'];//'https://dashscope.aliyuncs.com/compatible-mode/v1';


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
//  AVectorArray:=SA();
  // 插入一个向量
  ARecordJson:=SO();
  ARecordJson.S['team_id']:=ADataChunkJson.S['teamid'];
  ARecordJson.S['dataset_id']:=ADataChunkJson.S['datasetid'];
  ARecordJson.S['collection_id']:=ADataChunkJson.S['collectionid'];
  ARecordJson.S['model']:=ADatasetJson.S['vectormodel'];
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


//  AChunks:=SA();
//  AChunks.O[0]:=ARecordJson;
//  GlobalRagServer.FVectorStore.Add(AChunks);

  AVectorDataId:=GlobalRagServer.FVectorStore.Add(ARecordJson);

  //更新到dataset_datas表中
  ARecordJson:=SO();
  ARecordJson.I['modeldata_id']:=AVectorDataId;
  if AVectorDataId>0 then
  begin
    ARecordJson.S['state']:='succ';
  end
  else
  begin
    ARecordJson.S['state']:='fail';
  end;
  ADatasetDatasIntfItem.UpdateRecord(ADatasetDatasIntfItem.DBModule,
                        nil,
                        '',
                        ARecordJson,
//                        GetWhereKeyJson(['_id'],[ADataChunkJson.S['_id']]),
                        GetWhereKeyJson1('_id',ADataChunkJson.S['_id']),
                        '',
                        ACode,
                        ADesc,
                        ADataJson
                        );



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