// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      resultsCount: json['results_count'] as int,
      content: (json['content'] as List<dynamic>).map((e) => ServiceModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'results_count': instance.resultsCount,
      'content': instance.content.map((e) => e.toJson()).toList(),
    };
