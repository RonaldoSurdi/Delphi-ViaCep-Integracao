unit uImportFileExecutionThread;

interface

uses System.SysUtils, System.Classes;

type
    TExecution = class
    const
        NoOfTimes = 1000000;
    private
        CharPosInLine : Integer;
        FRegIndex     : Integer;
        FLine         : String;
        FSuccess      : Boolean;
        function Value(const Linha: String): String;
    public
        procedure Start;
        property RegIndex  : Integer    read  FRegIndex
                                        write FRegIndex;
        property Line      : String     read  FLine
                                        write FLine;
        property Success   : Boolean    read  FSuccess
                                        write FSuccess;
    end;

implementation

uses uDataModule;

{ TExecution }

function TExecution.Value(const Linha: String): String;
var
  ValorMontado: String;
begin
  ValorMontado := '';
  inc(CharPosInLine);
  while (Length(Linha) >= CharPosInLine) do begin
    if Linha[CharPosInLine] = ';' then
      break;
    ValorMontado := ValorMontado + Linha[CharPosInLine];
    inc(CharPosInLine);
  end;
  Result := ValorMontado;
end;

procedure TExecution.Start;
var
  flnaturezaParse,
  dsdocumentoParse,
  nmprimeiroParse,
  nmsegundoParse,
  dscepParse: String;
begin
  CharPosInLine := 0;
  flnaturezaParse:= Value(Line);
  dsdocumentoParse:= Value(Line);
  nmprimeiroParse:= Value(Line);
  nmsegundoParse:= Value(Line);
  dscepParse:= Value(Line);
  ClientModule1.InsertRegistro(
    flnaturezaParse,
    dsdocumentoParse,
    nmprimeiroParse,
    nmsegundoParse,
    dscepParse
  );
  Success:= true;
end;

end.
