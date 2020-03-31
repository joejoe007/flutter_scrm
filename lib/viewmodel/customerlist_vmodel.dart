import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'base/base_refresh_list_vmodel.dart';

class CustomerListVModel extends BaseRefreshListVModel {

  String key;

  CustomerListVModel({this.key});

  void setKey(String key) {
    this.key = key;
    initData();
  }

  @override
  void onDataReady() {
    initData();
    // TODO: implement loadData
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = 15;
    _params['key'] = key;
    return RepositoryCommon.searchCustomerList(_params);
  }

}