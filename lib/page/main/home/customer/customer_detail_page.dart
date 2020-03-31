import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/page/main/home/billing/billing_content_page.dart';
import 'package:flutter_project1/page/main/home/customer/consume_record_page.dart';
import 'package:flutter_project1/page/main/home/customer/customer_change_person_page.dart';
import 'package:flutter_project1/page/main/home/handlecard/opencardlist_page.dart';
import 'package:flutter_project1/page/main/home/membershipcard/memshipcard_detail_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/customer_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:quiver/strings.dart';

import 'customer_change_car_page.dart';

class CustomerDetailPage extends StatefulWidget {
  dynamic id;

  CustomerDetailPage(this.id);

  @override
  CustomerDetailPageState createState() => new CustomerDetailPageState(id);
}

class CustomerDetailPageState extends State<CustomerDetailPage> {
  dynamic id;

  CustomerDetailPageState(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: MyAppBarView(
          title: '客户详情',
          isBrightnessDark: false,
          leftIconColor: AppColors.color_ffffff,
          leftIcon: Icons.keyboard_arrow_left,
          barBackColor: AppColors.color_f73b42,
          titleColor: AppColors.color_ffffff,
          rightIconTitleColor: AppColors.color_ffffff,
          showBottomLine: false,
        ),
        body: Container(
          color: AppColors.color_f4f4f4,
          child: Stack(
            children: <Widget>[
              Container(
                color: AppColors.color_f73b42,
                height: Screen.h(100),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
                child: LoadingContainer<CustomDetailVModel>(
                    onModelReady: (model) {
                      model.setCustomerId(id: id);
                    },
                    successChild: (model) {
                      return Container(
                          child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView(
                              children: <Widget>[
                                /// 头部信息
                                _customHeader(context, model),

                                /// 车辆详情
                                _carInfo(context, model),

                                /// 会员卡信息
                                _membershipCardInfo(model),

                                /// 订单信息
                                _orderInfo(context, model),

                                DividerUtil.HDivider(Screen.h(30)),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: AutoMakeLayoutWidget(
                                    gradient: LinearGradient(colors: [
                                      AppColors.color_fb9b39,
                                      AppColors.color_fbbe50
                                    ]),
                                    gestureTapCallback: () {
                                      NavigatorUtil.getValuePush(context, OpenCardListPage(userId: id,)).then((value){
                                        if(value == null) return;
                                        model.onDataReady();
                                      });
                                    },
                                    child: Text(
                                      '办卡',
                                      style: TextStyle(
                                          color: AppColors.color_ffffff,
                                          fontSize: Screen.sp(17)),
                                    ),
                                    height: Screen.h(40),
                                    width: Screen.w(),
                                    bgCircle: 25,
                                  ),
                                ),
                                DividerUtil.VDivider(Screen.w(12)),
                                Expanded(
                                  child: AutoMakeLayoutWidget(
                                    gradient: LinearGradient(colors: [
                                      AppColors.color_fb5f65,
                                      AppColors.color_f73b42
                                    ]),
                                    gestureTapCallback: () {
                                      if (model.customDetailModel == null ||
                                          model.customDetailModel.cars ==
                                              null ||
                                          model.customDetailModel.cars.length ==
                                              0) {
                                        MyToast.showToast('没有车辆信息！');
                                        return;
                                      }
                                      NavigatorUtil.push(context, BillingContentPage(model.customDetailModel.cars[0].carNo,));
                                    },
                                    child: Text(
                                      '开单',
                                      style: TextStyle(
                                          color: AppColors.color_ffffff,
                                          fontSize: Screen.sp(17)),
                                    ),
                                    height: Screen.h(40),
                                    width: Screen.w(),
                                    bgCircle: 25,
                                  ),
                                  flex: 2,
                                )
                              ],
                            ),
                            margin: EdgeInsets.fromLTRB(Screen.w(12),
                                Screen.w(12), Screen.w(12), Screen.w(30)),
                          )
                        ],
                      ));
                    },
                    model: CustomDetailVModel()),
              ),
            ],
          ),
        ));
  }
}

