program Mutex;

uses
  Vcl.Forms,
  fMutex in 'fMutex.pas' {frmMutex},
  fTela2 in 'fTela2.pas' {frmTela2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMutex, frmMutex);
  Application.CreateForm(TfrmTela2, frmTela2);
  Application.Run;
end.
