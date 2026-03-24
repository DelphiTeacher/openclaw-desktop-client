unit SelectPictureFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  uBaseList,
  uSkinItems,
  ClipHeadFrame,
  uUIFunction,
  uManager,
  uAppCommon,
  uOpenClientCommon,
  uOpenCommon,
  uFrameContext,

  uFuncCommon,
  System.IOUtils,
  uTimerTask,
  XSuperObject,
  WaitingFrame,
  IdURI,
  uBaseLog,
//  uOpenCommon,
  TakePictureMenuFrame,
  uBaseHttpControl,

  MessageBoxFrame,

  uSkinButtonType, uSkinFireMonkeyButton, uSkinImageType, uSkinFireMonkeyImage,
  uSkinItemDesignerPanelType, uSkinFireMonkeyItemDesignerPanel,
  uSkinScrollControlType, uSkinCustomListType, uSkinVirtualListType,
  uSkinListViewType, uSkinFireMonkeyListView, uSkinFireMonkeyControl,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinLabelType, uSkinFireMonkeyLabel,
  uDrawCanvas;

type
  TStringArray=Array of String;

  TFrameSelectPicture = class(TFrame)
    pnlPicture: TSkinFMXPanel;
    lvPictures: TSkinFMXListView;
    pnlDeletePic: TSkinFMXItemDesignerPanel;
    ImgPic: TSkinFMXImage;
    btnDelPic: TSkinFMXButton;
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    btnOk: TSkinFMXButton;
    pnlBankground: TSkinFMXPanel;
    procedure lvPicturesClickItem(AItem: TSkinItem);
    procedure btnDelPicClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnReturnClick(Sender: TObject);
  private
    //本地文件名和图片数据流
    FLocalFileNameAndStreamList:TStringList;
    //本地文件路径
    FLocalFilePathList:TStringList;
    //上传成功之后的远程文件名
    FServerFileNameList:TStringList;


    FEditPictureItem:TSkinItem;
    procedure DoAddPictureFromMenu(Sender: TObject;ABitmap:TBitmap);
    procedure DoEditPictureFromMenu(Sender: TObject;ABitmap:TBitmap);

    procedure DoReturnFrameFromClipAddHeadFrame(Frame:TFrame);
    procedure DoReturnFrameFromClipEditHeadFrame(Frame:TFrame);
  private
    //上传图片
    procedure DoUpLoadShopPicExecute(ATimerTask:TObject);
    procedure DoUpLoadShopPicExecuteEnd(ATimerTask:TObject);

  private
    FNeedUploadCount:Integer;

    //是否需要剪裁
    FIsNeedClip:Boolean;
    FClipWidth:Integer;
    FClipHeight:Integer;
    //允许添加的最大图片数据
    FMaxCount:Integer;

    { Private declarations }
  public
//    FrameHistroy:TFrameHistroy;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    //是否上传
    FFIsUpLoad:Boolean;
    procedure AlignControls;
    procedure Clear;

    //初始
    procedure Init(
                    //图片值数组
                    APictureValues:Array of String;
                    //图片Url数组
                    APictureUrls:Array of String;
                    //是否需要剪裁
                    AIsNeedClip:Boolean;
                    //剪裁的比例
                    AClipWidth:Integer;
                    AClipHeght:Integer;
                    //允许几张
                    AMaxCount:Integer;
                    //是否显示导航栏
                    FIsShowToolBar:Boolean;
                    //是否显示文字
                    FISShowToText:Boolean;
                    //文字内容
                    FTextContent:String
                    );

    //保存到本地
    function SaveToLocalTemp(
                    //图片保存的质量
                    AQuality:Integer;
                    //图片文件的后缀名
                    AFileExt:String):Boolean;
    //上传到服务器
    function Upload(
                    //上传的Rest接口
                    AImageHttpServerUrl:String;
                    var AServerResponseDesc:String):Boolean;
    //获取上传后的值
    function GetServerFileNameArray(AMaxCount:Integer):TStringArray;
    //获取初始值
    function GetInitFileNameArray:TStringArray;

    { Public declarations }
  end;

