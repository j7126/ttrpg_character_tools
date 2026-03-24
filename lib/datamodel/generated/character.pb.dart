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

import 'character_alignment.pb.dart' as $2;
import 'character_life.pb.dart' as $3;
import 'character_skills.pb.dart' as $5;
import 'character_stats.pb.dart' as $4;
import 'options.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Character extends $pb.GeneratedMessage {
  factory Character({
    $core.String? id,
    $core.String? name,
    $0.Timestamp? createdTimestamp,
    $1.Options? options,
    $core.Iterable<$core.MapEntry<$core.String, $core.int>>? classAndLevel,
    $core.String? background,
    $core.String? race,
    $core.String? subRace,
    $core.int? xp,
    $2.CharacterAlignment? alignment,
    $3.CharacterLife? life,
    $4.CharacterStats? stats,
    $5.CharacterSkills? skills,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (createdTimestamp != null) result.createdTimestamp = createdTimestamp;
    if (options != null) result.options = options;
    if (classAndLevel != null) result.classAndLevel.addEntries(classAndLevel);
    if (background != null) result.background = background;
    if (race != null) result.race = race;
    if (subRace != null) result.subRace = subRace;
    if (xp != null) result.xp = xp;
    if (alignment != null) result.alignment = alignment;
    if (life != null) result.life = life;
    if (stats != null) result.stats = stats;
    if (skills != null) result.skills = skills;
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
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'createdTimestamp',
        protoName: 'createdTimestamp', subBuilder: $0.Timestamp.create)
    ..aOM<$1.Options>(6, _omitFieldNames ? '' : 'options',
        subBuilder: $1.Options.create)
    ..m<$core.String, $core.int>(7, _omitFieldNames ? '' : 'classAndLevel',
        protoName: 'classAndLevel',
        entryClassName: 'Character.ClassAndLevelEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('ttrpg_character_tools'))
    ..aOS(8, _omitFieldNames ? '' : 'background')
    ..aOS(9, _omitFieldNames ? '' : 'race')
    ..aOS(10, _omitFieldNames ? '' : 'subRace', protoName: 'subRace')
    ..aI(11, _omitFieldNames ? '' : 'xp')
    ..aOM<$2.CharacterAlignment>(12, _omitFieldNames ? '' : 'alignment',
        subBuilder: $2.CharacterAlignment.create)
    ..aOM<$3.CharacterLife>(13, _omitFieldNames ? '' : 'life',
        subBuilder: $3.CharacterLife.create)
    ..aOM<$4.CharacterStats>(14, _omitFieldNames ? '' : 'stats',
        subBuilder: $4.CharacterStats.create)
    ..aOM<$5.CharacterSkills>(15, _omitFieldNames ? '' : 'skills',
        subBuilder: $5.CharacterSkills.create)
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

  @$pb.TagNumber(5)
  $0.Timestamp get createdTimestamp => $_getN(2);
  @$pb.TagNumber(5)
  set createdTimestamp($0.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedTimestamp() => $_has(2);
  @$pb.TagNumber(5)
  void clearCreatedTimestamp() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureCreatedTimestamp() => $_ensure(2);

  @$pb.TagNumber(6)
  $1.Options get options => $_getN(3);
  @$pb.TagNumber(6)
  set options($1.Options value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasOptions() => $_has(3);
  @$pb.TagNumber(6)
  void clearOptions() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Options ensureOptions() => $_ensure(3);

  @$pb.TagNumber(7)
  $pb.PbMap<$core.String, $core.int> get classAndLevel => $_getMap(4);

  @$pb.TagNumber(8)
  $core.String get background => $_getSZ(5);
  @$pb.TagNumber(8)
  set background($core.String value) => $_setString(5, value);
  @$pb.TagNumber(8)
  $core.bool hasBackground() => $_has(5);
  @$pb.TagNumber(8)
  void clearBackground() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get race => $_getSZ(6);
  @$pb.TagNumber(9)
  set race($core.String value) => $_setString(6, value);
  @$pb.TagNumber(9)
  $core.bool hasRace() => $_has(6);
  @$pb.TagNumber(9)
  void clearRace() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get subRace => $_getSZ(7);
  @$pb.TagNumber(10)
  set subRace($core.String value) => $_setString(7, value);
  @$pb.TagNumber(10)
  $core.bool hasSubRace() => $_has(7);
  @$pb.TagNumber(10)
  void clearSubRace() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get xp => $_getIZ(8);
  @$pb.TagNumber(11)
  set xp($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(11)
  $core.bool hasXp() => $_has(8);
  @$pb.TagNumber(11)
  void clearXp() => $_clearField(11);

  @$pb.TagNumber(12)
  $2.CharacterAlignment get alignment => $_getN(9);
  @$pb.TagNumber(12)
  set alignment($2.CharacterAlignment value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasAlignment() => $_has(9);
  @$pb.TagNumber(12)
  void clearAlignment() => $_clearField(12);
  @$pb.TagNumber(12)
  $2.CharacterAlignment ensureAlignment() => $_ensure(9);

  @$pb.TagNumber(13)
  $3.CharacterLife get life => $_getN(10);
  @$pb.TagNumber(13)
  set life($3.CharacterLife value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasLife() => $_has(10);
  @$pb.TagNumber(13)
  void clearLife() => $_clearField(13);
  @$pb.TagNumber(13)
  $3.CharacterLife ensureLife() => $_ensure(10);

  @$pb.TagNumber(14)
  $4.CharacterStats get stats => $_getN(11);
  @$pb.TagNumber(14)
  set stats($4.CharacterStats value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasStats() => $_has(11);
  @$pb.TagNumber(14)
  void clearStats() => $_clearField(14);
  @$pb.TagNumber(14)
  $4.CharacterStats ensureStats() => $_ensure(11);

  @$pb.TagNumber(15)
  $5.CharacterSkills get skills => $_getN(12);
  @$pb.TagNumber(15)
  set skills($5.CharacterSkills value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasSkills() => $_has(12);
  @$pb.TagNumber(15)
  void clearSkills() => $_clearField(15);
  @$pb.TagNumber(15)
  $5.CharacterSkills ensureSkills() => $_ensure(12);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
