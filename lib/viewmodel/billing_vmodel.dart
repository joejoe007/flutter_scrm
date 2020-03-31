import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/common/router_manger.dart';
import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/model/memcardlist_model.dart';
import 'package:flutter_project1/model/order_detail_model.dart';
import 'package:flutter_project1/model/project_list_item_model.dart';
import 'package:flutter_project1/model/request/add_refund_order_model.dart';
import 'package:flutter_project1/model/request/billing_info_model.dart';
import 'package:flutter_project1/model/storeuserlist_model.dart';
import 'package:flutter_project1/page/main/home_page.dart';
import 'package:flutter_project1/page/main/main_page.dart';
import 'package:flutter_project1/repository/repository_common.dart';
import 'package:flutter_project1/util/functions.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/base/base_refresh_list_vmodel.dart';
import 'package:flutter_project1/widget/my_toast.dart';
import 'package:quiver/strings.dart';

/// 开单选择车牌号
class BillingVModel extends BaseRefreshListVModel {
  String _carNum;

  String get carNum => _carNum;

  set carNum(String value) {
    _carNum = value;
    notifyListeners();
  }

  @override
  void onDataReady() {}
}

/// 开单选择用户，车辆列表
class CarListVModel extends BaseRefreshListVModel<CarItemInfoModel> {
  String _key; // 关键词

  void setKey({String key = ''}) {
    this._key = key;
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
    if (isNotEmpty(_key)) {
      _params['key'] = _key;
    }
    return RepositoryCommon.searchCarList(_params);
  }
}

/// 开单内容
class BillingContentVModel extends BaseRefreshListVModel {
  TextEditingController moneyController = TextEditingController();
  TextEditingController preMoneyController = TextEditingController();
  dynamic _currentDriveM, _nextMaintainM, _nextMaintainTime, _keyCard;
  dynamic get currentDriveM => _currentDriveM;
  set currentDriveM(dynamic value) {
    _currentDriveM = value;
  }
  get nextMaintainM => _nextMaintainM;
  set nextMaintainM(value) {
    _nextMaintainM = value;
  }
  get nextMaintainTime => _nextMaintainTime;
  set nextMaintainTime(value) {
    _nextMaintainTime = value;
  }
  get keyCard => _keyCard;
  set keyCard(value) {
    _keyCard = value;
  }



  String _carNum;

  /// 根据车牌号获取个人信息
  CustomerInfoModel customerInfoModel;
  /// 当前车辆的信息
  CustomListCarModel currentCarInfoModel;

  /// 根据车牌拿用户信息
  getUserInfo(String carNum) {
    this._carNum = carNum;
    Map<String, dynamic> _params = Map();
    _params['carNo'] = _carNum;
    return RepositoryCommon.searchCustomerList(_params).then((value) {
      if (null == value.data) return;
      List<CustomerInfoModel> customerInfoModelList = value.data;
      if (customerInfoModelList.length != 0) {
        customerInfoModel = customerInfoModelList[0];
        /// 将当前车辆信息放入currentCarInfoModel
        if(customerInfoModel != null && customerInfoModel.cars != null){
          customerInfoModel.cars.forEach((item){
            if(carNum.toString() == item.carNo.toString()){
              currentCarInfoModel = item;
            }
          });
        }
        if(customerInfoModel != null && isNotEmpty(customerInfoModel?.id?.toString())){
          getMemCardCustomerData(customerInfoModel.id);
          getCardTypeList(customerInfoModel.id);
        }
      }
      notifyListeners();
    });
  }

  /// 会员卡扣次全部信息
  List<MemberCardTypeModel> cardCountAllList = [];

  /// 会员卡扣次计算
  getCardTypeList(dynamic consumerId) {
    Map<String, dynamic> _params = Map();
    _params['customerId'] = consumerId;
    _params['status'] = 5;
    RepositoryCommon.getMemcardTypeList(_params).then((value) {
      if (null == value.data) return;
      cardCountAllList = value.data;
      notifyListeners();
    });
  }


