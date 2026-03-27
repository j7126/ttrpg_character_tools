import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttrpg_character_tools/datamodel/extension/dice_extension.dart';
import 'package:ttrpg_character_tools/datamodel/generated/dice.pb.dart';

class DiceFieldBase extends StatefulWidget {
  const DiceFieldBase({
    super.key,
    required this.label,
    required this.value,
    required this.valueChanged,
    this.inputBorder,
    this.showLabel,
    this.isDense = false,
    this.textAlign = TextAlign.left,
    this.textStyle,
    this.focusNode,
  });

  final String label;
  final Iterable<Dice> value;
  final Function(Iterable<Dice> val) valueChanged;
  final InputBorder? inputBorder;
  final bool? showLabel;
  final bool isDense;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final FocusNode? focusNode;

  @override
  State<DiceFieldBase> createState() => _DiceFieldBaseState();
}

class _DiceFieldBaseState extends State<DiceFieldBase> {
  late TextEditingController controller;
  late String textValue;
  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  void _valueChanged() {
    if (textValue == controller.text) {
      return;
    }

    var dice = DiceListExtension.fromString(controller.text);

    textValue = dice.toDiceString();
    controller.text = textValue;
    widget.valueChanged(dice);
  }

  void _handleFocusChanged() {
    if (!_effectiveFocusNode.hasFocus) {
      _valueChanged();
    }
  }

  @override
  void initState() {
    textValue = widget.value.toDiceString();
    controller = TextEditingController(text: textValue);

    _effectiveFocusNode.addListener(_handleFocusChanged);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DiceFieldBase oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }

    if (widget.value.toDiceString() != textValue && !_effectiveFocusNode.hasFocus) {
      textValue = widget.value.toDiceString();
      controller.text = textValue;
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: () {
        _effectiveFocusNode.unfocus();
        _valueChanged();
      },
      textAlign: widget.textAlign,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9d \+]')),
      ],
      decoration: InputDecoration(
        border: widget.inputBorder ?? OutlineInputBorder(),
        labelText: (widget.showLabel ?? widget.inputBorder != InputBorder.none)
            ? widget.label
            : null,
        hintText: widget.label,
        isDense: widget.isDense,
      ),
      focusNode: _effectiveFocusNode,
      style: widget.textStyle,
    );
  }
}
