import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/text_field_base.dart';
import 'package:ttrpg_character_tools/character/character_ui/class_selection/class_field.dart';
import 'package:ttrpg_character_tools/character/character_ui/race_field.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/options.pb.dart';

class CharacterInfoWidget extends StatelessWidget {
  const CharacterInfoWidget({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldBase(
              label: "Name",
              value: character.name,
              valueChanged: (val) {
                character.name = val;
                changed();
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: ClassField(character: character, changed: changed),
              ),
              Expanded(
                child: RaceField(character: character, changed: changed),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldBase(
                    label: "Background",
                    value: character.background,
                    valueChanged: (val) {
                      character.background = val;
                      changed();
                    },
                  ),
                ),
              ),
              if (character.options.hasLevelingMethod() &&
                  character.options.levelingMethod == LevelingMethod.XP)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IntFieldBase(
                      label: "Experience Points",
                      value: character.xp,
                      valueChanged: (val) {
                        character.xp = val;
                        changed();
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
