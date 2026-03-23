unit uLangRes;

interface

resourcestring
  STITLE_PickCols = '选择列';

  SCAPTION_CustLevel = '客户等级：';
  SCAPTION_CustName = '姓名：';
  SCAPTION_CustPhase = '客户阶段:';
  SCAPTION_NOTE = '备注：';
  STITLE_CONTACTINFO =  '联系人信息';

  SCAPTION_CustSource = '客户来源：';
  SCaption_CustTitle = '客户名称：';
  SCAPTION_CustNum = '客户编号：';
  SCAPTION_CustCountry = '所在国家：';

  SCAPTION_CustMail = '邮箱：';
  SCAPTION_CustPhone = '手机：';
  SCAPTION_CustTracker = '最后跟进：';
  SCAPTION_CustModified = '修改用户：';
  SCAPTION_CustCreation = '创建用户：';
  SCAPTION_CustType = '客户类型：';
  SCAPTION_CustState = '客户状态：';
  SCAPTION_ExportOpenFile = '导出完成打开文件';
  SACTION_IncludePrefix = '只导出以下号码开头';
  SACTION_ExcludePrefix = '排除以下号码开头';
  SACTION_ALL = '全部';
  STITLE_ExportFilter = '过滤内容';
  SDLG_ExportData = '导出内容';
  SDLG_SendMessage = '发送消息';
  SHINT_CollapseContentInfo = '收拢联系人';
  SHINT_EXPContentInfo = '展开联系人';
  STITLE_FirmInfo = '公司信息';
  STITLE_OwnerItem = '所属：';
  SDATA_StrangeCustomer = '陌生客户';
  STITLE_WhatsappTaskList = '任务列表';
  STITLE_QuickMsg = '快速文本';
  SHINT_RememberMe = '记住密码';
  SHINT_VAR_WAITSEND = '等待发送(%s) ...';
  SAppTitle = 'MX搜索';
  SACTION_ONLINEHELP = '在线客服';
  SACTION_CopyCell = '复制单元格';
  SMODULE_SearchResult = '搜索记录';
  SMODULE_Contacts = '客户信息';
  SMODULE_Search = '客户发现';
  SMODULE_WhatsApp = 'WhatsApp';

  // uAppControls
  SMSG_CreateDirFailed = '创建目录失败';
  SSMSG_SearcherAppControlInterfaceError = '搜索服务错误, 未正常初始化AppControl ';

  // uBrowserTasks
  SMSG_TaskWaitErr = '任务等待执行次数异常 ';
  SMSG_TaskRound = '，可能是死循环';

  // uDataFieldDefConsts
  SColTitle_Contact = '联系人';
  SColTitle_OperatingWhatsApp = '运营WhastaApp';
  SColTitle_OperatingAccount = '运营账号';
  SColTitle_Source = '来源';
  SColTitle_CompanyName = '公司名称';
  SColTitle_Date = '联系时间';
  SColTitle_Whatsapp = 'WhatsApp';
  SColTitle_QuickMsg = '快速回复内容';
  SColTitle_Senddate = '发送时间';
  SColTitle_Message = '内容';
  SColTitle_State = '状态';
  SColTitle_Phone = '手机';
  SColTitle_Name = '姓名';
  SColTitle_Mail = '邮箱';
  SColTitle_tel = '电话';
  SColTitle_jobs = '职位';
  SColTitle_dept = '部门';
  SColTitle_NickName = '昵称';
  SColTitle_Owner = '拥有人';
  SColTitle_Job = '职位';
  SColTitle_Sex = '性别';
  SColTitle_Send = '发送';
  SColTitle_Status = '状态';
  SColTitle_URL = 'URL';
  SColTitle_ReviewsCount = '回复数量';
  SColTitle_Rating = '评分';
  SColTitle_PhoneNumber = '电话';
  SColTitle_Website = '网站';
  SColTitle_Address = '地址';
  SColTitle_Address2 = '地址2';
  SColTitle_Address1 = '地址1';
  SColTitle_Cetegory = '分类';
  SColTitle_BusinessName = '名称';
  SColTitle_ResultType = '结果类型';
  SColTitle_BussinessLink = '链接';
  SColTitle_PiceRange = '价格范围';
  SColTitle_Reviews = '回复数量';
  SColTitle_LocalityAddress = '位置';
  SColTitle_StreetAddress = '街区';
  SColTitle_ChatGroup = '群组';
  SColTitle_Keyword = '关键字';
  SColTitle_Title = '名称';
  SColTitle_Email = '邮箱';
  SColTitle_Master = '决策角色';
  SColTitle_custName = '客户';
  SColTitle_ContName = '联系人';

  // uDataParsers
  SMSG_ErrAttConfig = '属性配置错误';

  // uHttpRequestAPI
  SMSG_InvalidAPI = '无效API';

  // umxComponents
  SHINT_SearchContent = '搜索内容';

  //
  SInvalidAPI = '无效API: ';

  SERR_CONNECTSERVER = '网络链接异常';
  SMSG_PickExportCols = '请选择需要导出的列';

  SVERITYSTATE_None = '';
  SVERITYSTATE_Overtime = '超时';
  SVERITYSTATE_Invalid = '无效';
  SVERITYSTATE_Valid = '有效';
  SVERITYSTATE_NoLogin = '有效';// 'NoLogin';
  SVERITYSTATE_Lose   = '作废';// 'NoLogin';
  SVERITYSTATE_Processing = '...';

  SSENDSTATE_Failed = '失败';
  SSENDSTATE_Succeed = '发送';
  SSENDSTATE_Overtime = '超时';
  SSENDSTATE_Ignore   = '忽略';
  SSENDSTATE_Answer   = '回复';

  // uMXControls
  SMSG_NotCreateDataThread = 'TCommitDataSvr 线程数据无法创建';
  SMSG_ERRParser = '解析错误: ';
  SMSG_InvalidCompanys = '账号下未发现有授权';
  SMSG_CEFFatchInit = 'CEF页面抓取未初始化';

