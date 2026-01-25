import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/feature/entry.dart';
import 'package:ttrpg_character_tools/theme/text_styles.dart';

class TableView extends StatelessWidget {
  const TableView({
    super.key,
    required this.entry,
  });

  final FeatureEntry entry;

  @override
  Widget build(BuildContext context) {
    var foregroundColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          entry.caption ?? "",
          style: TextStyles.withAlpha(TextStyles.of(context).headline3, 150),
        ),
        const Gap(2.0),
        if (entry.colLabels != null && entry.rows != null)
          Table(
            children: [
              TableRow(
                children: [
                  for (var header in entry.colLabels!)
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                        child: Text(
                          header,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              for (var (index, row) in entry.rows!.indexed)
                TableRow(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? foregroundColor.withAlpha(30) : null,
                  ),
                  children: [
                    for (var cell in row)
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                          child: Text(
                            cell,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                )
            ],
          ),
      ],
    );
  }
}
