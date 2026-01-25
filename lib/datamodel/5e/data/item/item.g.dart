// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      name: json['name'] as String,
      source: json['source'] as String,
      page: (json['page'] as num?)?.toInt(),
      otherSources: (json['otherSources'] as List<dynamic>?)
          ?.map((e) => BookSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      srd: json['srd'],
      baseItem: json['baseItem'] as String?,
    )..basicRules = json['basicRules'] as bool?;

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'source': instance.source,
      'page': instance.page,
      'otherSources': instance.otherSources?.map((e) => e.toJson()).toList(),
      'srd': instance.srd,
      'basicRules': instance.basicRules,
      'baseItem': instance.baseItem,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
    };
