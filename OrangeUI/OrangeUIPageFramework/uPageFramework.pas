unit uPageFramework;

interface
{$IF DEFINED(ANDROID) OR DEFINED(IOS) OR DEFINED(MACOS) }
  {$DEFINE FMX}
{$IFEND}



//请在工程下放置FrameWork.inc
//或者在工程设置中配置FMX编译指令
//才可以正常编译此单元
{$IFNDEF FMX}
  {$IFNDEF VCL}
    {$I FrameWork.inc}
  {$ENDIF}
{$ENDIF}


uses
  Classes,
  SysUtils,
  Types,

  {$IFDEF FMX}
  FMX.Controls,
  FMX.Types,
  FMX.Dialogs,
  FMX.Edit,
  FMX.ComboEdit,
  FMX.ListBox,
  FMX.StdCtrls,
  FMX.Memo,
  FMX.Graphics,
  UITypes,
  MessageBoxFrame,
  WaitingFrame,
  FMX.Forms,
  uSkinCommonFrames,
  //选择日期过滤页面
  SelectFilterFrame,
  {$ENDIF}

  {$IFDEF VCL}
  Forms,
  Dialogs,
  {$ENDIF}

  uUIFunction,
  uDrawParam,
  uGraphicCommon,
  uSkinItems,
  uSkinMaterial,
  uSkinListLayouts,
  uSkinListViewType,
  uComponentType,
  uSkinRegManager,
  uBaseList,
  uBaseLog,
  IdURI,
  Math,


  {$IF CompilerVersion <= 21.0} // D2010之前
    //Delphi2010不能用XSuperObject
    SuperObject,
    superobjecthelper,
  {$ELSE}
    {$IFDEF SKIN_SUPEROBJECT}
    uSkinSuperObject,
    {$ELSE}
    XSuperObject,
    XSuperJson,
    {$ENDIF}
  {$IFEND}



  IniFiles,
  uOpenCommon,
  uOpenClientCommon,
  uBaseSkinControl,
  uDrawTextParam,
  uDrawPictureParam,
  uDrawRectParam,
//  uSkinPageControl,
//  uBasePageStructure,
  uSkinVirtualListType,
  uDataInterface,
//  uTableCommonRestCenter,
  uLang,
  uPageInstance,
//  uComponentType,
  uSkinItemJsonHelper,
  uBasePageStructure,
  uPageFrameworkDataSource,


//  uFrameContext,
//  System.Math.Vectors,
//  System.UIConsts,
//  System.Net.URLClient,


//  uSkinCommonFrames,
//  uTimerTask,
  DateUtils,
  uFuncCommon,
  uFileCommon,
//  uBaseHttpControl,
  uRestInterfaceCall,
  uBaseHttpControl,
  uPageStructure,




  uDrawCanvas,
  uFrameContext,

  BasePageFrame,
  uBasePageFrame,
//  BaseListPageFrame,
//  BaseViewPageFrame,
//  BaseEditPageFrame,
//  {$IFDEF VCL}
//  {$ENDIF}
//  BaseTableManageFrame,


  StrUtils,
  uTimerTask,
  uTimerTaskEvent;



type
  //开放平台的程序,你的意义是什么?
  TOpenPlatformFramework=class(TBaseOpenPlatformFramework)
  private
//    FOnNeedShowPage: TOnNeedShowPageEvent;
//    FOnCustomProcessPageAction: TOnCustomProcessPageActionEvent;
//    FLoadDataSetting:TLoadDataSetting;
//    FOnReturnFrame:TReturnFromFrameEvent;
//    FIsNeedHideFrame:Boolean;
//    FFromPageInstance:TPageInstance;
//    procedure tteShowPageExecuteEnd(ATimerTask: TTimerTask);
  protected
