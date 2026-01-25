import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/class/class.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/class/class_feature.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/condition/condition.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/item/item.dart';
import 'package:ttrpg_character_tools/datamodel/data_load_error.dart';

class DataLoader {
  static bool ready = false;
  static List<Class5e> classes = [];
  static List<ClassFeature5e> classFeatures = [];
  static List<Item> items = [];
  static List<Condition> conditions = [];

  static List<DataLoadError> errors = [];

  static Future loadData() async {
    if (ready) {
      return;
    }

    await loadClasses();
    await loadItems();
    await loadConditions();
    _hydrateReferences();
    ready = true;
  }

  static Future loadItems() async {
    var path = 'items-base.json';
    try {
      var json = await loadJson(path);
      var items = json["baseitem"] as List<dynamic>;
      DataLoader.items.addAll(items.map((x) => Item.fromJson(x)));
    } catch (e) {
      errors.add(DataLoadError(itemType: 'item', itemName: 'items-base', filePath: path, error: e.toString()));
    }

    path = 'items.json';
    try {
      var json = await loadJson(path);
      var items = json["item"] as List<dynamic>;
      DataLoader.items.addAll(
        items
            .where(
              (x) => x is Map<String, dynamic> && !x.containsKey("_copy"),
            )
            .map(
              (x) => Item.fromJson(x),
            ),
      );
    } catch (e) {
      errors.add(DataLoadError(itemType: 'item', itemName: 'items', filePath: path, error: e.toString()));
    }
  }

  static Future loadConditions() async {
    var path = 'conditionsdiseases.json';
    try {
      var json = await loadJson(path);
      var conditions = json["condition"] as List<dynamic>;
      DataLoader.conditions.addAll(conditions.map((x) => Condition.fromJson(x)));
    } catch (e) {
      errors.add(DataLoadError(itemType: 'condition', itemName: 'conditionsdiseases', filePath: path, error: e.toString()));
    }
  }

  static Future loadClasses() async {
    var indexPath = 'class/index.json';
    var index = await loadJson(indexPath);
    for (var kvp in index.entries) {
      var filename = kvp.value;
      if (filename is! String) {
        errors.add(DataLoadError(
            itemType: 'class', itemName: kvp.key, filePath: indexPath, error: "File name was not a string"));
        continue;
      }
      var path = 'class/$filename';
      if (!RegExp(r'^[a-zA-Z-]*\.json$').hasMatch(filename)) {
        errors
            .add(DataLoadError(itemType: 'class', itemName: kvp.key, filePath: path, error: "File name was not valid"));
        continue;
      }
      try {
        var json = await loadJson(path);
        var features = json["classFeature"] as List<dynamic>;
        classFeatures.addAll(features.map((x) => ClassFeature5e.fromJson(x)));
        var classesJson = json["class"] as List<dynamic>;
        classes.addAll(classesJson.map((x) => Class5e.fromJson(x)));
      } catch (e) {
        errors.add(DataLoadError(itemType: 'class', itemName: kvp.key, filePath: path, error: e.toString()));
      }
    }
  }

  static Future<Map<String, dynamic>> loadJson(String path) async {
    String json = await rootBundle.loadString("data/$path");
    return await compute((j) => jsonDecode(j), json);
  }

  static void _hydrateReferences() {
    for (var feat in classFeatures) {
      for (var entry in feat.entries) {
        entry.hydrateFeatureReference();
      }
    }
  }
}
