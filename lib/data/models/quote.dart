import 'package:json_annotation/json_annotation.dart';
import 'barrel.dart';

part 'quote.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Quote implements BaseModel {
  final String? id, quote, author;
  final DateTime? createdTime, lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  Quote(
      {this.id,
        this.quote,
        this.author,
        this.createdTime,
        this.lastUpdatedTime});

  factory Quote.fromJson(Map<String, dynamic> json) =>
      _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}