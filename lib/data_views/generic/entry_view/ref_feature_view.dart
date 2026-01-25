import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/data_views/5e/feature_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/feature/entry.dart';

class RefFeatureView extends StatelessWidget {
  const RefFeatureView({
    super.key,
    required this.entry,
  });

  final FeatureEntry entry;

  @override
  Widget build(BuildContext context) {
    if (entry.referencedFeature != null) {
      return FeatureView(
        feature: entry.referencedFeature!,
        card: false,
      );
    } else {
      return Container();
    }
  }
}
