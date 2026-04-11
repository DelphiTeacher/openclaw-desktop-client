unit uGlobal;

interface

uses
  Classes,
  XSuperObject,
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


  end;

var
  GlobalVar: TGlobalVar;

implementation

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

initialization
  GlobalVar := TGlobalVar.Create(nil);
  GlobalVar.FDBModule.DBConfigFileName:='RagCenterDBConfig.ini';
  GlobalVar.FDBModule.DBConfig.FDBDataBaseName:='rag_center';

finalization
  GlobalVar.Free;

end.
