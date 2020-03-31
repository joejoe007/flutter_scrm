/// 版本信息
class VersionInfoModel {
    String id;
    String miniCode;
    String os;
    int osType;
    String remark;
    int status;
    String uploadTime;
    String url;
    int versionCode;
    String versionName;
    int versionNumber;

    VersionInfoModel({this.id, this.miniCode, this.os, this.osType, this.remark, this.status, this.uploadTime, this.url, this.versionCode, this.versionName, this.versionNumber});

    factory VersionInfoModel.fromJson(Map<String, dynamic> json) {
        return VersionInfoModel(
            id: json['id'],
            miniCode: json['miniCode'],
            os: json['os'],
            osType: json['osType'],
            remark: json['remark'],
            status: json['status'],
            uploadTime: json['uploadTime'],
            url: json['url'],
            versionCode: json['versionCode'],
            versionName: json['versionName'],
            versionNumber: json['versionNumber'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['miniCode'] = this.miniCode;
        data['os'] = this.os;
        data['osType'] = this.osType;
        data['remark'] = this.remark;
        data['status'] = this.status;
        data['uploadTime'] = this.uploadTime;
        data['url'] = this.url;
        data['versionCode'] = this.versionCode;
        data['versionName'] = this.versionName;
        data['versionNumber'] = this.versionNumber;
        return data;
    }
}