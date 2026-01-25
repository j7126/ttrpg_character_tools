import 'package:json_annotation/json_annotation.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/class/armor_proficiency.dart';

part 'starting_proficiencies.g.dart';

@JsonSerializable(explicitToJson: true)
class ClassStartingProficiencies {
  ClassStartingProficiencies({
    required this.armor,
  });

  List<ArmorProficiency> armor;

  factory ClassStartingProficiencies.fromJson(Map<String, dynamic> json) => _$ClassStartingProficienciesFromJson(json);

  Map<String, dynamic> toJson() => _$ClassStartingProficienciesToJson(this);
}
