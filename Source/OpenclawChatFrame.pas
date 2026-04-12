unit OpenclawChatFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uManager,
  uLocalOpenClawHelper,
  EasyServiceCommonMaterialDataMoudle,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.WebBrowser, uSkinFireMonkeyControl, uSkinButtonType;

type
  TFrameOpenclawChat = class(TFrame)
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

{ TFrameOpenclawChat }

procedure TFrameOpenclawChat.btnRefreshClick(Sender: TObject);
begin
  //
  GlobalMainFrame.tteGetBasicData.Run();
end;

constructor TFrameOpenclawChat.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TFrameOpenclawChat.Load;
begin
  Self.WebBrowser1.Align:=TAlignLayout.Client;

  if GlobalManager.FOpenclawUrl<>'' then
  begin
    Self.WebBrowser1.Navigate(GlobalManager.FOpenclawUrl)
  end
  else
  begin
    Self.WebBrowser1.Navigate(GlobalOpenClawHelper.GetGatewayUrl);
  end;

end;

end.
