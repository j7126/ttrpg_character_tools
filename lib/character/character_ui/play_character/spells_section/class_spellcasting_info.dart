import 'package:collection/collection.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/interface/additional_spells_mixin.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/spells_section/known_spell_context.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_class_info_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/stats_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_class_info.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_spell_info.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pbenum.dart';

class ClassSpellcastingInfo {
  ClassSpellcastingInfo({
    required this.classInfo,
    required this.class5e,
    required this.spellSlots,
    required this.spellsKnown,
    required this.preparedSpells,
    required this.cantripsKnown,
    required this.highestSpellLevel,
    required this.magicType,
    required this.additionalKnownSpells,
    required this.expandedAvailableSpells,
    required this.expandedAvailableSpellsBySlotLevel,
  });

  final CharacterClassInfo classInfo;
  final Class5e class5e;
  final Map<int, int> spellSlots;
  final int spellsKnown;
  final int? preparedSpells;
  final int cantripsKnown;
  final int highestSpellLevel;
  final String magicType;
  final List<KnownSpellContext> additionalKnownSpells;
  final List<String> expandedAvailableSpells;
  final Map<int, List<String>> expandedAvailableSpellsBySlotLevel;

  static ClassSpellcastingInfo? getClassInfo(
    CharacterContext context,
    CharacterClassInfo info,
  ) {
    // get class info.
    var class5e = info.getClass();
    if (class5e == null) {
      return null;
    }

    // additional known spells from feats, subclass etc...
    List<KnownSpellContext> additionalKnownSpells = [];
    List<String> expandedAvailableSpells = [];
    Map<int, List<String>> expandedAvailableSpellsBySlotLevel = {};
    parseAdditionalSpells(
      context,
      additionalKnownSpells,
      expandedAvailableSpells,
      expandedAvailableSpellsBySlotLevel,
    );

    // spell slots.
    Map<int, int> spellSlots = {};
    String? magicType;
    if (class5e.classTableGroups != null) {
      var spellProgressionEntry = class5e.classTableGroups!
          .firstWhereOrNull((x) => x.rowsSpellProgression != null)
          ?.rowsSpellProgression;
      var warlockEntry = class5e.classTableGroups!.firstWhereOrNull(
        (x) =>
            x.colLabels != null &&
            x.colLabels!.contains("Slot Level") &&
            x.colLabels!.contains("Spell Slots") &&
            x.rows != null,
      );

      if (spellProgressionEntry != null) {
        var spellSlotsList = info.classLevel - 1 > spellProgressionEntry.length
            ? spellProgressionEntry.last
            : spellProgressionEntry[info.classLevel - 1];
        for (var i = 1; i <= spellSlotsList.length; i++) {
          spellSlots[i] = spellSlotsList[i - 1];
        }
        magicType = "spellcasting";
      } else if (warlockEntry != null) {
        var levelColIndex = warlockEntry.colLabels!.indexOf("Slot Level");
        var slotsColIndex = warlockEntry.colLabels!.indexOf("Spell Slots");
        var levelRow = info.classLevel - 1 > warlockEntry.rows!.length
            ? warlockEntry.rows!.last
            : warlockEntry.rows![info.classLevel - 1];
        if (!(slotsColIndex > levelRow.length ||
            levelColIndex > levelRow.length)) {
          var slots = levelRow[slotsColIndex].intVal;
          RegExp exp = RegExp(
            r'(?:{@[^ ]+ [^}]+\|level=([0-9]+)\|[^}]+})|(?:(?:[^{]|\n)+)',
          );
          var match = exp.firstMatch(levelRow[levelColIndex].entry ?? "");
          var slotLevel = match?.group(1) != null
              ? int.parse(match!.group(1)!)
              : null;
          if (slots != null && slotLevel != null) {
            spellSlots[slotLevel] = slots;
            magicType = "pact";
          }
        }
      }
    }

    // if we don't have any spellcasting, then return null.
    if (spellSlots.isEmpty &&
        (class5e.cantripProgression?.isEmpty ?? true) &&
        additionalKnownSpells.isEmpty) {
      return null;
    }

    // build info.
    return ClassSpellcastingInfo(
      classInfo: info,
      class5e: class5e,
      spellSlots: spellSlots,
      spellsKnown: (class5e.spellsKnownProgression?.isNotEmpty ?? false)
          ? info.classLevel - 1 > class5e.spellsKnownProgression!.length
                ? class5e.spellsKnownProgression!.last
                : class5e.spellsKnownProgression![info.classLevel - 1]
          : 0,
      preparedSpells: computePreparedSpells(context.character, info),
      cantripsKnown: (class5e.cantripProgression?.isNotEmpty ?? false)
          ? info.classLevel - 1 > class5e.cantripProgression!.length
                ? class5e.cantripProgression!.last
                : class5e.cantripProgression![info.classLevel - 1]
          : 0,
      highestSpellLevel:
          spellSlots.entries.lastWhereOrNull((x) => x.value > 0)?.key ?? 0,
      magicType: magicType ?? "unknown",
      additionalKnownSpells: additionalKnownSpells,
      expandedAvailableSpells: expandedAvailableSpells,
      expandedAvailableSpellsBySlotLevel: expandedAvailableSpellsBySlotLevel,
    );
  }

