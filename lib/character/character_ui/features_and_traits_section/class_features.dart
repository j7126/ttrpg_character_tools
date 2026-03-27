import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/data_views/5e/feature_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class_feature.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class ClassFeatures extends StatelessWidget {
  const ClassFeatures({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  List<Widget> _buildFeatures() {
    List<Widget> widgets = [];
    List<ClassFeature5e> features = [];
    for (var kvp in character.classAndLevel.entries) {
      var class5e = DataLoader.classes.firstWhereOrNull(
        (c) => c.name == kvp.key,
      );
      if (class5e != null) {
        for (var feat in class5e.classFeatures) {
          if (feat.level <= kvp.value) {
            features.add(feat);
          }
        }
      }
    }
    features.sortBy((x) => x.level);
    for (var feat in features) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: FeatureView(
            feature: feat,
            card: false,
            showDetailsInHeader: true,
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: "Features and Traits",
          border: OutlineInputBorder(),
        ),
        child: !DataLoader.ready
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: _buildFeatures(),
              ),
      ),
    );
  }
}
