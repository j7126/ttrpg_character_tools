import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:render_ttrpg_data/data_views/5e/classes_view.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/pages/class_page.dart';
import 'package:ttrpg_character_tools/pages/page_scaffold.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
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
      title: "Classes",
      body: !DataLoader.ready
          ? const Center(child: CircularProgressIndicator())
          : ClassesView(
              classes: DataLoader.classes,
              onOpen: (c) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClassPage(class5e: c),
                  ),
                );
              },
            ),
    );
  }
}
