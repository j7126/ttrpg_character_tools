import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/data_views/generic/entry_view/entry_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/class/class_feature.dart';
import 'package:ttrpg_character_tools/theme/text_styles.dart';

class FeatureView extends StatelessWidget {
  const FeatureView({
    super.key,
    required this.feature,
    this.card = true,
  });

  final ClassFeature5e feature;
  final bool card;

  @override
  Widget build(BuildContext context) {
    var featureView = SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            feature.name,
            style: TextStyles.of(context).getHeadline(feature.header),
          ),
          for (var entry in feature.entries)
            EntryView(
              entry: entry,
              header: feature.header,
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
