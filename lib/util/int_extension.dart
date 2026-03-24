extension IntExtension on int {
  String toStringWithSign() => this >= 0 ? "+$this" : toString();
}
