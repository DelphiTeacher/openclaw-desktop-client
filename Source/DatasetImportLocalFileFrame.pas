//convert pas to utf8 by ¥
unit DatasetImportLocalFileFrame;

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
  IdMultipartFormData,
  System.Net.Mime,
  ListItemStyleFrame_DatasetImportLocalFile,


  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, uDrawCanvas, uSkinItems, uSkinFireMonkeyControl, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinFireMonkeyListView, uSkinPanelType, uSkinFireMonkeyPanel, uTimerTaskEvent,
  uSkinLabelType, uSkinFireMonkeyLabel, FMX.ListBox, uSkinFireMonkeyComboBox,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit, uSkinButtonType,
  uSkinFireMonkeyButton;

type
  TFrameDatasetImportLocalFile = class(TFrame)
    lvData: TSkinFMXListView;
    pnlFilter: TSkinFMXPanel;
    SkinFMXLabel4: TSkinFMXLabel;
    cmbProviders: TSkinFMXComboBox;
    SkinFMXLabel5: TSkinFMXLabel;
    edtKeyword: TSkinFMXEdit;
    tteUpload: TTimerTaskEvent;
    btnNew: TSkinFMXButton;
    SkinFMXLabel1: TSkinFMXLabel;
    SkinFMXPanel1: TSkinFMXPanel;
    btnAll: TSkinFMXButton;
    btnEnabled: TSkinFMXButton;
    btnCurrent: TSkinFMXButton;
    lblCount: TSkinFMXLabel;
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    pnlHeader: TSkinFMXPanel;
    SkinFMXLabel2: TSkinFMXLabel;
    SkinFMXLabel3: TSkinFMXLabel;
    SkinFMXLabel8: TSkinFMXLabel;
    OpenDialog1: TOpenDialog;
    SkinFMXLabel9: TSkinFMXLabel;
    procedure btnNewClick(Sender: TObject);
    procedure tteUploadExecute(ATimerTask: TTimerTask);
    procedure tteUploadExecuteEnd(ATimerTask: TTimerTask);
    procedure btnReturnClick(Sender: TObject);
    procedure lvDataPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
      AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem;
      AItemDrawRect: TRect);
  private
    FPostJson:ISuperObject;
    procedure OnModalResultFromDatasetCreate(AMessageBoxFrame:TObject);
    { Private declarations }
  public
    FFiles:ISuperArray;
    FDatasetJson:ISuperObject;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Load(ADatasetJson:ISuperObject);
    { Public declarations }
  end;


var
  GlobalDatasetImportLocalFileFrame:TFrameDatasetImportLocalFile;

implementation

{$R *.fmx}

procedure TFrameDatasetImportLocalFile.btnNewClick(Sender: TObject);
var
  I:Integer;
  ARecordJson:ISuperObject;
  ASkinItem:TSkinItem;
begin
  //跳转到文件导入页面
  if Self.OpenDialog1.Execute then
  begin

    FFiles:=SA();


    Self.lvData.Prop.Items.BeginUpdate;
    Self.lvData.Prop.Items.Clear;
    try
      for I := 0 to Self.OpenDialog1.Files.Count-1 do
      begin
        // 添加到列表中
        ASkinItem:=Self.lvData.Prop.Items.Add;
        ASkinItem.Caption:=ExtractFileName(Self.OpenDialog1.Files[I]);
        ASkinItem.Name:=Self.OpenDialog1.Files[I];
        ASkinItem.Detail:=GetFileSizeStr(GetSizeOfFile(Self.OpenDialog1.Files[I]));
        ASkinItem.Tag:=0;
        //根据文件类型来确定图标
//        ASkinItem.Icon.FileName


        ARecordJson:=SO();
        ARecordJson.S['name']:=ExtractFileName(Self.OpenDialog1.Files[I]);
        ARecordJson.S['path']:=Self.OpenDialog1.Files[I];
        ARecordJson.S['size']:=GetFileSizeStr(GetSizeOfFile(Self.OpenDialog1.Files[I]));
        ARecordJson.S['status']:='';
        ARecordJson.I['progress']:=0;

        ASkinItem.Json:=ARecordJson;

        Self.FFiles.O[I]:=ARecordJson;


      end;
    finally
      Self.lvData.Prop.Items.EndUpdate;
    end;


    //开始上传
    Self.tteUpload.Run();

  end;


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

procedure TFrameDatasetImportLocalFile.btnReturnClick(Sender: TObject);
begin
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);

end;

