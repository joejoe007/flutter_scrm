import 'dart:convert';
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/model/itemlist_model.dart';
import 'package:flutter_project1/model/memcardcategory_model.dart';
import 'package:flutter_project1/model/storeuserlist_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/functions.dart';
import 'package:flutter_project1/widget/my_toast.dart';

import 'base/base_refresh_list_vmodel.dart';
import 'base/base_vmodel.dart';

class MemCardCategoryDetailVModel extends BaseVModel {
  String cardTypeId;
  List cardList = List();
  CustomerInfoModel infoModel = CustomerInfoModel();
  String beginDate = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);
  String discount;
  String payType;
  String _salerId;
  String saleName = '';

  String lastPrice = '0';

  StoreUserListModel selectStoreuserModel;

  /// 获取用户信息
  getUserInfo(dynamic userId){
    RepositoryCommon.getCustomerDetail(userId).then((value){
      if(value == null || value.data == null) return;
      CustomDetailModel customDetailModel = value.data;
      List<CustomListCarModel> cars = [];
      customDetailModel.cars.forEach((value){
        CustomListCarModel car = CustomListCarModel(carNo: value.carNo);
        cars.add(car);
      });
      CustomerInfoModel customerInfoModel = CustomerInfoModel(id: userId, name: customDetailModel.name, mobile: customDetailModel.mobile, cars: cars);
      setInfoModel(customerInfoModel);
    });
  }

  void setSelectDate(DateTime date) {
    this.beginDate = DateUtil.getDateStrByDateTime(date, format: DateFormat.YEAR_MONTH_DAY);
    notifyListeners();
  }

  void setLasePirce(String discount){
    this.discount = discount;
    if(discount.length > 0){
      lastPrice = (double.parse(categoryAddModel.price)  - double.parse(discount)).toStringAsFixed(2);/// // 保留指定的小数位数(四舍五入), 不足补0, 字符串返回
      if(double.parse(lastPrice)<0){
        lastPrice = categoryAddModel.price;
        this.discount = '';
        MyToast.showToast('优惠不可大于应收金额');
      }
    }else {
      lastPrice = categoryAddModel.price;
    }
    notifyListeners();
  }

  void setSelectSaleMem(StoreUserListModel storeUserListModel){
    this._salerId = storeUserListModel.id;
    this.saleName = storeUserListModel.name;
    this.selectStoreuserModel = storeUserListModel;
    notifyListeners();
  }

  void setInfoModel(CustomerInfoModel infoModel) {
    String carNo = '';
    if(infoModel.cars.length>0) {
      for(CustomListCarModel subModel in infoModel.cars) {
        carNo = carNo.length >0?carNo+'、'+subModel.carNo:carNo+subModel.carNo;
      }
    }
    infoModel.carNos = carNo;
    this.infoModel = infoModel;
    notifyListeners();
  }

  MemCardCategoryAddModel categoryAddModel = MemCardCategoryAddModel();

  @override
  void onDataReady() {
    Map<String, dynamic> _map = Map();
    _map['cardTypeId'] = cardTypeId;
    RepositoryCommon.getMemCardTypeDetail(_map).then((value) {
      categoryAddModel = value.data;
      lastPrice = categoryAddModel.price;
      for (MemCardCategorySubModel subModel in categoryAddModel.contents) {
        cardList.add(subModel);
      }
      for (MemCardCategorySubModel subModel in categoryAddModel.gifts) {
        cardList.add(subModel);
      }
      notifyListeners();
    }).catchError((error) {});
  }

  /// 办卡
  void createMemCard(GetBackValue getBackValue){
    Map<String, dynamic> _map = Map();
    _map['beginDate'] = beginDate;
    _map['cardTypeId'] = categoryAddModel.id;
    _map['channel'] = (Platform.isIOS) ? '1' : '2';
    _map['customerId'] = infoModel.id;
    _map['customerName'] = infoModel.name;
    _map['discount'] = discount;
    _map['mobile'] = infoModel.mobile;
    _map['payType'] = payType;
    _map['salerId'] = _salerId;
    RepositoryCommon.createMemCard(_map).then((vaule){
      getBackValue(vaule);
    }).catchError((error){

    });
  }
}

class MemCardCategoryAddVModel extends BaseVModel {
  bool limit;

  String cardTypeId;

  String status;


  MemCardCategoryAddModel addModel = MemCardCategoryAddModel();


  List itemlist = List();
  List moneyList = List();

  List giveitemlist = List();
  List givemoneyList = List();

  MemCardCategoryAddModel memCardCategoryAddModel = MemCardCategoryAddModel();

  MemCardCategoryAddVModel({this.limit = false});

  void setValildValue(String value) {
    addModel.validValue = int.parse(value);
    notifyListeners();
  }

