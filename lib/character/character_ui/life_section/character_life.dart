import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/character/character_ui/life_section/character_death_saves.dart';
import 'package:ttrpg_character_tools/character/character_ui/life_section/character_hit_dice_field.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class CharacterLifeWidget extends StatefulWidget {
  const CharacterLifeWidget({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  @override
  State<CharacterLifeWidget> createState() => _CharacterLifeWidgetState();
}

class _CharacterLifeWidgetState extends State<CharacterLifeWidget> {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Hit Points",
            ),
            isFocused: currentFocusNode.hasFocus || maxFocusNode.hasFocus,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Maximum"),
                      Gap(8.0),
                      Expanded(
                        child: IntFieldBase(
                          label: "Hit Point Maximum",
                          inputBorder: UnderlineInputBorder(),
                          showLabel: false,
                          isDense: true,
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(fontSize: 14),
                          focusNode: maxFocusNode,
                          value: widget.character.life.maxHitPointsQty,
                          valueChanged: (val) {
                            widget.character.life.maxHitPointsQty = val;
                            widget.changed();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                IntFieldBase(
                  label: "Current Hit Points",
                  inputBorder: InputBorder.none,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(fontSize: 20),
                  focusNode: currentFocusNode,
                  value: widget.character.life.hitPoints,
                  valueChanged: (val) {
                    widget.character.life.hitPoints = val;
                    widget.changed();
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntFieldBase(
            label: "Temporary Hit Points",
            value: widget.character.life.temporaryHitPoints,
            valueChanged: (val) {
              widget.character.life.temporaryHitPoints = val;
              widget.changed();
            },
            emptyIsZero: true,
          ),
        ),
        CharacterHitDiceField(
          character: widget.character,
          changed: widget.changed,
        ),
        if (widget.character.life.hitPoints == 0)
          CharacterDeathSaves(
            character: widget.character,
            changed: widget.changed,
          ),
      ],
    );
  }
}
