unit uBaseSystemTTS;

interface


uses
  SysUtils,
  Classes,
  uBaseLog,
  SyncObjs,
//  FMX.Types,
//  FMX.Dialogs,
//  FMX.Forms,

  TextToSpeak,



//  {$IFDEF SKIN_SUPEROBJECT}
//  uSkinSuperObject,
//  {$ELSE}
//  XSuperObject,
//  XSuperJson,
//  {$ENDIF}


//  uComponentType,
  uBaseList,
//  uBasePageStructure,


//  TextToSpeak,

  {$IFDEF ANDROID}
  //需要引入的单元
//  FMX.Helpers.Android,
  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.Jni.JavaTypes,
  //Androidapi.JNI.TTS,

  //Delphi 11
  Androidapi.JNI.Speech,
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  SpeechLib_TLB,
  ActiveX,
  {$ENDIF}

  StrUtils;

type
  TBaseTTS=class;


  TSpeakText=class
    Text:String;
    Delay:Integer;
    Times:Integer;
    constructor Create;
  end;
  TSpeakTextList=class(TBaseList)
  private
    function GetItem(Index: Integer): TSpeakText;
  public
    property Items[Index:Integer]:TSpeakText read GetItem;default;
  end;


  
  //语音播放线程
  TPlayerThread=class(TThread)
  protected
    FBaseTTS:TBaseTTS;
    procedure Execute;override;
  end;



  {$IFDEF ANDROID}
  //倾听者
  TttsOnInitListener = class(TJavaLocal, JTextToSpeech_OnInitListener)
  private
    FBaseTTS: TBaseTTS;
  public
    constructor Create(ABaseTTS: TBaseTTS);
  public
    procedure onInit(status: Integer); cdecl;
  end;
  {$ENDIF}

  TTTSInitErrorEvent=procedure(Sender:TObject;AErrorCode:Integer;AErrorMessage:String) of object;

  TBaseTTS=class(TComponent)
  protected
    FPlayerThread:TPlayerThread;

    //播放次数,有些地方要播放好几遍，比如医院叫号
    FRepeatTimes:Integer;

    //要播放的文本
    FTextListLock:TCriticalSection;
    FTextList:TSpeakTextList;

    FText: String;
    procedure SetText(const Value: String);

  public
    {$IFDEF ANDROID}
    FTtsListener: TttsOnInitListener;//倾听者私有对象
    FTTS: JTextToSpeech;//文字TO言语
    {$ENDIF}
  public
    {$IFDEF MSWINDOWS}
    FSpeechVoice:ISpeechVoice;
    {$ENDIF}
  public
    {$IFDEF IOS}
    FSpeechVoice:TSpeakVoice;
    {$ENDIF}

  public
    //TTS引擎会初始失败,所以要提示出来，安装一下三方的引擎
    OnInitError:TTTSInitErrorEvent;
    FIsInitError:Boolean;
    FIsInited:Boolean;
    procedure DoInitError(AErrorCode:Integer;AErrorMessage:String);
    function Init:Boolean;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
  public

    function IsSpeaking:Boolean;
    function Play(AText:String;
                  ADelay:Integer=0;
                  ATimes:Integer=1):Boolean;
    function DirectPlay(AText:String):Boolean;
    procedure Stop;
  published
    property Text:String read FText write SetText;
    property RepeatTimes:Integer read FRepeatTimes write FRepeatTimes;
  end;



implementation



{$IFDEF ANDROID}

{ TttsOnInitListener }

constructor TttsOnInitListener.Create(ABaseTTS: TBaseTTS);
begin
  Inherited Create;

  FBaseTTS:=ABaseTTS;
end;

procedure TttsOnInitListener.onInit(status: Integer);
var
  Result: Integer;
begin
  uBaseLog.HandleException(nil,'TttsOnInitListener.onInit');

  if (status = TJTextToSpeech.JavaClass.SUCCESS) then
  begin
    uBaseLog.HandleException(nil,'TttsOnInitListener.onInit SUCC');

    FBaseTTS.FIsInitError:=False;

//      try
//          Result := FBaseTTS.FTTS.setLanguage(TJLocale.JavaClass.US); // 这是指定这美语
//
//          if (Result = TJTextToSpeech.JavaClass.LANG_MISSING_DATA) or
//            (Result = TJTextToSpeech.JavaClass.LANG_NOT_SUPPORTED) then
//          begin
//            //这里在XE10.1中提示“只能在主线程中使用此提示”
//          end
//          else
//          begin
//      //      ShowMessage('初始化成功！')
//          end;
//      except
//        on E:Exception do
//        begin
//          uBaseLog.HandleException(E,'TttsOnInitListener.onInit');
//        end;
//      end;

  end
  else
  begin
    uBaseLog.HandleException(nil,'TttsOnInitListener.onInit FAIL status:'+IntToStr(status));

