/// 客户列表
/// CustomListCarModel
class CustomerInfoModel {
  List<CustomListCarModel> cars;
  dynamic consumePriceTotal;
  dynamic customerType;
  dynamic id;
  dynamic name;
  dynamic mobile;
  dynamic carNos;

  CustomerInfoModel(
      {this.cars,
      this.consumePriceTotal,
      this.customerType,
      this.id,
      this.name,
      this.mobile,
      this.carNos});

  factory CustomerInfoModel.fromJson(Map<String, dynamic> json) {
    return CustomerInfoModel(
      cars: json['cars'] != null
          ? (json['cars'] as List)
              .map((i) => CustomListCarModel.fromJson(i))
              .toList()
          : null,
      consumePriceTotal: json['consumePriceTotal'],
      customerType: json['customerType'],
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consumePriceTotal'] = this.consumePriceTotal;
    data['customerType'] = this.customerType;
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    if (this.cars != null) {
      data['cars'] = this.cars.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// 客户数量信息
class CustomerNumInfoModel {
  dynamic count;
  dynamic memberCount;

  CustomerNumInfoModel({this.count = 0, this.memberCount = 0});

  factory CustomerNumInfoModel.fromJson(Map<String, dynamic> json) {
    return CustomerNumInfoModel(
      count: json['count'],
      memberCount: json['memberCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['memberCount'] = this.memberCount;
    return data;
  }
}

/// 客户列表车辆信息
class CustomListCarModel {
  dynamic brandId;
  dynamic brandName;
  dynamic carNo;
  dynamic color;
  dynamic consumeCount;
  dynamic consumePrice;
  dynamic insuranceExpireTime;
  dynamic kilometers;
  dynamic lastConsumeTime;
  dynamic modelId;
  dynamic modelName;
  dynamic nextMaintainMileage;
  dynamic nextMaintainTime;
  dynamic price;
  dynamic seriesId;
  dynamic seriesModel;
  dynamic seriesName;

  CustomListCarModel(
      {this.brandId,
      this.brandName,
      this.carNo,
      this.color,
      this.consumeCount,
      this.consumePrice,
      this.insuranceExpireTime,
      this.kilometers,
      this.lastConsumeTime,
      this.modelId,
      this.modelName,
      this.nextMaintainMileage,
      this.nextMaintainTime,
      this.price,
      this.seriesId,
      this.seriesModel,
      this.seriesName});

  factory CustomListCarModel.fromJson(Map<String, dynamic> json) {
    return CustomListCarModel(
      brandId: json['brandId'],
      brandName: json['brandName'],
      carNo: json['carNo'],
      color: json['color'],
      consumeCount: json['consumeCount'],
      consumePrice: json['consumePrice'],
      insuranceExpireTime: json['insuranceExpireTime'],
      kilometers: json['kilometers'],
      lastConsumeTime: json['lastConsumeTime'],
      modelId: json['modelId'],
      modelName: json['modelName'],
      nextMaintainMileage: json['nextMaintainMileage'],
      nextMaintainTime: json['nextMaintainTime'],
      price: json['price'],
      seriesId: json['seriesId'],
      seriesModel: json['seriesModel'],
      seriesName: json['seriesName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['carNo'] = this.carNo;
    data['color'] = this.color;
    data['consumeCount'] = this.consumeCount;
    data['consumePrice'] = this.consumePrice;
    data['insuranceExpireTime'] = this.insuranceExpireTime;
    data['kilometers'] = this.kilometers;
    data['lastConsumeTime'] = this.lastConsumeTime;
    data['modelId'] = this.modelId;
    data['modelName'] = this.modelName;
    data['nextMaintainMileage'] = this.nextMaintainMileage;
    data['nextMaintainTime'] = this.nextMaintainTime;
    data['price'] = this.price;
    data['seriesId'] = this.seriesId;
    data['seriesModel'] = this.seriesModel;
    data['seriesName'] = this.seriesName;
    return data;
  }
}

/// 客户详情
class CustomDetailModel {
  dynamic birthday;
  List<CustomDetailCarModel> cars;
  dynamic company;
  dynamic mobile;
  dynamic name;
  dynamic remark;
  dynamic sex;
  dynamic customerType;

  CustomDetailModel(
      {this.birthday,
      this.cars,
      this.company,
      this.mobile,
      this.name,
      this.remark,
      this.sex,
      this.customerType});

  factory CustomDetailModel.fromJson(Map<String, dynamic> json) {
    return CustomDetailModel(
      birthday: json['birthday'],
      cars: json['cars'] != null
          ? (json['cars'] as List)
              .map((i) => CustomDetailCarModel.fromJson(i))
              .toList()
          : null,
      company: json['company'],
      mobile: json['mobile'],
      name: json['name'],
      remark: json['remark'],
      sex: json['sex'],
      customerType: json['customerType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthday'] = this.birthday;
    data['company'] = this.company;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['sex'] = this.sex;
    data['customerType'] = this.customerType;
    if (this.cars != null) {
      data['cars'] = this.cars.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// 客户详情的车辆信息
class CustomDetailCarModel {
  String annualExpireTime;
  String carBrandId;
  String carBrandName;
  String carColor;
  String carLogo;
  String carModelId;
  String carModelName;
  String carNo;
  String carSeriesId;
  String carSeriesName;
  String engineNo;
  String id;
  String insuranceExpireTime;
  dynamic kilometers;
  dynamic nextMaintainMileage;
  String nextMaintainTime;
  dynamic ownType;
  String vin;

  CustomDetailCarModel(
      {this.annualExpireTime,
      this.carBrandId,
      this.carBrandName,
      this.carColor,
      this.carLogo,
      this.carModelId,
      this.carModelName,
      this.carNo,
      this.carSeriesId,
      this.carSeriesName,
      this.engineNo,
      this.id,
      this.insuranceExpireTime,
      this.kilometers,
      this.nextMaintainMileage,
      this.nextMaintainTime,
      this.ownType,
      this.vin});

  factory CustomDetailCarModel.fromJson(Map<String, dynamic> json) {
    return CustomDetailCarModel(
      annualExpireTime: json['annualExpireTime'],
      carBrandId: json['carBrandId'],
      carBrandName: json['carBrandName'],
      carColor: json['carColor'],
      carLogo: json['carLogo'],
      carModelId: json['carModelId'],
      carModelName: json['carModelName'],
      carNo: json['carNo'],
      carSeriesId: json['carSeriesId'],
      carSeriesName: json['carSeriesName'],
      engineNo: json['engineNo'],
      id: json['id'],
      insuranceExpireTime: json['insuranceExpireTime'],
      kilometers: json['kilometers'],
      nextMaintainMileage: json['nextMaintainMileage'],
      nextMaintainTime: json['nextMaintainTime'],
      ownType: json['ownType'],
      vin: json['vin'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['annualExpireTime'] = this.annualExpireTime;
    data['carBrandId'] = this.carBrandId;
    data['carBrandName'] = this.carBrandName;
    data['carColor'] = this.carColor;
    data['carLogo'] = this.carLogo;
    data['carModelId'] = this.carModelId;
    data['carModelName'] = this.carModelName;
    data['carNo'] = this.carNo;
    data['carSeriesId'] = this.carSeriesId;
    data['carSeriesName'] = this.carSeriesName;
    data['engineNo'] = this.engineNo;
    data['id'] = this.id;
    data['insuranceExpireTime'] = this.insuranceExpireTime;
    data['kilometers'] = this.kilometers;
    data['nextMaintainMileage'] = this.nextMaintainMileage;
    data['nextMaintainTime'] = this.nextMaintainTime;
    data['ownType'] = this.ownType;
    data['vin'] = this.vin;
    return data;
  }
}

/// 客户消费累计
class CustomerConsumeTotalModel {
  dynamic consumeCount;
  dynamic consumeMoney;
  dynamic hangingMoney;

  CustomerConsumeTotalModel(
      {this.consumeCount, this.consumeMoney, this.hangingMoney});

  factory CustomerConsumeTotalModel.fromJson(Map<String, dynamic> json) {
    return CustomerConsumeTotalModel(
      consumeCount: json['consumeCount'],
      consumeMoney: json['consumeMoney'],
      hangingMoney: json['hangingMoney'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consumeCount'] = this.consumeCount;
    data['consumeMoney'] = this.consumeMoney;
    data['hangingMoney'] = this.hangingMoney;
    return data;
  }
}

/// 车牌获取车辆信息
class CarInfoByCarNumModel {
  dynamic annualExpireTime;
  dynamic buyTime;
  dynamic carBrandId;
  dynamic carColor;
  dynamic carLicenseNo;
  dynamic carModelId;
  dynamic carNo;
  dynamic carSeriesId;
  dynamic createTime;
  dynamic customerId;
  dynamic deleteTime;
  dynamic engineNo;
  dynamic id;
  dynamic insuranceCompany;
  dynamic insuranceDate;
  dynamic insuranceExpireTime;
  dynamic kilometers;
  dynamic mobile;
  dynamic nextMaintainMileage;
  dynamic nextMaintainTime;
  dynamic ownName;
  dynamic ownType;
  dynamic preMaintainMileage;
  dynamic preMaintainTime;
  dynamic status;
  dynamic storeId;
  dynamic tireBrand;
  dynamic tireChangeTime;
  dynamic updateTime;
  dynamic vin;

  CarInfoByCarNumModel(
      {this.annualExpireTime,
      this.buyTime,
      this.carBrandId,
      this.carColor,
      this.carLicenseNo,
      this.carModelId,
      this.carNo,
      this.carSeriesId,
      this.createTime,
      this.customerId,
      this.deleteTime,
      this.engineNo,
      this.id,
      this.insuranceCompany,
      this.insuranceDate,
      this.insuranceExpireTime,
      this.kilometers,
      this.mobile,
      this.nextMaintainMileage,
      this.nextMaintainTime,
      this.ownName,
      this.ownType,
      this.preMaintainMileage,
      this.preMaintainTime,
      this.status,
      this.storeId,
      this.tireBrand,
      this.tireChangeTime,
      this.updateTime,
      this.vin});

  factory CarInfoByCarNumModel.fromJson(Map<String, dynamic> json) {
    return CarInfoByCarNumModel(
      annualExpireTime: json['annualExpireTime'],
      buyTime: json['buyTime'],
      carBrandId: json['carBrandId'],
      carColor: json['carColor'],
      carLicenseNo: json['carLicenseNo'],
      carModelId: json['carModelId'],
      carNo: json['carNo'],
      carSeriesId: json['carSeriesId'],
      createTime: json['createTime'],
      customerId: json['customerId'],
      deleteTime: json['deleteTime'],
      engineNo: json['engineNo'],
      id: json['id'],
      insuranceCompany: json['insuranceCompany'],
      insuranceDate: json['insuranceDate'],
      insuranceExpireTime: json['insuranceExpireTime'],
      kilometers: json['kilometers'],
      mobile: json['mobile'],
      nextMaintainMileage: json['nextMaintainMileage'],
      nextMaintainTime: json['nextMaintainTime'],
      ownName: json['ownName'],
      ownType: json['ownType'],
      preMaintainMileage: json['preMaintainMileage'],
      preMaintainTime: json['preMaintainTime'],
      status: json['status'],
      storeId: json['storeId'],
      tireBrand: json['tireBrand'],
      tireChangeTime: json['tireChangeTime'],
      updateTime: json['updateTime'],
      vin: json['vin'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['annualExpireTime'] = this.annualExpireTime;
    data['buyTime'] = this.buyTime;
    data['carBrandId'] = this.carBrandId;
    data['carColor'] = this.carColor;
    data['carLicenseNo'] = this.carLicenseNo;
    data['carModelId'] = this.carModelId;
    data['carNo'] = this.carNo;
    data['carSeriesId'] = this.carSeriesId;
    data['createTime'] = this.createTime;
    data['customerId'] = this.customerId;
    data['deleteTime'] = this.deleteTime;
    data['engineNo'] = this.engineNo;
    data['id'] = this.id;
    data['insuranceCompany'] = this.insuranceCompany;
    data['insuranceDate'] = this.insuranceDate;
    data['insuranceExpireTime'] = this.insuranceExpireTime;
    data['kilometers'] = this.kilometers;
    data['mobile'] = this.mobile;
    data['nextMaintainMileage'] = this.nextMaintainMileage;
    data['nextMaintainTime'] = this.nextMaintainTime;
    data['ownName'] = this.ownName;
    data['ownType'] = this.ownType;
    data['preMaintainMileage'] = this.preMaintainMileage;
    data['preMaintainTime'] = this.preMaintainTime;
    data['status'] = this.status;
    data['storeId'] = this.storeId;
    data['tireBrand'] = this.tireBrand;
    data['tireChangeTime'] = this.tireChangeTime;
    data['updateTime'] = this.updateTime;
    data['vin'] = this.vin;
    return data;
  }
}

/// 车辆列表item
class CarItemInfoModel {
  dynamic carBrandName;
  dynamic carModelName;
  dynamic carNo;
  dynamic carSeriesName;
  dynamic consumeCount;
  dynamic customerId;
  dynamic customerName;
  dynamic customerType;
  dynamic id;
  dynamic lastInTime;
  dynamic telNo;
  dynamic vin;
  dynamic year;

  CarItemInfoModel(
      {this.carBrandName,
      this.carModelName,
      this.carNo,
      this.carSeriesName,
      this.consumeCount,
      this.customerId,
      this.customerName,
      this.customerType,
      this.id,
      this.lastInTime,
      this.telNo,
      this.vin,
      this.year});

  factory CarItemInfoModel.fromJson(Map<String, dynamic> json) {
    return CarItemInfoModel(
      carBrandName: json['carBrandName'],
      carModelName: json['carModelName'],
      carNo: json['carNo'],
      carSeriesName: json['carSeriesName'],
      consumeCount: json['consumeCount'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerType: json['customerType'],
      id: json['id'],
      lastInTime: json['lastInTime'],
      telNo: json['telNo'],
      vin: json['vin'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carBrandName'] = this.carBrandName;
    data['carModelName'] = this.carModelName;
    data['carNo'] = this.carNo;
    data['carSeriesName'] = this.carSeriesName;
    data['consumeCount'] = this.consumeCount;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['customerType'] = this.customerType;
    data['id'] = this.id;
    data['lastInTime'] = this.lastInTime;
    data['telNo'] = this.telNo;
    data['vin'] = this.vin;
    data['year'] = this.year;
    return data;
  }
}
