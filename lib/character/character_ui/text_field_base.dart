import 'package:flutter/material.dart';

class TextFieldBase extends StatefulWidget {
  const TextFieldBase({
    super.key,
    required this.label,
    required this.value,
    required this.valueChanged,
    this.outlined = true,
    this.textAlign = TextAlign.left,
  });

  final String label;
  final String value;
  final Function(String val) valueChanged;
  final bool outlined;
  final TextAlign textAlign;

  @override
  State<TextFieldBase> createState() => _TextFieldBaseState();
}

class _TextFieldBaseState extends State<TextFieldBase> {
  late TextEditingController controller;
  late String textValue;
  FocusNode focusNode = FocusNode();

  void _valueChanged() {
    if (textValue == controller.text) {
      return;
    }

    textValue = controller.text;
    widget.valueChanged(textValue);
  }

  @override
  void initState() {
    textValue = widget.value;
    controller = TextEditingController(text: textValue);

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        _valueChanged();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: () {
        focusNode.unfocus();
        _valueChanged();
      },
      textAlign: widget.textAlign,
      decoration: InputDecoration(
        border: widget.outlined ? OutlineInputBorder() : InputBorder.none,
        labelText: widget.outlined ? widget.label : null,
        hintText: widget.label,
      ),
      focusNode: focusNode,
    );
  }
}
