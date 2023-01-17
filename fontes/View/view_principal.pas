unit view_principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, view_funcionario, view_ticket,
  System.IniFiles, DMConexao;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Funcionarios: TMenuItem;
    Lanamentos: TMenuItem;
    Tickets1: TMenuItem;
    procedure FuncionariosClick(Sender: TObject);
    procedure Tickets1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.FuncionariosClick(Sender: TObject);
var
  fFuncionario: TfrmFuncionario;
begin
  fFuncionario := TfrmFuncionario.Create(Self);
  fFuncionario.ShowModal;
  fFuncionario.Free;
end;

procedure TForm1.Tickets1Click(Sender: TObject);
var
  frmTicket: TfrmTicket;
begin
  frmTicket := TfrmTicket.Create(Self);
  frmTicket.ShowModal;
  frmTicket.Free;
end;

end.
