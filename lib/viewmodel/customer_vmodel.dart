import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/car_type_model.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/model/memcardlist_model.dart';
import 'package:flutter_project1/model/order_detail_model.dart';
import 'package:flutter_project1/model/order_list_item_model.dart';
import 'package:flutter_project1/model/request/add_customer_info_model.dart';
import 'package:flutter_project1/page/main/home/customer/choosecar/az_common.dart';
import 'package:flutter_project1/page/main/home/customer/choosecar/city_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/base/base_refresh_list_vmodel.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:quiver/strings.dart';

/// 客户列表
class CustomerVModel extends BaseRefreshListVModel<CustomerInfoModel> {
  String _key; // 关键词

  CustomerNumInfoModel customerNumInfoModel = CustomerNumInfoModel();

  CustomerVModel({String key}) {
    _key = key;
  }

  void setKey(String key) {
    this._key = key;
    initData();
  }

  @override
  void onDataReady() {
    initData();
  }

  /// 获取客户数量信息
  void getCustomerNumInfo() {
    RepositoryCommon.getCustomerNumInfo().then((value) {
      customerNumInfoModel = value.data;
    });
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = Constant.PAGE_SIZE;
    if (isNotEmpty(_key)) {
      _params['key'] = _key;
    }
    return RepositoryCommon.searchCustomerList(_params);
  }
}

/// 客户详情
class CustomDetailVModel extends BaseRefreshListVModel {
  /// 客户id
  dynamic _id;

  /// 设置客户id
  setCustomerId({dynamic id}) {
    this._id = id;
  }

  dynamic get id => _id;

  /// 客户详情数据
  CustomDetailModel _customDetailModel = CustomDetailModel();

  CustomDetailModel get customDetailModel => _customDetailModel;

  /// 客户列表数据
  List<Record> _userCardList = [];

  List<Record> get userCardList => _userCardList;

  /// 客户消费累计信息
  CustomerConsumeTotalModel customerConsumeTotalModel =
      CustomerConsumeTotalModel();

  @override
  void onDataReady() {
    _getCustomeToal();
    _getCustomDetailById();
    _getUserCardList();
  }

  /// 客户消费累计
  void _getCustomeToal() {
    RepositoryCommon.getCustomerConsumeTotal(_id).then((value) {
      customerConsumeTotalModel = value.data;
      setSuccess();
    });
  }

  /// 获取客户信息
  void _getCustomDetailById() {
    RepositoryCommon.getCustomerDetail(_id).then((value) {
      _customDetailModel = value.data;
      setSuccess();
    });
  }

  /// 获取用户的会员卡
  void _getUserCardList() {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = 1;
    _params['pageSize'] = 1000;
    _params['customerId'] = _id;
    RepositoryCommon.getMemcardList(_params).then((value) {
      _userCardList = value.data;
      setSuccess();
    });
  }
}

/// 客户消费记录
class ConsumeRecordVModel extends BaseRefreshListVModel<OrderItemModel> {
  /// 关键词
  String _key = '';

  /// 用户id
  dynamic customerId;

  /// 设置关键词
  void setKey(String key) {
    this._key = key;
    initData();
  }

  /// 设置用户id
  void setCustomerId(dynamic customerId) {
    this.customerId = customerId;
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
    if (isNotEmpty(customerId)) {
      _params['customerId'] = customerId;
    }
    return RepositoryCommon.searchOrderList(_params);
  }
}

/// 新增客户信息vmodel
class CustomerAddPersonVModel extends BaseRefreshListVModel {
  TextEditingController nameController = new TextEditingController();
  TextEditingController tellController = new TextEditingController();
  TextEditingController remarkController = new TextEditingController();
  FocusNode tellNode = FocusNode();

  /// 车辆信息
  TextEditingController carNumController = new TextEditingController();
  TextEditingController vimController = new TextEditingController();
  TextEditingController carColorController = new TextEditingController();
  TextEditingController engineController = new TextEditingController();
  TextEditingController currentMController = new TextEditingController();
  TextEditingController nextMController = new TextEditingController();
  TextEditingController keyCardController = new TextEditingController();

