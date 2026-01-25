import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/data_views/generic/entry_view/entry_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/condition/condition.dart';

class ConditionView extends StatelessWidget {
  const ConditionView({
    super.key,
    required this.condition,
    this.card = true,
  });

  final Condition condition;
  final bool card;

  @override
  Widget build(BuildContext context) {
    var featureView = SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            condition.name,
            style: TextTheme.of(context).titleLarge,
          ),
          for (var entry in condition.entries)
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
