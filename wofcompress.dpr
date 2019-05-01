program wofcompress;

uses
  madExcept,
  madLinkDisAsm,
  madListModules,
  Forms,
  ufrmmain in 'ufrmmain.pas' {frmmain},
  wofhelper in 'wofhelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrmmain, frmmain);
  Application.Run;
end.
