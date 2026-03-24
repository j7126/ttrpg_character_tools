// This is a generated file - do not edit.
//
// Generated from character_stats.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'character_stats.pbenum.dart';

class CharacterStats extends $pb.GeneratedMessage {
  factory CharacterStats({
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? base,
    $core.Iterable<$core.MapEntry<$core.int, $core.int>>? current,
  }) {
    final result = create();
    if (base != null) result.base.addEntries(base);
    if (current != null) result.current.addEntries(current);
    return result;
  }

  CharacterStats._();

  factory CharacterStats.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterStats.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterStats',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..m<$core.int, $core.int>(1, _omitFieldNames ? '' : 'base',
        entryClassName: 'CharacterStats.BaseEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('ttrpg_character_tools'))
    ..m<$core.int, $core.int>(2, _omitFieldNames ? '' : 'current',
        entryClassName: 'CharacterStats.CurrentEntry',
        keyFieldType: $pb.PbFieldType.O3,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('ttrpg_character_tools'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterStats clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterStats copyWith(void Function(CharacterStats) updates) =>
      super.copyWith((message) => updates(message as CharacterStats))
          as CharacterStats;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterStats create() => CharacterStats._();
  @$core.override
  CharacterStats createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterStats getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterStats>(create);
  static CharacterStats? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.int, $core.int> get base => $_getMap(0);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.int, $core.int> get current => $_getMap(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
