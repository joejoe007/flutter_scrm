import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Set urlSet = Set();
bool loadingStatus = false;

class LoadingDialog {
  /// 显示
  static void show(url) {
    assert(GlobalContext.context != null);
    urlSet.add(url); // 放入set变量中
    // 已有弹窗，则不再显示弹窗, urlSet.length >= 2 保证了有一个执行弹窗即可，
    if (loadingStatus == true || urlSet.length >= 2) {
      return;
    }
    loadingStatus = true; // 修改状态
    // 请求前显示弹窗
    Future.delayed(Duration.zero, (){
      showDialog(
        context: GlobalContext.context,
        builder: (context) {
          return DialogContent();
        },
      );
    });
  }

  /// 关闭
  static void close(url) {
    assert(GlobalContext.context != null);
    urlSet.remove(url);
    // 所有接口接口返回并有弹窗
    if (urlSet.length == 0 && loadingStatus == true) {
      loadingStatus = false; // 修改状态
      // 完成后关闭loading窗口
      Future.delayed(Duration.zero,(){
        Navigator.of(GlobalContext.context, rootNavigator: true).pop();
      });
    }
  }
}

/// 弹窗内容
class DialogContent extends StatefulWidget {
  @override
  DialogContentState createState() => new DialogContentState();
}

class DialogContentState extends State<DialogContent> {

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  '加载中...',
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
}
