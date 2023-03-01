object ServerMethods1: TServerMethods1
  OnCreate = DSServerModuleCreate
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=PG'
      'Password=wkpass123'
      'Server=127.0.0.1'
      'Database=wkdbtest'
      'User_Name=wkusertest')
    LoginPrompt = False
    Left = 80
    Top = 48
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\pg\pgAdmin 4\bin\libpq.dll'
    Left = 64
    Top = 400
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 216
    Top = 400
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 368
    Top = 400
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 512
    Top = 400
  end
  object PessoaTable: TFDQuery
    ConstraintsEnabled = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT pessoa.idpessoa,'
      'endereco.idendereco,'
      'pessoa.flnatureza,'
      'pessoa.dsdocumento,'
      'pessoa.nmprimeiro,'
      'pessoa.nmsegundo,'
      'pessoa.dtregistro,'
      'endereco.dscep,'
      'endereco_integracao.nmcidade,'
      'endereco_integracao.nmbairro,'
      'endereco_integracao.nmlogradouro,'
      'endereco_integracao.dscomplemento '
      'FROM ((pessoa'
      'INNER JOIN endereco ON pessoa.idpessoa = endereco.idpessoa)'
      
        'INNER JOIN endereco_integracao ON endereco.idendereco = endereco' +
        '_integracao.idendereco);')
    Left = 73
    Top = 140
    object PessoaTableidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object PessoaTableidendereco: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'idendereco'
      Origin = 'idendereco'
    end
    object PessoaTableflnatureza: TSmallintField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
    end
    object PessoaTabledsdocumento: TWideStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object PessoaTablenmprimeiro: TWideStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object PessoaTablenmsegundo: TWideStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object PessoaTabledscep: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscep'
      Origin = 'dscep'
      Size = 15
    end
    object PessoaTablenmcidade: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object PessoaTablenmlogradouro: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmlogradouro'
      Origin = 'nmlogradouro'
      Size = 100
    end
    object PessoaTablenmbairro: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object PessoaTabledscomplemento: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
    object PessoaTabledtregistro: TDateField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
  end
  object FDQueryExec: TFDQuery
    Connection = FDConnection1
    Left = 224
    Top = 136
  end
end
