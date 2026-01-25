import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:ttrpg_character_tools/navigation/nav_entry.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  static NavBar? fromAdaptiveInfo(AdaptiveInfo info) => info.isLandscape ? null : const NavBar();

  @override
  Widget build(BuildContext context) {
    var index = NavEntry.entries.indexWhere((element) => ModalRoute.of(context)?.settings.name == element.route);
    if (index < 0) {
      index = 0;
    }

    return NavigationBar(
      onDestinationSelected: (value) => Navigator.of(context).pushReplacementNamed(NavEntry.entries[value].route),
      selectedIndex: index,
      destinations: [
        for (var entry in NavEntry.entries)
          NavigationDestination(
            selectedIcon: Icon(entry.selectedIcon),
            icon: Icon(entry.icon),
            label: entry.label,
          ),
      ],
    );
  }
}