  /// 推荐开单金额和扣次，edit
  MemCardBalanceModel balanceMode;

  void getMemCardCustomerData(dynamic consumerId) {
    if (customerInfoModel == null) return;
    Map<String, dynamic> _params = Map();
    _params['customerId'] = consumerId;
    RepositoryCommon.getMemCardCustomerBalance(_params).then((value) {
      balanceMode = value.data;
      notifyListeners();
    }).catchError((error) {});
  }






  /// 订单基础信息
  OrderDetailModel orderDetailModel;

  /// 获取订单基础数据
  getOrderCommonInfo(dynamic orderId) {
    RepositoryCommon.getOrderInfo(orderId).then((value) {
      if (null == value.data) return;
      orderDetailModel = value.data;
      _keyCard = orderDetailModel.keyCard;
      notifyListeners();
    });
  }


  /// 订单结算信息
  OrderSettlementDetailModel orderSettlementDetailModel;

  /// 获取结算信息
  getSettlementInfo(dynamic orderId) {
    if (orderId == null) return;
    RepositoryCommon.getOrderSettlementDetail(orderId).then((value) {
      if (null == value.data) return;
      orderSettlementDetailModel = value.data;
      preMoney = double.parse(StringUtil.checkEmpty(orderSettlementDetailModel?.prepayMoney, '0.0'));
      notifyListeners();
    });
  }





  /// 选择的项目
  List<ProjectItemModel> hasChooseProjectList = [];





  // 已经选择的
  List<MemberCardTypeModel> leftMoneyList = [];
  // 已经选择的会员卡扣次
  List<MemberCardTypeModel> cardHasCountList = [];

  /// 设置选择后的会员卡扣次
  setChooseCard(List<MemberCardTypeModel> list) {
    if (list == null) return;
    cardHasCountList.clear();
    cardHasCountList.addAll(list);
    notifyListeners();
  }

  /// 设置选择推荐开单会员卡扣次
  setRecommendChooseCard(List<MemberCardTypeModel> list) {
    if (list == null) return;
    resetSettlementInfo();
    cardHasCountList.clear();
    cardHasCountList.addAll(list);
    cardHasCountList.forEach((item){
      item.discountCount = 1;
    });
    hasChooseProjectList.clear();
    list.forEach((card) {
      ProjectItemModel projectModel = ProjectItemModel(
          id: card.itemId, name: card.itemName, price: card.balance, num: 1);
      hasChooseProjectList.add(projectModel);
    });
    notifyListeners();
  }

  /// 获取会员卡折扣次数
  int getChooseCardCount() {
    int count = 0;
    cardHasCountList.forEach((item) {
      count += item.discountCount;
    });
    return count;
  }

  /// 获取会员卡折扣金额
  double getChooseCardMoney() {
    double money = 0.0;
    hasChooseProjectList.forEach((project) {
      cardHasCountList.forEach((item) {
        if (int.parse(project.id.toString()) ==
            int.parse(item.itemId.toString())) {
          money += ((project.discount / 10) * double.parse(StringUtil.checkEmpty(project?.price?.toString(), '0.0')) * item.discountCount);
        }
      });
    });
    return money;
  }




  /// 选择的消费记录
  List<RecentOrderItemModel> recordList = [];

  /// 消费记录列表
  setRecommendRecord(List<RecentOrderItemModel> list) {
    if (list == null) return;
    resetSettlementInfo();
    recordList.clear();
    recordList.addAll(list);
    hasChooseProjectList.clear();
    list.forEach((item) async {
      await getOrderItemList(item.id);
    });
    notifyListeners();
  }



  /// 余额抵扣
  List<MemberCardTypeModel> hasLeftMoneyList = [];

  /// 设置选择的余额抵扣金额
  setMemberMoneyChoose(List<MemberCardTypeModel> list) {
    if (list == null) return;
    hasLeftMoneyList.clear();
    hasLeftMoneyList.addAll(list);
    notifyListeners();
  }

