import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_ui/class_selection/manage_class_dialog.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class ClassField extends StatelessWidget {
  const ClassField({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  String getClassText() {
    if (character.classAndLevel.isEmpty) {
      return "None Selected";
    }

    var text = "";

    for (var kvp in character.classAndLevel.entries) {
      if (text.isNotEmpty) {
        text += ", ";
      }
      text += "${kvp.key} ${kvp.value}";
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return ManageClassDialog(
                character: character,
                changed: changed,
              );
            },
          );
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: "Class and Level",
            border: OutlineInputBorder(),
          ),
          child: Row(
            children: [
              Text(getClassText()),
              Spacer(),
              Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
