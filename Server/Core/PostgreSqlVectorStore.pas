//convert pas to utf8 by ¥
unit PostgreSqlVectorStore;

interface

uses
  System.SysUtils, System.Classes, System.Math, System.Generics.Collections,
  uBaseDBHelper, XSuperObject, uDatasetToJson, uBaseLog,
  VectorStore, uBaseList, uGenTextEmbedding, uUniDBHelper, Data.DB, ServerDataBaseModule;

type
  TPostgreSqlVectorStore = class(TComponent, IVectorStore)
  private
    FTableName: string;
    procedure EnsureTableExists;
    // function VectorToString(const AVector: TArray<Double>): string;
    // function StringToVector(const AStr: string): TArray<Double>;
  public
    FDBModule: TDataBaseModule;
    constructor Create(AOwner:TComponent);
    destructor Destroy; override;

    procedure Start;
    
    procedure Add(AChunks:ISuperArray);
    procedure Delete(AWhereKeyJson:ISuperArray);
    function SimilaritySearch(ASearchRequest: TSearchRequest): TSearchResultList;
  end;



implementation



{ TPostgreSqlVectorStore }

constructor TPostgreSqlVectorStore.Create(AOwner:TComponent);
begin
  inherited;
  FDBModule:=TDataBaseModule.Create;
  FTableName:= 'modelData';

end;

destructor TPostgreSqlVectorStore.Destroy;
begin
  FreeAndNil(FDBModule);
  inherited;
end;

procedure TPostgreSqlVectorStore.Start;
var
  ADesc:String;
begin
  Self.FDBModule.DoPrepareStart(ADesc);
  EnsureTableExists;
end;

procedure TPostgreSqlVectorStore.EnsureTableExists;
var
  ACode:Integer;
  ADesc:String;
  SQL: string;
  ASQLDBHelper: TBaseDBHelper;
begin
  if not FDBModule.GetDBHelperFromPool(ASQLDBHelper,ADesc) then
  begin
    Exit;
  end;
  try

// -- 创建modeldata表
// CREATE TABLE modeldata (
//     id SERIAL PRIMARY KEY,
//     chunk TEXT NOT NULL,
//     model VARCHAR(45),
//     vector VECTOR,
//     team_id VARCHAR(45),
//     dataset_id VARCHAR(45),
//     collection_id VARCHAR(45),
//     createTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
// );


    SQL := Format(
      'CREATE EXTENSION IF NOT EXISTS vector;' +
      'CREATE TABLE IF NOT EXISTS %s (' +
      '  id SERIAL PRIMARY KEY,' +
      '  vector VECTOR NOT NULL,' +
      '  team_id VARCHAR(50) NOT NULL,' +
      '  dataset_id VARCHAR(50) NOT NULL,' +
      '  collection_id VARCHAR(50) NOT NULL,' +
      '  model VARCHAR(50) NOT NULL,' +
      '  createtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP' +
      ')', [FTableName]);

//    try
      ASQLDBHelper.SelfQuery(SQL,[],[],asoExec);
//    except
//      on E: Exception do
//        raise Exception.Create('Failed to create vector table: ' + E.Message);
//    end;

  finally
    FDBModule.FreeDBHelperToPool(ASQLDBHelper);
  end;

end;

// function TPostgreSqlVectorStore.VectorToString(const AVector: TArray<Double>): string;
// begin
//   Result := DoubleArrayToString(AVector);
// end;

// function TPostgreSqlVectorStore.StringToVector(const AStr: string): TArray<Double>;
// var
//   Parts: TArray<string>;
//   i: Integer;
// begin
//   Parts := AStr.Split([',']);
//   SetLength(Result, Length(Parts));
//   for i := 0 to High(Parts) do
//   begin
//     Result[i] := StrToFloatDef(Trim(Parts[i]), 0.0);
//   end;
// end;

procedure TPostgreSqlVectorStore.Add(AChunks:ISuperArray);
var
  i: Integer;
  ChunkId: string;
  Content: ISuperObject;
  Embedding: TArray<Double>;
  EmbeddingStr: string;
  SQL: string;
  ADesc:String;
  ASQLDBHelper: TBaseDBHelper;
begin
  if not FDBModule.GetDBHelperFromPool(ASQLDBHelper,ADesc) then
  begin
    Exit;
  end;
  try


    for i := 0 to AChunks.Length - 1 do
    begin
      Content := AChunks.O[i];
//      ChunkId := Format('chunk_%d_%d', [i, GetTickCount]);

      // TODO: Call embedding service to generate vector
      // For now, create a placeholder vector
//      SetLength(Embedding, 1536);
//      FillChar(Embedding[0], Length(Embedding) * SizeOf(Double), 0);

      EmbeddingStr := DoubleJsonArrayToString(Content.A['vector']);

//      SQL := Format(
//        'INSERT INTO %s (team_id,dataset_id,collection_id,vector) VALUES (%s, %s, %s, %s, %s) ',
//        [FTableName,
//        QuotedStr(Content.S['team_id']),
//        QuotedStr(Content.S['dataset_id']),
//        QuotedStr(Content.S['collection_id']),
//        QuotedStr(EmbeddingStr)]);
//
//      try


