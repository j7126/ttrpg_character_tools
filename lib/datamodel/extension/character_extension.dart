import 'package:ttrpg_character_tools/datamodel/generated/character.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_alignment.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_life.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/character_stats.pb.dart';
import 'package:ttrpg_character_tools/datamodel/generated/options.pb.dart';

extension CharacterExtension on Character {
  void validate() {
    if (!hasOptions()) {
      options = Options();
    }
    if (!hasAlignment()) {
      alignment = CharacterAlignment();
    }
    if (!hasLife()) {
      life = CharacterLife();
    }
    if (!hasStats()) {
      stats = CharacterStats();
    }
    if (!hasSkills()) {
      skills = CharacterSkills();
    }
  }
}
