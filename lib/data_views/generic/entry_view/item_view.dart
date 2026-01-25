import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/feature/entry.dart';

class EntryItemView extends StatelessWidget {
  const EntryItemView({super.key, required this.entry});

  final FeatureEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.remove, size: 20),
          Gap(8.0),
          Flexible(
            child: Text(
              entry.name ?? "",
              style: TextTheme.of(context).bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
