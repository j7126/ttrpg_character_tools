// This is a generated file - do not edit.
//
// Generated from character_alignment.proto.

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

@$core.Deprecated('Use alignmentADescriptor instead')
const AlignmentA$json = {
  '1': 'AlignmentA',
  '2': [
    {'1': 'Lawful', '2': 0},
    {'1': 'NeutralA', '2': 1},
    {'1': 'Chaotic', '2': 2},
  ],
};

/// Descriptor for `AlignmentA`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List alignmentADescriptor = $convert.base64Decode(
    'CgpBbGlnbm1lbnRBEgoKBkxhd2Z1bBAAEgwKCE5ldXRyYWxBEAESCwoHQ2hhb3RpYxAC');

@$core.Deprecated('Use alignmentBDescriptor instead')
const AlignmentB$json = {
  '1': 'AlignmentB',
  '2': [
    {'1': 'Good', '2': 0},
    {'1': 'NeutralB', '2': 1},
    {'1': 'Evil', '2': 2},
  ],
};

/// Descriptor for `AlignmentB`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List alignmentBDescriptor = $convert.base64Decode(
    'CgpBbGlnbm1lbnRCEggKBEdvb2QQABIMCghOZXV0cmFsQhABEggKBEV2aWwQAg==');

@$core.Deprecated('Use characterAlignmentDescriptor instead')
const CharacterAlignment$json = {
  '1': 'CharacterAlignment',
  '2': [
    {
      '1': 'a',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.ttrpg_character_tools.AlignmentA',
      '10': 'a'
    },
    {
      '1': 'b',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.ttrpg_character_tools.AlignmentB',
      '10': 'b'
    },
  ],
};

/// Descriptor for `CharacterAlignment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterAlignmentDescriptor = $convert.base64Decode(
    'ChJDaGFyYWN0ZXJBbGlnbm1lbnQSLwoBYRgBIAEoDjIhLnR0cnBnX2NoYXJhY3Rlcl90b29scy'
    '5BbGlnbm1lbnRBUgFhEi8KAWIYAiABKA4yIS50dHJwZ19jaGFyYWN0ZXJfdG9vbHMuQWxpZ25t'
    'ZW50QlIBYg==');
