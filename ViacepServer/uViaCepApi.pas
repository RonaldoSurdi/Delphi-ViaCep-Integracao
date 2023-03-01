unit uViaCepApi;

interface
uses
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL, System.json, System.SysUtils;
type
  TViaCepApi = class
  private
    RespCode: Integer;
    Logradouro, Complemento, Bairro, Localidade, UF, IBGE, Gia, Unidade : String;
    function GetStrNumber(const S: string): string;
    procedure BuscarCep(pCep: String);
    procedure LerJson(pJson: String);
  public
    function GetRespCode: Integer;
    function GetLogradouro : String;
    function GetComplemento : String;
    function GetBairro : String;
    function GetLocalidade : String;
    function GetUF : String;
    function GetIBGE : String;
    function GetGia : String;
    constructor Create(pCEP : String);
  end;
implementation
function TViaCepApi.GetStrNumber(const S: string): string;
var
  vText : PChar;
begin
  vText := PChar(S);
  Result := '';

  while (vText^ <> #0) do begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;
procedure TViaCepApi.BuscarCep(pCEP: String);
var
  IdHTTP: TIdHTTP;
  LHandler: TIdSSLIOHandlerSocketOpenSSL;
  Json: String;
  URL : String;
  cepParse: String;
begin
  Json := '';
  IdHTTP := TIdHTTP.Create();
  LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    try
      cepParse:= GetStrNumber(pCEP);
      IdHttp.IOHandler := LHandler;
      URL := 'http://viacep.com.br/ws/' + cepParse + '/json/';
      Json := IdHTTP.Get(URL);
      RespCode := IdHTTP.ResponseCode;
    except
      RespCode := IdHTTP.ResponseCode;
      exit;
    end;
  finally
    FreeAndNil(LHandler);
    FreeAndNil(IdHTTP);
  end;
  LerJson(Json);
end;
constructor TViaCepApi.Create(pCEP: String);
begin
   BuscarCep(pCEP);
end;
function TViaCepApi.GetBairro: String;
begin
  Result := Bairro;
end;
function TViaCepApi.GetComplemento: String;
begin
  Result := Complemento;
end;
function TViaCepApi.GetGia: String;
begin
  Result := Gia;
end;
function TViaCepApi.GetIBGE: String;
begin
  Result := IBGE;
end;
function TViaCepApi.GetLocalidade: String;
begin
  Result := Localidade;
end;
function TViaCepApi.GetLogradouro: String;
begin
  Result := Logradouro;
end;
function TViaCepApi.GetRespCode: Integer;
begin
  Result := RespCode;
end;
function TViaCepApi.GetUF: String;
begin
  Result := UF;
end;
procedure TViaCepApi.LerJson(pJson: String);
var
  umJSONObject : TJSONObject;
begin
  if (pJson <> '{'#$A'  "erro": true'#$A'}') then begin
    try
      umJSONObject:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(pJson), 0) as TJSONObject;
      Logradouro  := umJSONObject.Get('logradouro').JsonValue.Value;
      Bairro      := umJSONObject.Get('bairro').JsonValue.Value;
      Localidade  := umJSONObject.Get('localidade').JsonValue.Value;
      Complemento := umJSONObject.Get('complemento').JsonValue.Value;
      IBGE        := umJSONObject.Get('ibge').JsonValue.Value;
      UF          := umJSONObject.Get('uf').JsonValue.Value;
      Gia         := umJSONObject.Get('gia').JsonValue.Value;
    finally
      FreeAndNil(umJSONObject);
    end;
  end;
end;

end.
