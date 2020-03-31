/// 营业汇总界面数据
class BusinessDetailModel {
  dynamic businessPure;
  dynamic businessReal;
  dynamic businessTotal;
  dynamic carMember;
  dynamic carNew;
  dynamic carOld;
  dynamic carTotal;
  CardConsume cardConsume;
  CardLeft cardLeft;
  CardSales cardSales;

  BusinessDetailModel(
      {this.businessPure,
      this.businessReal,
      this.businessTotal,
      this.carMember,
      this.carNew,
      this.carOld,
      this.carTotal,
      this.cardConsume,
      this.cardLeft,
      this.cardSales});

  factory BusinessDetailModel.fromJson(Map<String, dynamic> json) {
    return BusinessDetailModel(
      businessPure: json['businessPure'],
      businessReal: json['businessReal'],
      businessTotal: json['businessTotal'],
      carMember: json['carMember'],
      carNew: json['carNew'],
      carOld: json['carOld'],
      carTotal: json['carTotal'],
      cardConsume: json['cardConsume'] != null
          ? CardConsume.fromJson(json['cardConsume'])
          : null,
      cardLeft:
          json['cardLeft'] != null ? CardLeft.fromJson(json['cardLeft']) : null,
      cardSales: json['cardSales'] != null
          ? CardSales.fromJson(json['cardSales'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businessPure'] = this.businessPure;
    data['businessReal'] = this.businessReal;
    data['businessTotal'] = this.businessTotal;
    data['carMember'] = this.carMember;
    data['carNew'] = this.carNew;
    data['carOld'] = this.carOld;
    data['carTotal'] = this.carTotal;
    if (this.cardConsume != null) {
      data['cardConsume'] = this.cardConsume.toJson();
    }
    if (this.cardLeft != null) {
      data['cardLeft'] = this.cardLeft.toJson();
    }
    if (this.cardSales != null) {
      data['cardSales'] = this.cardSales.toJson();
    }
    return data;
  }
}

class CardLeft {
  dynamic leftCount;
  dynamic leftCountPrice;
  dynamic leftMoney;
  dynamic totalMoney;

  CardLeft(
      {this.leftCount, this.leftCountPrice, this.leftMoney, this.totalMoney});

  factory CardLeft.fromJson(Map<String, dynamic> json) {
    return CardLeft(
      leftCount: json['leftCount'],
      leftCountPrice: json['leftCountPrice'],
      leftMoney: json['leftMoney'],
      totalMoney: json['totalMoney'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leftCount'] = this.leftCount;
    data['leftCountPrice'] = this.leftCountPrice;
    data['leftMoney'] = this.leftMoney;
    data['totalMoney'] = this.totalMoney;
    return data;
  }
}

class CardConsume {
  dynamic count;
  dynamic giftCount;
  dynamic giftMoney;
  dynamic money;
  dynamic totalCount;
  dynamic totalMoney;

  CardConsume(
      {this.count,
      this.giftCount,
      this.giftMoney,
      this.money,
      this.totalCount,
      this.totalMoney});

  factory CardConsume.fromJson(Map<String, dynamic> json) {
    return CardConsume(
      count: json['count'],
      giftCount: json['giftCount'],
      giftMoney: json['giftMoney'],
      money: json['money'],
      totalCount: json['totalCount'],
      totalMoney: json['totalMoney'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['giftCount'] = this.giftCount;
    data['giftMoney'] = this.giftMoney;
    data['money'] = this.money;
    data['totalCount'] = this.totalCount;
    data['totalMoney'] = this.totalMoney;
    return data;
  }
}

class CardSales {
  dynamic cardRecharge;
  dynamic cardRefund;
  dynamic cardSale;
  dynamic total;

  CardSales({this.cardRecharge, this.cardRefund, this.cardSale, this.total});

  factory CardSales.fromJson(Map<String, dynamic> json) {
    return CardSales(
      cardRecharge: json['cardRecharge'],
      cardRefund: json['cardRefund'],
      cardSale: json['cardSale'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardRecharge'] = this.cardRecharge;
    data['cardRefund'] = this.cardRefund;
    data['cardSale'] = this.cardSale;
    data['total'] = this.total;
    return data;
  }
}

/// 总销量和金额
class FinanceAccountAndTotalModel {
  dynamic acount;
  dynamic orderTotal;

  FinanceAccountAndTotalModel({this.acount, this.orderTotal});

  factory FinanceAccountAndTotalModel.fromJson(Map<String, dynamic> json) {
    return FinanceAccountAndTotalModel(
      acount: json['acount'],
      orderTotal: json['orderTotal'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acount'] = this.acount;
    data['orderTotal'] = this.orderTotal;
    return data;
  }
}

/// 营业汇总列表
class FinanceTotalItemModel {
  dynamic backMoney;
  dynamic car_no;
  dynamic incomeMoney;
  dynamic item_names;
  dynamic mobile;
  dynamic name;
  dynamic order_no;
  dynamic pay_status;

  FinanceTotalItemModel(
      {this.backMoney,
      this.car_no,
      this.incomeMoney,
      this.item_names,
      this.mobile,
      this.name,
      this.order_no,
      this.pay_status});

  factory FinanceTotalItemModel.fromJson(Map<String, dynamic> json) {
    return FinanceTotalItemModel(
      backMoney: json['backMoney'],
      car_no: json['car_no'],
      incomeMoney: json['incomeMoney'],
      item_names: json['item_names'],
      mobile: json['mobile'],
      name: json['name'],
      order_no: json['order_no'],
      pay_status: json['pay_status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backMoney'] = this.backMoney;
    data['car_no'] = this.car_no;
    data['incomeMoney'] = this.incomeMoney;
    data['item_names'] = this.item_names;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['order_no'] = this.order_no;
    data['pay_status'] = this.pay_status;
    return data;
  }
}

/// 会员卡统计总金额
class MemberSaleTotalModel {
  dynamic balance;
  dynamic leftTimes;
  dynamic leftTimesPrice;
  dynamic sale;

  MemberSaleTotalModel(
      {this.balance, this.leftTimes, this.leftTimesPrice, this.sale});

  factory MemberSaleTotalModel.fromJson(Map<String, dynamic> json) {
    return MemberSaleTotalModel(
      balance: json['balance'],
      leftTimes: json['leftTimes'],
      leftTimesPrice: json['leftTimesPrice'],
      sale: json['sale'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['leftTimes'] = this.leftTimes;
    data['leftTimesPrice'] = this.leftTimesPrice;
    data['sale'] = this.sale;
    return data;
  }
}

/// 实收明细item
class FinanceIncomeItemModel {
  dynamic actualPayWay;
  dynamic carNo;
  dynamic customerName;
  dynamic itemNames;
  dynamic mobile;
  dynamic money;
  dynamic orderId;
  dynamic orderNo;
  dynamic orderType;
  dynamic payStatus;
  dynamic refundMoney;

  FinanceIncomeItemModel(
      {this.actualPayWay, this.carNo, this.customerName, this.itemNames, this.mobile, this.money, this.orderId, this.orderNo, this.orderType, this.payStatus, this.refundMoney});

  factory FinanceIncomeItemModel.fromJson(Map<String, dynamic> json) {
    return FinanceIncomeItemModel(
      actualPayWay: json['actualPayWay'],
      carNo: json['carNo'],
      customerName: json['customerName'],
      itemNames: json['itemNames'],
      mobile: json['mobile'],
      money: json['money'],
      orderId: json['orderId'],
      orderNo: json['orderNo'],
      orderType: json['orderType'],
      payStatus: json['payStatus'],
      refundMoney: json['refundMoney'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actualPayWay'] = this.actualPayWay;
    data['carNo'] = this.carNo;
    data['customerName'] = this.customerName;
    data['itemNames'] = this.itemNames;
    data['mobile'] = this.mobile;
    data['money'] = this.money;
    data['orderId'] = this.orderId;
    data['orderNo'] = this.orderNo;
    data['orderType'] = this.orderType;
    data['payStatus'] = this.payStatus;
    data['refundMoney'] = this.refundMoney;
    return data;
  }
}

/// 会员卡销售item
class MemberCardSalesItemModel {
  dynamic cardName;
  dynamic cardPrice;
  dynamic cardTypeId;
  dynamic rechargePrice;
  dynamic refundPrice;
  dynamic saleCount;
  dynamic total;

  MemberCardSalesItemModel(
      {this.cardName,
      this.cardPrice,
      this.cardTypeId,
      this.rechargePrice,
      this.refundPrice,
      this.saleCount,
      this.total});

  factory MemberCardSalesItemModel.fromJson(Map<String, dynamic> json) {
    return MemberCardSalesItemModel(
      cardName: json['cardName'],
      cardPrice: json['cardPrice'],
      cardTypeId: json['cardTypeId'],
      rechargePrice: json['rechargePrice'],
      refundPrice: json['refundPrice'],
      saleCount: json['saleCount'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardName'] = this.cardName;
    data['cardPrice'] = this.cardPrice;
    data['cardTypeId'] = this.cardTypeId;
    data['rechargePrice'] = this.rechargePrice;
    data['refundPrice'] = this.refundPrice;
    data['saleCount'] = this.saleCount;
    data['total'] = this.total;
    return data;
  }
}

/// 会员卡剩余列表
class MemberCardMoneyItemModel {
  dynamic balance;
  dynamic cardTypeId;
  dynamic cardTypeName;
  List<Service> services;

  MemberCardMoneyItemModel(
      {this.balance, this.cardTypeId, this.cardTypeName, this.services});

  factory MemberCardMoneyItemModel.fromJson(Map<String, dynamic> json) {
    return MemberCardMoneyItemModel(
      balance: json['balance'],
      cardTypeId: json['cardTypeId'],
      cardTypeName: json['cardTypeName'],
      services: json['services'] != null
          ? (json['services'] as List).map((i) => Service.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['cardTypeId'] = this.cardTypeId;
    data['cardTypeName'] = this.cardTypeName;
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  dynamic cardTypeId;
  dynamic itemName;
  dynamic leftTimes;

  Service({this.cardTypeId, this.itemName, this.leftTimes});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      cardTypeId: json['cardTypeId'],
      itemName: json['itemName'],
      leftTimes: json['leftTimes'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardTypeId'] = this.cardTypeId;
    data['itemName'] = this.itemName;
    data['leftTimes'] = this.leftTimes;
    return data;
  }
}
