import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_manager.dart';
import 'package:ttrpg_character_tools/character/character_ui/build_character/character_build_ui.dart';
import 'package:ttrpg_character_tools/character/character_ui/build_character/character_choice.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/base_field/text_field_base.dart';
import 'package:ttrpg_character_tools/character/character_ui/play_character/character_play_ui.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_class_info_extension.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_class_info.pb.dart';
import 'package:ttrpg_character_tools/pages/page_scaffold.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  bool isPlayMode = false;
  Character? currentCharacter;
  List<CharacterChoice> characterChoices = [];
  List<(dynamic obj, CharacterClassInfo? classInfo)> allRulesObjs = [];

  void changed() {
    setState(() {
      CharacterManager.instance.saveCharacter();
    });
  }

  void rebuildRulesData() {
    if (mounted) {
      setState(() {
        refreshAllRulesObjs();
        rebuildChoices();
      });
    }
  }

  void refreshAllRulesObjs() {
    if (currentCharacter == null) {
      return;
    }

    setState(() {
      allRulesObjs = [];

      // class
      for (var classInfo in currentCharacter!.classInfo) {
        var class5e = classInfo.getClass();
        var subClass = classInfo.getSubClass();
        if (class5e != null) {
          allRulesObjs.add((class5e, classInfo));
          for (var feat in class5e.classFeatures) {
            if (feat.level <= classInfo.classLevel) {
              if (subClass != null &&
                  class5e.gainSubClassFeatures.any(feat.refCompare)) {
                for (var subFeat in subClass.subclassFeatures) {
                  if (subFeat.level == feat.level) {
                    allRulesObjs.add((subFeat, classInfo));
                  }
                }
              } else {
                allRulesObjs.add((feat, classInfo));
              }
            }
          }
        }
        if (subClass != null) {
          allRulesObjs.add((subClass, classInfo));
        }
      }

      // race
      var race = currentCharacter!.getRace();
      if (race != null) {
        allRulesObjs.add((race, null));
      }

      // subRace
      var subRace = currentCharacter!.getSubRace();
      if (subRace != null) {
        allRulesObjs.add((subRace, null));
      }
    });
  }

  void rebuildChoices() {
    if (currentCharacter == null) {
      return;
    }
    setState(() {
      characterChoices = CharacterChoice.getChoices(
        currentCharacter!,
        allRulesObjs,
      );
    });
  }

  void _dataLoaderReadyListener() {
    rebuildRulesData();
  }

  @override
  void initState() {
    DataLoader.loadData();
    DataLoader.readyNotifier.addListener(_dataLoaderReadyListener);
    super.initState();
  }

  @override
  void dispose() {
    DataLoader.readyNotifier.removeListener(_dataLoaderReadyListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var adaptiveInfo = AdaptiveInfo.of(context);

    if (!CharacterManager.instance.isOpen ||
        CharacterManager.instance.character == null) {
      return PageScaffold(
        adaptiveInfo: adaptiveInfo,
        title: "Character",
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("You don't have a character open."),
              Gap(16.0),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/characters");
                },
                child: Text("Open Character"),
              ),
            ],
          ),
        ),
      );
    }

    if (currentCharacter != CharacterManager.instance.character) {
      currentCharacter = CharacterManager.instance.character;
      isPlayMode = currentCharacter!.isValid;
      rebuildRulesData();
    }

    return PageScaffold(
      adaptiveInfo: adaptiveInfo,
      title: currentCharacter!.name.isEmpty
          ? "Character"
          : currentCharacter!.name,
      titleWidget: Builder(
        builder: (context) {
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFieldBase(
                    label: "Name",
                    inputBorder: InputBorder.none,
                    textAlign: TextAlign.center,
                    textStyle: DefaultTextStyle.of(context).style,
                    value: currentCharacter!.name,
                    valueChanged: (val) {
                      if (currentCharacter != null) {
                        currentCharacter!.name = val;
                        changed();
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text("Build"),
                  selected: !isPlayMode,
                  onSelected: (bool selected) {
                    setState(() {
                      isPlayMode = !selected;
                    });
                  },
                ),
              ),
              FilterChip(
                label: Text("Play"),
                selected: isPlayMode,
                onSelected: (bool selected) {
                  setState(() {
                    isPlayMode = selected;
                  });
                },
              ),
            ],
          );
        },
      ),
      body: CharacterContext(
        character: currentCharacter!,
        characterChoices: characterChoices,
        allRulesObjs: allRulesObjs,
        changed: changed,
        rebuildRulesData: rebuildRulesData,
        child: isPlayMode ? CharacterPlayUi() : CharacterBuildUi(),
      ),
    );
  }
}
