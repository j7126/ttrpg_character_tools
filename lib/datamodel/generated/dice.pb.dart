// This is a generated file - do not edit.
//
// Generated from dice.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Dice extends $pb.GeneratedMessage {
  factory Dice({
    $core.int? faces,
    $core.int? qty,
  }) {
    final result = create();
    if (faces != null) result.faces = faces;
    if (qty != null) result.qty = qty;
    return result;
  }

  Dice._();

  factory Dice.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Dice.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Dice',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'ttrpg_character_tools'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'faces')
    ..aI(2, _omitFieldNames ? '' : 'qty')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Dice clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Dice copyWith(void Function(Dice) updates) =>
      super.copyWith((message) => updates(message as Dice)) as Dice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Dice create() => Dice._();
  @$core.override
  Dice createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Dice getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Dice>(create);
  static Dice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get faces => $_getIZ(0);
  @$pb.TagNumber(1)
  set faces($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFaces() => $_has(0);
  @$pb.TagNumber(1)
  void clearFaces() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get qty => $_getIZ(1);
  @$pb.TagNumber(2)
  set qty($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQty() => $_has(1);
  @$pb.TagNumber(2)
  void clearQty() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
