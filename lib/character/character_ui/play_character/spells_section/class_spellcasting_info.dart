import 'package:collection/collection.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_class_info_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_stats_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/stats_type_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_class_info.pb.dart';
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
  });

  final CharacterClassInfo classInfo;
  final Class5e class5e;
  final Map<int, int> spellSlots;
  final int spellsKnown;
  final int? preparedSpells;
  final int cantripsKnown;
  final int highestSpellLevel;
  final String magicType;

  static ClassSpellcastingInfo? getClassInfo(
    Character character,
    CharacterClassInfo info,
  ) {
    var class5e = info.getClass();
    if (class5e == null) {
      return null;
    }

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

    if (spellSlots.isEmpty && (class5e.cantripProgression?.isEmpty ?? true)) {
      return null;
    }
    return ClassSpellcastingInfo(
      classInfo: info,
      class5e: class5e,
      spellSlots: spellSlots,
      spellsKnown: (class5e.spellsKnownProgression?.isNotEmpty ?? false)
          ? info.classLevel - 1 > class5e.spellsKnownProgression!.length
                ? class5e.spellsKnownProgression!.last
                : class5e.spellsKnownProgression![info.classLevel - 1]
          : 0,
      preparedSpells: computePreparedSpells(character, info),
      cantripsKnown: (class5e.cantripProgression?.isNotEmpty ?? false)
          ? info.classLevel - 1 > class5e.cantripProgression!.length
                ? class5e.cantripProgression!.last
                : class5e.cantripProgression![info.classLevel - 1]
          : 0,
      highestSpellLevel:
          spellSlots.entries.lastWhereOrNull((x) => x.value > 0)?.key ?? 0,
      magicType: magicType ?? "unknown",
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
}
