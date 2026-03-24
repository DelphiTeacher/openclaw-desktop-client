//convert pas to utf8 by ¥
unit MainFrame;

interface



uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uComponentType,
  uFuncCommon,
  uUIFunction,
  uDataSetToJson,

  Math,
  DateUtils,
//  uGPSLocation,
  uBaseLog,
  uDataInterface,
  uFMXSVGSupport,
//  uBaiduOCR,
//  uHttpBaiduOCR,
  uFrameContext,
  uManager,
  uTimerTask,
  HintFrame,
  uGetDeviceInfo,
  uOpenCommon,
  uOpenClientCommon,
  uBasePageStructure,
  uFileCommon,
//  ClientModuleUnit1,
  uRestInterfaceCall,
  WaitingFrame,
  MessageBoxFrame,
  ConfigFrame,
//  SettingFrame,
//  WorkBenchFrame,
//  ConsoleFrame,
//  ReportMenuFrame,
//  HomeFrame,


  uConst,
  HZSpell,
  uAppCommon,
//  uVirtualListDataController,

  FMX.Platform,

  XSuperObject,
  XSuperJson,
  uOpenClawHelper,

  uBaseList,
  uSkinItems,
  uSkinListBoxType,
  uSkinListViewType,
  uServiceManage,

//  RepairCarOrderListFrame,
//  ProcessTaskManageFrame,
//  MyFrame,
//  SideMenuFrame,
//  uPageFramework,
//  uReportPage,
//  uPageStructure,
//  uBasePageFrame,
//  BaseReportFrame,
//  SetRolePowerFrame,
//  BillListFrame,
  AIChatFrame,
//  ConfigAIListFrame,
  ServiceManageFrame,
  Winapi.ShellApi,
  Winapi.WIndows,
  InstallDaemonFrame,

  System.RegularExpressions,
  System.RegularExpressionsCore,

//  CarRepairCommonMaterialDataMoudle,
//  CC.BaiduOCR,

//  {$IFDEF HAS_FASTMSG}
//  FastMsg.Client.BindingEvents,
//  FastMsg.Client.Paths,
//  FastMsg.Client,
//  FastMsg.Client.ChatContent,
////  FastMsg.Client.CommonClass,
//  {$ENDIF}


  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, uSkinFireMonkeyButton, uSkinFireMonkeyLabel,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyVirtualList,
  uSkinFireMonkeyListBox, uSkinFireMonkeyControl,
  uSkinFireMonkeyItemDesignerPanel, uSkinFireMonkeyListView,
  uSkinFireMonkeyImage, uSkinFireMonkeyPanel, uSkinFireMonkeyMultiColorLabel,
  FMX.Edit, uSkinFireMonkeyEdit, uSkinFireMonkeyNotifyNumberIcon,
  uSkinFireMonkeyCheckBox, uSkinMaterial, uSkinButtonType,
  uSkinFireMonkeyCustomList, uSkinNotifyNumberIconType, uSkinCheckBoxType,
  uSkinMultiColorLabelType, uSkinImageType, uSkinLabelType,
  uSkinItemDesignerPanelType, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinPanelType, uSkinPageControlType,
  uSkinSwitchPageListPanelType, uSkinFireMonkeyPageControl,
  uSkinScrollBoxContentType, uSkinFireMonkeyScrollBoxContent,
  uSkinScrollBoxType, uSkinFireMonkeyScrollBox, FMX.ScrollBox, FMX.Memo,
  uSkinFireMonkeyMemo, uSkinImageListViewerType, uSkinFireMonkeyImageListViewer,
  uDrawPicture, uSkinImageList, uTimerTaskEvent, System.ImageList, FMX.ImgList,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.MediaLibrary.Actions, System.Actions,
  FMX.ActnList, FMX.StdActns, uDrawCanvas, FMX.MultiView;

