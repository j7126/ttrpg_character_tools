import 'package:json_annotation/json_annotation.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/ability.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/class/class_feature.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data_loader.dart';

part 'entry.g.dart';

@JsonSerializable(explicitToJson: true)
class FeatureEntry {
  FeatureEntry({
    required this.type,
    this.count,
    this.name,
    this.caption,
    this.entries,
    this.attributes,
    this.colLabels,
    this.colStyles,
    this.rows,
    this.classFeature,
    this.optionalfeature,
    this.items,
    this.subclassFeature,
  });

  FeatureEntryType type;
  int? count;
  String? name;
  String? caption;
  List<Ability>? attributes;
  List<String>? colLabels;
  List<String>? colStyles;
  List<List<String>>? rows;
  String? classFeature;
  String? optionalfeature;
  String? subclassFeature;

  @JsonKey(
    includeFromJson: false,
    includeToJson: true,
  )
  List<FeatureEntry>? entries;

  @JsonKey(
    includeFromJson: false,
    includeToJson: true,
  )
  List<FeatureEntry>? items;

  @JsonKey(
    includeFromJson: false,
    includeToJson: true,
  )
  ClassFeature5e? referencedFeature;

  void hydrateFeatureReference() {
    if (type == FeatureEntryType.refClassFeature) {
      referencedFeature = ClassFeature5e.fromReference(DataLoader.classFeatures, classFeature);
    }
  }

  factory FeatureEntry.fromJson(Map<String, dynamic> json) {
    var feature = _$FeatureEntryFromJson(json);
    var jsonEntries = json["entries"] ?? json["items"];
    var isEntries = json["entries"] != null;
    if (jsonEntries != null) {
      var entries = <FeatureEntry>[];
      for (var entry in jsonEntries as List<dynamic>) {
        if (entry is String) {
          entries.add(FeatureEntry(
            type: isEntries ? FeatureEntryType.entry : FeatureEntryType.item,
            name: entry,
          ));
        } else if (entry is Map<String, dynamic>) {
          entries.add(FeatureEntry.fromJson(entry));
        }
      }
      if (isEntries) {
        feature.entries = entries;
      } else {
        feature.items = entries;
      }
    }
    return feature;
  }

  Map<String, dynamic> toJson() => _$FeatureEntryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FeatureEntryPreserve {
  FeatureEntryPreserve({
    required this.consumes,
  });

  bool consumes;

  factory FeatureEntryPreserve.fromJson(Map<String, dynamic> json) => _$FeatureEntryPreserveFromJson(json);

  Map<String, dynamic> toJson() => _$FeatureEntryPreserveToJson(this);
}

enum FeatureEntryType {
  entries,
  list,
  item,
  table,
  options,
  abilityDc,
  abilityAttackMod,
  refClassFeature,
  refOptionalfeature,
  refSubclassFeature,
  entry,
  inset,
}
