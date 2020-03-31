import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/version_info_model.dart';
import 'package:flutter_project1/page/main/Home_page.dart';
import 'package:flutter_project1/page/main/shopmall_page.dart';
import 'package:flutter_project1/page/main/workbench_page.dart';
import 'package:flutter_project1/page/main/my_page.dart';
import 'package:flutter_project1/page/main/discover_page.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/main_vmodel.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/common_widget_util.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiver/strings.dart';

class MainPage extends StatefulWidget {
  int initPage;

  MainPage({this.initPage = 0});

  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController _pageController;
  MainVModel mainVModel = MainVModel();

  @override
  void initState() {
    _currentIndex = widget.initPage;
    _pageController = PageController(initialPage: widget.initPage);
    super.initState();
    mainVModel.getVersionInfo(
        (VersionState state, VersionInfoModel versionInfoModel) {
      switch (state) {
        case VersionState.Force:
          CommonWidgetUtil.showCustomDialogWidget(context,
              title: '强制更新',
              centerChild: Text(
                  isEmpty(versionInfoModel.remark)
                      ? ''
                      : versionInfoModel.remark,
                  style: CStyle.style(AppColors.color_999999, 14)),
              showCancel: false,
              barrierDismissible: false, sure: () {
            CommonWidgetUtil.launchURL(versionInfoModel.url);
          });
          break;
        case VersionState.Select:
          CommonWidgetUtil.showCustomDialogWidget(context,
              title: '更新',
              centerChild: Text(
                  isEmpty(versionInfoModel.remark)
                      ? ''
                      : versionInfoModel.remark,
                  style: CStyle.style(AppColors.color_999999, 14)), sure: () {
            CommonWidgetUtil.launchURL(versionInfoModel.url);
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new Scaffold(
            body: new WillPopScope(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    new HomePage(),
                    new WorkBenchPage(),
                    new ShopMallPage(),
                    new DiscoverPage(),
                    new MyPage(),
                  ],
                ),
                onWillPop: _exitApp),
//            floatingActionButton: FloatingActionButton(
//              backgroundColor: AppColors.color_ffffff,
//              elevation: 0,
//              onPressed: () {},
//              child: DecoratedBox(
//                decoration: BoxDecoration(
//                  shape: BoxShape.circle,
//                  color: AppColors.color_maincolor,
//                ),
//                child: SizedBox(
//                    height: 48,
//                    width: 48,
//                    child: Icon(
//                      Icons.add,
//                      color: AppColors.color_ffffff,
//                    )),
//              ),
//            ), // T
//            floatingActionButtonLocation:
//                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              color: AppColors.color_ffffff,
              shape: CircularNotchedRectangle(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(child: setBottomState(0),flex: 1,),
                    Expanded(child: setBottomState(1),flex: 1,),
                    Expanded(child: setBottomState(2),flex: 1,),
                    Expanded(child: setBottomState(3),flex: 1,),
                    Expanded(child: setBottomState(4),flex: 1,),
                  ],
                ),
              ),
            ),
          ),
          Align(
            child: GestureDetector(
              onTap: () {
                /// 商城
                onTap(2);
              },
              child: Container(
                  height: ScreenUtil.bottomBarHeight + 58 + 12 + Screen.sp(13),
                  width: 58,
                  color: AppColors.color_transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.color_ffffff),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
//                                color: AppColors.color_maincolor,
                              ),
                              child: SizedBox(
                                  height: 48,
                                  width: 48,
                                  child: Image.asset(AppImages.assetsCenterActive)),
                            ),
                          )),
                      Text('商城',
                          style: TextStyle(
                            color: _currentIndex == 2
                                ? AppColors.color_ff0000
                                : AppColors.color_434343,
                            fontSize: Screen.sp(13),
                          )),
                    ],
                  )),
            ),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  void onTap(int index) {
    _pageController.jumpToPage(index);
    _currentIndex = index;
    setState(() {});
  }

  /// 设置底部状态
  Widget setBottomState(int index) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            index == 2
                ? Text('')
                : new Image.asset(
                    getBottomStateImage(index),
                    width: Screen.w(20),
                    height: Screen.w(20),
                  ),
            Text(getBottomStateString(index),
                style: TextStyle(
                  color: _currentIndex == index
                      ? AppColors.color_ff0000
                      : AppColors.color_434343,
                  fontSize: Screen.sp(13),
                ))
          ],
        ));
  }

  /// 获取底部图片
  String getBottomStateImage(int index) {
    String image;
    switch (index) {
      case 0:
        image = _currentIndex == index
            ? AppImages.assetsHomeActive
            : AppImages.assetsHomeInActive;
        break;
      case 1:
        image = _currentIndex == index
            ? AppImages.assetsCategoryActive
            : AppImages.assetsCategoryInActive;
        break;
      case 2:

        /// 商城

        break;
      case 3:
        image = _currentIndex == index
            ? AppImages.assetsCartActive
            : AppImages.assetsCartInActive;
        break;
      case 4:
        image = _currentIndex == index
            ? AppImages.assetsMineActive
            : AppImages.assetsMineInActive;
        break;
    }
    return image;
  }

  /// 获取底部文字
  String getBottomStateString(int index) {
    String value;
    switch (index) {
      case 0:
        value = '首页';
        break;
      case 1:
        value = '工作';
        break;

      case 2:
        value = '';
        break;

      case 3:
        value = '发现';
        break;
      case 4:
        value = '我的';
        break;
    }
    return value;
  }

  /// 底部导航item
  BottomNavigationBarItem _bottomItem(String title, int index) {
    switch (index) {
      case 0:
        return BottomNavigationBarItem(
            icon: new Image.asset(
              AppImages.assetsHomeInActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            activeIcon: new Image.asset(
              AppImages.assetsHomeActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            title: Text(title,
                style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: Screen.sp(13),
                )));
        break;
      case 1:
        return BottomNavigationBarItem(
            icon: new Image.asset(
              AppImages.assetsCategoryInActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            activeIcon: new Image.asset(
              AppImages.assetsCategoryActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            title: Text(title,
                style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: Screen.sp(13),
                )));
        break;
      case 2:
        return BottomNavigationBarItem(
            icon: new Image.asset(
              AppImages.assetsCategoryInActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            activeIcon: new Image.asset(
              AppImages.assetsCategoryActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            title: Text(title,
                style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: Screen.sp(13),
                )));
        break;
      case 3:
        return BottomNavigationBarItem(
            icon: new Image.asset(
              AppImages.assetsCartInActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            activeIcon: new Image.asset(
              AppImages.assetsCartActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            title: Text(title,
                style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: Screen.sp(13),
                )));
        break;
      case 4:
        return BottomNavigationBarItem(
            icon: new Image.asset(
              AppImages.assetsMineInActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            activeIcon: new Image.asset(
              AppImages.assetsMineActive,
              width: Screen.w(20),
              height: Screen.w(20),
            ),
            title: Text(title,
                style: TextStyle(
                  color: AppColors.color_434343,
                  fontSize: Screen.sp(13),
                )));
        break;
    }
    return null;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime _lastPressedAt;

  /// 上次点击时间
  /// 退出app
  Future<bool> _exitApp() {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      MyToast.showToast('再按一次退出应用');
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
