unit DMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  System.IniFiles, CustomExceptions, Vcl.Forms, Vcl.Dialogs, System.UITypes;

type
  TDataModule1 = class(TDataModule)
    FDConnection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }


procedure TDataModule1.DataModuleCreate(Sender: TObject);
var
  configFile: TIniFile;
  user, password, driver: System.String;
begin
  configFile := TIniFile.Create(GetCurrentDir+'\config.txt');
  try
    try
      user := configFile.ReadString('Configuracoes', 'UserName', '');
      password := configFile.ReadString('Configuracoes', 'Password', '');
      driver := configFile.ReadString('Configuracoes', 'DriverName', '');
      FDConnection.DriverName := driver;
      FDConnection.Params.UserName := user;
      FDConnection.Params.Password := password;
      FDConnection.Connected := True;
    except
      on e:Exception do
      begin
        if (MessageDlg('Erro ao conectar ao banco de dados. '#13#10+e.Message+#13#10'A aplicação será encerrada.', mtError, [mbOk], 0, mbOk) = mrOk) then
          Application.MainForm.Close;
      end;
    end;
  finally
    configFile.Free;
  end;
end;

end.
