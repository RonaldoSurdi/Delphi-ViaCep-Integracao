unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.json,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, uViaCep, Vcl.FileCtrl;

type
  TfMenu = class(TForm)
    DataSourceRegistros: TDataSource;
    Panel1: TPanel;
    edtHostName: TEdit;
    pnTitle: TPanel;
    pnRegistros: TPanel;
    DBNavigatorRegistros: TDBNavigator;
    pnCadastro: TPanel;
    DBGridRegistros: TDBGrid;
    lbFlNatureza: TLabel;
    edFlNatureza: TEdit;
    lbDsDocumento: TLabel;
    edDsDocumento: TEdit;
    edNmPrimeiro: TEdit;
    lbNmPrimeiro: TLabel;
    edNmSegundo: TEdit;
    lbNmSegundo: TLabel;
    btGravar: TButton;
    btExcluir: TButton;
    edIdPessoa: TLabel;
    Label1: TLabel;
    edDsCep: TEdit;
    lbDsCep: TLabel;
    btValidarCep: TButton;
    btAdicionar: TButton;
    btImportarArquivo: TButton;
    edEndereco: TMemo;
    FileImportDialog: TFileOpenDialog;
    procedure btAdicionarClick(Sender: TObject);
    procedure DBGridRegistrosCellClick(Column: TColumn);
    procedure btGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btValidarCepClick(Sender: TObject);
    procedure edDsCepChange(Sender: TObject);
    procedure btImportarArquivoClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparEditsPessoa();
    procedure LimparEditsEndereco();
    procedure ImportarCSV(FileName:String);
  public
    { Public declarations }
  end;

var
  fMenu: TfMenu;

implementation

{$R *.dfm}

uses uDataModule, DBClient;

procedure TfMenu.LimparEditsPessoa();
begin
  edFlNatureza.Text  := '0';
  edDsDocumento.Text := '';
  edNmPrimeiro.Text  := '';
  edNmSegundo.Text   := '';
  edDsCep.Text       := '';
end;

procedure TfMenu.LimparEditsEndereco();
begin
  btValidarCep.Enabled:= true;
  edEndereco.Clear;
end;

procedure TfMenu.btAdicionarClick(Sender: TObject);
var
  idNext: Integer;
begin
  idNext := DataSourceRegistros.DataSet.RecordCount + 1;
  edIdPessoa.Caption :=  IntToStr(idNext);
  LimparEditsPessoa();
  LimparEditsEndereco();
  btGravar.Enabled := true;
  btExcluir.Enabled := false;
  btAdicionar.Enabled := false;
  edFlNatureza.SetFocus;
end;

