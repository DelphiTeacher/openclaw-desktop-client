unit uOpenAIStreamServerHelper;

interface

uses
  IdContext, IdCustomHTTPServer, IdHTTPServer, System.SysUtils, System.Classes,
  System.JSON, System.Generics.Collections;


procedure SendSSEData(AContext: TIdContext; const AData: string);
procedure SendSSEEvent(AContext: TIdContext; const AEvent, AData: string);
procedure SendSSEComplete(AContext: TIdContext);

procedure WriteChunk(AContext: TIdContext; const S: UTF8String);


implementation


//procedure TOpenAIStreamHandler.HandleChatCompletion(AContext: TIdContext;
//  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
//var
//  LJSON, LMessage: TJSONObject;
//  LMessages: TJSONArray;
//  LStream: Boolean;
//  LModel, LContent: string;
//  LChar: Char;
//  I, J: Integer;
//  LDelta: TJSONObject;
//  LChoice: TJSONObject;
//begin
//  // 只处理 POST /v1/chat/completions
//  if (ARequestInfo.Command <> 'POST') or
//     (ARequestInfo.Document <> '/v1/chat/completions') then
//  begin
//    AResponseInfo.ResponseNo := 404;
//    Exit;
//  end;
//
//  try
//    // 解析请求 JSON
//    LJSON := TJSONObject.ParseJSONValue(ARequestInfo.PostStream) as TJSONObject;
//    try
//      LStream := False;
//      if LJSON.GetValue('stream') is TJSONBool then
//        LStream := TJSONBool(LJSON.GetValue('stream')).AsBoolean;
//
//      LModel := 'gpt-3.5-turbo';
//      if LJSON.GetValue('model') <> nil then
//        LModel := LJSON.GetValue('model').Value;
//
//      LMessages := LJSON.GetValue('messages') as TJSONArray;
//
//      // 提取用户消息（简化示例，取最后一条）
//      if LMessages.Count > 0 then
//      begin
//        LMessage := LMessages.Items[LMessages.Count - 1] as TJSONObject;
//        LContent := LMessage.GetValue('content').Value;
//      end;
//
//      // 流式响应
//      if LStream then
//      begin
//        AResponseInfo.ContentType := 'text/event-stream';
//        AResponseInfo.CacheControl := 'no-cache';
//        AResponseInfo.Connection := 'keep-alive';
//        AResponseInfo.WriteHeader;
//
//        // 发送 SSE 格式的响应
//        SendSSEEvent(AContext, '', '{"id":"chatcmpl-123","object":"chat.completion.chunk","created":1677652288,"model":"' + LModel + '","choices":[{"index":0,"delta":{"role":"assistant"},"finish_reason":null}]}' + #13#10);
//
//        // 模拟流式返回消息内容
//        for I := 1 to Length(LContent) do
//        begin
//          LChar := LContent[I];
//
//          // 构建 delta 响应
//          LDelta := TJSONObject.Create;
//          LChoice := TJSONObject.Create;
//          try
//            LDelta.AddPair('content', LChar);
//
//            LChoice.AddPair('index', TJSONNumber.Create(0));
//            LChoice.AddPair('delta', LDelta);
//            LChoice.AddPair('finish_reason', TJSONNull.Create);
//
//            SendSSEEvent(AContext, '',
//              '{"id":"chatcmpl-123","object":"chat.completion.chunk","created":1677652288,"model":"' + LModel + '","choices":[' + LChoice.ToJSON + ']}' + #13#10);
//
//            Sleep(50); // 模拟生成延迟
//          finally
//            LDelta.Free;
//            LChoice.Free;
//          end;
//        end;
//
//        // 发送结束标记
//        SendSSEEvent(AContext, '', '{"id":"chatcmpl-123","object":"chat.completion.chunk","created":1677652288,"model":"' + LModel + '","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}' + #13#10);
//        SendSSEEvent(AContext, '', '[DONE]' + #13#10);
//      end
//      else
//      begin
//        // 非流式响应
//        AResponseInfo.ContentType := 'application/json';
//        AResponseInfo.ContentText :=
//          '{"id":"chatcmpl-123","object":"chat.completion","created":1677652288,"model":"' + LModel + '","choices":[{"index":0,"message":{"role":"assistant","content":"' + LContent + '"},"finish_reason":"stop"}]}';
//      end;
//    finally
//      LJSON.Free;
//    end;
//  except
//    on E: Exception do
//    begin
//      AResponseInfo.ResponseNo := 500;
//      AResponseInfo.ContentText := '{"error":"' + E.Message + '"}';
//    end;
//  end;
//end;

procedure WriteChunk(AContext: TIdContext; const S: UTF8String);
var
  Chunk: UTF8String;
begin
  Chunk :=
    IntToHex(Length(S), 1) + #13#10 +
    S + #13#10;

  AContext.Connection.IOHandler.Write(Chunk);
  AContext.Connection.IOHandler.WriteBufferFlush;
end;

procedure SendSSEData(AContext: TIdContext; const AData: string);
begin
  AContext.Connection.IOHandler.Write('data: ' + AData + #13#10#13#10);
  AContext.Connection.IOHandler.WriteBufferFlush;
end;

procedure SendSSEEvent(AContext: TIdContext;
  const AEvent, AData: string);
begin
  if AEvent <> '' then
    AContext.Connection.IOHandler.Write('event: ' + AEvent + #13#10);
  AContext.Connection.IOHandler.Write('data: ' + AData + #13#10#13#10);
  AContext.Connection.IOHandler.WriteBufferFlush;
end;

procedure SendSSEComplete(AContext: TIdContext);
begin
  AContext.Connection.IOHandler.Write('data: [DONE]' + #13#10#13#10);
  AContext.Connection.IOHandler.WriteBufferFlush;
end;



end.
