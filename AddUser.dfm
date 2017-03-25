object formAddUser: TformAddUser
  Left = 0
  Top = 0
  Caption = 'Add User'
  ClientHeight = 358
  ClientWidth = 426
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
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 8
    Top = 38
    Width = 39
    Height = 13
    Caption = 'Address'
  end
  object Label3: TLabel
    Left = 9
    Top = 65
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label4: TLabel
    Left = 9
    Top = 92
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label5: TLabel
    Left = 9
    Top = 119
    Width = 50
    Height = 13
    Caption = 'User Level'
  end
  object edName: TEdit
    Left = 72
    Top = 8
    Width = 345
    Height = 21
    TabOrder = 0
  end
  object edUsername: TEdit
    Left = 73
    Top = 62
    Width = 345
    Height = 21
    TabOrder = 2
  end
  object edPassword: TEdit
    Left = 73
    Top = 89
    Width = 345
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
  end
  object cbUserLevel: TComboBox
    Left = 73
    Top = 116
    Width = 345
    Height = 21
    Style = csDropDownList
    TabOrder = 4
    Items.Strings = (
      'Administrator'
      'User')
  end
  object NextGrid1: TNextGrid
    Left = 8
    Top = 143
    Width = 409
    Height = 178
    HeaderStyle = hsVista
    Options = [goGrid, goHeader, goSelectFullRow]
    TabOrder = 5
    TabStop = True
    object NxIncrementColumn1: TNxIncrementColumn
      DefaultWidth = 33
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'No'
      Header.Alignment = taCenter
      ParentFont = False
      Position = 0
      SortType = stAlphabetic
      Width = 33
    end
    object NxTextColumn1: TNxTextColumn
      DefaultWidth = 59
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Object ID'
      Header.Alignment = taCenter
      ParentFont = False
      Position = 1
      SortType = stAlphabetic
      Width = 59
    end
    object NxTextColumn2: TNxTextColumn
      DefaultWidth = 188
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Object Name'
      Header.Alignment = taCenter
      Options = [coCanClick, coCanInput, coCanSort, coEditing, coPublicUsing, coShowTextFitHint]
      ParentFont = False
      Position = 2
      SortType = stAlphabetic
      Width = 188
    end
    object NxTextColumn3: TNxListColumn
      DefaultValue = '0'
      DefaultWidth = 127
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Object Class'
      Header.Alignment = taCenter
      Options = [coAutoSize, coCanClick, coCanInput, coCanSort, coEditing, coPublicUsing, coShowTextFitHint]
      ParentFont = False
      Position = 3
      SortType = stNumeric
      Width = 127
      Items.Strings = (
        'Lamp'
        'Door'
        'Air Conditioner'
        'Fan'
        'Heater'
        'Pir'
        'Gas Sensor'
        'Rain Sensor')
    end
  end
  object btnOK: TButton
    Left = 342
    Top = 325
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 6
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 261
    Top = 325
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 7
    OnClick = btnCancelClick
  end
  object btnAddObj: TButton
    Left = 8
    Top = 325
    Width = 75
    Height = 25
    Caption = 'Add Object'
    TabOrder = 8
    OnClick = btnAddObjClick
  end
  object edAddress: TEdit
    Left = 73
    Top = 35
    Width = 345
    Height = 21
    TabOrder = 1
  end
end
