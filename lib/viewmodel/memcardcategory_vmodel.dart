import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/memcardcategory_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';

import 'base/base_refresh_list_vmodel.dart';

class MemCardCagtegoryVModel extends BaseRefreshListVModel {

  String selectId;
  String status;

  @override
  void onDataReady() {
    initData();
    // TODO: implement onDataReady
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    // TODO: implement loadListData
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = 10;
    return RepositoryCommon.getMemcardTypeListData(_params);
  }


  /// 删除、 上下架	integer($int32) 状态：0：正常/上架， 1：删除， 2：下架/失效


  void changeCardTypeStatus(){
    Map<String, dynamic> _map = Map();
    _map['ids'] = [selectId];
    _map['status'] = status;
    RepositoryCommon.changeMemCardTypeStatus(_map).then((value){
      initData();
    }).catchError((error){

    });
  }

}

class OpenCardListVModel extends BaseRefreshListVModel {
  String key;

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
    // TODO: implement loadListData
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = 10;
    _params['name'] = key;
    _params['status'] = 0;/// 正常状态
    return RepositoryCommon.getMemcardTypeListData(_params);
  }
}
