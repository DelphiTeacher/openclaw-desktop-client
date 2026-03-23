unit uRestIntfDataSource;

interface


uses
  SysUtils,
  {$IFDEF FMX}
  FMX.Controls,
  FMX.Types,
  {$ENDIF}

  {$IFDEF SKIN_SUPEROBJECT}
  uSkinSuperObject,
  {$ELSE}
  XSuperObject,
  XSuperJson,
  {$ENDIF}

  Classes,
  uBaseList,
  uBaseLog,
  IniFiles,
  Variants,
  DB,
  uFuncCommon,
//  uBaseDBHelper,
  uFileCommon,
  uBaseHttpControl,
  uDatasetToJson_Copy,
  uRestInterfaceCall_Copy,
//  uPageStructure,
  uComponentType,
  uPageFrameworkDataSource,
//  uManager,
//  uOpenClientCommon,
//  uRestInterfaceCall,
  uRestConnection,
  uBaseDBDataSource;



type
  //请求的参数键值对
  TRestIntfParam=class(TCollectionItem)
  private
    FName:String;
    FValue:String;
//    FVariable:String;
  protected
    //设置CollectionItem设计时显示的名称
    function GetDisplayName: string; override;
    procedure SetDisplayName(const Value: string); override;
  public
    function GetRealValue:String;
  published
    property Name:String read FName write FName;
    property Value:String read FValue write FValue;
//    property Variable:String read FVariable write FVariable stored False;
  end;


  //参数列表
  TRestIntfParams=class(TCollection)
  private
    function GetItem(Index: Integer): TRestIntfParam;
    function GetXMLPackage: String;
  public
    //需要按照名字顺序排序,如果名字相同,那要根据值来排序,生成的签名才是有用的
    procedure Sort;
//    //生成XML,微信需要使用
//    function GetXMLPackage:String;
    //生成需要签名的串
    function GetQueryParamsStr(
                              HasRefChar:Boolean=True;//是否需要引号
                              NeedUrlEncode:Boolean=False;//是否需要UrlEncode
                              SpaceCharReplace:String='20%'
                              ):String;
//    function GetSignQueryParamsStr:String;
    //添加一对键值
    procedure Add(const AName:String;const AValue:Variant);overload;

    constructor Create;
  public
    function GetNameArray:TStringDynArray;
    function GetValueArray:TVariantDynArray;
    function FindItemByName(AName:String):TRestIntfParam;
    function ItemValueByName(AName:String):String;
    property Items[Index:Integer]:TRestIntfParam read GetItem;default;
  end;



  TParamsDataSource=class(TBindDataSource)
  private
    FParams: TRestIntfParams;
    procedure SetParams(const Value: TRestIntfParams);
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    function GetValueByBindItemField(AParamName:String):Variant;override;
    procedure SetValue(AParamName:String;AValue:Variant);override;
  published
    //Params
    property Params:TRestIntfParams read FParams write SetParams;
  end;



  //数据库查询源，内部其实是一个Json数组
  TRestIntfDataSource=class(TJsonBindDataSource)
  private
    FConnection: TRestConnection;
    FHttpMethod: String;
    FParams: TRestIntfParams;
    FIntfUrl: String;
    procedure SetConnection(const Value: TRestConnection);
    procedure SetParams(const Value: TRestIntfParams);
  public
    function CanOpen:Boolean;override;
    function DoOpen():Boolean;override;

    //获取字段列表,绑定的时候需要供用户选择
    function GetFieldDefList(ABindItemFieldName:String):TFieldDefs;override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    //这是最后加载的,比Active晚,ResolveReference时
    property Connection:TRestConnection read FConnection write SetConnection;
    //接口名称
    property IntfUrl:String read FIntfUrl write FIntfUrl;
    //Get还是Post
    property HttpMethod:String read FHttpMethod write FHttpMethod;
    //Params
    property Params:TRestIntfParams read FParams write SetParams;
    //Headers
    //Body

    property Active:Boolean read FActive write SetActive;
  end;


function GetUrlQueryParameterValue(URL:String;HasWWW:Boolean;AParamName:String):String;
function ParseUrlQueryParameters(URL:String;HasWWW:Boolean=True):TRestIntfParams;

//function GetMimeType(AFileName:String):String;overload;
//function GetMimeType(AContent:TStream):String;overload;
function GenerateUrl(
                    AParamNames:Array of String;
                    AParamValues:Array of Variant
                    ):String;

function FuncUrlEncode(const S : String;SpaceCharReplace:String='20%') : String;overload;


implementation

function _IntToHex(Value: Integer; Digits: Integer): String;
begin
  Result := SysUtils.IntToHex(Value, Digits);
