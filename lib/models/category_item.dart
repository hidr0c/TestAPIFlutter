import 'package:json_annotation/json_annotation.dart';

part 'category_item.g.dart';

@JsonSerializable()
class CategoryItem {
  final String? name;

  CategoryItem({this.name});

  factory CategoryItem.fromJson(Map<String, dynamic> json) => _$CategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemToJson(this);
}
