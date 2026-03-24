unit GridSwitchPageFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Types,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, uSkinWindowsControl,
  uSkinButtonType, Vcl.ExtCtrls, uSkinWindowsEdit,
  uManager,
  uOpenClientCommon,
  uJsonToDataset, XSuperObject, System.StrUtils,


  Math,
  uWaitingForm,
  EasyServiceCommonMaterialDataMoudle_VCL,

  //kbmMemTable,
  uRestInterfaceCall, DateUtils, Data.Win.ADODB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uRestIntfMemTable, dxGDIPlusClasses, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, cxLabel, dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, uSkinMaterial, uDrawPicture, uSkinImageList,
  uSkinImageListPlayerType;

type
  TFrameEventGridSwitchPageLoadDataEvent=procedure(Sender:Tobject;APageIndex:Integer;APageSize:Integer) of object;

  TFrameGridSwitchPage = class(TFrame)
    btnFirstPage: TSkinWinButton;
    btnRefresh: TSkinWinButton;
    btnLastPage: TSkinWinButton;
    btnNextPage: TSkinWinButton;
    btnPriorPage: TSkinWinButton;
    Label1: TLabel;
    edtPageIndex: TcxTextEdit;
    Label2: TLabel;
    cmbPageSize: TcxComboBox;
    Label3: TLabel;
    lblPageCount: TLabel;
    Label5: TLabel;
    pnlClient: TPanel;
    imglistWaiting: TSkinImageList;
    imgWaiting: TSkinWinImageListPlayer;
    procedure btnFirstPageClick(Sender: TObject);virtual;
    procedure btnPriorPageClick(Sender: TObject);virtual;
    procedure btnNextPageClick(Sender: TObject);virtual;
    procedure btnLastPageClick(Sender: TObject);virtual;
    procedure btnRefreshClick(Sender: TObject);virtual;
    procedure cmbPageSizePropertiesChange(Sender: TObject);
    procedure edtPageIndexKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);virtual;
  private
    //总记录数
    FSumCount:Integer;


    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
    FOnChange:TNotifyEvent;
    FOnLoadData:TFrameEventGridSwitchPageLoadDataEvent;
    procedure DoChange;
    procedure LoadData();virtual;
    procedure DoCustomLoadData;virtual;
    procedure LoadFinished(ASumCount:Integer);virtual;
    procedure ClearcmbPageSizePropertiesChange;
    procedure RestorecmbPageSizePropertiesChange;
    function GetPageSize:Integer;
    { Public declarations }
  end;
//  TFrameGridSwitchPage=TFrameGridSwitchPage;


  TFrameRestMemTableGridSwitchPage=class(TFrameGridSwitchPage)
    procedure btnFirstPageClick(Sender: TObject);override;
    procedure btnPriorPageClick(Sender: TObject);override;
    procedure btnNextPageClick(Sender: TObject);override;
    procedure btnLastPageClick(Sender: TObject);override;
    procedure btnRefreshClick(Sender: TObject);override;
    procedure edtPageIndexKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);override;
  private
    FRestMemTable1: TRestMemTable;

//    procedure DoRestMemTableExecuteBegin(Sender:TObject);
//    procedure DoRestMemTableExecuteEnd(Sender:TObject);
  public
    procedure DoCustomLoadData();override;
    procedure DoRestMemTableChange(Sender:TObject);virtual;
    procedure Load(ARestMemTable1: TRestMemTable);

  end;


  TFrameEventGridSwitchPage=class(TFrameGridSwitchPage)
    procedure btnFirstPageClick(Sender: TObject);override;
    procedure btnPriorPageClick(Sender: TObject);override;
    procedure btnNextPageClick(Sender: TObject);override;
    procedure btnLastPageClick(Sender: TObject);override;
    procedure btnRefreshClick(Sender: TObject);override;
    procedure edtPageIndexKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);override;
  public
    procedure LoadData();override;
//    procedure DoRestMemTableChange(Sender:TObject);override;
//    procedure LoadFinished(ASumCount:Integer);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;




implementation

//uses
//  HomeForm;

{$R *.dfm}

{ TFrameGridSwitchPage }

//第一页
procedure TFrameGridSwitchPage.btnFirstPageClick(Sender: TObject);
begin
  Self.edtPageIndex.Text:='1';
  LoadData();
  DoChange;
end;

//最后一页
procedure TFrameGridSwitchPage.btnLastPageClick(Sender: TObject);
begin
  if StrToInt(Self.lblPageCount.Caption)>0 then
  begin
    Self.edtPageIndex.Text:=Self.lblPageCount.Caption;
    LoadData();
    DoChange;
  end;

end;

//下一页
procedure TFrameGridSwitchPage.btnNextPageClick(Sender: TObject);
var
  ANewPageIndex:Integer;
begin
  ANewPageIndex:=StrToInt(Self.edtPageIndex.Text)+1;
  if ANewPageIndex<=StrToInt(Self.lblPageCount.Caption) then
  begin
    Self.edtPageIndex.Text:=IntToStr(ANewPageIndex);

    LoadData();
    DoChange;
  end;
