// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_list_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseListBean _$base_listFromJson(Map<String, dynamic> json) {
  return BaseListBean(json['current'], json['pages'], json['size'],
      json['total'], json['records']);
}

Map<String, dynamic> _$base_listToJson(BaseListBean instance) =>
    <String, dynamic>{
      'current': instance.current,
      'pages': instance.pages,
      'size': instance.size,
      'total': instance.total,
      'records': instance.records
    };
