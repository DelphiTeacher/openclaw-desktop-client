unit uBaseManager;


interface

uses
  IniFiles,
//  uFileCommon,
  System.IOUtils,
  SysUtils;


type


  TBaseManager=class
  protected
    function CustomLoadFromINI(AIniFile:TIniFile): Boolean;virtual;
    function CustomSaveToINI(AIniFile:TIniFile): Boolean;virtual;
//    procedure CustomLoadFromUserConfigINI(AIniFile:TIniFile);virtual;
//    procedure CustomSaveToUserConfigINI(AIniFile:TIniFile);virtual;
  public
  public
    //是否第一次启动
    IsFirstStart:Boolean;

    //是否第一次启动显示过向导页面
    IsShowedGuideFrame:Boolean;

//    UserFID:String;



    //上次选择的语言
//    LangKind:TLangKind;


    //用户名
    LastLoginUser:String;
    //密码
    LastLoginPass:String;

//    LastFastMsgUserID:Integer;
//    //登录类型
//    LastLoginType:String;
    //登录key
    LastLoginKey:String;
    //登录状态
    IsLogin:Boolean;

  public
    //服务器
    ServerHost:String;
    //服务器端口
    ServerPort:Integer;
    //广告信息
    LastNonce:String;

    //点击关闭按钮所执行的操作
    ClickCloseButtonAction:String;
  public

//    //存放搜索历史的目录
//    function GetUserLocalDir:String;

//    function LoadFromUserInfoINI(AINIFilePath: String): Boolean;
//
//    function SaveToUserInfoINI(AINIFilePath: String): Boolean;
  public
    function LoadFromINI(AINIFilePath: String): Boolean;
    function SaveToINI(AINIFilePath: String): Boolean;
//  public
//    //加载上次登录的用户信息、本地搜索历史
//    procedure LoadUserConfig;virtual;
//    //保存本地搜索历史
//    procedure SaveUserConfig;virtual;
//    //保存上次登录的用户信息
//    procedure SaveLastLoginInfo;virtual;
//
//    //保存上次的广告信息
//    procedure SaveLastPosterInfo;virtual;
  public
    procedure Load(AConfigFileName:String='Config.ini');
    procedure Save(AConfigFileName:String='Config.ini');
//    procedure Logout;virtual;
  public
    constructor Create;virtual;
    destructor Destroy;override;
  end;

implementation



function GetApplicationPath:String;
begin
  {$IFDEF FPC}
      //LAZARUS
      //  Result:=ExtractFilePath(Application.ExeName);
        Result:=ExtractFilePath(GetModuleName(HInstance));
  {$ELSE}
      //DELPHI
      {$IFDEF FMX}
        Result:=System.IOUtils.TPath.GetDocumentsPath+PathDelim;
      {$ENDIF}

      {$IFDEF _MACOS}
      Result:=System.IOUtils.TPath.GetHomePath+PathDelim;
      {$ENDIF}

      {$IFDEF IOS}
      Result:=System.IOUtils.TPath.GetDocumentsPath+PathDelim;
      {$ENDIF}

      {$IFDEF Android}
      Result:=System.IOUtils.TPath.GetHomePath+PathDelim;
      {$ENDIF}


      {$IFDEF MSWINDOWS}
  //    Result:=System.IOUtils.TPath.GetLibraryPath;
      Result:=ExtractFilePath(GetModuleName(HInstance));
      {$ENDIF}


      {$IFDEF VCL}
    //  Result:=ExtractFilePath(Application.ExeName);
      Result:=ExtractFilePath(GetModuleName(HInstance));
      {$ENDIF}

      {$IFDEF LINUX}
    //  Result:=ExtractFilePath(Application.ExeName);
      Result:=ExtractFilePath(GetModuleName(HInstance));
      {$ENDIF}
  {$ENDIF}


end;


{ TBaseManager }


procedure TBaseManager.Load(AConfigFileName:String);
begin
//  Self.LoadFromINI(uFileCommon.GetApplicationPath+AConfigFileName);//'Config.ini');
  Self.LoadFromINI(GetApplicationPath+AConfigFileName);//'Config.ini');
end;

//procedure TBaseManager.SaveLastLoginInfo;
//begin
//  ForceDirectories(GetUserLocalDir);
//  SaveJsonToFile(Self.User.Json,GetUserLocalDir+'LastLoginInfo.json');
//end;

//procedure TBaseManager.SaveLastPosterInfo;
//begin
//
//end;

constructor TBaseManager.Create;
begin

  IsFirstStart:=True;

//
//  //授权中心的服务器,默认都是
//  CenterServerHost:='www.orangeui.cn';
//  CenterServerPort:=10020;


