import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_project1/common/api.dart';
import 'package:flutter_project1/common/const.dart';
import 'package:flutter_project1/http/result_bean.dart';
import 'package:flutter_project1/model/account_receiver_model.dart';
import 'package:flutter_project1/model/base/base_list_bean.dart';
import 'package:flutter_project1/model/car_type_model.dart';
import 'package:flutter_project1/model/customer.dart';
import 'package:flutter_project1/model/customercare_model.dart';
import 'package:flutter_project1/model/customercareset_model.dart';
import 'package:flutter_project1/model/finance_model.dart';
import 'package:flutter_project1/model/home.dart';
import 'package:flutter_project1/model/itemlist_model.dart';
import 'package:flutter_project1/model/memcardcategory_model.dart';
import 'package:flutter_project1/model/memcarddetail_model.dart';
import 'package:flutter_project1/model/memcardlist_model.dart';
import 'package:flutter_project1/model/order_detail_model.dart';
import 'package:flutter_project1/model/order_list_item_model.dart';
import 'package:flutter_project1/model/project_list_item_model.dart';
import 'package:flutter_project1/model/request/add_customer_info_model.dart';
import 'package:flutter_project1/model/request/add_refund_order_model.dart';
import 'package:flutter_project1/model/rolemenu_model.dart';
import 'package:flutter_project1/model/request/billing_info_model.dart';
import 'package:flutter_project1/model/request/submit_accout_model.dart';
import 'package:flutter_project1/model/storeoutlist_model.dart';
import 'package:flutter_project1/model/storeuserlist_model.dart';
import 'package:flutter_project1/model/version_info_model.dart';
import 'package:flutter_project1/page/test/test_page.dart';
import 'package:flutter_project1/util/sp_util.dart';

import 'base/remote_repo.dart';

