object formUbahRule: TformUbahRule
  Left = 0
  Top = 0
  Caption = 'Ubah Rule'
  ClientHeight = 202
  ClientWidth = 264
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
  object Label1: TLabel
    Left = 23
    Top = 16
    Width = 31
    Height = 13
    Caption = 'Obj_in'
  end
  object Label2: TLabel
    Left = 23
    Top = 56
    Width = 68
    Height = 13
    Caption = 'Obj_in_Status'
  end
  object Label3: TLabel
    Left = 23
    Top = 96
    Width = 39
    Height = 13
    Caption = 'Obj_out'
  end
  object Label4: TLabel
    Left = 23
    Top = 136
    Width = 75
    Height = 13
    Caption = 'Obj_out_status'
  end
  object cbObjIn: TComboBox
    Left = 104
    Top = 8
    Width = 145
    Height = 21
    TabOrder = 0
  end
  object editObjInStatus: TEdit
    Left = 104
    Top = 53
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object cbObjOut: TComboBox
    Left = 104
    Top = 93
    Width = 145
    Height = 21
    TabOrder = 2
  end
  object editObjOutStatus: TEdit
    Left = 104
    Top = 133
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object tombolCancel: TButton
    Left = 64
    Top = 169
    Width = 50
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = tombolCancelClick
  end
  object tombolOk: TButton
    Left = 206
    Top = 169
    Width = 50
    Height = 25
    Caption = 'OK'
    TabOrder = 5
    OnClick = tombolOkClick
  end
end
