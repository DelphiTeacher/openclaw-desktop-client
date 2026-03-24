unit UserSuggectionFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  System.StrUtils,
  System.IOUtils,
  uSkinListBoxType,
  Math,
  uSkinBufferBitmap,
  uOpenClientCommon,
  uOpenCommon,

  uDrawTextParam,

  uBaseList,
  uLang,
  uManager,
  uTimerTask,
  uUIFunction,
  XSuperObject,
  XSuperJson,
  uAPPCommon,

  MessageBoxFrame,
  TakePictureMenuFrame,
  ClipHeadFrame,
  WaitingFrame,
  EasyServiceCommonMaterialDataMoudle,
  SelectPictureFrame,

  uBaseHttpControl,
  uRestInterfaceCall,
//  uCommonUtils,
  uFuncCommon,
  uSkinItems,

  IDURI,
  HzSpell,
  uFrameContext,

  uSkinImageType, uSkinFireMonkeyImage, uSkinItemDesignerPanelType,
  uSkinFireMonkeyItemDesignerPanel, uSkinCustomListType, uSkinVirtualListType,
  uSkinListViewType, uSkinFireMonkeyListView, uSkinButtonType,
  uSkinFireMonkeyButton, uSkinLabelType, uSkinFireMonkeyLabel,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, uSkinFireMonkeyMemo,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinScrollBoxContentType,
  uSkinFireMonkeyScrollBoxContent, uSkinFireMonkeyControl,
  uSkinScrollControlType, uSkinScrollBoxType, uSkinFireMonkeyScrollBox,
  FMX.Memo.Types;

type
  TFrameUserSuggection = class(TFrame,IFrameHistroyReturnEvent)
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    pnlRecvAddr: TSkinFMXPanel;
    memoContext: TSkinFMXMemo;
    lblCharCount: TSkinFMXLabel;
    btnOK: TSkinFMXButton;
    lblHint: TSkinFMXLabel;
    SkinFMXPanel1: TSkinFMXPanel;
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    lblusedesc: TSkinFMXLabel;
    lblMemoTitle: TSkinFMXLabel;
    pnlBtnBox: TSkinFMXPanel;
    procedure btnOKClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
    procedure memoContextChange(Sender: TObject);
    procedure memoContextChangeTracking(Sender: TObject);
  private
    FSelectPictureFrame:TFrameSelectPicture;
  private
    //提出意见建议
    procedure DoInputUserOptionExecute(ATimerTask:TObject);
    procedure DoInputUserOptionExecuteEnd(ATimerTask:TObject);
  private
    //是否可以返回上一个Frame
    function CanReturn:TFrameReturnActionType;
  private
    //提交成功后返回
    procedure OnModalResultFromSuccess(AFrame:TObject);
    { Private declarations }
  public
    //清除
    procedure Clear;
    //提交意见反馈
    procedure Add;
  public
//    FrameHistroy:TFrameHistroy;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    { Public declarations }
  end;

var
  GlobalUserSuggectionFrame:TFrameUserSuggection;

implementation

{$R *.fmx}

{ TFrameUserSuggection }

procedure TFrameUserSuggection.Add;
var
  Names:TStringArray;
  Urls:TStringArray;
begin
  Clear;

  //加载积分用途
  if GlobalManager.AppJson<>nil then
  begin
    Self.lblusedesc.Caption:=
     GlobalManager.AppJson.S['score_use_desc'];
  end;

  SetLength(Names,0);
  SetLength(Urls,0);


  FSelectPictureFrame.Init(Names,Urls,False,0,0,6,False,False,'');


  Self.sbClient.VertScrollBar.Prop.Position:=0;
  Self.sbcClient.Height:=GetSuitScrollContentHeight(Self.sbcClient);
end;

procedure TFrameUserSuggection.btnOKClick(Sender: TObject);
begin
  if Trim(Self.memoContext.Text)='' then
  begin
    ShowMessageBoxFrame(Self,Trans('请输入意见建议!'),'',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;
  if Length(Self.memoContext.Text)>250 then
  begin
    ShowMessageBoxFrame(Self,Trans('内容字数超出!'),'',TMsgDlgType.mtInformation,['确定'],nil);
    Exit;
  end;

  //图片
  Self.FSelectPictureFrame.SaveToLocalTemp(100,'.png');

  ShowWaitingFrame(Self,Trans('提交中...'));

  //提交意见建议
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                 DoInputUserOptionExecute,
                 DoInputUserOptionExecuteEnd,
                 'InputUserOption');
end;

procedure TFrameUserSuggection.btnReturnClick(Sender: TObject);
begin
  //判断是否可以返回
  if CanReturnFrame(CurrentFrameHistroy)=TFrameReturnActionType.fratDefault then
  begin
    //返回
    HideFrame;
    ReturnFrame;
  end;
end;

