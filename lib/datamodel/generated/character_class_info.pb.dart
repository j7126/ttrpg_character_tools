// This is a generated file - do not edit.
//
// Generated from character_class_info.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CharacterClassInfo extends $pb.GeneratedMessage {
  factory CharacterClassInfo({
    $core.String? className,
    $core.String? classSource,
    $core.int? classLevel,
    $core.String? subClassName,
    $core.String? subClassSource,
  }) {
    final result = create();
    if (className != null) result.className = className;
    if (classSource != null) result.classSource = classSource;
    if (classLevel != null) result.classLevel = classLevel;
    if (subClassName != null) result.subClassName = subClassName;
    if (subClassSource != null) result.subClassSource = subClassSource;
    return result;
  }

  CharacterClassInfo._();

  factory CharacterClassInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterClassInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterClassInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'className', protoName: 'className')
    ..aOS(2, _omitFieldNames ? '' : 'classSource', protoName: 'classSource')
    ..aI(3, _omitFieldNames ? '' : 'classLevel', protoName: 'classLevel')
    ..aOS(4, _omitFieldNames ? '' : 'subClassName', protoName: 'subClassName')
    ..aOS(5, _omitFieldNames ? '' : 'subClassSource',
        protoName: 'subClassSource')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterClassInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterClassInfo copyWith(void Function(CharacterClassInfo) updates) =>
      super.copyWith((message) => updates(message as CharacterClassInfo))
          as CharacterClassInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterClassInfo create() => CharacterClassInfo._();
  @$core.override
  CharacterClassInfo createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterClassInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterClassInfo>(create);
  static CharacterClassInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get className => $_getSZ(0);
  @$pb.TagNumber(1)
  set className($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClassName() => $_has(0);
  @$pb.TagNumber(1)
  void clearClassName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get classSource => $_getSZ(1);
  @$pb.TagNumber(2)
  set classSource($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClassSource() => $_has(1);
  @$pb.TagNumber(2)
  void clearClassSource() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get classLevel => $_getIZ(2);
  @$pb.TagNumber(3)
  set classLevel($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasClassLevel() => $_has(2);
  @$pb.TagNumber(3)
  void clearClassLevel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get subClassName => $_getSZ(3);
  @$pb.TagNumber(4)
  set subClassName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSubClassName() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubClassName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get subClassSource => $_getSZ(4);
  @$pb.TagNumber(5)
  set subClassSource($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSubClassSource() => $_has(4);
  @$pb.TagNumber(5)
  void clearSubClassSource() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