end;

function TBaseManager.CustomLoadFromINI(AIniFile: TIniFile): Boolean;
begin

end;

//procedure TBaseManager.CustomLoadFromUserConfigINI(AIniFile: TIniFile);
//begin
//
//end;

function TBaseManager.CustomSaveToINI(AIniFile: TIniFile): Boolean;
begin

end;

//procedure TBaseManager.CustomSaveToUserConfigINI(AIniFile: TIniFile);
//begin
//
//end;

destructor TBaseManager.Destroy;
begin
  inherited;
end;

//function TBaseManager.GetUserLocalDir: String;
//begin
//  //wn
////  Result:=uFileCommon.GetApplicationPath+IntToStr(Self.User.fid)+PathDelim;
////  Result:=uFileCommon.GetApplicationPath+Self.User.fid+PathDelim;
//end;

function TBaseManager.LoadFromINI(AINIFilePath: String): Boolean;
var
  AIniFile:TIniFile;
begin
//  Result:=False;

  AIniFile:=TIniFile.Create(AINIFilePath{$IFNDEF MSWINDOWS},TEncoding.UTF8{$ENDIF});

  //是否第一次启动
  Self.IsFirstStart:=AIniFile.ReadBool('','IsFirstStart',True);
  Self.IsShowedGuideFrame:=AIniFile.ReadBool('','IsShowedGuideFrame',False);

  //wn
  //上次登录的用户FID
//  Self.User.fid:=AIniFile.ReadInteger('','LastLoginUserFid',0);

//  {$IFDEF INT_USER_FID}
//  Self.User.fid:=AIniFile.ReadString('','LastLoginUserFid','0');
//  {$ELSE}
//  Self.User.fid:=AIniFile.ReadString('','LastLoginUserFid','');
//  {$ENDIF}



//  Self.LastFastMsgUserID:=AIniFile.ReadInteger('','LastFastMsgUserID',0);


  //上次登录的用户名密码验证码
  Self.LastLoginUser:=AIniFile.ReadString('','LastLoginUser','');
  Self.LastLoginPass:=AIniFile.ReadString('','LastLoginPass','');


  //用户登录key
  Self.LastLoginKey:=AIniFile.ReadString('','LastLoginKey','');

  //用户的登录状态
  Self.IsLogin:=AIniFile.ReadBool('','IsLogin',False);

  //公告
  Self.LastNonce:=AIniFile.ReadString('','LastNonce','');

  Self.ServerHost:=AIniFile.ReadString('','ServerHost',ServerHost);
  Self.ServerPort:=AIniFile.ReadInteger('','ServerPort',ServerPort);


//  LangKind:=TLangKind(AIniFile.ReadInteger('','LangKind',Ord(LangKind)));
//
//
//  //用户定位的经纬度
//  Self.Longitude:=AIniFile.ReadFloat('','Longitude',0);
//  Self.Latitude:=AIniFile.ReadFloat('','Latitude',0);
//  //地址
//  Self.Addr:=AIniFile.ReadString('','Addr',Self.Addr);
//  Self.Province:=AIniFile.ReadString('','Province',Self.Province);
//  Self.City:=AIniFile.ReadString('','City',Self.City);
//  Self.Area:=AIniFile.ReadString('','Area',Self.Area);
//  Self.RegionName:=AIniFile.ReadString('','RegionName',Self.RegionName);
//
//  //自动播放视频
//  Self.AutoPlayVideoOnWiFi:=AIniFile.ReadString('','AutoPlayVideoOnWiFi',Self.AutoPlayVideoOnWiFi);
//  Self.AutoPlayVideoWithoutWiFi:=AIniFile.ReadString('','AutoPlayVideoWithoutWiFi',Self.AutoPlayVideoWithoutWiFi);
//
//
//  Self.CompanyName:=AIniFile.ReadString('','CompanyName',Self.CompanyName);
//  Self.CompanyID:=AIniFile.ReadString('','CompanyID',Self.CompanyID);
//  if (AppID='') or GlobalIsNeedAPPIDSetting then
//  begin
//    AppID:=AIniFile.ReadString('','AppID',AppID);
//  end;

  ClickCloseButtonAction:=AIniFile.ReadString('','ClickCloseButtonAction', '');

  CustomLoadFromINI(AIniFile);


  SysUtils.FreeAndNil(AIniFile);

  Result:=True;

end;

