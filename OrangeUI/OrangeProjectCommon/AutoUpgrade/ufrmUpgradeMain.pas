unit ufrmUpgradeMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uMXUpgrades, ComCtrls, uDataMessages;

type
  TfrmUpgradeMain = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    labTitle: TLabel;
    Button1: TButton;
    Shape1: TShape;
    Button4: TButton;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    FInUpdating: Boolean;
    FForceUpdate: Boolean;
    FUpgrade: TMXUpgrade;
    procedure AddMsg(const Value: string);
    procedure DoOnDownFinished(sender: TObject);

    { Private declarations }
  protected
    function GetUpgradeParams: string;
    procedure UMFileTraffic(var msg: TMessage); message UM_FileTraffic;
  public
    { Public declarations }
    function CheckVersion : boolean;
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
  end;

var
  frmUpgradeMain: TfrmUpgradeMain;

implementation

uses
  SynCommons, ShellAPI;

// START resource string wizard section
resourcestring
  SMSG_REUPDTE = '准备更新内容...';
  SMSG_DOWNFILES = '下载更新文件 ...';
  SMSG_NOTUPDATEFile = '无更新文件...';
  SMSG_UPDATEVer = '更新完成，版本：';

// END resource string wizard section


{$R *.dfm}

procedure TfrmUpgradeMain.Button1Click(Sender: TObject);
begin
  close;
end;

function TfrmUpgradeMain.CheckVersion: boolean;
var
  sParams: string;
begin
  Result := False;

  if not assigned(FUpgrade) then
  begin
    //取出参数
    sParams := GetUpgradeParams;
    if sParams <> '' then
    begin
      FUpgrade := TMXUpgrade.Create;
      FUpgrade.Init(sParams);
      FUpgrade.ProgressHandle := Handle;
    end;
  end;

  FForceUpdate := False;
  if assigned(FUpgrade) then
  begin
    //从服务器获取升级信息,并显示出来,以及判断是否强制更新
    /// Version 参数
    ///  verid = 当前的版本号
    ///  vertype = 当前的版本类型
    ///  http://192.168.0.103:4593/v1/tools/version?verid=2103130312&vertype=1
    Memo1.Text := FUpgrade.GetUpdateInfo(@FForceUpdate);
    Result := FUpgrade.NewVerCount > 0;
  end;

  //如果弹制更新
  if FForceUpdate then
  begin
    Panel1.Visible := False;
    BorderIcons := [];
    Button4Click(nil);
  end;
end;

constructor TfrmUpgradeMain.Create(AOwner: TComponent);
begin
  inherited;
  ProgressBar1.Visible := False;
end;

destructor TfrmUpgradeMain.Destroy;
begin
  if Assigned(FUpgrade) then
    FUpgrade.Free;
  inherited;
end;

procedure TfrmUpgradeMain.AddMsg(const Value: string);
begin
  Memo1.Lines.Insert(0, Value);
end;

procedure TfrmUpgradeMain.Button4Click(Sender: TObject);
var
  iCnt: integer;
begin
  //升级
  Button4.Enabled := False;
  AddMsg('--------------');
  AddMsg(SMSG_REUPDTE);

  //从服务器获取需要下载的文件
  iCnt := FUpgrade.GetUpgradeFiles;
  if iCnt > 0 then
  begin
    FUpgrade.KillTarget;

    AddMsg(SMSG_DOWNFILES);
    FInUpdating := True;
    FUpgrade.OnDownFinished := DoOnDownFinished;
    FUpgrade.DownFiles;
  end
  else
  begin
    AddMsg(SMSG_NOTUPDATEFile);
  end;
end;

procedure TfrmUpgradeMain.DoOnDownFinished(sender: TObject);
var
  sDir: string;
  sFileName: string;
begin
  Button4.Enabled := True;
  FUpgrade.OnDownFinished := nil;

  sDir := ExtractFilePath(ParamStr(0));
  sFileName := sDir + FUpgrade.ExecFile; //'MXSearcher.exe';

  FInUpdating := False;
  //替换文件
  if FUpgrade.UpdateFiles then
  begin
    AddMsg(SMSG_UPDATEVer + FUpgrade.CurrVer.Version);
    PostMessage(Handle, WM_CLOSE, 0, 0);
    ShellAPI.ShellExecute(0, 'Open', PChar(sFileName), nil, PChar(sDir), SW_SHOWNORMAL);
  end;
end;

function TfrmUpgradeMain.GetUpgradeParams: string;
var
  cStr: TStringStream;
  sFileName: string;
  sUpgradeParams: string;
begin
//  Result := UTF8ToString(JSONEncode(
//      ['id', 2103130312,
//       'vertype', 1,
//       'svraddr', '192.168.0.103',
//       'svrport', 4593,
//       'isssl', False,
//       'svrapi', 'v1']));

  sUpgradeParams := '';
  sFileName := '';
  if ParamCount > 0 then
    sFileName := ParamStr(1);

  if (sFileName <> '') and FileExists(sFileName) then
  begin
    cStr := TStringStream.Create('', TEncoding.UTF8);
    try
      cStr.LoadFromFile(sFileName);
      sUpgradeParams := cStr.DataString;
    finally
      cStr.Free;
    end;
  end;

  Result := sUpgradeParams;
end;

procedure TfrmUpgradeMain.UMFileTraffic(var msg: TMessage);
begin
  ProgressBar1.Visible := True;
  ProgressBar1.Position := msg.LParam;

end;

end.

