class SubmitAccountModel {
  dynamic customerId;
  dynamic discountsMoneyTotal;
  List<String> orderIds;
  dynamic payWay;
  dynamic paybackMoneyTotal;

  SubmitAccountModel(
      {this.customerId,
      this.discountsMoneyTotal,
      this.orderIds,
      this.payWay,
      this.paybackMoneyTotal});

  factory SubmitAccountModel.fromJson(Map<String, dynamic> json) {
    return SubmitAccountModel(
      customerId: json['customerId'],
      discountsMoneyTotal: json['discountsMoneyTotal'],
      orderIds: json['orderIds'] != null
          ? new List<String>.from(json['orderIds'])
          : null,
      payWay: json['payWay'],
      paybackMoneyTotal: json['paybackMoneyTotal'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['discountsMoneyTotal'] = this.discountsMoneyTotal;
    data['payWay'] = this.payWay;
    data['paybackMoneyTotal'] = this.paybackMoneyTotal;
    if (this.orderIds != null) {
      data['orderIds'] = this.orderIds;
    }
    return data;
  }
}
