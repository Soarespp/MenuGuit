object dmCadastros: TdmCadastros
  OldCreateOrder = False
  Height = 367
  Width = 466
  object qryDCU: TOraQuery
    Session = DataModule1.oraConexao
    SQL.Strings = (
      'select *'
      '  from dcu')
    Left = 56
    Top = 56
    object qryDCUID: TFloatField
      FieldName = 'ID'
    end
    object qryDCUVERSAO: TFloatField
      FieldName = 'VERSAO'
    end
    object qryDCUDIRETORIO: TStringField
      FieldName = 'DIRETORIO'
      Size = 200
    end
  end
  object dsDCU: TDataSource
    DataSet = qryDCU
    Left = 56
    Top = 104
  end
  object qryExecute: TOraQuery
    Session = DataModule1.oraConexao
    Left = 216
    Top = 72
  end
  object qryComGIT: TOraQuery
    Session = DataModule1.oraConexao
    SQL.Strings = (
      'select * from comandos order by seq')
    Left = 56
    Top = 216
    object qryComGITID: TFloatField
      FieldName = 'ID'
    end
    object qryComGITFUNCAO: TStringField
      FieldName = 'FUNCAO'
      Size = 200
    end
    object qryComGITCOMANDO: TStringField
      FieldName = 'COMANDO'
      Size = 200
    end
    object qryComGITSEQ: TFloatField
      FieldName = 'SEQ'
    end
    object qryComGITOPCAO: TStringField
      FieldName = 'OPCAO'
      Size = 200
    end
  end
  object dsComGit: TDataSource
    DataSet = qryComGIT
    Left = 64
    Top = 264
  end
  object qryRotina: TOraQuery
    Session = DataModule1.oraConexao
    SQL.Strings = (
      'select substr(a.rotina,6,2) modulo ,a.* from rotina a')
    Left = 344
    Top = 144
    object qryRotinaID: TFloatField
      FieldName = 'ID'
    end
    object qryRotinaROTINA: TStringField
      FieldName = 'ROTINA'
      Size = 200
    end
    object qryRotinaLINK: TStringField
      FieldName = 'LINK'
      Size = 200
    end
    object qryRotinaMODULO: TStringField
      FieldName = 'MODULO'
      Size = 2
    end
  end
  object dsRotina: TDataSource
    DataSet = qryRotina
    Left = 344
    Top = 184
  end
  object qryAten: TOraQuery
    Session = DataModule1.oraConexao
    SQL.Strings = (
      'select r.rotina rotinanome,'
      '       case a.tipocriacao'
      '          when 0 then '#39'Comum'#39
      '          else '#39'Nova Pasta'#39
      '       end tipo,'
      '       a.*'
      '  from Atendimento a,'
      '       rotina r'
      ' where a.rotina = r.id'
      'order by a.wt;')
    Left = 168
    Top = 176
    object qryAtenID: TFloatField
      FieldName = 'ID'
    end
    object qryAtenWT: TStringField
      FieldName = 'WT'
      Size = 200
    end
    object qryAtenBRANCH: TStringField
      FieldName = 'BRANCH'
      Size = 200
    end
    object qryAtenVERSAO: TFloatField
      FieldName = 'VERSAO'
    end
    object qryAtenTIPOCRIACAO: TIntegerField
      FieldName = 'TIPOCRIACAO'
    end
    object qryAtenDTCRIACAO: TDateTimeField
      FieldName = 'DTCRIACAO'
    end
    object qryAtenROTINA: TFloatField
      FieldName = 'ROTINA'
    end
    object qryAtenTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
    object qryAtenROTINANOME: TStringField
      FieldName = 'ROTINANOME'
      Size = 200
    end
  end
  object dsAten: TDataSource
    DataSet = qryAten
    Left = 168
    Top = 208
  end
end