  /// 获取余额抵扣次数
  int getLeftMoneyCount(){
    int count = 0;
    count = hasLeftMoneyList.length;
    return count;
  }

  /// 获取余额抵扣金额
  double getLeftMoney() {
    double memberMoney = 0;
    hasLeftMoneyList.forEach((item) {
      memberMoney += item.discountMoney;
    });
    return double.parse(StringUtil.formatNum(memberMoney, 2));
  }








  /// 销售人员
  List<StoreUserListModel> hasStoreUserListModelList = [];

  /// 设置销售人员信息
  setSaleUserInfo(List<StoreUserListModel> storeUserListModelList) {
    this.hasStoreUserListModelList = storeUserListModelList;
    notifyListeners();
  }

  String getSaleUserName() {
    StringBuffer nameBuffer = StringBuffer();
    String nameString = '';
    hasStoreUserListModelList.forEach((item) {
      if (isNotEmpty(item.name)) {
        nameBuffer.write(item.name + '，');
      }
    });
    if (isNotEmpty(nameBuffer.toString())) {
      nameString =
          nameBuffer.toString().substring(0, nameBuffer.toString().length - 1);
    }
    return nameString;
  }




  /// 手动优惠金额
  double handDiscount = 0.0;

  /// 预付金额
  double preMoney = 0.0;

  /// 备注
  String remark = '';

  /// 支付方式
  int payWay = -1;

  /// 适用整单，折扣
  bool isAllBill = false;
  double setItemDiscount = 10.00;

  /// 会员卡余额提醒
  bool cardRemind = false;

  set cardReminding(bool remind) {
    this.cardRemind = remind;
    notifyListeners();
  }

  /// 适用整单
  setAllBill() {
    hasChooseProjectList.forEach((item) {
      item.discount = setItemDiscount;
    });
    notifyListeners();
  }

  /// 获取单项信息列表
  getOrderItemList(dynamic orderId) {
    if (orderId == null) return;
    RepositoryCommon.getOrderItemInfo(orderId).then((value) {
      List<OrderItemInfoModel> orderItemList = value.data;
      orderItemList.forEach((item) {
        ProjectItemModel child = ProjectItemModel(
            categoryId: item.categoryId,
            id: item.itemId,
            name: item.itemName,
            price: item.price,
            num: int.parse(item.amount.toString()),
            discount: double.parse(StringUtil.checkEmpty(item?.discount, '10.00')));
        hasChooseProjectList.add(child);
      });
      notifyListeners();
    });
  }


  /// 添加
  addListNumIndex(int index) {
    hasChooseProjectList[index].num++;
    resetSettlementInfo();
    notifyListeners();
  }

  /// 减少
  deleteListNumIndex(int index) {
    if (hasChooseProjectList[index].num == 1) {
      hasChooseProjectList.removeAt(index);
      resetSettlementInfo();
      return;
    }
    hasChooseProjectList[index].num--;
    resetSettlementInfo();
  }

  /// 重置结算信息
  void resetSettlementInfo() {
    cardHasCountList.clear();
    hasLeftMoneyList.clear();
    handDiscount = 0.0;
    moneyController.text = '';
    notifyListeners();
  }


  /// 获取数量
  int getAllContentCount() {
    int count = 0;
    hasChooseProjectList.forEach((o) {
      if (o.num > 0) {
        count++;
      }
    });
    return count;
  }

  /// 合计金额
  double getAllContentMoney() {
    double money = 0.0;
    hasChooseProjectList.forEach((o) {
      if (o.num > 0) {
        money += (double.parse(StringUtil.checkEmpty(o?.price?.toString(),'0.0')) * (o.discount / 10) * o.num);
      }
    });
    return double.parse(StringUtil.formatNum(money, 2));
  }

  /// 应该收的钱
  double finalGetMoney() {
    double money = 0.0;
    money = getAllContentMoney() - getChooseCardMoney()- getLeftMoney() - handDiscount;
    return double.parse(StringUtil.formatNum(money, 2));
  }


