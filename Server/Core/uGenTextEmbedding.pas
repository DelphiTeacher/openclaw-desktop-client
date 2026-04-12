//convert pas to utf8 by ¥
unit uGenTextEmbedding;

interface


uses
  Classes,
  SysUtils,

//  XSuperObject,
  System.JSON,
  XSuperObject,

  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;



type
  TEmbeddingUsage = record
    PromptTokens: Integer;
    TotalTokens: Integer;
  end;

  TEmbeddingData = record
    Index: Integer;
    &Object: string;
    Embedding: TArray<Double>;
  end;

  TEmbeddingResponse = record
    &Object: string;
    Model: string;
    ID: string;
    Usage: TEmbeddingUsage;
    Data: TArray<TEmbeddingData>;

    function FromJSON(const JSONStr: string): Boolean;
    procedure Clear;
  end;


function GetTextEmbedding(NetHTTPClient1:TNetHTTPClient;AText:String;AAPIKey:String):TEmbeddingResponse;
//function getDoubleArrayStr(AValues:TArray<Double>):String;

function DoubleArrayToString(const DoubleArray: TArray<Double>): string;
function DoubleArrayToJsonArray(const DoubleArray: TArray<Double>): ISuperArray;
function DoubleJsonArrayToString(const DoubleArray: ISuperArray): string;
function DoubleJsonArrayToArray(const DoubleArray: ISuperArray): TArray<Double>;

function CosineSimilarity(const Vec1, Vec2: array of Double): Double;




implementation


//uses
//  System.SysUtils, System.Types;

function DoubleArrayToString(const DoubleArray: TArray<Double>): string;
var
  i: Integer;
  StrList: TStringList;
begin
  StrList := TStringList.Create;
  try
    // �������鲢��ÿ��Ԫ��ת��Ϊ�ַ���
    for i := 0 to High(DoubleArray) do
    begin
      StrList.Add(FloatToStr(DoubleArray[i]));  // ��ÿ��Ԫ��ת��Ϊ�ַ���
    end;

    // ���ַ����б����ӳ�һ���Զ��ŷָ����ַ���
    Result := StrList.CommaText;
  finally
    StrList.Free;
  end;
end;

function DoubleArrayToJsonArray(const DoubleArray: TArray<Double>): ISuperArray;
var
  i: Integer;
begin
  Result := SA();
  // �������鲢��ÿ��Ԫ��ת��Ϊ�ַ���
  for i := 0 to High(DoubleArray) do
  begin
    Result.F[I]:=DoubleArray[i];  // ��ÿ��Ԫ��ת��Ϊ�ַ���
  end;

end;

function DoubleJsonArrayToString(const DoubleArray: ISuperArray): string;
var
  i: Integer;
  StrList: TStringList;
begin
  StrList := TStringList.Create;
  try
    // �������鲢��ÿ��Ԫ��ת��Ϊ�ַ���
    for i := 0 to DoubleArray.Length-1 do
    begin
      StrList.Add(FloatToStr(DoubleArray.F[i]));  // ��ÿ��Ԫ��ת��Ϊ�ַ���
    end;

    // ���ַ����б����ӳ�һ���Զ��ŷָ����ַ���
    Result := StrList.CommaText;
  finally
    StrList.Free;
  end;
end;

function DoubleJsonArrayToArray(const DoubleArray: ISuperArray): TArray<Double>;
var
  i: Integer;
begin
  SetLength(Result,DoubleArray.Length);
  // �������鲢��ÿ��Ԫ��ת��Ϊ�ַ���
  for i := 0 to DoubleArray.Length-1 do
  begin
    Result[i]:=DoubleArray.F[i];  // ��ÿ��Ԫ��ת��Ϊ�ַ���
  end;

end;


{ TEmbeddingResponse }

function TEmbeddingResponse.FromJSON(const JSONStr: string): Boolean;
var
  JSONValue: TJSONValue;
  RootObj: TJSONObject;
  DataArray: TJSONArray;
  DataObj: TJSONObject;
  EmbeddingArray: TJSONArray;
  I, J: Integer;
begin
  Result := False;
  Clear;

  try
    JSONValue := TJSONObject.ParseJSONValue(JSONStr);
    if not Assigned(JSONValue) then Exit;

    try
      if not (JSONValue is TJSONObject) then Exit;

      RootObj := JSONValue as TJSONObject;

      // ����������Ϣ
      &Object := RootObj.GetValue<string>('object', '');
      Model := RootObj.GetValue<string>('model', '');
      ID := RootObj.GetValue<string>('id', '');

      // ����usage��Ϣ
      if RootObj.TryGetValue<TJSONObject>('usage', DataObj) then
      begin
        Usage.PromptTokens := DataObj.GetValue<Integer>('prompt_tokens', 0);
        Usage.TotalTokens := DataObj.GetValue<Integer>('total_tokens', 0);
      end;

      // ������������
      if RootObj.TryGetValue<TJSONArray>('data', DataArray) then
      begin
        SetLength(Data, DataArray.Count);

        for I := 0 to DataArray.Count - 1 do
        begin
          DataObj := DataArray.Items[I] as TJSONObject;

          // ����ÿ��Ƕ������
          Data[I].Index := DataObj.GetValue<Integer>('index', 0);
          Data[I].&Object := DataObj.GetValue<string>('object', '');

          // ������������
          if DataObj.TryGetValue<TJSONArray>('embedding', EmbeddingArray) then
          begin

            SetLength(Data[I].Embedding, EmbeddingArray.Count);
            for J := 0 to EmbeddingArray.Count - 1 do
            begin
              Data[I].Embedding[J] :=
                (EmbeddingArray.Items[J] as TJSONNumber).AsDouble;
            end;
          end;

        end;
      end;

      Result := True;

    finally
      JSONValue.Free;
    end;

  except
    on E: Exception do
    begin
      // ��¼��������쳣
