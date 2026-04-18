//convert pas to utf8 by ¥
unit uDatasetSearch;

interface

uses
  SysUtils,
  Classes,
  VectorStore,
  uGlobalVar,

  GenAI.Async.Promise,

  GenAI, GenAI.Types,

  uDatasetToJson,
  uTableCommonRestCenter,
  XSuperObject;


// 知识库搜索
function DatasetSearch(ARequestJson:ISuperObject;var ADesc:String):ISuperArray;


implementation

uses
  RagServer;


// 知识库搜索
function DatasetSearch(ARequestJson:ISuperObject;var ADesc:String):ISuperArray;
var
  ACode:Integer;
//  ADesc:String;
  ADataJson:ISuperObject;
  AStringStream:TStringStream;
  ASuperObject:ISuperObject;

  AIntfItem:TCommonRestIntfItem;
  AWhereKeyJsonArray:ISuperArray;
  I: Integer;
  ADatasetJson:ISuperObject;
  AVectorModelJson:ISuperObject;
  Client: IGenAI;
  Value1:TEmbeddings;
  ASearchRequest:TSearchRequest;
begin
  Result:=nil;

  AIntfItem:=GlobalCommonRestIntfList.Find('datasets');
  if AIntfItem=nil then
  begin
    ADesc:='不存在datasets接口';
    Exit;
  end;


  //返回知识库列表
  AWhereKeyJsonArray:=SA();
  AWhereKeyJsonArray.O[AWhereKeyJsonArray.Length]:=GetFieldCondition('AND','_id','=',ASuperObject.S['datasetId']);


  //根据知识库的向量类型来搜索
  //知识库是用的什么向量类型，就将问题生成什么向量类型，然后使用向量搜索
  //查询记录
  if not AIntfItem.GetRecordList(AIntfItem.DBModule,
                                nil,
                                '',
                                1,
                                MaxInt,
                                AWhereKeyJsonArray.AsJSON,
                                '',
                                '',0,0,'',0,
                                ACode,
                                ADesc,
                                ADataJson,
                                nil
                                ) then
  begin
    Exit;
  end;


  ADatasetJson:=ADataJson.A['RecordList'].O[0];

  //根据知识库的向量模型将问题生成向量
  //datasetId，str，在哪些知识库中进行搜索。支持多个知识库ID
  //text，str，搜索关键词，
  //limit，int，限制上下文字数，
  //similarity，float，限制最低相似度，
  //searchMode，str，有embedding向量相似度搜索，有fulltext全文搜索，还是mixed混合搜索，
  //usingReRank，bool，是否使用重排模型，
  //datasetSearchUsingExtensionQuery，bool，是否使用问题扩展，先使用大模型将问题扩展为多个相关的问题，增加搜索匹配的结果。
  //datasetSearchExtensionModel，str，问题扩展所使用的大模型
  //datasetSearchExtensionBg，str，问题扩展所使用的提示词背景。

//  AVectorModelJson:=GlobalVar.embeddingModelMap.O[ADatasetJson.S['vectormodel']];
  AVectorModelJson:=LocateJsonArray(GlobalVar.embeddingModelMap,'name',ADatasetJson.S['vectormodel']);

  Client := TGenAI.Create(AVectorModelJson.S['requestAuth']);
  Client.BaseURL := AVectorModelJson.S['requestUrl'];//'https://dashscope.aliyuncs.com/compatible-mode/v1';


  Value1 := Client.Embeddings.Create(
    procedure (Params: TEmbeddingsParams)
    begin
//      Params.Input([Self.Edit1.Text]);
//      Params.Model('text-embedding-v3');
      Params.Input([ARequestJson.S['text']]);
      Params.Model(ADatasetJson.S['vectormodel']);
      Params.Dimensions(1024);
      Params.EncodingFormat(TEncodingFormat.float);
    end);

  //创建SearchRequest
  ASearchRequest.TopK:=30;
  ASearchRequest.MaxTokens:=ARequestJson.I['limit'];
  ASearchRequest.Threshold:=ARequestJson.F['similarity'];
  ASearchRequest.Query:=ARequestJson.S['text'];
  ASearchRequest.Vector:=Value1.Data[0].Embedding;
  ASearchRequest.DatasetIds:=[ASuperObject.S['datasetId']];
  Result:=GlobalRagServer.FVectorStore.SimilaritySearch(ASearchRequest)

end;


end.
