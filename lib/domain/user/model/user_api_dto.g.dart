// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoTestRequest _$DoTestRequestFromJson(Map json) {
  return DoTestRequest(
    sectionId: json['sectionId'] as String,
  );
}

Map<String, dynamic> _$DoTestRequestToJson(DoTestRequest instance) =>
    <String, dynamic>{
      'sectionId': instance.sectionId,
    };

CreateUserRequest _$CreateUserRequestFromJson(Map json) {
  return CreateUserRequest(
    name: json['name'] as String,
    email: json['email'] as String,
    age: json['age'] as String,
  );
}

Map<String, dynamic> _$CreateUserRequestToJson(CreateUserRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'age': instance.age,
    };

FavoritePhraseRequest _$FavoritePhraseRequestFromJson(Map json) {
  return FavoritePhraseRequest(
    phraseId: json['phraseId'] as String,
    listId: json['listId'] as String,
    favorite: json['favorite'] as bool,
  );
}

Map<String, dynamic> _$FavoritePhraseRequestToJson(
        FavoritePhraseRequest instance) =>
    <String, dynamic>{
      'phraseId': instance.phraseId,
      'listId': instance.listId,
      'favorite': instance.favorite,
    };

GetPointRequest _$GetPointRequestFromJson(Map json) {
  return GetPointRequest(
    points: json['points'] as int,
  );
}

Map<String, dynamic> _$GetPointRequestToJson(GetPointRequest instance) =>
    <String, dynamic>{
      'points': instance.points,
    };

CreateFavoriteListRequest _$CreateFavoriteListRequestFromJson(Map json) {
  return CreateFavoriteListRequest(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CreateFavoriteListRequestToJson(
        CreateFavoriteListRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

DeleteFavoriteListRequest _$DeleteFavoriteListRequestFromJson(Map json) {
  return DeleteFavoriteListRequest(
    listId: json['listId'] as String,
  );
}

Map<String, dynamic> _$DeleteFavoriteListRequestToJson(
        DeleteFavoriteListRequest instance) =>
    <String, dynamic>{
      'listId': instance.listId,
    };

CreatePhrasesListRequest _$CreatePhrasesListRequestFromJson(Map json) {
  return CreatePhrasesListRequest(
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$CreatePhrasesListRequestToJson(
        CreatePhrasesListRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
    };

UpdatePhraseRequest _$UpdatePhraseRequestFromJson(Map json) {
  return UpdatePhraseRequest(
    listId: json['listId'] as String,
    phraseId: json['phraseId'] as String,
    phrase:
        json['phrase'] == null ? null : Phrase.fromJson(json['phrase'] as Map),
  );
}

Map<String, dynamic> _$UpdatePhraseRequestToJson(
        UpdatePhraseRequest instance) =>
    <String, dynamic>{
      'listId': instance.listId,
      'phraseId': instance.phraseId,
      'phrase': instance.phrase?.toJson(),
    };

AddPhraseToPhraseListRequest _$AddPhraseToPhraseListRequestFromJson(Map json) {
  return AddPhraseToPhraseListRequest(
    listId: json['listId'] as String,
    phrase:
        json['phrase'] == null ? null : Phrase.fromJson(json['phrase'] as Map),
  );
}

Map<String, dynamic> _$AddPhraseToPhraseListRequestToJson(
        AddPhraseToPhraseListRequest instance) =>
    <String, dynamic>{
      'listId': instance.listId,
      'phrase': instance.phrase?.toJson(),
    };

DeletePhraseRequest _$DeletePhraseRequestFromJson(Map json) {
  return DeletePhraseRequest(
    listId: json['listId'] as String,
    phraseId: json['phraseId'] as String,
  );
}

Map<String, dynamic> _$DeletePhraseRequestToJson(
        DeletePhraseRequest instance) =>
    <String, dynamic>{
      'listId': instance.listId,
      'phraseId': instance.phraseId,
    };

SendTestResultRequest _$SendTestResultRequestFromJson(Map json) {
  return SendTestResultRequest(
    sectionId: json['sectionId'] as String,
    score: json['score'] as int,
  );
}

Map<String, dynamic> _$SendTestResultRequestToJson(
        SendTestResultRequest instance) =>
    <String, dynamic>{
      'sectionId': instance.sectionId,
      'score': instance.score,
    };

ReadUserFromUserIdRequest _$ReadUserFromUserIdRequestFromJson(Map json) {
  return ReadUserFromUserIdRequest(
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$ReadUserFromUserIdRequestToJson(
        ReadUserFromUserIdRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
    };