//        ASQLDBHelper.SelfQuery(SQL);
        ASQLDBHelper.SelfQuery('INSERT INTO '+FTableName+' (team_id,dataset_id,collection_id,model,vector) VALUES (:team_id,:dataset_id,:collection_id,:model,ARRAY['+EmbeddingStr+']) ',
                              ['team_id','dataset_id','collection_id','model'],
                              [Content.S['team_id'],Content.S['dataset_id'],Content.S['collection_id'],Content.S['model']],
                              asoExec)



//      except
//        on E: Exception do
//          raise Exception.Create('Failed to insert chunk: ' + E.Message);
//      end;
    end;

  finally
    FDBModule.FreeDBHelperToPool(ASQLDBHelper);
  end;
end;

procedure TPostgreSqlVectorStore.Delete(AWhereKeyJson:ISuperArray);
var
  ADesc:String;
  SQL: string;
  ASQLDBHelper: TBaseDBHelper;
  AWhereSQL:String;
begin
  if not FDBModule.GetDBHelperFromPool(ASQLDBHelper,ADesc) then
  begin
    Exit;
  end;
  try


//    SQL := Format('DELETE FROM '+FTableName+' WHERE id = %s', [FTableName, QuotedStr(AChunkId)]);
//
//    try
//      ASQLDBHelper.SelfQuery(SQL);
//    except
//      on E: Exception do
//        raise Exception.Create('Failed to delete chunk: ' + E.Message);
//    end;

    AWhereSQL:=GetWhereConditionSQL(AWhereKeyJson,nil,nil);
    ASQLDBHelper.SelfQuery('DELETE FROM '+FTableName+' WHERE 1=1 '+AWhereSQL,[],[],asoExec)


  finally
    FDBModule.FreeDBHelperToPool(ASQLDBHelper);
  end;
end;

function TPostgreSqlVectorStore.SimilaritySearch(ASearchRequest: TSearchRequest): TSearchResultList;
var
  ADesc:String;
  SQL: string;
  QueryDataSet: TDataSet;
  Embedding: TArray<Double>;
  EmbeddingStr: string;
  Similarity: Double;
  ResultItem: TSearchResult;
  ASQLDBHelper: TBaseDBHelper;
  I: Integer;
begin
  Result:=nil;
  if not FDBModule.GetDBHelperFromPool(ASQLDBHelper,ADesc) then
  begin
    Exit;
  end;
  try

    Result := TSearchResultList.Create;
    


//    // TODO: Call embedding service to generate query vector
//    SetLength(Embedding, 1536);
//    FillChar(Embedding[0], Length(Embedding) * SizeOf(Double), 0);
//
//    EmbeddingStr := DoubleArrayToString(Embedding);
//
//    SQL := Format(
//      'SELECT chunk_id, content, embedding, ' +
//      '1 - (embedding <-> %s::vector) / 2 as similarity ' +
//      'FROM %s ' +
//      'WHERE (1 - (embedding <-> %s::vector) / 2) > %f ' +
//      'ORDER BY similarity DESC ' +
//      'LIMIT %d',
//      [QuotedStr(EmbeddingStr),
//      FTableName,
//      QuotedStr(EmbeddingStr),
//      ASearchRequest.Threshold,
//      ASearchRequest.TopK]);
//
//    try
//      ASQLDBHelper.SelfQuery(SQL);
//      QueryDataSet:=ASQLDBHelper.Query;
//      if QueryDataSet <> nil then
//      begin
//        QueryDataSet.First;
//        while not QueryDataSet.Eof do
//        begin
//          ResultItem := TSearchResult.Create;
//          // TODO: Populate ResultItem with data from QueryDataSet
//          Result.Add(ResultItem);
//          QueryDataSet.Next;
//        end;
//        QueryDataSet.Free;
//      end;
//    except
//      on E: Exception do
//        raise Exception.Create('Failed to search: ' + E.Message);
//    end;


    ASQLDBHelper.SelfQuery('SELECT *,inner_product(vector , ARRAY['+DoubleArrayToString(ASearchRequest.Vector)+']::vector) AS score FROM '+FTableName+' ORDER BY score desc LIMIT 100;');
    while not ASQLDBHelper.Query.Eof do
    begin
      ResultItem := TSearchResult.Create;

      // TODO: Populate ResultItem with data from QueryDataSet
//      for I := 0 to ASQLDBHelper.Query.FieldDefList.Count-1 do
//      begin
//        //vector在undac返回的时候，字段类型是ftmemo

//
//        uBaseLog.HandleException(nil,'TTableCommonRestServerItem.AddRecord '+ASQLDBHelper.Query.FieldDefList[I].Name+' '+IntToStr(Ord(ASQLDBHelper.Query.FieldDefList[I].DataType)));
//      end;


      Result.Add(ResultItem);
      ASQLDBHelper.Query.Next;
    end;

  finally
    FDBModule.FreeDBHelperToPool(ASQLDBHelper);
  end;
end;

end.
