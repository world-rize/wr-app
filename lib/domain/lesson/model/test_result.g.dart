// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResult _$TestResultFromJson(Map json) {
  return TestResult(
    sectionId: json['sectionId'] as String,
    score: json['score'] as int,
    date: json['date'] as String,
  );
}

Map<String, dynamic> _$TestResultToJson(TestResult instance) =>
    <String, dynamic>{
      'sectionId': instance.sectionId,
      'score': instance.score,
      'date': instance.date,
    };
