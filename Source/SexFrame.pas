unit SexFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uDrawCanvas, uSkinItems, uSkinScrollControlType, uSkinCustomListType,
  uSkinVirtualListType, uSkinListBoxType, uSkinFireMonkeyListBox,uUIFunction,
  uSkinFireMonkeyControl, uSkinPanelType, uSkinFireMonkeyPanel, uSkinAnimator;

type
  THideMenuType=(hmtNone,hmtSex);
  TTakedSexEvent=procedure(Sender:TObject;Asex:string) of object;
  TFrameSex = class(TFrame)
    pnlBackground: TSkinFMXPanel;
    pnlBottom: TSkinFMXPanel;
    lbMenu: TSkinFMXListBox;
    sexPopup: TSkinControlMoveAnimator;
    procedure sexPopupAnimateEnd(Sender: TObject);
    procedure lbMenuClickItem(AItem: TSkinItem);
  private
    FSex:string;
    { Private declarations }
  public
    OnTakedSex:TTakedSexEvent;
    HideMenuType:THideMenuType;
    procedure HideMenu;
    procedure ShowMenu;
    { Public declarations }
  end;

var
  GlobalSexMenuFrame:TFrameSex;

implementation

{$R *.fmx}

{ TFrameSex }

procedure TFrameSex.HideMenu;
begin
  sexPopup.GoForward;
end;

procedure TFrameSex.lbMenuClickItem(AItem: TSkinItem);
begin
  if (AItem.Name='man') or (AItem.Name='woman') then
  begin
    HideMenuType:=hmtsex;
    FSex:=AItem.Caption;
  end;

  if AItem.Name='取消' then
  begin
    HideMenuType:=hmtNone;
  end;
  HideMenu;
end;

procedure TFrameSex.sexPopupAnimateEnd(Sender: TObject);
begin
  if Self.sexPopup.DirectionType=adtForward then
  begin
      //隐藏弹出菜单结束
      Self.pnlBackground.Visible:=False;
      Self.Visible:=False;


      HideFrame;//(Self,hfcttBeforeReturnFrame,ufsefNone);
      ReturnFrame;//(Self);

      case HideMenuType of
        hmtsex:
        begin
          if Assigned(OnTakedSex) then
          begin
            OnTakedSex(Self,FSex);
          end;
        end;
      end;


  end;
end;

procedure TFrameSex.ShowMenu;
begin
  Self.pnlBackground.Visible:=True;
  Self.pnlBackground.Align:=TAlignLayout.{$IF CompilerVersion >= 34.0}{$ELSE}al{$ENDIF}None;
  Self.pnlBackground.SetBounds(0,0,Width,Height);
  Self.lbMenu.Width:=Width;
  Self.pnlBackground.BringToFront;
  sexPopup.GoBackward;
end;

end.
