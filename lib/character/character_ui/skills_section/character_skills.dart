import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_skill_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/stats_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';

class CharacterSkillsWidget extends StatelessWidget {
  const CharacterSkillsWidget({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

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
                    value: character.skills.proficency.contains(skill),
                    onChanged: (value) {
                      if (value == true) {
                        character.skills.proficency.add(skill);
                      } else {
                        character.skills.proficency.remove(skill);
                      }
                      changed();
                    },
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
                      value: character.getSkillModifier(skill),
                      valueChanged: (val) {},
                    ),
                  ),
                  Text(skill.name),
                  Text(" (${skill.associatedStat.shortName})"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
