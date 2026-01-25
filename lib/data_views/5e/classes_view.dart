import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/class/class.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data_loader.dart';
import 'package:ttrpg_character_tools/pages/class_page.dart';

class ClassesView extends StatelessWidget {
  const ClassesView({super.key});

  void openClass(BuildContext context, Class5e c) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClassPage(
          class5e: c,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var foregroundColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white;

    return DataLoader.ready
        ? Table(
            children: [
              const TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                      child: Text(
                        "Class",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                      child: Text(
                        "Source",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              for (var (index, class5e) in DataLoader.classes.indexed)
                TableRow(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? foregroundColor.withAlpha(30) : null,
                  ),
                  children: [
                    TableCell(
                      child: GestureDetector(
                        onTap: () => openClass(context, class5e),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                          child: Text(
                            class5e.name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                        child: Text(
                          class5e.source,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
            ],
          )
        : Container();
  }
}
