import 'package:collection/collection.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_skill_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_alignment.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_life.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/options.pb.dart';

extension CharacterExtension on Character {
  void validate() {
    if (!hasOptions()) {
      options = Options();
    }
    if (!hasAlignment()) {
      alignment = CharacterAlignment();
    }
    if (!hasLife()) {
      life = CharacterLife();
    }
    if (!hasStats()) {
      stats = CharacterStats();
    }
    if (!hasSkills()) {
      skills = CharacterSkills();
    }
  }

  bool isProficient(CharacterSkill skill) {
    return skills.proficency.contains(skill) ||
        skills.proficencyCalculated.contains(skill);
  }

  int getSkillModifier(CharacterSkill skill) {
    var modifier = stats.getStatModifier(skill.associatedStat);
    if (isProficient(skill)) {
      modifier += proficiencyBonus;
    }
    return modifier;
  }

  int get totalLevel => classAndLevel.values.sum;

  int get proficiencyBonus {
    if (stats.hasOverrideProficencyBonus()) {
      return stats.overrideProficencyBonus;
    } else if (totalLevel >= 17) {
      return 6;
    } else if (totalLevel >= 13) {
      return 5;
    } else if (totalLevel >= 9) {
      return 4;
    } else if (totalLevel >= 5) {
      return 3;
    } else {
      return 2;
    }
  }
}
