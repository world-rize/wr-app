// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:wr_app/domain/user/user_api_dto.dart';

abstract class IUserRepository {
  Future<TestResponse> test(TestRequestDto req);

  Future<ReadUserResponseDto> readUser(ReadUserRequestDto req);

  Future<CreateUserResponseDto> createUser(CreateUserRequestDto req);

  Future<FavoritePhraseResponseDto> favoritePhrase(
      FavoritePhraseRequestDto req);

  Future<GetPointResponseDto> getPoint(GetPointRequestDto req);

  Future<DoTestResponseDto> doTest(DoTestRequestDto req);
}

class UserRepository implements IUserRepository {
  @override
  Future<TestResponse> test(TestRequestDto req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'test')
          ..timeout = const Duration(seconds: 10);

    // dynamic -> Map<String, dynamic> -> Response
    return callable.call({}).then(
        (res) => TestResponse.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<ReadUserResponseDto> readUser(ReadUserRequestDto req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'readUser')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req).then((res) =>
        ReadUserResponseDto.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<CreateUserResponseDto> createUser(CreateUserRequestDto req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'createUser')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req).then((res) =>
        CreateUserResponseDto.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<FavoritePhraseResponseDto> favoritePhrase(
      FavoritePhraseRequestDto req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'favoritePhrase')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req).then((res) => FavoritePhraseResponseDto.fromJson(
        Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<GetPointResponseDto> getPoint(GetPointRequestDto req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'getPoint')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req).then((res) =>
        GetPointResponseDto.fromJson(Map<String, dynamic>.from(res.data)));
  }

  @override
  Future<DoTestResponseDto> doTest(DoTestRequestDto req) {
    final callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'doTest')
          ..timeout = const Duration(seconds: 10);

    return callable.call(req).then((res) =>
        DoTestResponseDto.fromJson(Map<String, dynamic>.from(res.data)));
  }
}