constructor TFrameDatasetImportLocalFile.Create(AOwner: TComponent);
begin
  inherited;
  Self.lvData.Prop.Items.BeginUpdate;
  Self.lvData.Prop.Items.Clear;
  Self.lvData.Prop.Items.EndUpdate;
end;

destructor TFrameDatasetImportLocalFile.Destroy;
begin
  inherited;
end;

procedure TFrameDatasetImportLocalFile.Load(ADatasetJson:ISuperObject);
begin
  FDatasetJson:=ADatasetJson;
//  Self.tteLoad.Run();
end;

procedure TFrameDatasetImportLocalFile.lvDataPrepareDrawItem(Sender: TObject;
  ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
  AItem: TSkinItem; AItemDrawRect: TRect);
var
  AItemStyleFrame:TFrameListItemStyle_DatasetImportLocalFile;
begin
  if AItem.Json<>nil then
  begin
    AItemStyleFrame:=TFrameListItemStyle_DatasetImportLocalFile(AItemDesignerPanel.Parent);
    AItemStyleFrame.SkinFMXProgressBar1.Prop.StaticPosition:=AItem.Json.I['progress'];
  end;

end;

procedure TFrameDatasetImportLocalFile.OnModalResultFromDatasetCreate(
  AMessageBoxFrame: TObject);
begin


end;

procedure TFrameDatasetImportLocalFile.tteUploadExecute(ATimerTask: TTimerTask);
var
  I:Integer;
  ARecordJson:ISuperObject;
  ACode:Integer;
  ADesc:String;
  ADataJson:ISuperObject;
  ARequestStream:TMultipartFormData;
begin
  //从接口加载知识库列表
  ATimerTask.TaskTag:=TASK_FAIL;

  // 一个文件一个文件的上传
  for I := 0 to Self.FFiles.Length-1 do
  begin
    ARecordJson:=Self.FFiles.O[I];

    ARequestStream:=TMultipartFormData.Create;
    try
      ARequestStream.AddFile('file',ARecordJson.S['path']);
      ARequestStream.AddField('metadata','{}');
      ARequestStream.AddField('bucketName','dataset');
      ARequestStream.AddField('data','');



      //获取首页统计
      if not SimpleCallAPI(
            'upload_form',
            nil,
            InterfaceUrl+'filemanage/',
            [],
            [],
            ACode,ADesc,ADataJson,
            GlobalRestAPISignType,
            GlobalRestAPIAppSecret,
            True,ARequestStream.Stream
    //        ['key',GlobalManager.User.key]
            ) then
        begin
          ARecordJson.S['status']:='上传失败';
          continue;
        end;

      ARecordJson.S['status']:='上传成功';
      ARecordJson.I['progress']:=100;
      ARecordJson.O['data']:=ADataJson;



    finally
      ARequestStream.Free;
    end;


    TTimerTask(ATimerTask).TaskDesc:='';
  end;

  TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;

end;

procedure TFrameDatasetImportLocalFile.tteUploadExecuteEnd(ATimerTask: TTimerTask);
//var
//  I:Integer;
//  ASuperObject:ISuperObject;
//  ASkinItem:TSkinItem;
//  ARecordJson:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//        //将获取到的知识库加载到界面中
//        Self.lvData.Prop.Items.BeginUpdate;
//        try
//          Self.lvData.Prop.Items.Clear;
//
//          for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
//          begin
//            ARecordJson:=ASuperObject.O['Data'].A['RecordList'].O[I];
//            //
////            ASkinItem:=TSkinJsonItem.Create(Self.lvData.Prop.Items);
//            ASkinItem:=Self.lvData.Prop.Items.Add;
//            ASkinItem.Caption:=ARecordJson.S['name'];
//            ASkinItem.Icon.FileName:=ARecordJson.S['avatar']+'.svg';
//            ASkinItem.Detail:=ARecordJson.S['intro'];
//            ASkinItem.Json:=ARecordJson;
//
//          end;
//
//          lblCount.Caption:=IntToStr(ASuperObject.O['Data'].I['SumCount']);
//
//
//        finally
//          lvData.Prop.Items.EndUpdate;
//        end;
//
//
//      end
//      else
//      begin
//        //获取基础数据失败
//        ShowMessageBoxFrame(Self,'上传完成','',TMsgDlgType.mtInformation,['确定'],nil);
//      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin

        //网络异常
        ShowMessageBoxFrame(Self,'接口调用失败',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);


    end;
  finally
    HideWaitingFrame;
  end;


end;

end.
