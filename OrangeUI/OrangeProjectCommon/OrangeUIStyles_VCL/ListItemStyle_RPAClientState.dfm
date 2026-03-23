object FrameListItemStyle_RPAClientState: TFrameListItemStyle_RPAClientState
  Left = 0
  Top = 0
  Width = 556
  Height = 382
  TabOrder = 0
  object ItemDesignerPanel: TSkinWinItemDesignerPanel
    Left = 60
    Top = 72
    Width = 301
    Height = 129
    ParentMouseEvent = True
    DirectUIVisible = False
    ComponentTypeUseKind = ctukDefault
    MaterialUseKind = mukSelfOwn
    KeepSelfOwnMaterial = True
    SelfOwnMaterial.BackColor.Color = clWhite
    SelfOwnMaterial.BackColor.IsFill = False
    SelfOwnMaterial.BackColor.DrawRectSetting.Left = 5.000000000000000000
    SelfOwnMaterial.BackColor.DrawRectSetting.Top = 5.000000000000000000
    SelfOwnMaterial.BackColor.DrawRectSetting.Right = 5.000000000000000000
    SelfOwnMaterial.BackColor.DrawRectSetting.Bottom = 5.000000000000000000
    SelfOwnMaterial.BackColor.DrawRectSetting.Enabled = True
    SelfOwnMaterial.BackColor.DrawEffectSetting.MouseOverEffect.FillColor.Color = 8501277
    SelfOwnMaterial.BackColor.DrawEffectSetting.MouseOverEffect.EffectTypes = [drpetIsFillChange]
    SelfOwnMaterial.BackColor.DrawEffectSetting.PushedEffect.IsFill = True
    SelfOwnMaterial.BackColor.DrawEffectSetting.PushedEffect.FillColor.Color = clWhite
    SelfOwnMaterial.BackColor.DrawEffectSetting.PushedEffect.EffectTypes = [drpetFillColorChange, drpetIsFillChange]
    SelfOwnMaterial.IsTransparent = True
    HitTest = False
    MouseDownFocus = False
    ParentBackground = False
    TabOrder = 0
    OnResize = ItemDesignerPanelResize
    Properties.IsPreview = False
    Properties.PreviewItem.Selected = False
    Properties.PreviewItem.Checked = False
    Properties.PreviewItem.Height = -1.000000000000000000
    Properties.PreviewItem.Visible = True
    Properties.PreviewItem.Color = clBlack
    Properties.PreviewItem.Width = -1.000000000000000000
    Properties.PreviewItem.Icon.IsClipRound = False
    Properties.PreviewItem.Pic.IsClipRound = False
    Properties.PreviewItem.Tag = 0
    Properties.PreviewItem.Tag1 = 0
    Properties.PreviewItem.ItemType = sitDefault
    Properties.PreviewItem.IsParent = False
    Properties.PreviewItem.Expanded = True
    Properties.PreviewItem.Childs.Data = {140000000000000400000000005C000000}
    Properties.PreviewItem.Childs = <>
    Properties.PreviewItem.Accessory = satNone
    Properties.ItemStringsBindingControlCollection = <>
    DesignSize = (
      301
      129)
    object imgItemIcon: TSkinWinImage
      AlignWithMargins = True
      Left = 10
      Top = 5
      Width = 48
      Height = 119
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 2
      Margins.Bottom = 5
      ParentMouseEvent = True
      BindItemFieldName = 'ItemIcon'
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = False
      SelfOwnMaterial.IsTransparent = True
      SelfOwnMaterial.DrawPictureParam.IsAutoFit = True
      SelfOwnMaterial.DrawPictureParam.PictureHorzAlign = phaCenter
      SelfOwnMaterial.DrawPictureParam.PictureVertAlign = pvaCenter
      SelfOwnMaterial.DrawPictureParam.DrawEffectSetting.MouseDownEffect.CommonEffectTypes = [dpcetOffsetChange]
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
      HitTest = False
      MouseDownFocus = False
      Align = alLeft
      ParentBackground = False
      TabOrder = 0
      Caption = ''
      Properties.AutoSize = False
      Properties.Picture.IsClipRound = False
      Properties.Animated = False
      Properties.AnimateSpeed = 10.000000000000000000
      Properties.GIFDelayExp = 12
      Properties.CurrentRotateAngle = 0
      Properties.Rotated = False
      Properties.RotateSpeed = 5.000000000000000000
      Properties.RotateIncrement = 20
    end
    object lblItemCaption: TSkinWinLabel
      Left = 120
      Top = 3
      Width = 163
      Height = 25
      ParentMouseEvent = True
      BindItemFieldName = 'ItemCaption'
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = False
      SelfOwnMaterial.IsTransparent = True
      SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.FontColor = clGray
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Color = clGray
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -16
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
      SelfOwnMaterial.DrawCaptionParam.DrawFont.FontColor.Color = clGray
      SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
      SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaRight
      SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaCenter
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.CommonEffectTypes = [dpcetOffsetChange]
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
      HitTest = False
      MouseDownFocus = False
      Anchors = [akTop, akRight]
      ParentBackground = False
      TabOrder = 1
      Caption = #20973#35777#29983#25104'01'
      Text = #20973#35777#29983#25104'01'
      Properties.AutoSize = False
    end
    object lblItemDetail1: TSkinWinMultiColorLabel
      Left = 120
      Top = 58
      Width = 163
      Height = 25
      ParentMouseEvent = True
      BindItemFieldName = 'ItemDetail'
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = False
      SelfOwnMaterial.IsTransparent = True
      SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.FontSize = 10
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -13
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
      SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
      SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaRight
      SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaCenter
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.CommonEffectTypes = [dpcetOffsetChange]
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
      HitTest = False
      MouseDownFocus = False
      Anchors = [akTop, akRight]
      ParentBackground = False
      TabOrder = 2
      Caption = #20219#21153#25968#65306'102 / 400'
      Text = #20219#21153#25968#65306'102 / 400'
      Properties.AutoSize = False
      Properties.ColorTextCollection = <
        item
          Text = #22788#29702#21333#25968':'
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end
        item
          Text = '12'
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Color = 6737427
          DrawFont.Height = -19
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          DrawFont.FontColor.Color = 6737427
          IsUseDefaultDrawFont = False
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end
        item
          Text = '/'
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end
        item
          Text = '22'
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end>
      Properties.Text1 = #22788#29702#21333#25968':'
      Properties.Text2 = '12'
      Properties.Text3 = '/'
      Properties.Text4 = '22'
      Properties.Color1 = clBlack
      Properties.Color2 = 6737427
      Properties.Color3 = clBlack
      Properties.Color4 = clBlack
    end
    object lblItemDetail: TSkinWinMultiColorLabel
      Left = 88
      Top = 30
      Width = 162
      Height = 25
      ParentMouseEvent = True
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = False
      SelfOwnMaterial.IsTransparent = True
      SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.FontSize = 10
      SelfOwnMaterial.DrawCaptionParam.FontColor = clGray
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Color = clGray
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -13
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
      SelfOwnMaterial.DrawCaptionParam.DrawFont.FontColor.Color = clGray
      SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
      SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaRight
      SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaCenter
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.CommonEffectTypes = [dpcetOffsetChange]
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
      HitTest = False
      MouseDownFocus = False
      Anchors = [akTop, akRight]
      ParentBackground = False
      TabOrder = 3
      Caption = #20973#35777#29983#25104#26426#22120#20154
      Text = #20973#35777#29983#25104#26426#22120#20154
      Properties.AutoSize = False
      Properties.ColorTextCollection = <
        item
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Color = clGray
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          DrawFont.FontColor.Color = clGray
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end
        item
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Color = clGray
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          DrawFont.FontColor.Color = clGray
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end
        item
          Text = #20973#35777#29983#25104#26426#22120#20154#36816#34892#20013
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Color = clGray
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          DrawFont.FontColor.Color = clGray
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end
        item
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Color = clGray
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          DrawFont.FontColor.Color = clGray
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end>
      Properties.Text3 = #20973#35777#29983#25104#26426#22120#20154#36816#34892#20013
      Properties.Color1 = clGray
      Properties.Color2 = clGray
      Properties.Color3 = clGray
      Properties.Color4 = clGray
    end
    object lblItemDetail2: TSkinWinMultiColorLabel
      Left = 120
      Top = 83
      Width = 163
      Height = 25
      ParentMouseEvent = True
      BindItemFieldName = 'ItemDetail'
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = False
      SelfOwnMaterial.IsTransparent = True
      SelfOwnMaterial.DrawCaptionParam.FontName = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.FontSize = 10
      SelfOwnMaterial.DrawCaptionParam.FontColor = clGray
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Charset = DEFAULT_CHARSET
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Color = clGray
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Height = -13
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Name = 'Tahoma'
      SelfOwnMaterial.DrawCaptionParam.DrawFont.Style = []
      SelfOwnMaterial.DrawCaptionParam.DrawFont.FontColor.Color = clGray
      SelfOwnMaterial.DrawCaptionParam.FontTrimming = fttNone
      SelfOwnMaterial.DrawCaptionParam.FontHorzAlign = fhaRight
      SelfOwnMaterial.DrawCaptionParam.FontVertAlign = fvaCenter
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.CommonEffectTypes = [dpcetOffsetChange]
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseDownEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.MouseOverEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.PushedEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.DisabledEffect.FontSize = 12
      SelfOwnMaterial.DrawCaptionParam.DrawEffectSetting.FocusedEffect.FontSize = 12
      HitTest = False
      MouseDownFocus = False
      Anchors = [akTop, akRight]
      ParentBackground = False
      TabOrder = 4
      Caption = #22788#29702#21333#25968#65306'102 / 400'
      Text = #22788#29702#21333#25968#65306'102 / 400'
      Properties.AutoSize = False
      Properties.ColorTextCollection = <
        item
          Text = #25346#36215#21333#25968':'
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Color = clGray
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          DrawFont.FontColor.Color = clGray
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end
        item
          Text = '36'
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Color = 4803071
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          DrawFont.FontColor.Color = 4803071
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end
        item
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Color = clGray
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          DrawFont.FontColor.Color = clGray
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end
        item
          DrawFont.Charset = DEFAULT_CHARSET
          DrawFont.Color = clGray
          DrawFont.Height = -11
          DrawFont.Name = 'Tahoma'
          DrawFont.Style = []
          DrawFont.FontColor.Color = clGray
          IsUseDefaultDrawFont = True
          IsUseDefaultDrawFontColor = False
          IsBindingItem = False
        end>
      Properties.Text1 = #25346#36215#21333#25968':'
      Properties.Text2 = '36'
      Properties.Color1 = clGray
      Properties.Color2 = 4803071
      Properties.Color3 = clGray
      Properties.Color4 = clGray
    end
    object btnStartTask: TSkinButton
      Left = 253
      Top = 27
      Width = 28
      Height = 28
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 0
      ParentMouseEvent = True
      DirectUIVisible = False
      ComponentTypeUseKind = ctukDefault
      MaterialUseKind = mukSelfOwn
      KeepSelfOwnMaterial = True
      SelfOwnMaterial.BackColor.Color = clWhite
      SelfOwnMaterial.BackColor.IsFill = False
      SelfOwnMaterial.IsTransparent = True
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
      SelfOwnMaterial.DrawIconParam.IsAutoFit = True
      SelfOwnMaterial.DrawIconParam.PictureHorzAlign = phaCenter
      SelfOwnMaterial.DrawIconParam.PictureVertAlign = pvaCenter
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
      HitTest = True
      MouseDownFocus = False
      Anchors = [akTop, akRight]
      ParentBackground = False
      TabOrder = 5
      Caption = ''
      Text = ''
      Properties.AutoSize = False
      Properties.IsAutoPush = False
      Properties.IsPushed = False
      Properties.Icon.IsClipRound = False
      Properties.Icon.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000800000
        00800806000000C33E61CB0000096C4944415478DAED5D6D72133D0CF632DC83
        E508C0F09B7212DA93D09CA4CD4908BF19E008AFB9474B5F2BD81927CD8724CB
        96ECEE33B3D39D34D9F5C7633D92D66B4F6E40FCFEFD7B86BF7FFFFEBD0A7FE0
        FCCD344DDBCF9E9E9EE6F8B539FB894F27E17B3E7E0FFEFE81FF85EBF88F1F3F
        6EB4EB55039376014A9175F675E8BC4FA1E3AE2ADECE0341C23DBE87FB6D4620
        459704804E6FD4E197E0E3DF4D28CFBA4742744380D4E9E1F4AB7659CEC0BBCE
        C8609A0059A77F71FB9ADD037C38D6AF5EBDBA7FF7EE9DD72ECC2998244027A3
        1D0BEF0C5B055304881D0F9D7EAD5D964AB8B746041304808E0FCEDC9DB243D7
        12105ADE5820822A010633F51CDC071F61A5E923A811E0E7CF9FB7AE6DC7FB6D
        8563A20710933D2E2589E267703EE32F2B52AEF5870F1F6E1BDE7387E604F8F1
        E3C75560FD9DABD7C8BB648D2BC8E281757A7878984359E758D637AEAE6FA222
        0B4D095069D4FB70ACE1A445C81565EB2A9C7E72F284D8D6A5A5356842800A4E
        9E0FC75A3B1D9B5909C8535C0B5EDA876B7E6EE11B54274034F9DF440A3B4D9B
        C7C7C79505EFF910152C83770DAC415502089AFC95F58C5A0EE1E866559304D5
        08F0EBD7AF6F8526DF3B45EF58028244A846822A0410E8FCAAAC6F0D092280FC
        BD7FFFFEB374D9440920E0EC99C990D58044FB483B87620428AC1C54A86B734F
        41A16F244A02110294747E2DD3661D5116203A9A193F17238108010A347F28AD
        A7A2D037F0A1EDDE9696A19800CCCE1F5AEBA9E05A0309EB5944006EE74B3077
        341448C27D68CF1BEE7DD904E038322F55EFB12820015B4A5904E0A47797CEC7
        813B2B2AFCE6334752C9048805FC8F7493A5F349603A87ACC8804C00AAEE2F9D
        CF0327B4E6B435890054DD5F3ABF0CCCFC0AC91F401380A1FB8BB72F00866348
        0AB1D104209AFEEA9D9F2663BC7EFDDAF7F298B8A4AE541260DB1F4500AAE9E7
        7AA4C406498E68B3D9339A60586094146009F0247DE3129C20E44DB8EF7DCDFB
        6A8338105103E32201C24D6106EF35E68EAD9CBE3365529F675F130CA7F06296
        F02C01A866277CF76D8BC6BF40CAA125819A87B924C767094071FC6AEB7E0EA4
        551A561242FDA1EE77C8AF9F75084F128032FA5BC7FB0459EA6A3229055283F3
        2401AC8E7E00D52F09C7CD6824A048C1B9017A940044ED2F7A1CC90185001986
        93044A3B9C1AA4470940B97068D4E6EF17320900184A12880EE1D1817A8A00D8
        B85F654A570101869304426EE06874341DB920BA715B857D25653C8321248168
        059E0DD86304808BCD888B35D7FEAC8C1204D836C8089240688F6721E11E0128
        CE9FD6E82756F8224690048A15387406F708406858B5D14F2C27055D4B02216C
        DFEBBB4302A0CC7FEBB8FF10950800E8561208D67B4F067604A0A4173542BF1C
        1509D0AD24706520274017E69F58D6127427099414798A0672027461FE89152D
        4557928095813C359C130095FCD136FFB1ACAD08D09524106460E7076C3B93A0
        FFEAE63F96B7190122BA7997111B0D244B9E0870EB70E94413BAA8408004F392
        4018CC5B3F201100D5A09AC99F834A6A11C0BC24606520F9018900DDE87F2CAF
        1A01224C4B02B23FB77E00850026F43F96579B0009262501EB0780459F081924
        33AB791822804949C0FA74E0084E04A7C18403182B68860011A6248130A86F26
        2C5BAC38800083044830210914AB3EF51601000C13C0842450228109EB305889
        0000960910A1FE720AC6B1A710C0D4ABDE1D102041CD71C63CDBD91200FB454B
        0B3D7444003549C00EEC85006DD05C124409E00C2581001D1220A159284D2140
        57594040C704B0F206F50E0B011AA355344521C0E203B48335095808D008CD53
        C54B1460045A6D8726C09208AA0AFB89A0850055A0FE749092095C1E0609C28A
        5C62A33BF4E3600BEF036495B34A00139366488F83B15F5E087016EA263F0765
        92CF3225AC10564C7E0ECA249F893A8D58BB72B1825608606650E4A0F8759459
        C166220103043065F20F817DCF13D2D25B02505F27325041D51743AC58C253A0
        3CDF595E0DA3C1A4C9CFC17A358CF35AB172259B13C08AF5BB046CDBECBD1CCA
        79ADB8874A4AC0C22C5F0A28FABFAD5FFAA0273FA0E50211D64D7E0ECE6BFEF9
        021150518C1FA03E39A405012C109D0ACE323F3B02705799325E51327A33F939
        38CBFCEC4D4FEA45066A2E13D793C9CFC15DE5ED709D40A8FC4519D08E066A10
        409BD4A510592892120D6866C2A4978A7D7C7C5CF5DCF99435020F1FEB3F9BA1
        CA65524B081240DDA19540C9FE0EC7560BBF75C8F5E7B59C410902F46EF20FDA
        83BDBFC3330248EC42D1A0C2451B46F46EF20FDAE2D62137933C36ABAB74CB18
        95D7A0B904D0765E2BB50576F4E3B78CB16E05380418C9E473DAE1D49C4E896D
        E39A47044402987E76CF85D4CE6E436F1C39A2C94FA8BE7124F526AEE15C010C
        014634F959FDA1EEA8ACDFA541709600445FA099437869F3E8114D7E42D3CDA3
        0154BD6D911B3855A6914D7E02D12A976D1F0FA032CE3578A0728C00239BFCAC
        DEB70E19F303306B11A0162BA06E575EDB04C7F24043CC2DEE670144AF1F80F2
        C95004002B10CCCE1DC1F454F7076283CC1626A9D606D50A53A410BD5C09430A
        D4174B1C0544DD27C92169BD1AAA063903B3877A07B5F31DD107231180210580
        211EB96A80DAF99C2888BC62559402704666C2CF161210C118F92C6BCB5AB28C
        E19102161220C1E87C7618CC5EB38EE10F0016C7F00C98120B60E75E8A162D5C
        48208782CE2FB2AC45042828F48B48DE60C1945491D477F1B2A5252408C7BAD7
        79F852605A51B1E71E22EBD63223838417290905030720965F115BB8B89404EE
        055903E2B395438826D74457AE2E24C1B67223FB0685A3BECAE36EF1A5CB2309
        AE1D43D7227C38D616B65F33D426D5E63A5459BB5EA2C26E0059106A0740B524
        5AD5CD0BB81EEE017C3836C122AC7AB108821D0FA83AC1A6FAEE1531C6058767
        2EBC940FC72634ECDAAA8F103B1E3AFD5AE0724DFCA126DB97943A3F47E09D11
        32088FF62D5ACE6D6CB61B688D868AF0E1D884E37BB8BEAF4D88AC1EAE425D00
        4D17A968BE1DAC40A87809DEFD23C41FF7CF8CB24801E584BFE1F75750D6302A
        3F095AB0A3E5D6088155F603AE680DCEC16F2B3C4D3E7D103A347D36679FC1F9
        8CBFAC48B9D4A21DD50DA195886009EA6B1299D811BC8293681D669E7F982040
        827018650E1697A03345808401A5616535B56D92000989080D3CF01AF0AE8354
        B66902E4C8ACC217D7D64BA7C0BBCE1E647543801CC62C83779D757A8E2E0990
        03C8F0F0F030870EB86A91AC813C42B807641D37DA696809744F8063C84831BB
        7F72F126257B62A2C7B97D19F1BB068989A298242ACA26F680FF01AF291A0F25
        768DFD0000000049454E44AE426082}
      Properties.PushedIcon.IsClipRound = False
      Properties.PushedIcon.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000800000
        00800806000000C33E61CB000007F04944415478DAED9D5D56DC36148065CF09
        A79B08759E9AAC02B288E635B012C24A80D776111956017DAA4B369143CE58B5
        E4F1FC614B57D2BD926CDFEF652825205B9FAEAE64592A04B3688AD40560D2C2
        022C1C1660E1B0000B870558382CC0C299B5004FD56F95D86C2E455154A510BF
        ABEF4929ABFDD517FBAFA5ACBB6F15FAB391F2517F7FB5AA3FD53FD7A9AF858A
        D908A02BBB69AE0A292FB6155B21FF895A49228BE25194E57A2E524C5680BEC2
        55CB96425C252842DDDEBCB58E14AB9512A24E7D4F7C989C004FE767DF1256FA
        185D7410E2E1D38F5FF7A90BE3C22404D88577216E529705401719CAF2610ADD
        44D602A88A2F9BE626B3D60EA6BDB9F7B98B90A500AAE28BCDE6AE4DE62E5397
        05895A96E5758E2264250051C5EFB377C576B8A78677473FB5D954FD9765515C
        743FDA0E1991CBD28AF039A784311B01547287D0C7EB444C0DD3D4D75837BA9F
        4F50622048D1258B2FAFDF506E5C20C905686FEE65D13477C273DCDEDECC5BF5
        19F3861E09E19F9FD4AD4CB7A9470D49050868F5D9B4A25E86F63ABEFA440625
        70CAEB4822806F5FAF5B7B59DEE7D4879E5E97E77035596E105D806DC8FFEEF0
        4FB269ED0ED7E8234292EB8C2A806BC84F1D1E83AFD74384D8D71C4D807FCECF
        EE1C12A66CC7CD3EB8767931258822C0F3FB77DF73BCF8D8B84440358BF8C7CB
        EB357599C80570A8FCEC264928D0D1A0CB812AC83DF9F8F2FA81B23CA402402B
        7FCEAD7E08C7DC8054023201C095DFB5FA35553972063A22A2EC0E48040056FE
        AC123D5FA05D029504E80200131DAEFC03A012507495A80200431A79623345C0
        1248798DF9FC004D80ED05FC6BF931AE7C03400950474B680240FAFD25277C50
        A0126035241401B8F271814453ACA430580048BFCF95EFCED3FB77574551DC99
        7E06E3BE060BF07C7EA64CAD460BB9B0491E4C0023AAE0AE2048006B01A55C7F
        FCF1EB33ED6D9A2F908748A15D81B700907EAA0D511FE63EB74F0DE03E07CDA9
        780B604BFCB0C7AB4BC69A0F04445A2F01AC891F877E74AC0DCE3321F41280AA
        30CC38D6AEC0B3D1390B606BFDB116322C11DBAA2A9F86E72C80ADF5B7C392E4
        EF1ACC158A28E05459DCFAD3831D059C0400FC71B261DFF3F9D99F14BF978A36
        12FE4DF17B6D51C0B5113A09D05682C4FAC3AE6C05F88BEAF723F3854A0085A5
        213ACD0E8205B08D45A9277D58803DB628E0D20D800530257F31FA7E16E0E47E
        9892718764102E8021FCC798F563018EB14464F0F43048005BF88F31F463018E
        B17603C0A7B0A08A33251DB1867E2CC05B30BA019000A667FEB11EFAB0006FB1
        CCCB80460356016C933FB11EF9B2006FC1180DD805C8A0FF57B000C398BA0148
        1E60ADBC1CFA7F7DA12CC020C65559803CC02A400EFDFFB61C2CC000A1790044
        80F1F17FC4255F2CC030B63CC0D6451BFF67E82FC7840518C7D2488D89A05900
        CB6C53CCD7BC5880718C89609000860423F6B37F16609C9091805100D30820F6
        0B1F2CC038210DD55F80C8CBBE598071C80430861616C0445C014CB99A652E80
        05A061260298268122AFFD6701C609990C6201686001B06101C6A11320608201
        1B16601C4E02F38305C0860518874C009E09F4261B01E86602590013F398090C
        5D6D82090B304E4843B5AD07085E758A050B304EC8AAAD9005212CC038392D08
        31AEDA0A5A11C44BC24699C79230452EB3812CC030A1ABB6EC02247E2B78570E
        166090D065FBF61743CCBB8146CB035880614297ED435E0DCB220F600186095D
        B60F7D39D47BD931E285B2002760BCB607130069378A105880B760BCB687B141
        44943C8005780BC6AE2D30016C79006F11734AEA2D62C0B919CA265131BA0116
        E0E47E200DCFE1DBC4D9378A204D0659803D9811D94500D41D2A5D6101F6D876
        6C7579691773AB58D2D3BF79ABD8A37B81B663ABEB66D149A3009378B3688565
        BB783E199418ECFD9AF9C0880991C581110A5B14E093C1F1A13AA789E6D028EE
        0AD0C9EAD0285081F8D83834B23B364E170A76A021D9B07029501FD0497B742C
        7705C158236DE0FB19610200CEBAE751813FD91F1EAD0B09393E9EF3016740F7
        3587E3E3756101A6F2D0100EA4F2B1222B8E008063CE0527852020491FE6E377
        B4AD5E410567098C00EF21EAA377D4BD7EADE3D50E9660006014455F7781BED9
        33201F50B00407805B3EC12BF924BB7D3B48B0F8C41092F0698896DDD108D01A
        2D9AE60A2481100F31379AC889D495AF20DBEF1FDAA7E9EB8BBCDB480E00A324
        F9825BD2031F5C24100BC90B9CEE4984D5D6E4277E3874078A597709E056AF88
        F4C65594235F1C2550CC2A41748C84519F9F443BF347DF089716308368E0217E
        F47C28AA00FAA6B849A0D02288B2BC9F4A7EE053F18AD8DBEF2AA20BA0803C46
        1EA06E0BBB6ECAF23657117C2B5E244C809308A008B8598A5A4A799BC323E6DD
        75487901EDE30F49BD5E2299003DDBC910F5FCA0F2F8E75D5490F231A60CBAD2
        379BCBB6C22B4F8175D9734874930BA0088C0687EC8410ABD51A2BA4EAF22941
        9BE6B2FDFD5F859FAC3B729AF8CA42801ED7E112807A7B916BF5A9C5E859ADEA
        A39FDC6CAAEE8E14FA5387F4EEBFB1CAA2C7F672B5BACE2987C94A801E021152
        9345B81F224B017A940865D3DC985E87CA9C6C2BBE276B017A2626C2A4E62D26
        21404F9F7DEB442CBFEE619233979312E0905E86B2282E124586BA4DEA6A5914
        8F53ABF443262BC02927D1A1128143B5017615DE86F775CEFDBA0BB311E094ED
        D85DE8099B161529D4A794B2DA5F7DB1FFBAADDCEE5B85FE6C84F84F7FAF1D2E
        CEA5B28798AD000C0C1660E1B0000B870558382CC0C26101160E0BB070FE078B
        2C38EA3BC05AC10000000049454E44AE426082}
      Properties.ButtonIndex = -1
      Properties.PushedGroupIndex = 0
    end
  end
end
