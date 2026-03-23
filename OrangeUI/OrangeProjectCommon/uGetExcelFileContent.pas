//convert pas to utf8 by ¥
unit uGetExcelFileContent;

interface

uses
   Classes,
   SysUtils,
   Variants,

  Xc12Utils5,
  XLSReadWriteII5,
  XLSSheetData5,
  XLSMergedCells5,


  uFileCommon,
  uFuncCommon,
  uDatasetToJson,

  XSuperObject;



//
function GetExcelFileContent(AExcelFilePath:String;ASheetFormatList:ISuperArray):ISuperArray;overload;
function GetExcelFileContent(AExcelFileStream:TMemoryStream;ASheetFormatList:ISuperArray;AFileName:String):ISuperArray;overload;
function GetExcelFileContent(XLS: TXLSReadWriteII5;ASheetFormatList:ISuperArray):ISuperArray;overload;


//列：值形式
function GetSheetContentColValueArray(ASheet:TXLSWorksheet;AIsSplitMergedCell:Boolean):ISuperArray;
//二维数组的形式
function GetSheetContentArray(ASheet:TXLSWorksheet;AIsSplitMergedCell:Boolean):ISuperArray;


function ConvertSheetJsonToTxt(ASheetJson:ISuperObject):String;

//将所有合并的单元格拆分
function SplitMergedCell(ASheet:TXLSWorksheet):Boolean;



implementation


//将Excel工作表转成的json格式转换为字符串
function ConvertSheetJsonToTxt(ASheetJson:ISuperObject):String;
var
  I: Integer;
  ANameArray:TStringDynArray;
  AValueArray:TVariantDynArray;
  J: Integer;
begin
  Result:='';
  for I := 0 to ASheetJson.A['RecordList'].Length-1 do
  begin
    //键：值
    ConvertJsonToArray(ASheetJson.A['RecordList'].O[I],ANameArray,AValueArray);
    for J := 0 to Length(ANameArray)-1 do
    begin
      Result:=Result+ANameArray[J]+':'+AValueArray[J]+#13#10;
    end;

//    Result:=Result+#13#10+#13#10+#13#10;

    //多少条数据分隔一次
//    if (I mod 10=0) then
//    begin
      Result:=Result+'------------------------------------'#13#10;
//    end;

  end;
end;



//判断单元格是否在合并单元格中
function IsCellInMergedRange(AWorksheet: TXLSWorksheet; ARow, ACol: Integer): Boolean;
var
  i: Integer;
  MergeRange: TXLSMergedCells;
begin
  Result := False; // 默认不在合并单元格内
  MergeRange := AWorksheet.MergedCells;

  // 遍历所有合并单元格
  for i := 0 to MergeRange.Count - 1 do
  begin
    // 检查目标单元格是否在当前合并单元格的范围内
    if (ARow >= MergeRange[i].Row1) and (ARow <= MergeRange[i].Row2) and
       (ACol >= MergeRange[i].Col1) and (ACol <= MergeRange[i].Col2) then
    begin
      Result := True; // 目标单元格在合并单元格内
      Break;
    end;
  end;
end;



function GetMergedCellInfo(AWorksheet: TXLSWorksheet; ARow, ACol: Integer;
   out Value: Variant): Boolean;
var
  i: Integer;
  MergeRange: TXLSMergedCells;
  //out
  StartRow, StartCol, EndRow, EndCol: Integer;
begin
  Result := False; // 默认未找到合并单元格
//  Value := ''; // 初始化值为空

  MergeRange := AWorksheet.MergedCells;

  // 遍历所有合并单元格
  for i := 0 to MergeRange.Count - 1 do
  begin
    if (ARow >= MergeRange[i].Row1) and
       (ARow <= MergeRange[i].Row2) and
       (ACol >= MergeRange[i].Col1) and
       (ACol <= MergeRange[i].Col2) then
    begin
      // 返回合并单元格的范围和值
      StartRow := MergeRange[i].Row1;
      StartCol := MergeRange[i].Col1;
      EndRow := MergeRange[i].Row2;
      EndCol := MergeRange[i].Col2;
      Value := AWorksheet.AsVariant[StartCol,StartRow];
      Result := True;
      Break;
    end;
  end;
end;


procedure SaveWorksheetAsExcel(AWorksheet: TXlsWorksheet; const SaveFileName: string);
var
  XLS: TXLSReadWriteII5;
  ANewSheet:TXLSWorksheet;
begin
  XLS := TXLSReadWriteII5.Create(nil);
//  XLS.Version:= xvExcel97;
  XLS.Version:= xvExcel2007;
  try
    try
      XLS.Filename := SaveFileName;


//      ANewSheet:=XLS.Add;
//      ANewSheet.Assign(AWorksheet);
      XLS.Sheets[0].Name:=AWorksheet.Name;


      // 在工作表中写入数据（可选）
      XLS.Sheets[0].AsString[1, 1] := 'Hello'; // 在第1行第1列写入数据
      XLS.Sheets[0].AsString[1, 2] := 'World'; // 在第1行第2列写入数据


      XLS.Write;

    except

    end;


  finally
    XLS.Free;
  end;