//    //需要显示页面
//    procedure DoNeedShowPage(Sender:TObject;
//                                  AFromPageInstance:TPageInstance;
//                                  AFromFieldControlSettingMap:TFieldControlSettingMap;
////                                  AToPageFID:Integer;
//                                  AToPage:TPage;
////                                  ALoadDataSetting:TLoadDataSetting;
//                                  //返回
//                                  AOnReturnFrame:TReturnFromFrameEvent;
//                                  var AIsProcessed:Boolean);override;
    //处理自定义的动作
    procedure DoCustomProcessPageAction(Sender:TObject;
                                        APageInstance:TObject;
                                        AAction:String;
                                        AFieldControlSettingMap:TObject;
                                        var AIsProcessed:Boolean);override;
//  public
//    FPageFrameList:TBaseList;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

//    //加载页面结构并显示页面
//    function ShowPage(APageFID:Integer;
////                      //加载设置
////                      ALoadDataSetting:TLoadDataSetting;
//                      AIsNeedHideFrame:Boolean;
//                      //返回
//                      AOnReturnFrame:TReturnFromFrameEvent;
//                      AFromPageInstance:TPageInstance):Boolean;overload;
//
//    //加载页面结构并显示页面
//    function ShowPage(
//                      //程序名
//                      AProgram:String;
//                      //功能名
//                      AFunction:String;
//                      //页面类型
//                      APageType:String;
//                      //页面名,如果为空,则加载默认页面
//                      APageName:String;
//                      //页面的平台,web,pc,app,wxapp
//                      APlatform:String;
//                      //加载设置
////                      ALoadDataSetting:TLoadDataSetting;
//                      AIsNeedHideFrame:Boolean;
//                      //返回
//                      AOnReturnFrame:TReturnFromFrameEvent;
//                      AFromPageFrameIntf:IPageFrame):Boolean;overload;
    function ShowPage(APageName:String;
                      //返回事件
                      AOnReturnFrame:TReturnFromFrameEvent=nil;
                      AFromPageInstance:TPageInstance=nil):TFrame;overload;//override;

    function CreateFrame(APage:TPage):TFrameBasePage;
    function GetPageFrameClass(APage:TPage):TFrameClass;
    //直接显示页面
    function DoShowPageFrame(APage:TPage;
  //                            ALoadDataSetting:TLoadDataSetting;
                              AIsNeedHideFrame:Boolean;
                              //返回
                              AOnReturnFrame:TReturnFromFrameEvent;
                              AFromPageInstance:TPageInstance):TFrameBasePage;

//    //选择页面点击返回事件
//    procedure DoSelectFrameListControlClickItem(AItem: TSkinItem);

//    function FindPageFrame(APageInstance:TPageInstance):TFrameBasePage;
//  published
//    //自定义的页面显示事件
//    property OnNeedShowPage:TOnNeedShowPageEvent read FOnNeedShowPage write FOnNeedShowPage;
//    //自定义的页面返回事件
//    property OnCustomProcessPageAction:TOnCustomProcessPageActionEvent read FOnCustomProcessPageAction write FOnCustomProcessPageAction;
  end;




  TOpenPlatformBindDataSourceManager=class(TLocalJsonBindDataSourceManager)
  public
    //商家版登录后商家信息
    //$login_shop.fid
    FLoginShopJson:ISuperObject;
    //用户登录后用户信息
    //$login_user.fid
    function GetLoginUserJson:ISuperObject;
  public
    function GetParamValue(AValueFrom:String;AParamName:String):Variant;override;
    procedure SetParamValue(AValueFrom:String;AParamName:String;AValue:Variant);override;
  end;




var
  //主程序
  GlobalOpenPlatformFramework:TOpenPlatformFramework;


//var
//  //设置列表项样式设置页面
//  GlobalListItemStyleListPage:TPage;
//  GlobalListItemStyleListPageFrame:TFrame;


////显示页面
//procedure ShowPageFrame(AProgram:String;
//                      AFunction:String;
//                      APageName:String;
//                      APageType:String;
//                      APlatform:String;
////                      ALoadDataSetting:TLoadDataSetting;
//                      AIsNeedHideFrame:Boolean;
//                      //返回
//                      AOnReturnFrame:TReturnFromFrameEvent);overload;
//function ShowPageFrame(APage:TPage;
////                      ALoadDataSetting:TLoadDataSetting;
//                      AOnReturnFrame:TReturnFromFrameEvent):TFrame;overload;

