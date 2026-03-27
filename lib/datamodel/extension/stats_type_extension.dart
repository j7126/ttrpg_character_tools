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
}
