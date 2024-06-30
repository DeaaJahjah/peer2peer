import 'package:json_annotation/json_annotation.dart';

part  'type_model.g.dart';
@JsonSerializable()
class TypeModel {
  int id;
  String createdAt;
  String updatedAt;
  String name;

  TypeModel({required this.id, required this.createdAt, required this.updatedAt, required this.name});

  factory TypeModel.fromJson(Map<String, dynamic> json) => _$TypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TypeModelToJson(this);
}