  void setlimit(bool limit) {
    this.limit = limit;
    notifyListeners();
  }

  void setUnit(String unit) {
    addModel.validUnit = unit == '年' ? 1 : (unit == '月' ? 2 : 3);
    notifyListeners();
  }

  void addMoneyList(String content) {
    moneyList.clear();
    MemCardCategorySubModel subModel = MemCardCategorySubModel();
    subModel.amount = content;
    subModel.type = 5;
    subModel.isPresent = 0;
    moneyList.add(subModel);
    notifyListeners();
  }

  void clearMoneyList(){
    moneyList.clear();
    notifyListeners();
  }

  void addItemlist(ItemListModel itemListModel) {
    MemCardCategorySubModel myModel = MemCardCategorySubModel();
    myModel.amount = 1;
    myModel.isPresent = 0;
    myModel.itemId = itemListModel.id;
    myModel.itemName = itemListModel.name;
    myModel.type = 1;
    myModel.unitPrice = itemListModel.price;
    for (int i = 0; i < itemlist.length; i++) {
      MemCardCategorySubModel subModel = itemlist[i];
      if (subModel.itemId == myModel.itemId) {
        myModel.amount = subModel.amount + 1;
        itemlist.removeAt(i);
      }
    }
    itemlist.add(myModel);
    notifyListeners();
  }

  void changeItemList(String num, int index) {
    MemCardCategorySubModel subModel = itemlist[index];
    subModel.amount = num;
  }

  void removeItemList(int index) {
    itemlist.removeAt(index);
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

  void clearGiveMoneyList(){
    givemoneyList.clear();
    notifyListeners();
  }

  void addGiveItemlist(ItemListModel itemListModel) {
    MemCardCategorySubModel myModel = MemCardCategorySubModel();
    myModel.amount = 1;
    myModel.isPresent = 1;
    myModel.itemId = itemListModel.id;
    myModel.itemName = itemListModel.name;
    myModel.type = 1;
    myModel.unitPrice = itemListModel.price;

    for (int i = 0; i < giveitemlist.length; i++) {
      MemCardCategorySubModel subModel = giveitemlist[i];
      if (subModel.itemId == myModel.itemId) {
        myModel.amount = subModel.amount + 1;
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

  void removeGiveItemList(int index) {
    giveitemlist.removeAt(index);
    notifyListeners();
  }


  void saveCardCategory(GetBackValue getBackValue) {
    Map<String, dynamic> _map = Map();
    _map['name'] = addModel.name;
    _map['price'] = addModel.price;
    _map['remark'] = addModel.remark;
    _map['validUnit'] = addModel.validUnit;
    _map['validValue'] = (!limit) ? '-1' : addModel.validValue.toString();
    _map['id'] = addModel.id;
    List _contentsList = List();

    for (MemCardCategorySubModel subModel in moneyList) {
      _contentsList.add(subModel.toJson());
    }

    for (MemCardCategorySubModel itemListModel in itemlist) {
      _contentsList.add(itemListModel.toJson());
    }

    _map['contents'] = _contentsList;

    List _giftItems = List();

    for (MemCardCategorySubModel subModel in givemoneyList) {
      _giftItems.add(subModel.toJson());
    }

    for (MemCardCategorySubModel itemListModel in giveitemlist) {
      _giftItems.add(itemListModel.toJson());
    }
    _map['gifts'] = _giftItems;

    RepositoryCommon.addMemType(_map).then((value) {
      getBackValue(value);
    }).catchError((error) {});
  }

  void getMemCategoryDetail() {
    Map<String, dynamic> _map = Map();
    _map['cardTypeId'] = cardTypeId;
    RepositoryCommon.getMemCardTypeDetail(_map).then((value) {
      addModel = value.data;

      /// 有效期
      if (addModel.validValue == -1) {
        setlimit(false);
      }else {
        setlimit(true);
      }

      for (MemCardCategorySubModel subModel in addModel.contents) {
        if (subModel.type == 5) {
          moneyList.add(subModel);
        } else {
          subModel.amount = subModel.amount.toInt();
          itemlist.add(subModel);
        }
      }
      for (MemCardCategorySubModel subModel in addModel.gifts) {
        if (subModel.type == 5) {
          givemoneyList.add(subModel);
        } else {
          subModel.amount = subModel.amount.toInt();
          giveitemlist.add(subModel);
        }
      }
      notifyListeners();
    }).catchError((error) {});
  }

  void changeCardTypeStatus(GetBackValue getBackValue) {
    Map<String, dynamic> _map = Map();
    _map['ids'] = [addModel.id];
    _map['status'] = status;
    RepositoryCommon.changeMemCardTypeStatus(_map).then((value) {
      getBackValue(value);
    }).catchError((error) {});
  }

  @override
  void onDataReady() {
    // TODO: implement onDataReady
  }
}
