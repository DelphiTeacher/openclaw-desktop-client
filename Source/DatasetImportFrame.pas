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
  uSkinFireMonkeyItemDesignerPanel,

  GenAI.Async.Promise,

  GenAI, GenAI.Types,
//  MessageBoxFrame,
  uOpenClientCommon,
//  uDatasetToJson,
  uRestInterfaceCall,

  uUIFunction,
  DatasetImportLocalFileFrame,
  DatasetImportSettingFrame,
  DatasetChunkPreviewFrame,
  DatasetImportConfirmFrame,



  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, uDrawCanvas, uSkinItems, uSkinFireMonkeyControl, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinFireMonkeyListView, uSkinPanelType, uSkinFireMonkeyPanel, uTimerTaskEvent,
  uSkinLabelType, uSkinFireMonkeyLabel, FMX.ListBox, uSkinFireMonkeyComboBox,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit, uSkinButtonType,
  uSkinFireMonkeyButton, uSkinPageControlType, uSkinFireMonkeyPageControl;

type
  TFrameDatasetImport = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    SkinFMXPageControl1: TSkinFMXPageControl;
    tsImportLocalFile: TSkinTabSheet;
    tsImportSetting: TSkinTabSheet;
    tsPreview: TSkinTabSheet;
    tsConfirm: TSkinTabSheet;
    pnlFilter: TSkinFMXPanel;
    SkinFMXLabel4: TSkinFMXLabel;
    cmbProviders: TSkinFMXComboBox;
    SkinFMXLabel5: TSkinFMXLabel;
    edtKeyword: TSkinFMXEdit;
    SkinFMXLabel2: TSkinFMXLabel;
    SkinFMXPanel4: TSkinFMXPanel;
    btnAll: TSkinFMXButton;
    btnEnabled: TSkinFMXButton;
    btnCurrent: TSkinFMXButton;
    lblCount: TSkinFMXLabel;
    SkinFMXButton1: TSkinFMXButton;
    procedure btnNewClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure SkinFMXPageControl1Change(Sender: TObject);
    procedure SkinFMXButton1Click(Sender: TObject);
  private
    FDatasetJson:ISuperObject;
    FCollectionJson:ISuperObject;
    procedure OnModalResultFromDatasetCreate(AMessageBoxFrame:TObject);
    { Private declarations }
  public
    FDatasetImportLocalFileFrame:TFrameDatasetImportLocalFile;
    FDatasetImportSettingFrame:TFrameDatasetImportSetting;
    FDatasetChunkPreviewFrame:TFrameDatasetChunkPreview;
    FDatasetImportConfirmFrame:TFrameDatasetImportConfirm;
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
  FCollectionJson:=SO();
  Self.SkinFMXPageControl1.Prop.ActivePage:=tsImportLocalFile;
  SkinFMXPageControl1Change(nil);
end;

procedure TFrameDatasetImport.OnModalResultFromDatasetCreate(
  AMessageBoxFrame: TObject);
begin


end;

procedure TFrameDatasetImport.SkinFMXButton1Click(Sender: TObject);
begin
  if Self.SkinFMXPageControl1.Prop.ActivePage=tsImportSetting then
  begin
    Self.FDatasetImportSettingFrame.Save();
  end;
  Self.SkinFMXPageControl1.Prop.ActivePageIndex:=Self.SkinFMXPageControl1.Prop.ActivePageIndex+1;
end;

procedure TFrameDatasetImport.SkinFMXPageControl1Change(Sender: TObject);
begin
  if Self.SkinFMXPageControl1.Prop.ActivePage=tsImportLocalFile then
  begin
    if FDatasetImportLocalFileFrame=nil then
    begin
      FDatasetImportLocalFileFrame:=TFrameDatasetImportLocalFile.Create(Self);
      FDatasetImportLocalFileFrame.Parent:=Self.SkinFMXPageControl1.Prop.ActivePage;
      FDatasetImportLocalFileFrame.Align:=TAlignLayout.Client;
      FDatasetImportLocalFileFrame.Load(FDatasetJson);
    end;

  end;
  if Self.SkinFMXPageControl1.Prop.ActivePage=tsImportSetting then
  begin
    if FDatasetImportSettingFrame=nil then
    begin
      FDatasetImportSettingFrame:=TFrameDatasetImportSetting.Create(Self);
      FDatasetImportSettingFrame.Parent:=Self.SkinFMXPageControl1.Prop.ActivePage;
      FDatasetImportSettingFrame.Align:=TAlignLayout.Client;
      FDatasetImportSettingFrame.Load(FCollectionJson);
    end;

  end;
  if Self.SkinFMXPageControl1.Prop.ActivePage=tsPreview then
  begin
    if FDatasetChunkPreviewFrame=nil then
    begin
      FDatasetChunkPreviewFrame:=TFrameDatasetChunkPreview.Create(Self);
      FDatasetChunkPreviewFrame.Parent:=Self.SkinFMXPageControl1.Prop.ActivePage;
      FDatasetChunkPreviewFrame.Align:=TAlignLayout.Client;
    end;
    FDatasetChunkPreviewFrame.Load(FDatasetImportLocalFileFrame.FFiles,FDatasetJson,FCollectionJson);

  end;
  if Self.SkinFMXPageControl1.Prop.ActivePage=tsConfirm then
  begin
    if FDatasetImportConfirmFrame=nil then
    begin
      FDatasetImportConfirmFrame:=TFrameDatasetImportConfirm.Create(Self);
      FDatasetImportConfirmFrame.Parent:=Self.SkinFMXPageControl1.Prop.ActivePage;
      FDatasetImportConfirmFrame.Align:=TAlignLayout.Client;
    end;
    FDatasetImportConfirmFrame.Load(FDatasetImportLocalFileFrame.FFiles,FDatasetJson,FCollectionJson);

  end;

end;

end.
