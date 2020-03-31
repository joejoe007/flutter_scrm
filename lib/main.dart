import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_project1/common/api.dart';
import 'package:flutter_project1/common/config.dart';
import 'package:flutter_project1/common/router_manger.dart';
import 'package:flutter_project1/page/login/login_page.dart';
import 'package:flutter_project1/page/main/home/order/order_list_page.dart';
import 'package:flutter_project1/page/main/main_page.dart';
import 'package:flutter_project1/page/main/workbench_page.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/sp_util.dart';
import 'package:permission_handler/permission_handler.dart';

import 'common/const.dart';

List<CameraDescription> cameras;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化一些参数
  Config.fill(
      debug: Constant.DEBUG, dbName: Constant.DB_NAME, apiUrl: Api.BASE_URL);
  await SpUtil.getInstance();
  initData();
  requestPermission();
  /// 获取设备上可用摄像头的列表。
  cameras = await availableCameras();
  runApp(MyApp());
}

void initData() {
  initEasyRefresh();
}

void initEasyRefresh() {
  /// 初始化刷新样式
  EasyRefresh.defaultHeader = ClassicalHeader(
      refreshText: "下拉刷新",
      refreshReadyText: "释放刷新",
      refreshingText: "正在刷新",
      refreshedText: "刷新完成",
      noMoreText: '没有更多',
      infoText: '更新于 %T'
  );
  EasyRefresh.defaultFooter = ClassicalFooter(
      loadText: "下拉加载更多",
      loadReadyText: "释放加载更多",
      loadingText: "加载中",
      loadedText: "加载完成",
      noMoreText: '没有更多',
      infoText: '更新于 %T'
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'scrm驾到应用',
      home: App(),
      onGenerateRoute: Router.generateRoute,
      routes: <String, WidgetBuilder>{
        RouteName.MainPage: (BuildContext context) => new MainPage(),// 主界面
        RouteName.WorkBench: (BuildContext context) => new WorkBenchPage(),// 工作台界面
        RouteName.OrderList: (BuildContext context) => new OrderListPager(),// 订单列表界面
      },
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    GlobalContext.setContext = context;
    Screen.init(context, 375, 667);
    return (SpUtil.getString(Constant.Token_key) != null &&
            SpUtil.getString(Constant.Token_key).length > 0)
        ? MainPage()
        : LoginPage();

  }
}

/// 申请权限
Future requestPermission() async {
  // 申请权限
  Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler()
      .requestPermissions([PermissionGroup.camera, PermissionGroup.storage]);

  // 申请结果
//  PermissionStatus permissionStorage =
//      await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
//
//  PermissionStatus permissionCamera =
//      await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);

//  if (permission == PermissionStatus.granted) {
//    MyToast.showToast("权限申请通过");
//  } else {
//    MyToast.showToast("权限申请被拒绝");
//  }
}
