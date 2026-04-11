unit DocumentReader;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  /// <summary>
  /// 图片项，包含图片ID和图片路径
  /// </summary>
  TParseImageItem = class
  private
    FImageId: string;
    FImagePath: string;
  public
    constructor Create(const AImageId, AImagePath: string);
    property ImageId: string read FImageId write FImageId;
    property ImagePath: string read FImagePath write FImagePath;
  end;

  /// <summary>
  /// 图片列表
  /// </summary>
  TParseImageList = class(TObjectList<TParseImageItem>)
  end;

  /// <summary>
  /// 文档解析结果，包含Markdown文本、图片列表和二维数组（用于Excel/CSV）
  /// </summary>
  TParseDocumentResult = class
  private
    FMarkdownContent: string;
    FImageList: TParseImageList;
    FTableData: TArray<TArray<string>>;
  public
    constructor Create;
    destructor Destroy; override;
    property MarkdownContent: string read FMarkdownContent write FMarkdownContent;
    property ImageList: TParseImageList read FImageList;
    property TableData: TArray<TArray<string>> read FTableData write FTableData;
  end;

  /// <summary>
  /// 文档读取器基类，定义文档解析的接口规范
  /// </summary>
  TDocumentReader = class abstract
  public
    /// <summary>
    /// 读取文档内容，返回解析结果
    /// </summary>
    /// <param name="ADocumentPath">文档路径</param>
    /// <returns>文档解析结果，包含Markdown内容和图片列表</returns>
    function Read(const ADocumentPath: string): TParseDocumentResult; virtual; abstract;

    /// <summary>
    /// 读取表格数据，返回二维数组
    /// </summary>
    /// <param name="ADocumentPath">文档路径</param>
    /// <returns>二维字符串数组，仅对Excel/CSV文件有效</returns>
    function ReadTable(const ADocumentPath: string): TArray<TArray<string>>; virtual;
  end;

// 解析文件
function ParseFile(AFilePath: String):TParseDocumentResult;


implementation

uses
  NativePDFDocumentReader;

function ParseFile(AFilePath: String):TParseDocumentResult;
var
  AFileExt:String;
  AReader:TDocumentReader;
begin
  Result:=nil;

  // 根据文件的后缀名来解析文件
  AFileExt := LowerCase(ExtractFileExt(AFilePath));

  AReader:=nil;

  if AFileExt = '.pdf' then
  begin
    AReader:=TNativePDFDocumentReader.Create;
  end;

  if AReader <> nil then
  begin
    try
        Result := AReader.Read(AFilePath);

    finally
      FreeAndNil(AReader);
    end;
  end;


end;


{ TParseImageItem }

constructor TParseImageItem.Create(const AImageId, AImagePath: string);
begin
  inherited Create;
  FImageId := AImageId;
  FImagePath := AImagePath;
end;

{ TParseDocumentResult }

constructor TParseDocumentResult.Create;
begin
  inherited Create;
  FImageList := TParseImageList.Create;
  FMarkdownContent := '';
  SetLength(FTableData, 0);
end;

destructor TParseDocumentResult.Destroy;
begin
  FImageList.Free;
  inherited Destroy;
end;

{ TDocumentReader }

function TDocumentReader.ReadTable(const ADocumentPath: string): TArray<TArray<string>>;
begin
  SetLength(Result, 0);
end;

end.
