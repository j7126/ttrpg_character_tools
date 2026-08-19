// This is a generated file - do not edit.
//
// Generated from character_build_choice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class CharacterBuildChoice extends $pb.GeneratedMessage {
  factory CharacterBuildChoice({
    $core.Iterable<CharacterBuildChoiceSelection>? choice,
    $core.int? maxSelectedQty,
  }) {
    final result = create();
    if (choice != null) result.choice.addAll(choice);
    if (maxSelectedQty != null) result.maxSelectedQty = maxSelectedQty;
    return result;
  }

  CharacterBuildChoice._();

  factory CharacterBuildChoice.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterBuildChoice.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterBuildChoice',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..pPM<CharacterBuildChoiceSelection>(1, _omitFieldNames ? '' : 'choice',
        subBuilder: CharacterBuildChoiceSelection.create)
    ..aI(2, _omitFieldNames ? '' : 'maxSelectedQty',
        protoName: 'maxSelectedQty')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterBuildChoice clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterBuildChoice copyWith(void Function(CharacterBuildChoice) updates) =>
      super.copyWith((message) => updates(message as CharacterBuildChoice))
          as CharacterBuildChoice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterBuildChoice create() => CharacterBuildChoice._();
  @$core.override
  CharacterBuildChoice createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterBuildChoice getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterBuildChoice>(create);
  static CharacterBuildChoice? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CharacterBuildChoiceSelection> get choice => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get maxSelectedQty => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxSelectedQty($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxSelectedQty() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxSelectedQty() => $_clearField(2);
}

class CharacterBuildChoiceSelection extends $pb.GeneratedMessage {
  factory CharacterBuildChoiceSelection({
    $core.String? choiceName,
    $core.String? choiceReference,
  }) {
    final result = create();
    if (choiceName != null) result.choiceName = choiceName;
    if (choiceReference != null) result.choiceReference = choiceReference;
    return result;
  }

  CharacterBuildChoiceSelection._();

  factory CharacterBuildChoiceSelection.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CharacterBuildChoiceSelection.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CharacterBuildChoiceSelection',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'choiceName', protoName: 'choiceName')
    ..aOS(2, _omitFieldNames ? '' : 'choiceReference',
        protoName: 'choiceReference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterBuildChoiceSelection clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CharacterBuildChoiceSelection copyWith(
          void Function(CharacterBuildChoiceSelection) updates) =>
      super.copyWith(
              (message) => updates(message as CharacterBuildChoiceSelection))
          as CharacterBuildChoiceSelection;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CharacterBuildChoiceSelection create() =>
      CharacterBuildChoiceSelection._();
  @$core.override
  CharacterBuildChoiceSelection createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CharacterBuildChoiceSelection getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CharacterBuildChoiceSelection>(create);
  static CharacterBuildChoiceSelection? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get choiceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set choiceName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChoiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearChoiceName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get choiceReference => $_getSZ(1);
  @$pb.TagNumber(2)
  set choiceReference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChoiceReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearChoiceReference() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
