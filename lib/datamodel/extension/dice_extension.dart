import 'package:collection/collection.dart';
import 'package:ttrpg_character_tools/datamodel/generated/dice.pb.dart';
import 'package:render_ttrpg_data/datamodel/5e/data/dice.dart' as dice_5e;

extension DiceExtension on Dice {
  dice_5e.Dice toDice5e() {
    return dice_5e.Dice(number: qty, faces: faces);
  }

  String toDiceString() {
    return '${qty}d$faces';
  }

  static Dice? fromString(String diceString) {
    diceString = diceString.replaceAll(" ", "");
    var match = RegExp(r'(\d*)d(\d+)').firstMatch(diceString);
    if (match != null && match.groupCount == 2) {
      var qty = int.tryParse(match.group(1) ?? '1') ?? 1;
      var faces = int.tryParse(match.group(2) ?? '-1');
      if (faces != null && faces > 0 && qty > 0) {
        return Dice(qty: qty, faces: faces);
      }
    }
    return null;
  }
}

extension DiceListExtension on Iterable<Dice> {
  Iterable<Dice> combine() {
    Map<int, Dice> combined = {};
    for (var die in this) {
      if (combined.containsKey(die.faces)) {
        combined[die.faces] = Dice(
          qty: combined[die.faces]!.qty + die.qty,
          faces: die.faces,
        );
      } else {
        combined[die.faces] = Dice(qty: die.qty, faces: die.faces);
      }
    }
    return combined.values;
  }

  String toDiceString() {
    return combine()
        .sortedBy((x) => x.faces)
        .map((d) => d.toDiceString())
        .join(' + ');
  }

  static List<Dice> fromString(String diceString) {
    List<Dice> dice = [];

    for (var part in diceString.split(RegExp(r'[+ ]'))) {
      if (part.isEmpty) {
        continue;
      }
      var die = DiceExtension.fromString(part);
      if (die != null) {
        dice.add(die);
      }
    }

    return dice.combine().toList();
  }
}

extension DiceExtension5e on dice_5e.Dice {
  Dice toDiceProto() {
    return Dice(qty: number, faces: faces);
  }
}
