import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/data_views/generic/entry_view/text_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/generic/entry.dart';
import 'package:render_ttrpg_data/theme/text_style_extension.dart';
import 'package:render_ttrpg_data/theme/text_styles.dart';
import 'package:render_ttrpg_data/widgets/fixed_thumb_scroll_view.dart';
import 'package:ttrpg_character_tools/character/character_ui/build_character/character_choice.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_build_choice.pb.dart';

class CharacterChoiceCard extends StatefulWidget {
  const CharacterChoiceCard({
    super.key,
    required this.choice,
    required this.character,
    required this.changed,
    this.hasExpansionPanel = true,
    this.scrollable = false,
    this.card = true,
  });

  final CharacterChoice choice;
  final Character character;
  final Function() changed;
  final bool hasExpansionPanel;
  final bool scrollable;
  final bool card;

  @override
  State<CharacterChoiceCard> createState() => _CharacterChoiceCardState();
}

class _CharacterChoiceCardState extends State<CharacterChoiceCard> {
  ExpansibleController controller = ExpansibleController();
  bool hasBeenAutoCollapsed = false;

  void valueChanged(CharacterBuildChoiceSelection? val, bool? state) {
    if (val == null) {
      state = false;
    }

    // get the choice obj for this choice
    var obj = widget.character.characterBuildChoices[widget.choice.reference];
    var priorLen = obj?.choice.length ?? 0;
    if (obj == null) {
      // create it if not exists
      if (state != false) {
        obj = CharacterBuildChoice(
          choice: [val!],
          maxSelectedQty: widget.choice.chooseQty,
        );
        widget.character.characterBuildChoices[widget.choice.reference] = obj;
      }
    } else {
      // update maxSelectedQty
      if (obj.maxSelectedQty != widget.choice.chooseQty) {
        obj.maxSelectedQty = widget.choice.chooseQty;
      }

      // add or remove the selection
      var hasAlready = obj.choice.any((x) => x.choiceName == val?.choiceName);
      if (val == null) {
        obj.choice.clear();
      } else if (state == true || (state == null && !hasAlready)) {
        if (!hasAlready) {
          if (obj.choice.length >= obj.maxSelectedQty) {
            obj.choice.removeAt(0);
          }
          obj.choice.add(val);
        }
      } else {
        obj.choice.removeWhere((x) => x.choiceName == val.choiceName);
      }
    }
    // collapse the view if all selected for the first time
    if (!hasBeenAutoCollapsed &&
        obj != null &&
        priorLen == 0 &&
        obj.choice.length >= obj.maxSelectedQty) {
      controller.collapse();
      hasBeenAutoCollapsed = true;
    }
    setState(() {
      widget.changed();
    });
  }

  @override
  void initState() {
    var choice =
        widget.character.characterBuildChoices[widget.choice.reference];
    if (choice == null || choice.choice.length < widget.choice.chooseQty) {
      controller.expand();
    } else {
      controller.collapse();
      hasBeenAutoCollapsed = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentValue = widget.choice.getCurrentChoice(widget.character);

    var children = <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text("Choose ${widget.choice.chooseQty}:"),
      ),
      for (var option in widget.choice.options)
        ListTile(
          title: TextView(
            option.hasChoiceReference() && option.choiceReference.isNotEmpty
                ? option.choiceReference
                : option.choiceName,
          ),
          onTap: () => valueChanged(option, null),
          leading: widget.choice.hasProgression
              ? Checkbox(
                  value:
                      currentValue?.choice.any(
                        (x) => x.choiceName == option.choiceName,
                      ) ??
                      false,
                  onChanged: (val) {
                    valueChanged(option, val);
                  },
                )
              : Radio<CharacterBuildChoiceSelection>(value: option),
        ),
    ];

    Widget child = widget.hasExpansionPanel
        ? ExpansionTile(
            controller: controller,
            onExpansionChanged: (value) {
              setState(() {});
            },
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextView(
                    widget.choice.reference,
                    style: TextStyles.of(context).headline1,
                    hiddenEntryTypes: {FeatureEntryType.options},
                  ),
                  if (!controller.isExpanded) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 6.0),
                      child: Icon(
                        Icons.arrow_forward,
                        size: TextTheme.of(context).bodyLarge?.fontSize,
                        color: TextTheme.of(context).bodyLarge?.color,
                      ),
                    ),
                    Text(
                      currentValue?.choice
                              .map((x) => x.choiceName)
                              .join(", ") ??
                          "",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                  ],
                  Spacer(),
                  Text(
                    widget.choice.sourceLabel,
                    style: TextTheme.of(context).bodyMedium?.withAlpha(200),
                  ),
                ],
              ),
            ),
            enabled:
                currentValue != null &&
                currentValue.choice.length >= widget.choice.chooseQty,
            dense: true,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            expandedAlignment: AlignmentGeometry.centerLeft,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            tilePadding: EdgeInsets.symmetric(horizontal: 8),
            children: children,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );

    child = RadioGroup<CharacterBuildChoiceSelection>(
      groupValue: currentValue?.choice.firstOrNull,
      onChanged: (val) => valueChanged(val, val != null),
      child: child,
    );

    if (widget.card) {
      child = Card(clipBehavior: Clip.hardEdge, child: child);
    }
    if (widget.scrollable) {
      child = FixedThumbScrollView(child: child);
    }

    return child;
  }
}