end;

//上一页
procedure TFrameGridSwitchPage.btnPriorPageClick(Sender: TObject);
var
  ANewPageIndex:Integer;
begin
  ANewPageIndex:=StrToInt(Self.edtPageIndex.Text)-1;
  if ANewPageIndex>0 then
  begin
    Self.edtPageIndex.Text:=IntToStr(StrToInt(Self.edtPageIndex.Text)-1);

    LoadData();
    DoChange;
  end;
end;

//刷新
procedure TFrameGridSwitchPage.btnRefreshClick(Sender: TObject);
begin
  LoadData;
  DoChange;
end;

procedure TFrameGridSwitchPage.ClearcmbPageSizePropertiesChange;
begin
  cmbPageSize.Properties.OnChange:=nil;
end;

procedure TFrameGridSwitchPage.cmbPageSizePropertiesChange(Sender: TObject);
begin
  LoadFinished(FSumCount);
  //重新设置下页数
  Self.edtPageIndex.Text:='1';
  Self.LoadData;
  Self.DoChange;
end;

constructor TFrameGridSwitchPage.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TFrameGridSwitchPage.Destroy;
begin

  inherited;
end;

procedure TFrameGridSwitchPage.DoChange;
begin
  if Assigned(Self.FOnChange) then
  begin
    FOnChange(Self);
  end;
end;

procedure TFrameGridSwitchPage.DoCustomLoadData;
begin
  if Assigned(FOnLoadData) then
  begin
    FOnLoadData(Self,StrToInt(Self.edtPageIndex.Text),StrToInt(Self.cmbPageSize.Text));
  end;

end;

procedure TFrameGridSwitchPage.edtPageIndexKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=13 then
  begin
    LoadData();
    DoChange;
  end;
end;

function TFrameGridSwitchPage.GetPageSize: Integer;
begin
  Result:=StrToInt(Self.cmbPageSize.Text);
end;

procedure TFrameGridSwitchPage.LoadData;
begin
  Self.btnRefresh.Visible:=False;
  Self.imgWaiting.Prop.Picture.SkinImageList:=Self.imglistWaiting;
  Self.imgWaiting.Visible:=True;
  imgWaiting.Prop.ImageListAnimated:=True;
  DoCustomLoadData;
end;

procedure TFrameGridSwitchPage.RestorecmbPageSizePropertiesChange;
begin
  cmbPageSize.Properties.OnChange:=cmbPageSizePropertiesChange;

end;

//
//procedure TFrameGridSwitchPage.DoRestMemTableExecuteBegin(Sender: TObject);
//begin
//  ShowWaitingFrame(nil,'加载中');
//end;
//
//procedure TFrameGridSwitchPage.DoRestMemTableExecuteEnd(Sender: TObject);
//begin
//  HideWaitingFrame;
//end;

procedure TFrameGridSwitchPage.LoadFinished(ASumCount: Integer);
begin
  FSumCount:=ASumCount;
  Self.lblPageCount.Caption:=IntToStr(Ceil(Self.FSumCount/StrToInt(Self.cmbPageSize.Text)));

  imgWaiting.Prop.ImageListAnimated:=False;
  Self.imgWaiting.Visible:=False;
  Self.btnRefresh.Visible:=True;


end;

{ TFrameEventGridSwitchPage }

procedure TFrameEventGridSwitchPage.btnFirstPageClick(Sender: TObject);
begin
  Inherited;
end;

procedure TFrameEventGridSwitchPage.btnLastPageClick(Sender: TObject);
begin
  Inherited;
end;

procedure TFrameEventGridSwitchPage.btnNextPageClick(Sender: TObject);
begin
  Inherited;
end;

procedure TFrameEventGridSwitchPage.btnPriorPageClick(Sender: TObject);
begin
  Inherited;
end;

procedure TFrameEventGridSwitchPage.btnRefreshClick(Sender: TObject);
begin
  Inherited;

end;

constructor TFrameEventGridSwitchPage.Create(AOwner: TComponent);
begin
  inherited;
  FSumCount:=0;
  Self.lblPageCount.Caption:='1';

  Self.Label1.Visible:=True;
  Self.Label2.Visible:=True;
  Self.lblPageCount.Visible:=True;
  Self.Label5.Visible:=True;
  Self.Label3.Visible:=True;
  Self.cmbPageSize.Visible:=True;

end;

destructor TFrameEventGridSwitchPage.Destroy;
begin

  inherited;
end;

procedure TFrameEventGridSwitchPage.LoadData();
begin
  Inherited;
end;

//procedure TFrameEventGridSwitchPage.DoRestMemTableChange(Sender: TObject);
//begin
////  Self.edtPageIndex.Text:=IntToStr(FPageIndex);
////  Self.lblPageCount.Caption:=IntToStr(FPageCount);
//
//end;

procedure TFrameEventGridSwitchPage.edtPageIndexKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  FPageIndex:=StrToInt(Self.edtPageIndex.Text);
  Inherited;
end;

