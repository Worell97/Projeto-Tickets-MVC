object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 8
    Top = 24
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Funcionarios: TMenuItem
        Caption = 'Funcionarios'
        OnClick = FuncionariosClick
      end
    end
    object Lanamentos: TMenuItem
      Caption = 'Lan'#231'amentos'
      object Tickets1: TMenuItem
        Caption = 'Tickets'
        OnClick = Tickets1Click
      end
    end
  end
end
