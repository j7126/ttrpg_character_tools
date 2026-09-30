import 'package:ttrpg_character_tools/datamodel/generated/character_spell_info.pb.dart';

class KnownSpellContext {
  const KnownSpellContext({
    required this.info,
    this.additionalKnownType = AdditionalKnownSpellType.none,
    this.sourceRef,
    this.innateType,
    this.innateQty = 0,
  });

  final CharacterSpellInfo info;
  final AdditionalKnownSpellType additionalKnownType;
  final String? sourceRef;
  final AdditionalKnownSpellInnateType? innateType;
  final int innateQty;
}

enum AdditionalKnownSpellType { none, known, innate }
enum AdditionalKnownSpellInnateType { will, ritual, daily, rest }
