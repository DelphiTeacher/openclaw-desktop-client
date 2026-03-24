unit NoticeListFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  EasyServiceCommonMaterialDataMoudle,

  uTimerTask,
  uManager,
  uDrawCanvas,

  uOpenClientCommon,
  uOpenCommon,

  uFuncCommon,
  uBaseList,
  uSkinItems,
  uLang,

//  uOpenCommon,
  WaitingFrame,
  MessageBoxFrame,
  uSkinListBoxType,
  uFrameContext,
  ListItemStyleFrame_IconNotice,
//  uSkinVirtualListType,

  uRestInterfaceCall,
  uUIFunction,
  XSuperObject,
  XSuperJson,
  uBaseHttpControl,


  uSkinFireMonkeyScrollControl, uSkinFireMonkeyCustomList,
  uSkinFireMonkeyVirtualList, uSkinFireMonkeyListBox, uSkinFireMonkeyButton,
  uSkinFireMonkeyControl, uSkinFireMonkeyPanel, uSkinFireMonkeyItemDesignerPanel,
  uSkinFireMonkeyLabel, uSkinFireMonkeyCheckBox, uSkinLabelType,
  uSkinCheckBoxType, uSkinItemDesignerPanelType, uSkinScrollControlType,
  uSkinCustomListType, uSkinVirtualListType, uSkinButtonType, uSkinPanelType;

type
  TFrameNoticeList = class(TFrame)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    lbNoticeList: TSkinFMXListBox;
    btnEdit: TSkinFMXButton;
    SkinFMXPanel1: TSkinFMXPanel;
    pnlBottom: TSkinFMXPanel;
    btnSetAllRead: TSkinFMXButton;
    btnDel: TSkinFMXButton;
    chkSelectedAllItem: TSkinFMXCheckBox;
    procedure btnReturnClick(Sender: TObject);
    procedure lbNoticeListPullDownRefresh(Sender: TObject);
    procedure lbNoticeListPullUpLoadMore(Sender: TObject);
    procedure lbNoticeListClickItem(AItem: TSkinItem);
    procedure lbNoticeListPrepareDrawItem(Sender: TObject; ACanvas: TDrawCanvas;
      AItemDesignerPanel: TSkinFMXItemDesignerPanel; AItem: TSkinItem;
      AItemDrawRect: TRect);
    procedure btnEditClick(Sender: TObject);
    procedure btnSetAllReadClick(Sender: TObject);
    procedure chkItemSelectedClick(Sender: TObject);
    procedure chkSelectedAllItemClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
  private
    FNoticeClassifyName:String;
    FNoticeList:TNoticeList;

    FPageIndex:Integer;

    FNoticeFID:Integer;

    FDelNoticeList:TStringList;

    procedure DoGetNoticeListExecute(ATimerTask:TObject);
    procedure DoGetNoticeListExecuteEnd(ATimerTask:TObject);

    procedure DoSetAllNoticeReadedExecute(ATimerTask:TObject);
    procedure DoSetAllNoticeReadedExecuteEnd(ATimerTask:TObject);

    procedure DoDelNoticeSelectedExecute(ATimerTask:TObject);
    procedure DoDelNoticeSelectedExecuteEnd(ATimerTask:TObject);
  private
    //通知详情
//    FNoticeFID:Integer;
    FNotice:TNotice;
    FNoticeClassify:TNoticeClassify;

    //获取通知详情
    procedure DoGetNoticeExecute(ATimerTask:Tobject);
    procedure DoGetNoticeExecuteEnd(ATimerTask:TObject);

    //根据不同通知跳转详情界面
    procedure GetNoticeInfo(Frame:TFrame;ANotice:TNotice);
    { Private declarations }
  protected
    procedure SetNoticeItemIcon(AItem:TSkinItem;ANotice:TNotice);virtual;
  public
//    FNClassify:TNoticeClassify;
    constructor Create(AOwner:TComponent);override;

    destructor Destroy;override;
  public
    procedure Load(ANoticeClassify:TNoticeClassify);overload;
    procedure Load(ANoticeClassifyName:String;ANoticeClassifyCaption:String);overload;
    { Public declarations }
  end;


  TFrameFirstAidExpertNoticeList=class(TFrameNoticeList)
  protected
    procedure SetNoticeItemIcon(AItem:TSkinItem;ANotice:TNotice);override;
  end;


