//convert pas to utf8 by ¥
unit uDatasetCollectionProcessTask;

interface


uses
  Classes,
  SysUtils,
  uTimerTask,
  uBaseLog,
  uFuncCommon,

  uTableCommonRestCenter,
  DocumentReader,
  TextSplitter,
  UploadFile,
  
  uDatasetToJson,
  XSuperObject;


type
  
  // 知识库数据集的处理任务线程
  TDatasetCollectionProcessTask=class(TBaseServiceThread)
  public
    procedure Execute;override;

  end;



function ProcessDatasetCollectionTask:Boolean;

// 处理数据集
function DoProcessDatasetCollection(ACollectionJson:ISuperObject;var ADesc:String):Boolean;
function DoPreviewDatasetCollection(ACollectionJson:ISuperObject;var ADesc:String;var ADataJson:ISuperObject):Boolean;

// 将文档解析之后的图片保存到数据库中
function SaveDocumentImages(ACollectionJson:ISuperObject;AParseDocumentResult:TParseDocumentResult;var ADesc:String):Boolean;



implementation


// 将文档解析之后的图片保存到数据库中
function SaveDocumentImages(ACollectionJson:ISuperObject;AParseDocumentResult:TParseDocumentResult;var ADesc:String):Boolean;
var
  I:Integer;
  ACode:Integer;
  // ADesc:String;
  ADataJson:ISuperObject;
  AWhereKeyJson:ISuperObject;
  AIntfItem:TCommonRestIntfItem;
  ARecordJson:ISuperObject;
  AImageItem:TParseImageItem;
begin
  Result:=False;

  AIntfItem:=GlobalCommonRestIntfList.Find('images');
  if AIntfItem=nil then
  begin
    // ADesc:='不存在dataset_collections接口';
    uBaseLog.HandleException(nil,'SaveDocumentImages 不存在images接口');
    Exit;
  end;

  // 保存图片
  for I:=0 to AParseDocumentResult.ImageList.Count-1 do
  begin
    AImageItem:=AParseDocumentResult.ImageList[I];

    ARecordJson:=SO();
//    ARecordJson.S['_id']:=AImageItem.ImageId;
    ARecordJson.S['teamId']:=ACollectionJson.S['teamId'];
    ARecordJson.S['filename']:=ExtractFileName(AImageItem.ImagePath);
    ARecordJson.S['filepath']:=AImageItem.ImagePath;
    ARecordJson.S['relatedId']:=ACollectionJson.S['fileId'];

    if not AIntfItem.AddRecord(AIntfItem.DBModule,nil,ACollectionJson.S['teamId'],ARecordJson,nil,ACode,ADesc,ADataJson) then
    begin
      Exit;
    end;

  end;

  Result:=True;

end;




// 处理数据集
function DoProcessDatasetCollection(ACollectionJson:ISuperObject;var ADesc:String):Boolean;
var
  I:Integer;
  ACode:Integer;
  ADataJson:ISuperObject;
  ARecordJson:ISuperObject;
  AParseDocumentResult:TParseDocumentResult;
  AChunks:TStringList;
  AIntfItem:TCommonRestIntfItem;
  AUpdateJson:ISuperObject;
  ATempJson:ISuperObject;
  AFileJson:ISuperObject;
  AFilePath:String;
