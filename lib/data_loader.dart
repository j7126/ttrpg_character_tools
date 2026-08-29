import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class_feature.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/subclass.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/condition/condition.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/generic/entry.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/item/item.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/feature/optional_feature.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/item/item_group.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/item/item_property.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/item/item_type.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/json_processer_5e.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/race/race.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/race/subrace/sub_race.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/spell/spell.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/spell/spell_source.dart';
import 'package:ttrpg_character_tools/data_load_error.dart';

class DataLoader {
  static final ValueNotifier<bool> readyNotifier = ValueNotifier<bool>(false);
  static bool get ready => readyNotifier.value;
  static bool isLoading = false;

  static List<DataLoadError> errors = [];

  static void loadData() async {
    if (ready || isLoading) {
      return;
    }

    isLoading = true;

    await loadItems();
    await loadSpells();
    await loadOptionalFeatures();
    await loadClasses();
    await loadConditions();
    await loadRaces();
    _hydrateReferences();
    readyNotifier.value = true;
  }

  static Future loadItems() async {
    var path = 'items-base.json';
    try {
      var json = await loadJson(path);
      var items = json["baseitem"] as List<dynamic>;
      DataModel5e.items.addAll(items.map((x) => Item.fromJson(x)));
      var itemTypes = json["itemType"] as List<dynamic>;
      DataModel5e.itemTypes.addAll(itemTypes.map((x) => ItemType.fromJson(x)));
      var itemProperties = json["itemProperty"] as List<dynamic>;
      DataModel5e.itemProperties.addAll(
        itemProperties.map((x) => ItemProperty.fromJson(x)),
      );
    } catch (e) {
      errors.add(
        DataLoadError(
          itemType: 'item',
          itemName: 'items-base',
          filePath: path,
          error: e.toString(),
        ),
      );
    }

    path = 'items.json';
    try {
      var json = await loadJson(path);
      var items = json["item"] as List<dynamic>;
      DataModel5e.items.addAll(
        items
            .where((x) => x is Map<String, dynamic> && !x.containsKey("_copy"))
            .map((x) => Item.fromJson(x)),
      );
      var itemGroups = json["itemGroup"] as List<dynamic>;
      DataModel5e.itemGroups.addAll(
        (itemGroups.map((x) => ItemGroup.fromJson(x))),
      );
    } catch (e) {
      errors.add(
        DataLoadError(
          itemType: 'item',
          itemName: 'items',
          filePath: path,
          error: e.toString(),
        ),
      );
    }

    DataModel5e.items.sortBy((x) => x.name);
    DataModel5e.itemGroups.sortBy((x) => x.name);
  }

  static Future loadSpells() async {
    var path = 'spells/sources.json';
    try {
      var json = await loadJson(path);
      for (var sourceEntry in json.entries) {
        var source = sourceEntry.key;
        DataModel5e.spellSources[source] = {};
        if (sourceEntry.value is Map<String, dynamic>) {
          for (var spellEntry
              in (sourceEntry.value as Map<String, dynamic>).entries) {
            DataModel5e.spellSources[source]![spellEntry.key] =
                SpellSource.fromJson(spellEntry.value);
          }
        }
      }
    } catch (e) {
      errors.add(
        DataLoadError(
          itemType: 'spell-source',
          itemName: 'sources',
          filePath: path,
          error: e.toString(),
        ),
      );
    }

    path = 'spells/index.json';
    var indexJson = await loadJson(path);
    final isPathAllowed = RegExp(r'^[a-zA-Z\-]+\.json$');
    for (var file in indexJson.values) {
      if (file is String && isPathAllowed.hasMatch(file)) {
        path = "spells/$file";
        try {
          var json = await loadJson(path);
          var spells = json["spell"] as List<dynamic>;
          DataModel5e.spells.addAll(spells.map((x) => Spell.fromJson(x)));
        } catch (e) {
          errors.add(
            DataLoadError(
              itemType: 'spell',
              itemName: file,
              filePath: path,
              error: e.toString(),
            ),
          );
        }
      }
    }

    DataModel5e.spells.sortBy((x) => x.name);
  }

