import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/util/int_extension.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';

class CharacterStatField extends StatefulWidget {
  const CharacterStatField({
    super.key,
    required this.stat,
    required this.isEditingBase,
    required this.minValue,
    required this.maxValue,
    this.hideModifier = false,
    this.changed,
  });

  final MapEntry<StatsType, String> stat;
  final bool isEditingBase;
  final int minValue;
  final int maxValue;
  final bool hideModifier;
  final Function()? changed;

  @override
  State<CharacterStatField> createState() => _CharacterStatFieldState();
}

class _CharacterStatFieldState extends State<CharacterStatField> {
  FocusNode focusNode = FocusNode();

  bool get isReadOnly => !widget.isEditingBase;

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
    var characterContext = CharacterContext.of(context);

    var field = IntFieldBase(
      label: widget.stat.value,
      inputBorder: InputBorder.none,
      textAlign: TextAlign.center,
      isDense: true,
      textStyle: widget.hideModifier ? TextStyle(fontSize: 22.0) : null,
      focusNode: focusNode,
      minValue: widget.minValue,
      maxValue: widget.maxValue,
      value: widget.isEditingBase
          ? characterContext.character.stats.getBaseStatValue(widget.stat.key)
          : characterContext.character.stats.getStatValue(widget.stat.key),
      valueChanged: widget.isEditingBase
          ? (val) {
              val = val.clamp(widget.minValue, widget.maxValue);
              characterContext.character.stats.base[widget.stat.key.value] =
                  val;
              characterContext.changed();
              widget.changed?.call();
            }
          : null,
    );

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
            padding: widget.hideModifier
                ? EdgeInsets.zero
                : const EdgeInsets.only(bottom: 20.0),
            child: GestureDetector(
              onTap: () {
                if (!isReadOnly) {
                  focusNode.requestFocus();
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: widget.stat.value,
                ),
                isFocused: focusNode.hasFocus && !isReadOnly,
                child: widget.hideModifier
                    ? field
                    : Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 14.0),
                        child: Text(
                          widget.isEditingBase
                              ? characterContext.character.stats
                                    .getBaseStatModifier(widget.stat.key)
                                    .toStringWithSign()
                              : characterContext.character.stats
                                    .getStatModifier(widget.stat.key)
                                    .toStringWithSign(),
                          style: TextStyle(fontSize: 28.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
          ),
          if (!widget.hideModifier)
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: focusNode.hasFocus && !isReadOnly
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey,
                        width: focusNode.hasFocus && !isReadOnly ? 2.0 : 1.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.elliptical(80, 50)),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: field,
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
