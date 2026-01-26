import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:render_ttrpg_data/data_views/5e/conditions_view.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/pages/page_scaffold.dart';

class ConditionsPage extends StatefulWidget {
  const ConditionsPage({super.key});

  @override
  State<ConditionsPage> createState() => _ConditionsPageState();
}

class _ConditionsPageState extends State<ConditionsPage> {
  void load() async {
    await DataLoader.loadData();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    load();
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
          : ConditionsView(conditions: DataLoader.conditions),
    );
  }
}
