//convert pas to utf8 by ¥

unit ChangeThemeFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,

  HintFrame,
  WaitingFrame,
  MessageBoxFrame,
  uRestInterfaceCall,
  uOpenCommon,

  uManager,
  uOpenClientCommon,
  uTimerTask,
  uUIFunction,
  XSuperObject,
  XSuperJson,
  uFrameContext,
  uBaseHttpControl,

  IniFiles,
  uFileCommon,
  uGraphicCommon,

  CommonImageDataMoudle,
  EasyServiceCommonMaterialDataMoudle,

  FMX.Controls.Presentation, FMX.Edit, uSkinFireMonkeyEdit,
  uSkinFireMonkeyScrollBoxContent,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyScrollBox, uSkinFireMonkeyButton,
  uSkinFireMonkeyControl, uSkinFireMonkeyPanel, uSkinScrollBoxContentType,
  uSkinScrollControlType, uSkinScrollBoxType, uSkinButtonType, uBaseSkinControl,
  uSkinPanelType, uSkinRadioButtonType, uSkinFireMonkeyRadioButton,
  uSkinCheckBoxType, uSkinFireMonkeyCheckBox;

type
  TFrameChangeTheme = class(TFrame)//,IFrameVirtualKeyboardAutoProcessEvent)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    btnConfirm: TSkinFMXButton;
    pnlContainer: TSkinFMXPanel;
    sbClient: TSkinFMXScrollBox;
    sbcClient: TSkinFMXScrollBoxContent;
    SkinFMXPanel2: TSkinFMXPanel;
    edtOldPass: TSkinFMXEdit;
    SkinFMXPanel6: TSkinFMXPanel;
    chkBox: TSkinFMXCheckBox;
    rbtnBlue: TSkinFMXRadioButton;
    rbtnGolden: TSkinFMXRadioButton;
    rbtnGreen: TSkinFMXRadioButton;
    rbtnOrange: TSkinFMXRadioButton;
    rbtnPurple: TSkinFMXRadioButton;
    rbtnPink: TSkinFMXRadioButton;
    rbtnRed: TSkinFMXRadioButton;
    rbtnBlack: TSkinFMXRadioButton;
    procedure btnReturnClick(Sender: TObject);
    procedure rbtnBlueChange(Sender: TObject);
    procedure rbtnGoldenChange(Sender: TObject);
    procedure rbtnGreenChange(Sender: TObject);
    procedure rbtnOrangeChange(Sender: TObject);
    procedure rbtnPinkChange(Sender: TObject);
    procedure rbtnPurpleChange(Sender: TObject);
    procedure rbtnRedChange(Sender: TObject);
    procedure rbtnBlackChange(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
  public
    FmyIniFile: TIniFile;

    // 当前主题和主题色
    FAppTheme: string;
    FAppThemeColor: string;

    procedure Load;

    //加载和更新配置
    function CustomLoadFromINI: Boolean;
    function CustomSaveToINI(AappTheme:string;AappThemeColor:string): Boolean;
    // 更新主题色状态
    procedure SyncThemeState;
    { Public declarations }
  end;

var
  GlobalChangeThemeFrame:TFrameChangeTheme;

implementation

//uses
//  MainForm,
//  LoginFrame;

{$R *.fmx}

constructor TFrameChangeTheme.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TFrameChangeTheme.Load;
begin
  // 从配置文件读取当前主题
  CustomLoadFromINI;
  SyncThemeState;
end;

procedure TFrameChangeTheme.btnReturnClick(Sender: TObject);
begin
  HideFrame;
  ReturnFrame;
end;

function TFrameChangeTheme.CustomLoadFromINI: Boolean;
var
  AappTheme: String;
//  AappThemeColor: String;
begin

  try

    FmyIniFile := TIniFile.Create(GetApplicationPath + 'Config.ini');
    AappTheme := FmyIniFile.ReadString('', 'appTheme', '');
//    AappThemeColor := FmyIniFile.ReadString('', 'appThemeColor', '');

    if AappTheme = '' then
    begin
      FAppTheme:= '海军蓝';
//      FAppThemeColor:= '$FF3478F5';
    end
    else
    begin
      FAppTheme:= AappTheme;
//      FAppThemeColor:= AappThemeColor;
    end;

  finally
    FmyIniFile.Free;
  end;
  Result:=True;

end;

function TFrameChangeTheme.CustomSaveToINI(AappTheme: string; AappThemeColor: string): Boolean;
begin

  try
    FmyIniFile := TIniFile.Create(GetApplicationPath + 'Config.ini');
    FmyIniFile.WriteString('', 'appTheme', AappTheme);
    FmyIniFile.WriteString('', 'appThemeColor', AappThemeColor);
  finally
    FmyIniFile.Free;
  end;
  Result:=True;

end;

// 同步主题选中状态
procedure TFrameChangeTheme.SyncThemeState;
begin

  if FAppTheme = '海军蓝' then
    Self.rbtnBlue.Properties.Checked:= True
  else if FAppTheme = '土豪金' then
    Self.rbtnGolden.Properties.Checked:= True
  else if FAppTheme = '原谅绿' then
    Self.rbtnGreen.Properties.Checked:= True
  else if FAppTheme = '火绒橙' then
    Self.rbtnOrange.Properties.Checked:= True
  else if FAppTheme = '猛男粉' then
    Self.rbtnPink.Properties.Checked:= True
  else if FAppTheme = '基佬紫' then
    Self.rbtnPurple.Properties.Checked:= True
  else if FAppTheme = '夕阳红' then
    Self.rbtnRed.Properties.Checked:= True
  else if FAppTheme = '暗夜黑' then
    Self.rbtnBlack.Properties.Checked:= True;

end;

// 海军蓝
procedure TFrameChangeTheme.rbtnBlueChange(Sender: TObject);
begin
  dmCommonImageDataMoudle.SkinTheme1.NavigationBarColor:= $FF3478F5;
  dmCommonImageDataMoudle.SkinTheme1.SkinThemeColor:= $FF3478F5;
  CustomSaveToINI(rbtnBlue.Caption, ColorToWebHex($FF3478F5));
end;

// 土豪金
procedure TFrameChangeTheme.rbtnGoldenChange(Sender: TObject);
begin
  dmCommonImageDataMoudle.SkinTheme1.NavigationBarColor:= $FFD1BC89;
  dmCommonImageDataMoudle.SkinTheme1.SkinThemeColor:= $FFD1BC89;
  CustomSaveToINI(rbtnGolden.Caption, ColorToWebHex($FFD1BC89));
end;

// 原谅绿
procedure TFrameChangeTheme.rbtnGreenChange(Sender: TObject);
begin
  dmCommonImageDataMoudle.SkinTheme1.NavigationBarColor:= $FF11B29F;
  dmCommonImageDataMoudle.SkinTheme1.SkinThemeColor:= $FF11B29F;
  CustomSaveToINI(rbtnGreen.Caption, ColorToWebHex($FF11B29F));
end;

// 火绒橙
procedure TFrameChangeTheme.rbtnOrangeChange(Sender: TObject);
begin
  dmCommonImageDataMoudle.SkinTheme1.NavigationBarColor:= $FFFFA924;
  dmCommonImageDataMoudle.SkinTheme1.SkinThemeColor:= $FFFFA924;
  CustomSaveToINI(rbtnOrange.Caption, ColorToWebHex($FFFFA924));
end;

// 猛男粉
procedure TFrameChangeTheme.rbtnPinkChange(Sender: TObject);
begin
  dmCommonImageDataMoudle.SkinTheme1.NavigationBarColor:= $FFF45FA1;
  dmCommonImageDataMoudle.SkinTheme1.SkinThemeColor:= $FFF45FA1;
  CustomSaveToINI(rbtnPink.Caption, ColorToWebHex($FFF45FA1));
end;

// 基佬紫
procedure TFrameChangeTheme.rbtnPurpleChange(Sender: TObject);
begin
  dmCommonImageDataMoudle.SkinTheme1.NavigationBarColor:= $FF9823AA;
  dmCommonImageDataMoudle.SkinTheme1.SkinThemeColor:= $FF9823AA;
  CustomSaveToINI(rbtnPurple.Caption, ColorToWebHex($FF9823AA));
end;

// 夕阳红
procedure TFrameChangeTheme.rbtnRedChange(Sender: TObject);
begin
  dmCommonImageDataMoudle.SkinTheme1.NavigationBarColor:= $FFE13D3B;
  dmCommonImageDataMoudle.SkinTheme1.SkinThemeColor:= $FFE13D3B;
  CustomSaveToINI(rbtnRed.Caption, ColorToWebHex($FFE13D3B));
end;

// 暗夜黑
procedure TFrameChangeTheme.rbtnBlackChange(Sender: TObject);
begin
  dmCommonImageDataMoudle.SkinTheme1.NavigationBarColor:= $FF2D2F32;
  dmCommonImageDataMoudle.SkinTheme1.SkinThemeColor:= $FF2D2F32;
  CustomSaveToINI(rbtnBlack.Caption, ColorToWebHex($FF2D2F32));
end;

end.

