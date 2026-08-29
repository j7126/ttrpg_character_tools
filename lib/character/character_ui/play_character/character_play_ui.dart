import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/character_info.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/features_and_traits_section/character_features.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/life_section/character_life.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/skills_section/character_inspiration_field.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/skills_section/character_proficiency_field.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/skills_section/character_saves.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/skills_section/character_skills.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/spells_section/character_spells.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/stats_section/character_stats.dart';

class CharacterPlayUi extends StatelessWidget {
  const CharacterPlayUi({super.key});

  @override
  Widget build(BuildContext context) {
    Widget tabContent(_CharacterPageTabs tab) => switch (tab) {
      _CharacterPageTabs.info => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // character stats
          CharacterStatsWidget(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // character skills section
              Container(
                constraints: BoxConstraints(maxWidth: 280.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // proficiency bonus
                    Row(
                      children: [
                        Expanded(child: CharacterInspirationField()),
                        Expanded(
                          child: CharacterProficiencyField(),
                        ),
                      ],
                    ),
                    // saving throws
                    CharacterSavesWidget(),
                    // skills
                    CharacterSkillsWidget(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    CharacterLifeWidget(),
                    CharacterFeatures(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      _CharacterPageTabs.spells => CharacterSpells(),
      _ => Container(),
    };

    return DefaultTabController(
      length: _CharacterPageTabs.values.length,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // character info
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: CharacterInfoWidget(),
          ),
          TabBar(
            tabs: [
              for (var tab in _CharacterPageTabs.values)
                Tab(child: Text(tab.name)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                for (var tab in _CharacterPageTabs.values)
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: tabContent(tab),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _CharacterPageTabs {
  info("Stats & Info"),
  spells("Spells"),
  items("Items & Equipment");

  final String name;

  const _CharacterPageTabs(this.name);
}
