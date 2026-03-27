import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/dice_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class CharacterHitDiceField extends StatefulWidget {
  const CharacterHitDiceField({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

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
                      value: widget.character.life.hitDice,
                      valueChanged: (val) {
                        widget.character.life.hitDice.clear();
                        widget.character.life.hitDice.addAll(val);
                        widget.changed();
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
              value: widget.character.life.currentHitDice,
              valueChanged: (val) {
                widget.character.life.currentHitDice.clear();
                widget.character.life.currentHitDice.addAll(val);
                widget.changed();
              },
            ),
          ],
        ),
      ),
    );
  }
}
