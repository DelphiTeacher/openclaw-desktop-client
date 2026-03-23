unit uDataMessages;

///
///  数据消息定义
///

interface

uses
  Messages;


type
  TNOTIFYID = Integer;

  PReturnDatas = ^TReturnDatas;
  TReturnDatas = record
    SearchID: Integer;
    URL: PChar;
    Title: PChar;
    Params: PChar;
    Body: PChar;
  end;

//  // integer 结构
//  TTaskNotifyParamRec = packed record
//    TaskID: Word;
//    ViewID: Byte;
//    Data  : Byte; // 进度 0 .. 100
//  end;
  TTaskViewRec = packed record
    TaskID: Word;
    ViewID: Word;
  end;

//  PTaskNotifyProgress = ^TTaskNotifyProgress;
//  TTaskNotifyProgress = record
//    TaskID: Integer;
//    ViewID: Integer;
//    Kind  : Integer;
//    Data: Integer;
//  end;
  TTaskProgressRec = packed record
    ViewID: Word;
    Data: Word;
  end;

  TFatchProgressRec = packed record
    TaskID: Word;
    Data: Word;
  end;

  PRequestDataRec = ^TRequestDataRec;
  TRequestDataRec = record
    ID: TNOTIFYID;      // 处理事件
    Sender: THandle;    // 请求着
    Data: string;       // Json 数据
    Handled: Boolean;   // 是否被处理
  end;

  PCommitDatasRec = ^TCommitDatasRec;
  TCommitDatasRec = record
    ID: Cardinal;
    SendDatas: string;
    ResponeData: string;
    Handled: Boolean;
  end;



const
  WM_DIFF = WM_USER + 1000;
  WM_BASEDATASEARCH = WM_DIFF;
  UFM_Baes        = WM_DIFF + 100;  // 抓取处理消息
  UWVM_Base       = WM_DIFF + 200;
  UMVM_Base       = WM_DIFF + 300;  // 主界面控制
  WMBROWSER_base  = WM_DIFF + 400;  // 浏览器的控制操作
  WMLISTENER_Base = WM_DIFF + 500;  // 监听对象内部使用
  WMINNER_Base    = WM_DIFF + 600;  // 实体内部使用，不允许外发消息

  DS_RETURNDATA     = WM_BASEDATASEARCH + 1;      /// wParam = SearchID lParam = PReturnDatas;
  DS_ParserData     = WM_BASEDATASEARCH + 2;      //
  DS_ParserFinished = WM_BASEDATASEARCH + 3;  // 数据解析完成, 同步到界面列表中
  DS_LogWriterInfo  = WM_BASEDATASEARCH + 4;  // wParam = Kind lParam = PChar
  DS_PUSHSEARCHURL  = WM_BASEDATASEARCH + 5;   // 加入URL列表 lParam = Count;


  UFM_FATCHPAGE = UFM_Baes + 1;         // 抓取数据  wParam = (int)SearchID lParam = (PChar)URL

  //UWVM_CheckTel         = UWVM_Base + 1;        /// 验证whatsapp tel ， lParam = telList, 用逗号分割tell
  //UWVM_SendTelMsg       = UWVM_Base + 3;        /// 验证whatsapp tel ，wParam = msg lParam = telList, 用逗号分割tell
  //UWVM_UpdateSendMsg    = UWVM_Base + 4;        //  验证确认 wParam = state 0(unknown) 1(Ok) 2(Err) lParam= PChar(ID)

  ///
  ///  处理流程
  ///    抓取页面数据 -> 打包数据  --> 保存到待处理列表  --> 空闲分发到注册的界面
  UWVM_ResultFatchDatas     = UWVM_Base + 7;        /// 返回抓取的数据 wParam = PChar(DataName) lParams = PChar(Json)
  UWVM_DispatchResultDatas  = UWVM_Base + 8;        /// 分发抓取的数据
  UWVM_UpdateDatas          = UWVM_Base + 9;        /// 子界面更新数据 wParam = PChar(DataName) lParams = PChar(Json)
  UWVM_REGISTUPDATEDATAS    = UWVM_Base + 10;       /// 注册更新数据对象  wParam = 0 注册 1 注销， LParam = Handle
  UWVM_SendNotify           = UWVM_Base + 11;
  UWVM_NotifyMsg            = UWVM_Base + 12;       // 通知消息  wParam = 通知类型 integer lParam 消息值 uMXConsts 单元中定义

  UWVM_RequestDatas         = UWVM_Base + 13;       // 请求数据  lParam = PRequestDataRec; // wParam = SendHandle lParam = PChar(Json)
  UWVM_CommitDatas          = UWVM_Base + 14;       // 提交数据  lParams = PCommitDatasRec;

  ///  通知状态变更
  ///  ------------------------------------------------
  NOTIFYBASE_WHATSAPP       = $1000;
  NOTIFY_ACTIONCHANGED      = NOTIFYBASE_WHATSAPP + 1;
    NAC_WHATSAPPTASKSTART     = 1;   // 任务开始
    NAC_WHATSAPPTASKFINISHED  = 2;   // 任务结束
    NAC_WHATSAPPTASKSTOP      = 3;
  // Finished
  NOTIFY_AccWhatsAppLoaded  = NOTIFYBASE_WHATSAPP + 2;   // whatsApp账号载入完成  Param = ViewID



  NOTIFY_TASKPROGRESS       = NOTIFYBASE_WHATSAPP + 3;   // 任务执行进度 百分比 lParam = PTaskNotifyProgress
  NOTIFY_TASKGROUPPROGRESS  = NOTIFYBASE_WHATSAPP + 4;   // 任务组 进度  lParam =  PTaskNotifyProgress
  NOTIFY_TASKSTART          = NOTIFYBASE_WHATSAPP + 5;
  NOTIFY_TASKFINISHED       = NOTIFYBASE_WHATSAPP + 6;   // 任务结束   lParam = PTaskNotifyProgress
  NOTIFY_TASKFAILED         = NOTIFYBASE_WHATSAPP + 7;   // 任务失败   lParam = PTaskNotifyProgress
  NOTIFY_TASKCHANGE         = NOTIFYBASE_WHATSAPP + 8;   // 任务控制   lParam = PTaskNotifyProgress
    VIEWIDBASE_Fatch        = 100;  //word

  NOTIFY_RESPONEEVENT       = NOTIFYBASE_WHATSAPP + 9;   // 请求事件返回

  NOTIFY_ChatterChanged     = NOTIFYBASE_WHATSAPP + 10;  // 聊天对象发生改变   lparam = ViewID
  NOTIFY_ChatMsgChanged     = NOTIFYBASE_WHATSAPP + 11;  //

  NOTIFY_ChatterInfoChange  = NOTIFYBASE_WHATSAPP + 12;  // 聊天对象个人信息有改变， 如头像改变
    NOTIFYVAL_CICIcon       = $0001;                     // 头像修改

  NOTIFY_DOMChanged         = NOTIFYBASE_WHATSAPP + 13;  //

  NOTIFY_AccWhatsAppChanged = NOTIFYBASE_WHATSAPP + 14;    // 账号发生改变   lparam = ViewID

  ///
  ///  搜索通知信息
  ///  --------------------------------------
  NOTIFYBASE_SEARCH         = $2000;
  NOTIFY_SEARCHEXEC         = NOTIFYBASE_SEARCH + 1;   // lParam PChar
  NOTIFY_SEARCHACTIONCHANG  = NOTIFYBASE_SEARCH + 2;
    NAC_SEARCHPUSH          = 1;
    NAC_SEARCHSTOP          = 2;
    NAC_SEARCHSTART         = 3;
    NAC_SEARCHEXEC          = 4;
    NAC_SEARCHTASK          = 5;
    NAC_CloseBrowser        = 6;

  NOTIFY_SEARCHACTIONSTATE  = NOTIFYBASE_SEARCH + 4;
    NACACTSTATE_START       = 1;
    NACACTSTATE_PAUSE       = 2;
    NACACTSTATE_CLOSE       = 3;

  NOTIFY_SEARCHUPDATEPRROGRESS = NOTIFYBASE_SEARCH + 8;     // 通知任务进度更新  lParam = TFatchProgressRec