  /// 重新设置选择的项目
  set setProjectList(List<ProjectItemModel> value) {
    hasChooseProjectList.clear();
    hasChooseProjectList.addAll(value);
    leftMoneyList.clear();
    hasChooseProjectList.forEach((project) {
      cardCountAllList.forEach((item) {
        if(int.parse(item.itemId.toString()) == 5){
          leftMoneyList.add(item);
        }
        if(int.parse(project.id.toString()) == int.parse(item.itemId.toString())) {
          cardHasCountList.add(item);
        }
      });
    });
    resetSettlementInfo();
    notifyListeners();
  }

  /// 设置支付方式
  setPayType(int payTypeInt) {
    this.payWay = payTypeInt;
    notifyListeners();
  }

  @override
  void onDataReady() {}

  /// 技师id
  String getSaleUserId() {
    StringBuffer idBuffer = StringBuffer();
    String idString = '';
    hasStoreUserListModelList.forEach((item) {
      if (isNotEmpty(item.id)) {
        idBuffer.write(item.id + '，');
      }
    });
    if (isNotEmpty(idBuffer.toString())) {
      idString =
          idBuffer.toString().substring(0, idBuffer.toString().length - 1);
    }
    return idString;
  }

  /// 开单
  submitBilling(BuildContext context, {dynamic orderId, bool save = false, bool settlement = false, bool repay = false, bool book = false}) {
    if(finalGetMoney() < 0){
      MyToast.showToast('应收金额不能为负');
      return;
    }
    CustomerInfo customerInfo = CustomerInfo(
        carBrandId: currentCarInfoModel?.brandId,
        carModelId: currentCarInfoModel?.modelId,
        carNo: _carNum,
        carSeriesId: currentCarInfoModel?.seriesId,
        id: customerInfoModel?.id,
        insuranceExpireTime: isNotEmpty(StringUtil.checkEmpty(currentCarInfoModel?.insuranceExpireTime, '')) ? DateUtil.getDateStrByTimeStr(currentCarInfoModel?.insuranceExpireTime, format: DateFormat.YEAR_MONTH_DAY) : '',
        kilometers: double.parse(StringUtil.checkEmpty(currentCarInfoModel?.kilometers, '0')).toInt(),
        nextMaintainMileage: double.parse(StringUtil.checkEmpty(currentCarInfoModel?.nextMaintainMileage, '0')).toInt(),
        nextMaintainTime: isNotEmpty(StringUtil.checkEmpty(currentCarInfoModel?.nextMaintainTime, ''))? DateUtil.getDateStrByTimeStr(currentCarInfoModel?.nextMaintainTime, format: DateFormat.YEAR_MONTH_DAY) : '',
        name: customerInfoModel?.name,
        remark: remark,
        telNo: customerInfoModel?.mobile);
    List<OrderDetail> orderList = [];
    hasChooseProjectList.forEach((item) {
      orderList.add(OrderDetail(
          amount: item.num,
          categoryId: item.categoryId,
          discount: item.discount,
          itemId: item.id,
          name: item.name,
          price: item.price,
          saleIds: getSaleUserId(),
          workerIds: getSaleUserId()));
    });
    Future<ResultBean> future;
    if (orderId == null) {
      BillingInfoModel billingInfoModel = BillingInfoModel(channel: Platform.isIOS ? 1 : 2, keyCard: _keyCard, customerInfo: customerInfo, orderDetails: orderList,);
      future = RepositoryCommon.addOrderInfo(billingInfoModel);
    } else {
      UpdateOrderInfoModel updateOrderInfoModel = UpdateOrderInfoModel(customerInfo: customerInfo, id: orderId, orderDetails: orderList, keyCard: _keyCard);
      future = RepositoryCommon.updateOrderInfo(updateOrderInfoModel);
    }
    future.then((value) {
      int orderId = int.parse(value.data.toString());
      /// 保存
      if (save) {
        MyToast.showToast('保存成功');
        NavigatorUtil.pushAndRemoveUtil(context, MainPage(initPage: 1,));
        return;
      }
      /// 结算
      if (settlement) {
        List<CardInfo> cardInfos = [];
        cardHasCountList.forEach((item) {
          CardInfo cardInfo = CardInfo(
              amount: item.discountCount,
              cardCustomerInfoId: item.id,
              itemId: item.itemId,
              type: 1);
          cardInfos.add(cardInfo);
        });
        hasLeftMoneyList.forEach((item) {
          CardInfo cardInfo = CardInfo(
              amount: item.discountMoney,
              cardCustomerInfoId: item.id,
              itemId: item.itemId,
              type: 5);
          cardInfos.add(cardInfo);
        });
        OrderSettlementModel orderSettlementModel = OrderSettlementModel(
            cardInfos: cardInfos,
            customerId: customerInfoModel?.id,
            discountsMoney: handDiscount,
            orderId: orderId,
            payStatus: book ? 1 : 4,
            payWay: payWay,
            remark: remark,
            sendMsg: cardRemind ? 1 : 0);
        /// 重置支付方式
        payWay = -1;
        RepositoryCommon.addOrderSettlement(orderSettlementModel).then((value) {
          if(book)
            MyToast.showToast('挂帐成功');
          else
            MyToast.showToast('结算成功');
          NavigatorUtil.pushAndRemoveUtil(context, MainPage(initPage: 1,));
        }).catchError((value){
          if(book)
            MyToast.showToast(value.message);
          else
            MyToast.showToast(value.message);
        });
        return;
      }
      if (repay) {
        OrderSettlementRepayModel repayModel = OrderSettlementRepayModel(orderId: orderId, payWay: payWay, prepayMoney: preMoney);
        /// 重置支付方式
        payWay = -1;
        RepositoryCommon.addOrderSettlementRepay(repayModel).then((value) {
          MyToast.showToast('预付成功');
          NavigatorUtil.pushAndRemoveUtil(context, MainPage(initPage: 1,));
        }).catchError((value){
          MyToast.showToast(value.message);
        });
        return;
      }
    }).catchError((value){
      MyToast.showToast(value.message);
    });
  }

