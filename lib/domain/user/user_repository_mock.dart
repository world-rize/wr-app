// Copyright © 2020 WorldRIZe. All rights reserved.
import 'dart:async';

import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';
import 'package:wr_app/domain/user/user_repository.dart';

class UserMockRepository implements IUserRepository {
  @override
  Future<TestResponse> test(TestRequestDto req) async {
    return TestResponse(success: true);
  }

  @override
  Future<ReadUserResponseDto> readUser(ReadUserRequestDto req) async {
    return ReadUserResponseDto(user: User.dummy());
  }

  @override
  Future<CreateUserResponseDto> createUser(CreateUserRequestDto req) async {
    return CreateUserResponseDto(user: User.dummy());
  }

  @override
  Future<UpdateUserResponseDto> updateUser(UpdateUserRequestDto req) async {
    return UpdateUserResponseDto(success: true);
  }

  @override
  Future<FavoritePhraseResponseDto> favoritePhrase(
      FavoritePhraseRequestDto req) async {
    return FavoritePhraseResponseDto(success: true);
  }

  @override
  Future<GetPointResponseDto> getPoint(GetPointRequestDto req) async {
    return GetPointResponseDto(success: true);
  }

  @override
  Future<DoTestResponseDto> doTest(DoTestRequestDto req) async {
    return DoTestResponseDto(success: true);
  }

  @override
  Future<DeleteUserResponseDto> deleteUser(DeleteUserRequestDto req) async {
    return DeleteUserResponseDto(success: true);
  }
}
