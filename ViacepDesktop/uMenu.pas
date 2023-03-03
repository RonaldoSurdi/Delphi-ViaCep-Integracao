unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.json,
  System.UITypes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, uViaCep, Vcl.FileCtrl, Vcl.ComCtrls;

type
  TfMenu = class(TForm)
    DataSourceRegistros: TDataSource;
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
    edDsCep: TEdit;
    lbDsCep: TLabel;
    btValidarCep: TButton;
    btAdicionar: TButton;
    btImportarArquivo: TButton;
    edEndereco: TMemo;
    StatusBar1: TStatusBar;
    procedure btAdicionarClick(Sender: TObject);
    procedure DBGridRegistrosCellClick(Column: TColumn);
    procedure btGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btValidarCepClick(Sender: TObject);
    procedure edDsCepChange(Sender: TObject);
    procedure btImportarArquivoClick(Sender: TObject);
    procedure edDsCepKeyPress(Sender: TObject; var Key: Char);
    procedure edDsCepEnter(Sender: TObject);
    procedure edDsCepExit(Sender: TObject);
  private
    { Private declarations }
    onEdit: Boolean;
    procedure LimparEditsPessoa();
    procedure LimparEditsEndereco();
    function Mascara(edt: String;str:String):string;
  public
    { Public declarations }
  end;

var
  fMenu: TfMenu;

implementation

{$R *.dfm}

uses uDataModule, DBClient, uImportFile;

procedure TfMenu.LimparEditsPessoa();
begin
  edFlNatureza.Text  := '0';
  edDsDocumento.Text := '';
  edNmPrimeiro.Text  := '';
  edNmSegundo.Text   := '';
  edDsCep.Text       := '99.999-999';
  edDsCep.Font.Color := clGrayText;
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
  onEdit:= false;
  edIdPessoa.Caption :=  'NOVO';
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

    onEdit:= false;
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
  if ((Length(edDsCep.Text) <> 10) or (edDsCep.Text = '99.999-999')) then begin
    ShowMessage('É necessário digitar o cep.');
    edDsCep.SetFocus;
    exit;
  end;

  if (onEdit) then
    ClientModule1.UpdateRegistro(
      edIdPessoa.Caption,
      edFlNatureza.Text,
      edDsDocumento.Text,
      edNmPrimeiro.Text,
      edNmSegundo.Text,
      edDsCep.Text
    )
  else
    ClientModule1.InsertRegistro(
      edFlNatureza.Text,
      edDsDocumento.Text,
      edNmPrimeiro.Text,
      edNmSegundo.Text,
      edDsCep.Text
    );

  ShowMessage('Redistro adicionado com sucesso.');
  btGravar.Enabled := true;
  btExcluir.Enabled := true;
  btAdicionar.Enabled := true;

  ClientModule1.LoadPessoa('');
  onEdit:= true;
end;

procedure TfMenu.btImportarArquivoClick(Sender: TObject);
begin
  fImportFile.ShowModal();
  ClientModule1.LoadPessoa('');
end;

procedure TfMenu.btValidarCepClick(Sender: TObject);
var
  resViaCep : TViaCep;
  resComplemento: String;
begin
  btValidarCep.Enabled:= false;
  try
    resViaCep := TViaCep.Create(edDsCep.text);
    if ((resViaCep.GetRespCode = 200) and (resViaCep.GetLocalidade <> '')) then begin
      edEndereco.Clear;
      edEndereco.Lines.Add(resViaCep.GetLocalidade + ' / ' + resViaCep.GetUf);
      edEndereco.Lines.Add(resViaCep.GetLogradouro);
      edEndereco.Lines.Add(resViaCep.GetBairro);
      resComplemento:= resViaCep.GetComplemento;
      if (resComplemento = '') then
        edEndereco.Lines.Add('(sem complemento)')
      else
        edEndereco.Lines.Add(resComplemento);
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
  if (DataSourceRegistros.DataSet.FieldByName('dscomplemento').AsString = '') then
    edEndereco.Lines.Add('(sem complemento)')
  else
    edEndereco.Lines.Add(DataSourceRegistros.DataSet.FieldByName('dscomplemento').AsString);

  edDsCep.Font.Color := clWindowText;
  btGravar.Enabled := true;
  btExcluir.Enabled := true;
  btAdicionar.Enabled := true;
  btValidarCep.Enabled := (DataSourceRegistros.DataSet.FieldByName('nmcidade').AsString <> '');

  onEdit:= true;
end;

function TfMenu.Mascara(edt: String;str:String):string;
var
  i : integer;
begin
  for i := 1 to Length(edt) do begin
     if (str[i] = '9') and not CharInSet(edt[i], ['0'..'9']) and (Length(edt)=Length(str)+1) then
        delete(edt,i,1);
     if (str[i] <> '9') and CharInSet(edt[i], ['0'..'9']) then
        insert(str[i],edt, i);
  end;
  Result := edt;
end;

procedure TfMenu.edDsCepChange(Sender: TObject);
begin
  btValidarCep.Enabled:= true;
  edDsCep.Text := Mascara(edDsCep.Text,'99.999-999');
  edDsCep.SelStart := Length(edDsCep.Text);
end;

procedure TfMenu.edDsCepEnter(Sender: TObject);
begin
  if (edDsCep.Text = '99.999-999') then begin
    edDsCep.Text := '';
    edDsCep.Font.Color := clWindowText;
  end;
end;

procedure TfMenu.edDsCepExit(Sender: TObject);
begin
  if (edDsCep.Text = '') then begin
    edDsCep.Text := '99.999-999';
    edDsCep.Font.Color := clGrayText;
  end;
end;

procedure TfMenu.edDsCepKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Abort;
end;

procedure TfMenu.FormActivate(Sender: TObject);
begin
  ClientModule1.DSRestCnn.Host := '127.0.0.1';
  ClientModule1.LoadPessoa('');
  edDsCep.Text := '99.999-999';
  edDsCep.Font.Color := clGrayText;
end;

end.
