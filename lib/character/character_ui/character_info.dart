import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/text_field_base.dart';
import 'package:ttrpg_character_tools/character/character_ui/class_selection/class_field.dart';
import 'package:ttrpg_character_tools/character/character_ui/race_field.dart';
import 'package:ttrpg_character_tools/datamodel/generated/options.pb.dart';

class CharacterInfoWidget extends StatelessWidget {
  const CharacterInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

    return Row(
      children: [
        Expanded(child: ClassField()),
        Expanded(child: RaceField()),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldBase(
              label: "Background",
              value: characterContext.character.background,
              valueChanged: (val) {
                characterContext.character.background = val;
                characterContext.changed();
              },
            ),
          ),
        ),
        if (characterContext.character.options.hasLevelingMethod() &&
            characterContext.character.options.levelingMethod ==
                LevelingMethod.XP)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntFieldBase(
                label: "Experience Points",
                value: characterContext.character.xp,
                valueChanged: (val) {
                  characterContext.character.xp = val;
                  characterContext.changed();
                },
              ),
            ),
          ),
      ],
    );
  }
}