end;

function GetExcelFileContent(XLS: TXLSReadWriteII5;ASheetFormatList:ISuperArray):ISuperArray;
var
  i, J: Integer;
  AText:String;
  ARowIndex:Integer;
//  ASheetCount:Integer;
//  ASheetNames:TStringList;
  ASheetJson:ISuperObject;
  AStartRow,AStartCol:Integer;
begin
  Result:=SA();

//  XLS := TXLSReadWriteII5.Create(nil);
//  ASheetNames:=TStringList.Create;
//  XLS.Version:= xvExcel2007;
//  XLS.Version:= xvExcelUnknown;
//type TExcelVersion = (xvNone,xvExcelUnknown,xvExcel21,xvExcel30,xvExcel40,xvExcel50,xvExcel97,xvExcel2007,xvOffice2007Encrypted);
  try
//      ASheetCount:=XLS.GetSheetNames(AExcelFilePath,ASheetNames);

//      XLS.Filename := AExcelFilePath;
//      XLS.LoadFromFile(AExcelFilePath);
//      XLS.Read;

//      for I := 0 to ASheetCount-1 do
      for I := 0 to XLS.Count -1 do
      begin
          if XLS.Sheets[I].Name='' then
          begin
            Continue;
          end;


          ASheetJson:=SO();
          ASheetJson.S['name']:=XLS.Sheets[I].Name;

          if (ASheetFormatList.O[I].S['format']='col_value') then
          begin
            ASheetJson.S['format']:='col_value';
            ASheetJson.A['RecordList']:=GetSheetContentColValueArray(XLS.Sheets[I],ASheetFormatList.O[I].B['is_split_merged_cell']);
          end
          else
          begin
            ASheetJson.S['format']:='cell_array';
            ASheetJson.A['RecordList']:=GetSheetContentArray(XLS.Sheets[I],ASheetFormatList.O[I].B['is_split_merged_cell']);
          end;


          //获取表格数据的开始行和开始列，使用第一行做为表头

          Result.O[I]:=ASheetJson;


          SaveStringToFile(FormatJson(UTFStrToUnicode(ASheetJson.AsJson)),'D:\KnowledgeGPT\财务审核办法\'+IntToStr(I)+'.'+XLS.Sheets[I].Name+'.json',TEncoding.UTF8);


          //          //将json文件转成txt文件
//          AText:=ConvertSheetJsonToTxt(ASheetJson);
//          SaveStringToFile(AText,ExtractFilePath(AExcelFilePath)+ExtractFileNameNoExt(AExcelFilePath)+'.'+XLS.Sheets[I].Name+'.txt',TEncoding.UTF8);
//
//
//
//          //拆分成单独的一个个文件
//          SaveWorksheetAsExcel(XLS.Sheets[I],ExtractFilePath(AExcelFilePath)+ExtractFileNameNoExt(AExcelFilePath)+'.'+XLS.Sheets[I].Name+'.xls');


      end;

  finally
//    FreeAndNil(ASheetNames);
  end;


end;

function GetExcelFileContent(AExcelFileStream:TMemoryStream;ASheetFormatList:ISuperArray;AFileName:String):ISuperArray;
var
  XLS : TXLSReadWriteII5;
begin

  XLS := TXLSReadWriteII5.Create(nil);
//  ASheetNames:=TStringList.Create;
//  XLS.Version:= xvExcel2007;
  XLS.Version:= xvExcelUnknown;
//type TExcelVersion = (xvNone,xvExcelUnknown,xvExcel21,xvExcel30,xvExcel40,xvExcel50,xvExcel97,xvExcel2007,xvOffice2007Encrypted);
  try
//      ASheetCount:=XLS.GetSheetNames(AExcelFilePath,ASheetNames);

      XLS.LoadFromStream(AExcelFileStream);

//      SysUtils.ForceDirectories(GetApplicationPath);
//      AExcelFileStream.Position:=0;
//      AExcelFileStream.SaveToFile(GetApplicationPath+AFileName);
//      XLS.LoadFromFile(GetApplicationPath+AFileName);


      Result:=GetExcelFileContent(XLS,ASheetFormatList);
  finally
    XLS.Free;
  end;
end;

function GetExcelFileContent(AExcelFilePath:String;ASheetFormatList:ISuperArray):ISuperArray;
var
  XLS : TXLSReadWriteII5;
begin

  XLS := TXLSReadWriteII5.Create(nil);
//  ASheetNames:=TStringList.Create;
//  XLS.Version:= xvExcel2007;
  XLS.Version:= xvExcelUnknown;
//type TExcelVersion = (xvNone,xvExcelUnknown,xvExcel21,xvExcel30,xvExcel40,xvExcel50,xvExcel97,xvExcel2007,xvOffice2007Encrypted);
  try
//      ASheetCount:=XLS.GetSheetNames(AExcelFilePath,ASheetNames);

      XLS.Filename := AExcelFilePath;
      XLS.LoadFromFile(AExcelFilePath);
      XLS.Read;

      Result:=GetExcelFileContent(XLS,ASheetFormatList);
  finally
    XLS.Free;
  end;

end;

function GetFirstDataRowCol(AWorksheet: TXLSWorksheet;var AStartRow:Integer;var AStartCol:Integer): Boolean;
var
  i, j: Integer;
  HasData: Boolean;
begin
  AStartRow := -1; // 初始化为-1，表示未找到有数据的行
  AStartCol := -1;
  for i := 0 to AWorksheet.LastRow do // 遍历每一行
  begin
    HasData := False;
    for j := 0 to AWorksheet.LastCol do // 遍历每一列
    begin
      if AWorksheet.AsString[i, j]<>'' then // 检查单元格是否有数据
      begin
        HasData := True;
        Break;
      end;
    end;
    if HasData then
    begin
      AStartRow := i; // 找到有数据的行
      AStartCol := j;
      Break;
    end;
  end;
  Result:=HasData;
end;



function GetSheetContentColValueArray(ASheet:TXLSWorksheet;AIsSplitMergedCell:Boolean):ISuperArray;
var
  AStartRow,AStartCol:Integer;
  I,J: Integer;
//  ARecordList:ISuperArray;
  ARecordJson:ISuperObject;
  ACellValue:Variant;
begin
  Result:=SA();
//  Result.S['name']:=ASheet.Name;

  if not GetFirstDataRowCol(ASheet,AStartRow,AStartCol) then
  begin
    Exit;
  end;


//  GetMergedCellInfo(ASheet,13,4,ACellValue);

//  ARecordList:=SA();
  for I := AStartRow+1 to ASheet.LastRow do
  begin
    ARecordJson:=SO();
    //将第一行做为标题
    for J := AStartCol to ASheet.LastCol do
    begin
      try
        //判断是不是合并单元格，我觉得这个对速度影响还是蛮大的
        if AIsSplitMergedCell and GetMergedCellInfo(ASheet,I,J,ACellValue) then
        begin
          ARecordJson.S[ASheet.AsString[J,AStartRow]] := ACellValue;
        end
        else
        begin
          ARecordJson.S[ASheet.AsString[J,AStartRow]] := ASheet.AsString[J,I];
        end;
      except

      end;

    end;
//    ARecordList.O[ARecordList.Length]:=ARecordJson;
    Result.O[Result.Length]:=ARecordJson;
  end;

//  Result.A['RecordList']:=ARecordList;

end;


//将所有合并的单元格拆分
function SplitMergedCell(ASheet:TXLSWorksheet):Boolean;
var
  AStartRow,AStartCol:Integer;
  I,J: Integer;
  ACellValue:Variant;
begin

//  Result.S['name']:=ASheet.Name;

  if not GetFirstDataRowCol(ASheet,AStartRow,AStartCol) then
  begin
    Exit;
  end;


//  GetMergedCellInfo(ASheet,13,4,ACellValue);

//  ARecordList:=SA();
  for I := AStartRow+1 to ASheet.LastRow do
  begin
    //将第一行做为标题
    for J := AStartCol to ASheet.LastCol do
    begin
      try
        //判断是不是合并单元格，我觉得这个对速度影响还是蛮大的
        if GetMergedCellInfo(ASheet,I,J,ACellValue) then
        begin
          ASheet.AsVariant[J,I]:=ACellValue;
        end;
      except

      end;

    end;
  end;


  // 删除所有的合并单元格
  ASheet.MergedCells.Clear;

end;


function GetSheetContentArray(ASheet:TXLSWorksheet;AIsSplitMergedCell:Boolean):ISuperArray;
var
  AStartRow,AStartCol:Integer;
  I,J: Integer;
//  ARecordList:ISuperArray;
//  ARecordJson:ISuperObject;
  ACellValue:Variant;
  AValueArray:ISuperArray;
begin
  Result:=SA();
//  Result.S['name']:=ASheet.Name;

  if not GetFirstDataRowCol(ASheet,AStartRow,AStartCol) then
  begin
    Exit;
  end;


//  GetMergedCellInfo(ASheet,13,4,ACellValue);

//  ARecordList:=SA();
  for I := AStartRow+1 to ASheet.LastRow do
  begin
    AValueArray:=SA();
    //将第一行做为标题
    for J := AStartCol to ASheet.LastCol do
    begin
      try
        //判断是不是合并单元格，我觉得这个对速度影响还是蛮大的
        if AIsSplitMergedCell and GetMergedCellInfo(ASheet,I,J,ACellValue) then
        begin
          AValueArray.S[J-AStartCol] := ACellValue;
        end
        else
        begin
          AValueArray.S[J-AStartCol] := ASheet.AsString[J,I];
        end;
      except

      end;

    end;
    Result.A[Result.Length]:=AValueArray;
  end;

//  Result.A['RecordList']:=ARecordList;

end;




end.
