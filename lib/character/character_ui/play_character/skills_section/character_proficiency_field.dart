import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';

class CharacterProficiencyField extends StatelessWidget {
  const CharacterProficiencyField({super.key});

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntFieldBase(
        label: "Proficiency",
        withSign: true,
        value: characterContext.character.proficiencyBonus,
        valueChanged: (val) {
          characterContext.character.stats.overrideProficencyBonus = val;
          characterContext.changed();
        },
        isCalculated: true,
        isOverridden: characterContext.character.stats
            .hasOverrideProficencyBonus(),
        resetValue: () async {
          characterContext.character.stats.clearOverrideProficencyBonus();
          characterContext.changed();
        },
      ),
    );
  }
}
