import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/dice_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';

class CharacterHitDiceField extends StatefulWidget {
  const CharacterHitDiceField({super.key});

  @override
  State<CharacterHitDiceField> createState() => _CharacterHitDiceFieldState();
}

class _CharacterHitDiceFieldState extends State<CharacterHitDiceField> {
  FocusNode maxFocusNode = FocusNode();
  FocusNode currentFocusNode = FocusNode();

  @override
  void initState() {
    maxFocusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    currentFocusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    maxFocusNode.dispose();
    currentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Hit Dice",
        ),
        isFocused: currentFocusNode.hasFocus || maxFocusNode.hasFocus,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Total"),
                  Gap(8.0),
                  Expanded(
                    child: DiceFieldBase(
                      label: "Total Hit Dice",
                      inputBorder: UnderlineInputBorder(),
                      showLabel: false,
                      isDense: true,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(fontSize: 14),
                      focusNode: maxFocusNode,
                      value: characterContext.character.hitDiceMax,
                      isCalculated: true,
                      isOverridden: characterContext
                          .character
                          .life
                          .hitDiceMaxOverride
                          .isNotEmpty,
                      valueChanged: (val) {
                        characterContext.character.life.hitDiceMaxOverride
                            .clear();
                        characterContext.character.life.hitDiceMaxOverride
                            .addAll(val);
                        characterContext.changed();
                      },
                      resetValue: () {
                        characterContext.character.life.hitDiceMaxOverride
                            .clear();
                        characterContext.changed();
                      },
                    ),
                  ),
                ],
              ),
            ),
            DiceFieldBase(
              label: "Hit Dice",
              inputBorder: InputBorder.none,
              textAlign: TextAlign.center,
              textStyle: TextStyle(fontSize: 20),
              focusNode: currentFocusNode,
              value: characterContext.character.life.currentHitDice,
              valueChanged: (val) {
                characterContext.character.life.currentHitDice.clear();
                characterContext.character.life.currentHitDice.addAll(val);
                characterContext.changed();
              },
            ),
          ],
        ),
      ),
    );
  }
}
