import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/itemlist_model.dart';
import 'package:flutter_project1/model/memcardcategory_model.dart';
import 'package:flutter_project1/model/memcarddetail_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/functions.dart';

import 'base/base_refresh_list_vmodel.dart';
import 'base/base_vmodel.dart';

class MemCardDetailVModel extends BaseRefreshListVModel {
  String refundPrice = '';

  String remark = '';

  dynamic payType = 3;

  /// 默认微信

  final String cardId;

  MemCardDetailVModel({this.cardId});

  MemCardDetailModel _cardDetailModel = MemCardDetailModel();

  MemCardDetailModel get cardDetailModel => _cardDetailModel;

  void clearCurrentInputPrice(){
    refundPrice = '';
    notifyListeners();
  }

  @override
  void onDataReady() {
    Map<String, dynamic> _params = Map();
    _params['id'] = cardId;
    RepositoryCommon.getMemCardDetail(_params).then((value) {
      _cardDetailModel = value.data;
      setSuccess();
      getCounsumeData();
    }).catchError((error) {
      setError();
    });
  }

  void getCounsumeData() {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = 1;
    _params['pageSize'] = 100;
    _params['cardCustomerId'] = _cardDetailModel.id;
    _params['type'] = 3;
    RepositoryCommon.getConsumeRecordList(_params).then((value) {
      list = value.data;
      setSuccess();
    });
  }

  void submmitData(GetBackValue getBackValue) {
    Map<String, dynamic> _params = Map();
    _params['refundPrice'] = refundPrice;
    _params['remark'] = remark;
    _params['payType'] = payType;
    _params['id'] = _cardDetailModel.id;

    RepositoryCommon.refundMemCard(_params).then((result) {

      getBackValue(result);
    });
  }
}

