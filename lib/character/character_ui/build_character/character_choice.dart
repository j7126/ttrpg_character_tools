import 'package:render_ttrpg_data/datamodel/5e/data/interface/optional_feature_progression_mixin.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_build_choice.pb.dart';
import 'package:collection/collection.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class_feature.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/generic/entry.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/interface/additional_spells_mixin.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/optional_feature_progression.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_class_info.pb.dart';

class CharacterChoice {
  const CharacterChoice({
    required this.reference,
    required this.name,
    required this.sourceLabel,
    required this.options,
    required this.chooseQty,
    required this.hasProgression,
    this.level,
  });

  final String reference;
  final String name;
  final String sourceLabel;
  final List<CharacterBuildChoiceSelection> options;
  final int chooseQty;
  final bool hasProgression;
  final int? level;

  CharacterBuildChoice? getCurrentChoice(Character character) =>
      character.characterBuildChoices[reference];

  static Iterable<CharacterChoice> getAdditionalSpellsChoice(
    AdditionalSpellsMixin additionalSpellProvider,
  ) {
    if (additionalSpellProvider.additionalSpells != null &&
        additionalSpellProvider.additionalSpells!.length > 1 &&
        !additionalSpellProvider.additionalSpells!.any(
          (x) => !x.containsKey("name"),
        )) {
      return [
        CharacterChoice(
          reference: additionalSpellProvider.refString,
          name: additionalSpellProvider.name,
          sourceLabel: additionalSpellProvider.sourceLabel,
          options: additionalSpellProvider.additionalSpells!
              .map(
                (x) => CharacterBuildChoiceSelection(
                  choiceName: x["name"] as String,
                ),
              )
              .toList(),
          chooseQty: 1,
          hasProgression: false,
          level: additionalSpellProvider is ClassFeature5e
              ? additionalSpellProvider.level
              : null,
        ),
      ];
    }

    return [];
  }

  static Iterable<CharacterChoice> getOptionalFeatureChoice(
    ClassFeature5e feat,
    Map<String, List<OptionalFeatureProgression>> progression,
    int classLevel,
  ) {
    var options = feat.entries.firstWhereOrNull(
      (x) => x.type == FeatureEntryType.options,
    );
    if (options != null &&
        options.entries != null &&
        options.count != null &&
        options.count! > 0) {
      var count = options.count!;
      var hasProgression = count > 1;
      if (progression.containsKey(feat.name)) {
        count = 0;
        hasProgression = true;
        // find fixed progression
        for (var prg in progression[feat.name]!) {
          var progressionMap = prg.progression;
          if (progressionMap is List<int> &&
              classLevel <= progressionMap.length) {
            count = progressionMap[classLevel - 1];
          }
        }
        // add additional progression
        for (var prg in progression[feat.name]!) {
          var progressionMap = prg.progression;
          if (progressionMap is Map<String, dynamic>) {
            for (var level = 1; level <= classLevel; level++) {
              var levelPrg = progressionMap[level.toString()];
              if (levelPrg is int) {
                count += levelPrg;
              }
            }
          }
        }
      }

      return [
        CharacterChoice(
          reference: feat.refString,
          name: feat.name,
          sourceLabel: feat.sourceLabel,
          options: options.entries!
              .map<CharacterBuildChoiceSelection?>(
                (x) => switch (x.type) {
                  FeatureEntryType.refOptionalfeature =>
                    x.referencedOptionalFeature == null
                        ? null
                        : CharacterBuildChoiceSelection(
                            choiceName: x.referencedOptionalFeature!.name,
                            choiceReference:
                                x.referencedOptionalFeature!.refString,
                          ),
                  FeatureEntryType.refSubclassFeature =>
                    x.classFeature == null
                        ? null
                        : CharacterBuildChoiceSelection(
                            choiceName: x.referencedFeature!.name,
                            choiceReference: x.referencedFeature!.refString,
                          ),
                  _ => null,
                },
              )
              .nonNulls
              .toList(),
          chooseQty: count,
          hasProgression: hasProgression,
          level: feat.level,
        ),
      ];
    }

    return [];
  }

  static List<CharacterChoice> getChoices(
    Character character,
    List<(dynamic obj, CharacterClassInfo? classInfo)> allRulesObjs,
  ) {
    List<CharacterChoice> choices = [];
    List<OptionalFeatureProgression> optionalFeatureProgressionList = [];

    // get optional feature progression.
    for (var (obj, classInfo) in allRulesObjs) {
      if (obj is OptionalFeatureProgressionMixin && classInfo != null) {
        List<OptionalFeatureProgression> optionalfeatureProgression =
            obj.optionalfeatureProgression ?? [];
        optionalFeatureProgressionList.addAll(
          optionalfeatureProgression.map(
            (x) => x = OptionalFeatureProgression(
              name: x.name,
              featureType: x.featureType,
              progression: x.progression,
              required: x.required,
              classSource: classInfo.className,
            ),
          ),
        );
      }
    }

    var optionalFeatureProgression = optionalFeatureProgressionList
        .groupListsBy((x) => x.classSource)
        .map((key, val) => MapEntry(key, val.groupListsBy((x) => x.name)));

    // all choices
    for (var (obj, classInfo) in allRulesObjs) {
      if (obj is AdditionalSpellsMixin) {
        choices.addAll(getAdditionalSpellsChoice(obj));
      }
      if (obj is ClassFeature5e && classInfo != null) {
        choices.addAll(
          getOptionalFeatureChoice(
            obj,
            optionalFeatureProgression[obj.className] ?? {},
            classInfo.classLevel,
          ),
        );
      }
    }

    choices.sort(
      (a, b) => a.level == null || b.level == null ? 0 : a.level! - b.level!,
    );

    return choices;
  }
}
