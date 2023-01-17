unit Controller_Funcionario;

interface

uses
  DAO_Funcionario, DTO_Funcionario, DMConexao, Datasnap.DBClient, Ticket.Utils, System.SysUtils;

type
  TFilter = class
    Nome: System.String;
    CPF: System.String;
    Situacao: System.String;
  end;

  TCFuncionario = class
  private
    { Private declarations }
  public
    procedure Salvar(const AData: TDtoFuncionario);
    procedure Inativar(const AId: System.Integer);
    procedure CarregarDataSet(DataSet: TClientDataSet); overload;
    procedure CarregarDataSet(DataSet: TClientDataSet; AFilter: TFilter); overload;
    { Public declarations }
  end;

implementation

{ CFuncionario }

procedure TCFuncionario.CarregarDataSet(DataSet: TClientDataSet);
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
        DataSet.FieldByName('situacao').AsString := iif(DtoFuncionario.Situacao = 'A', 'Ativo', 'Inativo');
        DataSet.FieldByName('dataAlteracao').AsString := FormatDateTime('dd/mm/yyyy hh:mm', DtoFuncionario.DataAlteracao);
        DataSet.Post;
      end;
    end;
  finally
    DtoFuncionarios.Free;
    DaoFuncionario.Free;
  end;
end;

procedure TCFuncionario.CarregarDataSet(DataSet: TClientDataSet; AFilter: TFilter);
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
        DataSet.FieldByName('situacao').AsString := iif(DtoFuncionario.Situacao = 'A', 'Ativo', 'Inativo');
        DataSet.FieldByName('dataAlteracao').AsString := FormatDateTime('dd/mm/yyyy hh:mm', DtoFuncionario.DataAlteracao);
        DataSet.Post;
      end;
    end;
  finally
    DtoFuncionarios.Free;
    DaoFuncionario.Free;
  end;
end;

procedure TCFuncionario.Inativar(const AId: System.Integer);
var
  DaoFuncionario: TDaoFuncionarios;
begin
  DaoFuncionario := TDaoFuncionarios.Create(DataModule1.FDConnection);
  try
    DaoFuncionario.SafeDisable(AId);
  finally
    DaoFuncionario.Free;
  end;
end;

procedure TCFuncionario.Salvar(const AData: TDtoFuncionario);
var
  DaoFuncionario: TDaoFuncionarios;
begin
  DaoFuncionario := TDaoFuncionarios.Create(DataModule1.FDConnection);
  try
    DaoFuncionario.Save(AData);
  finally
    DaoFuncionario.Free;
  end;
end;

end.
