import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttrpg_character_tools/util/int_extension.dart';

class IntFieldBase extends StatefulWidget {
  const IntFieldBase({
    super.key,
    required this.label,
    required this.value,
    required this.valueChanged,
    this.inputBorder,
    this.showLabel,
    this.isDense = false,
    this.textAlign = TextAlign.center,
    this.textStyle,
    this.focusNode,
    this.withSign = false,
  });

  final String label;
  final int value;
  final Function(int val) valueChanged;
  final InputBorder? inputBorder;
  final bool? showLabel;
  final bool isDense;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final bool withSign;

  @override
  State<IntFieldBase> createState() => _IntFieldBaseState();
}

class _IntFieldBaseState extends State<IntFieldBase> {
  late TextEditingController controller;
  late int intVal;
  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  void _updateText() {
    setState(() {
      controller.text = widget.withSign
          ? intVal.toStringWithSign()
          : intVal.toString();
    });
  }

  void _valueChanged() {
    var value = int.tryParse(controller.text);
    if (value == null) {
      _updateText();
      return;
    }

    if (value == intVal) {
      return;
    }

    intVal = value;
    _updateText();
    widget.valueChanged(intVal);
  }

  void _handleFocusChanged() {
    if (!_effectiveFocusNode.hasFocus) {
      _valueChanged();
    }
  }

  @override
  void initState() {
    intVal = widget.value;
    controller = TextEditingController(
      text: widget.withSign ? intVal.toStringWithSign() : intVal.toString(),
    );

    _effectiveFocusNode.addListener(_handleFocusChanged);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant IntFieldBase oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_handleFocusChanged);
      (widget.focusNode ?? _focusNode)?.addListener(_handleFocusChanged);
    }

    if (widget.value != intVal && !_effectiveFocusNode.hasFocus) {
      intVal = widget.value;
      _updateText();
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
      keyboardType: TextInputType.numberWithOptions(
        signed: true,
        decimal: false,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\-+\.]')),
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
