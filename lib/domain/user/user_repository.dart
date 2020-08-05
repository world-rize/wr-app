// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/user/model/user_api_dto.dart';

abstract class UserRepository {
  Future<TestResponse> test(TestRequestDto req);

  Future<ReadUserResponseDto> readUser(ReadUserRequestDto req);

  Future<CreateUserResponseDto> createUser(CreateUserRequestDto req);

  Future<UpdateUserResponseDto> updateUser(UpdateUserRequestDto req);

  Future<DeleteUserResponseDto> deleteUser(DeleteUserRequestDto req);

  Future<FavoritePhraseResponseDto> favoritePhrase(
      FavoritePhraseRequestDto req);

  Future<GetPointResponseDto> getPoint(GetPointRequestDto req);

  Future<DoTestResponseDto> doTest(DoTestRequestDto req);
}
