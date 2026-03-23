program TestFileSystem;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form2},
  ALIOSS in 'ALIOSS.pas',
  ALIOSSEXP in 'ALIOSSEXP.pas',
  ALIOSSMIME in 'ALIOSSMIME.pas',
  ALIOSSOPT in 'ALIOSSOPT.pas',
  ALIOSSUTIL in 'ALIOSSUTIL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
