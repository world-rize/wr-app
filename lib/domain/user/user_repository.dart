// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';

abstract class UserRepository {
  Future<void> test();

  Future<User> readUser();

  Future<User> createUser(CreateUserRequest req);

  Future<User> updateUser(User user);

  Future<void> deleteUser();

  Future<void> favoritePhrase(FavoritePhraseRequest req);

  Future<void> getPoint(GetPointRequest req);

  Future<void> doTest(DoTestRequest req);

  Future<void> createFavoriteList(CreateFavoriteListRequest req);

  Future<void> deleteFavoriteList(DeleteFavoriteListRequest req);

  Future<void> createPhrasesList(CreatePhrasesListRequest req);

  Future<void> addPhraseToPhraseList(AddPhraseToPhraseListRequest req);

  Future<void> sendTestResult(SendTestResultRequest req);
}
