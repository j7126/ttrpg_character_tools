import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:render_ttrpg_data/data_views/generic/entry_view/text_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/ability.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/interface/ability_bonus/ability_bonus.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/interface/ability_bonus/ability_bonus_mixin.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/race/race.dart';
import 'package:render_ttrpg_data/theme/text_styles.dart';
import 'package:render_ttrpg_data/util/int_extension.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/stats_section/character_stats.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_method_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/stats_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pb.dart';

class CharacterBuildAbilityScores extends StatefulWidget {
  const CharacterBuildAbilityScores({super.key, required this.context});

  final CharacterContext context;

  @override
  State<CharacterBuildAbilityScores> createState() =>
      _CharacterBuildAbilityScoresState();
}

class _CharacterBuildAbilityScoresState
    extends State<CharacterBuildAbilityScores> {
  static const List<int?> standardArray = [null, 8, 10, 12, 13, 14, 15];

  ExpansibleController controller = ExpansibleController();

  bool get hasValues =>
      widget.context.character.stats.base.length == StatsType.values.length;

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
        widget.context.character.stats.clearMethod();
      } else {
        widget.context.character.stats.method = method;
        for (var stat in StatsType.values.reversed) {
          var val = widget.context.character.stats.base[stat.value];
          if (val != null) {
            if (widget.context.character.stats.method ==
                StatsMethod.StatsStandardArray) {
              if (!standardArray.contains(val) ||
                  widget.context.character.stats.base.entries.any(
                    (x) => x.key != stat.value && x.value == val,
                  )) {
                widget.context.character.stats.base.remove(stat.value);
              }
            } else {
              widget.context.character.stats.base[stat.value] =
                  widget.context.character.stats.method ==
                      StatsMethod.StatsManual
                  ? val.clamp(0, 20)
                  : val.clamp(8, 15);
            }
          }
        }
      }
      widget.context.changed();
      _statsChanged();
    });
  }

  void _statsChanged() {
    if (!mounted) {
      return;
    }

    for (var stat in StatsType.values) {
      var val = widget.context.character.stats.base[stat.value];
      if (val != null) {
        var currentVal = val;
        for (var selection
            in widget.context.character.stats.characterStatsSelections) {
          currentVal += selection.currentMods[stat.value] ?? 0;
          currentVal += selection.fixedMods[stat.value] ?? 0;
        }
        currentVal = currentVal.clamp(0, 20);
        widget.context.character.stats.current[stat.value] = currentVal;
      } else {
        widget.context.character.stats.current.remove(stat.value);
      }
    }

    widget.context.changed();
  }

  int _getCurrentStatBonus(CharacterStatsSelection selection, Ability ab) {
    if (!mounted) {
      return 0;
    }

    return selection.currentMods[ab.toStatsType().value] ?? 0;
  }

  int _getTotalBonus(CharacterStatsSelection selection) =>
      selection.currentMods.values.sum;

  int _getNumWithSelectedBonus(
    CharacterStatsSelection selection,
    AbilityBonus bonus,
  ) {
    var num = 0;
    for (var ab in Ability.values) {
      if (_getCurrentStatBonus(selection, ab) > 0) {
        num++;
      }
    }
    return num;
  }

  void _selectBonusSelection(
    CharacterStatsSelection selection,
    bool? val,
    int i,
    Ability ab,
  ) {
    selection.currentMods[ab.toStatsType().value] = val == true ? i : 0;
    _statsChanged();
  }

  void _cleanupUnapplied(
    Map<String, CharacterStatsSelection> unappliedSelections,
  ) async {
    await Future.pause();
    if (!mounted) {
      return;
    }

    for (var val in unappliedSelections.values) {
      widget.context.character.stats.characterStatsSelections.remove(val);
    }
    _statsChanged();
  }

  @override
  void initState() {
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
    var bonusProviders = widget.context.allRulesObjs
        .map((x) {
          var obj = x.$1;
          return obj is AbilityBonusMixin ? obj : null;
        })
        .nonNulls
        .toList();

    var unappliedSelections = Map<String, CharacterStatsSelection>.fromEntries(
      widget.context.character.stats.characterStatsSelections.map(
        (x) => MapEntry(x.providerRef, x),
      ),
    );

    List<Widget> bonusAbilitySelectWidget(
      CharacterStatsSelection selection,
      AbilityBonusMixin provider,
      AbilityBonus bonus,
      Ability ab,
    ) {
      var widgets = <Widget>[];
      if (bonus.fixedBonus[ab] != null) {
        widgets.add(
          Text(
            bonus.fixedBonus[ab]!.toStringWithSign(),
            style: TextStyle(fontSize: 22),
          ),
        );
      }
      if (selection.fixedMods.containsKey(ab.toStatsType().value) !=
          (bonus.fixedBonus[ab] != null)) {
        // apply any fixed bonus
        () async {
          await Future.pause();
          if (!mounted) {
            return;
          }

          if (bonus.fixedBonus[ab] != null) {
            selection.fixedMods[ab.toStatsType().value] = bonus.fixedBonus[ab]!;
          } else {
            selection.fixedMods.remove(ab.toStatsType().value);
          }
          _statsChanged();
        }();
      }
      if (bonus.choose != null && bonus.choose!.from.contains(ab)) {
        for (
          var i = (bonus.choose!.count ?? 1) < 0
              ? 1
              : (bonus.choose!.amount ?? 1);
          i <= (bonus.choose!.amount ?? 1);
          i++
        ) {
          var currentBonus = _getCurrentStatBonus(selection, ab);
          var enabled =
              ((bonus.choose!.count ?? 1) < 0
                  ? _getTotalBonus(selection) <
                        (bonus.choose!.amount ?? 1) - i + 1
                  : _getNumWithSelectedBonus(selection, bonus) <
                        (bonus.choose!.count ?? 1)) ||
              _getCurrentStatBonus(selection, ab) >= i;
          widgets.add(
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: currentBonus == i,
                  onChanged: enabled
                      ? (val) => _selectBonusSelection(selection, val, i, ab)
                      : null,
                ),
                Opacity(
                  opacity: enabled ? 1 : 0.6,
                  child: Text(
                    i.toStringWithSign(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        }
      }
      return widgets;
    }

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
                  initialSelection: widget.context.character.stats.hasMethod()
                      ? widget.context.character.stats.method
                      : null,
                  enableFilter: false,
                  enableSearch: false,
                  requestFocusOnTap: false,
                  label: Text('Method'),
                  width: constraints.maxWidth,
                  onSelected: _setMethod,
                  dropdownMenuEntries: methodEntries,
                );
              },
            ),
          ),
          if (widget.context.character.stats.hasMethod())
            if (widget.context.character.stats.method ==
                StatsMethod.StatsManual)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CharacterStatsWidget(
                  isEditingBase: true,
                  minValue: 0,
                  maxValue: 20,
                  hideModifier: true,
                  changed: _statsChanged,
                ),
              )
            else if (widget.context.character.stats.method ==
                StatsMethod.StatsStandardArray)
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 12.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.0,
                  children: [
                    for (var st in StatsType.values)
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return DropdownMenu<int?>(
                              initialSelection:
                                  widget.context.character.stats.base[st.value],
                              enableFilter: false,
                              enableSearch: false,
                              requestFocusOnTap: false,
                              selectOnly: true,
                              label: Text(st.name),
                              width: constraints.maxWidth,
                              inputDecorationTheme: InputDecorationTheme(
                                border: OutlineInputBorder(),
                                enabledBorder:
                                    widget.context.character.stats.base
                                        .containsKey(st.value)
                                    ? null
                                    : OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: ColorScheme.of(context).error,
                                          width: 1.5,
                                        ),
                                      ),
                              ),
                              onSelected: (val) {
                                if (val != null) {
                                  widget.context.character.stats.base
                                      .removeWhere(
                                        ((key, value) => value == val),
                                      );
                                  widget.context.character.stats.base[st
                                          .value] =
                                      val;
                                } else {
                                  widget.context.character.stats.base.remove(
                                    st.value,
                                  );
                                }
                                _statsChanged();
                              },
                              dropdownMenuEntries: [
                                for (var val in standardArray)
                                  DropdownMenuEntry(
                                    value: val,
                                    label: val?.toString() ?? "_",
                                    labelWidget: Text(
                                      val?.toString() ?? "_",
                                      style:
                                          val == null ||
                                              widget
                                                  .context
                                                  .character
                                                  .stats
                                                  .base
                                                  .values
                                                  .contains(val)
                                          ? TextStyle(
                                              color: ColorScheme.of(context)
                                                  .onSurface
                                                  .withAlpha(100),
                                            )
                                          : null,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                  ],
                ),
              )
            else if (widget.context.character.stats.method ==
                StatsMethod.StatsPointBuy) ...[
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 12.0,
                ),
                child: () {
                  var remaining =
                      27 -
                      widget.context.character.stats.base.values
                          .map((x) => getPointCost(x) ?? 0)
                          .sum;
                  return Row(
                    children: [
                      Text(
                        "Base ability scores",
                        style: TextStyles.of(context).headline2
                            ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                      Spacer(),
                      Text(
                        "Points Remaining: $remaining",
                        style: TextStyles.of(context).headline2?.copyWith(
                          color: remaining < 0 ? Colors.red : null,
                        ),
                      ),
                    ],
                  );
                }(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                child: CharacterStatsWidget(
                  isEditingBase: true,
                  minValue: 8,
                  maxValue: 15,
                  hideModifier: true,
                  changed: _statsChanged,
                ),
              ),
            ],
          if (bonusProviders.any((x) => x.ability != null))
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 4.0,
                bottom: 8.0,
              ),
              child: Text(
                "Ability score bonuses",
                style: TextStyles.of(context).headline2
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ...() {
            var builder = <Widget>[];
            for (var bonusProvider in bonusProviders) {
              var ability = bonusProvider.ability;
              if (ability == null &&
                  bonusProvider is Race &&
                  bonusProvider.lineage != null) {
                ability = [
                  AbilityBonus(
                    choose: AbilityBonusChoose(
                      from: Ability.values,
                      amount: 3,
                      count: -1,
                    ),
                  ),
                ];
              }
              if (ability == null || ability.isEmpty) {
                continue;
              }
              var selection = unappliedSelections[bonusProvider.refString];
              if (selection != null) {
                unappliedSelections.remove(selection.providerRef);
              } else {
                selection = CharacterStatsSelection(
                  providerRef: bonusProvider.refString,
                );
                widget.context.character.stats.characterStatsSelections.add(
                  selection,
                );
              }

              builder.add(
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    bottom: 16.0,
                    right: 16.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextView(
                            bonusProvider.refString,
                            hintEntities: [bonusProvider],
                            style: TextStyle(
                              fontSize: TextStyles.of(context)
                                  .headline2
                                  ?.fontSize,
                            ),
                          ),
                          Gap(8.0),
                          Text(
                            ability
                                .map((bonus) => bonus.getDisplayText())
                                .join("; "),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          for (var ab in Ability.values)
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...bonusAbilitySelectWidget(
                                    selection,
                                    bonusProvider,
                                    ability.first,
                                    ab,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          for (var ab in Ability.values)
                            Expanded(
                              child: Text(ab.name, textAlign: TextAlign.center),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }

            // we need to clean up any selections that didn't match. Not sure if this is the best place for this.
            if (unappliedSelections.isNotEmpty) {
              _cleanupUnapplied(unappliedSelections);
            }

            return builder;
          }(),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CharacterStatsWidget(isEditingBase: false),
          ),
        ],
      ),
    );
  }
}
