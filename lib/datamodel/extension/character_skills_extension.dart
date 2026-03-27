import 'package:ttrpg_character_tools/datamodel/extension/character_skill_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pb.dart';

extension CharacterSkillsExtension on CharacterSkills {
  bool isProficient(CharacterSkill skill) {
    return proficency.contains(skill);
  }

  int getModifier(CharacterSkill skill, CharacterStats stats) {
    var modifier = stats.getStatModifier(skill.associatedStat);
    if (isProficient(skill)) {
      modifier += stats.profficencyBonus;
    }
    return modifier;
  }
}
