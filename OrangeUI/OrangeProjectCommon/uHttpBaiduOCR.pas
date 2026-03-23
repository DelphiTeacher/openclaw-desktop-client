unit uHttpBaiduOCR;

interface


uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,

  System.NetEncoding,
  XSuperObject,
  DateUtils,

  System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, FMX.Objects, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.MediaLibrary.Actions, System.Actions, FMX.ActnList,
  FMX.StdActns;


type
  THttpBaiduOCR=class
  private
    NetHTTPClient1: TNetHTTPClient;
    FAccessToken:ISuperObject;
  public
    FAccessKey:String;
    FAccessSecret:String;
    FServerRespones:String;
    constructor Create;
    destructor Destroy;override;
  public
    function GetAccessToken:Boolean;
    //识别车牌
    function CarLicensePlate(AFilePath:String;
                            var ACarPlate:String):Boolean;
    function Basic(AFilePath:String;var ACarPlate:String):Boolean;


  end;


implementation


function getBaiDuOcrToken(
  nethttpclient: TNetHTTPClient;
  AAccessKey:String;
  AAccessToken:String;
  var AResponse:String): Boolean;
var
  baselist: TStringList;
  stream: TStringStream;
  ss: TStringStream;
begin
  Result:=False;


  //先获取Token
  stream := TStringStream.Create('',TEncoding.UTF8);
  baselist := TStringList.Create;
  ss := TStringStream.Create('',TEncoding.UTF8);
  try
      try

          baselist.AddPair('grant_type', 'client_credentials');
//          baselist.AddPair('client_id', 'ik7EckvwL2gDnp5S1kueDGwG');
//          baselist.AddPair('client_secret', 'hFaONhb3PrXHiGOSe4E668kw5sGblgG5');

          baselist.AddPair('client_id', AAccessKey);
          baselist.AddPair('client_secret', AAccessToken);


          nethttpclient.Post('https://aip.baidubce.com/oauth/2.0/token', baselist, stream);



          //access_token： 要获取的Access Token；
          //expires_in： Access Token的有效期(秒为单位，一般为1个月)；


          //{
          //	"refresh_token": "25.65046bc3798933e4514aa9f2c7850f91.315360000.1864428481.282335-15508933",
          //	"expires_in": 2592000,
          //	"session_key": "9mzdCKJEW\/BHpHj+SdRrdt8Rjiyo9gbD2z2BXCOgiYxBREMbwtMPmCCyL\/Z2kniuUWB6NTCyAdDt7hJzDAC79Nen46T2iw==",
          //	"access_token": "24.3f316a22d7fef048397b6d0eb9bf2e33.2592000.1551660481.282335-15508933",
          //	"scope": "public vis-ocr_ocr brain_ocr_scope brain_ocr_general brain_ocr_general_basic brain_ocr_general_enhanced vis-ocr_business_license brain_ocr_webimage brain_all_scope brain_ocr_idcard brain_ocr_driving_license brain_ocr_vehicle_license vis-ocr_plate_number brain_solution brain_ocr_plate_number brain_ocr_accurate brain_ocr_accurate_basic brain_ocr_receipt brain_ocr_business_license brain_solution_iocr brain_ocr_handwriting brain_ocr_vat_invoice brain_numbers brain_ocr_train_ticket brain_ocr_taxi_receipt wise_adapt lebo_resource_base lightservice_public hetu_basic lightcms_map_poi kaidian_kaidian ApsMisTest_Test\u6743\u9650 vis-classify_flower lpq_\u5f00\u653e cop_helloScope ApsMis_fangdi_permission smartapp_snsapi_base iop_autocar oauth_tp_app smartapp_smart_game_openapi oauth_sessionkey smartapp_swanid_verify smartapp_opensource_openapi",
          //	"session_secret": "24967991e9915c7e2d41f816fbf2612e"
          //}

          AResponse:=stream.DataString;
          Result:=True;



      except
        on E:Exception do
        begin
          Exit;
        end;
      end;

  finally
    freeandnil(ss);
    freeandnil(baselist);
    freeandnil(stream);
  end;

end;

function getBaiDuOcr_Basic(filename: String;
  nethttpclient: TNetHTTPClient;
  AAccessToken:String;
  var AResponse:String): Boolean;
var
  url: String;
  strlist, baselist: TStringList;
  stream: TStringStream;
  fs: TFileStream;
  ss: TStringStream;
begin
  AResponse:='';
  Result:=False;

  if not fileexists(filename) then
  begin
