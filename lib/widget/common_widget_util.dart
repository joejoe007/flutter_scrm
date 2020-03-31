import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_project1/widget/custom_dialog_widget.dart';
import 'package:url_launcher/url_launcher.dart';

/// 一些常用的工具widget
class CommonWidgetUtil {
  /// 选择日期
  static chooseTime(BuildContext context, DateTime startTime, DateTime endTime,
      Function(String stringTime) function) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: startTime,
        maxTime: endTime, onConfirm: (date) {
      function(DateUtil.getDateStrByDateTime(date,
          format: DateFormat.YEAR_MONTH_DAY));
    }, currentTime: DateTime.now(), locale: LocaleType.zh);
  }

  /// 自定义弹出框
  static showCustomDialogWidget(BuildContext context,
      {String title = '提示',
      Widget centerChild,
      Function sure,
      bool barrierDismissible = true,
      bool showCancel = true,
      bool managerWidgetSelf = true,/// 控件自己管理确定按钮
      double width,
      double height}) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => WillPopScope(
              child: CustomDialog(
                title: title,
                centerWidget: centerChild,
                sureCallBack: sure,
                managerWidgetSelf : managerWidgetSelf,
                showCancel: showCancel,
                height: height,
                width: width,
              ),
              onWillPop: () async {
                return Future.value(false);
              },
            ));
  }

  /// 打开浏览器
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
