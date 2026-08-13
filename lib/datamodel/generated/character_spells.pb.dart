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
    $core.Iterable<ExpendedSpellSlots>? expendedSpellSlots,
  }) {
    final result = create();
    if (knownSpells != null) result.knownSpells.addAll(knownSpells);
    if (preparedSpells != null) result.preparedSpells.addAll(preparedSpells);
    if (knownCantrips != null) result.knownCantrips.addAll(knownCantrips);
    if (expendedSpellSlots != null)
      result.expendedSpellSlots.addAll(expendedSpellSlots);
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
    ..pPM<ExpendedSpellSlots>(4, _omitFieldNames ? '' : 'expendedSpellSlots',
        protoName: 'expendedSpellSlots', subBuilder: ExpendedSpellSlots.create)
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

  @$pb.TagNumber(4)
  $pb.PbList<ExpendedSpellSlots> get expendedSpellSlots => $_getList(3);
}

class ExpendedSpellSlots extends $pb.GeneratedMessage {
  factory ExpendedSpellSlots({
    $core.String? slotSource,
    $core.int? slotLevel,
    $core.int? numExpended,
  }) {
    final result = create();
    if (slotSource != null) result.slotSource = slotSource;
    if (slotLevel != null) result.slotLevel = slotLevel;
    if (numExpended != null) result.numExpended = numExpended;
    return result;
  }

  ExpendedSpellSlots._();

  factory ExpendedSpellSlots.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExpendedSpellSlots.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExpendedSpellSlots',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'slotSource', protoName: 'slotSource')
    ..aI(2, _omitFieldNames ? '' : 'slotLevel', protoName: 'slotLevel')
    ..aI(3, _omitFieldNames ? '' : 'numExpended', protoName: 'numExpended')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExpendedSpellSlots clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExpendedSpellSlots copyWith(void Function(ExpendedSpellSlots) updates) =>
      super.copyWith((message) => updates(message as ExpendedSpellSlots))
          as ExpendedSpellSlots;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExpendedSpellSlots create() => ExpendedSpellSlots._();
  @$core.override
  ExpendedSpellSlots createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ExpendedSpellSlots getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExpendedSpellSlots>(create);
  static ExpendedSpellSlots? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get slotSource => $_getSZ(0);
  @$pb.TagNumber(1)
  set slotSource($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSlotSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSlotSource() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get slotLevel => $_getIZ(1);
  @$pb.TagNumber(2)
  set slotLevel($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSlotLevel() => $_has(1);
  @$pb.TagNumber(2)
  void clearSlotLevel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get numExpended => $_getIZ(2);
  @$pb.TagNumber(3)
  set numExpended($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNumExpended() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumExpended() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
