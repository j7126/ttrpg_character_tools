// This is a generated file - do not edit.
//
// Generated from options.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class LevelingMethod extends $pb.ProtobufEnum {
  static const LevelingMethod Milestone =
      LevelingMethod._(0, _omitEnumNames ? '' : 'Milestone');
  static const LevelingMethod XP =
      LevelingMethod._(1, _omitEnumNames ? '' : 'XP');

  static const $core.List<LevelingMethod> values = <LevelingMethod>[
    Milestone,
    XP,
  ];

  static final $core.List<LevelingMethod?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static LevelingMethod? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const LevelingMethod._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
