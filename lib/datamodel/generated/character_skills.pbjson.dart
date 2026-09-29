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
      '1': 'currentProficency',
      '3': 1,
      '4': 3,
      '5': 14,
      '6': '.ttrpg_character_tools.CharacterSkill',
      '10': 'currentProficency'
    },
    {
      '1': 'overrides',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterSkills.OverridesEntry',
      '10': 'overrides'
    },
    {
      '1': 'overrideProficency',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.ttrpg_character_tools.CharacterSkill',
      '10': 'overrideProficency'
    },
    {
      '1': 'proficencyChoices',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterProficencyChoice',
      '10': 'proficencyChoices'
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
    'Cg9DaGFyYWN0ZXJTa2lsbHMSUwoRY3VycmVudFByb2ZpY2VuY3kYASADKA4yJS50dHJwZ19jaG'
    'FyYWN0ZXJfdG9vbHMuQ2hhcmFjdGVyU2tpbGxSEWN1cnJlbnRQcm9maWNlbmN5ElMKCW92ZXJy'
    'aWRlcxgCIAMoCzI1LnR0cnBnX2NoYXJhY3Rlcl90b29scy5DaGFyYWN0ZXJTa2lsbHMuT3Zlcn'
    'JpZGVzRW50cnlSCW92ZXJyaWRlcxJVChJvdmVycmlkZVByb2ZpY2VuY3kYAyADKA4yJS50dHJw'
    'Z19jaGFyYWN0ZXJfdG9vbHMuQ2hhcmFjdGVyU2tpbGxSEm92ZXJyaWRlUHJvZmljZW5jeRJeCh'
    'Fwcm9maWNlbmN5Q2hvaWNlcxgEIAMoCzIwLnR0cnBnX2NoYXJhY3Rlcl90b29scy5DaGFyYWN0'
    'ZXJQcm9maWNlbmN5Q2hvaWNlUhFwcm9maWNlbmN5Q2hvaWNlcxo8Cg5PdmVycmlkZXNFbnRyeR'
    'IQCgNrZXkYASABKAVSA2tleRIUCgV2YWx1ZRgCIAEoBVIFdmFsdWU6AjgB');

@$core.Deprecated('Use characterProficencyChoiceDescriptor instead')
const CharacterProficencyChoice$json = {
  '1': 'CharacterProficencyChoice',
  '2': [
    {'1': 'providerRef', '3': 1, '4': 1, '5': 9, '10': 'providerRef'},
    {
      '1': 'fixed',
      '3': 2,
      '4': 3,
      '5': 14,
      '6': '.ttrpg_character_tools.CharacterSkill',
      '10': 'fixed'
    },
    {
      '1': 'choices',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.ttrpg_character_tools.CharacterSkill',
      '10': 'choices'
    },
    {
      '1': 'choicesAny',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.ttrpg_character_tools.CharacterSkill',
      '10': 'choicesAny'
    },
  ],
};

/// Descriptor for `CharacterProficencyChoice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterProficencyChoiceDescriptor = $convert.base64Decode(
    'ChlDaGFyYWN0ZXJQcm9maWNlbmN5Q2hvaWNlEiAKC3Byb3ZpZGVyUmVmGAEgASgJUgtwcm92aW'
    'RlclJlZhI7CgVmaXhlZBgCIAMoDjIlLnR0cnBnX2NoYXJhY3Rlcl90b29scy5DaGFyYWN0ZXJT'
    'a2lsbFIFZml4ZWQSPwoHY2hvaWNlcxgDIAMoDjIlLnR0cnBnX2NoYXJhY3Rlcl90b29scy5DaG'
    'FyYWN0ZXJTa2lsbFIHY2hvaWNlcxJFCgpjaG9pY2VzQW55GAQgAygOMiUudHRycGdfY2hhcmFj'
    'dGVyX3Rvb2xzLkNoYXJhY3RlclNraWxsUgpjaG9pY2VzQW55');