//function ShowListItemStyleSettingFrame(AOnReturnFrame:TReturnFromFrameEvent):TFrame;


implementation



//function ShowListItemStyleSettingFrame(AOnReturnFrame:TReturnFromFrameEvent):TFrame;
//begin
//  if GlobalListItemStyleListPage=nil then
//  begin
//    GlobalListItemStyleListPage:=TPage.Create(nil);
//  end;
//  GlobalListItemStyleListPageFrame:TFrame;
//
//end;


//function ShowPageFrame(APage:TPage;
////                      ALoadDataSetting:TLoadDataSetting;
//                      AOnReturnFrame:TReturnFromFrameEvent):TFrame;
//begin
//  Result:=GlobalOpenPlatformFramework.DoShowPageFrame(APage,
////                                                      ALoadDataSetting,
//                                                      False,
//                                                      AOnReturnFrame);
//end;
//
//procedure ShowPageFrame(AProgram:String;
//                      AFunction:String;
//                      APageName:String;
//                      APageType:String;
//                      APlatform:String;
////                      ALoadDataSetting:TLoadDataSetting;
//                      AIsNeedHideFrame:Boolean;
//                      //返回
//                      AOnReturnFrame:TReturnFromFrameEvent);
//begin
//  GlobalOpenPlatformFramework.ShowPage(AProgram,
//                                      AFunction,
//                                      APageType,
//                                      APageName,
//                                      APlatform,
////                                      ALoadDataSetting,
//                                      AIsNeedHideFrame,
//                                      AOnReturnFrame);
//end;

{ TOpenPlatformFramework }

//procedure TOpenPlatformFramework.tteShowPageExecuteEnd(ATimerTask: TTimerTask);
//var
//  APage:TPage;
//begin
//  try
//    if TTimerTask(ATimerTask).TaskTag=TASK_SUCC then
//    begin
////      ASuperObject:=TSuperObject.Create(TTimerTask(ATimerTask).TaskDesc);
////      if ASuperObject.I['Code']=200 then
////      begin
//
//        APage:=TPage(ATimerTask.TaskObject);
//
//        //显示页面
//        Self.DoShowPageFrame(APage,
////                              FLoadDataSetting,
//                              FIsNeedHideFrame,
//                              FOnReturnFrame,
//                              FFromPageInstance);
//
//
////      end
////      else
////      begin
////        //登录失败
////        ShowMessageBoxFrame(Self,ASuperObject.S['Desc'],'',TMsgDlgType.mtInformation,['确定'],nil);
////      end;
//
//    end
//    else if TTimerTask(ATimerTask).TaskDesc<>'' then
//    begin
//      //网络异常
//      {$IFDEF FMX}
//      ShowMessageBoxFrame(nil,TTimerTask(ATimerTask).TaskDesc);
//      {$ENDIF}
//    end
//    else //if TTimerTask(ATimerTask).TaskTag=1 then
//    begin
//      //网络异常
//      {$IFDEF FMX}
//      ShowMessageBoxFrame(nil,'网络异常,请检查您的网络连接!');
//      {$ENDIF}
//    end;
//  finally
//    {$IFDEF FMX}
//    HideWaitingFrame;
//    {$ENDIF}
//  end;
//end;

constructor TOpenPlatformFramework.Create(AOwner:TComponent);
begin
  Inherited;

//  FPageFrameList:=TBaseList.Create(ooReference);


//  GlobalMainProgramSetting.OnNeedShowPage:=DoNeedShowPage;
//  GlobalMainProgramSetting.OnCustomProcessPageAction:=DoCustomProcessPageAction;
end;

