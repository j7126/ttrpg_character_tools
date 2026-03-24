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

class MaxHitPoints extends $pb.ProtobufEnum {
  static const MaxHitPoints HpAverage =
      MaxHitPoints._(0, _omitEnumNames ? '' : 'HpAverage');
  static const MaxHitPoints HpRolled =
      MaxHitPoints._(1, _omitEnumNames ? '' : 'HpRolled');
  static const MaxHitPoints HpCustom =
      MaxHitPoints._(2, _omitEnumNames ? '' : 'HpCustom');

  static const $core.List<MaxHitPoints> values = <MaxHitPoints>[
    HpAverage,
    HpRolled,
    HpCustom,
  ];

  static final $core.List<MaxHitPoints?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static MaxHitPoints? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MaxHitPoints._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
