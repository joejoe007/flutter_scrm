import 'package:flutter/material.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/account_receiver_model.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/model/request/submit_accout_model.dart';
import 'package:flutter_project1/page/main/home/account/account_receive_page.dart';
import 'package:flutter_project1/page/main/main_page.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/base/base_refresh_list_vmodel.dart';
import 'package:flutter_project1/widget/my_toast.dart';

/// 挂帐应收列表
class AccountReceiveVModel
    extends BaseRefreshListVModel<AccountNeedListItemModel> {
  String keyWords = '';

  AccountTotalModel accountTotalModel = new AccountTotalModel();

  setKey(String key) {
    this.keyWords = key;
    initData();
  }

  @override
  void onDataReady() {
    getAccountTotalMoney();
    initData();
  }

  /// 总欠款
  getAccountTotalMoney() {
    RepositoryCommon.getAccountTotalMoney(null).then((value) {
      accountTotalModel = value.data;
      setSuccess();
    });
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = Constant.PAGE_SIZE;
    _params['key'] = keyWords;
    return RepositoryCommon.getAccountList(_params);
  }
}

/// 销账列表
class AccountWriteOffVModel
    extends BaseRefreshListVModel<AccountConsumeItemModel> {
  dynamic customerId;
  dynamic totalMoney;

  AccountWriteOffVModel({this.customerId, this.totalMoney});

  bool checkAll = false;

  void checkAllList(bool check) {
    if (list == null || list.length == 0) return;
    list.forEach((item) {
      item.check = check;
    });
    checkAll = check;
    notifyListeners();
  }

  /// 检查列表状态
  void checkListState(bool check) {
    if (list == null || list.length == 0) return;
    checkAll = list.every((item) {
      return item.check == true;
    });
    notifyListeners();
  }

  /// 销帐金额
  String getChooseMoney() {
    double defaultMoney = 0;
    if (list == null || list.length == 0) return '0.00';
    list.forEach((item) {
      if (item.check) defaultMoney += double.parse(StringUtil.checkEmpty(item.creditMoney?.toString(), '0.00'));
    });
    return defaultMoney.toString();
  }

  /// 选择的列表集合
  List<AccountConsumeItemModel> getChooseList() {
    List<AccountConsumeItemModel> listChoose = [];
    if (list == null || list.length == 0) return listChoose;
    list.forEach((item) {
      if (item.check) listChoose.add(item);
    });
    return listChoose;
  }

  @override
  void onDataReady() {
    getConsumerList();
  }

  getConsumerList() {
    RepositoryCommon.getAccountConsumerList(customerId).then((value) {
      list = value.data;
      setSuccess();
    });
  }
}

/// 提交销账
class AccountSubmitVModel extends BaseRefreshListVModel {
  dynamic customerId;
  dynamic totalMoney = 0;
  List<AccountConsumeItemModel> accountList = [];

  AccountSubmitVModel({this.customerId, this.totalMoney, this.accountList});

  dynamic _discountMoney = 0;

  /// 支付方式
  dynamic payType = '';

  setPayType(dynamic payTypeInt) {
    this.payType = payTypeInt;
    notifyListeners();
  }

  set discountMoney(dynamic value) {
    this._discountMoney = value;
    notifyListeners();
  }

  dynamic get discountMoney => _discountMoney;

  submitAccount(BuildContext context) {
    List<String> stringList = [];
    accountList.forEach((item) {
      stringList.add(item.orderId.toString());
    });
    SubmitAccountModel submitAccountModel = SubmitAccountModel(
        customerId: customerId,
        discountsMoneyTotal: _discountMoney,
        orderIds: stringList,
        payWay: payType,
        paybackMoneyTotal: totalMoney);
    RepositoryCommon.submitAccount(submitAccountModel).then((value) {
      MyToast.showToast('销帐成功');
      NavigatorUtil.pushAndRemoveUtil(context, AccountReceivePage());
    }).catchError((value){
      MyToast.showToast(value.message);
    });
  }

  @override
  void onDataReady() {}
}
