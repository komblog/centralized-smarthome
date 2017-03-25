object dtModul: TdtModul
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 282
  Width = 225
  object Database1: TUniConnection
    ProviderName = 'MySQL'
    Database = 'central_smarthome'
    SpecificOptions.Strings = (
      'SQL Server.Authentication=auServer')
    Username = 'root'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 128
    Top = 16
  end
  object sqlQuery1: TUniQuery
    Connection = Database1
    Left = 136
    Top = 80
  end
  object sqlQuery2: TUniQuery
    Connection = Database1
    Left = 136
    Top = 152
  end
  object MySQLUniProvider1: TMySQLUniProvider
    Left = 136
    Top = 200
  end
  object sqlQuery3: TUniQuery
    Connection = Database1
    Left = 80
    Top = 144
  end
end
