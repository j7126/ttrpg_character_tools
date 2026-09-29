import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/data_views/5e/background_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/interface/reference_mixin.dart';
import 'package:render_ttrpg_data/widgets/link_with_content_tooltip.dart';
import 'package:ttrpg_character_tools/character/character_context.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_extension.dart';

class BackgroundField extends StatefulWidget {
  const BackgroundField({super.key});

  @override
  State<BackgroundField> createState() => _BackgroundFieldState();
}

class _BackgroundFieldState extends State<BackgroundField> {
  @override
  Widget build(BuildContext context) {
    var characterContext = CharacterContext.of(context);

    var backgroundParts = characterContext.character.hasBackground()
        ? ReferenceMixin.parseRefString(
            characterContext.character.background,
            null,
          )
        : null;

    var mainSearchAnchor = SearchAnchor(
      viewHintText: "Select background",
      builder: (BuildContext context, SearchController controller) {
        return GestureDetector(
          onTap: () => controller.openView(),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: "Background",
              border: OutlineInputBorder(),
            ),
            child: Row(
              children: [
                if (backgroundParts == null ||
                    characterContext.character.background.isEmpty)
                  Text("None Selected")
                else ...[
                  Text(
                    characterContext.character.getBackground()?.name ??
                        backgroundParts.first,
                  ),
                  if (backgroundParts.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        "(${backgroundParts[1].toUpperCase()})",
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
        return DataModel5e.backgrounds
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
                        tooltipView: BackgroundView(
                          background: item,
                          card: true,
                          outlined: true,
                          scrollable: true,
                        ),
                        contentView: BackgroundView(
                          background: item,
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
                  characterContext.character.background = item.refString;
                  characterContext.changed();
                  characterContext.rebuildRulesData();
                },
              ),
            );
      },
    );

    return Padding(padding: const EdgeInsets.all(8.0), child: mainSearchAnchor);
  }
}