  /// 撤单
  cancelOrder(BuildContext context , dynamic orderId) {
    RepositoryCommon.cancelOrder(orderId).then((value) {
      MyToast.showToast('撤单成功');
      NavigatorUtil.pushAndRemoveUtil(context, MainPage(initPage: 1,));
    }).catchError((value){
      MyToast.showToast(value.message);
    });
  }
}

/// 退单
class BackBillingVModel extends BaseRefreshListVModel {

  int payWay = -1;

  set detailModel(OrderSettlementDetailModel value) {
    refundOrderModel.orderId = value.orderId;
  }

  String operator = '请选择';
  AddRefundOrderModel refundOrderModel = AddRefundOrderModel();

  void setPayWay(dynamic payWay){
    this.payWay = payWay;
    refundOrderModel.payWay = payWay;
    notifyListeners();
  }

  set description(dynamic value) {
    refundOrderModel.remark = value;
  }

  void setOperator(StoreUserListModel storeUserListModel){
    this.operator = storeUserListModel.name;
    refundOrderModel.operator = storeUserListModel.id;
    notifyListeners();
  }

  @override
  void onDataReady() {

  }

  List<OrderItemInfoModel> orderItemList;

  /// 获取单项信息列表
  getOrderItemList(dynamic orderId) {
    if (orderId == null) return;
    RepositoryCommon.getOrderItemInfo(orderId).then((value) {
      if(null == value || null == value.data) return;
      orderItemList = value.data;
    });
  }

