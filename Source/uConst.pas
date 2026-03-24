//convert pas to utf8 by ¥
//门业管理
unit uConst;

interface


uses
  uOpenUISetting,
  uOpenCommon,
  uRestInterfaceCall,
  uOpenClientCommon;


const
  Const_Node_Port=18789;

const
  //默认服务器地址
  //AppStore上架需要域名,暂时分离开,因为域名还没备案,先用我服务器
  Const_Server_Host_IOS='www.orangeui.cn';//'127.0.0.1';//
  //Android,Windows可以IP直连
  Const_Server_Host_Other='www.orangeui.cn';//'127.0.0.1'

  //默认端口
  Const_Server_Port=10030;


  Const_Server_Host_IM='www.orangeui.cn';
  //开放平台网页的根链接
  Const_OpenWebRoot='http://www.orangeui.cn/open';//

  Const_AppUpdateINIUrl='http://www.orangeui.cn/open/apps/DoorManage/client/Version.ini';








  //授权中心的服务器,默认都是www.orangeui.cn:10020
  Const_CenterServerHost='www.orangeui.cn';
//  Const_CenterServerHost='127.0.0.1';//'www.orangeui.cn';
  Const_CenterServerPort=10020;
  //Const_CenterAppName='门业';






const

  //金贸通
  Const_APPID='1036';//初始的应用ID,用于升级
  Const_APPName='OpenClawDesktop客户端';
  Const_FilterAPPName='OpenClawDesktop';
  Const_APPEnName='OpenClawDesktop';
  //用户类型,客户
  Const_APPUserType:TUserType=utClient;
  //登录方式,默认手机号+验证码
  Const_APPLoginType=Const_RegisterLoginType_PhoneNum_PassWord;
  //注册协议
  Const_RegisterProtocolUrl='';//'http://www.orangeui.cn/open/apps/1000/ClientRegisterProtocol.html';
  //关于页面的版权信息
  Const_CopyrightCompany='';//'金华市劲界信息技术有限公司';//'金华劲界信息技术有限公司';
  Const_CopyrightTime='';//'Copyright @2015-2020';




const
  //个推推送的参数
  Const_GetuiPush_AppId='qdVeJwK4YS7dr5b2BIAAV2';
  Const_GetuiPush_AppSecret='0gk1UnwoyE6sKz7G2fX1e8';
  Const_GetuiPush_AppKey='bsZq5AsC4IAQd1s0JN6le7';
  Const_GetuiPush_MasterSecret='FWZhTH72MW7zoMkyZjC34';
  Const_GetuiPush_AppType='client';


const
  //小米推送的参数
  Const_XiaomiPush_AppId='2882303761519207514';
  Const_XiaomiPush_AppKey='5791920718514';




//  {$IFDEF USE_FCM_PUSH}
//const
//  //r4uclient的谷歌FCM推送配置   还未修改
//  Const_FcmPush_ProjectId='r4uclient';
//  Const_FcmPush_ApiKey='AIzaSyBjvNtVunmlAF67vF-tGTCx83HJCFEncS0';
//  Const_FcmPush_ApplicationId='1:438377136143:android:d00bc15d44d46c01';
//  Const_FcmPush_DatabaseUrl='https://r4uclient.firebaseio.com';
//  Const_FcmPush_GcmSenderId='438377136143';
//  {$ENDIF USE_FCM_PUSH}



//const
//  //Facebook的应用ID     还未修改
//  Const_Facebook_AppId='470274443422008';



//const
//  //微信的应用ID    客户端
//  Const_WeiXin_AppId='wxcd924148d13bdb8e';
//  Const_WeiXin_AppSecret='90ac476a3d8d3ad5d47d078002bc1260';
//  Const_WeiXin_PartnerID='1519118881';
//  Const_WeiXin_PartnerKey='13857563773wangnengdelphiteacher';
//  Const_WeiXin_IOSUniversalLink='https://www.orangeui.cn/delphi/';



//const
//  //支付宝的IOSSchema  付完钱跳回App用  每个App唯一
//  Const_AliPay_AppId='2021001143607090';



const
  //暂时写死的客服电话
  Const_ServiceEmp_Phone='13757961157';


const
  Const_ServiceEmp_IMUserId=0;



const
  //旋风APP接口签名方式的私钥
  Const_RestAPIAppSecret='B64A687070B5459AB5B7F979A5F3137A';//和tblapp中的密钥字段相对应的
  //全局的加签方式
  Const_RestAPISignType='md5';







implementation




initialization
  //LoginFrame
  //是否启用微信登录
  GlobalIsEnabledWeichatLogin:=False;
  //是否启用支付宝登录
  GlobalIsEnabledAlipayLogin:=False;//True;//True
  //是否启用Apple登录
  GlobalIsEnabledAppleLogin:=False;
//  {$IFDEF IOS}
//    if TOSVersion.Check(13) then
//    begin
//      //IOS13才支持
//      GlobalIsEnabledAppleLogin:=False;
//    end;
//  {$ENDIF IOS}
//  {$IFDEF MSWINDOWS}
//    //Windows下测试用
//    GlobalIsEnabledAppleLogin:=False;//True;
//  {$ENDIF}
  //是否启用QQ登录
  GlobalIsEnabledQQLogin:=False;
  //是否启用Facebook登录
  GlobalIsEnabledFacebookLogin:=False;
  //是否启用Twitter登录
  GlobalIsEnabledTwitterLogin:=False;

  //是否启用手机号密码登录
  GlobalIsEnabledPhonePasswordLogin:=True;
  //是否启用手机号验证码登录
  GlobalIsEnabledPhoneCaptchaLogin:=False;


  //三方登录需要完善手机号等
  GlobalIsThirdPartyNeedPhone:=False;//True;True;//


  CurrentVersion:='1.1.3';


  GlobalIsNeedGetAppInfo:=False;//需要，因为要获取到服务器的地址和端口


  GlobalIsNeedLoginThenShowMainFrame:=False;

  GlobalIsNeedRegister:=False;
  //登录页面是否需要服务器设置按钮
  GlobalIsNeedServerSetting:=True;
  //需要选择授权
  GlobalIsNeedAPPIDSetting:=True;


//  GlobalNoticeClassifyNameListStr:='order';
//  GlobalNoticeClassifyCaptionListStr:='订单';



//  //授权中心的服务器,默认都是
//  CenterServerHost:='www.orangeui.cn';
//  CenterServerPort:=10020;


  //旋风APP接口签名方式的私钥
  GlobalRestAPIAppSecret:=Const_RestAPIAppSecret;
  //全局的加签方式
  GlobalRestAPISignType:=Const_RestAPISignType;
  //是否启用加签的接口调用
  GlobalRestAPICheckSignIsEnable:=True;



end.
