unit fMutex;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, fTela2;

type
  TfrmMutex = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Mutex;
  end;

var
  frmMutex: TfrmMutex;

implementation

{$R *.dfm}

procedure TfrmMutex.btn1Click(Sender: TObject);
begin
  Mutex;
end;

procedure TfrmMutex.Mutex;
Var
  MutexHandle: THandle;
  hwind: HWND;
begin
  MutexHandle := CreateMutex(nil, TRUE, 'MeuMutexSD'); // Cria o mutex para n deixar executar 2x
  if MutexHandle <> 0 then
  begin
    if GetLastError = ERROR_ALREADY_EXISTS then // se já existe...
    begin
      MessageBox(0, 'Esta tela já tá aberta!', '', mb_IconHand); // msg pro usuario
      CloseHandle(MutexHandle); // fecha nosso mutex
      hwind := 0; // inicia variavel utilizada para pegar a tela 2
      repeat
        hwind := FindWindowEx(0, hwind, 'TApplication', 'PegaIdTela2'); // pegamos a tela 2, filha
      until (hwind <> Application.Handle);
      if (hwind <> 0) then
      begin
        ShowWindow(hwind, SW_SHOWNORMAL);
        SetForegroundWindow(hwind);
      end;
      Halt; // se já estiver aberta, fechamos o sistema "parar"
    end
  end;
  // se não deu problema e não está aberta, abre a nossa tela 2.
  Application.Initialize;
  Application.CreateForm(TfrmTela2, frmTela2);
  frmTela2.Show;
  Application.Run;

end;

end.