//    ShowMessage('初始化失败！');


    FBaseTTS.DoInitError(status,'');


  end;


end;
{$ENDIF}

{ TBaseTTS }

constructor TBaseTTS.Create(AOwner:TComponent);
begin
  Inherited;

  {$IFDEF ANDROID}
  FTtsListener := TttsOnInitListener.Create(self);
  {$ENDIF}

  FTextListLock:=TCriticalSection.Create;
  FTextList:=TSpeakTextList.Create;




  FRepeatTimes:=1;
end;

destructor TBaseTTS.Destroy;
begin

  if FPlayerThread<>nil then
  begin
    FPlayerThread.Terminate;
    FPlayerThread.WaitFor;
    FreeAndNil(FPlayerThread);
  end;


  {$IFDEF ANDROID}
  try
      if Assigned(FTTS) then
      begin
        FTTS.stop;
        FTTS.shutdown;
        FTTS := nil;
      end;
      FTtsListener := nil;
  except
    on E:Exception do
    begin
      uBaseLog.HandleException(E,'FormDestroy FTTS');
    end;
  end;
  {$ENDIF}


  {$IFDEF IOS}
  FreeAndNil(FSpeechVoice);
  {$ENDIF}


  FreeAndNil(FTextList);
  FreeAndNil(FTextListLock);

  inherited;
end;


function TBaseTTS.DirectPlay(AText: String): Boolean;
begin
//  {$IFDEF FREE_VERSION}
//  ShowMessage('三方SDK免费版限制');
//  {$ENDIF}



  Result:=False;

  if not FIsInited then
  begin
    if not Init then Exit;
  end;


  {$IFDEF ANDROID}
  if FTTS<>nil then
  begin
    uBaseLog.HandleException(nil,'TBaseTTS.DirectPlay SpeakOut FTTS.speak '+AText);
    Self.FTTS.speak(StringToJString(AText), TJTextToSpeech.JavaClass.QUEUE_FLUSH, nil);
  end;
  {$ENDIF}


  {$IFDEF MSWINDOWS}
  if FSpeechVoice<>nil then
  begin
//    FSpeechVoice.Volume
    try
      FSpeechVoice.Speak(AText,0);
    except
      on E:Exception do
      begin
        uBaseLog.HandleException(nil,'TBaseTTS.DirectPlay SpeakOut FTTS.speak '+AText);
      end;
    end;
  end;
  {$ENDIF}



  {$IFDEF IOS}
  FSpeechVoice.Text:=AText;
  FSpeechVoice.SpeakText;
  {$ENDIF}


  Result:=True;
end;


procedure TBaseTTS.DoInitError(AErrorCode: Integer; AErrorMessage: String);
begin
  FIsInitError:=True;
  if Assigned(Self.OnInitError) then
  begin
    Self.OnInitError(Self,AErrorCode,AErrorMessage);
  end;

end;

function TBaseTTS.Init:Boolean;
begin
  Result:=False;

  if Self.FIsInited and not Self.FIsInitError then
  begin
    Result:=True;
    Exit;
  end;

  {$IFDEF ANDROID}
  if (FTTS=nil) then
  begin
    try
      FTTS := TJTextToSpeech.JavaClass.init(SharedActivityContext, FTtsListener);
      Result:=True;
    except
      on E:Exception do
      begin
        uBaseLog.HandleException(E,'TBaseTTS.DirectPlay Init FTTS init');
        Self.DoInitError(0,E.Message);
      end;
    end;
  end
  else
  begin
    Result:=True;
  end;
  {$ENDIF}


  {$IFDEF MSWINDOWS}
  if (FSpeechVoice=nil)  then
  begin
    try
      FSpeechVoice:=CoSpVoice.Create;
      Result:=True;
      FIsInitError:=False;

//      Self.DoInitError(0,'初始失败');
    except
      on E:Exception do
      begin
        uBaseLog.HandleException(E,'TBaseTTS.DirectPlay Init FTTS init');
        Self.DoInitError(0,E.Message);
      end;
    end;
  end
  else
  begin
    Result:=True;
  end;
  {$ENDIF}



  {$IFDEF IOS}
  if (FSpeechVoice=nil) then
  begin
      try
        FSpeechVoice:=TSpeakVoice.Create;
        FSpeechVoice.Rate:=50;
  //    FSpeechVoice.
        Result:=True;

        FIsInitError:=False;
      except
        on E:Exception do
        begin
          uBaseLog.HandleException(E,'TBaseTTS.DirectPlay Init FTTS init');
          Self.DoInitError(0,E.Message);
        end;
      end;
  end
  else
  begin
      Result:=True;
  end;
  {$ENDIF}


  FIsInited:=True;