var
  GlobalSelectPictureFrame:TFrameSelectPicture;

implementation

{$R *.fmx}

procedure TFrameSelectPicture.AlignControls;
begin
  //判断是否需要隐藏添加按钮
  Self.lvPictures.Prop.Items.FindItemByType(sitItem1).Visible:=
    Self.lvPictures.Prop.Items.Count<=FMaxCount;


  Self.Height:=Self.lvPictures.Prop.GetContentHeight;

end;

procedure TFrameSelectPicture.btnDelPicClick(Sender: TObject);
begin
  //删除图片
  Self.lvPictures.Prop.Items.Remove(Self.lvPictures.Prop.InteractiveItem);
  AlignControls;
end;

procedure TFrameSelectPicture.btnOkClick(Sender: TObject);
begin
  SaveToLocalTemp(100,'.png');

  FFIsUpLoad:=True;

  ShowWaitingFrame(Self,'上传图片');
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                   DoUpLoadShopPicExecute,
                   DoUpLoadShopPicExecuteEnd,
                   'UpLoadShopPic');

end;

procedure TFrameSelectPicture.btnReturnClick(Sender: TObject);
begin
  FFIsUpLoad:=False;
  //返回
  HideFrame;//();
  ReturnFrame();
end;

procedure TFrameSelectPicture.Clear;
begin
  FFIsUpLoad:=False;
  Self.lvPictures.Prop.Items.ClearItemsByType(sitDefault);
end;

constructor TFrameSelectPicture.Create(AOwner: TComponent);
begin
  inherited;
  FLocalFilePathList:=TStringList.Create;
  FLocalFileNameAndStreamList:=TStringList.Create;
  FServerFileNameList:=TStringList.Create;
  Self.lvPictures.Prop.Items.ClearItemsByType(sitDefault);

  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);
end;

destructor TFrameSelectPicture.Destroy;
begin
  FreeAndNil(FLocalFilePathList);
  //清空一下里面的Stream,万一没有释放
  FreeStringListObjects(FLocalFileNameAndStreamList);

  FreeAndNil(FLocalFileNameAndStreamList);
  FreeAndNil(FServerFileNameList);

  inherited;
end;

procedure TFrameSelectPicture.DoAddPictureFromMenu(Sender: TObject;
  ABitmap: TBitmap);
var
  AListViewItem:TSkinListViewItem;
begin
  if Not Self.FIsNeedClip then
  begin
    //添加一张图片
    AListViewItem:=Self.lvPictures.Prop.Items.Insert(Self.lvPictures.Prop.Items.Count-1);
    //要放在Icon.Assign前面
    AListViewItem.Icon.Url:='';
    AListViewItem.Icon.Assign(ABitmap);
    //避免花掉
    CopyBitmap(ABitmap,AListViewItem.Icon);

    AlignControls;
  end
  else
  begin
    //上传商品轮播图片裁剪
    HideFrame;//(Self,hfcttBeforeShowframe);
    ShowFrame(TFrame(GlobalClipHeadFrame),TFrameClipHead,Application.MainForm,nil,nil,DoReturnFrameFromClipAddHeadFrame,Application);
    GlobalClipHeadFrame.Init(ABitmap,Self.FClipWidth,FClipHeight);
  end;
end;

procedure TFrameSelectPicture.DoEditPictureFromMenu(Sender: TObject;
  ABitmap: TBitmap);
begin
  //同样广告图片的修改不裁剪
  if Not Self.FIsNeedClip then
  begin
    //要放在Icon.Assign前面
    FEditPictureItem.Icon.Url:='';
    FEditPictureItem.Icon.Assign(ABitmap);
    //避免花掉
    CopyBitmap(ABitmap,FEditPictureItem.Icon);
  end
  else
  begin
    HideFrame;//(Self,hfcttBeforeShowframe);
    ShowFrame(TFrame(GlobalClipHeadFrame),TFrameClipHead,Application.MainForm,nil,nil,DoReturnFrameFromClipEditHeadFrame,Application);
    GlobalClipHeadFrame.Init(ABitmap,FClipWidth,FClipHeight);
  end;
end;

