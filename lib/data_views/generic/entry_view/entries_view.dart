import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/data_views/generic/entry_view/entry_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/feature/entry.dart';
import 'package:ttrpg_character_tools/theme/text_styles.dart';

class EntriesView extends StatelessWidget {
  const EntriesView({
    super.key,
    required this.entry,
    required this.header,
  });

  final FeatureEntry entry;
  final int header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            entry.name ?? "",
            style: TextStyles.of(context).getHeadline(header + 1),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var entry in entry.entries ?? [])
                  EntryView(
                    entry: entry,
                    header: header + 1,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