var
  GlobalIsNoticeListChanged:Boolean;

  GlobalNoticeListFrame:TFrameNoticeList;



implementation


uses
//  OrderInfoFrame,
  MainForm,
  MainFrame;
//  OrderListFrame;

{$R *.fmx}

procedure TFrameNoticeList.btnDelClick(Sender: TObject);
var
  I: Integer;
begin
  FDelNoticeList:=TStringList.Create;
  for I := 0 to Self.lbNoticeList.Prop.Items.Count-1 do
  begin
    if Self.lbNoticeList.Prop.Items.Items[I].Checked then
    begin
      FDelNoticeList.Add(IntToStr(TNotice(Self.lbNoticeList.Prop.Items.Items[I].Data).fid));
    end;
  end;

  if Self.lbNoticeList.Prop.Items.Count>0 then
  begin
    ShowWaitingFrame(Self,'删除中...');
    uTimerTask.GetGlobalTimerThread.RunTempTask(
                                  DoDelNoticeSelectedExecute,
                                  DoDelNoticeSelectedExecuteEnd,
                                  'DelNoticeSelected');
  end;
end;

procedure TFrameNoticeList.btnEditClick(Sender: TObject);
var
  I: Integer;
begin
  //编辑、取消共用按钮
  if Self.btnEdit.Caption='编辑' then
  begin
    if Self.lbNoticeList.Prop.Items.Count>0 then
    begin
      Self.btnEdit.Caption:='完成';

      Self.pnlBottom.Visible:=True;
      Self.btnSetAllRead.Enabled:=True;

      //编辑状态显示选中框
      //Self.chkOrderItemSelected.Visible:=True;

    end;
  end
  else
  begin
    Self.btnEdit.Caption:='编辑';

    Self.pnlBottom.Visible:=False;
    Self.chkSelectedAllItem.Prop.Checked:=False;
    Self.btnDel.Enabled:=False;

    //非编辑状态不显示选中框
    //Self.chkOrderItemSelected.Visible:=False;

    //恢复为未选中
    for I := 0 to Self.lbNoticeList.Prop.Items.Count-1 do
    begin
      if Self.lbNoticeList.Prop.Items.Items[I].Checked then
      begin
        Self.lbNoticeList.Prop.Items.Items[I].Checked:=False;
      end;
    end;
  end;
end;

procedure TFrameNoticeList.btnReturnClick(Sender: TObject);
begin
  if IsRepeatClickReturnButton(Self) then Exit;

  Self.btnEdit.Caption:='编辑';
  Self.pnlBottom.Visible:=False;

  HideFrame;//(Self,hfcttBeforeReturnFrame);
  ReturnFrame;//(Self);

end;

procedure TFrameNoticeList.btnSetAllReadClick(Sender: TObject);
begin
  //有未读消息
  ShowWaitingFrame(Self,'设置中...');
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                                  DoSetAllNoticeReadedExecute,
                                  DoSetAllNoticeReadedExecuteEnd,
                                  'SetAllNoticeReaded');

end;

procedure TFrameNoticeList.chkItemSelectedClick(Sender: TObject);
var
  ANotice:TNotice;
  I:Integer;
begin
  if Self.lbNoticeList.Prop.InteractiveItem<>nil then
  begin
    //勾选/取消勾选
    ANotice:=TNotice(Self.lbNoticeList.Prop.InteractiveItem.Data);

    Self.lbNoticeList.Prop.InteractiveItem.Checked:=
      Not Self.lbNoticeList.Prop.InteractiveItem.Checked;

    if Self.lbNoticeList.Prop.Items.IsCheckedAll then
    begin
      Self.chkSelectedAllItem.Prop.Checked:=True;
    end
    else
    begin
      Self.chkSelectedAllItem.Prop.Checked:=False;
    end;

    //有选中就可以删除
    for I := 0 to Self.lbNoticeList.Prop.Items.Count-1 do
    begin
      if Self.lbNoticeList.Prop.Items.Items[I].Checked then
      begin
        Self.btnDel.Enabled:=True;
        Exit;
      end
      else
      begin
        if I=Self.lbNoticeList.Prop.Items.Count-1 then
        begin
          Self.btnDel.Enabled:=False;
        end;
      end;
    end;

  end;

