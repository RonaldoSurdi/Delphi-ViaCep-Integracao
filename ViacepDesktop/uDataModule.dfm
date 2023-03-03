object ClientModule1: TClientModule1
  Height = 346
  Width = 481
  object DSRestCnn: TDSRestConnection
    Host = 'localhost'
    Port = 8080
    LoginPrompt = False
    Left = 48
    Top = 40
    UniqueId = '{55C77D6E-3B89-41C1-9942-5C6E6E47F8DD}'
  end
  object PessoaMemTable: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'idpessoa'
        DataType = ftLargeint
      end
      item
        Name = 'idendereco'
        DataType = ftLargeint
      end
      item
        Name = 'flnatureza'
        DataType = ftSmallint
      end
      item
        Name = 'dsdocumento'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'nmprimeiro'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'nmsegundo'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'dscep'
        DataType = ftWideString
        Size = 15
      end
      item
        Name = 'nmcidade'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'nmlogradouro'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'nmbairro'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'dscomplemento'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'dtregistro'
        DataType = ftDate
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 48
    Top = 112
    object PessoaMemTableidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object PessoaMemTableidendereco: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'idendereco'
      Origin = 'idendereco'
    end
    object PessoaMemTableflnatureza: TSmallintField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
    end
    object PessoaMemTabledsdocumento: TWideStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object PessoaMemTablenmprimeiro: TWideStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object PessoaMemTablenmsegundo: TWideStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object PessoaMemTabledscep: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscep'
      Origin = 'dscep'
      Size = 15
    end
    object PessoaMemTablenmcidade: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object PessoaMemTablenmlogradouro: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmlogradouro'
      Origin = 'nmlogradouro'
      Size = 100
    end
    object PessoaMemTablenmbairro: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object PessoaMemTabledscomplemento: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
    object PessoaMemTabledtregistro: TDateField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 192
    Top = 40
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 352
    Top = 40
  end
  object DataSource1: TDataSource
    DataSet = PessoaMemTable
    Left = 176
    Top = 112
  end
end
