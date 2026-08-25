import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/build_character/character_choice.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_class_info.pb.dart';

class CharacterContext extends InheritedWidget {
  const CharacterContext({
    super.key,
    required this.character,
    required this.characterChoices,
    required this.allRulesObjs,
    required this.changed,
    required this.rebuildRulesData,
    required super.child,
  });

  final Character character;
  final List<CharacterChoice> characterChoices;
  final List<(dynamic obj, CharacterClassInfo? classInfo)> allRulesObjs;
  final Function() changed;
  final Function() rebuildRulesData;

  static CharacterContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CharacterContext>();
  }

  static CharacterContext of(BuildContext context) {
    final CharacterContext? result = maybeOf(context);
    assert(result != null, 'No CharacterContext found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CharacterContext oldWidget) =>
      oldWidget.changed != changed ||
      oldWidget.character != character ||
      oldWidget.rebuildRulesData != rebuildRulesData ||
      oldWidget.characterChoices != characterChoices ||
      oldWidget.allRulesObjs != allRulesObjs;
}
