class MemCardListModel {
    int current;
    String pages;
    List<Record> records;
    int size;
    String total;

    MemCardListModel({this.current, this.pages, this.records, this.size, this.total});

    factory MemCardListModel.fromJson(Map<String, dynamic> json) {
        return MemCardListModel(
            current: json['current'],
            pages: json['pages'],
            records: json['records'] != null ? (json['records'] as List).map((i) => Record.fromJson(i)).toList() : null,
            size: json['size'],
            total: json['total'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['current'] = this.current;
        data['pages'] = this.pages;
        data['size'] = this.size;
        data['total'] = this.total;
        if (this.records != null) {
            data['records'] = this.records.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Record {
    String amount;
    dynamic balance;
    String beginDate;
    String cardName;
    String cardNo;
    String createTime;
    String customerName;
    String expireTime;
    String id;
    String itemName;
    int leftTimes;
    int status;

    Record({this.amount, this.balance, this.beginDate, this.cardName, this.cardNo, this.createTime, this.customerName, this.expireTime, this.id, this.itemName, this.leftTimes, this.status});

    factory Record.fromJson(Map<String, dynamic> json) {
        return Record(
            amount: json['amount'],
            balance: json['balance'],
            beginDate: json['beginDate'],
            cardName: json['cardName'],
            cardNo: json['cardNo'],
            createTime: json['createTime'],
            customerName: json['customerName'],
            expireTime: json['expireTime'],
            id: json['id'],
            itemName: json['itemName'],
            leftTimes: json['leftTimes'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['balance'] = this.balance;
        data['beginDate'] = this.beginDate;
        data['cardName'] = this.cardName;
        data['cardNo'] = this.cardNo;
        data['createTime'] = this.createTime;
        data['customerName'] = this.customerName;
        data['expireTime'] = this.expireTime;
        data['id'] = this.id;
        data['itemName'] = this.itemName;
        data['leftTimes'] = this.leftTimes;
        data['status'] = this.status;
        return data;
    }
}


class MemCardConsumeRecordsModel {
    dynamic amount;
    String carNo;
    dynamic cardCustomerId;
    dynamic cardCustomerInfoId;
    dynamic createTime;
    dynamic customerId;
    String customerName;
    dynamic expireTime;
    dynamic id;
    dynamic isPresent;
    dynamic itemId;
    String itemName;
    dynamic orderId;
    dynamic orderNo;
    dynamic payType;
    String remark;
    dynamic storeId;
    dynamic type;
    dynamic udpateTime;

    MemCardConsumeRecordsModel({this.amount, this.carNo, this.cardCustomerId, this.cardCustomerInfoId, this.createTime, this.customerId, this.customerName, this.expireTime, this.id, this.isPresent, this.itemId, this.itemName, this.orderId, this.orderNo, this.payType, this.remark, this.storeId, this.type, this.udpateTime});

    factory MemCardConsumeRecordsModel.fromJson(Map<String, dynamic> json) {
        return MemCardConsumeRecordsModel(
            amount: json['amount'],
            carNo: json['carNo'],
            cardCustomerId: json['cardCustomerId'],
            cardCustomerInfoId: json['cardCustomerInfoId'],
            createTime: json['createTime'],
            customerId: json['customerId'],
            customerName: json['customerName'],
            expireTime: json['expireTime'],
            id: json['id'],
            isPresent: json['isPresent'],
            itemId: json['itemId'],
            itemName: json['itemName'],
            orderId: json['orderId'],
            orderNo: json['orderNo'],
            payType: json['payType'],
            remark: json['remark'],
            storeId: json['storeId'],
            type: json['type'],
            udpateTime: json['udpateTime'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['amount'] = this.amount;
        data['carNo'] = this.carNo;
        data['cardCustomerId'] = this.cardCustomerId;
        data['cardCustomerInfoId'] = this.cardCustomerInfoId;
        data['createTime'] = this.createTime;
        data['customerId'] = this.customerId;
        data['customerName'] = this.customerName;
        data['expireTime'] = this.expireTime;
        data['id'] = this.id;
        data['isPresent'] = this.isPresent;
        data['itemId'] = this.itemId;
        data['itemName'] = this.itemName;
        data['orderId'] = this.orderId;
        data['orderNo'] = this.orderNo;
        data['payType'] = this.payType;
        data['remark'] = this.remark;
        data['storeId'] = this.storeId;
        data['type'] = this.type;
        data['udpateTime'] = this.udpateTime;
        return data;
    }
}

/// 客户会员卡项目列表
class MemberCardTypeModel {
    dynamic balance;
    dynamic cardCustomerId;
    dynamic cardName;
    dynamic cardTypeId;
    dynamic consumeAmount;
    dynamic createTime;
    dynamic customerId;
    dynamic expireTime;
    dynamic id;
    dynamic isPresent;
    dynamic itemCategoryId;
    dynamic itemId;
    dynamic itemName;
    dynamic parentStoreId;
    dynamic storeId;
    dynamic totalAmount;
    dynamic type;
    dynamic unitPrice;
    bool choose = false;
    double discountMoney = 0;
    int discountCount = 0;

    MemberCardTypeModel(
        {this.balance, this.cardCustomerId, this.cardName, this.cardTypeId, this.consumeAmount, this.createTime, this.customerId, this.expireTime, this.id, this.isPresent, this.itemCategoryId, this.itemId, this.itemName, this.parentStoreId, this.storeId, this.totalAmount, this.type, this.unitPrice});

    factory MemberCardTypeModel.fromJson(Map<String, dynamic> json) {
        return MemberCardTypeModel(
            balance: json['balance'],
            cardCustomerId: json['cardCustomerId'],
            cardName: json['cardName'],
            cardTypeId: json['cardTypeId'],
            consumeAmount: json['consumeAmount'],
            createTime: json['createTime'],
            customerId: json['customerId'],
            expireTime: json['expireTime'],
            id: json['id'],
            isPresent: json['isPresent'],
            itemCategoryId: json['itemCategoryId'],
            itemId: json['itemId'],
            itemName: json['itemName'],
            parentStoreId: json['parentStoreId'],
            storeId: json['storeId'],
            totalAmount: json['totalAmount'],
            type: json['type'],
            unitPrice: json['unitPrice'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['balance'] = this.balance;
        data['cardCustomerId'] = this.cardCustomerId;
        data['cardName'] = this.cardName;
        data['cardTypeId'] = this.cardTypeId;
        data['consumeAmount'] = this.consumeAmount;
        data['createTime'] = this.createTime;
        data['customerId'] = this.customerId;
        data['expireTime'] = this.expireTime;
        data['id'] = this.id;
        data['isPresent'] = this.isPresent;
        data['itemCategoryId'] = this.itemCategoryId;
        data['itemId'] = this.itemId;
        data['itemName'] = this.itemName;
        data['parentStoreId'] = this.parentStoreId;
        data['storeId'] = this.storeId;
        data['totalAmount'] = this.totalAmount;
        data['type'] = this.type;
        data['unitPrice'] = this.unitPrice;
        return data;
    }
}


class MemCardBalanceModel {
    dynamic balance;
    dynamic leftTimes;

    MemCardBalanceModel({this.balance, this.leftTimes});

    factory MemCardBalanceModel.fromJson(Map<String, dynamic> json) {
        return MemCardBalanceModel(
            balance: json['balance'],
            leftTimes: json['leftTimes'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['balance'] = this.balance;
        data['leftTimes'] = this.leftTimes;
        return data;
    }
}

