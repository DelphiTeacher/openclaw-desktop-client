unit LocationFrame;

interface

uses
  System.SysUtils,uFuncCommon, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Platform,


  uBaseList,
  uBaseLog,

  HintFrame,
  uManager,

  WaitingFrame,
  MessageBoxFrame,

  uMapCommon,
  BaiduWebMapFrame,

  uFileCommon,
  uAndroidLog,
//  uManager,
  uTimerTask,
  uUIFunction,
  XSuperObject,
  XSuperJson,
  uGPSLocation,
  DateUtils,
  uBaseHttpControl,
  uMobileUtils,
  uGetDeviceInfo,
  EasyServiceCommonMaterialDataMoudle,

  uSkinFireMonkeyButton,
  uSkinFireMonkeyControl,
  uSkinFireMonkeyPanel,
  uSkinFireMonkeyImage,
  uSkinPageControlType, uSkinFireMonkeyPageControl,
  uSkinFireMonkeySwitchPageListPanel, FMX.Controls.Presentation, FMX.Edit,
  uSkinFireMonkeyEdit, uSkinFireMonkeyDirectUIParent,
  uSkinFireMonkeyScrollBoxContent, uSkinFireMonkeyScrollControl,
  uSkinFireMonkeyScrollBox, uSkinFireMonkeyLabel, FMX.ScrollBox, FMX.Memo,
  uSkinFireMonkeyMemo, System.Notification, FMX.Memo.Types, uSkinLabelType,
  uSkinScrollBoxContentType, uSkinScrollControlType, uSkinScrollBoxType,
  uSkinButtonType, uSkinPanelType, uSkinMaterial, uFrameContext;