  static int? computePreparedSpells(
    Character character,
    CharacterClassInfo classInfo,
  ) {
    var class5e = classInfo.getClass();
    if (class5e?.preparedSpells == null) {
      return null;
    }

    var vals = <String, int>{};
    vals["level"] = classInfo.classLevel;
    for (var stat in StatsType.values) {
      vals["${stat.toAbility().toString().split('.').last}_mod"] = character
          .stats
          .getStatModifier(stat);
    }

    RegExp exp = RegExp(r'(?:(<\$)([^\$]+)\$>)|[\/+*-]|([0-9]+)');
    var matches = exp.allMatches(class5e!.preparedSpells!);
    var result = 0;
    String? operator;

    void applyNum(int num) {
      switch (operator) {
        case "-":
          result -= num;
        case "/":
          result ~/= num;
        case "*":
          result *= num;
        default:
          result += num;
      }
    }

    for (var match in matches) {
      if (match.group(1) == "<\$") {
        var val = vals[match.group(2)];
        if (val == null) {
          return 0;
        }
        applyNum(val);
      } else if (match.group(3) != null) {
        var val = int.tryParse(match.group(3)!);
        if (val == null) {
          return 0;
        }
        applyNum(val);
      } else {
        operator = match.group(0);
      }
    }

    return result;
  }

