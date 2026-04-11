unit NativePDFDocumentReader;

interface

uses
  System.SysUtils, System.Generics.Collections,
  DocumentReader, PDFium;

type
  /// <summary>
  /// 原生PDF文档读取器，直接从PDF文件中提取文本内容
  /// 不使用OCR技术，适用于文本型PDF文件
  /// </summary>
  TNativePDFDocumentReader = class(TDocumentReader)
  private
    FPdf: TPdf;
    procedure InitializePdf;
    procedure FinalizePdf;
    function ExtractTextFromPage(APageNumber: Integer): string;
    function ExtractImagesFromPage(APageNumber: Integer; AImageList: TParseImageList; var AImageIndex: Integer): string;
  public
    constructor Create;
    destructor Destroy; override;

    /// <summary>
    /// 读取PDF文档，返回Markdown格式的文本和图片列表
    /// </summary>
    function Read(const ADocumentPath: string): TParseDocumentResult; override;
  end;

implementation

{ TNativePDFDocumentReader }

constructor TNativePDFDocumentReader.Create;
begin
  inherited Create;
  FPdf := TPdf.Create(nil);
end;

destructor TNativePDFDocumentReader.Destroy;
begin
  FinalizePdf;
  FPdf.Free;
  inherited Destroy;
end;

procedure TNativePDFDocumentReader.InitializePdf;
begin
  if not FPdf.Active then
    FPdf.Active := True;
end;

procedure TNativePDFDocumentReader.FinalizePdf;
begin
  if FPdf.Active then
    FPdf.Active := False;
end;

function TNativePDFDocumentReader.ExtractTextFromPage(APageNumber: Integer): string;
begin
  FPdf.PageNumber := APageNumber;
  Result := FPdf.Text;
end;

function TNativePDFDocumentReader.ExtractImagesFromPage(APageNumber: Integer;
  AImageList: TParseImageList; var AImageIndex: Integer): string;
var
  I: Integer;
  ImageCount: Integer;
  ImageId: string;
  ImagePath: string;
  ImageItem: TParseImageItem;
  TempImagePath: string;
begin
  Result := '';
  FPdf.PageNumber := APageNumber;
  ImageCount := FPdf.ImageCount;

  if ImageCount > 0 then
  begin
    TempImagePath := GetEnvironmentVariable('TEMP');
    if TempImagePath = '' then
      TempImagePath := GetCurrentDir;

    for I := 0 to ImageCount - 1 do
    begin
      Inc(AImageIndex);
      ImageId := Format('img_%d', [AImageIndex]);
      ImagePath := Format('%s\%s.png', [TempImagePath, ImageId]);

      // 保存图片
      if Assigned(FPdf.Bitmap[I]) then
      begin
        FPdf.Bitmap[I].SaveToFile(ImagePath);
        ImageItem := TParseImageItem.Create(ImageId, ImagePath);
        AImageList.Add(ImageItem);

        // 在文本中插入图片引用
        Result := Result + Format('![%s](%s)', [ImageId, ImageId]) + #13#10;
      end;
    end;
  end;
end;

function TNativePDFDocumentReader.Read(const ADocumentPath: string): TParseDocumentResult;
var
  PageCount: Integer;
  PageNumber: Integer;
  PageText: string;
  PageImages: string;
  ImageIndex: Integer;
  MarkdownContent: string;
begin
  Result := TParseDocumentResult.Create;

  try
    // 设置PDF文件路径
    FPdf.FileName := ADocumentPath;

    // 打开PDF文档
    InitializePdf;

    if not FPdf.Active then
    begin
      Result.MarkdownContent := '';
      Exit;
    end;

    PageCount := FPdf.PageCount;
    MarkdownContent := '';
    ImageIndex := 0;

    // 遍历所有页面提取文本和图片
    for PageNumber := 1 to PageCount do
    begin
      // 提取文本
      PageText := ExtractTextFromPage(PageNumber);

      // 添加页码标记
      if PageNumber > 1 then
        MarkdownContent := MarkdownContent + #13#10 + '---' + #13#10;

      MarkdownContent := MarkdownContent + Format('## 第 %d 页' + #13#10, [PageNumber]);
      MarkdownContent := MarkdownContent + PageText + #13#10;

      // 提取图片
      PageImages := ExtractImagesFromPage(PageNumber, Result.ImageList, ImageIndex);
      if PageImages <> '' then
        MarkdownContent := MarkdownContent + PageImages + #13#10;
    end;

    Result.MarkdownContent := MarkdownContent;

  finally
    FinalizePdf;
  end;
end;

end.