end;

function FuncUrlEncode(const S : String;SpaceCharReplace:String='20%') : String;
var
  I : Integer;
  Ch : Char;
begin
  Result := '';
  for I := LowStr(S) to HighStr(S) do begin
      Ch := S[I];
      if ((Ch >= '0') and (Ch <= '9')) or
         ((Ch >= 'a') and (Ch <= 'z')) or
         ((Ch >= 'A') and (Ch <= 'Z')) or
         (Ch = '.') or (Ch = '-') or (Ch = '_') or (Ch = '~')then
          Result := Result + Ch
      else if Ch=' ' then
          Result := Result + SpaceCharReplace
      else
          Result := Result + '%' + _IntToHex(Ord(Ch), 2);
  end;
end;


function GenerateUrl(
                    AParamNames:Array of String;
                    AParamValues:Array of Variant
                    ):String;
var
  I:Integer;
  AParamValue:String;
  //订单参数列表
  APayParamList:TRestIntfParams;
begin

  APayParamList:=TRestIntfParams.Create;
  try

    for I := 0 to Length(AParamNames)-1 do
    begin
      AParamValue:=AParamValues[I];
      if AParamValue<>'' then
      begin
        APayParamList.Add(AParamNames[I],AParamValue);
      end;
    end;


    //排序
    APayParamList.Sort;
    //生成需要签名的串
    Result:=APayParamList.GetQueryParamsStr(False);


  finally
    FreeAndNil(APayParamList);
  end;

end;


//function GetMimeType(AContent:TStream):String;
//var
//  Suffic:array [0..2] of AnsiChar;
//begin
//  AContent.Position:=0;
//  AContent.Read(Suffic,3);
//  AContent.Position:=0;
//  if Suffic='BMP' then
//  begin
//    Result:='image/bmp';
//  end
//  else if Suffic='GIF' then
//  begin
//    Result:='image/gif';
//  end
//  else if Suffic='PNG' then
//  begin
//    Result:='image/png';
//  end
//  else if Suffic='JPG' then
//  begin
//    Result:='image/jpeg';
//  end
//  else
//  begin
//    Result:='application/octet-stream';
//  end;
//end;
//
//function GetMimeType(AFileName:String):String;
//var
//  LowerCaseFileExt:String;
//begin
//  LowerCaseFileExt:=LowerCase(ExtractFileExt(AFileName));
//  if LowerCaseFileExt='.bmp' then
//  begin
//    result:='image/bmp';
//  end
//  else if LowerCaseFileExt='.gif' then
//  begin
//    result:='image/gif';
//  end
//  else if (LowerCaseFileExt='.jpg') or (LowerCaseFileExt='.jpeg') then
//  begin
//    result:='image/jpeg';
//  end
//  else if LowerCaseFileExt='.png' then
//  begin
//    result:='image/png';
//  end
//  else
//  begin
//  result:='application/octet-stream';
//  end;
//end;

function ParseUrlQueryParameters(URL:String;HasWWW:Boolean):TRestIntfParams;
var
  I: Integer;
  AName,AValue:String;
  AEqualCharIndex:Integer;
  AParamStrList:TStringList;
  AParametersString:String;
  AParametersStringStartIndex:Integer;
begin
  Result:=TRestIntfParams.Create;
  if HasWWW then
  begin
    //解析出参数列表字符串
    AParametersStringStartIndex:=Pos('?',URL);
    AParametersString:=Copy(URL,AParametersStringStartIndex+1,MaxInt);
  end
  else
  begin
    AParametersString:=URL;
  end;

  if AParametersString<>'' then
  begin
    //找到参数列表字符串
    AParamStrList:=TStringList.Create;
    Try
      AParamStrList.Delimiter:='&';
      AParamStrList.DelimitedText:=AParametersString;
      for I := 0 to AParamStrList.Count-1 do
      begin
        if (AParamStrList[I]<>'') then
        begin
          AEqualCharIndex:=Pos('=',AParamStrList[I]);
          if AEqualCharIndex>0 then
          begin
            AName:=Copy(AParamStrList[I],1,AEqualCharIndex-1);
            AValue:=Copy(AParamStrList[I],AEqualCharIndex+1,Length(AParamStrList[I])-AEqualCharIndex);
            Result.Add(AName,AValue);
          end;
        end;
      end;
    Finally
      AParamStrList.Free;
    End;
  end;

end;


function GetUrlQueryParameterValue(URL:String;HasWWW:Boolean;AParamName:String):String;
var
  AInterfaceParameters:TRestIntfParams;
