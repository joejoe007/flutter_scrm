import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/customercare_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/widget/my_toast.dart';

import 'base/base_refresh_list_vmodel.dart';

class CustomerCareVModel extends BaseRefreshListVModel {
  final String status;
  bool allSelect = false;

  CustomerCareVModel({this.status});

  @override
  void onDataReady() {
    initData();
    // TODO: implement onDataReady
  }

  void setSelect(CustomerCareListModel selectModel) {
    selectModel.isSelect = !selectModel.isSelect;
    bool _haveDeSelect = false;
    for(CustomerCareListModel subModel in list) {
      if(!subModel.isSelect) {
        _haveDeSelect = true;
      }
    }
    this.allSelect = !_haveDeSelect;
    notifyListeners();
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    return RepositoryCommon.getCustomerCareList({'alertStatus': status});
  }

  void setAllSelect(bool allSelect) {
    this.allSelect = allSelect;
    for(CustomerCareListModel subModel in list) {
      subModel.isSelect = allSelect;
    }
    notifyListeners();
  }

  /// 发送提醒
  void sendCustomerCare() {
    List _selectList = List();
    for(CustomerCareListModel subModel in list) {
      if(subModel.isSelect) {
        _selectList.add(subModel);
      }
    }
  
    RepositoryCommon.sendCustomerCare(_selectList)
        .then((value) {
          MyToast.showToast('发送成功');
          initData();
    })
        .catchError((error) {

    });
  }
}
