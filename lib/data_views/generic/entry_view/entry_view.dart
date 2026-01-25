import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/data_views/generic/entry_view/entry_ability_stat_view.dart';
import 'package:ttrpg_character_tools/data_views/generic/entry_view/entries_view.dart';
import 'package:ttrpg_character_tools/data_views/generic/entry_view/list_view.dart';
import 'package:ttrpg_character_tools/data_views/generic/entry_view/ref_feature_view.dart';
import 'package:ttrpg_character_tools/data_views/generic/entry_view/table_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/feature/entry.dart';

class EntryView extends StatelessWidget {
  const EntryView({
    super.key,
    required this.entry,
    this.header = 1,
  });

  final FeatureEntry entry;
  final int header;

  @override
  Widget build(BuildContext context) {
    return switch (entry.type) {
      FeatureEntryType.entries => EntriesView(entry: entry, header: header,),
      FeatureEntryType.list => EntryListView(entry: entry),
      FeatureEntryType.item => Container(width: 200, height: 30, color: Colors.red, child: Text(entry.type.name)),
      FeatureEntryType.table => TableView(entry: entry),
      FeatureEntryType.options => Container(width: 200, height: 30, color: Colors.red, child: Text(entry.type.name)),
      FeatureEntryType.abilityDc => EntryAbilityStatView(entry: entry),
      FeatureEntryType.abilityAttackMod => EntryAbilityStatView(entry: entry),
      FeatureEntryType.refClassFeature => RefFeatureView(entry: entry),
      FeatureEntryType.refOptionalfeature =>
        Container(width: 200, height: 30, color: Colors.red, child: Text(entry.type.name)),
      FeatureEntryType.refSubclassFeature =>
        Container(width: 200, height: 30, color: Colors.red, child: Text(entry.type.name)),
      _ => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(entry.name ?? ""),
        ),
    };
  }
}
