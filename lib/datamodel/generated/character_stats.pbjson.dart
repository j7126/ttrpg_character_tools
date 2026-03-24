// This is a generated file - do not edit.
//
// Generated from character_stats.proto.

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

@$core.Deprecated('Use statsTypeDescriptor instead')
const StatsType$json = {
  '1': 'StatsType',
  '2': [
    {'1': 'Strength', '2': 0},
    {'1': 'Dexterity', '2': 1},
    {'1': 'Constitution', '2': 2},
    {'1': 'Intelligence', '2': 3},
    {'1': 'Wisdom', '2': 4},
    {'1': 'Charisma', '2': 5},
  ],
};

/// Descriptor for `StatsType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List statsTypeDescriptor = $convert.base64Decode(
    'CglTdGF0c1R5cGUSDAoIU3RyZW5ndGgQABINCglEZXh0ZXJpdHkQARIQCgxDb25zdGl0dXRpb2'
    '4QAhIQCgxJbnRlbGxpZ2VuY2UQAxIKCgZXaXNkb20QBBIMCghDaGFyaXNtYRAF');

@$core.Deprecated('Use statsMethodDescriptor instead')
const StatsMethod$json = {
  '1': 'StatsMethod',
  '2': [
    {'1': 'StatsStandardArray', '2': 0},
    {'1': 'StatsPointBuy', '2': 1},
    {'1': 'StatsRolled', '2': 2},
  ],
};

/// Descriptor for `StatsMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List statsMethodDescriptor = $convert.base64Decode(
    'CgtTdGF0c01ldGhvZBIWChJTdGF0c1N0YW5kYXJkQXJyYXkQABIRCg1TdGF0c1BvaW50QnV5EA'
    'ESDwoLU3RhdHNSb2xsZWQQAg==');

@$core.Deprecated('Use characterStatsDescriptor instead')
const CharacterStats$json = {
  '1': 'CharacterStats',
  '2': [
    {
      '1': 'base',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterStats.BaseEntry',
      '10': 'base'
    },
    {
      '1': 'current',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterStats.CurrentEntry',
      '10': 'current'
    },
  ],
  '3': [CharacterStats_BaseEntry$json, CharacterStats_CurrentEntry$json],
};

@$core.Deprecated('Use characterStatsDescriptor instead')
const CharacterStats_BaseEntry$json = {
  '1': 'BaseEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use characterStatsDescriptor instead')
const CharacterStats_CurrentEntry$json = {
  '1': 'CurrentEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CharacterStats`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterStatsDescriptor = $convert.base64Decode(
    'Cg5DaGFyYWN0ZXJTdGF0cxJDCgRiYXNlGAEgAygLMi8udHRycGdfY2hhcmFjdGVyX3Rvb2xzLk'
    'NoYXJhY3RlclN0YXRzLkJhc2VFbnRyeVIEYmFzZRJMCgdjdXJyZW50GAIgAygLMjIudHRycGdf'
    'Y2hhcmFjdGVyX3Rvb2xzLkNoYXJhY3RlclN0YXRzLkN1cnJlbnRFbnRyeVIHY3VycmVudBo3Cg'
    'lCYXNlRW50cnkSEAoDa2V5GAEgASgFUgNrZXkSFAoFdmFsdWUYAiABKAVSBXZhbHVlOgI4ARo6'
    'CgxDdXJyZW50RW50cnkSEAoDa2V5GAEgASgFUgNrZXkSFAoFdmFsdWUYAiABKAVSBXZhbHVlOg'
    'I4AQ==');
