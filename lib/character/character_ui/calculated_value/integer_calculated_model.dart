
class IntegerCalculatedModel {
  const IntegerCalculatedModel({
    required this.value,
    required this.name,
    this.children = const [],
  });

  final int value;
  final String name;
  final List<IntegerCalculatedModel> children;
}
