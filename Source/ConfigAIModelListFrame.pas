//convert pas to utf8 by ¥
unit ConfigAIModelListFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uManager,
  uSkinItemJsonHelper,
//  ConfigAIFrame,
  uDataSetToJson,
  XSuperObject,
  uFileCommon,
  uTimerTask,
  uDrawParam,
  AIModels,
  WaitingFrame,
  HintFrame,
  MessageBoxFrame,
  uFMXSVGSupport,
  ListItemStyleFrame_IconCaption,
  ListItemStyleFrame_AIModelConfig,
  EasyServiceCommonMaterialDataMoudle,
  USkinFireMonkeyItemDesignerPanel,

  GenAI.Async.Promise,

  GenAI, GenAI.Types,
  uLocalOpenClawHelper,

  uRestInterfaceCall,
  uOpenClientCommon,


  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, uDrawCanvas, uSkinItems, uSkinFireMonkeyControl, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinFireMonkeyListView, uSkinPanelType, uSkinFireMonkeyPanel, uTimerTaskEvent,
  uSkinLabelType, uSkinFireMonkeyLabel, FMX.ListBox, uSkinFireMonkeyComboBox,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit, uSkinButtonType,
  uSkinFireMonkeyButton;

type
  TFrameConfigAIModelList = class(TFrame)
    lvChannel: TSkinFMXListView;
    tteLoad: TTimerTaskEvent;
    pnlFilter: TSkinFMXPanel;
    pnlHeader: TSkinFMXPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    SkinFMXLabel2: TSkinFMXLabel;
    SkinFMXLabel3: TSkinFMXLabel;
    SkinFMXLabel4: TSkinFMXLabel;
    cmbProviders: TSkinFMXComboBox;
    SkinFMXLabel5: TSkinFMXLabel;
    edtKeyword: TSkinFMXEdit;
    btnCurrent: TSkinFMXButton;
    btnEnabled: TSkinFMXButton;
    btnAll: TSkinFMXButton;
    tteTestModel: TTimerTaskEvent;
    procedure lvChannelClickItem(AItem: TSkinItem);
    procedure tteLoadExecute(ATimerTask: TTimerTask);
    procedure lvChannelNewListItemStyleFrameCacheInit(Sender: TObject; AListItemTypeStyleSetting: TListItemTypeStyleSetting; ANewListItemStyleFrameCache: TListItemStyleFrameCache);
    procedure cmbProvidersChange(Sender: TObject);
    procedure edtKeywordChangeTracking(Sender: TObject);
    procedure edtKeywordChange(Sender: TObject);
    procedure tteTestModelExecute(ATimerTask: TTimerTask);
    procedure lvChannelClickItemDesignerPanelChild(Sender: TObject;
      AItem: TBaseSkinItem; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
      AChild: TFmxObject);
    procedure tteTestModelBegin(ATimerTask: TTimerTask);
    procedure tteTestModelExecuteEnd(ATimerTask: TTimerTask);
    procedure btnCurrentClick(Sender: TObject);
    procedure btnEnabledClick(Sender: TObject);
    procedure btnAllClick(Sender: TObject);
    procedure tteLoadExecuteEnd(ATimerTask: TTimerTask);
  private
    procedure DoFilter;
    procedure DoLoadModels(AModelList:ISuperArray);
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    procedure Load;
    { Public declarations }
  end;



implementation




{$R *.fmx}

{ TFrameInstallAI }

procedure TFrameConfigAIModelList.btnAllClick(Sender: TObject);
begin
  DoFilter;

end;

procedure TFrameConfigAIModelList.btnCurrentClick(Sender: TObject);
begin
  DoFilter;
end;

procedure TFrameConfigAIModelList.btnEnabledClick(Sender: TObject);
begin
  DoFilter;

end;

procedure TFrameConfigAIModelList.cmbProvidersChange(Sender: TObject);
begin
  Self.DoFilter;
end;

constructor TFrameConfigAIModelList.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFrameConfigAIModelList.Destroy;
begin

  inherited;
end;

procedure TFrameConfigAIModelList.DoFilter;
var
  I:Integer;
  AModelJson:ISuperObject;
