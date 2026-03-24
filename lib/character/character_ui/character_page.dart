import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:ttrpg_character_tools/character/character_manager.dart';
import 'package:ttrpg_character_tools/character/character_ui/character_life_section.dart';
import 'package:ttrpg_character_tools/character/character_ui/character_stats_section.dart';
import 'package:ttrpg_character_tools/character/character_ui/int_field_base.dart';
import 'package:ttrpg_character_tools/character/character_ui/text_field_base.dart';
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldBase(
                        label: "Name",
                        value: character.name,
                        valueChanged: (val) {
                          character.name = val;
                          changed();
                        },
                      ),
                    ),
                    Gap(8.0),
                    Expanded(
                      child: TextFieldBase(
                        label: "Background",
                        value: character.background,
                        valueChanged: (val) {
                          character.background = val;
                          changed();
                        },
                      ),
                    ),
                    Gap(8.0),
                    Expanded(
                      child: IntFieldBase(
                        label: "Experience Points",
                        value: character.xp,
                        valueChanged: (val) {
                          character.xp = val;
                          changed();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 200.0),
                    child: CharacterStatsSection(
                      character: character,
                      changed: changed,
                    ),
                  ),
                  Expanded(
                    child: CharacterLifeSection(
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
