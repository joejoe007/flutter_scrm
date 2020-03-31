class AddRefundOrderModel {
  dynamic operator;
  dynamic cardCustomerInfoId;
  dynamic orderId;
  dynamic payWay;
  List<RefundOrdersDetail> refundOrdersDetails;
  dynamic remark;

  AddRefundOrderModel(
      {this.operator,
      this.cardCustomerInfoId,
      this.orderId,
      this.payWay,
      this.refundOrdersDetails,
      this.remark});

  factory AddRefundOrderModel.fromJson(Map<String, dynamic> json) {
    return AddRefundOrderModel(
      operator: json['operator'],
      cardCustomerInfoId: json['cardCustomerInfoId'],
      orderId: json['orderId'],
      payWay: json['payWay'],
      refundOrdersDetails: json['refundOrdersDetails'] != null
          ? (json['refundOrdersDetails'] as List)
              .map((i) => RefundOrdersDetail.fromJson(i))
              .toList()
          : null,
      remark: json['remark'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['operator'] = this.operator;
    data['cardCustomerInfoId'] = this.cardCustomerInfoId;
    data['orderId'] = this.orderId;
    data['payWay'] = this.payWay;
    data['remark'] = this.remark;
    if (this.refundOrdersDetails != null) {
      data['refundOrdersDetails'] =
          this.refundOrdersDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RefundOrdersDetail {
  dynamic buyAmount;
  dynamic buyPrice;
  dynamic itemId;
  dynamic refundAmount;
  dynamic refundPrice;

  RefundOrdersDetail(
      {this.buyAmount,
      this.buyPrice,
      this.itemId,
      this.refundAmount,
      this.refundPrice});

  factory RefundOrdersDetail.fromJson(Map<String, dynamic> json) {
    return RefundOrdersDetail(
      buyAmount: json['buyAmount'],
      buyPrice: json['buyPrice'],
      itemId: json['itemId'],
      refundAmount: json['refundAmount'],
      refundPrice: json['refundPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyAmount'] = this.buyAmount;
    data['buyPrice'] = this.buyPrice;
    data['itemId'] = this.itemId;
    data['refundAmount'] = this.refundAmount;
    data['refundPrice'] = this.refundPrice;
    return data;
  }
}
