// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserStatistics _$UserStatisticsFromJson(Map json) {
  return UserStatistics(
    testScores: (json['testScores'] as Map)?.map(
      (k, e) => MapEntry(k as String, e as String),
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

UserAttributes _$UserAttributesFromJson(Map json) {
  return UserAttributes(
    age: json['age'] as String,
    email: json['email'] as String,
    membership: _$enumDecodeNullable(_$MembershipEnumMap, json['membership']),
  );
}

Map<String, dynamic> _$UserAttributesToJson(UserAttributes instance) =>
    <String, dynamic>{
      'age': instance.age,
      'email': instance.email,
      'membership': _$MembershipEnumMap[instance.membership],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MembershipEnumMap = {
  Membership.normal: 'normal',
  Membership.pro: 'pro',
};

FavoritePhraseDigest _$FavoritePhraseDigestFromJson(Map json) {
  return FavoritePhraseDigest(
    id: json['id'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$FavoritePhraseDigestToJson(
        FavoritePhraseDigest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

FavoritePhraseList _$FavoritePhraseListFromJson(Map json) {
  return FavoritePhraseList(
    id: json['id'] as String,
    title: json['title'] as String,
    sortType: json['sortType'] as String,
    isDefault: json['isDefault'] as bool,
    favoritePhraseIds: (json['favoritePhraseIds'] as Map)?.map(
      (k, e) => MapEntry(
          k as String,
          e == null
              ? null
              : FavoritePhraseDigest.fromJson((e as Map)?.map(
                  (k, e) => MapEntry(k as String, e),
                ))),
    ),
  );
}

Map<String, dynamic> _$FavoritePhraseListToJson(FavoritePhraseList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sortType': instance.sortType,
      'isDefault': instance.isDefault,
      'favoritePhraseIds':
          instance.favoritePhraseIds?.map((k, e) => MapEntry(k, e?.toJson())),
    };

PhraseList _$PhraseListFromJson(Map json) {
  return PhraseList(
    id: json['id'] as String,
    title: json['title'] as String,
    sortType: json['sortType'] as String,
    isDefault: json['isDefault'] as bool,
    phrases: (json['phrases'] as Map)?.map(
      (k, e) => MapEntry(
          k as String,
          e == null
              ? null
              : Phrase.fromJson((e as Map)?.map(
                  (k, e) => MapEntry(k as String, e),
                ))),
    ),
  );
}

Map<String, dynamic> _$PhraseListToJson(PhraseList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sortType': instance.sortType,
      'isDefault': instance.isDefault,
      'phrases': instance.phrases?.map((k, e) => MapEntry(k, e?.toJson())),
    };

User _$UserFromJson(Map json) {
  return User(
    uuid: json['uuid'] as String,
    name: json['name'] as String,
    userId: json['userId'] as String,
    favorites: (json['favorites'] as Map)?.map(
      (k, e) => MapEntry(
          k as String,
          e == null
              ? null
              : FavoritePhraseList.fromJson((e as Map)?.map(
                  (k, e) => MapEntry(k as String, e),
                ))),
    ),
    notes: (json['notes'] as Map)?.map(
      (k, e) => MapEntry(
          k as String,
          e == null
              ? null
              : PhraseList.fromJson((e as Map)?.map(
                  (k, e) => MapEntry(k as String, e),
                ))),
    ),
    statistics: json['statistics'] == null
        ? null
        : UserStatistics.fromJson((json['statistics'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    activities: (json['activities'] as List)
        ?.map((e) => e == null
            ? null
            : UserActivity.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
    attributes: json['attributes'] == null
        ? null
        : UserAttributes.fromJson((json['attributes'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'userId': instance.userId,
      'favorites': instance.favorites?.map((k, e) => MapEntry(k, e?.toJson())),
      'notes': instance.notes?.map((k, e) => MapEntry(k, e?.toJson())),
      'statistics': instance.statistics?.toJson(),
      'attributes': instance.attributes?.toJson(),
      'activities': instance.activities?.map((e) => e?.toJson())?.toList(),
    };
