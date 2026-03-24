unit ServerSettingFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uFileCommon,

  uConst,
  uBaseList,
  uSkinItems,
  uSkinListViewType,
  uSkinListBoxType,


  WaitingFrame,
  MessageBoxFrame,
  PopupMenuFrame,

  uManager,
  uOpenClientCommon,
  uOpenUISetting,
  uOpenCommon,
  uTimerTask,
  uUIFunction,
  XSuperObject,
  XSuperJson,
  uFrameContext,
  uBaseHttpControl,
  uRestInterfaceCall,


  EasyServiceCommonMaterialDataMoudle,

  uSkinFireMonkeyButton, uSkinFireMonkeyControl, uSkinFireMonkeyPanel,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyScrollBox,
  uSkinFireMonkeyDirectUIParent, uSkinFireMonkeyScrollBoxContent,
  uSkinFireMonkeyVirtualList, uSkinFireMonkeyListView, uSkinFireMonkeyLabel,
  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit, FMX.ScrollBox,
  FMX.Memo, uSkinFireMonkeyMemo, uSkinFireMonkeyItemDesignerPanel,
  uSkinFireMonkeyImage, uSkinMaterial, uSkinMemoType, uSkinFireMonkeyFrameImage,
  FMX.ListBox, uSkinFireMonkeyComboBox, uSkinComboBoxType,
  uSkinScrollBoxContentType, uSkinScrollControlType, uSkinScrollBoxType,
  uSkinButtonType, uBaseSkinControl, uSkinPanelType, uTimerTaskEvent;




type
  TFrameServerSetting = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    pnlDevide0: TSkinFMXPanel;
    btnOK: TSkinFMXButton;
    pnlServerPort: TSkinFMXPanel;
    edtServerPort: TSkinFMXEdit;
    pnlServerHost: TSkinFMXPanel;
    edtServerHost: TSkinFMXEdit;
    ClearEditButton1: TClearEditButton;
    ClearEditButton2: TClearEditButton;
    cmbTestServerList: TSkinFMXComboBox;
    pnlCompanyName: TSkinFMXPanel;
    edtCompanyName: TSkinFMXEdit;
    ClearEditButton3: TClearEditButton;
    pnlAppID: TSkinFMXPanel;
    edtAppID: TSkinFMXEdit;
    btnQueryCompany: TSkinFMXButton;
    ClearEditButton4: TClearEditButton;
    tteGetAppList: TTimerTaskEvent;
    procedure btnOKClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure cmbTestServerListChange(Sender: TObject);
    procedure btnQueryCompanyClick(Sender: TObject);
    procedure tteGetAppListBegin(ATimerTask: TTimerTask);
    procedure tteGetAppListExecute(ATimerTask: TTimerTask);
    procedure tteGetAppListExecuteEnd(ATimerTask: TTimerTask);
  private
//    FClickIndex:Integer;
    // 弹出框
    procedure DoMenuClickFromPopupMenuFrame(APopupMenuFrame: TFrame);
    { Private declarations }
  public
//    FrameHistroy:TFrameHistroy;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    procedure Load;
    { Public declarations }
  end;



var
  GlobalServerSettingFrame:TFrameServerSetting;

implementation

uses
  MainForm;

{$R *.fmx}

procedure TFrameServerSetting.btnQueryCompanyClick(Sender: TObject);
begin

  if pnlCompanyName.Visible and (Const_FilterAPPName<>'') and (Self.edtCompanyName.Text='') then
  begin
    ShowMessageBoxFrame(Self,'请输入公司名称或简称!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  //
  tteGetAppList.Run();
end;

procedure TFrameServerSetting.btnReturnClick(Sender: TObject);
begin
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self.FrameHistroy);

end;

procedure TFrameServerSetting.cmbTestServerListChange(Sender: TObject);
begin
  //
  Self.edtServerHost.Text:=Self.cmbTestServerList.Text;
end;

procedure TFrameServerSetting.Load;
begin


  Self.edtAppID.Text:=(AppID);
  Self.edtCompanyName.Text:=GlobalManager.CompanyName;


  //服务器
  Self.edtServerHost.Text:=GlobalManager.ServerHost;
  //端口
  Self.edtServerPort.Text:=IntToStr(GlobalManager.ServerPort);

end;

procedure TFrameServerSetting.tteGetAppListBegin(ATimerTask: TTimerTask);
begin
  ShowWaitingFrame('加载中...');
end;

procedure TFrameServerSetting.tteGetAppListExecute(ATimerTask: TTimerTask);
begin
    try
        //出错
        TTimerTask(ATimerTask).TaskTag:=1;


        //保存
        TTimerTask(ATimerTask).TaskDesc:=
            SimpleCallAPI('get_app_list',
                          nil,
                          CenterInterfaceUrl+'program_framework/',
                          ['filter_company_name',
                          'filter_name',
                          'pageindex','pagesize'],
                          [Self.edtCompanyName.Text,
                          Const_FilterAPPName,
                          1,
                          20
                          ],
                          GlobalRestAPISignType,
                          GlobalRestAPIAppSecret
                          );


        if TTimerTask(ATimerTask).TaskDesc<>'' then
        begin
          TTimerTask(ATimerTask).TaskTag:=TASK_SUCC;
        end;


    except
      on E:Exception do
      begin
        //异常
        TTimerTask(ATimerTask).TaskDesc:=E.Message;
      end;
    end;
end;

procedure TFrameServerSetting.tteGetAppListExecuteEnd(ATimerTask: TTimerTask);
var
  ASuperObject:ISuperObject;
  ASkinItem:TSkinItem;
  ACompanyNames:TStringDynArray;
  AAppIDs:TStringDynArray;
  I: Integer;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

