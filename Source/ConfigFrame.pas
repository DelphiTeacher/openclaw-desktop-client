unit ConfigFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
//  ConfigAIListFrame,
  ServiceManageFrame,
  CustomAIModelSettingFrame,
  uSkinFireMonkeyPageControl, uSkinPageControlType, uSkinFireMonkeyControl;

type
  TFrameConfig = class(TFrame)
    pcMain: TSkinFMXPageControl;
    tsModel: TSkinTabSheet;
    tsService: TSkinFMXTabSheet;
    procedure pcMainChange(Sender: TObject);
  private
    { Private declarations }
  public
//    FConfigAIListFrame:TFrameConfigAIList;
    FServiceManageFrame:TFrameServiceManage;
    FCustomAIModelSettingFrame:TFrameCustomAIModelSetting;
    procedure Load;
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrameConfig.Load;
begin
  Self.pcMain.Prop.ActivePage:=nil;
  Self.pcMain.Prop.ActivePage:=tsModel;
end;

procedure TFrameConfig.pcMainChange(Sender: TObject);
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
      FCustomAIModelSettingFrame.Load(False);
    end;

  end;



  if Self.pcMain.Prop.ActivePage=tsService then
  begin
    if FServiceManageFrame=nil then
    begin
      FServiceManageFrame:=TFrameServiceManage.Create(Self);
      FServiceManageFrame.Parent:=Self.pcMain.Prop.ActivePage;
      FServiceManageFrame.Align:=TAlignLayout.Client;
      FServiceManageFrame.Load(True);
    end;

  end;

end;

end.
