unit DAO_Ticket;

interface

uses
  System.SysUtils,
  Data.DB,
  DTO_Ticket,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DApt,
  Ticket.Utils;
type
  TDaoTickets = class
  strict private
    const
      Select: System.UnicodeString =
          'SELECT ' +
          '  ticket.id,'+
          '  ticket.funcionario,'+
          '  ticket.quantidade,'+
          '  ticket.situacao, '+
          '  ticket.dataEntrega, '+
          '  funcionario.cpf, '+
          '  funcionario.nome '+
          'FROM ' +
          '  ticket '+
          'INNER JOIN funcionario ON '+
          '  ticket.funcionario = funcionario.id ';
      Insert: System.UnicodeString =
          'INSERT INTO ticket(' +
          '  funcionario,'+
          '  quantidade,'+
          '  situacao, '+
          '  dataEntrega) '+
          'VALUES('+
          '  :funcionario,'+
          '  :quantidade,'+
          '  :situacao, '+
          '  :dataEntrega); ';
      Update: System.UnicodeString =
          'UPDATE ' +
          ' ticket ' +
          'SET ' +
          '  situacao = :situacao, '+
          '  quantidade = :quantidade '+
          ' WHERE id = :id ';

      Disable: System.UnicodeString =
          'UPDATE ' +
          ' ticket ' +
          'SET ' +
          '  situacao = "I" '+
          'WHERE ' +
          '  id = :id';
  private
    FConnection: TFDConnection;
    class procedure InternalLoad(var AQuery: TFDQuery; const AObject: TDtoTicket); static;
  public
      constructor Create(AConnection: TFDConnection);
      procedure UnsafeSave(const AObject: TDtoTicket);
      procedure Save(const AObject: TDtoTicket);
      function Load   (const AObject: TDtoTicket; const AId: System.Integer): Boolean;
      function LoadListPorSituacao  (const AObjectList: TDtoTickets; const ASituacao: System.String): Boolean;
      function LoadListPorFuncionario  (const AObjectList: TDtoTickets; const AFuncionarioId: System.String): Boolean;
      function LoadFilteredList(const AObjectList: TDtoTickets; const ANome: System.string; const ACPF: System.string;
        const ASituacao: System.String; const ADataInicial: System.TDate; const ADataFinal: System.TDate): System.Boolean;
      procedure UnSafeDisable (const AId: System.Integer);
      procedure SafeDisable (const AId: System.Integer);
  end;
implementation
  uses
    System.TypInfo;
{ TDaoTickets }

constructor TDaoTickets.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

class procedure TDaoTickets.InternalLoad(var AQuery: TFDQuery;const AObject: TDtoTicket);
begin
  AObject.id := AQuery.FieldByName('id').AsInteger;
  AObject.NomeFuncionario := AQuery.FieldByName('nome').AsString;
  AObject.FuncionarioId := AQuery.FieldByName('funcionario').AsInteger;
  AObject.CpfFuncionario := AQuery.FieldByName('cpf').AsString;
  AObject.Quantidade := AQuery.FieldByName('quantidade').AsInteger;
  AObject.situacao := AQuery.FieldByName('situacao').AsString;
  AObject.DataEntrega := AQuery.FieldByName('dataEntrega').AsDateTime;
end;

function TDaoTickets.Load(const AObject: TDtoTicket; const AId: System.Integer): Boolean;
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

function TDaoTickets.LoadListPorFuncionario(const AObjectList: TDtoTickets;
  const AFuncionarioId: System.String): Boolean;
const
  CWhere =
    ' WHERE ' +
    '  funcionario.nome LIKE "%:funcionario%" ';
var
  LQuery: TFDQuery;
  LObjectAux : TDtoTicket;
