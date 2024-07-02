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
  final String? createdAt;
  final String? updatedAt;
  final int userId;
  final String location;
  final num price;
  final int? searchValue;
  final bool? isFavorite;
  final TypeModel type;
  final Category category;
  final UserModel user;
  
  final String? imageUrl;

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
      this.imageUrl
  });

  ServiceModel copyWith({
    int? id,
    String? name,
    int? typeId,
    int? categoryId,
    String? image,
    String? description,
    String? createdAt,
    String? updatedAt,
    int? userId,
    String? location,
    num? price,
    int? searchValue,
    bool? isFavorite,
    TypeModel? type,
    Category? category,
    UserModel? user,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      typeId: typeId ?? this.typeId,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      location: location ?? this.location,
      price: price ?? this.price,
      searchValue: searchValue ?? this.searchValue,
      isFavorite: isFavorite ?? this.isFavorite,
      type: type ?? this.type,
      category: category ?? this.category,
      user: user ?? this.user,
    );
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
