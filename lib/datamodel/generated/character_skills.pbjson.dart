// This is a generated file - do not edit.
//
// Generated from character_skills.proto.

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

@$core.Deprecated('Use characterSkillDescriptor instead')
const CharacterSkill$json = {
  '1': 'CharacterSkill',
  '2': [
    {'1': 'Acrobatics', '2': 0},
    {'1': 'AnimalHandling', '2': 1},
    {'1': 'Arcana', '2': 2},
    {'1': 'Athletics', '2': 3},
    {'1': 'Deception', '2': 4},
    {'1': 'History', '2': 5},
    {'1': 'Insight', '2': 6},
    {'1': 'Intimidation', '2': 7},
    {'1': 'Investigation', '2': 8},
    {'1': 'Medicine', '2': 9},
    {'1': 'Nature', '2': 10},
    {'1': 'Perception', '2': 11},
    {'1': 'Performance', '2': 12},
    {'1': 'Persuasion', '2': 13},
    {'1': 'Religion', '2': 14},
    {'1': 'SleightOfHand', '2': 15},
    {'1': 'Stealth', '2': 16},
    {'1': 'Survival', '2': 17},
  ],
};

/// Descriptor for `CharacterSkill`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List characterSkillDescriptor = $convert.base64Decode(
    'Cg5DaGFyYWN0ZXJTa2lsbBIOCgpBY3JvYmF0aWNzEAASEgoOQW5pbWFsSGFuZGxpbmcQARIKCg'
    'ZBcmNhbmEQAhINCglBdGhsZXRpY3MQAxINCglEZWNlcHRpb24QBBILCgdIaXN0b3J5EAUSCwoH'
    'SW5zaWdodBAGEhAKDEludGltaWRhdGlvbhAHEhEKDUludmVzdGlnYXRpb24QCBIMCghNZWRpY2'
    'luZRAJEgoKBk5hdHVyZRAKEg4KClBlcmNlcHRpb24QCxIPCgtQZXJmb3JtYW5jZRAMEg4KClBl'
    'cnN1YXNpb24QDRIMCghSZWxpZ2lvbhAOEhEKDVNsZWlnaHRPZkhhbmQQDxILCgdTdGVhbHRoEB'
    'ASDAoIU3Vydml2YWwQEQ==');

@$core.Deprecated('Use characterSkillsDescriptor instead')
const CharacterSkills$json = {
  '1': 'CharacterSkills',
  '2': [
    {
      '1': 'proficency',
      '3': 1,
      '4': 3,
      '5': 14,
      '6': '.ttrpg_character_tools.CharacterSkill',
      '10': 'proficency'
    },
    {
      '1': 'overrides',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterSkills.OverridesEntry',
      '10': 'overrides'
    },
  ],
  '3': [CharacterSkills_OverridesEntry$json],
};

@$core.Deprecated('Use characterSkillsDescriptor instead')
const CharacterSkills_OverridesEntry$json = {
  '1': 'OverridesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 5, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 5, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CharacterSkills`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterSkillsDescriptor = $convert.base64Decode(
    'Cg9DaGFyYWN0ZXJTa2lsbHMSRQoKcHJvZmljZW5jeRgBIAMoDjIlLnR0cnBnX2NoYXJhY3Rlcl'
    '90b29scy5DaGFyYWN0ZXJTa2lsbFIKcHJvZmljZW5jeRJTCglvdmVycmlkZXMYAiADKAsyNS50'
    'dHJwZ19jaGFyYWN0ZXJfdG9vbHMuQ2hhcmFjdGVyU2tpbGxzLk92ZXJyaWRlc0VudHJ5Uglvdm'
    'VycmlkZXMaPAoOT3ZlcnJpZGVzRW50cnkSEAoDa2V5GAEgASgFUgNrZXkSFAoFdmFsdWUYAiAB'
    'KAVSBXZhbHVlOgI4AQ==');
