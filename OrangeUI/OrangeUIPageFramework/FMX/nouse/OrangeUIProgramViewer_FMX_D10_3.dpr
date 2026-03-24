program OrangeUIProgramViewer_FMX_D10_3;



uses
  System.StartUpCopy,
  FMX.Forms,
  ViewMainForm in 'ViewMainForm.pas' {frmViewMain},
  uTableCommonRestCenter in '..\OrangeUIProduct\OpenPlatform\TableCommonRestCenter\Server\uTableCommonRestCenter.pas',
  uUniDBHelper in '..\OrangeProjectCommon\DataBase\uUniDBHelper.pas',
  uBaseDBHelper in '..\OrangeProjectCommon\DataBase\uBaseDBHelper.pas',
  uDataBaseConfig in '..\OrangeProjectCommon\ServerCommon\Config\uDataBaseConfig.pas',
  uObjectPool in '..\OrangeProjectCommon\DataBase\uObjectPool.pas',
  uUniDBHelperPool in '..\OrangeProjectCommon\DataBase\uUniDBHelperPool.pas',
  uFMXUnidacDataBaseModule in '..\OrangeProjectCommon\DataBase\uFMXUnidacDataBaseModule.pas',
  uConst in 'uConst.pas',
  uPageStructure in 'uPageStructure.pas',
  uOpenClientCommon in '..\OrangeUIAppFramework\uOpenClientCommon.pas',
  uVersionChecker in '..\OrangeUIAppFramework\uVersionChecker.pas';

{$R *.res}

begin
  ReportMemoryLeaksONShutdown:=DebugHook<>0;

  Application.Initialize;
  Application.CreateForm(TfrmViewMain, frmViewMain);
  Application.Run;
end.
