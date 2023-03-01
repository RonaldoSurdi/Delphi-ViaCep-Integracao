object fMenu: TfMenu
  Left = 0
  Top = 0
  Caption = 'Menu de integra'#231#227'o'
  ClientHeight = 574
  ClientWidth = 938
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnActivate = FormActivate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 542
    Width = 938
    Height = 32
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 528
    ExplicitWidth = 934
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 49
      Height = 30
      Align = alLeft
      Alignment = taRightJustify
      Caption = 'Servidor: '
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object edtHostName: TEdit
      AlignWithMargins = True
      Left = 55
      Top = 6
      Width = 235
      Height = 20
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Text = '127.0.0.1'
      TextHint = 'Hostname or IP Address'
      ExplicitHeight = 21
    end
  end
  object pnTitle: TPanel
    Left = 0
    Top = 0
    Width = 938
    Height = 61
    Align = alTop
    Caption = 'TESTE DE CADASTRO DE ENDERE'#199'OS E INTEGRA'#199#195'O VIACEP'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -19
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 934
  end
  object pnRegistros: TPanel
    Left = 0
    Top = 61
    Width = 666
    Height = 481
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 402
    ExplicitHeight = 467
    object DBNavigatorRegistros: TDBNavigator
      Left = 1
      Top = 1
      Width = 664
      Height = 48
      DataSource = ClientModule1.DataSource1
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 400
    end
    object DBGridRegistros: TDBGrid
      Left = 1
      Top = 49
      Width = 664
      Height = 431
      Align = alClient
      DataSource = ClientModule1.DataSource1
      FixedColor = clBtnShadow
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = DBGridRegistrosCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'idpessoa'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'flnatureza'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dsdocumento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmprimeiro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmsegundo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dscep'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmcidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmlogradouro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmbairro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dscomplemento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dtregistro'
          Visible = True
        end>
    end
  end
  object pnCadastro: TPanel
    Left = 666
    Top = 61
    Width = 272
    Height = 481
    Align = alRight
    TabOrder = 3
    ExplicitLeft = 405
    ExplicitTop = 55
    ExplicitHeight = 468
    object lbFlNatureza: TLabel
      Left = 32
      Top = 49
      Width = 47
      Height = 15
      Caption = 'Natureza'
    end
    object lbDsDocumento: TLabel
      Left = 32
      Top = 90
      Width = 63
      Height = 15
      Caption = 'Documento'
    end
    object lbNmPrimeiro: TLabel
      Left = 32
      Top = 131
      Width = 79
      Height = 15
      Caption = 'Primeiro nome'
    end
    object lbNmSegundo: TLabel
      Left = 32
      Top = 174
      Width = 81
      Height = 15
      Caption = 'Segundo nome'
    end
    object edIdPessoa: TLabel
      Left = 32
      Top = 15
      Width = 9
      Height = 21
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lbDsCep: TLabel
      Left = 32
      Top = 219
      Width = 21
      Height = 15
      Caption = 'Cep'
    end
    object edFlNatureza: TEdit
      Left = 32
      Top = 64
      Width = 209
      Height = 23
      NumbersOnly = True
      TabOrder = 0
      Text = '0'
    end
    object edDsDocumento: TEdit
      Left = 32
      Top = 106
      Width = 209
      Height = 23
      MaxLength = 20
      TabOrder = 1
    end
    object edNmPrimeiro: TEdit
      Left = 32
      Top = 147
      Width = 209
      Height = 23
      MaxLength = 100
      TabOrder = 2
    end
    object edNmSegundo: TEdit
      Left = 32
      Top = 192
      Width = 209
      Height = 23
      MaxLength = 100
      TabOrder = 3
    end
    object btGravar: TButton
      Left = 32
      Top = 344
      Width = 209
      Height = 46
      Caption = 'Gravar'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btGravarClick
    end
    object btExcluir: TButton
      Left = 152
      Top = 13
      Width = 89
      Height = 25
      Caption = 'Excluir'
      Enabled = False
      TabOrder = 5
      OnClick = btExcluirClick
    end
    object edDsCep: TEdit
      Left = 32
      Top = 236
      Width = 129
      Height = 23
      MaxLength = 10
      TabOrder = 6
      Text = '89.705-046'
      OnChange = edDsCepChange
    end
    object btValidarCep: TButton
      Left = 167
      Top = 235
      Width = 74
      Height = 25
      Caption = 'Validar'
      TabOrder = 7
      OnClick = btValidarCepClick
    end
    object btAdicionar: TButton
      Left = 32
      Top = 397
      Width = 209
      Height = 28
      Caption = 'Adicionar novo registro'
      TabOrder = 8
      OnClick = btAdicionarClick
    end
    object btImportarArquivo: TButton
      Left = 32
      Top = 432
      Width = 209
      Height = 28
      Caption = 'Importar registros de arquivo'
      TabOrder = 9
      OnClick = btImportarArquivoClick
    end
    object edEndereco: TMemo
      Left = 32
      Top = 266
      Width = 209
      Height = 72
      TabStop = False
      Alignment = taCenter
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 10
    end
  end
  object DataSourceRegistros: TDataSource
    DataSet = ClientModule1.PessoaMemTable
    Left = 56
    Top = 448
  end
  object FileImportDialog: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'TXT'
        FileMask = '*.txt'
      end
      item
        DisplayName = 'CSV'
        FileMask = '*.csv'
      end>
    FileTypeIndex = 0
    Options = []
    Title = 'Importar registros de arquivo'
    Left = 168
    Top = 448
  end
end
