unit AIChatFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uManager,
  uOpenClawHelper,
  EasyServiceCommonMaterialDataMoudle,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.WebBrowser, uSkinFireMonkeyControl, uSkinButtonType;

type
  TFrameAIChat = class(TFrame)
    WebBrowser1: TWebBrowser;
    btnRefresh: TSkinButton;
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    procedure Load;
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
  MainFrame;

{ TFrameAIChat }

procedure TFrameAIChat.btnRefreshClick(Sender: TObject);
begin
  //
  GlobalMainFrame.tteGetBasicData.Run();
end;

constructor TFrameAIChat.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TFrameAIChat.Load;
begin
  Self.WebBrowser1.Align:=TAlignLayout.Client;

  if GlobalManager.FJetAIUrl<>'' then
  begin
    Self.WebBrowser1.Navigate(GlobalManager.FJetAIUrl)
  end
  else
  begin
    Self.WebBrowser1.Navigate(GlobalOpenClawHelper.GetGatewayUrl);
  end;

end;

end.
