class DataLoadError {
  const DataLoadError({
    required this.itemType,
    required this.itemName,
    required this.filePath,
    required this.error,
  });

  final String itemType;
  final String itemName;
  final String filePath;
  final String error;
}
