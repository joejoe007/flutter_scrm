import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/model/shareinfo_model.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class ShareTestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ShareTestPageState();
  }
}

class ShareTestPageState extends State<ShareTestPage> {
  WebViewController _controller;
  String _title = 'webview';
  Uint8List bytes;
  String imgUrl;

  @override
  void initState() {
    super.initState();
    _initFluwx();

//    WXSuccess           = 0,    /**< 成功    */
//    WXErrCodeCommon     = -1,   /**< 普通错误类型    */
//    WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
//    WXErrCodeSentFail   = -3,   /**< 发送失败    */
//    WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
//    WXErrCodeUnsupport  = -5,   /**< 微信不支持    */

    fluwx.responseFromShare.listen((data) {
      print('*******************${data.errCode}');

      _controller.evaluateJavascript("_setFlutterSignal(0,'success')");
    });

    fluwx.responseFromPayment.listen((data) {
      print('^^^^^^^^^^^^^^^^^^^${data.errCode}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MyAppBarView(
          title: '首页',
          leftVisible: false,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                child: GestureDetector(
                  onTap: (){

                  },
                  child: bytes!=null?Image.memory(bytes):Icon(Icons.dehaze),
                )

              ),
              Expanded(child: Container(
                  child: SafeArea(
                    child: WebView(
                      initialUrl: 'http://192.168.1.4:8080/#/articleVideo/list/215',
                      //JS执行模式 是否允许JS执行
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) {
                        _controller = controller;
                      },
                      onPageFinished: (url) {
//                        _controller.evaluateJavascript('window.flutter=true;window.flutterShare = flutterShare; window.Wechat = {Scene:{TIMELINE:1,SESSION:2},Type:{WEBPAGE:1}};window.Wechat.share=function(o) {flutterShare.postMessage(JSON.stringify(o));};document.title;')
//                            .then((result) {
//                          setState(() {
//                            _title = result;
//                          });
//                        });


                        _controller.evaluateJavascript('window.flutter=true')
                            .then((result) {
                          setState(() {
                            _title = result;
                          });
                        });

                      },
                      navigationDelegate: (NavigationRequest request) {
                        if (request.url.startsWith("myapp://")) {
                          print("即将打开 ${request.url}");

                          return NavigationDecision.prevent;
                        }
                        return NavigationDecision.navigate;
                      },
                      javascriptChannels: <JavascriptChannel>[
                        JavascriptChannel(
                            name: 'flutterShare',
                            onMessageReceived: (JavascriptMessage message) {
                              print(message.message);
                              ShareInfoModel model =
                              ShareInfoModel.fromJson(json.decode(message.message));
                              _shareWeixin(model);
                              /// 返回base64 格式不被识别需要切分
//                              model.message.thumb = model.message.thumb.split(',')[1];
//                              setState(() {
//                                bytes = Base64Decoder().convert(model.message.thumb);
//                              });

                            }),
                      ].toSet(),
                    ),
                  )),flex: 1,)
            ],
          ),
        ));
  }

  /// 微信初始化
  _initFluwx() async {
    await fluwx.registerWxApi(
        appId: "wx387bd31fbc6afbcb",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://");
    var result = await fluwx.isWeChatInstalled();
    print("is installed $result");
  }

  void _shareWeixin(ShareInfoModel shareInfoModel) {
    fluwx.WeChatScene scene = fluwx.WeChatScene.SESSION;
    if (shareInfoModel.scene == 1) {
      scene = fluwx.WeChatScene.TIMELINE;
    }

    /// 网页形式
    fluwx
        .shareToWeChat(fluwx.WeChatShareWebPageModel(
        webPage: shareInfoModel.message.media.webpageUrl,
        title: shareInfoModel.message.title,
        description: shareInfoModel.message.description,
        thumbnail: shareInfoModel.message.thumb,
        scene: scene))
        .then((value) {
      print(value);
    }).catchError((error) {
      print(error);
    });
  }

  /*
  * Base64加密
  */
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /*
  * Base64解密
  */
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }
}
