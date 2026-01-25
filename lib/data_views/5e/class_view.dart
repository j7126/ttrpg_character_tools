import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/data_views/5e/feature_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/class/class.dart';

class ClassView extends StatelessWidget {
  const ClassView({
    super.key,
    required this.class5e,
    this.showTitle = true,
  });

  final Class5e class5e;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              class5e.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            for (var feat in class5e.classFeatures)
              FeatureView(
                feature: feat,
              ),
          ],
        ),
      ),
    );
  }
}
