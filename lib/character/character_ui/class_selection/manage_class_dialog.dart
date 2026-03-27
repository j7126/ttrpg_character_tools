import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';

class ManageClassDialog extends StatefulWidget {
  const ManageClassDialog({
    super.key,
    required this.character,
    required this.changed,
  });

  final Character character;
  final Function() changed;

  @override
  State<ManageClassDialog> createState() => _ManageClassDialogState();
}

class _ManageClassDialogState extends State<ManageClassDialog> {
  final SearchController searchController = SearchController();

  void removeLevel(String className) async {
    var level = widget.character.classAndLevel[className] ?? 0;
    var confirmMessage = level > 1
        ? "Removing a level from $className will down level your character."
        : "Removing this level will remove the $className class from your character.";
    var result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Remove Level"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(confirmMessage),
              Text("Are you sure you want to do this?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("No"),
            ),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  ColorScheme.of(context).error,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
    if (result != true) {
      return;
    }
    setState(() {
      if (level > 1) {
        widget.character.classAndLevel[className] = level - 1;
      } else {
        widget.character.classAndLevel.remove(className);
      }
      widget.changed();
    });
  }

  void _dataLoaderReadyListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    DataLoader.readyNotifier.addListener(_dataLoaderReadyListener);
    super.initState();
  }

  @override
  void dispose() {
    DataLoader.readyNotifier.removeListener(_dataLoaderReadyListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 64.0,
      ),
      titlePadding: const EdgeInsets.only(top: 12.0, left: 18.0, right: 16.0),
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          const Text("Class and Level"),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SizedBox(
        width: min(MediaQuery.of(context).size.width - 32, 400.0),
        child: !DataLoader.ready
            ? SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                  top: 12.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var kvp in widget.character.classAndLevel.entries)
                      Card(
                        margin: EdgeInsets.only(bottom: 12.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Gap(8.0),
                                Text(kvp.key, style: TextStyle(fontSize: 20.0)),
                                Spacer(),
                                IconButton(
                                  onPressed: () => removeLevel(kvp.key),
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: ColorScheme.of(context).error,
                                  ),
                                ),
                                Text(
                                  "Level ${kvp.value}",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.character.classAndLevel[kvp.key] =
                                          kvp.value + 1;
                                      widget.changed();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    color: ColorScheme.of(context).primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    SearchAnchor(
                      searchController: searchController,
                      builder:
                          (BuildContext context, SearchController controller) {
                            return FilledButton(
                              onPressed: () {
                                controller.openView();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Add Class"), Icon(Icons.add)],
                              ),
                            );
                          },
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                            return DataLoader.classes
                                .where(
                                  (x) => x.name.toLowerCase().contains(
                                    searchController.text.toLowerCase(),
                                  ),
                                )
                                .map(
                                  (item) => ListTile(
                                    title: Text(item.name),
                                    trailing: Text(
                                      item.source,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: ColorScheme.of(
                                          context,
                                        ).onSurface.withAlpha(150),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        controller.closeView(null);
                                        var level =
                                            widget.character.classAndLevel[item
                                                .name] ??
                                            0;
                                        widget.character.classAndLevel[item
                                                .name] =
                                            level + 1;
                                        widget.changed();
                                      });
                                    },
                                  ),
                                );
                          },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
