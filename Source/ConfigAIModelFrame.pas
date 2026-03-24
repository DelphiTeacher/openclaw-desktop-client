//convert pas to utf8 by ¥
unit ConfigAIModelFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,


  XSuperObject,
  uFileCommon,
  uGraphicCommon,
  uFuncCommon,
  uManager,
  uServiceManage,
  StrUtils,
  uDataSetToJson,
  ShellAPI,
  Windows,
  MessageBoxFrame,
  CommonImageDataMoudle,
  uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel,
  EasyServiceCommonMaterialDataMoudle,
  ListItemStyleFrame_IconCaption_RightGrayButton_InstallModel,

  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyControl, uSkinButtonType, uDrawCanvas,
  uSkinItems, uSkinScrollControlType, uSkinCustomListType, uSkinVirtualListType, uSkinListViewType, uSkinFireMonkeyListView, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  uSkinPanelType, uSkinFireMonkeyPanel, FMX.Effects, uSkinPageControlType, uSkinFireMonkeyPageControl, FMX.WebBrowser, uSkinFireMonkeyMemo, uSkinLabelType, uSkinFireMonkeyLabel;

type
  TFrameConfigAIModel = class(TFrame)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtKey: TEdit;
    btnSave: TSkinButton;
    SkinFMXPanel1: TSkinFMXPanel;
    lvLocalModels: TSkinFMXListView;
    Label4: TLabel;
    SkinFMXPanel2: TSkinFMXPanel;
    btnDownloadOllama: TSkinButton;
    SkinFMXPanel3: TSkinFMXPanel;
    lvOfficialModels: TSkinFMXListView;
    Label5: TLabel;
    btnAddModel: TSkinButton;
    btnAddModel2: TSkinButton;
    SkinFMXPageControl1: TSkinFMXPageControl;
    tsAuto: TSkinTabSheet;
    tsOneAPI: TSkinTabSheet;
    WebBrowser1: TWebBrowser;
    SkinFMXLabel1: TSkinFMXLabel;
    procedure lvLocalModelsPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem; AItemDrawRect: TRect);
    procedure lvLocalModelsClickItemDesignerPanelChild(Sender: TObject; AItem: TBaseSkinItem; AItemDesignerPanel: TSkinFMXItemDesignerPanel; AChild: TFmxObject);
    procedure btnDownloadOllamaClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure lvOfficialModelsPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem; AItemDrawRect: TRect);
    procedure lvOfficialModelsClickItemDesignerPanelChild(Sender: TObject; AItem: TBaseSkinItem; AItemDesignerPanel: TSkinFMXItemDesignerPanel; AChild: TFmxObject);
    procedure btnAddModelClick(Sender: TObject);
    procedure SkinFMXPageControl1Change(Sender: TObject);
  private
    { Private declarations }
  public
    FChannelJson:ISuperObject;

    //官方渠道的one-api配置
    FOfficialConfigedJson:ISuperObject;
    //本地渠道的配置
    FOllamaConfigedJson:ISuperObject;


    FOldOfficialModels:TStringList;
    FOldOllamaModels:TStringList;

    procedure SyncModels;

    procedure DoModalResultFromOpenGPSMessageBox(AMessageBoxFrame:TObject);
    //对话框返回
    procedure DoOneInputMessageBoxFrameModalResult(AMessageBoxFrame:TObject);

    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    procedure Load(AChannelJson:ISuperObject;AOfficialConfigedJson:ISuperObject;AOllamaConfigedJson:ISuperObject);
    { Public declarations }
  end;


implementation

{$R *.fmx}

{ TFrameConfigAIModel }

procedure TFrameConfigAIModel.btnAddModelClick(Sender: TObject);
var
  AMessageBoxFrame:TFrameMessageBox;
begin
  AMessageBoxFrame:=ShowMessageBoxFrame(nil,
                      '',
                      '',
                      TMsgDlgType.mtInformation,
                      ['确定','取消'],
                      DoOneInputMessageBoxFrameModalResult,
                      nil,
                      '请输入模型名称',
                      ConvertToStringDynArray([]),
                      nil,
                      1//,
                      //nil,nil,True
                      );
  AMessageBoxFrame.pnlInput1.Caption:='名称';
  AMessageBoxFrame.edtInput1.Text:='';
  AMessageBoxFrame.edtInput1.TextPrompt:='';
  AMessageBoxFrame.edtInput1.FilterChar:='';
  AMessageBoxFrame.edtInput1.KeyboardType:=TVirtualKeyboardType.Default;
  AMessageBoxFrame.btnDec1.Visible:=False;
  AMessageBoxFrame.btnInc1.Visible:=False;
