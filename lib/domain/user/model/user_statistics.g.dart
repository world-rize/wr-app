// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatistics _$UserStatisticsFromJson(Map json) {
  return UserStatistics(
    testResults: (json['testResults'] as List)
        ?.map((e) => e == null ? null : TestResult.fromJson(e as Map))
        ?.toList(),
    points: json['points'] as int,
    testLimitCount: json['testLimitCount'] as int,
    lastLogin: json['lastLogin'] as String,
    isIntroducedFriend: json['isIntroducedFriend'] as bool,
  );
}

Map<String, dynamic> _$UserStatisticsToJson(UserStatistics instance) =>
    <String, dynamic>{
      'testResults': instance.testResults?.map((e) => e?.toJson())?.toList(),
      'points': instance.points,
      'testLimitCount': instance.testLimitCount,
      'lastLogin': instance.lastLogin,
      'isIntroducedFriend': instance.isIntroducedFriend,
    };
