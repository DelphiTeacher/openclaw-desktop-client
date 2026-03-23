object FrameGridSwitchPage: TFrameGridSwitchPage
  Left = 0
  Top = 0
  Width = 968
  Height = 39
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23536#57791#33931#38342#21620#31910
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 968
    Height = 39
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object lblSumCount: TSkinWinLabel
      Left = 390
      Top = 0
      Width = 85
      Height = 39
      ParentMouseEvent = True
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = True
      SelfOwnMaterial.IsTransparent = False
      SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.FontSize = 8
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -11
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
      SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
      SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaLeft
      SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaCenter
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
      HitTest = False
      MouseDownFocus = False
      Align = alRight
      ParentBackground = False
      TabOrder = 0
      Caption = 'Total 11258'
      Text = 'Total 11258'
      Properties.AutoSize = False
    end
    object lblGoTo: TSkinWinLabel
      Left = 870
      Top = 0
      Width = 45
      Height = 39
      ParentMouseEvent = True
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = True
      SelfOwnMaterial.IsTransparent = False
      SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.FontSize = 8
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -11
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
      SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
      SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaLeft
      SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaCenter
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
      HitTest = False
      MouseDownFocus = False
      Align = alRight
      ParentBackground = False
      TabOrder = 1
      Caption = 'Go to'
      Text = 'Go to'
      Properties.AutoSize = False
    end
    object pnlGoTo: TSkinPanel
      Left = 915
      Top = 0
      Width = 53
      Height = 39
      ParentMouseEvent = True
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = True
      SelfOwnMaterial.IsTransparent = False
      SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.FontSize = 8
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -11
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
      SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
      SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaLeft
      SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaTop
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
      HitTest = True
      MouseDownFocus = False
      Align = alRight
      ParentBackground = False
      TabOrder = 2
      Caption = ''
      Text = ''
      object edtPageIndex: TEdit
        Left = 8
        Top = 7
        Width = 40
        Height = 26
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #23536#57791#33931#38342#21620#31910
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '1'
        OnKeyUp = edtPageIndexKeyUp
      end
    end
    object pnlPageSize: TSkinPanel
      Left = 475
      Top = 0
      Width = 93
      Height = 39
      ParentMouseEvent = True
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = True
      SelfOwnMaterial.IsTransparent = False
      SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.FontSize = 8
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -11
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
      SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
      SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaLeft
      SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaTop
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
      HitTest = True
      MouseDownFocus = False
      Align = alRight
      ParentBackground = False
      TabOrder = 3
      Caption = ''
      Text = ''
      object cmbPageSize: TComboBox
        Left = 3
        Top = 6
        Width = 81
        Height = 26
        ItemIndex = 0
        TabOrder = 0
        Text = '20'
        OnChange = cmbPageSizePropertiesChange
        Items.Strings = (
          '20'
          '100'
          '200'
          '500'
          '1000')
      end
    end
    object pnlSwitchPageIndex: TSkinPanel
      Left = 568
      Top = 0
      Width = 302
      Height = 39
      ParentMouseEvent = True
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = True
      SelfOwnMaterial.IsTransparent = False
      SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.FontSize = 8
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -11
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
      SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
      SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaLeft
      SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaTop
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
      HitTest = True
      MouseDownFocus = False
      Align = alRight
      ParentBackground = False
      TabOrder = 4
      Caption = ''
      Text = ''
      object btnNextPage: TSkinWinButton
        Left = 262
        Top = 0
        Width = 40
        Height = 39
        Margins.Left = 0
        Margins.Right = 0
        ParentMouseEvent = True
        DirectUIVisible = False
        ComponentTypeUseKind = ctukDefault
        MaterialUseKind = mukRef
        KeepSelfOwnMaterial = True
        MaterialName = 'btnFirstPage_Material'
        SelfOwnMaterial.BackColor.Color = clWhite
        SelfOwnMaterial.BackColor.IsFill = True
        SelfOwnMaterial.IsTransparent = False
        SelfOwnMaterial.ArrowPicture.IsClipRound = False
        SelfOwnMaterial.IsAutoCenterIconAndCaption = False
        SelfOwnMaterial.DrawDetailParam.FontName = 'Tahoma'
        SelfOwnMaterial.DrawDetailParam.FontSize = 8
        SelfOwnMaterial.DrawDetailParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawDetailParam.DrawFont.Height = -11
        SelfOwnMaterial.DrawDetailParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawDetailParam.DrawFont.Style = []
        SelfOwnMaterial.DrawDetailParam.FontTrimming = fttNone
        SelfOwnMaterial.DrawDetailParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawDetailParam.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawDetailParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawDetailParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawDetailParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawDetailParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawDetailParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawDetail1Param.FontName = 'Tahoma'
        SelfOwnMaterial.DrawDetail1Param.FontSize = 8
        SelfOwnMaterial.DrawDetail1Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawDetail1Param.DrawFont.Height = -11
        SelfOwnMaterial.DrawDetail1Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawDetail1Param.DrawFont.Style = []
        SelfOwnMaterial.DrawDetail1Param.FontTrimming = fttNone
        SelfOwnMaterial.DrawDetail1Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawDetail1Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawDetail1Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawDetail1Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawDetail1Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawDetail1Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawDetail1Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawHelpTextParam.FontName = 'Tahoma'
        SelfOwnMaterial.DrawHelpTextParam.FontSize = 8
        SelfOwnMaterial.DrawHelpTextParam.FontColor = clGray
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.Color = clGray
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.Height = -11
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.Style = []
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.FontColor.Color = clGray
        SelfOwnMaterial.DrawHelpTextParam.FontTrimming = fttNone
        SelfOwnMaterial.DrawHelpTextParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawHelpTextParam.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawHelpTextParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawHelpTextParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawHelpTextParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawHelpTextParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawHelpTextParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
        SelfOwnMaterial.DrawCaptionParam.FontSize = 8
        SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -11
        SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
        SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
        SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.NormalPicture.IsClipRound = False
        SelfOwnMaterial.HoverPicture.IsClipRound = False
        SelfOwnMaterial.DownPicture.IsClipRound = False
        SelfOwnMaterial.DisabledPicture.IsClipRound = False
        SelfOwnMaterial.FocusedPicture.IsClipRound = False
        SelfOwnMaterial.PushedPicture.IsClipRound = False
        RefMaterial = btnFirstPage_Material
        HitTest = False
        MouseDownFocus = False
        Align = alRight
        ParentBackground = False
        TabOrder = 0
        OnClick = btnNextPageClick
        Caption = ''
        Text = ''
        Properties.AutoSize = False
        Properties.IsAutoPush = False
        Properties.IsPushed = False
        Properties.Icon.IsClipRound = False
        Properties.Icon.FileName = 'next_page.svg'
        Properties.PushedIcon.IsClipRound = False
        Properties.ButtonIndex = -1
        Properties.PushedGroupIndex = 0
      end
      object btnPriorPage: TSkinWinButton
        Left = 34
        Top = 0
        Width = 40
        Height = 39
        Margins.Left = 0
        Margins.Right = 0
        ParentMouseEvent = True
        DirectUIVisible = False
        ComponentTypeUseKind = ctukDefault
        MaterialUseKind = mukRef
        KeepSelfOwnMaterial = True
        MaterialName = 'btnFirstPage_Material'
        SelfOwnMaterial.BackColor.Color = clWhite
        SelfOwnMaterial.BackColor.IsFill = True
        SelfOwnMaterial.IsTransparent = False
        SelfOwnMaterial.ArrowPicture.IsClipRound = False
        SelfOwnMaterial.IsAutoCenterIconAndCaption = False
        SelfOwnMaterial.DrawDetailParam.FontName = 'Tahoma'
        SelfOwnMaterial.DrawDetailParam.FontSize = 8
        SelfOwnMaterial.DrawDetailParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawDetailParam.DrawFont.Height = -11
        SelfOwnMaterial.DrawDetailParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawDetailParam.DrawFont.Style = []
        SelfOwnMaterial.DrawDetailParam.FontTrimming = fttNone
        SelfOwnMaterial.DrawDetailParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawDetailParam.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawDetailParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawDetailParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawDetailParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawDetailParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawDetailParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawDetail1Param.FontName = 'Tahoma'
        SelfOwnMaterial.DrawDetail1Param.FontSize = 8
        SelfOwnMaterial.DrawDetail1Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawDetail1Param.DrawFont.Height = -11
        SelfOwnMaterial.DrawDetail1Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawDetail1Param.DrawFont.Style = []
        SelfOwnMaterial.DrawDetail1Param.FontTrimming = fttNone
        SelfOwnMaterial.DrawDetail1Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawDetail1Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawDetail1Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawDetail1Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawDetail1Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawDetail1Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawDetail1Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawHelpTextParam.FontName = 'Tahoma'
        SelfOwnMaterial.DrawHelpTextParam.FontSize = 8
        SelfOwnMaterial.DrawHelpTextParam.FontColor = clGray
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.Color = clGray
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.Height = -11
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.Style = []
        SelfOwnMaterial.DrawHelpTextParam.DrawFont.FontColor.Color = clGray
        SelfOwnMaterial.DrawHelpTextParam.FontTrimming = fttNone
        SelfOwnMaterial.DrawHelpTextParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawHelpTextParam.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawHelpTextParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawHelpTextParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawHelpTextParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawHelpTextParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawHelpTextParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
        SelfOwnMaterial.DrawCaptionParam.FontSize = 8
        SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -11
        SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
        SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
        SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.NormalPicture.IsClipRound = False
        SelfOwnMaterial.HoverPicture.IsClipRound = False
        SelfOwnMaterial.DownPicture.IsClipRound = False
        SelfOwnMaterial.DisabledPicture.IsClipRound = False
        SelfOwnMaterial.FocusedPicture.IsClipRound = False
        SelfOwnMaterial.PushedPicture.IsClipRound = False
        RefMaterial = btnFirstPage_Material
        HitTest = False
        MouseDownFocus = False
        Align = alRight
        ParentBackground = False
        TabOrder = 1
        OnClick = btnPriorPageClick
        Caption = ''
        Text = ''
        Properties.AutoSize = False
        Properties.IsAutoPush = False
        Properties.IsPushed = False
        Properties.Icon.IsClipRound = False
        Properties.Icon.FileName = 'prior_page.svg'
        Properties.PushedIcon.IsClipRound = False
        Properties.ButtonIndex = -1
        Properties.PushedGroupIndex = 0
      end
      object lbPageIndexs: TSkinListBox
        Left = 74
        Top = 0
        Width = 188
        Height = 39
        ParentMouseEvent = True
        DirectUIVisible = False
        ComponentTypeUseKind = ctukDefault
        MaterialUseKind = mukSelfOwn
        KeepSelfOwnMaterial = True
        SelfOwnMaterial.BackColor.Color = clWhite
        SelfOwnMaterial.BackColor.IsFill = True
        SelfOwnMaterial.IsTransparent = False
        SelfOwnMaterial.PullDownRefreshPanelMaterial.BackColor.Color = clWhite
        SelfOwnMaterial.PullDownRefreshPanelMaterial.BackColor.IsFill = True
        SelfOwnMaterial.PullDownRefreshPanelMaterial.IsTransparent = False
        SelfOwnMaterial.PullDownRefreshPanelMaterial.IndicatorColor = clBlack
        SelfOwnMaterial.PullDownRefreshPanelMaterial.LoadingPicture.IsClipRound = False
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.FontName = 'Tahoma'
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.FontSize = 8
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.DrawFont.Height = -11
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.DrawFont.Style = []
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.FontTrimming = fttNone
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.FontVertAlign = fvaTop
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DrawLoadingCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.PullDownRefreshPanelMaterial.EnableAutoCenterPosition = False
        SelfOwnMaterial.PullDownRefreshPanelMaterial.EnableLoadingImageBiggerEffect = False
        SelfOwnMaterial.PullDownRefreshPanelMaterial.EnableLoadingImageRotateEffect = True
        SelfOwnMaterial.PullDownRefreshPanelMaterial.LoadingCaption = #27491#22312#21047#26032'...'
        SelfOwnMaterial.PullDownRefreshPanelMaterial.DecidedLoadCaption = #26494#24320#21047#26032
        SelfOwnMaterial.PullDownRefreshPanelMaterial.UnDecidedLoadCaption = #19979#25289#21047#26032
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.BackColor.Color = clWhite
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.BackColor.IsFill = True
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.IsTransparent = False
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.IndicatorColor = clBlack
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.LoadingPicture.IsClipRound = False
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.FontName = 'Tahoma'
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.FontSize = 8
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.DrawFont.Height = -11
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.DrawFont.Style = []
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.FontTrimming = fttNone
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.FontVertAlign = fvaTop
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DrawLoadingCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.EnableAutoCenterPosition = False
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.EnableLoadingImageBiggerEffect = False
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.EnableLoadingImageRotateEffect = True
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.LoadingCaption = #27491#22312#21152#36733'...'
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.DecidedLoadCaption = #26494#24320#21152#36733#26356#22810
        SelfOwnMaterial.PullUpLoadMorePanelMaterial.UnDecidedLoadCaption = #19978#25289#21152#36733#26356#22810
        SelfOwnMaterial.DrawEmptyContentCaptionParam.FontName = 'Tahoma'
        SelfOwnMaterial.DrawEmptyContentCaptionParam.FontSize = 8
        SelfOwnMaterial.DrawEmptyContentCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawEmptyContentCaptionParam.DrawFont.Height = -11
        SelfOwnMaterial.DrawEmptyContentCaptionParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawEmptyContentCaptionParam.DrawFont.Style = []
        SelfOwnMaterial.DrawEmptyContentCaptionParam.FontTrimming = fttNone
        SelfOwnMaterial.DrawEmptyContentCaptionParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawEmptyContentCaptionParam.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawEmptyContentCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawEmptyContentCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawEmptyContentCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawEmptyContentCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawEmptyContentCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.FontName = 'Tahoma'
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.FontSize = 8
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.DrawFont.Height = -11
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.DrawFont.Style = []
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.FontTrimming = fttNone
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawEmptyContentDescriptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawSpaceParam.Color = clWhite
        SelfOwnMaterial.DrawSpaceParam.IsFill = False
        SelfOwnMaterial.IsSimpleDrawGroupRoundRect = False
        SelfOwnMaterial.IsSimpleDrawGroupBeginDevide = True
        SelfOwnMaterial.IsSimpleDrawGroupEndDevide = True
        SelfOwnMaterial.DrawGroupBeginDevideParam.Color = 15592941
        SelfOwnMaterial.DrawGroupBeginDevideParam.IsFill = False
        SelfOwnMaterial.DrawGroupBackColorParam.Color = 15592941
        SelfOwnMaterial.DrawGroupBackColorParam.IsFill = False
        SelfOwnMaterial.GroupBackPicture.IsClipRound = False
        SelfOwnMaterial.DrawGroupEndDevideParam.Color = 15592941
        SelfOwnMaterial.DrawGroupEndDevideParam.IsFill = False
        SelfOwnMaterial.ItemBackNormalPicture.IsClipRound = False
        SelfOwnMaterial.ItemBackHoverPicture.IsClipRound = False
        SelfOwnMaterial.ItemBackDownPicture.IsClipRound = False
        SelfOwnMaterial.ItemBackPushedPicture.IsClipRound = False
        SelfOwnMaterial.DrawItemBackColorParam.Color = 15592941
        SelfOwnMaterial.DrawItemBackColorParam.IsFill = True
        SelfOwnMaterial.DrawItemBackColorParam.FillColor.Color = 15592941
        SelfOwnMaterial.DrawItemBackColorParam.IsRound = True
        SelfOwnMaterial.DrawItemBackColorParam.RoundWidth = 2
        SelfOwnMaterial.DrawItemBackColorParam.RoundHeight = 2
        SelfOwnMaterial.DrawItemBackColorParam.DrawRectSetting.Left = 5.000000000000000000
        SelfOwnMaterial.DrawItemBackColorParam.DrawRectSetting.Top = 5.000000000000000000
        SelfOwnMaterial.DrawItemBackColorParam.DrawRectSetting.Right = 5.000000000000000000
        SelfOwnMaterial.DrawItemBackColorParam.DrawRectSetting.Bottom = 5.000000000000000000
        SelfOwnMaterial.DrawItemBackColorParam.DrawRectSetting.Enabled = True
        SelfOwnMaterial.DrawItemBackColorParam.DrawEffectSetting.PushedEffect.FillColor.UseThemeColor = ctThemeColor
        SelfOwnMaterial.DrawItemBackColorParam.DrawEffectSetting.PushedEffect.EffectTypes = [drpetFillColorChange]
        SelfOwnMaterial.ItemAccessoryPicture.IsClipRound = False
        SelfOwnMaterial.IsDrawCenterItemRect = False
        SelfOwnMaterial.DrawCenterItemRectParam.Color = 15592941
        SelfOwnMaterial.DrawCenterItemRectParam.IsFill = False
        SelfOwnMaterial.IsSimpleDrawItemDevide = True
        SelfOwnMaterial.DrawItemDevideParam.Color = 15592941
        SelfOwnMaterial.DrawItemDevideParam.IsFill = False
        SelfOwnMaterial.DrawItemCaptionParam.FontName = 'Tahoma'
        SelfOwnMaterial.DrawItemCaptionParam.FontSize = 8
        SelfOwnMaterial.DrawItemCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawItemCaptionParam.DrawFont.Height = -11
        SelfOwnMaterial.DrawItemCaptionParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawItemCaptionParam.DrawFont.Style = []
        SelfOwnMaterial.DrawItemCaptionParam.FontTrimming = fttNone
        SelfOwnMaterial.DrawItemCaptionParam.FontHorzAlign = fhaCenter
        SelfOwnMaterial.DrawItemCaptionParam.FontVertAlign = fvaCenter
        SelfOwnMaterial.DrawItemCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawItemCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawItemCaptionParam.DrawEffectSetting.PushedEffect.FontColor.Color = clWhite
        SelfOwnMaterial.DrawItemCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemCaptionParam.DrawEffectSetting.PushedEffect.EffectTypes = [dtpetFontColorChange]
        SelfOwnMaterial.DrawItemCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawItemCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetailParam.FontName = 'Tahoma'
        SelfOwnMaterial.DrawItemDetailParam.FontSize = 8
        SelfOwnMaterial.DrawItemDetailParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawItemDetailParam.DrawFont.Height = -11
        SelfOwnMaterial.DrawItemDetailParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawItemDetailParam.DrawFont.Style = []
        SelfOwnMaterial.DrawItemDetailParam.FontTrimming = fttNone
        SelfOwnMaterial.DrawItemDetailParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawItemDetailParam.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawItemDetailParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetailParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetailParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetailParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetailParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail1Param.FontName = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail1Param.FontSize = 8
        SelfOwnMaterial.DrawItemDetail1Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawItemDetail1Param.DrawFont.Height = -11
        SelfOwnMaterial.DrawItemDetail1Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail1Param.DrawFont.Style = []
        SelfOwnMaterial.DrawItemDetail1Param.FontTrimming = fttNone
        SelfOwnMaterial.DrawItemDetail1Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawItemDetail1Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawItemDetail1Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail1Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail1Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail1Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail1Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail2Param.FontName = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail2Param.FontSize = 8
        SelfOwnMaterial.DrawItemDetail2Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawItemDetail2Param.DrawFont.Height = -11
        SelfOwnMaterial.DrawItemDetail2Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail2Param.DrawFont.Style = []
        SelfOwnMaterial.DrawItemDetail2Param.FontTrimming = fttNone
        SelfOwnMaterial.DrawItemDetail2Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawItemDetail2Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawItemDetail2Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail2Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail2Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail2Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail2Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail3Param.FontName = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail3Param.FontSize = 8
        SelfOwnMaterial.DrawItemDetail3Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawItemDetail3Param.DrawFont.Height = -11
        SelfOwnMaterial.DrawItemDetail3Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail3Param.DrawFont.Style = []
        SelfOwnMaterial.DrawItemDetail3Param.FontTrimming = fttNone
        SelfOwnMaterial.DrawItemDetail3Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawItemDetail3Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawItemDetail3Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail3Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail3Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail3Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail3Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail4Param.FontName = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail4Param.FontSize = 8
        SelfOwnMaterial.DrawItemDetail4Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawItemDetail4Param.DrawFont.Height = -11
        SelfOwnMaterial.DrawItemDetail4Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail4Param.DrawFont.Style = []
        SelfOwnMaterial.DrawItemDetail4Param.FontTrimming = fttNone
        SelfOwnMaterial.DrawItemDetail4Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawItemDetail4Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawItemDetail4Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail4Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail4Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail4Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail4Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail5Param.FontName = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail5Param.FontSize = 8
        SelfOwnMaterial.DrawItemDetail5Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawItemDetail5Param.DrawFont.Height = -11
        SelfOwnMaterial.DrawItemDetail5Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail5Param.DrawFont.Style = []
        SelfOwnMaterial.DrawItemDetail5Param.FontTrimming = fttNone
        SelfOwnMaterial.DrawItemDetail5Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawItemDetail5Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawItemDetail5Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail5Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail5Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail5Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail5Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail6Param.FontName = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail6Param.FontSize = 8
        SelfOwnMaterial.DrawItemDetail6Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DrawItemDetail6Param.DrawFont.Height = -11
        SelfOwnMaterial.DrawItemDetail6Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DrawItemDetail6Param.DrawFont.Style = []
        SelfOwnMaterial.DrawItemDetail6Param.FontTrimming = fttNone
        SelfOwnMaterial.DrawItemDetail6Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DrawItemDetail6Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DrawItemDetail6Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail6Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail6Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail6Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DrawItemDetail6Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.ItemAccessoryPicture.IsClipRound = False
        SelfOwnMaterial.DefaultTypeItemMaterial.ItemBackNormalPicture.IsClipRound = False
        SelfOwnMaterial.DefaultTypeItemMaterial.ItemBackHoverPicture.IsClipRound = False
        SelfOwnMaterial.DefaultTypeItemMaterial.ItemBackDownPicture.IsClipRound = False
        SelfOwnMaterial.DefaultTypeItemMaterial.ItemBackPushedPicture.IsClipRound = False
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.Color = 15592941
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.IsFill = True
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.FillColor.Color = 15592941
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.IsRound = True
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.RoundWidth = 2
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.RoundHeight = 2
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.DrawRectSetting.Left = 5.000000000000000000
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.DrawRectSetting.Top = 5.000000000000000000
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.DrawRectSetting.Right = 5.000000000000000000
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.DrawRectSetting.Bottom = 5.000000000000000000
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.DrawRectSetting.Enabled = True
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.DrawEffectSetting.PushedEffect.FillColor.UseThemeColor = ctThemeColor
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemBackColorParam.DrawEffectSetting.PushedEffect.EffectTypes = [drpetFillColorChange]
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.FontName = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.FontSize = 8
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawFont.Height = -11
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawFont.Style = []
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.FontTrimming = fttNone
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.FontHorzAlign = fhaCenter
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.FontVertAlign = fvaCenter
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.PushedEffect.FontColor.Color = clWhite
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.PushedEffect.EffectTypes = [dtpetFontColorChange]
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.FontName = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.FontSize = 8
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.DrawFont.Height = -11
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.DrawFont.Style = []
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.FontTrimming = fttNone
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.FontVertAlign = fvaTop
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetailParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.FontName = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.FontSize = 8
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.DrawFont.Height = -11
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.DrawFont.Style = []
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.FontTrimming = fttNone
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail1Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.FontName = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.FontSize = 8
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.DrawFont.Height = -11
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.DrawFont.Style = []
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.FontTrimming = fttNone
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail2Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.FontName = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.FontSize = 8
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.DrawFont.Height = -11
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.DrawFont.Style = []
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.FontTrimming = fttNone
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail3Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.FontName = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.FontSize = 8
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.DrawFont.Height = -11
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.DrawFont.Style = []
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.FontTrimming = fttNone
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail4Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.FontName = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.FontSize = 8
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.DrawFont.Height = -11
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.DrawFont.Style = []
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.FontTrimming = fttNone
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail5Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.FontName = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.FontSize = 8
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.DrawFont.Height = -11
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.DrawFont.Style = []
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.FontTrimming = fttNone
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.FontVertAlign = fvaTop
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.DefaultTypeItemMaterial.DrawItemDetail6Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.ItemAccessoryPicture.IsClipRound = False
        SelfOwnMaterial.Item1TypeItemMaterial.ItemBackNormalPicture.IsClipRound = False
        SelfOwnMaterial.Item1TypeItemMaterial.ItemBackHoverPicture.IsClipRound = False
        SelfOwnMaterial.Item1TypeItemMaterial.ItemBackDownPicture.IsClipRound = False
        SelfOwnMaterial.Item1TypeItemMaterial.ItemBackPushedPicture.IsClipRound = False
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemBackColorParam.Color = clWhite
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemBackColorParam.IsFill = False
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.FontName = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.FontSize = 8
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.DrawFont.Height = -11
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.DrawFont.Style = []
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.FontTrimming = fttNone
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.FontVertAlign = fvaTop
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.FontName = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.FontSize = 8
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.DrawFont.Height = -11
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.DrawFont.Style = []
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.FontTrimming = fttNone
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.FontHorzAlign = fhaLeft
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.FontVertAlign = fvaTop
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetailParam.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.FontName = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.FontSize = 8
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.DrawFont.Height = -11
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.DrawFont.Style = []
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.FontTrimming = fttNone
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.FontVertAlign = fvaTop
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail1Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.FontName = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.FontSize = 8
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.DrawFont.Height = -11
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.DrawFont.Style = []
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.FontTrimming = fttNone
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.FontVertAlign = fvaTop
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail2Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.FontName = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.FontSize = 8
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.DrawFont.Height = -11
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.DrawFont.Style = []
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.FontTrimming = fttNone
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.FontVertAlign = fvaTop
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail3Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.FontName = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.FontSize = 8
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.DrawFont.Height = -11
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.DrawFont.Style = []
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.FontTrimming = fttNone
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.FontVertAlign = fvaTop
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail4Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.FontName = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.FontSize = 8
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.DrawFont.Height = -11
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.DrawFont.Style = []
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.FontTrimming = fttNone
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.FontVertAlign = fvaTop
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail5Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.FontName = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.FontSize = 8
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.DrawFont.Charset = DEFAULT_CHARSET
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.DrawFont.Height = -11
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.DrawFont.Name = 'Tahoma'
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.DrawFont.Style = []
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.FontTrimming = fttNone
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.FontHorzAlign = fhaLeft
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.FontVertAlign = fvaTop
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.DrawEffectSetting.PushedEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.DrawEffectSetting.DisabledEffect.FontSize = 12
        SelfOwnMaterial.Item1TypeItemMaterial.DrawItemDetail6Param.DrawEffectSetting.FocusedEffect.FontSize = 12
        SelfOwnMaterial.IsAutoAdjustItemDesignerPanelSize = True
        HitTest = True
        MouseDownFocus = False
        Align = alRight
        ParentBackground = False
        TabOrder = 2
        VertScrollBar.Left = 176
        VertScrollBar.Top = 0
        VertScrollBar.Width = 12
        VertScrollBar.Height = 39
        VertScrollBar.ParentMouseEvent = True
        VertScrollBar.DirectUIVisible = False
        VertScrollBar.ComponentTypeUseKind = ctukDefault
        VertScrollBar.MaterialUseKind = mukSelfOwn
        VertScrollBar.KeepSelfOwnMaterial = True
        VertScrollBar.SelfOwnMaterial.BackColor.Color = clWhite
        VertScrollBar.SelfOwnMaterial.BackColor.IsFill = True
        VertScrollBar.SelfOwnMaterial.IsTransparent = False
        VertScrollBar.SelfOwnMaterial.ThumbBtnMinSize = 40
        VertScrollBar.SelfOwnMaterial.ThumbBtnDrawSize = 4
        VertScrollBar.SelfOwnMaterial.IsDefaultDrawThumbBtn = True
        VertScrollBar.SelfOwnMaterial.ThumbBtnRectParam.Color = 11513775
        VertScrollBar.SelfOwnMaterial.ThumbBtnRectParam.IsFill = False
        VertScrollBar.SelfOwnMaterial.ThumbBtnRectParam.FillColor.Color = 11513775
        VertScrollBar.HitTest = True
        VertScrollBar.MouseDownFocus = False
        VertScrollBar.ParentBackground = False
        VertScrollBar.Properties.AutoSize = False
        VertScrollBar.Properties.Kind = sbVertical
        VertScrollBar.Properties.SmallChange = 1
        VertScrollBar.Properties.LargeChange = 10
        VertScrollBar.Properties.CanOverRangeTypes = [cortMin, cortMax]
        HorzScrollBar.Left = 0
        HorzScrollBar.Top = 27
        HorzScrollBar.Width = 188
        HorzScrollBar.Height = 12
        HorzScrollBar.ParentMouseEvent = True
        HorzScrollBar.DirectUIVisible = False
        HorzScrollBar.ComponentTypeUseKind = ctukDefault
        HorzScrollBar.MaterialUseKind = mukSelfOwn
        HorzScrollBar.KeepSelfOwnMaterial = True
        HorzScrollBar.SelfOwnMaterial.BackColor.Color = clWhite
        HorzScrollBar.SelfOwnMaterial.BackColor.IsFill = True
        HorzScrollBar.SelfOwnMaterial.IsTransparent = False
        HorzScrollBar.SelfOwnMaterial.ThumbBtnMinSize = 40
        HorzScrollBar.SelfOwnMaterial.ThumbBtnDrawSize = 4
        HorzScrollBar.SelfOwnMaterial.IsDefaultDrawThumbBtn = True
        HorzScrollBar.SelfOwnMaterial.ThumbBtnRectParam.Color = 11513775
        HorzScrollBar.SelfOwnMaterial.ThumbBtnRectParam.IsFill = False
        HorzScrollBar.SelfOwnMaterial.ThumbBtnRectParam.FillColor.Color = 11513775
        HorzScrollBar.HitTest = True
        HorzScrollBar.MouseDownFocus = False
        HorzScrollBar.ParentBackground = False
        HorzScrollBar.Properties.AutoSize = False
        HorzScrollBar.Properties.Kind = sbHorizontal
        HorzScrollBar.Properties.SmallChange = 1
        HorzScrollBar.Properties.LargeChange = 10
        HorzScrollBar.Properties.CanOverRangeTypes = []
        ScrollControlCorner.Left = 176
        ScrollControlCorner.Top = 27
        ScrollControlCorner.Width = 12
        ScrollControlCorner.Height = 12
        ScrollControlCorner.ParentMouseEvent = True
        ScrollControlCorner.DirectUIVisible = False
        ScrollControlCorner.ComponentTypeUseKind = ctukDefault
        ScrollControlCorner.MaterialUseKind = mukSelfOwn
        ScrollControlCorner.KeepSelfOwnMaterial = True
        ScrollControlCorner.SelfOwnMaterial.BackColor.Color = clWhite
        ScrollControlCorner.SelfOwnMaterial.BackColor.IsFill = True
        ScrollControlCorner.SelfOwnMaterial.IsTransparent = False
        ScrollControlCorner.HitTest = True
        ScrollControlCorner.MouseDownFocus = False
        ScrollControlCorner.ParentBackground = False
        Properties.ContentWidth = -1.000000000000000000
        Properties.ContentHeight = -1.000000000000000000
        Properties.EnableAutoPullDownRefreshPanel = False
        Properties.EnableAutoPullUpLoadMorePanel = False
        Properties.VertCanOverRangeTypes = [cortMin, cortMax]
        Properties.HorzCanOverRangeTypes = []
        Properties.VertScrollBarShowType = sbstNone
        Properties.HorzScrollBarShowType = sbstNone
        Properties.EnabledAutoScroll = False
        Properties.MultiSelect = False
        Properties.IsAutoSelected = True
        Properties.ItemHeight = -1.000000000000000000
        Properties.ItemSpaceType = sistDefault
        Properties.SelectedItemHeight = -1.000000000000000000
        Properties.ItemHeightCalcType = isctSeparate
        Properties.ItemPanDragGestureDirection = ipdgdtLeft
        Properties.IsEmptyContent = False
        Properties.EmptyContentPicture.IsClipRound = False
        Properties.StopEditingItemMode = seimAuto
        Properties.FixedItems = 0
        Properties.EnableResizeItemWidth = False
        Properties.EnableResizeItemHeight = False
        Properties.EnableAutoDragDropItem = False
        Properties.IsEnabledCenterItemSelectMode = False
        Properties.ItemWidth = 40.000000000000000000
        Properties.SelectedItemWidth = -1.000000000000000000
        Properties.ItemWidthCalcType = isctSeparate
        Properties.ItemLayoutType = iltHorizontal
        Properties.ItemColorType = sictNone
        Properties.ItemColorFieldSetType = sicstNone
        Properties.Items.Data = {
          140000040000000400000000005C00000018170000001A000000000042006900
          6E006100720079004F0062006A0065006300740000000E000000000E00080000
          004800650069006700680074000000000000000000F0BF0E000000000C000800
          0000570069006400740068000000000000000000F0BF15000000001000040000
          00560069007300690062006C0065000000FFFFFFFF04000000000A0000000000
          4E0061006D006500000007000000000800040000005400610067000000000000
          0007000000000A00040000005400610067003100000000000000150000000010
          000400000043006800650063006B006500640000000000000007000000001200
          040000004900740065006D005400790070006500000000000000040000000014
          00000000004900740065006D005300740079006C006500000018120000000A00
          1A000000490063006F006E000000540044007200610077005000690063007400
          7500720065000000040000000014000000000049006D006100670065004E0061
          006D00650000001700000000180000000000470049004600460069006C006500
          440061007400610000001700000000180000000000530056004700460069006C
          0065004400610074006100000004000000000A060A0000004E0061006D006500
          00000D54F0790000490063006F006E0000000400000000100606000000430061
          007000740069006F006E000000076898980000FE560768000004000000000C06
          00000000470072006F007500700000000652C47E000007000000001206040000
          0052006F00770043006F0075006E00740000004C887065000001000000070000
          000012060400000043006F006C0043006F0075006E0074000000175270650000
          01000000070000000012080400000052006F00770049006E0064006500780000
          004C880B4E07680000FFFFFFFF070000000012080400000043006F006C004900
          6E00640065007800000017520B4E07680000FFFFFFFF0700000000200A040000
          0050006900630074007500720065004400720061007700540079007000650000
          00D87E36527B7C8B570000000000000700000000160A0400000049006D006100
          6700650049006E006400650078000000FE5647720B4E07680000FFFFFFFF0400
          000000140A0000000049006D006100670065004E0061006D0065000000FE5647
          720D54F07900000400000000120C00000000460069006C0065004E0061006D00
          65000000FE5647728765F64E0D54000004000000001A0E000000005200650073
          006F0075007200630065004E0061006D0065000000FE564772448D906E0D54F0
          7900000400000000080A00000000550072006C000000FE564772FE94A5630000
          15000000001810040000004900730043006C006900700052006F0075006E0064
          0000002F6626546A52C18810620657625F0000000000001900000000160A0500
          00004600690078006500640043006F006C006F0072000000038C74659C987282
          00000000002061181200000008001A0000005000690063000000540044007200
          6100770050006900630074007500720065000000040000000014000000000049
          006D006100670065004E0061006D006500000017000000001800000000004700
          49004600460069006C0065004400610074006100000017000000001800000000
          00530056004700460069006C0065004400610074006100000004000000000A06
          080000004E0061006D00650000000D54F0790000500069006300000004000000
          00100606000000430061007000740069006F006E000000076898980000FE5647
          72000004000000000C0600000000470072006F007500700000000652C47E0000
          070000000012060400000052006F00770043006F0075006E00740000004C8870
          65000001000000070000000012060400000043006F006C0043006F0075006E00
          7400000017527065000001000000070000000012080400000052006F00770049
          006E0064006500780000004C880B4E07680000FFFFFFFF070000000012080400
          000043006F006C0049006E00640065007800000017520B4E07680000FFFFFFFF
          0700000000200A04000000500069006300740075007200650044007200610077
          0054007900700065000000D87E36527B7C8B570000000000000700000000160A
          0400000049006D0061006700650049006E006400650078000000FE5647720B4E
          07680000FFFFFFFF0400000000140A0000000049006D006100670065004E0061
          006D0065000000FE5647720D54F07900000400000000120C0000000046006900
          6C0065004E0061006D0065000000FE5647728765F64E0D54000004000000001A
          0E000000005200650073006F0075007200630065004E0061006D0065000000FE
          564772448D906E0D54F07900000400000000080A00000000550072006C000000
          FE564772FE94A563000015000000001810040000004900730043006C00690070
          0052006F0075006E00640000002F6626546A52C18810620657625F0000000000
          001900000000160A050000004600690078006500640043006F006C006F007200
          0000038C74659C98728200000000002061070000000012000400000049007400
          65006D00540079007000650000000000000015000000001C0004000000410075
          0074006F00530069007A00650057006900640074006800000000000000150000
          00001E00040000004100750074006F00530069007A0065004800650069006700
          680074000000000000000400000000100004000000430061007000740069006F
          006E0000003100000004000000000E0000000000440065007400610069006C00
          00000400000000100000000000440065007400610069006C0031000000040000
          0000100000000000440065007400610069006C00320000000400000000100000
          000000440065007400610069006C003300000004000000001000000000004400
          65007400610069006C0034000000040000000010000000000044006500740061
          0069006C00350000000400000000100000000000440065007400610069006C00
          3600000007000000001400040000004100630063006500730073006F00720079
          0000000000000018170000001A0000000000420069006E006100720079004F00
          62006A0065006300740000000E000000000E0008000000480065006900670068
          0074000000000000000000F0BF0E000000000C00080000005700690064007400
          68000000000000000000F0BF1500000000100004000000560069007300690062
          006C0065000000FFFFFFFF04000000000A00000000004E0061006D0065000000
          070000000008000400000054006100670000000000000007000000000A000400
          0000540061006700310000000000000015000000001000040000004300680065
          0063006B00650064000000000000000700000000120004000000490074006500
          6D00540079007000650000000000000004000000001400000000004900740065
          006D005300740079006C006500000018120000000A001A000000490063006F00
          6E00000054004400720061007700500069006300740075007200650000000400
          00000014000000000049006D006100670065004E0061006D0065000000170000
          0000180000000000470049004600460069006C00650044006100740061000000
          1700000000180000000000530056004700460069006C00650044006100740061
          00000004000000000A060A0000004E0061006D00650000000D54F07900004900
          63006F006E0000000400000000100606000000430061007000740069006F006E
          000000076898980000FE560768000004000000000C0600000000470072006F00
          7500700000000652C47E0000070000000012060400000052006F00770043006F
          0075006E00740000004C88706500000100000007000000001206040000004300
          6F006C0043006F0075006E007400000017527065000001000000070000000012
          080400000052006F00770049006E0064006500780000004C880B4E07680000FF
          FFFFFF070000000012080400000043006F006C0049006E006400650078000000
          17520B4E07680000FFFFFFFF0700000000200A04000000500069006300740075
          0072006500440072006100770054007900700065000000D87E36527B7C8B5700
          00000000000700000000160A0400000049006D0061006700650049006E006400
          650078000000FE5647720B4E07680000FFFFFFFF0400000000140A0000000049
          006D006100670065004E0061006D0065000000FE5647720D54F0790000040000
          0000120C00000000460069006C0065004E0061006D0065000000FE5647728765
          F64E0D54000004000000001A0E000000005200650073006F0075007200630065
          004E0061006D0065000000FE564772448D906E0D54F07900000400000000080A
          00000000550072006C000000FE564772FE94A563000015000000001810040000
          004900730043006C006900700052006F0075006E00640000002F6626546A52C1
          8810620657625F0000000000001900000000160A050000004600690078006500
          640043006F006C006F0072000000038C74659C98728200000000002002181200
          000008001A000000500069006300000054004400720061007700500069006300
          74007500720065000000040000000014000000000049006D006100670065004E
          0061006D00650000001700000000180000000000470049004600460069006C00
          6500440061007400610000001700000000180000000000530056004700460069
          006C0065004400610074006100000004000000000A06080000004E0061006D00
          650000000D54F079000050006900630000000400000000100606000000430061
          007000740069006F006E000000076898980000FE564772000004000000000C06
          00000000470072006F007500700000000652C47E000007000000001206040000
          0052006F00770043006F0075006E00740000004C887065000001000000070000
          000012060400000043006F006C0043006F0075006E0074000000175270650000
          01000000070000000012080400000052006F00770049006E0064006500780000
          004C880B4E07680000FFFFFFFF070000000012080400000043006F006C004900
          6E00640065007800000017520B4E07680000FFFFFFFF0700000000200A040000
          0050006900630074007500720065004400720061007700540079007000650000
          00D87E36527B7C8B570000000000000700000000160A0400000049006D006100
          6700650049006E006400650078000000FE5647720B4E07680000FFFFFFFF0400
          000000140A0000000049006D006100670065004E0061006D0065000000FE5647
          720D54F07900000400000000120C00000000460069006C0065004E0061006D00
          65000000FE5647728765F64E0D54000004000000001A0E000000005200650073
          006F0075007200630065004E0061006D0065000000FE564772448D906E0D54F0
          7900000400000000080A00000000550072006C000000FE564772FE94A5630000
          15000000001810040000004900730043006C006900700052006F0075006E0064
          0000002F6626546A52C18810620657625F0000000000001900000000160A0500
          00004600690078006500640043006F006C006F0072000000038C74659C987282
          0000000000207407000000001200040000004900740065006D00540079007000
          650000000000000015000000001C00040000004100750074006F00530069007A
          0065005700690064007400680000000000000015000000001E00040000004100
          750074006F00530069007A006500480065006900670068007400000000000000
          0400000000100004000000430061007000740069006F006E0000003200000004
          000000000E0000000000440065007400610069006C0000000400000000100000
          000000440065007400610069006C003100000004000000001000000000004400
          65007400610069006C0032000000040000000010000000000044006500740061
          0069006C00330000000400000000100000000000440065007400610069006C00
          340000000400000000100000000000440065007400610069006C003500000004
          00000000100000000000440065007400610069006C0036000000070000000014
          00040000004100630063006500730073006F0072007900000000000000181700
          00001A0000000000420069006E006100720079004F0062006A00650063007400
          00000E000000000E000800000048006500690067006800740000000000000000
          00F0BF0E000000000C0008000000570069006400740068000000000000000000
          F0BF1500000000100004000000560069007300690062006C0065000000FFFFFF
          FF04000000000A00000000004E0061006D006500000007000000000800040000
          0054006100670000000000000007000000000A00040000005400610067003100
          000000000000150000000010000400000043006800650063006B006500640000
          000000000007000000001200040000004900740065006D005400790070006500
          00000000000004000000001400000000004900740065006D005300740079006C
          006500000018120000000A001A000000490063006F006E000000540044007200
          6100770050006900630074007500720065000000040000000014000000000049
          006D006100670065004E0061006D006500000017000000001800000000004700
          49004600460069006C0065004400610074006100000017000000001800000000
          00530056004700460069006C0065004400610074006100000004000000000A06
          0A0000004E0061006D00650000000D54F0790000490063006F006E0000000400
          000000100606000000430061007000740069006F006E000000076898980000FE
          560768000004000000000C0600000000470072006F007500700000000652C47E
          0000070000000012060400000052006F00770043006F0075006E00740000004C
          887065000001000000070000000012060400000043006F006C0043006F007500
          6E007400000017527065000001000000070000000012080400000052006F0077
          0049006E0064006500780000004C880B4E07680000FFFFFFFF07000000001208
          0400000043006F006C0049006E00640065007800000017520B4E07680000FFFF
          FFFF0700000000200A0400000050006900630074007500720065004400720061
          00770054007900700065000000D87E36527B7C8B570000000000000700000000
          160A0400000049006D0061006700650049006E006400650078000000FE564772
          0B4E07680000FFFFFFFF0400000000140A0000000049006D006100670065004E
          0061006D0065000000FE5647720D54F07900000400000000120C000000004600
          69006C0065004E0061006D0065000000FE5647728765F64E0D54000004000000
          001A0E000000005200650073006F0075007200630065004E0061006D00650000
          00FE564772448D906E0D54F07900000400000000080A00000000550072006C00
          0000FE564772FE94A563000015000000001810040000004900730043006C0069
          00700052006F0075006E00640000002F6626546A52C18810620657625F000000
          0000001900000000160A050000004600690078006500640043006F006C006F00
          72000000038C74659C98728200000000002000181200000008001A0000005000
          6900630000005400440072006100770050006900630074007500720065000000
          040000000014000000000049006D006100670065004E0061006D006500000017
          00000000180000000000470049004600460069006C0065004400610074006100
          00001700000000180000000000530056004700460069006C0065004400610074
          006100000004000000000A06080000004E0061006D00650000000D54F0790000
          50006900630000000400000000100606000000430061007000740069006F006E
          000000076898980000FE564772000004000000000C0600000000470072006F00
          7500700000000652C47E0000070000000012060400000052006F00770043006F
          0075006E00740000004C88706500000100000007000000001206040000004300
          6F006C0043006F0075006E007400000017527065000001000000070000000012
          080400000052006F00770049006E0064006500780000004C880B4E07680000FF
          FFFFFF070000000012080400000043006F006C0049006E006400650078000000
          17520B4E07680000FFFFFFFF0700000000200A04000000500069006300740075
          0072006500440072006100770054007900700065000000D87E36527B7C8B5700
          00000000000700000000160A0400000049006D0061006700650049006E006400
          650078000000FE5647720B4E07680000FFFFFFFF0400000000140A0000000049
          006D006100670065004E0061006D0065000000FE5647720D54F0790000040000
          0000120C00000000460069006C0065004E0061006D0065000000FE5647728765
          F64E0D54000004000000001A0E000000005200650073006F0075007200630065
          004E0061006D0065000000FE564772448D906E0D54F07900000400000000080A
          00000000550072006C000000FE564772FE94A563000015000000001810040000
          004900730043006C006900700052006F0075006E00640000002F6626546A52C1
          8810620657625F0000000000001900000000160A050000004600690078006500
          640043006F006C006F0072000000038C74659C98728200000000002059070000
          00001200040000004900740065006D0054007900700065000000000000001500
          0000001C00040000004100750074006F00530069007A00650057006900640074
          00680000000000000015000000001E00040000004100750074006F0053006900
          7A00650048006500690067006800740000000000000004000000001000040000
          00430061007000740069006F006E0000003300000004000000000E0000000000
          440065007400610069006C000000040000000010000000000044006500740061
          0069006C00310000000400000000100000000000440065007400610069006C00
          320000000400000000100000000000440065007400610069006C003300000004
          00000000100000000000440065007400610069006C0034000000040000000010
          0000000000440065007400610069006C00350000000400000000100000000000
          440065007400610069006C003600000007000000001400040000004100630063
          006500730073006F007200790000000000000018170000001A00000000004200
          69006E006100720079004F0062006A0065006300740000000E000000000E0008
          0000004800650069006700680074000000000000000000F0BF0E000000000C00
          08000000570069006400740068000000000000000000F0BF1500000000100004
          000000560069007300690062006C0065000000FFFFFFFF04000000000A000000
          00004E0061006D00650000000700000000080004000000540061006700000000
          00000007000000000A0004000000540061006700310000000000000015000000
          0010000400000043006800650063006B00650064000000000000000700000000
          1200040000004900740065006D00540079007000650000000000000004000000
          001400000000004900740065006D005300740079006C00650000001812000000
          0A001A000000490063006F006E00000054004400720061007700500069006300
          74007500720065000000040000000014000000000049006D006100670065004E
          0061006D00650000001700000000180000000000470049004600460069006C00
          6500440061007400610000001700000000180000000000530056004700460069
          006C0065004400610074006100000004000000000A060A0000004E0061006D00
          650000000D54F0790000490063006F006E000000040000000010060600000043
          0061007000740069006F006E000000076898980000FE56076800000400000000
          0C0600000000470072006F007500700000000652C47E00000700000000120604
          00000052006F00770043006F0075006E00740000004C88706500000100000007
          0000000012060400000043006F006C0043006F0075006E007400000017527065
          000001000000070000000012080400000052006F00770049006E006400650078
          0000004C880B4E07680000FFFFFFFF070000000012080400000043006F006C00
          49006E00640065007800000017520B4E07680000FFFFFFFF0700000000200A04
          0000005000690063007400750072006500440072006100770054007900700065
          000000D87E36527B7C8B570000000000000700000000160A0400000049006D00
          61006700650049006E006400650078000000FE5647720B4E07680000FFFFFFFF
          0400000000140A0000000049006D006100670065004E0061006D0065000000FE
          5647720D54F07900000400000000120C00000000460069006C0065004E006100
          6D0065000000FE5647728765F64E0D54000004000000001A0E00000000520065
          0073006F0075007200630065004E0061006D0065000000FE564772448D906E0D
          54F07900000400000000080A00000000550072006C000000FE564772FE94A563
          000015000000001810040000004900730043006C006900700052006F0075006E
          00640000002F6626546A52C18810620657625F0000000000001900000000160A
          050000004600690078006500640043006F006C006F0072000000038C74659C98
          7282000000000020EA181200000008001A000000500069006300000054004400
          7200610077005000690063007400750072006500000004000000001400000000
          0049006D006100670065004E0061006D00650000001700000000180000000000
          470049004600460069006C006500440061007400610000001700000000180000
          000000530056004700460069006C006500440061007400610000000400000000
          0A06080000004E0061006D00650000000D54F079000050006900630000000400
          000000100606000000430061007000740069006F006E000000076898980000FE
          564772000004000000000C0600000000470072006F007500700000000652C47E
          0000070000000012060400000052006F00770043006F0075006E00740000004C
          887065000001000000070000000012060400000043006F006C0043006F007500
          6E007400000017527065000001000000070000000012080400000052006F0077
          0049006E0064006500780000004C880B4E07680000FFFFFFFF07000000001208
          0400000043006F006C0049006E00640065007800000017520B4E07680000FFFF
          FFFF0700000000200A0400000050006900630074007500720065004400720061
          00770054007900700065000000D87E36527B7C8B570000000000000700000000
          160A0400000049006D0061006700650049006E006400650078000000FE564772
          0B4E07680000FFFFFFFF0400000000140A0000000049006D006100670065004E
          0061006D0065000000FE5647720D54F07900000400000000120C000000004600
          69006C0065004E0061006D0065000000FE5647728765F64E0D54000004000000
          001A0E000000005200650073006F0075007200630065004E0061006D00650000
          00FE564772448D906E0D54F07900000400000000080A00000000550072006C00
          0000FE564772FE94A563000015000000001810040000004900730043006C0069
          00700052006F0075006E00640000002F6626546A52C18810620657625F000000
          0000001900000000160A050000004600690078006500640043006F006C006F00
          72000000038C74659C9872820000000000200007000000001200040000004900
          740065006D00540079007000650000000000000015000000001C000400000041
          00750074006F00530069007A0065005700690064007400680000000000000015
          000000001E00040000004100750074006F00530069007A006500480065006900
          6700680074000000000000000400000000100004000000430061007000740069
          006F006E0000003400000004000000000E000000000044006500740061006900
          6C0000000400000000100000000000440065007400610069006C003100000004
          00000000100000000000440065007400610069006C0032000000040000000010
          0000000000440065007400610069006C00330000000400000000100000000000
          440065007400610069006C003400000004000000001000000000004400650074
          00610069006C0035000000040000000010000000000044006500740061006900
          6C003600000007000000001400040000004100630063006500730073006F0072
          007900000000000000}
        Properties.Items = <
          item
            Selected = False
            Checked = False
            Height = -1.000000000000000000
            Visible = True
            Color = clBlack
            Width = -1.000000000000000000
            Icon.IsClipRound = False
            Pic.IsClipRound = False
            Tag = 0
            Tag1 = 0
            ItemType = sitDefault
            Caption = '1'
            Accessory = satNone
            AutoSizeWidth = False
            AutoSizeHeight = False
          end
          item
            Selected = False
            Checked = False
            Height = -1.000000000000000000
            Visible = True
            Color = clBlack
            Width = -1.000000000000000000
            Icon.IsClipRound = False
            Pic.IsClipRound = False
            Tag = 0
            Tag1 = 0
            ItemType = sitDefault
            Caption = '2'
            Accessory = satNone
            AutoSizeWidth = False
            AutoSizeHeight = False
          end
          item
            Selected = False
            Checked = False
            Height = -1.000000000000000000
            Visible = True
            Color = clBlack
            Width = -1.000000000000000000
            Icon.IsClipRound = False
            Pic.IsClipRound = False
            Tag = 0
            Tag1 = 0
            ItemType = sitDefault
            Caption = '3'
            Accessory = satNone
            AutoSizeWidth = False
            AutoSizeHeight = False
          end
          item
            Selected = False
            Checked = False
            Height = -1.000000000000000000
            Visible = True
            Color = clBlack
            Width = -1.000000000000000000
            Icon.IsClipRound = False
            Pic.IsClipRound = False
            Tag = 0
            Tag1 = 0
            ItemType = sitDefault
            Caption = '4'
            Accessory = satNone
            AutoSizeWidth = False
            AutoSizeHeight = False
          end>
        Properties.EnableBuffer = False
        OnClickItem = lbPageIndexsClickItem
      end
    end
  end
  object btnFirstPage_Material: TSkinButtonDefaultMaterial
    BackColor.Color = clWhite
    BackColor.IsFill = True
    IsTransparent = False
    ArrowPicture.IsClipRound = False
    IsAutoCenterIconAndCaption = False
    DrawDetailParam.FontName = 'Tahoma'
    DrawDetailParam.FontSize = 8
    DrawDetailParam.DrawFont.Charset = DEFAULT_CHARSET
    DrawDetailParam.DrawFont.Height = -11
    DrawDetailParam.DrawFont.Name = 'Tahoma'
    DrawDetailParam.DrawFont.Style = []
    DrawDetailParam.FontTrimming = fttNone
    DrawDetailParam.FontHorzAlign = fhaLeft
    DrawDetailParam.FontVertAlign = fvaTop
    DrawDetailParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
    DrawDetailParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
    DrawDetailParam.DrawEffectSetting.PushedEffect.FontSize = 12
    DrawDetailParam.DrawEffectSetting.DisabledEffect.FontSize = 12
    DrawDetailParam.DrawEffectSetting.FocusedEffect.FontSize = 12
    DrawDetail1Param.FontName = 'Tahoma'
    DrawDetail1Param.FontSize = 8
    DrawDetail1Param.DrawFont.Charset = DEFAULT_CHARSET
    DrawDetail1Param.DrawFont.Height = -11
    DrawDetail1Param.DrawFont.Name = 'Tahoma'
    DrawDetail1Param.DrawFont.Style = []
    DrawDetail1Param.FontTrimming = fttNone
    DrawDetail1Param.FontHorzAlign = fhaLeft
    DrawDetail1Param.FontVertAlign = fvaTop
    DrawDetail1Param.DrawEffectSetting.MouseDownEffect.FontSize = 12
    DrawDetail1Param.DrawEffectSetting.MouseOverEffect.FontSize = 12
    DrawDetail1Param.DrawEffectSetting.PushedEffect.FontSize = 12
    DrawDetail1Param.DrawEffectSetting.DisabledEffect.FontSize = 12
    DrawDetail1Param.DrawEffectSetting.FocusedEffect.FontSize = 12
    DrawHelpTextParam.FontName = 'Tahoma'
    DrawHelpTextParam.FontSize = 8
    DrawHelpTextParam.FontColor = clGray
    DrawHelpTextParam.DrawFont.Charset = DEFAULT_CHARSET
    DrawHelpTextParam.DrawFont.Color = clGray
    DrawHelpTextParam.DrawFont.Height = -11
    DrawHelpTextParam.DrawFont.Name = 'Tahoma'
    DrawHelpTextParam.DrawFont.Style = []
    DrawHelpTextParam.DrawFont.FontColor.Color = clGray
    DrawHelpTextParam.FontTrimming = fttNone
    DrawHelpTextParam.FontHorzAlign = fhaLeft
    DrawHelpTextParam.FontVertAlign = fvaTop
    DrawHelpTextParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
    DrawHelpTextParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
    DrawHelpTextParam.DrawEffectSetting.PushedEffect.FontSize = 12
    DrawHelpTextParam.DrawEffectSetting.DisabledEffect.FontSize = 12
    DrawHelpTextParam.DrawEffectSetting.FocusedEffect.FontSize = 12
    DrawIconParam.IsAutoFit = True
    DrawIconParam.PictureHorzAlign = phaCenter
    DrawIconParam.DrawRectSetting.Height = 30.000000000000000000
    DrawIconParam.DrawRectSetting.PositionVertType = dppvtCenter
    DrawIconParam.DrawEffectSetting.MouseDownEffect.CommonEffectTypes = [dpcetOffsetChange, dpcetAlphaChange]
    DrawCaptionParam.FontName = 'Tahoma'
    DrawCaptionParam.FontSize = 8
    DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
    DrawCaptionParam.DrawFont.Height = -11
    DrawCaptionParam.DrawFont.Name = 'Tahoma'
    DrawCaptionParam.DrawFont.Style = []
    DrawCaptionParam.FontTrimming = fttNone
    DrawCaptionParam.FontHorzAlign = fhaLeft
    DrawCaptionParam.FontVertAlign = fvaTop
    DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
    DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
    DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
    DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
    DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
    NormalPicture.IsClipRound = False
    HoverPicture.IsClipRound = False
    DownPicture.IsClipRound = False
    DisabledPicture.IsClipRound = False
    FocusedPicture.IsClipRound = False
    PushedPicture.IsClipRound = False
    DrawPictureParam.IsAutoFit = True
    DrawPictureParam.PictureHorzAlign = phaCenter
    DrawPictureParam.DrawRectSetting.Height = 30.000000000000000000
    DrawPictureParam.DrawRectSetting.Enabled = True
    DrawPictureParam.DrawRectSetting.PositionVertType = dppvtCenter
    Left = 96
  end
end
