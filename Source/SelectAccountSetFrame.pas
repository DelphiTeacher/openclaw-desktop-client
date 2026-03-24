unit SelectAccountSetFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,


  EasyServiceCommonMaterialDataMoudle,

  uConst,
  uManager,
  uDrawCanvas,

  uFuncCommon,
  uBaseList,

  uTimerTask,
  uOpenClientCommon,
  uSkinImageList,

  uComponentType,
  WaitingFrame,
  MessageBoxFrame,

  uSkinListBoxType,
  uSkinItemJsonHelper,

  uRestInterfaceCall,
  uUIFunction,
  XSuperObject,
  XSuperJson,
  uBaseHttpControl,


  SelectMonthFrame,

  DateUtils,
  uAPPCommon,
  uBasePageStructure,

  uSkinFireMonkeyItemDesignerPanel,
  uSkinItemDesignerPanelType,

  uSkinFireMonkeyButton, uSkinFireMonkeyControl, uSkinFireMonkeyPanel,
  FMX.DateTimeCtrls, uSkinFireMonkeyDateEdit, uSkinFireMonkeyRadioButton,
  uSkinFireMonkeyCheckBox, uSkinFireMonkeyScrollBoxContent,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyScrollBox, uSkinMaterial,
  uSkinButtonType, uSkinFireMonkeyLabel, uSkinLabelType, uSkinRadioButtonType,
  uSkinCheckBoxType, uSkinScrollBoxContentType, uSkinScrollControlType,
  uSkinScrollBoxType, uSkinPanelType,uDrawRectParam, uTimerTaskEvent,
  uSkinItems, uSkinCustomListType, uSkinVirtualListType, uSkinListViewType,
  uSkinTreeViewType, uSkinFireMonkeyTreeView;

type
  TIntegerArray=array of Integer;
  TFrameSelectAccountSet = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    btnOK: TSkinFMXButton;
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    pnlEmpty4: TSkinFMXPanel;
    tteGetAccountAppList: TTimerTaskEvent;
    lbMenus: TSkinFMXTreeView;
    procedure btnReturnClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure tteGetAccountAppListBegin(ATimerTask: TTimerTask);
    procedure tteGetAccountAppListExecute(ATimerTask: TTimerTask);
    procedure tteGetAccountAppListExecuteEnd(ATimerTask: TTimerTask);
    procedure lbMenusClickItem(AItem: TSkinItem);
    procedure lbMenusClickItemDesignerPanelChild(Sender: TObject;
      AItem: TBaseSkinItem; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
      AChild: TFmxObject);
  private
    procedure Clear;
    procedure SetApp(AAppJson:ISuperObject);
    { Private declarations }
  public
    FUserName: string;

     //点击的菜单项的标题
    ModalResult:String;
    //点击的菜单项的Item.Name
    ModalResultName:String;
    ModalResultItem:TSkinItem;
    ModalResultDataJsonStr:String;
    ModalResultDataJson:ISuperObject;
    //选择的下标
    ModalResultIndex:Integer;

    procedure Load;

    constructor Create(AOwner:TComponent);override;

    //静态数据
    procedure Init( //菜单框标题
                    const ACaption:String;
                    //菜单项数组,['男','女','未知']
                    AMenuCaptions:Array of String;
                    //['male','female','unknow']
                    AMenuNames:Array of String;
                    //列表项的样式
                    AItemStyle:String='';
                    //是否显示过滤框
                    AIsShowFilter:Boolean=False;
                    //窗体宽度
                    AWidth:Double=320;
                    ARecordListArray:ISuperArray=nil;
                    //图片列表
                    AMenuImageList:TSkinImageList=nil;
                    //每个菜单的图标
                    AMenuIconImageIndexs:TIntegerArray=[]);overload;
  public
    { Public declarations }
  end;

var
  GlobalSelectAccountSetFrame:TFrameSelectAccountSet;

implementation

uses
  MainForm;

{$R *.fmx}


procedure TFrameSelectAccountSet.btnOKClick(Sender: TObject);
begin
  //返回
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self.FrameHistroy);
end;

procedure TFrameSelectAccountSet.btnReturnClick(Sender: TObject);
begin
  if GetFrameHistory(Self)<>nil then GetFrameHistory(Self).OnReturnFrame:=nil;

  //返回
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self.FrameHistroy);
end;

constructor TFrameSelectAccountSet.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TFrameSelectAccountSet.Load;
begin
  if ((Const_APPID='') or GlobalIsNeedAPPIDSetting) and IsMobPhone(FUserName) then
  begin
    //需要选择AppID
    tteGetAccountAppList.Run();
  end;
end;

procedure TFrameSelectAccountSet.Clear;
begin
  ModalResult:='';
  ModalResultName:='';
  ModalResultItem:=nil;
  ModalResultDataJsonStr:='';
  ModalResultDataJson:=nil;
  ModalResultIndex:=-1;


//  FOnCustomLoadDataToUIEnd:=nil;


  //加载菜单项到ListBox
  Self.lbMenus.Prop.Items.BeginUpdate;
  try
    Self.lbMenus.Prop.Items.Clear(True);
  finally
    Self.lbMenus.Prop.Items.EndUpdate;
  end;


