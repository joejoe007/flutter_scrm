import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/automake_btn_widget.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

import '../../main_page.dart';

enum ResultType { getMoney, openCard, backCar, backOrder }

class OpenCardResultPage extends StatefulWidget {
  ResultType resultType;

  OpenCardResultPage({Key key, this.resultType = ResultType.openCard})
      : super(key: key);

  @override
  _OpenCardResultPageState createState() {
    return _OpenCardResultPageState();
  }
}

class _OpenCardResultPageState extends State<OpenCardResultPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _requestPop() {
    return new Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
          appBar: MyAppBarView(
            title: widget.resultType == ResultType.getMoney
                ? '收款成功'
                : (widget.resultType == ResultType.openCard)
                    ? '开卡成功'
                    : (widget.resultType == ResultType.backOrder)
                        ? '退单成功'
                        : '退卡成功',
            leftCallback: () {
              NavigatorUtil.pushAndRemoveUtil(context, MainPage(initPage: 1,));
            },
          ),
          body: Container(
            color: AppColors.color_f4f4f4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: Screen.w(76),
                  height: Screen.w(76),
                  child: Image.asset(AppImages.redResultSuccessImg),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Screen.w(18)),
                  child: Center(
                    child: Text(
                      widget.resultType == ResultType.getMoney
                          ? '收款成功'
                          : (widget.resultType == ResultType.openCard)
                              ? '支付成功'
                              : (widget.resultType == ResultType.backOrder)
                                  ? '退单成功'
                                  : '退卡成功',
                      style: TextStyle(
                          color: AppColors.color_212121,
                          fontSize: Screen.sp(17)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Screen.w(73.5)),
                  child: Center(
                      child: Container(
                    width: 205,
                    height: 50,
                    child: MyAutoBtn(
                      title: '返回首页',
                      isHaveBorder: true,
                      textFontSize: Screen.sp(17),
                      textColor: AppColors.color_f73b42,
                      circle: 25,
                      borderColor: AppColors.color_f73b42,
                      backColor: AppColors.color_ffffff,
                      onPressed: () {
                        NavigatorUtil.pushAndRemoveUtil(context, MainPage(initPage: 1,));
                      },
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