  CustomerAddPersonVModel(
      {dynamic customerId,
      CustomDetailModel customDetailModel,
      CustomDetailCarModel customDetailCarModel}) {
    if (customerId == null && customDetailModel == null) return;

    /// 个人信息
    this._customerId = customerId;
    setChangeUserInfo(customDetailModel);

    if (customDetailCarModel == null) return;

    /// 车辆信息
    setChangeBindCarInfo(customDetailCarModel);
    this.carNumController.text = customDetailCarModel.carNo.toString();
    this._carNum = customDetailCarModel.carNo.toString();
  }

  /// 设置个人信息
  void setChangeUserInfo(CustomDetailModel customDetailModel){
    this.nameController.text = customDetailModel.name.toString();
    this._name = customDetailModel.name.toString();
    this.tellController.text = customDetailModel.mobile.toString();
    this._phone = customDetailModel.mobile.toString();
    this._sex = customDetailModel.sex == SexType.boy ? '男' : customDetailModel.sex == SexType.girl ? '女' : '';
    this._birthday = DateUtil.getDateStrByTimeStr(
        customDetailModel.birthday.toString(),
        format: DateFormat.YEAR_MONTH_DAY);
    this.remarkController.text = customDetailModel.remark.toString();
    this._remark = customDetailModel.remark.toString();
    notifyListeners();
  }

  /// 设置车辆信息
  void setChangeBindCarInfo(CustomDetailCarModel customDetailCarModel) {
    if (customDetailCarModel == null) return;

    /// 车辆信息
    this.vimController.text = customDetailCarModel.vin.toString();
    this._vinNum = customDetailCarModel.vin.toString();
    this._carType = StringUtil.checkEmpty(customDetailCarModel.carBrandName) + StringUtil.checkEmpty(customDetailCarModel.carSeriesName) + StringUtil.checkEmpty(customDetailCarModel.carModelName);
    this.carColorController.text = customDetailCarModel.carColor.toString();
    this._carColor = customDetailCarModel.carColor.toString();
    this._carBrandId = customDetailCarModel.carBrandId;
    this._carSeriesId = customDetailCarModel.carSeriesId;
    this._carModeId = customDetailCarModel.carModelId;
    this.engineController.text = customDetailCarModel.engineNo.toString();
    this._engineNum = customDetailCarModel.engineNo.toString();
    this._safeTime = DateUtil.getDateStrByTimeStr(
        customDetailCarModel.insuranceExpireTime.toString(),
        format: DateFormat.YEAR_MONTH_DAY);
    this._yearCheckTime = DateUtil.getDateStrByTimeStr(
        customDetailCarModel.annualExpireTime.toString(),
        format: DateFormat.YEAR_MONTH_DAY);
    this.currentMController.text = customDetailCarModel.kilometers.toString();
    this._currentDriveM = customDetailCarModel.kilometers.toString();
    this.nextMController.text =
        customDetailCarModel.nextMaintainMileage.toString();
    this._nextMaintainM = customDetailCarModel.nextMaintainMileage.toString();
    this._nextMaintainTime = DateUtil.getDateStrByTimeStr(
        customDetailCarModel.nextMaintainTime.toString(),
        format: DateFormat.YEAR_MONTH_DAY);
    notifyListeners();
  }

  /// 客户id
  dynamic _customerId;

  String _name, _phone, _sex, _birthday, _remark;
  String _carNum,
      _vinNum,
      _carType,
      _carColor,
      _engineNum,
      _safeTime,
      _yearCheckTime;
  String _currentDriveM, _nextMaintainM, _nextMaintainTime;
  dynamic _carBrandId ,_carSeriesId ,_carModeId; // 车辆信息
  dynamic keyCard;// 钥匙牌号

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  get phone => _phone;

  set phone(value) {
    _phone = value;
  }

  get sex => _sex;

  set sex(value) {
    _sex = value;
    notifyListeners();
  }

  get birthday => _birthday;

  set birthday(value) {
    _birthday = value;
    notifyListeners();
  }

  get remark => _remark;

  set remark(value) {
    _remark = value;
  }

  String get carNum => _carNum;

  set carNum(String value) {
    _carNum = value;
  }

  get vinNum => _vinNum;

  set vinNum(value) {
    _vinNum = value;
  }

  get carType => _carType;

  set carType(value) {
    _carType = value;
  }

  get carColor => _carColor;

  set carColor(value) {
    _carColor = value;
  }

  get engineNum => _engineNum;

  set engineNum(value) {
    _engineNum = value;
  }

  get safeTime => _safeTime;

