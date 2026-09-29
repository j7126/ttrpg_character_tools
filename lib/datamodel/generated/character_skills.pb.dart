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
    $core.Iterable<CharacterSkill>? currentProficency,
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? overrides,
    $core.Iterable<CharacterSkill>? overrideProficency,
    $core.Iterable<CharacterProficencyChoice>? proficencyChoices,
  }) {
    final result = create();
    if (currentProficency != null)
      result.currentProficency.addAll(currentProficency);
    if (overrides != null) result.overrides.addEntries(overrides);
    if (overrideProficency != null)
      result.overrideProficency.addAll(overrideProficency);
    if (proficencyChoices != null)
      result.proficencyChoices.addAll(proficencyChoices);
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
        1, _omitFieldNames ? '' : 'currentProficency', $pb.PbFieldType.KE,
        protoName: 'currentProficency',
        valueOf: CharacterSkill.valueOf,
        enumValues: CharacterSkill.values,
        defaultEnumValue: CharacterSkill.Acrobatics)
    ..m<$core.int, $core.int>(2, _omitFieldNames ? '' : 'overrides',
        entryClassName: 'CharacterSkills.OverridesEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('ttrpg_character_tools'))
    ..pc<CharacterSkill>(
        3, _omitFieldNames ? '' : 'overrideProficency', $pb.PbFieldType.KE,
        protoName: 'overrideProficency',
        valueOf: CharacterSkill.valueOf,
        enumValues: CharacterSkill.values,
        defaultEnumValue: CharacterSkill.Acrobatics)
    ..pPM<CharacterProficencyChoice>(
        4, _omitFieldNames ? '' : 'proficencyChoices',
        protoName: 'proficencyChoices',
        subBuilder: CharacterProficencyChoice.create)
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
  $pb.PbList<CharacterSkill> get currentProficency => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.int, $core.int> get overrides => $_getMap(1);

  @$pb.TagNumber(3)
  $pb.PbList<CharacterSkill> get overrideProficency => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<CharacterProficencyChoice> get proficencyChoices => $_getList(3);
}

class CharacterProficencyChoice extends $pb.GeneratedMessage {
  factory CharacterProficencyChoice({
    $core.String? providerRef,
    $core.Iterable<CharacterSkill>? fixed,
    $core.Iterable<CharacterSkill>? choices,
    $core.Iterable<CharacterSkill>? choicesAny,
  }) {
    final result = create();
    if (providerRef != null) result.providerRef = providerRef;
    if (fixed != null) result.fixed.addAll(fixed);
    if (choices != null) result.choices.addAll(choices);
    if (choicesAny != null) result.choicesAny.addAll(choicesAny);
    return result;
  }

  CharacterProficencyChoice._();

  factory CharacterProficencyChoice.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterProficencyChoice.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterProficencyChoice',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'providerRef', protoName: 'providerRef')
    ..pc<CharacterSkill>(2, _omitFieldNames ? '' : 'fixed', $pb.PbFieldType.KE,
        valueOf: CharacterSkill.valueOf,
        enumValues: CharacterSkill.values,
        defaultEnumValue: CharacterSkill.Acrobatics)
    ..pc<CharacterSkill>(
        3, _omitFieldNames ? '' : 'choices', $pb.PbFieldType.KE,
        valueOf: CharacterSkill.valueOf,
        enumValues: CharacterSkill.values,
        defaultEnumValue: CharacterSkill.Acrobatics)
    ..pc<CharacterSkill>(
        4, _omitFieldNames ? '' : 'choicesAny', $pb.PbFieldType.KE,
        protoName: 'choicesAny',
        valueOf: CharacterSkill.valueOf,
        enumValues: CharacterSkill.values,
        defaultEnumValue: CharacterSkill.Acrobatics)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterProficencyChoice clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterProficencyChoice copyWith(
          void Function(CharacterProficencyChoice) updates) =>
      super.copyWith((message) => updates(message as CharacterProficencyChoice))
          as CharacterProficencyChoice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterProficencyChoice create() => CharacterProficencyChoice._();
  @$core.override
  CharacterProficencyChoice createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterProficencyChoice getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterProficencyChoice>(create);
  static CharacterProficencyChoice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerRef => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerRef($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProviderRef() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderRef() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<CharacterSkill> get fixed => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<CharacterSkill> get choices => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<CharacterSkill> get choicesAny => $_getList(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