begin
  AInterfaceParameters:=ParseUrlQueryParameters(URL,HasWWW);
  if AInterfaceParameters.FindItemByName(AParamName)<>nil then
  begin
    Result:=AInterfaceParameters.FindItemByName(AParamName).FValue;
  end;
  FreeAndNil(AInterfaceParameters);
end;


{ TRestIntfParam }

//constructor TRestIntfParam.Create(const AName:String;const AValue:String);
//begin
//  FName:=AName;
//  FValue:=AValue;
//end;
//
//destructor TRestIntfParam.Destroy;
//begin
//  inherited;
//end;

{ TRestIntfParams }

function TRestIntfParams.GetQueryParamsStr(
                              HasRefChar:Boolean=True;//是否需要引号
                              NeedUrlEncode:Boolean=False;//是否需要UrlEncode
                              SpaceCharReplace:String='20%'
                              ): String;
var
  I:Integer;
  ValueStr:String;
begin
  Result:='';
  for I := 0 to Count-1 do
  begin
    ValueStr:=Items[I].Value;
    if ValueStr<>'' then
    begin

      if NeedUrlEncode then
      begin
        ValueStr:=FuncUrlEncode(ValueStr,SpaceCharReplace);
      end;

      if HasRefChar then
      begin
        ValueStr:='"'+ValueStr+'"';
      end;


      Result:=Result+Items[I].Name+'='+ValueStr;

      if I<Count-1 then
      begin
        Result:=Result+'&';
      end;
    end;
  end;
end;

function TRestIntfParams.GetValueArray: TVariantDynArray;
var
  I: Integer;
begin
  SetLength(Result,Self.Count);
  for I := 0 to Self.Count-1 do
  begin
    Result[I]:=Items[I].GetRealValue;
  end;

end;

procedure TRestIntfParams.Add(const AName: String;const AValue: Variant);
var
  AItem:TRestIntfParam;
begin
  AItem:=TRestIntfParam(Inherited Add);
  AItem.FName:=AName;
  AItem.FValue:=VarToStr(AValue);
end;

constructor TRestIntfParams.Create;
begin
  Inherited Create(TRestIntfParam);
end;

function TRestIntfParams.FindItemByName(AName: String): TRestIntfParam;
var
  I: Integer;
begin
  Result:=nil;
  for I := 0 to Self.Count - 1 do
  begin
    if Items[I].Name=AName then
    begin
      Result:=Items[I];
      Break;
    end;
  end;
end;

function TRestIntfParams.GetItem(Index: Integer): TRestIntfParam;
begin
  Result:=TRestIntfParam(Inherited Items[Index]);
end;

function TRestIntfParams.GetNameArray: TStringDynArray;
var
  I: Integer;
begin
  SetLength(Result,Self.Count);
  for I := 0 to Self.Count-1 do
  begin
    Result[I]:=Items[I].Name;
  end;
end;

function TRestIntfParams.GetXMLPackage: String;
var
  I:Integer;
  ValueStr:String;
begin
  Result:='<xml>'+#13#10;
  for I := 0 to Count-1 do
  begin
    ValueStr:=Items[I].Value;
    //if ValueStr<>'' then
//    begin
      Result:=Result+'<'+Items[I].Name+'>'+ValueStr+'</'+Items[I].Name+'>'+#13#10;
//    end;
  end;
  Result:=Result+'</xml>';
end;

function TRestIntfParams.ItemValueByName(AName: String): String;
var
  AInterfaceParameter:TRestIntfParam;
begin
  Result:='';
  AInterfaceParameter:=Self.FindItemByName(AName);
  if AInterfaceParameter<>nil then
  begin
    Result:=AInterfaceParameter.GetRealValue;
  end;
end;

//function TRestIntfParams.GetSignQueryParamsStr: String;
//var
//  I:Integer;
//  ValueStr:String;
//begin
//  Result:='';
//  for I := 0 to Count-1 do
//  begin
//    ValueStr:=Items[I].Value;
//    //if ValueStr<>'' then
////    begin
//      Result:=Result+Items[I].Name+ValueStr;
////    end;
//  end;
//end;

function SortByName_Compare(Item1, Item2: Pointer): Integer;
var
  Param1,Param2:TRestIntfParam;
begin
  Param1:=TRestIntfParam(Item1);
  Param2:=TRestIntfParam(Item2);
  if Param1.FName>Param2.FName then
  begin
    Result:=1;
  end
  else if Param1.FName<Param2.FName then
  begin
    Result:=-1;
  end
  else
  begin
    Result:=0;
  end;
end;

procedure TRestIntfParams.Sort;
begin
//  FItems.Sort(SortByName_Compare);
end;



{ TRestIntfDataSource }

