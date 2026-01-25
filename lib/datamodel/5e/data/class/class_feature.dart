import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/base_object.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/book_source.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/feature/entry.dart';

part 'class_feature.g.dart';

@JsonSerializable(explicitToJson: true)
class ClassFeature5e extends BaseObject {
  ClassFeature5e({
    required super.name,
    required super.source,
    required super.page,
    super.otherSources,
    super.srd,
    required this.className,
    required this.classSource,
    required this.level,
    this.header = 0,
    this.entries = const [],
  });

  String className;
  String classSource;
  int level;
  int header;

  @JsonKey(
    includeFromJson: false,
    includeToJson: true,
  )
  List<FeatureEntry> entries;

  static ClassFeature5e? fromReference(List<ClassFeature5e>? features, String? reference) {
    var splitRef = reference?.split("|");

    if (features == null || splitRef == null || splitRef.length != 4) {
      return null;
    }

    var name = splitRef[0];
    var className = splitRef[1];
    var source = splitRef[2];
    var level = int.tryParse(splitRef[3]);
    return features.firstWhereOrNull((ClassFeature5e x) =>
        (name.isEmpty || x.name == name) &&
        (className.isEmpty || x.className == className) &&
        (source.isEmpty || x.source == source) &&
        (level == null || x.level == level));
  }

  factory ClassFeature5e.fromJson(Map<String, dynamic> json) {
    var feature = _$ClassFeature5eFromJson(json);
    var entries = <FeatureEntry>[];
    for (var entry in json["entries"] as List<dynamic>) {
      if (entry is String) {
        entries.add(FeatureEntry(
          type: FeatureEntryType.entry,
          name: entry,
        ));
      } else if (entry is Map<String, dynamic>) {
        entries.add(FeatureEntry.fromJson(entry));
      }
    }
    feature.entries = entries;
    return feature;
  }

  Map<String, dynamic> toJson() => _$ClassFeature5eToJson(this);
}
