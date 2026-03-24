import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:ttrpg_character_tools/character/character_manager.dart';
import 'package:ttrpg_character_tools/character/character_ui/character_page.dart';
import 'package:ttrpg_character_tools/navigation/error_page.dart';
import 'package:ttrpg_character_tools/character/characters_page.dart';
import 'package:ttrpg_character_tools/pages/classes_page.dart';
import 'package:ttrpg_character_tools/pages/conditions_page.dart';
import 'package:ttrpg_character_tools/pages/items_page.dart';
import 'package:ttrpg_character_tools/service/settings.dart';
import 'package:window_manager/window_manager.dart';

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
  @override
  void initState() {
    CharacterManager.instance = CharacterManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
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
