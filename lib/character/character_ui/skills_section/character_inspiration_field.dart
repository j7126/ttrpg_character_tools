import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class CharacterInspirationField extends StatelessWidget {
  const CharacterInspirationField({
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
        label: "Inspiration",
        withSign: false,
        value: character.hasInspiration() ? character.inspiration : 0,
        valueChanged: (val) {
          if (val == 0) {
            character.clearInspiration();
          } else {
            character.inspiration = val;
          }
          changed();
        },
      ),
    );
  }
}