//  NOTIFY_SEARCHUPDATEPRROGRESS
  //
  // 客户信息相关
  // --------------------------------------------------------
  NOTIFYBASE_CUSTOMINFO       = $4000;
  NOTIFY_RequestCustomInfo    = NOTIFYBASE_CUSTOMINFO + 1;    // 请求客户信息 lParam = listener handle
  NOTIFY_RequestWhatsAppInfo  = NOTIFYBASE_CUSTOMINFO + 2;
  NOTIFY_RequestCharHistory   = NOTIFYBASE_CUSTOMINFO + 4;    // 请求聊天记录
  NOTIFY_LinkWhatsAppAcc      = NOTIFYBASE_CUSTOMINFO + 5;
  NOTIFY_SaveCharHistory      = NOTIFYBASE_CUSTOMINFO + 6;
  // NOTIFY_UpdateLinkWhatsAppAcc= NOTIFYBASE_CUSTOMINFO + 7;   SUPDName_ResponeLinkWhatsAppAcc NOTIFY_UpdateLinkWhatsAppAcc


  COMMITDATA_BASE             = $8000;
  COMMITDATA_BuildCustomer    = COMMITDATA_BASE + 1; // 创建联系人



  UMVM_SwitchView   = UMVM_Base + 2;      // 切换到特定页面,  wParam = int(0, 1), 1 --- 不显示只创建
                                          //                  lParam = PChar ViewName
                                          //                  视图对象指针（只能内部使用）

  UMVM_UpdateView   =  UMVM_Base + 3;     // 第一次未显示，需要补刷一个Show，
                                          //   触发form的Show事件处理
  UM_FileTraffic    = UMVM_Base + 4;

  UBT_Base = UMVM_Base + 5;               // 浏览器任务控制器消息
  UBT_Exec  = UBT_Base + 1;               // 执行当前任务  wParam = Pchar(msgID), lParam = PChar(MsgData)
  UBT_Pause = UBT_Base + 2;               // 暂停任务


  ///
  ///  浏览器控制消息
  ///  --------------------------------------
  WMBROWSER_RELOADPAGE    = WMBROWSER_base + 1;
  //WMBROWSER_DispatchTask  = WMBROWSER_base + 2;  // 通知执行任务，根据模块确定执行实际  wParam = TTaskViewRec
  WMBROWSER_RemoveTask    = WMBROWSER_base + 4;  // 清除任务 lParam = 0, 全部清除
  WMBROWSER_OpenURL       = WMBROWSER_base + 5;  //  wParam = 1 (设置为默认) lParam = PChar(URL)
  WMBROWSER_FatchData     = WMBROWSER_base + 6;  // 抓取浏览器特定数据 lParam = Json(extractdata = )
  WMBROWSER_FatchTask     = WMBROWSER_base + 7;  // 抓取浏览器特定数据 lParam = Json(extractdata = )
  WMBROWSER_SearchAction  = WMBROWSER_base + 8;  // 浏览器功能处理 wParam = Action
    WSACTSTATE_START       = 1;
    WSACTSTATE_PAUSE       = 2;
    WSACTSTATE_CLOSE       = 3;
  WMBROWSER_OpenWhatsApp  = WMBROWSER_base + 9;     // 直接打开WhatsApp账号进行 lParam = PChar()
  WMBROWSER_QuickSendMsg  = WMBROWSER_base + 11;    // 快速恢复 lParam = PChar(msg)
  WMBROWSER_TaskData      = WMBROWSER_base + 12;    // Task统一管理, 这个消息只能使用在已确定的任务执行对象上
                                                    // wParam = 0, lParam = 0 查寻当前模块任务数量

  WMBROWSER_PageTabActive  = WMBROWSER_base + 13;    // 页签是否被激活 wParam = 1 active 0 invalid 同（WM_ACTIVATE）
