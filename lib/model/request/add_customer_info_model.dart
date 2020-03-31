class AddCustomerInfoModel {
  String birthday;
  List<AddCustomerInfoCarModel> cars;
  String company;
  dynamic id;
  String name;
  String remark;
  int sex;
  String mobile;

  AddCustomerInfoModel(
      {this.birthday,
      this.cars,
      this.company,
      this.id,
      this.name,
      this.remark,
      this.sex,
      this.mobile});

  factory AddCustomerInfoModel.fromJson(Map<String, dynamic> json) {
    return AddCustomerInfoModel(
      birthday: json['birthday'],
      cars: json['cars'] != null
          ? (json['cars'] as List)
              .map((i) => AddCustomerInfoCarModel.fromJson(i))
              .toList()
          : null,
      company: json['company'],
      id: json['id'],
      name: json['name'],
      remark: json['remark'],
      sex: json['sex'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthday'] = this.birthday;
    data['company'] = this.company;
    data['id'] = this.id;
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['sex'] = this.sex;
    data['mobile'] = this.mobile;
    if (this.cars != null) {
      data['cars'] = this.cars.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddCustomerInfoCarModel {
  String annualExpireTime;
  dynamic carBrandId;
  String carColor;
  dynamic carModelId;
  String carNo;
  dynamic carSeriesId;
  dynamic customerId;
  String customerName;
  String engineNo;
  String insuranceExpireTime;
  dynamic kilometers;
  dynamic nextMaintainMileage;
  String nextMaintainTime;
  int ownType;
  String tel;
  String vin;

  AddCustomerInfoCarModel(
      {this.annualExpireTime,
      this.carBrandId,
      this.carColor,
      this.carModelId,
      this.carNo,
      this.carSeriesId,
      this.customerId,
      this.customerName,
      this.engineNo,
      this.insuranceExpireTime,
      this.kilometers,
      this.nextMaintainMileage,
      this.nextMaintainTime,
      this.ownType,
      this.tel,
      this.vin});

  factory AddCustomerInfoCarModel.fromJson(Map<String, dynamic> json) {
    return AddCustomerInfoCarModel(
      annualExpireTime: json['annualExpireTime'],
      carBrandId: json['carBrandId'],
      carColor: json['carColor'],
      carModelId: json['carModelId'],
      carNo: json['carNo'],
      carSeriesId: json['carSeriesId'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      engineNo: json['engineNo'],
      insuranceExpireTime: json['insuranceExpireTime'],
      kilometers: json['kilometers'],
      nextMaintainMileage: json['nextMaintainMileage'],
      nextMaintainTime: json['nextMaintainTime'],
      ownType: json['ownType'],
      tel: json['tel'],
      vin: json['vin'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['annualExpireTime'] = this.annualExpireTime;
    data['carBrandId'] = this.carBrandId;
    data['carColor'] = this.carColor;
    data['carModelId'] = this.carModelId;
    data['carNo'] = this.carNo;
    data['carSeriesId'] = this.carSeriesId;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['engineNo'] = this.engineNo;
    data['insuranceExpireTime'] = this.insuranceExpireTime;
    data['kilometers'] = this.kilometers;
    data['nextMaintainMileage'] = this.nextMaintainMileage;
    data['nextMaintainTime'] = this.nextMaintainTime;
    data['ownType'] = this.ownType;
    data['tel'] = this.tel;
    data['vin'] = this.vin;
    return data;
  }
}
