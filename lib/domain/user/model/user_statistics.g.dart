// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatistics _$UserStatisticsFromJson(Map json) {
  return UserStatistics(
    testScores: (json['testScores'] as Map)?.map(
      (k, e) => MapEntry(k as String, e as int),
    ),
    points: json['points'] as int,
    testLimitCount: json['testLimitCount'] as int,
  );
}

Map<String, dynamic> _$UserStatisticsToJson(UserStatistics instance) =>
    <String, dynamic>{
      'testScores': instance.testScores,
      'points': instance.points,
      'testLimitCount': instance.testLimitCount,
    };
