unit Controller_Tickets;

interface

uses
  DAO_Ticket, DTO_Ticket, DMConexao, Datasnap.DBClient, Ticket.Utils, System.SysUtils,
  DAO_Funcionario, DTO_Funcionario;

type
  TTicketFilter = class
    public
      Nome: System.String;
      CPF: System.String;
      Situacao: System.String;
      DataInicial: System.TDate;    
      DataFinal: System.TDate;
      constructor Create();

    private
      procedure InternalClear();
    
  end;


  TCTicket = class
  private
    FTotal: System.Integer;
    function GetTotal: System.Integer;
    procedure SetTotal(const Value: System.Integer);
    { Private declarations }
  public
    property Total: System.Integer read GetTotal write SetTotal;
    procedure Salvar(const AData: TDtoTicket);
    procedure Inativar(const AId: System.Integer);
    procedure CarregarDataSet(DataSet: TClientDataSet); overload;
    procedure CarregarDataSet(DataSet: TClientDataSet; AFilter: TTicketFilter); overload;
    procedure CarregarDataSetFuncionarios(DataSet: TClientDataSet); overload;
    procedure CarregarDataSetFuncionarios(DataSet: TClientDataSet; AFilter: TTicketFilter); overload;
    { Public declarations }
  end;

implementation

{ CTicket }

procedure TCTicket.CarregarDataSet(DataSet: TClientDataSet);
var
  DtoTickets: TDtoTickets;
  DtoTicket: TDtoTicket;
  DaoTicket: TDaoTickets;
begin
  DtoTickets := TDtoTickets.Create();
  DaoTicket := TDaoTickets.Create(DataModule1.FDConnection);
  DataSet.EmptyDataSet;
  DataSet.Open;
  Total := 0;
  try
    if(DaoTicket.LoadListPorSituacao(DtoTickets, 'A')) then
    begin
      for DtoTicket in DtoTickets do
      begin
        DataSet.Append;
        DataSet.FieldByName('id').AsInteger := DtoTicket.Id;
        DataSet.FieldByName('nome').AsString := DtoTicket.NomeFuncionario;
        DataSet.FieldByName('cpf').AsString := DtoTicket.CpfFuncionario;
        DataSet.FieldByName('quantidade').AsInteger:= DtoTicket.Quantidade;
        DataSet.FieldByName('situacao').AsString := iif(DtoTicket.Situacao = 'A', 'Ativo', 'Inativo');
        DataSet.FieldByName('dataEntrega').AsString := FormatDateTime('dd/mm/yyyy hh:mm', DtoTicket.DataEntrega);
        DataSet.Post;
        Total := Total + DtoTicket.Quantidade;
      end;
    end;
  finally
    DtoTickets.Free;
    DaoTicket.Free;
  end;
end;

procedure TCTicket.CarregarDataSet(DataSet: TClientDataSet; AFilter: TTicketFilter);
var
  DtoTickets: TDtoTickets;
  DtoTicket: TDtoTicket;
  DaoTicket: TDaoTickets;
begin
  if ((AFilter.Nome = '') and (AFilter.CPF = '') and (AFilter.Situacao = '')) then exit;

  DtoTickets := TDtoTickets.Create();
  DaoTicket := TDaoTickets.Create(DataModule1.FDConnection);
  DataSet.EmptyDataSet;
  DataSet.Open; 
  Total := 0;
  try
    if(DaoTicket.LoadFilteredList(DtoTickets, AFilter.Nome, AFilter.CPF, AFilter.Situacao, AFilter.DataInicial, AFilter.DataFinal)) then
    begin
      for DtoTicket in DtoTickets do
      begin
        DataSet.Append;
        DataSet.FieldByName('id').AsInteger := DtoTicket.Id;
        DataSet.FieldByName('nome').AsString := DtoTicket.NomeFuncionario; 
        DataSet.FieldByName('cpf').AsString := DtoTicket.CpfFuncionario;
        DataSet.FieldByName('quantidade').AsInteger:= DtoTicket.Quantidade;
        DataSet.FieldByName('situacao').AsString := iif(DtoTicket.Situacao = 'A', 'Ativo', 'Inativo');
        DataSet.FieldByName('dataEntrega').AsString := FormatDateTime('dd/mm/yyyy hh:mm', DtoTicket.DataEntrega);
        DataSet.Post;             
        Total := Total + DtoTicket.Quantidade;
      end;
    end;
  finally
    DtoTickets.Free;
    DaoTicket.Free;
  end;
