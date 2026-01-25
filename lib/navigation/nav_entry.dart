import 'package:flutter/material.dart';

class NavEntry {
  const NavEntry({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String route;

  static const List<NavEntry> entries = [
    NavEntry(
      icon: Icons.groups_outlined,
      selectedIcon: Icons.groups,
      label: "Characters",
      route: "/characters",
    ),
    NavEntry(
      icon: Icons.class_outlined,
      selectedIcon: Icons.class_,
      label: "Classes",
      route: "/classes",
    ),
    NavEntry(
      icon: Icons.category_outlined,
      selectedIcon: Icons.category,
      label: "Items",
      route: "/items",
    ),
    NavEntry(
      icon: Icons.category_outlined,
      selectedIcon: Icons.category,
      label: "Conditions",
      route: "/conditions",
    ),
  ];
}
