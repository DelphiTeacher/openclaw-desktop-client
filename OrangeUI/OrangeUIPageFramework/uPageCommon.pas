unit uPageCommon;

interface
{$IF DEFINED(ANDROID) OR DEFINED(IOS) OR DEFINED(MACOS) }
  {$DEFINE FMX}
{$IFEND}



//请在工程下放置FrameWork.inc
//或者在工程设置中配置FMX编译指令
//才可以正常编译此单元
{$IFNDEF FMX}
  {$IFNDEF VCL}
    {$I FrameWork.inc}
  {$ENDIF}
{$ENDIF}


uses
  SysUtils,
  Classes,

  XSuperObject,

  uFileCommon,
  uFuncCommon;//,
//  uComponentType,
//  uSkinButtonType,
//  uBasePageStructure,
//  uPageStructure;

const
  IID_IPageSavedValue:TGUID='{56154C25-7AB3-4D9A-903D-30CF7A43A86E}';
type

  IPageSavedValue=interface
    ['{56154C25-7AB3-4D9A-903D-30CF7A43A86E}']
    function GetSavedValue:ISuperObject;
  end;


function change_page_file_name(const root_dir, page_fid, old_page_name, new_page_name: String;var ADesc:String):Boolean;


implementation

function change_page_file_name(const root_dir, page_fid, old_page_name, new_page_name: String;var ADesc:String):Boolean;
var
  ACode:Integer;
  ADataJson:ISuperObject;

  AUpdateJson:ISuperObject;

  AProgramDir:String;
  APageFilePath:String;
  ASuperObject:ISuperObject;
begin
  Result:=False;

  try

    AProgramDir:=root_dir;
    APageFilePath:=AProgramDir+old_page_name+PathDelim+old_page_name+'.json';
    if FileExists(APageFilePath) then
    begin
      ASuperObject:=SO(GetStringFromFile(APageFilePath,TEncoding.UTF8));
      ASuperObject.S['name']:=new_page_name;
      SaveStringToFile(ASuperObject.AsJson,APageFilePath,TEncoding.UTF8);
    end;

    //先改文件名
    if FileExists(AProgramDir+old_page_name+PathDelim+old_page_name+'.json') then
    begin
      SysUtils.RenameFile(AProgramDir+old_page_name+PathDelim+old_page_name+'.json',AProgramDir+old_page_name+PathDelim+new_page_name+'.json');
    end;
    if FileExists(AProgramDir+old_page_name+PathDelim+old_page_name+'.py') then
    begin
      SysUtils.RenameFile(AProgramDir+old_page_name+PathDelim+old_page_name+'.py',AProgramDir+old_page_name+PathDelim+new_page_name+'.py');
    end;
    if FileExists(AProgramDir+old_page_name+PathDelim+old_page_name+'.js') then
    begin
      SysUtils.RenameFile(AProgramDir+old_page_name+PathDelim+old_page_name+'.js',AProgramDir+old_page_name+PathDelim+new_page_name+'.js');
    end;

    //更改文件夹的名称,更改脚本文件的名称
    if DirectoryExists(AProgramDir+old_page_name) then
    begin
      SysUtils.RenameFile(AProgramDir+old_page_name,AProgramDir+new_page_name);
    end;

    Result:=True;

  except
    on E:Exception do
    begin
      ADesc:=E.Message;
    end;
  end;

end;


end.

