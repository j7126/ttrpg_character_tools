import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';

class RaceField extends StatelessWidget {
  const RaceField({super.key});

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

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
                  if (!characterContext.character.hasRace() ||
                      characterContext.character.race.isEmpty)
                    Text("None Selected")
                  else ...[
                    Text(characterContext.character.race.split("|").first),
                    if (characterContext.character.race.split("|").length > 1)
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "(${characterContext.character.race.split("|")[1]})",
                          style: TextStyle(
                            fontSize: 12,
                            color: TextTheme.of(context).bodyMedium?.color
                                ?.withAlpha(160),
                          ),
                        ),
                      ),
                  ],
                  Spacer(),
                  Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.onSurface
                        .withAlpha(200),
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
                          color: ColorScheme.of(context).onSurface
                              .withAlpha(150),
                        ),
                      ),
                      onTap: () {
                        controller.closeView(null);
                        characterContext.character.race =
                            "${item.name}|${item.source}";
                        characterContext.changed();
                        characterContext.rebuildRulesData();
                      },
                    ),
                  );
            },
      ),
    );
  }
}
