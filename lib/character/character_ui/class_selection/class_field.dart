import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/character/character_ui/class_selection/manage_class_dialog.dart';

class ClassField extends StatelessWidget {
  const ClassField({super.key});

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

    String getClassText() {
      if (characterContext.character.classInfo.isEmpty) {
        return "None Selected";
      }

      var text = "";

      for (var classInfo in characterContext.character.classInfo) {
        if (text.isNotEmpty) {
          text += ", ";
        }
        text += "${classInfo.className} ${classInfo.classLevel}";
      }

      return text;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return ManageClassDialog(
                character: characterContext.character,
                changed: () {
                  characterContext.changed();
                  characterContext.rebuildRulesData();
                },
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
