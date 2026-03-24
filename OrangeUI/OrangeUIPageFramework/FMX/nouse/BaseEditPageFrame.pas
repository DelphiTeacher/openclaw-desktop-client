unit BaseEditPageFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,


  uLang,
  HintFrame,
  uUIFunction,
//  uPageFrameworkCommon,
  uComponentType,
  uBasePageStructure,
  uPageStructure,
  uDataInterface,
//  EasyServiceCommonMaterialDataMoudle,

  BasePageFrame, uSkinButtonType, uSkinFireMonkeyButton, uSkinFireMonkeyControl,
  uSkinPanelType, uSkinFireMonkeyPanel, FMX.Controls.Presentation, FMX.Edit,
  uSkinFireMonkeyEdit, uSkinScrollBoxContentType,
  uSkinFireMonkeyScrollBoxContent, uSkinScrollControlType, uSkinScrollBoxType,
  uSkinFireMonkeyScrollBox, uSkinMaterial, uSkinLabelType, uSkinFireMonkeyLabel,
  uFrameContext;



type
  TFrameBaseEditPage = class(TFrameBaseFMXPage,IFrameVirtualKeyboardAutoProcessEvent)
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    btnSave: TSkinFMXButton;
    btnDelete: TSkinFMXButton;
    pnlContent: TSkinFMXPanel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
  private
    //当前需要处理的控件
    function GetCurrentPorcessControl(AFocusedControl:TControl):TControl;
    function GetVirtualKeyboardControlParent:TControl;

    { Private declarations }
//  protected
//    //获取创建子控件的父控件
//    function GetMainLayoutParent:TControl;override;
////    function GetMainLayoutParentMarginsTop:Double;override;
//
//    //获取创建子控件的父控件
//    function GetBottomToolbarLayoutParent:TControl;override;
////    function GetBottomToolbarLayoutParentMarginsTop:Double;override;
//
//    function CustomInitPage//(APage:TPage;ALoadDataSetting:TLoadDataSetting)
//                            :Boolean;override;
//
//    function CreatePageInstance:TPageInstance;override;
//  public
//    EditPageInstance:TEditPageInstance;
//    //加载页面结构
//    function LoadPage(APage:TPage//;ALoadDataSetting:TLoadDataSetting
//                      ):Boolean;override;
    { Public declarations }
  end;



var
  FrameBaseEditPage: TFrameBaseEditPage;

implementation

{$R *.fmx}

{ TFrameBaseEditPage }

procedure TFrameBaseEditPage.btnDeleteClick(Sender: TObject);
begin
  inherited;

//  //删除
//  TEditPageInstance(Self.PageInstance).DoDelRecordAction;
end;

procedure TFrameBaseEditPage.btnSaveClick(Sender: TObject);
begin
  inherited;

  //检查输入是否合法


//  //保存
//  TEditPageInstance(Self.PageInstance).DoSaveRecordAction(True);

end;

//function TFrameBaseEditPage.CreatePageInstance: TPageInstance;
//begin
//  EditPageInstance:=TEditPageInstance.Create(Self);
////  TEditPageInstance(EditPageInstance).OnSaveRecordSucc:=DoEditPageInstanceSaveRecordSucc;
//
//  Result:=EditPageInstance;
//end;
//
//function TFrameBaseEditPage.CustomInitPage//(APage: TPage;
//  //ALoadDataSetting: TLoadDataSetting)
//  : Boolean;
//begin
//  //保存是一定要的。
//  Self.btnSave.Visible:=True;
//
//  //编辑状态有删除按钮,判断是否需要
//  Self.btnDelete.Visible:=not Self.PageInstance.FLoadDataSetting.IsAddRecord;
//
//end;
//
//function TFrameBaseEditPage.GetBottomToolbarLayoutParent: TControl;
//begin
//  Result:=Self.sbcClient;
//end;

//function TFrameBaseEditPage.GetBottomToolbarLayoutParentMarginsTop: Double;
//begin
//  Result:=Self.PageInstance.MainControlMapList.FListLayoutsManager.CalcContentHeight;
//end;

function TFrameBaseEditPage.GetCurrentPorcessControl(
  AFocusedControl: TControl): TControl;
begin
  Result:=AFocusedControl;
end;

function TFrameBaseEditPage.GetVirtualKeyboardControlParent: TControl;
begin
  Result:=Self;
end;

//function TFrameBaseEditPage.GetMainLayoutParent: TControl;
//begin
//  Result:=Self.pnlContent;//sbcClient;
//end;

//function TFrameBaseEditPage.GetMainLayoutParentMarginsTop: Double;
//begin
//  Result:=0;
//end;

//function TFrameBaseEditPage.LoadPage(APage: TPage//;ALoadDataSetting:TLoadDataSetting
//                                    ): Boolean;
//begin
//  Result:=Inherited;
////  //创建主控件列表
////  PageInstance.CreateControls(Self.pnlClient,Const_PagePart_Main);
//
//  //设置父控件的高度
//  SetSuitScrollContentHeight(pnlContent,0);
//  SetSuitScrollContentHeight(sbcClient);
//
//
////  //创建底部工具栏的控件列表
////  PageInstance.CreateControls(Self.pnlBottomToolbar,Const_PagePart_BottomToolbar);
////  //设置父控件的高度
////  SetSuitScrollContentHeight(pnlBottomToolbar);
////
////
////  //设置滚动框的高度
////  SetSuitScrollContentHeight(sbcClient);
//
//end;

end.

