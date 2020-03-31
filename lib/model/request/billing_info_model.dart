/// 新增订单
class BillingInfoModel {
  dynamic channel;
  CustomerInfo customerInfo;
  dynamic keyCard;
  List<OrderDetail> orderDetails;

  BillingInfoModel(
      {this.channel, this.customerInfo, this.keyCard, this.orderDetails});

  factory BillingInfoModel.fromJson(Map<String, dynamic> json) {
    return BillingInfoModel(
      channel: json['channel'],
      customerInfo: json['customerInfo'] != null
          ? CustomerInfo.fromJson(json['customerInfo'])
          : null,
      keyCard: json['keyCard'],
      orderDetails: json['orderDetails'] != null
          ? (json['orderDetails'] as List)
              .map((i) => OrderDetail.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel'] = this.channel;
    data['keyCard'] = this.keyCard;
    if (this.customerInfo != null) {
      data['customerInfo'] = this.customerInfo.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerInfo {
  dynamic carBrandId;
  dynamic carModelId;
  dynamic carNo;
  dynamic carSeriesId;
  dynamic id;
  dynamic insuranceExpireTime;
  dynamic kilometers;
  dynamic name;
  dynamic nextMaintainMileage;
  dynamic nextMaintainTime;
  dynamic remark;
  dynamic telNo;

  CustomerInfo(
      {this.carBrandId,
      this.carModelId,
      this.carNo,
      this.carSeriesId,
      this.id,
      this.insuranceExpireTime,
      this.kilometers,
      this.name,
      this.nextMaintainMileage,
      this.nextMaintainTime,
      this.remark,
      this.telNo});

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      carBrandId: json['carBrandId'],
      carModelId: json['carModelId'],
      carNo: json['carNo'],
      carSeriesId: json['carSeriesId'],
      id: json['id'],
      insuranceExpireTime: json['insuranceExpireTime'],
      kilometers: json['kilometers'],
      name: json['name'],
      nextMaintainMileage: json['nextMaintainMileage'],
      nextMaintainTime: json['nextMaintainTime'],
      remark: json['remark'],
      telNo: json['telNo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carBrandId'] = this.carBrandId;
    data['carModelId'] = this.carModelId;
    data['carNo'] = this.carNo;
    data['carSeriesId'] = this.carSeriesId;
    data['id'] = this.id;
    data['insuranceExpireTime'] = this.insuranceExpireTime;
    data['kilometers'] = this.kilometers;
    data['name'] = this.name;
    data['nextMaintainMileage'] = this.nextMaintainMileage;
    data['nextMaintainTime'] = this.nextMaintainTime;
    data['remark'] = this.remark;
    data['telNo'] = this.telNo;
    return data;
  }
}

class OrderDetail {
  dynamic amount;
  dynamic categoryId;
  dynamic createTime;
  dynamic discount;
  dynamic itemId;
  dynamic name;
  dynamic price;
  dynamic rework;
  dynamic saleIds;
  dynamic workStatus;
  dynamic workerIds;

  OrderDetail(
      {this.amount,
      this.categoryId,
      this.createTime,
      this.discount,
      this.itemId,
      this.name,
      this.price,
      this.rework,
      this.saleIds,
      this.workStatus,
      this.workerIds});

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      amount: json['amount'],
      categoryId: json['categoryId'],
      createTime: json['createTime'],
      discount: json['discount'],
      itemId: json['itemId'],
      name: json['name'],
      price: json['price'],
      rework: json['rework'],
      saleIds: json['saleIds'],
      workStatus: json['workStatus'],
      workerIds: json['workerIds'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['categoryId'] = this.categoryId;
    data['createTime'] = this.createTime;
    data['discount'] = this.discount;
    data['itemId'] = this.itemId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['rework'] = this.rework;
    data['saleIds'] = this.saleIds;
    data['workStatus'] = this.workStatus;
    data['workerIds'] = this.workerIds;
    return data;
  }
}

/// 修改订单
class UpdateOrderInfoModel {
  CustomerInfo customerInfo;
  dynamic id;
  dynamic keyCard;
  List<OrderDetail> orderDetails;

  UpdateOrderInfoModel(
      {this.customerInfo, this.id, this.keyCard, this.orderDetails});

  factory UpdateOrderInfoModel.fromJson(Map<String, dynamic> json) {
    return UpdateOrderInfoModel(
      customerInfo: json['customerInfo'] != null
          ? CustomerInfo.fromJson(json['customerInfo'])
          : null,
      id: json['id'],
      keyCard: json['keyCard'],
      orderDetails: json['orderDetails'] != null
          ? (json['orderDetails'] as List)
              .map((i) => OrderDetail.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keyCard'] = this.keyCard;
    if (this.customerInfo != null) {
      data['customerInfo'] = this.customerInfo.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// 订单结算
class OrderSettlementModel {
  List<CardInfo> cardInfos;
  dynamic couponId;
  dynamic couponMoney;
  dynamic customerId;
  dynamic discountsMoney;
  int orderId;
  dynamic payStatus;
  dynamic payWay;
  dynamic remark;
  dynamic sendMsg;

  OrderSettlementModel(
      {this.cardInfos,
      this.couponId,
      this.couponMoney,
      this.customerId,
      this.discountsMoney,
      this.orderId,
      this.payStatus,
      this.payWay,
      this.remark,
      this.sendMsg});

  factory OrderSettlementModel.fromJson(Map<String, dynamic> json) {
    return OrderSettlementModel(
      cardInfos: json['cardInfos'] != null
          ? (json['cardInfos'] as List)
              .map((i) => CardInfo.fromJson(i))
              .toList()
          : null,
      couponId: json['couponId'],
      couponMoney: json['couponMoney'],
      customerId: json['customerId'],
      discountsMoney: json['discountsMoney'],
      orderId: json['orderId'],
      payStatus: json['payStatus'],
      payWay: json['payWay'],
      remark: json['remark'],
      sendMsg: json['sendMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponId'] = this.couponId;
    data['couponMoney'] = this.couponMoney;
    data['customerId'] = this.customerId;
    data['discountsMoney'] = this.discountsMoney;
    data['orderId'] = this.orderId;
    data['payStatus'] = this.payStatus;
    data['payWay'] = this.payWay;
    data['remark'] = this.remark;
    data['sendMsg'] = this.sendMsg;
    if (this.cardInfos != null) {
      data['cardInfos'] = this.cardInfos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardInfo {
  dynamic amount;
  dynamic cardCustomerInfoId;
  dynamic itemId;
  dynamic type;

  CardInfo({this.amount, this.cardCustomerInfoId, this.itemId, this.type});

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      amount: json['amount'],
      cardCustomerInfoId: json['cardCustomerInfoId'],
      itemId: json['itemId'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['cardCustomerInfoId'] = this.cardCustomerInfoId;
    data['itemId'] = this.itemId;
    data['type'] = this.type;
    return data;
  }
}

/// 预付
class OrderSettlementRepayModel {
  int orderId;
  dynamic payWay;
  dynamic prepayMoney;

  OrderSettlementRepayModel({this.orderId, this.payWay, this.prepayMoney});

  factory OrderSettlementRepayModel.fromJson(Map<String, dynamic> json) {
    return OrderSettlementRepayModel(
      orderId: json['orderId'],
      payWay: json['payWay'],
      prepayMoney: json['prepayMoney'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['payWay'] = this.payWay;
    data['prepayMoney'] = this.prepayMoney;
    return data;
  }
}
