// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wr_app/domain/lesson/index.dart';

part 'user_api_dto.g.dart';

// XXXRequestDto
// XXXResponseDto

// reason of `@JsonSerializable(explicitToJson: true, anyMap: true)`
// see https://stackoverflow.com/questions/58741971/casterror-type-internallinkedhashmapdynamic-dynamic-is-not-a-subtype-of

@JsonSerializable(explicitToJson: true, anyMap: true)
class DoTestRequest {
  DoTestRequest({
    @required this.sectionId,
  });

  factory DoTestRequest.fromJson(Map<String, dynamic> json) =>
      _$DoTestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DoTestRequestToJson(this);

  String sectionId;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class CreateUserRequest {
  CreateUserRequest({
    @required this.name,
    @required this.email,
    @required this.age,
  });

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);

  String name;

  String email;

  String age;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class FavoritePhraseRequest {
  FavoritePhraseRequest({
    @required this.phraseId,
    @required this.listId,
    @required this.favorite,
  });

  factory FavoritePhraseRequest.fromJson(Map<String, dynamic> json) =>
      _$FavoritePhraseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritePhraseRequestToJson(this);

  String phraseId;
  String listId;
  bool favorite;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class GetPointRequest {
  GetPointRequest({
    @required this.points,
  });

  factory GetPointRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPointRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPointRequestToJson(this);

  int points;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class CreateFavoriteListRequest {
  CreateFavoriteListRequest({
    @required this.name,
  });

  factory CreateFavoriteListRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateFavoriteListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateFavoriteListRequestToJson(this);

  String name;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class DeleteFavoriteListRequest {
  DeleteFavoriteListRequest({
    @required this.listId,
  });

  factory DeleteFavoriteListRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteFavoriteListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteFavoriteListRequestToJson(this);

  String listId;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class CreatePhrasesListRequest {
  CreatePhrasesListRequest({
    @required this.title,
  });

  factory CreatePhrasesListRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePhrasesListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePhrasesListRequestToJson(this);

  String title;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class UpdatePhraseRequest {
  UpdatePhraseRequest({
    @required this.listId,
    @required this.phraseId,
    @required this.phrase,
  });

  factory UpdatePhraseRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePhraseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePhraseRequestToJson(this);

  String listId;

  String phraseId;

  Phrase phrase;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class AddPhraseToPhraseListRequest {
  AddPhraseToPhraseListRequest({
    @required this.listId,
    @required this.phrase,
  });

  factory AddPhraseToPhraseListRequest.fromJson(Map<String, dynamic> json) =>
      _$AddPhraseToPhraseListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddPhraseToPhraseListRequestToJson(this);

  String listId;

  Phrase phrase;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class DeletePhraseRequest {
  DeletePhraseRequest({
    @required this.listId,
    @required this.phraseId,
  });

  factory DeletePhraseRequest.fromJson(Map<String, dynamic> json) =>
      _$DeletePhraseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePhraseRequestToJson(this);

  String listId;

  String phraseId;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class SendTestResultRequest {
  SendTestResultRequest({
    @required this.sectionId,
    @required this.score,
  });

  factory SendTestResultRequest.fromJson(Map<String, dynamic> json) =>
      _$SendTestResultRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendTestResultRequestToJson(this);

  String sectionId;

  int score;
}
