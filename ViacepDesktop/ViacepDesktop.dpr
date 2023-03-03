program ViacepDesktop;

uses
  Vcl.Forms,
  uMenu in 'uMenu.pas' {fMenu},
  uDataModule in 'uDataModule.pas' {ClientModule1: TDataModule},
  uViaCep in 'uViaCep.pas',
  uImportFile in 'uImportFile.pas' {fImportFile},
  uImportFileWorkerThread in 'uImportFileWorkerThread.pas',
  uImportFileExecutionThread in 'uImportFileExecutionThread.pas',
  uClientClasses in 'uClientClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMenu, fMenu);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.CreateForm(TfImportFile, fImportFile);
  Application.Run;
end.
