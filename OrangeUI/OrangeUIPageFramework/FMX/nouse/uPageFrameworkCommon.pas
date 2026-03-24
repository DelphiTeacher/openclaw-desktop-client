unit uPageFrameworkCommon;

interface

const
  //页面框架的功能类型
  Const_FunctionType_DataManage='data_manage';


  {$REGION '页面框架的页面类型'}
const
  //页面框架的页面类型
  //列表页面
  Const_PageType_ListPage='list_page';
  //编辑页面
  Const_PageType_EditPage='edit_page';
  //查看页面
  Const_PageType_ViewPage='view_page';
  //自定义页面
  Const_PageType_CustomPage='custom_page';
  //树型列表页面
  Const_PageType_TreeListPage='tree_list_page';
  //主从编辑页面
  Const_PageType_MasterDetailEditPage='master_detail_edit_page';
  //主从查看页面
  Const_PageType_MasterDetailViewPage='master_detail_view_page';
  {$ENDREGION '页面框架的页面类型'}


  {$REGION '页面框架的页面区域'}
const
  //页面框架的页面区域
  //主区域
  Const_PagePart_Main='';
  //搜索栏
  Const_PagePart_SearchBar='search_bar';
  //顶部工具栏
  Const_PagePart_TopToolbar='top_toolbar';
  //行操作区
  Const_PagePart_RowOperBar='row_oper_bar';
  //底部工具栏
  Const_PagePart_BottomToolbar='bottom_toolbar';
  {$ENDREGION '页面框架的页面区域'}


  {$REGION '页面框架的操作'}
const
  //页面框架的操作
  //跳转到新增页面
  Const_PageAction_JumpToNewRecordPage='jump_to_new_record_page';
  //跳转到编辑页面
  Const_PageAction_JumpToEditRecordPage='jump_to_edit_record_page';
  //跳转到查看页面
  Const_PageAction_JumpToViewRecordPage='jump_to_view_record_page';
  //跳转到主从新增页面
  Const_PageAction_JumpToNewMasterDetailRecordPage='jump_to_new_master_detail_record_page';
  //跳转到主从编辑页面
  Const_PageAction_JumpToEditMasterDetailRecordPage='jump_to_edit_master_detail_record_page';
  //跳转到主从查看页面
  Const_PageAction_JumpToViewMasterDetailRecordPage='jump_to_view_master_detail_record_page';
  //批量删除
  Const_PageAction_BatchDelRecord='batch_del_record';
  //批量保存
  Const_PageAction_BatchSaveRecord='batch_save_record';
  //搜索
  Const_PageAction_SearchRecordList='search_record_list';
  //删除
  Const_PageAction_DelRecord='del_record';
  //返回
  Const_PageAction_ReturnPage='return_page';
  //关闭页面
  Const_PageAction_ClosePage='close_page';
  //保存
  Const_PageAction_SaveRecord='save_record';
  //取消保存
  Const_PageAction_CancelSaveRecord='cancel_save_record';
  //保存并返回
  Const_PageAction_SaveRecordAndReturn='save_record_and_return';
  //保存新增并继续新增
  Const_PageAction_SaveRecordAndContinueAdd='save_record_and_continue_add';
  {$ENDREGION '页面框架的页面区域'}


  {$REGION '页面布局类型'}
const
  //页面布局-自动
  Const_PageAlignType_Auto='auto';
  //页面布局-手动
  Const_PageAlignType_Manual='manual';
  {$ENDREGION '页面布局类型'}


const
  //编辑页面输入Panel的默认素材
  Const_ControlStyle_EditPageInputPanelDefault='EditPageInputPanelDefault';
  //编辑页面输入Label的默认素材
  Const_ControlStyle_EditPageHintLabelDefult='EditPageHintLabelDefault';



const
  //接口类型
  Const_IntfType_TableCommonRest='table_common_rest';




implementation




end.
