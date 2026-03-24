unit BaseListPageFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 

  uSkinItems,
  uUIFunction,
//  uPageFramework,
  uDataInterface,
  uPageStructure,
  uComponentType,
//  uVirtualListDataController,
//  EasyServiceCommonMaterialDataMoudle,



  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  BasePageFrame, uSkinButtonType, uSkinFireMonkeyButton, uSkinFireMonkeyControl,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinScrollControlType,
  uSkinCustomListType, uSkinVirtualListType, uSkinListViewType,
  uSkinFireMonkeyListView, uFrameContext;

type
  TFrameBaseListPage = class(TFrameBasePage)
    btnAddRecord: TSkinFMXButton;
    procedure btnAddRecordClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function CreatePageInstance:TPageInstance;override;
    function CustomInitPage//(APage:TPage;ALoadDataSetting:TLoadDataSetting)
                            :Boolean;override;
//    //调用接口数据返回
//    function LoadDataIntfResult(ADataIntfResult:TDataIntfResult;
//                                    ALoadDataSetting:TLoadDataSetting):Boolean;override;
  public
    ListPageInstance:TListPageInstance;
//    ListControl:TSkinVirtualList;
    { Public declarations }
  end;




var
  FrameBaseListPage: TFrameBaseListPage;

implementation

uses
   BaseEditPageFrame;

{$R *.fmx}


{ TFrameBaseListPage }

procedure TFrameBaseListPage.btnAddRecordClick(Sender: TObject);
begin
  inherited;
  //添加记录
//  Self.PageInstance.DoJumpToNewRecordPageAction;

end;

function TFrameBaseListPage.CreatePageInstance: TPageInstance;
begin
  ListPageInstance:=TListPageInstance.Create(Self);
  Result:=ListPageInstance;
end;

function TFrameBaseListPage.CustomInitPage//(APage: TPage;ALoadDataSetting:TLoadDataSetting)
                                          : Boolean;
begin

  //添加记录按钮是否显示
//  Self.btnAddRecord.Visible:=(Self.PageInstance.PageStructure.has_add_record_button=1);




//  //判断是用ListView,ListBox,还是TreeView等
//  ListControl:=TSkinListView.Create(Self);
//  ListControl.Align:=TAlignLayout.Client;
//  ListControl.Parent:=Self.pnlClient;
//
//
//  //根据页面结构设置列表控件
//  ListControl.Prop.DefaultItemStyle:=APage.default_list_item_style;
//
//
//
//
//  if APage.item_col_count>0 then
//  begin
//    TSkinListView(ListControl).Prop.ColCount:=APage.item_col_count;
//  end;
//
//  if APage.item_col_width>0 then
//  begin
//    TSkinListView(ListControl).Prop.ItemWidth:=APage.item_col_width;
//  end;
//
//  if APage.item_height>0 then
//  begin
//    TSkinListView(ListControl).Prop.ItemHeight:=APage.item_height;
//  end;


end;

//procedure TFrameBaseListPage.DoReturnFrameFromEditPageFrame(AFrame: TFrame);
//var
//  ASkinItem:TBaseSkinItem;
//begin
//  //从编辑页面返回到列表页面
//  if TFrameBaseEditPage(AFrame).PageInstance.FLoadDataSetting.IsAddRecord then
//  begin
//    //添加记录返回
////    ASkinItem:=TBaseSkinItem(Self.PageInstance.FlvData.Prop.Items.Add);
//    //怎么把值赋给它
//    Self.PageInstance.AddSkinItemToListControl(Self.ListPageInstance.FlvData,
//                                               TFrameBaseEditPage(AFrame).EditPageInstance.FSaveDataIntfResult.DataJson,
//                                               nil
//                                                );
//
//
//  end;
//
//end;

//function TFrameBaseListPage.LoadDataIntfResult(ADataIntfResult: TDataIntfResult;
//                                                    ALoadDataSetting:TLoadDataSetting): Boolean;
//var
//  ASkinItem:TSkinItem;
//begin
//  if ListControl<>nil then
//  begin
//    ListControl.Prop.Items.BeginUpdate;
//    try
//      if ALoadDataSetting.PageIndex=1 then
//      begin
//        Self.ListControl.Prop.Items.Clear(True);
//      end;
//
//
//
//
//    finally
//      ListControl.Prop.Items.EndUpdate;
//    end;
//  end;
//end;

initialization
  GlobalFrameworkComponentTypeClasses.Add('list_page',TFrameBaseListPage,'列表页面');


end.
