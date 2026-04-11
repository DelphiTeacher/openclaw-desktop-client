unit CommonImageDataMoudle;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, FMX.ImgList, uDrawPicture,

  System.DateUtils,
  uFuncCommon,
  uSkinImageList, uGraphicCommon;

type
  TdmCommonImageDataMoudle = class(TDataModule)
    imglistAppIcon: TSkinImageList;
    imgListNoticeIcon: TSkinImageList;
    imgHeadList: TSkinImageList;
    imglistProduct: TSkinImageList;
    imglistViewType: TSkinImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCommonImageDataMoudle: TdmCommonImageDataMoudle;


function GetActivityRules(AFullMoney1:Double;
                          ADescMoney1:Double;
                          AFullMoney2:Double;
                          ADescMoney2:Double;
                          AFullMoney3:Double;
                          ADescMoney3:Double):String;

//计算时间差
function GetTime(ADateTime:String):String;

//配送费计算
function GetFeeCountString( ADistance_free: Double;
                            AWeather_free: Double;
                            AWeight_free: Double;
                            ATime_free: Double;
                            ABasic_free: Double;
                            AVolum_free: Double):String;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}


function GetActivityRules(AFullMoney1:Double;
                          ADescMoney1:Double;
                          AFullMoney2:Double;
                          ADescMoney2:Double;
                          AFullMoney3:Double;
                          ADescMoney3:Double):String;
begin
  Result:='';

  if (AFullMoney1<>0) and (ADescMoney1<>0) then
  begin
    Result:=Result+'满'+FloatToStr(AFullMoney1)+'减'+FloatToStr(ADescMoney1)+' ';
  end;

  if (AFullMoney2<>0) and (ADescMoney2<>0) then
  begin
    Result:=Result+'满'+FloatToStr(AFullMoney2)+'减'+FloatToStr(ADescMoney2)+' ';
  end;

  if (AFullMoney3<>0) and (ADescMoney3<>0) then
  begin
    Result:=Result+'满'+FloatToStr(AFullMoney3)+'减'+FloatToStr(ADescMoney3)+' ';
  end;


end;

function GetTime(ADateTime:String):String;
var
  DateTime:TDateTime;
begin
  Result:='';

  if ADateTime<>'' then
  begin
    DateTime:=StandardStrToDateTime(ADateTime);

    if MinutesBetween(Now,DateTime)=0 then
    begin
      Result:='刚刚';
    end
    else if (0<MinutesBetween(Now,DateTime)) and (MinutesBetween(Now,DateTime)<60) then
    begin
      Result:=IntToStr(MinutesBetween(Now,DateTime))+'分钟前';
    end
    else
    begin
      if (1<=HoursBetween(Now,DateTime)) and (HoursBetween(Now,DateTime)<24)  then
      begin
        Result:=IntToStr(HoursBetween(Now,DateTime))+'小时前';
      end
      else
      begin
        Result:=IntToStr(DaysBetween(Now,DateTime))+'天前';
      end;
    end;
  end;

end;

function GetFeeCountString( ADistance_free: Double;
                            AWeather_free: Double;
                            AWeight_free: Double;
                            ATime_free: Double;
                            ABasic_free: Double;
                            AVolum_free: Double):String;
begin
  Result:='';

  if ABasic_free<>0 then
  begin
    Result:=Result+'基础费:'+FloatToStr(ABasic_free)+'元'+#13#10;
  end;

  if ADistance_free<>0 then
  begin
    Result:=Result+'距离加价:'+FloatToStr(ADistance_free)+'元'+#13#10;
  end;

  if AWeather_free<>0 then
  begin
    Result:=Result+'天气加价:'+FloatToStr(AWeather_free)+'元'+#13#10;
  end;

  if ATime_free<>0 then
  begin
    Result:=Result+'时间加价:'+FloatToStr(ATime_free)+'元'+#13#10;
  end;

  if AVolum_free<>0 then
  begin
    Result:=Result+'体积加价:'+FloatToStr(AVolum_free)+'元'+#13#10;
  end;

end;

end.
