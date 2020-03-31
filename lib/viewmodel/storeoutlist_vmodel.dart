import 'package:common_utils/common_utils.dart';
import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/date_util.dart';
import 'package:flutter_project1/util/functions.dart';

import 'base/base_refresh_list_vmodel.dart';
import 'base/base_vmodel.dart';

class StoreOutListVModel extends BaseRefreshListVModel {

  String startTime =  DateUtils.getStartMonth();
//  DateUtil.getDateStrByDateTime(DateTime.now(),
//      format: DateFormat.YEAR_MONTH_DAY);

  String endTime =  DateUtils.getEndMonth();


  void setStartTime(DateTime startTime) {
    this.startTime = DateUtil.getDateStrByDateTime(startTime,
        format: DateFormat.YEAR_MONTH_DAY);
    initData();
  }

  void setEndTime(DateTime endTime) {
    this.endTime = DateUtil.getDateStrByDateTime(endTime,
        format: DateFormat.YEAR_MONTH_DAY);
    initData();
  }

  String selectStoreCostId;

  @override
  void onDataReady() {
    initData();
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = 10;
    _params['startTime'] = startTime;
    _params['endTime'] = endTime;
    return RepositoryCommon.getStoreOutList(_params);
  }

  void deleteStoreOut() {
    Map<String, dynamic> _params = Map();
    _params['storeCostId'] = selectStoreCostId;
    RepositoryCommon.deleteStoreOut(_params).then((value) {
      initData();
    }).catchError((error) {});
  }
}

class StoreOutAddVModel extends BaseVModel {
  String beginDate = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);

  String storeId = '';

  String type = '';

  int typeIndex = 0;


  String price = '';

  List chooseList = ['水电费', '房租', '工资', '采购', '店面维修', '其他'];

  /// type	string支出类型1 水电费 2 房租 3 工资 4 采购 5 店面维修 6 其他

  StoreOutAddVModel({this.storeId});


  void setSelectDate(DateTime date) {
    this.beginDate =
        DateUtil.getDateStrByDateTime(date, format: DateFormat.YEAR_MONTH_DAY);
    notifyListeners();
  }

  void setSelectType(int index) {
    type = chooseList[index];
    typeIndex = index+1;
    notifyListeners();
  }

  @override
  void onDataReady() {
    // TODO: implement onDataReady
  }

  void submmitData(GetBackValue backValue){
    Map<String, dynamic> _map = Map();
    _map['storeId'] = storeId;
    _map['type'] = typeIndex.toString();
    _map['costPrice'] = price;
    _map['costTime'] = beginDate;
    RepositoryCommon.addstoreOut(_map).then((value){
      backValue(value);
    }).catchError((error){

    });
  }
}

