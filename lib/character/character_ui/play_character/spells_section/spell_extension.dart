import 'package:render_ttrpg_data/datamodel/5e/data/spell/spell.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/spells_section/class_spellcasting_info.dart';

extension SpellExtension on Spell {
  bool isAvailable(ClassSpellcastingInfo info) =>
      level <= info.highestSpellLevel &&
      ((spellClassSource?.classSource != null &&
              spellClassSource!.classSource!.any(
                (source) =>
                    source.name == info.class5e.name &&
                    source.source == info.class5e.source,
              )) ||
          (spellClassSource?.classVariant != null &&
              spellClassSource!.classVariant!.any(
                (source) =>
                    source.name == info.class5e.name &&
                    source.source == info.class5e.source,
              )) ||
          info.expandedAvailableSpells.any(matchExtendedFilter) ||
          (info.expandedAvailableSpellsBySlotLevel[level]?.any(
                matchExtendedFilter,
              ) ??
              false));

  bool matchExtendedFilter(String filter) {
    if (filter.startsWith("@all:")) {
      filter = filter.replaceFirst("@all:", "");
      RegExp exp = RegExp(
        r'^(?:(?:level=([0-9]+)\|)|(?:class=([^\|]+)\|)|(?:source=([^\|]+)\|))+\|*$',
      );
      var match = exp.firstMatch("$filter|");
      if (match != null && match.groupCount > 0) {
        var lvl = int.tryParse(match.group(1) ?? "");
        var clss = match.group(2);
        var source = match.group(3);
        return (lvl == null || lvl == level) ||
            (clss == null ||
                (spellClassSource?.classSource?.any(
                      (x) => x.name.toLowerCase() == clss.toLowerCase(),
                    ) ??
                    false)) ||
            (source == null ||
                source.toLowerCase() == this.source.toLowerCase());
      }
    } else {
      var parts = filter.split("#");
      if (parts.isNotEmpty &&
          parts.first.split("|").length <= 1 &&
          name.toLowerCase() == parts.first.toLowerCase()) {
        return true;
      }
    }

    return false;
  }
}
