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

import 'character_skills.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'character_skills.pbenum.dart';

class CharacterSkills extends $pb.GeneratedMessage {
  factory CharacterSkills({
    $core.Iterable<CharacterSkill>? proficency,
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? overrides,
    $core.Iterable<CharacterSkill>? proficencyCalculated,
    $core.Iterable<$core.MapEntry<$core.String, CharacterSkill>>?
        proficencyChoices,
  }) {
    final result = create();
    if (proficency != null) result.proficency.addAll(proficency);
    if (overrides != null) result.overrides.addEntries(overrides);
    if (proficencyCalculated != null)
      result.proficencyCalculated.addAll(proficencyCalculated);
    if (proficencyChoices != null)
      result.proficencyChoices.addEntries(proficencyChoices);
    return result;
  }

  CharacterSkills._();

  factory CharacterSkills.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterSkills.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterSkills',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..pc<CharacterSkill>(
        1, _omitFieldNames ? '' : 'proficency', $pb.PbFieldType.KE,
        valueOf: CharacterSkill.valueOf,
        enumValues: CharacterSkill.values,
        defaultEnumValue: CharacterSkill.Acrobatics)
    ..m<$core.int, $core.int>(2, _omitFieldNames ? '' : 'overrides',
        entryClassName: 'CharacterSkills.OverridesEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('ttrpg_character_tools'))
    ..pc<CharacterSkill>(
        3, _omitFieldNames ? '' : 'proficencyCalculated', $pb.PbFieldType.KE,
        protoName: 'proficencyCalculated',
        valueOf: CharacterSkill.valueOf,
        enumValues: CharacterSkill.values,
        defaultEnumValue: CharacterSkill.Acrobatics)
    ..m<$core.String, CharacterSkill>(
        4, _omitFieldNames ? '' : 'proficencyChoices',
        protoName: 'proficencyChoices',
        entryClassName: 'CharacterSkills.ProficencyChoicesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OE,
        valueOf: CharacterSkill.valueOf,
        enumValues: CharacterSkill.values,
        valueDefaultOrMaker: CharacterSkill.Acrobatics,
        defaultEnumValue: CharacterSkill.Acrobatics,
        packageName: const $pb.PackageName('ttrpg_character_tools'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterSkills clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterSkills copyWith(void Function(CharacterSkills) updates) =>
      super.copyWith((message) => updates(message as CharacterSkills))
          as CharacterSkills;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterSkills create() => CharacterSkills._();
  @$core.override
  CharacterSkills createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterSkills getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterSkills>(create);
  static CharacterSkills? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CharacterSkill> get proficency => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.int, $core.int> get overrides => $_getMap(1);

  @$pb.TagNumber(3)
  $pb.PbList<CharacterSkill> get proficencyCalculated => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, CharacterSkill> get proficencyChoices => $_getMap(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
