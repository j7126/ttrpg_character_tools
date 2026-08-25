import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/data_views/5e/feature_view.dart';
import 'package:render_ttrpg_data/data_views/generic/entry_view/entry_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class_feature.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/generic/entry.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/interface/feature_like.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/race/race_feature.dart';
import 'package:render_ttrpg_data/theme/text_styles.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/build_character/character_choice_card.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_class_info_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';

class CharacterFeatures extends StatefulWidget {
  const CharacterFeatures({super.key});

  @override
  State<CharacterFeatures> createState() => _CharacterFeaturesState();
}

class _CharacterFeaturesState extends State<CharacterFeatures> {
  Type? filterMode;
  List<String> excludedClasses = [];

  List<Widget> _buildFeatures() {
    var characterContext = CharacterContext.of(context);

    List<Widget> widgets = [];
    List<FeatureLike> features = [];

    // add class features
    if (filterMode == null || filterMode == ClassFeature5e) {
      for (var classInfo in characterContext.character.classInfo) {
        var class5e = classInfo.getClass();
        if (class5e != null && !excludedClasses.contains(class5e.name)) {
          for (var feat in class5e.classFeatures) {
            if (feat.level <= classInfo.classLevel) {
              features.add(feat);
              var subClass = classInfo.getSubClass();
              if (subClass != null &&
                  class5e.gainSubClassFeatures.any(feat.refCompare)) {
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
      var race = characterContext.character.getRace();
      if (race != null) {
        var excludedEntries = ["speed", "creature type"];
        for (var entry in race.entries) {
          if (entry.name != null &&
              !excludedEntries.contains(entry.name!.toLowerCase())) {
            var feature = RaceFeature(
              name: entry.name!,
              source: race.source,
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
          shouldReplaceEntryViewFunc: (entry) =>
              entry.type == FeatureEntryType.options &&
              characterContext.characterChoices.any(
                (x) => x.reference == feat.refString,
              ),
          entryViewReplacementBuilder: (context, entry) {
            var choice = characterContext.characterChoices.firstWhereOrNull(
              (x) => x.reference == feat.refString,
            );
            if (choice == null) {
              return null;
            }
            var currentChoice = choice.getCurrentChoice(
              characterContext.character,
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${choice.name} options - choose ${choice.chooseQty}",
                      style: TextStyles.of(context).headline3,
                    ),
                    Spacer(),
                    IconButton(
                      iconSize: 18,
                      onPressed: () async {
                        await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Text(choice.name),
                                  Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                              content: Container(
                                constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width * 0.6 -
                                      64,
                                ),
                                child: CharacterChoiceCard(
                                  choice: choice,
                                  character: characterContext.character,
                                  changed: characterContext.changed,
                                  hasExpansionPanel: false,
                                  scrollable: true,
                                  card: false,
                                ),
                              ),
                            );
                          },
                        );
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
                if (currentChoice == null ||
                    currentChoice.choice.isEmpty ||
                    entry.entries == null)
                  Text("None Selected")
                else
                  ...[
                    for (var option in entry.entries!)
                      switch (option.type) {
                        FeatureEntryType.refOptionalfeature =>
                          option.referencedOptionalFeature == null ||
                                  !currentChoice.choice.any(
                                    (x) =>
                                        x.choiceReference ==
                                        option
                                            .referencedOptionalFeature!
                                            .refString,
                                  )
                              ? null
                              : EntryView(entry: option),
                        FeatureEntryType.refSubclassFeature =>
                          option.classFeature == null ||
                                  !currentChoice.choice.any(
                                    (x) =>
                                        x.choiceReference ==
                                        option.referencedFeature!.refString,
                                  )
                              ? null
                              : EntryView(entry: option),
                        _ => null,
                      },
                  ].nonNulls,
              ],
            );
          },
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

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
                          characterContext.character.classInfo.length > 1)
                        for (var cl in characterContext.character.classInfo)
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
