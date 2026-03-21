import 'dart:async';
import 'dart:io';

import 'package:ttrpg_character_tools/datamodel/extension/timestamp_extension.dart';
import 'package:ttrpg_character_tools/character/file_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';
import 'package:path/path.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_file.pb.dart';
import 'package:uuid/uuid.dart';
import 'package:window_manager/window_manager.dart';
import 'package:xxh3/xxh3.dart';

class CharacterManager {
  static const String characterFileExtension = "character";

  static late CharacterManager instance;

  bool get isOpen => character != null && file != null;
  Character? character;
  File? file;
  int lastFileHash = 0;

  late Timer autoSaveTimer;

  CharacterManager() {
    autoSaveTimer = Timer(Duration(milliseconds: 60000), autosaveCallback);
  }

  void autosaveCallback() {
    if (isOpen) {
      saveCharacter();
    }
  }

  Future saveCharacter() async {
    if (!isOpen) {
      return;
    }
    var buffer = character!.writeToBuffer();
    var bufferHash = xxh3(buffer);
    if (bufferHash == lastFileHash) {
      return;
    }
    lastFileHash = bufferHash;
    await CharacterFileFormat.writeFile(file: file!, protobufPayload: buffer);
  }

  Future closeCharacter() async {
    await saveCharacter();
    file = null;
    character = null;
    await windowManager.setTitle("Character Manager");
  }

  Future<CharacterFile?> createCharacter() async {
    closeCharacter();

    String? filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Create New Character',
      type: FileType.custom,
      allowedExtensions: [characterFileExtension],
    );

    if (filePath == null) {
      return null;
    }

    if (extension(filePath) != ".$characterFileExtension") {
      filePath = "$filePath.$characterFileExtension";
    }

    file = File(filePath);
    character = Character(
      id: Uuid().v4(),
      createdTimestamp: TimestampExtension.now(),
    );
    var buffer = character!.writeToBuffer();
    var bufferHash = xxh3(buffer);
    lastFileHash = bufferHash;
    await CharacterFileFormat.writeFile(file: file!, protobufPayload: buffer);
    var characterFile = CharacterFile(path: file!.path);
    if (Platform.isMacOS) {
      characterFile.macosBookmark = await SecureBookmarks().bookmark(file!);
    }
    _characterOpened();
    return characterFile;
  }

  Future<CharacterFile?> openCharacter({CharacterFile? characterFile}) async {
    closeCharacter();

    if (characterFile == null) {
      var result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: [characterFileExtension],
      );
      if (result != null && result.files.length == 1) {
        characterFile = CharacterFile(path: result.files.single.path);
      }
    }
    if (characterFile != null) {
      File? file;
      if (Platform.isMacOS) {
        if (characterFile.macosBookmark.isNotEmpty) {
          var entity = await SecureBookmarks().resolveBookmark(
            characterFile.macosBookmark,
          );
          if (entity is File) {
            file = entity;
            await SecureBookmarks().startAccessingSecurityScopedResource(file);
          }
        } else {
          file = File(characterFile.path);
          characterFile.macosBookmark = await SecureBookmarks().bookmark(file);
        }
      } else {
        file = File(characterFile.path);
      }
      if (file != null) {
        if (await file.exists() && !file.path.contains("/.Trash/")) {
          characterFile.path = file.path;
          try {
            var readResult = await CharacterFileFormat.readFile(file);
            var data = readResult.payload;
            var bufferHash = xxh3(data);
            lastFileHash = bufferHash;
            character = Character.fromBuffer(data);
            this.file = file;
          } catch (e) {
            character = null;
            this.file = null;
            characterFile = null;
          }
        } else {
          characterFile = null;
          if (Platform.isMacOS) {
            SecureBookmarks().stopAccessingSecurityScopedResource(file);
          }
        }
      }
    }
    _characterOpened();
    return characterFile;
  }

  void _characterOpened() async {
    if (isOpen) {
      await windowManager.setTitle(
        "Character Manager: ${basenameWithoutExtension(file!.path)}",
      );
    }
  }
}
