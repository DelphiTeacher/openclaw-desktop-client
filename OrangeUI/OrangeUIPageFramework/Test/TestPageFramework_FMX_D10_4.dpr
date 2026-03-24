program TestPageFramework_FMX_D10_4;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit9 in 'Unit9.pas' {Form9},
  uPageFramework in '..\uPageFramework.pas',
  uBasePageFrame in '..\uBasePageFrame.pas',
  BasePageFrame in '..\FMX\BasePageFrame.pas' {FrameBaseFMXPage: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