function TRestIntfDataSource.CanOpen: Boolean;
begin
  Result:=False;
  if Self.FIntfUrl='' then Exit;
  if Self.FHttpMethod='' then Exit;
  if Self.FConnection=nil then Exit;
  Result:=True;
end;

constructor TRestIntfDataSource.Create(AOwner: TComponent);
begin
  inherited;
  FParams:=TRestIntfParams.Create;
  FHttpMethod:='GET';
end;

destructor TRestIntfDataSource.Destroy;
begin
  FreeAndNil(FParams);
  inherited;
end;

function TRestIntfDataSource.DoOpen: Boolean;
var
  AInterfaceUrl:String;
//  AUrlParamNames:TStringDynArray;
//  AUrlParamValues:TVariantDynArray;
begin
  AInterfaceUrl:='';
  if Self.FConnection<>nil then
  begin
    AInterfaceUrl:=Self.FConnection.InterfaceUrl;
  end;

//  SetLength(AUrlParamNames,Self.FParams.Count);
//  SetLength(AUrlParamValues,Self.FParams.Count);

  JsonStr.Text:=
    formatJson(UTFStrToUnicode(
        SimpleCallAPI(Self.FIntfUrl,
                                        nil,
                                        AInterfaceUrl,
                                        Self.FParams.GetNameArray,
                                        Self.FParams.GetValueArray)
                                    ));

  Result:=True;
end;

function TRestIntfDataSource.GetFieldDefList(ABindItemFieldName:String): TFieldDefs;
var
  AJsonNameArray:TStringDynArray;
  I: Integer;
  AJson:ISuperObject;
  AJsonAray:ISuperArray;
begin
  Self.FFieldDefs.Clear;
  Result:=FFieldDefs;

  if (FDataJson=nil) then Exit;

  if ABindItemFieldName<>'' then
  begin
      //是否存在这个节点
      if not GetJsonContainsHasLevel(FDataJson,ABindItemFieldName) then
      begin
        Exit;
      end;

      //判断节点的类型,
      case GetJsonTypeHasLevel(FDataJson,ABindItemFieldName) of
        varArray:
        begin

          AJsonAray:=GetJsonArrayHasLevel(FDataJson,ABindItemFieldName);
          if AJsonAray.Length>0 then
          begin
            AJson:=AJsonAray.O[0];
          end;

        end;

      end
  end
  else
  begin
      AJson:=FDataJson;

  end;

  if AJson=nil then Exit;
  
  //是对象数组
  AJsonNameArray:=GetJsonNameArray(AJson);
  for I := 0 to Length(AJsonNameArray)-1 do
  begin
    FFieldDefs.Add(AJsonNameArray[I],
                   ConvertVarTypeToFieldType(FDataJson.GetType(AJsonNameArray[I])),
                   0,
                   False
                  );
  end;

end;

procedure TRestIntfDataSource.SetConnection(const Value: TRestConnection);
begin
  if FConnection<>Value then
  begin

    FConnection := Value;

    if FActive then
    begin
      Open;
    end;

  end;
end;

procedure TRestIntfDataSource.SetParams(const Value: TRestIntfParams);
begin
  FParams.Assign(Value);
end;

{ TRestIntfParam }

function TRestIntfParam.GetDisplayName: string;
begin
  Result:=FName+':'+FValue;
end;

function TRestIntfParam.GetRealValue: String;
begin
  //判断是否是变量
  if Copy(FValue,1,1)='{' then
  begin
    Result:=GlobalBindDataSourceList.GetVaribleValue(FValue);
  end
  else
  begin
    Result:=FValue;
  end;
end;

procedure TRestIntfParam.SetDisplayName(const Value: string);
begin
  inherited;

end;

{ TParamsDataSource }

constructor TParamsDataSource.Create(AOwner: TComponent);
begin
  inherited;
  FParams:=TRestIntfParams.Create;
end;

destructor TParamsDataSource.Destroy;
begin
  FreeAndNil(FParams);
  inherited;
end;

function TParamsDataSource.GetValueByBindItemField(AParamName: String): Variant;
begin
  Result:=FParams.ItemValueByName(AParamName);
end;

procedure TParamsDataSource.SetParams(const Value: TRestIntfParams);
begin
  FParams.Assign(Value);
end;

procedure TParamsDataSource.SetValue(AParamName: String; AValue: Variant);
var
  AItem:TRestIntfParam;
begin
  AItem:=FParams.FindItemByName(AParamName);
  if AItem<>nil then
  begin
    AItem.FValue:=AValue;
  end;
end;

initialization
  GetGlobalFrameworkComponentTypeClasses.Add('RestIntfDataSource',TRestIntfDataSource,'远程接口数据源');//服务端数据库数据源



end.
