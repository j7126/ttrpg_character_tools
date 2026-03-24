// This is a generated file - do not edit.
//
// Generated from character_skills.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CharacterSkill extends $pb.ProtobufEnum {
  static const CharacterSkill Acrobatics =
      CharacterSkill._(0, _omitEnumNames ? '' : 'Acrobatics');
  static const CharacterSkill AnimalHandling =
      CharacterSkill._(1, _omitEnumNames ? '' : 'AnimalHandling');
  static const CharacterSkill Arcana =
      CharacterSkill._(2, _omitEnumNames ? '' : 'Arcana');
  static const CharacterSkill Athletics =
      CharacterSkill._(3, _omitEnumNames ? '' : 'Athletics');
  static const CharacterSkill Deception =
      CharacterSkill._(4, _omitEnumNames ? '' : 'Deception');
  static const CharacterSkill History =
      CharacterSkill._(5, _omitEnumNames ? '' : 'History');
  static const CharacterSkill Insight =
      CharacterSkill._(6, _omitEnumNames ? '' : 'Insight');
  static const CharacterSkill Intimidation =
      CharacterSkill._(7, _omitEnumNames ? '' : 'Intimidation');
  static const CharacterSkill Investigation =
      CharacterSkill._(8, _omitEnumNames ? '' : 'Investigation');
  static const CharacterSkill Medicine =
      CharacterSkill._(9, _omitEnumNames ? '' : 'Medicine');
  static const CharacterSkill Nature =
      CharacterSkill._(10, _omitEnumNames ? '' : 'Nature');
  static const CharacterSkill Perception =
      CharacterSkill._(11, _omitEnumNames ? '' : 'Perception');
  static const CharacterSkill Performance =
      CharacterSkill._(12, _omitEnumNames ? '' : 'Performance');
  static const CharacterSkill Persuasion =
      CharacterSkill._(13, _omitEnumNames ? '' : 'Persuasion');
  static const CharacterSkill Religion =
      CharacterSkill._(14, _omitEnumNames ? '' : 'Religion');
  static const CharacterSkill SleightOfHand =
      CharacterSkill._(15, _omitEnumNames ? '' : 'SleightOfHand');
  static const CharacterSkill Stealth =
      CharacterSkill._(16, _omitEnumNames ? '' : 'Stealth');
  static const CharacterSkill Survival =
      CharacterSkill._(17, _omitEnumNames ? '' : 'Survival');

  static const $core.List<CharacterSkill> values = <CharacterSkill>[
    Acrobatics,
    AnimalHandling,
    Arcana,
    Athletics,
    Deception,
    History,
    Insight,
    Intimidation,
    Investigation,
    Medicine,
    Nature,
    Perception,
    Performance,
    Persuasion,
    Religion,
    SleightOfHand,
    Stealth,
    Survival,
  ];

  static final $core.List<CharacterSkill?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 17);
  static CharacterSkill? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CharacterSkill._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
