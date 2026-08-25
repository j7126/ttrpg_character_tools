import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/stats_section/character_stat_field.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';

class CharacterStatsWidget extends StatelessWidget {
  const CharacterStatsWidget({
    super.key,
    this.isEditingBase = false,
    this.minValue = 0,
    this.maxValue = 20,
  });

  final bool isEditingBase;
  final int minValue;
  final int maxValue;

  static const List<MapEntry<StatsType, String>> availableStats = [
    MapEntry(StatsType.Strength, "Strength"),
    MapEntry(StatsType.Dexterity, "Dexterity"),
    MapEntry(StatsType.Constitution, "Constitution"),
    MapEntry(StatsType.Intelligence, "Intelligence"),
    MapEntry(StatsType.Wisdom, "Wisdom"),
    MapEntry(StatsType.Charisma, "Charisma"),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var stat in availableStats)
          Expanded(
            child: CharacterStatField(
              stat: stat,
              isEditingBase: isEditingBase,
              minValue: minValue,
              maxValue: maxValue,
            ),
          ),
      ],
    );
  }
}
