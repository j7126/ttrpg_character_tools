import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/navigation/nav_entry.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({super.key, this.showAppTitle = true});

  final bool showAppTitle;

  @override
  Widget build(BuildContext context) {
    var index = NavEntry.entries.indexWhere(
      (element) => ModalRoute.of(context)?.settings.name == element.route,
    );
    if (index < 0) {
      index = 0;
    }

    return NavigationDrawer(
      onDestinationSelected: (value) => Navigator.of(
        context,
      ).pushReplacementNamed(NavEntry.entries[value].route),
      selectedIndex: index,
      children: [
        if (showAppTitle)
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 20),
            child: Text(
              "Character Manager",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        else
          const Gap(16.0),
        for (var entry in NavEntry.entries)
          NavigationDrawerDestination(
            label: Text(entry.labelOverride?.call() ?? entry.label),
            icon: Icon(entry.icon),
            selectedIcon: Icon(entry.selectedIcon),
            enabled: entry.shouldShow?.call() ?? true,
          ),
      ],
    );
  }
}
