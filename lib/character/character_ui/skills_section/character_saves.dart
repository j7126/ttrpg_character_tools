import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/field_reset_button.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_skill_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/stats_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';

class CharacterSavesWidget extends StatelessWidget {
  const CharacterSavesWidget({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  static const List<StatsType> saves = [
    StatsType.Strength,
    StatsType.Dexterity,
    StatsType.Constitution,
    StatsType.Intelligence,
    StatsType.Wisdom,
    StatsType.Charisma,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: "Saving Throws",
          border: OutlineInputBorder(),
          isDense: true,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var save in saves)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor:
                        character.stats.savingThrowProficencyCalculated
                            .contains(save)
                        ? null
                        : ColorScheme.of(context).tertiary,
                    value: character.isProficientSave(save),
                    onChanged:
                        !character.isProficientSave(save) ||
                            character.stats.savingThrowProficency.contains(save)
                        ? (value) {
                            if (value == true) {
                              character.stats.savingThrowProficency.add(save);
                            } else {
                              character.stats.savingThrowProficency.remove(
                                save,
                              );
                            }
                            changed();
                          }
                        : null,
                  ),
                  SizedBox(
                    width: 36,
                    height: 22,
                    child: IntFieldBase(
                      label: "",
                      isDense: true,
                      withSign: true,
                      inputBorder: UnderlineInputBorder(),
                      textStyle: TextStyle(fontSize: 14),
                      value: character.getSaveModifier(save),
                      valueChanged: (val) {
                        character.stats.savingThrowOverrides[save.value] = val;
                        changed();
                      },
                      isCalculated: true,
                      hideResetButton: true,
                      isOverridden: character.stats.savingThrowOverrides
                          .containsKey(save.value),
                    ),
                  ),
                  Text(save.name),
                  Spacer(),
                  if (character.stats.savingThrowOverrides.containsKey(
                    save.value,
                  ))
                    FieldResetButton(
                      resetValue: () {
                        character.stats.savingThrowOverrides.remove(save.value);
                        changed();
                      },
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
