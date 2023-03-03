unit uImportFileWorkerThread;

interface

uses
    System.SysUtils, System.Classes,
    uImportFileExecutionThread;

type
    TWorkerThread = class(TThread)
    private
        FExecution : TExecution;
        FID        : Integer;
        FRegIndex  : Integer;
        FLine      : String;
        FSuccess   : Boolean;
    protected
        procedure Execute; override;
    public
        property ID  : Integer          read  FID
                                        write FID;
        property RegIndex  : Integer    read  FRegIndex
                                        write FRegIndex;
        property Line      : String     read  FLine
                                        write FLine;
        property Success   : Boolean    read  FSuccess
                                        write FSuccess;
    end;


implementation

{ TWorkerThread }

procedure TWorkerThread.Execute;
begin
    FExecution := TExecution.Create;
    try
        FExecution.RegIndex := RegIndex;
        FExecution.Line := Line;
        FExecution.Start;
        FSuccess := FExecution.Success;
    finally
        FreeAndNil(FExecution);
    end;
end;

end.
