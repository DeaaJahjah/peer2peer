import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category {
  int id;
  String name;
  String createdAt;
  String updatedAt;

  Category({required this.id, required this.name, required this.createdAt, required this.updatedAt});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
