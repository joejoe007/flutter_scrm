import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/model/order_list_item_model.dart';
import 'package:flutter_project1/page/main/home/billing/billing_content_page.dart';
import 'package:flutter_project1/page/main/home/billing/billing_operate_util.dart';
import 'package:flutter_project1/page/main/home/order/order_detail_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/customer_vmodel.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:quiver/strings.dart';

class ConsumeRecordPager extends StatefulWidget {
  dynamic customerId;

  ConsumeRecordPager({this.customerId});

  @override
  _ConsumeRecordPagerState createState() => _ConsumeRecordPagerState();
}

class _ConsumeRecordPagerState extends State<ConsumeRecordPager>
    with SingleTickerProviderStateMixin {
  ConsumeRecordVModel _consumeRecordVModel;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new MyAppBarView(title: '客户消费记录'),
        backgroundColor: AppColors.color_f4f4f4,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                color: AppColors.color_ffffff,
                padding: EdgeInsets.all(Screen.w(12)),
                child: AutoMakeSearchBar(
                  fieldCallBack: (content) {
                    if (_consumeRecordVModel == null) return;
                    _consumeRecordVModel.setKey(content);
                  },
                  hintText: '输入订单号/订单内容',
                ),
              ),
              Expanded(
                child: _allList(type: 0), // 待结算,
              )
            ],
          ),
        ));
  }

  /// 列表，type类型
  Widget _allList({int type}) {
    return new LoadingContainer<ConsumeRecordVModel>(
        refreshType: RefreshType.normal,
        onModelReady: (model) {
          _consumeRecordVModel = model;
          model.setCustomerId(widget.customerId);
        },
        successChild: (model) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return _builderItem(context, index, model.list[index]);
            },
            itemCount: model.list.length,
          );
        },
        model: ConsumeRecordVModel());
  }

Widget _builderItem(BuildContext context, int index, OrderItemModel orderItemModel) {
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.fromLTRB(
          Screen.w(12), Screen.w(6), Screen.w(12), Screen.w(6)),
      child: Column(
        children: <Widget>[
          // 头部
          Container(
            padding: EdgeInsets.all(Screen.w(12)),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  '订单号 ' + StringUtil.checkEmpty(orderItemModel?.orderNo?.toString()),
                  style: CStyle.style(AppColors.color_212121, 16),
                )),
                Text(
                  Order.getPayStatusName(orderItemModel.payStatus),
                  style: CStyle.style(AppColors.color_ff3b25, 16),
                ),
              ],
            ),
          ),
          Divider(
            height: Screen.h(0.5),
          ),
          Container(
            padding: EdgeInsets.all(Screen.w(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  StringUtil.checkEmpty(orderItemModel?.itemNames?.toString()),
                  style: CStyle.style(AppColors.color_666666, 14),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '开单时间 | ' + StringUtil.checkEmpty(orderItemModel?.createTime?.toString()),
                        overflow: TextOverflow.ellipsis,
                        style: CStyle.style(AppColors.color_999999, 12),
                      ),
                    ),
                    Text(
                      "¥" + StringUtil.checkEmpty(orderItemModel?.orderMoney?.toString(), '0'),
                      style: CStyle.style(AppColors.color_212121, 14, true),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: AppColors.color_ffffff,
          borderRadius: BorderRadius.all(Radius.circular(5))),
    ),
    onTap: () {
      List<operate> operateList = OrderOperate.orderOperateState(orderItemModel.payStatus, orderItemModel.status);
      if(operateList.contains(operate.edit)){
        NavigatorUtil.push(context, BillingContentPage(orderItemModel.carNo, orderId: orderItemModel.id,));
      } else {
        NavigatorUtil.getValuePush(context, OrderDetailPage(orderItemModel.id, operateList, orderItemModel.carNo)).then((value){
          if(value != null){
            _consumeRecordVModel?.onDataReady();
          }
        });
      }
    },
  );
}
}

