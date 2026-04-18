unit AIModels;

interface

uses
  Classes,
  SysUtils,
  uFileCommon,
  uFuncCommon,
  XSuperObject,
  uBaseLog;

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


//获取所有的默认模型渠道供应商列表
function GetDefaultChannelList():ISuperArray;

//获取所有的默认模型列表
function GetDefaultModelList():ISuperArray;


function FilterModels(AModelList:ISuperArray;AModelType:String):ISuperArray;

function GetDefaultModel(AModelList:ISuperArray;AModelType:String):String;

implementation


function GetDefaultChannelList():ISuperArray;
var
  I: Integer;
  J:Integer;
  AProviderFilePath:String;
  AProviderJson: ISuperObject;
begin
  Result:=SA();

  for I := 0 to Length(ModelProviderIdType) - 1 do
  begin
    AProviderFilePath:=GetApplicationPath+'provider'+PathDelim+ModelProviderIdType[I]+'.json';
    if not FileExists(AProviderFilePath) then continue;
    AProviderJson:=SO(GetStringFromFile(AProviderFilePath,TEncoding.UTF8));

    Result.O[Result.Length]:=AProviderJson;
  end;
  
end;

//获取所有的默认模型列表
function GetDefaultModelList():ISuperArray;
var
  I: Integer;
  J:Integer;
  AProviderFilePath:String;
  AProviderJson: ISuperObject;
begin
  Result:=SA();

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


end.
