// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starting_proficiencies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassStartingProficiencies _$ClassStartingProficienciesFromJson(
        Map<String, dynamic> json) =>
    ClassStartingProficiencies(
      armor: (json['armor'] as List<dynamic>)
          .map((e) => $enumDecode(_$ArmorProficiencyEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$ClassStartingProficienciesToJson(
        ClassStartingProficiencies instance) =>
    <String, dynamic>{
      'armor':
          instance.armor.map((e) => _$ArmorProficiencyEnumMap[e]!).toList(),
    };

const _$ArmorProficiencyEnumMap = {
  ArmorProficiency.light: 'light',
  ArmorProficiency.medium: 'medium',
  ArmorProficiency.heavy: 'heavy',
  ArmorProficiency.shields: 'shields',
};