  static Future loadOptionalFeatures() async {
    var path = 'optionalfeatures.json';
    try {
      var json = await loadJson(path);
      var items = json["optionalfeature"] as List<dynamic>;
      DataModel5e.optionalFeatures.addAll(
        items.map((x) => OptionalFeature.fromJson(x)),
      );
    } catch (e) {
      errors.add(
        DataLoadError(
          itemType: 'optionalfeature',
          itemName: 'optionalfeatures',
          filePath: path,
          error: e.toString(),
        ),
      );
    }
  }

  static Future loadConditions() async {
    var path = 'conditionsdiseases.json';
    try {
      var json = await loadJson(path);
      var conditions = json["condition"] as List<dynamic>;
      DataModel5e.conditions.addAll(
        conditions.map((x) => Condition.fromJson(x)),
      );
    } catch (e) {
      errors.add(
        DataLoadError(
          itemType: 'condition',
          itemName: 'conditionsdiseases',
          filePath: path,
          error: e.toString(),
        ),
      );
    }
  }

  static Future loadRaces() async {
    var path = 'races.json';
    try {
      var json = await loadJson(path);
      var races = json["race"] as List<dynamic>;
      DataModel5e.races.addAll(races.map((x) => Race.fromJson(x)));
      var subRaces = json["subrace"] as List<dynamic>;
      DataModel5e.subRaces.addAll(subRaces.map((x) => SubRace.fromJson(x)));
    } catch (e) {
      errors.add(
        DataLoadError(
          itemType: 'race',
          itemName: 'race',
          filePath: path,
          error: e.toString(),
        ),
      );
    }
  }

  static Future loadClasses() async {
    var indexPath = 'class/index.json';
    var index = await loadJson(indexPath);
    for (var kvp in index.entries) {
      var filename = kvp.value;
      if (filename == "class-sidekick.json") {
        continue;
      }
      if (filename is! String) {
        errors.add(
          DataLoadError(
            itemType: 'class',
            itemName: kvp.key,
            filePath: indexPath,
            error: "File name was not a string",
          ),
        );
        continue;
      }
      var path = 'class/$filename';
      if (!RegExp(r'^[a-zA-Z-]*\.json$').hasMatch(filename)) {
        errors.add(
          DataLoadError(
            itemType: 'class',
            itemName: kvp.key,
            filePath: path,
            error: "File name was not valid",
          ),
        );
        continue;
      }
      try {
        var json = await loadJson(path);
        var features = json["classFeature"] as List<dynamic>;
        DataModel5e.classFeatures.addAll(
          features.map((x) => ClassFeature5e.fromJson(x)),
        );
        var subclassFeature = json["subclassFeature"] as List<dynamic>?;
        DataModel5e.classFeatures.addAll(
          subclassFeature?.map((x) => ClassFeature5e.fromJson(x)) ?? [],
        );
        var classesJson = json["class"] as List<dynamic>;
        DataModel5e.classes.addAll(classesJson.map((x) => Class5e.fromJson(x)));
        var subClassesJson = json["subclass"] as List<dynamic>;
        DataModel5e.subClasses.addAll(
          subClassesJson.map((x) => SubClass.fromJson(x)),
        );
      } catch (e) {
        errors.add(
          DataLoadError(
            itemType: 'class',
            itemName: kvp.key,
            filePath: path,
            error: e.toString(),
          ),
        );
      }
    }
  }

  static Future<Map<String, dynamic>> loadJson(String path) async {
    String json = await rootBundle.loadString("data/$path");
    return await compute((j) => JsonProcesser5e.process(jsonDecode(j)), json);
  }

  static void _hydrateReferences() {
    for (var feat in DataModel5e.classFeatures) {
      _hydrateEntryReferences(feat.entries);
    }
    for (var item in DataModel5e.items) {
      item.hydrateReferences();
    }
    for (var item in DataModel5e.itemGroups) {
      item.hydrateReferences();
    }
    for (var spell in DataModel5e.spells) {
      spell.hydrateReferences();
    }
  }

  static void _hydrateEntryReferences(List<FeatureEntry> entries) {
    for (var entry in entries) {
      entry.hydrateReferences();
      if (entry.entries != null) {
        _hydrateEntryReferences(entry.entries!);
      }
    }
  }
}
