unit ReportConditionFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  ParentFrame, System.Actions, FMX.ActnList, uDrawPicture, uSkinImageList,


  EasyServiceCommonMaterialDataMoudle,

  uSkinScrollControlType, uSkinScrollBoxType, uSkinFireMonkeyScrollBox,
  uSkinButtonType, uSkinFireMonkeyButton, uSkinFireMonkeyControl,
  uSkinPanelType, uSkinFireMonkeyPanel,StoreHouseStatus, uSkinLabelType,
  uSkinFireMonkeyLabel, uSkinScrollBoxContentType, FMX.App.hardwarecall,
  uSkinFireMonkeyScrollBoxContent, uSkinCheckBoxType, uSkinFireMonkeyCheckBox,uUIFunction,
  dimconst, FMX.DateTimeCtrls, uSkinFireMonkeyDateEdit,BaseReport, FMX.Edit,
  FMX.Controls.Presentation, uSkinFireMonkeyEdit;

type
  TfmReportCondition = class(TfmParentFrame)
    listHead: TSkinFMXScrollBox;
    S: TSkinFMXScrollBoxContent;
    pnlClients: TSkinFMXPanel;
    lblClientsPrex: TSkinFMXLabel;
    lblClients: TSkinFMXButton;
    SkinFMXButton1: TSkinFMXButton;
    pnlProduct: TSkinFMXPanel;
    SkinFMXLabel4: TSkinFMXLabel;
    lblProduct: TSkinFMXButton;
    SkinFMXButton3: TSkinFMXButton;
    pnlStock: TSkinFMXPanel;
    lblStockPrex: TSkinFMXLabel;
    lblStock: TSkinFMXButton;
    SkinFMXButton2: TSkinFMXButton;
    pnlShowZero: TSkinFMXPanel;
    chkItemChecked: TSkinFMXCheckBox;
    SkinFMXPanel2: TSkinFMXPanel;
    btnQuery: TSkinFMXButton;
    SkinFMXPanel3: TSkinFMXPanel;
    btnScan: TSkinFMXButton;
    SkinFMXPanel4: TSkinFMXPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    edtBeginDate: TSkinFMXDateEdit;
    SkinFMXLabel2: TSkinFMXLabel;
    edtEndDate: TSkinFMXDateEdit;
    pnlEmp: TSkinFMXPanel;
    SkinFMXLabel3: TSkinFMXLabel;
    lblEmp: TSkinFMXButton;
    SkinFMXButton4: TSkinFMXButton;
    btnClear: TSkinFMXButton;
    pnlBillNO: TSkinFMXPanel;
    btnSelectBillNO: TSkinFMXButton;
    pnlDateArea: TSkinFMXPanel;
    btnSelectDateArea: TSkinSelectDateAreaButton;
    edtBillNO: TSkinFMXEdit;
    ClearEditButton2: TClearEditButton;
    pnSettleAccount: TSkinFMXPanel;
    SkinFMXLabel5: TSkinFMXLabel;
    btnSelectSettleAccount: TSkinFMXButton;
    SkinFMXButton6: TSkinFMXButton;
    pnlBillStatus: TSkinFMXPanel;
    SkinFMXLabel6: TSkinFMXLabel;
    btnSelectBillStatus: TSkinFMXButton;
    SkinFMXButton7: TSkinFMXButton;
    pnlBillSource: TSkinFMXPanel;
    SkinFMXLabel7: TSkinFMXLabel;
    btnSelectBillSource: TSkinFMXButton;
    SkinFMXButton8: TSkinFMXButton;
    pnlBillType: TSkinFMXPanel;
    SkinFMXLabel8: TSkinFMXLabel;
    bntSelectBillType: TSkinFMXButton;
    SkinFMXButton9: TSkinFMXButton;
    procedure lblStockClick(Sender: TObject);
    procedure lblProductClick(Sender: TObject);
    procedure lblClientsClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnScanClick(Sender: TObject);
    procedure lblEmpClick(Sender: TObject);
  private
    { Private declarations }
     FQrScan: TQrScan;
      procedure DoScanEvent(const ACallResult: integer; const AScanText: string);
  public
    { Public declarations }
    fmSaleReprot :TfmBaseReport;
    flag:integer;
    procedure SetStockClassID(pData:PStockRec);override;
    procedure SetProductClassID(pData:PProductRec);override;
    procedure SetClientClassID(pData:PClientRec);override;
    procedure SetEmpClassID(pData:PEmpRec);override;
    procedure DoClientSelectResult(Ac: TObject);
    procedure DoEmpSelectResult(Ac: TObject);
    procedure DoStoreSelectResult(Ac: TObject);
  end;

