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

  String get name {
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
      CharacterSkill.SleightOfHand => "Sleight of Hand",
      CharacterSkill.Stealth => "Stealth",
      CharacterSkill.Survival => "Survival",
      _ => "",
    };
  }
}
