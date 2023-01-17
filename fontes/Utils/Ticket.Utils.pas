unit Ticket.Utils;

interface

uses
  System.Classes, System.Types, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, System.SysUtils,
  CustomExceptions;
  function iif(condition: Boolean; value1, value2: System.Variant): System.Variant;
  function ValidarCampos(AForm: TForm): Boolean;
  function CpfValido(const ACPF: System.String): System.Boolean;
  procedure LimparCampos(AForm: TForm);
  procedure ValidarCpf(const ACpf: System.String);


implementation
{ TUtils }

function iif(condition: Boolean; value1,
  value2: System.Variant): System.Variant;
begin
  if(condition) then
    Result := value1
  else
    Result := value2;
end;

function ValidarCampos(AForm: TForm): Boolean;
var
  Contador: System.Integer;
begin
  Result := False;
  for Contador := 0 to AForm.ComponentCount - 1 do
  begin
    if (AForm.Components[Contador].ClassType = TEdit) then
    begin
      if ((TEdit(AForm.Components[Contador]).Text = '') and TEdit(AForm.Components[Contador]).Enabled
        and (TEdit(AForm.Components[Contador]).Tag = 1)) then
      begin
        Result := true;
        TEdit(AForm.Components[Contador]).TextHint := 'Campo Obrigatório*';
      end else
      begin
        TEdit(AForm.Components[Contador]).TextHint := '';
      end;
    end;

    if (AForm.Components[Contador].ClassType = TLabeledEdit) then
    begin
      if ((TLabeledEdit(AForm.Components[Contador]).Text = '') and TLabeledEdit(AForm.Components[Contador]).Enabled
        and (TLabeledEdit(AForm.Components[Contador]).Tag = 1)) then
      begin
        Result := true;
        TLabeledEdit(AForm.Components[Contador]).TextHint := 'Campo Obrigatório*';
      end else
      begin
        TLabeledEdit(AForm.Components[Contador]).TextHint := '';
      end;
    end;

  end;
end;


procedure LimparCampos(AForm: TForm);
var
  Contador: System.Integer;
begin
  for Contador := 0 to AForm.ComponentCount - 1 do
  begin
    if AForm.Components[Contador].ClassType = TEdit then
    begin
      TEdit(AForm.Components[Contador]).Text := '';
      TEdit(AForm.Components[Contador]).TextHint := '';
    end;

    if (AForm.Components[Contador].ClassType = TLabeledEdit) then
    begin
      TLabeledEdit(AForm.Components[Contador]).Text := '';
      TLabeledEdit(AForm.Components[Contador]).TextHint := '';
    end;

    if (AForm.Components[Contador].ClassType = TRadioGroup) then
    begin
      TRadioGroup(AForm.Components[Contador]).ItemIndex := 0;
    end;
  end;
end;

function CpfValido(const ACPF: System.String): System.Boolean;
var
  v: array [0 .. 1] of Word;
  cpf: array [0 .. 10] of Byte;
  I: Byte;
begin
  Result := False;

  { Verificando se tem 11 caracteres }
  if Length(ACPF) <> 11 then
  begin
    Exit;
  end;

  { Conferindo se todos dígitos são iguais }
  if ACPF = StringOfChar('0', 11) then
    Exit;

  if ACPF = StringOfChar('1', 11) then
    Exit;

  if ACPF = StringOfChar('2', 11) then
    Exit;

  if ACPF = StringOfChar('3', 11) then
    Exit;

  if ACPF = StringOfChar('4', 11) then
    Exit;

  if ACPF = StringOfChar('5', 11) then
    Exit;

  if ACPF = StringOfChar('6', 11) then
    Exit;

  if ACPF = StringOfChar('7', 11) then
    Exit;

  if ACPF = StringOfChar('8', 11) then
    Exit;

  if ACPF = StringOfChar('9', 11) then
    Exit;

  try
    for I := 1 to 11 do
      cpf[I - 1] := StrToInt(ACPF[I]);
    // Nota: Calcula o primeiro dígito de verificação.
    v[0] := 10 * cpf[0] + 9 * cpf[1] + 8 * cpf[2];
    v[0] := v[0] + 7 * cpf[3] + 6 * cpf[4] + 5 * cpf[5];
    v[0] := v[0] + 4 * cpf[6] + 3 * cpf[7] + 2 * cpf[8];
    v[0] := 11 - v[0] mod 11;
    v[0] := iif(v[0] >= 10, 0, v[0]);
    // Nota: Calcula o segundo dígito de verificação.
    v[1] := 11 * cpf[0] + 10 * cpf[1] + 9 * cpf[2];
    v[1] := v[1] + 8 * cpf[3] + 7 * cpf[4] + 6 * cpf[5];
    v[1] := v[1] + 5 * cpf[6] + 4 * cpf[7] + 3 * cpf[8];
    v[1] := v[1] + 2 * v[0];
    v[1] := 11 - v[1] mod 11;
    v[1] := iif(v[1] >= 10, 0, v[1]);
    // Nota: Verdadeiro se os dígitos de verificação são os esperados.
    Result := ((v[0] = cpf[9]) and (v[1] = cpf[10]));
  except
    on E: Exception do
      Result := False;
  end;
end;


procedure ValidarCpf(const ACpf: System.String);
begin
  if (CpfValido(ACpf)) then
    Exit
  else
    raise TInvalidCpfException.Create('Cpf inválido');
end;

end.
