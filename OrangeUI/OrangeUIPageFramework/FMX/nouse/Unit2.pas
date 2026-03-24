unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  uDrawParam,
  uDrawTextParam,
  uDrawRectParam,
  uDrawPathParam,
  uDrawLineParam,
  uDrawPictureParam,
  uSkinSuperObject,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
  ADrawParam:TDrawParam;
  AJsonStr:String;
begin
  ADrawParam:=TDrawParam.Create('','');
  try
    AJsonStr:=ADrawParam.SaveToJson;
    ADrawParam.LoadFromJson(AJsonStr);
    Self.Memo1.Text:=AJsonStr;
  finally
    FreeAndNil(ADrawParam);
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  ASuperObject:ISuperObject;
begin
  ASuperObject:=TSuperObject.Create('{"name":"张三", "other":["中国","程序员"]}');
  ShowMessage(ASuperObject.S['name']);

  ASuperObject.S['a']:='b';
  ASuperObject.B['b']:=True;
  ASuperObject.I['c']:=100;
  ASuperObject.F['d']:=3.14;

  ShowMessage(ASuperObject.AsJson);



  ASuperObject.S['a']:='c';
  ASuperObject.B['b']:=False;
  ASuperObject.I['c']:=200;
  ASuperObject.F['d']:=4.14;

  ShowMessage(ASuperObject.AsJson);


  ASuperObject:=nil;

end;

procedure TForm2.Button3Click(Sender: TObject);
var
  ADrawParam:TDrawTextParam;
  AJsonStr:String;
begin
  ADrawParam:=TDrawTextParam.Create('','');
  try
    AJsonStr:=ADrawParam.SaveToJson;
    ADrawParam.LoadFromJson(AJsonStr);
    Self.Memo1.Text:=AJsonStr;
  finally
    FreeAndNil(ADrawParam);
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
var
  ADrawParam:TDrawPictureParam;
  AJsonStr:String;
begin
  ADrawParam:=TDrawPictureParam.Create('','');
  try
    AJsonStr:=ADrawParam.SaveToJson;
    ADrawParam.LoadFromJson(AJsonStr);
    Self.Memo1.Text:=AJsonStr;
  finally
    FreeAndNil(ADrawParam);
  end;
end;

procedure TForm2.Button5Click(Sender: TObject);
var
  ADrawParam:TDrawRectParam;
  AJsonStr:String;
begin
  ADrawParam:=TDrawRectParam.Create('','');
  try
    AJsonStr:=ADrawParam.SaveToJson;
    ADrawParam.LoadFromJson(AJsonStr);
    Self.Memo1.Text:=AJsonStr;
  finally
    FreeAndNil(ADrawParam);
  end;
end;

procedure TForm2.Button6Click(Sender: TObject);
var
  ADrawParam:TDrawLineParam;
  AJsonStr:String;
begin
  ADrawParam:=TDrawLineParam.Create('','');
  try
    AJsonStr:=ADrawParam.SaveToJson;
    ADrawParam.LoadFromJson(AJsonStr);
    Self.Memo1.Text:=AJsonStr;
  finally
    FreeAndNil(ADrawParam);
  end;
end;

procedure TForm2.Button7Click(Sender: TObject);
var
  ADrawParam:TDrawPathParam;
  AJsonStr:String;
begin
  ADrawParam:=TDrawPathParam.Create('','');
  try
    AJsonStr:=ADrawParam.SaveToJson;
    ADrawParam.LoadFromJson(AJsonStr);
    Self.Memo1.Text:=AJsonStr;
  finally
    FreeAndNil(ADrawParam);
  end;
end;

end.
