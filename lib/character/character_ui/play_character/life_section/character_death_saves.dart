import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';

class CharacterDeathSaves extends StatelessWidget {
  const CharacterDeathSaves({super.key});

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

    Widget successCheckbox(int num) {
      return Checkbox(
        value: characterContext.character.life.deathSaveSuccess >= num,
        onChanged: (val) {
          if (val == true) {
            characterContext.character.life.deathSaveSuccess++;
          } else {
            characterContext.character.life.deathSaveSuccess--;
          }
          characterContext.changed();
        },
      );
    }

    Widget failCheckbox(int num) {
      return Checkbox(
        value: characterContext.character.life.deathSaveFailure >= num,
        onChanged: (val) {
          if (val == true) {
            characterContext.character.life.deathSaveFailure++;
          } else {
            characterContext.character.life.deathSaveFailure--;
          }
          characterContext.changed();
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Death Saves",
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Successes"),
                  successCheckbox(1),
                  successCheckbox(2),
                  successCheckbox(3),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Failures"),
                  failCheckbox(1),
                  failCheckbox(2),
                  failCheckbox(3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
