import 'package:json_annotation/json_annotation.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/base_object.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/book_source.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/feature/entry.dart';

part 'condition.g.dart';

@JsonSerializable(explicitToJson: true)
class Condition extends BaseObject {
  Condition({
    required super.name,
    required super.source,
    super.page,
    super.otherSources,
    super.srd,
    this.entries = const [],
  });

  @JsonKey(
    includeFromJson: false,
    includeToJson: true,
  )
  List<FeatureEntry> entries;

  factory Condition.fromJson(Map<String, dynamic> json) {
    var feature = _$ConditionFromJson(json);
    var entries = <FeatureEntry>[];
    if (json["entries"] != null) {
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
    }
    feature.entries = entries;
    return feature;
  }

  Map<String, dynamic> toJson() => _$ConditionToJson(this);

  bool searchCompare(String searchString) {
    return name.toLowerCase().contains(searchString) ||
        (srd is String && srd.toLowerCase().contains(searchString));
  }
}
