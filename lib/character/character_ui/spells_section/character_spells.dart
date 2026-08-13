import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:render_ttrpg_data/data_views/5e/spell_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/spell/spell.dart';
import 'package:render_ttrpg_data/theme/text_styles.dart';
import 'package:render_ttrpg_data/util/int_extension.dart';
import 'package:render_ttrpg_data/widgets/link_with_content_tooltip.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/int_field_base.dart';
import 'package:ttrpg_character_tools/character/character_ui/base_field/text_field_base.dart';
import 'package:ttrpg_character_tools/character/character_ui/spells_section/class_spellcasting_info.dart';
import 'package:ttrpg_character_tools/character/character_ui/spells_section/wrap_columns.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/stats_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_spell_info.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_spells.pb.dart';

class CharacterSpells extends StatefulWidget {
  const CharacterSpells({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  @override
  State<CharacterSpells> createState() => _CharacterSpellsState();
}

class _CharacterSpellsState extends State<CharacterSpells> {
  final Map<Class5e, SearchController> spellSearchController = {};
  final Map<CharacterSpellInfo, Spell> spellsCache = {};

  void buildSpellCache() {
    for (var spellInfo in widget.character.spells.knownCantrips) {
      if (!spellsCache.containsKey(spellInfo)) {
        spellsCache[spellInfo] = DataModel5e.spells.firstWhere(
          (x) =>
              x.name == spellInfo.spellName &&
              x.source == spellInfo.spellSource,
        );
      }
    }
    for (var spellInfo in widget.character.spells.knownSpells) {
      if (!spellsCache.containsKey(spellInfo)) {
        spellsCache[spellInfo] = DataModel5e.spells.firstWhere(
          (x) =>
              x.name == spellInfo.spellName &&
              x.source == spellInfo.spellSource,
        );
      }
    }
  }

  Widget spellEntry((CharacterSpellInfo, Spell) spellInfo) {
    var spell = spellInfo.$2;
    return Row(
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: LinkWithContentTooltip(
                    tooltipView: SpellView(
                      spell: spell,
                      card: true,
                      outlined: true,
                      scrollable: true,
                    ),
                    contentView: SpellView(spell: spell, card: false),
                    text: spell.name,
                    style: TextStyle(fontSize: 18),
                    fittedBox: true,
                    waitDuration: Duration(milliseconds: 500),
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              var infoList = spell.level == 0
                  ? widget.character.spells.knownCantrips
                  : widget.character.spells.knownSpells;
              infoList.remove(spellInfo.$1);
              widget.changed();
            });
          },
          icon: Icon(Icons.delete, size: 20),
        ),
      ],
    );
  }

  Widget addSpellsButton(
    ClassSpellcastingInfo info,
    List<(CharacterSpellInfo, Spell)> knownCantrips,
    List<(CharacterSpellInfo, Spell)> knownSpells,
  ) {
    return SearchAnchor(
      searchController:
          spellSearchController[info.class5e] ??
          (spellSearchController[info.class5e] = SearchController()),
      viewHintText: "Add Spell",
      viewConstraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      builder: (BuildContext context, SearchController controller) {
        return SizedBox(
          height: 48,
          child: FilledButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(4),
                ),
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 12.0),
              ),
            ),
            onPressed: () {
              controller.openView();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add), Text("Add Spell")],
            ),
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return DataModel5e.spells
            .where(
              (spell) =>
                  spell.level <= info.highestSpellLevel &&
                  ((spell.spellClassSource?.classSource != null &&
                          spell.spellClassSource!.classSource!.any(
                            (source) =>
                                source.name == info.class5e.name &&
                                source.source == info.class5e.source,
                          )) ||
                      (spell.spellClassSource?.classVariant != null &&
                          spell.spellClassSource!.classVariant!.any(
                            (source) =>
                                source.name == info.class5e.name &&
                                source.source == info.class5e.source,
                          ))),
            )
            .sortedBy((x) => x.level)
            .where(
              (x) =>
                  x.name.toLowerCase().contains(controller.text.toLowerCase()),
            )
            .map((spell) {
              var infoList = spell.level == 0
                  ? widget.character.spells.knownCantrips
                  : widget.character.spells.knownSpells;
              return ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(spell.name),
                    if (infoList.any((x) => x.spellName == spell.name))
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "(Already Known)",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorScheme.of(
                              context,
                            ).onSurface.withAlpha(150),
                          ),
                        ),
                      ),
                  ],
                ),
                trailing: Text(
                  "${spell.level == 0 ? "Cantrip" : "${spell.level.ordinal()}-level"} | ${spell.source}",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorScheme.of(context).onSurface.withAlpha(150),
                  ),
                ),
                onTap: infoList.any((x) => x.spellName == spell.name)
                    ? null
                    : () {
                        setState(() {
                          controller.closeView(null);
                          controller.clear();
                          if (!infoList.any((x) => x.spellName == spell.name)) {
                            infoList.add(
                              CharacterSpellInfo(
                                spellName: spell.name,
                                spellSource: spell.source,
                                spellClassName: info.class5e.name,
                                spellClassSource: info.class5e.source,
                              ),
                            );
                            widget.changed();
                          }
                        });
                      },
              );
            });
      },
    );
  }

  @override
  void dispose() {
    for (var x in spellSearchController.values) {
      x.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Iterable<ClassSpellcastingInfo> classes = [];
    if (DataLoader.ready) {
      classes = widget.character.classInfo
          .map((x) => ClassSpellcastingInfo.getClassInfo(widget.character, x))
          .nonNulls;
      buildSpellCache();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var info in classes)
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: () {
                var knownCantrips = widget.character.spells.knownCantrips
                    .where(
                      (x) =>
                          x.spellClassName == info.class5e.name &&
                          x.spellClassSource == info.class5e.source,
                    )
                    .map((x) => (x, spellsCache[x]))
                    .where((x) => x.$2 != null)
                    .map((x) => (x.$1, x.$2!))
                    .toList();
                var knownSpells = widget.character.spells.knownSpells
                    .where(
                      (x) =>
                          x.spellClassName == info.class5e.name &&
                          x.spellClassSource == info.class5e.source,
                    )
                    .map((x) => (x, spellsCache[x]))
                    .where((x) => x.$2 != null)
                    .map((x) => (x.$1, x.$2!))
                    .sortedBy((x) => x.$2.level)
                    .toList();
                var knownAll = [
                  ...knownCantrips,
                  ...knownSpells,
                ].groupSetsBy((x) => x.$2.level);
                return [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              info.class5e.name,
                              style: TextStyles.of(context).headline0,
                              textAlign: TextAlign.center,
                            ),
                            RichText(
                              text: TextSpan(
                                text: '',
                                children: [
                                  if (info.cantripsKnown > 0) ...[
                                    TextSpan(
                                      text: "Cantrips Known: ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    TextSpan(
                                      text: knownCantrips.length.toString(),
                                      style:
                                          knownCantrips.length >
                                              info.cantripsKnown
                                          ? TextStyle(color: Colors.red)
                                          : null,
                                    ),
                                    TextSpan(text: " / ${info.cantripsKnown}"),
                                  ],
                                  if (info.preparedSpells != null &&
                                      info.preparedSpells! > 0) ...[
                                    TextSpan(text: ", Spells Prepared: "),
                                    TextSpan(
                                      text: knownSpells.length.toString(),
                                      style:
                                          knownSpells.length >
                                              info.preparedSpells!
                                          ? TextStyle(color: Colors.red)
                                          : null,
                                    ),
                                    TextSpan(text: " / ${info.preparedSpells}"),
                                  ] else if (info.spellsKnown > 0) ...[
                                    TextSpan(
                                      text: ", Spells Known: ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    TextSpan(
                                      text: knownSpells.length.toString(),
                                      style:
                                          knownSpells.length > info.spellsKnown
                                          ? TextStyle(color: Colors.red)
                                          : null,
                                    ),
                                    TextSpan(text: " / ${info.spellsKnown}"),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFieldBase(
                            label: "Spellcasting Ability",
                            value:
                                info.class5e.spellcastingAbility?.name ??
                                "Unknown",
                            valueChanged: null,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IntFieldBase(
                            label: "Spell Save DC",
                            value: info.class5e.spellcastingAbility == null
                                ? 0
                                : 8 +
                                      widget.character.stats.getStatModifier(
                                        info.class5e.spellcastingAbility!
                                            .toStatsType(),
                                      ) +
                                      widget.character.proficiencyBonus,
                            valueChanged: null,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IntFieldBase(
                            label: "Spell Attack Bonus",
                            value: info.class5e.spellcastingAbility == null
                                ? 0
                                : widget.character.stats.getStatModifier(
                                        info.class5e.spellcastingAbility!
                                            .toStatsType(),
                                      ) +
                                      widget.character.proficiencyBonus,
                            valueChanged: null,
                            withSign: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: addSpellsButton(
                          info,
                          knownCantrips,
                          knownSpells,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: WrapColumns(
                      minWidth: 300,
                      runSpacing: 22,
                      spacing: 10,
                      children: () {
                        var builder = <Widget>[];
                        for (
                          var spellLevel = 0;
                          spellLevel <= info.highestSpellLevel;
                          spellLevel++
                        ) {
                          var expendedSlots = widget
                              .character
                              .spells
                              .expendedSpellSlots
                              .firstWhereOrNull(
                                (x) =>
                                    x.slotSource == info.magicType &&
                                    x.slotLevel == spellLevel,
                              );
                          builder.add(
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        ((InputDecorationTheme.of(
                                                      context,
                                                    ).border
                                                    as OutlineInputBorder?) ??
                                                (const OutlineInputBorder()))
                                            .borderRadius,
                                    border: Border.all(
                                      width: 1,
                                      color: ColorScheme.of(
                                        context,
                                      ).outline, // avoids black
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: 42,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                          ),
                                          child: Text(
                                            spellLevel.toString(),
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                        VerticalDivider(),
                                        if (spellLevel == 0)
                                          Expanded(
                                            child: Text(
                                              "Cantrips",
                                              style: TextStyle(fontSize: 20),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        else if (info.spellSlots.containsKey(
                                          spellLevel,
                                        )) ...[
                                          Expanded(
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: "Slots Total",
                                                isDense: true,
                                              ),
                                              child: Text(
                                                info.spellSlots[spellLevel]
                                                    .toString(),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: IntFieldBase(
                                              label: "Slots Expended",
                                              inputBorder: InputBorder.none,
                                              showLabel: true,
                                              textStyle:
                                                  DefaultTextStyle.of(
                                                    context,
                                                  ).style.copyWith(
                                                    color:
                                                        (expendedSlots
                                                                    ?.numExpended ??
                                                                0) >
                                                            info.spellSlots[spellLevel]!
                                                        ? Colors.red
                                                        : null,
                                                  ),
                                              textAlign: TextAlign.left,
                                              value:
                                                  expendedSlots?.numExpended ??
                                                  0,
                                              valueChanged: (val) {
                                                if (expendedSlots == null) {
                                                  var slots =
                                                      ExpendedSpellSlots(
                                                        slotSource:
                                                            info.magicType,
                                                        slotLevel: spellLevel,
                                                        numExpended: val,
                                                      );
                                                  widget
                                                      .character
                                                      .spells
                                                      .expendedSpellSlots
                                                      .add(slots);
                                                } else {
                                                  expendedSlots.numExpended =
                                                      val;
                                                }
                                                widget.changed();
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            onPressed:
                                                (expendedSlots?.numExpended ??
                                                        0) >=
                                                    info.spellSlots[spellLevel]!
                                                ? null
                                                : () {
                                                    if (expendedSlots == null) {
                                                      var slots =
                                                          ExpendedSpellSlots(
                                                            slotSource:
                                                                info.magicType,
                                                            slotLevel:
                                                                spellLevel,
                                                            numExpended: 1,
                                                          );
                                                      widget
                                                          .character
                                                          .spells
                                                          .expendedSpellSlots
                                                          .add(slots);
                                                    } else {
                                                      expendedSlots
                                                          .numExpended++;
                                                    }
                                                    widget.changed();
                                                  },
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                                if (knownAll[spellLevel] != null)
                                  for (var spellInfo
                                      in knownAll[spellLevel]!) ...[
                                    spellEntry(spellInfo),
                                    Divider(height: 2),
                                  ],
                              ],
                            ),
                          );
                        }
                        return builder;
                      }(),
                    ),
                  ),
                  if (knownAll.entries
                      .where((x) => x.key > info.highestSpellLevel)
                      .any((x) => x.value.isNotEmpty))
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 500),
                        child: Column(
                          children: [
                            Gap(16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: Text(
                                "Spells known of higher level than available slots",
                                style: TextStyles.of(context).headline2,
                              ),
                            ),
                            for (var spellInfo
                                in knownAll.entries
                                    .where(
                                      (x) => x.key > info.highestSpellLevel,
                                    )
                                    .expand((x) => x.value))
                              spellEntry(spellInfo),
                          ],
                        ),
                      ),
                    ),
                ];
              }(),
            ),
          ),
      ],
    );
  }
}
