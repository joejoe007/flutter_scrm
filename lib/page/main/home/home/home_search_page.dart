import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/model/order_list_item_model.dart';
import 'package:flutter_project1/page/main/home/billing/billing_content_page.dart';
import 'package:flutter_project1/page/main/home/billing/billing_operate_util.dart';
import 'package:flutter_project1/page/main/home/customer/customer_detail_page.dart';
import 'package:flutter_project1/page/main/home/customer/widget/customer_list_widget.dart';
import 'package:flutter_project1/page/main/home/order/order_detail_page.dart';
import 'package:flutter_project1/page/main/home/order/widget/order_list_widget.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/viewmodel/customer_vmodel.dart';
import 'package:flutter_project1/viewmodel/order_vmodel.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/search_appbar_widget.dart';

CustomerVModel _customerVModel;
OrderVModel _orderVModel;

class HomeSearchPage extends StatefulWidget {
  String _key;

  HomeSearchPage({String key = ''}) {
    this._key = key;
  }

  @override
  HomeSearchPagerState createState() => HomeSearchPagerState();
}

class HomeSearchPagerState extends State<HomeSearchPage>
    with TickerProviderStateMixin {
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
  void dispose() {
    mController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: SearchAppBar(
        inputText: widget._key,
        fieldCallBack: (content) {
          widget._key = content;
          _orderVModel?.setKey(content);
          _customerVModel?.setKey(content);
          setState(() {});
        },
      ),
      backgroundColor: AppColors.color_f4f4f4,
      resizeToAvoidBottomPadding: false,
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
            new Text('订单'),
            new Text('客户'),
          ],
        ),
      ),
      Expanded(
        child: TabBarView(
          controller: mController,
          children: <Widget>[
            _AllOrderListPage(widget._key), // 订单
            _AllCustomerListPage(widget._key), // 客户
          ],
        ),
      )
    ]);
  }
}

/// 订单模块
/// 订单列表，type类型
class _AllOrderListPage extends StatefulWidget {
  String _keyWords;

  _AllOrderListPage(this._keyWords);

  @override
  _AllOrderListPageState createState() => new _AllOrderListPageState();
}

class _AllOrderListPageState extends State<_AllOrderListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new LoadingContainer<OrderVModel>(
        onModelReady: (model) {
          _orderVModel = model;
        },
        refreshType: RefreshType.normal,
        successChild: (model) {
          return ListView.builder(
            itemBuilder: (context, index) {
              OrderItemModel item = model.list[index];
              return index == 0 ?
                Column(children: <Widget>[
                  DividerUtil.HDivider(Screen.h(12)),
                  itemWidget(item),
                ],) : itemWidget(item);
            },
            itemCount: model.list.length,
          );
        },
        model: OrderVModel(key: widget._keyWords));
  }

  Widget itemWidget(OrderItemModel item){
    return GestureDetector(
      child: OrderItemWidget(item),
      onTap: () {
        List<operate> operateList = OrderOperate.orderOperateState(item.payStatus, item.status);
        if(operateList.contains(operate.edit)){
          /// 未结算的
          NavigatorUtil.push(context, BillingContentPage(item.carNo, orderId: item.id,));
        } else {
          NavigatorUtil.getValuePush(context, OrderDetailPage(item.id, operateList, item.carNo)).then((value){
            if(null != value){
              _orderVModel?.onDataReady();
            }
          });
        }
      },
    );
  }
}

/// 客户模块
/// 客户列表，type类型
class _AllCustomerListPage extends StatefulWidget {
  String _keyWords;

  _AllCustomerListPage(this._keyWords);

  @override
  _AllCustomerListPageState createState() => new _AllCustomerListPageState();
}

class _AllCustomerListPageState extends State<_AllCustomerListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new LoadingContainer<CustomerVModel>(
        onModelReady: (model) {
          _customerVModel = model;

        },
        refreshType: RefreshType.normal,
        successChild: (model) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return index == 0 ?
              Column(children: <Widget>[
                DividerUtil.HDivider(Screen.h(12)),
                GestureDetector(
                  child: CustomerListWidget(model.list[index]),
                  onTap: () {
                    NavigatorUtil.push(
                        context, new CustomerDetailPage(model.list[index].id));
                  },
                )
              ],) :
              GestureDetector(
                child: CustomerListWidget(model.list[index]),
                onTap: () {
                  NavigatorUtil.push(
                      context, new CustomerDetailPage(model.list[index].id));
                },
              );
            },
            itemCount: model.list.length,
          );
        },
        model: CustomerVModel(key: widget._keyWords));
  }
}
