import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/datamodel/5e/data/feature/entry.dart';

class EntryAbilityStatView extends StatelessWidget {
  const EntryAbilityStatView({
    super.key,
    required this.entry,
  });

  final FeatureEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${entry.name ?? ""}${entry.type == FeatureEntryType.abilityDc ? " save DC" : entry.type == FeatureEntryType.abilityAttackMod ? " attack modifier" : ""}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("${entry.type == FeatureEntryType.abilityDc ? " = 8" : ""}${entry.attributes?.map((x) => " + ${x.name} modifier").join()} + Proficiency Bonus"),
            ],
          ),
        ],
      ),
    );
  }
}
