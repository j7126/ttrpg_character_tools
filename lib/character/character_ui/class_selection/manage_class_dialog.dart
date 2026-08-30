import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:render_ttrpg_data/data_views/5e/class_view.dart';
import 'package:render_ttrpg_data/data_views/5e/subclass_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/subclass.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';
import 'package:render_ttrpg_data/widgets/link_with_content_tooltip.dart';
import 'package:ttrpg_character_tools/data_loader.dart';
import 'package:ttrpg_character_tools/datamodel/extension/character_class_info_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_class_info.pb.dart';

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
  final SearchController classSearchController = SearchController();
  final SearchController subClassSearchController = SearchController();
  List<SubClass> subclassOptions = [];

  void removeLevel(CharacterClassInfo classInfo) async {
    var confirmMessage = classInfo.classLevel > 1
        ? "Removing a level from ${classInfo.className} will down level your character."
        : "Removing this level will remove the ${classInfo.className} class from your character.";
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
      if (mounted) {
        if (classInfo.classLevel > 1) {
          classInfo.classLevel--;
        } else {
          widget.character.classInfo.remove(classInfo);
        }
        widget.changed();
      }
    });
  }

  void _dataLoaderReadyListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _showSubClassSelection(Class5e cl) {
    subclassOptions = DataModel5e.subClasses
        .where((x) => x.className == cl.name && x.classSource == cl.source)
        .toList();
    if (subclassOptions.isNotEmpty) {
      subClassSearchController.openView();
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
    classSearchController.dispose();
    subClassSearchController.dispose();
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
        width: min(MediaQuery.of(context).size.width - 32, 480.0),
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
                    for (var classInfo in widget.character.classInfo) ...[
                      Card(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Gap(8.0),
                                    Text(
                                      classInfo.className,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    ...() {
                                      var class5e = classInfo.getClass();
                                      return [
                                        if (class5e != null)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                            child: LinkWithContentTooltip(
                                              tooltipView: ClassView(
                                                class5e: class5e,
                                                card: true,
                                                outlined: true,
                                                scrollable: true,
                                              ),
                                              contentView: ClassView(
                                                class5e: class5e,
                                                card: false,
                                                scrollable: false,
                                              ),
                                              text: "",
                                              style: null,
                                              linkMode:
                                                  LinkTooltipViewMode.helpIcon,
                                            ),
                                          ),
                                      ];
                                    }(),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () => removeLevel(classInfo),
                                      icon: Icon(
                                        Icons.remove_circle_outline,
                                        color: ColorScheme.of(context).error,
                                      ),
                                    ),
                                    Text(
                                      "Level ${classInfo.classLevel}",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          classInfo.classLevel++;
                                          if (classInfo.classLevel > 20) {
                                            classInfo.classLevel = 20;
                                          }
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
                                if (DataModel5e.subClasses.any(
                                  (x) =>
                                      x.className == classInfo.className &&
                                      x.classSource == classInfo.classSource,
                                ))
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Gap(8.0),
                                      Text(
                                        classInfo.hasSubClassName()
                                            ? classInfo.subClassName
                                            : "No sub-class selected",
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      ...() {
                                        var subClass = classInfo.getSubClass();
                                        return [
                                          if (subClass != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: LinkWithContentTooltip(
                                                tooltipView: SubclassView(
                                                  subclass: subClass,
                                                  card: true,
                                                  outlined: true,
                                                  scrollable: true,
                                                ),
                                                contentView: SubclassView(
                                                  subclass: subClass,
                                                  card: false,
                                                  scrollable: false,
                                                ),
                                                text: "",
                                                style: null,
                                                linkMode: LinkTooltipViewMode
                                                    .helpIcon,
                                              ),
                                            ),
                                        ];
                                      }(),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          var cl = classInfo.getClass();
                                          if (cl != null) {
                                            _showSubClassSelection(cl);
                                          }
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    SearchAnchor(
                      searchController: classSearchController,
                      viewHintText: "Add Class",
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
                            return DataModel5e.classes
                                .where(
                                  (x) => !widget.character.classInfo.any(
                                    (info) => x.name == info.className,
                                  ),
                                )
                                .where(
                                  (x) => x.name.toLowerCase().contains(
                                    controller.text.toLowerCase(),
                                  ),
                                )
                                .map(
                                  (item) => ListTile(
                                    title: Text(item.name),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          item.source,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorScheme.of(context)
                                                .onSurface
                                                .withAlpha(150),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                          ),
                                          child: LinkWithContentTooltip(
                                            tooltipView: ClassView(
                                              class5e: item,
                                              card: true,
                                              outlined: true,
                                              scrollable: true,
                                            ),
                                            contentView: ClassView(
                                              class5e: item,
                                              card: false,
                                              scrollable: false,
                                            ),
                                            text: item.name,
                                            style: null,
                                            linkMode:
                                                LinkTooltipViewMode.helpIcon,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        controller.closeView(null);
                                        controller.clear();
                                        if (!widget.character.classInfo.any(
                                          (info) => info.className == item.name,
                                        )) {
                                          widget.character.classInfo.add(
                                            CharacterClassInfo(
                                              className: item.name,
                                              classSource: item.source,
                                              classLevel: 1,
                                            ),
                                          );
                                          widget.changed();
                                        }
                                      });
                                      _showSubClassSelection(item);
                                    },
                                  ),
                                );
                          },
                    ),
                    SearchAnchor(
                      searchController: subClassSearchController,
                      viewHintText: "Select sub-class",
                      builder:
                          (BuildContext context, SearchController controller) {
                            return Container();
                          },
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                            return subclassOptions
                                .where(
                                  (x) => x.name.toLowerCase().contains(
                                    controller.text.toLowerCase(),
                                  ),
                                )
                                .map(
                                  (item) => ListTile(
                                    title: Text(item.name),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          item.source,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: ColorScheme.of(context)
                                                .onSurface
                                                .withAlpha(150),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8.0,
                                          ),
                                          child: LinkWithContentTooltip(
                                            tooltipView: SubclassView(
                                              subclass: item,
                                              card: true,
                                              outlined: true,
                                              scrollable: true,
                                            ),
                                            contentView: SubclassView(
                                              subclass: item,
                                              card: false,
                                              scrollable: false,
                                            ),
                                            text: item.name,
                                            style: null,
                                            linkMode:
                                                LinkTooltipViewMode.helpIcon,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        controller.closeView(null);
                                        controller.clear();
                                        var classInfo = widget
                                            .character
                                            .classInfo
                                            .firstWhereOrNull(
                                              (x) =>
                                                  x.className ==
                                                      item.className &&
                                                  x.classSource ==
                                                      x.classSource,
                                            );
                                        if (classInfo != null) {
                                          classInfo.subClassName = item.name;
                                          classInfo.subClassSource =
                                              item.source;
                                          widget.changed();
                                        }
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
