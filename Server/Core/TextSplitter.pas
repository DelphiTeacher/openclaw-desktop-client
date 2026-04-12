//convert pas to utf8 by ¥
unit TextSplitter;

interface

uses
  Classes,System.SysUtils, System.Generics.Collections,XSuperObject,DocumentReader;

type
  // 文档切片设置类
  TTextSplitterSetting = class
  private
    FChunkSize: Integer;
    FChunkOverlap: Integer;
    FSeparator: String;
  public
    constructor Create;
    destructor Destroy; override;

//    procedure LoadFromJSON(AJson: ISuperObject);

    // 属性
    property ChunkSize: Integer read FChunkSize write FChunkSize;
    property ChunkOverlap: Integer read FChunkOverlap write FChunkOverlap;
    property Separator: String read FSeparator write FSeparator;

  end;

  // 文档切片基类
  TTextSplitter = class abstract
  protected
    FSetting: TTextSplitterSetting;
  public
    constructor Create();
    destructor Destroy; override;

    // 属性
    property Setting: TTextSplitterSetting read FSetting;

    // 方法
    function Split(const Text: string): TStringList; virtual;abstract;

  end;

// 将文档进行分片
function SplitDocument(AChunkSettingJson:ISuperObject;AParseDocumentResult:TParseDocumentResult):TStringList;


implementation

uses
  TokenTextSplitter;

// 将文档进行分片
function SplitDocument(AChunkSettingJson:ISuperObject;AParseDocumentResult:TParseDocumentResult):TStringList;
var
  ATextSplitter:TTextSplitter;
begin
  ATextSplitter:=nil;
  // 根据不同的分片设置，创建不同的分片类
  if AChunkSettingJson.S['chunkSplitMode'] = 'size' then
  begin
    ATextSplitter:=TTokenTextSplitter.Create;
    
  end;
  ATextSplitter.FSetting.FChunkSize:=AChunkSettingJson.I['chunkSize'];

  Result:=ATextSplitter.Split(AParseDocumentResult.MarkdownContent);

end;

{ TTextSplitterSetting }

constructor TTextSplitterSetting.Create;
begin
  inherited Create;
  FChunkSize := 1000;
  FChunkOverlap := 0;
  // FSeparators := TStringList.Create;

  // 初始化默认分隔符
  // FSeparators.Add(#13#10);  // 换行符
  FSeparator:=#10;     // 换行符
  // FSeparators.Add(' ');     // 空格
  // FSeparators.Add('');      // 空字符串（最后的分隔符）
end;

destructor TTextSplitterSetting.Destroy;
begin
  // FSeparators.Free;
  inherited Destroy;
end;

//procedure TTextSplitterSetting.LoadFromJSON(AJson: ISuperObject);
//begin
//  FChunkSize := AJson.I['chunkSize'];
//  // FChunkOverlap := AJson.I['chunkOverlap'];
//  FSeparator := AJson.S['chunkSplitter'];
//end;

// procedure TTextSplitterSetting.SetChunkSize(Value: Integer);
// begin
//   if Value > 0 then
//     FChunkSize := Value
//   else
//     raise Exception.Create('ChunkSize must be greater than 0');
// end;

// procedure TTextSplitterSetting.SetChunkOverlap(Value: Integer);
// begin
//   if Value >= 0 then
//     FChunkOverlap := Value
//   else
//     raise Exception.Create('ChunkOverlap must be greater than or equal to 0');

//   if Value > FChunkSize then
//     raise Exception.Create('ChunkOverlap cannot be greater than ChunkSize');
// end;

//   procedure TTextSplitterSetting.AddSeparator(const Separator: string);
//   begin
//     if FSeparators.IndexOf(Separator) = -1 then
//       FSeparators.Add(Separator);
//   end;

//   procedure TTextSplitterSetting.ClearSeparators;
//   begin
//     FSeparators.Clear;
//   end;

//   function TTextSplitterSetting.Validate: Boolean;
//   begin
//     Result := (FChunkSize > 0) and (FChunkOverlap >= 0) and (FChunkOverlap <= FChunkSize);
//   end;

{ TTextSplitter }

constructor TTextSplitter.Create();
begin
  inherited Create;
  FSetting := TTextSplitterSetting.Create
end;

destructor TTextSplitter.Destroy;
begin
  FSetting.Free;
  inherited Destroy;
end;



end.
