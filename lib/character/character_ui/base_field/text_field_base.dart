import 'package:flutter/material.dart';

class TextFieldBase extends StatefulWidget {
  const TextFieldBase({
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
  final String value;
  final Function(String val) valueChanged;
  final InputBorder? inputBorder;
  final bool? showLabel;
  final bool isDense;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final FocusNode? focusNode;

  @override
  State<TextFieldBase> createState() => _TextFieldBaseState();
}

class _TextFieldBaseState extends State<TextFieldBase> {
  late TextEditingController controller;
  late String textValue;
  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  void _valueChanged() {
    if (textValue == controller.text) {
      return;
    }

    textValue = controller.text;
    widget.valueChanged(textValue);
  }

  void _handleFocusChanged() {
    if (!_effectiveFocusNode.hasFocus) {
      _valueChanged();
    }
  }

  @override
  void initState() {
    textValue = widget.value;
    controller = TextEditingController(text: textValue);

    _effectiveFocusNode.addListener(_handleFocusChanged);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextFieldBase oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }

    if (widget.value != textValue && !_effectiveFocusNode.hasFocus) {
      textValue = widget.value;
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
