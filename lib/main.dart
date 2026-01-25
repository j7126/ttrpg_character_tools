import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:ttrpg_character_tools/navigation/error_page.dart';
import 'package:ttrpg_character_tools/pages/characters_page.dart';
import 'package:ttrpg_character_tools/pages/classes_page.dart';
import 'package:ttrpg_character_tools/pages/conditions_page.dart';
import 'package:ttrpg_character_tools/pages/items_page.dart';
import 'package:ttrpg_character_tools/service/settings.dart';
import 'package:ttrpg_character_tools/service/static_service.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool settingsReady = false;
  bool get ready => settingsReady;

  void loadSettingsService() async {
    Service.settingsService = await SettingsService.build();
    setState(() {
      settingsReady = true;
    });
  }

  @override
  void initState() {
    loadSettingsService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
        title: Service.appName,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: lightDynamic ??
              ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.light,
              ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkDynamic ??
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
                pageBuilder: (_, __, ___) => const CharactersPage(),
                settings: settings,
              );
            case "/classes":
              return PageRouteBuilder(
                pageBuilder: (_, __, ___) => const ClassesPage(),
                settings: settings,
              );
            case "/items":
              return PageRouteBuilder(
                pageBuilder: (_, __, ___) => const ItemsPage(),
                settings: settings,
              );
            case "/conditions":
              return PageRouteBuilder(
                pageBuilder: (_, __, ___) => const ConditionsPage(),
                settings: settings,
              );
            default:
              return PageRouteBuilder(pageBuilder: (_, __, ___) => const ErrorPage());
          }
        },
        initialRoute: "/characters",
      );
    });
  }
}
