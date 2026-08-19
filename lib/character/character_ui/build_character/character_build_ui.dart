import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/build_character/character_choice_card.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/character_info.dart';

class CharacterBuildUi extends StatelessWidget {
  const CharacterBuildUi({super.key});

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CharacterInfoWidget(),
            for (var choice in CharacterContext.of(context).characterChoices)
              CharacterChoiceCard(
                choice: choice,
                character: characterContext.character,
                changed: characterContext.changed,
              ),
          ],
        ),
      ),
    );
  }
}
