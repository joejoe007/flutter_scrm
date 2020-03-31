import 'package:flutter/material.dart';
import 'package:flutter_project1/common/api.dart';
import 'package:flutter_project1/common/jscode.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ElectricityWebViewPage extends StatefulWidget {
  ElectricityWebViewPage({Key key}) : super(key: key);

  @override
  _ElectricityWebViewPageState createState() {
    return _ElectricityWebViewPageState();
  }
}

class _ElectricityWebViewPageState extends State<ElectricityWebViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBarView(
        title: '',
      ),
      body: Container(
        child: SafeArea(child: WebView(
          initialUrl: 'http://192.168.1.36:8080/#/register',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _controller = controller;
          },
          onPageFinished: (url) {
            _controller.evaluateJavascript(JSCodeUtil.jsSendToken)
                .then((result) {

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
                name: 'getToken',
                onMessageReceived: (JavascriptMessage message) {
                  print(message.message);
                }),
          ].toSet(),
        ),),
      ),
    );
  }
}