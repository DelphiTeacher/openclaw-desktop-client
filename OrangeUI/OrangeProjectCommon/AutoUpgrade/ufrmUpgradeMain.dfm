object frmUpgradeMain: TfrmUpgradeMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #26356#26032#35828#26126
  ClientHeight = 460
  ClientWidth = 485
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 20
  Padding.Top = 10
  Padding.Right = 20
  Padding.Bottom = 10
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 23
    Top = 63
    Width = 439
    Height = 341
    Align = alClient
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      #26368#26032#29256#26412#65306' v1.0.0'
      ''
      #26356#26032#20869#23481
      '-----------------------'
      '1'#12289#20462#27491'******'
      '2'#12289#20462#27491'******'
      '3'#12289#20462#27491'******')
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 20
    Top = 411
    Width = 445
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 5
    Padding.Bottom = 5
    TabOrder = 0
    object Button1: TButton
      Left = 348
      Top = 5
      Width = 97
      Height = 29
      Align = alRight
      Caption = #36339#36807
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button4: TButton
      Left = 259
      Top = 5
      Width = 89
      Height = 29
      Align = alRight
      Caption = #21319#32423
      TabOrder = 1
      OnClick = Button4Click
    end
  end
  object Panel2: TPanel
    Left = 20
    Top = 10
    Width = 445
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    Padding.Left = 5
    Padding.Bottom = 5
    ParentFont = False
    TabOrder = 2
    object labTitle: TLabel
      Left = 5
      Top = 0
      Width = 84
      Height = 44
      Align = alLeft
      Caption = #31243#24207#26356#26032
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5066061
      Font.Height = -21
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      Layout = tlBottom
      ExplicitHeight = 28
    end
    object Shape1: TShape
      Left = 5
      Top = 44
      Width = 440
      Height = 1
      Align = alBottom
      Pen.Color = clSilver
      ExplicitWidth = 443
    end
  end
  object ProgressBar1: TProgressBar
    Left = 20
    Top = 407
    Width = 445
    Height = 4
    Align = alBottom
    TabOrder = 3
  end
end
