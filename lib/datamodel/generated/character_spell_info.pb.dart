// This is a generated file - do not edit.
//
// Generated from character_spell_info.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CharacterSpellInfo extends $pb.GeneratedMessage {
  factory CharacterSpellInfo({
    $core.String? spellName,
    $core.String? spellSource,
    $core.String? spellClassName,
    $core.String? spellClassSource,
  }) {
    final result = create();
    if (spellName != null) result.spellName = spellName;
    if (spellSource != null) result.spellSource = spellSource;
    if (spellClassName != null) result.spellClassName = spellClassName;
    if (spellClassSource != null) result.spellClassSource = spellClassSource;
    return result;
  }

  CharacterSpellInfo._();

  factory CharacterSpellInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterSpellInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterSpellInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'spellName', protoName: 'spellName')
    ..aOS(2, _omitFieldNames ? '' : 'spellSource', protoName: 'spellSource')
    ..aOS(3, _omitFieldNames ? '' : 'spellClassName',
        protoName: 'spellClassName')
    ..aOS(4, _omitFieldNames ? '' : 'spellClassSource',
        protoName: 'spellClassSource')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterSpellInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterSpellInfo copyWith(void Function(CharacterSpellInfo) updates) =>
      super.copyWith((message) => updates(message as CharacterSpellInfo))
          as CharacterSpellInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterSpellInfo create() => CharacterSpellInfo._();
  @$core.override
  CharacterSpellInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterSpellInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterSpellInfo>(create);
  static CharacterSpellInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get spellName => $_getSZ(0);
  @$pb.TagNumber(1)
  set spellName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSpellName() => $_has(0);
  @$pb.TagNumber(1)
  void clearSpellName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get spellSource => $_getSZ(1);
  @$pb.TagNumber(2)
  set spellSource($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSpellSource() => $_has(1);
  @$pb.TagNumber(2)
  void clearSpellSource() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get spellClassName => $_getSZ(2);
  @$pb.TagNumber(3)
  set spellClassName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSpellClassName() => $_has(2);
  @$pb.TagNumber(3)
  void clearSpellClassName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get spellClassSource => $_getSZ(3);
  @$pb.TagNumber(4)
  set spellClassSource($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSpellClassSource() => $_has(3);
  @$pb.TagNumber(4)
  void clearSpellClassSource() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
