unit DTO_Funcionario;

interface

uses
  System.Generics.Collections, FireDAC.Comp.Client;
type
  TDtoFuncionario = class;
  TDtoFuncionarios = class;
  TDtoFuncionario = class(TObject)
  private
    { private declarations }
    FId: System.Integer;
    FNome: System.String;
    FCpf: System.String;
    FSituacao: System.String;
    FDataAlteracao: System.TDateTime;
    procedure InternalClear();
    function GetCpf: System.String;
    function GetDataAlteracao: System.TDateTime;
    function GetId: System.Integer;
    function GetNome: System.String;
    function GetSituacao: System.String;
    procedure SetCpf(const Value: System.String);
    procedure SetDataAlteracao(const Value: System.TDateTime);
    procedure SetId(const Value: System.Integer);
    procedure SetNome(const Value: System.String);
    procedure SetSituacao(const Value: System.String);

  public
    constructor Create();
    procedure Clear; inline;
    property Id: System.Integer read GetId write SetId;
    property Nome: System.String read GetNome write SetNome;
    property Cpf: System.String read GetCpf write SetCpf;
    property Situacao: System.String read GetSituacao write SetSituacao;
    property DataAlteracao: System.TDateTime read GetDataAlteracao write SetDataAlteracao;
  end;

  TDtoFuncionarios = class(TObjectList<TDtoFuncionario>)
  end;

implementation

{ TDtoFuncionario }

procedure TDtoFuncionario.Clear;
begin
  Self.InternalClear();
end;

constructor TDtoFuncionario.Create;
begin
  Self.InternalClear();
end;

function TDtoFuncionario.GetCpf: System.String;
begin
  result := FCpf;
end;

function TDtoFuncionario.GetDataAlteracao: System.TDateTime;
begin
  result := FDataAlteracao;
end;

function TDtoFuncionario.GetId: System.Integer;
begin
  result := FId;
end;

function TDtoFuncionario.GetNome: System.String;
begin
  result := FNome;
end;

function TDtoFuncionario.GetSituacao: System.String;
begin
  result := FSituacao;
end;

procedure TDtoFuncionario.InternalClear;
begin
  FId := 0;
  FNome :=  '';
  FCpf := '';
  FSituacao := 'A';
  FDataAlteracao := 0;
end;

procedure TDtoFuncionario.SetCpf(const Value: System.String);
begin
  FCpf := Value;
end;

procedure TDtoFuncionario.SetDataAlteracao(const Value: System.TDateTime);
begin
  FDataAlteracao := Value;
end;

procedure TDtoFuncionario.SetId(const Value: System.Integer);
begin
  FId := Value;
end;

procedure TDtoFuncionario.SetNome(const Value: System.String);
begin
  FNome := Value;
end;

procedure TDtoFuncionario.SetSituacao(const Value: System.String);
begin
  FSituacao := Value;
end;

end.
