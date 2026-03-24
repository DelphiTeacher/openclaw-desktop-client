unit BaseGridPageFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasePageFrame, Vcl.ExtCtrls,
  uDrawCanvas, uSkinItems, uSkinButtonType, uSkinItemDesignerPanelType,


  uDataInterface,
  uPageStructure,
  uPageInstance,
  uUIFunction,
  uFuncCommon,
  uDatasetToJson,
  uSkinItemJsonHelper,
  BaseEditPageFrame,
  MessageBoxFrame_VCL,
  //公共素材模块
  {$IFDEF FPC}
  EasyServiceCommonMaterialDataMoudle_VCL_Lazarus,
  {$ELSE}
  Vcl.Imaging.jpeg,Vcl.Imaging.pngimage,
  EasyServiceCommonMaterialDataMoudle_VCL,
  {$ENDIF}

  uSkinWindowsControl, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualGridType, uSkinItemGridType;

type
  TFrameBaseGridPage = class(TFrameBasePage)
    gridData: TSkinWinItemGrid;
    idpAction: TSkinItemDesignerPanel;
    btnEditRecord: TSkinButton;
    btnDeleteRow: TSkinButton;
    btnSearch: TSkinButton;
    btnAdd: TSkinButton;
    procedure btnSearchClick(Sender: TObject);
    procedure btnEditRecordClick(Sender: TObject);
    procedure btnDeleteRecordClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteRowClick(Sender: TObject);
  private
    FNeedDeleteItem:TSkinJsonItemGridRow;
    procedure DoModalResultFromCloseMesageBoxFrame(Sender: TObject);
    { Private declarations }
  public
    procedure DoReturnFromAddRecordFrame(AFrame:TFrame);
    procedure DoReturnFromEditRecordFrame(AFrame:TFrame);
    //页面调用加载数据接口结束
    procedure DoPageInstanceLoadDataTaskEnd(Sender:TObject;
                                   APageInstance:TPageInstance;
                                   ADataIntfResult: TDataIntfResult;
                                   ADataIntfResult2: TDataIntfResult);override;
    function GetEditRecordFrameClass:TFrameBaseEditPageClass;virtual;

    constructor Create(AOwner:TComponent);override;
    { Public declarations }
  end;

var
  FrameBaseGridPage: TFrameBaseGridPage;

implementation

{$R *.dfm}

procedure TFrameBaseGridPage.btnAddClick(Sender: TObject);
var
  AFrame:TFrameBasePage;
begin
  inherited;

  //新建
  AFrame:=GetEditRecordFrameClass.Create(Application);
  ShowFrame(TFrame(AFrame),TFrameClass(GetEditRecordFrameClass),DoReturnFromAddRecordFrame);
  TFrameBaseEditPage(AFrame).Add;
  TForm(AFrame.Parent).Caption:='添加';

end;

procedure TFrameBaseGridPage.btnDeleteRecordClick(Sender: TObject);
var
  AListViewItem:TSkinJsonItemGridRow;
begin
  inherited;

  AListViewItem:=TSkinJsonItemGridRow(Self.gridData.Prop.InteractiveItem);
  //删除
  Self.FPageInstance.DeleteJson(AListViewItem.Json);
  if not FPageInstance.FDelDataIntfResult.Succ then
  begin
    ShowMessage(FPageInstance.FDelDataIntfResult.Desc);
    Exit;
  end;
  Self.FPageInstance.LoadData(True);
end;

procedure TFrameBaseGridPage.btnDeleteRowClick(Sender: TObject);
begin
  inherited;
  FNeedDeleteItem:=TSkinJsonItemGridRow(Self.gridData.Prop.InteractiveItem);
  ShowMessageBoxFrame(nil,'确定删除该记录?','',TMsgDlgType.mtCustom,['确定'],
                                        DoModalResultFromCloseMesageBoxFrame,
                                        nil,
                                        '提示'
                                        ,ConvertToStringDynArray(['ok'])
                                        );


end;

procedure TFrameBaseGridPage.btnEditRecordClick(Sender: TObject);
var
  AFrame:TFrameBasePage;
  AListViewItem:TSkinJsonItemGridRow;
begin
  inherited;

  AListViewItem:=TSkinJsonItemGridRow(Self.gridData.Prop.InteractiveItem);

  //编辑
  AFrame:=GetEditRecordFrameClass.Create(Application);
  ShowFrame(TFrame(AFrame),TFrameClass(GetEditRecordFrameClass),DoReturnFromEditRecordFrame);
  TFrameBaseEditPage(AFrame).Edit(AListViewItem.Json);
  TForm(AFrame.Parent).Caption:='编辑';

end;

procedure TFrameBaseGridPage.btnSearchClick(Sender: TObject);
begin
  inherited;
  Self.PageInstance.LoadData(True);
end;

constructor TFrameBaseGridPage.Create(AOwner: TComponent);
var
  AColumn:TSkinVirtualGridColumn;
begin
  inherited;

  Self.gridData.Prop.BeginUpdate;
  try

    //如果表格中有操作列,那么将设计面板赋值给该列
    AColumn:=Self.gridData.Prop.Columns.FindByCaption('操作');
    AColumn.ItemDesignerPanel:=Self.idpAction;

    Self.gridData.Prop.Items.Clear();

  finally
    Self.gridData.Prop.EndUpdate;
  end;

end;

function TFrameBaseGridPage.GetEditRecordFrameClass: TFrameBaseEditPageClass;
begin
  Result:=TFrameBaseEditPage;
end;

procedure TFrameBaseGridPage.DoModalResultFromCloseMesageBoxFrame(
  Sender: TObject);
begin
  //删除
  Self.FPageInstance.DeleteJson(Self.FNeedDeleteItem.Json);
  if not FPageInstance.FDelDataIntfResult.Succ then
  begin
    ShowMessage(FPageInstance.FDelDataIntfResult.Desc);
    Exit;
  end;
  Self.FPageInstance.LoadData(True);

end;

procedure TFrameBaseGridPage.DoPageInstanceLoadDataTaskEnd(Sender: TObject;
  APageInstance: TPageInstance; ADataIntfResult,
  ADataIntfResult2: TDataIntfResult);
var
  I:Integer;
  AListViewItem:TSkinJsonItemGridRow;
begin
  inherited;
  if Self.FPageInstance.FLoadDataIntfResult.Succ then
  begin
    //加载数据成功,加载到表格中去

    Self.gridData.Prop.Items.BeginUpdate;
    try
      Self.gridData.Prop.Items.Clear(True);

      for I := 0 to Self.FPageInstance.FLoadDataIntfResult.DataJson.A['RecordList'].Length-1 do
      begin

        AListViewItem:=TSkinJsonItemGridRow.Create(Self.gridData.Prop.Items);

        AListViewItem.Json:=Self.FPageInstance.FLoadDataIntfResult.DataJson.A['RecordList'].O[I];

      end;

    finally
      Self.gridData.Prop.Items.EndUpdate();
    end;

  end;

end;

procedure TFrameBaseGridPage.DoReturnFromAddRecordFrame(AFrame: TFrame);
begin
  Self.PageInstance.LoadData(True);
end;

procedure TFrameBaseGridPage.DoReturnFromEditRecordFrame(AFrame: TFrame);
begin
  Self.PageInstance.LoadData(True);
end;

end.
