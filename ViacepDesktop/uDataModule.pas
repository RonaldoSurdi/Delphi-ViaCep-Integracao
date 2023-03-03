unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, uClientClasses, Datasnap.DSClientRest,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageJSON;


type
  TClientModule1 = class(TDataModule)
    DSRestCnn: TDSRestConnection;
    PessoaMemTable: TFDMemTable;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    PessoaMemTableidpessoa: TLargeintField;
    PessoaMemTableidendereco: TLargeintField;
    PessoaMemTableflnatureza: TSmallintField;
    PessoaMemTabledsdocumento: TWideStringField;
    PessoaMemTablenmprimeiro: TWideStringField;
    PessoaMemTablenmsegundo: TWideStringField;
    PessoaMemTabledscep: TWideStringField;
    PessoaMemTablenmcidade: TWideStringField;
    PessoaMemTablenmlogradouro: TWideStringField;
    PessoaMemTablenmbairro: TWideStringField;
    PessoaMemTabledscomplemento: TWideStringField;
    PessoaMemTabledtregistro: TDateField;
    DataSource1: TDataSource;
  private
    FInstanceOwner: Boolean;
    FServerMethods1Client: TServerMethods1Client;
    function GetServerMethods1Client: TServerMethods1Client;
    { Private declarations }
  public
    procedure LoadPessoa(const idpessoa: string);
    procedure InsertRegistro(flnatureza: String; dsdocumento: String; nmprimeiro: String; nmsegundo: String; dscep: String);
    procedure UpdateRegistro(const idpessoa: string; flnatureza: String; dsdocumento: String; nmprimeiro: String; nmsegundo: String; dscep: String);
    procedure DeleteRegistro(const idpessoa: string);
    procedure SavePessoa;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethods1Client: TServerMethods1Client read GetServerMethods1Client write FServerMethods1Client;

end;

var
  ClientModule1: TClientModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses Data.FireDACJSONReflect;

constructor TClientModule1.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule1.Destroy;
begin
  FServerMethods1Client.Free;
  inherited;
end;

function TClientModule1.GetServerMethods1Client: TServerMethods1Client;
begin
  if FServerMethods1Client = nil then
    FServerMethods1Client:= TServerMethods1Client.Create(DSRestCnn, FInstanceOwner);
  Result := FServerMethods1Client;
end;

procedure TClientModule1.LoadPessoa(const idpessoa: string);
var
  LDataSetList: TFDJSONDataSets;
begin
  LDataSetList := ServerMethods1Client.GetPessoa(idpessoa);
  PessoaMemTable.Close;
  PessoaMemTable.AppendData(TFDJSONDataSetsReader.GetListValue
    (LDataSetList, 0));
  PessoaMemTable.Open;
end;

procedure TClientModule1.InsertRegistro(flnatureza: String; dsdocumento: String; nmprimeiro: String; nmsegundo: String; dscep: String);
begin
  ServerMethods1Client.InsertPessoa(flnatureza,dsdocumento,nmprimeiro,nmsegundo,dscep);
end;

procedure TClientModule1.UpdateRegistro(const idpessoa: string; flnatureza: String; dsdocumento: String; nmprimeiro: String; nmsegundo: String; dscep: String);
begin
  ServerMethods1Client.UpdatePessoa(idpessoa,flnatureza,dsdocumento,nmprimeiro,nmsegundo,dscep);
end;

procedure TClientModule1.DeleteRegistro(const idpessoa: string);
begin
  ServerMethods1Client.DeletePessoa(idpessoa);
end;

procedure TClientModule1.SavePessoa;
var
  Delta: TFDJSONDeltas;
begin
  if PessoaMemTable.State in dsEditModes then
    PessoaMemTable.Post;
  Delta := TFDJSONDeltas.Create;
  TFDJSONDeltasWriter.ListAdd(Delta, PessoaMemTable);
  ServerMethods1Client.ApplyPessoa(Delta);
end;

end.
