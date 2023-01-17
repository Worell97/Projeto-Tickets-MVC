unit DTO_Ticket;

interface

uses
  System.Generics.Collections, FireDAC.Comp.Client;
type
  TDtoTicket = class;
  TDtoTickets = class;
  TDtoTicket = class(TObject)
  private
    { private declarations }
    FId: System.Integer;
    FFuncionarioId: System.Integer;
    FNomeFuncionario: System.String;
    FCpfFuncionario: System.String;
    FQuantidade: System.Integer;
    FSituacao: System.String;
    FDataEntrega: System.TDateTime;
    procedure InternalClear();
    function GetQuantidade: System.Integer;
    function GetDataEntrega: System.TDateTime;
    function GetId: System.Integer;
    function GetFuncionarioId: System.Integer;
    function GetSituacao: System.String;
    function GetNomeFuncionario: System.String;
    function GetCpfFuncionario: System.String;
    procedure SetQuantidade(const Value: System.Integer);
    procedure SetDataEntrega(const Value: System.TDateTime);
    procedure SetId(const Value: System.Integer);
    procedure SetFuncionarioId(const Value: System.Integer);
    procedure SetSituacao(const Value: System.String);
    procedure SetNomeFuncionario(const Value: System.String);
    procedure SetCpfFuncionario(const Value: System.String);

  public
    constructor Create();
    procedure Clear; inline;
    property Id: System.Integer read GetId write SetId;
    property FuncionarioId: System.Integer read GetFuncionarioId write SetFuncionarioId;
    property NomeFuncionario: System.String read GetNomeFuncionario write SetNomeFuncionario;
    property CpfFuncionario: System.String read GetCpfFuncionario write SetCpfFuncionario;
    property Quantidade: System.Integer read GetQuantidade write SetQuantidade;
    property Situacao: System.String read GetSituacao write SetSituacao;
    property DataEntrega: System.TDateTime read GetDataEntrega write SetDataEntrega;
  end;

  TDtoTickets = class(TObjectList<TDtoTicket>)
  end;

implementation

{ TDtoTicket }

procedure TDtoTicket.Clear;
begin
  Self.InternalClear();
end;

constructor TDtoTicket.Create;
begin
  Self.InternalClear();
end;

function TDtoTicket.GetQuantidade: System.Integer;
begin
  result := FQuantidade;
end;

function TDtoTicket.GetCpfFuncionario: System.String;
begin
  result := FCpfFuncionario;
end;

function TDtoTicket.GetDataEntrega: System.TDateTime;
begin
  result := FDataEntrega;
end;

function TDtoTicket.GetId: System.Integer;
begin
  result := FId;
end;

function TDtoTicket.GetNomeFuncionario: System.String;
begin
  result := FNomeFuncionario;
end;

function TDtoTicket.GetFuncionarioId: System.Integer;
begin
  result := FFuncionarioId;
end;

function TDtoTicket.GetSituacao: System.String;
begin
  result := FSituacao;
end;

procedure TDtoTicket.InternalClear;
begin
  FId := 0;
  FFuncionarioId :=  0;
  FNomeFuncionario :=  '';
  FQuantidade := 0;
  FSituacao := 'A';
  FDataEntrega := 0;
end;

procedure TDtoTicket.SetQuantidade(const Value: System.Integer);
begin
  FQuantidade := Value;
end;

procedure TDtoTicket.SetCpfFuncionario(const Value: System.String);
begin
  FCpfFuncionario := Value;
end;

procedure TDtoTicket.SetDataEntrega(const Value: System.TDateTime);
begin
  FDataEntrega := Value;
end;

procedure TDtoTicket.SetId(const Value: System.Integer);
begin
  FId := Value;
end;

procedure TDtoTicket.SetNomeFuncionario(const Value: System.String);
begin
  FNomeFuncionario := Value;
end;

procedure TDtoTicket.SetFuncionarioId(const Value: System.Integer);
begin
  FFuncionarioId := Value;
end;

procedure TDtoTicket.SetSituacao(const Value: System.String);
begin
  FSituacao := Value;
end;

end.
