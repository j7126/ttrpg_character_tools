import 'package:ttrpg_character_tools/datamodel/generated/character_spell_info.pb.dart';

class KnownSpellContext {
  const KnownSpellContext({
    required this.info,
    this.additionalKnownType = AdditionalKnownSpellType.none,
    this.sourceRef,
  });

  final CharacterSpellInfo info;
  final AdditionalKnownSpellType additionalKnownType;
  final String? sourceRef;
}

enum AdditionalKnownSpellType { none, known, innate }
