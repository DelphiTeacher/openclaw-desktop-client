unit uSQLUpgradeItem;

interface

uses
  Classes,
  uBaseList,
  uBaseLog;

type
  //数据库脚本更新项
  TSQLUpgradeItem = class
    //版本号,日期
    ver: String;
    desc: String;
    SQL: string;
    SqliteSQL: string;
    SQLServerSQL: string;
    MysqlSQL: string;
  end;

  TSQLUpgradeList=class(TBaseList)
  private
    function GetItem(Index: Integer): TSQLUpgradeItem;
  public
    property Items[Index:Integer]:TSQLUpgradeItem read GetItem;default;
  end;


implementation


{ TSQLUpgradeList }

function TSQLUpgradeList.GetItem(Index: Integer): TSQLUpgradeItem;
begin
  Result:=TSQLUpgradeItem(Inherited Items[Index]);
end;

end.
