// This is a generated file - do not edit.
//
// Generated from character_life.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'character_life.pbenum.dart';
import 'dice.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'character_life.pbenum.dart';

class CharacterLife extends $pb.GeneratedMessage {
  factory CharacterLife({
    $core.int? hitPoints,
    $core.int? temporaryHitPoints,
    MaxHitPoints? maxHitPoints,
    $core.int? maxHitPointsQty,
    $core.Iterable<$0.Dice>? hitDice,
    $core.int? deathSaveSuccess,
    $core.int? deathSaveFailure,
    $core.Iterable<$0.Dice>? currentHitDice,
  }) {
    final result = create();
    if (hitPoints != null) result.hitPoints = hitPoints;
    if (temporaryHitPoints != null)
      result.temporaryHitPoints = temporaryHitPoints;
    if (maxHitPoints != null) result.maxHitPoints = maxHitPoints;
    if (maxHitPointsQty != null) result.maxHitPointsQty = maxHitPointsQty;
    if (hitDice != null) result.hitDice.addAll(hitDice);
    if (deathSaveSuccess != null) result.deathSaveSuccess = deathSaveSuccess;
    if (deathSaveFailure != null) result.deathSaveFailure = deathSaveFailure;
    if (currentHitDice != null) result.currentHitDice.addAll(currentHitDice);
    return result;
  }

  CharacterLife._();

  factory CharacterLife.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterLife.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterLife',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'hitPoints', protoName: 'hitPoints')
    ..aI(2, _omitFieldNames ? '' : 'temporaryHitPoints',
        protoName: 'temporaryHitPoints')
    ..aE<MaxHitPoints>(3, _omitFieldNames ? '' : 'maxHitPoints',
        protoName: 'maxHitPoints', enumValues: MaxHitPoints.values)
    ..aI(4, _omitFieldNames ? '' : 'maxHitPointsQty',
        protoName: 'maxHitPointsQty')
    ..pPM<$0.Dice>(5, _omitFieldNames ? '' : 'hitDice',
        protoName: 'hitDice', subBuilder: $0.Dice.create)
    ..aI(6, _omitFieldNames ? '' : 'deathSaveSuccess',
        protoName: 'deathSaveSuccess')
    ..aI(7, _omitFieldNames ? '' : 'deathSaveFailure',
        protoName: 'deathSaveFailure')
    ..pPM<$0.Dice>(8, _omitFieldNames ? '' : 'currentHitDice',
        protoName: 'currentHitDice', subBuilder: $0.Dice.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterLife clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterLife copyWith(void Function(CharacterLife) updates) =>
      super.copyWith((message) => updates(message as CharacterLife))
          as CharacterLife;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterLife create() => CharacterLife._();
  @$core.override
  CharacterLife createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterLife getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterLife>(create);
  static CharacterLife? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get hitPoints => $_getIZ(0);
  @$pb.TagNumber(1)
  set hitPoints($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHitPoints() => $_has(0);
  @$pb.TagNumber(1)
  void clearHitPoints() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get temporaryHitPoints => $_getIZ(1);
  @$pb.TagNumber(2)
  set temporaryHitPoints($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTemporaryHitPoints() => $_has(1);
  @$pb.TagNumber(2)
  void clearTemporaryHitPoints() => $_clearField(2);

  @$pb.TagNumber(3)
  MaxHitPoints get maxHitPoints => $_getN(2);
  @$pb.TagNumber(3)
  set maxHitPoints(MaxHitPoints value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMaxHitPoints() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxHitPoints() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get maxHitPointsQty => $_getIZ(3);
  @$pb.TagNumber(4)
  set maxHitPointsQty($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxHitPointsQty() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxHitPointsQty() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$0.Dice> get hitDice => $_getList(4);

  @$pb.TagNumber(6)
  $core.int get deathSaveSuccess => $_getIZ(5);
  @$pb.TagNumber(6)
  set deathSaveSuccess($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDeathSaveSuccess() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeathSaveSuccess() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get deathSaveFailure => $_getIZ(6);
  @$pb.TagNumber(7)
  set deathSaveFailure($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDeathSaveFailure() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeathSaveFailure() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$0.Dice> get currentHitDice => $_getList(7);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