end;

procedure TFrameConfigAIModel.btnDownloadOllamaClick(Sender: TObject);
begin
  //打开网页让它下载安装即可
  //安装Ollama
  ShellExecute(0,'open',PWideChar('https://ollama.com/download/OllamaSetup.exe'),nil,nil,SW_SHOWNORMAL);

end;

procedure TFrameConfigAIModel.btnSaveClick(Sender: TObject);
var
  ANewOfficialModels:TStringList;
  ANewOllamaModels:TStringList;
  I: Integer;
  ADesc:String;
  AIsChanged:Boolean;
begin

  ANewOfficialModels:=TStringList.Create;
  ANewOllamaModels:=TStringList.Create;


  try

      AIsChanged:=False;


      for I := 0 to Self.lvOfficialModels.Prop.Items.Count-1 do
      begin
        if Self.lvOfficialModels.Prop.Items[I].Detail='已启用' then
        begin
          ANewOfficialModels.Add(Self.lvOfficialModels.Prop.Items[I].Caption);
        end;

      end;



      for I := 0 to Self.lvLocalModels.Prop.Items.Count-1 do
      begin
        if Self.lvLocalModels.Prop.Items[I].Detail='已启用' then
        begin
          ANewOllamaModels.Add(GetOllamaSupportModelName(Self.lvLocalModels.Prop.Items[I].Caption));
        end;

      end;


      if (FOfficialConfigedJson.S['key']<>Self.edtKey.Text)
        or (ANewOfficialModels.CommaText<>Self.FOldOfficialModels.Text)
        or (ANewOllamaModels.CommaText<>Self.FOldOllamaModels.Text)
         then
      begin
        AIsChanged:=True;
      end;



      if not GlobalManager.SaveAIConfig(Self.FChannelJson,
                                        Self.FOfficialConfigedJson,
                                        Self.FOllamaConfigedJson,
                                        Self.edtKey.Text,
                                        ANewOfficialModels,
                                        ANewOllamaModels,
                                        ADesc) then
      begin
        ShowMessage(ADesc);
        Exit;
      end;

      if AIsChanged then
      begin
        ShowMessageBoxFrame(nil,'配置已更新,需要重启服务,然后刷新网页！','',
                            TMsgDlgType.mtInformation,['稍后手动','重启服务'],
                            DoModalResultFromOpenGPSMessageBox);
      end;

  finally
    FreeAndNil(ANewOfficialModels);
    FreeAndNil(ANewOllamaModels);
  end;


end;

constructor TFrameConfigAIModel.Create(AOwner: TComponent);
begin
  inherited;
  FOldOfficialModels:=TStringList.Create;
  FOldOllamaModels:=TStringList.Create;

end;

destructor TFrameConfigAIModel.Destroy;
begin
  FreeAndNil(FOldOfficialModels);
  FreeAndNil(FOldOllamaModels);

  inherited;
end;

procedure TFrameConfigAIModel.DoModalResultFromOpenGPSMessageBox(AMessageBoxFrame: TObject);
var
  ADesc:String;
begin
  if (TFrameMessageBox(AMessageBoxFrame).ModalResult='确定')
    or (TFrameMessageBox(AMessageBoxFrame).ModalResult='重启服务') then
  begin
    GlobalServiceManager.StopServer(ADesc);
    GlobalServiceManager.StartServer(ADesc);
  end;

end;

procedure TFrameConfigAIModel.DoOneInputMessageBoxFrameModalResult(AMessageBoxFrame: TObject);
begin
  if TFrameMessageBox(AMessageBoxFrame).ModalResult='确定' then
  begin
//    ShowMessage('您的姓名是 '+TFrameMessageBox(AMessageBoxFrame).edtInput1.Text);


    GlobalManager.SaveCustomAIModel(Self.FChannelJson,TFrameMessageBox(AMessageBoxFrame).edtInput1.Text);

    //添加到列表中去
    SyncModels;

  end;

end;

