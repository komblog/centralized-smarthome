object formListRule: TformListRule
  Left = 0
  Top = 0
  Caption = 'Daftar Rule'
  ClientHeight = 388
  ClientWidth = 546
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
  object gridListRule: TNextGrid
    Left = -1
    Top = 0
    Width = 546
    Height = 349
    Options = [goGrid, goHeader, goSelectFullRow]
    TabOrder = 0
    TabStop = True
    object NxIncrementColumn1: TNxTextColumn
      DefaultWidth = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'id'
      Header.Alignment = taCenter
      Options = [coCanClick, coCanInput, coCanSort, coPublicUsing]
      ParentFont = False
      Position = 0
      SortType = stAlphabetic
      Width = 30
    end
    object NxComboBoxColumn1: TNxTextColumn
      DefaultWidth = 77
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Obj_in'
      Header.Alignment = taCenter
      ParentFont = False
      Position = 1
      SortType = stAlphabetic
      Width = 77
    end
    object NxTextColumn3: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Obj_in_name'
      ParentFont = False
      Position = 2
      SortType = stAlphabetic
    end
    object NxTextColumn1: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Obj_in_status'
      Header.Alignment = taCenter
      ParentFont = False
      Position = 3
      SortType = stAlphabetic
    end
    object NxComboBoxColumn2: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Obj_out'
      Header.Alignment = taCenter
      ParentFont = False
      Position = 4
      SortType = stAlphabetic
    end
    object NxTextColumn4: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'obj_out_name'
      ParentFont = False
      Position = 5
      SortType = stAlphabetic
    end
    object NxTextColumn2: TNxTextColumn
      DefaultWidth = 115
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Obj_out_status'
      Header.Alignment = taCenter
      ParentFont = False
      Position = 6
      SortType = stAlphabetic
      Width = 115
    end
  end
  object tombolTambah: TButton
    Left = 170
    Top = 355
    Width = 75
    Height = 25
    Caption = 'Tambah'
    TabOrder = 1
    OnClick = tombolTambahClick
  end
  object tombolHapus: TButton
    Left = 8
    Top = 355
    Width = 75
    Height = 25
    Caption = 'Hapus'
    TabOrder = 2
    OnClick = tombolHapusClick
  end
  object tombolEdit: TButton
    Left = 89
    Top = 355
    Width = 75
    Height = 25
    Caption = 'Edit'
    TabOrder = 3
    OnClick = tombolEditClick
  end
  object tombolKirimRule: TButton
    Left = 251
    Top = 355
    Width = 75
    Height = 25
    Caption = 'Kirim Rule'
    TabOrder = 4
    OnClick = tombolKirimRuleClick
  end
  object btnPrntPIR: TButton
    Left = 332
    Top = 355
    Width = 83
    Height = 25
    Caption = 'Print Kode PIR'
    TabOrder = 5
    OnClick = btnPrntPIRClick
  end
  object btnPrintLampu: TBitBtn
    Left = 421
    Top = 355
    Width = 98
    Height = 25
    Caption = 'Print Kode Lampu'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 6
    OnClick = btnPrintLampuClick
  end
end
