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
      builder: (BuildContext context, SearchController controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: RichText(
                text: TextSpan(
                  text: 'Cantrips Known: ',
                  children: [
                    TextSpan(
                      text: knownCantrips.length.toString(),
                      style: knownCantrips.length > info.cantripsKnown
                          ? TextStyle(color: Colors.red)
                          : null,
                    ),
                    TextSpan(text: " / ${info.cantripsKnown}, Spells Known: "),
                    TextSpan(
                      text: knownSpells.length.toString(),
                      style: knownSpells.length > info.spellsKnown
                          ? TextStyle(color: Colors.red)
                          : null,
                    ),
                    TextSpan(text: " / ${info.spellsKnown}"),
                  ],
                ),
              ),
            ),
            Gap(16.0),
            FilledButton(
              onPressed: () {
                controller.openView();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Add Spell"), Icon(Icons.add)],
              ),
            ),
          ],
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
          .map(ClassSpellcastingInfo.getClassInfo)
          .nonNulls;
      buildSpellCache();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var info in classes)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          info.class5e.name,
                          style: TextStyles.of(context).headline0,
                          textAlign: TextAlign.center,
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
                    ],
                  ),
                  ...() {
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
                      addSpellsButton(info, knownCantrips, knownSpells),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: WrapColumns(
                          minWidth: 300,
                          runSpacing: 22,
                          spacing: 10,
                          children: [
                            for (
                              var spellLevel = 0;
                              spellLevel <= info.highestSpellLevel;
                              spellLevel++
                            )
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
                          ],
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
                ],
              ),
            ),
          ),
      ],
    );
  }
}
