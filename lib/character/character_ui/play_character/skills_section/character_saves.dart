import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/field_reset_button.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';

class CharacterSavesWidget extends StatelessWidget {
  const CharacterSavesWidget({super.key});

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
    var characterContext = CharacterContext.of(context);

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
                        characterContext
                            .character
                            .stats
                            .savingThrowProficencyCalculated
                            .contains(save)
                        ? null
                        : ColorScheme.of(context).tertiary,
                    value: characterContext.character.isProficientSave(save),
                    onChanged:
                        !characterContext.character.isProficientSave(save) ||
                            characterContext
                                .character
                                .stats
                                .savingThrowProficency
                                .contains(save)
                        ? (value) {
                            if (value == true) {
                              characterContext
                                  .character
                                  .stats
                                  .savingThrowProficency
                                  .add(save);
                            } else {
                              characterContext
                                  .character
                                  .stats
                                  .savingThrowProficency
                                  .remove(save);
                            }
                            characterContext.changed();
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
                      value: characterContext.character.getSaveModifier(save),
                      valueChanged: (val) {
                        characterContext
                                .character
                                .stats
                                .savingThrowOverrides[save.value] =
                            val;
                        characterContext.changed();
                      },
                      isCalculated: true,
                      hideResetButton: true,
                      isOverridden: characterContext
                          .character
                          .stats
                          .savingThrowOverrides
                          .containsKey(save.value),
                    ),
                  ),
                  Text(save.name),
                  Spacer(),
                  if (characterContext.character.stats.savingThrowOverrides
                      .containsKey(save.value))
                    FieldResetButton(
                      resetValue: () {
                        characterContext.character.stats.savingThrowOverrides
                            .remove(save.value);
                        characterContext.changed();
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
