import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/theme/text_styles.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/stats_section/character_stats.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_method_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';

class CharacterBuildAbilityScores extends StatefulWidget {
  const CharacterBuildAbilityScores({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  @override
  State<CharacterBuildAbilityScores> createState() =>
      _CharacterBuildAbilityScoresState();
}

class _CharacterBuildAbilityScoresState
    extends State<CharacterBuildAbilityScores> {
  ExpansibleController controller = ExpansibleController();
  late TextEditingController methodDropdownController;

  bool get hasValues =>
      widget.character.stats.base.length == StatsType.values.length;

  List<DropdownMenuEntry<StatsMethod>> methodEntries = StatsMethod.values
      .map(
        (x) => DropdownMenuEntry<StatsMethod>(value: x, label: x.displayName),
      )
      .toList();

  int? getPointCost(int score) => switch (score) {
    8 => 0,
    9 => 1,
    10 => 2,
    11 => 3,
    12 => 4,
    13 => 5,
    14 => 7,
    15 => 9,
    _ => null,
  };

  void _setMethod(StatsMethod? method) {
    setState(() {
      if (method == null) {
        widget.character.stats.clearMethod();
      } else {
        widget.character.stats.method = method;
        for (var stat in StatsType.values) {
          if (widget.character.stats.base.containsKey(stat.value)) {
            widget.character.stats.base[stat.value] =
                widget.character.stats.method == StatsMethod.StatsManual
                ? widget.character.stats.base[stat.value]!.clamp(0, 20)
                : widget.character.stats.base[stat.value]!.clamp(8, 15);
          }
        }
      }
      widget.changed();
    });
  }

  @override
  void initState() {
    methodDropdownController = TextEditingController(
      text: widget.character.stats.hasMethod()
          ? widget.character.stats.method.displayName
          : "",
    );
    if (hasValues) {
      controller.collapse();
    } else {
      controller.expand();
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
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        controller: controller,
        onExpansionChanged: (value) {
          setState(() {});
        },
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Ability Scores", style: TextStyles.of(context).headline1),
              Spacer(),
            ],
          ),
        ),
        enabled: hasValues || !controller.isExpanded,
        dense: true,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: AlignmentGeometry.centerLeft,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        tilePadding: EdgeInsets.symmetric(horizontal: 8),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return DropdownMenu<StatsMethod>(
                  controller: methodDropdownController,
                  enableFilter: false,
                  enableSearch: false,
                  requestFocusOnTap: true,
                  label: Text('Method'),
                  width: constraints.maxWidth,
                  onSelected: _setMethod,
                  dropdownMenuEntries: methodEntries,
                );
              },
            ),
          ),
          if (widget.character.stats.hasMethod())
            if (widget.character.stats.method == StatsMethod.StatsManual)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CharacterStatsWidget(isEditingBase: true),
              )
            else if (widget.character.stats.method ==
                StatsMethod.StatsPointBuy) ...[
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 12.0,
                ),
                child: Text(
                  "Points Remaining: ${27 - widget.character.stats.base.values.map((x) => getPointCost(x) ?? 0).sum}",
                  style: TextStyles.of(context).headline2
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CharacterStatsWidget(
                  isEditingBase: true,
                  minValue: 8,
                  maxValue: 15,
                ),
              ),
            ],
        ],
      ),
    );
  }
}
