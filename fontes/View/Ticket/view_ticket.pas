unit view_ticket;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.WinXPickers, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Ticket.Utils,
  Controller_Tickets, DTO_Ticket, Controller_Funcionario, System.UITypes;

type
  TfrmTicket = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    btnCancelar: TButton;
    btnEditar: TButton;
    btnInativar: TButton;
    btnNovo: TButton;
    btnSalvar: TButton;
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
    dsTicket: TDataSource;
    cdsTicket: TClientDataSet;
    cdsTicketid: TIntegerField;
    cdsTicketnome: TStringField;
    cdsTicketcpf: TStringField;
    cdsTicketsituacao: TStringField;
    cdsTicketdataAlteracao: TStringField;
    dpDataInicial: TDatePicker;
    lblDataInicial: TLabel;
    lblDataFinal: TLabel;
    dpDataFinal: TDatePicker;
    cdsTicketquantidade: TIntegerField;
    pnlTotalizador: TPanel;
    edtTotal: TEdit;
    pnlRight: TPanel;
    dbgFuncionariosPesquisa: TDBGrid;
    Panel2: TPanel;
    lblEditFuncionarioNome: TLabeledEdit;
    btnFiltrarFuncionario: TButton;
    lblEdtFuncionarioCpf: TLabeledEdit;
    pnlLeft: TPanel;
    lblEdtNovoQuantidade: TLabeledEdit;
    lblEdtNovoNome: TLabeledEdit;
    lblEdtId: TLabeledEdit;
    cdsFuncionario: TClientDataSet;
    cdsFuncionarioid: TIntegerField;
    cdsFuncionarionome: TStringField;
    cdsFuncionariocpf: TStringField;
    dsFuncionario: TDataSource;
    cbAtivoInativo: TCheckBox;
    lblTotal: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnInativarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFiltrarFuncionarioClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure tsNovoShow(Sender: TObject);
    procedure dbgFuncionariosPesquisaDblClick(Sender: TObject);
    procedure dpDataInicialChange(Sender: TObject);
    procedure dpDataFinalChange(Sender: TObject);
  private
    procedure ShiftMode;
    procedure ConfigForm;
    procedure Load();
    procedure FilteredLoad();
    procedure LoadFuncionariosPesquisa();
    procedure LoadFilteredFuncionario();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTicket: TfrmTicket;
  IsEditing: Boolean = false;
  idFuncionarioTicket: System.Integer;

implementation

{$R *.dfm}

procedure TfrmTicket.ShiftMode;
begin
  IsEditing := not IsEditing;
  ConfigForm();
  if IsEditing then
    pgMain.ActivePageIndex := 1
  else
    pgMain.ActivePageIndex := 0;
end;

procedure TfrmTicket.tsNovoShow(Sender: TObject);
begin
  LoadFuncionariosPesquisa();
end;

procedure TfrmTicket.btnCancelarClick(Sender: TObject);
begin
  LimparCampos(Self);
  ShiftMode();
end;

procedure TfrmTicket.btnEditarClick(Sender: TObject);
begin
  if DBGrid1.DataSource.DataSet.IsEmpty then exit;

  ShiftMode();
  lblEdtId.Text := DBGrid1.DataSource.DataSet.FindField('id').AsString;
  lblEdtNovoNome.Text := DBGrid1.DataSource.DataSet.FindField('nome').AsString;
  lblEdtNovoQuantidade.Text := DBGrid1.DataSource.DataSet.FindField('quantidade').AsString;
  cbAtivoInativo.Checked := DBGrid1.DataSource.DataSet.FindField('situacao').AsString = 'Ativo';
end;

procedure TfrmTicket.btnFiltrarClick(Sender: TObject);
begin
  FilteredLoad();
end;

procedure TfrmTicket.btnFiltrarFuncionarioClick(Sender: TObject);
begin
  LoadFilteredFuncionario();
end;

procedure TfrmTicket.btnInativarClick(Sender: TObject);
var
  Control_Ticket: TCTicket;
