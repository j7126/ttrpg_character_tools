// This is a generated file - do not edit.
//
// Generated from options.proto.

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

@$core.Deprecated('Use levelingMethodDescriptor instead')
const LevelingMethod$json = {
  '1': 'LevelingMethod',
  '2': [
    {'1': 'Milestone', '2': 0},
    {'1': 'XP', '2': 1},
  ],
};

/// Descriptor for `LevelingMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List levelingMethodDescriptor = $convert
    .base64Decode('Cg5MZXZlbGluZ01ldGhvZBINCglNaWxlc3RvbmUQABIGCgJYUBAB');

@$core.Deprecated('Use optionsDescriptor instead')
const Options$json = {
  '1': 'Options',
  '2': [
    {
      '1': 'disableColorCodeLife',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'disableColorCodeLife'
    },
    {
      '1': 'levelingMethod',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.ttrpg_character_tools.LevelingMethod',
      '10': 'levelingMethod'
    },
  ],
};

/// Descriptor for `Options`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List optionsDescriptor = $convert.base64Decode(
    'CgdPcHRpb25zEjIKFGRpc2FibGVDb2xvckNvZGVMaWZlGAEgASgIUhRkaXNhYmxlQ29sb3JDb2'
    'RlTGlmZRJNCg5sZXZlbGluZ01ldGhvZBgCIAEoDjIlLnR0cnBnX2NoYXJhY3Rlcl90b29scy5M'
    'ZXZlbGluZ01ldGhvZFIObGV2ZWxpbmdNZXRob2Q=');
