import 'package:flutter_project1/model/customercare_model.dart';
import 'package:flutter_project1/model/home.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/base/base_refresh_list_vmodel.dart';

class HomeVModel extends BaseRefreshListVModel {
  // 营业额是否可见
  bool _sumMoneyShow = false;

  bool get sumMoneyShow => _sumMoneyShow;

  /// 统计数据
  HomeStatisticsModel homeStatisticsModel;

  /// 客户关怀
  List<CustomerCareListModel> listCare = [];

  set sumMoneyShow(bool value) {
    _sumMoneyShow = value;
    notifyListeners();
  }

  @override
  void onDataReady() {
    getHomeStatistic();
    getConsumerAlarmNo();
  }

  /// 首页统计数据
  getHomeStatistic() {
    RepositoryCommon.getHomeStatistics(null).then((value) {
      homeStatisticsModel = value.data;
      notifyListeners();
    });
  }

  /// 客户关怀未提醒的
  getConsumerAlarmNo(){
    RepositoryCommon.getCustomerCareList({'alertStatus': 0, 'pageNum' : 1, 'pageSize' : 100}).then((value){
      if(value.data == null) return;
      listCare.clear();
      listCare.addAll(value.data);
      notifyListeners();
    });
  }

  List<String> showConsumerWidget() {
    List<String> list = [];
    if (listCare.length == 0) {
      list.add('.暂无提醒',);
      return list;
    }
    listCare.forEach((item) {
      list.add('.' + StringUtil.checkEmpty(item?.customerName?.toString(), ''));
    });
    return list;
  }
}
