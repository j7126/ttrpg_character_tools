import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/data_views/generic/entry_view/entry_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/item/item.dart';

class ItemView extends StatelessWidget {
  const ItemView({
    super.key,
    required this.item,
    this.card = true,
  });

  final Item item;
  final bool card;

  @override
  Widget build(BuildContext context) {
    var featureView = SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.name,
          ),
          for (var entry in item.entries)
            EntryView(
              entry: entry,
              header: 1,
            ),
        ],
      ),
    );
    return card
        ? Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: featureView,
            ),
          )
        : featureView;
  }
}
