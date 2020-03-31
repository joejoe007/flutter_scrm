import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressDialog extends StatelessWidget {
  //子布局
  final Widget child;

  //加载中是否显示
  final bool loading;

  //进度提醒内容
  final String msg;

  //加载中动画
  final Widget progress;

  //背景透明度
  final double alpha;

  //字体颜色
  final Color textColor;

  ProgressDialog(
      {Key key,
      @required this.loading,
      this.msg,
      this.progress = const CircularProgressIndicator(),
      this.alpha = 0.3,
      this.textColor = Colors.white,
      @required this.child})
      : assert(child != null),
        assert(loading != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (loading) {
      Widget layoutProgress;
      if (msg == null) {
        layoutProgress = Center(
          child: progress,
        );
      } else {
        layoutProgress = Center(
            child: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: SpinKitFadingCircle(
                  color: AppColors.color_999999,
                  size: 30,
                ),
              ),
              Container(
                child: Text(
                  msg,
                  style: TextStyle(
                      color: AppColors.color_666666,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: AppColors.color_ffffff,
              borderRadius: BorderRadius.circular(5)),
        ));
      }
      widgetList.add(Opacity(
        opacity: alpha,
        child: new ModalBarrier(color: Colors.black87),
      ));
      widgetList.add(layoutProgress);
    }
    return Stack(
      children: widgetList,
    );
  }
}
