object formUsageLimit: TformUsageLimit
  Left = 0
  Top = 0
  Caption = 'Power Limit'
  ClientHeight = 97
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 34
    Height = 13
    Caption = 'Cluster'
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 121
    Height = 13
    Caption = 'Maximum Power per User'
  end
  object cbCluster: TComboBox
    Left = 135
    Top = 10
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 0
    OnChange = cbClusterChange
  end
  object edMaxPower: TEdit
    Left = 135
    Top = 37
    Width = 145
    Height = 21
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 216
    Top = 64
    Width = 65
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 135
    Top = 64
    Width = 65
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
