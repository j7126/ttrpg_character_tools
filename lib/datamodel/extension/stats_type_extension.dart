import 'package:render_ttrpg_data/datamodel/5e/data/ability.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';

extension StatsTypeExtension on StatsType {
  String get name {
    return switch (this) {
      StatsType.Strength => "Strength",
      StatsType.Dexterity => "Dexterity",
      StatsType.Constitution => "Constitution",
      StatsType.Intelligence => "Intelligence",
      StatsType.Wisdom => "Wisdom",
      StatsType.Charisma => "Charisma",
      _ => "",
    };
  }

  String get shortName {
    return switch (this) {
      StatsType.Strength => "STR",
      StatsType.Dexterity => "DEX",
      StatsType.Constitution => "CON",
      StatsType.Intelligence => "INT",
      StatsType.Wisdom => "WIS",
      StatsType.Charisma => "CHA",
      _ => "",
    };
  }

  Ability toAbility() => switch (this) {
    StatsType.Strength => Ability.str,
    StatsType.Dexterity => Ability.dex,
    StatsType.Constitution => Ability.con,
    StatsType.Intelligence => Ability.int,
    StatsType.Wisdom => Ability.wis,
    StatsType.Charisma => Ability.cha,
    _ => Ability.values.first,
  };
}

extension AbilityStatsTypeExtension on Ability {
  StatsType toStatsType() => switch (this) {
    Ability.str => StatsType.Strength,
    Ability.dex => StatsType.Dexterity,
    Ability.con => StatsType.Constitution,
    Ability.int => StatsType.Intelligence,
    Ability.wis => StatsType.Wisdom,
    Ability.cha => StatsType.Charisma,
    _ => StatsType.values.first,
  };
}
