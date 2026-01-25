// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassFeature5e _$ClassFeature5eFromJson(Map<String, dynamic> json) =>
    ClassFeature5e(
      name: json['name'] as String,
      source: json['source'] as String,
      page: (json['page'] as num?)?.toInt(),
      otherSources: (json['otherSources'] as List<dynamic>?)
          ?.map((e) => BookSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      srd: json['srd'],
      className: json['className'] as String,
      classSource: json['classSource'] as String,
      level: (json['level'] as num).toInt(),
      header: (json['header'] as num?)?.toInt() ?? 0,
    )..basicRules = json['basicRules'] as bool?;

Map<String, dynamic> _$ClassFeature5eToJson(ClassFeature5e instance) =>
    <String, dynamic>{
      'name': instance.name,
      'source': instance.source,
      'page': instance.page,
      'otherSources': instance.otherSources?.map((e) => e.toJson()).toList(),
      'srd': instance.srd,
      'basicRules': instance.basicRules,
      'className': instance.className,
      'classSource': instance.classSource,
      'level': instance.level,
      'header': instance.header,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
    };
