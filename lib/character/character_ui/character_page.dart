import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:ttrpg_character_tools/character/character_manager.dart';
import 'package:ttrpg_character_tools/character/character_ui/character_info.dart';
import 'package:ttrpg_character_tools/character/character_ui/features_and_traits_section/class_features.dart';
import 'package:ttrpg_character_tools/character/character_ui/life_section/character_life.dart';
import 'package:ttrpg_character_tools/character/character_ui/skills_section/character_proficiency_field.dart';
import 'package:ttrpg_character_tools/character/character_ui/skills_section/character_skills.dart';
import 'package:ttrpg_character_tools/character/character_ui/stats_section/character_stats.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/pages/page_scaffold.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  void changed() {
    setState(() {
      CharacterManager.instance.saveCharacter();
    });
  }

  void _dataLoaderReadyListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    DataLoader.loadData();
    DataLoader.readyNotifier.addListener(_dataLoaderReadyListener);
    super.initState();
  }

  @override
  void dispose() {
    DataLoader.readyNotifier.removeListener(_dataLoaderReadyListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var character = CharacterManager.instance.character;

    var adaptiveInfo = AdaptiveInfo.of(context);

    if (!CharacterManager.instance.isOpen || character == null) {
      return PageScaffold(
        adaptiveInfo: adaptiveInfo,
        title: "Character",
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("You don't have a character open."),
              Gap(16.0),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/characters");
                },
                child: Text("Open Character"),
              ),
            ],
          ),
        ),
      );
    }

    return PageScaffold(
      adaptiveInfo: adaptiveInfo,
      title: character.name.isEmpty ? "Character" : character.name,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // character info
              CharacterInfoWidget(character: character, changed: changed),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // character stats
                  CharacterStatsWidget(character: character, changed: changed),
                  // character skills section
                  Container(
                    constraints: BoxConstraints(maxWidth: 280.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // profficency bonus
                        CharacterProficiencyField(
                          character: character,
                          changed: changed,
                        ),
                        // skills
                        CharacterSkillsWidget(
                          character: character,
                          changed: changed,
                        ),
                      ],
                    ),
                  ),
                  // life section
                  Expanded(
                    child: CharacterLifeWidget(
                      character: character,
                      changed: changed,
                    ),
                  ),
                  Expanded(
                    child: ClassFeatures(
                      character: character,
                      changed: changed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
