import 'package:json_annotation/json_annotation.dart';

part 'base_list_bean.g.dart';

@JsonSerializable()
class BaseListBean<T> extends Object {
  dynamic current;

  dynamic pages;

  dynamic size;

  dynamic total;

  List<T> records;

  BaseListBean(
    this.current,
    this.pages,
    this.size,
    this.total,
    this.records,
  );

  factory BaseListBean.fromJson(Map<String, dynamic> srcJson) =>
      _$base_listFromJson(srcJson);

  Map<String, dynamic> toJson() => _$base_listToJson(this);
}