procedure TFrameConfigAIModel.Load(AChannelJson:ISuperObject;AOfficialConfigedJson:ISuperObject;AOllamaConfigedJson:ISuperObject);
begin
  FChannelJson:=AChannelJson;
  FOfficialConfigedJson:=AOfficialConfigedJson;
  FOllamaConfigedJson:=AOllamaConfigedJson;
  if FOllamaConfigedJson=nil then
  begin
    FOllamaConfigedJson:=SO();
  end;

  Self.FOldOllamaModels.Clear;
  Self.FOldOfficialModels.Clear;


  //找到官方的配置和本地部署的配置
  if FOfficialConfigedJson<>nil then
  begin
    Self.edtKey.Text:=FOfficialConfigedJson.S['key'];
  end
  else
  begin
    FOfficialConfigedJson:=SO();
    Self.edtKey.Text:='';
  end;




//  if GlobalManager.FIsInstalledOllama then
//  begin
//    Self.btnDownloadOllama.Caption:='已安装Ollama';
//  end
//  else
//  begin
//    Self.btnDownloadOllama.Caption:='安装Ollama';
//  end;


  SyncModels;
end;

procedure TFrameConfigAIModel.lvLocalModelsClickItemDesignerPanelChild(Sender: TObject; AItem: TBaseSkinItem; AItemDesignerPanel: TSkinFMXItemDesignerPanel; AChild: TFmxObject);
begin
  if TSkinItem(AItem).Detail='点击安装' then
  begin
    //安装AI
    ShellExecute(0,'open',PWideChar('ollama'),PWideChar(' pull '+GetOllamaSupportModelName(TSkinItem(AItem).Caption)),nil,SW_SHOWNORMAL);
  end
  else if TSkinItem(AItem).Detail='已启用' then
  begin
    TSkinItem(AItem).Detail:='已安装';
  end
  else
  begin
    TSkinItem(AItem).Detail:='已启用';
  end;
end;

procedure TFrameConfigAIModel.lvLocalModelsPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem; AItemDrawRect: TRect);
var
  AFrame:TFrameIconCaption_RightGrayButton_InstallModelListItemStyle;
begin
  if AItemDesignerPanel.Parent is TFrameIconCaption_RightGrayButton_InstallModelListItemStyle then
  begin
    AFrame:=TFrameIconCaption_RightGrayButton_InstallModelListItemStyle(AItemDesignerPanel.Parent);

    if (AItem.Detail='点击安装') then
    begin
      AFrame.lblItemDetail.Material.BackColor.BorderColor.Color:=LightgrayColor;
      AFrame.lblItemDetail.Material.DrawCaptionParam.FontColor:=LightgrayColor;
    end
    else
    begin
      AFrame.lblItemDetail.Material.BackColor.BorderColor.Color:=uGraphicCommon.SkinThemeColor;
      AFrame.lblItemDetail.Material.DrawCaptionParam.FontColor:=uGraphicCommon.SkinThemeColor;
    end;

  end;

end;

procedure TFrameConfigAIModel.lvOfficialModelsClickItemDesignerPanelChild(Sender: TObject; AItem: TBaseSkinItem; AItemDesignerPanel: TSkinFMXItemDesignerPanel; AChild: TFmxObject);
begin
  if TSkinItem(AItem).Detail='已启用' then
  begin
    TSkinItem(AItem).Detail:='已禁用';
  end
  else
  begin
    TSkinItem(AItem).Detail:='已启用';
  end;
end;

procedure TFrameConfigAIModel.lvOfficialModelsPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem;
  AItemDrawRect: TRect);
var
  AFrame:TFrameIconCaption_RightGrayButton_InstallModelListItemStyle;
begin
  if AItemDesignerPanel.Parent is TFrameIconCaption_RightGrayButton_InstallModelListItemStyle then
  begin
    AFrame:=TFrameIconCaption_RightGrayButton_InstallModelListItemStyle(AItemDesignerPanel.Parent);
    if (AItem.Detail='已安装') or (AItem.Detail='已启用') then
    begin
      AFrame.lblItemDetail.Material.BackColor.BorderColor.Color:=uGraphicCommon.SkinThemeColor;
      AFrame.lblItemDetail.Material.DrawCaptionParam.FontColor:=uGraphicCommon.SkinThemeColor;
