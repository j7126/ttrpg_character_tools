// This is a generated file - do not edit.
//
// Generated from character_build_choice.proto.

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

@$core.Deprecated('Use characterBuildChoiceDescriptor instead')
const CharacterBuildChoice$json = {
  '1': 'CharacterBuildChoice',
  '2': [
    {
      '1': 'choice',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterBuildChoiceSelection',
      '10': 'choice'
    },
    {'1': 'maxSelectedQty', '3': 2, '4': 1, '5': 5, '10': 'maxSelectedQty'},
  ],
};

/// Descriptor for `CharacterBuildChoice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterBuildChoiceDescriptor = $convert.base64Decode(
    'ChRDaGFyYWN0ZXJCdWlsZENob2ljZRJMCgZjaG9pY2UYASADKAsyNC50dHJwZ19jaGFyYWN0ZX'
    'JfdG9vbHMuQ2hhcmFjdGVyQnVpbGRDaG9pY2VTZWxlY3Rpb25SBmNob2ljZRImCg5tYXhTZWxl'
    'Y3RlZFF0eRgCIAEoBVIObWF4U2VsZWN0ZWRRdHk=');

@$core.Deprecated('Use characterBuildChoiceSelectionDescriptor instead')
const CharacterBuildChoiceSelection$json = {
  '1': 'CharacterBuildChoiceSelection',
  '2': [
    {'1': 'choiceName', '3': 1, '4': 1, '5': 9, '10': 'choiceName'},
    {
      '1': 'choiceReference',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'choiceReference',
      '17': true
    },
  ],
  '8': [
    {'1': '_choiceReference'},
  ],
};

/// Descriptor for `CharacterBuildChoiceSelection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterBuildChoiceSelectionDescriptor =
    $convert.base64Decode(
        'Ch1DaGFyYWN0ZXJCdWlsZENob2ljZVNlbGVjdGlvbhIeCgpjaG9pY2VOYW1lGAEgASgJUgpjaG'
        '9pY2VOYW1lEi0KD2Nob2ljZVJlZmVyZW5jZRgCIAEoCUgAUg9jaG9pY2VSZWZlcmVuY2WIAQFC'
        'EgoQX2Nob2ljZVJlZmVyZW5jZQ==');