/// 头部信息
Widget _customHeader(BuildContext context, CustomDetailVModel model) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(prefix0.Radius.circular(5))),
    color: AppColors.color_ffffff,
    child: Padding(
      padding: EdgeInsets.all(Screen.w(20)),
      child: Column(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: <Widget>[
                Container(
                    height: Screen.w(60),
                    width: Screen.w(60),
                    child: CircleAvatar(
                        child: Text(
                          isEmpty(model.customDetailModel?.name?.toString())
                              ? ''
                              : model.customDetailModel.name.substring(0, 1),
                          style: TextStyle(
                              fontSize: Screen.sp(30),
                              color: AppColors.color_ffffff,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: AppColors.color_fbbe50)),
                DividerUtil.VDivider(Screen.w(16)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            isEmpty(model.customDetailModel?.name?.toString())
                                ? '未知'
                                : model.customDetailModel.name.toString(),
                            style: TextStyle(
                                fontSize: Screen.sp(24),
                                color: AppColors.color_212121,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          DividerUtil.VDivider(Screen.w(8.5)),
                          Visibility(
                            child: AutoMakeLayoutWidget(
                              width: Screen.w(35),
                              height: Screen.h(21),
                              bgCircle: 5,
                              gradient: LinearGradient(colors: [
                                AppColors.color_f2c97f,
                                AppColors.color_cb993e
                              ]),
                              child: Text(
                                '会员',
                                style: TextStyle(
                                    color: AppColors.color_ffffff,
                                    fontSize: Screen.sp(13)),
                              ),
                            ),
                            visible: Member.boolMember(model.customDetailModel?.customerType),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                      Align(
                        child: Text(
                          isEmpty(model.customDetailModel?.mobile?.toString()) ? '' : model.customDetailModel.mobile.toString(),
                          style: TextStyle(
                              fontSize: Screen.sp(15),
                              color: AppColors.color_666666),
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    ],
                  ),
                  flex: 1,
                ),
                Center(
                  child: Icon(
                    Icons.chevron_right,
                    color: AppColors.color_999999,
                  ),
                ),
              ],
            ),
            onTap: () {
              /// 修改个人信息
              NavigatorUtil.getValuePush(
                  context,
                  CustomerChangePersonPage(
                    customDetailModel: model.customDetailModel,
                    customerId: model.id,
                  )).then((value){
                    if(value != null) {
                      model.onDataReady();
                    }
              });
            },
          ),
          DividerUtil.HDivider(Screen.h(30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _consumptionWidget(
                  '消费次数',
              StringUtil.checkEmpty(model.customerConsumeTotalModel?.consumeCount?.toString(),'0')),
              Container(
                height: Screen.h(30),
                child: VerticalDivider(
                  width: Screen.w(0.5),
                  color: AppColors.color_959595,
                ),
              ),
              _consumptionWidget(
                  '累计消费(元)',
                StringUtil.checkEmpty(model.customerConsumeTotalModel?.consumeMoney?.toString(),'0')),
                Container(
                height: Screen.h(30),
                child: VerticalDivider(
                  width: Screen.w(0.5),
                  color: AppColors.color_959595,
                ),
              ),
              _consumptionWidget(
                  '挂帐消费(元)',
                  StringUtil.checkEmpty(model.customerConsumeTotalModel?.consumeMoney?.toString(),'0')),
            ],
          ),
        ],
      ),
    ),
  );
}

/// 消费账单item
Widget _consumptionWidget(String content, String num) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        num,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Screen.sp(24),
            color: AppColors.color_212121),
      ),
      Padding(
        padding: EdgeInsets.only(top: Screen.h(6)),
        child: Text(
          content,
          style:
              TextStyle(fontSize: Screen.sp(11), color: AppColors.color_999999),
        ),
      )
    ],
  );
}

/// 车辆详情
Widget _carInfo(BuildContext context, CustomDetailVModel model) {
  return Card(
    margin: EdgeInsets.only(top: Screen.h(8)),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(prefix0.Radius.circular(5))),
    color: AppColors.color_ffffff,
    child: Padding(
      padding: EdgeInsets.fromLTRB(Screen.h(10), 0, Screen.h(10), 0),
      child: Column(
        children: <Widget>[
          _listHeaderCommon(
              '车辆信息',
              GestureDetector(
                child: Text(
                  '+ 新增车辆',
                  style: TextStyle(
                      color: AppColors.color_f73b42, fontSize: Screen.sp(12)),
                ),
                onTap: () {
                  NavigatorUtil.getValuePush(
                      context,
                      CustomerChangeCarPage(
                        customDetailModel: model.customDetailModel,
                        customerId: model.id,
                      )).then((value){
                        if(value != null){
                          model.onDataReady();
                        }
                  });
                },
              )),
          Divider(
            height: Screen.h(0.5),
            color: AppColors.color_959595,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: _buildCarInfoListItemWidget(
                    StringUtil.checkEmpty(model.customDetailModel?.cars[index]?.carNo?.toString(),''),
                    StringUtil.checkEmpty(model.customDetailModel?.cars[index]?.carBrandName?.toString(),'')),
                  onTap: () {
                    NavigatorUtil.getValuePush(
                        context,
                        CustomerChangeCarPage(
                          canChangeCarNo: false,
                          customDetailModel: model.customDetailModel,
                          customDetailCarModel:
                              model.customDetailModel.cars[index],
                          customerId: model.id,
                        )).then((value){
                          if(value != null) {
                            model.onDataReady();
                          }
                    });
                  },
                );
              },
              itemCount: model.customDetailModel?.cars == null ? 0 : model.customDetailModel.cars.length)
        ],
      ),
    ),
  );
}