var
  fmReportCondition: TfmReportCondition;

implementation
 uses SelectStock,SelectClients,SelectProduct,Main,LocalDb,MessageBoxFrame,SelectEmp,HintFrame,System.Permissions{$IFDEF IOS},osScanForm{$endif};
{$R *.fmx}

procedure TfmReportCondition.btnClearClick(Sender: TObject);
begin
  inherited;
   fmSaleReprot.CCLASSID := '';
   lblClients.StaticCaption := '';
   fmSaleReprot.SClassID :='';
   lblStock.StaticCaption := '';
   fmSaleReprot.PClassID := '';
   lblProduct.StaticCaption :=  '';
   fmSaleReprot.ISZERO := '0';
   chkItemChecked.Prop.Checked := False;
   fmSaleReprot.strCurrentParentid := '';
   ShowHintFrame(fmMain, '查询条件已清除！', 3);
end;

procedure TfmReportCondition.btnQueryClick(Sender: TObject);
begin
  inherited;

  ReturnFrame(FrameHistroy);
  HideFrame(Self,hfcttBeforeShowFrame);
  if  fmReportCondition.flag = 1 then
  begin
    fmReportCondition.pnlEmp.Visible := true;
    fmReportCondition.pnlProduct.Visible := true;
    fmReportCondition.pnlStock.Visible := true;
    fmReportCondition.pnlShowZero.visible := true;
    fmReportCondition.pnlActionBar.Caption := '销售报表--查询条件';
  end;
  if chkItemChecked.Prop.Checked then
  fmSaleReprot.ISZERO := '1' else
  fmSaleReprot.ISZERO := '0';
  fmSaleReprot.BeginDate  :=   FormatDateTime('yyyy-mm-dd',edtBeginDate.Date);
  fmSaleReprot.EndDate := FormatDateTime('yyyy-mm-dd', edtEndDate.date) + ' 23:59:59';
  fmSaleReprot.DoOpen;
end;

procedure TfmReportCondition.DoClientSelectResult(Ac: TObject);
begin
  fmSaleReprot.CCLASSID :=  TfmSelectClients(Ac).ModalResultCClassid;
  if flag = 1 then
    fmSaleReprot.CCLASSID := TfmSelectClients(Ac).ModalResultCID;

  lblClients.StaticCaption := TfmSelectClients(Ac).ModalResultCName;
end;

procedure TfmReportCondition.DoEmpSelectResult(Ac: TObject);
begin
   fmSaleReprot.EClassID :=  TfmSelectEmp(Ac).ModalResultEClassid ;
   lblemp.StaticCaption := TfmSelectEmp(Ac).ModalResultEName;
end;

procedure TfmReportCondition.DoScanEvent(const ACallResult: integer;
  const AScanText: string);
  var
   strSql :string;
begin
 strSql := '';
 strSql := format(strBillGetProductOfBarCode,[AScanText]);
 dmLocalDb.FDQuery1.Close;
 dmLocalDb.FDQuery1.SQL.Clear;
 dmLocalDb.FDQuery1.Open(strSql);
 if dmLocalDb.FDQuery1.RecordCount > 0 then begin
  lblProduct.StaticCaption := dmLocalDb.FDQuery1.FieldByName('p_name').AsString;
  fmSaleReprot.PClassID := dmLocalDb.FDQuery1.FieldByName('p_class_id').AsString;
 end else
  ShowMessageBoxFrame(fmMain, '条码无效!', '',TMsgDlgType.mtError, ['确定']);
end;

