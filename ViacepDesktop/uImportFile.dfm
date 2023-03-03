object fImportFile: TfImportFile
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Importar registros de arquivo'
  ClientHeight = 521
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  TextHeight = 15
  object sbImport: TStatusBar
    Left = 0
    Top = 502
    Width = 697
    Height = 19
    Panels = <>
    ExplicitTop = 501
    ExplicitWidth = 693
  end
  object pnProgress: TPanel
    Left = 0
    Top = 0
    Width = 697
    Height = 502
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 693
    ExplicitHeight = 501
    object btLocalizarArquivo: TBitBtn
      Left = 16
      Top = 13
      Width = 665
      Height = 45
      Caption = 'Localizar arquivo'
      TabOrder = 0
      OnClick = btLocalizarArquivoClick
    end
    object DisplayMemo: TMemo
      Left = 16
      Top = 64
      Width = 665
      Height = 377
      Lines.Strings = (
        'DisplayMemo')
      ReadOnly = True
      ScrollBars = ssHorizontal
      TabOrder = 1
    end
    object ProcessProgressBar: TProgressBar
      Left = 16
      Top = 452
      Width = 665
      Height = 41
      TabOrder = 2
    end
    object PrepareProgressBar: TProgressBar
      Left = 16
      Top = 443
      Width = 665
      Height = 9
      Max = 10
      TabOrder = 3
    end
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
    Left = 64
    Top = 361
  end
end
