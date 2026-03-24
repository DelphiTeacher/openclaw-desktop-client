//convert pas to utf8 by ¥
unit ConfigAIModelListFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uManager,
  uSkinItemJsonHelper,
  ConfigAIFrame,
  uDataSetToJson,
  XSuperObject,
  uFileCommon,
  uTimerTask,
  uDrawParam,
  ListItemStyleFrame_IconCaption,

  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, uDrawCanvas, uSkinItems, uSkinFireMonkeyControl, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListViewType, uSkinFireMonkeyListView, uSkinPanelType, uSkinFireMonkeyPanel, uTimerTaskEvent;

type
  TFrameConfigAIModelList = class(TFrame)
    lvChannel: TSkinFMXListView;
    tteLoad: TTimerTaskEvent;
    procedure lvChannelClickItem(AItem: TSkinItem);
    procedure tteLoadExecute(ATimerTask: TTimerTask);
    procedure lvChannelNewListItemStyleFrameCacheInit(Sender: TObject; AListItemTypeStyleSetting: TListItemTypeStyleSetting; ANewListItemStyleFrameCache: TListItemStyleFrameCache);
  private
    FConfigAIFrame:TFrameConfigAI;
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

constructor TFrameConfigAIModelList.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFrameConfigAIModelList.Destroy;
begin

  inherited;
end;

procedure TFrameConfigAIModelList.Load;
var
  I: Integer;
  ASkinItem:TSkinItem;
  AConfiguredJson:ISuperObject;
begin
  lvChannel.Prop.Items.BeginUpdate;
  try
    Self.lvChannel.Prop.Items.Clear();
    for I := 0 to GlobalManager.AIChannelArray.Length-1 do
    begin
      ASkinItem:=Self.lvChannel.Prop.Items.Add;
      ASkinItem.Caption:=GlobalManager.AIChannelArray.O[I].S['text'];
      ASkinItem.Json:=GlobalManager.AIChannelArray.O[I];

      if FileExists(GetApplicationPath+'icons'+PathDelim+GlobalManager.AIChannelArray.O[I].S['icon_file']) then
      begin
        ASkinItem.Icon.FileName:=GetApplicationPath+'icons'+PathDelim+GlobalManager.AIChannelArray.O[I].S['icon_file'];
      end;

      //已经配置的模型,启用状态，没有配置的，不启用状态
      AConfiguredJson:=nil;
      if GlobalManager.FConfigedChannels<>nil then
      begin
        AConfiguredJson:=LocateJsonArray(GlobalManager.FConfigedChannels,'type',GlobalManager.AIChannelArray.O[I].I['value']);
      end;

      if AConfiguredJson<>nil then
      begin
//        ASkinItem.Detail:='已配置';
        GlobalManager.AIChannelArray.O[I].O['configured']:=AConfiguredJson;
      end
      else
      begin
//        ASkinItem.Detail:='未配置';
      end;

    end;

  finally
    lvChannel.Prop.Items.EndUpdate;
  end;

  Self.tteLoad.Run();

end;

procedure TFrameConfigAIModelList.lvChannelClickItem(AItem: TSkinItem);
begin
  //配置该AI渠道
  if FConfigAIFrame=nil then
  begin
    FConfigAIFrame:=TFrameConfigAI.Create(Self);
    FConfigAIFrame.Parent:=Self.pnlClient;
    FConfigAIFrame.Align:=TAlignLayout.Client;
    FConfigAIFrame.Visible:=True;
  end;
  FConfigAIFrame.Load(AItem.Json,AItem.Json.O['configured'],LocateJsonArray(GlobalManager.FConfigedChannels,'type',30));

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
end;

end.
