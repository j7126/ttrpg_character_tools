import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/data_views/5e/race_view.dart';
import 'package:render_ttrpg_data/data_views/5e/sub_race_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/interface/reference_mixin.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/race/race.dart';
import 'package:render_ttrpg_data/widgets/link_with_content_tooltip.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';

class RaceField extends StatefulWidget {
  const RaceField({super.key});

  @override
  State<RaceField> createState() => _RaceFieldState();
}

class _RaceFieldState extends State<RaceField> {
  final SearchController subRaceSearchController = SearchController();

  Race? currentRaceCache;

  @override
  void dispose() {
    subRaceSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

    var raceParts = characterContext.character.hasRace()
        ? characterContext.character.race.split("|")
        : null;
    var subRaceParts = characterContext.character.hasSubRace()
        ? ReferenceMixin.parseRefString(
            characterContext.character.subRace,
            null,
          )
        : null;

    var mainSearchAnchor = SearchAnchor(
      viewHintText: "Select race",
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
                if (raceParts == null ||
                    characterContext.character.race.isEmpty)
                  Text("None Selected")
                else ...[
                  Text(raceParts.first),
                  if (subRaceParts != null &&
                      subRaceParts.length > 1 &&
                      subRaceParts[1].toLowerCase() !=
                          raceParts.first.toLowerCase())
                    Text(" (${subRaceParts[1]})"),
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
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
                ),
              ],
            ),
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return DataModel5e.races
            .where(
              (x) =>
                  x.name.toLowerCase().contains(controller.text.toLowerCase()),
            )
            .map(
              (item) => ListTile(
                title: Text(item.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.source,
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorScheme.of(context).onSurface.withAlpha(150),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: LinkWithContentTooltip(
                        tooltipView: RaceView(
                          race: item,
                          card: true,
                          outlined: true,
                          scrollable: true,
                        ),
                        contentView: RaceView(race: item, card: false),
                        text: "",
                        style: null,
                        linkMode: LinkTooltipViewMode.helpIcon,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  controller.closeView(null);
                  characterContext.character.race =
                      "${item.name}|${item.source}";
                  characterContext.character.clearSubRace();
                  var availableSubRaces = DataModel5e.subRaces
                      .where((x) => x.raceName == item.name)
                      .toList();
                  var autoSubRace = availableSubRaces.firstWhereOrNull(
                    (x) => x.name == null,
                  );
                  if (autoSubRace != null) {
                    characterContext.character.subRace = autoSubRace.refString;
                  }
                  characterContext.changed();
                  characterContext.rebuildRulesData();
                  if (availableSubRaces.any((x) => x != autoSubRace)) {
                    currentRaceCache = item;
                    subRaceSearchController.openView();
                  }
                },
              ),
            );
      },
    );

    var subRaceSearchAnchor = SearchAnchor(
      searchController: subRaceSearchController,
      viewHintText: "Select sub-race",
      builder: (BuildContext context, SearchController controller) {
        return Container();
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return DataModel5e.subRaces
            .where(
              (x) =>
                  x.raceName.toLowerCase() ==
                  characterContext.character.race
                      .split("|")
                      .firstOrNull
                      ?.toLowerCase(),
            )
            .where(
              (x) =>
                  x.name?.toLowerCase().contains(
                    controller.text.toLowerCase(),
                  ) ??
                  true,
            )
            .map(
              (item) => ListTile(
                title: Text(item.variableName),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.source,
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorScheme.of(context).onSurface.withAlpha(150),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: LinkWithContentTooltip(
                        tooltipView: SubRaceView(
                          race: currentRaceCache!,
                          subRace: item,
                          card: true,
                          outlined: true,
                          scrollable: true,
                        ),
                        contentView: SubRaceView(
                          race: currentRaceCache!,
                          subRace: item,
                          card: false,
                        ),
                        text: "",
                        style: null,
                        linkMode: LinkTooltipViewMode.helpIcon,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  controller.closeView(null);
                  characterContext.character.subRace = item.refString;
                  characterContext.changed();
                  characterContext.rebuildRulesData();
                },
              ),
            );
      },
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [subRaceSearchAnchor, mainSearchAnchor],
      ),
    );
  }
}
