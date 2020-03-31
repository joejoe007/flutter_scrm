import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:tobias/tobias.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class ShopMallPage extends StatefulWidget {
  ShopMallPage({Key key}) : super(key: key);

  @override
  _ShopMallPageState createState() {
    return _ShopMallPageState();
  }
}

class _ShopMallPageState extends State<ShopMallPage> {
  String _payInfo = "";
  String _text = "share text from fluwx";
  fluwx.WeChatScene scene = fluwx.WeChatScene.SESSION;

  @override
  void initState() {
    super.initState();
    _initFluwx();
    fluwx.responseFromPayment.listen((data){
      print('^^^^^^^^^^^^^^^^^^^${data.errCode} ${data.errStr}');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: MyAppBarView(
          title: '商城',
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                      height: 40,
                      color: AppColors.color_maincolor,
                      child: Center(
                        child: Text('支付宝支付'),
                      )),
                  onTap: () {
                    /// 唤起支付宝
                    isAliPayInstalled().then((data) {
                      callAlipay();
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                      height: 40,
                      color: Colors.green,
                      child: Center(
                        child: Text('微信支付'),
                      )),
                  onTap: () {
//                    fluwx
//                        .pay(
//                            appId: 'wxa66749ab62357bec',
//                            partnerId: '1900000109',
//                            prepayId: '1101000000140415649af9fc314aa427',
//                            packageValue: 'Sign=WXPay',
//                            nonceStr: '1101000000140429eb40476f8896f4c9',
//                            timeStamp: 1398746574,
//                            sign: '7FFECB600D7157C5AA49810D2D8F28BC2811827B',
//                            signType: '选填',
//                            extData: '选填')
//                        .then((data) {
//                      print("---》$data");
//                    });

                    fluwx
                        .payWithWeChat(
                            appId: 'wx387bd31fbc6afbcb',
                            partnerId: '1900000109',
                            prepayId: '1101000000140415649af9fc314aa427',
                            packageValue: 'Sign=WXPay',
                            nonceStr: '1101000000140429eb40476f8896f4c9',
                            timeStamp: 1398746574,
                            sign: '7FFECB600D7157C5AA49810D2D8F28BC2811827B')
                        .then((value) {});
                  },
                ),
                GestureDetector(
                  child: Container(
                      height: 40,
                      color: Colors.yellow,
                      child: Center(
                        child: Text('微信分享'),
                      )),
                  onTap: () {
                    _shareText();
                  },
                ),
              ],
            ),
          ),
        ));
  }

  /// 支付宝支付
  callAlipay() async {
    Map payResult;
    try {
      print("The pay info is : " + _payInfo);
      payResult = await aliPay(
          'app_id=2017121400771110&method=alipay.trade.app.pay&format=json&charset=UTF-8&sign_type=RSA2&version=1.0&return_url=https%3A%2F%2Fwww.miaozancn.com&notify_url=https%3A%2F%2Fwww.miaozancn.com%2Fapi%2Fpay%2FaliPay%2Fnotify&timestamp=2020-01-06+20%3A03%3A43&sign=WGohXk5M8MXirah3iTzoICK6dr9B%2FSaF1eF6XYelgdQDVD23C3lyUDBVcF0ydo90I%2BbXf1DuVHGNcxMztRgwva1yO1Qd1lhgd2SzA1xLCz2URS3YWElM8wiFOJKISSJF550PJ9hQcBuitqTdMmNox3dv9esFADKxNs7Ij3HxZaMsRJvPg5%2B9%2B06nqA7YtWTIfpKY6%2Bk0L%2FtLUoKjfL4%2Fq1uq1dyHWCNdsOg4ycMyKgssXmD6BfWQOafvLpt6qgVge%2F2%2B0iBz%2BhFkdTqr351EWuKrDol2VjDqP9rXRqIpc8yUg11Zqtgiu%2FHgxGxqU6GEN5g2BORt5IH%2BXkh2ycJfYA%3D%3D&biz_content=%7B%22out_trade_no%22%3A%22171895997986372%22%2C%22total_amount%22%3A%220.01%22%2C%22subject%22%3A14148%2C%22passback_params%22%3A%22recharge%22%2C%22disable_pay_channels%22%3A%22credit_group%2CcreditCard%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%7D&alipay_sdk=+alipay-sdk-php-20161101');
      print("--->$payResult");
    } on Exception catch (e) {
      payResult = {};
    }
    if (!mounted) return;
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

  void _shareText() {
//    fluwx.share(fluwx.WeChatShareTextModel(
//            text: _text,
//            transaction: "text${DateTime.now().millisecondsSinceEpoch}",
//            scene: scene))
//        .then((data) {
//      print(data);
//    });

    fluwx
        .shareToWeChat(fluwx.WeChatShareTextModel(
            text: _text,
            transaction: "text${DateTime.now().millisecondsSinceEpoch}",
            scene: scene))
        .then((data) {});
  }
}
