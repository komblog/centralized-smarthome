object formLogin: TformLogin
  Left = 0
  Top = 0
  Caption = 'Authentication'
  ClientHeight = 117
  ClientWidth = 329
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
    Left = 16
    Top = 16
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object edUsername: TNxEdit
    Left = 80
    Top = 13
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object edPassword: TNxEdit
    Left = 80
    Top = 45
    Width = 233
    Height = 21
    TabOrder = 1
    PasswordChar = '*'
    OnKeyPress = edPasswordKeyPress
  end
  object btnCancel: TNxButton
    Left = 157
    Top = 80
    Width = 75
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnOK: TNxButton
    Left = 238
    Top = 80
    Width = 75
    Caption = 'Login'
    TabOrder = 3
    OnClick = btnOKClick
  end
end
