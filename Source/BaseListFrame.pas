unit BaseListFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  BaseParentFrame, System.Actions, FMX.ActnList, uDrawPicture, uSkinImageList,
  EasyServiceCommonMaterialDataMoudle,

  uSkinScrollControlType, uSkinScrollBoxType, uSkinFireMonkeyScrollBox,
  uSkinButtonType, uSkinFireMonkeyButton, uSkinFireMonkeyControl,
  uSkinPanelType, uSkinFireMonkeyPanel, uSkinCustomListType,
  uSkinVirtualGridType, uSkinDBGridType, uSkinFireMonkeyDBGrid,
  uSkinVirtualListType, uSkinListBoxType, uSkinFireMonkeyListBox,
  uSkinCheckBoxType, uSkinFireMonkeyCheckBox, uSkinImageType,
  uSkinFireMonkeyImage, uSkinLabelType, uSkinFireMonkeyLabel,
  uSkinItemDesignerPanelType, uSkinFireMonkeyItemDesignerPanel, uDrawCanvas,
  uSkinItems, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FMX.Edit, FMX.Controls.Presentation, uSkinFireMonkeyEdit,
  uTimerTaskEvent, uSkinListViewType, uSkinFireMonkeyListView;

type
  TFrameBaseList = class(TFrameParent)
    pnlSearch: TSkinFMXPanel;
    edtQueryCondition: TSkinFMXEdit;
    ClearEditButton1: TClearEditButton;
    lvData: TSkinFMXListView;
    tteLoadData: TTimerTaskEvent;
    btnAdd: TSkinFMXButton;
  private
    { Private declarations }
  public
    { Public declarations }
  protected
  end;

var
  FrameBaseList: TFrameBaseList;

implementation

{$R *.fmx}


{ TfmBaseInfoClass }



end.