//  WMBROWSER_WhatsAppLoaded = WMBROWSER_base + 14;    // WhatsApp 账号加载完成
  WMBROWSER_ExecScript     = WMBROWSER_base + 15;    /// wParam = 'RETRIEVEDOM name'  lParam = PChar(Config) PetrieveFatchDatas
  ExecScriptType_Task      = 'Task';                 ///   wParam = '':  直接执行脚本
                                                     ///  wParam  = 'task'

                                                     ///
  WMBROWSER_NotifyView    = WMBROWSER_base + 16;    ///  请求信息返回 wParam = NOTIFYVIEWID, lParm = Params
    NOTIFYVIEWID_Open             = 1;              //   打开  lParam = 需要打开的视图ID（integer）
    NOTIFYVIEWID_Close            = 2;              //
      VIEWID_ChatHistory  = 1;
    NOTIFYVIEWID_Unloaded         = 3;              //   视图已经卸载完成，可以释放
    NOTIFYVIEWID_DispatchTask     = 4;              // 任务分派  lParam = PChar
    NOTIFYVIEWID_ClearTask        = 5;              // 清除任务（包括停止）

  //WMBROWSER_OpenView       = WMBROWSER_base + 17;    /// 打开特定页面
                                                     /// wParam = 需要打开视图的ID
                                                     ///  lParam = 1 打开
                                                     ///           0 关闭
                                                     ///
//  WMBROWSER_CloseView      =  WMBROWSER_base + 20;   /// wParam = 实体指针
  //WMBROWSER_ChromeClose    =  WMBROWSER_base + 21;   /// 浏览器关闭完成  wParam = Sender

  WMBROWSER_CloseBrowser   =  WMBROWSER_base + 22;   /// 请求子视图关闭， wParam = handle (当前发起请求关闭视图的Handle)
                                                     ///   这个主要解决 Chrome的延迟释放处理
                                                     ///   return = 0, 可以直接释放，
                                                     ///   return = 1, 需要等待，视图内部处理完成后，再通知主对象进行释放
  WMBROWSER_ResponeClose   =  WMBROWSER_base + 23;   ///  和 WMBROWSER_CloseBrowser 成对
  ///
  ///  监听对象内容使用
  ///
  /// Base = WMLISTER_Base
  WMLISTENER_NotifyUpdate = WMLISTENER_Base + 1;

  ///
  ///  实体内部消息
  ///  base WMINNER_Base
  WMINNER_Notify    = WMINNER_Base + 1;   /// 实体内部的消息，不允许广播
  ///
  ///

const
  E_INVALIDDATAFMT = $1001; //  无效数据格式


  ViewParamID_AutoTrans = 1;


  // 调度功能

  DispFunID_TranText = $0001;  //  翻译


implementation

end.
