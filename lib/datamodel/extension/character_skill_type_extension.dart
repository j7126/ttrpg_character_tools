import 'package:render_ttrpg_data/datamodel/5e/data/skill.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';

extension CharacterSkillTypeExtension on CharacterSkill {
  StatsType get associatedStat {
    switch (this) {
      case CharacterSkill.Acrobatics:
      case CharacterSkill.SleightOfHand:
      case CharacterSkill.Stealth:
        return StatsType.Dexterity;
      case CharacterSkill.AnimalHandling:
      case CharacterSkill.Insight:
      case CharacterSkill.Medicine:
      case CharacterSkill.Perception:
      case CharacterSkill.Survival:
        return StatsType.Wisdom;
      case CharacterSkill.Arcana:
      case CharacterSkill.History:
      case CharacterSkill.Investigation:
      case CharacterSkill.Nature:
      case CharacterSkill.Religion:
        return StatsType.Intelligence;
      case CharacterSkill.Athletics:
        return StatsType.Strength;
      case CharacterSkill.Deception:
      case CharacterSkill.Intimidation:
      case CharacterSkill.Performance:
      case CharacterSkill.Persuasion:
        return StatsType.Charisma;
      default:
        throw Exception("Unknown skill: $this");
    }
  }

  String get displayName {
    return switch (this) {
      CharacterSkill.Acrobatics => "Acrobatics",
      CharacterSkill.AnimalHandling => "Animal Handling",
      CharacterSkill.Arcana => "Arcana",
      CharacterSkill.Athletics => "Athletics",
      CharacterSkill.Deception => "Deception",
      CharacterSkill.History => "History",
      CharacterSkill.Insight => "Insight",
      CharacterSkill.Intimidation => "Intimidation",
      CharacterSkill.Investigation => "Investigation",
      CharacterSkill.Medicine => "Medicine",
      CharacterSkill.Nature => "Nature",
      CharacterSkill.Perception => "Perception",
      CharacterSkill.Performance => "Performance",
      CharacterSkill.Persuasion => "Persuasion",
      CharacterSkill.Religion => "Religion",
      CharacterSkill.SleightOfHand => "Sleight of Hand",
      CharacterSkill.Stealth => "Stealth",
      CharacterSkill.Survival => "Survival",
      _ => "",
    };
  }

  Skill toSkill() => switch (this) {
    CharacterSkill.Acrobatics => Skill.acrobatics,
    CharacterSkill.AnimalHandling => Skill.animalHandling,
    CharacterSkill.Arcana => Skill.arcana,
    CharacterSkill.Athletics => Skill.athletics,
    CharacterSkill.Deception => Skill.deception,
    CharacterSkill.History => Skill.history,
    CharacterSkill.Insight => Skill.insight,
    CharacterSkill.Intimidation => Skill.intimidation,
    CharacterSkill.Investigation => Skill.investigation,
    CharacterSkill.Medicine => Skill.medicine,
    CharacterSkill.Nature => Skill.nature,
    CharacterSkill.Perception => Skill.perception,
    CharacterSkill.Performance => Skill.performance,
    CharacterSkill.Persuasion => Skill.persuasion,
    CharacterSkill.Religion => Skill.religion,
    CharacterSkill.SleightOfHand => Skill.sleightOfHand,
    CharacterSkill.Stealth => Skill.stealth,
    CharacterSkill.Survival => Skill.survival,
    _ => throw Exception("Invalid Skill"),
  };
}

extension SkillTypeExtension on Skill {
  CharacterSkill toCharacterSkill() => switch (this) {
    Skill.acrobatics => CharacterSkill.Acrobatics,
    Skill.animalHandling => CharacterSkill.AnimalHandling,
    Skill.arcana => CharacterSkill.Arcana,
    Skill.athletics => CharacterSkill.Athletics,
    Skill.deception => CharacterSkill.Deception,
    Skill.history => CharacterSkill.History,
    Skill.insight => CharacterSkill.Insight,
    Skill.intimidation => CharacterSkill.Intimidation,
    Skill.investigation => CharacterSkill.Investigation,
    Skill.medicine => CharacterSkill.Medicine,
    Skill.nature => CharacterSkill.Nature,
    Skill.perception => CharacterSkill.Perception,
    Skill.performance => CharacterSkill.Performance,
    Skill.persuasion => CharacterSkill.Persuasion,
    Skill.religion => CharacterSkill.Religion,
    Skill.sleightOfHand => CharacterSkill.SleightOfHand,
    Skill.stealth => CharacterSkill.Stealth,
    Skill.survival => CharacterSkill.Survival,
  };
}
