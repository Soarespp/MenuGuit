object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 339
  Width = 600
  object oraConexao: TOraSession
    Username = 'GIT'
    Server = 'LOCAL'
    Connected = True
    LoginPrompt = False
    Left = 288
    Top = 152
    EncryptedPassword = 'B8FFB6FFABFF'
  end
end