type
  TFrameMain = class(TFrame)
    tteGetBasicData: TTimerTaskEvent;
    pcMain: TSkinFMXPageControl;
    tsMy: TSkinFMXTabSheet;
    tsReport: TSkinFMXTabSheet;
    tsHome: TSkinTabSheet;
    tsConfig: TSkinTabSheet;
    tmrCheckService: TTimer;
    procedure lbHomeClickItem(AItem: TSkinItem);
    procedure btnQuickClick(Sender: TObject);
    procedure edtFilterClick(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure tteGetBasicDataExecute(ATimerTask: TTimerTask);
    procedure tteGetBasicDataExecuteEnd(ATimerTask: TTimerTask);
    procedure tteGetBasicDataBegin(ATimerTask: TTimerTask);
    procedure tmrSyncDataTimer(Sender: TObject);
    procedure tteSyncDataExecute(ATimerTask: TTimerTask);
//    procedure CCBaiduOCR1InitAccessTokenWithAkSkResult(Sender: TObject;
//      AErrorCode: Integer; AErrorMsg, AToken: string);
//    procedure CCBaiduOCR1RecognizeResult(Sender: TObject;
//      AOCRType: TCCBaiduOCRType; AErrorCode: Integer; AErrorMsg, AFilePath,
//      AJosonResult: string; AIDCardInfo: TCCIDCardInfo;
//      ABankCardInfo: TCCBankCardInfo);
    procedure btnScanClick(Sender: TObject);
//    procedure tteGetCarInfoBegin(ATimerTask: TTimerTask);
//    procedure tteGetCarInfoExecute(ATimerTask: TTimerTask);
//    procedure tteGetCarInfoExecuteEnd(ATimerTask: TTimerTask);
    procedure ActionTakePhotoFromCameraDidFinishTaking(Image: TBitmap);
    procedure tmrCheckServiceTimer(Sender: TObject);
//  private
//    {$IFDEF IOS}
//    FBaiduOCR:TBaiduOCR;
//    {$ENDIF}
//    procedure DoBaiduOCRScanCarPlateNumberSucc(Sender:TObject);
//    procedure DoBaiduOCRDetectFail(Sender:TObject);
  private
//    CCBaiduOCR1: TCCBaiduOCR;
    //  object CCBaiduOCR1: TCCBaiduOCR
    //    OnInitAccessTokenWithAkSkResult = CCBaiduOCR1InitAccessTokenWithAkSkResult
    //    OnRecognizeResult = CCBaiduOCR1RecognizeResult
    //    Left = 575
    //    Top = 88
    //  end

  //    FHttpBaiduOCR:THttpBaiduOCR;
  private
//    MultiView1:TMultiView;
//    //侧边栏
//    FSideMenuFrame:TFrameSideMenu;
  private

    FScanedCarPlate:String;


//    procedure FindCarPlate(AResultString:String);

    //快速接车,选择车辆信息后返回
    procedure DoReturnFrameFromSelectCarInfoFrame(AFrame:TFrame);
    procedure DoReturnFrameFromInstallDaemonFrame(AFrame:TFrame);
    { Private declarations }
  public

//    procedure ShowSideMenuFrame(AParent:TFmxObject);

    procedure ProcessGetNotice(ANotice:TNotice;ASuperObject:ISuperObject);

    procedure PorcessGetUserNoticeUnReadCount(ANoticeUnReadCount:Integer);

  public
    {$IFDEF HAS_FASTMSG}
    procedure OnAddRecentItem(ABindingEvent: TBindingEvent);
    procedure LoadContactsListFrame;
    procedure SyncRecentContactFrameCaption(ARecentContactCaption:String='最近会话');
    procedure LoadRecentContactFrame;
    {$ENDIF}
  public
    //获取并刷新未读消息数
    function SyncUnReadMsgCount:Integer;

  public
    procedure Login(AIsOnlineLogin:Boolean);
    procedure Logout;
  public
//    FrameHistroy:TFrameHistroy;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    //点击推送后触发的事件
    procedure ClickPushNotification(AUserCustomJson:ISuperObject;
                                      ATitle:String;
                                      ABody:String;
//                                      AOS:String;
                                      AIsAtBackground:Boolean);
  public
//    FProcessTaskManageFrame:TFrameProcessTaskManage;
    FAIChatFrame:TFrameAIChat;
    FConfigFrame:TFrameConfig;
//    FConfigAIListFrame:TFrameConfigAIList;
//    FServiceManageFrame:TFrameServiceManage;

//    FHomeFrame:TFrameHome;
//    FMailListFrame: TFrameBillList;
//    //工作台
//    FWorkBenchFrame:TFrameWorkBench;
//
//    //分析报表
//    FReportMenuFrame:TFrameReportMenu;
//
////    FRepairCarOrderListFrame:TFrameRepairCarOrderList;
//    FMyFrame:TFrameMy;
//    //根据不同通知跳转详情界面
//    procedure GetNoticeInfo(Frame:TFrame;ANotice:TNotice);
//  public
//    //为选择维修配件获取数据
//    procedure DoGetDataForSelectMaterialPopupMenuFrame(ATimerTask: TTimerTask);
//    //为选择维修项目获取数据
//    procedure DoGetDataForSelectItemPopupMenuFrame(ATimerTask: TTimerTask);
  public

    //开始定位
    procedure DoStartLocation;
    //定位改变
    procedure DoLocationChange;
    //定位超时
    procedure DoLocationTimeout;
    //定位启动失败
    procedure DoLocationStartError;

    //地址改变
    procedure DoLocationAddrChange;
    //地址解析失败了
    procedure DoGeocodeAddrError;
    //地址解析超时了
    procedure DoGeocodeAddrTimeout;
    { Public declarations }
  end;



var
  GlobalMainFrame:TFrameMain;



implementation



uses
//  ScanInStoreFrame,
  MainForm//,
//  AddCarInfoFrame,
//  CarInfoListFrame,
//  WorkStationStatusFrame,
//  DispatchWorkFrame,
//  WaitDispatchOrderListFrame,
//  AddCarRepairOrderFrame
  ;

{$R *.fmx}

procedure TFrameMain.ActionTakePhotoFromCameraDidFinishTaking(Image: TBitmap);
var
  AFilePath:String;
  ABitmapCodecSaveParams:TBitmapCodecSaveParams;
begin
  AFilePath:=GetApplicationPath+FormatDateTime('YYYY-MM-DD HH:MM:SS',Now)+'.png';
  ABitmapCodecSaveParams.Quality:=70;
  Image.SaveToFile(AFilePath);




//  TThread.CreateAnonymousThread(procedure
//  begin
//
//      TThread.Synchronize(nil,procedure
//      begin
//        ShowWaitingFrame(Self,'识别中...');
//      end);
//
//
//      if not FHttpBaiduOCR.CarLicensePlate(AFilePath,FScanedCarPlate) then
//      begin
//          TThread.Synchronize(nil,procedure
//          begin
//            ShowMessage('扫描不到车牌号!');
//          end);
//
//          Exit;
//      end;
//
//
//      TThread.Synchronize(nil,procedure
//      begin
//       HideWaitingFrame;
//      end);
//
//
//      TThread.Synchronize(nil,procedure
//      begin
//        //ShowMessage(ACarPlate);
//        ShowHintFrame(Self,'扫描到车牌'+FScanedCarPlate);
//        //判断是否存在该车辆信息
//        Self.tteGetCarInfo.Run;
//      end);
//
//
//  end).Start;
end;

procedure TFrameMain.btnQuickClick(Sender: TObject);
//var
//  AFramePopupStyle:TFramePopupStyle;
begin
//  //显示车辆列表
//  HideFrame(Self);
//  AFramePopupStyle.PopupWidth:=640;
//  AFramePopupStyle.PopupHeight:=frmMain.ClientHeight-80;
//  ShowFrame(TFrame(GlobalCarInfoListFrame),TFrameCarInfoList,frmMain,nil,nil,nil,
//              nil,True,True,
////              TUseFrameSwitchEffectType.ufsefDefault,
//              TUseFrameSwitchEffectType.ufsefNone,
//              //使用弹出风格
//              False,//True,
//              @AFramePopupStyle);
//  //清空搜索
//  GlobalCarInfoListFrame.edtFilter.Text:='';
//  GlobalCarInfoListFrame.Load(futManage);
end;

procedure TFrameMain.btnScanClick(Sender: TObject);
//  {$IFDEF MSWINDOWS}
//var
//  AFilePath:String;
//  OpenDialog: TOpenDialog;
//  {$ENDIF MSWINDOWS}
begin
  {$IFDEF ANDROID}
//  CCBaiduOCR1.ocr_license_plate;
  {$ENDIF ANDROID}



  {$IFDEF IOS}
//  //拍照
//  Self.ActionTakePhotoFromCamera.MaxHeight:=800;
//  Self.ActionTakePhotoFromCamera.MaxWidth:=800;
//  Self.ActionTakePhotoFromCamera.ExecuteTarget(nil);
  {$ENDIF IOS}



  {$IFDEF MSWINDOWS}

//  FScanedCarPlate:='浙G0P716';
//  //判断是否存在该车辆信息
//  Self.tteGetCarInfo.Run;



//  AFilePath:='';
//
//  //选择文件
//  OpenDialog := TOpenDialog.Create(nil);
//  try
//    OpenDialog.Filter := TBitmapCodecManager.GetFilterString;
//    OpenDialog.Options:=OpenDialog.Options+[TOpenOption.ofAllowMultiSelect];
//    if OpenDialog.Execute then
//    begin
//
//        AFilePath:=OpenDialog.FileName
//
//    end;
//  finally
//    uFuncCommon.FreeAndNil(OpenDialog);
//  end;
//
//  if AFilePath<>'' then
//  begin
//
//        TThread.CreateAnonymousThread(procedure
//        begin
//            if not FHttpBaiduOCR.CarLicensePlate(AFilePath,FScanedCarPlate) then
//            begin
//                TThread.Synchronize(nil,procedure
//                begin
//                  ShowMessage('扫描不到车牌号!');
//                end);
//
//                Exit;
//            end;
//
//
//
//            TThread.Synchronize(nil,procedure
//            begin
//              //ShowMessage(ACarPlate);
//              ShowHintFrame(Self,'扫描到车牌'+FScanedCarPlate);
//              //判断是否存在该车辆信息
//              Self.tteGetCarInfo.Run;
//            end);
//
//
//        end).Start;
//
//
//  end;

  {$ENDIF IOS}


//  {$IFDEF IOS}
//
////  Self.FBaiduOCR.ScanCarPlateNumber;
//  {$ENDIF}

////  FindCarPlate('测试测试浙G0P716测试测试你能不能找的到');
//  //测试
//  AJosonResult:='{"log_id": 430470497296450702,'
//                      +'"words_result": { '
////                      +'"number": "浙G32104" '//存在的车辆
//                      +'"number": "浙G32103" '  //不存在的车辆
//                      +'}'
//                +'}';
//  CCBaiduOCR1RecognizeResult(nil,CCBaiduOCRType_LicensePlate,0,'','',AJosonResult,AIDCardInfo,ABankCardInfo);
end;

//procedure TFrameMain.CCBaiduOCR1InitAccessTokenWithAkSkResult(Sender: TObject;
//  AErrorCode: Integer; AErrorMsg, AToken: string);
//begin
//  {$IFDEF ANDROID}
//  if AErrorCode<>0 then
//  begin
//    ShowMessage('获取Token失败！- '+AErrorMsg);
//  end;
//  {$ENDIF ANDROID}
//end;

//procedure TFrameMain.CCBaiduOCR1RecognizeResult(Sender: TObject;
//  AOCRType: TCCBaiduOCRType; AErrorCode: Integer; AErrorMsg, AFilePath,
//  AJosonResult: string; AIDCardInfo: TCCIDCardInfo;
//  ABankCardInfo: TCCBankCardInfo);
//var
//  ASuperObject:ISuperObject;
//begin
////  FMX.Types.Log.d('OrangeUI '+AJosonResult);
////
//////识别结果
//////{"log_id": 430470497296450702,
//////"words_result": {
//////    "color": "blue",
//////    "number": "鑻廍730V7",
//////    "probability": [1.0, 0.9998598098754883, 0.9999668598175049, 0.9998667240142822, 0.9999775886535645, 0.9999877214431763, 0.9992883801460266],
//////"vertexes_location": [{"x": 229}, {"y": 177, "x": 575}, {"y": 290, "x": 593}, {"y": 400, "x": 248}]}}
////
////  ASuperObject:=TSuperObject.Create(AJosonResult);
//////  for I := 0 to ASuperObject.I['words_result_num']-1 do
//////  begin
//////    //有些地区的车牌号中间有个点
//////    AResultString:=AResultString+ASuperObject.A['words_result'].O[I].S['words'].Replace('·','');
//////  end;
////
////  if ASuperObject.Contains('words_result')
////    and ASuperObject.O['words_result'].Contains('number') then
////  begin
////      FScanedCarPlate:=ASuperObject.O['words_result'].S['number'];
////      ShowHintFrame(Self,'扫描到车牌'+ASuperObject.O['words_result'].S['number']);
//////      Self.btnQuickClick(Self);
//////      GlobalCarInfoListFrame.edtFilter.Text:=ASuperObject.O['words_result'].S['number'];
//////      GlobalCarInfoListFrame.Load(futManage);
////      //判断是否存在该车辆信息
////      Self.tteGetCarInfo.Run;
////  end
////  else
////  begin
////      ShowHintFrame(Self,'扫描不到车牌!');
////  end;
//
//end;

constructor TFrameMain.Create(AOwner: TComponent);
begin
  inherited;

//  if Not IsPadDevice then
//  begin
//    Self.edtFilter.Properties.HelpText:='车牌号/手机号/姓名';
//  end
//  else
//  begin
//    Self.edtFilter.Properties.HelpText:='请输入车牌号、手机号、姓名进行搜索';
//  end;

//  {$IFDEF IOS}
//  Self.btnScan.Visible:=False;
//  {$ENDIF}


//  {$IFDEF ANDROID}
//  //ak sk 与包名要对应
//  Self.CCBaiduOCR1.initAccessTokenWithAkSk(
//    'h8UfG0c8UcP9mXt9MwwUqaj5',
//    'f2OaOst8hbQuGXakbWnZVfR9GlCwbdy5');
//  {$ENDIF}
//
//
//  FHttpBaiduOCR:=THttpBaiduOCR.Create;


//  {$IFDEF IOS}
//  FBaiduOCR:=TBaiduOCR.Create;
//  FBaiduOCR.OnScanCarPlateNumberSucc:=Self.DoBaiduOCRScanCarPlateNumberSucc;
//  FBaiduOCR.OnDetectFail:=Self.DoBaiduOCRDetectFail;
//  FBaiduOCR.Init('guSiGoWBXWtog50gTP5ZGaHv','Lima7CugnPNFQNMdlHIndGGf4ol6OE2I');
//  {$ENDIF}


  //Self.pcMain.Prop.Orientation:=toNone;
  Self.pcMain.Prop.IsAfterPaintTabIcon:=True;



end;

destructor TFrameMain.Destroy;
begin
//  {$IFDEF IOS}
//  FreeAndNil(FBaiduOCR);
//  {$ENDIF}

//  FreeAndNil(FHttpBaiduOCR);

  inherited;
end;

//procedure TFrameMain.DoClickItemInSelectWaitDispatchOrderListFrame(
//  AItem: TSkinItem);
//var
//  AWaitPostRepairCarOrder:ISuperObject;
//begin
//  AWaitPostRepairCarOrder:=TSuperObject.Create(AItem.DataJsonStr);
//
//
//  //在待派工单列表中选择某一单
//  HideFrame(CurrentFrame);
//  ShowFrame(TFrame(GlobalDispatchWorkFrame),TFrameDispatchWork);
//  GlobalDispatchWorkFrame.Clear;
//  GlobalDispatchWorkFrame.Load(AWaitPostRepairCarOrder);
//end;


procedure TFrameMain.ClickPushNotification(AUserCustomJson:ISuperObject;
                                          ATitle:String;
                                          ABody:String;
//                                          AOS:String;
                                          AIsAtBackground:Boolean);
begin
  ShowMessage('您收到一条通知!'+#13#10
        +'ATitle:'+ABody+#13#10
        +'ABody:'+ABody+#13#10
        +'AUserCustomJson:'+AUserCustomJson.AsJSON+#13#10
        );
//  if (AOS='IOS') and Not AIsAtBackground then
//  begin
//      //在前台收到的消息
//      //弹出对话框
//      //播放声音
//      ShowMessage('您收到一条通知!'+#13#10
//            +'('+ABody+')'
//            );
//  end
//  else
//  begin
//      //点击在后台收到的消息
//
//
//  end;
end;

//procedure TFrameMain.GetNoticeInfo(Frame: TFrame; ANotice: TNotice);
//begin
//  ShowWaitingFrame(Frame,'加载中...');
////  FNoticeFID:=ANotice.fid;
////  FNotice:=ANotice;
////  uTimerTask.GetGlobalTimerThread.RunTempTask(
////                                              DoGetNoticeExecute,
////                                              DoGetNoticeExecuteEnd);
//end;

//procedure TFrameMain.DoBaiduOCRDetectFail(Sender: TObject);
//begin
//  {$IFDEF IOS}
//  ShowHintFrame(nil,Self.FBaiduOCR.ErrorDesc);
//  {$ENDIF IOS}
//end;

procedure TFrameMain.DoGeocodeAddrError;
begin

end;

procedure TFrameMain.DoGeocodeAddrTimeout;
begin

end;

//procedure TFrameMain.DoGetDataForSelectItemPopupMenuFrame(ATimerTask: TTimerTask);
//var
//  ASuperObject:ISuperObject;
//  AListData:TDataIntfResult;
//begin
//  try
//      //出错
//      TTimerTask(ATimerTask).TaskTag:=1;
//
//
//
//      AListData:=TDataIntfResult.Create;
//      AListData.DataType:=ldtJson;
//      TTimerTask(ATimerTask).TaskObject:=AListData;
//
//      if GlobalManager.RepairItemsDataJson<>nil then
//      begin
////          AListData.Code:=SUCC;
//
//          AListData.Succ:=True;
//
//          //已经有数据了,就不要再重新获取了
//          AListData.DataJson:=GlobalManager.RepairItemsDataJson;
//          TTimerTask(ATimerTask).TaskTag:=0;
//          Exit;
//      end;
//
//
//
//
//
//      //没有获取过,重新获取
//      TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI_TableCommonGetRecordList(
//          'RepairItemView',
//          nil,
//          CommonRestCenterInterfaceUrl,
//          AppID,
//          GlobalManager.User.fid,
//          '',
//          1,
//          MaxInt,//返回全部数据
//          //条件,四个一组
//          [],
//          //排序,两个一组
//          ''
//          );
//
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
////      AListData.Code:=ASuperObject.I['Code'];
//      AListData.Succ:=(ASuperObject.I['Code']=SUCC);
//      AListData.Desc:=ASuperObject.S['Desc'];
//      AListData.DataJson:=ASuperObject.O['Data'];
//
//      if ASuperObject.I['Code']=SUCC then
//      begin
//        GlobalManager.RepairItemsDataJson:=AListData.DataJson;
//      end;
//
//
//      TTimerTask(ATimerTask).TaskTag:=0;
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
//end;
//
//procedure TFrameMain.DoGetDataForSelectMaterialPopupMenuFrame(
//  ATimerTask: TTimerTask);
//var
//  ASuperObject:ISuperObject;
//  AListData:TDataIntfResult;
//begin
//  try
//      //出错
//      TTimerTask(ATimerTask).TaskTag:=1;
//
//
//
//      AListData:=TDataIntfResult.Create;
//      AListData.DataType:=ldtJson;
//      TTimerTask(ATimerTask).TaskObject:=AListData;
//
//      if GlobalManager.RepairMaterialsDataJson<>nil then
//      begin
////          AListData.Code:=SUCC;
//          AListData.Succ:=True;
//
//          //已经有数据了,就不要再重新获取了
//          AListData.DataJson:=GlobalManager.RepairMaterialsDataJson;
//          TTimerTask(ATimerTask).TaskTag:=0;
//          Exit;
//      end;
//
//
//
//      //没有获取过,重新获取
//      TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI_TableCommonGetRecordList(
//          'GoodsInfoView',
//          nil,
//          CommonRestCenterInterfaceUrl,
//          AppID,
//          GlobalManager.User.fid,
//          '',
//          1,
//          MaxInt,//返回全部数据
//          //条件,四个一组
//          [],
//          //排序,两个一组
//          ''
//          );
//
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
////      AListData.Code:=ASuperObject.I['Code'];
//      AListData.SUCC:=(ASuperObject.I['Code']=SUCC);
//
//
//      AListData.Desc:=ASuperObject.S['Dec'];
//      AListData.DataJson:=ASuperObject.O['Data'];
//
//      if ASuperObject.I['Code']=SUCC then
//      begin
//        GlobalManager.RepairMaterialsDataJson:=AListData.DataJson;
//      end;
//
//
//      TTimerTask(ATimerTask).TaskTag:=0;
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
//
//end;

procedure TFrameMain.DoLocationAddrChange;
begin

end;

procedure TFrameMain.DoLocationChange;
begin
  OutputDebugString('OrangeUI TFrameMain.DoLocationChange Begin');

//  if Not GlobalManager.IsGPSLocated then
//  begin
//      //只定位一次
//
//      OutputDebugString('OrangeUI TFrameMain.DoLocationChange IsGPSLocated:False');
//      GlobalManager.IsGPSLocated:=True;
//
//
//      //经纬度
//      GlobalManager.Longitude:=GlobalGPSLocation.Longitude;
//      GlobalManager.Latitude:=GlobalGPSLocation.Latitude;
//
//      GlobalManager.Save;
//
//
//
////      //上传用户定位
////      if FHomeFrame<>nil then
////      begin
////        FHomeFrame.DoLocationChange;
////      end;
//
//
//
//      //过个几个分钟停止定位
//      OutputDebugString('OrangeUI TFrameMain.DoLocationChange GlobalGPSLocation.StopLocation');
//      //取到地址了,那么停止定位
//      GlobalGPSLocation.StopLocation;
//
//
//
//      //获取详细地址
//      GlobalGPSLocation.GeocodeAddr;
//
//
////      //启动重新定位的定时器
////      tmrReLocation.Enabled:=True;
//
//
//  end;

  OutputDebugString('OrangeUI TFrameMain.DoLocationChange End');

end;

procedure TFrameMain.DoLocationStartError;
begin

end;

procedure TFrameMain.DoLocationTimeout;
begin

end;

procedure TFrameMain.DoReturnFrameFromInstallDaemonFrame(AFrame: TFrame);
begin
//  Self.pcMain.Prop.ActivePage:=tsHome;
//  pcMainChange(nil);
//  //显示网页
//  Self.FAIChatFrame.Load;
  Self.tteGetBasicData.Run();
end;

//procedure TFrameMain.DoBaiduOCRScanCarPlateNumberSucc(Sender:TObject);
//begin
//  {$IFDEF IOS}
//  FScanedCarPlate:=Self.FBaiduOCR.CarPlateNumber;
//  ShowHintFrame(Self,'扫描到车牌'+FScanedCarPlate);
//  //判断是否存在该车辆信息
//  Self.tteGetCarInfo.Run;
//  {$ENDIF}
//end;

procedure TFrameMain.DoReturnFrameFromSelectCarInfoFrame(AFrame: TFrame);
//var
//  ACarInfoSuperObject:ISuperObject;
begin
//  //如果选择到匹配的车辆,填入相关的信息
//  if GlobalCarInfoListFrame.lvCarInfoList.Prop.SelectedItem<>nil then
//  begin
//    ACarInfoSuperObject:=TSuperObject.Create(
//      GlobalCarInfoListFrame.lvCarInfoList.Prop.SelectedItem.DataJsonStr
//          );
//
//    HideFrame(Self);
//    ShowFrame(TFrame(GlobalAddCarRepairOrderFrame),TFrameAddCarRepairOrder);
//    GlobalAddCarRepairOrderFrame.Clear;
//
//    //加载车辆信息和车主信息
//    GlobalAddCarRepairOrderFrame.FAddCarInfoFrame.Load(ACarInfoSuperObject);
//  end;
end;

procedure TFrameMain.DoStartLocation;
begin

end;

procedure TFrameMain.edtFilterClick(Sender: TObject);
begin
//  //显示车辆列表,然后快速接车
//  HideFrame(Self);
//  ShowFrame(TFrame(GlobalCarInfoListFrame),TFrameCarInfoList,DoReturnFrameFromSelectCarInfoFrame);
//  GlobalCarInfoListFrame.edtFilter.Text:='';
//  GlobalCarInfoListFrame.Load(futManage);
end;

//procedure TFrameMain.FindCarPlate(AResultString: String);
//var
//  ARegEx:TPerlRegEx;
//begin
//  if AResultString<>'' then
//  begin
//      //利用正则表达式过滤出车牌
//      //^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$
//      ARegEx:=TPerlRegEx.Create();
//      try
//          //ARegEx.Options:=
//          ARegEx.Subject:=AResultString;
//          ARegEx.RegEx:=
//            //'[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}'
//              '[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}'
//              +'[A-Z]{1}'
//              +'[A-Z0-9]{4}'
//              +'[A-Z0-9挂学警港澳]{1}'
//              ;
//
//          if ARegEx.Match then
//          begin
//
//              Self.btnQuickClick(Self);
//              GlobalCarInfoListFrame.edtFilter.Text:=ARegEx.MatchedText;
//              GlobalCarInfoListFrame.Load(futManage);
//              //AFilePath  图片地址
//              //  ShowMessage('扫描结果--'+AJosonResult);
//
//          end
//          else
//          begin
//            ShowMessageBoxFrame(Self,'扫描不到车牌!'+AResultString);
//          end;
//      finally
//        FreeAndNil(ARegEx);
//      end;
//  end
//  else
//  begin
//      ShowMessageBoxFrame(Self,'扫描不到车牌!');
//  end;
//
//end;

procedure TFrameMain.lbHomeClickItem(AItem: TSkinItem);
var
  AFramePopupStyle:TFramePopupStyle;
begin
//  if AItem.ItemType=sitDefault then
//  begin
//    if AItem.Caption='接车' then
//    begin
//        HideFrame(Self);
//        AFramePopupStyle.PopupWidth:=640;
//        AFramePopupStyle.PopupHeight:=frmMain.ClientHeight-80;
//        ShowFrame(TFrame(GlobalAddCarRepairOrderFrame),TFrameAddCarRepairOrder,frmMain,
//                nil,nil,nil,nil,True,True,
//                TUseFrameSwitchEffectType.ufsefDefault,
//                False,//True,
//                @AFramePopupStyle);
//        GlobalAddCarRepairOrderFrame.Clear;
//    end
//    else if AItem.Caption='派工' then
//    begin
//        //显示待派的工单列表
//        HideFrame(Self);
//        ShowFrame(TFrame(GlobalWaitDispatchOrderListFrame),TFrameRepairCarOrderList);
//        GlobalWaitDispatchOrderListFrame.FilterOrderState:='(''待派'')';
//        GlobalWaitDispatchOrderListFrame.Load('待派工单',futSelectList,'派工');//,DoClickItemInSelectWaitDispatchOrderListFrame);
//    end
//    else if AItem.Caption='领料' then
//    begin
//        //显示待领料的工单列表
//        HideFrame(Self);
//        ShowFrame(TFrame(GlobalWaitPickOrderListFrame),TFrameRepairCarOrderList);
//        GlobalWaitPickOrderListFrame.FilterOrderState:='(''已派工'')';
//        GlobalWaitPickOrderListFrame.Load('待领料工单',futSelectList,'领料');//,DoClickItemInSelectWaitDispatchOrderListFrame);
//    end
//    else if AItem.Caption='验收' then
//    begin
//        //显示待验收的工单列表
//        HideFrame(Self);
//        ShowFrame(TFrame(GlobalWaitCheckOrderListFrame),TFrameRepairCarOrderList);
//        GlobalWaitCheckOrderListFrame.FilterOrderState:='(''已派工'')';
//        GlobalWaitCheckOrderListFrame.Load('待验收工单',futSelectList,'验收');//,DoClickItemInSelectWaitDispatchOrderListFrame);
//    end
//    ;
//  end;
end;

{$IFDEF HAS_FASTMSG}

procedure TFrameMain.LoadContactsListFrame;
begin

end;

procedure TFrameMain.LoadRecentContactFrame;
begin

end;

procedure TFrameMain.OnAddRecentItem(ABindingEvent: TBindingEvent);
begin

end;

procedure TFrameMain.SyncRecentContactFrameCaption(
  ARecentContactCaption: String);
begin

end;

{$ENDIF}

procedure TFrameMain.Login(AIsOnlineLogin:Boolean);
//var
//  APage:TPage;
//  AFrame:TFrameBasePage;
//  ABasePageFrame:TFrameBasePage;
//  ARoleJson:ISuperObject;
begin
//  Self.lbHome.Prop.Items.FindItemByCaption('待结算').Detail:='0';
//  Self.lbHome.Prop.Items.FindItemByCaption('今日接车').Detail:='0';
//  Self.lbHome.Prop.Items.FindItemByCaption('今日结算').Detail:='0';
//  Self.lbHome.Prop.Items.FindItemByCaption('今日营收').Detail:='0.00';


  //如果是在线登录了,则同步下数据,否则使用缓存
//  if AIsOnlineLogin then
//  begin

//    if not GlobalOpenClawHelper.IsOpenClawConfigured then
//    begin
////      Self.pcMain.Prop.ActivePage:=tsConfig;
//      //跳转到配置页面
//
//    end
//    else
//    begin
      tteGetBasicData.Run;
//    end;


//  tmrSyncData.Enabled:=True;
//  end;

//  Self.pcMain.Prop.ActivePageIndex:=0;


//  if MultiView1=nil then
//  begin
//    MultiView1:=TMultiView.Create(Self);
//    MultiView1.Parent:=Self;
//  end;
//  MultiView1.Mode:=TMultiViewMode.Drawer;
//
////  Self.MultiView1.MasterButton:=Self.imgUserHead;//Self.btnShowSideBar;
//  MultiView1.TargetControl:=Self;
//
//
//
////
////  FSideMenuFrame.Load;
//  //侧边菜单一定要先准备好,不然手指从侧边左往右滑会滑出空白
//  if FSideMenuFrame=nil then
//  begin
//    FSideMenuFrame:=TFrameSideMenu.Create(Self);
//    FSideMenuFrame.Parent:=Self.MultiView1;
//    FSideMenuFrame.Align:=TAlignLayout.Client;
//  end;
//  Self.FSideMenuFrame.Load(False);




  //Self.pcMain.Prop.Orientation:=toNone;

  //Self.pcMain.Prop.ActivePage:=tsOrder;

//  pcMainChange(nil);

//  if FConsoleFrame<>nil then
//  begin
//    FConsoleFrame.LoadProcess;
//  end;

//  if CurrentFrame<>GlobalProcessTaskManageFrame then
//  begin
//    //直接跳转到工序任务单管理页面
//    HideFrame;
//    ShowFrame(TFrame(GlobalProcessTaskManageFrame),TFrameProcessTaskManage);//,frmMain,nil,nil,nil,nil,False,True,ufsefNone);
//    GlobalProcessTaskManageFrame.Load;
//  end;





//  if not pcMain.Visible then Exit;
//
//  //显示测试页面
//  pcMain.Visible:=False;
////  //显示测试页面
//////  uPageFramework.GlobalOpenPlatformFramework.ShowPage('report',nil,nil);
////  APage:=GlobalMainProgramSetting.FProgramTemplate.PageList.Find('report');
////  AFrame:=uPageFramework.GlobalOpenPlatformFramework.CreateFrame(APage);
////  AFrame.Parent:=Application.MainForm;
////  AFrame.Align:=TAlignLayout.Client;
//////  uPageFramework.GlobalOpenPlatformFramework.CreateFrame('report',nil,nil);
////  AFrame.LoadPage(APage,nil);
//
////  AFrame:=TFrameBasePage(GlobalOpenPlatformFramework.ShowPage('report',nil,nil));
//  AFrame:=TFrameBasePage(GlobalOpenPlatformFramework.ShowPage('list_report',nil,nil));


//  ABasePageFrame:=TFrameBasePage(uPageFramework.GlobalOpenPlatformFramework.ShowPage('RoleList'));
//  ABasePageFrame.FPageInstance.DoCustomPageAction(Const_PageAction_AddRecord);

//  ARoleJson:=SO('{"RowNumber":1,"fid":5,"appid":1016,"name":"\u5382\u957F",'
//                    +'"descript":"\u9664\u9500\u552E\uFF0C\u8D22\u52A1\uFF0C\u91D1\u989D\u4E0D\u663E\u793A\uFF0C\u5176\u5B83\u90FD\u8981\u4E14\u53EF\u4EE5\u64CD\u4F5C",'
//                    +'"orderno":0,"createtime":"2022-09-27 09:00:00","is_deleted":0}');
//  ShowFrame(TFrame(GlobalSetRolePowerFrame),TFrameSetRolePower);
//  GlobalSetRolePowerFrame.Load(ARoleJson);



//  HideFrame;
//  ShowFrame(TFrame(GlobalBaseReportDetailFrame),TFrameBaseReportDetail);
//  GlobalBaseReportDetailFrame.Load('下单报表','客户','百歌门业','','','');

end;

procedure TFrameMain.Logout;
begin
//  GlobalManager.FCurrentProcess:='';

//  FSideMenuFrame.Load;


//  Self.tmrSyncData.Enabled:=False;
end;

procedure TFrameMain.pcMainChange(Sender: TObject);
begin
//  if Self.pcMain.Prop.ActivePage=tsOrder then
//  begin
//      //切换到了工单页面
//      if Self.FRepairCarOrderListFrame=nil then
//      begin
//        FRepairCarOrderListFrame:=TFrameRepairCarOrderList.Create(Self);
//        FRepairCarOrderListFrame.Parent:=tsOrder;
//        FRepairCarOrderListFrame.Align:=TAlignLayout.Client;
////        FRepairCarOrderListFrame.Load('工单',futManage,'查看');//,Self.DoClickItemInSelectWaitDispatchOrderListFrame);
//        FRepairCarOrderListFrame.Load('',futManage,'查看');//,Self.DoClickItemInSelectWaitDispatchOrderListFrame);
//      end;
//  end;

//  if Self.pcMain.Prop.ActivePage=tsOrder then
//  begin
//      //切换到了工单页面
//      if Self.FProcessTaskManageFrame=nil then
//      begin
//        FProcessTaskManageFrame:=TFrameProcessTaskManage.Create(Self);
//        FProcessTaskManageFrame.Parent:=tsOrder;
//        FProcessTaskManageFrame.Align:=TAlignLayout.Client;
//      end;
//      if FProcessTaskManageFrame.FUserFID<>GlobalManager.User.fid then FProcessTaskManageFrame.Load;
//  end;

  //首页
  if Self.pcMain.Prop.ActivePage=tsHome then
  begin

//    if Self.FHomeFrame=nil then
//    begin
//      FHomeFrame:=TFrameHome.Create(Self);
//      FHomeFrame.Parent:=Self.pcMain.Prop.ActivePage;
//      FHomeFrame.Align:=TAlignLayout.Client;
//      FHomeFrame.Load;
//    end;
    if FAIChatFrame=nil then
    begin
      FAIChatFrame:=TFrameAIChat.Create(Self);
      FAIChatFrame.Parent:=Self.pcMain.Prop.ActivePage;
      FAIChatFrame.Align:=TAlignLayout.Client;
//      FAIChatFrame.Load;
    end;
  end;


  if Self.pcMain.Prop.ActivePage=tsConfig then
  begin
    if FConfigFrame=nil then
    begin
      FConfigFrame:=TFrameConfig.Create(Self);
      FConfigFrame.Parent:=Self.pcMain.Prop.ActivePage;
      FConfigFrame.Align:=TAlignLayout.Client;
      FConfigFrame.Load;
    end;

  end;



//  //邮件
//  if Self.pcMain.Prop.ActivePage=tsMail then
//  begin
//
//    if Self.FMailListFrame=nil then
//    begin
//      FMailListFrame:=TFrameBillList.Create(Self);
//      FMailListFrame.Parent:=Self.pcMain.Prop.ActivePage;
//      FMailListFrame.Align:=TAlignLayout.Client;
//      FMailListFrame.btnClassify.Visible:=False;
//      FMailListFrame.pnlToolBar.Caption:='邮件';
//      FMailListFrame.btnReturn.Visible:=False;
//      //设置列表项样式
//      FMailListFrame.lvData.Properties.DefaultItemStyle:='Bill';
//      //设置字段显示绑定
//  //    FMailListFrame.lvData.Properties.DefaultItemStyleConfig.Text:=
//  //      'lblCaption.BindItemFieldName:=''客户名称'';'+#13#10
//  //      +'lblDetail.BindItemFieldName:=''主要联系人'';'+#13#10
//  //      +'lblDetail1.BindItemFieldName:=''最近联系时间'';'+#13#10
//  //      ;
//      //设置字段显示绑定
//      FMailListFrame.lvData.Properties.DefaultItemStyleConfig.Text:=
//        'lblCaption.BindItemFieldName:=''主题'';'+#13#10
//
//        +'lblDetailHint.Caption:=发件人:;'+#13#10
//        +'lblDetail.BindItemFieldName:=''发件人'';'+#13#10
//        +'lblDetail.Left:=70;'+#13#10
//
//        +'lblDetail1Hint.Caption:=时间:;'+#13#10
//        +'lblDetail1.BindItemFieldName:=''时间'';'+#13#10
//        +'lblDetail1.Left:=60;'+#13#10
//        //隐藏图标
//        +'imgItemIcon.Visible:=False;'+#13#10
//        ;
////      //列表项自定义字段列表
////      FMailListFrame.FItemStyleFieldList.Add('客户编号');
////      FMailListFrame.FItemStyleFieldList.Add('客户类型');
////      FMailListFrame.FItemStyleFieldList.Add('业务员');
//
//      FMailListFrame.FSelectMode:=False;
//
//      FMailListFrame.Load('邮件');
////      FMailListFrame.LoadDataList();
//
//    end;
//  end;
//

//
//  //分析报表
//  if Self.pcMain.Prop.ActivePage=tsReport then
//  begin
//
//    if Self.FReportMenuFrame=nil then
//    begin
//      FReportMenuFrame:=TFrameReportMenu.Create(Self);
//      FReportMenuFrame.Parent:=Self.pcMain.Prop.ActivePage;
//      FReportMenuFrame.Align:=TAlignLayout.Client;
//      FReportMenuFrame.Load;
//    end
//    else
//    begin
//      FReportMenuFrame.Load;
//    end;
//
////    if Self.FHomeFrame=nil then
////    begin
////      FHomeFrame:=TFrameHome.Create(Self);
////      FHomeFrame.Parent:=tsConsole;
////      FHomeFrame.Align:=TAlignLayout.Client;
//////      FHomeFrame.Load;
////    end;
//  end;
//
//  //工作台
//  if Self.pcMain.Prop.ActivePage=tsWorkBench then
//  begin
//
//    if Self.FWorkBenchFrame=nil then
//    begin
//      FWorkBenchFrame:=TFrameWorkBench.Create(Self);
//      FWorkBenchFrame.Parent:=Self.pcMain.Prop.ActivePage;
//      FWorkBenchFrame.Align:=TAlignLayout.Client;
//      FWorkBenchFrame.Load;
//    end;
//
//  end;


//  if CurrentFrame<>GlobalProcessTaskManageFrame then
//  begin
//    //直接跳转到工序任务单管理页面
//    HideFrame;
//    ShowFrame(TFrame(GlobalProcessTaskManageFrame),TFrameProcessTaskManage);//,frmMain,nil,nil,nil,nil,False,True,ufsefNone);
//    GlobalProcessTaskManageFrame.Load;
//  end;
//
//  if Self.pcMain.Prop.ActivePage=tsMy then
//  begin
//
//      //切换到我的页面
//      if FMyFrame=nil then
//      begin
//        FMyFrame:=TFrameMy.Create(Self);
//        FMyFrame.Parent:=Self.pcMain.Prop.ActivePage;
//        FMyFrame.Align:=TAlignLayout.Client;
//      end;
//      FMyFrame.Load;
//      //if FMyFrame.FUserFID<>GlobalManager.User.fid then FMyFrame.Load;
//  end;

end;

procedure TFrameMain.PorcessGetUserNoticeUnReadCount(ANoticeUnReadCount: Integer);
begin
  //

end;

procedure TFrameMain.ProcessGetNotice(ANotice: TNotice;
  ASuperObject: ISuperObject);
begin

end;

//procedure TFrameMain.ShowSideMenuFrame(AParent:TFmxObject);
//begin
//  if not GlobalManager.IsLogin then
//  begin
//    ShowLoginFrame(True);
//    Exit;
//  end;
//
//  if FSideMenuFrame=nil then
//  begin
//    FSideMenuFrame:=TFrameSideMenu.Create(Self);
//    FSideMenuFrame.Parent:=Self.MultiView1;
//    FSideMenuFrame.Align:=TAlignLayout.Client;
//  end;
//  //
//  Self.FSideMenuFrame.Load;
//
//  MultiView1.Parent:=AParent;
//  Self.MultiView1.ShowMaster;
//  Self.MultiView1.Visible:=True;
//
//end;

function TFrameMain.SyncUnReadMsgCount: Integer;
begin

end;

procedure TFrameMain.tmrCheckServiceTimer(Sender: TObject);
begin
  //
end;

procedure TFrameMain.tmrSyncDataTimer(Sender: TObject);
begin
//  tmrSyncData.Enabled:=False;
//
//  Self.tteSyncData.Run;
end;

procedure TFrameMain.tteGetBasicDataBegin(ATimerTask: TTimerTask);
begin
  ShowWaitingFrame('服务检测中...');
end;

procedure TFrameMain.tteGetBasicDataExecute(ATimerTask: TTimerTask);
var
  ADesc:String;
begin
  try
      //出错
      TTimerTask(ATimerTask).TaskTag:=1;


      //首次安装,全部都安装，检测都不需要检测
      ADesc:='';

      if not GlobalOpenClawHelper.IsOpenClawConfigured then
      begin
        TTimerTask(ATimerTask).TaskDesc:=ADesc;
        Exit;
      end;

      if GlobalServiceManager.IsServerRunning(ADesc) then
      begin
        TTimerTask(ATimerTask).TaskTag:=0;
        TTimerTask(ATimerTask).TaskDesc:=ADesc;
        Exit;
      end;

      if not GlobalServiceManager.StartServer(ADesc) then
      begin
        TTimerTask(ATimerTask).TaskDesc:=ADesc;
        Exit;
      end;

      //等待服务启动，等收到指定输出就表示服务启动成功了
      //09:49:25 [gateway] [plugins] plugins.allow is empty; discovered non-bundled plugins may auto-load: feishu (D:\Program Files\nodejs\node_global\node_modules\openclaw\extensions\feishu\index.ts). Set plugins.allow to explicit trusted ids.
      //09:49:38 [gateway] [plugins] duplicate plugin id detected; bundled plugin will be overridden by config plugin (D:\OpenClawCode\openclaw\extensions\feishu\index.ts) (plugin=feishu, source=D:\OpenClawCode\openclaw\extensions\feishu\index.ts)
      //09:49:38 [canvas] host mounted at http://127.0.0.1:18789/__openclaw__/canvas/ (root C:\Users\Administrator\.openclaw\canvas)
      //09:49:39 [heartbeat] started
      //09:49:39 [health-monitor] started (interval: 300s, startup-grace: 60s, channel-connect-grace: 120s)
      //09:49:39 [gateway] agent model: custom-api-moleapi-com/gpt-5.4
      //09:49:39 [gateway] listening on ws://127.0.0.1:18789, ws://[::1]:18789 (PID 2392)
      //09:49:39 [gateway] log file: C:\Users\ADMINI~1\AppData\Local\Temp\openclaw\openclaw-2026-03-22.log
      //09:49:39 [browser/server] Browser control listening on http://127.0.0.1:18791/ (auth=token)



      //判断服务有没有启动，有没有配置成功
      if not GlobalServiceManager.WaitServerStarted(2*60,ADesc) then
      begin
        TTimerTask(ATimerTask).TaskDesc:=ADesc;
        Exit;
      end;


     TTimerTask(ATimerTask).TaskTag:=0;
  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;

end;

procedure TFrameMain.tteGetBasicDataExecuteEnd(ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
    begin
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if ASuperObject.I['Code']=200 then
//      begin

        GlobalManager.SaveUserConfig;

        Self.pcMain.Prop.ActivePage:=tsHome;
        pcMainChange(nil);
        //显示网页
        Self.FAIChatFrame.Load;

        //ShowHintFrame(Self,'获取基础数据成功!');

//      end
//      else
//      begin
//        //获取基础数据失败
////        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
//      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin

        if not GlobalOpenClawHelper.IsOpenClawConfigured then
        begin
          //刚安装好没有配置过,跳转到配置向导
          HideFrame;
          ShowFrame(TFrame(GlobalInstallDaemonFrame),TFrameInstallDaemon,DoReturnFrameFromInstallDaemonFrame);
          GlobalInstallDaemonFrame.Load();
          Exit;
        end;


        //网络异常
        ShowMessageBoxFrame(Self,'服务检测失败!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
        Self.pcMain.Prop.ActivePage:=tsConfig;


    end;
  finally
    HideWaitingFrame;
  end;
end;

//procedure TFrameMain.tteGetCarInfoBegin(ATimerTask: TTimerTask);
//begin
//  ShowWaitingFrame(Self,'加载中...');
//end;
//
//procedure TFrameMain.tteGetCarInfoExecute(ATimerTask: TTimerTask);
////var
////  AWhereConditions:uDataSetToJson.TVariantDynArray;
//begin
//
//  try
//      //出错
//      TTimerTask(ATimerTask).TaskTag:=1;
//
////      if Trim(edtFilter.Text)<>'' then
////      begin
////        AWhereConditions:=['AND','车牌号','=',FScanedCarPlate];
////      end
////      else
////      begin
////        AWhereConditions:=[];
////      end;
//
//      TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI(
//          'get_record_list',
//          nil,
//          CommonRestCenterInterfaceUrl,
//          ['appid',
//          'user_fid',
//          'key',
//          'rest_name',
//          'pageindex',
//          'pagesize',
//          'where_key_json',
//          'order_by'],
//          [
//          AppID,
//          GlobalManager.User.fid,
//          '',
//          'CarInfoView',
//          1,
//          1,
//          //条件,四个一组
//          GetWhereConditions(['车牌号'],[FScanedCarPlate]),
//          //排序,两个一组
//          ''],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//          );
//
//      TTimerTask(ATimerTask).TaskTag:=0;
//  except
//    on E:Exception do
//    begin
//      //异常
//      TTimerTask(ATimerTask).TaskDesc:=E.Message;
//    end;
//  end;
//
//
//end;
//
//procedure TFrameMain.tteGetCarInfoExecuteEnd(ATimerTask: TTimerTask);
////var
////  ASuperObject:ISuperObject;
////  AFramePopupStyle:TFramePopupStyle;
//begin
////  try
////    if TTimerTask(ATimerTask).TaskTag=0 then
////    begin
////      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
////      if ASuperObject.I['Code']=200 then
////      begin
//////          if ASuperObject.O['Data'].A['RecordList'].Length>0 then
//////          begin
////
////
////              //已经存在该车辆信息
////              HideFrame(CurrentFrame);
////              AFramePopupStyle.PopupWidth:=640;
////              AFramePopupStyle.PopupHeight:=frmMain.ClientHeight-80;
////              ShowFrame(TFrame(GlobalAddCarRepairOrderFrame),TFrameAddCarRepairOrder,frmMain,
////                      nil,nil,nil,nil,True,True,
////                      TUseFrameSwitchEffectType.ufsefDefault,
////                      False,//True,
////                      @AFramePopupStyle);
////              GlobalAddCarRepairOrderFrame.Clear;
////
////              if ASuperObject.O['Data'].A['RecordList'].Length>0 then
////              begin
////                GlobalAddCarRepairOrderFrame.FAddCarInfoFrame.Load(ASuperObject.O['Data'].A['RecordList'].O[0]);
////              end
////              else
////              begin
////                GlobalAddCarRepairOrderFrame.FAddCarInfoFrame.SetCarPlateNumber(FScanedCarPlate);
////              end;
////
////
////
//////          end
//////          else
//////          begin
//////              //不存在该车辆信息
//////
//////              //添加车辆信息
//////              HideFrame(CurrentFrame);
//////              ShowFrame(TFrame(GlobalAddCarInfoFrame),TFrameAddCarInfo);
//////              GlobalAddCarInfoFrame.Clear(True);
//////              GlobalAddCarInfoFrame.pnlToolBar.Caption:='添加车辆信息';
//////              GlobalAddCarInfoFrame.SetCarPlateNumber(Self.FScanedCarPlate);
//////
//////          end;
////      end
////      else
////      begin
////        //获取列表失败
////        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
////      end;
////
////    end
////    else if TTimerTask(ATimerTask).TaskTag=1 then
////    begin
////      //网络异常
////      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
////    end;
////  finally
////    HideWaitingFrame;
////  end;
//end;

procedure TFrameMain.tteSyncDataExecute(ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
begin
  try
      //出错
      TTimerTask(ATimerTask).TaskTag:=1;




//      //获取首页统计
//      TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI(
//            'get_home_stat',
//            nil,
//            CarglCenterInterfaceUrl,
//            ['appid','user_fid','key','operator'],
//            [AppID,
//            GlobalManager.User.fid,
//            '',
//            GlobalManager.OperatorJson.S['操作员']
//            ],
//                                        GlobalRestAPISignType,
//                                        GlobalRestAPIAppSecret
//            );
//      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
//      if (ASuperObject.I['Code']=200) then
//      begin
//            TThread.Synchronize(nil,procedure
//            begin
//              Self.lbHome.Prop.Items.FindItemByCaption('待结算').Detail:=IntToStr(ASuperObject.O['Data'].I['待结算']);
//              Self.lbHome.Prop.Items.FindItemByCaption('今日接车').Detail:=IntToStr(ASuperObject.O['Data'].I['今日接车']);
//              Self.lbHome.Prop.Items.FindItemByCaption('今日结算').Detail:=IntToStr(ASuperObject.O['Data'].I['今日结算']);
//              Self.lbHome.Prop.Items.FindItemByCaption('今日营收').Detail:=Format('%.2f',[ASuperObject.O['Data'].F['今日营收']]);
//            end);
//      end;



//      TThread.Synchronize(nil,procedure
//      begin
//        Self.tmrSyncData.Enabled:=True;
//      end);


     TTimerTask(ATimerTask).TaskTag:=0;
  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;

end;

end.