function TOpenPlatformFramework.CreateFrame(APage: TPage): TFrameBasePage;
begin
  if SameText(APage.page_type,Const_PageType_EditPage) then
  begin
    Result:=TFrameBaseEditPage.Create(Application);
  end
  else if SameText(APage.page_type,Const_PageType_ListPage) then
  begin
    Result:=TFrameBaseListPage.Create(Application);
  end
  {$IFDEF VCL}
  else if SameText(APage.page_type,Const_PageType_TableManagePage) then
  begin
    Result:=TFrameBaseTableManagePage.Create(Application);
  end
  {$ENDIF}
  else if SameText(APage.page_type,Const_PageType_ViewPage) then
  begin
    Result:=TFrameBaseViewPage.Create(Application);
  end
  else
  begin
    Result:=TFrameBasePage.Create(Application);
  end;
  SetFrameName(Result);
end;

function TOpenPlatformFramework.GetPageFrameClass(APage: TPage): TFrameClass;
begin
  if SameText(APage.page_type,Const_PageType_EditPage) then
  begin
    Result:=TFrameBaseEditPage;
  end
  else if SameText(APage.page_type,Const_PageType_ListPage) then
  begin
    Result:=TFrameBaseListPage;
  end
  {$IFDEF VCL}
  else if SameText(APage.page_type,Const_PageType_TableManagePage) then
  begin
    Result:=TFrameBaseTableManagePage;
  end
  {$ENDIF}
  else if SameText(APage.page_type,Const_PageType_ViewPage) then
  begin
    Result:=TFrameBaseViewPage;
  end
  else
  begin
    Result:=TFrameBasePage;
  end;
end;

destructor TOpenPlatformFramework.Destroy;
begin

//  FreeAndNil(FPageFrameList);

  inherited;
end;

//procedure TOpenPlatformFramework.DoSelectFrameListControlClickItem(
//  AItem: TSkinItem);
//begin
//  HideFrame;
//  ReturnFrame;
//end;

function TOpenPlatformFramework.DoShowPageFrame(APage: TPage;
                  //                                ALoadDataSetting:TLoadDataSetting;
                                                AIsNeedHideFrame:Boolean;
                                                AOnReturnFrame:TReturnFromFrameEvent;
                                                AFromPageInstance:TPageInstance): TFrameBasePage;
var
  ABasePageFrameClass:TFrameClass;
  ABasePageFrame:TFrameBasePage;
  I: Integer;
  AForm:TForm;
  AFramePopupStyle:TFramePopupStyle;
begin
  {$IFDEF FMX}
  if AIsNeedHideFrame then
  begin
    HideFrame;
  end;
  {$ENDIF}



//  //判断是否打开过
//  ABasePageFrame:=nil;
//  for I := 0 to GlobalOpenPlatformFramework.FPageFrameList.Count-1 do
//  begin
//    if TFrameBasePage(GlobalOpenPlatformFramework.FPageFrameList[I]).PageInstance.PageStructure=APage then
//    begin
//      ABasePageFrame:=TFrameBasePage(GlobalOpenPlatformFramework.FPageFrameList[I]);
//      Break;
//    end;
//  end;
//
//  if ABasePageFrame=nil then
//  begin
//    //每次都创建页面
//    ABasePageFrame:=Self.CreateFrame(APage);



  AFramePopupStyle.Clear;
  {$IFDEF VCL}
  //设置弹出窗体的尺寸
  if (APage.design_width>0) and (APage.design_height>0) then
  begin
    AFramePopupStyle.PopupWidth:=Ceil(APage.design_width);
    AFramePopupStyle.PopupHeight:=Ceil(APage.design_height);
  end;
  {$ENDIF}

//  {$IFDEF FMX}
//  HideFrame;
//  {$ENDIF}

  ABasePageFrame:=nil;
  ABasePageFrameClass:=GetPageFrameClass(APage);
  ShowFrame(TFrame(ABasePageFrame),ABasePageFrameClass,{$IFDEF VCL}nil{$ENDIF}{$IFDEF FMX}Application.MainForm{$ENDIF},nil,nil,AOnReturnFrame,Application,True,True,TUseFrameSwitchEffectType.ufsefDefault,False,@AFramePopupStyle);



    {$IFDEF FMX}
    ABasePageFrame.LoadPage(APage,AFromPageInstance);//,//,ALoadDataSetting