procedure TFrameSelectPicture.DoReturnFrameFromClipAddHeadFrame(Frame: TFrame);
var
  AListViewItem:TSkinListViewItem;
  ABitmap:TBitmap;
begin
  ABitmap:=GlobalClipHeadFrame.GetClipBitmap;
  //添加一张图片
  AListViewItem:=Self.lvPictures.Prop.Items.Insert(Self.lvPictures.Prop.Items.Count-1);
  //要放在Icon.Assign前面
  AListViewItem.Icon.Url:='';
  AListViewItem.Icon.Assign(ABitmap);
  //避免花掉
  CopyBitmap(ABitmap,AListViewItem.Icon);
  FreeAndNil(ABitmap);

  AlignControls;
end;


procedure TFrameSelectPicture.DoReturnFrameFromClipEditHeadFrame(Frame: TFrame);
var
  ABitmap:TBitmap;
begin
  ABitmap:=GlobalClipHeadFrame.GetClipBitmap;
  //要放在Icon.Assign前面
  FEditPictureItem.Icon.Url:='';
  FEditPictureItem.Icon.Assign(ABitmap);
  //避免花掉
  CopyBitmap(ABitmap,FEditPictureItem.Icon);
  FreeAndNil(ABitmap);
end;

procedure TFrameSelectPicture.DoUpLoadShopPicExecute(ATimerTask: TObject);
var
  AServerResponseDesc:String;
  APicUploadSucc:Boolean;
begin
  // 出错
  TTimerTask(ATimerTask).TaskTag := 1;
  try

    APicUploadSucc:=False;
    try
      //上传
      APicUploadSucc:=Upload(ImageHttpServerUrl+'/upload'
                              +'?appid='+(AppID)
                              +'&filename='+'%s'
                              +'&filedir='+'Shop_Pic'
                              +'&fileext='+'.png',
                              AServerResponseDesc);

      if APicUploadSucc=True then
      begin
        TTimerTask(ATimerTask).TaskTag := 0;
      end;

    finally

    end;

  except
    on E: Exception do
    begin
      // 异常
      TTimerTask(ATimerTask).TaskDesc := E.Message;
    end;
  end;

end;

procedure TFrameSelectPicture.DoUpLoadShopPicExecuteEnd(ATimerTask: TObject);
var
  ASuperObject: ISuperObject;
begin
   try
    if TTimerTask(ATimerTask).TaskTag = 0 then
    begin

      //图片上传成功
      //返回
      HideFrame;//();
      ReturnFrame();
    end
    else if TTimerTask(ATimerTask).TaskTag = 1 then
    begin
      // 网络异常
      //图片上传失败
      ShowMessageBoxFrame(Self,'图片上传失败!','',TMsgDlgType.mtInformation,['确定'],nil);
    end;
  finally
    HideWaitingFrame;
  end;

end;

function TFrameSelectPicture.GetInitFileNameArray: TStringArray;
var
  I: Integer;
begin
  if Self.lvPictures.Prop.Items.Count>0 then
  begin
    SetLength(Result,Self.lvPictures.Prop.Items.Count);

    for I := 0 to Self.lvPictures.Prop.Items.Count-1 do
    begin
      Result[I]:=Self.lvPictures.Prop.Items[I].Name;
    end;
  end;
end;

function TFrameSelectPicture.GetServerFileNameArray(
  AMaxCount: Integer): TStringArray;
var
  I: Integer;
begin
  if Self.lvPictures.Prop.Items.Count-1>AMaxCount then
  begin
    AMaxCount:=Self.lvPictures.Prop.Items.Count-1;
  end;

  SetLength(Result,AMaxCount);
  for I := 0 to AMaxCount-1 do
  begin
    Result[I]:='';
  end;

  for I := 0 to Self.FServerFileNameList.Count-1 do
  begin
    Result[I]:=FServerFileNameList[I];
  end;
end;


procedure TFrameSelectPicture.Init(//图片值数组
                                    APictureValues:Array of String;
                                    //图片Url数组
                                    APictureUrls:Array of String;
                                    AIsNeedClip: Boolean;
                                    AClipWidth, AClipHeght,
                                    AMaxCount: Integer;
                                    FIsShowToolBar:Boolean;
                                    //是否显示文字
                                    FISShowToText:Boolean;
                                    //文字内容
                                    FTextContent:String
                                    );
