import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/stats_section/character_stat_field.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';

class CharacterStatsWidget extends StatelessWidget {
  const CharacterStatsWidget({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

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
        for (var stat in availableStats.take(3))
          Expanded(
            child: CharacterStatField(
              stat: stat,
              character: character,
              changed: changed,
            ),
          ),
        for (var stat in availableStats.skip(3))
          Expanded(
            child: CharacterStatField(
              stat: stat,
              character: character,
              changed: changed,
            ),
          ),
      ],
    );
  }
}