  void backBillOrder(GetBackValue getBackValue ){
    if(orderItemList != null) {
      List<RefundOrdersDetail> list = [];
      orderItemList.forEach((item){
        RefundOrdersDetail detail = RefundOrdersDetail(buyAmount: item.amount, buyPrice: item.total, itemId: item.itemId, refundAmount: item.amount, refundPrice: item.total);
        list.add(detail);
      });
      refundOrderModel.refundOrdersDetails = list;
    }
    RepositoryCommon.refundOrderAdd(refundOrderModel).then((value){
      MyToast.showToast('退单成功');
      getBackValue(value);
    }).catchError((value){
      MyToast.showToast(value.message);
    });
  }
}

/// 项目列表
class ProjectListVModel extends BaseRefreshListVModel<ProjectItemModel> {

  bool showSearch = false;

  /// 搜索的list
  searchKey(String key){
    showSearch = isNotEmpty(key);
    list.forEach((item){
      item.searchShow = item.name.toString().contains(key);
    });
    notifyListeners();
  }

  /// 已经选择了的
  List<ProjectItemModel> hasChooseList = [];

  setHasChooseList(List<ProjectItemModel> hasChooseList) {
    this.hasChooseList = hasChooseList;
  }

  /// 添加
  addListNumIndex(int index) {
    list[index].num++;
    notifyListeners();
  }

  /// 减少
  deleteListNumIndex(int index) {
    if (list[index].num == 0) {
      MyToast.showToast('不能再减了');
      return;
    }
    list[index].num--;
    notifyListeners();
  }

  bool hideSheet() {
    bool hide = false;
    hide = list.every((item) {
      return item.num == 0;
    });
    return hide;
  }

  /// 获取金额
  double getAllContentMoney() {
    double money = 0.0;
    list.forEach((o) {
      if (o.num > 0) {
        money += (double.parse(StringUtil.checkEmpty(o?.price?.toString(),'0.0')) * o.num);
      }
    });
    return money;
  }

  /// 获取数量
  int getAllContentCount() {
    int count = 0;
    list.forEach((o) {
      if (o.num > 0) {
        count++;
      }
    });
    return count;
  }

  /// 计算已经选过的
  List<ProjectItemModel> hasChooseProject() {
    List<ProjectItemModel> choosedList = [];
    for (ProjectItemModel o in list) {
      if (o.num > 0) {
        choosedList.add(o);
      }
    }
    return choosedList;
  }

  @override
  void onDataReady() {

  }

  /// 加载项目列表
  void loadProjectList({dynamic id}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = 1;
    _params['pageSize'] = Constant.PAGE_SIZE_1000;
    RepositoryCommon.projectList(_params).then((value) {
      list.clear();
      list.addAll(value.data);
      if(id != null){
        getCardCountList(id, list);
      }
      setSuccess();
      if (hasChooseList == null || hasChooseList.length == 0) return;
      for (ProjectItemModel allItem in list) {
        for (ProjectItemModel chooseItem in hasChooseList) {
          if (chooseItem.id == allItem.id) {
            allItem.num = chooseItem.num;
            allItem.discount = chooseItem.discount;
          }
        }
      }
      notifyListeners();
    }).catchError((value) {
      setEmpty();
    });
  }

  /// 获取会员卡扣次接口
  getCardCountList(dynamic consumerId, List<ProjectItemModel> list) {
    Map<String, dynamic> _params = Map();
    _params['customerId'] = consumerId;
    _params['status'] = 5;
    RepositoryCommon.getMemcardTypeList(_params).then((value) {
      if (value.data == null) return;
      List<MemberCardTypeModel> cardCountList = value.data;
      list.forEach((item){
        cardCountList.forEach((cardItem){
          if(int.parse(item.id.toString()) == int.parse(cardItem.itemId.toString()) && int.parse(cardItem.balance.toString()) > 0){
            item.showCardMember = true;
          }
        });
      });
      notifyListeners();
    });
  }

}

