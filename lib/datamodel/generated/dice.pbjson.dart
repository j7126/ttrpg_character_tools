// This is a generated file - do not edit.
//
// Generated from dice.proto.

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

@$core.Deprecated('Use diceDescriptor instead')
const Dice$json = {
  '1': 'Dice',
  '2': [
    {'1': 'faces', '3': 1, '4': 1, '5': 5, '10': 'faces'},
    {'1': 'qty', '3': 2, '4': 1, '5': 5, '10': 'qty'},
  ],
};

/// Descriptor for `Dice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List diceDescriptor = $convert.base64Decode(
    'CgREaWNlEhQKBWZhY2VzGAEgASgFUgVmYWNlcxIQCgNxdHkYAiABKAVSA3F0eQ==');
