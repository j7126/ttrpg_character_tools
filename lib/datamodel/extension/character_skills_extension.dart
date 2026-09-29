import 'package:ttrpg_character_tools/datamodel/generated/character_skills.pb.dart';

extension CharacterSkillsExtension on CharacterSkills {
  void applyChoices() {
    var prof = <CharacterSkill>{};
    for (var selection in proficencyChoices) {
      prof.addAll(selection.fixed);
      prof.addAll(selection.choices);
      prof.addAll(selection.choicesAny);
    }

    currentProficency.clear();
    currentProficency.addAll(prof);
  }
}
