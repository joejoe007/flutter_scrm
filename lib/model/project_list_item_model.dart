/// 项目列表
class ProjectItemModel {
  dynamic categoryId;
  dynamic commonUse;
  dynamic cost;
  dynamic firstCategoryId;
  dynamic firstCategoryName;
  dynamic hot;
  dynamic hours;
  dynamic id;
  dynamic miniPrice;
  dynamic name;
  dynamic price;
  dynamic secondCategoryName;
  dynamic sort;
  dynamic storeId;
  int num;
  double discount;
  bool searchShow = false;
  bool showCardMember = false;// 展示会员标志

  ProjectItemModel({
    this.categoryId,
    this.commonUse,
    this.cost,
    this.firstCategoryId,
    this.firstCategoryName,
    this.hot,
    this.hours,
    this.id,
    this.miniPrice,
    this.name,
    this.price,
    this.secondCategoryName,
    this.sort,
    this.num = 0,
    this.storeId,
    this.discount = 10.00,
    this.searchShow = false,
  });

  factory ProjectItemModel.fromJson(Map<String, dynamic> json) {
    return ProjectItemModel(
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
