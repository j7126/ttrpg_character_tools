import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';
import 'package:ttrpg_character_tools/util/int_extension.dart';

class CharacterStatField extends StatefulWidget {
  const CharacterStatField({
    super.key,
    required this.stat,
    required this.character,
    required this.changed,
  });

  final MapEntry<StatsType, String> stat;
  final Character character;
  final Function() changed;

  @override
  State<CharacterStatField> createState() => _CharacterStatFieldState();
}

class _CharacterStatFieldState extends State<CharacterStatField> {
  FocusNode focusNode = FocusNode();

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void initState() {
    focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        right: 8.0,
        bottom: 6.0,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: GestureDetector(
              onTap: () {
                focusNode.requestFocus();
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: widget.stat.value,
                ),
                isFocused: focusNode.hasFocus,
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0, bottom: 18.0),
                  child: Text(
                    widget.character.stats
                        .getStatModifier(widget.stat.key)
                        .toStringWithSign(),
                    style: TextStyle(fontSize: 32.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: focusNode.hasFocus
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                      width: focusNode.hasFocus ? 2.0 : 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.elliptical(80, 50)),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  width: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IntFieldBase(
                      label: widget.stat.value,
                      inputBorder: InputBorder.none,
                      textAlign: TextAlign.center,
                      isDense: true,
                      focusNode: focusNode,
                      value:
                          widget.character.stats.getStatValue(widget.stat.key),
                      valueChanged: (val) {
                        widget.character.stats.base[widget.stat.key.value] =
                            val;
                        widget.character.stats.current[widget.stat.key.value] =
                            val;
                        widget.changed();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