type
//  TTestThread=class(TThread)
//  public
//    procedure Execute;override;
//    Constructor Create(CreateSuspended: Boolean);
//    destructor Destroy;override;
//  end;




  TFrameLocation = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    sbClient: TSkinFMXScrollBox;
    sbcContent: TSkinFMXScrollBoxContent;
    pnlDevide0: TSkinFMXPanel;
    pnlLongitude: TSkinFMXPanel;
    pnlLatitude: TSkinFMXPanel;
    lblLongitude: TSkinFMXLabel;
    lblLatitude: TSkinFMXLabel;
    pnlAddr: TSkinFMXPanel;
    lblAddr: TSkinFMXLabel;
    pnlDevide1: TSkinFMXPanel;
    tmrUpdateLocationUI: TTimer;
    tmrSyncLocationAndAddr: TTimer;
    pnlUploadLocation: TSkinFMXPanel;
    btnUploadLocation: TSkinFMXButton;
    btnHistroy: TSkinFMXButton;
    pnlMemo: TSkinFMXPanel;
    memMemo: TSkinFMXMemo;
    pnlIsAutoUploadLocation: TSkinFMXPanel;
    switchIsAutoUploadLocation: TSwitch;
    tmrStartLocation: TTimer;
    btnReturn: TSkinFMXButton;
    FrameContext1: TFrameContext;
    pnlMap: TSkinFMXPanel;
    procedure btnUploadLocationClick(Sender: TObject);
    procedure tmrUpdateLocationUITimer(Sender: TObject);
    procedure tmrSyncLocationAndAddrTimer(Sender: TObject);
    procedure btnHistroyClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure switchIsAutoUploadLocationSwitch(Sender: TObject);
    procedure tmrStartLocationTimer(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure FrameContext1CanReturn(Sender: TObject;
      var AIsCanReturn: TFrameReturnActionType);
    procedure sbClientResize(Sender: TObject);
  private
    FMemo:String;
    //上传定位
    procedure DoUploadLocationExecute(ATimerTask:TObject);
    procedure DoUploadLocationExecuteEnd(ATimerTask:TObject);
    { Private declarations }
  public
//    FrameHistroy:TFrameHistroy;
    FMapFrame:TFrameBaiduWebMap;

    FMyMapAnnotation: TMapAnnotation;

  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    FGPSLocationChangeLink:TSkinObjectChangeLink;
    FGPSAddrChangeLink:TSkinObjectChangeLink;
    procedure Load;
    procedure DoLocationChange(Sender:TObject);
    procedure DoAddrChange(Sender:TObject);
    { Public declarations }
  end;

var
  GlobalLocationFrame:TFrameLocation;



implementation

{$R *.fmx}

uses
  MainForm,
  MainFrame;



procedure TFrameLocation.DoAddrChange(Sender: TObject);
begin
  //地址改变事件,有可能在线程中
  TThread.Synchronize(nil,procedure
  begin
    Self.lblAddr.Caption:=GlobalGPSLocation.Addr;
  end);
end;

procedure TFrameLocation.DoLocationChange(Sender: TObject);
var
  AMapPolyline:TMapAnnotation;
//  AMyMapAnnotation:TMapAnnotation;
begin
  //坐标改变事件,有可能在线程中
  //更新界面上的坐标和地址
  //在一定的精度范围内,不需要重新获取地址
  if GlobalGPSLocation.HasLocated then
  begin
    Self.lblLongitude.Caption:=FloatToStr(GlobalGPSLocation.Longitude);
    Self.lblLatitude.Caption:=FloatToStr(GlobalGPSLocation.Latitude);
    Self.lblAddr.Caption:=GlobalGPSLocation.Addr;

    //获取地址
    GlobalGPSLocation.GeocodeAddr;

    TThread.Synchronize(nil,procedure
    begin

      if FMapFrame<>nil then
      begin

        // 绘制/更新 遮盖物位置
        if GlobalGPSLocation.HasLocated then
        begin
            uBaseLog.OutputDebugString('TFrameLocation.DoLoadMapFrame Located');

            if FMyMapAnnotation = nil then
            begin
              FMyMapAnnotation:=TMapAnnotation.Create;
              FMyMapAnnotation.Location.GPSType:=GlobalGPSLocation.Location.GPSType;//gtGCJ02;
              FMyMapAnnotation.Location.longitude:=GlobalGPSLocation.Longitude;
              FMyMapAnnotation.Location.latitude:=GlobalGPSLocation.Latitude;
              FMyMapAnnotation.Name:='我的位置';
              FMyMapAnnotation.User:='rider';

              FMapFrame.FMapAnnotationList.Add(FMyMapAnnotation);
            end
            else
            begin
              FMyMapAnnotation.Location.GPSType:=GlobalGPSLocation.Location.GPSType;
              FMyMapAnnotation.Location.longitude:=GlobalGPSLocation.Longitude;
              FMyMapAnnotation.Location.latitude:=GlobalGPSLocation.Latitude;
              FMyMapAnnotation.IsUpdatedMarkerToMap:= False;
            end;
        end
        else
        begin
            uBaseLog.OutputDebugString('TFrameLocation.DoLoadMapFrame Not Located');
        end;

        // 设置地图中心
        FMapFrame.Center.GPSType:=GlobalGPSLocation.Location.GPSType;
        FMapFrame.Center.longitude:=GlobalGPSLocation.Longitude;
        FMapFrame.Center.latitude:=GlobalGPSLocation.Latitude;

        //更新地图
        if GlobalApplicationState<>TApplicationEvent.EnteredBackground then
        begin
          FMapFrame.SyncCenter;
          FMapFrame.Sync;
        end;

      end;

    end);


    //定位到了就不需要更新了，或者几秒钟更新一次
    GlobalGPSLocation.StopLocation;


  end
  else
  begin
    //初始位置
    Self.lblLongitude.Caption:='';
    Self.lblLatitude.Caption:='';
    Self.lblAddr.Caption:='';
  end;

end;

procedure TFrameLocation.DoUploadLocationExecute(ATimerTask: TObject);
//var
//  AResultStream:TStringStream;
//  FParamsObject:ISuperObject;
begin
//  //出错
//  TTimerTask(ATimerTask).TaskTag:=1;
//
//  try
//
//
//    FParamsObject:=TSuperObject.Create;
//    FParamsObject.I['EmpID']:=GlobalManager.User.fid;
//    FParamsObject.F['Longitude']:=GlobalGPSLocation.Longitude;
//    FParamsObject.F['Latitude']:=GlobalGPSLocation.Latitude;
//    FParamsObject.S['GPSType']:=GPSTypeNames[GlobalGPSLocation.GPSType];
//    FParamsObject.S['Addr']:=GlobalGPSLocation.Addr;
//    FParamsObject.I['IsAuto']:=Ord(False);//手动
//    FParamsObject.S['ClientVersion']:=CurrentVersion;
//    FParamsObject.S['OS']:=GetOS;
//    FParamsObject.S['OSVersion']:=GetOSVersion;
//    FParamsObject.S['PhoneType']:=GetPhoneType;
//    FParamsObject.S['IMEI']:=GlobalManager.User.CurrentIMEI;
//    FParamsObject.S['Memo']:=FMemo;
//
//
//    //上传定位
//    AResultStream:=TStringStream.Create;
//    try
//
//      dmEmpLocationClient.kbmMWSimpleClient1.Connect;
//      dmEmpLocationClient.kbmMWSimpleClient1.Request('EmpLocation','1.0','UploadLocation',[FParamsObject.AsJson]);
//
//
//      AResultStream.CopyFrom(dmEmpLocationClient.kbmMWSimpleClient1.ResultStream,
//                              dmEmpLocationClient.kbmMWSimpleClient1.ResultStream.Size);
//
//      TTimerTask(ATimerTask).TaskDesc:=AResultStream.DataString;
//
//      TTimerTask(ATimerTask).TaskTag:=0;
//
//
//
//      //测试启动日志
//      DoRecordStartServerLog(GlobalGPSLocation,
//                              GlobalManager.User.FID);
//    except
//      on E:Exception do
//      begin
//        //异常
//        HandleException(E,'TFrameLocation.DoUploadLocationExecute');
//        TTimerTask(ATimerTask).TaskDesc:=E.Message;
//      end;
//    end;
//  finally
//    dmEmpLocationClient.kbmMWSimpleClient1.Disconnect;
//    AResultStream.Free;
//  end;
end;

procedure TFrameLocation.DoUploadLocationExecuteEnd(ATimerTask: TObject);
//var
//  ASuperObject:ISuperObject;
begin
//  try
//    if TTimerTask(ATimerTask).TaskTag=0 then
//    begin
//
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin
//
//        //上传位置成功
//        //提示上传成功
//
//        Self.memMemo.Text:='';
//
//        ShowHintFrame(frmMain,UploadLocationCaption+'成功!');
//
//
//      end
//      else
//      begin
//        //上传位置失败
//        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;
//
//    end
//    else if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
//    end;
//  finally
//    HideWaitingFrame;
//  end;
end;

procedure TFrameLocation.FrameContext1CanReturn(Sender: TObject;
  var AIsCanReturn: TFrameReturnActionType);
begin
  //
  GlobalGPSLocation.StopLocation;

end;

procedure TFrameLocation.Load;
begin

//  Self.btnHistroy.Visible:=
//    //管理员
//    (GlobalManager.User.is_emp=1)
////    False;
////    or   (GlobalManager.User.Phone='18957901025')
////    or (GlobalManager.User.Phone='15216873386')
////    or (GlobalManager.User.Phone='18006890741')
//    or (GlobalManager.User.Phone='18991896618')
//    or (GlobalManager.User.Phone='18066966300');
//
//
//
//  if Not HasAutoUploadLocationFunction then
//  begin
//    //没有自动签到功能
//    pnlIsAutoUploadLocation.Visible:=False;
//
//    //禁止自动发送定位
//    GlobalManager.User.IsAutoUploadLocation:=False;
//
//    GlobalManager.User.Save(uFileCommon.GetApplicationPath);
//  end
//  else
//  begin
//    pnlIsAutoUploadLocation.Visible:=True;
//  end;



//  Self.btnTest.Visible:=
//    False;
//       (GlobalManager.User.Phone='18957901025')
//    or (GlobalManager.User.Phone='18006890741')
//    or (GlobalManager.User.Phone='18991896618')
//    or (GlobalManager.User.Phone='18066966300')
//    ;

//  Self.btnTest.Visible:=Self.btnHistroy.Visible;


  tmrStartLocation.Enabled:=True;

  //----------------------------------------------------------------------------

  //创建百度地图网页
  if FMapFrame = nil then
    FMapFrame:=TFrameBaiduWebMap.Create(Self);

  //不显示工具栏
  FMapFrame.pnlToolBar.Visible:=False;

  //启用缓存图模式来显示地图
  FMapFrame.ProcessNativeControlModalShowPanel1.IsEnableModalShow:=True;
  // FMapFrame.ProcessNativeControlModalShowPanel1.BeginModalShow;

  //要显示一下,ReturnFrame的时候会被隐藏
  FMapFrame.Visible:=True;
  FMapFrame.Parent:=Self.pnlMap;
  FMapFrame.Align:=TAlignLayout.Client;
  //FMapFrame.Height:= 300;

  //不需要鱼骨控件和地图类型切换控件
  FMapFrame.IsNeedMapControl:=False;

  //  //设置事件
  //  FMapFrame.OnClickMapScreenshot:=DoMapFrameClickMapScreenshot;
  FMapFrame.OnReturnButtonClick:=nil;
  FMapFrame.OnSetPoint:=nil;

  //  DoLoadMapFrame(FMapFrame);

  //地图的缩放级别
  FMapFrame.ZoomLevel:=18;

  //显示模式
  FMapFrame.ViewMode:=mfvmView;

  //清空一下
  FMapFrame.FMapAnnotationList.Clear(True);
  FMapFrame.FMapPolylineList.Clear(True);

  //中心点
  FMapFrame.Center:=CalcAnnotationListCenter(FMapFrame.FMapAnnotationList);

  FMapFrame.Load;//Sync;

  uBaseLog.OutputDebugString('TFrameLocation.DoLoadMapFrame End');

  //GlobalGPSLocation.FSkinObjectChangeManager.RegisterChanges('LocationChange',DoGPSLocationChange);
  FGPSLocationChangeLink:=TSkinObjectChangeLink.Create;
  FGPSLocationChangeLink.FName:='LocationChange';
  FGPSLocationChangeLink.OnChange:=Self.DoLocationChange;;
  GlobalGPSLocation.FSkinObjectChangeManager.RegisterChanges(FGPSLocationChangeLink);
  //  //位置改变
  //  GlobalGPSLocation.OnLocationChange:=DoGPSLocationChange;


//  Self.pnlMap.Height:= Self.sbcContent.Height
//                     - Self.pnlLongitude.Height
//                     - Self.pnlLatitude.Height
//                     - Self.pnlAddr.Height
//                     - Self.pnlMemo.Height
//                     - Self.pnlUploadLocation.Height;
//  FMapFrame.Position.Y:=Self.lvGroupByTypes.Position.Y+FMapFrame.Height;
//  Self.sbcContent.Height:=GetSuitScrollContentHeight(sbcContent);

end;

procedure TFrameLocation.sbClientResize(Sender: TObject);
begin
  Self.sbcContent.Height:= Self.sbClient.Height;
end;

procedure TFrameLocation.switchIsAutoUploadLocationSwitch(Sender: TObject);
begin
//  if switchIsAutoUploadLocation.IsChecked then
//  begin
//    ShowHintFrame(frmMain,'当前设置为自动'+UploadLocationCaption);
////    ShowHintFrame('自动上传定位服务已启动');
//  end
//  else
//  begin
//    ShowHintFrame(frmMain,'当前设置为不自动'+UploadLocationCaption);
//  end;
//
//
//  //自动发送定位
//  GlobalManager.User.IsAutoUploadLocation:=Self.switchIsAutoUploadLocation.IsChecked;
//
//  GlobalManager.User.Save(uFileCommon.GetApplicationPath);


end;

procedure TFrameLocation.btnReturnClick(Sender: TObject);
begin
  FreeAndNil(FMapFrame);
  FMyMapAnnotation:= nil;

  HideFrame;
  ReturnFrame;
end;

procedure TFrameLocation.btnTestClick(Sender: TObject);
//var
//  I: Integer;
begin

//  //隐藏
//  HideFrame(GlobalMainFrame,hfcttBeforeShowFrame);
//
//  //查看员工签到
//  ShowFrame(TFrame(GlobalViewEmpLocationHistroyFrame),TFrameViewEmpLocationHistroy,frmMain,nil,nil,nil,Application);
//  GlobalViewEmpLocationHistroyFrame.FrameHistroy:=CurrentFrameHistroy;
//
//  GlobalViewEmpLocationHistroyFrame.Load;



  //并发测试
//  Self.btnTest.Caption:=Self.btnTest.Caption+' 开';
//
//  {$IFDEF MSWINDOWS}
//  for I := 0 to 20-1 do
//  {$ELSE}
//  for I := 0 to 10-1 do
//  {$ENDIF}
//  begin
//    TTestThread.Create(False);
//  end;

end;

procedure TFrameLocation.tmrStartLocationTimer(Sender: TObject);
begin
  tmrStartLocation.Enabled:=False;
  frmMain.StartGPSLocation;
end;

procedure TFrameLocation.tmrSyncLocationAndAddrTimer(Sender: TObject);
begin
//  //更新定位(IOS)
//  GlobalGPSLocation.SyncLocation;
end;

procedure TFrameLocation.tmrUpdateLocationUITimer(Sender: TObject);
begin

//  //更新界面上的坐标和地址
//  if GlobalGPSLocation.HasLocated then
//  begin
//    Self.lblLongitude.Caption:=FloatToStr(GlobalGPSLocation.Longitude);
//    Self.lblLatitude.Caption:=FloatToStr(GlobalGPSLocation.Latitude);
//    Self.lblAddr.Caption:=GlobalGPSLocation.Addr;
//  end
//  else
//  begin
//    //初始位置
//    Self.lblLongitude.Caption:='';
//    Self.lblLatitude.Caption:='';
//    Self.lblAddr.Caption:='';
//  end;

end;

procedure TFrameLocation.btnHistroyClick(Sender: TObject);
begin
//  //隐藏
//  HideFrame(GlobalMainFrame,hfcttBeforeShowFrame);
//
//  //签到历史
//  ShowFrame(TFrame(GlobalLocationHistroyFrame),TFrameLocationHistroy,frmMain,nil,nil,nil,Application);
//  GlobalLocationHistroyFrame.FrameHistroy:=CurrentFrameHistroy;
//
//  GlobalLocationHistroyFrame.pnlToolBar.Visible:=True;
//  GlobalLocationHistroyFrame.Load(GlobalManager.User.FID,Now,Now);

end;

procedure TFrameLocation.btnUploadLocationClick(Sender: TObject);
begin

  //是否打开GPS


//  if Not GlobalGPSLocation.HasLocated then
//  begin
//    ShowMessageBoxFrame(Self,'没有获取到您当前的位置!','',TMsgDlgType.mtInformation,['确定'],nil);
//    Exit;
//  end;
//
//  if Self.btnUploadLocation.CanFocus then
//  begin
//    Self.btnUploadLocation.SetFocus;
//  end;
//
//  FMemo:=Self.memMemo.Text;
//
//  //上传定位
//  ShowWaitingFrame(Self,'正在'+UploadLocationCaption+'...');
//  //上传定位
//  uTimerTask.GetGlobalTimerThread.RunTempTask(
//                                              DoUploadLocationExecute,
//                                              DoUploadLocationExecuteEnd
//                                              );



end;

constructor TFrameLocation.Create(AOwner: TComponent);
begin
  inherited;


//  //自动发送定位
//  switchIsAutoUploadLocation.OnSwitch:=nil;
//  Self.switchIsAutoUploadLocation.IsChecked:=GlobalManager.User.IsAutoUploadLocation;
//  switchIsAutoUploadLocation.OnSwitch:=Self.switchIsAutoUploadLocationSwitch;
//
//
//  Self.btnUploadLocation.Caption:=UploadLocationCaption;


  //初始位置
  Self.lblLongitude.Caption:='';
  Self.lblLatitude.Caption:='';
  Self.lblAddr.Caption:='';
  Self.memMemo.Text:='';


//  //先隐藏
//  Self.btnTest.Visible:=False;
//  Self.btnHistroy.Visible:=False;



  if FGPSLocationChangeLink=nil then
  begin
    FGPSLocationChangeLink:=TSkinObjectChangeLink.Create;
    FGPSLocationChangeLink.FName:='LocationChange';
    FGPSLocationChangeLink.OnChange:=Self.DoLocationChange;
  end;
  GlobalGPSLocation.FSkinObjectChangeManager.RegisterChanges(FGPSLocationChangeLink);

  if FGPSAddrChangeLink=nil then
  begin
    FGPSAddrChangeLink:=TSkinObjectChangeLink.Create;
    FGPSAddrChangeLink.FName:='AddrChange';
    FGPSAddrChangeLink.OnChange:=Self.DoAddrChange;
  end;
  GlobalGPSLocation.FSkinObjectChangeManager.RegisterChanges(FGPSAddrChangeLink);


end;

destructor TFrameLocation.Destroy;
begin

  //结束Android服务之前 ，先取消回调，不然会闪退
  if GlobalGPSLocation<>nil then
  begin
    GlobalGPSLocation.FSkinObjectChangeManager.UnRegisterChanges(FGPSLocationChangeLink);
  end;

  if GlobalGPSLocation<>nil then
  begin
    GlobalGPSLocation.FSkinObjectChangeManager.UnRegisterChanges(FGPSAddrChangeLink);
  end;


  inherited;
end;



//
//{ TTestThread }
//
//constructor TTestThread.Create(CreateSuspended: Boolean);
//begin
//  Inherited Create(CreateSuspended);
//
//
////  FParamsObject:=TSuperObject.Create;
////  //测试
////  FParamsObject.I['EmpID']:=0;
////  FParamsObject.F['Longitude']:=GlobalGPSLocation.Longitude;
////  FParamsObject.F['Latitude']:=GlobalGPSLocation.Latitude;
////  FParamsObject.S['GPSType']:=GPSTypeNames[GlobalGPSLocation.GPSType];
////  FParamsObject.S['Addr']:=GlobalGPSLocation.Addr;
////  FParamsObject.I['IsAuto']:=Ord(False);//手动
////  FParamsObject.S['ClientVersion']:=CurrentVersion;
////  FParamsObject.S['OS']:=GetOS;
////  FParamsObject.S['OSVersion']:=GetOSVersion;
////  FParamsObject.S['PhoneType']:=GetPhoneType;
////  FParamsObject.S['IMEI']:=GlobalManager.User.CurrentIMEI;
////  FParamsObject.S['Memo']:='测试';
////
////  FParamsObjectJsonStr:=FParamsObject.AsJSON;
////
////  FdmEmpLocationClient:=TdmEmpLocationClient.Create(nil);
////  FdmEmpLocationClient.kbmMWSimpleClient1.OnClientTransmit:=nil;
////  FdmEmpLocationClient.kbmMWSimpleClient1.OnClientReceive:=nil;
////  frmMain.SyncServerSetting(FdmEmpLocationClient,GlobalManager.ServerHost,GlobalManager.ServerPort);
//end;
//
//destructor TTestThread.Destroy;
//begin
//
//  inherited;
//end;
//
//procedure TTestThread.Execute;
//begin
//  while not Self.Terminated do
//  begin
//
//      //上传定位测试
//
//      //上传定位
//      try
//        Sleep(500);
//
//
//        DoAutoUploadLocation(GlobalGPSLocation,0,'Test',False);
//
//
//        uAndroidLog.HandleException(nil,'TFrameLocation.DoUploadLocationExecute');
//      except
//        on E:Exception do
//        begin
//          //异常
//          uAndroidLog.HandleException(E,'TFrameLocation.DoUploadLocationExecute');
//        end;
//      end;
//  end;
//
//end;



end.

