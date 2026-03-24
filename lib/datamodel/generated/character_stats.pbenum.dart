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

class StatsType extends $pb.ProtobufEnum {
  static const StatsType Strength =
      StatsType._(0, _omitEnumNames ? '' : 'Strength');
  static const StatsType Dexterity =
      StatsType._(1, _omitEnumNames ? '' : 'Dexterity');
  static const StatsType Constitution =
      StatsType._(2, _omitEnumNames ? '' : 'Constitution');
  static const StatsType Intelligence =
      StatsType._(3, _omitEnumNames ? '' : 'Intelligence');
  static const StatsType Wisdom =
      StatsType._(4, _omitEnumNames ? '' : 'Wisdom');
  static const StatsType Charisma =
      StatsType._(5, _omitEnumNames ? '' : 'Charisma');

  static const $core.List<StatsType> values = <StatsType>[
    Strength,
    Dexterity,
    Constitution,
    Intelligence,
    Wisdom,
    Charisma,
  ];

  static final $core.List<StatsType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static StatsType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const StatsType._(super.value, super.name);
}

class StatsMethod extends $pb.ProtobufEnum {
  static const StatsMethod StatsStandardArray =
      StatsMethod._(0, _omitEnumNames ? '' : 'StatsStandardArray');
  static const StatsMethod StatsPointBuy =
      StatsMethod._(1, _omitEnumNames ? '' : 'StatsPointBuy');
  static const StatsMethod StatsRolled =
      StatsMethod._(2, _omitEnumNames ? '' : 'StatsRolled');

  static const $core.List<StatsMethod> values = <StatsMethod>[
    StatsStandardArray,
    StatsPointBuy,
    StatsRolled,
  ];

  static final $core.List<StatsMethod?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static StatsMethod? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const StatsMethod._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
