import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/data_views/5e/item_view.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/item/item.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data_loader.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({super.key});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  List<Item> items = [];

  @override
  void initState() {
    search("");
    super.initState();
  }

  void search(String searchString) {
    setState(() {
      if (searchString.isEmpty) {
        items = DataLoader.items.toList();
        return;
      }

      searchString = searchString.toLowerCase();
      items = DataLoader.items.where((x) => x.searchCompare(searchString)).toList();
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
                        "Item",
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
                  itemCount: items.length,
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
                                  child: ItemView(
                                    item: items[i],
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
                                items[i].name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                              child: Text(
                                items[i].source,
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