begin
  lvChannel.Prop.Items.BeginUpdate;
  try
    for I := 0 to lvChannel.Prop.Items.Count-1 do
    begin
      AModelJson:=lvChannel.Prop.Items[I].Json;
      if (Self.cmbProviders.ItemIndex>0) and (AModelJson.S['provider']<>Self.cmbProviders.Text) then
      begin
        Self.lvChannel.Prop.Items[I].Visible:=False;
        Continue;
      end;
      if (Self.edtKeyword.Text<>'') and not (Pos(Self.edtKeyword.Text,AModelJson.S['model'])>0) then
      begin
        Self.lvChannel.Prop.Items[I].Visible:=False;
        Continue;
      end;

      if Self.btnCurrent.Prop.IsPushed and (GlobalOpenClawHelper.FCustomModelId<>AModelJson.S['model']) then
      begin
        //仅显示当前的模型
        Self.lvChannel.Prop.Items[I].Visible:=False;
        Continue;

      end;
      if Self.btnEnabled.Prop.IsPushed and (AModelJson.B['isActive']=False) then
      begin
        //仅显示启用的模型
        Self.lvChannel.Prop.Items[I].Visible:=False;
        Continue;
      end;

      Self.lvChannel.Prop.Items[I].Visible:=True;
    end;
  finally
    lvChannel.Prop.Items.EndUpdate;
  end;
end;

procedure TFrameConfigAIModelList.DoLoadModels(AModelList: ISuperArray);
var
  I: Integer;
  ASkinItem:TSkinItem;
  AModelJson:ISuperObject;
  AConfiguredJson:ISuperObject;
begin

  //添加模型列表
  lvChannel.Prop.Items.BeginUpdate;
  try
    Self.lvChannel.Prop.Items.Clear();
    for I := 0 to AModelList.Length-1 do
    begin
      //只需要显示大语言模型就可以了，不需要显示向量模型
      AModelJson:=AModelList.O[I];
      if AModelJson.S['type']<>'llm' then Continue;


      ASkinItem:=Self.lvChannel.Prop.Items.Add;
      ASkinItem.Caption:=GlobalManager.MyAIModelsArray.O[I].S['model'];
      ASkinItem.Checked:=GlobalManager.MyAIModelsArray.O[I].B['isActive'];
      ASkinItem.Json:=GlobalManager.MyAIModelsArray.O[I];

      if FileExists(GetApplicationPath+'icons'+PathDelim+'model'+PathDelim+AModelJson.S['provider']+'.svg') then
      begin
        ASkinItem.Icon.FileName:=GetApplicationPath+'icons'+PathDelim+'model'+PathDelim+AModelJson.S['provider']+'.svg';
      end;

//      //已经配置的模型,启用状态，没有配置的，不启用状态
//      AConfiguredJson:=nil;
//      if GlobalManager.FConfigedChannels<>nil then
//      begin
//        AConfiguredJson:=LocateJsonArray(GlobalManager.FConfigedChannels,'type',GlobalManager.MyAIModelsArray.O[I].I['value']);
//      end;
//
//      if AConfiguredJson<>nil then
//      begin
////        ASkinItem.Detail:='已配置';
//        GlobalManager.MyAIModelsArray.O[I].O['configured']:=AConfiguredJson;
//      end
//      else
//      begin
////        ASkinItem.Detail:='未配置';
//      end;

    end;

  finally
    lvChannel.Prop.Items.EndUpdate;
  end;
end;

procedure TFrameConfigAIModelList.edtKeywordChange(Sender: TObject);
begin
  DoFilter;
end;

procedure TFrameConfigAIModelList.edtKeywordChangeTracking(Sender: TObject);
begin
  DoFilter;
end;

procedure TFrameConfigAIModelList.Load;
var
  I: Integer;
  ASkinItem:TSkinItem;
  AModelJson:ISuperObject;
  AConfiguredJson:ISuperObject;
begin

  //添加厂商过滤列表
  cmbProviders.Items.BeginUpdate;
  try
    cmbProviders.Items.Clear;
    cmbProviders.Items.Add('全部');
    for I := 0 to GlobalManager.AIChannelArray.Length-1 do
    begin
      cmbProviders.Items.Add(GlobalManager.AIChannelArray.O[I].S['provider']);

    end;

  finally
    cmbProviders.Items.EndUpdate;
  end;

