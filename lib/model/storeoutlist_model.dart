class StoreOutListModel {
    String costDesc;
    dynamic costPrice;
    String costTime;
    String id;
    String remark;
    String storeId;
    String type;

    StoreOutListModel({this.costDesc, this.costPrice, this.costTime, this.id, this.remark, this.storeId, this.type});

    factory StoreOutListModel.fromJson(Map<String, dynamic> json) {
        return StoreOutListModel(
            costDesc: json['costDesc'],
            costPrice: json['costPrice'],
            costTime: json['costTime'],
            id: json['id'],
            remark: json['remark'],
            storeId: json['storeId'],
            type: json['type'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['costDesc'] = this.costDesc;
        data['costPrice'] = this.costPrice;
        data['costTime'] = this.costTime;
        data['id'] = this.id;
        data['remark'] = this.remark;
        data['storeId'] = this.storeId;
        data['type'] = this.type;
        return data;
    }
}