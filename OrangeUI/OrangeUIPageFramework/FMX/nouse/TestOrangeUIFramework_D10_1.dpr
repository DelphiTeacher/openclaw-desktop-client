program TestOrangeUIFramework_D10_1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit5 in 'Unit5.pas' {Form5},
  TestListPageForm in 'TestListPageForm.pas' {frmTestListPage},
  XSuperJSON in '..\OrangeProjectCommon\XSuperObject\XSuperJSON.pas',
  XSuperObject in '..\OrangeProjectCommon\XSuperObject\XSuperObject.pas',
  uOpenClientCommon in '..\OrangeUIAppFramework\uOpenClientCommon.pas',
  BaseListPageFrame in 'BaseListPageFrame.pas' {FrameBaseListPage: TFrame},
  BasePageFrame in 'BasePageFrame.pas' {FrameBasePage: TFrame},
  ListItemStyleFrame_Base in '..\OrangeUIStyles\ListItemStyleFrame_Base.pas' {FrameBaseListItemStyleBase: TFrame},
  BaseParentItemStyleFrame in '..\OrangeUIStyles\BaseParentItemStyleFrame.pas' {FrameBaseParentItemStyle: TFrame},
  BaseListItemStyleFrame in '..\OrangeUIStyles\BaseListItemStyleFrame.pas' {FrameBaseListItemStyle: TFrame},
  uPageFramework in 'uPageFramework.pas',
  uPageStructure in 'uPageStructure.pas';

{$R *.res}

begin

  ReportMemoryLeaksONShutdown:=DebugHook<>0;


  Application.Initialize;
  //  Application.CreateForm(TForm1, Form1);
//  Application.CreateForm(TForm5, Form5);
  //  Application.CreateForm(TFrameBaseEditPage, FrameBaseEditPage);
  Application.CreateForm(TfrmTestListPage, frmTestListPage);
  Application.Run;
end.
