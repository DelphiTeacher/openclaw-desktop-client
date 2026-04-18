//convert pas to utf8 by ¥
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
    DatasetIds:TArray<String>;
  end;

//  // 搜索结果
//  TSearchResult = class
//    id:String;
//    q:String;
//    a:String;
//  end;
//  TSearchResultList=class(TBaseList)
//  end;


  IVectorStore = interface
    function Add(AChunk:ISuperObject):Integer;
    procedure delete(AWhereKeyJson:ISuperArray);
    function similaritySearch(ASearchRequest:TSearchRequest):ISuperArray;
  end;



implementation

end.