  static void parseAdditionalSpells(
    CharacterContext context,
    List<KnownSpellContext> additionalKnownSpells,
    List<String> expandedAvailableSpells,
    Map<int, List<String>> expandedAvailableSpellsBySlotLevel,
  ) {
    for (var (provider, classInfo) in context.allRulesObjs) {
      if (provider is! AdditionalSpellsMixin ||
          provider.additionalSpells == null) {
        continue;
      }

      Map<String, dynamic>? additionalSpells;

      // map spells based on character choice related to the spell provider
      if (provider.additionalSpells!.length == 1) {
        additionalSpells = provider.additionalSpells!.first;
      } else if (provider.additionalSpells!.length > 1) {
        var choice = context.characterChoices.firstWhereOrNull(
          (x) => x.reference == provider.refString,
        );
        var choiceVal = choice?.getCurrentChoice(context.character);
        if (choiceVal != null && choiceVal.choice.isNotEmpty) {
          additionalSpells = provider.additionalSpells!.firstWhereOrNull(
            (x) => choiceVal.choice.first.choiceName == x["name"],
          );
        }
      }

      // handle additional spells
      if (additionalSpells != null) {
        var known = additionalSpells["known"];
        var expanded = additionalSpells["expanded"];
        var innate = additionalSpells["innate"];

        // Known spells
        if (known is Map<String, dynamic>) {
          void addKnown(List spells) {
            for (var spellString in spells) {
              if (spellString is! String) {
                continue;
              }
              var spell = DataModel5e.spells.firstWhereOrNull(
                (x) => x.name.toLowerCase() == spellString.toLowerCase(),
              );
              if (spell != null &&
                  !additionalKnownSpells.any(
                    (x) =>
                        x.info.spellName.toLowerCase() ==
                        spellString.toLowerCase(),
                  )) {
                additionalKnownSpells.add(
                  KnownSpellContext(
                    info: CharacterSpellInfo(
                      spellName: spell.name,
                      spellSource: spell.source,
                      spellClassName: classInfo?.className,
                      spellClassSource: classInfo?.classSource,
                    ),
                    additionalKnownType: AdditionalKnownSpellType.known,
                    sourceRef: provider.refString,
                  ),
                );
              }
            }
          }

          var lvlKnown = known["_"];
          if (lvlKnown is List) {
            addKnown(lvlKnown);
          }
          for (
            var level = 1;
            level <= (classInfo?.classLevel ?? context.character.totalLevel);
            level++
          ) {
            var lvlKnown = known[level.toString()];
            if (lvlKnown is List) {
              addKnown(lvlKnown);
            }
          }
        }

        // Expanded available spells
        if (expanded is Map<String, dynamic>) {
          for (
            var level = 1;
            level <= (classInfo?.classLevel ?? context.character.totalLevel);
            level++
          ) {
            var classLvlExpanded = expanded[level.toString()];
            if (classLvlExpanded is List) {
              for (var item in classLvlExpanded) {
                if (item is String) {
                  expandedAvailableSpells.add(item);
                } else if (item is Map<String, dynamic>) {
                  var all = item["all"];
                  if (all is String) {
                    expandedAvailableSpells.add("@all:$all");
                  }
                }
              }
            }
          }
          for (var spellLevel = 1; spellLevel <= 9; spellLevel++) {
            var spellLvlExpanded = expanded["s$spellLevel"];
            if (spellLvlExpanded is List) {
              for (var item in spellLvlExpanded) {
                if (item is String) {
                  var lst = expandedAvailableSpellsBySlotLevel[spellLevel];
                  if (lst == null) {
                    lst = [];
                    expandedAvailableSpellsBySlotLevel[spellLevel] = lst;
                  }
                  lst.add(item);
                }
              }
            }
          }
        }

        // Innate spells
        if (innate is Map<String, dynamic>) {
          void addInnate(Map<String, dynamic> spells) {
            for (var type in AdditionalKnownSpellInnateType.values) {
              var innateSpell = spells[type.name];
              List? spellStringList;
              int? qty = 0;
              if (innateSpell != null && innateSpell is Map<String, dynamic>) {
                for (var qtyKvp in innateSpell.entries) {
                  qty = int.tryParse(qtyKvp.key);
                  if (qty != null && qtyKvp.value is List) {
                    spellStringList = qtyKvp.value;
                  }
                }
              } else if (innateSpell != null && innateSpell is List) {
                spellStringList = innateSpell;
              }
              if (spellStringList != null) {
                for (var spellString in spellStringList) {
                  if (spellString is! String) {
                    continue;
                  }
                  var spell = DataModel5e.spells.firstWhereOrNull(
                    (x) => x.name.toLowerCase() == spellString.toLowerCase(),
                  );
                  if (spell != null &&
                      !additionalKnownSpells.any(
                        (x) =>
                            x.info.spellName.toLowerCase() ==
                            spellString.toLowerCase(),
                      )) {
                    additionalKnownSpells.add(
                      KnownSpellContext(
                        info: CharacterSpellInfo(
                          spellName: spell.name,
                          spellSource: spell.source,
                          spellClassName: classInfo?.className,
                          spellClassSource: classInfo?.classSource,
                        ),
                        additionalKnownType: AdditionalKnownSpellType.innate,
                        sourceRef: provider.refString,
                        innateQty: qty ?? 0,
                        innateType: type,
                      ),
                    );
                  }
                }
              }
            }
          }

          var lvlInnate = innate["_"];
          if (lvlInnate is Map<String, dynamic>) {
            addInnate(lvlInnate);
          }
          for (
            var level = 1;
            level <= (classInfo?.classLevel ?? context.character.totalLevel);
            level++
          ) {
            var lvlInnate = innate[level.toString()];
            if (lvlInnate is Map<String, dynamic>) {
              addInnate(lvlInnate);
            }
          }
        }
      }
    }
  }
}
