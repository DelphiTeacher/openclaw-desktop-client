//convert pas to utf8 by ¥
unit uSkinFireMonkeyItemDesignerPanel;

//{$I FireMonkey.inc}
//
//{$I Source\Controls\uSkinItemDesignerPanel_Impl_Code.inc}



interface
{$I FrameWork.inc}

uses
  Classes,
  Types,
  uDrawCanvas,
  uSkinItems,
  uGraphicCommon,
  uSkinItemDesignerPanelType;

type
  {$I Source\Controls\ComponentPlatformsAttribute.inc}
  TSkinFMXItemDesignerPanel=class(TSkinItemDesignerPanel)
  end;
//  TSkinFMXItemDesignerPanel=TSkinItemDesignerPanel;



  TItemDesignerPanel=TSkinFMXItemDesignerPanel;//{$IFDEF VCL}TSkinWinItemDesignerPanel{$ENDIF}{$IFDEF FMX}TSkinFMXItemDesignerPanel{$ENDIF};
//  TItemDesignerPanel=TSkinItemDesignerPanel;//{$IFDEF VCL}TSkinWinItemDesignerPanel{$ENDIF}{$IFDEF FMX}TSkinFMXItemDesignerPanel{$ENDIF};
//  TItemDesignerPanel=TSkinFMXItemDesignerPanel;//{$IFDEF VCL}TSkinWinItemDesignerPanel{$ENDIF}{$IFDEF FMX}TSkinFMXItemDesignerPanel{$ENDIF};


  TVirtualListDrawItemEvent=procedure(Sender:TObject;
                                      ACanvas:TDrawCanvas;
                                      AItemDesignerPanel:TSkinFMXItemDesignerPanel;
                                      AItem:TSkinItem;
                                      AItemDrawRect:TRect) of object;


implementation


end.
