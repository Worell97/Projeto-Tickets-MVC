object frmTicket: TfrmTicket
  Left = 0
  Top = 0
  Caption = 'Tickets'
  ClientHeight = 449
  ClientWidth = 785
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
    Width = 785
    Height = 41
    Align = alTop
    Color = clTeal
    ParentBackground = False
    TabOrder = 0
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 408
    Width = 785
    Height = 41
    Align = alBottom
    Color = clTeal
    ParentBackground = False
    TabOrder = 1
    object btnCancelar: TButton
      Left = 709
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
    object btnEditar: TButton
      Left = 484
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
      Left = 559
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
    object btnNovo: TButton
      Left = 409
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
    object btnSalvar: TButton
      Left = 634
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
    Width = 785
    Height = 343
    ActivePage = tsBuscar
    Align = alClient
    TabOrder = 2
    object tsBuscar: TTabSheet
      Caption = 'Buscar'
      object pnlCenter: TPanel
        Left = 0
        Top = 0
        Width = 777
        Height = 315
        Align = alClient
        TabOrder = 0
        object DBGrid1: TDBGrid
          Left = 1
          Top = 89
          Width = 775
          Height = 225
          Align = alClient
          DataSource = dsTicket
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
              FieldName = 'dataEntrega'
              Title.Caption = 'Data entrega'
              Width = 114
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'quantidade'
              Title.Caption = 'Quantidade'
              Visible = True
            end>
        end
        object pnlFilter: TPanel
          Left = 1
          Top = 1
          Width = 775
          Height = 88
          Align = alTop
          Color = clActiveBorder
          ParentBackground = False
          TabOrder = 0
          object lblDataInicial: TLabel
            Left = 16
            Top = 45
            Width = 63
            Height = 17
            Caption = 'Data inicial'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblDataFinal: TLabel
            Left = 255
            Top = 45
            Width = 55
            Height = 17
            Caption = 'Data final'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblEdtNome: TLabeledEdit
            Left = 16
            Top = 22
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
            Left = 578
            Top = 1
            Width = 121
            Height = 86
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
            TabOrder = 4
          end
          object btnFiltrar: TButton
            Left = 699
            Top = 1
            Width = 75
            Height = 86
            Align = alRight
            Caption = 'Filtrar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = btnFiltrarClick
          end
          object lblEdtCpf: TLabeledEdit
            Left = 255
            Top = 22
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
          object dpDataInicial: TDatePicker
            Left = 16
            Top = 64
            Height = 21
            Date = 44942.000000000000000000
            DateFormat = 'dd/mm/yyyy'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            TabOrder = 2
            OnChange = dpDataInicialChange
          end
          object dpDataFinal: TDatePicker
            Left = 255
            Top = 64
            Width = 160
            Height = 21
            Date = 44942.000000000000000000
            DateFormat = 'dd/mm/yyyy'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            TabOrder = 3
            OnChange = dpDataFinalChange
          end
        end
      end
    end
    object tsNovo: TTabSheet
      Caption = 'Novo'
      ImageIndex = 1
      OnShow = tsNovoShow
      object pnlRight: TPanel
        Left = 297
        Top = 0
        Width = 480
        Height = 315
        Align = alClient
        TabOrder = 0
        object dbgFuncionariosPesquisa: TDBGrid
          Left = 1
          Top = 73
          Width = 478
          Height = 241
          Align = alClient
          DataSource = dsFuncionario
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDblClick = dbgFuncionariosPesquisaDblClick
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
              Width = 263
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cpf'
              Title.Caption = 'CPF'
              Width = 109
              Visible = True
            end>
        end
        object Panel2: TPanel
          Left = 1
          Top = 1
          Width = 478
          Height = 72
          Align = alTop
          Color = clActiveBorder
          ParentBackground = False
          TabOrder = 0
          object lblEditFuncionarioNome: TLabeledEdit
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
          object btnFiltrarFuncionario: TButton
            Left = 402
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
            TabOrder = 2
            OnClick = btnFiltrarFuncionarioClick
          end
          object lblEdtFuncionarioCpf: TLabeledEdit
            Left = 255
            Top = 30
            Width = 141
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
      object pnlLeft: TPanel
        Left = 0
        Top = 0
        Width = 297
        Height = 315
        Align = alLeft
        TabOrder = 1
        object lblEdtNovoQuantidade: TLabeledEdit
          Tag = 1
          Left = 16
          Top = 117
          Width = 233
          Height = 21
          EditLabel.Width = 68
          EditLabel.Height = 17
          EditLabel.Caption = 'Quantidade'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Segoe UI'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          NumbersOnly = True
          TabOrder = 0
        end
        object lblEdtNovoNome: TLabeledEdit
          Tag = 1
          Left = 16
          Top = 71
          Width = 233
          Height = 21
          EditLabel.Width = 67
          EditLabel.Height = 17
          EditLabel.Caption = 'Funcionario'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -13
          EditLabel.Font.Name = 'Segoe UI'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          Enabled = False
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
          Top = 150
          Width = 97
          Height = 17
          Caption = 'Ativo'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
      end
    end
  end
  object pnlTotalizador: TPanel
    Left = 0
    Top = 384
    Width = 785
    Height = 24
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object lblTotal: TLabel
      Left = 597
      Top = 4
      Width = 28
      Height = 17
      Caption = 'Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edtTotal: TEdit
      Left = 648
      Top = 1
      Width = 136
      Height = 22
      Align = alRight
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight, akBottom]
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      Text = '0'
      ExplicitHeight = 25
    end
  end
  object dsTicket: TDataSource
    DataSet = cdsTicket
    Left = 476
    Top = 1
  end
  object cdsTicket: TClientDataSet
    PersistDataPacket.Data = {
      A60000009619E0BD010000001800000006000000000003000000A60002696404
      00010000000000046E6F6D650100490000000100055749445448020002007800
      0363706601004900000001000557494454480200020014000873697475616361
      6F0100490000000100055749445448020002000A000B64617461456E74726567
      6101004900000001000557494454480200020014000A7175616E746964616465
      04000100000000000000}
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
        Name = 'dataEntrega'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 542
    Top = 1
    object cdsTicketid: TIntegerField
      FieldName = 'id'
    end
    object cdsTicketnome: TStringField
      FieldName = 'nome'
      Size = 120
    end
    object cdsTicketcpf: TStringField
      FieldName = 'cpf'
    end
    object cdsTicketsituacao: TStringField
      FieldName = 'situacao'
      Size = 10
    end
    object cdsTicketdataAlteracao: TStringField
      FieldName = 'dataEntrega'
    end
    object cdsTicketquantidade: TIntegerField
      FieldName = 'quantidade'
    end
  end
  object cdsFuncionario: TClientDataSet
    PersistDataPacket.Data = {
      560000009619E0BD010000001800000003000000000003000000560002696404
      00010000000000046E6F6D650100490000000100055749445448020002007800
      0363706601004900000001000557494454480200020014000000}
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
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 690
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
  end
  object dsFuncionario: TDataSource
    DataSet = cdsFuncionario
    Left = 612
    Top = 1
  end
end
