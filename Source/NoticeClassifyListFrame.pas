unit NoticeClassifyListFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  CommonImageDataMoudle,
  EasyServiceCommonMaterialDataMoudle,

  uTimerTask,
  uManager,
  uLang,


  uOpenClientCommon,
  uFuncCommon,
  uBaseList,
  uSkinItems,
  uRestInterfaceCall,
  uOpenCommon,
  uConst,
  uOpenUISetting,

  WaitingFrame,
  uFrameContext,
  MessageBoxFrame,
  uSkinListBoxType,

  uUIFunction,
  XSuperObject,
  XSuperJson,
  uBaseHttpControl,


  uSkinFireMonkeyButton, uSkinFireMonkeyControl, uSkinFireMonkeyPanel,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyCustomList,
  uSkinFireMonkeyVirtualList, uSkinFireMonkeyListBox, uSkinFireMonkeyLabel,
  uSkinFireMonkeyImage, uSkinFireMonkeyItemDesignerPanel,
  uSkinFireMonkeyNotifyNumberIcon, uDrawPicture, uSkinImageList,
  uSkinNotifyNumberIconType, uSkinLabelType, uSkinImageType,
  uSkinItemDesignerPanelType, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinButtonType, uSkinPanelType, uDrawCanvas;

type
  TFrameNoticeClassifyList = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    lbNoticeList: TSkinFMXListBox;
    idpNotice: TSkinFMXItemDesignerPanel;
    imgNoticePic: TSkinFMXImage;
    lblNoticeName: TSkinFMXLabel;
    lblNoticeDetail: TSkinFMXLabel;
    btnItem: TSkinFMXButton;
    nniNumber: TSkinFMXNotifyNumberIcon;
    procedure lbNoticeListPullDownRefresh(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure lbNoticeListClickItem(AItem: TSkinItem);
  private
    FNoticeClassifyList:TNoticeClassifyList;
    FNoticeClassifyFID:Integer;

    procedure GetNoticeClassifyListExecute(ATimerTask:TObject);
    procedure GetNoticeClassifyListExecuteEnd(ATimerTask:TObject);

  private
    procedure OnReturnFromNoticeListFrame(Frame:TFrame);
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    procedure Load;
    { Public declarations }
  end;

var
  GlobalNoticeClassifyListFrame:TFrameNoticeClassifyList;


function GetNoticeIconIndex(notice_classify_caption:String;notice_classify_name:String=''):Integer;

implementation

{$R *.fmx}
uses
//  NoticeListFrame,
  MainFrame,
  MainForm,
  NoticeListFrame;



function GetNoticeIconIndex(notice_classify_caption:String;notice_classify_name:String=''):Integer;
var
  ADrawPicture:TDrawPicture;
begin
  Result:=0;

  //传统,写死,根据下标
  if dmCommonImageDataMoudle.imgListNoticeIcon.PictureList[0].ImageName='' then
  begin
      if Pos('系统公告',notice_classify_caption)>0 then
      begin
        Result:=1;
      end;
      if Pos('订单消息',notice_classify_caption)>0 then
      begin
        Result:=2;
      end;
      if Pos('账号消息',notice_classify_caption)>0 then
      begin
        Result:=3;
      end;
      if Pos('留言',notice_classify_caption)>0 then
      begin
        Result:=4;
      end;
      if Pos('站内信',notice_classify_caption)>0 then
      begin
        Result:=5;
      end;
  end
  else
  begin

      //最新的,根据name
      ADrawPicture:=
        dmCommonImageDataMoudle.imgListNoticeIcon.PictureList.ItemsByName[notice_classify_name];
      if ADrawPicture<>nil then
      begin
        Result:=dmCommonImageDataMoudle.imgListNoticeIcon.PictureList.IndexOf(ADrawPicture);
      end;

  end;
end;

{ TFrameNotice }

procedure TFrameNoticeClassifyList.btnReturnClick(Sender: TObject);
begin
  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);
end;

constructor TFrameNoticeClassifyList.Create(AOwner: TComponent);
//var
//  I:Integer;
//  ANoticeClassifyNameList:TStringList;
//  ANoticeClassifyCaptionList:TStringList;
//  AListBoxItem:TSkinListBoxItem;
begin
  inherited;
  FNoticeClassifyList:=TNoticeClassifyList.Create;
  Self.lbNoticeList.Prop.Items.Clear(True);

  Self.lbNoticeList.Prop.SkinImageList:=dmCommonImageDataMoudle.imgListNoticeIcon;


  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);



//  ANoticeClassifyNameList:=TStringList.Create;
//  ANoticeClassifyCaptionList:=TStringList.Create;
  Self.lbNoticeList.Prop.Items.BeginUpdate;
  try
//    ANoticeClassifyNameList.CommaText:=GlobalNoticeClassifyNameListStr;
//    ANoticeClassifyCaptionList.CommaText:=GlobalNoticeClassifyCaptionListStr;
    Self.lbNoticeList.Prop.Items.Clear;

//    for I := 0 to ANoticeClassifyNameList.Count-1 do
//    begin
//
//    end;


  finally
//    FreeAndNil(ANoticeClassifyNameList);
//    FreeAndNil(ANoticeClassifyCaptionList);
    Self.lbNoticeList.Prop.Items.EndUpdate;
  end;




