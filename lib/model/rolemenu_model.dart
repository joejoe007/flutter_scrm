class RoleMenuModel {
  String code;
  String icon;
  String id;
  dynamic ismenu;
  dynamic isopen;
  dynamic levels;
  List<RoleMenuModel> list;
  String name;
  dynamic num;
  String pcode;
  String pcodes;
  dynamic status;
  String storeId;
  String tips;
  String url;

  bool isSelect;

  RoleMenuModel(
      {this.code,
      this.icon,
      this.id,
      this.ismenu,
      this.isopen,
      this.levels,
      this.list,
      this.name,
      this.num,
      this.pcode,
      this.pcodes,
      this.status,
      this.storeId,
      this.tips,
      this.url,
      this.isSelect = false});

  factory RoleMenuModel.fromJson(Map<String, dynamic> json) {
    return RoleMenuModel(
      code: json['code'],
      icon: json['icon'],
      id: json['id'],
      ismenu: json['ismenu'],
      isopen: json['isopen'],
      levels: json['levels'],
      list: json['list'] != null
          ? (json['list'] as List)
              .map((i) => RoleMenuModel.fromJson(i))
              .toList()
          : null,
      name: json['name'],
      num: json['num'],
      pcode: json['pcode'],
      pcodes: json['pcodes'],
      status: json['status'],
      storeId: json['storeId'],
      tips: json['tips'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['ismenu'] = this.ismenu;
    data['isopen'] = this.isopen;
    data['levels'] = this.levels;
    data['name'] = this.name;
    data['num'] = this.num;
    data['pcode'] = this.pcode;
    data['pcodes'] = this.pcodes;
    data['status'] = this.status;
    data['storeId'] = this.storeId;
    data['tips'] = this.tips;
    data['url'] = this.url;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SysRelationAddListModel {
  dynamic menuid;
  String name;
  dynamic osType;
  dynamic roleid;
  dynamic storeId;
  dynamic id;

  SysRelationAddListModel(
      {this.menuid,
      this.name,
      this.osType,
      this.roleid,
      this.storeId,
      this.id});

  factory SysRelationAddListModel.fromJson(Map<String, dynamic> json) {
    return SysRelationAddListModel(
      menuid: json['menuid'],
      name: json['name'],
      osType: json['osType'],
      roleid: json['roleid'],
      storeId: json['storeId'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuid'] = this.menuid;
    data['name'] = this.name;
    data['osType'] = this.osType;
    data['roleid'] = this.roleid;
    data['storeId'] = this.storeId;
    data['id'] = this.id;
    return data;
  }
}
