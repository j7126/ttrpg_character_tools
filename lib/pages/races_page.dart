import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/data_views/5e/races_view.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/pages/page_scaffold.dart';

class RacesPage extends StatefulWidget {
  const RacesPage({super.key});

  @override
  State<RacesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<RacesPage> {
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
      title: "Items",
      body: !DataLoader.ready
          ? const Center(child: CircularProgressIndicator())
          : RacesView(),
    );
  }
}
