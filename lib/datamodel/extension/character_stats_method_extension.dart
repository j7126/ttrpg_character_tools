import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pb.dart';

extension CharacterStatsMethodExtension on StatsMethod {
  String get displayName => switch (this) {
    StatsMethod.StatsStandardArray => "Standard Array",
    StatsMethod.StatsPointBuy => "Point Buy",
    StatsMethod.StatsManual => "Rolled",
    _ => name,
  };
}
