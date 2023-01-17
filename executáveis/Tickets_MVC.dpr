program Tickets_MVC;

uses
  Vcl.Forms,
  MidasLib,
  view_principal in '..\fontes\View\view_principal.pas' {Form1},
  DMConexao in '..\fontes\DataModel\DMConexao.pas' {DataModule1: TDataModule},
  view_funcionario in '..\fontes\View\Funcionario\view_funcionario.pas' {frmFuncionario},
  Controller_Funcionario in '..\fontes\Controller\Funcionario\Controller_Funcionario.pas',
  DAO_Funcionario in '..\fontes\Model\Funcionario\DAO_Funcionario.pas',
  DTO_Funcionario in '..\fontes\Model\Funcionario\DTO_Funcionario.pas',
  DAO_Ticket in '..\fontes\Model\Ticket\DAO_Ticket.pas',
  DTO_Ticket in '..\fontes\Model\Ticket\DTO_Ticket.pas',
  Ticket.Utils in '..\fontes\Utils\Ticket.Utils.pas',
  view_ticket in '..\fontes\View\Ticket\view_ticket.pas' {frmTicket},
  Controller_Tickets in '..\fontes\Controller\Tickets\Controller_Tickets.pas',
  CustomExceptions in '..\fontes\Utils\CustomExceptions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
