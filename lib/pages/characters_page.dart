import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:ttrpg_character_tools/character/character_manager.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_file.pb.dart';
import 'package:ttrpg_character_tools/pages/page_scaffold.dart';
import 'package:ttrpg_character_tools/service/settings.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  List<CharacterFile>? recentFiles;

  @override
  void initState() {
    _checkCharacterFiles();
    super.initState();
  }

  void _checkCharacterFiles() async {
    List<CharacterFile> files = [];
    for (var data in SettingsService.instance.conf_recentFiles) {
      var recentFile = CharacterFile.fromJson(data);
      FileSystemEntity file;
      if (Platform.isMacOS) {
        try {
          file = await SecureBookmarks().resolveBookmark(
            recentFile.macosBookmark,
          );
        } on PlatformException {
          continue;
        }
        await SecureBookmarks().startAccessingSecurityScopedResource(file);
      } else {
        file = File(recentFile.path);
      }
      if (await file.exists() && !file.path.contains("/.Trash/")) {
        recentFile.path = file.path;
        files.add(recentFile);
      }
      if (Platform.isMacOS) {
        await SecureBookmarks().stopAccessingSecurityScopedResource(file);
      }
    }
    SettingsService.instance.conf_recentFiles = files
        .map((x) => x.writeToJson())
        .toList();
    setState(() {
      recentFiles = files;
    });
  }

  void _createCharacter() async {
    var characterFile = await CharacterManager.instance.createCharacter();
    if (characterFile == null) {
      return;
    }
    _characterOpened(characterFile);
  }

  void _openCharacter({CharacterFile? characterFile}) async {
    characterFile = await CharacterManager.instance.openCharacter(
      characterFile: characterFile,
    );
    if (characterFile == null) {
      _checkCharacterFiles();
      if (mounted) {
        showDialog<void>(
          context: this.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Failed to open file'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      return;
    }
    _characterOpened(characterFile);
  }

  void _characterOpened(CharacterFile characterFile) async {
    setState(() {
      recentFiles ??= [];
      recentFiles!.removeWhere((x) => x.path == characterFile.path);
      recentFiles!.insert(0, characterFile);
      SettingsService.instance.conf_recentFiles = recentFiles!
          .map((x) => x.writeToJson())
          .toList();
    });
    if (!mounted) {
      return;
    }
    // TODO: open character page
    /*await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => CharacterPage()));*/
    if (!mounted) {
      return;
    }
    _checkCharacterFiles();
  }

  @override
  Widget build(BuildContext context) {
    var adaptiveInfo = AdaptiveInfo.of(context);

    return PageScaffold(
      adaptiveInfo: adaptiveInfo,
      title: "Characters",
      appBarActions: [
        FilledButton(
          onPressed: _createCharacter,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.add), Text("Create Character")],
          ),
        ),
        Gap(8.0),
        FilledButton(
          onPressed: () => _openCharacter(),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              ColorScheme.of(context).tertiary,
            ),
            foregroundColor: WidgetStatePropertyAll(
              ColorScheme.of(context).onTertiary,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.file_open), Text("Open Character")],
          ),
        ),
        Gap(16.0),
      ],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            recentFiles == null
                ? CircularProgressIndicator()
                : recentFiles!.isEmpty
                ? Center(child: Text("You don't have any recent characters"))
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var file in recentFiles!)
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  onTap: () =>
                                      _openCharacter(characterFile: file),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          basenameWithoutExtension(file.path),
                                          style: TextTheme.of(
                                            context,
                                          ).titleLarge,
                                        ),
                                        Text(
                                          file.path,
                                          style: TextTheme.of(context).bodySmall
                                              ?.copyWith(
                                                color: ColorScheme.of(
                                                  context,
                                                ).onSurface.withAlpha(100),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
