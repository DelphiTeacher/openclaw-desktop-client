unit TokenTextSplitter;

interface

uses
    Classes,
    System.SysUtils,
    System.Generics.Collections,
    TextSplitter,
    uDocSplit;

type
    TTokenTextSplitter = class(TTextSplitter)
    private
    public
        function Split(const Text: string): TStringList; override;

    end;

implementation

function TTokenTextSplitter.Split(const Text: string): TStringList;
begin
    Result:=SplitDoc(Text,Self.FSetting.ChunkSize);
end;



end.