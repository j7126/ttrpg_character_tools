import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/data_views/5e/feature_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class_feature.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/feature_like.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/generic/entry.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/race/race_feature.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_class_info_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class CharacterFeatures extends StatefulWidget {
  const CharacterFeatures({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  @override
  State<CharacterFeatures> createState() => _CharacterFeaturesState();
}

class _CharacterFeaturesState extends State<CharacterFeatures> {
  Type? filterMode;
  List<String> excludedClasses = [];

  List<Widget> _buildFeatures() {
    List<Widget> widgets = [];
    List<FeatureLike> features = [];

    // add class features
    if (filterMode == null || filterMode == ClassFeature5e) {
      for (var classInfo in widget.character.classInfo) {
        var class5e = classInfo.getClass();
        if (class5e != null && !excludedClasses.contains(class5e.name)) {
          for (var feat in class5e.classFeatures) {
            if (feat.level <= classInfo.classLevel) {
              features.add(feat);
              var subClass = classInfo.getSubClass();
              if (subClass != null &&
                  class5e.gainSubClassFeatures.any(feat.matchesReference)) {
                for (var subFeat in subClass.subclassFeatures) {
                  if (subFeat.level == feat.level) {
                    features.add(subFeat);
                  }
                }
              }
            }
          }
        }
      }
    }

    if (filterMode == null || filterMode == RaceFeature) {
      if (widget.character.hasRace() && widget.character.race.isNotEmpty) {
        var raceParts = widget.character.race.split("|");
        var raceName = raceParts[0];
        var raceSource = raceParts.length > 1 ? raceParts[1] : null;
        var race = DataModel5e.races.firstWhereOrNull(
          (x) =>
              x.name == raceName &&
              (raceSource == null || x.source == raceSource),
        );
        var excludedEntries = ["speed", "creature type"];
        for (var entry in race?.entries ?? <FeatureEntry>[]) {
          if (entry.name != null &&
              !excludedEntries.contains(entry.name!.toLowerCase())) {
            var feature = RaceFeature(
              name: entry.name!,
              source: race!.source,
              page: race.page,
              otherSources: race.otherSources,
              srd: race.srd,
              raceName: race.name,
              raceSource: race.source,
              entries: entry.entries ?? [],
            );
            features.add(feature);
          }
        }
      }
    }

    features.sortBy((x) => x.order);
    for (var feat in features) {
      widgets.add(
        FeatureView(
          feature: feat,
          card: false,
          showDetailsInHeader: true,
          collapsible: true,
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: "Features and Traits",
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 6.0),
        ),
        child: !DataLoader.ready
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text("All"),
                          selected: filterMode == null,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                filterMode = null;
                                excludedClasses.clear();
                              }
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text("Race"),
                          selected: filterMode == RaceFeature,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                filterMode = RaceFeature;
                              }
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text("Class"),
                          selected: filterMode == ClassFeature5e,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                filterMode = ClassFeature5e;
                                excludedClasses.clear();
                              }
                            });
                          },
                        ),
                      ),
                      Spacer(),
                      if (filterMode == ClassFeature5e &&
                          widget.character.classInfo.length > 1)
                        for (var cl in widget.character.classInfo)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: FilterChip(
                              label: Text(cl.className),
                              selected: !excludedClasses.contains(cl.className),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    excludedClasses.remove(cl.className);
                                  } else {
                                    excludedClasses.add(cl.className);
                                  }
                                });
                              },
                            ),
                          ),
                    ],
                  ),
                  ..._buildFeatures(),
                ],
              ),
      ),
    );
  }
}