end;

procedure TCTicket.CarregarDataSetFuncionarios(DataSet: TClientDataSet;
  AFilter: TTicketFilter);
var
  DtoFuncionarios: TDtoFuncionarios;
  DtoFuncionario: TDtoFuncionario;
  DaoFuncionario: TDaoFuncionarios;
begin
  if ((AFilter.Nome = '') and (AFilter.CPF = '') and (AFilter.Situacao = '')) then exit;

  DtoFuncionarios := TDtoFuncionarios.Create();
  DaoFuncionario := TDaoFuncionarios.Create(DataModule1.FDConnection);
  DataSet.EmptyDataSet;
  DataSet.Open;
  try
    if(DaoFuncionario.LoadFilteredList(DtoFuncionarios, AFilter.Nome, AFilter.CPF, AFilter.Situacao)) then
    begin
      for DtoFuncionario in DtoFuncionarios do
      begin
        DataSet.Append;
        DataSet.FieldByName('id').AsInteger := DtoFuncionario.Id;
        DataSet.FieldByName('nome').AsString := DtoFuncionario.Nome;
        DataSet.FieldByName('cpf').AsString := DtoFuncionario.Cpf;
        DataSet.Post;
      end;
    end;
  finally
    DtoFuncionarios.Free;
    DaoFuncionario.Free;
  end;

end;

function TCTicket.GetTotal: System.Integer;
begin
  Result := FTotal;
end;

procedure TCTicket.CarregarDataSetFuncionarios(DataSet: TClientDataSet);
var
  DtoFuncionarios: TDtoFuncionarios;
  DtoFuncionario: TDtoFuncionario;
  DaoFuncionario: TDaoFuncionarios;
begin
  DtoFuncionarios := TDtoFuncionarios.Create();
  DaoFuncionario := TDaoFuncionarios.Create(DataModule1.FDConnection);
  DataSet.EmptyDataSet;
  DataSet.Open;
  try
    if(DaoFuncionario.LoadListPorSituacao(DtoFuncionarios, 'A')) then
    begin
      for DtoFuncionario in DtoFuncionarios do
      begin
        DataSet.Append;
        DataSet.FieldByName('id').AsInteger := DtoFuncionario.Id;
        DataSet.FieldByName('nome').AsString := DtoFuncionario.Nome;
        DataSet.FieldByName('cpf').AsString := DtoFuncionario.Cpf;
        DataSet.Post;
      end;
    end;
  finally
    DtoFuncionarios.Free;
    DaoFuncionario.Free;
  end;

end;

procedure TCTicket.Inativar(const AId: System.Integer);
var
  DaoTicket: TDaoTickets;
begin
  DaoTicket := TDaoTickets.Create(DataModule1.FDConnection);
  try
    DaoTicket.SafeDisable(AId);
  finally
    DaoTicket.Free;
  end;
end;

procedure TCTicket.Salvar(const AData: TDtoTicket);
var
  DaoTicket: TDaoTickets;
begin
  DaoTicket := TDaoTickets.Create(DataModule1.FDConnection);
  try
    DaoTicket.Save(AData);
  finally
    DaoTicket.Free;
  end;
end;

procedure TCTicket.SetTotal(const Value: System.Integer);
begin
  FTotal := Value;
end;

{ TTicketFilter }

constructor TTicketFilter.Create;
begin
  InternalClear();
end;

procedure TTicketFilter.InternalClear;
begin                 
  Nome := '';
  CPF := '';
  Situacao := 'A';
  DataInicial := 0;
  DataFinal := 0;  
end;

end.