//procedure TFrameEventGridSwitchPage.LoadFinished(ASumCount: Integer);
//begin
//  Inherited;
//  Self.lblPageCount.Caption:=IntToStr(Ceil(Self.FSumCount/StrToInt(Self.cmbPageSize.Text)));
//end;




{ TFrameRestMemTableGridSwitchPage }

procedure TFrameRestMemTableGridSwitchPage.btnFirstPageClick(Sender: TObject);
begin
  inherited;
//  if FRestMemTable1<>nil then
//  begin
//    FRestMemTable1.GetFirstPage;
//    Self.edtPageIndex.Text:=IntToStr(FRestMemTable1.PageIndex);
//  end
//  else
//  begin
//    if Self.edtPageIndex.Text <> '1' then
//    begin
//      Self.edtPageIndex.Text:= '1';
//    end
//    else
//    begin
//      Exit;
//    end;
//  end;
//  DoChange;

end;

procedure TFrameRestMemTableGridSwitchPage.btnLastPageClick(Sender: TObject);
begin
  inherited;
//  if FRestMemTable1<>nil then
//  begin
//    FRestMemTable1.GetLastPage;
//    Self.edtPageIndex.Text:=IntToStr(FRestMemTable1.PageIndex);
//  end
//  else
//  begin
//    if Self.edtPageIndex.Text <> Self.lblPageCount.Caption then
//    begin
//      Self.edtPageIndex.Text:= Self.lblPageCount.Caption;
//    end
//    else
//    begin
//      Exit;
//    end;
//  end;
//  DoChange;

end;

procedure TFrameRestMemTableGridSwitchPage.btnNextPageClick(Sender: TObject);
begin
  inherited;
//  if FRestMemTable1<>nil then
//  begin
//    FRestMemTable1.GetNextPage;
//    Self.edtPageIndex.Text:=IntToStr(FRestMemTable1.PageIndex);
//  end
//  else
//  begin
//    if StrToInt(Self.edtPageIndex.Text) < StrToInt(Self.lblPageCount.Caption) then
//    begin
//      Self.edtPageIndex.Text:=IntToStr(StrToInt(Self.edtPageIndex.Text)+1);
//    end
//    else
//    begin
//      Exit;
//    end;
//  end;
//  DoChange;

end;

procedure TFrameRestMemTableGridSwitchPage.btnPriorPageClick(Sender: TObject);
begin
  inherited;
//  if FRestMemTable1<>nil then
//  begin
//    FRestMemTable1.GetPriorPage;
//    Self.edtPageIndex.Text:=IntToStr(FRestMemTable1.PageIndex);
//  end
//  else
//  begin
//    if StrToInt(Self.edtPageIndex.Text) > 1 then
//    begin
//      Self.edtPageIndex.Text:=IntToStr(StrToInt(Self.edtPageIndex.Text)-1);
//    end
//    else
//    begin
//      Exit;
//    end;
//  end;
//  DoChange;

end;

procedure TFrameRestMemTableGridSwitchPage.btnRefreshClick(Sender: TObject);
begin
  inherited;

end;

//procedure TFrameRestMemTableGridSwitchPage.DoRestMemTableChange(
//  Sender: TObject);
//begin
//
//end;

procedure TFrameRestMemTableGridSwitchPage.edtPageIndexKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
//  if Key=13 then
//  begin
//    if FRestMemTable1<>nil then
//    begin
//      FRestMemTable1.PageIndex:=StrToInt(Self.edtPageIndex.Text);
//      FRestMemTable1.Refresh;
//    end;
//    DoChange;
//  end;

end;

procedure TFrameRestMemTableGridSwitchPage.DoRestMemTableChange(Sender: TObject);
begin
  Self.edtPageIndex.Text:=IntToStr(FRestMemTable1.PageIndex);
  Self.lblPageCount.Caption:=IntToStr(FRestMemTable1.PageCount);
  Self.cmbPageSize.Text:=IntToStr(FRestMemTable1.PageSize);
  LoadFinished(FRestMemTable1.SumRecordCount);

//  if Self.FRestMemTable1.PageCount=0 then
//  begin
//    Self.btnFirstPage.Enabled:=False;
//    Self.btnPriorPage.Enabled:=False;
//    Self.btnNextPage.Enabled:=False;
//    Self.btnLastPage.Enabled:=False;
//  end
//  else
//  begin
//
//  end;


end;

procedure TFrameRestMemTableGridSwitchPage.Load(ARestMemTable1: TRestMemTable);
begin
  FRestMemTable1:=ARestMemTable1;
  FRestMemTable1.OnGetRestDatasetPageChange:=DoRestMemTableChange;
//  FRestMemTable1.OnExecuteBegin:=DoRestMemTableExecuteBegin;
//  FRestMemTable1.OnExecuteEnd:=DoRestMemTableExecuteEnd;

end;

procedure TFrameRestMemTableGridSwitchPage.DoCustomLoadData;
begin
  inherited;
  if FRestMemTable1<>nil then
  begin
    FRestMemTable1.Refresh;
  end;

end;

end.