  set safeTime(value) {
    _safeTime = value;
    notifyListeners();
  }

  get yearCheckTime => _yearCheckTime;

  set yearCheckTime(value) {
    _yearCheckTime = value;
    notifyListeners();
  }

  String get currentDriveM => _currentDriveM;

  set currentDriveM(String value) {
    _currentDriveM = value;
  }

  get nextMaintainM => _nextMaintainM;

  set nextMaintainM(value) {
    _nextMaintainM = value;
  }

  get nextMaintainTime => _nextMaintainTime;

  set nextMaintainTime(value) {
    _nextMaintainTime = value;
    notifyListeners();
  }

  String get carBrandId => _carBrandId;

  set carBrandId(String value) {
    _carBrandId = value;
  }

  String get carSeriesId => _carSeriesId;

  set carSeriesId(String value) {
    _carSeriesId = value;
  }

  String get carModelId => _carModeId;

  set carModelId(String value) {
    _carModeId = value;
  }

  @override
  void onDataReady() {}

  /// 检验手机号
  void mobileExist() {
    Map<String, dynamic> _params = Map();
    _params['customerId'] = _customerId;
    _params['mobile'] = _phone;
    RepositoryCommon.mobileExist(_params).then((value) {
      bool result = false;
      if (value.data is bool) {
        result = value.data as bool;
      }
      if (result) {
        MyToast.showToast('手机号已存在');
      }
    });
  }

  /// 新增用户信息
  void submitAddCustomerInfo(BuildContext context, bool completeUserInfo) {
    AddCustomerInfoCarModel car = AddCustomerInfoCarModel(
        annualExpireTime: _yearCheckTime,
        carNo: _carNum,
        carBrandId: _carBrandId,
        carSeriesId: _carSeriesId,
        carModelId: _carModeId,
        carColor: _carColor,
        engineNo: _engineNum,
        insuranceExpireTime: _safeTime,
        kilometers: _currentDriveM,
        nextMaintainMileage: _nextMaintainM,
        nextMaintainTime: _nextMaintainTime,
        vin: _vinNum);
    List<AddCustomerInfoCarModel> list = [car];
    AddCustomerInfoModel info = AddCustomerInfoModel(
        id: _customerId,
        name: _name,
        mobile: _phone,
        birthday: _birthday,
        remark: _remark,
        sex: _sex == '男' ? SexType.boy : _sex == '女' ? SexType.girl : 0,
        cars: list);
    RepositoryCommon.addOrUpdateCustomerInfo(info).then((value) {
      if(completeUserInfo){
        MyToast.showToast('完善客户成功');
        Navigator.of(context).pop(keyCard);
      } else {
        MyToast.showToast('客户新增成功');
        Navigator.of(context).pop('');
      }
    }).catchError((value) {
      MyToast.showToast(value.message);
    });
  }

  /// 更新用户信息
  void submitChangeCustomerInfo(BuildContext context) {
    AddCustomerInfoModel info = AddCustomerInfoModel(
        id: _customerId,
        name: _name,
        mobile: _phone,
        sex: _sex == '男' ? SexType.boy : _sex == '女' ? SexType.girl : 0,
        birthday: _birthday);
    RepositoryCommon.addOrUpdateCustomerInfo(info).then((value) {
      MyToast.showToast('保存成功');
      Navigator.of(context).pop('');
    }).catchError((value) {
      MyToast.showToast(value.message);
    });
  }

  /// 新增车辆信息
  void submitAddCustomerCarInfo(BuildContext context, bool changeCar) {
    AddCustomerInfoCarModel car = AddCustomerInfoCarModel(
        annualExpireTime: _yearCheckTime,
        carNo: _carNum,
        customerId: _customerId,
        customerName: _name,
        carBrandId: _carBrandId,
        carSeriesId: _carSeriesId,
        carModelId: _carModeId,
        carColor: _carColor,
        engineNo: _engineNum,
        insuranceExpireTime: _safeTime,
        kilometers: _currentDriveM,
        nextMaintainMileage: _nextMaintainM,
        nextMaintainTime: _nextMaintainTime,
        vin: _vinNum);
    RepositoryCommon.addOrUpdateCarInfo(car).then((value) {
      if (changeCar) {
        MyToast.showToast('车辆新增成功');
      } else {
        MyToast.showToast('车辆修改成功');
      }
      Navigator.of(context).pop('');
    }).catchError((value) {
      MyToast.showToast(value.message);
    });
  }

