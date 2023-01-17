unit DAO_Funcionario;

interface
uses
  System.SysUtils,
  Data.DB,
  DTO_Funcionario,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DApt,
  Ticket.Utils,
  CustomExceptions;
type
  TDaoFuncionarios = class
  strict private
    const
      Select: System.UnicodeString =
          'SELECT ' +
          '  id,'+
          '  nome,'+
          '  cpf,'+
          '  situacao, '+
          '  dataAlteracao '+
          'FROM ' +
          '  funcionario ';
      SelectCpf: System.UnicodeString =
          'SELECT ' +
          '  cpf '+
          'FROM ' +
          '  funcionario ';
      Insert: System.UnicodeString =
          'INSERT INTO funcionario(' +
          '  nome,'+
          '  cpf,'+
          '  situacao, '+
          '  dataAlteracao) '+
          'VALUES('+
          '  :nome,'+
          '  :cpf,'+
          '  :situacao, '+
          '  :dataAlteracao) ';
      Update: System.UnicodeString =
          'UPDATE ' +
          ' funcionario ' +
          'SET ' +
          '  nome = :nome, '+
          '  cpf = :cpf, '+
          '  situacao = :situacao, '+
          '  dataAlteracao = :dataAlteracao ' +
          ' WHERE id = :id ';

      Disable: System.UnicodeString =
          'UPDATE ' +
          ' funcionario ' +
          'SET ' +
          '  situacao = "I", '+
          '  dataAlteracao = :dataAlteracao '+
          'WHERE ' +
          '  id = :id';

  private
    FConnection: TFDConnection;
    class procedure InternalLoad(var AQuery: TFDQuery; const AObject: TDtoFuncionario); static;
  public
      constructor Create(AConnection: TFDConnection);
      procedure UnsafeSave(const AObject: TDtoFuncionario);
      procedure Save(const AObject: TDtoFuncionario);
      function Load   (const AObject: TDtoFuncionario; const AId: System.Integer): System.Boolean;
      function LoadListPorSituacao  (const AObjectList: TDtoFuncionarios; const ASituacao: System.String): System.Boolean;
      function LoadFilteredList(const AObjectList: TDtoFuncionarios; const ANome: System.string;
        const ACPF: System.string; const ASituacao: System.string): System.Boolean;
      function VerificaCpfJaCadastrado(const ACpf: System.String): System.Boolean;
      procedure UnSafeDisable (const AId: System.Integer);
      procedure SafeDisable (const AId: System.Integer);
  end;
implementation
  uses
    System.TypInfo;
{ TDaoFuncionarios }

constructor TDaoFuncionarios.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

class procedure TDaoFuncionarios.InternalLoad(var AQuery: TFDQuery;const AObject: TDtoFuncionario);
begin
  AObject.id := AQuery.FieldByName('id').AsInteger;
  AObject.nome := AQuery.FieldByName('nome').AsString;
  AObject.cpf := AQuery.FieldByName('cpf').AsString;
  AObject.situacao := AQuery.FieldByName('situacao').AsString;
  AObject.DataAlteracao := AQuery.FieldByName('dataAlteracao').AsDateTime;
end;

function TDaoFuncionarios.Load(const AObject: TDtoFuncionario; const AId: System.Integer): Boolean;
const
  CWhere =
    ' WHERE ' +
    '  id = :id';
var
  LQuery: TFDQuery;
begin
  Result := False;
  if (AId > 0) then
  begin
    LQuery := TFDQuery.Create(nil);
    try
      LQuery.Connection := FConnection;
      LQuery.SQL.Add(Select+CWhere);
      LQuery.ParamByName('id').AsInteger := AId;
      LQuery.Open;
      Result := not(LQuery.IsEmpty);
      if not(LQuery.IsEmpty) then
        InternalLoad(LQuery, AObject);
    finally
      LQuery.Free;
    end;
  end;
end;

function TDaoFuncionarios.LoadFilteredList(const AObjectList: TDtoFuncionarios;
  const ANome: System.string; const ACPF: System.string; const ASituacao: System.string): System.Boolean;
var
  Where: System.String;
  LQuery: TFDQuery;
  LObjectAux : TDtoFuncionario;