end;

procedure TFrameNoticeList.chkSelectedAllItemClick(Sender: TObject);
begin

  //全选/全不选
  if Self.lbNoticeList.Prop.Items.Count>0 then
  begin


      //编辑状态
      //全选/全不选
      if Not Self.lbNoticeList.Prop.Items.IsCheckedAll then
      begin
        Self.lbNoticeList.Prop.Items.CheckAll;
      end
      else
      begin
        Self.lbNoticeList.Prop.Items.UnCheckAll;
      end;

      Self.chkSelectedAllItem.Prop.Checked:=
        (Self.lbNoticeList.Prop.Items.Count>0)
        and Self.lbNoticeList.Prop.Items.IsCheckedAll;

      //  //全选按钮状态与删除按钮状态同步
      if Self.chkSelectedAllItem.Prop.Checked then
      begin
        Self.btnDel.Enabled:=True;
      end
      else
      begin
        Self.btnDel.Enabled:=False;
      end;
  end
  else
  begin

  end;

end;

constructor TFrameNoticeList.Create(AOwner: TComponent);
begin
  inherited;

//  FNoticeClassify:=TNoticeClassify.Create;


  FNoticeList:=TNoticeList.Create;
  Self.lbNoticeList.Prop.Items.ClearItemsByType(sitDefault);
  Self.lbNoticeList.Prop.Items.ClearItemsByType(sitItem1);

  GlobalIsNoticeListChanged:=False;

  RecordSubControlsLang(Self);
  TranslateSubControlsLang(Self);

  Self.pnlBottom.Visible:=False;

end;

destructor TFrameNoticeList.Destroy;
begin
//  FreeAndNil(FNoticeClassify);

  FreeAndNil(FNoticeList);
  FreeAndNil(FDelNoticeList);
  inherited;
end;

