// This is a generated file - do not edit.
//
// Generated from character_spells.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'character_spell_info.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CharacterSpells extends $pb.GeneratedMessage {
  factory CharacterSpells({
    $core.Iterable<$0.CharacterSpellInfo>? knownSpells,
    $core.Iterable<$0.CharacterSpellInfo>? preparedSpells,
    $core.Iterable<$0.CharacterSpellInfo>? knownCantrips,
  }) {
    final result = create();
    if (knownSpells != null) result.knownSpells.addAll(knownSpells);
    if (preparedSpells != null) result.preparedSpells.addAll(preparedSpells);
    if (knownCantrips != null) result.knownCantrips.addAll(knownCantrips);
    return result;
  }

  CharacterSpells._();

  factory CharacterSpells.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterSpells.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterSpells',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..pPM<$0.CharacterSpellInfo>(1, _omitFieldNames ? '' : 'knownSpells',
        protoName: 'knownSpells', subBuilder: $0.CharacterSpellInfo.create)
    ..pPM<$0.CharacterSpellInfo>(2, _omitFieldNames ? '' : 'preparedSpells',
        protoName: 'preparedSpells', subBuilder: $0.CharacterSpellInfo.create)
    ..pPM<$0.CharacterSpellInfo>(3, _omitFieldNames ? '' : 'knownCantrips',
        protoName: 'knownCantrips', subBuilder: $0.CharacterSpellInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterSpells clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterSpells copyWith(void Function(CharacterSpells) updates) =>
      super.copyWith((message) => updates(message as CharacterSpells))
          as CharacterSpells;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterSpells create() => CharacterSpells._();
  @$core.override
  CharacterSpells createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterSpells getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterSpells>(create);
  static CharacterSpells? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$0.CharacterSpellInfo> get knownSpells => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.CharacterSpellInfo> get preparedSpells => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$0.CharacterSpellInfo> get knownCantrips => $_getList(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
