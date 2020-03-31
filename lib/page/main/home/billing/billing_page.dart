import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/page/main/home/billing/car_search_page.dart';
import 'package:flutter_project1/page/main/home/billing/enter_license_page.dart';
import 'package:flutter_project1/page/main/home/billing/widget/scan_car_num_widget.dart';
import 'package:flutter_project1/page/main/home/customer/customer_search_page.dart';
import 'package:flutter_project1/util/log_util.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

import 'billing_content_page.dart';

class BillingPage extends StatefulWidget {
  @override
  _BillingPageState createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarView(
        title: '开单',
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: Screen.h(45)),
          color: AppColors.color_ffffff,
          child: Column(
            children: <Widget>[
              functionWidget(AppImages.billingScan, '扫车牌', () {
                ScanCarNum.scanCarNum().then((value) {
                  Log.info('carNum' + value);
                  NavigatorUtil.push(context, BillingContentPage(value));
                });
              }),
              functionWidget(AppImages.billingEdit, '输入车牌', () {
                NavigatorUtil.push(context, EnterLicensePage());
              }),
              functionWidget(AppImages.billingSearch, '搜索客户', () {
                NavigatorUtil.getValuePush(
                  context,
                  CarListSearchPage(),
                ).then((value) {
                  if(value == null) return;
                  NavigatorUtil.push(context, BillingContentPage(value));
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget functionWidget(
      String iconString, String title, GestureTapCallback gestureTapCallback) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(Screen.w(12)),
        child: AutoMakeLayoutWidget(
            width: Screen.w(),
            height: Screen.h(110),
            bgColor: AppColors.color_f4f4f4,
            bgCircle: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  iconString,
                  fit: BoxFit.contain,
                  width: Screen.w(36),
                  height: Screen.h(36),
                ),
                DividerUtil.VDivider(Screen.w(23)),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: CStyle.style(AppColors.color_434343, 20),
                ),
              ],
            )),
      ),
      onTap: gestureTapCallback,
    );
  }
}
