unit iOSQRCodeScanForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  uSkinButtonType, uSkinFireMonkeyButton, uSkinFireMonkeyControl,
//  uSkinMeDM7ZBarView,

  uFuncCommon,
  uFileCommon,
  System.IOUtils,

  {$IFDEF IOS}
  iOSapi.AVFoundation,


  //{$IFDEF HAS_IOSBARCODE}
  uSDKVersion,
  iOSapi.BarCode,
  //{$ENDIF HAS_IOSBARCODE}


  Macapi.Helpers,
  Macapi.ObjectiveC, Macapi.Dispatch, Macapi.CoreFoundation, iOSapi.Foundation,
  iOSapi.CocoaTypes, iOSapi.CoreGraphics, iOSapi.CoreMedia, iOSapi.QuartzCore,
  iOSapi.CoreVideo,
  FMX.Platform.iOS,
  iOSApi.UIKit,
  {$ENDIF IOS}

  uSkinPanelType, uSkinFireMonkeyPanel, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Media;

type
//  //扫描结果返回事件
//  TScanResultEvent=procedure(Sender:TObject;
//                            AResult:String;
//                            AFormat:String
//                            ) of object;



  {$IFDEF IOS}
    //{$IFDEF HAS_IOSBARCODE}
    TAVCaptureMetadataOutputObjectsDelegate = class(TOCLocal, AVCaptureMetadataOutputObjectsDelegate)
      [MethodName('captureOutput:didOutputMetadataObjects:fromConnection:')]
      procedure captureOutputdidOutputMetadataObjects(captureOutput: AVCaptureOutput; metadataObjects: NSArray; connection: AVCaptureConnection); cdecl;
    end;
    //{$ENDIF HAS_IOSBARCODE}

  {$ENDIF IOS}



  TfrmiOSQRCodeScan = class(TForm)
    pnlToolBar: TSkinFMXPanel;
    btnReturn: TSkinFMXButton;
    pnlClient: TPanel;
    MediaPlayer1: TMediaPlayer;
    procedure btnReturnClick(Sender: TObject);
  private
    {$IFDEF IOS}
//    FParentView:UIView;

    device:AVCaptureDevice;
    input:AVCaptureDeviceInput;
    ObjectTypes:NSMutableArray;
    session:AVCaptureSession;
    layer:AVCaptureVideoPreviewLayer;

    //{$IFDEF HAS_IOSBARCODE}
      output:AVCaptureMetadataOutput;
      Delegate:TAVCaptureMetadataOutputObjectsDelegate;
    //{$ENDIF HAS_IOSBARCODE}

//    procedure DoRequestAccessForMediaTypecompletionHandler(granted:Boolean);
    procedure DocaptureOutputdidOutputMetadataObjects(captureOutput: AVCaptureOutput; metadataObjects: NSArray; connection: AVCaptureConnection); cdecl;
    {$ENDIF IOS}
    { Private declarations }
  public
    FOnScanResult:TScanResultEvent;

    procedure StartScan;
    procedure StopScan;
    { Public declarations }
  end;

var
  frmiOSQRCodeScan: TfrmiOSQRCodeScan;

implementation

{$R *.fmx}

{ TfrmiOSQRCodeScan }

procedure TfrmiOSQRCodeScan.StartScan;
var
  ARect:TRectF;
  AColor:Integer;
//  AJCameraPreview:JCameraPreview;
begin
    {$IFDEF IOS}
        //{$IFDEF HAS_IOSBARCODE}
        //设置代理 在主线程里刷新
        if Delegate=nil then
        begin



            // Do any additional setup after loading the view, typically from a nib.
            //获取摄像设备
            device := TAVCaptureDevice.Wrap(TAVCaptureDevice.OCClass.defaultDeviceWithMediaType(AVMediaTypeVideo));
            //创建输入流
            input :=TAVCaptureDeviceInput.Wrap(TAVCaptureDeviceInput.OCClass.deviceInputWithDevice(device, nil));
            //创建输出流
            output := TAVCaptureMetadataOutput.Wrap(TAVCaptureMetadataOutput.Wrap(TAVCaptureMetadataOutput.OCClass.alloc).init);


            FMX.Types.Log.d('OrangeUI TOrangeScan.DoStartScan 1');


            Delegate:=TAVCaptureMetadataOutputObjectsDelegate.Create;//(Self);
            output.setMetadataObjectsDelegateWithqueue((Delegate as ILocalObject).GetObjectID, dispatch_get_main_queue);


            FMX.Types.Log.d('OrangeUI TOrangeScan.DoStartScan 2');

            //初始化链接对象
            session := TAVCaptureSession.Create;
            //高质量采集率
            session.setSessionPreset(AVCaptureSessionPresetHigh);
            session.addInput(input);
            session.addOutput(output);


            FMX.Types.Log.d('OrangeUI TOrangeScan.DoStartScan 3');


            //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
            ObjectTypes:=TNSMutableArray.Create;
            ObjectTypes.addObject((AVMetadataObjectTypeQRCode as ILocalObject).GetObjectID);
            ObjectTypes.addObject((AVMetadataObjectTypeEAN13Code as ILocalObject).GetObjectID);
            ObjectTypes.addObject((AVMetadataObjectTypeEAN8Code as ILocalObject).GetObjectID);
            ObjectTypes.addObject((AVMetadataObjectTypeCode128Code as ILocalObject).GetObjectID);
          ////  ObjectTypes.addObject((AVMetadataObjectTypeQRCode as ILocalObject).GetObjectID);
            output.setMetadataObjectTypes(ObjectTypes);


            FMX.Types.Log.d('OrangeUI TOrangeScan.DoStartScan 4');


            layer := TAVCaptureVideoPreviewLayer.Wrap(TAVCaptureVideoPreviewLayer.OCClass.layerWithSession(session));
            layer.setVideoGravity(AVLayerVideoGravityResizeAspectFill);

            FMX.Types.Log.d('OrangeUI TOrangeScan.DoStartScan 5');





            ARect := TRectF.Create(0, 0, pnlClient.Width, pnlClient.Height);
            ARect.Fit(pnlClient.AbsoluteRect);
            layer.setFrame(CGRectFromRect(ARect));



            //FParentView.layer.insertSublayer(layer, 0);
            WindowHandleToPlatform(Handle).View.layer.insertSublayer(layer, 0);


            FMX.Types.Log.d('OrangeUI TOrangeScan.DoStartScan 6');

        end;

        //开始捕获
        session.startRunning;
        //{$ENDIF HAS_IOSBARCODE}
    {$ENDIF IOS}