var
  I: Integer;
  AListViewItem:TSkinListViewItem;
begin
  Self.pnlToolBar.Visible:=FIsShowToolBar;

  if FISShowToText=True then
  begin
    Self.pnlPicture.Caption:=FTextContent;
    Self.lvPictures.Margins.Left:=100;
  end
  else
  begin
    Self.pnlPicture.Caption:='';
    Self.lvPictures.Margins.Left:=0;
  end;

  if FIsShowToolBar=False then
  begin
    Self.pnlPicture.Align:=TAlignLayout.Client;
  end
  else
  begin
    Self.pnlPicture.Align:=TAlignLayout.Top;
  end;

  FIsNeedClip:=AIsNeedClip;
  FClipWidth:=AClipWidth;
  FClipHeight:=AClipHeght;

  FMaxCount:=AMaxCount;

  Self.lvPictures.Prop.Items.BeginUpdate;
  try
    Self.lvPictures.Prop.Items.ClearItemsByType(sitDefault);

    for I := 0 to Length(APictureUrls)-1 do
    begin
      AListViewItem:=Self.lvPictures.Prop.Items.Insert(Self.lvPictures.Prop.Items.Count-1);

      AListViewItem.Icon.Url:=APictureUrls[I];
      //存下文件名(保存的时候用,如果修改过了清空,如果没有修改过保持原样)
      AListViewItem.Icon.Name:=APictureValues[I];
      //立即下载
      AListViewItem.Icon.WebUrlPicture;

    end;

  finally
    Self.lvPictures.Prop.Items.EndUpdate;
  end;


  Self.AlignControls;
end;

procedure TFrameSelectPicture.lvPicturesClickItem(AItem: TSkinItem);
begin
  HideVirtualKeyboard;

  //拍照
  ShowFrame(TFrame(GlobalTakePictureMenuFrame),TFrameTakePictureMenu,Application.MainForm,nil,nil,nil,Application,True,False,ufsefNone);
//  GlobalTakePictureMenuFrame.FDefaultPicVisble:=False;
  //  GlobalTakePictureMenuFrame.FrameHistroy:=CurrentFrameHistroy;
  //添加
  if AItem.ItemType=sitItem1 then
  begin
    GlobalTakePictureMenuFrame.OnTakedPicture:=DoAddPictureFromMenu;
  end
  else
  //修改
  if AItem.ItemType=sitDefault then
  begin
    FEditPictureItem:=AItem;
    GlobalTakePictureMenuFrame.OnTakedPicture:=DoEditPictureFromMenu;
  end;
  GlobalTakePictureMenuFrame.ShowMenu;

end;

function TFrameSelectPicture.SaveToLocalTemp(AQuality: Integer;
  AFileExt: String): Boolean;
var
  I:Integer;
  APicStream:TMemoryStream;
  AFileName:String;
  ABitmapCodecSaveParams:TBitmapCodecSaveParams;
begin
  FNeedUploadCount:=0;

  FServerFileNameList.Clear;
  FLocalFilePathList.Clear;
  //清空一下里面的Stream,万一没有释放
  FreeStringListObjects(FLocalFileNameAndStreamList);


  for I := 0 to Self.lvPictures.Prop.Items.Count-2 do
  begin

    if (Self.lvPictures.Prop.Items[I].Icon.Url='') then
    begin
        //新添加或修改过的图片
        AFileName:=CreateGUIDString+AFileExt;
        ABitmapCodecSaveParams.Quality:=AQuality;
        Self.lvPictures.Prop.Items[I].Icon.SaveToFile(
                                                      System.IOUtils.TPath.GetDocumentsPath+PathDelim+AFileName,
                                                      @ABitmapCodecSaveParams
                                                      );


        APicStream:=TMemoryStream.Create;
        APicStream.LoadFromFile(System.IOUtils.TPath.GetDocumentsPath+PathDelim+AFileName);

        FLocalFileNameAndStreamList.AddObject(AFileName,APicStream);
        Self.FLocalFilePathList.Add(System.IOUtils.TPath.GetDocumentsPath+PathDelim+AFileName);
        FServerFileNameList.Add('');

        Inc(FNeedUploadCount);
    end
    else
    begin
        //原图
        FLocalFileNameAndStreamList.AddObject(Self.lvPictures.Prop.Items[I].Icon.Name,nil);
        Self.FLocalFilePathList.Add('');
        Self.FServerFileNameList.Add(Self.lvPictures.Prop.Items[I].Icon.Name);
    end;
  end;
