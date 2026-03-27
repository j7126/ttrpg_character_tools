import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pb.dart';

extension CharacterStatsExtension on CharacterStats {
  int getStatValue(StatsType stat) {
    return current[stat.value] ?? base[stat.value] ?? 0;
  }

  int getStatModifier(StatsType stat) {
    final value = getStatValue(stat);
    return (value / 2 - 5).floor();
  }
}