//  Self.lbItemCategory.Visible:=False;
end;

procedure TFrameSelectAccountSet.SetApp(AAppJson: ISuperObject);
begin
  GlobalManager.CompanyName:=AAppJson.S['company_name'];
  AppID:=IntToStr(AAppJson.I['fid']);

  //服务器
  GlobalManager.ServerHost:=AAppJson.S['server'];
  if AAppJson.I['server_port']>0 then
  begin
    //端口,端口不变
    GlobalManager.ServerPort:=AAppJson.I['server_port'];
  end;

  //保存
  GlobalManager.Save;

  //更新客户端连接
  frmMain.SyncServerSetting(GlobalManager.ServerHost,GlobalManager.ServerPort);
end;

procedure TFrameSelectAccountSet.Init(const ACaption:String;
                              AMenuCaptions:Array of String;
                              AMenuNames:Array of String;
                              AItemStyle:String;
                              AIsShowFilter:Boolean;
                              AWidth:Double;
                              ARecordListArray:ISuperArray;
                              AMenuImageList:TSkinImageList;
                              AMenuIconImageIndexs:TIntegerArray);
var
  I: Integer;
  AItem:TSkinItem;
begin
  Clear;

//  PrepareForShow(ACaption,
//                  AItemStyle,
//                  AIsShowFilter,
//                  AWidth);


  Self.lbMenus.Prop.SkinImageList:=AMenuImageList;

  //加载菜单项到ListBox
  Self.lbMenus.Prop.Items.BeginUpdate;
  try
    for I := 0 to Length(AMenuCaptions)-1 do
    begin
      AItem:=Self.lbMenus.Prop.Items.Add;
      AItem.Caption:=AMenuCaptions[I];
      if Length(AMenuNames)>I then
      begin
        AItem.Name:=AMenuNames[I];
      end;

      if ARecordListArray<>nil then
      begin
        AItem.Json:=ARecordListArray.O[I];
      end;

      if Length(AMenuIconImageIndexs)>I then
      begin
        AItem.Icon.ImageIndex:=AMenuIconImageIndexs[I];
      end;

    end;
  finally
    Self.lbMenus.Prop.Items.EndUpdate;
  end;

  //设置弹出框的高度
//  FrameResize(nil);
end;

procedure TFrameSelectAccountSet.lbMenusClickItem(AItem: TSkinItem);
begin
  if IsRepeatClickReturnButton(Self) then Exit;

  //选择的菜单项
  ModalResult:=AItem.Caption;
  ModalResultName:=AItem.Name;
  ModalResultDataJsonStr:=AItem.DataJsonStr;
  ModalResultDataJson:=nil;
  if GetItemJsonObject(AItem)<>nil then
  begin
    ModalResultDataJson:=GetItemJsonObject(AItem).Json;
  end;
  ModalResultIndex:=AItem.Index;
  ModalResultItem:=AItem;

  SetApp(Self.ModalResultDataJson);

//  HideFrame;
  //主窗体接口调用成功
  frmMain.DoCallLoginAPISucc(False,
                              //显示主页MainFrame
                              True);
end;

procedure TFrameSelectAccountSet.lbMenusClickItemDesignerPanelChild(
  Sender: TObject; AItem: TBaseSkinItem;
  AItemDesignerPanel: TSkinFMXItemDesignerPanel; AChild: TFmxObject);
begin
  if AChild.Name='imgGroupExpanded' then
  begin
    TSkinTreeViewItem(AItem).Expanded:=not TSkinTreeViewItem(AItem).Expanded;
  end;
end;

procedure TFrameSelectAccountSet.tteGetAccountAppListBegin(ATimerTask: TTimerTask);
begin
  ShowWaitingFrame('加载中...');
end;

procedure TFrameSelectAccountSet.tteGetAccountAppListExecute(
  ATimerTask: TTimerTask);
begin
  try
      //出错
      TTimerTask(ATimerTask).TaskTag:=1;

      //保存
      TTimerTask(ATimerTask).TaskDesc:=
          SimpleCallAPI('get_account_app_list',
                        nil,
                        CenterInterfaceUrl+'program_framework/',
                        ['phone',
                        'user_type',
                        'filter_app_name'],
                        [FUserName,
                        APPUserType,
                        Const_FilterAPPName
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

procedure TFrameSelectAccountSet.tteGetAccountAppListExecuteEnd(
  ATimerTask: TTimerTask);
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


        if ASuperObject.O['Data'].A['RecordList'].Length=0 then
        begin
          ShowMessageBoxFrame(nil,'未找到'+Const_FilterAPPName+'的授权');
          Exit;
        end;

        if ASuperObject.O['Data'].A['RecordList'].Length=1 then
        begin
          SetApp(ASuperObject.O['Data'].A['RecordList'].O[0]);

          HideFrame;
          //主窗体接口调用成功
          frmMain.DoCallLoginAPISucc(False,
                                      //显示主页MainFrame
                                      True);

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


        //初始化加载授权数据
        Self.Init('选择授权',
                  ACompanyNames,
                  AAppIDS,
                  '',
                  False,
                  320,
                  ASuperObject.O['Data'].A['RecordList']
                  );

      end
      else
      begin
          //条码检测失败
          //ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);

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

end.