//      OutputDebugString(PChar('JSON��������: ' + E.Message));
      Clear;
    end;
  end;
end;

procedure TEmbeddingResponse.Clear;
begin
  &Object := '';
  Model := '';
  ID := '';
  Usage.PromptTokens := 0;
  Usage.TotalTokens := 0;
  SetLength(Data, 0);
end;

function CosineSimilarity(const Vec1, Vec2: array of Double): Double;
var
  i: Integer;
  dotProduct, norm1, norm2: Double;
begin
  if Length(Vec1) <> Length(Vec2) then
    raise Exception.Create('Vectors must have the same length');

  dotProduct := 0.0;
  norm1 := 0.0;
  norm2 := 0.0;

  for i := 0 to High(Vec1) do
  begin
    dotProduct := dotProduct + Vec1[i] * Vec2[i];
    norm1 := norm1 + Sqr(Vec1[i]);
    norm2 := norm2 + Sqr(Vec2[i]);
  end;

  norm1 := Sqrt(norm1);
  norm2 := Sqrt(norm2);

  if (norm1 = 0) or (norm2 = 0) then
    Result := 0
  else
    Result := Round(dotProduct / (norm1 * norm2)*100)/100;
end;
//
////�����������������ƶ�
//function CosineSimilarity(const Vec1, Vec2: ISuperArray): Double;
//var
//  i: Integer;
//  dotProduct, norm1, norm2: Double;
//begin
//  if Vec1.length <> Vec2.Length then
//    raise Exception.Create('Vectors must have the same length');
//
//  dotProduct := 0.0;
//  norm1 := 0.0;
//  norm2 := 0.0;
//
//  for i := 0 to Vec1.Length-1 do
//  begin
//    dotProduct := dotProduct + Vec1.F[i] * Vec2.F[i];
//    norm1 := norm1 + Sqr(Vec1.F[i]);
//    norm2 := norm2 + Sqr(Vec2.F[i]);
//  end;
//
//  norm1 := Sqrt(norm1);
//  norm2 := Sqrt(norm2);
//
//  if (norm1 = 0) or (norm2 = 0) then
//    Result := 0
//  else
//    Result := dotProduct / (norm1 * norm2);
//end;


function GetTextEmbedding(NetHTTPClient1:TNetHTTPClient;AText:String;AAPIKey:String):TEmbeddingResponse;
var
  ARequest1Stream:TStringStream;
  AResponse1Stream:TStringStream;
//  APostJson:ISuperObject;
  AJSONObject: TJSONObject;
  AHeaders: TNetHeaders;
begin
  FillChar(Result, SizeOf(Result), 0);

//  APostJson:=SO();
//  APostJson.S['model']:='text-embedding-v3';
//  APostJson.S['input']:=AText;
//  ARequest1Stream:=TStringStream.Create(APostJson.AsJSON(),TEncoding.UTF8);


  AJSONObject := TJSONObject.Create;
  AJSONObject.AddPair('model','text-embedding-v3');
  AJSONObject.AddPair('input',AText);




  ARequest1Stream:=TStringStream.Create(AJSONObject.ToJSON(),TEncoding.UTF8);



  SetLength(AHeaders,2);
  AHeaders[0].Name:='Content-Type';
  AHeaders[0].Value:='application/json';
  AHeaders[1].Name:='Authorization';
//  AHeaders[1].Value:='Bearer sk-fcc2c19aa30f473f9c39b57b1fa3af84';
  AHeaders[1].Value:='Bearer '+AAPIKey;



  AResponse1Stream:=TStringStream.Create('',TEncoding.UTF8);
  try

    NetHTTPClient1.Post('https://dashscope.aliyuncs.com/compatible-mode/v1/embeddings',ARequest1Stream,AResponse1Stream,AHeaders);


    if Length(AText)<4 then
    begin
      AResponse1Stream.SaveToFile('D:\'+AText+'.json');
    end;



    Result.FromJSON(AResponse1Stream.DataString);
  finally
    ARequest1Stream.Free;
    AResponse1Stream.Free;
  end;
end;




//function getDoubleArrayStr(AValues:TArray<Double>):String;
//var
//  I: Integer;
//begin
//  for I := Low to High do
//  begin
//
//  end;
//end;



end.
