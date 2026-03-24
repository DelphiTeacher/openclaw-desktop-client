unit InstallDaemonFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  ServiceManageFrame,
  CustomAIModelSettingFrame,
  uSkinPageControlType, uSkinFireMonkeyPageControl, uSkinFireMonkeyControl,
  uSkinButtonType, uSkinFireMonkeyButton, uSkinPanelType, uSkinFireMonkeyPanel;

type
  TFrameInstallDaemon = class(TFrame)
    pcMain: TSkinFMXPageControl;
    tsService: TSkinFMXTabSheet;
    tsModel: TSkinTabSheet;
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    procedure pcMainChange(Sender: TObject);
  private
    { Private declarations }
  public
    FServiceManageFrame:TFrameServiceManage;
    FCustomAIModelSettingFrame:TFrameCustomAIModelSetting;
    procedure Load;
    { Public declarations }
  end;

var
  GlobalInstallDaemonFrame:TFrameInstallDaemon;

implementation

{$R *.fmx}

{ TFrameInstallDaemon }

procedure TFrameInstallDaemon.Load;
begin
  Self.pcMain.Prop.ActivePage:=nil;
  Self.pcMain.Prop.ActivePage:=tsModel;

end;

procedure TFrameInstallDaemon.pcMainChange(Sender: TObject);
begin

//  if Self.pcMain.Prop.ActivePage=tsModel then
//  begin
//    if FConfigAIListFrame=nil then
//    begin
//      FConfigAIListFrame:=TFrameConfigAIList.Create(Self);
//      FConfigAIListFrame.Parent:=Self.pcMain.Prop.ActivePage;
//      FConfigAIListFrame.Align:=TAlignLayout.Client;
//      FConfigAIListFrame.Load;
//    end;
//
//  end;

  if Self.pcMain.Prop.ActivePage=tsModel then
  begin
    if FCustomAIModelSettingFrame=nil then
    begin
      FCustomAIModelSettingFrame:=TFrameCustomAIModelSetting.Create(Self);
      FCustomAIModelSettingFrame.pnlToolBar.Visible:=False;
      FCustomAIModelSettingFrame.Parent:=Self.pcMain.Prop.ActivePage;
      FCustomAIModelSettingFrame.Align:=TAlignLayout.Client;
      FCustomAIModelSettingFrame.Load(True);
    end;

  end;



//  if Self.pcMain.Prop.ActivePage=tsService then
//  begin
//    if FServiceManageFrame=nil then
//    begin
//      FServiceManageFrame:=TFrameServiceManage.Create(Self);
//      FServiceManageFrame.Parent:=Self.pcMain.Prop.ActivePage;
//      FServiceManageFrame.Align:=TAlignLayout.Client;
//      FServiceManageFrame.Load(True);
//    end;
//
//  end;

end;

end.
