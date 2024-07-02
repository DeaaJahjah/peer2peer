import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int? id;
  final String name;
  final String email;
  final String? bio;
  @JsonKey(name: 'phone')
  final String phoneNumber;
  @JsonKey(name: 'avatar')
  final String? imgUrl;
  @JsonKey(name: 'fcm_user_id')
  final String? fcmUserId;
  final String? imageUrl;


  UserModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.bio,
    required this.imgUrl,
    this.fcmUserId,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  // factory UserModel.fromFirestore(DocumentSnapshot documentSnapshot) {
  //   UserModel userModel = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

  //   userModel.id = documentSnapshot.id;
  //   return userModel;
  // }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