end;

function TFrameSelectPicture.Upload(AImageHttpServerUrl: String;
  var AServerResponseDesc: String): Boolean;
var
  AHttpControl:THttpControl;
  I: Integer;
  AResponseStream:TStringStream;
  ASuperObject:ISuperObject;
  APicStream:TMemoryStream;
  APicUploadSucc:Boolean;
begin
  Result:=False;

  if FNeedUploadCount=0 then
  begin
    Result:=True;
    Exit;
  end;

  AHttpControl:=TSystemHttpControl.Create;
  try

      APicUploadSucc:=True;
      //上传图片
      for I := 0 to Self.FLocalFilePathList.Count-1 do
      begin

          //需要上传
          if FServerFileNameList[I]='' then
          begin

              APicStream:=TMemoryStream(FLocalFileNameAndStreamList.Objects[I]);
              if APicStream<>nil then
              begin
                  AResponseStream:=TStringStream.Create('',TEncoding.UTF8);
                  try
                    try


//                      FMX.Types.Log.d('OrangeUI -pic_name-'+FLocalFileNameAndStreamList[I]);
//                      FMX.Types.Log.d('OrangeUI -AImageHttpServerUrl-'+AImageHttpServerUrl);
                      APicUploadSucc:=AHttpControl.Post(
                            TIdURI.URLEncode(
                              Format(AImageHttpServerUrl,[FLocalFileNameAndStreamList[I]])
                              ),
                              APicStream,AResponseStream);
//                      FMX.Types.Log.d('OrangeUI -AHttpControl.Post end-');
                      if APicUploadSucc then
                      begin
                        AResponseStream.Position:=0;



                        //ASuperObject:=TSuperObject.ParseStream(AResponseStream);
                        //会报错'Access violation at address 004B6C7C in module ''Server.exe''. Read of address 00000000'
                        //要从AResponseStream.DataString加载
                        ASuperObject:=TSuperObject.Create(AResponseStream.DataString);

            //            '{"Code":200,"Desc":"\u4E0A\u4F20\u6587\u4EF6\u6210\u529F",
            //            "Data":{
            //            "RemoteFilePath":"Upload\\1002\\Shop_Pic\\2018\\2018-03-18\\C8B626D93B014B098B8BC829BE13D744.jpg",
            //            "Url":"Upload/1002/Shop_Pic/2018/2018-03-18/C8B626D93B014B098B8BC829BE13D744.jpg"
            //                  }
            //            }'

                        if ASuperObject.I['Code']=200 then
                        begin
                          //上传成功
                          FServerFileNameList[I]:=ASuperObject.O['Data'].S['RemoteFilePath'];
                        end
                        else
                        begin
                          //上传失败
                          AServerResponseDesc:=ASuperObject.S['Desc'];
                        end;


                      end
                      else
                      begin
                        //Http调用失败
                      end;
                    except
                      on E:Exception do
                      begin
                        uBaseLog.HandleException(E,'TFrameSelectPicture.Upload');
                      end;
                    end;

                  finally
                    FLocalFileNameAndStreamList.Objects[I]:=nil;
                    uFuncCommon.FreeAndNil(APicStream);
                    uFuncCommon.FreeAndNil(AResponseStream);
                  end;

                  if Not APicUploadSucc then
                  begin
                    //图片上传失败
                    //退出循环
                    Break;
                  end;
              end;
          end;
      end;

      Result:=True;


  finally
    FreeAndNil(AHttpControl);
  end;

end;


end.
