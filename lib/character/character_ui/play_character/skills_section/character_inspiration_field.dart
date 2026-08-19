import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/int_field_base.dart';

class CharacterInspirationField extends StatelessWidget {
  const CharacterInspirationField({super.key});

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntFieldBase(
        label: "Inspiration",
        withSign: false,
        value: characterContext.character.hasInspiration()
            ? characterContext.character.inspiration
            : 0,
        valueChanged: (val) {
          if (val == 0) {
            characterContext.character.clearInspiration();
          } else {
            characterContext.character.inspiration = val;
          }
          characterContext.changed();
        },
      ),
    );
  }
}
