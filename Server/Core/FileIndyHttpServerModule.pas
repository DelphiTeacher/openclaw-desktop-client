unit FileIndyHttpServerModule;

interface

uses
  System.SysUtils, System.Classes,

//  Forms,
//  Windows,
  StrUtils,

  EncdDecd,
  uGenerateThumb,
  uOpenClientCommon,
//  uThumbCommon,
  uFuncCommon,
  uFileCommon,
  uDataSetToJson,
//  uLang,

  uBaseLog,
  XSuperObject,
  XSuperJson,
  kbmMWGlobal,

  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,

  IdContext, IdCustomHTTPServer,
  IdMessageCoder,
  IdMessageCoderMIME,
  IdGlobalProtocols,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdHTTPServer, IdHeaderList,
  IdServerIOHandler, IdSSL, IdSSLOpenSSL;




type
  TdmFileIndyHttpServer = class(TDataModule)
    IdHTTPServer: TIdHTTPServer;
    IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL;
    procedure IdHTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure IdHTTPServerDoneWithPostStream(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; var VCanFree: Boolean);
    procedure IdHTTPServerCommandOther(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure IdFileHTTPServerHeadersAvailable(AContext: TIdContext;
      const AUri: string; AHeaders: TIdHeaderList;
      var VContinueProcessing: Boolean);
    procedure IdHTTPServerQuerySSLPort(APort: Word; var VUseSSL: Boolean);
  private
    FSSLPort:Word;
    { Private declarations }
  public
    WWWRootDir:String;
    WWWRootDirList:TStringList;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public
    function SetSSL(AEnable:Boolean):Boolean;
    procedure SetPort(ADefaultPort:Word;ASSLPort:Word);
    { Public declarations }
  end;




var
  dmFileIndyHttpServer: TdmFileIndyHttpServer;



function ProcessUploadFile(WWWRootDir:String;
                           AAppID:String;
                           AFileName:String;
                           AFileExt:String;
                           AFileDir:String;
                           ARequestInfoPostStream:TStream;
                           var ARemoteFilePath:String;
                           var ACode:Integer;
                           var ADesc:String):Boolean;
function GetMimeDecoderParam(AMimeDecoder:TIdMessageDecoderMIME;var AName:String;var AFileName:String):Boolean;


implementation




{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TdmFileIndyHttpServer.Create(AOwner: TComponent);
begin
  inherited;

  //默认是服务端EXE目录
  WWWRootDir:=GetApplicationPath;//ExtractFilePath(Application.ExeName);

  WWWRootDirList:=TStringList.Create;


end;

function ProcessUploadFile(WWWRootDir:String;
                           AAppID:String;
                           AFileName:String;
                           AFileExt:String;
                           AFileDir:String;
                           ARequestInfoPostStream:TStream;
                           var ARemoteFilePath:String;
                           var ACode:Integer;
                           var ADesc:String):Boolean;
var
  AUniqeFileName:String;
  AFileSavedDir:String;
  ARelateFileDir:String;
begin
  Result:=False;


//  if (Trim(AAppID)='') then
//  begin
//    ADesc:=('AppID不能为空');
//    Exit;
//  end;
  if (Trim(AFileDir)='') then
  begin
    ADesc:=('FileDir不能为空');
    Exit;
  end;

  if (Trim(AFileExt)='') then
  begin
    ADesc:=('文件名或后缀名不能为空');
    Exit;
  end;


  if (ARequestInfoPostStream<>nil)
    and (ARequestInfoPostStream.Size=0) then
  begin
    ADesc:=('文件内容不能为空');
    Exit;
  end;


  if AAppID<>'' then
  begin
      //生成唯一的文件名
      ARelateFileDir:=GetFileUploadRemotePath(AAppID,AFileDir);

      AFileSavedDir:=WWWRootDir+ARelateFileDir;
      if (AFileName<>'') and not FileExists(AFileSavedDir+AFileName) then
      begin
        AUniqeFileName:=AFileName;
      end
      else
      begin
        AUniqeFileName:=CreateGUIDString+AFileExt;
      end;

  end
  else
  begin
      ARelateFileDir:='webfiles'+PathDelim+AFileDir;

      AFileSavedDir:=WWWRootDir+ARelateFileDir;
      if (AFileName<>'') then
      begin
        AUniqeFileName:=AFileName;
      end
      else
      begin
        AUniqeFileName:=CreateGUIDString+AFileExt;
      end;

  end;



  //FileDir参数表示上传到哪个文件夹
  //一般是Temp,上传的文件都保存到临时目录,
  //上传结束,保存数据的时候再移动到对应的目录中
//  ARelateFileDir:='Upload'+'\'
//                  +AAppID+'\'
//                  +AFileDir+'\'
//                  +FormatDateTime('YYYY',Now)+'\'
//                  +FormatDateTime('YYYY-MM-DD',Now)+'\';
  



  //创建目录
  System.SysUtils.ForceDirectories(AFileSavedDir);
  if Not System.SysUtils.DirectoryExists(AFileSavedDir) then
  begin
    ADesc:=('目录不存在');
    Exit;
  end;



  if ARequestInfoPostStream<>nil then
  begin

      try
          //保存到文件
          ARequestInfoPostStream.Position:=0;
          if ARequestInfoPostStream is TMemoryStream then
          begin
            TMemoryStream(ARequestInfoPostStream).SaveToFile(AFileSavedDir+AUniqeFileName);
          end
          else if ARequestInfoPostStream is TkbmMWMemoryStream then
          begin
            TkbmMWMemoryStream(ARequestInfoPostStream).SaveToFile(AFileSavedDir+AUniqeFileName);
          end
          ;

          ACode:=SUCC;
          ADesc:=('上传文件成功');
          ARemoteFilePath:=ARelateFileDir+AUniqeFileName;
          Result:=True;
      except
        on E:Exception do
        begin
          ADesc:=('保存文件失败 '+E.Message);
        end;
      end;


      {$IFDEF LINUX}
      {$ELSE}
      //如果是图片文件
      if SameText(AFileExt,'.jpg')
        or SameText(AFileExt,'.jpeg')
//        or SameText(AFileExt,'.png')
//        or SameText(AFileExt,'.bmp')
//        or SameText(AFileExt,'.gif')
        then
      begin
          try
            //生成JPG缩略图
            ARequestInfoPostStream.Position:=0;
            GenerateThumbJpegFile(ARequestInfoPostStream,
                                  AFileSavedDir+Const_ThumbPrefix+AUniqeFileName);

            ACode:=SUCC;
          except
            on E:Exception do
            begin
              ADesc:=('生成缩略图失败 '+E.Message);
            end;
          end;
      end;
      {$ENDIF}

  end
  else
  begin
      ADesc:=('文件数据不存在');
  end;

end;


function GetMimeDecoderParam(AMimeDecoder:TIdMessageDecoderMIME;var AName:String;var AFileName:String):Boolean;
var
  AStartIndex:Integer;
begin
  Result:=False;

  //'form-data; name="page_json"; filename="page1.json"'
  //取出name
  AName:=AMimeDecoder.Headers.Values['Content-Disposition'];
  AStartIndex:=Pos('name="',AName);
  AName:=Copy(AName,AStartIndex+Length('name="'),MaxInt);
  AStartIndex:=Pos('"',AName);
  AName:=Copy(AName,1,AStartIndex-1);

  //取出filename
  AFileName:=AMimeDecoder.Headers.Values['Content-Disposition'];
  AStartIndex:=Pos('filename="',AFileName);
  AFileName:=Copy(AFileName,AStartIndex+Length('filename="'),MaxInt);
  AStartIndex:=Pos('"',AFileName);
  AFileName:=Copy(AFileName,1,AStartIndex-1);

  Result:=True;

end;


procedure TdmFileIndyHttpServer.IdHTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  LFilename: string;
  LPathname: string;

  AAppID:String;
  AFileDir:String;
  AFileName:String;
  AFileExt:String;
  AContentType:String;

  ARemoteFilePath:String;

  ACode:Integer;
  ADesc:String;
  ADataJson:ISuperObject;

  AMimeDecoder: TIdMessageDecoder;
  ABodyStream:TMemoryStream;
  AIdHeaderList:TIdHeaderList;
  msgEnd:Boolean;

  ANetHttpClient:TNetHttpClient;
  AUrl:String;
  AIsFileExists:Boolean;
  I: Integer;
begin
//  uBaseLog.HandleException(nil,'TdmFileIndyHttpServer.IdHTTPServerCommandGet Begin');
//  uBaseLog.HandleException(nil,'TdmFileIndyHttpServer.IdHTTPServerCommandGet Document='+ARequestInfo.Document);
//  uBaseLog.HandleException(nil,'TdmFileIndyHttpServer.IdHTTPServerCommandGet Params='+ARequestInfo.Params.Text);


  //浏览器请求http://127.0.0.1:8008/index.html?a=1&b=2
  //ARequestInfo.Document  返回    /index.html
  //ARequestInfo.QueryParams 返回  a=1b=2
  //ARequestInfo.Params.Values['name']   接收get,post过来的数据
  ////webserver发文件
  LFilename := ARequestInfo.Document;

  //允许跨域访问
  AResponseInfo.CustomHeaders.Add('Access-Control-Allow-Origin:*');
  AResponseInfo.CustomHeaders.Add('Access-Control-Allow-Headers:*');
  AResponseInfo.CustomHeaders.Add('Access-Control-Allow-Method:*');


  //浏览器请求http://127.0.0.1:8008/upload?
  //appid=1002&filename=aaa.jpg&filedir=goods_pic&fileext=.jpg
  if SameText(LFilename,'/upload') then
  begin


          //上传文件
          ACode:=FAIL;
          ADesc:='';
          ADataJson:=nil;

          try


                //需要验证APPKey,不然会受攻击
                AAppID:=ARequestInfo.Params.Values['appid'];
                AFileDir:=ARequestInfo.Params.Values['filedir'];

                //filename参数表示保存的文件名,有后缀,但是这个文件名我们不使用
                AFileName:=ARequestInfo.Params.Values['filename'];
                AFileExt:=ARequestInfo.Params.Values['fileext'];
                if AFileExt='' then
                begin
                  AFileExt:=ExtractFileExt(AFileName);
                end;

                ARemoteFilePath:='';
                if ProcessUploadFile(WWWRootDir,
                                     AAppID,
                                     AFileName,
                                     AFileExt,
                                     AFileDir,
                                     ARequestInfo.PostStream,
                                     ARemoteFilePath,
                                     ACode,
                                     ADesc) then
                begin
                  //上传成功
                end;

            finally
                //返回
                ADataJson:=TSuperObject.Create;
                ADataJson.S['RemoteFilePath']:=ARemoteFilePath;
                ADataJson.S['Url']:=ReplaceStr(ARemoteFilePath,'\','/');
                AResponseInfo.ContentText:=ReturnJson(ACode,ADesc,ADataJson).AsJSON;
            end;


  end
  else if SameText(LFilename,'/plupload') then
  begin
          //解决plupload这个JS图片上传控件的跨域问题
          //OPTIONS命令
          AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Origin']:='*';

          ACode:=FAIL;
          ADesc:='';
          ADataJson:=nil;
          try
              //需要验证APPKey,不然会受攻击
              AAppID:=ARequestInfo.Params.Values['appid'];
              AFileDir:=ARequestInfo.Params.Values['filedir'];

              if (Trim(AAppID)='') then
              begin
                ADesc:=('AppID不能为空');
                Exit;
              end;
              if (Trim(AFileDir)='') then
              begin
                ADesc:=('FileDir不能为空');
                Exit;
              end;


              //给plupload这个JS文件上传控件做的接口
              if ARequestInfo.PostStream<>nil then
              begin
                  ARequestInfo.PostStream.Position:=0;
                  //保存到本地测试
          //        TMemoryStream(ARequestInfo.PostStream).SaveToFile('D:\post.txt');


                  //------WebKitFormBoundaryOWWn6zTHJMweb4kk
                  //Content-Disposition: form-data; name="name"
                  //
                  //9A0B3A9D240F2C52CCFA82780B1BB1A5.jpg
                  //------WebKitFormBoundaryOWWn6zTHJMweb4kk

        //Content-Disposition: form-data; name="file"; filename="9A0B3A9D240F2C52CCFA82780B1BB1A5.jpg"
                  //Content-Type: image/jpeg
                  AMimeDecoder := TIdMessageDecoderMIME.Create(nil);
                  try
                    AMimeDecoder.SourceStream:=ARequestInfo.PostStream;
                    AMimeDecoder.FreeSourceStream:=False;
                    //一定要设置MIMEBoundary,不然ReadBody会结束不了,死循环
                    TIdMessageDecoderMIME(AMimeDecoder).MIMEBoundary := Copy(AMimeDecoder.ReadLn(),3,MaxInt);
                    AMimeDecoder.ReadHeader;
                    repeat
                      case AMimeDecoder.PartType of
                        mcptText:
                        begin
                        end;
                        mcptAttachment:
                        begin
                          //获取到name和文件
                          if AMimeDecoder.Headers.Values['Content-Type']<>'' then
                          begin

                              AIdHeaderList:=TIdHeaderList.Create(QuoteRFC822);
                              try
                                AIdHeaderList.AddStrings(AMimeDecoder.Headers);

                                //获取FileName
                                AFileName:=AIdHeaderList.Params['Content-Disposition','filename'];
                                AFileExt:=ExtractFileExt(AFileName);
                                AContentType:=AIdHeaderList.Values['Content-Type'];
                              finally
                                FreeAndNil(AIdHeaderList);
                              end;


                              ABodyStream:=TMemoryStream.Create;
                              try

                                //如果Encoding为空,那么Decoder.ReadBody默认为7bit格式读取
                                //但是plupload上传的是8bit格式的,所以要指定
                                if AMimeDecoder.Headers.Values['Content-Transfer-Encoding']='' then
                                begin
                                  AMimeDecoder.Headers.Values['Content-Transfer-Encoding']:='8bit';
                                end;
                                AMimeDecoder.ReadBody(ABodyStream,msgEnd);


                                ARemoteFilePath:='';
                                if ProcessUploadFile(WWWRootDir,
                                                     AAppID,
                                                     AFileName,
                                                     AFileExt,
                                                     AFileDir,
                                                     ABodyStream,
                                                     ARemoteFilePath,
                                                     ACode,
                                                     ADesc) then
                                begin
                                  //上传成功
                                end;


                                //暂时只支持同时上传一个文件
                                Break;

                              finally
                                FreeAndNil(ABodyStream);
                              end;
                          end;
                        end;
                        mcptIgnore: ;
                        mcptEOF:
                        begin
                          Break;
                        end;
                      end;

                      if AMimeDecoder.PartType<>mcptEOF then
                      begin
                        AMimeDecoder.Headers.Clear;
                        AMimeDecoder.ReadHeader;
                      end;

                    until AMimeDecoder.PartType=mcptEOF;

                  finally
                    FreeAndNil(AMimeDecoder);
                  end;

              end
              else
              begin
                ADesc:=('文件内容不能为空');
                Exit;
              end;
          finally
            //返回
            ADataJson:=TSuperObject.Create;
            ADataJson.S['RemoteFilePath']:=ARemoteFilePath;
            ADataJson.S['Url']:=ReplaceStr(ARemoteFilePath,'\','/');
            AResponseInfo.ContentText:=ReturnJson(ACode,ADesc,ADataJson).AsJSON;
          end;

  end
  else if SameText(LFilename,'/get_web_url') then
  begin
          AUrl:=EncdDecd.DecodeString(ARequestInfo.Params.Values['url']);
          if AUrl<>'' then
          begin
            ANetHttpClient:=TNetHttpClient.Create(nil);
            AResponseInfo.ContentStream:=TMemoryStream.Create;
            try
              try
                ANetHttpClient.Get(AUrl,AResponseInfo.ContentStream);
              except
                on E:Exception do
                begin
                  uBaseLog.HandleException(E,'TdmFileIndyHttpServer.IdHTTPServerCommandGet ANetHttpClient.Get '+AUrl);
                end;
              end;
            finally
              FreeAndNil(ANetHttpClient);
            end;
          end;
  end
  else
  begin

          //下载图片

          //请求文件
          if LFilename = '/' then
          begin
            LFilename := 'index.html';
          end;
          LFilename:=ReplaceStr(LFilename,'/','\');

          if LFilename[1]='\' then
          begin
            LFilename:=Copy(LFilename,2,MaxInt);
          end;

          LPathname := WWWRootDir + LFilename;
          AIsFileExists:=FileExists(LPathname);
          if not AIsFileExists then
          begin
              for I := 0 to Self.WWWRootDirList.Count-1 do
              begin
                LPathname := WWWRootDirList[I] + LFilename;
                AIsFileExists:=FileExists(LPathname);
                if AIsFileExists then
                begin
                  Break;
                end;
              end;
          end;
          
          if AIsFileExists then
          begin

            //D:\MyFiles\OrangeUIProduct\济胜汽修接车APP\Server\Win32\Debug\Upload\1003\Update\emp\Version.ini
            //D:\MyFiles\OrangeUIProduct\OpenPlatform\Server\Win32\Debug\Upload\1003\Update\emp
//              uBaseLog.HandleException(nil,'TdmFileIndyHttpServer.IdHTTPServerCommandGet 文件存在');
              try


                  if (LowerCase(ExtractFileExt(LFilename))='.jpg') or (LowerCase(ExtractFileExt(LFilename))='.jpeg') then
                  begin
                    AResponseInfo.ContentType:='image/jpeg';
                    AResponseInfo.ContentStream := TFileStream.Create(LPathname, fmOpenRead + fmShareDenyWrite);//发文件
                  end
                  else if (LowerCase(ExtractFileExt(LFilename))='.png') then
                  begin
                    AResponseInfo.ContentType:='image/png';
                    AResponseInfo.ContentStream := TFileStream.Create(LPathname, fmOpenRead + fmShareDenyWrite);//发文件
                  end
                  else //if (LowerCase(ExtractFileExt(LFilename))='.csv') then //在网页上点击能下载，而不是直接在页面中显示内容
                  begin
                    //不能什么文件都能下载,提高安全性
                    { TODO : 不能什么文件都能下载,提高安全性 }
                    //AResponseInfo.ContentType:='application/octet-stream';

                    AResponseInfo.ResponseNo := 404;
                    AResponseInfo.ContentText := '找不到' + ARequestInfo.Document;

                  end;
              except
                on E:Exception do
                begin
                  uBaseLog.HandleException(E,'TdmFileIndyHttpServer.IdHTTPServerCommandGet');
                end;
              end;

          end
          else
          begin
//              uBaseLog.HandleException(nil,'TdmFileIndyHttpServer.IdHTTPServerCommandGet 文件不存在');
              AResponseInfo.ResponseNo := 404;
              AResponseInfo.ContentText := '找不到' + ARequestInfo.Document;
          end;

  end;

//  uBaseLog.HandleException(nil,'TdmFileIndyHttpServer.IdHTTPServerCommandGet End');
end;

procedure TdmFileIndyHttpServer.IdHTTPServerCommandOther(
  AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo);
begin
  //解决plupload这个JS图片上传控件的跨域问题
  //OPTIONS命令
  //AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Origin']:='*';

  //允许跨域访问
  AResponseInfo.CustomHeaders.Add('Access-Control-Allow-Origin:*');
  AResponseInfo.CustomHeaders.Add('Access-Control-Allow-Headers:*');
  AResponseInfo.CustomHeaders.Add('Access-Control-Allow-Method:*');

end;

procedure TdmFileIndyHttpServer.IdHTTPServerDoneWithPostStream(
  AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
  var VCanFree: Boolean);
begin
  VCanFree:=False;
end;

procedure TdmFileIndyHttpServer.IdHTTPServerQuerySSLPort(APort: Word;
  var VUseSSL: Boolean);
begin
  //判断哪个端口使用SSL,
  VUseSSL:=False;
  if APort=FSSLPort then
  begin
    VUseSSL:=True;
  end;
end;

procedure TdmFileIndyHttpServer.SetPort(ADefaultPort, ASSLPort: Word);
begin
  FSSLPort:=ASSLPort;

  IdHTTPServer.Bindings.Clear;

  //默认HTTP端口
  IdHTTPServer.Bindings.Add.Port:=ADefaultPort;

  if ASSLPort<>0 then
  begin
    //支持HTTPS
    IdHTTPServer.Bindings.Add.Port:=ASSLPort;
  end;

end;

function TdmFileIndyHttpServer.SetSSL(AEnable: Boolean):Boolean;
begin
  Result:=False;

  if AEnable then
  begin
        if DirectoryExists(WWWRootDir+'SSLCert')
          and FileExists(WWWRootDir+'SSLCert\'+'server.crt')
          and FileExists(WWWRootDir+'SSLCert\'+'server.key')
          and FileExists(WWWRootDir+'SSLCert\'+'server-ca.crt')
           then
        begin
          IdServerIOHandlerSSLOpenSSL1.SSLOptions.CertFile := WWWRootDir+'SSLCert\'+'server.crt';
          IdServerIOHandlerSSLOpenSSL1.SSLOptions.KeyFile := WWWRootDir+'SSLCert\'+'server.key';
          IdServerIOHandlerSSLOpenSSL1.SSLOptions.RootCertFile := WWWRootDir+'SSLCert\'+'server-ca.crt';

          IdServerIOHandlerSSLOpenSSL1.SSLOptions.Method := sslvSSLv23;//sslvTLSv1_2;
          IdServerIOHandlerSSLOpenSSL1.SSLOptions.Mode := sslmServer;

          IdServerIOHandlerSSLOpenSSL1.SSLOptions.VerifyDepth := 1;
          //加了会报错
//          IdServerIOHandlerSSLOpenSSL1.SSLOptions.VerifyMode := [sslvrfPeer,sslvrfFailIfNoPeerCert,sslvrfClientOnce];
          IdServerIOHandlerSSLOpenSSL1.SSLOptions.VerifyDirs:=WWWRootDir+'SSLCert\';


          IdHTTPServer.IOHandler:=IdServerIOHandlerSSLOpenSSL1;
        end;

  end
  else
  begin
        IdHTTPServer.IOHandler:=nil;
        Result:=True;
  end;
end;

destructor TdmFileIndyHttpServer.Destroy;
begin
  FreeAndNil(WWWRootDirList);
  inherited;
end;

procedure TdmFileIndyHttpServer.IdFileHTTPServerHeadersAvailable(
  AContext: TIdContext; const AUri: string; AHeaders: TIdHeaderList;
  var VContinueProcessing: Boolean);
begin
  //解决跨域的问题
  AHeaders.Values['Access-Control-Allow-Origin']:='*';
end;

end.
