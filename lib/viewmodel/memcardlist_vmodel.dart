import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/memcardlist_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'base/base_refresh_list_vmodel.dart';
import 'base/base_vmodel.dart';

class MemCardListVModel extends BaseRefreshListVModel {
  final String status;
  String customerId;
  String key;
  bool _isUsekey = false;
  bool isNoData = false;

  MemCardListVModel({this.status, this.customerId});

  @override
  void onDataReady() {
    setEmpty();
//    initData();
    // TODO: implement loadData
  }

  void setCustomerId(String customerId) {
    isNoData = true;
    _isUsekey = false;
    this.customerId = customerId;
    requestListData();
  }

  void setKey(String key) {
    isNoData = true;
    _isUsekey = true;
    this.key = key;
    requestListData();
  }

  void requestListData() {
    Map<String, dynamic> _params = Map();
    _params['status'] = status;
    if (_isUsekey) {
      _params['key'] = key;
    } else {
      _params['customerId'] = customerId;
    }
    RepositoryCommon.getMemcardTypeList(_params).then((value) {
      List _result = value.data;
      Map _map = Map();
      for (MemberCardTypeModel typeModel in _result) {
        if (_map.containsKey(typeModel.cardCustomerId)) {
          List _subList = _map[typeModel.cardCustomerId];
          _subList.add(typeModel);
          _map[typeModel.cardCustomerId] = _subList;
        } else {
          List _fristList = List();
          _fristList.add(typeModel);
          _map[typeModel.cardCustomerId] = _fristList;
        }
      }
      list = _map.values.toList();
      list.length > 0 ? setSuccess() : setEmpty();
    }).catchError((error) {
      setError();
    });
  }

  /// 暂时不用
  @override
  Future<ResultBean> loadListData({int pageNum}) {
    // TODO: implement loadListData
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = 10;
    _params['status'] = status;
    if (_isUsekey) {
      _params['key'] = key;
    } else {
      _params['customerId'] = customerId;
    }
    return RepositoryCommon.getMemcardList(_params);
  }
}

class MemCardCustomerBalanceVModel extends BaseVModel {
  String customerId;

  String showText = '';

  void setCustomerId(String customerId) {
    showText = '';
    this.customerId = customerId;
    getMemCardCustomerData();
  }

  @override
  void onDataReady() {
    // TODO: implement onDataReady
  }

  void getMemCardCustomerData() {
    Map<String, dynamic> _params = Map();
    _params['customerId'] = customerId;
    RepositoryCommon.getMemCardCustomerBalance(_params).then((value) {

      MemCardBalanceModel balanceModel = value.data;
      showText =
          '此客户总余额：${balanceModel.balance.toString()}元   总扣次：${balanceModel.leftTimes.toString()}次';
      notifyListeners();
    }).catchError((error) {});
  }
}
