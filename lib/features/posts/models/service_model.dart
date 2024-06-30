import 'package:json_annotation/json_annotation.dart';
import 'package:lets_buy/features/auth/models/user_model.dart';

import 'category_model.dart';
import 'type_model.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  final int id;
  final String name;
  final int typeId;
  final int categoryId;
  final String? image;
  final String description;
  final String createdAt;
  final String updatedAt;
  final int userId;
  final String location;
  final int searchValue;
  final double price;
  final bool isFavorite;
  final TypeModel type;
  final Category category;
  final UserModel user;

  ServiceModel({
    required this.id,
    required this.name,
    required this.typeId,
    required this.categoryId,
    required this.image,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.location,
    required this.price,
    required this.searchValue,
    required this.isFavorite,
    required this.type,
    required this.category,
    required this.user,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
