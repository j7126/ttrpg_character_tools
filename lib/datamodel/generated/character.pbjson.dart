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
    {
      '1': 'classAndLevel',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.Character.ClassAndLevelEntry',
      '10': 'classAndLevel'
    },
    {'1': 'background', '3': 8, '4': 1, '5': 9, '10': 'background'},
    {'1': 'race', '3': 9, '4': 1, '5': 9, '10': 'race'},
    {'1': 'subRace', '3': 10, '4': 1, '5': 9, '10': 'subRace'},
    {'1': 'xp', '3': 11, '4': 1, '5': 5, '9': 0, '10': 'xp', '17': true},
    {
      '1': 'alignment',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterAlignment',
      '10': 'alignment'
    },
    {
      '1': 'life',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterLife',
      '10': 'life'
    },
    {
      '1': 'stats',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterStats',
      '10': 'stats'
    },
    {
      '1': 'skills',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterSkills',
      '10': 'skills'
    },
  ],
  '3': [Character_ClassAndLevelEntry$json],
  '8': [
    {'1': '_xp'},
  ],
};

@$core.Deprecated('Use characterDescriptor instead')
const Character_ClassAndLevelEntry$json = {
  '1': 'ClassAndLevelEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Character`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterDescriptor = $convert.base64Decode(
    'CglDaGFyYWN0ZXISDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSRgoQY3JlYX'
    'RlZFRpbWVzdGFtcBgFIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSEGNyZWF0ZWRU'
    'aW1lc3RhbXASOAoHb3B0aW9ucxgGIAEoCzIeLnR0cnBnX2NoYXJhY3Rlcl90b29scy5PcHRpb2'
    '5zUgdvcHRpb25zElkKDWNsYXNzQW5kTGV2ZWwYByADKAsyMy50dHJwZ19jaGFyYWN0ZXJfdG9v'
    'bHMuQ2hhcmFjdGVyLkNsYXNzQW5kTGV2ZWxFbnRyeVINY2xhc3NBbmRMZXZlbBIeCgpiYWNrZ3'
    'JvdW5kGAggASgJUgpiYWNrZ3JvdW5kEhIKBHJhY2UYCSABKAlSBHJhY2USGAoHc3ViUmFjZRgK'
    'IAEoCVIHc3ViUmFjZRITCgJ4cBgLIAEoBUgAUgJ4cIgBARJHCglhbGlnbm1lbnQYDCABKAsyKS'
    '50dHJwZ19jaGFyYWN0ZXJfdG9vbHMuQ2hhcmFjdGVyQWxpZ25tZW50UglhbGlnbm1lbnQSOAoE'
    'bGlmZRgNIAEoCzIkLnR0cnBnX2NoYXJhY3Rlcl90b29scy5DaGFyYWN0ZXJMaWZlUgRsaWZlEj'
    'sKBXN0YXRzGA4gASgLMiUudHRycGdfY2hhcmFjdGVyX3Rvb2xzLkNoYXJhY3RlclN0YXRzUgVz'
    'dGF0cxI+CgZza2lsbHMYDyABKAsyJi50dHJwZ19jaGFyYWN0ZXJfdG9vbHMuQ2hhcmFjdGVyU2'
    'tpbGxzUgZza2lsbHMaQAoSQ2xhc3NBbmRMZXZlbEVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQK'
    'BXZhbHVlGAIgASgFUgV2YWx1ZToCOAFCBQoDX3hw');