//      AFrame.lblItemDetail.Enabled:=False;
    end
    else
    begin
      AFrame.lblItemDetail.Material.BackColor.BorderColor.Color:=LightgrayColor;
      AFrame.lblItemDetail.Material.DrawCaptionParam.FontColor:=LightgrayColor;
//      AFrame.lblItemDetail.Enabled:=True;
    end;

  end;

end;

procedure TFrameConfigAIModel.SkinFMXPageControl1Change(Sender: TObject);
begin
  //
  if Self.SkinFMXPageControl1.Prop.ActivePage=tsOneAPI then
  begin
    Self.WebBrowser1.URL:='http://localhost:5436';
  end;

end;

procedure TFrameConfigAIModel.SyncModels;
var
  I: Integer;
  AOllamaModelName:String;
  ASkinItem:TSkinItem;
  ASplitStringList:TStringList;
begin


  ASplitStringList:=TStringList.Create;
  ASplitStringList.CommaText:=FOfficialConfigedJson.S['models'];
  Self.lvOfficialModels.Prop.Items.BeginUpdate;
  try
    Self.lvOfficialModels.Prop.Items.Clear();
    //加载所有的模型
    for I := 0 to FChannelJson.A['models'].Length-1 do
    begin
      ASkinItem:=Self.lvOfficialModels.Prop.Items.Add;
      ASkinItem.Caption:=FChannelJson.A['models'].S[I];
      //判断是否已经安装
      if FileExists(GetApplicationPath+'icons'+PathDelim+FChannelJson.S['icon_file']) then
      begin
        ASkinItem.Icon.FileName:=GetApplicationPath+'icons'+PathDelim+FChannelJson.S['icon_file'];
      end;


      if ASplitStringList.IndexOf(FChannelJson.A['models'].S[I])<>-1 then
      begin
        ASkinItem.Detail:='已启用';
        Self.FOldOfficialModels.Add(FChannelJson.A['models'].S[I]);
      end
      else
      begin
        ASkinItem.Detail:='点击启用';
      end;

    end;
  finally
    Self.lvOfficialModels.Prop.Items.EndUpdate;
    FreeAndNil(ASplitStringList);
  end;







  ASplitStringList:=TStringList.Create;
  ASplitStringList.CommaText:=FOllamaConfigedJson.S['models'];
  Self.lvLocalModels.Prop.Items.BeginUpdate;
  try
    Self.lvLocalModels.Prop.Items.Clear();
    //加载所有的模型
    for I := 0 to FChannelJson.A['models'].Length-1 do
    begin
      ASkinItem:=Self.lvLocalModels.Prop.Items.Add;
      ASkinItem.Caption:=FChannelJson.A['models'].S[I];
      //判断是否已经安装
      if FileExists(GetApplicationPath+'icons'+PathDelim+FChannelJson.S['icon_file']) then
      begin
        ASkinItem.Icon.FileName:=GetApplicationPath+'icons'+PathDelim+FChannelJson.S['icon_file'];
      end;

      //qwen2:7b      dd314f039b9d    4.4 GB    5 weeks ago
      //qwen2:0.5b    6f48b936a09f    352 MB    5 weeks ago
      //qwen:0.5b     b5dc5e784f2a    394 MB    5 weeks ago
      //gemma:7b      a72c7f4d0a15    5.0 GB    5 months ago
      //gemma:2b      b50d6c999e59    1.7 GB    5 months ago

      //"qwen2-7b-instruct",  deepseek-r1
      AOllamaModelName:=GetOllamaSupportModelName(FChannelJson.A['models'].S[I]);



      if LocateJsonArray(GlobalManager.FLocalInstalledModels,'name',AOllamaModelName)=nil then
      begin
        ASkinItem.Detail:='点击安装';
//        ASkinItem.Detail:='未安装';
      end
      else
      begin
        //ASkinItem.Detail:='已启用';
        //ASkinItem.Detail1:='已安装';

        if ASplitStringList.IndexOf(AOllamaModelName)<>-1 then
        begin
          ASkinItem.Detail:='已启用';
          Self.FOldOllamaModels.Add(AOllamaModelName);
        end
        else
        begin
          ASkinItem.Detail:='已安装';
        end;

      end;



    end;
  finally
    Self.lvLocalModels.Prop.Items.EndUpdate;
    FreeAndNil(ASplitStringList);
  end;


end;

end.
