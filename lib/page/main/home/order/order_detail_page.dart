import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/model/order_detail_model.dart';
import 'package:flutter_project1/page/main/home/billing/back_billing_page.dart';
import 'package:flutter_project1/page/main/home/billing/billing_operate_util.dart';
import 'package:flutter_project1/page/main/home/customer/customer_add_person_page.dart';
import 'package:flutter_project1/page/main/home/handlecard/widget/payway_widget.dart';
import 'package:flutter_project1/page/main/home/order/refund_order_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/order_vmodel.dart';
import 'package:flutter_project1/widget/automake_layout_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/common_widget_util.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:quiver/strings.dart';

class OrderDetailPage extends StatefulWidget {
  List<operate> operateList; /// 操作权限
  dynamic orderId;/// 订单id
  dynamic carNo;/// 车牌

  OrderDetailPage(this.orderId, this.operateList, this.carNo);

  @override
  OrderDetailState createState() => new OrderDetailState();
}

class OrderDetailState extends State<OrderDetailPage> {
  OrderDetailVModel _orderDetailVModel;
  bool sheetVisibility = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: getAppBarInfo(context, _orderDetailVModel, widget.operateList, (){
        CommonWidgetUtil.showCustomDialogWidget(context, centerChild: Text('确认撤单？', style: CStyle.style(AppColors.color_999999, 16),), sure: () {
          _orderDetailVModel.cancelOrder(context, widget.orderId);
        });
      } , (){
        if(null != _orderDetailVModel?.orderSettlementDetailModel)
          NavigatorUtil.push(context, BackBillingPage(_orderDetailVModel.orderSettlementDetailModel));
      }),
      body: SafeArea(
          child: LoadingContainer<OrderDetailVModel>(
              onModelReady: (model) {
                _orderDetailVModel = model;
                model.getUserInfoByCarNo(widget.carNo);
                model.getOrderCommonInfo(widget.orderId);
                model.getSettlementInfo(widget.orderId);
                model.getOrderItemInfo(widget.orderId);
                model.setSuccess();
              },
              successChild: (model) {
                return Container(
                    color: AppColors.color_f4f4f4,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Stack(
                              children: <Widget>[

                                /// 中间部分
                                Container(height: double.maxFinite,
                                  child: Container(child: ListView(
                                    children: <Widget>[

                                      /// 头部状态
                                      payStatusText(model),

                                      /// 顶部个人信息
                                      _topCustomer(context, model),

                                      /// 订单内容信息
                                      _orderDetail(context, model),

                                      /// 结算信息
                                      /// 撤单隐藏
                                      Visibility(child: _settlementWidget(context, model), visible: !(widget.operateList.contains(operate.showCancel))),

                                      /// 订单信息
                                      _orderInfoWidget(context, model),
                                    ],
                                  ), height: double.maxFinite,),),
                                Visibility(
                                  child: Positioned(
                                    child: _showHasChoose(context, model),
                                  ),
                                  visible: sheetVisibility,
                                )

                              ],), height: double.maxFinite,),),

                        /// 底部信息
                        Divider(
                          height: Screen.h(0.5),
                        ),
                        Container(
                            color: AppColors.color_ffffff,
                            height: Screen.h(50),
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(
                                Screen.w(12), 0, Screen.w(12), 0),
                            child:
                            (widget.operateList != null &&
                                widget.operateList.contains(operate.pay)) ?
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Row(children: <Widget>[
                                  GestureDetector(child: Row(children: <Widget>[
                                    Text('应收：¥' + StringUtil.checkEmpty(
                                        model.orderSettlementDetailModel
                                            ?.shouldPay?.toString(), '0'),
                                      style: CStyle.style(
                                          AppColors.color_212121, 14),),
                                    Visibility(child: Icon(
                                      Icons.keyboard_arrow_up,
                                      color: AppColors.color_999999,),
                                      visible: widget.operateList != null &&
                                          widget.operateList.contains(
                                              operate.pay),)
                                  ],), onTap: () {
                                    if (widget.operateList != null &&
                                        widget.operateList.contains(
                                            operate.pay))
                                      setState(() {
                                        sheetVisibility = !sheetVisibility;
                                      });
                                  },),
                                  Expanded(child: SizedBox()),
                                  AutoMakeLayoutWidget(
                                    width: Screen.w(75),
                                    height: Screen.h(30),
                                    gestureTapCallback: () {
                                      showModalBottomSheet(
                                          backgroundColor: AppColors
                                              .color_transparent,
                                          context: context,
                                          builder: (BuildContext dialogContex) {
                                            return PayWayWidget(
                                              getBackValue: ((payType) async {
                                                print('支付方式' +
                                                    payType.toString());
                                                await model.setPayWay(payType);
                                                model.submitAccount(
                                                    context, widget.orderId);
                                              }),
                                            );
                                          });
                                    },
                                    bgCircle: 17,
                                    gradient: LinearGradient(colors: [
                                      AppColors.color_fb5f65,
                                      AppColors.color_f73b42
                                    ]),
                                    child: Text('收款', style: CStyle.style(
                                        AppColors.color_ffffff, 14),
                                    ),
                                  ),
                                ],)
                            ) : Align(
                              alignment: Alignment.centerLeft,
                              child: Text('实收：¥' + StringUtil.checkEmpty(
                                  model.orderSettlementDetailModel?.shouldPay
                                      ?.toString(), '0') + '(' + Order
                                  .getPayWayName(
                                  model.orderSettlementDetailModel?.actualPayWay
                                      ?.toString()) + ')', style: CStyle.style(
                                  AppColors.color_212121, 14),),
                            ))
                      ],
                    ));
              },
              model: OrderDetailVModel())),
    );
  }

  /// 头部状态
  Widget payStatusText(OrderDetailVModel model) {
    return Container(width: Screen.w(),
      height: Screen.h(35),
      color: AppColors.color_ff3c48,
      alignment: Alignment.center,
      child: Text(
        Order.getPayStatusName(model?.orderDetailModel?.payStatus) + '(' +
            Order.getOrderStatusName(model?.orderDetailModel?.status) + ')',
        style: CStyle.style(AppColors.color_ffffff, 14),),
    );
  }

  /// 顶部个人信息
  Widget _topCustomer(BuildContext context, OrderDetailVModel model) {
    return Container(
      decoration: BoxDecoration(color: AppColors.color_ffffff,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      margin: EdgeInsets.fromLTRB(Screen.w(0), Screen.w(12), 0, Screen.w(12)),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Padding(padding: EdgeInsets.all(Screen.w(12)),
              child: Row(
                children: <Widget>[
                  Container(height: Screen.w(45),
                      width: Screen.w(45),
                      child: CircleAvatar(
                          child: Text(StringUtil.checkEmpty(model
                              .customerInfoModel?.name.toString(), '未')
                              .substring(0, 1),
                            style: TextStyle(fontSize: Screen.sp(20),
                                color: AppColors.color_ffffff,
                                fontWeight: FontWeight.bold),),
                          backgroundColor: AppColors.color_fbbe50)),
                  DividerUtil.VDivider(Screen.w(16)),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              StringUtil.checkEmpty(widget.carNo?.toString()),
                              style: TextStyle(fontSize: Screen.sp(16),
                                  color: AppColors.color_212121,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            DividerUtil.VDivider(Screen.w(8.5)),
                            Visibility(
                              child: AutoMakeLayoutWidget(width: Screen.w(30),
                                height: Screen.h(18),
                                bgCircle: 5,
                                gradient: LinearGradient(colors: [
                                  AppColors.color_f2c97f,
                                  AppColors.color_cb993e
                                ]),
                                child: Text('会员', style: TextStyle(
                                    color: AppColors.color_ffffff,
                                    fontSize: Screen.sp(12)),
                                ),
                              ),
                              visible: Member.boolMember(
                                  model.customerInfoModel?.customerType),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        Align(
                          child: Text(StringUtil.checkEmpty(
                              model.customerInfoModel?.name?.toString()) + ' ' +
                              StringUtil.checkEmpty(
                                  model.customerInfoModel?.mobile?.toString()),
                            style: TextStyle(fontSize: Screen.sp(14),
                                color: AppColors.color_666666),
                          ),
                          alignment: Alignment.centerLeft,
                        )
                      ],
                    ),
                    flex: 1,
                  ),
                  Center(child: Icon(
                    Icons.chevron_right, color: AppColors.color_999999,),),
                ],
              ),
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              NavigatorUtil.push(context, CustomerAddPersonPage(carNum: widget.carNo, consumerId: model.customerInfoModel?.id, orderId: widget.orderId,));
            },
          ),
        ],
      ),
    );
  }


  /// 显示应收明细的
  Widget _showHasChoose(BuildContext context, OrderDetailVModel model) {
    return Container(
      color: Color(0xb3212121),
      child: Column(
        children: <Widget>[
          Container(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  sheetVisibility = !sheetVisibility;
                });
              },
            ),
            height: Screen.h(300),
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.color_ffffff,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            height: Screen.h(50),
            child: Stack(
              children: <Widget>[
                Center(
                    child: Text(
                      '应收明细',
                      style: TextStyle(
                          fontSize: Screen.sp(17), fontWeight: FontWeight.bold),
                    )),
                Positioned(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        sheetVisibility = !sheetVisibility;
                      });
                    },
                    child: Icon(Icons.close),
                  ),
                  right: Screen.w(12),
                  top: Screen.h(15),
                ),
              ],
            ),
          ),
          Divider(
            height: Screen.h(0.5),
            color: AppColors.color_999999,
          ),
          Expanded(
            child: Container(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return allListDetail()[index];
                },
                itemCount: allListDetail().length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: Screen.h(0.5),
                  );
                },
              ),
              color: AppColors.color_ffffff,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> allListDetail() {
    List<Widget> list = [];
    if (_orderDetailVModel.orderItemSum() != 0) {
      list.add(_itemTextWidget('订单合计', '¥' + StringUtil.checkEmpty(_orderDetailVModel?.orderItemSum()?.toString(), '0')));
    }
    if (isNotEmpty(StringUtil.checkEmpty(_orderDetailVModel?.orderSettlementDetailModel?.cardItemMoney?.toString()))) {
      list.add(_itemTextWidget('扣次', '¥' + StringUtil.checkEmpty(_orderDetailVModel?.orderSettlementDetailModel?.cardItemMoney?.toString(), '0')));
    }
    if (isNotEmpty(StringUtil.checkEmpty(_orderDetailVModel?.orderSettlementDetailModel?.balanceMoney?.toString()))) {
      list.add(_itemTextWidget('余额抵扣', '¥' + StringUtil.checkEmpty(_orderDetailVModel?.orderSettlementDetailModel?.balanceMoney?.toString(), '0')));
    }
    if (isNotEmpty(StringUtil.checkEmpty(_orderDetailVModel?.orderSettlementDetailModel?.discountsMoney?.toString()))) {
      list.add(_itemTextWidget('优惠', '¥' + StringUtil.checkEmpty(_orderDetailVModel?.orderSettlementDetailModel?.discountsMoney?.toString(), '0')));
    }
    if (isNotEmpty(StringUtil.checkEmpty(_orderDetailVModel?.orderSettlementDetailModel?.prepayMoney?.toString()))) {
      list.add(_itemTextWidget('预收', '¥' + StringUtil.checkEmpty(_orderDetailVModel?.orderSettlementDetailModel?.prepayMoney?.toString(), '0')));
    }
    return list;
  }

  /// 有项目订单项目结算信息，不可以修改的
  Widget _orderDetail(BuildContext context, OrderDetailVModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: Screen.w(12)),
      child: Column(
        children: <Widget>[
          Container(color: AppColors.color_ffffff,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(Screen.w(12)),
                  child: Text(
                    '订单内容', style: CStyle.style(AppColors.color_434343, 17),),
                ),
                Divider(
                  height: Screen.h(0.5),
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.orderItemInfoList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    OrderItemInfoModel orderItemInfoModel = model
                        .orderItemInfoList[index];
                    return _projectListCanChangeWidget(orderItemInfoModel,);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(height: Screen.h(0.5),);
                  },
                ),
                Divider(
                  height: Screen.h(0.5),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '共' + model.orderItemInfoList.length.toString() + '项：合计¥' +
                        model.orderItemSum().toString(),
                    textAlign: TextAlign.right,
                    style: CStyle.style(AppColors.color_212121, 14),
                  ),
                  padding: EdgeInsets.all(Screen.w(12)),
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }

  /// item，不可以修改数据的
  Widget _projectListCanChangeWidget(OrderItemInfoModel orderItemInfoModel) {
    return Container(
      color: AppColors.color_ffffff,
      padding: EdgeInsets.fromLTRB(
          Screen.w(12), Screen.h(10), Screen.w(12), Screen.h(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            StringUtil.checkEmpty(orderItemInfoModel?.itemName?.toString()),
            style: CStyle.style(AppColors.color_666666, 14),
          ),
          DividerUtil.HDivider(Screen.h(5)),
          Row(
            children: <Widget>[
              Text('¥' + StringUtil.checkEmpty(
                  orderItemInfoModel?.price?.toString(), '0'),
                style: CStyle.style(AppColors.color_ff3c48, 14),),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(right: Screen.w(12)),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          double.parse(StringUtil.checkEmpty(
                              orderItemInfoModel?.discount, '10.00')) == 10.0
                              ? '无折扣'
                              : orderItemInfoModel?.discount.toString() + '折',
                          style: CStyle.style(AppColors.color_666666, 14),
                        ),
                        Text('X' + orderItemInfoModel.amount.toString(),
                          style: CStyle.style(AppColors.color_666666, 14),),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 显示信息的框子
  Widget _itemTextWidget(String title, String text,
      {EdgeInsetsGeometry margin}) {
    return Container(
      margin: margin,
      padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
      height: Screen.h(45),
      color: AppColors.color_ffffff,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: AppColors.color_212121, fontSize: Screen.sp(15)),
            ),
          ),
          Text(
            text,
            style:
            TextStyle(color: AppColors.color_999999, fontSize: Screen.sp(14)),
          ),
        ],
      ),
    );
  }

  /// 结算信息
  Widget _settlementWidget(BuildContext context, OrderDetailVModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: Screen.w(12)),
      color: AppColors.color_ffffff,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(Screen.w(12)),
            child: Text(
              '结算信息', style: CStyle.style(AppColors.color_434343, 17),),
          ),
          Divider(
            height: Screen.h(0.5),
          ),
          _itemTextWidget('会员卡扣次', '-¥' + StringUtil.checkEmpty(
              model.orderSettlementDetailModel?.cardItemMoney, '0')),
          _itemTextWidget('余额抵扣', '-¥' + StringUtil.checkEmpty(
              model.orderSettlementDetailModel?.balanceMoney, '0')),
          _itemTextWidget('优惠', StringUtil.checkEmpty(
              model.orderSettlementDetailModel?.discountsMoney, '0')),
          Visibility(
            child:
            _itemTextWidget('预收', StringUtil.checkEmpty(
                model.orderSettlementDetailModel?.prepayMoney, '0')),
            visible: double.parse(StringUtil.checkEmpty(
                model.orderSettlementDetailModel?.prepayMoney, '0.0')) != 0,)
        ],
      ),
    );
  }

  /// 订单信息
  Widget _orderInfoWidget(BuildContext context, OrderDetailVModel model) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: AppColors.color_ffffff,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(Screen.w(12)),
                  child: Text(
                    '订单信息', style: CStyle.style(AppColors.color_434343, 17),),
                ),
                Divider(
                  height: Screen.h(0.5),
                ),
                _itemTextWidget('订单号',
                    StringUtil.checkEmpty(model.orderDetailModel?.orderNo)),
                _itemTextWidget('开单时间',
                    StringUtil.checkEmpty(model.orderDetailModel?.createTime)),
                _itemTextWidget('结算时间',
                    StringUtil.checkEmpty(model.orderDetailModel?.settleTime)),
                _itemTextWidget('技师', StringUtil.checkEmpty(
                    model.orderDetailModel?.createManName)),
                /// 退单号
                Visibility(
                  child: Container(
                  padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
                  height: Screen.h(45),
                  color: AppColors.color_ffffff,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '退单号',
                          style: TextStyle(
                              color: AppColors.color_212121, fontSize: Screen.sp(15)),
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                            text: StringUtil.checkEmpty(model.orderDetailModel?.refundOrderNo),
                              style: TextStyle(color: AppColors.color_f73b42, fontSize: Screen.sp(14)),
                          recognizer: TapGestureRecognizer()..onTap = ()  {
                            /// 退单详情
                            NavigatorUtil.push(context, RefundOrderPage(model.orderDetailModel?.refundId));
                          })),
                    ],
                  ),
                ),
                  visible: widget.operateList != null && widget.operateList.contains(operate.showBack),),
                _itemTextWidget('备注', StringUtil.checkEmpty(model.orderSettlementDetailModel?.remark),),
                DividerUtil.HDivider(Screen.h(12)),
              ],
            ),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: Screen.w(12)),
    );
  }

  /// appBarInfo
  Widget getAppBarInfo(BuildContext context, OrderDetailVModel model, List<operate> operateList, Function cancel, Function back) {
    if (operateList == null || operateList.length == 0 || getShowOperateList(model, cancel , back).length == 0) {
      return MyAppBarView(
        title: '订单详情',
      );
    } else {
      return MyAppBarView(
        title: '订单详情',
        rightIcon: Icons.more_horiz,
        rightCallback: () {
           showMenu(
              context: context,
              position: RelativeRect.fromLTRB(Screen.w(), Screen.h(80), 0, 0),
              items: getShowOperateList(model, cancel, back));
        },
      );
    }
  }

  /// 权限操作
  List<PopupMenuItem<String>> getShowOperateList(OrderDetailVModel model, Function cancel, Function back){
    List<PopupMenuItem<String>> list = [];
    if(widget.operateList != null && widget.operateList.contains(operate.cancel)){
      list.add(PopupMenuItem<String>(
          height: Screen.h(40),
          value: '撤单',
          child: GestureDetector(behavior: HitTestBehavior.opaque,
            child: new Text('撤单', style: CStyle.style(AppColors.color_212121, 14),),
            onTap: cancel,
          )));
    }
    if(widget.operateList != null && widget.operateList.contains(operate.back)){
      list.add(PopupMenuItem<String>(
          height: Screen.h(40),
          value: '退单',
          child: GestureDetector(behavior: HitTestBehavior.opaque,
            child: new Text('退单', style: CStyle.style(AppColors.color_212121, 14),),
            onTap: back,
          )));
    }
    return list;
  }
}
