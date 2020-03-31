import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/itemlist_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/functions.dart';

import 'base/base_refresh_list_vmodel.dart';
import 'base/base_vmodel.dart';

class ItemSetListVModel extends BaseRefreshListVModel {
  String name;

  void setName(String name) {
    this.name = name;
    initData();
  }

  @override
  void onDataReady() {
    initData();
    // TODO: implement onDataReady
  }

  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = 10;
    _params['name'] = name;
    return RepositoryCommon.getItemListData(_params);
  }
}

class ItemSetAddVModel extends BaseVModel {

  String itemId;

  ItemListDetailModel _detailModel = ItemListDetailModel();
  ItemListDetailModel get detailModel => _detailModel;

  List _list = List();

  List get list => _list;

  List _modelList = List();

  List get modelList => _modelList;

  void setSelectModel(List selectModelValue) {
    ItemCategoryListModel listModel = _modelList[selectModelValue.first];
    ItemCategoryListModel _selectModel =
        listModel.subCategory[selectModelValue.last];
    _detailModel.categoryId = _selectModel.id.toString();
  }

  @override
  void onDataReady() {
    // TODO: implement onDataReady
  }

  void submmitData(GetBackValue getBackValue) {
    Map<String, dynamic> _map = Map();
    _map = _detailModel.toJson();
    RepositoryCommon.addItem(_map).then((value) {
      getBackValue(value);
    }).catchError((error) {});
  }

  void updateData(GetBackValue getBackValue) {
    Map<String, dynamic> _map = Map();
    _map = _detailModel.toJson();
    RepositoryCommon.updateItemDetail(_map).then((value) {
      getBackValue(value);
    }).catchError((error) {});
  }

  void getItemDetailData() {
    Map<String, dynamic> _map = Map();
    _map['serviceItemId'] = itemId;
    RepositoryCommon.getItemListDetail(_map)
        .then((value) {
          _detailModel = value.data;
          notifyListeners();
    })
        .catchError((error) {

    });
  }

  void getCategoryData() {
    Map<String, dynamic> _map = Map();
    RepositoryCommon.getItemCategory(_map).then((value) {
      _modelList = value.data;
      for (int i = 0; i < _modelList.length; i++) {
        Map _map = Map();
        List _valueList = List();
        ItemCategoryListModel subModel = _modelList[i];
        for (ItemCategoryListModel secondSubModle in subModel.subCategory) {
          _valueList.add(secondSubModle.name);
        }
        _map[subModel.name] = _valueList;

        _list.add(_map);
      }
      notifyListeners();
    }).catchError((error) {});
  }

  /// 项目删除
  void deleteItem(GetBackValue getBackValue){
    Map<String, dynamic> _map = Map();
    _map['ids'] = [itemId];
    RepositoryCommon.deleteItem(_map).then((value){
      getBackValue(value);

    }).catchError((error){

    });
  }
}
