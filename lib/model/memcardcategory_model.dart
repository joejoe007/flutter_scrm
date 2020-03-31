class MemCardCategoryListModel {
  dynamic balance;
  String createTime;
  String id;
  String name;
  String parentStoreId;
  dynamic price;
  String remark;
  dynamic saleCount;
  dynamic status;
  String storeId;
  String updateTime;
  dynamic validUnit;
  dynamic validValue;

  MemCardCategoryListModel(
      {this.balance,
      this.createTime,
      this.id,
      this.name,
      this.parentStoreId,
      this.price,
      this.remark,
      this.saleCount,
      this.status,
      this.storeId,
      this.updateTime,
      this.validUnit,
      this.validValue});

  factory MemCardCategoryListModel.fromJson(Map<String, dynamic> json) {
    return MemCardCategoryListModel(
      balance: json['balance'],
      createTime: json['createTime'],
      id: json['id'],
      name: json['name'],
      parentStoreId: json['parentStoreId'],
      price: json['price'],
      remark: json['remark'],
      saleCount: json['saleCount'],
      status: json['status'],
      storeId: json['storeId'],
      updateTime: json['updateTime'],
      validUnit: json['validUnit'],
      validValue: json['validValue'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['createTime'] = this.createTime;
    data['id'] = this.id;
    data['name'] = this.name;
    data['parentStoreId'] = this.parentStoreId;
    data['price'] = this.price;
    data['remark'] = this.remark;
    data['saleCount'] = this.saleCount;
    data['status'] = this.status;
    data['storeId'] = this.storeId;
    data['updateTime'] = this.updateTime;
    data['validUnit'] = this.validUnit;
    data['validValue'] = this.validValue;
    return data;
  }
}

class MemCardCategoryAddModel {
  List<MemCardCategorySubModel> contents;
  List<MemCardCategorySubModel> gifts;
  dynamic id;
  String name;
  dynamic price;
  String remark;
  dynamic validUnit;
  dynamic validValue;
  dynamic saleCount;
  dynamic status;
  dynamic storeId;
  dynamic updateTime;
  dynamic createTime;
  dynamic balance;

  MemCardCategoryAddModel(
      {this.contents,
      this.gifts,
      this.id,
      this.name = '',
      this.price = '',
      this.remark= '',
      this.validUnit = 1,

      /// 年1 月2 日3
      this.validValue = 1,
      this.saleCount,
      this.status,
      this.storeId,
      this.updateTime,
      this.createTime,
      this.balance});

  factory MemCardCategoryAddModel.fromJson(Map<String, dynamic> json) {
    return MemCardCategoryAddModel(
      contents: json['contents'] != null
          ? (json['contents'] as List)
              .map((i) => MemCardCategorySubModel.fromJson(i))
              .toList()
          : null,
      gifts: json['gifts'] != null
          ? (json['gifts'] as List)
              .map((i) => MemCardCategorySubModel.fromJson(i))
              .toList()
          : null,
      id: json['id'],
      name: json['name'],
      price: json['price'],
      remark: json['remark'],
      validUnit: json['validUnit'],
      validValue: json['validValue'],
      saleCount: json['saleCount'],
      status: json['status'],
      storeId: json['storeId'],
      updateTime: json['updateTime'],
      createTime: json['createTime'],
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['remark'] = this.remark;
    data['validUnit'] = this.validUnit;
    data['validValue'] = this.validValue;
    if (this.contents != null) {
      data['contents'] = this.contents.map((v) => v.toJson()).toList();
    }
    if (this.gifts != null) {
      data['gifts'] = this.gifts.map((v) => v.toJson()).toList();
    }
    data['saleCount'] = this.saleCount;
    data['status'] = this.status;
    data['storeId'] = this.storeId;
    data['updateTime'] = this.updateTime;
    data['createTime'] = this.createTime;
    data['balance'] = this.balance;
    return data;
  }
}

class MemCardCategorySubModel {
  dynamic amount;
  dynamic cardTypeId;
  dynamic id;
  dynamic isPresent;
  dynamic itemId;
  String itemName;
  dynamic type;
  dynamic unitPrice;
  dynamic createTime;
  dynamic expireTime;
  dynamic parentStoreId;
  dynamic remark;
  dynamic status;
  dynamic storeId;
  dynamic unit;

  MemCardCategorySubModel(
      {this.amount,
      this.cardTypeId,
      this.id,
      this.isPresent,
      this.itemId,
      this.itemName,
      this.type,
      this.unitPrice,
      this.createTime,
      this.expireTime,
      this.parentStoreId,
      this.remark,
      this.status,
      this.storeId,
      this.unit});

  factory MemCardCategorySubModel.fromJson(Map<String, dynamic> json) {
    return MemCardCategorySubModel(
      amount: json['amount'],
      cardTypeId: json['cardTypeId'],
      id: json['id'],
      isPresent: json['isPresent'],
      itemId: json['itemId'],
      itemName: json['itemName'],
      type: json['type'],
      unitPrice: json['unitPrice'],
      createTime: json['createTime'],
      expireTime: json['expireTime'],
      parentStoreId: json['parentStoreId'],
      remark: json['remark'],
      status: json['status'],
      storeId: json['storeId'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['cardTypeId'] = this.cardTypeId;
    data['id'] = this.id;
    data['isPresent'] = this.isPresent;
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['type'] = this.type;
    data['unitPrice'] = this.unitPrice;
    data['createTime'] = this.createTime;
    data['expireTime'] = this.expireTime;
    data['parentStoreId'] = this.parentStoreId;
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['storeId'] = this.storeId;
    data['unit'] = this.unit;
    return data;
  }
}
