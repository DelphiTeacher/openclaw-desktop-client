//convert pas to utf8 by ¥
unit ServiceManageFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 

  Winapi.WinSvc,
  Winapi.ShellApi,
  Windows,
  uFileCommon,
  uManager,
  uServiceManage,
  uLocalOpenClawHelper,

  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyControl, uSkinButtonType;




type
  TFrameServiceManage = class(TFrame)
    Label1: TLabel;
    lblNode: TLabel;
    lblStatusNode: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnSave: TSkinButton;
    Label7: TLabel;
    edtJetUrl: TEdit;
    edtWebPort: TEdit;
    tmIdle: TTimer;
    btnRunNode: TSkinButton;
    SkinButton1: TSkinButton;
    Label4: TLabel;
    procedure btnRunNodeClick(Sender: TObject);
    procedure btnStopNodeClick(Sender: TObject);
    procedure btnInstallNodeClick(Sender: TObject);
    procedure tmIdleTimer(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SkinButton1Click(Sender: TObject);
  private
//	  schSCManager: SC_HANDLE;
//
//
//    schService_Node: SC_HANDLE;
//	  ssStatus_Node: TServiceStatus;
//
//
//    m_RunLimit: Integer;
//    m_StopLimit: Integer;

    procedure SyncButtonState;
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    procedure Load(AUpdateButton:Boolean);
    procedure DisabledAllButtons;



    { Public declarations }
  end;

implementation

{$R *.fmx}


const
//  RunningTextColor = TAlphaColorRec.Black; //默认黑色
//  RunningTextColor = $00804000; //藏蓝
//  RunningTextColor = $00E8AB0B; //淡蓝
  RunningTextColor = TAlphaColorRec.Green; //绿
//  RunningTextColor = $000000D2;  //红
  ErrorTextColor = TAlphaColorRec.Red;  //红


{ TFrameServiceManage }

procedure TFrameServiceManage.btnInstallNodeClick(Sender: TObject);
begin

//  //判断node有没有安装
//  ShellExecute(0,'open',PWideChar(GetApplicationPath+'install_node.bat'),nil,nil,SW_SHOWNORMAL);



end;

procedure TFrameServiceManage.btnRunNodeClick(Sender: TObject);
//var
//  lpServiceArgVectors: PChar;
begin
//  if schService_Node = 0 then Exit;
//
////	tmIdle.Enabled := False;
////
////	m_RunLimit := 0;
////
////  DisabledAllButtons;
//
//	StartService(schService_Node, 0, lpServiceArgVectors);
//
////	tmRunMainServer.Enabled := True;



end;

procedure TFrameServiceManage.btnSaveClick(Sender: TObject);
begin
//  GlobalManager.FWebHost:=Self.edtWebHost.Text;
//  GlobalManager.FWebPort:=StrToInt(Self.edtWebPort.Text);
//  GlobalServiceManager.SaveSetting;

end;

procedure TFrameServiceManage.Button1Click(Sender: TObject);
begin
//  ShellExecute(0,'open',PWideChar('http://localhost:5436'),nil,nil,SW_SHOWNORMAL);

end;

procedure TFrameServiceManage.Button2Click(Sender: TObject);
begin
//  ShellExecute(0,'open',PWideChar('http://localhost:5437'),nil,nil,SW_SHOWNORMAL);

end;

constructor TFrameServiceManage.Create(AOwner: TComponent);
begin
  inherited;

//	//检查服务状态
//	schSCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
//	if (schSCManager = 0) then
//	begin
//    ShowMessage('访问系统服务管理器SCM失败,请以管理员权限运行！');
//    lblStatusNode.Text := '无法获取';
//    lblStatusNode.TextSettings.FontColor := ErrorTextColor;
//	end;

  tmIdle.Enabled := True;
end;

procedure TFrameServiceManage.DisabledAllButtons;
begin

end;

procedure TFrameServiceManage.Load(AUpdateButton:Boolean);
var
  bEnabled_btnRunNode: Boolean;
  bEnabled_btnStopNode: Boolean;
begin
  Self.edtWebPort.Text:=IntToStr(GlobalOpenClawHelper.FGatewayPort);
  if GlobalManager.FOpenclawUrl='' then
  begin
    Self.edtJetUrl.Text:=GlobalOpenClawHelper.GetGatewayUrl;
  end
  else
  begin
    Self.edtJetUrl.Text:=GlobalManager.FOpenclawUrl;
  end;

  SyncButtonState;


//  if schSCManager = 0 then Exit;
//
//  if AUpdateButton then
//  begin
//    bEnabled_btnRunNode := False;
//    bEnabled_btnStopNode := False;
//  end;
//
//
//	if (schService_Node <> 0) then
//  begin
//    CloseServiceHandle(schService_Node);
//    schService_Node := 0;
//  end;
//
//
//
//
//  schService_Node := OpenService(schSCManager,
//    PChar('JetAINodeServer'), SERVICE_ALL_ACCESS);
//  if (schService_Node = 0) then
//  begin
//    lblStatusNode.Text := '服务未安装';
//    lblStatusNode.TextSettings.FontColor := ErrorTextColor;
//  end;
//
//
//  if schService_Node <> 0 then
//  begin
//    QueryServiceStatus(schService_Node, ssStatus_Node);
//    case ssStatus_Node.dwCurrentState of
//      SERVICE_STOPPED: begin
//        if AUpdateButton then
//        begin
//          bEnabled_btnRunNode := True;
//          bEnabled_btnStopNode := False;
//        end;
//        lblStatusNode.Text := '已停止';
//        lblStatusNode.TextSettings.FontColor := ErrorTextColor;
//      end;
//      SERVICE_RUNNING: begin
//        if AUpdateButton then
//        begin
//          bEnabled_btnRunNode := False;
//          bEnabled_btnStopNode := True;
//        end;
//        lblStatusNode.Text := '正在运行';
//        lblStatusNode.TextSettings.FontColor := RunningTextColor;
//      end;
//      SERVICE_START_PENDING: begin
//        if AUpdateButton then
//        begin
//          bEnabled_btnRunNode := False;
//          bEnabled_btnStopNode := False;
//        end;
//        lblStatusNode.Text := '正在启动...';
//        lblStatusNode.TextSettings.FontColor := TAlphaColorRec.Black;
//      end;
//      SERVICE_STOP_PENDING: begin
//        if AUpdateButton then
//        begin
//          bEnabled_btnRunNode := False;
//          bEnabled_btnStopNode := False;
//        end;
//        lblStatusNode.Text := '正在停止...';
//        lblStatusNode.TextSettings.FontColor := TAlphaColorRec.Black;
//      end;
//    end;//case
//  end;
//
//
//
//  if AUpdateButton then
//  begin
//    btnRunNode.Enabled := bEnabled_btnRunNode;
//    btnStopNode.Enabled := bEnabled_btnStopNode;
//  end;


end;

procedure TFrameServiceManage.SkinButton1Click(Sender: TObject);
begin
  ShellExecute(0,'open',PWideChar(Self.edtJetUrl.Text),nil,nil,SW_SHOWNORMAL);

end;

procedure TFrameServiceManage.SyncButtonState;
var
  ADesc:String;
begin
  if GlobalServiceManager.IsServerRunning(ADesc) then
  begin
    Self.btnRunNode.Caption:='停止服务';
    lblStatusNode.Text := '正在运行';
    lblStatusNode.TextSettings.FontColor := RunningTextColor;
  end
  else
  begin
    Self.btnRunNode.Caption:='启动服务';
    lblStatusNode.Text := '服务未启动';
    lblStatusNode.TextSettings.FontColor := ErrorTextColor;
  end;

end;

procedure TFrameServiceManage.tmIdleTimer(Sender: TObject);
begin
//  Self.Load(True);
end;

procedure TFrameServiceManage.btnStopNodeClick(Sender: TObject);
begin

//  if not AllUserLogout then Exit;

//  if schService_Node = 0 then Exit;

//  if schService_Httpd <> 0 then
//  begin
//    QueryServiceStatus(schService_Httpd, ssStatus_Httpd);
//    if (ssStatus_Httpd.dwCurrentState = SERVICE_RUNNING) then
//    begin
//      MessageBox(Handle, PChar('关闭该项服务将同时停止' + OEM_Service_WebServer_DisplayName + '！'), '提示', MB_OK + MB_ICONWARNING);
//      ControlService(schService_Httpd, SERVICE_CONTROL_STOP, ssStatus_Httpd);
//    end;
//  end;

//	tmIdle.Enabled := False;
//
//	m_StopLimit := 0;
//
//  DisabledAllButtons;

//	ControlService(schService_Node, SERVICE_CONTROL_STOP, ssStatus_Node);
//	ControlService(schService_MainServer, SERVICE_CONTROL_SHUTDOWN, ssStatus_MainServer);

//	tmStopMainServer.Enabled := True;


end;

end.
