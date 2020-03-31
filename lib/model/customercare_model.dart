class CustomerCareListModel {
  String alarmSwitch;
  dynamic alertStatus;
  dynamic autoSwitch;
  dynamic carId;
  String content;
  String customerCarNo;
  String customerId;
  String customerMobile;
  String customerName;
  String id;
  String sendEndTime;
  String sendStartTime;
  String sendTime;
  String storeId;
  dynamic templateId;
  String triggerEndTime;
  String triggerStartTime;
  String triggerTime;
  String typeName;
  bool isSelect; /// 自定义

  CustomerCareListModel(
      {this.alarmSwitch,
      this.alertStatus,
      this.autoSwitch,
      this.carId,
      this.content,
      this.customerCarNo,
      this.customerId,
      this.customerMobile,
      this.customerName,
      this.id,
      this.sendEndTime,
      this.sendStartTime,
      this.sendTime,
      this.storeId,
      this.templateId,
      this.triggerEndTime,
      this.triggerStartTime,
      this.triggerTime,
      this.typeName,
      this.isSelect = false});

  factory CustomerCareListModel.fromJson(Map<String, dynamic> json) {
    return CustomerCareListModel(
      alarmSwitch: json['alarmSwitch'],
      alertStatus: json['alertStatus'],
      autoSwitch: json['autoSwitch'],
      carId: json['carId'],
      content: json['content'],
      customerCarNo: json['customerCarNo'],
      customerId: json['customerId'],
      customerMobile: json['customerMobile'],
      customerName: json['customerName'],
      id: json['id'],
      sendEndTime: json['sendEndTime'],
      sendStartTime: json['sendStartTime'],
      sendTime: json['sendTime'],
      storeId: json['storeId'],
      templateId: json['templateId'],
      triggerEndTime: json['triggerEndTime'],
      triggerStartTime: json['triggerStartTime'],
      triggerTime: json['triggerTime'],
      typeName: json['typeName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alarmSwitch'] = this.alarmSwitch;
    data['alertStatus'] = this.alertStatus;
    data['autoSwitch'] = this.autoSwitch;
    data['carId'] = this.carId;
    data['content'] = this.content;
    data['customerCarNo'] = this.customerCarNo;
    data['customerId'] = this.customerId;
    data['customerMobile'] = this.customerMobile;
    data['customerName'] = this.customerName;
    data['id'] = this.id;
    data['sendEndTime'] = this.sendEndTime;
    data['sendStartTime'] = this.sendStartTime;
    data['sendTime'] = this.sendTime;
    data['storeId'] = this.storeId;
    data['templateId'] = this.templateId;
    data['triggerEndTime'] = this.triggerEndTime;
    data['triggerStartTime'] = this.triggerStartTime;
    data['triggerTime'] = this.triggerTime;
    data['typeName'] = this.typeName;
    return data;
  }
}