//         ShowMessageBoxFrame(frmMain,'保存成功!');
//         ShowHintFrame(frmMain,'保存成功!');



//          if Self.lvData.Prop.Items.Count>0 then
//          begin
//            ShowMessageBoxFrame(nil,'列表中还有未提交的条码,请先保存');
//            Exit;
//          end;

        if ASuperObject.O['Data'].A['RecordList'].Length=0 then
        begin
          ShowMessageBoxFrame(nil,'未找到授权');
          Exit;
        end;


        //if ASuperObject.O[''] then
        SetLength(ACompanyNames,ASuperObject.O['Data'].A['RecordList'].Length);
        SetLength(AAppIDs,ASuperObject.O['Data'].A['RecordList'].Length);
        for I := 0 to ASuperObject.O['Data'].A['RecordList'].Length-1 do
        begin
          ACompanyNames[I]:=ASuperObject.O['Data'].A['RecordList'].O[I].S['company_name']
                              //加上应用名称
                              +'-'+ASuperObject.O['Data'].A['RecordList'].O[I].S['name'];
          AAppIDs[I]:=IntToStr(ASuperObject.O['Data'].A['RecordList'].O[I].I['fid']);
        end;


        //选择授权
        ShowFrame(TFrame(GlobalPopupMenuFrame),TFramePopupMenu,frmMain,nil,nil,DoMenuClickFromPopupMenuFrame,Application,True,True,ufsefNone);
        GlobalPopupMenuFrame.Init('选择授权',
                                  ACompanyNames,
                                  AAppIDS
                                  );



      end
      else
      begin
          //条码检测失败
          //ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);

//          //已经存在
//          //播放出错的声音
//          if FileExists(GetApplicationPath+'scan_fail.mp3') then
//          begin
//            Self.MediaPlayer1.FileName:=GetApplicationPath+'scan_fail.mp3';
//            Self.MediaPlayer1.Play;
//          end
//          else
//          begin
//            //ShowMessage('声音文件不存在');
//          end;
//
//          SyncCount(True,ASuperObject.S['Desc']);
//
      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin
      //网络异常
      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
    end;
  finally
    HideWaitingFrame;
  end;

end;

constructor TFrameServerSetting.Create(AOwner: TComponent);
begin
  inherited;

  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);


  //测试服务器
  cmbTestServerList.Items.Add('www.orangeui.cn');
//  cmbTestServerList.Items.Add('www.petchip.cn');
//  cmbTestServerList.Items.Add('www.ycliving.cn');
//  cmbTestServerList.Items.Add('ec2-13-211-25-71.ap-southeast-2.compute.amazonaws.com');
//  cmbTestServerList.Items.Add('1.gomxf.com');
  cmbTestServerList.Items.Add('127.0.0.1');
  cmbTestServerList.Items.Add('192.168.1.168');
  cmbTestServerList.Items.Add('192.168.1.4');
  cmbTestServerList.Items.Add('192.168.3.250');
  cmbTestServerList.Items.Add('36.134.118.226');


  //测试环境下显示
  cmbTestServerList.Material.BackColor.IsFill:=DirectoryExists('E:\MyFiles');


  Self.pnlCompanyName.Visible:=(Const_APPID='') or GlobalIsNeedAPPIDSetting;
  Self.pnlAppID.Visible:=(Const_APPID='') or GlobalIsNeedAPPIDSetting;


end;

destructor TFrameServerSetting.Destroy;
begin

  inherited;
end;

procedure TFrameServerSetting.DoMenuClickFromPopupMenuFrame(
  APopupMenuFrame: TFrame);
begin
  Self.edtCompanyName.Text:=TFramePopupMenu(APopupMenuFrame).ModalResult;
  Self.edtAppID.Text:=TFramePopupMenu(APopupMenuFrame).ModalResultName;

//   if TFramePopupMenu(APopupMenuFrame).ModalResult='删除' then
//   begin
//     Self.lvData.Prop.Items.Remove(Self.lvData.Prop.InteractiveItem);
//
//     Self.SyncCount(False);
//
//     //保存草稿
//     SaveToLocal;

//   end;

end;

procedure TFrameServerSetting.btnOKClick(Sender: TObject);
var
  AServerPort:Integer;
begin
  HideVirtualKeyboard;


//  if pnlCompanyName.Visible and (Self.edtCompanyName.Text='') then
//  begin
//    ShowMessageBoxFrame(Self,'请输入公司名称!','',TMsgDlgType.mtInformation,['确定'],nil);
//    Exit;
//  end;

  if pnlAppID.Visible and ((Self.edtAppID.Text='') or (Self.edtAppID.Text='0')) then
  begin
    ShowMessageBoxFrame(Self,'请输入授权号AppID!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  if Self.edtServerHost.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入服务器地址!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;
  if Self.edtServerPort.Text='' then
  begin
    ShowMessageBoxFrame(Self,'请输入服务器端口!','',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;


  GlobalManager.CompanyName:=Self.edtCompanyName.Text;
  AppID:=(Self.edtAppID.Text);


  //服务器
  GlobalManager.ServerHost:=Self.edtServerHost.Text;
  //端口
  GlobalManager.ServerPort:=StrToInt(Self.edtServerPort.Text);

  //保存
  GlobalManager.Save;



  //更新客户端连接
  frmMain.SyncServerSetting(Self.edtServerHost.Text,StrToInt(Self.edtServerPort.Text));


  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self.FrameHistroy);

end;

end.