//
//  //添加模型列表
//  lvChannel.Prop.Items.BeginUpdate;
//  try
//    Self.lvChannel.Prop.Items.Clear();
//    for I := 0 to GlobalManager.MyAIModelsArray.Length-1 do
//    begin
//      //只需要显示大语言模型就可以了，不需要显示向量模型
//      AModelJson:=GlobalManager.MyAIModelsArray.O[I];
//      if AModelJson.S['type']<>'llm' then Continue;
//
//
//      ASkinItem:=Self.lvChannel.Prop.Items.Add;
//      ASkinItem.Caption:=GlobalManager.MyAIModelsArray.O[I].S['model'];
//      ASkinItem.Checked:=GlobalManager.MyAIModelsArray.O[I].B['isActive'];
//      ASkinItem.Json:=GlobalManager.MyAIModelsArray.O[I];
//
//      if FileExists(GetApplicationPath+'icons'+PathDelim+'model'+PathDelim+GlobalManager.MyAIModelsArray.O[I].S['provider']+'.svg') then
//      begin
//        ASkinItem.Icon.FileName:=GetApplicationPath+'icons'+PathDelim+'model'+PathDelim+GlobalManager.MyAIModelsArray.O[I].S['provider']+'.svg';
//      end;
//
////      //已经配置的模型,启用状态，没有配置的，不启用状态
////      AConfiguredJson:=nil;
////      if GlobalManager.FConfigedChannels<>nil then
////      begin
////        AConfiguredJson:=LocateJsonArray(GlobalManager.FConfigedChannels,'type',GlobalManager.MyAIModelsArray.O[I].I['value']);
////      end;
////
////      if AConfiguredJson<>nil then
////      begin
//////        ASkinItem.Detail:='已配置';
////        GlobalManager.MyAIModelsArray.O[I].O['configured']:=AConfiguredJson;
////      end
////      else
////      begin
//////        ASkinItem.Detail:='未配置';
////      end;
//
//    end;
//
//  finally
//    lvChannel.Prop.Items.EndUpdate;
//  end;
  DoLoadModels(GlobalManager.MyAIModelsArray);

  DoFilter;


//  Self.tteLoad.Run();

end;

procedure TFrameConfigAIModelList.lvChannelClickItem(AItem: TSkinItem);
begin
//  //配置该AI渠道
//  if FConfigAIFrame=nil then
//  begin
//    FConfigAIFrame:=TFrameConfigAI.Create(Self);
//    FConfigAIFrame.Parent:=Self.pnlClient;
//    FConfigAIFrame.Align:=TAlignLayout.Client;
//    FConfigAIFrame.Visible:=True;
//  end;
//  FConfigAIFrame.Load(AItem.Json,AItem.Json.O['configured'],LocateJsonArray(GlobalManager.FConfigedChannels,'type',30));

end;

procedure TFrameConfigAIModelList.lvChannelClickItemDesignerPanelChild(
  Sender: TObject; AItem: TBaseSkinItem;
  AItemDesignerPanel: TSkinFMXItemDesignerPanel; AChild: TFmxObject);
var
  AModelJson:ISuperObject;
begin
  AModelJson:=TSkinItem(AItem).Json;
  if AChild.Name='chkEnable' then
  begin
    AModelJson.B['isActive']:=not AModelJson.B['isActive'];
    TSkinItem(AItem).Checked:=not TSkinItem(AItem).Checked;
    GlobalManager.SaveMyModels;

  end;
  if AChild.Name='btnTest' then
  begin
    //测试模型是否可用
    Self.tteTestModel.TaskObject:=AItem;
    Self.tteTestModel.Run();
  end;
  //模型配置
  if AChild.Name='btnConfig' then
  begin

  end;
end;

procedure TFrameConfigAIModelList.lvChannelNewListItemStyleFrameCacheInit(Sender: TObject; AListItemTypeStyleSetting: TListItemTypeStyleSetting;
  ANewListItemStyleFrameCache: TListItemStyleFrameCache);
var
  AFrame:TFrameIconCaptionListItemStyle;
