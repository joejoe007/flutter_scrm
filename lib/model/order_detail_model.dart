/// 订单详情基础信息
class OrderDetailModel {
  dynamic cancelManName;
  dynamic cancelTime;
  dynamic carNo;
  dynamic channel;
  dynamic createManName;
  dynamic createTime;
  dynamic creator;
  dynamic customerId;
  dynamic id;
  dynamic itemNames;
  dynamic keyCard;
  dynamic kilometers;
  dynamic nextMaintainMileage;
  dynamic nextMaintainTime;
  dynamic orderNo;
  dynamic orderType;
  dynamic payStatus;
  dynamic refundManName;
  dynamic refundOrderNo;
  dynamic refundId;
  dynamic refundTime;
  dynamic remark;
  dynamic settleManName;
  dynamic settleTime;
  dynamic status;
  dynamic storeId;
  dynamic updateTime;

  OrderDetailModel(
      {this.cancelManName,
      this.cancelTime,
      this.carNo,
      this.channel,
      this.createManName,
      this.createTime,
      this.creator,
      this.customerId,
      this.id,
      this.itemNames,
      this.keyCard,
      this.kilometers,
      this.nextMaintainMileage,
      this.nextMaintainTime,
      this.orderNo,
      this.orderType,
      this.payStatus,
      this.refundManName,
      this.refundOrderNo,
      this.refundId,
      this.refundTime,
      this.remark,
      this.settleManName,
      this.settleTime,
      this.status,
      this.storeId,
      this.updateTime});

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      cancelManName: json['cancelManName'],
      cancelTime: json['cancelTime'],
      carNo: json['carNo'],
      channel: json['channel'],
      createManName: json['createManName'],
      createTime: json['createTime'],
      creator: json['creator'],
      customerId: json['customerId'],
      id: json['id'],
      itemNames: json['itemNames'],
      keyCard: json['keyCard'],
      kilometers: json['kilometers'],
      nextMaintainMileage: json['nextMaintainMileage'],
      nextMaintainTime: json['nextMaintainTime'],
      orderNo: json['orderNo'],
      orderType: json['orderType'],
      payStatus: json['payStatus'],
      refundManName: json['refundManName'],
      refundOrderNo: json['refundOrderNo'],
      refundId: json['refundId'],
      refundTime: json['refundTime'],
      remark: json['remark'],
      settleManName: json['settleManName'],
      settleTime: json['settleTime'],
      status: json['status'],
      storeId: json['storeId'],
      updateTime: json['updateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cancelManName'] = this.cancelManName;
    data['cancelTime'] = this.cancelTime;
    data['carNo'] = this.carNo;
    data['channel'] = this.channel;
    data['createManName'] = this.createManName;
    data['createTime'] = this.createTime;
    data['creator'] = this.creator;
    data['customerId'] = this.customerId;
    data['id'] = this.id;
    data['itemNames'] = this.itemNames;
    data['keyCard'] = this.keyCard;
    data['kilometers'] = this.kilometers;
    data['nextMaintainMileage'] = this.nextMaintainMileage;
    data['nextMaintainTime'] = this.nextMaintainTime;
    data['orderNo'] = this.orderNo;
    data['orderType'] = this.orderType;
    data['payStatus'] = this.payStatus;
    data['refundManName'] = this.refundManName;
    data['refundOrderNo'] = this.refundOrderNo;
    data['refundId'] = this.refundId;
    data['refundTime'] = this.refundTime;
    data['remark'] = this.remark;
    data['settleManName'] = this.settleManName;
    data['settleTime'] = this.settleTime;
    data['status'] = this.status;
    data['storeId'] = this.storeId;
    data['updateTime'] = this.updateTime;
    return data;
  }
}

/// 订单单项信息
class OrderItemInfoModel {
  dynamic amount;
  dynamic cardName;
  dynamic categoryId;
  dynamic categoryName;
  dynamic createTime;
  dynamic discount;
  dynamic id;
  dynamic itemId;
  dynamic itemName;
  dynamic money;
  dynamic orderId;
  dynamic parentStoreId;
  dynamic price;
  dynamic rework;
  dynamic saleIds;
  dynamic saleNames;
  dynamic status;
  dynamic storeId;
  dynamic total;
  dynamic type;
  dynamic workStatus;
  dynamic workerIds;
  dynamic workerNames;

