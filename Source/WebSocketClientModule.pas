//convert pas to utf8 by ¥
unit WebSocketClientModule;

interface

uses
  System.SysUtils, System.Classes, sgcBase_Classes, sgcSocket_Classes,
  sgcTCP_Classes, sgcWebSocket_Classes, sgcWebSocket_Classes_Indy,
  uOpenclawHelper,
  XSuperObject,
  uBaseLog,
  uFuncCommon,
  uFileCommon,
  sgcWebSocket_Client, sgcWebSocket;

type
  TdmWebSocketClient = class(TDataModule)
    sgcWebSocketClient1: TsgcWebSocketClient;
    procedure sgcWebSocketClient1Connect(Connection: TsgcWSConnection);
    procedure DataModuleCreate(Sender: TObject);
    procedure sgcWebSocketClient1Disconnect(Connection: TsgcWSConnection;
      Code: Integer);
    procedure sgcWebSocketClient1Message(Connection: TsgcWSConnection;
      const Text: string);
    procedure sgcWebSocketClient1Handshake(Connection: TsgcWSConnection;
      var Headers: TStringList);
  private
    { Private declarations }
  public
    procedure Start;
    procedure Stop;
    function IsConnected:Boolean;
    function GetConnectMsg:ISuperObject;
    { Public declarations }
  end;

var
  dmWebSocketClient: TdmWebSocketClient;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmWebSocketClient.DataModuleCreate(Sender: TObject);
begin
  Start;
end;

function TdmWebSocketClient.GetConnectMsg: ISuperObject;
var
  ARoles:ISuperArray;
begin
  //{
  //  "type": "req",
  //  "id": "…",
  //  "method": "connect",
  //  "params": {
  //    "minProtocol": 3,
  //    "maxProtocol": 3,
  //    "client": {
  //      "id": "cli",
  //      "version": "1.2.3",
  //      "platform": "macos",
  //      "mode": "operator"
  //    },
  //    "role": "operator",
  //    "scopes": ["operator.read", "operator.write"],
  //    "caps": [],
  //    "commands": [],
  //    "permissions": {},
  //    "auth": { "token": "…" },
  //    "locale": "en-US",
  //    "userAgent": "openclaw-cli/1.2.3",
  //    "device": {
  //      "id": "device_fingerprint",
  //      "publicKey": "…",
  //      "signature": "…",
  //      "signedAt": 1737264000000,
  //      "nonce": "…"
  //    }
  //  }
  //}


  Result:=SO();
  Result.S['type']:='req';
  Result.S['id']:=CreateGUIDString();
  Result.S['method']:='connect';
  Result.O['params'].I['minProtocol']:=3;
  Result.O['params'].I['maxProtocol']:=3;
  Result.O['params'].O['client'].S['id']:='cli';
  Result.O['params'].O['client'].S['version']:='1.2.3';
  Result.O['params'].O['client'].S['platform']:='windows';
  Result.O['params'].O['client'].S['mode']:='operator';
  
  Result.O['params'].S['role']:='operator';
  ARoles:=SA();
  ARoles.S[0]:='operator.read';
  ARoles.S[1]:='operator.write';
  Result.O['params'].A['roles']:=ARoles;
  // Result.O['params'].A['scopes']:=['operator.read', 'operator.write'];
  Result.O['params'].A['caps']:=SA();
  Result.O['params'].A['commands']:=SA();
  Result.O['params'].O['permissions']:=SO();
  Result.O['params'].O['auth'].S['token']:=GlobalOpenClawHelper.FAuthToken;
  Result.O['params'].S['locale']:='en-US';
  Result.O['params'].S['userAgent']:='desktopclient/1.2.3';

  Result.O['params'].O['device'].S['id']:='delphiteacher_macbook';
  Result.O['params'].O['device'].S['publicKey']:='';
  Result.O['params'].O['device'].S['signature']:='';
  Result.O['params'].O['device'].I['signedAt']:=timeMillionSecondsIntervalSince1970(Now());
  Result.O['params'].O['device'].S['nonce']:=CreateGUIDString();


  SaveStringToFile(Result.AsJson(),GetApplicationPath+'connect.json',TEncoding.UTF8);

end;

function TdmWebSocketClient.IsConnected: Boolean;
begin

end;

procedure TdmWebSocketClient.sgcWebSocketClient1Connect(Connection: TsgcWSConnection);
begin
  //与openclaw网关服务建立连接
  uBaseLog.HandleException(nil,'TdmWebSocketClient.sgcWebSocketClient1 Connect');
end;

procedure TdmWebSocketClient.sgcWebSocketClient1Disconnect(
  Connection: TsgcWSConnection; Code: Integer);
begin
  //断开连接
  uBaseLog.HandleException(nil,'TdmWebSocketClient.sgcWebSocketClient1 Disconnect');
end;

procedure TdmWebSocketClient.sgcWebSocketClient1Handshake(
  Connection: TsgcWSConnection; var Headers: TStringList);
begin
  //
end;

procedure TdmWebSocketClient.sgcWebSocketClient1Message(
  Connection: TsgcWSConnection; const Text: string);
var
  AResponseJson:ISuperObject;
begin
  //收到消息
  //'{"type":"event","event":"connect.challenge","payload":{"nonce":"98f77495-7324-45c1-a73c-27e6ecda46a2","ts":1774427389811}}'
  //'{"type":"res","id":"4CCD5E38CF0642C3BB3642F1475EA237","ok":false,"error":{"code":"INVALID_REQUEST","message":"invalid connect params: at root: unexpected property ''roles''; at /client/mode: must be equal to constant; at /client/mode: must match a schema in anyOf; at /device/publicKey: must NOT have fewer than 1 characters; at /device/signature: must NOT have fewer than 1 characters"}}'
  uBaseLog.HandleException(nil,'TdmWebSocketClient.sgcWebSocketClient1 Message Text:'+Text);

  AResponseJson:=SO(Text);

  if AResponseJson.S['event']='connect.challenge' then
  begin
    //网关发来的连接挑战，其实就是验证token
    //发送首帧
    Self.sgcWebSocketClient1.WriteData(Self.GetConnectMsg.AsJSON());

  end;


end;

procedure TdmWebSocketClient.Start;
begin

//  "gateway": {
//    "port": 18789,
//    "mode": "local",
//    "bind": "loopback",
//    "auth": {
//      "mode": "token",
//      "token": "f3d587a762b177332e69617785e867e24af9962151a3286f"
//    },
//    "tailscale": {
//      "mode": "off",
//      "resetOnExit": false
//    }
//  },
  //连接的时候，根据openclaw的设置，自动设置服务器和端口。
  Self.sgcWebSocketClient1.Port:=GlobalOpenClawHelper.FGatewayPort;
  Self.sgcWebSocketClient1.Host:='127.0.0.1';

//  //使用token的验证方式
//  Self.sgcWebSocketClient1.Authentication.Enabled:=True;
//  Self.sgcWebSocketClient1.Authentication.Token.Enabled:=True;
//  Self.sgcWebSocketClient1.Authentication.Token.AuthToken:=GlobalOpenClawHelper.FAuthToken;

  Self.sgcWebSocketClient1.Active:=True;



end;

procedure TdmWebSocketClient.Stop;
begin

end;

end.
