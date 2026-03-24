unit Unit16;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,

  uPageStructure,

  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm16 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
  private
    //排列管理,以便表格方式排列表
    FControlList:TFieldControlSettingMapList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form16: TForm16;

implementation

{$R *.dfm}

procedure TForm16.FormCreate(Sender: TObject);
begin

  FControlList:=TFieldControlSettingMapList.Create();
  FControlList.Parent:=Self.Panel1;

  FControlList.LayoutSetting.align_type:=Const_PageAlignType_Auto;
  FControlList.LayoutSetting.col_count:=-1;
  FControlList.LayoutSetting.row_height:=40;
  FControlList.LayoutSetting.row_space:=0;
  FControlList.LayoutSetting.col_width:=100;

end;

end.
