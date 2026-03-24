unit SearchConditionFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uSkinButtonType, FMX.Edit, FMX.Controls.Presentation, uSkinFireMonkeyEdit,

  uUIFunction,
  CommonImageDataMoudle,
  EasyServiceCommonMaterialDataMoudle,

  FMX.DateTimeCtrls, uSkinFireMonkeyDateEdit, uSkinCheckBoxType,
  uSkinFireMonkeyCheckBox, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinScrollBoxContentType, uSkinFireMonkeyScrollBoxContent, System.Actions,
  FMX.ActnList, uDrawPicture, uSkinImageList, uSkinScrollControlType,
  uSkinScrollBoxType, uSkinFireMonkeyScrollBox, uSkinFireMonkeyButton,
  uSkinFireMonkeyControl, uSkinPanelType, uSkinFireMonkeyPanel;

type
  TFrameSearchCondition = class(TFrame)
    pnlActionBar: TSkinFMXPanel;
    btnActionBack: TSkinFMXButton;
    btnClear: TSkinFMXButton;
    lstMain: TSkinFMXScrollBox;
    SkinFMXPanel3: TSkinFMXPanel;
    pnlMostTopBar: TSkinFMXPanel;
    SkinImageList1: TSkinImageList;
    AcMain: TActionList;
    SkinFMXPanel2: TSkinFMXPanel;
    listHead: TSkinFMXScrollBox;
    S: TSkinFMXScrollBoxContent;
    pnlClients: TSkinFMXPanel;
    lblClientsPrex: TSkinFMXLabel;
    lblClients: TSkinFMXButton;
    SkinFMXButton1: TSkinFMXButton;
    pnlProduct: TSkinFMXPanel;
    SkinFMXLabel4: TSkinFMXLabel;
    lblProduct: TSkinFMXButton;
    btnScan: TSkinFMXButton;
    SkinFMXButton3: TSkinFMXButton;
    pnlStock: TSkinFMXPanel;
    lblStockPrex: TSkinFMXLabel;
    lblStock: TSkinFMXButton;
    SkinFMXButton2: TSkinFMXButton;
    SkinFMXPanel4: TSkinFMXPanel;
    SkinFMXLabel1: TSkinFMXLabel;
    edtBeginDate: TSkinFMXDateEdit;
    SkinFMXLabel2: TSkinFMXLabel;
    edtEndDate: TSkinFMXDateEdit;
    pnlEmp: TSkinFMXPanel;
    SkinFMXLabel3: TSkinFMXLabel;
    lblEmp: TSkinFMXButton;
    SkinFMXButton4: TSkinFMXButton;
    btnQuery: TSkinFMXButton;
    pnlBillNO: TSkinFMXPanel;
    btnSelectBillNO: TSkinFMXButton;
    edtBillNO: TSkinFMXEdit;
    ClearEditButton2: TClearEditButton;
    pnlDateArea: TSkinFMXPanel;
    btnSelectDateArea: TSkinSelectDateAreaButton;
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
    procedure btnActionBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GlobalSearchConditionFrame:TFrameSearchCondition;


implementation

{$R *.fmx}

procedure TFrameSearchCondition.btnActionBackClick(Sender: TObject);
begin
  HideFrame;
  ReturnFrame;
end;

end.
