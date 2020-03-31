import 'package:flutter_project1/page/main/home/customer/choosecar/az_common.dart';

/// 所有车的品牌
class CarTypeModel {
  List<BrandName> allList;
  List<BrandName> HOT;

  CarTypeModel({this.allList, this.HOT});

  factory CarTypeModel.fromJson(Map<String, dynamic> json) {
    return CarTypeModel(
      allList: json['allList'] != null
          ? (json['allList'] as List).map((i) => BrandName.fromJson(i)).toList()
          : null,
      HOT: json['HOT'] != null
          ? (json['HOT'] as List).map((i) => BrandName.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allList != null) {
      data['allList'] = this.allList.map((v) => v.toJson()).toList();
    }
    if (this.HOT != null) {
      data['HOT'] = this.HOT.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandName extends ISuspensionBean {
  String id;
  String isHot;
  String logo;
  String name;
  String remark;
  String status;
  String word;
  String tagIndex;
  String namePinyin;

  @override
  String getSuspensionTag() => tagIndex;

  BrandName(
      {this.id,
      this.isHot,
      this.logo,
      this.name,
      this.remark,
      this.status,
      this.tagIndex,
      this.namePinyin,
      this.word});

  factory BrandName.fromJson(Map<String, dynamic> json) {
    return BrandName(
      id: json['id'],
      isHot: json['isHot'],
      logo: json['logo'],
      name: json['name'],
      remark: json['remark'],
      status: json['status'],
      word: json['word'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isHot'] = this.isHot;
    data['logo'] = this.logo;
    data['name'] = this.name;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['word'] = this.word;
    return data;
  }
}

/// 根据品牌获取车系
class CarSeriesItemModel {
  dynamic carBrandId;
  dynamic id;
  dynamic name;
  dynamic producer;
  dynamic remark;
  dynamic status;

  CarSeriesItemModel(
      {this.carBrandId,
      this.id,
      this.name,
      this.producer,
      this.remark,
      this.status});

  factory CarSeriesItemModel.fromJson(Map<String, dynamic> json) {
    return CarSeriesItemModel(
      carBrandId: json['carBrandId'],
      id: json['id'],
      name: json['name'],
      producer: json['producer'],
      remark: json['remark'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carBrandId'] = this.carBrandId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['producer'] = this.producer;
    data['remark'] = this.remark;
    data['status'] = this.status;
    return data;
  }
}

/// 车辆型号
class CarModelItemModel {
  dynamic attribute;
  dynamic carBrandId;
  dynamic carSeriesId;
  dynamic cylinder;
  dynamic displacement;
  dynamic driverType;
  dynamic emission;
  dynamic enginerPlace;
  dynamic frontBrakeType;
  dynamic frontHubSpec;
  dynamic frontTyreSpec;
  dynamic gearbox;
  dynamic guidePrice;
  dynamic id;
  dynamic importType;
  dynamic intakeForm;
  dynamic modelYear;
  dynamic name;
  dynamic oilGrade;
  dynamic powerSteer;
  dynamic price;
  dynamic producer;
  dynamic rearBrakeType;
  dynamic rearHubSpec;
  dynamic rearTyreSpec;
  dynamic remark;
  dynamic status;
  dynamic tsy;
  dynamic ttm;
  dynamic tty;
  dynamic uniqueIndexed;

  CarModelItemModel(
      {this.attribute,
      this.carBrandId,
      this.carSeriesId,
      this.cylinder,
      this.displacement,
      this.driverType,
      this.emission,
      this.enginerPlace,
      this.frontBrakeType,
      this.frontHubSpec,
      this.frontTyreSpec,
      this.gearbox,
      this.guidePrice,
      this.id,
      this.importType,
      this.intakeForm,
      this.modelYear,
      this.name,
      this.oilGrade,
      this.powerSteer,
      this.price,
      this.producer,
      this.rearBrakeType,
      this.rearHubSpec,
      this.rearTyreSpec,
      this.remark,
      this.status,
      this.tsy,
      this.ttm,
      this.tty,
      this.uniqueIndexed});

  factory CarModelItemModel.fromJson(Map<String, dynamic> json) {
    return CarModelItemModel(
      attribute: json['attribute'],
      carBrandId: json['carBrandId'],
      carSeriesId: json['carSeriesId'],
      cylinder: json['cylinder'],
      displacement: json['displacement'],
      driverType: json['driverType'],
      emission: json['emission'],
      enginerPlace: json['enginerPlace'],
      frontBrakeType: json['frontBrakeType'],
      frontHubSpec: json['frontHubSpec'],
      frontTyreSpec: json['frontTyreSpec'],
      gearbox: json['gearbox'],
      guidePrice: json['guidePrice'],
      id: json['id'],
      importType: json['importType'],
      intakeForm: json['intakeForm'],
      modelYear: json['modelYear'],
      name: json['name'],
      oilGrade: json['oilGrade'],
      powerSteer: json['powerSteer'],
      price: json['price'],
      producer: json['producer'],
      rearBrakeType: json['rearBrakeType'],
      rearHubSpec: json['rearHubSpec'],
      rearTyreSpec: json['rearTyreSpec'],
      remark: json['remark'],
      status: json['status'],
      tsy: json['tsy'],
      ttm: json['ttm'],
      tty: json['tty'],
      uniqueIndexed: json['uniqueIndexed'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute'] = this.attribute;
    data['carBrandId'] = this.carBrandId;
    data['carSeriesId'] = this.carSeriesId;
    data['cylinder'] = this.cylinder;
    data['displacement'] = this.displacement;
    data['driverType'] = this.driverType;
    data['emission'] = this.emission;
    data['enginerPlace'] = this.enginerPlace;
    data['frontBrakeType'] = this.frontBrakeType;
    data['frontHubSpec'] = this.frontHubSpec;
    data['frontTyreSpec'] = this.frontTyreSpec;
    data['gearbox'] = this.gearbox;
    data['guidePrice'] = this.guidePrice;
    data['id'] = this.id;
    data['importType'] = this.importType;
    data['intakeForm'] = this.intakeForm;
    data['modelYear'] = this.modelYear;
    data['name'] = this.name;
    data['oilGrade'] = this.oilGrade;
    data['powerSteer'] = this.powerSteer;
    data['price'] = this.price;
    data['producer'] = this.producer;
    data['rearBrakeType'] = this.rearBrakeType;
    data['rearHubSpec'] = this.rearHubSpec;
    data['rearTyreSpec'] = this.rearTyreSpec;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['tsy'] = this.tsy;
    data['ttm'] = this.ttm;
    data['tty'] = this.tty;
    data['uniqueIndexed'] = this.uniqueIndexed;
    return data;
  }
}
