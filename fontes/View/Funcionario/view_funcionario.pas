unit view_funcionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Data.DB, Vcl.DBGrids, Datasnap.DBClient, Vcl.StdCtrls, DAO_Funcionario, DTO_Funcionario,
  DMConexao, FireDAC.Comp.Client, Controller_Funcionario, Ticket.Utils, System.UITypes;

type
  TfrmFuncionario = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    dsFuncionario: TDataSource;
    cdsFuncionario: TClientDataSet;
    btnNovo: TButton;
    btnEditar: TButton;
    btnInativar: TButton;
    pgMain: TPageControl;
    tsBuscar: TTabSheet;
    pnlCenter: TPanel;
    DBGrid1: TDBGrid;
    pnlFilter: TPanel;
    lblEdtNome: TLabeledEdit;
    rgSituacao: TRadioGroup;
    btnFiltrar: TButton;
    lblEdtCpf: TLabeledEdit;
    tsNovo: TTabSheet;
    btnCancelar: TButton;
    btnSalvar: TButton;
    lblEdtNovoNome: TLabeledEdit;
    lblEdtNovoCpf: TLabeledEdit;
    cdsFuncionarioid: TIntegerField;
    cdsFuncionarionome: TStringField;
    cdsFuncionariocpf: TStringField;
    cdsFuncionariosituacao: TStringField;
    cdsFuncionariodataAlteracao: TStringField;
    lblEdtId: TLabeledEdit;
    cbAtivoInativo: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnInativarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Load();
    procedure FilteredLoad();
    procedure ShiftMode();
    procedure ConfigButtons();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFuncionario: TfrmFuncionario;
  IsEditing: Boolean;

implementation

{$R *.dfm}

{ TfrmFuncionario }

procedure TfrmFuncionario.btnCancelarClick(Sender: TObject);
begin
  LimparCampos(Self);
  ShiftMode();
end;

procedure TfrmFuncionario.btnEditarClick(Sender: TObject);
begin
  if DBGrid1.DataSource.DataSet.IsEmpty then exit;

  ShiftMode();
  lblEdtId.Text := DBGrid1.DataSource.DataSet.FindField('id').AsString;
  lblEdtNovoNome.Text := DBGrid1.DataSource.DataSet.FindField('nome').AsString;
  lblEdtNovoCpf.Text := DBGrid1.DataSource.DataSet.FindField('cpf').AsString;
  cbAtivoInativo.Checked := DBGrid1.DataSource.DataSet.FindField('situacao').AsString = 'Ativo';
end;

procedure TfrmFuncionario.btnFiltrarClick(Sender: TObject);
begin
  FilteredLoad();
end;

procedure TfrmFuncionario.btnInativarClick(Sender: TObject);
var
  Control_Funcionario: TCFuncionario;
begin
  if DBGrid1.DataSource.DataSet.FindField('id').AsString = '' then exit;

  Control_Funcionario := TCFuncionario.Create;
  try
    if (MessageDlg('Deseja realmente inativar este registro?',mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes) then
      Control_Funcionario.Inativar(StrToInt(DBGrid1.DataSource.DataSet.FindField('id').AsString));
  finally
    Load();
  end;
end;

procedure TfrmFuncionario.btnNovoClick(Sender: TObject);
begin
  ShiftMode();
end;

procedure TfrmFuncionario.btnSalvarClick(Sender: TObject);
var
  Control_Funcionario: TCFuncionario;
  DtoDados: TDtoFuncionario;
begin
  if ValidarCampos(Self) then exit;

  Control_Funcionario := TCFuncionario.Create;
  DtoDados := TDtoFuncionario.Create;

  try
    DtoDados.Id := iif(lblEdtId.Text <> '', lblEdtId.Text, 0);
    DtoDados.Nome := lblEdtNovoNome.Text;
    DtoDados.Cpf := lblEdtNovoCpf.Text;
    DtoDados.Situacao := iif(cbAtivoInativo.Checked, 'A', 'I');
    Control_Funcionario.Salvar(DtoDados);
  finally
    DtoDados.Free;
    Control_Funcionario.Free;
  end;

  Load();
  ShiftMode();
end;

procedure TfrmFuncionario.ConfigButtons;
begin
  if IsEditing then
  begin
    btnSalvar.Show;
    btnCancelar.Show;
    btnInativar.Hide;
    btnEditar.Hide;
    btnNovo.Hide;
  end else
  begin
    btnSalvar.Hide;
    btnCancelar.Hide;
    btnInativar.Show;
    btnEditar.Show;
    btnNovo.Show;
  end;
end;

procedure TfrmFuncionario.ShiftMode;
begin
  IsEditing := not IsEditing;
  ConfigButtons();
  if pgMain.ActivePageIndex = 0 then
    pgMain.ActivePageIndex := 1
  else
    pgMain.ActivePageIndex := 0;
end;

procedure TfrmFuncionario.FilteredLoad;
var
  Control_Funcionario: TCFuncionario;
  Filter: TFilter;
begin
  Filter := TFilter.Create;
  Control_Funcionario := TCFuncionario.Create;
  try
    Filter.Nome := lblEdtNome.Text;
    Filter.CPF := lblEdtCpf.Text;
    Filter.Situacao := iif(rgSituacao.ItemIndex = 2, 'T', iif(rgSituacao.ItemIndex = 0, 'A', 'I'));
    Control_Funcionario.CarregarDataSet(cdsFuncionario, Filter);
  finally
    Control_Funcionario.Free;
    Filter.Free;
  end;
end;

procedure TfrmFuncionario.FormCreate(Sender: TObject);
begin
  tsBuscar.TabVisible := False;
  tsNovo.TabVisible := False;
  pgMain.ActivePageIndex := 0;
  IsEditing := false;
  ConfigButtons();
  Load();
end;

procedure TfrmFuncionario.FormShow(Sender: TObject);
begin
  lblEdtNome.SetFocus();
end;

procedure TfrmFuncionario.Load;
var
  Control_Funcionario: TCFuncionario;
begin
  LimparCampos(Self);
  Control_Funcionario := TCFuncionario.Create;
  try
    Control_Funcionario.CarregarDataSet(cdsFuncionario);
  finally
    Control_Funcionario.Free;
  end;
end;

end.
