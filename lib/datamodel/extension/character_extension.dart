import 'package:collection/collection.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_class_info_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_skill_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/dice_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_alignment.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_life.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/dice.pb.dart';
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
    if (skills.overrides.containsKey(skill.value)) {
      return skills.overrides[skill.value]!;
    }
    var modifier = stats.getStatModifier(skill.associatedStat);
    if (isProficient(skill)) {
      modifier += proficiencyBonus;
    }
    return modifier;
  }

  bool isProficientSave(StatsType stat) {
    return stats.savingThrowProficency.contains(stat) ||
        stats.savingThrowProficencyCalculated.contains(stat);
  }

  int getSaveModifier(StatsType stat) {
    if (stats.savingThrowOverrides.containsKey(stat.value)) {
      return stats.savingThrowOverrides[stat.value]!;
    }
    var modifier = stats.getStatModifier(stat);
    if (isProficientSave(stat)) {
      modifier += proficiencyBonus;
    }
    return modifier;
  }

  int get totalLevel => classInfo.map((x) => x.classLevel).sum;

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

  Iterable<Dice> get hitDiceMax {
    if (life.hitDiceMaxOverride.isNotEmpty) {
      return life.hitDiceMaxOverride;
    }
    var dice = <Dice>[];
    for (var classInfo in classInfo) {
      var cl = classInfo.getClass();
      if (cl != null) {
        var hd = cl.hd.toDiceProto();
        hd.qty = classInfo.classLevel;
        dice.add(hd);
      }
    }
    return dice.combine();
  }
}
