object dmFileIndyHttpServer: TdmFileIndyHttpServer
  Height = 294
  Width = 371
  object IdHTTPServer: TIdHTTPServer
    Bindings = <>
    DefaultPort = 7030
    OnCommandOther = IdHTTPServerCommandOther
    OnDoneWithPostStream = IdHTTPServerDoneWithPostStream
    OnCommandGet = IdHTTPServerCommandGet
    Left = 152
    Top = 96
  end
  object IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 152
    Top = 160
  end
end
