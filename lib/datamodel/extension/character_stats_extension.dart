import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pb.dart';

extension CharacterStatsExtension on CharacterStats {
  int getStatValue(StatsType stat) {
    return current[stat.value] ?? base[stat.value] ?? 0;
  }

  int getBaseStatValue(StatsType stat) {
    return base[stat.value] ?? 0;
  }

  int getStatModifier(StatsType stat) {
    final value = getStatValue(stat);
    return (value / 2 - 5).floor();
  }

  int getBaseStatModifier(StatsType stat) {
    final value = getBaseStatValue(stat);
    return (value / 2 - 5).floor();
  }

  void applyChoices() {
    for (var stat in StatsType.values) {
      var val = base[stat.value];
      if (val != null) {
        var currentVal = val;
        for (var selection in characterStatsSelections) {
          currentVal += selection.currentMods[stat.value] ?? 0;
          currentVal += selection.fixedMods[stat.value] ?? 0;
        }
        currentVal = currentVal.clamp(0, 20);
        current[stat.value] = currentVal;
      } else {
        current.remove(stat.value);
      }
    }
  }
}