end;

destructor TFrameNoticeClassifyList.Destroy;
begin
  FreeAndNil(FNoticeClassifyList);
  inherited;
end;

procedure TFrameNoticeClassifyList.GetNoticeClassifyListExecute(ATimerTask: TObject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  try


    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('get_user_notice_classify',
                                                    nil,
                                                    UserCenterInterfaceUrl,
                                                    ['appid',
                                                    'user_fid',
                                                    'key'],
                                                    [AppID,
                                                    GlobalManager.User.fid,
                                                    GlobalManager.User.key],
                                                    GlobalRestAPISignType,
                                                    GlobalRestAPIAppSecret
                                                    );


    if TTimerTask(ATimerTask).TaskDesc<>'' then
    begin
      TTimerTask(ATimerTask).TaskTag:=0;
    end;

  except
    on E:Exception do
    begin
      //异常
      TTimerTask(ATimerTask).TaskDesc:=E.Message;
    end;
  end;
end;

procedure TFrameNoticeClassifyList.GetNoticeClassifyListExecuteEnd(ATimerTask: TObject);
var
  I:Integer;
  ASuperObject:ISuperObject;
  ANoticeClassifyList:TNoticeClassifyList;
  AListBoxItem:TSkinListBoxItem;
begin

  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin
          ANoticeClassifyList:=TNoticeClassifyList.Create(ooReference);
          ANoticeClassifyList.ParseFromJsonArray(TNoticeClassify,ASuperObject.O['Data'].A['NoticeClassify']);
          Self.lbNoticeList.Prop.Items.BeginUpdate;
          try
              Self.lbNoticeList.Prop.Items.Clear(True);
              for I := 0 to ANoticeClassifyList.Count-1 do
              begin

                FNoticeClassifyList.Add(ANoticeClassifyList[I]);

                AListBoxItem:=Self.lbNoticeList.Prop.Items.Add;
                AListBoxItem.Data:=ANoticeClassifyList[I];
                AListBoxItem.Caption:=Trans(ANoticeClassifyList[I].notice_classify_caption);
                AListBoxItem.Detail:=Trans(ANoticeClassifyList[I].classify_desc);

//                if ANoticeClassifyList[I].notice_classify_name='账号消息' then
//                begin
//                  AListBoxItem.Detail:='有关账号的审核等的通知';
//                end;
//                if ANoticeClassifyList[I].notice_classify_name='其他消息' then
//                begin
//                  AListBoxItem.Detail:='例如审核结果通知等';
//                end;
//                if ANoticeClassifyList[I].notice_classify_name='系统公告' then
//                begin
//                  AListBoxItem.Detail:='系统平台的通知，例如：升级';
//                end;
//                if ANoticeClassifyList[I].notice_classify_name='订单消息' then
//                begin
//                  AListBoxItem.Detail:='对订单操作的通知';
//                end;
//                if ANoticeClassifyList[I].notice_classify_name='站内信' then
//                begin
//                  AListBoxItem.Detail:='内部通知';
//                end;
                AListBoxItem.Detail1:=IntToStr(ANoticeClassifyList[I].notice_classify_unread_count);
                AListBoxItem.Icon.ImageIndex:=GetNoticeIconIndex(ANoticeClassifyList[I].notice_classify_caption,
                        ANoticeClassifyList[I].notice_classify);

              end;
          finally
            Self.lbNoticeList.Prop.Items.EndUpdate();
            FreeAndNil(ANoticeClassifyList);
          end;
      end
      else
      begin
        //获取失败
        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin
      //网络异常
      ShowMessageBoxFrame(Self,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
    end;
  finally
    HideWaitingFrame;
    Self.lbNoticeList.Prop.StopPullDownRefresh('刷新成功!',600);
  end;

end;

procedure TFrameNoticeClassifyList.lbNoticeListClickItem(AItem: TSkinItem);
var
  ANoticeClassify:TNoticeClassify;
begin
  ANoticeClassify:=AItem.Data;

  HideFrame;//(CurrentFrame,hfcttBeforeShowFrame);
  //显示消息列表
  ShowFrame(TFrame(GlobalNoticeListFrame),TFrameNoticeList,frmMain,nil,nil,OnReturnFromNoticeListFrame,Application);


  GlobalNoticeListFrame.Load(ANoticeClassify);

end;

procedure TFrameNoticeClassifyList.lbNoticeListPullDownRefresh(Sender: TObject);
begin
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                                   GetNoticeClassifyListExecute,
                                   GetNoticeClassifyListExecuteEnd,
                                   'GetNoticeClassifyList');
end;

procedure TFrameNoticeClassifyList.Load;
begin
//  if GlobalNoticeClassifyNameListStr='' then
//  begin
    Self.lbNoticeList.Prop.StartPullDownRefresh;
//  end
//  else
//  begin
//
//  end;
end;

procedure TFrameNoticeClassifyList.OnReturnFromNoticeListFrame(Frame: TFrame);
begin
  if GlobalIsNoticeListChanged then
  begin
    GlobalIsNoticeListChanged:=False;

    Self.lbNoticeList.Prop.StartPullDownRefresh;
    //刷新未读通知数
    frmMain.GetUserNoticeUnReadCount;
  end;

end;

end.

