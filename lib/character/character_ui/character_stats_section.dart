import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/character/character_ui/int_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';
import 'package:ttrpg_character_tools/util/int_extension.dart';

class CharacterStatsSection extends StatelessWidget {
  const CharacterStatsSection({
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var stat in availableStats)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(4.0),
                  Text(
                    stat.value,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    character.stats.base[stat.key.value] == null
                        ? "?"
                        : (character.stats.base[stat.key.value]! / 2 - 5)
                              .floor()
                              .toStringWithSign(),
                    style: TextStyle(fontSize: 28.0),
                  ),
                  IntFieldBase(
                    label: stat.value,
                    outlined: false,
                    value: character.stats.base[stat.key.value] ?? 0,
                    valueChanged: (val) {
                      character.stats.base[stat.key.value] = val;
                      character.stats.current[stat.key.value] = val;
                      changed();
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
