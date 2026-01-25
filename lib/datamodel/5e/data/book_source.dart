import 'package:json_annotation/json_annotation.dart';

part 'book_source.g.dart';

@JsonSerializable(explicitToJson: true)
class BookSource {
  BookSource({
    required this.source,
    required this.page,
  });

  String source;
  int? page;

  factory BookSource.fromJson(Map<String, dynamic> json) => _$BookSourceFromJson(json);

  Map<String, dynamic> toJson() => _$BookSourceToJson(this);
}
