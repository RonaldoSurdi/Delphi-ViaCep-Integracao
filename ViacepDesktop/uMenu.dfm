object fMenu: TfMenu
  Left = 0
  Top = 0
  Caption = 'Menu de integra'#231#227'o'
  ClientHeight = 617
  ClientWidth = 938
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  TextHeight = 15
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
    TabOrder = 0
    ExplicitWidth = 934
  end
  object pnRegistros: TPanel
    Left = 0
    Top = 61
    Width = 666
    Height = 537
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 662
    ExplicitHeight = 536
    object DBNavigatorRegistros: TDBNavigator
      Left = 1
      Top = 1
      Width = 664
      Height = 48
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 660
    end
    object DBGridRegistros: TDBGrid
      Left = 1
      Top = 49
      Width = 664
      Height = 487
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
          Title.Caption = 'Id'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'flnatureza'
          Title.Caption = 'Natureza'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dsdocumento'
          Title.Caption = 'Documento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmprimeiro'
          Title.Caption = 'Primeiro nome'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmsegundo'
          Title.Caption = 'Segundo nome'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dscep'
          Title.Caption = 'Cep'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmcidade'
          Title.Caption = 'Cidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmlogradouro'
          Title.Caption = 'Logradouro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nmbairro'
          Title.Caption = 'Bairro'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dscomplemento'
          Title.Caption = 'Complemento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dtregistro'
          Title.Caption = 'Data registro'
          Visible = True
        end>
    end
  end
  object pnCadastro: TPanel
    Left = 666
    Top = 61
    Width = 272
    Height = 537
    Align = alRight
    TabOrder = 2
    ExplicitLeft = 662
    ExplicitHeight = 536
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
      Top = 394
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
      Top = 237
      Width = 129
      Height = 23
      MaxLength = 10
      TabOrder = 6
      OnChange = edDsCepChange
      OnEnter = edDsCepEnter
      OnExit = edDsCepExit
      OnKeyPress = edDsCepKeyPress
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
      Top = 446
      Width = 209
      Height = 28
      Caption = 'Adicionar novo registro'
      TabOrder = 8
      OnClick = btAdicionarClick
    end
    object btImportarArquivo: TButton
      Left = 32
      Top = 480
      Width = 209
      Height = 41
      Caption = 'Importar registros de arquivo'
      TabOrder = 9
      OnClick = btImportarArquivoClick
    end
    object edEndereco: TMemo
      Left = 16
      Top = 266
      Width = 241
      Height = 122
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 598
    Width = 938
    Height = 19
    Panels = <>
    ExplicitTop = 597
    ExplicitWidth = 934
  end
  object DataSourceRegistros: TDataSource
    DataSet = ClientModule1.PessoaMemTable
    Left = 56
    Top = 512
  end
end