  OrderItemInfoModel(
      {this.amount,
      this.cardName,
      this.categoryId,
      this.categoryName,
      this.createTime,
      this.discount,
      this.id,
      this.itemId,
      this.itemName,
      this.money,
      this.orderId,
      this.parentStoreId,
      this.price,
      this.rework,
      this.saleIds,
      this.saleNames,
      this.status,
      this.storeId,
      this.total,
      this.type,
      this.workStatus,
      this.workerIds,
      this.workerNames});

  factory OrderItemInfoModel.fromJson(Map<String, dynamic> json) {
    return OrderItemInfoModel(
      amount: json['amount'],
      cardName: json['cardName'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      createTime: json['createTime'],
      discount: json['discount'],
      id: json['id'],
      itemId: json['itemId'],
      itemName: json['itemName'],
      money: json['money'],
      orderId: json['orderId'],
      parentStoreId: json['parentStoreId'],
      price: json['price'],
      rework: json['rework'],
      saleIds: json['saleIds'],
      saleNames: json['saleNames'],
      status: json['status'],
      storeId: json['storeId'],
      total: json['total'],
      type: json['type'],
      workStatus: json['workStatus'],
      workerIds: json['workerIds'],
      workerNames: json['workerNames'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['cardName'] = this.cardName;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['createTime'] = this.createTime;
    data['discount'] = this.discount;
    data['id'] = this.id;
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['money'] = this.money;
    data['orderId'] = this.orderId;
    data['parentStoreId'] = this.parentStoreId;
    data['price'] = this.price;
    data['rework'] = this.rework;
    data['saleIds'] = this.saleIds;
    data['saleNames'] = this.saleNames;
    data['status'] = this.status;
    data['storeId'] = this.storeId;
    data['total'] = this.total;
    data['type'] = this.type;
    data['workStatus'] = this.workStatus;
    data['workerIds'] = this.workerIds;
    data['workerNames'] = this.workerNames;
    return data;
  }
}

/// 订单详情结算信息
class OrderSettlementDetailModel {
  dynamic actualPay;
  dynamic actualPayWay;
  dynamic alipayMoney;
  dynamic balanceMoney;
  dynamic cardCustomerId;
  dynamic cardItemMoney;
  dynamic cashMoney;
  dynamic change;
  dynamic couponMoney;
  dynamic createTime;
  List<Detail> details;
  dynamic discountsMoney;
  dynamic id;
  dynamic orderId;
  dynamic orderMoney;
  dynamic orderNo;
  dynamic orderType;
  dynamic payStatus;
  dynamic prepayMoney;
  dynamic prepayWay;
  dynamic refundBalanceMoney;
  dynamic refundCardItemMoney;
  dynamic refundMoney;
  dynamic remark;
  dynamic sendMsg;
  dynamic shouldPay;
  dynamic storeId;
  dynamic unionMoney;
  dynamic wechatMoney;

  OrderSettlementDetailModel(
      {this.actualPay,
      this.actualPayWay,
      this.alipayMoney,
      this.balanceMoney,
      this.cardCustomerId,
      this.cardItemMoney,
      this.cashMoney,
      this.change,
      this.couponMoney,
      this.createTime,
      this.details,
      this.discountsMoney,
      this.id,
      this.orderId,
      this.orderMoney,
      this.orderNo,
      this.orderType,
      this.payStatus,
      this.prepayMoney,
      this.prepayWay,
      this.refundBalanceMoney,
      this.refundCardItemMoney,
      this.refundMoney,
      this.remark,
      this.sendMsg,
      this.shouldPay,
      this.storeId,
      this.unionMoney,
      this.wechatMoney});

  factory OrderSettlementDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderSettlementDetailModel(
      actualPay: json['actualPay'],
      actualPayWay: json['actualPayWay'],
      alipayMoney: json['alipayMoney'],
      balanceMoney: json['balanceMoney'],
      cardCustomerId: json['cardCustomerId'],
      cardItemMoney: json['cardItemMoney'],
      cashMoney: json['cashMoney'],
      change: json['change'],
      couponMoney: json['couponMoney'],
      createTime: json['createTime'],
      details: json['details'] != null && json['details'] != ''
          ? (json['details'] as List).map((i) => Detail.fromJson(i)).toList()
          : null,
      discountsMoney: json['discountsMoney'],
      id: json['id'],
      orderId: json['orderId'],
      orderMoney: json['orderMoney'],
      orderNo: json['orderNo'],
      orderType: json['orderType'],
      payStatus: json['payStatus'],
      prepayMoney: json['prepayMoney'],
      prepayWay: json['prepayWay'],
      refundBalanceMoney: json['refundBalanceMoney'],
      refundCardItemMoney: json['refundCardItemMoney'],
      refundMoney: json['refundMoney'],
      remark: json['remark'],
      sendMsg: json['sendMsg'],
      shouldPay: json['shouldPay'],
      storeId: json['storeId'],
      unionMoney: json['unionMoney'],
      wechatMoney: json['wechatMoney'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actualPay'] = this.actualPay;
    data['actualPayWay'] = this.actualPayWay;
    data['alipayMoney'] = this.alipayMoney;
    data['balanceMoney'] = this.balanceMoney;
    data['cardCustomerId'] = this.cardCustomerId;
    data['cardItemMoney'] = this.cardItemMoney;
    data['cashMoney'] = this.cashMoney;
    data['change'] = this.change;
    data['couponMoney'] = this.couponMoney;
    data['createTime'] = this.createTime;
    data['discountsMoney'] = this.discountsMoney;
    data['id'] = this.id;
    data['orderId'] = this.orderId;
    data['orderMoney'] = this.orderMoney;
    data['orderNo'] = this.orderNo;
    data['orderType'] = this.orderType;
    data['payStatus'] = this.payStatus;
    data['prepayMoney'] = this.prepayMoney;
    data['prepayWay'] = this.prepayWay;
    data['refundBalanceMoney'] = this.refundBalanceMoney;
    data['refundCardItemMoney'] = this.refundCardItemMoney;
    data['refundMoney'] = this.refundMoney;
    data['remark'] = this.remark;
    data['sendMsg'] = this.sendMsg;
    data['shouldPay'] = this.shouldPay;
    data['storeId'] = this.storeId;
    data['unionMoney'] = this.unionMoney;
    data['wechatMoney'] = this.wechatMoney;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  dynamic cardName;
  dynamic couponName;
  dynamic money;
  dynamic payWay;
  dynamic type;

  Detail({this.cardName, this.couponName, this.money, this.payWay, this.type});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      cardName: json['cardName'],
      couponName: json['couponName'],
      money: json['money'],
      payWay: json['payWay'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardName'] = this.cardName;
    data['couponName'] = this.couponName;
    data['money'] = this.money;
    data['payWay'] = this.payWay;
    data['type'] = this.type;
    return data;
  }
}

/// 消费记录item
class RecentOrderItemModel {
  dynamic createTime;
  dynamic id;
  dynamic itemNames;
  dynamic orderNo;
  dynamic userName;
  bool choose = false;

  RecentOrderItemModel(
      {this.createTime, this.id, this.itemNames, this.orderNo, this.userName});

  factory RecentOrderItemModel.fromJson(Map<String, dynamic> json) {
    return RecentOrderItemModel(
      createTime: json['createTime'],
      id: json['id'],
      itemNames: json['itemNames'],
      orderNo: json['orderNo'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['itemNames'] = this.itemNames;
    data['orderNo'] = this.orderNo;
    data['userName'] = this.userName;
    return data;
  }
}

/// 退单详情
class RefundOrderItemModel {
    dynamic id;
    dynamic itemId;
    dynamic itemName;
    dynamic refundAmount;
    dynamic refundPrice;

    RefundOrderItemModel({this.id, this.itemId, this.itemName, this.refundAmount, this.refundPrice});

    factory RefundOrderItemModel.fromJson(Map<String, dynamic> json) {
        return RefundOrderItemModel(
            id: json['id'],
            itemId: json['itemId'],
            itemName: json['itemName'],
            refundAmount: json['refundAmount'],
            refundPrice: json['refundPrice'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['itemId'] = this.itemId;
        data['itemName'] = this.itemName;
        data['refundAmount'] = this.refundAmount;
        data['refundPrice'] = this.refundPrice;
        return data;
    }
}
