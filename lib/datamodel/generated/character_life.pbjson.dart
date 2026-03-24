// This is a generated file - do not edit.
//
// Generated from character_life.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use maxHitPointsDescriptor instead')
const MaxHitPoints$json = {
  '1': 'MaxHitPoints',
  '2': [
    {'1': 'HpAverage', '2': 0},
    {'1': 'HpRolled', '2': 1},
    {'1': 'HpCustom', '2': 2},
  ],
};

/// Descriptor for `MaxHitPoints`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List maxHitPointsDescriptor = $convert.base64Decode(
    'CgxNYXhIaXRQb2ludHMSDQoJSHBBdmVyYWdlEAASDAoISHBSb2xsZWQQARIMCghIcEN1c3RvbR'
    'AC');

@$core.Deprecated('Use characterLifeDescriptor instead')
const CharacterLife$json = {
  '1': 'CharacterLife',
  '2': [
    {'1': 'hitPoints', '3': 1, '4': 1, '5': 5, '10': 'hitPoints'},
    {
      '1': 'temporaryHitPoints',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'temporaryHitPoints'
    },
    {
      '1': 'maxHitPoints',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.ttrpg_character_tools.MaxHitPoints',
      '10': 'maxHitPoints'
    },
    {
      '1': 'maxHitPointsQty',
      '3': 4,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'maxHitPointsQty',
      '17': true
    },
    {
      '1': 'hitDice',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.Dice',
      '10': 'hitDice'
    },
    {'1': 'deathSaveSuccess', '3': 6, '4': 1, '5': 5, '10': 'deathSaveSuccess'},
    {'1': 'deathSaveFailure', '3': 7, '4': 1, '5': 5, '10': 'deathSaveFailure'},
  ],
  '8': [
    {'1': '_maxHitPointsQty'},
  ],
};

/// Descriptor for `CharacterLife`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterLifeDescriptor = $convert.base64Decode(
    'Cg1DaGFyYWN0ZXJMaWZlEhwKCWhpdFBvaW50cxgBIAEoBVIJaGl0UG9pbnRzEi4KEnRlbXBvcm'
    'FyeUhpdFBvaW50cxgCIAEoBVISdGVtcG9yYXJ5SGl0UG9pbnRzEkcKDG1heEhpdFBvaW50cxgD'
    'IAEoDjIjLnR0cnBnX2NoYXJhY3Rlcl90b29scy5NYXhIaXRQb2ludHNSDG1heEhpdFBvaW50cx'
    'ItCg9tYXhIaXRQb2ludHNRdHkYBCABKAVIAFIPbWF4SGl0UG9pbnRzUXR5iAEBEjUKB2hpdERp'
    'Y2UYBSADKAsyGy50dHJwZ19jaGFyYWN0ZXJfdG9vbHMuRGljZVIHaGl0RGljZRIqChBkZWF0aF'
    'NhdmVTdWNjZXNzGAYgASgFUhBkZWF0aFNhdmVTdWNjZXNzEioKEGRlYXRoU2F2ZUZhaWx1cmUY'
    'ByABKAVSEGRlYXRoU2F2ZUZhaWx1cmVCEgoQX21heEhpdFBvaW50c1F0eQ==');
