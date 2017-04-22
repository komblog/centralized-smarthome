object formMain: TformMain
  Left = 0
  Top = 0
  Caption = 'Object Simulator'
  ClientHeight = 605
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poDesigned
  OnShow = FormShow
  DesignSize = (
    439
    605)
  PixelsPerInch = 96
  TextHeight = 13
  object NextGrid1: TNextGrid
    Left = 0
    Top = 0
    Width = 439
    Height = 605
    Align = alClient
    HeaderStyle = hsVista
    Options = [goGrid, goHeader, goRowResizing, goSelectFullRow]
    TabOrder = 0
    TabStop = True
    OnAfterEdit = NextGrid1AfterEdit
    object NxIncrementColumn1: TNxIncrementColumn
      DefaultWidth = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'No'
      ParentFont = False
      Position = 0
      SortType = stAlphabetic
      Width = 30
    end
    object NxTextColumn1: TNxTextColumn
      Alignment = taCenter
      DefaultWidth = 56
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
      Width = 56
    end
    object NxTextColumn2: TNxTextColumn
      DefaultWidth = 91
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Object Name'
      Header.Alignment = taCenter
      ParentFont = False
      Position = 2
      SortType = stAlphabetic
      Width = 91
    end
    object NxProgressColumn1: TNxProgressColumn
      DefaultValue = '0'
      DefaultWidth = 50
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Status'
      Header.Alignment = taCenter
      ParentFont = False
      Position = 3
      SortType = stNumeric
      Width = 50
      HideWhenEmpty = False
      LowValueColor = clBlack
      ProgressStyle = psSolid
    end
    object NxTextColumn3: TNxTextColumn
      DefaultWidth = 46
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Power'
      Header.Alignment = taCenter
      Options = [coAutoSize, coCanClick, coCanInput, coCanSort, coPublicUsing, coShowTextFitHint]
      ParentFont = False
      Position = 4
      SortType = stAlphabetic
      Width = 46
    end
    object NxTextColumn5: TNxTextColumn
      DefaultWidth = 84
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'IP'
      Header.Alignment = taCenter
      ParentFont = False
      Position = 5
      SortType = stAlphabetic
      Width = 84
    end
    object NxTextColumn4: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'SET'
      Header.Alignment = taCenter
      Options = [coCanClick, coCanInput, coCanSort, coEditing, coPublicUsing, coShowTextFitHint]
      ParentFont = False
      Position = 6
      SortType = stAlphabetic
    end
  end
  object NxButton1: TNxButton
    Left = 350
    Top = 574
    Width = 81
    Anchors = [akRight, akBottom]
    Caption = 'Default Port'
    TabOrder = 1
    OnClick = NxButton1Click
  end
  object NxPanel1: TNxPanel
    Left = 182
    Top = 568
    Width = 249
    Height = 29
    AdaptiveColors = False
    Anchors = [akRight, akBottom]
    Caption = 'NxPanel1'
    Color = clWhite
    UseDockManager = False
    ParentColor = False
    TabOrder = 2
    Visible = False
    object edPort: TEdit
      Left = 3
      Top = 4
      Width = 169
      Height = 21
      TabOrder = 0
      Text = '16209'
    end
    object NxButton2: TNxButton
      Left = 175
      Top = 3
      Width = 71
      Caption = 'Set'
      TabOrder = 1
      OnClick = NxButton2Click
    end
  end
  object IdTCPServer1: TIdTCPServer
    Active = True
    Bindings = <>
    DefaultPort = 16209
    OnDisconnect = IdTCPServer1Disconnect
    OnExecute = IdTCPServer1Execute
    Left = 96
    Top = 536
  end
  object PopupMenu1: TPopupMenu
    Left = 16
    Top = 536
    object Refresh2: TMenuItem
      Caption = 'Refresh'
      OnClick = Refresh2Click
    end
  end
  object IdTCPClientUpdate: TIdTCPClient
    ConnectTimeout = 0
    Host = 'localhost'
    IPVersion = Id_IPv4
    Port = 13550
    ReadTimeout = 0
    Left = 376
    Top = 520
  end
end