//                            AFromPageFrameIntf);
    {$ENDIF}
    {$IFDEF VCL}
    ABasePageFrame.LoadPage(APage,//,ALoadDataSetting
                            AFromPageInstance);
    {$ENDIF}
//    FPageFrameList.Add(ABasePageFrame);
//  end
//  else
//  begin
//
//  end;



  {$IFDEF VCL}
  ABasePageFrame.FrameResize(nil);
  AForm:=GlobalFrameFormMapList.FindByFrame(ABasePageFrame).FForm;

  AForm.Caption:=APage.caption;
  if SameText(APage.page_type,Const_PageType_TableManagePage) then
  begin
    AForm.BorderStyle:=bsSizeable;
  end;
  {$ENDIF}


  Result:=ABasePageFrame;
end;

//function TOpenPlatformFramework.FindPageFrame(APageInstance: TPageInstance): TFrameBasePage;
//var
//  I:Integer;
//begin
//  //判断是否打开过
//  Result:=nil;
//  for I := 0 to Self.FPageFrameList.Count-1 do
//  begin
//    if TFrameBasePage(Self.FPageFrameList[I]).PageInstance=APageInstance then
//    begin
//      Result:=TFrameBasePage(Self.FPageFrameList[I]);
//      Break;
//    end;
//  end;
//
//end;

function TOpenPlatformFramework.ShowPage(APageName: String;
                                          AOnReturnFrame: TReturnFromFrameEvent;
                                          AFromPageInstance:TPageInstance): TFrame;
var
  APage:TPage;
begin
  Result:=nil;

  APage:=GlobalMainProgramSetting.FProgramTemplate.PageList.Find(APageName);
  if APage=nil then
  begin
    ShowMessage('找不到该页面:'+APageName);
    Exit;
  end;
  Result:=DoShowPageFrame(APage,True,AOnReturnFrame,AFromPageInstance);

end;

procedure TOpenPlatformFramework.DoCustomProcessPageAction(Sender: TObject;
  APageInstance: TObject;
  AAction:String;
  AFieldControlSettingMap:TObject;
  var AIsProcessed:Boolean);
var
  AForm:TForm;
  ASuperObject:ISuperObject;
  ABasePageFrame:TFrameBasePage;
begin

  Inherited;

//  if Assigned(FOnCustomProcessPageAction) then
//  begin
//    FOnCustomProcessPageAction(Sender,APageInstance,AAction,AIsProcessed);
//  end;

//  if not AIsProcessed then
//  begin
//    {$IFDEF FMX}
//    HideFrame;
//    ReturnFrame;
//    {$ENDIF}
//  end;


  if APageInstance<>nil then
  begin
      if     //编辑页面类型,保存完之后关闭
              (TPageInstance(APageInstance).PageStructure.page_type=Const_PageType_EditPage)
              and ( (AAction=Const_PageAction_AfterSaveRecord)
                    or (AAction=Const_PageAction_AfterCancelAddRecord)
                    or (AAction=Const_PageAction_AfterCancelEditRecord))
        //其他页面类型
        or (AAction=Const_PageAction_ReturnPage)
        or (AAction=Const_PageAction_ClosePage) then
      begin

          {$IFDEF VCL}
          //改的时候注意，所有Page在保存之后，都会调用这个方法的
          if APageInstance.Owner is TFrameBasePage then
          begin
//            if FPageFrameList.IndexOf(APageInstance.Owner)<>-1 then
//            begin
//                //要看Frame是怎么显示的,如果是通过ShowFrame显示的,那么
//                HideFrame(TFrame(APageInstance.Owner));
//                ReturnFrame(TFrame(APageInstance.Owner));
//            end
//            else
//            begin
                if GlobalFrameFormMapList.FindByFrame(TFrame(APageInstance.Owner))<>nil then
                begin
                  AForm:=GlobalFrameFormMapList.FindByFrame(TFrame(APageInstance.Owner)).FForm;
                  AForm.Close;
                end;
