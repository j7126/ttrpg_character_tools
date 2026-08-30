import 'package:flutter/material.dart';
import 'package:render_ttrpg_data/util/int_extension.dart';
import 'package:ttrpg_character_tools/character/character_ui/calculated_value/integer_calculated_model.dart';

class CalculatedModelView extends StatelessWidget {
  const CalculatedModelView({
    super.key,
    required this.model,
    this.showValueSign = false,
  });

  final IntegerCalculatedModel model;
  final bool showValueSign;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorScheme.of(context).primary.withAlpha(200),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${model.name} ", style: TextStyle(fontSize: 12)),
                Text(
                  showValueSign
                      ? model.value.toStringWithSign()
                      : model.value.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        if (model.children.isNotEmpty) ...[
          Text(" = (", style: TextStyle(fontSize: 18)),
          for (var (i, child) in model.children.indexed) ...[
            CalculatedModelView(model: child, showValueSign: showValueSign),
            if (i < model.children.length - 1)
              Text(" + ", style: TextStyle(fontSize: 18)),
          ],
          Text(")", style: TextStyle(fontSize: 18)),
        ],
      ],
    );
  }
}
