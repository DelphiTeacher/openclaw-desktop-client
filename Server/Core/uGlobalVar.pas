//convert pas to utf8 by ¥
unit uGlobalVar;

interface

uses
  Classes,
  XSuperObject,
  AIModels,
  uTableCommonRestCenter,
  ServerDataBaseModule;

type
  TGlobalVar = class(TComponent)
  public
    FDBModule: TDataBaseModule;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    //默认模型
    systemModelList:ISuperArray;
    //
    systemActiveModelList:ISuperArray;
    llmModelMap:ISuperArray;
    embeddingModelMap:ISuperArray;
    ttsModelMap:ISuperArray;
    sttModelMap:ISuperArray;
    reRankModelMap:ISuperArray;
    //默认模型
    systemDefaultModel_llm:String;
    systemDefaultModel_embedding:String;
    systemDefaultModel_tts:String;
    systemDefaultModel_stt:String;
    systemDefaultModel_rerank:String;


    procedure Start;
    procedure Stop;
  end;



var
  GlobalVar: TGlobalVar;


// 从数据库载载系统模型
function LoadSystemModels(var ADesc:String):Boolean;

// 保存所有默认模型到数据库
function SaveSystemModels(var ADesc:String):Boolean;


implementation

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


  ADBModels:=ADataJson.A['RecordList'];
//  for I := 0 to ADataJson.A['RecordList'].Length-1 do
//  begin
//    AModelJson:=SO(ADataJson.A['RecordList'].O[I].S['metadata']);
//    ADBModels.O[ADBModels.Length]:=AModelJson;
//  end;
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


{ TGlobalVar }

constructor TGlobalVar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDBModule := TDataBaseModule.Create();
end;

destructor TGlobalVar.Destroy;
begin
  FDBModule.Free;
  inherited Destroy;
end;

procedure TGlobalVar.Start;
var
  ADesc:String;
begin
  FDBModule.DoPrepareStart(ADesc);
  LoadSystemModels(ADesc);

end;

procedure TGlobalVar.Stop;
begin
  FDBModule.DoPrepareStop();

end;

initialization
  GlobalVar := TGlobalVar.Create(nil);
  GlobalVar.FDBModule.DBConfigFileName:='RagCenterDBConfig.ini';
  GlobalVar.FDBModule.DBConfig.FDBDataBaseName:='rag_center';

finalization
  GlobalVar.Free;

end.
