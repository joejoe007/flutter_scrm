import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../page/main/Home_page.dart';
import '../page/main/workbench_page.dart';
import '../page/main/my_page.dart';
import '../page/main/discover_page.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class _Item {
  String name, activeIcon, normalIcon;
  _Item(this.name, this.activeIcon, this.normalIcon);
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  List<Widget> list = List();

  final itemNames = [
    _Item('首页', AppImages.assetsHomeActive,AppImages.assetsHomeInActive,
       ),
    _Item('发现',  AppImages.assetsCategoryActive,AppImages.assetsCategoryInActive,
    ),
    _Item('工作台',  AppImages.assetsCartActive,AppImages.assetsCartInActive,
    ),
    _Item('我的',  AppImages.assetsMineActive,AppImages.assetsMineInActive,
    )
  ];

  List<BottomNavigationBarItem> itemList;

  @override
  void initState() {
    list
      ..add(HomePage())
      ..add(DiscoverPage())
      ..add(WorkBenchPage())
      ..add(MyPage());

    if(itemList == null){
      itemList = itemNames
          .map((item) => BottomNavigationBarItem(
          icon: Image.asset(
            item.normalIcon,
            width: Screen.w(50),
            height: Screen.h(50),
          ),
          title: Text(
            item.name,
//            style: TextStyle(fontSize: Screen.sp(29)),

          ),
          activeIcon:
          Image.asset(item.activeIcon, width: Screen.w(50), height: Screen.h(50))))
          .toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 12,
        items: itemList,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        /// 选中颜色
      ),
    );
  }
}
