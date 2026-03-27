import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class CharacterProficiencyField extends StatelessWidget {
  const CharacterProficiencyField({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntFieldBase(
        label: "Proficiency Bonus",
        withSign: true,
        value: character.stats.profficencyBonus,
        valueChanged: (val) {
          character.stats.profficencyBonus = val;
          changed();
        },
      ),
    );
  }
}
