unit AIModels;

interface

uses
  Classes,
  SysUtils,
  uFileCommon,
  uFuncCommon,
  XSuperObject,
  uBaseLog,
  uGlobal,
  uTableCommonRestCenter;

const
  ModelTypeLLM = 'llm';
  ModelTypeEmbedding = 'embedding';
  ModelTypeTTS = 'tts';
  ModelTypeSTT = 'stt';
  ModelTypeRerank = 'rerank';

  //模型厂商列表
  ModelProviderIdType: array[0..28] of string = ('OpenAI'
                                                ,'Claude'
                                                ,'Gemini'
                                                ,'Meta'
                                                ,'MistralAI'
                                                ,'Groq'
                                                ,'Grok'
                                                ,'Jina'
                                                ,'AliCloud'
                                                ,'Qwen'
                                                ,'Doubao'
                                                ,'DeepSeek'
                                                ,'ChatGLM'
                                                ,'Ernie'
                                                ,'Moonshot'
                                                ,'MiniMax'
                                                ,'SparkDesk'
                                                ,'Hunyuan'
                                                ,'Baichuan'
                                                ,'StepFun'
                                                ,'Yi'
                                                ,'Siliconflow'
                                                ,'PPIO'
                                                ,'Ollama'
                                                ,'BAAI'
                                                ,'FishAudio'
                                                ,'Intern'
                                                ,'Moka'
                                                ,'Other');



//获取所有的默认模型列表
function GetDefaultModelList():ISuperArray;
// 从数据库载载系统模型
function LoadSystemModels(var ADesc:String):Boolean;

// 保存所有默认模型到数据库
function SaveSystemModels(var ADesc:String):Boolean;


implementation



//获取所有的默认模型列表
function GetDefaultModelList():ISuperArray;
var
  I: Integer;
  J:Integer;
  AProviderFilePath:String;
  AProviderJson: ISuperObject;
begin
  Result:=TSuperArray.Create;

  for I := 0 to Length(ModelProviderIdType) - 1 do
  begin
    AProviderFilePath:=GetApplicationPath+'provider'+PathDelim+ModelProviderIdType[I]+'.json';
    if not FileExists(AProviderFilePath) then continue;
    AProviderJson:=SO(GetStringFromFile(AProviderFilePath,TEncoding.UTF8));

    for J:=0 to AProviderJson.A['list'].Length-1 do
    begin
      AProviderJson.A['list'].O[J].S['provider']:=ModelProviderIdType[I];
      AProviderJson.A['list'].O[J].B['isCustom']:=False;
      Result.O[Result.Length]:=AProviderJson.A['list'].O[J];
    end;
  end;
end;

// 保存所有默认模型到数据库
function SaveSystemModels(var ADesc:String):Boolean;
var
  AModelList:ISuperArray;
var
  I:Integer;
  ACode:Integer;
//  ADesc:String;
  ADataJson:ISuperObject;

  ARecordJson:ISuperObject;
  AIntfItem:TCommonRestIntfItem;
begin
  Result:=False;

  AModelList:=GetDefaultModelList;

  AIntfItem:=GlobalCommonRestIntfList.Find('system_models');
  if AIntfItem=nil then
  begin
    ADesc:='不存在system_models接口';
    Exit;
  end;  
  
  // 模型是保存在JSONB字段的，所以要看看如何更新
  for I:=0 to AModelList.Length-1 do
  begin
    ARecordJson:=SO();
    ARecordJson.S['model']:=AModelList.O[I].S['model'];
    //还需要补充其他字段，是否默认模型，是否启用，是否自定义等
    ARecordJson.S['metadata']:=AModelList.O[I].AsJson();

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

  Result:=True;

end;

function FilterModels(AModelList:ISuperArray;AModelType:String):ISuperArray;
var
  I: Integer;
begin
  Result:=SA();
  for I := 0 to AModelList.Length-1 do
  begin
    if AModelList.O[I].S['type']=AModelType then
    begin
      Result.O[Result.Length]:=AModelList.O[I];
    end;
  end;
end;

function GetDefaultModel(AModelList:ISuperArray;AModelType:String):String;
var
  I: Integer;
begin
  Result:='';
  for I := 0 to AModelList.Length-1 do
  begin
    if (AModelList.O[I].S['type']=AModelType) and (AModelList.O[I].B['isDefault']) then
    begin
      Result:=AModelList.O[I].S['model'];
      Exit;
    end;
  end;
end;

// 从数据库载载系统模型
function LoadSystemModels(var ADesc:String):Boolean;
var
  AIntfItem:TCommonRestIntfItem;
var
  I:Integer;
  ACode:Integer;
//  ADesc:String;
  ADataJson:ISuperObject;
  ADBModels:ISuperArray;
  AModelJson:ISuperObject;
  ASuperArray:ISuperArray;
begin
  Result:=False;

  AIntfItem:=GlobalCommonRestIntfList.Find('system_models');
  if AIntfItem=nil then
  begin
    ADesc:='不存在system_models接口';
    Exit;
  end;

  if not AIntfItem.GetRecordList('',1,MaxInt,'','','',0,0,'',0,ACode,ADesc,ADataJson) then
  begin
    Exit;
  end;
  if ADataJson.A['RecordList'].Length=0 then
  begin
    if not SaveSystemModels(ADesc) then
    begin
      Exit;
    end;
    if not AIntfItem.GetRecordList('',1,MaxInt,'','','',0,0,'',0,ACode,ADesc,ADataJson) then
    begin
      Exit;
    end;
  end;


  ADBModels:=SA();
  for I := 0 to ADataJson.A['RecordList'].Length-1 do
  begin
    AModelJson:=SO(ADataJson.A['RecordList'].O[I].S['metadata']);
    ADBModels.O[ADBModels.Length]:=AModelJson;
  end;
  GlobalVar.systemModelList:=ADBModels;
  GlobalVar.llmModelMap:=FilterModels(ADBModels,ModelTypeLLM);
  GlobalVar.embeddingModelMap:=FilterModels(ADBModels,ModelTypeEmbedding);
  GlobalVar.ttsModelMap:=FilterModels(ADBModels,ModelTypeTTS);
  GlobalVar.sttModelMap:=FilterModels(ADBModels,ModelTypeSTT);
  GlobalVar.reRankModelMap:=FilterModels(ADBModels,ModelTypeRerank);

  //筛选出不同的模型类型
  GlobalVar.systemDefaultModel_llm:=GetDefaultModel(ADBModels,ModelTypeLLM);
  if GlobalVar.systemDefaultModel_llm='' then
  begin
    GlobalVar.systemDefaultModel_llm:=GlobalVar.llmModelMap.O[0].S['model'];
  end;

  GlobalVar.systemDefaultModel_embedding:=GetDefaultModel(ADBModels,ModelTypeEmbedding);
  if GlobalVar.systemDefaultModel_embedding='' then
  begin
    GlobalVar.systemDefaultModel_embedding:=GlobalVar.embeddingModelMap.O[0].S['model'];
  end;

  GlobalVar.systemDefaultModel_rerank:=GetDefaultModel(ADBModels,ModelTypeRerank);
  if GlobalVar.systemDefaultModel_rerank='' then
  begin
    GlobalVar.systemDefaultModel_rerank:=GlobalVar.rerankModelMap.O[0].S['model'];
  end;



  Result:=True;
end;

end.