begin
  Where :=
    ' WHERE TRUE' +
    iif((ASituacao <> '') and (ASituacao <> 'T'), ' and situacao = "'+ASituacao+'"', '') +
    iif(ANome <> '', ' and nome like "%'+ANome+'%"', '') +
    iif(ACPF <> '', ' and cpf = "'+ACPF+'%"', '');

  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Add(Select+Where);
    LQuery.Open;
    Result := not(LQuery.IsEmpty);

    if (LQuery.IsEmpty) then exit;

    LQuery.First;
    while not(LQuery.Eof) do
    begin
      LObjectAux := TDtoFuncionario.Create;
      InternalLoad(LQuery, LObjectAux);
      AObjectList.Add(LObjectAux);
      LQuery.Next;
    end;
  finally
    LQuery.Free;
  end;
end;

function TDaoFuncionarios.LoadListPorSituacao(const AObjectList: TDtoFuncionarios;
  const ASituacao: System.String): Boolean;
const
  CWhere =
    ' WHERE ' +
    '  situacao = :situacao ';
var
  LQuery: TFDQuery;
  LObjectAux : TDtoFuncionario;
begin
  Result := False;
  if (ASituacao = '') then exit;

  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Add(Select+CWhere);
    LQuery.ParamByName('situacao').AsString := ASituacao;
    LQuery.Open;
    Result := not(LQuery.IsEmpty);

    if (LQuery.IsEmpty) then exit;

    LQuery.First;
    while not(LQuery.Eof) do
    begin
      LObjectAux := TDtoFuncionario.Create;
      InternalLoad(LQuery, LObjectAux);
      AObjectList.Add(LObjectAux);
      LQuery.Next;
    end;
  finally
    LQuery.Free;
  end;
end;

procedure TDaoFuncionarios.SafeDisable(const AId: System.Integer);
begin
  FConnection.StartTransaction;
  try
    UnSafeDisable(AId);
    FConnection.Commit;
  except
    FConnection.Rollback;
    raise
  end;
end;

procedure TDaoFuncionarios.Save(const AObject: TDtoFuncionario);
begin
   FConnection.StartTransaction;
   try
      ValidarCpf(AObject.Cpf);

      if(AObject.Id <= 0) then
        if(VerificaCpfJaCadastrado(AObject.Cpf)) then
          raise TDuplicatedCpfException.Create('Cpf já cadastrado');

      UnsafeSave(AObject);
      FConnection.Commit;
   except
      FConnection.Rollback;
      raise;
   end;
end;

procedure TDaoFuncionarios.UnSafeDisable(const AId: System.Integer);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Add(Disable);
    LQuery.ParamByName('id').AsInteger := AId;
    LQuery.ParamByName('dataAlteracao').AsDateTime := Now;
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

procedure TDaoFuncionarios.UnsafeSave(const AObject: TDtoFuncionario);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);

  try
    LQuery.Connection := FConnection;
    if (AObject.Id <= 0) then
    begin
      LQuery.SQL.Add(Insert);
    end else
    begin
      LQuery.SQL.Add(Update);
      LQuery.ParamByName('id').AsInteger := AObject.Id;
    end;
    LQuery.ParamByName('nome').AsString := AObject.nome;
    LQuery.ParamByName('cpf').AsString:= AObject.cpf;
    LQuery.ParamByName('situacao').AsString:= AObject.Situacao;
    LQuery.ParamByName('dataAlteracao').AsDateTime:= Now;
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

function TDaoFuncionarios.VerificaCpfJaCadastrado(
  const ACpf: System.String): System.Boolean;
const
  CWhere =
    ' WHERE ' +
    '  cpf = :cpf';
var
  LQuery: TFDQuery;
begin
  Result := False;
  if (ACpf <> '') then
  begin
    LQuery := TFDQuery.Create(nil);
    try
      LQuery.Connection := FConnection;
      LQuery.SQL.Add(Select+CWhere);
      LQuery.ParamByName('cpf').AsString := ACpf;
      LQuery.Open;
      Result := not(LQuery.IsEmpty);
    finally
      LQuery.Free;
    end;
  end;
end;

end.
