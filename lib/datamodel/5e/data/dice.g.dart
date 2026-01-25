// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dice _$DiceFromJson(Map<String, dynamic> json) => Dice(
      number: (json['number'] as num).toInt(),
      faces: (json['faces'] as num).toInt(),
    );

Map<String, dynamic> _$DiceToJson(Dice instance) => <String, dynamic>{
      'number': instance.number,
      'faces': instance.faces,
    };
