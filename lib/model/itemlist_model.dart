class ItemListModel {
    String categoryId;
    dynamic commonUse;
    dynamic cost;
    String firstCategoryId;
    String firstCategoryName;
    dynamic hot;
    dynamic hours;
    String id;
    dynamic miniPrice;
    String name;
    dynamic price;
    String secondCategoryName;
    dynamic sort;
    String storeId;
    dynamic total;
    dynamic selectNum;

    ItemListModel({this.categoryId, this.commonUse, this.cost, this.firstCategoryId, this.firstCategoryName, this.hot, this.hours, this.id, this.miniPrice, this.name, this.price, this.secondCategoryName, this.sort, this.storeId, this.total, this.selectNum});

    factory ItemListModel.fromJson(Map<String, dynamic> json) {
        return ItemListModel(
            categoryId: json['categoryId'],
            commonUse: json['commonUse'],
            cost: json['cost'],
            firstCategoryId: json['firstCategoryId'],
            firstCategoryName: json['firstCategoryName'],
            hot: json['hot'],
            hours: json['hours'],
            id: json['id'],
            miniPrice: json['miniPrice'],
            name: json['name'],
            price: json['price'],
            secondCategoryName: json['secondCategoryName'],
            sort: json['sort'],
            storeId: json['storeId'],
            total: json['total'],
            selectNum: json['selectNum'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['categoryId'] = this.categoryId;
        data['commonUse'] = this.commonUse;
        data['cost'] = this.cost;
        data['firstCategoryId'] = this.firstCategoryId;
        data['firstCategoryName'] = this.firstCategoryName;
        data['hot'] = this.hot;
        data['hours'] = this.hours;
        data['id'] = this.id;
        data['miniPrice'] = this.miniPrice;
        data['name'] = this.name;
        data['price'] = this.price;
        data['secondCategoryName'] = this.secondCategoryName;
        data['sort'] = this.sort;
        data['storeId'] = this.storeId;
        data['total'] = this.total;
        data['selectNum'] = this.selectNum;
        return data;
    }
}

class ItemCategoryListModel {
    dynamic flag;
    String id;
    String name;
    String parentId;
    dynamic sort;
    String storeId;
//    List<ItemCategoryListModel> subCategory;
    dynamic subCategory;

    ItemCategoryListModel({this.flag, this.id, this.name, this.parentId, this.sort, this.storeId, this.subCategory});

    factory ItemCategoryListModel.fromJson(Map<String, dynamic> json) {
        return ItemCategoryListModel(
            flag: json['flag'],
            id: json['id'],
            name: json['name'],
            parentId: json['parentId'],
            sort: json['sort'],
            storeId: json['storeId'],
            subCategory: (json['subCategory'] != null && !(json['subCategory'] is String)) ? (json['subCategory'] as List).map((i) => ItemCategoryListModel.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['flag'] = this.flag;
        data['id'] = this.id;
        data['name'] = this.name;
        data['parentId'] = this.parentId;
        data['sort'] = this.sort;
        data['storeId'] = this.storeId;
        if (this.subCategory != null && !(this.subCategory is String)) {
            data['subCategory'] = this.subCategory.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class ItemListDetailModel {
    dynamic categoryId;
    dynamic commonUse;
    dynamic cost;
    dynamic firstCategoryId;
    String firstCategoryName;
    dynamic hot;
    dynamic hours;
    dynamic id;
    dynamic miniPrice;
    String name;
    dynamic price;
    String secondCategoryName;
    dynamic sort;
    dynamic storeId;

    ItemListDetailModel({this.categoryId, this.commonUse, this.cost, this.firstCategoryId, this.firstCategoryName, this.hot, this.hours, this.id, this.miniPrice, this.name, this.price, this.secondCategoryName, this.sort, this.storeId});

    factory ItemListDetailModel.fromJson(Map<String, dynamic> json) {
        return ItemListDetailModel(
            categoryId: json['categoryId'],
            commonUse: json['commonUse'],
            cost: json['cost'],
            firstCategoryId: json['firstCategoryId'],
            firstCategoryName: json['firstCategoryName'],
            hot: json['hot'],
            hours: json['hours'],
            id: json['id'],
            miniPrice: json['miniPrice'],
            name: json['name'],
            price: json['price'],
            secondCategoryName: json['secondCategoryName'],
            sort: json['sort'],
            storeId: json['storeId'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['categoryId'] = this.categoryId;
        data['commonUse'] = this.commonUse;
        data['cost'] = this.cost;
        data['firstCategoryId'] = this.firstCategoryId;
        data['firstCategoryName'] = this.firstCategoryName;
        data['hot'] = this.hot;
        data['hours'] = this.hours;
        data['id'] = this.id;
        data['miniPrice'] = this.miniPrice;
        data['name'] = this.name;
        data['price'] = this.price;
        data['secondCategoryName'] = this.secondCategoryName;
        data['sort'] = this.sort;
        data['storeId'] = this.storeId;
        return data;
    }
}