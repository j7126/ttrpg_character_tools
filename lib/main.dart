import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:ttrpg_character_tools/character/character_manager.dart';
import 'package:ttrpg_character_tools/character/character_ui/character_page.dart';
import 'package:ttrpg_character_tools/navigation/error_page.dart';
import 'package:ttrpg_character_tools/character/characters_page.dart';
import 'package:ttrpg_character_tools/pages/classes_page.dart';
import 'package:ttrpg_character_tools/pages/conditions_page.dart';
import 'package:ttrpg_character_tools/pages/items_page.dart';
import 'package:ttrpg_character_tools/pages/races_page.dart';
import 'package:ttrpg_character_tools/pages/spells_page.dart';
import 'package:ttrpg_character_tools/service/settings.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xdg_desktop_portal/xdg_desktop_portal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.setTitle("Character Manager");
  await SettingsService.build();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Color? overrideAcentColor;

  void getAccentColor() async {
    if (Platform.isLinux) {
      try {
        var client = XdgDesktopPortalClient();
        var result = await client.settings.read(
          "org.freedesktop.appearance",
          "accent-color",
        );
        var vals = List.from(
          result.asVariant().asStruct().map((x) => x.asDouble()),
        );
        if (vals.length == 3 && !vals.any((x) => x < 0 || x > 1)) {
          var color = Color.fromARGB(
            255,
            (255 * vals[0]).floor(),
            (255 * vals[1]).floor(),
            (255 * vals[2]).floor(),
          );
          if (mounted) {
            setState(() {
              overrideAcentColor = color;
            });
          }
        }
      } catch (exception) {
        overrideAcentColor = null;
      }
    }
  }

  @override
  void initState() {
    getAccentColor();
    CharacterManager.instance = CharacterManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        if (overrideAcentColor != null) {
          lightDynamic = ColorScheme.fromSeed(
            seedColor: overrideAcentColor!,
            brightness: Brightness.light,
          );
          darkDynamic = ColorScheme.fromSeed(
            seedColor: overrideAcentColor!,
            brightness: Brightness.dark,
          );
        }
        return MaterialApp(
          title: "Character Manager",
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme:
                lightDynamic ??
                ColorScheme.fromSeed(
                  seedColor: Colors.green,
                  brightness: Brightness.light,
                ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme:
                darkDynamic ??
                ColorScheme.fromSeed(
                  seedColor: Colors.green,
                  brightness: Brightness.dark,
                ),
            useMaterial3: true,
          ),
          onGenerateRoute: (settings) {
            var name = settings.name;

            if (name == "/") {
              name = "/characters";
            }

            switch (name) {
              case "/characters":
                return PageRouteBuilder(
                  pageBuilder: (_, _, _) => const CharactersPage(),
                  settings: settings,
                );
              case "/character":
                return PageRouteBuilder(
                  pageBuilder: (_, _, _) => const CharacterPage(),
                  settings: settings,
                );
              case "/classes":
                return PageRouteBuilder(
                  pageBuilder: (_, _, _) => const ClassesPage(),
                  settings: settings,
                );
              case "/items":
                return PageRouteBuilder(
                  pageBuilder: (_, _, _) => const ItemsPage(),
                  settings: settings,
                );
              case "/conditions":
                return PageRouteBuilder(
                  pageBuilder: (_, _, _) => const ConditionsPage(),
                  settings: settings,
                );
              case "/spells":
                return PageRouteBuilder(
                  pageBuilder: (_, _, _) => const SpellsPage(),
                  settings: settings,
                );
              case "/races":
                return PageRouteBuilder(
                  pageBuilder: (_, _, _) => const RacesPage(),
                  settings: settings,
                );
              default:
                return PageRouteBuilder(
                  pageBuilder: (_, _, _) => const ErrorPage(),
                );
            }
          },
          initialRoute: "/characters",
        );
      },
    );
  }
}
