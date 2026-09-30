import 'package:collection/collection.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/background/background.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/interface/ability_bonus/ability_bonus_mixin.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/interface/skill_proficiency/skill_proficiency_mixin.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/race/race.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/race/subrace/sub_race.dart';
import 'package:ttrpg_character_tools/character/character_ui/calculated_value/integer_calculated_model.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_class_info_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_skill_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_skills_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/dice_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_alignment.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_class_info.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_life.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_spells.pb.dart';
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
    if (!hasSpells()) {
      spells = CharacterSpells();
    }
  }

  bool get isValid {
    return life.maxHitPointsQty > 0;
  }

  bool isProficient(CharacterSkill skill) {
    return skills.overrideProficency.contains(skill) ||
        skills.currentProficency.contains(skill);
  }

  IntegerCalculatedModel getSkillModifier(CharacterSkill skill) {
    List<IntegerCalculatedModel> children = [];

    if (skills.overrides.containsKey(skill.value)) {
      return IntegerCalculatedModel(
        value: skills.overrides[skill.value]!,
        name: "${skill.displayName} (Override)",
      );
    }
    var modifier = stats.getStatModifier(skill.associatedStat);
    children.add(
      IntegerCalculatedModel(value: modifier, name: skill.associatedStat.name),
    );
    if (isProficient(skill)) {
      modifier += proficiencyBonus;
      children.add(
        IntegerCalculatedModel(value: proficiencyBonus, name: "Proficency"),
      );
    }

    return IntegerCalculatedModel(
      value: modifier,
      name: skill.displayName,
      children: children,
    );
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

  Race? getRace() {
    if (hasRace() && race.isNotEmpty) {
      var parts = race.split("|");
      var name = parts[0];
      var source = parts.length > 1 ? parts[1] : null;
      return DataModel5e.races.firstWhereOrNull(
        (x) => x.name == name && (source == null || x.source == source),
      );
    }

    return null;
  }

  SubRace? getSubRace() {
    if (hasSubRace() && subRace.isNotEmpty) {
      return DataModel5e.subRaces.firstWhereOrNull(
        (x) => x.refCompare(subRace),
      );
    }

    return null;
  }

  Background? getBackground() {
    if (hasBackground() && background.isNotEmpty) {
      return DataModel5e.backgrounds.firstWhereOrNull(
        (x) => x.refCompare(background),
      );
    }

    return null;
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

  void applyRulesData(List<(dynamic, CharacterClassInfo?)> allRulesObjs) {
    // skill proficiency
    var initialClassName = classInfo.firstOrNull?.className;
    var skillProficiencyProviders = allRulesObjs
        .where(
          (x) =>
              !(x.$1 is Class5e &&
                  initialClassName != null &&
                  x.$1.name != initialClassName),
        )
        .map((x) {
          var obj = x.$1;
          return obj is SkillProficiencyMixin &&
                  obj.skillProficiencies != null &&
                  obj.skillProficiencies!.isNotEmpty
              ? obj
              : null;
        })
        .nonNulls
        .toList();
    for (var provider in skillProficiencyProviders) {
      var choice = skills.proficencyChoices.firstWhereOrNull(
        (x) => x.providerRef == provider.refString,
      );
      if (choice == null) {
        choice = CharacterProficencyChoice(providerRef: provider.refString);
        skills.proficencyChoices.add(choice);
      }
      if (provider.skillProficiencies != null) {
        for (var prof in provider.skillProficiencies!) {
          for (var fixedSkill in prof.fixedSkills) {
            if (!choice.fixed.contains(fixedSkill.toCharacterSkill())) {
              choice.fixed.add(fixedSkill.toCharacterSkill());
            }
          }
        }
        for (var i = 0; i < choice.choices.length;) {
          if (provider.skillProficiencies!.isEmpty ||
              !provider.skillProficiencies!.first.chooseSkills.contains(
                choice.choices[i].toSkill(),
              ) ||
              i + 1 > provider.skillProficiencies!.first.chooseNumber) {
            choice.choices.removeAt(i);
          } else {
            i++;
          }
        }
        for (var i = 0; i < choice.choicesAny.length;) {
          if (provider.skillProficiencies!.isEmpty ||
              i + 1 > provider.skillProficiencies!.first.numAny) {
            choice.choicesAny.removeAt(i);
          } else {
            i++;
          }
        }
      }
    }
    var skillProficiencyProvidersRefSet = skillProficiencyProviders
        .map((x) => x.refString)
        .toSet();
    for (var val
        in skills.proficencyChoices
            .where(
              (x) => !skillProficiencyProvidersRefSet.contains(x.providerRef),
            )
            .toList()) {
      skills.proficencyChoices.remove(val);
    }
    skills.applyChoices();

    // ability bonus
    var abilityBonusProvidersRefSet = allRulesObjs
        .map((x) {
          var obj = x.$1;
          return obj is AbilityBonusMixin ? obj : null;
        })
        .nonNulls
        .map((x) => x.refString)
        .toSet();
    for (var val
        in stats.characterStatsSelections
            .where((x) => !abilityBonusProvidersRefSet.contains(x.providerRef))
            .toList()) {
      stats.characterStatsSelections.remove(val);
    }
    stats.applyChoices();
  }
}