procedure TfMenu.btExcluirClick(Sender: TObject);
begin
  if MessageDlg('Tem certeza que deseja excluir o registro [' + edIdPessoa.Caption + ']?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then begin

    ClientModule1.DeleteRegistro(edIdPessoa.Caption);

    ShowMessage('Redistro excluido com sucesso.');

    ClientModule1.LoadPessoa('');
  end;
end;

procedure TfMenu.btGravarClick(Sender: TObject);
begin
  if (edIdPessoa.Caption = '0') then begin
    ShowMessage('É necessário ativar a conexão');
    exit;
  end;
  if (edFlNatureza.Text = '0') then begin
    ShowMessage('É necessário digitar a natureza.');
    edFlNatureza.SetFocus;
    exit;
  end;
  if (edDsDocumento.Text = '') then begin
    ShowMessage('É necessário digitar o documento.');
    edDsDocumento.SetFocus;
    exit;
  end;
  if (edNmPrimeiro.Text = '') then begin
    ShowMessage('É necessário digitar o primeiro nome.');
    edNmPrimeiro.SetFocus;
    exit;
  end;
  if (edNmSegundo.Text = '') then begin
    ShowMessage('É necessário digitar o segundo nome.');
    edNmSegundo.SetFocus;
    exit;
  end;
  if (Length(edDsCep.Text) <> 10) then begin
    ShowMessage('É necessário digitar o cep.');
    edDsCep.SetFocus;
    exit;
  end;

  if (btExcluir.Enabled) then begin
    ClientModule1.UpdateRegistro(
      edIdPessoa.Caption,
      edFlNatureza.Text,
      edDsDocumento.Text,
      edNmPrimeiro.Text,
      edNmSegundo.Text,
      edDsCep.Text
    );
  end else begin
    ClientModule1.InsertRegistro(
      edIdPessoa.Caption,
      edFlNatureza.Text,
      edDsDocumento.Text,
      edNmPrimeiro.Text,
      edNmSegundo.Text,
      edDsCep.Text
    );
  end;

  btGravar.Enabled := true;
  btExcluir.Enabled := true;
  btAdicionar.Enabled := true;

  ShowMessage('Redistro adicionado com sucesso.');
  ClientModule1.LoadPessoa('');
end;


procedure TfMenu.btImportarArquivoClick(Sender: TObject);
begin
  if FileImportDialog.Execute then
    if FileExists(FileImportDialog.FileName) then
      ImportarCSV(FileImportDialog.FileName);
end;

procedure TfMenu.ImportarCSV(FileName:String);
var
  ArquivoCSV: TextFile;
  Contador, I: Integer;
  Linha: String;
  flnaturezaParse: String;
  dsdocumentoParse: String;
  nmprimeiroParse: String;
  nmsegundoParse: String;
  dscepParse: String;
  idNext: Integer;

  function MontaValor: String;
  var
    ValorMontado: String;
  begin
    ValorMontado := '';
    inc(I);
    while (Length(Linha) >= I) do begin
      if Linha[I] = ';' then
        break;
      ValorMontado := ValorMontado + Linha[I];
      inc(I);
    end;
    result := ValorMontado;
  end;

begin
  AssignFile(ArquivoCSV, FileName);

  try
    Reset(ArquivoCSV);
    Contador := 1;
    idNext := DataSourceRegistros.DataSet.RecordCount + 1;
    while not Eoln(ArquivoCSV) do begin
      Readln(ArquivoCSV, Linha);
      I := 0;
      flnaturezaParse:= MontaValor;
      dsdocumentoParse:= MontaValor;
      nmprimeiroParse:= MontaValor;
      nmsegundoParse:= MontaValor;
      dscepParse:= MontaValor;
      ClientModule1.InsertRegistro(
        IntToStr(idNext),
        flnaturezaParse,
        dsdocumentoParse,
        nmprimeiroParse,
        nmsegundoParse,
        dscepParse
      );
      Inc(Contador);
      Inc(idNext);
    end;
  finally
    CloseFile(ArquivoCSV);
  end;

  ShowMessage('Redistros importados com sucesso.');
  ClientModule1.LoadPessoa('');
end;

procedure TfMenu.btValidarCepClick(Sender: TObject);
var
  resViaCep : TViaCep;
begin
  btValidarCep.Enabled:= false;
  try
    resViaCep := TViaCep.Create(edDsCep.text);
    if ((resViaCep.GetRespCode = 200) and (resViaCep.GetLocalidade <> '')) then begin
      edEndereco.Clear;
      edEndereco.Lines.Add(resViaCep.GetLocalidade + ' / ' + resViaCep.GetUf);
      edEndereco.Lines.Add(resViaCep.GetLogradouro);
      edEndereco.Lines.Add(resViaCep.GetBairro);
      edEndereco.Lines.Add(resViaCep.GetComplemento);
    end else begin
      LimparEditsEndereco();
      showMessage('CEP inválido ou não encontrado');
    end;
   finally
     FreeAndNil(resViaCep);
   end;
end;

procedure TfMenu.DBGridRegistrosCellClick(Column: TColumn);
begin
  edIdPessoa.Caption :=  DataSourceRegistros.DataSet.FieldByName('idpessoa').AsString;
  edFlNatureza.Text := DataSourceRegistros.DataSet.FieldByName('flnatureza').AsString;
  edDsDocumento.Text := DataSourceRegistros.DataSet.FieldByName('dsdocumento').AsString;
  edNmPrimeiro.Text := DataSourceRegistros.DataSet.FieldByName('nmprimeiro').AsString;
  edNmSegundo.Text := DataSourceRegistros.DataSet.FieldByName('nmsegundo').AsString;
  edDsCep.Text := DataSourceRegistros.DataSet.FieldByName('dscep').AsString;
  edEndereco.Clear;
  edEndereco.Lines.Add(DataSourceRegistros.DataSet.FieldByName('nmcidade').AsString);
  edEndereco.Lines.Add(DataSourceRegistros.DataSet.FieldByName('nmlogradouro').AsString);
  edEndereco.Lines.Add(DataSourceRegistros.DataSet.FieldByName('nmbairro').AsString);
  edEndereco.Lines.Add(DataSourceRegistros.DataSet.FieldByName('dscomplemento').AsString);

  btGravar.Enabled := true;
  btExcluir.Enabled := true;
  btAdicionar.Enabled := true;
  btValidarCep.Enabled := (DataSourceRegistros.DataSet.FieldByName('nmcidade').AsString <> '');
end;

procedure TfMenu.edDsCepChange(Sender: TObject);
begin
  btValidarCep.Enabled:= true;
end;

procedure TfMenu.FormActivate(Sender: TObject);
begin
  ClientModule1.DSRestCnn.Host := edtHostName.Text;
  ClientModule1.LoadPessoa('');
end;

end.
