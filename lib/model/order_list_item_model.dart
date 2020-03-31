class OrderItemModel {
  dynamic carNo;
  dynamic channel;
  dynamic createTime;
  dynamic creator;
  dynamic customerId;
  dynamic customerName;
  dynamic customerType;
  dynamic id;
  dynamic itemNames;
  dynamic mobile;
  dynamic orderMoney;
  dynamic orderNo;
  dynamic orderType;
  dynamic paidMoney;
  dynamic parentStoreId;
  dynamic payStatus;
  dynamic remark;
  dynamic settleTime;
  dynamic status;
  dynamic storeId;
  dynamic updateTime;

  OrderItemModel(
      {this.carNo,
      this.channel,
      this.createTime,
      this.creator,
      this.customerId,
      this.customerName,
      this.customerType,
      this.id,
      this.itemNames,
      this.mobile,
      this.orderMoney,
      this.orderNo,
      this.orderType,
      this.paidMoney,
      this.parentStoreId,
      this.payStatus,
      this.remark,
      this.settleTime,
      this.status,
      this.storeId,
      this.updateTime});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      carNo: json['carNo'],
      channel: json['channel'],
      createTime: json['createTime'],
      creator: json['creator'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerType: json['customerType'],
      id: json['id'],
      itemNames: json['itemNames'],
      mobile: json['mobile'],
      orderMoney: json['orderMoney'],
      orderNo: json['orderNo'],
      orderType: json['orderType'],
      paidMoney: json['paidMoney'],
      parentStoreId: json['parentStoreId'],
      payStatus: json['payStatus'],
      remark: json['remark'],
      settleTime: json['settleTime'],
      status: json['status'],
      storeId: json['storeId'],
      updateTime: json['updateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carNo'] = this.carNo;
    data['channel'] = this.channel;
    data['createTime'] = this.createTime;
    data['creator'] = this.creator;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['customerType'] = this.customerType;
    data['id'] = this.id;
    data['itemNames'] = this.itemNames;
    data['mobile'] = this.mobile;
    data['orderMoney'] = this.orderMoney;
    data['orderNo'] = this.orderNo;
    data['orderType'] = this.orderType;
    data['paidMoney'] = this.paidMoney;
    data['parentStoreId'] = this.parentStoreId;
    data['payStatus'] = this.payStatus;
    data['remark'] = this.remark;
    data['settleTime'] = this.settleTime;
    data['status'] = this.status;
    data['storeId'] = this.storeId;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
