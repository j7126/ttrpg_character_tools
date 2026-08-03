import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/data_views/5e/class_view.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/class.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/class/subclass.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/data_model_5e.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key, required this.class5e});

  final Class5e class5e;

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  late List<SubClass> subclassOptions;
  SubClass? subclass;

  @override
  void initState() {
    subclassOptions = DataModel5e.subClasses
        .where(
          (x) =>
              x.className == widget.class5e.name &&
              x.classSource == widget.class5e.source,
        )
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.class5e.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                ChoiceChip(
                  label: Text("No Subclass"),
                  selected: subclass == null,
                  onSelected: (bool selected) {
                    if (selected) {
                      setState(() {
                        subclass = null;
                      });
                    }
                  },
                ),
                for (var sc in subclassOptions)
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: ChoiceChip(
                      label: Text(sc.shortName),
                      selected: subclass == sc,
                      onSelected: (bool selected) {
                        setState(() {
                          subclass = selected ? sc : null;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ClassView(
              class5e: widget.class5e,
              showTitle: false,
              subClass: subclass,
            ),
          ),
        ],
      ),
    );
  }
}
