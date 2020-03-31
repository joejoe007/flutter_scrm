import 'package:flutter_project1/util/string_util.dart';

/// 判断支付状态和订单状态
class OrderOperate {

  static List<operate> orderOperateState(dynamic payStatus, dynamic status, {dynamic orderType = 3}) {
    List<operate> operateList = [];
    if (int.parse(StringUtil.checkEmpty(orderType)) != 3) {
      return operateList;
    }
    switch (int.parse(StringUtil.checkEmpty(payStatus))) {
      case 0: // 未结算
        switch (int.parse(StringUtil.checkEmpty(status))) {
          case 0: // 预开单
            operateList.add(operate.pay);
            operateList.add(operate.edit);
            operateList.add(operate.cancel);
            break;
          case 2: // 施工完成
            break;
          case 4: // 撤单
            operateList.add(operate.showCancel);
            break;
          case 5: // 退单
            break;
        }
        break;
      case 1: // 挂账
        switch (int.parse(StringUtil.checkEmpty(status))) {
          case 0: // 预开单
            break;
          case 2: // 施工完成
            operateList.add(operate.pay);
            operateList.add(operate.cancel);
            break;
          case 4: // 撤单
            operateList.add(operate.showCancel);
            break;
          case 5: // 退单
            break;
        }
        break;
      case 4: // 已结算
        switch (int.parse(StringUtil.checkEmpty(status))) {
          case 0: // 预开单
            break;
          case 2: // 施工完成
            operateList.add(operate.cancel);
            operateList.add(operate.back);
            break;
          case 4: // 撤单
            operateList.add(operate.showCancel);
            break;
          case 5: // 退单
            operateList.add(operate.showBack);
            break;
        }
        break;
    }
    return operateList;
  }
}

enum operate{
  /// 操作权限
  pay,// 支付
  edit,// 修改
  cancel,// 撤销
  back,// 退回
  /// 显示权限
  showCancel,// 撤工单
  showBack,// 退工单
}

