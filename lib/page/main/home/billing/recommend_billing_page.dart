import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/billing_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:flutter_project1/widget/round_check_box.dart';

class RecommendBillingPage extends StatefulWidget {
  dynamic customerId;

  RecommendBillingPage(this.customerId);

  @override
  RecommendBillingPageState createState() => RecommendBillingPageState();
}

class RecommendBillingPageState extends State<RecommendBillingPage>
    with SingleTickerProviderStateMixin {
  TabController mController;
  String key;

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
    return new Scaffold(
      appBar: MyAppBarView(
        title: '推荐开单',
      ),
      backgroundColor: AppColors.color_f4f4f4,
      body: SafeArea(child: _tabBar),
    );
  }

  /// 头部
  Widget get _tabBar {
    return Column(children: <Widget>[
      Container(
        color: AppColors.color_ffffff,
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
            new Text('会员卡'),
            new Text('消费记录'),
          ],
        ),
      ),
      Expanded(
        child: TabBarView(
          controller: mController,
          children: <Widget>[
            _memberRecommend(widget.customerId), // 会员卡
            _consumeRecommed(widget.customerId), // 消费记录
          ],
        ),
      )
    ]);
  }
}

/// 消费记录
class _consumeRecommed extends StatefulWidget {
  dynamic consumeId;

  _consumeRecommed(this.consumeId);

  @override
  _consumeRecommedState createState() => new _consumeRecommedState();
}

class _consumeRecommedState extends State<_consumeRecommed>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return LoadingContainer<RecommendCardConsumeListVModel>(
        autoDispose: false,
        onModelReady: (model) {
          model.getRecentOrderList(widget.consumeId);
        },
        successChild: (model) {
          return Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (index == model.list.length)
                        return DividerUtil.HDivider(Screen.h(120));
                      return _builderConsumeItem(model, context, index);
                    },
                    itemCount: model.list.length + 1,
                  )),
                ],
              ),
              Positioned(
                bottom: Screen.h(0),
                left: Screen.w(0),
                right: Screen.w(0),
                child: Center(
                  child: AutoMakeLayoutWidget(
                    margin: EdgeInsets.all(Screen.w(12)),
                    gradient: LinearGradient(colors: [
                      AppColors.color_fb5f65,
                      AppColors.color_f73b42
                    ]),
                    gestureTapCallback: () {
                      if (model.getNum() == 0) {
                        MyToast.showToast('未勾选任何内容');
                        return;
                      }
                      Navigator.of(context)
                          .pop([1, model.getChooseRecentOrder()]);
                    },
                    child: Text(
                      '开单（已选' + model.getNum().toString() + '项）',
                      style: TextStyle(
                          color: AppColors.color_ffffff,
                          fontSize: Screen.sp(17)),
                    ),
                    height: Screen.h(50),
                    width: Screen.w(300),
                    bgCircle: 25,
                  ),
                ),
              ),
            ],
          );
        },
        model: RecommendCardConsumeListVModel());
  }

  Widget _builderConsumeItem(
      RecommendCardConsumeListVModel model, BuildContext context, int index1) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.color_ffffff,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        margin: EdgeInsets.fromLTRB(
            Screen.w(12), Screen.w(6), Screen.w(12), Screen.w(6)),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(Screen.w(12)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      model.list[index1].orderNo.toString(),
                      style: CStyle.style(AppColors.color_212121, 17),
                    ),
                  ),
                  RoundCheckBox(
                      value: model.list[index1].choose,
                      onChanged: (value) {
                        model.list[index1].choose = value;
                        model.notifyListeners();
                      }),
                ],
              ),
            ),
            Divider(
              height: Screen.h(0.5),
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(Screen.w(12)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          StringUtil.getSplitString(
                                  model.list[index1].itemNames.toString(),
                                  ',')[index]
                              .toString(),
                          style: CStyle.style(AppColors.color_666666, 14),
                        ),
                      ),
                      DividerUtil.VDivider(Screen.w(12)),
                    ],
                  ),
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: StringUtil.getSplitString(
                      model.list[index1].itemNames.toString(), ',')
                  .length,
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}

/// 会员卡
class _memberRecommend extends StatefulWidget {
  dynamic customerId;

  _memberRecommend(this.customerId);

  @override
  _memberRecommendState createState() => new _memberRecommendState();
}

class _memberRecommendState extends State<_memberRecommend>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return LoadingContainer<RecommendCardListVModel>(
        autoDispose: false,
        onModelReady: (model) {
          model.getCardList(widget.customerId);
        },
        successChild: (model) {
          return Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (index == model.map.length)
                          return DividerUtil.HDivider(Screen.h(120));
                        return _builderItem(model, context, index);
                      },
                      shrinkWrap: true,
                      itemCount: model.map.length + 1,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: Screen.h(0),
                left: Screen.w(0),
                right: Screen.w(0),
                child: Center(
                  child: AutoMakeLayoutWidget(
                    margin: EdgeInsets.all(Screen.w(12)),
                    gradient: LinearGradient(colors: [
                      AppColors.color_fb5f65,
                      AppColors.color_f73b42
                    ]),
                    gestureTapCallback: () {
                      if (model.getNum() == 0) {
                        MyToast.showToast('未勾选任何内容');
                        return;
                      }
                      Navigator.of(context).pop([0, model.getChooseCard()]);
                    },
                    child: Text(
                      '开单（已选' + model.getNum().toString() + '项）',
                      style: TextStyle(
                          color: AppColors.color_ffffff,
                          fontSize: Screen.sp(17)),
                    ),
                    height: Screen.h(50),
                    width: Screen.w(300),
                    bgCircle: 25,
                  ),
                ),
              ),
            ],
          );
        },
        model: RecommendCardListVModel());
  }

  Widget _topHeader(String left) {
    return Container(
      padding: EdgeInsets.all(Screen.w(12)),
      child: Row(
        children: <Widget>[
          Text(
            left,
            style: CStyle.style(AppColors.color_212121, 17),
          ),
        ],
      ),
    );
  }

  Widget _builderItem(
      RecommendCardListVModel model, BuildContext context, int index1) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.color_ffffff,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        margin: EdgeInsets.fromLTRB(
            Screen.w(12), Screen.w(6), Screen.w(12), Screen.w(6)),
        child: Column(
          children: <Widget>[
            _topHeader(model.map.keys.toList()[index1]),
            Divider(
              height: Screen.h(0.5),
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(Screen.w(12)),
                  child: Row(
                    children: <Widget>[
                      Text(
                        model.map.values
                            .toList()[index1][index]
                            .itemName
                            .toString(),
                        style: CStyle.style(AppColors.color_666666, 14),
                      ),
                      Expanded(
                        child: Text(
                          '剩余' +
                              model.map.values
                                  .toList()[index1][index]
                                  .balance
                                  .toString() +
                              '次',
                          style: CStyle.style(AppColors.color_999999, 12),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      DividerUtil.VDivider(Screen.w(12)),
                      Container(
                        child: RoundCheckBox(
                            value:
                                model.map.values.toList()[index1][index].choose,
                            onChanged: (value) {
                              model.map.values.toList()[index1][index].choose =
                                  value;
                              model.notifyListeners();
                            }),
                      )
                    ],
                  ),
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.map.values.toList()[index1].length,
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