/// 会员余额
class MemberBalanceListVModel
    extends BaseRefreshListVModel<MemberCardTypeModel> {
  String consumerId;
  List<MemberCardTypeModel> hasChooseList = [];

  setConsumerId(String consumerId) {
    this.consumerId = consumerId;
  }

  setHasChooseList(List<MemberCardTypeModel> hasChooseList) {
    this.hasChooseList = hasChooseList;
  }

  @override
  void onDataReady() {
    getCardTypeList();
  }

  /// 加载项目列表
  getCardTypeList() {
    Map<String, dynamic> _params = Map();
    _params['customerId'] = consumerId;
    _params['status'] = 5;
    RepositoryCommon.getMemcardTypeList(_params).then((value) {
      List<MemberCardTypeModel> listChild = value.data;
      listChild.forEach((item) {
        // 现金
        if (int.parse(item.type.toString()) == 5) {
          list.add(item);
          list.forEach((item) {
            hasChooseList.forEach((has) {
              if (int.parse(item.id.toString()) ==
                  int.parse(has.id.toString())) {
                item.discountMoney = has.discountMoney;
                item.choose = has.choose;
              }
            });
          });
        }
      });
      setSuccess();
    });
  }

  /// 返回的选择的金额抵扣
  List<MemberCardTypeModel> getChooseList() {
    if (list.length == 0) return null;
    List<MemberCardTypeModel> resultList = [];
    list.forEach((item) {
      if (item.choose) {
        resultList.add(item);
      }
    });
    return resultList;
  }

  /// 需要的总金额
  double totalMoney = 0.0;
}

/// 优惠券
class CouponListVModel extends BaseRefreshListVModel {
  dynamic status;
  String customerId;

  CouponListVModel({this.status, this.customerId});

  @override
  void onDataReady() {
    initData();
  }

  @override
  Future<ResultBean> loadListData({int pageNum}) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = Constant.PAGE_SIZE;
    _params['status'] = status;
    _params['customerId'] = customerId;
    return RepositoryCommon.getMemcardList(_params);
  }
}

/// 推荐办卡，会员卡
class RecommendCardListVModel extends BaseRefreshListVModel {
  List<MemberCardTypeModel> memberCardList = [];

  HashMap<String, List<MemberCardTypeModel>> _map = HashMap();

  Map<String, List<MemberCardTypeModel>> get map => _map;

  @override
  void onDataReady() {}

  /// 获取推荐开单列表
  getCardList(dynamic consumerId) {
    Map<String, dynamic> _params = Map();
    _params['customerId'] = consumerId;
    _params['status'] = 5;
    RepositoryCommon.getMemcardTypeList(_params).then((value) {
      if (value.data == null) return;
      this.memberCardList.clear();
      List<MemberCardTypeModel> list = value.data;
      list.forEach((item) {
        if (int.parse(item.type.toString()) != 5) {
          this.memberCardList.add(item);
        }
      });
      groupList(this.memberCardList, _map);
      setSuccess();
    });
  }

  /// 获取开单个数
  int getNum() {
    int num = 0;
    memberCardList.forEach((item) {
      if (item.choose) num += 1;
    });
    return num;
  }

  /// 获取已经选择的会员卡开单
  List<MemberCardTypeModel> getChooseCard() {
    List<MemberCardTypeModel> list = [];
    this.memberCardList.forEach((item) {
      if (item.choose) list.add(item);
    });
    return list;
  }
}

/// 推荐办卡，消费记录
class RecommendCardConsumeListVModel
    extends BaseRefreshListVModel<RecentOrderItemModel> {
  @override
  void onDataReady() {}

  /// 获取消费记录
  getRecentOrderList(dynamic consumerId) {
    RepositoryCommon.getRecentOrderInfo(consumerId).then((value) {
      if (value.data == null) return;
      list = value.data;
      setSuccess();
    });
  }

  /// 获取开单个数
  int getNum() {
    int num = 0;
    list.forEach((item) {
      if (item.choose) num += 1;
    });
    return num;
  }

  /// 获取已经选择的消费记录list
  List<RecentOrderItemModel> getChooseRecentOrder() {
    List<RecentOrderItemModel> list = [];
    this.list.forEach((item) {
      if (item.choose) list.add(item);
    });
    return list;
  }
}

/// 会员卡扣次
class MemberCardReductionListVModel extends BaseRefreshListVModel {
  String consumerId;

