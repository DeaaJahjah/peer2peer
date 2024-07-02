// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as int?,
    name: json['name'] as String,
    email: json['email'] as String,
    bio: json['bio'] as String?,
    phoneNumber: json['phone'] as String,
    imgUrl: json['avatar'] as String?,
    imageUrl: json['image_url'] as String?,
    fcmUserId: json['fcm_user_id'] as String?);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'bio': instance.bio,
      'phone_number': instance.phoneNumber,
      'img_url': instance.imgUrl,
      'fcm_user_id': instance.fcmUserId,
      'image_url': instance.imageUrl
    };