begin
  Result:=False;
  ADesc:='';


  AIntfItem:=GlobalCommonRestIntfList.Find('dataset_collections');
  if AIntfItem=nil then
  begin
    // ADesc:='不存在dataset_collections接口';
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在dataset_collections接口');
    Exit;
  end;
  // 开始处理数据集，先将该数据集的状态设置为process
  AUpdateJson:=SO();
  AUpdateJson.S['state']:='process';
  AIntfItem.UpdateRecord(AIntfItem.DBModule,nil,'',AUpdateJson,GetWhereConditions(['_id'],[ACollectionJson.S['_id']]),'',ACode,ADesc,ATempJson);



  AParseDocumentResult:=nil;
  //如果是本地文件，那么先解析文件
  if ACollectionJson.S['type'] = 'file' then
  begin
    // 先获取文件内容
    if not GetFilePathByFileId(BUCKET_DATASET,ACollectionJson.S['fileId'],ADesc,AFileJson,AFilePath) then
    begin
      Exit;
    end;
    // 先解析文件
    AParseDocumentResult:=ParseFile(AFilePath);
  end;
  if AParseDocumentResult=nil then
  begin
    ADesc:='文件解析失败';
    Exit;
  end;

  // 将解析后的文本保存到数据库中，避免预览和处理的时候重复解析，造成耗时
  // 保存到buffer_rawtexts表中
  AIntfItem:=GlobalCommonRestIntfList.Find('buffer_rawtexts');
  if AIntfItem=nil then
  begin
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在buffer_rawtexts接口');
    Exit;
  end;
  // 删除原有记录
  AIntfItem.DeleteRecord(AIntfItem.DBModule,nil,ACollectionJson.S['teamId'],ACollectionJson.S['fileId'],'',ACode,ADesc,ADataJson);
  // 添加新的记录
  ARecordJson:=SO();
//  ARecordJson.S['_id']:=CreateGUIDString();
  ARecordJson.S['sourceId']:=ACollectionJson.S['fileId'];
  ARecordJson.S['rawtext']:=AParseDocumentResult.MarkdownContent;
  AIntfItem.AddRecord(AIntfItem.DBModule,nil,'',ARecordJson,nil,ACode,ADesc,ADataJson);




  // 将解析后的文档内容保存到数据库
//  SaveDocumentImages(ACollectionJson,AParseDocumentResult,ADesc);


  // 将文档内容进行分片并存储
  AChunks:=SplitDocument(ACollectionJson,AParseDocumentResult);

  // 对分片进行存储
  AIntfItem:=GlobalCommonRestIntfList.Find('dataset_datas');
  if AIntfItem=nil then
  begin
    // ADesc:='不存在dataset_collections接口';
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在dataset_datas接口');
    Exit;
  end;
  AIntfItem.DeleteRecord(AIntfItem.DBModule,nil,ACollectionJson.S['teamId'],ACollectionJson.S['fileId'],'',ACode,ADesc,ADataJson);
  for I:=0 to AChunks.Count-1 do
  begin
    ARecordJson:=SO();
//    ARecordJson.S['_id']:=CreateGUIDString;
    ARecordJson.S['teamId']:=ACollectionJson.S['teamId'];
    ARecordJson.S['datasetId']:=ACollectionJson.S['datasetId'];
    ARecordJson.S['collectionId']:=ACollectionJson.S['_id'];
    ARecordJson.S['q']:=AChunks[I];
    ARecordJson.I['chunkIndex']:=I;
    AIntfItem.AddRecord(AIntfItem.DBModule,nil,ACollectionJson.S['teamId'],ARecordJson,nil,ACode,ADesc,ADataJson);

  end;


  FreeAndNil(AChunks);




  AIntfItem:=GlobalCommonRestIntfList.Find('dataset_collections');
  if AIntfItem=nil then
  begin
    // ADesc:='不存在dataset_collections接口';
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在dataset_collections接口');
    Exit;
  end;
  // 数据集处理结束
  AUpdateJson:=SO();
  AUpdateJson.S['status']:='succ';
  AIntfItem.UpdateRecord(AIntfItem.DBModule,nil,'',AUpdateJson,GetWhereConditions(['_id'],[ACollectionJson.S['_id']]),'',ACode,ADesc,ATempJson);


  Result:=True;

end;

// 预览数据集
function DoPreviewDatasetCollection(ACollectionJson:ISuperObject;var ADesc:String;var ADataJson:ISuperObject):Boolean;
var
  I:Integer;
  ACode:Integer;
