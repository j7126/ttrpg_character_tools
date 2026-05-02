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
    this.isCalculated = false,
    this.isOverridden = false,
    this.resetValue,
    this.emptyIsZero = false,
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
  final bool isCalculated;
  final bool isOverridden;
  final Function()? resetValue;
  final bool emptyIsZero;

  @override
  State<IntFieldBase> createState() => _IntFieldBaseState();
}

class _IntFieldBaseState extends State<IntFieldBase> {
  late TextEditingController controller;
  late int intVal;
  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());
  bool showingConfirmOverrideDialog = false;

  void _updateText() {
    setState(() {
      controller.text = widget.withSign
          ? intVal.toStringWithSign()
          : intVal.toString();
    });
  }

  void _valueChanged() async {
    if (showingConfirmOverrideDialog) {
      return;
    }

    var value = controller.text.isEmpty && widget.emptyIsZero
        ? 0
        : int.tryParse(controller.text);
    if (value == null) {
      _updateText();
      return;
    }

    if (value == intVal) {
      return;
    }

    if (widget.isCalculated) {
      showingConfirmOverrideDialog = true;
      var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Override Field"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("This will override the calculated value."),
                Text("Are you sure you want to do this?"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No"),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Yes"),
              ),
            ],
          );
        },
      );
      showingConfirmOverrideDialog = false;
      if (result != true) {
        _updateText();
        return;
      }
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
        suffixIcon: widget.isOverridden
            ? Tooltip(
                message: "This field is overriden",
                child: IconButton(
                  onPressed: widget.resetValue == null
                      ? null
                      : () async {
                          var result = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Reset Field"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "This will reset the field to the calculated value.",
                                    ),
                                    Text("Are you sure you want to do this?"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text("No"),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text("Yes"),
                                  ),
                                ],
                              );
                            },
                          );
                          if (result != true) {
                            return;
                          }

                          widget.resetValue?.call();
                        },
                  icon: Icon(
                    Icons.replay,
                    color: ColorScheme.of(context).tertiary,
                  ),
                ),
              )
            : null,
      ),
      focusNode: _effectiveFocusNode,
      style: widget.textStyle,
    );
  }
}
