import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/finance_model.dart';
import 'package:flutter_project1/page/main/home/finance/open_statictisc_sum_page.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/finance_statictisc_vmodel.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/common_widget_util.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';

class MemberCardStatPage extends StatefulWidget {

  String begin, end;

  MemberCardStatPage({this.begin, this.end});

  @override
  _MemberCardStatPageState createState() => _MemberCardStatPageState();
}

class _MemberCardStatPageState extends State<MemberCardStatPage>
    with SingleTickerProviderStateMixin {
  TabController mController;

  @override
  void initState() {
    super.initState();
    mController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBarView(
          title: '会员卡统计',
          showBottomLine: false,
        ),
        backgroundColor: AppColors.color_f4f4f4,
        body: SafeArea(
            child: LoadingContainer<MemberTopMoneyVModel>(
                onModelReady: (model) {
                  model.setSuccess();
                },
                successChild: (model) {
                  return Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(Screen.w(12)),
                          color: AppColors.color_ffffff,
                          child: Center(
                            child: Container(
                              width: Screen.w(250),
                              decoration: BoxDecoration(
                                color: AppColors.color_f5f5f5,
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(16)),
                              ),
                              padding: EdgeInsets.fromLTRB(
                                  0, Screen.w(5), 0, Screen.w(5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    child: Text(
                                      StringUtil.checkEmpty(model.begin?.toString(), widget.begin.toString()),
                                      style: CStyle.style(
                                          AppColors.color_434343, 15),
                                    ),
                                    onTap: () {
                                      CommonWidgetUtil.chooseTime(
                                          context,
                                          DateTime(1900, 1, 1),
                                          DateTime.now(), (time) {
                                        model.begin = time;
                                        memberCardSumVModel.beginTime = time;
                                        memberTotalMoneyVModel.beginTime = time;
                                      });
                                    },
                                    behavior: HitTestBehavior.opaque,
                                  ),
                                  Text(
                                    ' 至 ',
                                    style: CStyle.style(
                                        AppColors.color_434343, 15),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: Text(
                                      StringUtil.checkEmpty(model.end?.toString(), widget.end.toString()),
                                      style: CStyle.style(
                                          AppColors.color_434343, 15),
                                    ),
                                    onTap: () {
                                      CommonWidgetUtil.chooseTime(
                                          context,
                                          DateTime(1900, 1, 1),
                                          DateTime.now(), (time) {
                                        model.end = time;
                                        memberCardSumVModel.endTime = time;
                                        memberTotalMoneyVModel.endTime = time;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Container(
                        height: Screen.h(120),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            gradient: LinearGradient(colors: [
                              AppColors.color_fb5f65,
                              AppColors.color_f73b42
                            ])),
                        margin: EdgeInsets.all(Screen.w(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '会员卡销售',
                                  style:
                                      CStyle.style(AppColors.color_ffffff, 13),
                                ),
                                DividerUtil.HDivider(Screen.h(10)),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '¥',
                                      style: CStyle.style(
                                          AppColors.color_ffffff, 14),
                                    ),
                                    DividerUtil.VDivider(Screen.w(10)),
                                    Text(
                                      StringUtil.checkEmpty(model.memberSaleTotalModel?.sale?.toString(), '0'),
                                      style: CStyle.style(
                                          AppColors.color_ffffff, 33),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '剩余总值',
                                  style:
                                      CStyle.style(AppColors.color_ffffff, 13),
                                ),
                                DividerUtil.HDivider(Screen.h(10)),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '¥',
                                      style: CStyle.style(
                                          AppColors.color_ffffff, 14),
                                    ),
                                    DividerUtil.VDivider(Screen.w(10)),
                                    Text(
                                      StringUtil.checkEmpty(model.memberSaleTotalModel?.balance?.toString(), '0'),
                                      style: CStyle.style(
                                          AppColors.color_ffffff, 33),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                      ),

                      /// tab 头部
                      Container(
                        height: Screen.h(45),
                        child: TabBar(
                          onTap: (index) {},
                          indicatorSize: TabBarIndicatorSize.label,
                          controller: mController,
                          labelColor: AppColors.color_ff3b25,
                          indicatorColor: AppColors.color_ff3b25,
                          unselectedLabelColor: AppColors.color_666666,
                          labelStyle: TextStyle(fontSize: Screen.sp(14)),
                          tabs: <Widget>[
                            new Text('会员卡销售'),
                            new Text('剩余总值'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: mController,
                          children: <Widget>[
                            _AllCardSellPage(
                                begin: model.begin, end: model.end),
                            // 会员卡销售
                            _AllLastSellPage(
                                begin: model.begin, end: model.end),
                            // 剩余总额
                          ],
                        ),
                      )
                    ],
                  );
                },
                model: MemberTopMoneyVModel(widget.begin, widget.end))));
  }
}

MemberCardSumVModel memberCardSumVModel;

/// 会员卡销售
class _AllCardSellPage extends StatefulWidget {
  String begin, end;

  _AllCardSellPage({this.begin, this.end});

  @override
  AllCardSellPageState createState() => new AllCardSellPageState();
}

class AllCardSellPageState extends State<_AllCardSellPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return LoadingContainer<MemberCardSumVModel>(
        refreshType: RefreshType.withwidget,
        autoDispose: false,
        onModelReady: (model) {
          memberCardSumVModel = model;
        },
        successChild: (model) {
          return ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (BuildContext context, int index) {
              return _realItem(model.list[index]);
            },
          );
        },
        outRefreshChild: (model, easy) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  _realItemHeader(),
                  Expanded(
                    child: easy,
                  )
                ],
              ),
              width: Screen.w(),
              margin: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
            ),
            scrollDirection: Axis.horizontal,
          );
        },
        model: MemberCardSumVModel(widget.begin, widget.end));
  }
}

