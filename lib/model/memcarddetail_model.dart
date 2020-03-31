class MemCardDetailModel {
  String cardName;
  String cardNo;
  List<Content> contents;
  String createTime;
  String customerName;
  String expireTime;
  List<Gift> gifts;
  String id;
  String mobile;
  dynamic salePrice;
  int status;
  String customerId;

  MemCardDetailModel(
      {this.cardName,
      this.cardNo,
      this.contents,
      this.createTime,
      this.customerName,
      this.expireTime,
      this.gifts,
      this.id,
      this.mobile,
      this.salePrice,
      this.status,
      this.customerId});

  factory MemCardDetailModel.fromJson(Map<String, dynamic> json) {
    return MemCardDetailModel(
        cardName: json['cardName'],
        cardNo: json['cardNo'],
        contents: json['contents'] != null
            ? (json['contents'] as List)
                .map((i) => Content.fromJson(i))
                .toList()
            : null,
        createTime: json['createTime'],
        customerName: json['customerName'],
        expireTime: json['expireTime'],
        gifts: json['gifts'] != null
            ? (json['gifts'] as List).map((i) => Gift.fromJson(i)).toList()
            : null,
        id: json['id'],
        mobile: json['mobile'],
        salePrice: json['salePrice'],
        status: json['status'],
        customerId: json['customerId']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardName'] = this.cardName;
    data['cardNo'] = this.cardNo;
    data['createTime'] = this.createTime;
    data['customerName'] = this.customerName;
    data['expireTime'] = this.expireTime;
    data['id'] = this.id;
    data['mobile'] = this.mobile;
    data['salePrice'] = this.salePrice;
    data['status'] = this.status;
    if (this.contents != null) {
      data['contents'] = this.contents.map((v) => v.toJson()).toList();
    }
    if (this.gifts != null) {
      data['gifts'] = this.gifts.map((v) => v.toJson()).toList();
    }
    data['customerId'] = this.customerId;
    return data;
  }
}

class Gift {
  dynamic balance;
  dynamic consumeAmount;
  String id;
  dynamic isPresent;
  String itemId;
  String itemName;
  dynamic price;
  dynamic totalAmount;
  int type;
  dynamic unitPrice;

  Gift(
      {this.balance,
      this.consumeAmount,
      this.id,
      this.isPresent,
      this.itemId,
      this.itemName,
      this.price,
      this.totalAmount,
      this.type,
      this.unitPrice});

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      balance: json['balance'],
      consumeAmount: json['consumeAmount'],
      id: json['id'],
      isPresent: json['isPresent'],
      itemId: json['itemId'],
      itemName: json['itemName'],
      price: json['price'],
      totalAmount: json['totalAmount'],
      type: json['type'],
      unitPrice: json['unitPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['consumeAmount'] = this.consumeAmount;
    data['id'] = this.id;
    data['isPresent'] = this.isPresent;
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['price'] = this.price;
    data['totalAmount'] = this.totalAmount;
    data['type'] = this.type;
    data['unitPrice'] = this.unitPrice;
    return data;
  }
}

class Content {
  dynamic balance;
  dynamic consumeAmount;
  String id;
  dynamic isPresent;
  String itemId;
  String itemName;
  dynamic price;
  dynamic totalAmount;
  int type;
  dynamic unitPrice;

  Content(
      {this.balance,
      this.consumeAmount,
      this.id,
      this.isPresent,
      this.itemId,
      this.itemName,
      this.price,
      this.totalAmount,
      this.type,
      this.unitPrice});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      balance: json['balance'],
      consumeAmount: json['consumeAmount'],
      id: json['id'],
      isPresent: json['isPresent'],
      itemId: json['itemId'],
      itemName: json['itemName'],
      price: json['price'],
      totalAmount: json['totalAmount'],
      type: json['type'],
      unitPrice: json['unitPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['consumeAmount'] = this.consumeAmount;
    data['id'] = this.id;
    data['isPresent'] = this.isPresent;
    data['itemId'] = this.itemId;
    data['itemName'] = this.itemName;
    data['price'] = this.price;
    data['totalAmount'] = this.totalAmount;
    data['type'] = this.type;
    data['unitPrice'] = this.unitPrice;
    return data;
  }
}
