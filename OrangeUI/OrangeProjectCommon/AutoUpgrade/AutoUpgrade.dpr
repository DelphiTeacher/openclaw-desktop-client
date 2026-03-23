program   AutoUpgrade                                                            ;

uses
  Forms,
  ufrmUpgradeMain in 'ufrmUpgradeMain.pas' {frmUpgradeMain},
  uUpgradeFileTransfers in 'uUpgradeFileTransfers.pas',
  uFileHashs in 'uFileHashs.pas',
  uMXUpgrades in 'uMXUpgrades.pas',
  uHttpRequestAPI in 'uHttpRequestAPI.pas',
  uDataMessages in 'uDataMessages.pas',
  XSuperJSON in '..\XSuperObject\XSuperJSON.pas',
  XSuperObject in '..\XSuperObject\XSuperObject.pas';

{$R *.res}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmUpgradeMain, frmUpgradeMain);
  if frmUpgradeMain.CheckVersion then
    Application.Run;
end.
