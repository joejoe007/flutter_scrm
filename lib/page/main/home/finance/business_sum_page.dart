import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/page/main/home/finance/open_statictisc_sum_page.dart';
import 'package:flutter_project1/page/main/home/finance/real_statictisc_sum_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/finance_statictisc_vmodel.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/common_widget_util.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

import 'member_card_statistic_page.dart';

class BusinessSumPage extends StatefulWidget {
  @override
  _BusinessSumPageState createState() => _BusinessSumPageState();
}

class _BusinessSumPageState extends State<BusinessSumPage> {
  BusinessSumVModel _businessSumVModel = BusinessSumVModel();
  String _currentString = '今天';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBarView(
          title: '营业汇总',
        ),
        backgroundColor: AppColors.color_f4f4f4,
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(Screen.w(12)),
              color: AppColors.color_ffffff,
              child: Row(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.color_f5f5f5,
                        borderRadius:
                        new BorderRadius.all(new Radius.circular(16)),
                      ),
                      padding: EdgeInsets.fromLTRB(
                          Screen.w(12), Screen.w(5), Screen.w(12), Screen.w(5)),
                      child: PopupMenuButton(
                        onSelected: (value) {
                          setState(() {
                            switch (value) {
                              case 1:
                                _currentString = '今天';
                                _businessSumVModel.setStartAndEndTime(
                                    DateUtil.getDateStrByDateTime(
                                        DateTime.now(),
                                        format: DateFormat.YEAR_MONTH_DAY),
                                    DateUtil.getDateStrByDateTime(
                                        DateTime.now(),
                                        format: DateFormat.YEAR_MONTH_DAY));
                                break;
                              case 2:
                                _currentString = '本月';
                                _businessSumVModel.setStartAndEndTime(
                                    DateTime.now().year.toString() +
                                        '-' +
                                        DateTime.now().month.toString() +
                                        '-01',
                                    DateUtil.getDateStrByDateTime(
                                        DateTime.now(),
                                        format: DateFormat.YEAR_MONTH_DAY));
                                break;
                              case 3:
                                _currentString = '本年';
                                _businessSumVModel.setStartAndEndTime(
                                    DateTime.now().year.toString() + '-01-01',
                                    DateUtil.getDateStrByDateTime(
                                        DateTime.now(),
                                        format: DateFormat.YEAR_MONTH_DAY));
                                break;
                              case 4:
                                _currentString = '其他';
                                _businessSumVModel.setStartAndEndTime(
                                    DateUtil.getDateStrByDateTime(
                                        DateTime.now(),
                                        format: DateFormat.YEAR_MONTH_DAY),
                                    DateUtil.getDateStrByDateTime(
                                        DateTime.now(),
                                        format: DateFormat.YEAR_MONTH_DAY));
                            }
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              _currentString,
                              style: CStyle.style(AppColors.color_434343, 15),
                            ),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Text('今天'),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text('本月'),
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: Text('本年'),
                          ),
                          PopupMenuItem(
                            value: 4,
                            child: Text('其他'),
                          ),
                        ],
                      )),
                  DividerUtil.VDivider(Screen.w(12)),
                  Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.color_f5f5f5,
                          borderRadius:
                          new BorderRadius.all(new Radius.circular(16)),
                        ),
                        padding: EdgeInsets.fromLTRB(
                            Screen.w(12), Screen.w(5), Screen.w(12), Screen.w(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Text(
                                _businessSumVModel.startTime,
                                style: CStyle.style(AppColors.color_434343, 15),
                              ),
                              onTap: () {
                                CommonWidgetUtil.chooseTime(
                                    context, DateTime(1900, 1, 1), DateTime.now(),
                                        (time) {
                                          _currentString = '其他';
                                          _businessSumVModel.setStartTime(time);
                                      setState(() {});
                                    });
                              },
                            ),
                            Text(
                              ' 至 ',
                              style: CStyle.style(AppColors.color_434343, 15),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Text(
                                _businessSumVModel.endTime,
                                style: CStyle.style(AppColors.color_434343, 15),
                              ),
                              onTap: () {
                                CommonWidgetUtil.chooseTime(
                                    context, DateTime(1900, 1, 1), DateTime.now(),
                                        (time) {
                                          _currentString = '其他';
                                          _businessSumVModel.setEndTime(time);
                                      setState(() {});
                                    });
                              },
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Expanded(child: LoadingContainer<BusinessSumVModel>(
              onModelReady: (model) {
                _businessSumVModel = model;
              },
              successChild: (model) {
                return ListView(
                  children: <Widget>[
                    _commonItem(
                        '营业统计',
                        _itemChild('营业额', '¥' + StringUtil.checkEmpty(model.businessDetailModel?.businessTotal?.toString(), '0')),
                        _itemChild('实收', '¥' + StringUtil.checkEmpty(model.businessDetailModel?.businessReal?.toString(), '0')),
                        _itemChild('毛利', '¥' + StringUtil.checkEmpty(model.businessDetailModel?.businessPure?.toString(), '0'))),
                    _commonItem(
                        '会员卡统计',
                        _itemChild('会员卡销售', '¥' + StringUtil.checkEmpty(model.businessDetailModel?.cardSales?.cardSale?.toString(), '0')),
                        _itemChild('会员卡消费', '¥' + StringUtil.checkEmpty(model.businessDetailModel?.cardConsume?.totalMoney?.toString(), '0')),
                        _itemChild('剩余总值', '¥' + StringUtil.checkEmpty(model.businessDetailModel?.cardLeft?.totalMoney?.toString(), '0'))),
                    _commonItem(
                        '进店台次统计',
                        _itemChild('新车进店（台）', StringUtil.checkEmpty(model.businessDetailModel.carNew?.toString(), '0')),
                        _itemChild('老客车辆（台）', StringUtil.checkEmpty(model.businessDetailModel.carOld?.toString(), '0')),
                        _itemChild('会员车辆（台）', StringUtil.checkEmpty(model.businessDetailModel.carMember?.toString(), '0'))),
                    Container(
                      margin: EdgeInsets.all(Screen.w(12)),
                      padding: EdgeInsets.all(Screen.w(12)),
                      decoration: BoxDecoration(
                        color: AppColors.color_ffffff,
                        borderRadius:
                        new BorderRadius.all(new Radius.circular(5)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  AppImages.financeTotal,
                                  fit: BoxFit.contain,
                                  width: Screen.w(17),
                                  height: Screen.h(20),
                                ),
                                DividerUtil.HDivider(Screen.w(12)),
                                Text(
                                  '营业汇总',
                                  style:
                                  CStyle.style(AppColors.color_212121, 16),
                                ),
                              ],
                            ),
                            onTap: () {
                              print('startTime' + model.startTime.toString());
                              print('endTime' + model.endTime.toString());
                              NavigatorUtil.push(context, OpenStatisticSumPage(begin: model.startTime, end: model.endTime,));
                            },
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  AppImages.financeReal,
                                  fit: BoxFit.contain,
                                  width: Screen.w(17),
                                  height: Screen.h(20),
                                ),
                                DividerUtil.HDivider(Screen.w(12)),
                                Text(
                                  '实收统计',
                                  style:
                                  CStyle.style(AppColors.color_212121, 16),
                                ),
                              ],
                            ),
                            onTap: () {
                              NavigatorUtil.push(
                                  context, RealStatisticSumPage(begin: model.startTime, end: model.endTime,));
                            },
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  AppImages.financeCard,
                                  fit: BoxFit.contain,
                                  width: Screen.w(17),
                                  height: Screen.h(20),
                                ),
                                DividerUtil.HDivider(Screen.w(12)),
                                Text(
                                  '会员卡统计',
                                  style:
                                  CStyle.style(AppColors.color_212121, 16),
                                ),
                              ],
                            ),
                            onTap: () {
                              NavigatorUtil.push(context, MemberCardStatPage(begin: model.startTime, end: model.endTime,));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              model: BusinessSumVModel(),
            ),),
          ],
        ));
  }
}

/// item
Widget _commonItem(String title, Widget first, Widget second, Widget last) {
  return Container(
      margin: EdgeInsets.all(Screen.w(12)),
      decoration: BoxDecoration(
        color: AppColors.color_ffffff,
        borderRadius: new BorderRadius.all(new Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Screen.w(12)),
            child: Text(
              title,
              style: CStyle.style(AppColors.color_434343, 15),
            ),
          ),
          Divider(
            height: Screen.h(0.5),
          ),
          Container(
            padding: EdgeInsets.all(Screen.w(12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[first, second, last],
            ),
          )
        ],
      ));
}

Widget _itemChild(String title, String value) {
  return Column(
    children: <Widget>[
      Text(
        title,
        style: CStyle.style(AppColors.color_212121, 14),
      ),
      DividerUtil.HDivider(Screen.w(12)),
      Text(
        value,
        style: CStyle.style(AppColors.color_ff3c48, 15),
      ),
    ],
  );
}
