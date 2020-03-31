import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/common_style.dart';

class CustomDialog extends Dialog {
  CustomDialog({
    Key key,
    this.title,
    this.centerWidget,
    this.sureCallBack,
    this.managerWidgetSelf = false,
    this.width,
    this.height,
    this.showCancel = true,
  }) : super(key: key);

  Function sureCallBack;
  Widget centerWidget;
  String title;
  double width;
  double height;
  bool showCancel;
  bool managerWidgetSelf = false;/// 用户自己管理确定按钮

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_transparent,
      body: Center(
          child: Container(
              width: width ?? Screen.w(312),
              height: height ?? Screen.h(170),
              decoration: BoxDecoration(
                  color: AppColors.color_ffffff,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0, Screen.h(12), 0, Screen.h(12)),
                    child: Text(
                      title,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: AppColors.color_333333,
                          fontSize: Screen.sp(20),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: centerWidget,
                  ),
                  Divider(
                    height: Screen.h(0.5),
                    color: AppColors.color_999999,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Visibility(
                          child: Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: GestureDetector(
                                  child: Text(
                                    '取消',
                                    textAlign: TextAlign.center,
                                    style: CStyle.style(
                                        AppColors.color_999999, 17),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                )),
                                Container(
                                    height: Screen.h(50),
                                    child: VerticalDivider(
                                        color: AppColors.color_999999)),
                              ],
                            ),
                          ),
                          visible: showCancel,
                        ),
                        Expanded(
                            child: GestureDetector(
                          child: Text(
                            '确定',
                            textAlign: TextAlign.center,
                            style: CStyle.style(AppColors.color_999999, 17),
                          ),
                          onTap: () {
                            sureCallBack();
                            if(managerWidgetSelf){
                              Navigator.of(context).pop();
                            }
                          },
                        )),
                      ],
                    ),
                    height: Screen.h(50),
                  )
                ],
              ))),
    );
  }
}
