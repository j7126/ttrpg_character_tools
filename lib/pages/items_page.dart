import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:render_ttrpg_data/data_views/5e/items_view.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/pages/page_scaffold.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ItemsPage> {
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
          : ItemsView(items: DataLoader.items),
    );
  }
}