procedure TfmReportCondition.DoStoreSelectResult(Ac: TObject);
begin
  fmSaleReprot.SClassID :=TfmSelectStock(Ac).ModalResultSClassid;
  lblStock.StaticCaption := TfmSelectStock(Ac).ModalResultSName;
end;

procedure TfmReportCondition.lblClientsClick(Sender: TObject);
begin
  inherited;
  HideFrame(self, hfcttBeforeShowFrame);
  ShowFrame(TFrame(fmSelectClients), TfmSelectClients, fmMain, nil, nil, nil,Application);
  fmSelectClients.FrameHistroy := CurrentFrameHistroy;
  fmSelectClients.isReportQuery := true;
  fmSelectClients.COnModalResult := DoClientSelectResult;
  fmSelectClients.strParantId := '000000';
  fmSelectClients.DoOpen;
end;

procedure TfmReportCondition.lblEmpClick(Sender: TObject);
begin
  inherited;
   HideFrame(self, hfcttBeforeShowFrame);
  ShowFrame(TFrame(fmSelectEmp), TfmSelectEmp, fmMain, nil, nil, nil,
    Application);
  fmSelectEmp.FrameHistroy := CurrentFrameHistroy;
  fmSelectEmp.AOnModalResult := DoEmpSelectResult;
  fmSelectEmp.isReportQuery := true;
  fmSelectEmp.strParantId := '000000';
  fmSelectEmp.DoOpen;
end;

procedure TfmReportCondition.lblProductClick(Sender: TObject);
begin
  inherited;
  HideFrame(self, hfcttBeforeShowFrame);
  ShowFrame(TFrame(fmSelectProduct), TfmSelectProduct, fmMain, nil, nil, nil,Application);
  fmSelectProduct.FrameHistroy := CurrentFrameHistroy;
  fmSelectProduct.isReportQuery := true;
  fmSelectProduct.fmbill := self;
  fmSelectProduct.strParantId := '000000';
  fmSelectProduct.DoOpen;
end;

procedure TfmReportCondition.lblStockClick(Sender: TObject);
begin
  HideFrame(self, hfcttBeforeShowFrame);
  ShowFrame(TFrame(fmSelectStock), TfmSelectStock, fmMain, nil, nil, nil,Application);
  fmSelectStock.FrameHistroy := CurrentFrameHistroy;
  fmSelectStock.isSecondS_id := False;
  fmSelectStock.isReportQuery := true;
  fmSelectStock.AOnModalResult := DoStoreSelectResult;
  fmSelectStock.strParantId := '000000';
  fmSelectStock.DoOpen;
end;
procedure TfmReportCondition.SetClientClassID(pData: PClientRec);
begin
  inherited;
  fmSaleReprot.CCLASSID :=  pData.c_class_id;
  if flag = 1 then
    fmSaleReprot.CCLASSID := pData.c_id;

  lblClients.StaticCaption := pData.c_name;
end;

procedure TfmReportCondition.SetEmpClassID(pData: PEmpRec);
begin
  inherited;
  fmSaleReprot.EClassID :=  pData.e_class_id;
  lblemp.StaticCaption := pData.e_name;
end;

procedure TfmReportCondition.SetProductClassID(pData: PProductRec);
begin
  inherited;
  fmSaleReprot.PClassID := pData.p_class_id;
  lblProduct.StaticCaption :=  pData.p_name;
end;

procedure TfmReportCondition.SetStockClassID(pData: PStockRec);
begin
  inherited;
  fmSaleReprot.SClassID := pData.s_class_id;
  lblStock.StaticCaption := PData.s_name;
end;

procedure TfmReportCondition.btnScanClick(Sender: TObject);
begin
  inherited;
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions([FPermissionCAMERA], nil, nil);
  if not assigned(FQrScan) then
    FQrScan := TQrScan.Create;
  FQrScan.QrScan(DoScanEvent);
     {$endif}
   {$IFDEF IOS}
//  if not assigned(IosScanForm) then
//  IosScanForm:= TIosScanForm.Create(application);
//  IosScanForm.QrScan(DoScanEvent);
  if not assigned(FQrScan) then
    FQrScan := TQrScan.Create;
  FQrScan.QrScan(DoScanEvent);
  {$endif}
end;

end.
