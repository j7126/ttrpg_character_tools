import 'package:flutter/material.dart';

class WrapColumns extends StatelessWidget {
  const WrapColumns({
    super.key,
    required this.minWidth,
    required this.children,
    this.spacing = 0,
    this.runSpacing = 0,
    this.columnCrossAxisAlignment = CrossAxisAlignment.start,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
  });

  final double minWidth;
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final CrossAxisAlignment columnCrossAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        var numColumns = (constraints.maxWidth / minWidth).floor();
        if (children.length < numColumns) {
          numColumns = children.length;
        }
        var colWidth =
            (constraints.maxWidth - spacing * (numColumns - 1)) / numColumns;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: columnCrossAxisAlignment,
          spacing: runSpacing,
          children: [
            for (var i = 0; i < children.length;)
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: rowCrossAxisAlignment,
                spacing: spacing,
                children: [
                  for (
                    var j = 0;
                    j < numColumns && i < children.length;
                    i++, j++
                  )
                    SizedBox(width: colWidth, child: children[i]),
                ],
              ),
          ],
        );
      }),
    );
  }
}
