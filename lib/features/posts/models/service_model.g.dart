// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ContentFromJson(Map<String, dynamic> json) => ServiceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      typeId: json['type_id'] as int,
      categoryId: json['category_id'] as int,
      image: json['image'] as String?,
      description: json['description'] as String,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userId: json['user_id'] as int,
      location: json['location'] as String,
      searchValue: json['search_value'] as int?,
      imageUrl: json['image_url'] as String?,
      price: json['price'] as num,
      isFavorite: json['is_favorite'] as bool?,
      type: TypeModel.fromJson(json['type'] as Map<String, dynamic>),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      user: UserModel.fromJson(
        json['user'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ContentToJson(ServiceModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type_id': instance.typeId,
      'category_id': instance.categoryId,
      'image': instance.image,
      'description': instance.description,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user_id': instance.userId,
      'location': instance.location,
      'search_value': instance.searchValue,
      'is_favorite': instance.isFavorite,
      'type': instance.type.toJson(),
      'category': instance.category.toJson(),
      'user': instance.user.toJson(),
      'price': instance.price,
      'image_url': instance.imageUrl,
    };
