unit uImportFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, System.Generics.Collections, uImportFileWorkerThread;

type
  TfImportFile = class(TForm)
    sbImport: TStatusBar;
    pnProgress: TPanel;
    btLocalizarArquivo: TBitBtn;
    FileImportDialog: TFileOpenDialog;
    DisplayMemo: TMemo;
    ProcessProgressBar: TProgressBar;
    PrepareProgressBar: TProgressBar;
    procedure btLocalizarArquivoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    InExec: Boolean;
    RegCount: Integer;
    ThreadList : TList<TWorkerThread>;
    procedure WorkerThreadTerminate(Sender : TObject);
    procedure ImportarCSV(FileName:String);
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;
  end;

var
  fImportFile: TfImportFile;

implementation

{$R *.dfm}

constructor TfImportFile.Create(AOwner: TComponent);
begin
    ThreadList := TList<TWorkerThread>.Create;
    inherited Create(AOwner);
end;

destructor TfImportFile.Destroy;
begin
    FreeAndNil(ThreadList);
    inherited Destroy;
end;

procedure TfImportFile.FormActivate(Sender: TObject);
begin
    InExec:= false;
    PrepareProgressBar.Position:= 0;
    ProcessProgressBar.Position:= 0;
    DisplayMemo.Clear;
end;

procedure TfImportFile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (InExec) then begin
    Showmessage('Aguarde finalização do processamento...');
    Action:=CaNone;
  end;
end;

procedure TfImportFile.WorkerThreadTerminate(Sender: TObject);
var
  WorkerThread : TWorkerThread;
begin
  WorkerThread := TWorkerThread(Sender);
  ThreadList.Remove(WorkerThread);

  Inc(RegCount);
  ProcessProgressBar.Position:= RegCount;

  if ThreadList.Count = 0 then begin
    Sleep(500);
    DisplayMemo.Lines.Add('');
    DisplayMemo.Lines.Add('');
    DisplayMemo.Lines.Add('Registros importados com sucesso.');
    btLocalizarArquivo.Enabled:= True;
    ShowMessage('Registros importados com sucesso.');
    InExec:= false;
  end;
end;

procedure TfImportFile.ImportarCSV(FileName:String);
var
  WorkerThread: TWorkerThread;
  ArquivoCSV: TextFile;
  RegIndex: Integer;
  PrepareCount: Integer;
  Linha: String;
begin
  InExec:= true;
  btLocalizarArquivo.Enabled:= False;
  RegCount:= 0;
  PrepareCount:= 0;
  PrepareProgressBar.Position:= 0;
  ProcessProgressBar.Position:= 0;
  ProcessProgressBar.Max:= 0;
  DisplayMemo.Clear;
  DisplayMemo.Lines.Add('Importando arquivo: ');
  DisplayMemo.Lines.Add(FileName);
  DisplayMemo.Lines.Add('');

  RegIndex:= 0;
  AssignFile(ArquivoCSV, FileName);
  Application.ProcessMessages;

  try
    Reset(ArquivoCSV);
    while not Eoln(ArquivoCSV) do begin
      Sleep(5);
      Inc(RegIndex);
      Readln(ArquivoCSV, Linha);
      WorkerThread                 := TWorkerThread.Create(True);
      WorkerThread.ID              := RegIndex;
      WorkerThread.RegIndex        := RegIndex;
      WorkerThread.Line            := Linha;
      WorkerThread.Priority        := tpLower;
      WorkerThread.OnTerminate     := WorkerThreadTerminate;
      WorkerThread.FreeOnTerminate := True;
      ThreadList.Add(WorkerThread);
      DisplayMemo.Lines.Add(Format('Processando thread %d', [WorkerThread.RegIndex]));
      WorkerThread.Start;
      if (PrepareCount < 10) then
        Inc(PrepareCount)
      else PrepareCount:= 1;
      PrepareProgressBar.Position:= PrepareCount;
      Application.ProcessMessages;
    end;
  finally
    CloseFile(ArquivoCSV);
  end;

  PrepareProgressBar.Position:= 10;
  ProcessProgressBar.Max:= RegIndex;
  DisplayMemo.Lines.Add('');
  DisplayMemo.Lines.Add(Format('Existem %d threads em execução.', [RegIndex ]));
  DisplayMemo.Lines.Add('');
end;

procedure TfImportFile.btLocalizarArquivoClick(Sender: TObject);
begin
  if FileImportDialog.Execute then
    if FileExists(FileImportDialog.FileName) then
      ImportarCSV(FileImportDialog.FileName);
end;

end.
