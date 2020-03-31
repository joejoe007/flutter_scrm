import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/rolemenu_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/functions.dart';

import 'base/base_refresh_list_vmodel.dart';

class RoleMenVModel extends BaseRefreshListVModel {
  List _relationList = List();
  int selectTag = 0;
  bool isAllSelect = false;

  void setSelectTag(int tag) {
    this.selectTag = tag;
    bool haveDeselet = false;
    if (list[selectTag].list.length > 0) {
      for (RoleMenuModel subModel in list[selectTag].list) {
        if (!subModel.isSelect) {
          haveDeselet = true;
        }
      }
    } else {
      haveDeselet = true;
    }

    isAllSelect = !haveDeselet;
    notifyListeners();
  }

  void setSelectModel(RoleMenuModel selectModel) {
    selectModel.isSelect = !selectModel.isSelect;

    bool haveDeselet = false;
    for (RoleMenuModel subModel in list[selectTag].list) {
      if (!subModel.isSelect) {
        haveDeselet = true;
      }
    }
    isAllSelect = !haveDeselet;
    notifyListeners();
  }

  void setAllSelect(bool isAllSelect) {
    this.isAllSelect = isAllSelect;
    for (RoleMenuModel subModel in list[selectTag].list) {
      subModel.isSelect = this.isAllSelect;
    }
    notifyListeners();
  }

  @override
  void onDataReady() {
    getLisTata();
    // TODO: implement onDataReady
  }

  void getLisTata(){
    RepositoryCommon.getsysMenuList(Map()).then((v){
      list = v.data;
      requestRelationListData();
      setSuccess();
    }).catchError((error){
      setError();
    });
  }


  void requestRelationListData() {
    RepositoryCommon.getsysRelationList(Map()).then((value) {
      _relationList = value.data;
      if (list.length > 0) {
        for (RoleMenuModel menuModel in list) {
          for (RoleMenuModel subModel in menuModel.list) {
            for (SysRelationAddListModel relationModel in _relationList) {
              if (subModel.id == relationModel.menuid) {
                subModel.isSelect = true;
              }
            }
          }
        }
      }
      setSuccess();
    }).catchError((error) {

    });
  }

  void submmit(GetBackValue getBackValue) {
    List _selectList = List();

    for (RoleMenuModel subModel in list[selectTag].list) {
      if (subModel.isSelect) {
//        _selectList.add(subModel.toJson());
        SysRelationAddListModel addListModel = SysRelationAddListModel();
        addListModel.osType = '';

        ///(Platform.isIOS) ? '1' : '2';
        addListModel.menuid = subModel.id;
        addListModel.storeId = subModel.storeId;
        addListModel.roleid = '';
        addListModel.name = subModel.name;
      }
    }
    if (_selectList.length > 0) {
      for (Map _map in _selectList) {
        _map['id'] = '';
      }
    }
    RepositoryCommon.addSysrelation(_selectList).then((value) {
      getBackValue(value);
    }).catchError((value) {});
  }
}
