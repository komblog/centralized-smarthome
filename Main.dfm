object formMain: TformMain
  Left = 0
  Top = -55
  Caption = 'Centralized Smarthome'
  ClientHeight = 721
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object NxSplitter1: TNxSplitter
    Left = 233
    Top = 25
    Width = 1
    Height = 677
    ExplicitHeight = 446
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 702
    Width = 773
    Height = 19
    Panels = <>
    ExplicitTop = 691
  end
  object NxPanelLeft: TNxPanel
    Left = 0
    Top = 25
    Width = 233
    Height = 677
    AdaptiveColors = False
    Align = alLeft
    Caption = 'NxPanelLeft'
    Color = clWhite
    UseDockManager = False
    PanelBorders = []
    ParentColor = False
    TabOrder = 1
    ExplicitHeight = 666
    object TreeView1: TTreeView
      Left = 0
      Top = 0
      Width = 233
      Height = 519
      Align = alClient
      Indent = 19
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnDblClick = TreeView1DblClick
      ExplicitHeight = 508
    end
    object NxFlipPanel1: TNxFlipPanel
      Left = 0
      Top = 519
      Width = 233
      Height = 158
      Align = alBottom
      Caption = 'Description'
      CollapseGlyph.Data = {
        7A010000424D7A01000000000000360000002800000009000000090000000100
        2000000000004401000000000000000000000000000000000000604830406048
        30FF604830FF604830FF604830FF604830FF604830FF604830FF60483040C0A8
        90FFFFF0E0FFE0D0C0FFE0C8B0FFE0C0B0FFD0B8A0FFD0B8A0FFD0B8A0FF6048
        30FFC0A890FFFFF8F0FFFFF0E0FFF0E0E0FFF0D8D0FFF0D8C0FFF0D0C0FFD0B8
        A0FF604830FFC0A890FFFFF8FFFFFFF8F0FFFFF0E0FFF0E0E0FFF0D8D0FFF0D0
        C0FFD0B8A0FF604830FFC0A8A0FFFFFFFFFF604830FF604830FF604830FF6048
        30FF604830FFE0C0B0FF604830FFC0A8A0FFFFFFFFFFFFFFFFFFFFF8FFFFFFF0
        F0FFFFF0E0FFF0E8E0FFE0C0B0FF604830FFC0B0A0FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF8FFFFFFF0F0FFFFF0E0FFE0D0C0FF604830FFC0B0A0FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFF8FFFFFFF0F0FFF0F0E0FF604830FFC0B0A040C0B0
        A0FFC0B0A0FFC0A8A0FFC0A8A0FFC0A8A0FFC0A890FFC0A090FF60483040}
      ExpandGlyph.Data = {
        7A010000424D7A01000000000000360000002800000009000000090000000100
        2000000000004401000000000000000000000000000000000000604830406048
        30FF604830FF604830FF604830FF604830FF604830FF604830FF60483040C0A8
        90FFFFF0E0FFE0D0C0FFE0C8B0FFE0C0B0FFD0B8A0FFD0B8A0FFD0B8A0FF6048
        30FFC0A890FFFFF8F0FFFFF0E0FFF0E0E0FF604830FFF0D8C0FFF0D0C0FFD0B8
        A0FF604830FFC0A890FFFFF8FFFFFFF8F0FFFFF0E0FF604830FFF0D8D0FFF0D0
        C0FFD0B8A0FF604830FFC0A8A0FFFFFFFFFF604830FF604830FF604830FF6048
        30FF604830FFE0C0B0FF604830FFC0A8A0FFFFFFFFFFFFFFFFFFFFF8FFFF6048
        30FFFFF0E0FFF0E8E0FFE0C0B0FF604830FFC0B0A0FFFFFFFFFFFFFFFFFFFFFF
        FFFF604830FFFFF0F0FFFFF0E0FFE0D0C0FF604830FFC0B0A0FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFF8FFFFFFF0F0FFF0F0E0FF604830FFC0B0A040C0B0
        A0FFC0B0A0FFC0A8A0FFC0A8A0FFC0A8A0FFC0A890FFC0A090FF60483040}
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'Tahoma'
      HeaderFont.Style = []
      ExplicitTop = 508
      FullHeight = 0
      object NextInspector1: TNextInspector
        Left = 0
        Top = 18
        Width = 233
        Height = 140
        Align = alClient
        SplitterPosition = 115
        TabOrder = 0
        object NxTextItem1: TNxTextItem
          Caption = 'User Data'
          ReadOnly = True
          ParentIndex = -1
          object NxTextItem3: TNxTextItem
            Caption = 'Name'
            SuffixStyle = ssReadOnly
            ParentIndex = 0
          end
          object NxTextItem4: TNxTextItem
            Caption = 'Address'
            ParentIndex = 0
          end
        end
        object NxTextItem2: TNxTextItem
          Caption = 'Summary'
          ReadOnly = True
          ParentIndex = -1
          object NxTextItem5: TNxTextItem
            Caption = 'Status'
            ParentIndex = 3
          end
          object NxTextItem6: TNxTextItem
            Caption = 'Number of Objects'
            ParentIndex = 3
          end
          object NxTextItem7: TNxTextItem
            Caption = 'ON'
            ParentIndex = 3
          end
          object NxTextItem8: TNxTextItem
            Caption = 'OFF'
            ParentIndex = 3
          end
        end
      end
    end
  end
  object NxPanelRight: TNxPanel
    Left = 234
    Top = 25
    Width = 539
    Height = 677
    AdaptiveColors = False
    Align = alClient
    Caption = 'NxPanelRight'
    Color = clWhite
    UseDockManager = False
    PanelBorders = []
    ParentColor = False
    TabOrder = 2
    ExplicitHeight = 666
    object NxSplitter2: TNxSplitter
      Left = 0
      Top = 177
      Width = 539
      Height = 1
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 540
    end
    object NxPanelRightTop: TNxPanel
      Left = 0
      Top = 0
      Width = 539
      Height = 177
      AdaptiveColors = False
      Align = alTop
      Caption = 'NxPanelRightTop'
      UseDockManager = False
      TabOrder = 0
      object NextGridObject: TNextGrid
        Left = 0
        Top = 0
        Width = 539
        Height = 177
        Align = alClient
        HeaderStyle = hsVista
        Options = [goGrid, goHeader, goSelectFullRow]
        PopupMenu = PopupMenu1
        TabOrder = 0
        TabStop = True
        OnAfterEdit = NextGridObjectAfterEdit
        OnDblClick = NextGridObjectDblClick
        object NxTextColumn1: TNxTextColumn
          Alignment = taCenter
          DefaultWidth = 57
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Header.Caption = 'Object Id'
          Header.Alignment = taCenter
          ParentFont = False
          Position = 0
          SortType = stAlphabetic
          Width = 57
        end
        object NxTextColumn2: TNxTextColumn
          DefaultWidth = 167
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Header.Caption = 'Object Name'
          Header.Alignment = taCenter
          ParentFont = False
          Position = 1
          SortType = stAlphabetic
          Width = 167
        end
        object NxTextColumn3: TNxTextColumn
          Alignment = taCenter
          DefaultWidth = 67
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Header.Caption = 'Status'
          Header.Alignment = taCenter
          Options = [coCanClick, coCanInput, coCanSort, coEditing, coPublicUsing, coShowTextFitHint]
          ParentFont = False
          Position = 2
          SortType = stAlphabetic
          Width = 67
        end
        object NxTextColumn9: TNxTextColumn
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Footer.Alignment = taCenter
          Header.Caption = 'Power'
          Header.Alignment = taCenter
          ParentFont = False
          Position = 3
          SortType = stAlphabetic
        end
        object NxTextColumn11: TNxTextColumn
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Header.Caption = 'IP'
          Header.Alignment = taCenter
          ParentFont = False
          Position = 4
          SortType = stAlphabetic
        end
        object NxTextColumn4: TNxTextColumn
          DefaultWidth = 86
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Header.Caption = 'Description'
          Header.Alignment = taCenter
          Options = [coAutoSize, coCanClick, coCanInput, coCanSort, coPublicUsing, coShowTextFitHint]
          ParentFont = False
          Position = 5
          SortType = stAlphabetic
          Width = 86
        end
      end
    end
    object NxHeaderPanel1: TNxHeaderPanel
      Left = 0
      Top = 178
      Width = 539
      Height = 499
      Align = alClient
      Caption = '[Object ID] Object Name <ON/OFF>'
      HeaderFont.Charset = DEFAULT_CHARSET
      HeaderFont.Color = clWindowText
      HeaderFont.Height = -11
      HeaderFont.Name = 'Tahoma'
      HeaderFont.Style = []
      ParentHeaderFont = False
      TabOrder = 1
      ExplicitHeight = 488
      FullWidth = 539
      object NxSplitter3: TNxSplitter
        Left = 305
        Top = 27
        Width = 1
        Height = 470
        ExplicitLeft = 241
        ExplicitHeight = 239
      end
      object NextGridLog: TNextGrid
        Left = 0
        Top = 27
        Width = 305
        Height = 470
        Align = alLeft
        HeaderStyle = hsVista
        Options = [goGrid, goHeader, goSelectFullRow]
        PopupMenu = PopupMenu1
        TabOrder = 0
        TabStop = True
        ExplicitHeight = 459
        object NxTextColumn5: TNxIncrementColumn
          DefaultWidth = 37
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Header.Caption = 'No'
          Header.Alignment = taCenter
          Options = [coCanClick, coCanInput, coCanSort, coPublicUsing, coShowTextFitHint]
          ParentFont = False
          Position = 0
          SortType = stAlphabetic
          Width = 37
        end
        object NxTextColumn8: TNxTextColumn
          DefaultWidth = 57
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
          Width = 57
        end
        object NxTextColumn6: TNxTextColumn
          DefaultWidth = 104
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Header.Caption = 'Time'
          Header.Alignment = taCenter
          ParentFont = False
          Position = 2
          SortType = stAlphabetic
          Width = 104
        end
        object NxTextColumn7: TNxTextColumn
          DefaultWidth = 49
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Header.Caption = 'Status'
          Header.Alignment = taCenter
          ParentFont = False
          Position = 3
          SortType = stAlphabetic
          Width = 49
        end
        object NxTextColumn10: TNxTextColumn
          DefaultWidth = 56
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
          Width = 56
        end
      end
      object Chart1: TChart
        Left = 306
        Top = 27
        Width = 231
        Height = 470
        Legend.Visible = False
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        DepthAxis.Automatic = False
        DepthAxis.AutomaticMaximum = False
        DepthAxis.AutomaticMinimum = False
        DepthAxis.Maximum = 0.500000000000079400
        DepthAxis.Minimum = -0.499999999999913600
        DepthTopAxis.Automatic = False
        DepthTopAxis.AutomaticMaximum = False
        DepthTopAxis.AutomaticMinimum = False
        DepthTopAxis.Maximum = 0.500000000000079400
        DepthTopAxis.Minimum = -0.499999999999913600
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.Maximum = 100.000000000000000000
        RightAxis.Automatic = False
        RightAxis.AutomaticMaximum = False
        RightAxis.AutomaticMinimum = False
        View3D = False
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        ExplicitHeight = 459
        PrintMargins = (
          36
          15
          36
          15)
        object Series1: TFastLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Style = smsValue
          Marks.Visible = True
          SeriesColor = clBlue
          LinePen.Color = clBlue
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
        end
      end
    end
  end
  object NxPanelTop: TNxPanel
    Left = 0
    Top = 0
    Width = 773
    Height = 25
    AdaptiveColors = False
    Align = alTop
    Caption = 'NxPanelTop'
    Color = clWhite
    UseDockManager = False
    PanelBorders = []
    ParentColor = False
    TabOrder = 3
    object NxPanelTopLeft: TNxPanel
      Left = 0
      Top = 0
      Width = 121
      Height = 25
      AdaptiveColors = False
      Align = alLeft
      UseDockManager = False
      PanelBorders = []
      TabOrder = 0
      object btnNext: TNxButton
        AlignWithMargins = True
        Left = 61
        Top = 2
        Width = 58
        Height = 21
        Margins.Left = 1
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        Caption = 'Next'
        TabOrder = 0
      end
      object btnBack: TNxButton
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 57
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 1
        Margins.Bottom = 2
        Align = alLeft
        Caption = 'Back'
        TabOrder = 1
      end
    end
    object NxPanelTopRight: TNxPanel
      Left = 680
      Top = 0
      Width = 93
      Height = 25
      AdaptiveColors = False
      Align = alRight
      Caption = 'nxPanelTopRight'
      UseDockManager = False
      PanelBorders = []
      TabOrder = 1
      object btnSearch: TNxButton
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 88
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Bottom = 2
        Align = alClient
        Caption = 'Search'
        TabOrder = 0
        OnClick = btnSearchClick
      end
    end
    object NxPanel1: TNxPanel
      Left = 121
      Top = 0
      Width = 559
      Height = 25
      AdaptiveColors = False
      Align = alClient
      Caption = 'NxPanel1'
      UseDockManager = False
      PanelBorders = []
      TabOrder = 2
      object edSearch: TNxEdit
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 553
        Height = 19
        Align = alClient
        TabOrder = 0
        OnKeyPress = edSearchKeyPress
        ExplicitHeight = 21
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 432
    Top = 648
    object File1: TMenuItem
      Caption = 'File'
      ShortCut = 49222
      object Login1: TMenuItem
        Caption = 'Log in'
        OnClick = Login1Click
      end
      object Logout1: TMenuItem
        Caption = 'Log out'
        OnClick = Logout1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      ShortCut = 49221
      object Next1: TMenuItem
        Caption = 'Next'
      end
      object Back1: TMenuItem
        Caption = 'Back'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ut1: TMenuItem
        Caption = 'Cut'
      end
      object Copy1: TMenuItem
        Caption = 'Copy'
      end
      object Paste1: TMenuItem
        Caption = 'Paste'
      end
      object Delete1: TMenuItem
        Caption = 'Delete'
      end
    end
    object Search1: TMenuItem
      Caption = 'Search'
      ShortCut = 49235
      object Find1: TMenuItem
        Caption = 'Find'
      end
      object FindClass1: TMenuItem
        Caption = 'Find Class'
      end
      object FindObject1: TMenuItem
        Caption = 'Find Object'
      end
      object FindUser1: TMenuItem
        Caption = 'Find User'
      end
      object FindUsername1: TMenuItem
        Caption = 'Find Username'
      end
      object FindAddress1: TMenuItem
        Caption = 'Find Address'
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      ShortCut = 49238
      object ViewStatus1: TMenuItem
        Caption = 'View Status'
      end
      object ViewLog1: TMenuItem
        Caption = 'View Log'
      end
      object ViewLogChart1: TMenuItem
        Caption = 'View Log Chart'
      end
      object ViewPacketLog1: TMenuItem
        Caption = 'View Packet Log'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object All1: TMenuItem
        Caption = 'All'
        OnClick = All1Click
      end
    end
    object Setting1: TMenuItem
      Caption = 'Setting'
      ShortCut = 49236
      object Schedule1: TMenuItem
        Caption = 'Schedule'
      end
      object Rule1: TMenuItem
        Caption = 'Rule'
        OnClick = Rule1Click
      end
      object AddObject1: TMenuItem
        Caption = 'Add Object'
        OnClick = AddObject1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object User1: TMenuItem
        Caption = 'Add User'
        OnClick = User1Click
      end
      object EditUser1: TMenuItem
        Caption = 'Edit User'
      end
      object DeleteUser1: TMenuItem
        Caption = 'Delete User'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object ObjectSimulatorIPAddress1: TMenuItem
        Caption = 'Object Simulator IP Address'
        OnClick = ObjectSimulatorIPAddress1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object LimitUsage1: TMenuItem
        Caption = 'Usage Limit'
        OnClick = LimitUsage1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      ShortCut = 49224
      object Manual1: TMenuItem
        Caption = 'Manual'
      end
      object About1: TMenuItem
        Caption = 'About'
      end
    end
  end
  object IdTCPClient1: TIdTCPClient
    OnDisconnected = IdTCPClient1Disconnected
    OnConnected = IdTCPClient1Connected
    ConnectTimeout = 0
    Host = 'localhost'
    IPVersion = Id_IPv4
    Port = 16209
    ReadTimeout = 0
    Left = 385
    Top = 648
  end
  object PopupMenu1: TPopupMenu
    Left = 328
    Top = 648
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      OnClick = Refresh1Click
    end
  end
  object IdTCPServerUpdate: TIdTCPServer
    Active = True
    Bindings = <>
    DefaultPort = 13550
    OnExecute = IdTCPServerUpdateExecute
    Left = 240
    Top = 648
  end
end
