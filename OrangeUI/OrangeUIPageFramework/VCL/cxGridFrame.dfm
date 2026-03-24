object FrameCxGrid: TFrameCxGrid
  Left = 0
  Top = 0
  Width = 756
  Height = 458
  TabOrder = 0
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 756
    Height = 458
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = cxcbsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnKeyDown = cxGrid1DBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellClick = cxGrid1DBTableView1CellClick
      OnFocusedRecordChanged = cxGrid1DBTableView1FocusedRecordChanged
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.CopyCaptionsToClipboard = False
      OptionsBehavior.CopyRecordsToClipboard = False
      OptionsBehavior.CopyPreviewToClipboard = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OnCustomDrawIndicatorCell = cxGrid1DBTableView1CustomDrawIndicatorCell
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object DataSource1: TDataSource
    DataSet = RestMemTable1
    Left = 72
    Top = 152
  end
  object RestMemTable1: TRestMemTable
    AfterInsert = RestMemTable1AfterInsert
    BeforeDelete = RestMemTable1BeforeDelete
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    FieldDefsInterfaceUrl = 
      'http://127.0.0.1:10020/tablecommonrest/get_record_list?appid=101' +
      '2&rest_name=MedicineSimpleInfo&pageindex=1&pagesize=100'
    OnGetRestDatasetPage = RestMemTable1GetRestDatasetPage
    Left = 408
    Top = 144
  end
end
