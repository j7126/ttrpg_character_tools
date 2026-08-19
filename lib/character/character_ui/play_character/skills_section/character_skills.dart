import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/field_reset_button.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_skill_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/stats_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';

class CharacterSkillsWidget extends StatelessWidget {
  const CharacterSkillsWidget({super.key});

  static const List<CharacterSkill> skills = [
    CharacterSkill.Acrobatics,
    CharacterSkill.AnimalHandling,
    CharacterSkill.Arcana,
    CharacterSkill.Athletics,
    CharacterSkill.Deception,
    CharacterSkill.History,
    CharacterSkill.Insight,
    CharacterSkill.Intimidation,
    CharacterSkill.Investigation,
    CharacterSkill.Medicine,
    CharacterSkill.Nature,
    CharacterSkill.Perception,
    CharacterSkill.Performance,
    CharacterSkill.Persuasion,
    CharacterSkill.Religion,
    CharacterSkill.SleightOfHand,
    CharacterSkill.Stealth,
    CharacterSkill.Survival,
  ];

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: "Skills",
          border: OutlineInputBorder(),
          isDense: true,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var skill in skills)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor:
                        characterContext.character.skills.proficencyCalculated
                            .contains(skill)
                        ? null
                        : ColorScheme.of(context).tertiary,
                    value: characterContext.character.isProficient(skill),
                    onChanged:
                        !characterContext.character.isProficient(skill) ||
                            characterContext.character.skills.proficency
                                .contains(skill)
                        ? (value) {
                            if (value == true) {
                              characterContext.character.skills.proficency.add(
                                skill,
                              );
                            } else {
                              characterContext.character.skills.proficency
                                  .remove(skill);
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
                      value: characterContext.character.getSkillModifier(skill),
                      valueChanged: (val) {
                        characterContext.character.skills.overrides[skill
                                .value] =
                            val;
                        characterContext.changed();
                      },
                      isCalculated: true,
                      hideResetButton: true,
                      isOverridden: characterContext.character.skills.overrides
                          .containsKey(skill.value),
                    ),
                  ),
                  Text(skill.name),
                  Text(" (${skill.associatedStat.shortName})"),
                  Spacer(),
                  if (characterContext.character.skills.overrides.containsKey(
                    skill.value,
                  ))
                    FieldResetButton(
                      resetValue: () {
                        characterContext.character.skills.overrides.remove(
                          skill.value,
                        );
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
