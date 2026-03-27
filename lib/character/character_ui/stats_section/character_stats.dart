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
    return Container(
      constraints: BoxConstraints(maxWidth: 140.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var stat in availableStats)
            CharacterStatField(
              stat: stat,
              character: character,
              changed: changed,
            ),
        ],
      ),
    );
  }
}
