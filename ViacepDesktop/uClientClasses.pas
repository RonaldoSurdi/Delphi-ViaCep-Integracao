//
// Created by the DataSnap proxy generator.
// 01/03/2023 14:16:41
// 

unit uClientClasses;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type

  IDSRestCachedTFDJSONDataSets = interface;

  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FDSServerModuleCreateCommand: TDSRestCommand;
    FGetPessoaCommand: TDSRestCommand;
    FGetPessoaCommand_Cache: TDSRestCommand;
    FUpdateEnderecoCommand: TDSRestCommand;
    FInsertPessoaCommand: TDSRestCommand;
    FUpdatePessoaCommand: TDSRestCommand;
    FDeletePessoaCommand: TDSRestCommand;
    FApplyPessoaCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function GetPessoa(idpessoa: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetPessoa_Cache(idpessoa: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function UpdateEndereco(idendereco: string; dscep: string; const ARequestFilter: string = ''): Boolean;
    function InsertPessoa(idpessoa: string; flnatureza: string; dsdocumento: string; nmprimeiro: string; nmsegundo: string; dscep: string; const ARequestFilter: string = ''): Boolean;
    function UpdatePessoa(idpessoa: string; flnatureza: string; dsdocumento: string; nmprimeiro: string; nmsegundo: string; dscep: string; const ARequestFilter: string = ''): Boolean;
    function DeletePessoa(idpessoa: string; const ARequestFilter: string = ''): Boolean;
    procedure ApplyPessoa(ADeltaList: TFDJSONDeltas);
  end;

  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TServerMethods1_DSServerModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TServerMethods1_GetPessoa: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'idpessoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods1_GetPessoa_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'idpessoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_UpdateEndereco: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'idendereco'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'dscep'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods1_InsertPessoa: array [0..6] of TDSRestParameterMetaData =
  (
    (Name: 'idpessoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'flnatureza'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'dsdocumento'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'nmprimeiro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'nmsegundo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'dscep'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods1_UpdatePessoa: array [0..6] of TDSRestParameterMetaData =
  (
    (Name: 'idpessoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'flnatureza'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'dsdocumento'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'nmprimeiro'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'nmsegundo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'dscep'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods1_DeletePessoa: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'idpessoa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods1_ApplyPessoa: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'ADeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas')
  );

implementation

procedure TServerMethods1Client.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FConnection.CreateCommand;
    FDSServerModuleCreateCommand.RequestType := 'POST';
    FDSServerModuleCreateCommand.Text := 'TServerMethods1."DSServerModuleCreate"';
    FDSServerModuleCreateCommand.Prepare(TServerMethods1_DSServerModuleCreate);
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDSServerModuleCreateCommand.Execute;
end;

function TServerMethods1Client.GetPessoa(idpessoa: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetPessoaCommand = nil then
  begin
    FGetPessoaCommand := FConnection.CreateCommand;
    FGetPessoaCommand.RequestType := 'GET';
    FGetPessoaCommand.Text := 'TServerMethods1.GetPessoa';
    FGetPessoaCommand.Prepare(TServerMethods1_GetPessoa);
  end;
  FGetPessoaCommand.Parameters[0].Value.SetWideString(idpessoa);
  FGetPessoaCommand.Execute(ARequestFilter);
  if not FGetPessoaCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetPessoaCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetPessoaCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetPessoaCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.GetPessoa_Cache(idpessoa: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetPessoaCommand_Cache = nil then
  begin
    FGetPessoaCommand_Cache := FConnection.CreateCommand;
    FGetPessoaCommand_Cache.RequestType := 'GET';
    FGetPessoaCommand_Cache.Text := 'TServerMethods1.GetPessoa';
    FGetPessoaCommand_Cache.Prepare(TServerMethods1_GetPessoa_Cache);
  end;
  FGetPessoaCommand_Cache.Parameters[0].Value.SetWideString(idpessoa);
  FGetPessoaCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetPessoaCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethods1Client.UpdateEndereco(idendereco: string; dscep: string; const ARequestFilter: string): Boolean;
begin
  if FUpdateEnderecoCommand = nil then
  begin
    FUpdateEnderecoCommand := FConnection.CreateCommand;
    FUpdateEnderecoCommand.RequestType := 'GET';
    FUpdateEnderecoCommand.Text := 'TServerMethods1.UpdateEndereco';
    FUpdateEnderecoCommand.Prepare(TServerMethods1_UpdateEndereco);
  end;
  FUpdateEnderecoCommand.Parameters[0].Value.SetWideString(idendereco);
  FUpdateEnderecoCommand.Parameters[1].Value.SetWideString(dscep);
  FUpdateEnderecoCommand.Execute(ARequestFilter);
  Result := FUpdateEnderecoCommand.Parameters[2].Value.GetBoolean;
end;

function TServerMethods1Client.InsertPessoa(idpessoa: string; flnatureza: string; dsdocumento: string; nmprimeiro: string; nmsegundo: string; dscep: string; const ARequestFilter: string): Boolean;
begin
  if FInsertPessoaCommand = nil then
  begin
    FInsertPessoaCommand := FConnection.CreateCommand;
    FInsertPessoaCommand.RequestType := 'GET';
    FInsertPessoaCommand.Text := 'TServerMethods1.InsertPessoa';
    FInsertPessoaCommand.Prepare(TServerMethods1_InsertPessoa);
  end;
  FInsertPessoaCommand.Parameters[0].Value.SetWideString(idpessoa);
  FInsertPessoaCommand.Parameters[1].Value.SetWideString(flnatureza);
  FInsertPessoaCommand.Parameters[2].Value.SetWideString(dsdocumento);
  FInsertPessoaCommand.Parameters[3].Value.SetWideString(nmprimeiro);
  FInsertPessoaCommand.Parameters[4].Value.SetWideString(nmsegundo);
  FInsertPessoaCommand.Parameters[5].Value.SetWideString(dscep);
  FInsertPessoaCommand.Execute(ARequestFilter);
  Result := FInsertPessoaCommand.Parameters[6].Value.GetBoolean;
end;

function TServerMethods1Client.UpdatePessoa(idpessoa: string; flnatureza: string; dsdocumento: string; nmprimeiro: string; nmsegundo: string; dscep: string; const ARequestFilter: string): Boolean;
begin
  if FUpdatePessoaCommand = nil then
  begin
    FUpdatePessoaCommand := FConnection.CreateCommand;
    FUpdatePessoaCommand.RequestType := 'GET';
    FUpdatePessoaCommand.Text := 'TServerMethods1.UpdatePessoa';
    FUpdatePessoaCommand.Prepare(TServerMethods1_UpdatePessoa);
  end;
  FUpdatePessoaCommand.Parameters[0].Value.SetWideString(idpessoa);
  FUpdatePessoaCommand.Parameters[1].Value.SetWideString(flnatureza);
  FUpdatePessoaCommand.Parameters[2].Value.SetWideString(dsdocumento);
  FUpdatePessoaCommand.Parameters[3].Value.SetWideString(nmprimeiro);
  FUpdatePessoaCommand.Parameters[4].Value.SetWideString(nmsegundo);
  FUpdatePessoaCommand.Parameters[5].Value.SetWideString(dscep);
  FUpdatePessoaCommand.Execute(ARequestFilter);
  Result := FUpdatePessoaCommand.Parameters[6].Value.GetBoolean;
end;

function TServerMethods1Client.DeletePessoa(idpessoa: string; const ARequestFilter: string): Boolean;
begin
  if FDeletePessoaCommand = nil then
  begin
    FDeletePessoaCommand := FConnection.CreateCommand;
    FDeletePessoaCommand.RequestType := 'GET';
    FDeletePessoaCommand.Text := 'TServerMethods1.DeletePessoa';
    FDeletePessoaCommand.Prepare(TServerMethods1_DeletePessoa);
  end;
  FDeletePessoaCommand.Parameters[0].Value.SetWideString(idpessoa);
  FDeletePessoaCommand.Execute(ARequestFilter);
  Result := FDeletePessoaCommand.Parameters[1].Value.GetBoolean;
end;

procedure TServerMethods1Client.ApplyPessoa(ADeltaList: TFDJSONDeltas);
begin
  if FApplyPessoaCommand = nil then
  begin
    FApplyPessoaCommand := FConnection.CreateCommand;
    FApplyPessoaCommand.RequestType := 'POST';
    FApplyPessoaCommand.Text := 'TServerMethods1."ApplyPessoa"';
    FApplyPessoaCommand.Prepare(TServerMethods1_ApplyPessoa);
  end;
  if not Assigned(ADeltaList) then
    FApplyPessoaCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FApplyPessoaCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FApplyPessoaCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ADeltaList), True);
      if FInstanceOwner then
        ADeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FApplyPessoaCommand.Execute;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FGetPessoaCommand.DisposeOf;
  FGetPessoaCommand_Cache.DisposeOf;
  FUpdateEnderecoCommand.DisposeOf;
  FInsertPessoaCommand.DisposeOf;
  FUpdatePessoaCommand.DisposeOf;
  FDeletePessoaCommand.DisposeOf;
  FApplyPessoaCommand.DisposeOf;
  inherited;
end;

end.
