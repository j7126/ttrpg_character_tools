// This is a generated file - do not edit.
//
// Generated from character.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $0;

import 'options.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Character extends $pb.GeneratedMessage {
  factory Character({
    $core.String? id,
    $core.String? name,
    $core.int? life,
    $core.int? maxLife,
    $0.Timestamp? createdTimestamp,
    $1.Options? options,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (life != null) result.life = life;
    if (maxLife != null) result.maxLife = maxLife;
    if (createdTimestamp != null) result.createdTimestamp = createdTimestamp;
    if (options != null) result.options = options;
    return result;
  }

  Character._();

  factory Character.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Character.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Character',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aI(3, _omitFieldNames ? '' : 'life')
    ..aI(4, _omitFieldNames ? '' : 'maxLife', protoName: 'maxLife')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'createdTimestamp',
        protoName: 'createdTimestamp', subBuilder: $0.Timestamp.create)
    ..aOM<$1.Options>(6, _omitFieldNames ? '' : 'options',
        subBuilder: $1.Options.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Character clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Character copyWith(void Function(Character) updates) =>
      super.copyWith((message) => updates(message as Character)) as Character;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Character create() => Character._();
  @$core.override
  Character createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Character getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Character>(create);
  static Character? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get life => $_getIZ(2);
  @$pb.TagNumber(3)
  set life($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLife() => $_has(2);
  @$pb.TagNumber(3)
  void clearLife() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get maxLife => $_getIZ(3);
  @$pb.TagNumber(4)
  set maxLife($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxLife() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxLife() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.Timestamp get createdTimestamp => $_getN(4);
  @$pb.TagNumber(5)
  set createdTimestamp($0.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedTimestamp() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureCreatedTimestamp() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Options get options => $_getN(5);
  @$pb.TagNumber(6)
  set options($1.Options value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasOptions() => $_has(5);
  @$pb.TagNumber(6)
  void clearOptions() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Options ensureOptions() => $_ensure(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
