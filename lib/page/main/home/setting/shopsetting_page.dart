import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/page/main/home/customercare/customercarelist_page.dart';
import 'package:flutter_project1/page/main/home/setting/rolemanage/rolemanage_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_section_table_view/flutter_section_table_view.dart';

import 'customercareset/customercareset_page.dart';
import 'employeerightsset/employeerights_list_page.dart';
import 'itemset/itemset_list_page.dart';
import 'memshipcardset/memshipcardset_list_page.dart';

class ShopSettingPage extends StatefulWidget {
  ShopSettingPage({Key key}) : super(key: key);

  @override
  _ShopSettingPageState createState() {
    return _ShopSettingPageState();
  }
}

class _ShopSettingPageState extends State<ShopSettingPage> {
  List _list = [
    [AppImages.settingproject, '项目设置'],
    [AppImages.settingmemcard, '会员卡设置'],
    [AppImages.settingemployees, '员工管理'],
    [AppImages.settingrole, '角色权限'],
    [AppImages.settingmemcare, '客户关怀设置']
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBarView(
        title: '营业设置',
      ),
      body: Container(
        color: AppColors.color_f4f4f4,
        child: SectionTableView(
          sectionCount: 1,
          numOfRowInSection: (section) {
            return 5;
          },
          cellAtIndexPath: (section, row) {
            return _bulidListWidget(row);
          },
//          sectionHeaderHeight: (section) => Screen.h(150),
          headerInSection: (section) {
            return Container(
//              height: Screen.h(150),
              child: Image.asset(
                AppImages.settingback,
                fit: BoxFit.fitWidth,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bulidListWidget(int row) {
    return GestureDetector(
      onTap: () {
        switch (row) {
          case 0:
            ///  项目设置
            NavigatorUtil.push(context, new ItemSetListPage());
            break;
          case 1:
            /// 会员卡设置
            NavigatorUtil.push(context, new MemShipSetListPage());
            break;
          case 2:
            ///员工管理
            NavigatorUtil.push(context, new EmployrightsListPage());
            break;
          case 3:
            ///角色权限
            NavigatorUtil.push(context, new RoleManagePage());
            break;
          default:
            /// 客户关怀
            NavigatorUtil.push(context, new CustomerCareSetPage());
            break;
        }
      },
      child: Container(
          height: 45,
          color: AppColors.color_ffffff,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 20, height: 20, child: Image.asset(_list[row][0])),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(_list[row][1]),
                  ),
                  flex: 1,
                ),
                Container(
                  width: 20,
                  height: 20,
                  child: Icon(Icons.chevron_right),
                )
              ],
            ),
          )),
    );
  }
}
