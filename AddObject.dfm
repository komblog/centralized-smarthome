object formAddObject: TformAddObject
  Left = 0
  Top = 0
  Caption = 'Tambah Object'
  ClientHeight = 167
  ClientWidth = 271
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object namaObject: TLabel
    Left = 40
    Top = 24
    Width = 69
    Height = 13
    Caption = 'Nama Object :'
  end
  object tipeObject: TLabel
    Left = 49
    Top = 56
    Width = 60
    Height = 13
    Caption = 'Tipe object :'
  end
  object powerObject: TLabel
    Left = 72
    Top = 88
    Width = 37
    Height = 13
    Caption = 'Power :'
  end
  object editNamaObject: TEdit
    Left = 128
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object cbTipeObject: TComboBox
    Left = 128
    Top = 53
    Width = 121
    Height = 21
    TabOrder = 1
    OnChange = cbTipeObjectChange
    Items.Strings = (
      'Input'
      'Output')
  end
  object editPower: TEdit
    Left = 128
    Top = 85
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object objId: TEdit
    Left = 296
    Top = 53
    Width = 49
    Height = 21
    TabOrder = 3
    Visible = False
  end
  object Button1: TButton
    Left = 40
    Top = 134
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 174
    Top = 134
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 5
    OnClick = Button2Click
  end
end