//            end;

          end;
          {$ENDIF}

          {$IFDEF FMX}
          HideFrame;
          ReturnFrame;
          {$ENDIF}

      end;
  end;


//  if (AAction=Const_PageAction_JumpToPage) then
//  begin
//    AIsProcessed:=True;
//    //  public
//    //    jump_to_page_program:String;//	nvarchar(255)	跳转到指定的页面的程序模板name,比如ycliving
//    //    jump_to_page_function:String;//	nvarchar(255)	跳转到指定的页面的功能name,比如shop_goods_manage
//    //    jump_to_page_name:String;//	nvarchar(255)	跳转到指定的页面的页面name,比如goods_list_page
//    //    jump_to_page_type:String;//	nvarchar(255)	跳转到指定的页面的页面类型,list_page
//    //
//    //    jump_to_page_fid:Integer;//	int	跳转到指定的页面的页面fid,比较直接
//    //    jump_to_page_action:String;//跳转到指定的页面的页面之后，让它干什么
//
//    ABasePageFrame:=TFrameBasePage(ShowPage(AFieldControlSettingMap.Setting.jump_to_page_name,
//                                            //                ALoadDataSetting,
//                                            //                True,
//                                                            nil,
//                                                            APageInstance));
//    if AFieldControlSettingMap.Setting.jump_to_page_action<>'' then
//    begin
//      ABasePageFrame.PageInstance.DoCustomPageAction(AFieldControlSettingMap.Setting.jump_to_page_action);
//    end;
//
//
//  end;


  //从控件点击过来的选择日期范围
  if (AFieldControlSettingMap<>nil) and (AAction=Const_PageAction_SelectDateArea) then
  begin
      {$IFDEF FMX}

      AIsProcessed:=True;
      //搜索
      HideFrame;
      ShowFrame(TFrame(GlobalSelectFilterFrame),TFrameSelectFilter,TFieldControlSettingMap(AFieldControlSettingMap).DoReturnFrame);
      ASuperObject:=TSuperObject.Create(TFieldControlSettingMap(AFieldControlSettingMap).Value);
      //完成日期
      GlobalSelectFilterFrame.Load(
                                  ASuperObject.S['StartDate'],
                                  ASuperObject.S['EndDate'],
                                  ''
                                  );
      GlobalSelectFilterFrame.pnlToolBar.Caption:='选择'+TFieldControlSettingMap(AFieldControlSettingMap).Setting.field_caption;
      {$ENDIF}
  end;


end;

//procedure TOpenPlatformFramework.DoNeedShowPage(Sender: TObject;
//                                                AFromPageFrameIntf:IPageFrame;
//                                                AFromFieldControlSettingMap:TFieldControlSettingMap;
////                                                AToPageFID:Integer;
//                                                AToPage:TPage;
////                                                ALoadDataSetting: TLoadDataSetting;
//                                                //返回
//                                                AOnReturnFrame:TReturnFromFrameEvent;
//                                                var AIsProcessed:Boolean);
//var
//  ABasePageFrame:TFrameBasePage;
//begin
//  Inherited;
//
//  if AToPage<>nil then
//  begin
//    Self.DoShowPageFrame(AToPage,
////                          ALoadDataSetting,
//                          True,
//                          AOnReturnFrame);
////  HideFrame;
////  ShowPageFrame(Self.PageStructure.EditPage,
////                ALoadDataSetting,
////                DoReturnFrameFromEditPageFrame);
//  end
//  else if (AFromFieldControlSettingMap<>nil) and (AFromFieldControlSettingMap.Setting.jump_to_page_name<>'') then
//  begin
//
//    ABasePageFrame:=ShowPage(AFromFieldControlSettingMap.Setting.jump_to_page_name,
//            //                ALoadDataSetting,
//            //                True,
//                            AOnReturnFrame);
//    if AFromFieldControlSettingMap.Setting.jump_to_page_action<>'' then
//    begin
//      ABasePageFrame.PageInstance.DoCustomPageAction(AFromFieldControlSettingMap.Setting.jump_to_page_action);
//    end;
//
//  end;
//
////  if Assigned(FOnNeedShowPage) then
////  begin
////
////  end;
//
//end;