function TFrameUserSuggection.CanReturn: TFrameReturnActionType;
begin
  Result:=TFrameReturnActionType.fratDefault;
  if Self.memoContext.Lines.Text<>'' then
  begin
    Result:=TFrameReturnActionType.fratCanNotReturn;

    ShowMessageBoxFrame(Self,Trans('您确定要退出吗？'),'',TMsgDlgType.mtInformation,['取消','确定'],OnModalResultFromSuccess);

  end;
end;

procedure TFrameUserSuggection.Clear;
begin
  Self.memoContext.Text:='';
  //积分用途清空
  Self.lblusedesc.Text:='';
end;

constructor TFrameUserSuggection.Create(AOwner: TComponent);
begin
  inherited;
  //选择图片
  Self.FSelectPictureFrame:=TFrameSelectPicture.Create(Self);
  FSelectPictureFrame.Parent:=Self.sbcClient;
  FSelectPictureFrame.Align:=TAlignLayout.Top;
 // FSelectPictureFrame.Margins.Top:=10;
  FSelectPictureFrame.Position.Y:=
    Self.lblHint.Position.Y
    +Self.lblHint.Height
    -1;

  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);
end;

destructor TFrameUserSuggection.Destroy;
begin

  inherited;
end;

procedure TFrameUserSuggection.DoInputUserOptionExecute(ATimerTask: TObject);
var
  APicUploadSucc:Boolean;
  Pic1:String;
  Pic2:String;
  Pic3:String;
  Pic4:String;
  Pic5:String;
  Pic6:String;
  AServerResponseDesc:String;
begin
  // 出错
  TTimerTask(ATimerTask).TaskTag := 1;
  try

    APicUploadSucc:=False;

    APicUploadSucc:=Self.FSelectPictureFrame.Upload(
                             ImageHttpServerUrl+'/upload'
                             +'?appid='+(AppID)
                             +'&filename='+'%s'
                             +'&filedir='+'Suggestion_Pic'
                             +'&fileext='+'.png',
                             AServerResponseDesc
                            );
        //图片上传成功
    if (APicUploadSucc=True) then
    begin
      Pic1:=Self.FSelectPictureFrame.GetServerFileNameArray(6)[0];
      Pic2:=Self.FSelectPictureFrame.GetServerFileNameArray(6)[1];
      Pic3:=Self.FSelectPictureFrame.GetServerFileNameArray(6)[2];
      Pic4:=Self.FSelectPictureFrame.GetServerFileNameArray(6)[3];
      Pic5:=Self.FSelectPictureFrame.GetServerFileNameArray(6)[4];
      Pic6:=Self.FSelectPictureFrame.GetServerFileNameArray(6)[5];
    end;


    TTimerTask(ATimerTask).TaskDesc :=SimpleCallAPI('add_suggestion',
                                                      nil,
                                                      UserSuggectionUserCenterInterfaceUrl,
                                                      ['appid',
                                                      'user_fid',
                                                      'content',
                                                      'key',
                                                      'pic1path',
                                                      'pic2path',
                                                      'pic3path',
                                                      'pic4path',
                                                      'pic5path',
                                                      'pic6path'],
                                                      [AppID,
                                                      GlobalManager.User.fid,
                                                      Self.memoContext.Text,
                                                      GlobalManager.User.key,
                                                      Pic1,
                                                      Pic2,
                                                      Pic3,
                                                      Pic4,
                                                      Pic5,
                                                      Pic6
                                                      ],
                                                      GlobalRestAPISignType,
                                                      GlobalRestAPIAppSecret
                                                      );
    if TTimerTask(ATimerTask).TaskDesc <> '' then
    begin
      TTimerTask(ATimerTask).TaskTag := 0;
    end;

  except
    on E: Exception do
    begin
      // 异常
      TTimerTask(ATimerTask).TaskDesc := E.Message;
    end;
  end;
end;

procedure TFrameUserSuggection.DoInputUserOptionExecuteEnd(ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
begin

  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin
        //提交成功
        ShowMessageBoxFrame(Self,Trans('提交成功'),'',TMsgDlgType.mtInformation,['确定'],OnModalResultFromSuccess);

      end
      else
      begin
        //调用失败
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
  end;
end;

procedure TFrameUserSuggection.memoContextChange(Sender: TObject);
begin
  lblCharCount.Caption:=IntToStr(Length(Self.memoContext.Text))+'/250';
end;

procedure TFrameUserSuggection.memoContextChangeTracking(Sender: TObject);
begin
  lblCharCount.Caption:=IntToStr(Length(Self.memoContext.Text))+'/250';
end;

procedure TFrameUserSuggection.OnModalResultFromSuccess(AFrame: TObject);
begin
  if TFrameMessageBox(AFrame).ModalResult=Trans('确定') then
  begin
    //清空,表示可以退出
    Self.memoContext.Text:='';
    //返回
    HideFrame;//(Self,hfcttBeforeReturnFrame);
    ReturnFrame;//(Self.FrameHistroy);
  end;
end;

end.
