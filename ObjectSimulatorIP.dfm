object formObjectSimulatorIPAddress: TformObjectSimulatorIPAddress
  Left = 0
  Top = 0
  Caption = 'Object Simulator IP Address'
  ClientHeight = 93
  ClientWidth = 289
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
    Left = 8
    Top = 11
    Width = 134
    Height = 13
    Caption = 'Object Simulator IP Address'
  end
  object Label2: TLabel
    Left = 8
    Top = 38
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object edIP: TNxEdit
    Left = 148
    Top = 8
    Width = 133
    Height = 21
    TabOrder = 0
    Text = 'localhost'
  end
  object btnConnect: TNxButton
    Left = 179
    Top = 62
    Width = 102
    Caption = 'Connect'
    TabOrder = 1
    OnClick = btnConnectClick
  end
  object edPort: TNxEdit
    Left = 148
    Top = 35
    Width = 133
    Height = 21
    TabOrder = 2
    Text = '16209'
  end
  object NxButton1: TNxButton
    Left = 71
    Top = 62
    Width = 102
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = NxButton1Click
  end
end
