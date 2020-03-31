/// vim image
class VimImageModel {
  dynamic request_id;
  dynamic success;
  dynamic vin;

  VimImageModel({this.request_id, this.success, this.vin});

  factory VimImageModel.fromJson(Map<String, dynamic> json) {
    return VimImageModel(
      request_id: json['request_id'],
      success: json['success'],
      vin: json['vin'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.request_id;
    data['success'] = this.success;
    data['vin'] = this.vin;
    return data;
  }
}