begin
  if DBGrid1.DataSource.DataSet.FindField('id').AsString = '' then exit;

  Control_Ticket := TCTicket.Create;
  try
    if (MessageDlg('Deseja realmente inativar este registro?',mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes) then
      Control_Ticket.Inativar(StrToInt(DBGrid1.DataSource.DataSet.FindField('id').AsString));
  finally
    Load();
  end;
end;

procedure TfrmTicket.btnNovoClick(Sender: TObject);
begin
 ShiftMode();
end;

procedure TfrmTicket.btnSalvarClick(Sender: TObject);
var
  Control_Ticket: TCTicket;
  DtoDados: TDtoTicket;
begin
  if idFuncionarioTicket <= 0 then
  begin
    ShowMessage('Selecione um funcionario do grid a direita com um duplo clique.');
    exit;
  end;
  if ValidarCampos(Self) then exit;


  Control_Ticket := TCTicket.Create;
  DtoDados := TDtoTicket.Create;
  try
    DtoDados.Id := iif(lblEdtId.Text <> '', lblEdtId.Text, 0);
    DtoDados.FuncionarioId := idFuncionarioTicket;
    DtoDados.Quantidade := StrToInt(lblEdtNovoQuantidade.Text);
    DtoDados.Situacao := iif(cbAtivoInativo.Checked, 'A', 'I');
    Control_Ticket.Salvar(DtoDados);
  finally
    DtoDados.Free;
    Control_Ticket.Free;
    ShiftMode();
    LimparCampos(Self);
    Load();
  end;
end;

procedure TfrmTicket.Load;
var
  Control_Ticket: TCTicket;
begin
  Control_Ticket := TCTicket.Create;
  try
    Control_Ticket.CarregarDataSet(cdsTicket);
    edtTotal.Text := Control_Ticket.Total.ToString;
  finally
    Control_Ticket.Free;
  end;
end;

procedure TfrmTicket.LoadFilteredFuncionario;
var
  Control_Ticket: TCTicket;
  Filter: TTicketFilter;
begin
  Filter := TTicketFilter.Create;
  Control_Ticket := TCTicket.Create;
  try
    Filter.Nome := lblEdtNome.Text;
    Filter.CPF := lblEdtCpf.Text;
    Filter.Situacao := 'A';
    Control_Ticket.CarregarDataSetFuncionarios(cdsFuncionario, Filter);
  finally
    Control_Ticket.Free;
    Filter.Free;
  end;
end;

procedure TfrmTicket.LoadFuncionariosPesquisa;
var
  Control_Ticket: TCTicket;
begin
  Control_Ticket := TCTicket.Create;
  try
    Control_Ticket.CarregarDataSetFuncionarios(cdsFuncionario);
  finally
    Control_Ticket.Free;
  end;
end;

procedure TfrmTicket.ConfigForm;
begin
  if IsEditing then
  begin
    btnSalvar.Show;
    btnCancelar.Show;
    cbAtivoInativo.Show;
    cbAtivoInativo.Enabled := lblEdtId.Text <> '';
    pnlTotalizador.Hide;
    btnInativar.Hide;
    btnEditar.Hide;
    btnNovo.Hide;
  end else
  begin
    btnSalvar.Hide;
    btnCancelar.Hide;
    cbAtivoInativo.Hide;
    pnlTotalizador.Show;
    btnInativar.Show;
    btnEditar.Show;
    btnNovo.Show;
  end;
end;

procedure TfrmTicket.dbgFuncionariosPesquisaDblClick(Sender: TObject);
begin
  idFuncionarioTicket := dbgFuncionariosPesquisa.DataSource.DataSet.FindField('id').AsInteger;
  lblEdtNovoNome.Text := dbgFuncionariosPesquisa.DataSource.DataSet.FindField('nome').AsString;
  lblEdtNovoQuantidade.SetFocus;
end;

procedure TfrmTicket.dpDataFinalChange(Sender: TObject);
begin
  if dpDataFinal.Date < dpDataInicial.Date then
    dpDataInicial.Date := dpDataFinal.Date;
end;

procedure TfrmTicket.dpDataInicialChange(Sender: TObject);
begin
  if dpDataInicial.Date > dpDataFinal.Date then
    dpDataFinal.Date := dpDataInicial.Date;
end;

procedure TfrmTicket.FilteredLoad;
var
  Control_Ticket: TCTicket;
  Filter: TTicketFilter;
begin
  Filter := TTicketFilter.Create;
  Control_Ticket := TCTicket.Create;
  try
    Filter.Nome := lblEdtNome.Text;
    Filter.CPF := lblEdtCpf.Text;
    Filter.Situacao := iif(rgSituacao.ItemIndex = 2, 'T', iif(rgSituacao.ItemIndex = 0, 'A', 'I'));
    Filter.DataInicial := dpDataInicial.Date;
    Filter.DataFinal := dpDataFinal.Date;
    Control_Ticket.CarregarDataSet(cdsTicket, Filter);
    edtTotal.Text := Control_Ticket.Total.ToString;
  finally
    Control_Ticket.Free;
    Filter.Free;
  end;
end;

procedure TfrmTicket.FormCreate(Sender: TObject);
begin
  dpDataFinal.Date := IncMonth(dpDataInicial.Date);
  tsBuscar.TabVisible := False;
  tsNovo.TabVisible := False;
  pgMain.ActivePageIndex := 0;
  IsEditing := false;
  ConfigForm();
  Load();
end;

procedure TfrmTicket.FormShow(Sender: TObject);
begin
  lblEdtNome.SetFocus();
end;

end.
