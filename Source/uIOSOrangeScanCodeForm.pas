unit uIOSOrangeScanCodeForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  System.Messaging,
  uFuncCommon_Copy,

  FMX.Types,

//  uOrangeScanCodeControl,
//  iOSQRCodeScanForm,
  uOrangeScanCodeForm;


type
  TIOSOrangeScanCodeUI=class(TBaseOrangeScanCodeUI)
  private
    FfrmiOSQRCodeScan:TfrmiOSQRCodeScan;
  public
    FOrangeScanCodeForm:TOrangeScanCodeForm;
    constructor Create(AOrangeScanCodeForm:TOrangeScanCodeForm);override;
    destructor Destroy;override;
    procedure DoStartScan;override;
  end;

implementation

{ TIOSOrangeScanCodeUI }

constructor TIOSOrangeScanCodeUI.Create(AOrangeScanCodeForm: TOrangeScanCodeForm);
begin
  inherited;
  FfrmiOSQRCodeScan:=TfrmiOSQRCodeScan.Create(nil);

end;

destructor TIOSOrangeScanCodeUI.Destroy;
begin
  FreeAndNil(FfrmiOSQRCodeScan);
  inherited;
end;

procedure TIOSOrangeScanCodeUI.DoStartScan;
begin
  FfrmiOSQRCodeScan.FOnScanResult:=Self.FOrangeScanCodeForm.OnScanResult;
  FfrmiOSQRCodeScan.StartScan;
end;

end.