begin
  Result := False;
  if (AFuncionarioId <> '') then
  begin
    LQuery := TFDQuery.Create(nil);
    try
      LQuery.Connection := FConnection;
      LQuery.SQL.Add(Select+CWhere);
      LQuery.ParamByName('funcionario').AsString := AFuncionarioId;
      LQuery.Open;
      Result := not(LQuery.IsEmpty);

      if (LQuery.IsEmpty) then exit;

      LQuery.First;
      while not(LQuery.Eof) do
      begin
        LObjectAux := TDtoTicket.Create;
        InternalLoad(LQuery, LObjectAux);
        AObjectList.Add(LObjectAux);
        LQuery.Next;
      end;
    finally
      LQuery.Free;
    end;
  end;
end;

function TDaoTickets.LoadListPorSituacao(const AObjectList: TDtoTickets;
  const ASituacao: System.String): Boolean;
const
  CWhere =
    ' WHERE ' +
    '  ticket.situacao = :situacao ';
var
  LQuery: TFDQuery;
  LObjectAux : TDtoTicket;
begin
  Result := False;
  if (ASituacao <> '') then
  begin
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
        LObjectAux := TDtoTicket.Create;
        InternalLoad(LQuery, LObjectAux);
        AObjectList.Add(LObjectAux);
        LQuery.Next;
      end;
    finally
      LQuery.Free;
    end;
  end;
end;

function TDaoTickets.LoadFilteredList(const AObjectList: TDtoTickets; const ANome: System.string; const ACPF: System.string;
  const ASituacao: System.string; const ADataInicial: System.TDate; const ADataFinal: System.TDate): System.Boolean;
var
  Where: System.String;
  LQuery: TFDQuery;
  LObjectAux : TDtoTicket;
begin
  Where :=
    ' WHERE TRUE' +
    iif((ASituacao <> '') and (ASituacao <> 'T'), ' and ticket.situacao = "'+ASituacao+'"', '') +
    iif(ANome <> '', ' and funcionario.nome like "%'+ANome+'%"', '') +
    iif(ACPF <> '', ' and funcionario.cpf = "'+ACPF+'"', '');
    if(ADataInicial > 0)  then
      if (ADataFinal > 0) then
      begin
        if ADataInicial = ADataFinal then
          Where := Where + ' and dataEntrega = "'+FormatDateTime('yyyy-mm-dd', ADataInicial)+'"'
        else
          Where := Where + ' and dataEntrega between "'+FormatDateTime('yyyy-mm-dd', ADataInicial)+'" and "'+
            FormatDateTime('yyyy-mm-dd', ADataFinal)+'"';
      end;


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
      LObjectAux := TDtoTicket.Create;
      InternalLoad(LQuery, LObjectAux);
      AObjectList.Add(LObjectAux);
      LQuery.Next;
    end;
  finally
    LQuery.Free;
  end;
end;

procedure TDaoTickets.SafeDisable(const AId: System.Integer);
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

procedure TDaoTickets.Save(const AObject: TDtoTicket);
begin
   FConnection.StartTransaction;
   try
      UnsafeSave(AObject);
      FConnection.Commit;
   except
      FConnection.Rollback;
      raise;
   end;
end;

procedure TDaoTickets.UnSafeDisable(const AId: System.Integer);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Add(Disable);
    LQuery.ParamByName('id').AsInteger := AId;
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;

procedure TDaoTickets.UnsafeSave(const AObject: TDtoTicket);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := FConnection;
  try
    if (AObject.Id <= 0) then
    begin
      LQuery.SQL.Add(Insert);
      LQuery.ParamByName('funcionario').AsInteger := AObject.FuncionarioId;
      LQuery.ParamByName('situacao').AsString:= AObject.Situacao;
      LQuery.ParamByName('dataEntrega').AsDateTime:= Now;
    end else
    begin
      LQuery.SQL.Add(Update);
      LQuery.ParamByName('id').AsInteger := AObject.Id;
      LQuery.ParamByName('situacao').AsString:= AObject.Situacao;
    end;
    LQuery.ParamByName('quantidade').AsInteger:= AObject.Quantidade;
    LQuery.ExecSQL;
  finally
    LQuery.Free;
  end;
end;
end.