//    showmessage('传入的图片不存在');
//    result := 'file not exists';
    Exit;
  end;



  stream := TStringStream.Create('',TEncoding.UTF8);
  baselist := TStringList.Create;
  fs := TFileStream.Create(filename, FMOpenRead);
  ss := TStringStream.Create('',TEncoding.UTF8);
  try
      TNetEncoding.Base64.Encode(fs, ss);
      nethttpclient.ContentType := 'application/x-www-form-urlencoded';
      url := 'https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic'
                +'?'
                + 'access_token=' + AAccessToken;
      baselist.AddPair('image', ss.DataString);

      nethttpclient.Post(url, baselist, stream);

      //{
      //	"log_id": 3764652729201746466,
      //	"words_result_num": 1,
      //	"words_result": [{
      //		"words": "苏E730V7"
      //	}]
      //}


      AResponse := stream.DataString;

      Result:=True;
  finally
    freeandnil(fs);
    freeandnil(ss);
    freeandnil(baselist);
    freeandnil(stream);
  end;

end;

function getBaiDuOcr_LicensePlate(filename: String;
  nethttpclient: TNetHTTPClient;
  AAccessToken:String;
  var AResponse:String): Boolean;
var
  url: String;
  strlist, baselist: TStringList;
  stream: TStringStream;
  fs: TFileStream;
  ss: TStringStream;
begin
  AResponse:='';
  Result:=False;

  if not fileexists(filename) then
  begin
//    showmessage('传入的图片不存在');
//    result := 'file not exists';
    Exit;
  end;



  stream := TStringStream.Create('',TEncoding.UTF8);
  baselist := TStringList.Create;
  fs := TFileStream.Create(filename, FMOpenRead);
  ss := TStringStream.Create('',TEncoding.UTF8);
  try
      TNetEncoding.Base64.Encode(fs, ss);
      nethttpclient.ContentType := 'application/x-www-form-urlencoded';
      url := 'https://aip.baidubce.com/rest/2.0/ocr/v1/license_plate'
                +'?'
                + 'access_token=' + AAccessToken;
      baselist.AddPair('image', ss.DataString);

      nethttpclient.Post(url, baselist, stream);



      //{
      //	"log_id": 5330198640615329026,
      //	"words_result": {
      //		"color": "blue",
      //		"number": "苏E730V7",
      //		"probability": [1.0, 0.9999985694885254, 0.9999971389770508, 0.9999891519546509, 0.9996276497840881, 0.9996053576469421, 0.9996033310890198],
      //		"vertexes_location": [{
      //			"y": 231,
      //			"x": 95
      //		}, {
      //			"y": 222,
      //			"x": 533
      //		}, {
      //			"y": 356,
      //			"x": 536
      //		}, {
      //			"y": 365,
      //			"x": 98
      //		}]
      //	}
      //}


      //{
      //	"log_id": 8227464982128090178,
      //	"error_code": 282102,
      //	"error_msg": "detect plate number error"
      //}

      AResponse := stream.DataString;

      Result:=True;
  finally
    freeandnil(fs);
    freeandnil(ss);
    freeandnil(baselist);
    freeandnil(stream);
  end;

end;


{ THttpBaiduOCR }

function THttpBaiduOCR.CarLicensePlate(AFilePath: String;
  var ACarPlate: String): Boolean;
var
  ASuperObject:ISuperObject;
begin
    ACarPlate:='';
    Result:=False;



    //获取Token
    if Not GetAccessToken() then
    begin
  //      //获取Token失败
  //      TThread.Synchronize(nil,procedure
  //      begin
  //          ShowMessage('AccessToken获取失败!');
  //      end);
        Exit;
    end;




    //调用
    if not getBaiDuOcr_LicensePlate(AFilePath,
                        Self.NetHTTPClient1,
                        Self.FAccessToken.S['access_token'],
                        FServerRespones
                        ) then
    begin
  //      TThread.Synchronize(nil,procedure
  //      begin
  //          ShowMessage('车牌号获取失败!');
  //      end);
        Exit;
    end;



    ASuperObject:=TSuperObject.Create(FServerRespones);
    if not ASuperObject.Contains('words_result')
      or (ASuperObject.O['words_result'].S['number']='') then
    begin

  //      TThread.Synchronize(nil,procedure
  //      begin
  //          ShowMessage('没有获取到车牌号!');
  //      end);
        Exit;
    end;


    ACarPlate:=ASuperObject.O['words_result'].S['number'];
    Result:=True;

end;

function THttpBaiduOCR.Basic(AFilePath: String;
  var ACarPlate: String): Boolean;
var
  ASuperObject:ISuperObject;
  I: Integer;