/// 会员卡信息
Widget _membershipCardInfo(CustomDetailVModel model) {
  return Card(
    margin: EdgeInsets.only(top: Screen.h(8)),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(prefix0.Radius.circular(5))),
    color: AppColors.color_ffffff,
    child: Padding(
      padding: EdgeInsets.fromLTRB(Screen.h(10), 0, Screen.h(10), 0),
      child: Column(
        children: <Widget>[
          _listHeaderCommon(
            '会员卡信息',
            Text(
              '',
              style: TextStyle(
                  color: AppColors.color_bcbcbc, fontSize: Screen.sp(12)),
            ),
          ),
          Divider(
            height: Screen.h(0.5),
            color: AppColors.color_959595,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: _buildMemberInfoListItemWidget(
                      StringUtil.checkEmpty(model.userCardList[index]?.cardName?.toString()),
                      '剩余' + StringUtil.checkEmpty(model.userCardList[index]?.balance?.toString(),'0') + '元，剩余'
                          + StringUtil.checkEmpty(model.userCardList[index]?.leftTimes?.toString(),'0') + '次'),
                  onTap: () {
                    NavigatorUtil.push(
                        context,
                        new MemShipCardDetailPage(
                          cardId: model.userCardList[index].id,
                        ));
                  },
                );
              },
              itemCount:
                  model.userCardList == null ? 0 : model.userCardList.length)
        ],
      ),
    ),
  );
}

/// 订单信息
Widget _orderInfo(BuildContext context, CustomDetailVModel model) {
  return GestureDetector(
    child: Card(
      margin: EdgeInsets.only(top: Screen.h(8)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(prefix0.Radius.circular(5))),
      color: AppColors.color_ffffff,
      child: Padding(
        padding: EdgeInsets.fromLTRB(Screen.h(10), 0, Screen.h(10), 0),
        child: _listHeaderCommon(
            '订单信息',
            Row(
              children: <Widget>[
                Text(
                  '订单记录',
                  style: TextStyle(
                      color: AppColors.color_999999, fontSize: Screen.sp(12)),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.color_999999,
                ),
              ],
            )),
      ),
    ),
    onTap: () {
      NavigatorUtil.push(
          context,
          ConsumeRecordPager(
            customerId: model.id,
          ));
    },
  );
}

/// 会员卡信息列表内容
Widget _buildMemberInfoListItemWidget(String title, String content) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, Screen.h(10), 0, Screen.h(10)),
    color: AppColors.color_ffffff,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style:
              TextStyle(fontSize: Screen.sp(12), color: AppColors.color_212121),
        ),
        Expanded(
          child: Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  content,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: AppColors.color_666666, fontSize: Screen.sp(12)),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.color_999999,
                ),
              ],
            ),
            alignment: Alignment.centerRight,
          ),
        )
      ],
    ),
  );
}

/// 车辆信息列表内容
Widget _buildCarInfoListItemWidget(String title, String content) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, Screen.h(10), 0, Screen.h(10)),
    color: AppColors.color_ffffff,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style:
              TextStyle(fontSize: Screen.sp(12), color: AppColors.color_212121),
        ),
        DividerUtil.VDivider(Screen.w(15)),
        Text(
          content,
          textAlign: TextAlign.left,
          style:
              TextStyle(color: AppColors.color_666666, fontSize: Screen.sp(12)),
        ),
        Expanded(
          child: Align(
            child: Icon(
              Icons.chevron_right,
              color: AppColors.color_999999,
            ),
            alignment: Alignment.centerRight,
          ),
        )
      ],
    ),
  );
}

/// 列表头部
Widget _listHeaderCommon(String title, Widget child) {
  return Container(
    color: AppColors.color_ffffff,
    padding: EdgeInsets.fromLTRB(0, Screen.h(10), 0, Screen.h(10)),
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: Screen.w(2),
              height: Screen.h(15),
              decoration: BoxDecoration(
                  color: AppColors.color_f73b42,
                  borderRadius: BorderRadius.all(prefix0.Radius.circular(5))),
            ),
            DividerUtil.VDivider(Screen.w(7.5)),
            Text(
              title,
              style: TextStyle(
                  color: AppColors.color_212121,
                  fontSize: Screen.sp(16),
                  fontWeight: FontWeight.bold),
            )
          ],
        )),
        child,
      ],
    ),
  );
}
