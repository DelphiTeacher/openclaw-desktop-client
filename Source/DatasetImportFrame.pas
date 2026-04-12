//convert pas to utf8 by ¥
unit DatasetImportFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uManager,
  AIModels,
  uSkinItemJsonHelper,
//  ConfigAIFrame,
  uDataSetToJson,
  XSuperObject,
  uFileCommon,
  uTimerTask,
  uDrawParam,
//  AIModels,
  WaitingFrame,
  HintFrame,
  MessageBoxFrame,
  uFMXSVGSupport,
  ListItemStyleFrame_IconCaption,
  ListItemStyleFrame_RagDataset,
  EasyServiceCommonMaterialDataMoudle,
  USkinFireMonkeyItemDesignerPanel,

  GenAI.Async.Promise,

  GenAI, GenAI.Types,
//  MessageBoxFrame,
  uOpenClientCommon,
//  uDatasetToJson,
  uRestInterfaceCall,

  uUIFunction,


  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, uDrawCanvas, uSkinItems, uSkinFireMonkeyControl, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinFireMonkeyListView, uSkinPanelType, uSkinFireMonkeyPanel, uTimerTaskEvent,
  uSkinLabelType, uSkinFireMonkeyLabel, FMX.ListBox, uSkinFireMonkeyComboBox,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit, uSkinButtonType,
  uSkinFireMonkeyButton, uSkinPageControlType;

type
  TFrameDatasetImport = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    SkinPageControl1: TSkinPageControl;
    procedure btnNewClick(Sender: TObject);
    procedure tteCreateDatasetExecute(ATimerTask: TTimerTask);
    procedure tteLoadExecute(ATimerTask: TTimerTask);
    procedure btnReturnClick(Sender: TObject);
  private
    FPostJson:ISuperObject;
    procedure OnModalResultFromDatasetCreate(AMessageBoxFrame:TObject);
    { Private declarations }
  public
    FDatasetJson:ISuperObject;
    constructor Create(AOwner:TComponent);override;
    procedure Load(ADatasetJson:ISuperObject);
    { Public declarations }
  end;


var
  GlobalDatasetImportFrame:TFrameDatasetImport;

implementation

{$R *.fmx}

procedure TFrameDatasetImport.btnNewClick(Sender: TObject);
//var
//  I:Integer;
begin
  //跳转到文件导入页面


//  Self.cmbVectorModel.Items.Clear;
//  //把系统启用的向量模型加载到下拉框中
//  for I := 0 to GlobalManager.MyAIModelsArray.Length-1 do
//  begin
//    if GlobalManager.MyAIModelsArray.O[I].S['type']=ModelTypeEmbedding then
//    begin
//      Self.cmbVectorModel.Items.Add(GlobalManager.MyAIModelsArray.O[I].S['model']);
//    end;
//  end;
//
//  ShowMessageBoxFrame(Self, '创建知识库', '', TMsgDlgType.mtInformation, ['取消','确定'], OnModalResultFromDatasetCreate,Self.pnlDatasetCreate);
end;

procedure TFrameDatasetImport.btnReturnClick(Sender: TObject);
begin
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);

end;

constructor TFrameDatasetImport.Create(AOwner: TComponent);
begin
  inherited;
//  pnlDatasetCreate.Visible:=False;
end;

procedure TFrameDatasetImport.Load(ADatasetJson:ISuperObject);
begin
  FDatasetJson:=ADatasetJson;
//  Self.tteLoad.Run();
end;

procedure TFrameDatasetImport.OnModalResultFromDatasetCreate(
  AMessageBoxFrame: TObject);
begin
  if TFrameMessageBox(AMessageBoxFrame).ModalResult = '确定' then
  begin

  end;

end;

procedure TFrameDatasetImport.tteCreateDatasetExecute(ATimerTask: TTimerTask);
begin
  //调用知识库创建的接口
  ATimerTask.TaskTag:=TASK_FAIL;

  //获取首页统计
  TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI(
        'dataset/create',
        nil,
        InterfaceUrl+'ragcenter/',
        [],
        [],
        GlobalRestAPISignType,
        GlobalRestAPIAppSecret,
        True,nil,FPostJson.AsJSON//,
//        ['key',GlobalManager.User.key]
        );

  TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;

end;

procedure TFrameDatasetImport.tteLoadExecute(ATimerTask: TTimerTask);
var
  ARequestJson:ISuperObject;
begin
  //从接口加载知识库列表
  ATimerTask.TaskTag:=TASK_FAIL;

  ARequestJson:=SO();

  //获取首页统计
  TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI(
        'dataset/list',
        nil,
        InterfaceUrl+'ragcenter/',
        [],
        [],
        GlobalRestAPISignType,
        GlobalRestAPIAppSecret,
        True,nil,ARequestJson.AsJson
//        ['key',GlobalManager.User.key]
        );

  TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;

end;

end.
