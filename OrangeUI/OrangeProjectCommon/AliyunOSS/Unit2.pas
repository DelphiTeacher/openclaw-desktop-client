unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ALIOSS,
  ALIOSSUTIL,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  AAliOssFileSystem:TAliOssFileSystem;
  AStringStream:TStringStream;
  AContent:String;
  string_to_sign:String;
  signature:String;
begin
  //测试签名
//  string_to_sign:='PUT'+#10#10#10'Wed, 28 Dec 2022 09:56:32 GMT\n x-oss-meta-magic:abracadabra\nx-oss-meta-author:alice\n/examplebucket/nelson';
//  signature := Base64Encode(EncryptHMACSha1(string_to_sign, '*******'));
  //****BXZE5Hleb/2****


  //阿里云OSS文档https://help.aliyun.com/document_detail/375247.html?spm=a2c4g.375302.0.0
//  AAliOssFileSystem:=TAliOssFileSystem.Create('*****',
//                                              '*****',
//                                              'oss-cn-hangzhou.aliyuncs.com',
//                                              False,
//                                              False
//                                              );
//
//  AAliOssFileSystem.ChangeVolumn('orangeui');
//  AStringStream:=TStringStream.Create('Hello '+DateTimeToStr(Now),TEncoding.UTF8);
//  AStringStream.Position:=0;
//  AAliOssFileSystem.WriteFile('aa.txt',AStringStream);
//  AStringStream.Free;




//  AAliOssFileSystem:=TAliOssFileSystem.Create('****',
//                                              '****',
//                                              'oss-cn-hangzhou.aliyuncs.com',
//                                              False,
//                                              True
//                                              );
//
//  AAliOssFileSystem.oss.enable_domain_style:=True;
//  AAliOssFileSystem.ChangeVolumn('whatsappchats1');
//  AStringStream:=TStringStream.Create('Hello',TEncoding.UTF8);
//  AStringStream.Position:=0;
//  AAliOssFileSystem.WriteFile('a.txt',AStringStream);
//  AStringStream.Free;
//  AAliOssFileSystem.ReadFile('a.txt',AContent);
//  ShowMessage(AContent);
//  Exit;



//  AAliOssFileSystem:=TAliOssFileSystem.Create(
//                                              '****',
//                                              '********',
//                                              'oss-cn-hangzhou.aliyuncs.com',
//                                              False,
//                                              True,
//                                              'CAIS***R5/Ymee1+JhTU3RLd5m5zekzz2'
//                                              +'IH1MenRgBOwXs/Q+lWhY7/sclqFzVphGSEbNapP7czTnN0TzDbDasumZ'
//                                              +'sJYm6vT8a0XxZjf/2MjNGZabKPrWZvaqbX3diyZ32sGUXD6+XlujQ/b'
//                                              +'r4NwdGbZxZASjaidcD9p7PxZrrNRgVUHcLvGwKBXn8AGyZQhKwlMt1Do'
//                                              +'ltPzhnZfMsUCB3QLAp7VL99irEP+NdNJxOZpzadCx0dFte7DJuCwqsE'
//                                              +'USqvom0fAVpGeW74nNWgQP+WaPN+vF79toNxRlYas3HaFJqvXmnOF/oP'
//                                              +'bUk4nnPtzGzGbpgE8agAF3Q5xB1SVPLPBrX/4Je4uYyf2lKr5UTfpnqH'
//                                              +'xm7Xzl+wbdj0IgDDAAsgMYJ68CSksL909JRt1UR7etTF+kxVO5qZdlV/'
//                                              +'ajve+kgcNFXTj5ZTvGqjfURw05doNbM8FDDC8TWhLaJRcnW6VHISdsd'
//                                              +'nYHtfllqxX37MrLgSi4whnfkA=='
//                                              );
//  //bucket已经在域名中了，不需要再调用
//  AAliOssFileSystem.oss.enable_domain_style:=True;
//  AAliOssFileSystem.ChangeVolumn('whatsappchats1');
//  AStringStream:=TStringStream.Create('Hello',TEncoding.UTF8);
//  AStringStream.Position:=0;
//  AAliOssFileSystem.WriteFile('a.txt',AStringStream);
//  AStringStream.Free;
//
//
//  AAliOssFileSystem.ReadFile('a.txt',AContent);
//  ShowMessage(AContent);
//
//  FreeAndNil(AAliOssFileSystem);



  //https://faceom.oss-us-east-1.aliyuncs.com/fbsearch/a.txt
  AAliOssFileSystem:=TAliOssFileSystem.Create(
                                              '****',
                                              '******',
                                              'oss-us-east-1.aliyuncs.com',
                                              False,
                                              True);
  //bucket已经在域名中了，不需要再调用
  AAliOssFileSystem.oss.enable_domain_style:=True;
  AAliOssFileSystem.ChangeVolumn('faceom');
  AStringStream:=TStringStream.Create('Hello '+DateTimeToStr(Now),TEncoding.UTF8);
  AStringStream.Position:=0;
  AAliOssFileSystem.WriteFile('/fbsearch/a.txt',AStringStream);
  AStringStream.Free;


  AAliOssFileSystem.ReadFile('/fbsearch/a.txt',AContent);
  ShowMessage(AContent);

  FreeAndNil(AAliOssFileSystem);

end;

end.
