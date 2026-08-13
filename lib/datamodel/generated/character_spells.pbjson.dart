// This is a generated file - do not edit.
//
// Generated from character_spells.proto.

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

@$core.Deprecated('Use characterSpellsDescriptor instead')
const CharacterSpells$json = {
  '1': 'CharacterSpells',
  '2': [
    {
      '1': 'knownSpells',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterSpellInfo',
      '10': 'knownSpells'
    },
    {
      '1': 'preparedSpells',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterSpellInfo',
      '10': 'preparedSpells'
    },
    {
      '1': 'knownCantrips',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.CharacterSpellInfo',
      '10': 'knownCantrips'
    },
    {
      '1': 'expendedSpellSlots',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.ttrpg_character_tools.ExpendedSpellSlots',
      '10': 'expendedSpellSlots'
    },
  ],
};

/// Descriptor for `CharacterSpells`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List characterSpellsDescriptor = $convert.base64Decode(
    'Cg9DaGFyYWN0ZXJTcGVsbHMSSwoLa25vd25TcGVsbHMYASADKAsyKS50dHJwZ19jaGFyYWN0ZX'
    'JfdG9vbHMuQ2hhcmFjdGVyU3BlbGxJbmZvUgtrbm93blNwZWxscxJRCg5wcmVwYXJlZFNwZWxs'
    'cxgCIAMoCzIpLnR0cnBnX2NoYXJhY3Rlcl90b29scy5DaGFyYWN0ZXJTcGVsbEluZm9SDnByZX'
    'BhcmVkU3BlbGxzEk8KDWtub3duQ2FudHJpcHMYAyADKAsyKS50dHJwZ19jaGFyYWN0ZXJfdG9v'
    'bHMuQ2hhcmFjdGVyU3BlbGxJbmZvUg1rbm93bkNhbnRyaXBzElkKEmV4cGVuZGVkU3BlbGxTbG'
    '90cxgEIAMoCzIpLnR0cnBnX2NoYXJhY3Rlcl90b29scy5FeHBlbmRlZFNwZWxsU2xvdHNSEmV4'
    'cGVuZGVkU3BlbGxTbG90cw==');

@$core.Deprecated('Use expendedSpellSlotsDescriptor instead')
const ExpendedSpellSlots$json = {
  '1': 'ExpendedSpellSlots',
  '2': [
    {'1': 'slotSource', '3': 1, '4': 1, '5': 9, '10': 'slotSource'},
    {'1': 'slotLevel', '3': 2, '4': 1, '5': 5, '10': 'slotLevel'},
    {'1': 'numExpended', '3': 3, '4': 1, '5': 5, '10': 'numExpended'},
  ],
};

/// Descriptor for `ExpendedSpellSlots`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List expendedSpellSlotsDescriptor = $convert.base64Decode(
    'ChJFeHBlbmRlZFNwZWxsU2xvdHMSHgoKc2xvdFNvdXJjZRgBIAEoCVIKc2xvdFNvdXJjZRIcCg'
    'lzbG90TGV2ZWwYAiABKAVSCXNsb3RMZXZlbBIgCgtudW1FeHBlbmRlZBgDIAEoBVILbnVtRXhw'
    'ZW5kZWQ=');