/// item headerr
Widget _realItemHeader() {
  return Table(
    //表格边框样式
    border: TableBorder.all(
      color: AppColors.color_666666,
    ),
    children: [
      TableRow(children: [
        titleItem('会员卡名称', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('售卡数量', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('售卡金额', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('续卡金额', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('退卡金额', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('合计', AppColors.color_212121, AppColors.color_f5f5f5, 35),
      ]),
    ],
  );
}

/// item
Widget _realItem(MemberCardSalesItemModel model) {
  return Table(
    //表格边框样式
    border: TableBorder(
      verticalInside: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      horizontalInside: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      left: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      right: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      top: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.25),
      ),
      bottom: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.25),
      ),
    ),
    children: [
      TableRow(children: [
        titleItem(StringUtil.checkEmpty(model?.cardName?.toString()), AppColors.color_999999, AppColors.color_ffffff, 40),
        titleItem(StringUtil.checkEmpty(model?.saleCount?.toString(), '0'), AppColors.color_999999, AppColors.color_ffffff, 40),
        titleItem(StringUtil.checkEmpty(model?.cardPrice?.toString(), '0'), AppColors.color_999999, AppColors.color_ffffff, 40),
        titleItem(StringUtil.checkEmpty(model?.rechargePrice?.toString(), '0'), AppColors.color_999999, AppColors.color_ffffff, 40),
        titleItem(StringUtil.checkEmpty(model?.refundPrice?.toString(), '0'), AppColors.color_999999, AppColors.color_ffffff, 40),
        titleItem(StringUtil.checkEmpty(model?.total?.toString(), '0'), AppColors.color_999999, AppColors.color_ffffff, 40),
      ]),
    ],
  );
}

MemberTotalMoneyVModel memberTotalMoneyVModel;

/// 剩余总值
class _AllLastSellPage extends StatefulWidget {
  String begin, end;

  _AllLastSellPage({this.begin, this.end});

  @override
  _AllLastSellPageState createState() => new _AllLastSellPageState();
}

class _AllLastSellPageState extends State<_AllLastSellPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return LoadingContainer<MemberTotalMoneyVModel>(
        refreshType: RefreshType.withwidget,
        onModelReady: (model) {
          memberTotalMoneyVModel = model;
        },
        autoDispose: false,
        successChild: (model) {
          return ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (BuildContext context, int index) {
              return _realLastItem(model.list[index]);
            },
          );
        },
        outRefreshChild: (model, easy) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  _realLastItemHeader(),
                  Expanded(
                    child: easy,
                  )
                ],
              ),
              width: Screen.w(),
              margin: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
            ),
            scrollDirection: Axis.horizontal,
          );
        },
        model: MemberTotalMoneyVModel(widget.begin, widget.end));
  }
}

/// item headerr
Widget _realLastItemHeader() {
  return Table(
    //表格边框样式
    border: TableBorder.all(
      color: AppColors.color_666666,
    ),
    children: [
      TableRow(children: [
        titleItem('会员卡名称', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('现金余额', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('服务', AppColors.color_212121, AppColors.color_f5f5f5, 35),
        titleItem('剩余次数', AppColors.color_212121, AppColors.color_f5f5f5, 35),
      ]),
    ],
  );
}

/// item
Widget _realLastItem(MemberCardMoneyItemModel model) {
  List<Widget> listWidgetFirst = [];
  for (Service o in model.services) {
    listWidgetFirst.add(
      titleItem(StringUtil.checkEmpty(o?.itemName?.toString()), AppColors.color_999999, AppColors.color_ffffff, 40),
    );
  }
  List<Widget> listWidgetSecond = [];
  for (Service o in model.services) {
    listWidgetSecond.add(
      titleItem(StringUtil.checkEmpty(o?.leftTimes?.toString(), '0'), AppColors.color_999999, AppColors.color_ffffff, 40),
    );
  }
  return Table(
    //表格边框样式
    border: TableBorder(
      verticalInside: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      horizontalInside: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      left: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      right: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.5),
      ),
      top: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.25),
      ),
      bottom: BorderSide(
        color: AppColors.color_999999,
        width: Screen.w(0.25),
      ),
    ),
    children: [
      TableRow(children: [
        Container(
          height: Screen.h(40) * model.services.length,
          alignment: Alignment.center,
          color: AppColors.color_ffffff,
          child: Text(
            StringUtil.checkEmpty(model?.cardTypeName?.toString()),
            style: CStyle.style(AppColors.color_999999, 14),
          ),
        ),
        Container(
          height: Screen.h(40) * model.services.length,
          alignment: Alignment.center,
          color: AppColors.color_ffffff,
          child: Text(
            StringUtil.checkEmpty(model?.balance?.toString()),
            style: CStyle.style(AppColors.color_999999, 14),
          ),
        ),
        Container(
          height: Screen.h(40) * model.services.length,
          alignment: Alignment.center,
          color: AppColors.color_ffffff,
          child: Column(
            children: listWidgetFirst,
          ),
        ),
        Container(
          height: Screen.h(40) * model.services.length,
          alignment: Alignment.center,
          color: AppColors.color_ffffff,
          child: Column(
            children: listWidgetSecond,
          ),
        ),
      ]),
    ],
  );
}
