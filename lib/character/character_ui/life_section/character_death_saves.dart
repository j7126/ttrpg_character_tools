import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class CharacterDeathSaves extends StatelessWidget {
  const CharacterDeathSaves({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  Widget successCheckbox(int num) {
    return Checkbox(
      value: character.life.deathSaveSuccess >= num,
      onChanged: (val) {
        if (val == true) {
          character.life.deathSaveSuccess++;
        } else {
          character.life.deathSaveSuccess--;
        }
        changed();
      },
    );
  }

  Widget failCheckbox(int num) {
    return Checkbox(
      value: character.life.deathSaveFailure >= num,
      onChanged: (val) {
        if (val == true) {
          character.life.deathSaveFailure++;
        } else {
          character.life.deathSaveFailure--;
        }
        changed();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Death Saves",
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Successes"),
                successCheckbox(1),
                successCheckbox(2),
                successCheckbox(3),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
    );
  }
}
