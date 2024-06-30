import 'package:json_annotation/json_annotation.dart';
import 'package:lets_buy/features/posts/models/service_model.dart';

part 'result_model.g.dart';

@JsonSerializable()
class Result {
  int resultsCount;
  List<ServiceModel> content;

  Result({required this.resultsCount, required this.content});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
