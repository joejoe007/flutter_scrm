
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

class Constant {
  /// 是否是调试模式
  static final bool DEBUG = true;

  /// 数据库名称
  static final String DB_NAME = "scrm";

  /// 测试图片地址
  static final String TEST_IMAGE_URL =
      "https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png";

  /// vim code
  static final String VIN_APP_CODE = '1c434160297643ca9eb7f68479a13ece';

  /// pageSize
  static final int PAGE_SIZE = 10; // 默认十条
  static final int PAGE_SIZE_100 = 100; // 可以100条
  static final int PAGE_SIZE_1000 = 1000; // 可以1000条

  /// key
  static final String Token_key = 'token';
}

/// 性别
class SexType {
  static int boy = 1;
  static int girl = 2;
}

/// 会员
class Member{

  static final int MemberType = 1; // 会员
  static final int NoTMemberType = 2; // 非会员

  /// 判断是否是会员
  static bool boolMember(dynamic customerType) {
    bool isMember = false;
    if (null == customerType) return isMember;
    if (isEmpty(customerType.toString())) return isMember;
    return int.parse(customerType.toString()) == MemberType;
  }

}

/// 订单相关
class Order {

  /// 订单类型
  static String getOrderTypeName(dynamic orderType) {
    String orderTypeName = '';
    if(orderType == null) return orderTypeName;
    if(isEmpty(orderType.toString())) return orderTypeName;
    switch (int.parse(orderType.toString())) {
      case 2:
        orderTypeName = '会员卡售卡';
        break;
      case 3:
        orderTypeName = '项目订单';
        break;
      case 4:
        orderTypeName = '会员卡充值';
        break;
      case 5:
        orderTypeName = '会员卡退卡';
        break;
    }
    return orderTypeName;
  }

  /// 支付方式
  static String getPayWayName(dynamic payWay) {
    String payWayName = '';
    if(payWay == null) return payWayName;
    if(isEmpty(payWay.toString())) return payWayName;
    switch (int.parse(payWay.toString())) {
      case 1:
        payWayName = '微信';
        break;
      case 2:
        payWayName = '支付宝';
        break;
      case 3:
        payWayName = '现金';
        break;
      case 4:
        payWayName = '银联';
        break;
    }
    return payWayName;
  }

  /// 支付状态
  static String getPayStatusName(dynamic payStatus) {
    String payStatusName = '';
    if(payStatus == null) return payStatusName;
    if(isEmpty(payStatus.toString())) return payStatusName;
    switch (int.parse(payStatus.toString())) {
      case 0:
        payStatusName = '未结算';
        break;
      case 1:
        payStatusName = '挂账';
        break;
      case 4:
        payStatusName = '已结算';
        break;
    }
    return payStatusName;
  }

  /// 订单状态
  static String getOrderStatusName(dynamic status) {
    String payStatusName = '';
    if(status == null) return payStatusName;
    if(isEmpty(status.toString())) return payStatusName;
    switch (int.parse(status.toString())) {
      case 0:
        payStatusName = '预开单';
        break;
      case 1:
        payStatusName = '施工中';
        break;
      case 2:
        payStatusName = '施工完成';
        break;
      case 3:
        payStatusName = '订单完成';
        break;
      case 4:
        payStatusName = '撤单';
        break;
      case 5:
        payStatusName = '退单';
        break;
      case 8:
        payStatusName = '返工';
        break;
    }
    return payStatusName;
  }

}

class GlobalContext {
  /// 全局的context
  static BuildContext _context;

  static BuildContext get context {
    assert(null != _context);
    return _context;
  }

  static set setContext(BuildContext value) {
    _context = value;
  }
}
