import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/data_views/5e/condition_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/condition/condition.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data_loader.dart';

class ConditionsView extends StatefulWidget {
  const ConditionsView({super.key});

  @override
  State<ConditionsView> createState() => _ConditionsViewState();
}

class _ConditionsViewState extends State<ConditionsView> {
  List<Condition> conditions = [];

  @override
  void initState() {
    search("");
    super.initState();
  }

  void search(String searchString) {
    setState(() {
      if (searchString.isEmpty) {
        conditions = DataLoader.conditions.toList();
        return;
      }

      searchString = searchString.toLowerCase();
      conditions = DataLoader.conditions.where((x) => x.searchCompare(searchString)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var foregroundColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white;

    return DataLoader.ready
        ? Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                decoration: const InputDecoration(
                  label: Text("Search"),
                ),
                onChanged: search,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                      child: Text(
                        "Condition",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
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
              Expanded(
                child: ListView.builder(
                  itemCount: conditions.length,
                  itemExtent: 32,
                  itemBuilder: (context, i) => Container(
                    decoration: BoxDecoration(
                      color: i % 2 == 0 ? foregroundColor.withAlpha(30) : null,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                                  child: ConditionView(
                                    condition: conditions[i],
                                    card: false,
                                  ),
                                ),
                              );
                            });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                              child: Text(
                                conditions[i].name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                              child: Text(
                                conditions[i].source,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
