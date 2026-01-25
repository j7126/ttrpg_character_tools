import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:ttrpg_character_tools/data_views/5e/items_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data_loader.dart';
import 'package:ttrpg_character_tools/pages/page_scaffold.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ItemsPage> {
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
          : const ItemsView(),
    );
  }
}
