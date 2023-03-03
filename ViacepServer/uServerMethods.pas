unit uServerMethods;

interface

uses System.SysUtils, System.Classes, System.Json, DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
    FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
    FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
    FireDAC.Comp.Client, Data.FireDACJSONReflect, FireDAC.Comp.UI,
    FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, uViaCepApi;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    PessoaTable: TFDQuery;
    PessoaTableidpessoa: TLargeintField;
    PessoaTableflnatureza: TSmallintField;
    PessoaTabledsdocumento: TWideStringField;
    PessoaTablenmprimeiro: TWideStringField;
    PessoaTablenmsegundo: TWideStringField;
    PessoaTabledtregistro: TDateField;
    FDQueryExec: TFDQuery;
    PessoaTableidendereco: TLargeintField;
    PessoaTabledscep: TWideStringField;
    PessoaTablenmcidade: TWideStringField;
    PessoaTablenmbairro: TWideStringField;
    PessoaTablenmlogradouro: TWideStringField;
    PessoaTabledscomplemento: TWideStringField;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure PreparePessoa(const idpessoa: string = '');
  public
    { Public declarations }
    function GetPessoa(const idpessoa: string): TFDJSONDataSets;
    function UpdateEndereco(const idendereco: string; dscep: string): Boolean;
    function InsertPessoa(flnatureza: String; dsdocumento: String; nmprimeiro: String; nmsegundo: String; dscep: String): Boolean;
    function UpdatePessoa(const idpessoa: String; flnatureza: String; dsdocumento: String; nmprimeiro: String; nmsegundo: String; dscep: String): Boolean;
    function DeletePessoa(const idpessoa: String): Boolean;
    procedure ApplyPessoa(const ADeltaList: TFDJSONDeltas);
  end;

implementation


{$R *.dfm}


procedure TServerMethods1.DSServerModuleCreate(Sender: TObject);
begin
  //
end;

procedure TServerMethods1.PreparePessoa(const idpessoa: string = '');
var
  sSQL: string;
begin
  sSQL := 'SELECT pessoa.idpessoa,' +
          'endereco.idendereco,' +
          'pessoa.flnatureza,' +
          'pessoa.dsdocumento,' +
          'pessoa.nmprimeiro,' +
          'pessoa.nmsegundo,' +
          'pessoa.dtregistro,' +
          'endereco.dscep,' +
          'endereco_integracao.nmcidade,' +
          'endereco_integracao.nmbairro,' +
          'endereco_integracao.nmlogradouro,' +
          'endereco_integracao.dscomplemento' +
          ' FROM ((pessoa ' +
          ' INNER JOIN endereco ON pessoa.idpessoa = endereco.idpessoa)' +
          ' INNER JOIN endereco_integracao ON endereco.idendereco = endereco_integracao.idendereco)';
  if not idpessoa.IsEmpty then
    sSQL := sSQL + ' WHERE pessoa.idpessoa = ' + idpessoa;
  sSQL := sSQL + ' ORDER BY pessoa.idpessoa;';
  PessoaTable.Active := False;
  PessoaTable.SQL.Text := sSQL;
end;

function TServerMethods1.GetPessoa(const idpessoa: string): TFDJSONDataSets;
begin
  PreparePessoa(idpessoa);
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, PessoaTable);
end;

function TServerMethods1.UpdateEndereco(const idendereco: string; dscep: string): Boolean;
var
  resViaCep : TViaCepApi;
  resultFunction: Boolean;
begin
  resultFunction:= false;
  try
    resViaCep := TViaCepApi.Create(dscep);
    if ((resViaCep.GetRespCode = 200) and (resViaCep.GetLocalidade <> '')) then begin
      FDConnection1.StartTransaction;
      try
        FDQueryExec.Close;
        FDQueryExec.SQL.Clear;
        FDQueryExec.SQL.Add('UPDATE endereco_integracao SET nmcidade = ' + QuotedStr(resViaCep.GetLocalidade + ' / ' + resViaCep.GetUf) +
                                                          ',nmbairro = ' + QuotedStr(resViaCep.GetBairro) +
                                                          ',nmlogradouro = ' + QuotedStr(resViaCep.GetLogradouro) +
                                                          ',dscomplemento = ' + QuotedStr(resViaCep.GetComplemento));
        FDQueryExec.SQL.Add('WHERE idendereco = ' + idendereco + ';');
        FDQueryExec.ExecSQL;

        FDConnection1.Commit;
        resultFunction:= true;
      except
        on E: Exception do
        begin
          FDConnection1.Rollback;
          raise Exception.Create('Error Message: ' + E.Message);
        end;
      end;
    end;
   finally
     FreeAndNil(resViaCep);
   end;

   Result:= resultFunction;
end;

function TServerMethods1.InsertPessoa(flnatureza: String; dsdocumento: String; nmprimeiro: String; nmsegundo: String; dscep: String): Boolean;
var
  sSQL: string;
  idpessoa: Integer;
  resultFunction: Boolean;