begin
//  if ANewListItemStyleFrameCache.FItemStyleFrame is TFrameIconCaptionListItemStyle then
//  begin
//    AFrame:=TFrameIconCaptionListItemStyle(ANewListItemStyleFrameCache.FItemStyleFrame);
//    AFrame.ItemDesignerPanel.Material.BackColor.DrawRectSetting.SetMargins(10,5,10,5);
//    AFrame.ItemDesignerPanel.Material.BackColor.DrawRectSetting.SizeType:=TDPSizeType.dpstPixel;
//    AFrame.ItemDesignerPanel.Material.BackColor.DrawRectSetting.Enabled:=True;
//    AFrame.ItemDesignerPanel.Material.BackColor.IsRound:=True;
//
//    AFrame.ItemDesignerPanel.Material.BackColor.DrawEffectSetting.PushedEffect.CommonEffectTypes:=[dpcetShadowSizeChange]+AFrame.ItemDesignerPanel.Material.BackColor.DrawEffectSetting.PushedEffect.CommonEffectTypes;
//    AFrame.ItemDesignerPanel.Material.BackColor.DrawEffectSetting.PushedEffect.ShadowSize:=5;
//    AFrame.ItemDesignerPanel.Material.BackColor.DrawEffectSetting.PushedEffect.FillColor.Color:=TAlphaColorRec.White;
////    AFrame.ItemDesignerPanel.Material.BackColor.ShadowSize:=10;
//  end;
  //
end;

procedure TFrameConfigAIModelList.tteLoadExecute(ATimerTask: TTimerTask);
begin
//  GlobalManager.LoadConfigedChannels;

  //从接口加载模型列表
  //从接口加载知识库列表
  ATimerTask.TaskTag:=TASK_FAIL;

  //获取首页统计
  TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI(
        'ai/model/list',
        nil,
        InterfaceUrl+'ragcenter/',
        [],
        [],
        GlobalRestAPISignType,
        GlobalRestAPIAppSecret
        );

  TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;



end;

procedure TFrameConfigAIModelList.tteLoadExecuteEnd(ATimerTask: TTimerTask);
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

        DoLoadModels(ASuperObject.O['Data'].A['RecordList']);

        DoFilter;



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

procedure TFrameConfigAIModelList.tteTestModelBegin(ATimerTask: TTimerTask);
begin
  ShowWaitingFrame(nil,'检测中...');
end;

procedure TFrameConfigAIModelList.tteTestModelExecute(ATimerTask: TTimerTask);
var
  Client: IGenAI;
  AModelJson:ISuperObject;
  AIsOK:Boolean;
begin
  ATimerTask.TaskTag:=TASK_FAIL;
  try

    AModelJson:=TSkinItem(ATimerTask.TaskObject).Json;


    Client := TGenAI.Create('sk-5c2de62c553f41bdafa7357c390a0079');//AModelJson.S['key']);
    Client.BaseURL := 'https://dashscope.aliyuncs.com/compatible-mode/v1';
  //  Client.BaseURL := Self.edtAIServer.Text;

    //流式
    AIsOK:=Client.Chat.CreateStream(
      procedure (Params: TChatParams)
      begin
        Params.Model(AModelJson.S['model']);
        Params.Messages([
          FromUser('hello')
        ]);
        Params.Stream;
      end,
      procedure (var Chat: TChat; IsDone: Boolean; var Cancel: Boolean)
      begin
  //      if (not IsDone) and Assigned(Chat) then
  //        begin
  //          //将大模型回复的分块拼起来
  //          Self.memResponse.Text:=Self.memResponse.Text+Chat.Choices[0].Delta.Content;
  //          Application.ProcessMessages;
  //
  //        end;
        if IsDone then
        begin
          //测试成功了

        end;
      end);

    if AIsOK then
    begin
      ATimerTask.TaskTag:=TASK_SUCC;
    end;

  except
    on E:Exception do
    begin
      ATimerTask.TaskDesc:=E.Message;
    end;

  end;

end;

procedure TFrameConfigAIModelList.tteTestModelExecuteEnd(
  ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
    begin

        ShowHintFrame(Self,'成功!');


    end
    else
    begin


        //网络异常
        ShowMessageBoxFrame(Self,'失败!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);

    end;
  finally
    HideWaitingFrame;
  end;

end;

end.
