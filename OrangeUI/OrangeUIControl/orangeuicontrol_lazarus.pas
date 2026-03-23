{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit OrangeUIControl_Lazarus;

{$warn 5023 off : no warning about unused units}
interface

uses
  uBasePageStructure, uBasePathData, uBinaryObjectList, 
  uDownloadPictureManager, uFrameContext, uSkinBufferBitmap, uSkinGIFImage, 
  uUIFunction, uUrlPicture, uVersion, uBinaryTreeDoc, uComponentType, 
  uDrawCanvas, uDrawEngine, uDrawLineParam, uDrawParam, uDrawPathParam, 
  uDrawPicture, uDrawPictureParam, uDrawRectParam, uDrawTextParam, 
  uGraphicCommon, uSkinAnimator, uSkinImageList, uSkinItems, uSkinListLayouts, 
  uSkinMaterial, uSkinPicture, uSkinPublic, uSkinRegManager, uTimerTaskEvent, 
  uSkinButtonType, uSkinLabelType, uBaseSkinControl, uSkinWindowsControl, 
  uSkinCheckBoxType, uComponentTypeRegister, uSkinCalloutRectType, 
  uSkinComboBoxType, uSkinComboEditType, uSkinControlGestureManager, 
  uSkinControlPanDragGestureManager, uSkinCustomListType, uSkinDateEditType, 
  uSkinDBGridType, uSkinDrawPanelType, uSkinEditType, uSkinFrameImageType, 
  uSkinImageListPlayerType, uSkinImageListViewerType, uSkinImageType, 
  uSkinItemDesignerPanelType, uSkinItemGridType, uSkinListBoxType, 
  uSkinListViewType, uSkinMemoType, uSkinMultiColorLabelType, 
  uSkinNotifyNumberIconType, uSkinPageControlType, uSkinPanelType, 
  uSkinPopupType, uSkinProgressBarType, uSkinPullLoadPanelType, 
  uSkinRadioButtonType, uSkinRoundImageType, uSkinScrollBarType, 
  uSkinScrollBoxContentType, uSkinScrollBoxType, uSkinScrollControlCornerType, 
  uSkinScrollControlType, uSkinSwitchBarType, 
  uSkinSwitchPageListControlGestureManager, uSkinSwitchPageListPanelType, 
  uSkinSwitchType, uSkinTimeEditType, uSkinTrackBarType, uSkinTreeViewType, 
  uSkinVirtualChartType, uSkinVirtualGridType, uSkinVirtualListType, 
  uskinsuperobject, uSkinFormType, uDrawPictureEditor, uSkinRepeatImageType, 
  uSkinVirtualChartBezierLineDrawer, uSkinColumnHeaderType, uNativeDrawCanvas, 
  uNativeSkinPictureEngine, uBaseHttpControl, uBaseList, uBaseLog, 
  uFileCommon, uFuncCommon, uLang, uTimerTask, MD5_OrangeUI, xsuperobject, 
  uBGRABufferBitmap, uBGRADrawCanvas, uBGRASkinPictureEngine, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('uComponentTypeRegister', @uComponentTypeRegister.Register);
  RegisterUnit('uDrawPictureEditor', @uDrawPictureEditor.Register);
end;

initialization
  RegisterPackage('OrangeUIControl_Lazarus', @Register);
end.
