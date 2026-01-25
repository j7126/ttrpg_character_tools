// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class5e _$Class5eFromJson(Map<String, dynamic> json) => Class5e(
      name: json['name'] as String,
      source: json['source'] as String,
      page: (json['page'] as num?)?.toInt(),
      otherSources: (json['otherSources'] as List<dynamic>?)
          ?.map((e) => BookSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      srd: json['srd'],
      hd: Dice.fromJson(json['hd'] as Map<String, dynamic>),
      proficiency: (json['proficiency'] as List<dynamic>)
          .map((e) => $enumDecode(_$AbilityEnumMap, e))
          .toList(),
      spellcastingAbility:
          $enumDecodeNullable(_$AbilityEnumMap, json['spellcastingAbility']),
    )
      ..basicRules = json['basicRules'] as bool?
      ..casterProgression = json['casterProgression'] as String?
      ..cantripProgression = (json['cantripProgression'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList()
      ..spellsKnownProgression =
          (json['spellsKnownProgression'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList();

Map<String, dynamic> _$Class5eToJson(Class5e instance) => <String, dynamic>{
      'name': instance.name,
      'source': instance.source,
      'page': instance.page,
      'otherSources': instance.otherSources?.map((e) => e.toJson()).toList(),
      'srd': instance.srd,
      'basicRules': instance.basicRules,
      'hd': instance.hd.toJson(),
      'proficiency':
          instance.proficiency.map((e) => _$AbilityEnumMap[e]!).toList(),
      'spellcastingAbility': _$AbilityEnumMap[instance.spellcastingAbility],
      'casterProgression': instance.casterProgression,
      'cantripProgression': instance.cantripProgression,
      'spellsKnownProgression': instance.spellsKnownProgression,
    };

const _$AbilityEnumMap = {
  Ability.str: 'str',
  Ability.dex: 'dex',
  Ability.con: 'con',
  Ability.int: 'int',
  Ability.wis: 'wis',
  Ability.cha: 'cha',
};
