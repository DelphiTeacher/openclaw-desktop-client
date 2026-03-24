unit BaseParentFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uDrawPicture, uSkinImageList, uSkinButtonType, uSkinFireMonkeyButton,
  uSkinFireMonkeyControl, uSkinPanelType, uSkinFireMonkeyPanel, System.Actions,

  uFrameContext,
  EasyServiceCommonMaterialDataMoudle,

  FMX.ActnList,uUIFunction, uSkinScrollBoxContentType,
  uSkinFireMonkeyScrollBoxContent, uSkinScrollControlType, uSkinScrollBoxType,
  uSkinFireMonkeyScrollBox,uLang;

type
  TFrameParent = class(TFrame,IFrameHistroyCanReturnEvent)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    procedure btnReturnClick(Sender: TObject);
  private
    { Private declarations }

//    procedure SetC_ID(const Value: string);
  public

    //是否可以返回上一个Frame
    function CanReturn:TFrameReturnActionType;virtual;

    { Public declarations }
//    s_id,c_id,e_id,s_name,d_id:string;
//
//    FrameHistroy:TFrameHistroy;
//    constructor Create(AOwner: TComponent); override;
//    procedure SetStockCaption(szCaption:string);dynamic;
//    procedure SetStockSID(strs_id:string);dynamic;
//
//    procedure SetEmpClassID(pData:PEmpRec);dynamic;
//    procedure SetStockClassID(pData:PStockRec);dynamic;
//    procedure SetProductClassID(pData:PProductRec);dynamic;
//    procedure SetClientClassID(pData:PClientRec);dynamic;
//
//    PROCEDURE clearBill;dynamic;
  end;

implementation

{$R *.fmx}

{ TfmParentFrame }

procedure TFrameParent.btnReturnClick(Sender: TObject);
begin
  //wn
  //什么也不做
  //清空返回事件,也就是返回的时候不调用它
  if GetFrameHistory(Self)<>nil then GetFrameHistory(Self).OnReturnFrame:=nil;
  //wn
  HideFrame;//(FrameHistroy);
  ReturnFrame;//(nil,1,True);
end;





//procedure TfmParentFrame.clearBill;
//begin
// //
//end;
//
//
//
//constructor TfmParentFrame.Create(AOwner: TComponent);
//begin
//  inherited;
// {$IFDEF ANDROID}
// {$ELSE}
//  pnlMostTopBar.Visible := False;
// {$ENDIF}
//end;
//
//procedure TfmParentFrame.SetClientClassID(pData: PClientRec);
//begin
//
//end;
//
//procedure TfmParentFrame.SetC_ID(const Value: string);
//begin
//
//end;
//
//procedure TfmParentFrame.SetEmpClassID(pData: PEmpRec);
//begin
// //
//end;
//
//procedure TfmParentFrame.SetProductClassID(pData: PProductRec);
//begin
//
//end;
//
//procedure TfmParentFrame.SetStockCaption(szCaption: string);
//begin
//// s_name :=  szCaption;
//end;
//
//
//
//procedure TfmParentFrame.SetStockClassID(pData: PStockRec);
//begin
// //
//end;
//
//procedure TfmParentFrame.SetStockSID(strs_id:string);
//begin
// //
//end;

function TFrameParent.CanReturn: TFrameReturnActionType;
begin
  Result:=TFrameReturnActionType.fratReturnAndFree;
end;

end.