procedure TFrameNoticeList.DoDelNoticeSelectedExecute(ATimerTask: TObject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  try
    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('del_user_notice',
                                                    nil,
                                                    UserCenterInterfaceUrl,
                                                    ['appid',
                                                    'user_fid',
                                                    'key',
                                                    'notice_fids'
                                                    ],
                                                    [AppID,
                                                    GlobalManager.User.fid,
                                                    GlobalManager.User.key,
                                                    FDelNoticeList.CommaText
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

procedure TFrameNoticeList.DoDelNoticeSelectedExecuteEnd(ATimerTask: TObject);
var
  I:Integer;
  ASuperObject:ISuperObject;
  ANoticeList:TNoticeList;
  AListBoxItem:TSkinListBoxItem;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin
          //删除成功
          Self.lbNoticeList.Prop.StartPullDownRefresh;

          FreeAndNil(FDelNoticeList);
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
  end;

end;

procedure TFrameNoticeList.DoGetNoticeListExecute(ATimerTask: TObject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  try
    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('get_user_notice_list',
                                                    nil,
                                                    UserCenterInterfaceUrl,
                                                    ['appid',
                                                    'user_fid',
                                                    'key',
                                                    'notice_classify',
                                                    'pageindex',
                                                    'pagesize'
                                                    ],
                                                    [AppID,
                                                    GlobalManager.User.fid,
                                                    GlobalManager.User.key,
                                                    FNoticeClassifyName,//分类
                                                    FPageIndex,
                                                    20],
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

procedure TFrameNoticeList.DoGetNoticeListExecuteEnd(ATimerTask: TObject);
var
  I:Integer;
  ASuperObject:ISuperObject;
  ANoticeList:TNoticeList;
  AListBoxItem:TSkinListBoxItem;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

          //获取消息列表成功

          ANoticeList:=TNoticeList.Create(ooReference);
          ANoticeList.ParseFromJsonArray(TNotice,ASuperObject.O['Data'].A['NoticeList']);

          Self.lbNoticeList.Prop.Items.BeginUpdate;
          try
            if FPageIndex=1 then
            begin
              Self.lbNoticeList.Prop.Items.ClearItemsByType(sitDefault);
              Self.lbNoticeList.Prop.Items.ClearItemsByType(sitItem1);
              FNoticeList.Clear(True);
            end;

            for I := 0 to ANoticeList.Count-1 do
            begin

              FNoticeList.Add(ANoticeList[I]);

              AListBoxItem:=Self.lbNoticeList.Prop.Items.Add;
//              if ANoticeList[I].notice_classify='system' then
//              begin
//                AListBoxItem.ItemType:=sitItem1;
//
//                Self.chkItemSelected.Visible:=False;
//                Self.btnEdit.Visible:=False;
//              end
//              else
//              begin
                AListBoxItem.ItemType:=sitDefault;

//                Self.chkItemSelected.Visible:=True;
                Self.btnEdit.Visible:=True;
//                //非编辑状态下不显示checkBox
//                if Self.btnEdit.Caption='编辑' then
//                begin
//                  Self.chkOrderItemSelected.Visible:=False;
//                end
//                else
//                begin
//                  Self.chkOrderItemSelected.Visible:=True;
//                end;
//              end;

              AListBoxItem.Data:=ANoticeList[I];

              AListBoxItem.Caption:=ANoticeList[I].caption;
              AListBoxItem.Detail:=ANoticeList[I].createtime;
              AListBoxItem.Detail1:=ANoticeList[I].content;

              //全选中后再获取更多通知时统一
              if Self.chkSelectedAllItem.Prop.Checked then
              begin
                AListBoxItem.Checked:=True;
              end
              else
              begin
                AListBoxItem.Checked:=False;
              end;

              SetNoticeItemIcon(AListBoxItem,ANoticeList[I]);

            end;

          finally
            Self.lbNoticeList.Prop.Items.EndUpdate();
            FreeAndNil(ANoticeList);
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
    //刷新结束若全选按钮未选中则默认全部未选中
    if Not Self.chkSelectedAllItem.Prop.Checked then
    begin
      Self.chkSelectedAllItem.Prop.Checked:=False;
      Self.btnDel.Enabled:=False;
    end;

    if FPageIndex>1 then
    begin
        //加载更多
        if (TTimerTask(ATimerTask).TaskTag=TASK_SUCC) and (ASuperObject.O['Data'].A['NoticeList'].Length>0) then
        begin
          Self.lbNoticeList.Prop.StopPullUpLoadMore('加载成功!',0,True);
        end
        else
        begin
          Self.lbNoticeList.Prop.StopPullUpLoadMore('下面没有了!',600,False);
        end;
    end
    else
    begin
        //刷新
        Self.lbNoticeList.Prop.StopPullDownRefresh('刷新成功!',600);
    end;

  end;
end;

procedure TFrameNoticeList.DoGetNoticeExecute(ATimerTask: Tobject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;

  try
    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI(
          'get_user_notice',
          nil,
          UserCenterInterfaceUrl,
          ['appid',
          'user_fid',
          'key',
          'notice_fid'
          ],
          [AppID,
          GlobalManager.User.fid,
          GlobalManager.User.key,
          FNoticeFID
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

procedure TFrameNoticeList.DoGetNoticeExecuteEnd(ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
begin

  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

          if FNotice.is_readed=0 then
          begin
            //未读设置为已读
            if FNoticeClassify<>nil then FNoticeClassify.notice_classify_unread_count:=FNoticeClassify.notice_classify_unread_count-1;

            GlobalManager.User.notice_unread_count:=GlobalManager.User.notice_unread_count-1;
            //返回需要刷新
            GlobalIsNoticeListChanged:=True;
          end;


          FNotice.ParseFromJson(ASuperObject.O['Data'].A['Notice'].O[0]);
          ASuperObject:=TSuperObject.Create(FNotice.custom_data_json);

          GlobalMainFrame.ProcessGetNotice(FNotice,ASuperObject);


          FNotice.is_readed:=1;

          Self.lbNoticeList.Invalidate;

//          //订单消息
//          if FNotice.notice_classify='order' then
//          begin
//            if ASuperObject.Contains('order_fid') then
//            begin
//                //是订单消息
//                FOrder.fid:=ASuperObject.I['order_fid'];
//
//                //订单详情
//                uTimerTask.GetGlobalTimerThread.RunTempTask(
//                              DoGetNoticeOrderExecute,
//                              DoGetNoticeOrderExecuteEnd);
//                //
//
//
//            end;
//          end
//          //其他消息
//          else if FNotice.notice_classify='other' then
//          begin
//            //酒店审核结果    FNotice.notice_sub_type='hotel_audit_result'
//            //挂钩信息、实名认证等
//            //有要用的属性就先借用了
//            FHotel.audit_user_name:=ASuperObject.S['audit_user_name'];
//            FHotel.audit_state:=ASuperObject.I['audit_state'];
//            FHotel.audit_remark:=ASuperObject.S['audit_remark'];
//            FHotel.audit_time:=FNotice.createtime;
//
//            //隐藏
//            HideFrame;//(CurrentFrame,hfcttBeforeShowFrame);
//
//            //审核意见
//            ShowFrame(TFrame(GlobalAuditInfoFrame),TFrameAuditInfo,frmMain,nil,nil,nil,Application);
//            GlobalAuditInfoFrame.Clear;
//            GlobalAuditInfoFrame.LoadHotel(FHotel);
//            GlobalAuditInfoFrame.FrameHistroy:=CurrentFrameHistroy;
//
//          end
//          else
//          begin
//
//            //隐藏
//            HideFrame;//(CurrentFrame,hfcttBeforeShowFrame);
//            //详情界面
//            ShowFrame(TFrame(GlobalSystemNotificationInfoFrame),TFrameSystemNotificationInfo,frmMain,nil,nil,nil,Application);
//            GlobalSystemNotificationInfoFrame.FrameHistroy:=CurrentFrameHistroy;
//            //系统通知
//            if FNotice.notice_classify='system' then
//            begin
//              GlobalSystemNotificationInfoFrame.Load('公告详情',FNotice);
//            end
//            //站内信
//            else if FNotice.notice_classify='mail' then
//            begin
//              GlobalSystemNotificationInfoFrame.Load('消息详情',FNotice);
//            end;
//          end;

      end
      else
      begin
        //获取失败
        ShowMessageBoxFrame(frmMain,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);

      end;

    end
    else if TTimerTask(ATimerTask).TaskTag=1 then
    begin
      //网络异常
      ShowMessageBoxFrame(frmMain,'网络异常,请检查您的网络连接!',TTimerTask(ATimerTask).TaskDesc,TMsgDlgType.mtInformation,['确定'],nil);
    end;
  finally
    HideWaitingFrame;
  end;

end;


procedure TFrameNoticeList.GetNoticeInfo(Frame: TFrame; ANotice: TNotice);
begin
  ShowWaitingFrame(Frame,'加载中...');
  FNoticeFID:=ANotice.fid;
  FNotice:=ANotice;
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                            DoGetNoticeExecute,
                            DoGetNoticeExecuteEnd,
                            'GetNotice');
end;

procedure TFrameNoticeList.DoSetAllNoticeReadedExecute(ATimerTask: TObject);
begin
  //出错
  TTimerTask(ATimerTask).TaskTag:=1;
  try
    TTimerTask(ATimerTask).TaskDesc:=SimpleCallAPI('set_all_notice_readed',
                                                    nil,
                                                    UserCenterInterfaceUrl,
                                                    ['appid',
                                                    'user_fid',
                                                    'key',
                                                    'notice_classify'
                                                    ],
                                                    [AppID,
                                                    GlobalManager.User.fid,
                                                    GlobalManager.User.key,
                                                    FNoticeClassifyName//消息分类
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

procedure TFrameNoticeList.DoSetAllNoticeReadedExecuteEnd(ATimerTask: TObject);
var
  ASuperObject:ISuperObject;
begin
  try
    if TTimerTask(ATimerTask).TaskTag=0 then
    begin
      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
      if ASuperObject.I['Code']=200 then
      begin

          //设置已读成功
          //刷新
          Self.lbNoticeList.Prop.StartPullDownRefresh;

          //返回需要刷新
          GlobalIsNoticeListChanged:=True;
      end
      else
      begin
        //设置失败
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

procedure TFrameNoticeList.lbNoticeListClickItem(AItem: TSkinItem);
var
  ANotice:TNotice;
begin
  ANotice:=AItem.Data;
  //根据不同消息跳转各自的详情界面
//  GlobalMainFrame.GetNoticeInfo(Self, ANotice);
  Self.GetNoticeInfo(Self, ANotice);


end;

procedure TFrameNoticeList.lbNoticeListPrepareDrawItem(Sender: TObject;
  ACanvas: TDrawCanvas; AItemDesignerPanel: TSkinFMXItemDesignerPanel;
  AItem: TSkinItem; AItemDrawRect: TRect);
var
  ANotice:TNotice;
  AFrameListItemStyle_IconNotice:TFrameListItemStyle_IconNotice;
begin
  ANotice:=AItem.Data;

  if AItemDesignerPanel.Parent is TFrameListItemStyle_IconNotice then
  begin
    AFrameListItemStyle_IconNotice:=TFrameListItemStyle_IconNotice(AItemDesignerPanel.Parent);

    if ANotice.is_readed=1 then
    begin
      AFrameListItemStyle_IconNotice.lblOrderNoticeName.SelfOwnMaterialToDefault.DrawCaptionParam.FontColor:=TAlphaColorRec.Gray;
      AFrameListItemStyle_IconNotice.lblOrderCreatetime.SelfOwnMaterialToDefault.DrawCaptionParam.FontColor:=TAlphaColorRec.Gray
    end
    else
    begin
      AFrameListItemStyle_IconNotice.lblOrderNoticeName.SelfOwnMaterialToDefault.DrawCaptionParam.FontColor:=TAlphaColorRec.Black;
      AFrameListItemStyle_IconNotice.lblOrderCreatetime.SelfOwnMaterialToDefault.DrawCaptionParam.FontColor:=TAlphaColorRec.Black
    end;

    AFrameListItemStyle_IconNotice.chkOrderItemSelected.Visible:=(Self.btnEdit.Caption='完成');

    
  end;

end;

procedure TFrameNoticeList.lbNoticeListPullDownRefresh(Sender: TObject);
begin
  FPageIndex:=1;
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                                  DoGetNoticeListExecute,
                                  DoGetNoticeListExecuteEnd,
                                  'GetNoticeList');
end;

procedure TFrameNoticeList.lbNoticeListPullUpLoadMore(Sender: TObject);
begin
  FPageIndex:=FPageIndex+1;
  uTimerTask.GetGlobalTimerThread.RunTempTask(
                                  DoGetNoticeListExecute,
                                  DoGetNoticeListExecuteEnd,
                                  'GetNoticeList');
end;

procedure TFrameNoticeList.Load(ANoticeClassifyName,
  ANoticeClassifyCaption: String);
begin
  FNoticeClassifyName:=ANoticeClassifyName;
//  FNClassify:=ANoticeClassify;
  FNoticeClassify:=nil;

  Self.pnlToolBar.Caption:=Trans(ANoticeClassifyCaption);

  Self.lbNoticeList.Prop.StartPullDownRefresh;

end;

procedure TFrameNoticeList.SetNoticeItemIcon(AItem: TSkinItem;ANotice:TNotice);
begin

end;

procedure TFrameNoticeList.Load(ANoticeClassify:TNoticeClassify);
begin
  FNoticeClassifyName:=ANoticeClassify.notice_classify;
//  FNClassify:=ANoticeClassify;
  FNoticeClassify:=ANoticeClassify;

  Self.pnlToolBar.Caption:=Trans(ANoticeClassify.notice_classify_caption);

  Self.lbNoticeList.Prop.StartPullDownRefresh;
end;



{ TFrameFirstAidExpertNoticeList }

procedure TFrameFirstAidExpertNoticeList.SetNoticeItemIcon(AItem: TSkinItem;ANotice:TNotice);
begin
  inherited;
//  if ANotice.notice_sub_type=Const_NoticeSubCalssify_Exception then
  begin
    AItem.Icon.FileName:='alert.png';
  end;
end;

end.






