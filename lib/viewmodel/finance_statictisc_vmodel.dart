import 'package:common_utils/common_utils.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/model/finance_model.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/viewmodel/base/base_refresh_list_vmodel.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:quiver/strings.dart';

/// 营业汇总
class BusinessSumVModel extends BaseRefreshListVModel {
  String startTime = DateUtil.getDateStrByDateTime(DateTime.now(),
          format: DateFormat.YEAR_MONTH_DAY),
      endTime = DateUtil.getDateStrByDateTime(DateTime.now(),
          format: DateFormat.YEAR_MONTH_DAY);

  setStartTime(String startTime) {
    this.startTime = startTime;
    onDataReady();
  }

  setEndTime(String endTime) {
    this.endTime = endTime;
    onDataReady();
  }

  setStartAndEndTime(String startTime, String endTime) {
    this.startTime = startTime;
    this.endTime = endTime;
    onDataReady();
  }

  /// 营业汇总详情信息
  BusinessDetailModel _businessDetailModel = BusinessDetailModel();

  BusinessDetailModel get businessDetailModel => _businessDetailModel;

  @override
  void onDataReady() {
    getFinanceDetail();
  }

  /// 获取信息
  void getFinanceDetail() {
    Map<String, dynamic> _params = Map();
    _params['begin'] = startTime;
    _params['end'] = endTime;
    RepositoryCommon.getBusinessInfo(_params).then((value) {
      _businessDetailModel = value.data;
      notifyListeners();
      setSuccess();
    });
  }
}

/// 营业汇总统计
class OpenStatisticSumVModel
    extends BaseRefreshListVModel<FinanceTotalItemModel> {

  OpenStatisticSumVModel(this._begin, this._end);

  String _begin = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);
  String _end = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);

  String get begin => _begin;

  String get end => _end;

  FinanceAccountAndTotalModel financeAccountAndTotalModel =
      FinanceAccountAndTotalModel();

  void setRangeTime({String startTime, String endTime}) {
    if (isNotEmpty(startTime)) this._begin = startTime;
    if (isNotEmpty(endTime)) this._end = endTime;
    initAccount();
    initData();
  }

  @override
  void onDataReady() {
    initAccount();
    initData();
  }

  void initAccount() {
    Map<String, dynamic> _params = Map();
    _params['begin'] = _begin;
    _params['end'] = _end;
    RepositoryCommon.getFinanceTotalDetail(_params).then((value) {
      financeAccountAndTotalModel = value.data;
      setSuccess();
    });
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['begin'] = _begin;
    _params['end'] = _end;
    _params['pageNum'] = pageNum;
    _params['pageSize'] = Constant.PAGE_SIZE;
    return RepositoryCommon.getFinanceTotalList(_params);
  }
}

/// 实收统计
class RealStatisticSumVModel
    extends BaseRefreshListVModel<FinanceIncomeItemModel> {

  RealStatisticSumVModel(this._begin, this._end);

  String _begin = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);
  String _end = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);

  String get begin => _begin;

  String get end => _end;

  FinanceAccountAndTotalModel financeAccountAndTotalModel =
      FinanceAccountAndTotalModel();

  void setRangeTime({String startTime, String endTime}) {
    if (isNotEmpty(startTime)) this._begin = startTime;
    if (isNotEmpty(endTime)) this._end = endTime;
    initAccount();
    initData();
  }

  void initAccount() {
    Map<String, dynamic> _params = Map();
    _params['begin'] = _begin;
    _params['end'] = _end;
    RepositoryCommon.getFinanceTotalDetail(_params).then((value) {
      financeAccountAndTotalModel = value.data;
      setSuccess();
    });
  }

  @override
  void onDataReady() {
    initAccount();
    initData();
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['begin'] = _begin;
    _params['end'] = _end;
    _params['pageNum'] = pageNum;
    _params['pageSize'] = Constant.PAGE_SIZE;
    return RepositoryCommon.getIncomeTotalList(_params);
  }
}

/// 会员卡统计
class MemberTopMoneyVModel extends BaseRefreshListVModel {

  MemberTopMoneyVModel(this._begin, this._end);

  String _begin = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);
  String _end = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);

  /// 总额度显示
  MemberSaleTotalModel _memberSaleTotalModel = MemberSaleTotalModel();

  MemberSaleTotalModel get memberSaleTotalModel => _memberSaleTotalModel;

  set memberSaleTotalModel(MemberSaleTotalModel value) {
    _memberSaleTotalModel = value;
  }

  @override
  void onDataReady() {
    getTotalMoney();
  }

  /// 获取总额度数据
  void getTotalMoney() {
    Map<String, dynamic> _params = Map();
    _params['begin'] = _begin;
    _params['end'] = _end;
    RepositoryCommon.getMemberCardStatisticData(_params).then((value) {
      _memberSaleTotalModel = value.data;
      notifyListeners();
    });
  }

  String get begin => _begin;

  set begin(String value) {
    _begin = value;
    getTotalMoney();
    notifyListeners();
  }

  String get end => _end;

  set end(String value) {
    if (DateUtil.getDateMsByTimeStr(value) <
        DateUtil.getDateMsByTimeStr(_begin)) {
      MyToast.showToast('结束时间不能小于开始时间');
      return;
    }
    _end = value;
    getTotalMoney();
    notifyListeners();
  }
}

/// 会员卡统计,会员卡销售
class MemberCardSumVModel
    extends BaseRefreshListVModel<MemberCardSalesItemModel> {
  String _beginTime = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);
  String _endTime = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);

  MemberCardSumVModel(this._beginTime, this._endTime);

  set beginTime(String value) {
    _beginTime = value;
    initData();
  }

  set endTime(String value) {
    _endTime = value;
    initData();
  }

  @override
  void onDataReady() {
    initData();
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = Constant.PAGE_SIZE;
    _params['begin'] = _beginTime;
    _params['end'] = _endTime;
    return RepositoryCommon.getMemberCardStatisticListData(_params);
  }
}

/// 会员卡统计,剩余总额
class MemberTotalMoneyVModel
    extends BaseRefreshListVModel<MemberCardMoneyItemModel> {
  String _beginTime = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);
  String _endTime = DateUtil.getDateStrByDateTime(DateTime.now(),
      format: DateFormat.YEAR_MONTH_DAY);

  MemberTotalMoneyVModel(this._beginTime, this._endTime);

  String get beginTime => _beginTime;

  set beginTime(String value) {
    _beginTime = value;
    initData();
  }

  String get endTime => _endTime;

  set endTime(String value) {
    _endTime = value;
    initData();
  }

  @override
  void onDataReady() {
    initData();
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = Constant.PAGE_SIZE;
    _params['begin'] = _beginTime;
    _params['end'] = _endTime;
    return RepositoryCommon.getMemberCardStatisticMoneyListData(_params);
  }
}
