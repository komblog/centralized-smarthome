object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 256
  Width = 229
  object UniConnection1: TUniConnection
    ProviderName = 'MySQL'
    Database = 'simulator'
    Username = 'root'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object MySQLUniProvider1: TMySQLUniProvider
    Left = 144
    Top = 120
  end
  object UniQuery1: TUniQuery
    Connection = UniConnection1
    Left = 64
    Top = 104
  end
end
