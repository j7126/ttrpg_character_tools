import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/data_views/5e/spells_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/pages/page_scaffold.dart';

class SpellsPage extends StatefulWidget {
  const SpellsPage({super.key});

  @override
  State<SpellsPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<SpellsPage> {
  @override
  void initState() {
    DataLoader.loadData();
    DataLoader.readyNotifier.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var adaptiveInfo = AdaptiveInfo.of(context);

    return PageScaffold(
      adaptiveInfo: adaptiveInfo,
      title: "Spells",
      body: !DataLoader.ready
          ? const Center(child: CircularProgressIndicator())
          : SpellsView(spells: DataModel5e.spells),
    );
  }
}
