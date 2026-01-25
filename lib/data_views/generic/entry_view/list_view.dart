import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/data_views/generic/entry_view/item_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/feature/entry.dart';

class EntryListView extends StatelessWidget {
  const EntryListView({
    super.key,
    required this.entry,
  });

  final FeatureEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var entry in entry.items ?? [])
                  EntryItemView(
                    entry: entry,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
