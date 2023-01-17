object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Database=tickets'
      'User_Name=tickets')
    Left = 32
    Top = 64
  end
end