// START resource string wizard section
  SMSG_UploadFILEOVERSize = '文件过大，上传文件不能超过2G';

  // uWhatsAppControls
  SMSG_TASKITEMTYPE = 'TWhatsAppTaskItem.Valid 枚举类型未处理';
  STITLE_CUSTOM = '客户名称';
  STITLE_USERName = '联系人姓名';
  STITLE_UserTel = '联系人手机';
  STITLE_UserMail = '联系人邮箱';
  SMSG_NotReadUser = '无法读取联系人导入文件 ';
  SMsg_BindNotEmpty = '绑定账号不能为空';
  SMSG_NotLoadWhatsApp = '当前WhatsApp账号未加载';
  SHINT_ChatMsgPrefix = '我:';

  // ContactsFrame
  SAction_Search = 'Search';
  STITLE_ContactSearchErr = '搜索失败:';
  STITLE_ContactKeyUser = '关键决策人';
  STITLE_ContactAssUser = '辅助决策人';
  STITLE_ContactDEFUser = '普通角色';
  SHINT_ContactDataCount = '共%d条';
  STITLE_ContactOwner = '所属: ';
  SCAPTION_GOTO = '前往';
  SCAPTION_PAGE = '页';

  // untCreateCustFrame
  SBTN_Cancel = '取消';
  SMSG_CustExistsCust = '获取MX已有客户%s失败，错误:%s';
  SMSG_CustCancelAsk = '未保存数据，您确定要取消建档吗？';
  SMSG_CancelBuildCust = '取消建档';
  SMSG_CustQuickBuild = '快速建档';
  SMSG_CustBuildSucceed = '建档成功';
  SMSG_CustParamInvalidCustName = '客户名称必填!';
  SMSG_CustParamInvalidOptNum = '保存失败!保存操作码错误:';
  SMSG_CustParamInvalidDept = '保存失败!所属部门默认错误.';
  SMSG_CustSaveParamInvalid = '保存失败!参数错误:';

  // untCustomerEdit
  STITLE_EditCust = '客户编辑';
  STITLE_EditUser = '联系人编辑';
  SBTN_CLOSE = '关闭';
  SMSG_EditSaveAsk = '您有修改的信息未保存，需要保存吗？';
  SMSG_SaveSucceed = '保存成功!';
  SMSG_DuplicateSocialAccount = '社交类型不能重复!';
  SHINT_AddSocialAcc = '添加社交账号';
  SHINT_AddMail = '添加邮箱账号';
  STITLE_SaveUser = '保存联系人';
  STITLE_SaveCust = '保存客户';
  SHINT_DelMail = '删除邮箱账号';
  SHINT_DelSocialAcc = '删除社交账号';

  // untHttpClient
  SSATE_Review = '审核中';
  SMSG_ErrDownPic = '下载图片错误：';
  SMSG_ErrNet = '您的网络开小差啦，请检查网络后重试!';
  SMSG_ErrFoundWhatsApp = '根据WhatsApp查询客户错误：';
  SMSG_ErrSearchMXDict = '查询MX数据字典错误：';
  SMSG_GetDept = '获取部门错误：';
  SMSG_ErrAuthorization = '授权错误:';
  SMSG_SuccAuth = '授权验证通过';
  SMSG_ERROtherPCBind = '授权错误:此账号已绑定其它电脑';
  SMSG_ErrAuthNotEnough = '授权数不足';
  SMSG_AuthAutoBind = '有授权数,自动绑定电脑';
  SMSG_RequestErr = '网络请求错误: ';
  SMSG_NotToken = '未获取令牌';
  SMSG_PhoneNotVerify = '手机号未验证';
  SMSG_MailNotVerify = '邮箱未验证';
  SMSG_PwdTooManyRetries = '密码输入错误超过5次';
  SMSG_CreateErr = 'Execute创建错误：';

  // ucgPopupDlgDocks
  SBTN_OK = '确定(&O)';
  SBTN_Cancal = '取消(&C)';
  SMSG_BUILDDlgErr = '创建Dlg异常： ';

  // udlgImportCustomAddressbooks
  //SCOLTITLE_STATE = '状态';
  SACTION_Close = '关闭';
  SACTION_Import = '导入数据';
  SHINT_SelectImportFile = '选择导入的文件';
  SDlgTitle_Import = '选择导入文件';

  SDLGACT_Cancel = '取消';
  SDLGACT_EXport = '导出';

  SDLGTitle_ImportWahtsApp = 'WhatsApp 号码列表';

  SLABLE_Owner = '所属: ';
  SBTN_EditCust = '编辑客户';
  SCOLTITLE_UserName = '姓名';

  // ufraWhatsAppDataInfo
  SActTitle_OpenChat = '发起聊天';
  SActTitle_RemoveSelectWAList = '删除账号';
  SActTitle_ClearInvalidStates = '清除无效验证状态';
  SActTitle_JoinGroup = '加入群组';
  SActTitle_CreateGroup = '智能建群';
  SActTitle_FatchGroupUser = '提取群组';
  SActTitle_CloseTask = '关闭任务';
  SActTitle_ClearSendedWAList = '清除已经发送的帐号';
  SActTitle_ClearInvalidWAList = '清除验证无效账号';
  SActTitle_ClearWAList = '清除';
  SActTitle_ExportWAList = '导出';
  SActTitle_ImportWAList = '导入';
  SActTitle_StartVerify = '验证账号';
  SActTitle_SendMessage = '发送消息';

  STITLE_PageCust = '客户信息';
  STITLE_ChatRec = '聊天记录';
  STITLE_QuickBuildCust = '快速建档';
  STITLE_AddBook = '通讯录';
  SHINT_ParserErr = '解析错误: ';
  SDLGTITLE_BatchImportGroup = '批量加入群组';
  SLABEL_AutoFatchGroupUser = '自动抓取群组';
  STITLE_TaskList = '任务列表';

  SLABEL_AutoTrans = '自动翻译';
  SHINTMSG_ImportGroupUser = '导入群组联系人完成，共增加%d条。';
  SDLGTitle_TASKHINT = '任务提示';
  SMSG_ClearTask = '当前有任务在处理是否要取消，重新设置任务？';
  SDLGTitle_Info = '消息';
  SMSG_SendNumberPleaseImport = '没有可发送的账号，请导入再试。';
  SDLGTitle_Clear = '清除';
  SMsg_DoYouWantToClearAll = '是否要清除当前列表账号？';

  STitle_HistoryTabMe = '我的';
  STitle_HistoryTabAll = '全部';
  SACTTitle_Search = '搜索';
  SHINT_CloseMsgList = '关闭聊天记录';
  SHINT_UnBindUser = '未绑定的联系人信息';
  SHINT_NOFoundUser = '无有联系人';
  SMSG_NOTFoundData = '无法获取界面的数据源 TDlgSearchView.LoadDatas';
  SHINT_NOTMSG = '(没有聊天消息)';
  SDlgTitle_SearchChatter = '搜索联系人';
  SACT_ImportCustoms = '导入联系人';
  SACT_DetailCustomer = '客户详情';
  SACT_TransferCustomer = '转交';
  SACT_RemoveCustomer = '删除';

  SDLGMSG_OVERFile = '生成模板文件已经存在'#13#10'%s'#13#10'是否要覆盖？';
  SDLGTITLE_SaveTmp = '保存模板文件';
  SACT_DownImpTmp = '下载模板';
  SACT_Import = '导入';
  SACT_ImportFromTmp = '从文件模板导入';
  SITEMHINT_notdata = '暂无相关内容';
  SITEMHINT_Search = '搜索 ';

  SDATA_ChatMsgPrefix = '我:';

  SHINT_NOTDATATYPE = '数据类型错误';

  SAct_Copy = '复制';
  SAct_Send = '发送';
  SAct_GetLastMsg = '提取最近';
  SAct_Transfer = '翻译';
  SHINT_InputTransText = '请输入需要翻译的文字';

  // uSearchPanels
  SHINT_Demo = '内部演示版';
  SLAB_Filter = '过滤词';
  SLAB_Domain = '域名';
  SLAB_MailSuffix = '邮箱后缀';
  SHINT_MailKeys = '多个关键词用空格隔开，例：@gmail.com';
  SHINT_DomainKeys = '多个关键词用空格隔开，例：facebook.com';
  SHINT_FilterKeys = '多个过滤词用空格隔开';
  SCAPTION_MuiHint = '多个关键词用空格隔开';
  SCAPTIONLAB_Key = '关键词';
  SBTNCAPTION_STOP = '停止';
  SBTNCAPTION_Search = '搜索';


  // uQuickSendMsgViews
  STitle_AddQuickMsg = '新增快速回复';
  SAct_Del = '删除';
  SAct_Add = '新增';
  // uMaintainCustomerViews
  SHint_NotCustomer = '暂无相关信息';
  SCaption_Search = '搜索';

  // ufrmWhatsAppViews
  STITLE_FATCHGROUP = '提取群组';
  STITLE_JOINGROUP = '加入群组';
  SHINT_LOSTPHONTSIGNAL = '网络信号丢失，请检查手机和电脑VPN是否正常连接';//'手机网络信号丢失，请检查手机网络是否正常';
  SMSG_InitAccInfo = '当前账户信息无法读取，请增加账号头像后重试载入账号。';
  SACT_ReloadAccInfo = '重新获取当前WhatsApp账号信息';
  STITLE_MaskTitleDefault = '执行任务';
  STITLE_MaskTitleFatchGroupUser = '提取群组';
  STITLE_SENDER = '发送';
  STITLE_Verify = '验证';
  SMSG_INVALIDNET = '网络错误，无法加载WhatsApp页面';

  SACT_ReloadView = '重载WhatsApp界面 ...';

  // ufrmWhatsApps
  SHINT_AccountLoading = '加载 ...';

  // ufrmLogin
  SDLG_Login = '登录';
  SMSG_NOTSELEE = '未选择登录企业';
  SMSG_NETERR = '网络连接错误 ';
  SMSG_SelectCust = '请选择公司';
  SMSG_NOTAuthFirm = '没有可登陆企业，可能您没有开通许可';
  SHINT_INNTEST = '(内部测试)';
  SACT_OK = '确定';
  SACT_Login = '登录';

  //分页标签名
  // ufraViewSearcher
  STitle_SearchIns = 'Instagram';
  STitle_SearchYelp = 'Yelp';
  STitle_SearchGoogleMap = 'Google Map';
  STitle_SearchWhatsappGroup = 'Whatsapp群组';
  STitle_SearchGoogle = 'Google';
  SHINT_FATCHPAGEDATA = '抓取页面数据';
  SMSG_NOTNET = '网络错误，无法加载页面';

  // ufraViewSearcher
  SCAPTION_SEC = '秒';
  SCAPTION_WAITTIME = '等待：';
  SCAPTION_PageCount = '页数';
  SHINT_ImportTarget = '输入目标网址';
  SHINT_MailExp = '样式: @gmail.com';
  SHINT_SearchCountry = '搜索国家';
  SCAPTION_Keys = '关键词：';
  SCAPTION_Wait = '随机等待：';
  SCAPTION_PageNum = '页码：';
  SCAPTION_FatchSite = '提取平台：';
  SCAPTION_MailSuffre = '邮箱后缀：';
  SCAPTION_Country = '国家区号：';
  SCAPTION_Fatch = '提取目标：';
  SCAPTION_SITEOPTCustom = '自定义';
  SCAPTION_EnabledDeepSearch = '允许深度搜索';
  SACTTITEL_OpenYelloPage = '打开Yello Pages';
  SACTTITLE_OpenYelp = '打开 Yelp';
  SACTTITLE_OpenGoogleMap = '打开Google Map';
  SACTTITLE_Clear = '清除结果';
  SACTTITLE_Export = '导出';
  SACTTITLE_Stop = '停止';
  SACTTITLE_ExtractCurrPage = '提取当页';
  SACTTITLE_Extract = '提取';

  // udlgSendWahtsAppMsgsOnlyMsg
  SCAPTION_RandomWaitSend = '发送延迟时间';
  SCAPTION_ValidChatSend = '发送验证成功的账号';
  SCAPTION_IgnoreChatSended = '忽略已经发送的账号';
  SCAPTION_AddTaskSend = '定时发送';
  SCAPTION_ImmediatelaySend = '直接发送';
  STITLE_SendMsgGroupOptions = '选项';
  STITLE_GroupPic = '图片';
  STITLE_SendMessageList = '消息列表';
  SDATA_SendEmptyMsg = '在此处输入消息';
  SDATA_SendDefMsgName = '默认消息';



implementation



end.
