//  ADataJson:ISuperObject;
  ARecordJson:ISuperObject;
  ARecordList:ISuperArray;
  AParseDocumentResult:TParseDocumentResult;
  AChunks:TStringList;
  AIntfItem:TCommonRestIntfItem;
  AUpdateJson:ISuperObject;
  ATempJson:ISuperObject;
  AFileJson:ISuperObject;
  AFilePath:String;
begin
  Result:=False;
  ADesc:='';



  AParseDocumentResult:=nil;
  //如果是本地文件，那么先解析文件
//  if ACollectionJson.S['type'] = 'file' then
//  begin
    // 先获取文件内容
    if not GetFilePathByFileId(BUCKET_DATASET,ACollectionJson.S['sourceId'],ADesc,AFileJson,AFilePath) then
    begin
      Exit;
    end;
    // 先解析文件
    AParseDocumentResult:=ParseFile(AFilePath);
//  end;
  if AParseDocumentResult=nil then
  begin
    ADesc:='文件解析失败';
    Exit;
  end;

  // 将解析后的文本保存到数据库中，避免预览和处理的时候重复解析，造成耗时
  // 保存到buffer_rawtexts表中
  AIntfItem:=GlobalCommonRestIntfList.Find('buffer_rawtexts');
  if AIntfItem=nil then
  begin
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在buffer_rawtexts接口');
    Exit;
  end;
  // 删除原有记录
  AIntfItem.DeleteRecord(AIntfItem.DBModule,nil,ACollectionJson.S['teamId'],ACollectionJson.S['fileId'],'',ACode,ADesc,ADataJson);
  // 添加新的记录
  ARecordJson:=SO();
//  ARecordJson.S['_id']:=CreateGUIDString();
  ARecordJson.S['sourceId']:=ACollectionJson.S['fileId'];
  ARecordJson.S['rawtext']:=AParseDocumentResult.MarkdownContent;




  // 将解析后的文档内容保存到数据库
//  SaveDocumentImages(ACollectionJson,AParseDocumentResult,ADesc);


  // 将文档内容进行分片并存储
  AChunks:=SplitDocument(ACollectionJson,AParseDocumentResult);


  ARecordList:=SA();

  ADataJson:=SO();
  ADataJson.A['chunks']:=ARecordList;
  for I := 0 to AChunks.Count-1 do
  begin
    ARecordList.O[I].S['q']:=AChunks[I];
  end;

  AChunks.Free;


  ADesc:='分块成功';
  Result:=True;

end;



function ProcessDatasetCollectionTask:Boolean;
var
  ACode:Integer;
  ADesc:String;
  ADataJson:ISuperObject;
  ACollectionJson:ISuperObject;
  AUpdateJson:ISuperObject;
  ATempJson:ISuperObject;
  AWhereKeyJson:ISuperObject;
  AIntfItem:TCommonRestIntfItem;
  AWhereKeyJsonArray:ISuperArray;
begin
  Result:=False;

  AIntfItem:=GlobalCommonRestIntfList.Find('dataset_collections');
  if AIntfItem=nil then
  begin
    // ADesc:='不存在dataset_collections接口';
    uBaseLog.HandleException(nil,'TDatasetCollectionProcessTask.Execute 不存在dataset_collections接口');
    Exit;
  end;

  // 从数据库中查询需要重新处理的知识库数据集
  AWhereKeyJsonArray:=GetWhereConditionArray(['state'],['wait']);

  if not AIntfItem.GetRecord('',AWhereKeyJsonArray.AsJSON(),'','',ACode,ADesc,ACollectionJson) then
  begin
    //不存在等久一点
    Exit;
  end;


  // 处理数据集
  if not DoProcessDatasetCollection(ACollectionJson,ADesc) then
  begin
    Exit;
  end;

  Result:=True;

end;


{ TDatasetCollectionProcessTask }

procedure TDatasetCollectionProcessTask.Execute;
begin
  SleepThread(10000);
  while not Terminated do
  begin


    // 处理数据集
    if not ProcessDatasetCollectionTask then
    begin
      //不存在等久一点
      SleepThread(5000);
      continue;
    end;



  end;

end;

end.
