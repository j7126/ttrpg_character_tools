import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class RaceField extends StatelessWidget {
  const RaceField({super.key, required this.character, required this.changed});

  final Character character;
  final Function() changed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return GestureDetector(
            onTap: () => controller.openView(),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: "Race",
                border: OutlineInputBorder(),
              ),
              child: Row(
                children: [
                  if (!character.hasRace() || character.race.isEmpty)
                    Text("None Selected")
                  else ...[
                    Text(character.race.split("|").first),
                    if (character.race.split("|").length > 1)
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "(${character.race.split("|")[1]})",
                          style: TextStyle(
                            fontSize: 12,
                            color: TextTheme.of(context).bodyMedium?.color?.withAlpha(160),
                          ),
                        ),
                      ),
                  ],
                  Spacer(),
                  Icon(
                    Icons.edit,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(200),
                  ),
                ],
              ),
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
              return DataModel5e.races
                  .where(
                    (x) => x.name.toLowerCase().contains(
                      controller.text.toLowerCase(),
                    ),
                  )
                  .map(
                    (item) => ListTile(
                      title: Text(item.name),
                      trailing: Text(
                        item.source,
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorScheme.of(
                            context,
                          ).onSurface.withAlpha(150),
                        ),
                      ),
                      onTap: () {
                        controller.closeView(null);
                        character.race = "${item.name}|${item.source}";
                        changed();
                      },
                    ),
                  );
            },
      ),
    );
  }
}