  /// 根据车牌获取车辆信息
  void getCarInfoByCarNum(
      void showDialog(CarInfoByCarNumModel customDetailCarModel)) {
    RepositoryCommon.getCarInfoByCarNum(_carNum).then((value) {
      CarInfoByCarNumModel carInfoByCarNumModel = value.data;
      if (carInfoByCarNumModel != null) {
        /// 有车辆信息
        showDialog(carInfoByCarNumModel);
      }
    });
  }

  /// 订单基础信息
  OrderDetailModel orderDetailModel;

  /// 根据用户id，获取用户详情
  void getUserInfoByConsumerId(dynamic consumerId, dynamic carNo, {dynamic orderId}) {
    this._customerId = consumerId;
    this._carNum = carNo;
    if(consumerId == null) return;
    RepositoryCommon.getCustomerDetail(consumerId).then((value) {
      CustomDetailModel customDetailModel = value.data;
      if (customDetailModel != null) {
        /// 用户信息
        setChangeUserInfo(customDetailModel);
        if (customDetailModel.cars != null) {
          customDetailModel.cars.forEach((item) {
            if (item.carNo.toString() == carNo.toString()) {
              setChangeBindCarInfo(item);
              if(orderId == null) return;
                RepositoryCommon.getOrderInfo(orderId).then((value) {
                  if (null == value.data) return;
                  OrderDetailModel orderDetailModel = value.data;
                  this.currentMController.text = StringUtil.checkEmpty(orderDetailModel?.kilometers?.toString());
                  this._currentDriveM = StringUtil.checkEmpty(orderDetailModel?.kilometers?.toString());
                  this.nextMController.text = StringUtil.checkEmpty(orderDetailModel?.nextMaintainMileage?.toString());
                  this._nextMaintainM = StringUtil.checkEmpty(orderDetailModel?.nextMaintainMileage?.toString());
                  this._nextMaintainTime = isNotEmpty(StringUtil.checkEmpty(orderDetailModel?.nextMaintainTime?.toString())) ? DateUtil.getDateStrByTimeStr(orderDetailModel.nextMaintainTime.toString(), format: DateFormat.YEAR_MONTH_DAY) : '';
                  this.keyCard = StringUtil.checkEmpty(orderDetailModel?.keyCard);
                  notifyListeners();
                });
            }
          });
        }
      }
    });
  }

}

/// 选择品牌
class ChooseCarModelVModel extends BaseRefreshListVModel {

  List<BrandName> brandList = [];
  List<String> indexTagList = [];

  @override
  void onDataReady() {
    getCarBrand();
  }

  void getCarBrand() {
    RepositoryCommon.getBrandList().then((value) {
      if (value == null || value.data == null) return;
      CarTypeModel carTypeModel = value.data;
      List<BrandName> aList = carTypeModel.allList;
      List<BrandName> hotList = carTypeModel.HOT;
      brandList.clear();
      brandList.addAll(aList);
      _handleList(brandList);

      //将热门城市置顶
      hotList.forEach((item){
        item.tagIndex = "★";
      });
      brandList.insertAll(0, hotList);
      indexTagList.addAll(SuspensionUtil.getTagIndexList(brandList));

      SuspensionUtil.setShowSuspensionStatus(brandList);

      setSuccess();
    }).catchError((value) {});
  }

  void _handleList(List<BrandName> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(list);
  }
}

/// 选择车型
class ChooseSeriesVModel extends BaseRefreshListVModel {

  List<CarSeriesItemModel> seriesList = [];

  @override
  void onDataReady() {

  }

  void getCarSeries(dynamic id) {
    RepositoryCommon.getCarSeriesList(id).then((value) {
      if (value == null || value.data == null) return;
      seriesList = value.data;
      setSuccess();
    }).catchError((value) {});
  }


}

/// 选择车系
class ChooseModelVModel extends BaseRefreshListVModel {

  List<CarModelItemModel> carModelList = [];

  @override
  void onDataReady() {

  }

  void getCarModel(dynamic id) {
    RepositoryCommon.getCarModelList(id).then((value) {
      if (value == null || value.data == null) return;
      carModelList = value.data;
      setSuccess();
    }).catchError((value) {});
  }


}

