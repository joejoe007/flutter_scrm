import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';

/// 自定义按钮或者布局界面
class AutoMakeLayoutWidget extends StatelessWidget {
  final Color bgColor; // 背景颜色
  final double bgCircle; // 背景弧度
  final double width; // 长度
  final double height; // 高度
  final Widget child; // 子布局
  final Alignment alignment; // 位置默认居中
  final GestureTapCallback gestureTapCallback; // 点击事件
  final double borderWidth;
  final Color borderColor;
  final Gradient gradient; // 渐变色
  final EdgeInsetsGeometry margin;
  final bool check;// 是否可以点击

  const AutoMakeLayoutWidget(
      {Key key,
      this.bgColor = AppColors.color_ffffff,
      this.bgCircle = 20.0,
      this.width = 50.0,
      this.height = 25.0,
      this.alignment = Alignment.center,
      @required this.child,
      this.gestureTapCallback,
      this.borderWidth = 0.5,
      this.borderColor = Colors.transparent,
      this.margin,
      this.check = true,
      this.gradient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: margin,
        alignment: alignment,
        decoration: BoxDecoration(
          gradient: check ? gradient : null,
          border: new Border.all(width: borderWidth, color: borderColor),
          borderRadius: new BorderRadius.all(new Radius.circular(bgCircle)),
          color: check ? bgColor : AppColors.color_666666,
        ),
        width: width,
        height: height,
        child: child,
      ),
      onTap: check ? gestureTapCallback : null,
    );
  }
}
