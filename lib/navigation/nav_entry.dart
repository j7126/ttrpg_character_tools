import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/character/character_manager.dart';

class NavEntry {
  const NavEntry({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.route,
    this.labelOverride,
    this.shouldShow,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String route;
  final String? Function()? labelOverride;
  final bool Function()? shouldShow;

  static List<NavEntry> entries = [
    const NavEntry(
      icon: Icons.groups_outlined,
      selectedIcon: Icons.groups,
      label: "Characters",
      route: "/characters",
    ),
    NavEntry(
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: "Character",
      route: "/character",
      labelOverride: () =>
          CharacterManager.instance.character != null &&
              CharacterManager.instance.character!.name.isNotEmpty
          ? CharacterManager.instance.character!.name
          : null,
      shouldShow: () => CharacterManager.instance.isOpen,
    ),
    const NavEntry(
      icon: Icons.class_outlined,
      selectedIcon: Icons.class_,
      label: "Classes",
      route: "/classes",
    ),
    const NavEntry(
      icon: Icons.category_outlined,
      selectedIcon: Icons.category,
      label: "Items",
      route: "/items",
    ),
    const NavEntry(
      icon: Icons.category_outlined,
      selectedIcon: Icons.category,
      label: "Conditions",
      route: "/conditions",
    ),
  ];
}
