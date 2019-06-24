program Lactec_CRUD;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {FormIndex},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Lactec_CRUD';
  TStyleManager.TrySetStyle('Metropolis UI Blue');
  Application.CreateForm(TFormIndex, FormIndex);
  Application.Run;
end.
