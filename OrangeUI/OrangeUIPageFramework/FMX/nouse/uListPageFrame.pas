unit uListPageFrame;

interface


uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,


//  uUIFunction,
  uTimerTask,
//  uManager,
  uBaseHttpControl,


  XSuperObject,
  XSuperJson,
  uDataSetToJson,

  uDrawCanvas,
  uSkinItems,
  uSkinListBoxType,
  uBaseList,


  uSkinFireMonkeyButton, uSkinFireMonkeyPanel, uSkinFireMonkeyControl,
  uSkinFireMonkeyScrollControl, uSkinFireMonkeyCustomList,
  uSkinFireMonkeyVirtualList, uSkinFireMonkeyListBox,
  uSkinFireMonkeyItemDesignerPanel, uSkinFireMonkeyLabel, uSkinFireMonkeyImage,
  uDrawPicture, uSkinImageList, uSkinFireMonkeyRadioButton, uSkinButtonType,
  uSkinPanelType, uSkinRadioButtonType, uSkinLabelType, uSkinImageType,
  uSkinItemDesignerPanelType, uBaseSkinControl, uSkinScrollControlType,
  uSkinCustomListType, uSkinVirtualListType;



type
  //页面配置
  TPageFrame=class(TComponent)

  end;



  //Json数据
  TJsonData=class(TBaseJsonObject)
    SuperObject:ISuperObject;
  end;
  TJsonDataList=class(TBaseJsonObjectList)
  private
    function GetItem(Index: Integer): TJsonData;
  public
    property Items[Index:Integer]:TJsonData read GetItem;default;
  end;



  TBaseListClass=class of TBaseList;
  TGetDataListClassEvent=procedure(Sender:TObject;AClass:TBaseListClass) of object;



  //列表页面的配置
  TListPageFrame=class(TPageFrame)
  private
    FPageSize:Integer;

    FOnLoadDataInThread: TTimerTaskNotify;
    FOnLoadDataEndInUI: TTimerTaskNotify;
    FItemDesignerPanel: TSkinFMXItemDesignerPanel;
    FOnGetDataListClass: TGetDataListClassEvent;
    procedure SetOnLoadDataEndInUI(const Value: TTimerTaskNotify);
    procedure SetOnLoadDataInThread(const Value: TTimerTaskNotify);
    procedure SetOnGetDataListClass(const Value: TGetDataListClassEvent);
    procedure SetItemDesignerPanel(const Value: TSkinFMXItemDesignerPanel);
  public
    procedure DoOnLoadDataEndInUI(const Value: TTimerTask);virtual;
    procedure DoOnLoadDataInThread(const Value: TTimerTask);virtual;
  public
    PageIndex:Integer;
    //数据列表
    DataList:TBaseList;
    function GetDataList:TBaseList;

    //显示页面
//    procedure ShowFrame;
    //返回页面
//    procedure ReturnFrame;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  published
    property PageSize:Integer read FPageSize write FPageSize;
    //设计面板
    property ItemDesignerPanel:TSkinFMXItemDesignerPanel read FItemDesignerPanel write SetItemDesignerPanel;

    //获取数据列表类的列表
    property OnGetDataListClass:TGetDataListClassEvent read FOnGetDataListClass write SetOnGetDataListClass;
    //加载数据
    property OnLoadDataInThread:TTimerTaskNotify read FOnLoadDataInThread write SetOnLoadDataInThread;
    //加载数据结束
    property OnLoadDataEndInUI:TTimerTaskNotify read FOnLoadDataEndInUI write SetOnLoadDataEndInUI;
  end;




implementation

{ TListPageFrame }

constructor TListPageFrame.Create(AOwner: TComponent);
begin
  inherited;

  PageIndex:=1;
  FPageSize:=20;

end;

destructor TListPageFrame.Destroy;
begin
  FreeAndNil(DataList);
  inherited;
end;

procedure TListPageFrame.DoOnLoadDataEndInUI(const Value: TTimerTask);
begin
  if Assigned(Self.OnLoadDataEndInUI) then
  begin
    Self.OnLoadDataEndInUI(Value);
  end;
end;

procedure TListPageFrame.DoOnLoadDataInThread(const Value: TTimerTask);
begin
  if Assigned(Self.OnLoadDataInThread) then
  begin
    Self.OnLoadDataInThread(Value);
  end;
end;

function TListPageFrame.GetDataList: TBaseList;
var
  AClass:TBaseListClass;
begin
  Result:=DataList;
  if Result=nil then
  begin
    AClass:=nil;
    if Assigned(Self.FOnGetDataListClass) then
    begin
      FOnGetDataListClass(Self,AClass);
      Result:=AClass.Create;
    end;
  end;
end;

procedure TListPageFrame.SetItemDesignerPanel(
  const Value: TSkinFMXItemDesignerPanel);
begin
  FItemDesignerPanel := Value;
end;

procedure TListPageFrame.SetOnGetDataListClass(
  const Value: TGetDataListClassEvent);
begin
  FOnGetDataListClass := Value;
end;

procedure TListPageFrame.SetOnLoadDataEndInUI(const Value: TTimerTaskNotify);
begin
  FOnLoadDataEndInUI := Value;
end;

procedure TListPageFrame.SetOnLoadDataInThread(const Value: TTimerTaskNotify);
begin
  FOnLoadDataInThread := Value;
end;

{ TJsonDataList }

function TJsonDataList.GetItem(Index: Integer): TJsonData;
begin
  Result:=TJsonData(Inherited Items[Index]);
end;

end.
