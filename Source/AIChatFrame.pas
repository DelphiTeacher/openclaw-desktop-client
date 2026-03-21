unit AIChatFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uManager,
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

  //  Self.WebBrowser1.URL:='http://localhost:3003/chat?username=root&password='+'123456';//不能自动登录
  //这个比较稳定一点
//  Self.WebBrowser1.URL:=GlobalManager.FJetAIUrl;
  Self.WebBrowser1.Navigate(GlobalManager.FJetAIUrl)
//  Self.WebBrowser1.URL:=GlobalManager.FJetAIUrl+'login?lastRoute=/chat&username=root&password='+'123456';

end;

end.
