/// 列表item
class AccountNeedListItemModel {
  dynamic carNo;
  dynamic creditMoneyTotal;
  dynamic customerId;
  dynamic customerName;
  dynamic mobile;
  dynamic paybackMoneyTotal;

  AccountNeedListItemModel(
      {this.carNo,
      this.creditMoneyTotal,
      this.customerId,
      this.customerName,
      this.mobile,
      this.paybackMoneyTotal});

  factory AccountNeedListItemModel.fromJson(Map<String, dynamic> json) {
    return AccountNeedListItemModel(
      carNo: json['carNo'],
      creditMoneyTotal: json['creditMoneyTotal'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      mobile: json['mobile'],
      paybackMoneyTotal: json['paybackMoneyTotal'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carNo'] = this.carNo;
    data['creditMoneyTotal'] = this.creditMoneyTotal;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['mobile'] = this.mobile;
    data['paybackMoneyTotal'] = this.paybackMoneyTotal;
    return data;
  }
}

/// 总欠款
class AccountTotalModel {
  dynamic customerNum;
  dynamic needPayMoney;

  AccountTotalModel({this.customerNum, this.needPayMoney});

  factory AccountTotalModel.fromJson(Map<String, dynamic> json) {
    return AccountTotalModel(
      customerNum: json['customerNum'],
      needPayMoney: json['needPayMoney'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerNum'] = this.customerNum;
    data['needPayMoney'] = this.needPayMoney;
    return data;
  }
}

/// 个人欠款的列表
class AccountConsumeItemModel {
  dynamic creditMoney;
  dynamic customerId;
  dynamic customerName;
  dynamic discountsMoney;
  dynamic mobile;
  dynamic orderId;
  dynamic orderNo;
  dynamic orderTime;
  dynamic paybackMoney;
  dynamic paybackTime;
  dynamic carNo;
  dynamic itemNames;
  bool check = false;

  AccountConsumeItemModel(
      {this.creditMoney,
      this.customerId,
      this.customerName,
      this.discountsMoney,
      this.mobile,
      this.orderId,
      this.orderNo,
      this.orderTime,
      this.paybackMoney,
      this.carNo,
      this.itemNames,
      this.paybackTime});

  factory AccountConsumeItemModel.fromJson(Map<String, dynamic> json) {
    return AccountConsumeItemModel(
      creditMoney: json['creditMoney'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      discountsMoney: json['discountsMoney'],
      mobile: json['mobile'],
      orderId: json['orderId'],
      orderNo: json['orderNo'],
      orderTime: json['orderTime'],
      paybackMoney: json['paybackMoney'],
      carNo: json['carNo'],
      itemNames: json['itemNames'],
      paybackTime: json['paybackTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creditMoney'] = this.creditMoney;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['discountsMoney'] = this.discountsMoney;
    data['mobile'] = this.mobile;
    data['orderId'] = this.orderId;
    data['orderNo'] = this.orderNo;
    data['orderTime'] = this.orderTime;
    data['paybackMoney'] = this.paybackMoney;
    data['carNo'] = this.carNo;
    data['itemNames'] = this.itemNames;
    data['paybackTime'] = this.paybackTime;
    return data;
  }
}