  List<ProjectItemModel> chooseProjectList = [];

  List<MemberCardTypeModel> hasChooseCardList = [];
  
  /// 去调现金和不可用的
  List<MemberCardTypeModel> canUseList = [];

  setConsumerId(String consumerId) {
    this.consumerId = consumerId;
  }

  setChooseProjectList(List<ProjectItemModel> projectList) {
    this.chooseProjectList = projectList;
  }

  setHasChooseProject(List<MemberCardTypeModel> projectList) {
    this.hasChooseCardList = projectList;
  }

  HashMap<String, List<MemberCardTypeModel>> _map = HashMap();

  Map<String, List<MemberCardTypeModel>> get map => _map;

  @override
  void onDataReady() {
    getCardTypeList();
  }

  getCardTypeList() {
    Map<String, dynamic> _params = Map();
    _params['customerId'] = consumerId;
    _params['status'] = 5;
    RepositoryCommon.getMemcardTypeList(_params).then((value) {
      if (value.data == null) return;
      
      /// 根据itemid去掉没有用的部分
      chooseProjectList.forEach((pItem) {
        value.data.forEach((item) {
          if (int.parse(item.type.toString()) != 5) {
            if (int.parse(pItem.id.toString()) ==
                int.parse(item.itemId.toString())) {
              canUseList.add(item);
            }
          }
        });
      });
      canUseList.forEach((item) {
        hasChooseCardList.forEach((has) {
          if (int.parse(item.id.toString()) == int.parse(has.id.toString())) {
            item.choose = has.choose;
            item.discountCount = has.discountCount;
          }
        });
      });
      groupList(canUseList, _map);
      setSuccess();
    });
  }

  /// 返回的选择的选择扣次详情
  List<MemberCardTypeModel> getChooseList() {
    if (_map.length == 0) return null;
    List<MemberCardTypeModel> resultList = [];
    List<MemberCardTypeModel> listGroup = [];
    List<List<MemberCardTypeModel>> listList = _map.values.toList();
    listList.forEach((items) {
      listGroup.addAll(items);
    });
    listGroup.forEach((item) {
      if (item.choose) {
        resultList.add(item);
      }
    });
    return resultList;
  }

  /// 比较项目内容和会员卡扣次
  compare(bool value, MemberCardTypeModel model) {
    chooseProjectList.forEach((project) {
      if (int.parse(project.id.toString()) == int.parse(model.itemId.toString())) {
        if(value){
          bool isCanChoose = canUseList.every((item){
            List<MemberCardTypeModel> allSame = [];
            if (int.parse(item.itemId.toString()) == int.parse(model.itemId.toString())) {
              if(item.discountCount > 0){
                allSame.add(item);
              }
            }
            print('allSame' + allSame.length.toString());

            if(allSame.length > 0)
              return false;
            else
              return true;
          });
          print('isCanChoose' + isCanChoose.toString());
          if(!isCanChoose){
            MyToast.showToast('不可再选');
            return ;
          }
          /// 项目大于扣次数
          if(project.num >= double.parse(StringUtil.checkEmpty(model?.balance?.toString(), '0')).toInt()){
            model.discountCount = double.parse(model.balance.toString()).toInt();
          } else {
            model.discountCount = project.num;
          }
          model.choose = value;
        } else {
          model.discountCount = 0;
          model.choose = value;
        }
        notifyListeners();
      }
    });
  }

}

/// 分组
void groupList(List<MemberCardTypeModel> list,
    HashMap<String, List<MemberCardTypeModel>> map) {
  if (null == list || map == null) return;
  String key;
  List<MemberCardTypeModel> listTmp;
  for (MemberCardTypeModel val in list) {
    key = val.cardName.toString(); //按这个属性分组，map的Key
    listTmp = map[key];
    if (null == listTmp) {
      listTmp = new List<MemberCardTypeModel>();
      map[key] = listTmp;
    }
    listTmp.add(val);
  }
}
