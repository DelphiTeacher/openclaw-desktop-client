//convert pas to utf8 by ¥
unit uDocSplit;

interface

uses
  Classes,
  SysUtils,
  System.RegularExpressions;



//将文档拆分成一句一句
function SplitDocToSentences(ADocString:String):TStringList;
//将文档进行分片
function SplitDoc(ADocString:String;AChunkSize:Integer=512):TStringList;


implementation


function SplitDocToSentences(ADocString:String):TStringList;
var
  Pattern: TRegEx;
  Matches: TMatchCollection;
  i: Integer;
  Sentence: string;
begin
  Result:=TStringList.Create;

  if ADocString = '' then
    Exit;

  Sentence:='';
  for I := 1 to Length(ADocString) do
  begin
    if (ADocString[I]=',') or (ADocString[I]='.') or (ADocString[I]='!') or (ADocString[I]=#10) then
    begin
      Result.Add(Sentence+ADocString[I]);
      Sentence:='';
      continue;
    end;
    Sentence:=Sentence+ADocString[I];
  end;

  // 如果没有匹配到任何句子，返回整个文本
  if (Result.Count = 0) then
  begin
    Result.Add(ADocString);
  end;

end;


function SplitDoc(ADocString:String;AChunkSize:Integer=512):TStringList;
var
  ASentences:TStrings;
  ASumLen:Integer;
  ASumStr:String;
  I: Integer;
begin
  Result:=TStringList.Create;
  ASentences:=SplitDocToSentences(ADocString);

  ASumLen:=0;
  ASumStr:='';
  for I := 0 to ASentences.Count-1 do
  begin
    if ASumLen+Length(ASentences[I])>AChunkSize then
    begin
      Result.Add(ASumStr);
      ASumStr:='';
      ASumLen:=0;
      continue;
    end;
    ASumStr:=ASumStr+ASentences[I];
    ASumLen:=ASumLen+Length(ASentences[I]);

  end;
  if ASumStr<>'' then
  begin
    Result.Add(ASumStr);
  end;

  ASentences.Free;

end;


end.
