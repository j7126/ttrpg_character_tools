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

class AlignmentA extends $pb.ProtobufEnum {
  static const AlignmentA Lawful =
      AlignmentA._(0, _omitEnumNames ? '' : 'Lawful');
  static const AlignmentA NeutralA =
      AlignmentA._(1, _omitEnumNames ? '' : 'NeutralA');
  static const AlignmentA Chaotic =
      AlignmentA._(2, _omitEnumNames ? '' : 'Chaotic');

  static const $core.List<AlignmentA> values = <AlignmentA>[
    Lawful,
    NeutralA,
    Chaotic,
  ];

  static final $core.List<AlignmentA?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static AlignmentA? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AlignmentA._(super.value, super.name);
}

class AlignmentB extends $pb.ProtobufEnum {
  static const AlignmentB Good = AlignmentB._(0, _omitEnumNames ? '' : 'Good');
  static const AlignmentB NeutralB =
      AlignmentB._(1, _omitEnumNames ? '' : 'NeutralB');
  static const AlignmentB Evil = AlignmentB._(2, _omitEnumNames ? '' : 'Evil');

  static const $core.List<AlignmentB> values = <AlignmentB>[
    Good,
    NeutralB,
    Evil,
  ];

  static final $core.List<AlignmentB?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static AlignmentB? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AlignmentB._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
