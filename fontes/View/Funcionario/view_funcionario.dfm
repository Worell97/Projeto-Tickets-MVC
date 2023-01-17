object frmFuncionario: TfrmFuncionario
  Left = 0
  Top = 0
  Caption = 'Funcionario'
  ClientHeight = 476
  ClientWidth = 728
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 728
    Height = 41
    Align = alTop
    Color = clTeal
    ParentBackground = False
    TabOrder = 1
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 435
    Width = 728
    Height = 41
    Align = alBottom
    Color = clTeal
    ParentBackground = False
    TabOrder = 2
    object btnNovo: TButton
      Left = 352
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Novo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnEditar: TButton
      Left = 427
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Editar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnInativar: TButton
      Left = 502
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Inativar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnInativarClick
    end
    object btnCancelar: TButton
      Left = 652
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnCancelarClick
    end
    object btnSalvar: TButton
      Left = 577
      Top = 1
      Width = 75
      Height = 39
      Align = alRight
      Caption = 'Salvar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnSalvarClick
    end
  end
  object pgMain: TPageControl
    Left = 0
    Top = 41
    Width = 728
    Height = 394
    ActivePage = tsBuscar
    Align = alClient
    TabOrder = 0
    object tsBuscar: TTabSheet
      Caption = 'Buscar'
      object pnlCenter: TPanel
        Left = 0
        Top = 0
        Width = 720
        Height = 366
        Align = alClient
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 1
          Top = 73
          Width = 718
          Height = 292
          Align = alClient
          DataSource = dsFuncionario
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'id'
              Title.Caption = 'Id'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nome'
              Title.Caption = 'Nome'
              Width = 300
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cpf'
              Title.Caption = 'CPF'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'situacao'
              Title.Caption = 'Situa'#231#227'o'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'dataAlteracao'
              Title.Caption = #218'ltima altera'#231#227'o'
              Width = 128
              Visible = True
            end>
        end
        object pnlFilter: TPanel
          Left = 1
          Top = 1
          Width = 718
          Height = 72
          Align = alTop
          Color = clActiveBorder
          ParentBackground = False
          TabOrder = 0
          object lblEdtNome: TLabeledEdit
            Left = 16
            Top = 30
            Width = 233
            Height = 21
            EditLabel.Width = 36
            EditLabel.Height = 17
            EditLabel.Caption = 'Nome'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Segoe UI'
            EditLabel.Font.Style = []
            EditLabel.ParentFont = False
            TabOrder = 0
          end
          object rgSituacao: TRadioGroup
            Left = 521
            Top = 1
            Width = 121
            Height = 70
            Align = alRight
            Caption = 'Situacao'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              'Ativo'
              'Inativo'
              'Todos')
            ParentFont = False
            TabOrder = 2
          end
          object btnFiltrar: TButton
            Left = 642
            Top = 1
            Width = 75
            Height = 70
            Align = alRight
            Caption = 'Filtrar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = btnFiltrarClick
          end
          object lblEdtCpf: TLabeledEdit
            Left = 255
            Top = 30
            Width = 160
            Height = 21
            EditLabel.Width = 21
            EditLabel.Height = 17
            EditLabel.Caption = 'CPF'
            EditLabel.Font.Charset = DEFAULT_CHARSET
            EditLabel.Font.Color = clWindowText
            EditLabel.Font.Height = -13
            EditLabel.Font.Name = 'Segoe UI'
            EditLabel.Font.Style = []
            EditLabel.ParentFont = False
            NumbersOnly = True
            TabOrder = 1
          end
        end
      end
    end
    object tsNovo: TTabSheet
      Caption = 'Novo'
      ImageIndex = 1
      object lblEdtNovoNome: TLabeledEdit
        Tag = 1
        Left = 16
        Top = 67
        Width = 233
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 17
        EditLabel.Caption = 'Nome'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Segoe UI'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 0
      end
      object lblEdtNovoCpf: TLabeledEdit
        Tag = 1
        Left = 16
        Top = 107
        Width = 233
        Height = 21
        EditLabel.Width = 21
        EditLabel.Height = 17
        EditLabel.Caption = 'CPF'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Segoe UI'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        NumbersOnly = True
        TabOrder = 1
      end
      object lblEdtId: TLabeledEdit
        Left = 16
        Top = 27
        Width = 233
        Height = 21
        EditLabel.Width = 11
        EditLabel.Height = 17
        EditLabel.Caption = 'Id'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Segoe UI'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Enabled = False
        NumbersOnly = True
        ReadOnly = True
        TabOrder = 2
      end
      object cbAtivoInativo: TCheckBox
        Left = 16
        Top = 134
        Width = 97
        Height = 17
        Caption = 'Ativo'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
    end
  end
  object dsFuncionario: TDataSource
    DataSet = cdsFuncionario
    Left = 484
    Top = 1
  end
  object cdsFuncionario: TClientDataSet
    PersistDataPacket.Data = {
      950000009619E0BD010000001800000005000000000003000000950002696404
      00010000000000046E6F6D650100490000000100055749445448020002007800
      0363706601004900000001000557494454480200020014000873697475616361
      6F0100490000000100055749445448020002000A000D64617461416C74657261
      63616F01004900000001000557494454480200020014000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 120
      end
      item
        Name = 'cpf'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'situacao'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'dataAlteracao'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 564
    Top = 1
    object cdsFuncionarioid: TIntegerField
      FieldName = 'id'
    end
    object cdsFuncionarionome: TStringField
      FieldName = 'nome'
      Size = 120
    end
    object cdsFuncionariocpf: TStringField
      FieldName = 'cpf'
    end
    object cdsFuncionariosituacao: TStringField
      FieldName = 'situacao'
      Size = 10
    end
    object cdsFuncionariodataAlteracao: TStringField
      FieldName = 'dataAlteracao'
    end
  end
end
