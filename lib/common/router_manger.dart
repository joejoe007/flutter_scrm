import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RouteName {
  /// 主界面
  static const String MainPage = '/main_page';
  /// 工作台界面
  static const String WorkBench = '/workbench_page';
  /// 订单列表
  static const String OrderList = '/order_list_page';

}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.WorkBench:

        break;
    }
  }
}