class MemCardContinueVModel extends BaseVModel {
  bool limit = false;
  dynamic validUnit = 1;
  String payType = '';
  dynamic lastPrice = 0;
  String discount = '';
  String cardId = '';
  String remark = '';
  String expireDate = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);
  dynamic totalPrice = 0;

  List itemlist = List();
  List moneyList = List();

  List giveitemlist = List();
  List givemoneyList = List();

  List rechargeList = List();

  void setSelectDate(DateTime date) {
    this.expireDate =
        DateUtil.getDateStrByDateTime(date, format: DateFormat.YEAR_MONTH_DAY);
    notifyListeners();
  }

  void setDiscount(String discount) {
    this.discount = discount;
    if (discount.length > 0) {
      lastPrice = totalPrice - double.parse(discount);
    } else {
      lastPrice = totalPrice;
    }
    notifyListeners();
  }

  void setlimit(bool limit) {
    this.limit = limit;
    notifyListeners();
  }

  void setUnit(String unit) {
    validUnit = unit == '年' ? 1 : (unit == '月' ? 2 : 3);
    notifyListeners();
  }

  void addMoneyList(String content) {
    moneyList.clear();
    MemCardCategorySubModel subModel = MemCardCategorySubModel();
    subModel.amount = content;
    subModel.type = 5;
    subModel.isPresent = 0;
    moneyList.add(subModel);

    totalPrice = 0;
    for (MemCardCategorySubModel subModel in moneyList) {
      if (subModel.amount.length != 0) {
        totalPrice += double.parse(subModel.amount);
      }
    }
    for (MemCardCategorySubModel subModel in itemlist) {
      totalPrice += subModel.unitPrice * int.parse(subModel.amount);
    }

    if (discount.length > 0) {
      lastPrice = totalPrice - double.parse(discount);
    } else {
      lastPrice = totalPrice;
    }

    notifyListeners();
  }

  void addItemlist(ItemListModel itemListModel) {
    MemCardCategorySubModel myModel = MemCardCategorySubModel();
    myModel.amount = '1';
    myModel.isPresent = 0;
    myModel.itemId = itemListModel.id;
    myModel.itemName = itemListModel.name;
    myModel.type = 1;
    myModel.unitPrice = itemListModel.price;
    for (int i = 0; i < itemlist.length; i++) {
      MemCardCategorySubModel subModel = itemlist[i];
      if (subModel.itemId == myModel.itemId) {
        myModel.amount = (int.parse(subModel.amount) + 1).toString();
        itemlist.removeAt(i);
      }
    }
    itemlist.add(myModel);

    totalPrice = 0;
    for (MemCardCategorySubModel subModel in moneyList) {
      totalPrice += double.parse(subModel.amount);
    }

    /// 刷新总价格
    for (MemCardCategorySubModel subModel in itemlist) {
      totalPrice += subModel.unitPrice * int.parse(subModel.amount);
    }

    if (discount.length > 0) {
      lastPrice = totalPrice - double.parse(discount);
    } else {
      lastPrice = totalPrice;
    }

    notifyListeners();
  }

  /// 修改次数
  void changeItemList(String num, int index) {
    MemCardCategorySubModel subModel = itemlist[index];
    subModel.amount = num;
    totalPrice = 0;
    for (MemCardCategorySubModel subModel in moneyList) {
      totalPrice += double.parse(subModel.amount);
    }

    /// 刷新总价格
    for (MemCardCategorySubModel subModel in itemlist) {
      if (subModel.amount.length != 0) {
        totalPrice += subModel.unitPrice * int.parse(subModel.amount);
      }
    }

    if (discount.length > 0) {
      lastPrice = totalPrice - double.parse(discount);
    } else {
      lastPrice = totalPrice;
    }

    notifyListeners();
  }

  void addGiveMoneyList(String content) {
    givemoneyList.clear();
    MemCardCategorySubModel subModel = MemCardCategorySubModel();
    subModel.amount = content;
    subModel.type = 5;
    subModel.isPresent = 1;
    givemoneyList.add(subModel);
    notifyListeners();
  }

  void addGiveItemlist(ItemListModel itemListModel) {
    MemCardCategorySubModel myModel = MemCardCategorySubModel();
    myModel.amount = '1';
    myModel.isPresent = 1;
    myModel.itemId = itemListModel.id;
    myModel.itemName = itemListModel.name;
    myModel.type = 1;
    myModel.unitPrice = itemListModel.price;

    for (int i = 0; i < giveitemlist.length; i++) {
      MemCardCategorySubModel subModel = giveitemlist[i];
      if (subModel.itemId == myModel.itemId) {
        myModel.amount = (int.parse(subModel.amount) + 1).toString();
        giveitemlist.removeAt(i);
      }
    }
    giveitemlist.add(myModel);
    notifyListeners();
  }

  void changeGiveItemList(String num, int index) {
    MemCardCategorySubModel subModel = itemlist[index];
    subModel.amount = num;
  }

  void submmitData(GetBackValue getBackValue) {
    if (itemlist.length > 0) {
      for (MemCardCategorySubModel subModel in itemlist) {
        rechargeList.add(subModel.toJson());
      }
    }
    if (giveitemlist.length > 0) {
      for (MemCardCategorySubModel subModel in giveitemlist) {
        rechargeList.add(subModel.toJson());
      }
    }
    if (moneyList.length > 0) {
      for (MemCardCategorySubModel subModel in moneyList) {
        rechargeList.add(subModel.toJson());
      }
    }
    if (givemoneyList.length > 0) {
      for (MemCardCategorySubModel subModel in givemoneyList) {
        rechargeList.add(subModel.toJson());
      }
    }
    Map<String, dynamic> _map = Map();
    _map['channel'] = (Platform.isIOS) ? '1' : '2';
    _map['discount'] = discount;
    _map['expireDate'] = (limit) ? expireDate : '';
    _map['id'] = cardId;
    _map['payType'] = payType;
    _map['recharge'] = rechargeList;
    _map['remark'] = remark;
    RepositoryCommon.rechargeMemCard(_map).then((value) {
      getBackValue(value);
    }).then((error) {});
  }

  @override
  void onDataReady() {
    // TODO: implement onDataReady
  }
}