end;

function TBaseTTS.IsSpeaking: Boolean;
begin
  Result:=False;

  {$IFDEF ANDROID}
  ReSult:=(Self.FTTS<>nil) and Self.FTTS.isSpeaking;
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  Result:=(FSpeechVoice<>nil) and (FSpeechVoice.Status.RunningState=SRSEIsSpeaking);
  {$ENDIF}
end;


function TBaseTTS.Play(AText: String;
                  ADelay:Integer=0;
                  ATimes:Integer=1): Boolean;
var
  ASpeakText:TSpeakText;
begin
  Result:=False;

  if Trim(AText)='' then Exit;

  ASpeakText:=TSpeakText.Create;
  ASpeakText.Text:=AText;
  ASpeakText.Delay:=ADelay;
  ASpeakText.Times:=ATimes;


  FTextList.Add(ASpeakText);

  if not FIsInited then
  begin
    if not Init then
    begin
  //    ShowMessage('语音引擎初始失败!');
      Exit;
    end;
  end;


  if FPlayerThread=nil then
  begin
    Self.FPlayerThread:=TPlayerThread.Create(True);
    Self.FPlayerThread.FBaseTTS:=Self;
    Self.FPlayerThread.Start;
  end;

  Result:=True;
end;

procedure TBaseTTS.SetText(const Value: String);
begin
  if FText<>Value then
  begin
    FText := Value;

    Self.Play(FText);
  end;
end;

procedure TBaseTTS.Stop;
begin
//  {$IFDEF FREE_VERSION}
//  ShowMessage('三方SDK免费版限制');
//  {$ENDIF}




  if not Init then Exit;


  {$IFDEF ANDROID}
  if FTTS<>nil then
  begin
    uBaseLog.HandleException(nil,'SpeakOut FTTS.Stop ');
    Self.FTTS.stop;
  end;
  {$ENDIF}


  {$IFDEF MSWINDOWS}
  if FSpeechVoice<>nil then
  begin
//    FSpeechVoice.Volume
    try
      FSpeechVoice.Pause;
    except

    end;
  end;
  {$ENDIF}



  {$IFDEF IOS}
  FSpeechVoice.StopSpeakText;
  {$ENDIF}



end;

{ TPlayerThread }

procedure TPlayerThread.Execute;
var
  I:Integer;
  ARemind:TSpeakText;
begin

  {$IFDEF MSWINDOWS}
  CoInitialize(nil);
  {$ENDIF}
  try
      while Not Self.Terminated do
      begin
        try



            //取第一条通知
            ARemind:=nil;
            FBaseTTS.FTextListLock.Enter;
            try
              if FBaseTTS.FTextList.Count>0 then
              begin
                ARemind:=FBaseTTS.FTextList[0];
                FBaseTTS.FTextList.Delete(0,False);
              end;
            finally
              FBaseTTS.FTextListLock.Leave;
            end;


        
            if ARemind<>nil then
            begin
                //重复播放一定的次数
//                FMX.Types.Log.d('OrangeUI --speaking--FRepeatTimes'+IntToStr(FBaseTTS.FRepeatTimes));
                for I := 0 to FBaseTTS.FRepeatTimes-1 do
                begin

                    try

                        if ARemind.Delay>0 then
                        begin
                          Sleep(ARemind.Delay);
                        end;



                        FBaseTTS.DirectPlay(ARemind.Text);

                        //直接Sleep的话  加入文本在2秒内读不完  就会断句
                        while FBaseTTS.IsSpeaking do
                        begin
                          Sleep(1000);
                        end;


                        Sleep(1000);

                    except
                      on E:Exception do
                      begin
                        uBaseLog.HandleException(E,'SpeakOut FTTS.speak');
                        Sleep(1000);
                      end;
                    end;

                end;

                FreeAndNil(ARemind);
            end;


            if FBaseTTS.FTextList.Count=0 then
            begin
              Sleep(1000);
            end;

        except
          on E:Exception do
          begin
            uBaseLog.HandleException(E,'TPlayerThread.Execute');
            Sleep(1000);
          end;
        end;
      end;
  finally
    {$IFDEF MSWINDOWS}
    CoUnInitialize();
    {$ENDIF}
  end;
end;



{ TSpeakTextList }

function TSpeakTextList.GetItem(Index: Integer): TSpeakText;
begin
  Result:=TSpeakText(Inherited Items[Index]);
end;



{ TSpeakText }

constructor TSpeakText.Create;
begin
  Times:=1;
end;



end.