//procedure TBaseManager.LoadUserConfig;
//var
//  AIniFile:TIniFile;
//begin
////  Result:=False;
//
//  AIniFile:=TIniFile.Create(GetUserLocalDir+'Config.ini'{$IFNDEF MSWINDOWS},TEncoding.UTF8{$ENDIF});
//  try
//    CustomLoadFromUserConfigINI(AIniFile);
//  finally
//    SysUtils.FreeAndNil(AIniFile);
//  end;
//
//
//
//  //最后一次登录的用户的部分信息
//  if FileExists(GetUserLocalDir+'LastLoginInfo.json') then
//  begin
//    LoadJsonFromFile(User.Json,GetUserLocalDir+'LastLoginInfo.json');
//    Self.User.ParseFromJson(User.Json);
////    TopRecentChatsJsonArrayStr:=User.Json.S['TopRecentChatsJsonArrayStr'];
//  end;
//
//end;
//
//procedure TBaseManager.Logout;
//begin
//  //登录状态为未登录
//  Self.IsLogin:=False;
//
//  //退出登录  清空密码
//  Self.LastLoginPass:='';
//  Self.User.Clear;//fid:='';
//  //保存INI
//  Self.Save;
//
//
//end;

function TBaseManager.SaveToINI(AINIFilePath: String): Boolean;
var
  AIniFile:TIniFile;
begin
//  Result:=False;
  AIniFile:=TIniFile.Create(AINIFilePath{$IFNDEF MSWINDOWS},TEncoding.UTF8{$ENDIF});

  //是否第一次启动
  AIniFile.WriteBool('','IsFirstStart',Self.IsFirstStart);
  AIniFile.WriteBool('','IsShowedGuideFrame',Self.IsShowedGuideFrame);

//  //wn
//  //上次登录的用户FID
////  AIniFile.WriteInteger('','LastLoginUserFid',Self.User.fid);
//  AIniFile.WriteString('','LastLoginUserFid',Self.User.fid);
////  AIniFile.WriteInteger('','LastFastMsgUserID',LastFastMsgUserID);



  //上次登录的用户名密码验证码
  AIniFile.WriteString('','LastLoginUser',Self.LastLoginUser);
  AIniFile.WriteString('','LastLoginPass',Self.LastLoginPass);

  //用户登录key,用
  AIniFile.WriteString('','LastLoginKey',Self.LastLoginKey);


  //广告
  AIniFile.WriteString('','LastNonce',Self.LastNonce);


  //用户的登录状态
  AIniFile.WriteBool('','IsLogin',Self.IsLogin);


  AIniFile.WriteString('','ServerHost',Self.ServerHost);
  AIniFile.WriteInteger('','ServerPort',Self.ServerPort);

//  AIniFile.WriteInteger('','LangKind',Ord(LangKind));
//
//
//  //用户选择的经纬度
//  AIniFile.WriteFloat('','Longitude',Self.Longitude);
//  AIniFile.WriteFloat('','Latitude',Self.Latitude);
//  //地址
//  AIniFile.WriteString('','Addr',Self.Addr);
//  AIniFile.WriteString('','Province',Self.Province);
//  AIniFile.WriteString('','City',Self.City);
//  AIniFile.WriteString('','Area',Self.Area);
//  AIniFile.WriteString('','RegionName',Self.RegionName);
//
//  //自动播放视频
//  AIniFile.WriteString('','AutoPlayVideoOnWiFi',Self.AutoPlayVideoOnWiFi);
//  AIniFile.WriteString('','AutoPlayVideoWithoutWiFi',Self.AutoPlayVideoWithoutWiFi);
//
//
//  //公司名称
//  AIniFile.WriteString('','CompanyName',Self.CompanyName);
//  AIniFile.WriteString('','CompanyID',Self.CompanyID);
//  AIniFile.WriteString('','AppID',AppID);
//
//  AIniFile.WriteString('','ClickCloseButtonAction',Self.ClickCloseButtonAction);

  CustomSaveToINI(AIniFile);


  SysUtils.FreeAndNil(AIniFile);
  Result:=True;

end;

procedure TBaseManager.Save(AConfigFileName:String);
begin
  Self.SaveToINI(GetApplicationPath+AConfigFileName);//'Config.ini');
end;

//procedure TBaseManager.SaveUserConfig;
//var
//  AIniFile:TIniFile;
//begin
//
//  ForceDirectories(GetUserLocalDir);
////  Result:=False;
//
//  AIniFile:=TIniFile.Create(GetUserLocalDir+'Config.ini'{$IFNDEF MSWINDOWS},TEncoding.UTF8{$ENDIF});
//  try
//    CustomSaveToUserConfigINI(AIniFile);
//  finally
//    SysUtils.FreeAndNil(AIniFile);
//  end;
//
//
//end;



end.