end;

procedure TfrmiOSQRCodeScan.StopScan;
begin
    {$IFDEF IOS}
  if session<>nil then
  begin
    FMX.Types.Log.d('OrangeUI TOrangeScan.CloseScan begin');

    session.stopRunning;
    session.removeInput(input);
    //{$IFDEF HAS_IOSBARCODE}
      session.removeOutput(output);
    //{$ENDIF HAS_IOSBARCODE}

    device:=nil;
    input:=nil;
    //{$IFDEF HAS_IOSBARCODE}
      output:=nil;
    //{$ENDIF HAS_IOSBARCODE}


    FMX.Types.Log.d('OrangeUI TOrangeScan.CloseScan 1');
    layer.setFrame(CGRectFromRect(RectF(0,0,1,1)));

    FMX.Types.Log.d('OrangeUI TOrangeScan.CloseScan 2');
    layer.removeFromSuperlayer;


    layer:=nil;
    session:=nil;

    //{$IFDEF HAS_IOSBARCODE}
      FreeAndNil(Delegate);
    //{$ENDIF HAS_IOSBARCODE}

    FMX.Types.Log.d('OrangeUI TOrangeScan.CloseScan end');
  end;

    {$ENDIF IOS}
end;

procedure TfrmiOSQRCodeScan.btnReturnClick(Sender: TObject);
begin
  StopScan;
  Close;
end;

    {$IFDEF IOS}
procedure TfrmiOSQRCodeScan.DocaptureOutputdidOutputMetadataObjects(
  captureOutput: AVCaptureOutput; metadataObjects: NSArray;
  connection: AVCaptureConnection);
  //{$IFDEF HAS_IOSBARCODE}
var
  metadataObject:AVMetadataMachineReadableCodeObject;
  info:string;
  AIsNeedContinue:Boolean;
  //{$ENDIF HAS_IOSBARCODE}
begin
  //{$IFDEF HAS_IOSBARCODE}
  if (metadataObjects <>nil) and (metadataObjects.count > 0) then
  begin
      metadataObject :=TAVMetadataMachineReadableCodeObject.Wrap(metadataObjects.objectAtIndex(0));
      //输出扫描字符串 metadataObject.stringValue
      FMX.Types.Log.d('OrangeUI TAVCaptureMetadataOutputObjectsDelegate.captureOutputdidOutputMetadataObjects '+NSStrToStr(metadataObject.stringValue));

      MediaPlayer1.FileName:=GetApplicationPath+'scan_succeeded.mp3';
      MediaPlayer1.Play;

      AIsNeedContinue:=False;
      if Assigned(FOnScanResult) then
      begin
        FOnScanResult(Self,NSStrToStr(metadataObject.stringValue),
                            '',AIsNeedContinue);
      end;


      StopScan;
      Close;

  //   [session stopRunning];
  //    Self.session.stopRunning;
  //    ShowMessage(NSStrToStr(metadataObject.stringValue));
  end;
  //{$ENDIF HAS_IOSBARCODE}
end;
    {$ENDIF IOS}

    {$IFDEF IOS}
{ TAVCaptureMetadataOutputObjectsDelegate }

  //{$IFDEF HAS_IOSBARCODE}
  procedure TAVCaptureMetadataOutputObjectsDelegate.captureOutputdidOutputMetadataObjects(
    captureOutput: AVCaptureOutput; metadataObjects: NSArray;
    connection: AVCaptureConnection);
  begin
    frmiOSQRCodeScan.DocaptureOutputdidOutputMetadataObjects(captureOutput,metadataObjects,connection);
  end;
  //{$ENDIF HAS_IOSBARCODE}
    {$ENDIF IOS}

end.
