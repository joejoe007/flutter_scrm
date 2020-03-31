class CustomerCareSetModel {
  dynamic alarmSwitch;
  dynamic arguments;
  dynamic autoSwitch;
  String createTime;
  String id;
  String modifyTime;
  String storeId;
  String templateCode;
  dynamic templateId;
  String typeName;

  CustomerCareSetModel(
      {this.alarmSwitch,
      this.arguments,
      this.autoSwitch,
      this.createTime,
      this.id,
      this.modifyTime,
      this.storeId,
      this.templateCode,
      this.templateId,
      this.typeName});

  factory CustomerCareSetModel.fromJson(Map<String, dynamic> json) {
    return CustomerCareSetModel(
      alarmSwitch: json['alarmSwitch'],
      arguments: json['arguments'],
      autoSwitch: json['autoSwitch'],
      createTime: json['createTime'],
      id: json['id'],
      modifyTime: json['modifyTime'],
      storeId: json['storeId'],
      templateCode: json['templateCode'],
      templateId: json['templateId'],
      typeName: json['typeName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alarmSwitch'] = this.alarmSwitch;
    data['arguments'] = this.arguments;
    data['autoSwitch'] = this.autoSwitch;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['modifyTime'] = this.modifyTime;
    data['storeId'] = this.storeId;
    data['templateCode'] = this.templateCode;
    data['templateId'] = this.templateId;
    data['typeName'] = this.typeName;
    return data;
  }
}
