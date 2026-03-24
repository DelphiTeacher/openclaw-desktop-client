unit BaseViewPageFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,


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
  TFrameBaseViewPage = class(TFrameBaseFMXPage)
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
  private
    { Private declarations }
  protected
    //获取创建子控件的父控件
    function GetMainLayoutParent:TControl;override;
//    function GetMainLayoutParentMarginsTop:Double;override;

    //获取创建子控件的父控件
    function GetBottomToolbarLayoutParent:TControl;override;
//    function GetBottomToolbarLayoutParentMarginsTop:Double;override;
  public
    //加载页面结构
    function LoadPage(APage:TPage//;ALoadDataSetting:TLoadDataSetting
                      ):Boolean;override;
    { Public declarations }
  end;



var
  FrameBaseViewPage: TFrameBaseViewPage;

implementation

{$R *.fmx}

{ TFrameBaseViewPage }

function TFrameBaseViewPage.GetBottomToolbarLayoutParent: TControl;
begin
  Result:=Self.sbcClient;
end;

//function TFrameBaseViewPage.GetBottomToolbarLayoutParentMarginsTop: Double;
//begin
//  Result:=Self.PageInstance.MainControlMapList.FListLayoutsManager.CalcContentHeight;
//end;

function TFrameBaseViewPage.GetMainLayoutParent: TControl;
begin
  Result:=Self.sbcClient;
end;

//function TFrameBaseViewPage.GetMainLayoutParentMarginsTop: Double;
//begin
//  Result:=0;
//end;

function TFrameBaseViewPage.LoadPage(APage: TPage//;ALoadDataSetting:TLoadDataSetting
                                    ): Boolean;
begin
  Result:=Inherited;
//  //创建主控件列表
//  PageInstance.CreateControls(Self.pnlClient,Const_PagePart_Main);

  //设置父控件的高度
  SetSuitScrollContentHeight(sbcClient);



//  //创建底部工具栏的控件列表
//  PageInstance.CreateControls(Self.pnlBottomToolbar,Const_PagePart_BottomToolbar);
//  //设置父控件的高度
//  SetSuitScrollContentHeight(pnlBottomToolbar);
//
//
//  //设置滚动框的高度
//  SetSuitScrollContentHeight(sbcClient);

end;

end.
