// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeModel _$TypeModelFromJson(Map<String, dynamic> json) => TypeModel(
      id: json['id'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$TypeModelToJson(TypeModel instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'name': instance.name,
    };
