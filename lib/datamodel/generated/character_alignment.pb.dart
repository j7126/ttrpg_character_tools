// This is a generated file - do not edit.
//
// Generated from character_alignment.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'character_alignment.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'character_alignment.pbenum.dart';

class CharacterAlignment extends $pb.GeneratedMessage {
  factory CharacterAlignment({
    AlignmentA? a,
    AlignmentB? b,
  }) {
    final result = create();
    if (a != null) result.a = a;
    if (b != null) result.b = b;
    return result;
  }

  CharacterAlignment._();

  factory CharacterAlignment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterAlignment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterAlignment',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..aE<AlignmentA>(1, _omitFieldNames ? '' : 'a',
        enumValues: AlignmentA.values)
    ..aE<AlignmentB>(2, _omitFieldNames ? '' : 'b',
        enumValues: AlignmentB.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterAlignment clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterAlignment copyWith(void Function(CharacterAlignment) updates) =>
      super.copyWith((message) => updates(message as CharacterAlignment))
          as CharacterAlignment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterAlignment create() => CharacterAlignment._();
  @$core.override
  CharacterAlignment createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterAlignment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterAlignment>(create);
  static CharacterAlignment? _defaultInstance;

  @$pb.TagNumber(1)
  AlignmentA get a => $_getN(0);
  @$pb.TagNumber(1)
  set a(AlignmentA value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasA() => $_has(0);
  @$pb.TagNumber(1)
  void clearA() => $_clearField(1);

  @$pb.TagNumber(2)
  AlignmentB get b => $_getN(1);
  @$pb.TagNumber(2)
  set b(AlignmentB value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasB() => $_has(1);
  @$pb.TagNumber(2)
  void clearB() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
