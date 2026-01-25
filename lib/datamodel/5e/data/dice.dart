import 'package:json_annotation/json_annotation.dart';

part 'dice.g.dart';

@JsonSerializable(explicitToJson: true)
class Dice {
  Dice({
    required this.number,
    required this.faces,
  });

  int number;
  int faces;

  factory Dice.fromJson(Map<String, dynamic> json) => _$DiceFromJson(json);

  Map<String, dynamic> toJson() => _$DiceToJson(this);
}