class RepositoryCommon {
  /// 测试接口数据
  static Future<ResultBean<List<model_test>>> getTestBanner() {
    Completer<ResultBean<List<model_test>>> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.TEST_URL,
        successCallBack: (data, message) {
      List responseJson = json.decode(data);
      List<model_test> modelTestList =
          responseJson.map((m) => new model_test.fromJson(m)).toList();
      completer.complete(ResultBean(modelTestList, message));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 测试会员卡列表接口
  static Future<ResultBean> getMemcardListTest(int pageNum) {
    Map<String, dynamic> _params = Map();
    _params['pageNum'] = pageNum;
    _params['pageSize'] = Constant.PAGE_SIZE;
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CARDCUSTOMERLIST_URL,
        queryParameters: _params, successCallBack: (data, msg) {
      Map map = json.decode(data);
      BaseListBean baseListBean = BaseListBean.fromJson(map);
      List responseJson = json.decode(json.encode(baseListBean.records));
      List<Record> recordList =
          responseJson.map((m) => new Record.fromJson(m)).toList();
      completer.complete(ResultBean(recordList, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 登录
  /// 登录接口
  static Future<ResultBean<String>> login(Map<String, dynamic> params) {
    Completer<ResultBean<String>> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.LOGIN_URL, data: json.encode(params),
        successCallBack: (data, msg) {
      String responseJson = json.decode(data);
      SpUtil.putString(Constant.Token_key, responseJson);
      RemoteRepo.inst.httpRequest.refreshToken();

      completer.complete(ResultBean(responseJson, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 首页接口
  /// 首页统计
  static Future<ResultBean> getHomeStatistics(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.HOME_STATISTICS,
        queryParameters: params, successCallBack: (data, msg) {
          Map map = json.decode(data);
          HomeStatisticsModel homeStatisticsModel = HomeStatisticsModel
              .fromJson(map);
          completer.complete(ResultBean(homeStatisticsModel, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }



  /// 余额查询
  /// 会员列表
  static Future<ResultBean> getMemcardList(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CARDCUSTOMERLIST_URL,
        queryParameters: params, successCallBack: (data, msg) {
      Map map = json.decode(data);
      BaseListBean baseListBean = BaseListBean.fromJson(map);
      List<Record> memcardList = baseListBean.records
          .map((i) => Record.fromJson(i))
          .toList();
      completer.complete(ResultBean(memcardList, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 会员卡详情
  static Future<ResultBean> getMemCardDetail(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest
        .get(Api.CARDCUSTOMERDETAIL_URL + '/' + params['id'],
            successCallBack: (data, msg) {
      Map map = json.decode(data);
      MemCardDetailModel memCardDetailModel = MemCardDetailModel.fromJson(map);
      completer.complete(ResultBean(memCardDetailModel, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 会员卡退卡
  static Future<ResultBean> refundMemCard(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    params['channel'] = (Platform.isIOS) ? '1' : '2';
    RemoteRepo.inst.httpRequest.post(Api.REFUNDCUSTOMERCARD_URL,
        data: json.encode(params),showDialog:true, successCallBack: (data, msg) {
      completer.complete(ResultBean(data, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 会员卡办卡
  static Future<ResultBean> createMemCard(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.CREATECUSTOMERCARD_URL,
        data: json.encode(params),showDialog:true, successCallBack: (data, msg) {
          completer.complete(ResultBean(data, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 会员卡交易记录
  static Future<ResultBean> getConsumeRecordList(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get('${Api.CONSUMERECORD_URL}/',
        queryParameters: params, successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List<MemCardConsumeRecordsModel> memcardList = baseListBean.records
              .map((i) => MemCardConsumeRecordsModel.fromJson(i))
              .toList();
          completer.complete(ResultBean(memcardList, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 客户会员卡项目列表
  static Future<ResultBean> getMemcardTypeList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CONSUMER_CARD_TYPE_URL,
        queryParameters: params, successCallBack: (data, msg) {
          List responseJson = json.decode(data);
          List<MemberCardTypeModel> typeList =
          responseJson.map((m) => new MemberCardTypeModel.fromJson(m)).toList();
          completer.complete(ResultBean(typeList, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 客户会员卡余额
  static Future<ResultBean> getMemCardCustomerBalance(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CARDCUSTOMERBALANCE_URL+'/${params['customerId']}',
        queryParameters: params, successCallBack: (data, msg) {
          Map map = json.decode(data);
          MemCardBalanceModel balanceModel = MemCardBalanceModel.fromJson(map);
          completer.complete(ResultBean(balanceModel, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 会员卡充值续卡
  static Future<ResultBean> rechargeMemCard(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.CARDCUSTOMERRECHARGE_URL,
        data: json.encode(params),showDialog:true, successCallBack: (data, msg) {
          completer.complete(ResultBean(data, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }



  /// 会员卡卡种
  /// 会员卡卡种列表
  static Future<ResultBean> getMemcardTypeListData(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.MEMCARDTYPELIST_URL,
        queryParameters: params, successCallBack: (data, msg) {
      Map map = json.decode(data);
      BaseListBean baseListBean = BaseListBean.fromJson(map);
      List<MemCardCategoryListModel> memTypeList = baseListBean.records
          .map((i) => MemCardCategoryListModel.fromJson(i))
          .toList();
      completer.complete(ResultBean(memTypeList, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  ///  增加会员卡种
  static Future<ResultBean> addMemType(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.MEMCARDTYPEADD_URL,showDialog: true,
        data: json.encode(params), successCallBack: (data, msg) {
          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 会员卡种详情
  static Future<ResultBean> getMemCardTypeDetail(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.MEMCARDTYPEDETAIL_URL+'/${params['cardTypeId']}',
        queryParameters: params, successCallBack: (data, msg) {
          Map map = json.decode(data);
          MemCardCategoryAddModel categoryAddModel = MemCardCategoryAddModel.fromJson(map);
          completer.complete(ResultBean(categoryAddModel, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 会员卡状态修改
  static Future<ResultBean> changeMemCardTypeStatus(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.MEMCARDTYPECHANGESTATUS_URL,
        data: json.encode(params), successCallBack: (data, msg) {
      String responseJson = json.decode(data);
      completer.complete(ResultBean(responseJson, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 会员卡统计
  /// 会员卡统计总额度
  static Future<ResultBean> getMemberCardStatisticData(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(
        Api.MEMCARD_STATISTIC_SALES_TOTAL_MONEY_URL, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          MemberSaleTotalModel memberSaleTotalModel = MemberSaleTotalModel
              .fromJson(map);
          completer.complete(ResultBean(memberSaleTotalModel, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 会员卡统销售统计列表
  static Future<ResultBean> getMemberCardStatisticListData(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(
        Api.MEMCARD_STATISTIC_SALES_LIST_URL, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List responseJson = json.decode(json.encode(baseListBean.records));
          List<MemberCardSalesItemModel> list =
          responseJson.map((m) => new MemberCardSalesItemModel.fromJson(m))
              .toList();
          completer.complete(ResultBean(list, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 会员卡统销售金额统计列表
  static Future<ResultBean> getMemberCardStatisticMoneyListData(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(
        Api.MEMCARD_STATISTIC_SALES_MONEY_LIST_URL, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List responseJson = json.decode(json.encode(baseListBean.records));
          List<MemberCardMoneyItemModel> list =
          responseJson.map((m) => new MemberCardMoneyItemModel.fromJson(m))
              .toList();
          completer.complete(ResultBean(list, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 挂帐应收
  /// 挂帐应收列表
  static Future<ResultBean> getAccountList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.ACCOUNT_RECEIVER_LIST,
        queryParameters: params, successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List<AccountNeedListItemModel> accountList = baseListBean.records
              .map((i) => AccountNeedListItemModel.fromJson(i))
              .toList();
          completer.complete(ResultBean(accountList, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 挂帐应收总欠款
  static Future<ResultBean> getAccountTotalMoney(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.ACCOUNT_RECEIVER_NEED_PAY_TOTAL,
        queryParameters: params, successCallBack: (data, msg) {
      Map map = json.decode(data);
      AccountTotalModel accountTotalModel = AccountTotalModel.fromJson(map);
      completer.complete(ResultBean(accountTotalModel, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 个人挂帐列表
  static Future<ResultBean> getAccountConsumerList(dynamic customerId) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest
        .get(Api.ACCOUNT_RECEIVER_CUSTOMER_LIST + customerId,
            successCallBack: (data, msg) {
      List responseJson = json.decode(data);
      List<AccountConsumeItemModel> accountList = responseJson
          .map((m) => new AccountConsumeItemModel.fromJson(m))
          .toList();
      completer.complete(ResultBean(accountList, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 销帐单
  static Future<ResultBean> submitAccount(
      SubmitAccountModel submitAccountModel) {
    Completer<ResultBean> completer = Completer();
    var json = submitAccountModel.toJson();
    RemoteRepo.inst.httpRequest.put(Api.ACCOUNT_RECEIVER_PAY_BACK, data: json,
        successCallBack: (data, msg) {
          completer.complete(ResultBean(data, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 项目设置
  /// 项目列表
  static Future<ResultBean> getItemListData(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.SERVICELIST_URL,
        queryParameters: params, successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List<ItemListModel> memTypeList = baseListBean.records
              .map((i) => ItemListModel.fromJson(i))
              .toList();
          for(ItemListModel submodel in memTypeList) {
            submodel.total = baseListBean.total;
          }
          completer.complete(ResultBean(memTypeList, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  ///项目增加
  static Future<ResultBean> addItem(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    String jsonString = json.encode(params);
    RemoteRepo.inst.httpRequest.post(Api.SRRVICEADD_URL,showDialog:true,data: jsonString,
        successCallBack: (data, msg) {
          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 项目分类
  static Future<ResultBean> getItemCategory(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.SERVICECATEGORYLIST_URL,
        queryParameters: params, successCallBack: (data, msg) {
          List responseJson = json.decode(data);
          List<ItemCategoryListModel> itemCategoryList =
          responseJson.map((m) => new ItemCategoryListModel.fromJson(m)).toList();
          completer.complete(ResultBean(itemCategoryList, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 项目详情
  static Future<ResultBean> getItemListDetail(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.SERVICELISTDETAIL_URL+'/${params['serviceItemId']}',
        queryParameters: params, successCallBack: (data, msg) {

          Map responseJson = json.decode(data);
          ItemListDetailModel itemListDetailModel =  ItemListDetailModel.fromJson(responseJson);
          completer.complete(ResultBean(itemListDetailModel, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 项目更新
  static Future<ResultBean> updateItemDetail(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.put(Api.SERVICEDETAILUPDATE_URL,
        data: json.encode(params), successCallBack: (data, msg) {

          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 项目删除
  static Future<ResultBean> deleteItem(
      Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.delete(Api.SERVICEDELETE_URL,
        data: json.encode(params), successCallBack: (data, msg) {

          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }



  /// 门店支出
  /// 门店支出列表
  static Future<ResultBean> getStoreOutList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.STORECOSTLISTURL, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List responseJson = json.decode(json.encode(baseListBean.records));
          List<StoreOutListModel> list =
          responseJson.map((m) => new StoreOutListModel.fromJson(m)).toList();
          completer.complete(ResultBean(list, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

 /// 门店支出删除
  static Future<ResultBean> deleteStoreOut(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.delete(Api.STORECOSTDELETE_URL, queryParameters: params,
        successCallBack: (data, msg) {

          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 新增门店支出
  static Future<ResultBean>addstoreOut(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.STORECOSTADD_URL, showDialog: true,data: json.encode(params),
        successCallBack: (data, msg) {

          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }


  ///员工信息
  ///员工列表
  static Future<ResultBean> getStoreUserList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.STOREUSERLIST_URL, queryParameters: params,
        successCallBack: (data, msg) {

          List responseJson = json.decode(data);
          List<StoreUserListModel> storeUserListModel =
          responseJson.map((m) => StoreUserListModel.fromJson(m)).toList();
          completer.complete(ResultBean(storeUserListModel, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 添加员工
  static Future<ResultBean> addStoreUser(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.STOREUSERADD_URL, data: json.encode(params),
        successCallBack: (data, msg) {
          var responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 修改员工
  static Future<ResultBean> changeStoreUser(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.put(Api.STOREUSERUPDATE_URL, data: json.encode(params),
        successCallBack: (data, msg) {
          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 删除员工
  static Future<ResultBean> deleteStoreUser(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.delete(Api.STOREUSERDELETE_URL, queryParameters: params,
        successCallBack: (data, msg) {
          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }



  /// 角色
  /// 角色列表
  static Future<ResultBean> getRoleList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.SYSROLELIST_URL, data: json.encode(params),
        successCallBack: (data, msg) {

          List responseJson = json.decode(data);
          List<RoleListModel> roleListModel =
          responseJson.map((m) => RoleListModel.fromJson(m)).toList();
          completer.complete(ResultBean(roleListModel, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }




  /// 角色和权限
  /// 菜单列表
  static Future<ResultBean> getsysMenuList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.SYSMENULIST_URL, queryParameters: params,
        successCallBack: (data, msg) {
          List responseJson = json.decode(data);
          List<RoleMenuModel> roleMenuListModel =
          responseJson.map((m) => RoleMenuModel.fromJson(m)).toList();
          completer.complete(ResultBean(roleMenuListModel, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 新增
  static Future<ResultBean> addSysrelation(List list) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.SYSRELATIONADD_URL, data: json.encode(list),
        successCallBack: (data, msg) {
          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }


  static Future<ResultBean> getsysRelationList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.SYSRELATIONLIST_URL, queryParameters: params,
        successCallBack: (data, msg) {
          List responseJson = json.decode(data);
          List<SysRelationAddListModel> realstionListModel =
          responseJson.map((m) => SysRelationAddListModel.fromJson(m)).toList();
          completer.complete(ResultBean(realstionListModel, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }




  /// 客户关怀设置
  /// 客户关怀设置列表
  static Future<ResultBean> getCustomerCareSetList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.SCRMALARMSETTING_URL, queryParameters: params,
        successCallBack: (data, msg) {

          List responseJson = json.decode(data);
          List<CustomerCareSetModel> caresetModelList =
          responseJson.map((m) => CustomerCareSetModel.fromJson(m)).toList();
          completer.complete(ResultBean(caresetModelList, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 修改客户关怀设置
  static Future<ResultBean> updateCustomerCareSet(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.put(Api.UPDATESCRMALARMSETTING_URL, data: json.encode(params),
        successCallBack: (data, msg) {
          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 开启关闭设置
  static Future<ResultBean> updateAllCustomerCareSet(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.put(Api.UPDATEALLSCRMALARMSETTING_URL, queryParameters: params,
        successCallBack: (data, msg) {
          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }



  /// 客户关怀
  /// 客户关怀列表
  static Future<ResultBean> getCustomerCareList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.SCRMALARMHISTORYLIST_URL, data: json.encode(params),
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List responseJson = json.decode(json.encode(baseListBean.records));
          List<CustomerCareListModel> list =
          responseJson.map((m) => new CustomerCareListModel.fromJson(m)).toList();
          completer.complete(ResultBean(list, msg));

        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 发送客户关怀
  static Future<ResultBean> sendCustomerCare(List list) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.post(Api.SCRMALARMHISTORYSEND_URL, showDialog: true,data: json.encode(list),
        successCallBack: (data, msg) {
          String responseJson = json.decode(data);
          completer.complete(ResultBean(responseJson, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }


  /// 车型车系
  /// 车辆品牌
  static Future<ResultBean> getBrandList(){
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CAR_BRAND_LIST,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          CarTypeModel carTypeModel = CarTypeModel.fromJson(map);
          completer.complete(ResultBean(carTypeModel, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 根据车品牌id获取车系
  static Future<ResultBean> getCarSeriesList(dynamic seriesId){
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CAR_SERIES_LIST + seriesId,
        successCallBack: (data, msg) {
          List responseJson = json.decode(data);
          List<CarSeriesItemModel> seriesItemList = responseJson.map((m) => new CarSeriesItemModel.fromJson(m)).toList();
          completer.complete(ResultBean(seriesItemList, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 根据车系id获取型号
  static Future<ResultBean> getCarModelList(dynamic modelId){
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CAR_MODELS + modelId,
        successCallBack: (data, msg) {
          List responseJson = json.decode(data);
          List<CarModelItemModel> carModelItemList = responseJson.map((m) => new CarModelItemModel.fromJson(m)).toList();
          completer.complete(ResultBean(carModelItemList, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }



  /// 客户管理
  /// 客户列表
  static Future<ResultBean> searchCustomerList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CUSTOMER_LIST, queryParameters: params,
        successCallBack: (data, msg) {
      Map map = json.decode(data);
      BaseListBean baseListBean = BaseListBean.fromJson(map);
      List responseJson = json.decode(json.encode(baseListBean.records));
      List<CustomerInfoModel> customerList =
          responseJson.map((m) => new CustomerInfoModel.fromJson(m)).toList();
      completer.complete(ResultBean(customerList, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 客户数量信息
  static Future<ResultBean> getCustomerNumInfo() {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CUSTOMER_NUM_INFO,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          CustomerNumInfoModel custoner = CustomerNumInfoModel.fromJson(map);
          completer.complete(ResultBean(custoner, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 检验手机号
  static Future<ResultBean> mobileExist(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CUSTOMER_MOBILE_EXIST,
        queryParameters: params,
        successCallBack: (data, msg) {
          completer.complete(ResultBean(data, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 新增更新客户信息
  static Future<ResultBean> addOrUpdateCustomerInfo(
      AddCustomerInfoModel addCustomerInfoModel) {
    Completer<ResultBean> completer = Completer();
    var json = addCustomerInfoModel.toJson();
    RemoteRepo.inst.httpRequest.post(Api.CUSTOMER_ADD_UPDATE_INFO, data: json,
        successCallBack: (data, msg) {
      completer.complete(ResultBean(data, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 客户详情，id客户id
  static Future<ResultBean> getCustomerDetail(dynamic id) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CUSTOMER_DETAIL + id,
        successCallBack: (data, msg) {
      Map map = json.decode(data);
      CustomDetailModel customDetailModel = CustomDetailModel.fromJson(map);
      completer.complete(ResultBean(customDetailModel, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 车辆管理
  /// 新增/跟新车辆信息
  static Future<ResultBean> addOrUpdateCarInfo(
      AddCustomerInfoCarModel addCustomerInfoCarModel) {
    Completer<ResultBean> completer = Completer();
    var json = addCustomerInfoCarModel.toJson();
    RemoteRepo.inst.httpRequest.post(Api.CAR_ADD_UPDATE_INFO, data: json,
        successCallBack: (data, msg) {
          completer.complete(ResultBean(data, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 车牌号获取车辆详情
  static Future<ResultBean> getCarInfoByCarNum(dynamic carNum) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(
        Api.CAR_INFO_BY_CAR_NUM + carNum,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          CarInfoByCarNumModel carInfo = CarInfoByCarNumModel.fromJson(map);
          completer.complete(ResultBean(carInfo, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 车辆信息列表
  static Future<ResultBean> searchCarList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CAR_INFO_LIST, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List responseJson = json.decode(json.encode(baseListBean.records));
          List<CarItemInfoModel> carList =
          responseJson.map((m) => new CarItemInfoModel.fromJson(m)).toList();
          completer.complete(ResultBean(carList, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 客户消费统计
  /// 客户消费累计
  static Future<ResultBean> getCustomerConsumeTotal(dynamic id) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.CUSTOMER_CONSTOMER_TOTAL + id,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          CustomerConsumeTotalModel consumeTotalModel =
          CustomerConsumeTotalModel.fromJson(map);
          completer.complete(ResultBean(consumeTotalModel, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 订单界面
  /// 订单列表
  static Future<ResultBean> searchOrderList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.ORDER_LIST, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List responseJson = json.decode(json.encode(baseListBean.records));
          List<OrderItemModel> orderList =
          responseJson.map((m) => new OrderItemModel.fromJson(m)).toList();
          completer.complete(ResultBean(orderList, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 根据订单ID查询订单基础数据(不包含订单项数据)
  static Future<ResultBean> getOrderInfo(dynamic id) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.ORDER_Detail + id,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          OrderDetailModel orderDetailModel = OrderDetailModel.fromJson(map);
          completer.complete(ResultBean(orderDetailModel, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 撤单
  static Future<ResultBean> cancelOrder(dynamic orderId) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.ORDER_CANCEL + orderId.toString(),
        successCallBack: (data, msg) {
          completer.complete(ResultBean('', msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 消费记录
  static Future<ResultBean> getRecentOrderInfo(dynamic consumerId) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(
        Api.ORDER_RECENT_ORDERS + consumerId, successCallBack: (data, msg) {
      List responseJson = json.decode(data);
      List<RecentOrderItemModel> typeList =
      responseJson.map((m) => new RecentOrderItemModel.fromJson(m)).toList();
      completer.complete(ResultBean(typeList, msg));
    }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 订单详情
  /// 订单单项信息
  static Future<ResultBean> getOrderItemInfo(dynamic orderId) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(
        Api.ORDER_ITEM_INFO + orderId,
        successCallBack: (data, msg) {
          List responseJson = json.decode(data);
          List<OrderItemInfoModel> orderItemInfo =
          responseJson.map((m) => OrderItemInfoModel.fromJson(m)).toList();
          completer.complete(ResultBean(orderItemInfo, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 开单
  /// 新增订单
  static Future<ResultBean> addOrderInfo(BillingInfoModel billingInfoModel) {
    Completer<ResultBean> completer = Completer();
    var json = billingInfoModel.toJson();
    RemoteRepo.inst.httpRequest.post(Api.ADD_ORDER, data: json,
        successCallBack: (data, msg) {
          completer.complete(ResultBean(jsonDecode(data), msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 修改订单
  static Future<ResultBean> updateOrderInfo(
      UpdateOrderInfoModel updateOrderInfoModel) {
    Completer<ResultBean> completer = Completer();
    var json = updateOrderInfoModel.toJson();
    RemoteRepo.inst.httpRequest.put(Api.UPDATE_ORDER, data: json,
        successCallBack: (data, msg) {
          completer.complete(ResultBean(jsonDecode(data), msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 订单结算
  /// 新增订单结算
  static Future<ResultBean> addOrderSettlement(
      OrderSettlementModel orderSettlementModel) {
    Completer<ResultBean> completer = Completer();
    var json = orderSettlementModel.toJson();
    RemoteRepo.inst.httpRequest.post(Api.ADD_ORDER_SETTLEMENT, data: json,
        successCallBack: (data, msg) {
          completer.complete(ResultBean(data, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 根据订单id获取结算数据
  static Future<ResultBean> getOrderSettlementDetail(String id) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.ORDER_SETTLEMENT_DETAIL + id,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          OrderSettlementDetailModel orderDetailModel = OrderSettlementDetailModel
              .fromJson(map);
          completer.complete(ResultBean(orderDetailModel, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 预付
  static Future<ResultBean> addOrderSettlementRepay(
      OrderSettlementRepayModel orderSettlementRepayModel) {
    Completer<ResultBean> completer = Completer();
    var json = orderSettlementRepayModel.toJson();
    RemoteRepo.inst.httpRequest.post(Api.ORDER_SETTLEMENT_PREPAY, data: json,
        successCallBack: (data, msg) {
          completer.complete(ResultBean(data, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 项目
  /// 项目列表
  static Future<ResultBean> projectList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.PROJECT_LIST, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List responseJson = json.decode(json.encode(baseListBean.records));
          List<ProjectItemModel> projectList =
          responseJson.map((m) => new ProjectItemModel.fromJson(m)).toList();
          completer.complete(ResultBean(projectList, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 营业汇总
  /// 营业汇总详情信息
  static Future<ResultBean> getBusinessInfo(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.FINANCE_DETAIL, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          BusinessDetailModel businessDetailModel =
          BusinessDetailModel.fromJson(map);
          completer.complete(ResultBean(businessDetailModel, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 营业汇总销量和总金额
  static Future<ResultBean> getFinanceTotalDetail(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(
        Api.FINANCE_SUM_DETAIL, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          FinanceAccountAndTotalModel businessDetailModel =
          FinanceAccountAndTotalModel.fromJson(map);
          completer.complete(ResultBean(businessDetailModel, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 营业汇总统计
  static Future<ResultBean> getFinanceTotalList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.FINANCE_SUM_LIST, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List responseJson = json.decode(json.encode(baseListBean.records));
          List<FinanceTotalItemModel> item =
          responseJson.map((m) => new FinanceTotalItemModel.fromJson(m))
              .toList();
          completer.complete(ResultBean(item, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 实收明细销量和总金额
  static Future<ResultBean> getIncomeTotalDetail(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(
        Api.FINANCE_INCOME_DETAIL, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          FinanceAccountAndTotalModel businessDetailModel =
          FinanceAccountAndTotalModel.fromJson(map);
          completer.complete(ResultBean(businessDetailModel, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 营业汇总实收明细
  static Future<ResultBean> getIncomeTotalList(Map<String, dynamic> params) {
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(
        Api.FINANCE_INCOME_LIST, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List responseJson = json.decode(json.encode(baseListBean.records));
          List<FinanceIncomeItemModel> item =
          responseJson.map((m) => new FinanceIncomeItemModel.fromJson(m))
              .toList();
          completer.complete(ResultBean(item, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

  /// 退单
  /// 新增退单
  static Future<ResultBean> refundOrderAdd(
      AddRefundOrderModel addRefundOrderModel) {
    Completer<ResultBean> completer = Completer();
    var json = addRefundOrderModel.toJson();
    RemoteRepo.inst.httpRequest.post(Api.REFUND_ORDERS_ADD, data: json,
        successCallBack: (data, msg) {
          completer.complete(ResultBean(data, msg));
        }, errorCallBack: (code, msg) {
          completer.completeError(ResultBean(code, msg));
        });
    return completer.future;
  }

  /// 退单详情
  static Future<ResultBean> refundOrderDetail(dynamic refundId){
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.REFUND_ORDERS_DETAIL + refundId,
        successCallBack: (data, msg) {
          List responseJson = json.decode(data);
          List<RefundOrderItemModel> refundItemList =
          responseJson.map((m) => RefundOrderItemModel.fromJson(m)).toList();
          completer.complete(ResultBean(refundItemList, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }


  /// 版本更新
  /// 获取最新的app版本
  static Future<ResultBean> getVersionInfo(Map<String, dynamic> params){
    Completer<ResultBean> completer = Completer();
    RemoteRepo.inst.httpRequest.get(Api.VERSION_BASE_URL + Api.APP_VERSION_INFO, queryParameters: params,
        successCallBack: (data, msg) {
          Map map = json.decode(data);
          VersionInfoModel versionInfoModel =
          VersionInfoModel.fromJson(map);
          completer.complete(ResultBean(versionInfoModel, msg));
        }, errorCallBack: (code, msg) {
      completer.completeError(ResultBean(code, msg));
    });
    return completer.future;
  }

}