begin
  resultFunction:= false;
  FDConnection1.StartTransaction;
  try
    FDQueryExec.Close;
    FDQueryExec.SQL.Clear;
    FDQueryExec.SQL.Add('SELECT MAX(idpessoa) FROM pessoa');
    FDQueryExec.Open;
    if (FDQueryExec.Fields[0].AsString = 'null') then
      idpessoa:= 1
    else
      idpessoa:= FDQueryExec.Fields[0].AsInteger + 1;

    FDQueryExec.Close;
    FDQueryExec.SQL.Clear;
    FDQueryExec.SQL.Add('INSERT INTO pessoa (idpessoa,flnatureza,dsdocumento,nmprimeiro,nmsegundo,dtregistro)');
    FDQueryExec.SQL.Add('VALUES (' + IntToStr(idpessoa) + ',' + flnatureza + ',' + QuotedStr(dsdocumento) + ',' + QuotedStr(nmprimeiro) + ',' + QuotedStr(nmsegundo) + ',NOW())');
    FDQueryExec.ExecSQL;

    FDQueryExec.Close;
    FDQueryExec.SQL.Clear;
    FDQueryExec.SQL.Add('INSERT INTO endereco (idendereco,idpessoa,dscep)');
    FDQueryExec.SQL.Add('VALUES (' + IntToStr(idpessoa) + ',' + IntToStr(idpessoa) + ',' + QuotedStr(dscep) + ')');
    FDQueryExec.ExecSQL;

    FDQueryExec.Close;
    FDQueryExec.SQL.Clear;
    FDQueryExec.SQL.Add('INSERT INTO endereco_integracao (idendereco,nmcidade,nmbairro,nmlogradouro,dscomplemento)');
    FDQueryExec.SQL.Add('VALUES (' + IntToStr(idpessoa) + ',' + QuotedStr('') + ',' + QuotedStr('') + ',' + QuotedStr('') + ',' + QuotedStr('') + ')');
    FDQueryExec.ExecSQL;

    FDConnection1.Commit;
    resultFunction:= true;
  except
    on E: Exception do
    begin
      FDConnection1.Rollback;
      raise Exception.Create('Error Message: ' + E.Message);
    end;
  end;

  if (resultFunction) then
    Result:= UpdateEndereco(IntToStr(idpessoa), dscep)
  else Result:= resultFunction;
end;

function TServerMethods1.UpdatePessoa(const idpessoa: String; flnatureza: String; dsdocumento: String; nmprimeiro: String; nmsegundo: String; dscep: String): Boolean;
var
  sSQL: string;
  resultFunction: Boolean;
begin
  resultFunction:= false;
  FDConnection1.StartTransaction;
  try
    FDQueryExec.Close;
    FDQueryExec.SQL.Clear;
    FDQueryExec.SQL.Add('UPDATE pessoa SET flnatureza = ' + flnatureza + ',dsdocumento = ' + QuotedStr(dsdocumento) + ',nmprimeiro = ' + QuotedStr(nmprimeiro) + ',nmsegundo = ' + QuotedStr(nmsegundo));
    FDQueryExec.SQL.Add('WHERE idpessoa = ' + idpessoa + ';');
    FDQueryExec.ExecSQL;

    FDConnection1.Commit;
    resultFunction:= true;
  except
    on E: Exception do
    begin
      FDConnection1.Rollback;
      raise Exception.Create('Error Message: ' + E.Message);
    end;
  end;

  if (resultFunction) then
    Result:= UpdateEndereco(idpessoa, dscep)
  else Result:= resultFunction;
end;

function TServerMethods1.DeletePessoa(const idpessoa: String): Boolean;
var
  sSQL: string;
  resultFunction: Boolean;
begin
  resultFunction:= false;
  FDConnection1.StartTransaction;
  try
    FDQueryExec.Close;
    FDQueryExec.SQL.Clear;
    FDQueryExec.SQL.Add('DELETE FROM pessoa');
    FDQueryExec.SQL.Add('WHERE idpessoa = ' + idpessoa + ';');
    FDQueryExec.ExecSQL;

    FDConnection1.Commit;
    resultFunction:= true;
  except
    on E: Exception do
    begin
      FDConnection1.Rollback;
      raise Exception.Create('Error Message: ' + E.Message);
    end;
  end;

  Result:= resultFunction;
end;

procedure TServerMethods1.ApplyPessoa(const ADeltaList: TFDJSONDeltas);
var
  LApply: IFDJSONDeltasApplyUpdates;
begin
  LApply := TFDJSONDeltasApplyUpdates.Create(ADeltaList);
  FDConnection1.StartTransaction;
  try
    LApply.ApplyUpdates(0, PessoaTable.Command);
    if LApply.Errors.Count > 0 then
      Exception.Create(LApply.Errors.Strings.Text)
    else
      FDConnection1.Commit;
  except
    on E: Exception do
    begin
      FDConnection1.Rollback;
      raise Exception.Create('Error Message: ' + E.Message);
    end;
  end;
end;

end.

