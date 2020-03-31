import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/model/order_detail_model.dart';
import 'package:flutter_project1/model/order_list_item_model.dart';
import 'package:flutter_project1/model/request/submit_accout_model.dart';
import 'package:flutter_project1/model/storeuserlist_model.dart';
import 'package:flutter_project1/page/main/main_page.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/base/base_refresh_list_vmodel.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:quiver/strings.dart';

/// 订单列表界面
class OrderVModel extends BaseRefreshListVModel<OrderItemModel> {
  /// 关键词
  String _key = '';

  OrderVModel({String key}) {
    this._key = key;
  }

  /// time
  String _startTime = '';

  String _endTime = '';

  String get startTime => _startTime;

  String get endTime => _endTime;

  /// 结算状态
  dynamic _payStatus = '';

  /// 订单类型
  dynamic _orderType = '';

  void setKey(String key) {
    this._key = key;
    initData();
  }

  void setAllTime({String startTime, String endTime}) {
    this._startTime = startTime;
    this._endTime = endTime;
    initData();
  }

  void setStartTime(String startTime){
    this._startTime = startTime;
    initData();
  }

  void setEndTime(String endTime){
    this._endTime = endTime;
    initData();
  }

  void setOrderType(dynamic orderType) {
    this._orderType = orderType;
    initData();
  }

  void setPayStatus(dynamic payStatus) {
    this._payStatus = payStatus;
    initData();
  }

  @override
  void onDataReady() {
    initData();
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = Constant.PAGE_SIZE;
    if (isNotEmpty(_key)) {
      _params['key'] = _key;
    }
    if (isNotEmpty(_startTime)) {
      _params['startTime'] = _startTime;
    }
    if (isNotEmpty(_endTime)) {
      _params['endTime'] = _endTime;
    }
    if (isNotEmpty(_orderType.toString())) {
      _params['orderType'] = _orderType;
    }
    if (isNotEmpty(_payStatus.toString())) {
      _params['payStatus'] = _payStatus;
    }
    return RepositoryCommon.searchOrderList(_params);
  }
}

/// 订单详情
class OrderDetailVModel extends BaseRefreshListVModel {

  /// 支付方式
  int payWay;

  setPayWay(int payWay){
    this.payWay = payWay;
  }

  /// 根据车牌号获取个人信息
  CustomerInfoModel customerInfoModel;

  /// 订单基础信息
  OrderDetailModel orderDetailModel;

  /// 订单结算信息
  OrderSettlementDetailModel orderSettlementDetailModel;

  /// 订单内容信息
  List<OrderItemInfoModel> orderItemInfoList = [];

  /// 销售人员
  StoreUserListModel storeUserListModel = StoreUserListModel();

  /// 设置销售人员信息
  setSaleUserInfo(StoreUserListModel storeUserListModel) {
    this.storeUserListModel = storeUserListModel;
    notifyListeners();
  }

  /// 根据车牌拿用户信息
  getUserInfoByCarNo(dynamic carNum) {
    Map<String, dynamic> _params = Map();
    _params['carNo'] = carNum;
    return RepositoryCommon.searchCustomerList(_params).then((value) {
      if (null == value.data) return;
      List<CustomerInfoModel> customerInfoModelList = value.data;
      if (customerInfoModelList.length != 0) {
        customerInfoModel = customerInfoModelList[0];
      }
      notifyListeners();
    });
  }

  /// 获取订单基础数据
  getOrderCommonInfo(dynamic orderId) {
    RepositoryCommon.getOrderInfo(orderId).then((value) {
      if (null == value.data) return;
      orderDetailModel = value.data;
      notifyListeners();
    });
  }

  /// 获取单项信息
  getOrderItemInfo(dynamic orderId) {
    if (orderId == null) return;
    RepositoryCommon.getOrderItemInfo(orderId).then((value) {
      if (null == value.data) return;
      orderItemInfoList = value.data;
      notifyListeners();
    });
  }

  /// 获取结算信息
  getSettlementInfo(dynamic orderId) {
    if (orderId == null) return;
    RepositoryCommon.getOrderSettlementDetail(orderId).then((value) {
      if (null == value.data) return;
      orderSettlementDetailModel = value.data;
      notifyListeners();
    });
  }

  // 计算订单内容合计
  double orderItemSum() {
    double sum = 0;
    if (orderItemInfoList == null) return sum;
    orderItemInfoList.forEach((item) {
      sum += ((double.parse(StringUtil.checkEmpty(item?.discount, '10.00')) / 10) * double.parse(StringUtil.checkEmpty(item?.price, '0.00'))) * int.parse(StringUtil.checkEmpty(item.amount, '0'));
    });
    return double.parse(StringUtil.formatNum(sum, 2));
  }

  /// 撤单
  cancelOrder(BuildContext context , dynamic _orderId) {
    RepositoryCommon.cancelOrder(_orderId).then((value) {
      MyToast.showToast('撤单成功');
      NavigatorUtil.pushAndRemoveUtil(context, MainPage(initPage: 1,));
    }).catchError((value){
      MyToast.showToast(value.message);
    });
  }

  /// 销帐
  submitAccount(BuildContext context, dynamic orderId) {
    List<String> stringList = [orderId];
    SubmitAccountModel submitAccountModel = SubmitAccountModel(
        discountsMoneyTotal: 0,
        orderIds: stringList,
        payWay: payWay,);
    RepositoryCommon.submitAccount(submitAccountModel).then((value) {
      MyToast.showToast('销帐成功');
      Navigator.of(context).pop('');
    }).catchError((value){
      MyToast.showToast(value.message);
    });
  }

  @override
  void onDataReady() {}
}


/// 退单详情
class RefundOrderVModel extends BaseRefreshListVModel {

  @override
  void onDataReady() {}

  List<RefundOrderItemModel> refundItemList = [];

  getRefundOrderList(dynamic refundId){
    if(refundId == null) return;
    RepositoryCommon.refundOrderDetail(refundId).then((value){
      if(value == null || value.data == null) return;
      refundItemList = value.data;
      setSuccess();
    });
  }

}