unit DatasetManageFrame;

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
  uUIFunction,
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

  DatasetDetailFrame,


  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, uDrawCanvas, uSkinItems, uSkinFireMonkeyControl, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinFireMonkeyListView, uSkinPanelType, uSkinFireMonkeyPanel, uTimerTaskEvent,
  uSkinLabelType, uSkinFireMonkeyLabel, FMX.ListBox, uSkinFireMonkeyComboBox,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit, uSkinButtonType,
  uSkinFireMonkeyButton;

type
  TFrameDatasetManage = class(TFrame)
    lvData: TSkinFMXListView;
    pnlFilter: TSkinFMXPanel;
    SkinFMXLabel4: TSkinFMXLabel;
    cmbProviders: TSkinFMXComboBox;
    SkinFMXLabel5: TSkinFMXLabel;
    edtKeyword: TSkinFMXEdit;
    tteLoad: TTimerTaskEvent;
    btnNew: TSkinFMXButton;
    pnlDatasetCreate: TSkinFMXPanel;
    SkinFMXLabel6: TSkinFMXLabel;
    SkinFMXLabel7: TSkinFMXLabel;
    edtDatasetName: TSkinFMXEdit;
    cmbVectorModel: TSkinFMXComboBox;
    tteCreateDataset: TTimerTaskEvent;
    SkinFMXLabel1: TSkinFMXLabel;
    SkinFMXPanel1: TSkinFMXPanel;
    btnAll: TSkinFMXButton;
    btnEnabled: TSkinFMXButton;
    btnCurrent: TSkinFMXButton;
    lblCount: TSkinFMXLabel;
    procedure btnNewClick(Sender: TObject);
    procedure tteCreateDatasetExecute(ATimerTask: TTimerTask);
    procedure tteLoadExecute(ATimerTask: TTimerTask);
    procedure tteLoadExecuteEnd(ATimerTask: TTimerTask);
    procedure tteCreateDatasetExecuteEnd(ATimerTask: TTimerTask);
    procedure lvDataClickItem(AItem: TSkinItem);
  private
    FPostJson:ISuperObject;
    procedure OnModalResultFromDatasetCreate(AMessageBoxFrame:TObject);
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    procedure Load;
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrameDatasetManage.btnNewClick(Sender: TObject);
var
  I:Integer;
begin
  Self.cmbVectorModel.Items.Clear;
  //把系统启用的向量模型加载到下拉框中
  for I := 0 to GlobalManager.MyAIModelsArray.Length-1 do
  begin
    if GlobalManager.MyAIModelsArray.O[I].S['type']=ModelTypeEmbedding then
    begin
      Self.cmbVectorModel.Items.Add(GlobalManager.MyAIModelsArray.O[I].S['model']);
    end;
  end;

  ShowMessageBoxFrame(Self, '', '', TMsgDlgType.mtCustom, ['取消','确定'], OnModalResultFromDatasetCreate,Self.pnlDatasetCreate,'创建知识库');
end;

constructor TFrameDatasetManage.Create(AOwner: TComponent);
begin
  inherited;
  pnlDatasetCreate.Visible:=False;
end;

procedure TFrameDatasetManage.Load;
begin
  Self.tteLoad.Run();
end;

procedure TFrameDatasetManage.lvDataClickItem(AItem: TSkinItem);
begin
  HideFrame;
  ShowFrame(TFrame(GlobalDatasetDetailFrame),TFrameDatasetDetail);
  GlobalDatasetDetailFrame.Load(AItem.Json);

end;

procedure TFrameDatasetManage.OnModalResultFromDatasetCreate(
  AMessageBoxFrame: TObject);
begin
  if TFrameMessageBox(AMessageBoxFrame).ModalResult = '确定' then
  begin


    //{
    //  "_id": {
    //    "$oid": "67c01388db8a03d411f55b31"
    //  },
    //  "parentId": null,
    //  "teamId": {
    //    "$oid": "676bc5488b0b00cd5e72bcf8"
    //  },
    //  "tmbId": {
    //    "$oid": "681b29e901626017a3dc44b8"
    //  },
    //  "type": "dataset",
    //  "status": "active",
    //  "avatar": "core/dataset/commonDatasetColor",
    //  "name": "档案管理",
    //  "vectorModel": "text-embedding-v1",
    //  "agentModel": "qwen3:32b",
    //  "intro": "财务",
    //  "inheritPermission": true,
    //  "updateTime": {
    //    "$date": "2025-02-27T07:26:00.680Z"
    //  },
    //  "__v": 0,
    //  "collectionNames": [],
    //  "collectionNamesStr": "",
    //  "summary": "档案",
    //  "entityReced": true,
    //  "summaryGened": true
    //}


    //调用接口来创建
    FPostJson:=SO();
    FPostJson.S['tmbid']:=GlobalManager.User.fid;
    FPostJson.S['type']:='dataset';
    FPostJson.S['status']:='active';
    FPostJson.S['avatar']:='core/dataset/commonDatasetColor';
    FPostJson.S['name']:=Self.edtDatasetName.Text;
    FPOstJson.S['vectorModel']:=Self.cmbVectorModel.Text;

    Self.tteCreateDataset.Run();
  end;

end;

procedure TFrameDatasetManage.tteCreateDatasetExecute(ATimerTask: TTimerTask);
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

procedure TFrameDatasetManage.tteCreateDatasetExecuteEnd(
  ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin
        //将获取到的知识库加载到界面中
        Self.tteLoad.Run();
      end
      else
      begin
        //获取基础数据失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
      end;

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

procedure TFrameDatasetManage.tteLoadExecute(ATimerTask: TTimerTask);
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

procedure TFrameDatasetManage.tteLoadExecuteEnd(ATimerTask: TTimerTask);
var
  I:Integer;
  ASuperObject:ISuperObject;
  ASkinItem:TSkinItem;
  ARecordJson:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin
        //将获取到的知识库加载到界面中
        Self.lvData.Prop.Items.BeginUpdate;
        try
          Self.lvData.Prop.Items.Clear;

          for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
          begin
            ARecordJson:=ASuperObject.O['Data'].A['RecordList'].O[I];
            //
//            ASkinItem:=TSkinJsonItem.Create(Self.lvData.Prop.Items);
            ASkinItem:=Self.lvData.Prop.Items.Add;
            ASkinItem.Caption:=ARecordJson.S['name'];
            ASkinItem.Icon.FileName:=ARecordJson.S['avatar']+'.svg';
            ASkinItem.Detail:=ARecordJson.S['intro'];
            ASkinItem.Json:=ARecordJson;

          end;

          lblCount.Caption:=IntToStr(ASuperObject.O['Data'].I['SumCount']);


        finally
          lvData.Prop.Items.EndUpdate;
        end;


      end
      else
      begin
        //获取基础数据失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
      end;

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
