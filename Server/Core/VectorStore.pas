unit VectorStore;

interface

uses
  System.SysUtils, System.Classes, System.Math, System.Generics.Collections, uBaseList,XSuperObject;


type
  TSearchRequest = record
    Query: String;
    TopK: Integer;
    Threshold: Double;
    MaxTokens: Integer;
    Vector:TArray<Double>;
  end;

  // 搜索结果
  TSearchResult = class

  end;
  TSearchResultList=class(TBaseList)
  end;


  IVectorStore = interface
    procedure add(AChunks:ISuperArray);
    procedure delete(AWhereKeyJson:ISuperArray);
    function similaritySearch(ASearchRequest:TSearchRequest):TSearchResultList;
  end;



implementation

end.