unit BasePageFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, ExtCtrls, Dialogs,
  Math,

  uBaseLog,
  uComponentType,
  uFuncCommon,
  XSuperObject,
  uRestInterfaceCall,
//  uManager,
  uDatasetToJson,
//  uJsonToDataset,
  uOpenClientCommon,
  uOpenCommon,
  uTimerTask,
  uGraphicCommon,
//  SelectPopupForm,

//  GridSwitchPageFrame,

  uPageStructure,
  uBasePageStructure,
  uDataInterface,

  {$IFDEF HAS_LOCAL_DB_INTERFACE}
  //使用本地数据库模式
  uTableCommonRestCenter,
  {$ELSE}
  uRestHttpDataInterface,
  {$ENDIF}

//  uTableCommonRestCenter,
  EasyServiceCommonMaterialDataMoudle_VCL,

  uSkinWindowsControl, uSkinButtonType;

type
  TFrameBaseVCLPage = class(TFrame)
    pnlToolbar: TPanel;
    pnlBottombar: TPanel;
    pnlClient: TPanel;
    procedure FrameResize(Sender: TObject);virtual;
    procedure FrameMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);virtual;
    procedure FrameMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);virtual;
    { Public declarations }
  end;





implementation

{$R *.dfm}




end.
