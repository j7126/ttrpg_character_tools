// This is a generated file - do not edit.
//
// Generated from character.proto.

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

@$core.Deprecated('Use characterDescriptor instead')
const Character$json = {
  '1': 'Character',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'life', '3': 3, '4': 1, '5': 5, '10': 'life'},
    {'1': 'maxLife', '3': 4, '4': 1, '5': 5, '10': 'maxLife'},
    {
      '1': 'createdTimestamp',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdTimestamp'
    },
    {
      '1': 'options',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.ttrpg_character_tools.Options',
      '10': 'options'
    },
  ],
};

/// Descriptor for `Character`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterDescriptor = $convert.base64Decode(
    'CglDaGFyYWN0ZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSEgoEbGlmZR'
    'gDIAEoBVIEbGlmZRIYCgdtYXhMaWZlGAQgASgFUgdtYXhMaWZlEkYKEGNyZWF0ZWRUaW1lc3Rh'
    'bXAYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUhBjcmVhdGVkVGltZXN0YW1wEj'
    'gKB29wdGlvbnMYBiABKAsyHi50dHJwZ19jaGFyYWN0ZXJfdG9vbHMuT3B0aW9uc1IHb3B0aW9u'
    'cw==');
