import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_class_info_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class CharacterSpells extends StatelessWidget {
  const CharacterSpells({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  @override
  Widget build(BuildContext context) {
    var classes = character.classInfo.map((info) => (info, info.getClass()));
    return Text("");
  }
}