begin
    ACarPlate:='';
    Result:=False;



    //获取Token
    if Not GetAccessToken() then
    begin
  //      //获取Token失败
  //      TThread.Synchronize(nil,procedure
  //      begin
  //          ShowMessage('AccessToken获取失败!');
  //      end);
        Exit;
    end;




    //调用
    if not getBaiDuOcr_Basic(AFilePath,
                        Self.NetHTTPClient1,
                        Self.FAccessToken.S['access_token'],
                        FServerRespones
                        ) then
    begin
  //      TThread.Synchronize(nil,procedure
  //      begin
  //          ShowMessage('车牌号获取失败!');
  //      end);
        Exit;
    end;


    //'{"words_result":[{"words":"Jord"},{"words":"苏E.730V7"}],"words_result_num":2,"log_id":1772135554968351824}'
    ASuperObject:=TSuperObject.Create(FServerRespones);
    if not ASuperObject.Contains('words_result')
      or (ASuperObject.A['words_result'].Length=0) then
    begin

  //      TThread.Synchronize(nil,procedure
  //      begin
  //          ShowMessage('没有获取到车牌号!');
  //      end);
        Exit;
    end;

    ACarPlate:='';
    for I := 0 to ASuperObject.A['words_result'].Length-1 do
    begin
      if ACarPlate<>'' then
      begin
        ACarPlate:=ACarPlate+' ';
      end;
      ACarPlate:=ACarPlate+ASuperObject.A['words_result'].O[I].S['words'];
    end;

//    ACarPlate:=ASuperObject.O['words_result'].S['number'];
    Result:=True;

end;

constructor THttpBaiduOCR.Create;
begin
  NetHTTPClient1:=TNetHTTPClient.Create(nil);
  FAccessToken:=TSuperObject.Create;

//  baselist.AddPair('client_id', 'ik7EckvwL2gDnp5S1kueDGwG');
//  baselist.AddPair('client_secret', 'hFaONhb3PrXHiGOSe4E668kw5sGblgG5');
  FAccessKey:='ik7EckvwL2gDnp5S1kueDGwG';
  FAccessSecret:='hFaONhb3PrXHiGOSe4E668kw5sGblgG5';

end;

destructor THttpBaiduOCR.Destroy;
begin
  FreeAndNil(NetHTTPClient1);
  FAccessToken:=nil;
  inherited;
end;

function THttpBaiduOCR.GetAccessToken: Boolean;
var
  AGetTime:TDateTime;
begin
    Result:=False;

    //{
    //	"refresh_token": "25.65046bc3798933e4514aa9f2c7850f91.315360000.1864428481.282335-15508933",
    //	"expires_in": 2592000,
    //	"session_key": "9mzdCKJEW\/BHpHj+SdRrdt8Rjiyo9gbD2z2BXCOgiYxBREMbwtMPmCCyL\/Z2kniuUWB6NTCyAdDt7hJzDAC79Nen46T2iw==",
    //	"access_token": "24.3f316a22d7fef048397b6d0eb9bf2e33.2592000.1551660481.282335-15508933",
    //	"scope": "public vis-ocr_ocr brain_ocr_scope brain_ocr_general brain_ocr_general_basic brain_ocr_general_enhanced vis-ocr_business_license brain_ocr_webimage brain_all_scope brain_ocr_idcard brain_ocr_driving_license brain_ocr_vehicle_license vis-ocr_plate_number brain_solution brain_ocr_plate_number brain_ocr_accurate brain_ocr_accurate_basic brain_ocr_receipt brain_ocr_business_license brain_solution_iocr brain_ocr_handwriting brain_ocr_vat_invoice brain_numbers brain_ocr_train_ticket brain_ocr_taxi_receipt wise_adapt lebo_resource_base lightservice_public hetu_basic lightcms_map_poi kaidian_kaidian ApsMisTest_Test\u6743\u9650 vis-classify_flower lpq_\u5f00\u653e cop_helloScope ApsMis_fangdi_permission smartapp_snsapi_base iop_autocar oauth_tp_app smartapp_smart_game_openapi oauth_sessionkey smartapp_swanid_verify smartapp_opensource_openapi",
    //	"session_secret": "24967991e9915c7e2d41f816fbf2612e"
    //}

    AGetTime:=TDateTime(FAccessToken.F['get_time']);


    if
      //不存在令牌
      not FAccessToken.Contains('access_token')
      //或者已经过期
      or (DateUtils.SecondsBetween(AGetTime,Now)>FAccessToken.I['expires_in']-60*60) then
    begin
        //需要重新获取

        if not getBaiDuOcrToken(Self.NetHTTPClient1,
                                Self.FAccessKey,
                                Self.FAccessSecret,
                                FServerRespones) then
        begin
          Exit;
        end;

        FAccessToken:=TSuperObject.Create(FServerRespones);
        //获取时间
        FAccessToken.F['get_time']:=Now;

        if FAccessToken.Contains('access_token') then
        begin
          Result:=True;
        end;





    end
    else
    begin
        //可以使用上次的令牌
        Result:=True;
    end;


end;

end.
