import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/data_views/5e/class_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({
    super.key,
    required this.class5e,
  });

  final Class5e class5e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(class5e.name),
      ),
      body: ClassView(
        class5e: class5e,
        showTitle: false,
      ),
    );
  }
}
