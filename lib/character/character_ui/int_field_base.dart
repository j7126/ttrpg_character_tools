import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntFieldBase extends StatefulWidget {
  const IntFieldBase({
    super.key,
    required this.label,
    required this.value,
    required this.valueChanged,
    this.outlined = true,
    this.textAlign = TextAlign.center,
  });

  final String label;
  final int value;
  final Function(int val) valueChanged;
  final bool outlined;
  final TextAlign textAlign;

  @override
  State<IntFieldBase> createState() => _IntFieldBaseState();
}

class _IntFieldBaseState extends State<IntFieldBase> {
  late TextEditingController controller;
  late int intVal;
  FocusNode focusNode = FocusNode();

  void _valueChanged() {
    var value = int.tryParse(controller.text);
    if (value == null) {
      setState(() {
        controller.text = intVal.toString();
      });
      return;
    }

    if (value == intVal) {
      return;
    }

    intVal = value;
    widget.valueChanged(intVal);
  }

  @override
  void initState() {
    intVal = widget.value;
    controller = TextEditingController(text: intVal.toString());

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
      keyboardType: TextInputType.numberWithOptions(
        signed: true,
        decimal: false,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9\-+\.]')),
      ],
      decoration: InputDecoration(
        border: widget.outlined ? OutlineInputBorder() : InputBorder.none,
        labelText: widget.outlined ? widget.label : null,
        hintText: widget.label,
      ),
      focusNode: focusNode,
    );
  }
}
