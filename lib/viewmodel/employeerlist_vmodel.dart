import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/storeuserlist_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/functions.dart';

import 'base/base_refresh_list_vmodel.dart';
import 'base/base_vmodel.dart';

class EmployeerListVModel extends BaseRefreshListVModel {
  StoreUserListModel selectModel;

  @override
  void onDataReady() {
    initData();
    // TODO: implement loadData
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    return RepositoryCommon.getStoreUserList(_params);
  }

  void setSelectModel(StoreUserListModel storeUserListModel , bool isReload) {
    for(StoreUserListModel subModel in list) {
      if(storeUserListModel.id == subModel.id) {
        subModel.select = true;
        selectModel = subModel;
      }else {
        subModel.select = false;
      }
    }
    if(isReload) {
      notifyListeners();
    }

  }
}

/// 选择技师多选
class EmployeeMuListVModel extends BaseRefreshListVModel<StoreUserListModel> {

  @override
  void onDataReady() {
    initData();
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    return RepositoryCommon.getStoreUserList(_params);
  }

  /// 设置已经选择的技师
  void setSelectModel(List<StoreUserListModel> storeUserListModelList) {
    if (storeUserListModelList == null || storeUserListModelList.length == 0)
      return;
    list.forEach((item) {
      item.select = false;
      storeUserListModelList.forEach((itemChoose) {
        if (item.id == itemChoose.id) {
          item.select = true;
        }
      });
    });
    notifyListeners();
  }

  /// 选择技师
  List<StoreUserListModel> getAllPeople() {
    List<StoreUserListModel> selectModelList = [];
    list.forEach((item) {
      if (item.select) {
        selectModelList.add(item);
      }
    });
    return selectModelList;
  }

}

class ChangeEmployeerVModel extends BaseVModel {
  String selectId = '';

  List roleList = List();
  List roleNameList = List();

  String roleName = '';
  String _selectRoleId;
  String name;
  String mobile;

  void setSelectRoleId(int selectIndex) {
    this._selectRoleId = roleList[selectIndex].id.toString();
    roleName = roleList[selectIndex].name;
  }


  @override
  void onDataReady() {
    // TODO: implement onDataReady
  }

  /// 获取角色信息
  void getRoleListData() {
    RepositoryCommon.getRoleList(Map()).then((value) {
      roleList = value.data;
      for (RoleListModel subModel in roleList) {
        roleNameList.add(subModel.name);
      }
      notifyListeners();
    }).catchError((error) {});
  }

  /// 提交信息
  void submmitStoreUser(GetBackValue getBackValue) {
    Map<String, dynamic> _params = Map();
    _params['roleId'] = _selectRoleId;
    _params['mobile'] = mobile;
    _params['name'] = name;
    RepositoryCommon.addStoreUser(_params).then((value) {
      getBackValue(value);
    }).catchError((error) {});
  }

  /// 编辑信息
  void updateStoreUser(GetBackValue getBackValue) {
    Map<String, dynamic> _params = Map();
    _params['roleId'] = _selectRoleId;
    _params['mobile'] = mobile;
    _params['name'] = name;
    _params['id'] = selectId;
    RepositoryCommon.changeStoreUser(_params).then((value) {
      getBackValue(value);
    }).catchError((error) {});
  }

  /// 删除信息
  void deleteStoreUser(GetBackValue getBackValue) {
    Map<String, dynamic> _params = Map();
    _params['storeUserId'] = selectId;
    RepositoryCommon.deleteStoreUser(_params).then((value) {
      getBackValue(value);
    }).catchError((error) {});
  }

}
