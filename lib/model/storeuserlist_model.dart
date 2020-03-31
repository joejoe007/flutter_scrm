class StoreUserListModel {
    String id;
    String mobile;
    String name;
    String roleName;
    bool select;

    StoreUserListModel({this.id, this.mobile, this.name, this.roleName ,this.select = false});

    factory StoreUserListModel.fromJson(Map<String, dynamic> json) {
        return StoreUserListModel(
            id: json['id'],
            mobile: json['mobile'],
            name: json['name'],
            roleName: json['roleName'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['mobile'] = this.mobile;
        data['name'] = this.name;
        data['roleName'] = this.roleName;
        return data;
    }
}


//class RoleListModel {
//    dynamic defType;
//    dynamic id;
//    String name;
//    dynamic pid;
//    String roleType;
//
//    RoleListModel({this.defType, this.id, this.name, this.pid, this.roleType});
//
//    factory RoleListModel.fromJson(Map<String, dynamic> json) {
//        return RoleListModel(
//            defType: json['defType'],
//            id: json['id'],
//            name: json['name'],
//            pid: json['pid'],
//            roleType: json['roleType'],
//        );
//    }
//
//    Map<String, dynamic> toJson() {
//        final Map<String, dynamic> data = new Map<String, dynamic>();
//        data['defType'] = this.defType;
//        data['id'] = this.id;
//        data['name'] = this.name;
//        data['pid'] = this.pid;
//        data['roleType'] = this.roleType;
//        return data;
//    }
//}

class RoleListModel {
    String clientAccess;
    String createName;
    String createTime;
    dynamic defType;
    dynamic deptid;
    dynamic id;
    String name;
    dynamic num;
    String parentStoreId;
    dynamic pid;
    String roleType;
    String status;
    String storeId;
    String tips;
    String updateTime;
    dynamic version;

    RoleListModel({this.clientAccess, this.createName, this.createTime, this.defType, this.deptid, this.id, this.name, this.num, this.parentStoreId, this.pid, this.roleType, this.status, this.storeId, this.tips, this.updateTime, this.version});

    factory RoleListModel.fromJson(Map<String, dynamic> json) {
        return RoleListModel(
            clientAccess: json['clientAccess'],
            createName: json['createName'],
            createTime: json['createTime'],
            defType: json['defType'],
            deptid: json['deptid'],
            id: json['id'],
            name: json['name'],
            num: json['num'],
            parentStoreId: json['parentStoreId'],
            pid: json['pid'],
            roleType: json['roleType'],
            status: json['status'],
            storeId: json['storeId'],
            tips: json['tips'],
            updateTime: json['updateTime'],
            version: json['version'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['clientAccess'] = this.clientAccess;
        data['createName'] = this.createName;
        data['createTime'] = this.createTime;
        data['defType'] = this.defType;
        data['deptid'] = this.deptid;
        data['id'] = this.id;
        data['name'] = this.name;
        data['num'] = this.num;
        data['parentStoreId'] = this.parentStoreId;
        data['pid'] = this.pid;
        data['roleType'] = this.roleType;
        data['status'] = this.status;
        data['storeId'] = this.storeId;
        data['tips'] = this.tips;
        data['updateTime'] = this.updateTime;
        data['version'] = this.version;
        return data;
    }
}