//function TOpenPlatformFramework.ShowPage(APageFID: Integer;
//                                          //加载设置
////                                          ALoadDataSetting:TLoadDataSetting;
//                                          AIsNeedHideFrame:Boolean;
//                                          //返回
//                                          AOnReturnFrame:TReturnFromFrameEvent): Boolean;
//var
//  APage:TPage;
//begin
//  APage:=GlobalMainProgramSetting.FProgramTemplate.PageList.Find(APageFID);
//  if (APage=nil) or not (APage.IsLoaded) then
//  begin
////    FLoadDataSetting:=ALoadDataSetting;
//    FIsNeedHideFrame:=AIsNeedHideFrame;
//    FOnReturnFrame:=AOnReturnFrame;
//    Result:=GlobalMainProgramSetting.FProgramTemplate.LoadPage(APageFID,
//                                                              tteShowPageExecuteEnd)
//  end
//  else
//  begin
//
//    Self.DoShowPageFrame(APage,
////                          ALoadDataSetting,
//                          AIsNeedHideFrame,
//                          AOnReturnFrame);
//  end;
//
//end;

//function TOpenPlatformFramework.ShowPage(AProgram:String;
//                                        AFunction:String;
//                                        APageType:String;
//                                        APageName:String;
//                                        APlatform:String;
////                                        ALoadDataSetting:TLoadDataSetting;
//                                        AIsNeedHideFrame:Boolean;
//                                        AOnReturnFrame:TReturnFromFrameEvent): Boolean;
//var
//  APage:TPage;
//begin
//  APage:=GlobalMainProgramSetting.FProgramTemplate.PageList.Find(AFunction,APageType,APageName,APlatform);
//  if (APage=nil) or not (APage.IsLoaded) then
//  begin
////    FLoadDataSetting:=ALoadDataSetting;
//    FOnReturnFrame:=AOnReturnFrame;
//    FIsNeedHideFrame:=AIsNeedHideFrame;
//
//    Result:=GlobalMainProgramSetting.FProgramTemplate.LoadPage(AProgram,
//                                          AFunction,
//                                          APageType,
//                                          APageName,
//                                          APlatform,
//                                          tteShowPageExecuteEnd)
//  end
//  else
//  begin
//
//    Self.DoShowPageFrame(APage,
////                          ALoadDataSetting,
//                          AIsNeedHideFrame,
//                          AOnReturnFrame);
//  end;
//end;




{ TOpenPlatformBindDataSourceManager }

function TOpenPlatformBindDataSourceManager.GetLoginUserJson: ISuperObject;
begin
  Result:=GlobalBaseManager.User.Json;
end;

function TOpenPlatformBindDataSourceManager.GetParamValue(AValueFrom:String;
  AParamName: String): Variant;
begin
  if AValueFrom='local_data_source' then
  begin
    Result:=Self.FDataJson.V[AParamName];
  end
  {$IFDEF FMX}
  else if AValueFrom='login_shop' then
  begin
    Result:=Self.FLoginShopJson.V[AParamName];
  end
  else if AValueFrom='login_user' then
  begin
    Result:=Self.GetLoginUserJson.V[AParamName];
  end
  {$ENDIF}
  else
//  if AParamJson.S['value_from']='const' then
  begin
    Result:=Inherited;
//    Result:=AParamJson.V['value'];
  end;

end;

procedure TOpenPlatformBindDataSourceManager.SetParamValue(AValueFrom:String;AParamName: String;
  AValue: Variant);
begin
  inherited;

end;

initialization
  GlobalOpenPlatformFramework:=TOpenPlatformFramework.Create(nil);
  GlobalBindDataSourceManagerClass:=TOpenPlatformBindDataSourceManager;



finalization
  FreeAndNil(GlobalOpenPlatformFramework);



end.
