import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/customercareset_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';

import 'base/base_refresh_list_vmodel.dart';

class CustomerCareSetVModel extends BaseRefreshListVModel {
  bool isOpen = false;

  int argument;

  void setIsOpen(bool isOpen) {
    Map<String, dynamic> _map = Map();
    _map['swichStatus'] = isOpen ? 1 : 0;
    RepositoryCommon.updateAllCustomerCareSet(_map).then((value) {
      initData();
    }).catchError((error) {});
  }

  void setSwitch(bool isOpen, CustomerCareSetModel setModel) {
    Map<String, dynamic> _map = Map();
    _map['alarmSwitch'] = setModel.alarmSwitch == 1 ? 0 : 1;
    _map['id'] = setModel.id;
    RepositoryCommon.updateCustomerCareSet(_map).then((value) {
      initData();
    }).catchError((error) {});
  }

  void changeArgument(CustomerCareSetModel setModel){
    Map<String, dynamic> _map = Map();
    _map['arguments'] = setModel.arguments;
    _map['id'] = setModel.id;
    RepositoryCommon.updateCustomerCareSet(_map).then((value) {
      initData();
    }).catchError((error) {});
  }

  @override
  void onDataReady() {
    initData();
    // TODO: implement loadData
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    return RepositoryCommon.getCustomerCareSetList(Map());
  }
}
