import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';

class DividerUtil {
  /// 水平方向的分割线
  static Widget HDivider(double height) {
    return Divider(
      height: height,
      color: AppColors.color_transparent,
    );
  }

  /// 竖直方向的分割线
  static Widget VDivider(double width) {
    return VerticalDivider(width: width, color: AppColors.color_transparent);
  }
}
