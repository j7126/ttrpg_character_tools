import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/character/character_ui/life_section/character_death_saves.dart';
import 'package:ttrpg_character_tools/character/character_ui/life_section/character_hit_dice_field.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class CharacterLifeWidget extends StatelessWidget {
  const CharacterLifeWidget({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntFieldBase(
            label: "Hit Point Maximum",
            value: character.life.maxHitPointsQty,
            valueChanged: (val) {
              character.life.maxHitPointsQty = val;
              changed();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntFieldBase(
            label: "Current Hit Points",
            value: character.life.hitPoints,
            valueChanged: (val) {
              character.life.hitPoints = val;
              changed();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntFieldBase(
            label: "Temporary Hit Points",
            value: character.life.temporaryHitPoints,
            valueChanged: (val) {
              character.life.temporaryHitPoints = val;
              changed();
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CharacterHitDiceField(
                character: character,
                changed: changed,
              ),
            ),
            Expanded(
              child: CharacterDeathSaves(
                character: character,
                changed: changed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
