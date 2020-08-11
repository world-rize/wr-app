// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/domain/user/model/user_api_dto.dart';

abstract class UserRepository {
  Future<void> test();

  Future<User> readUser();

  Future<User> createUser(CreateUserRequest req);

  Future<User> updateUser(User user);

  Future<void> deleteUser();

  Future<User> favoritePhrase(FavoritePhraseRequest req);

  Future<User> getPoint(GetPointRequest req);

  Future<User> doTest(DoTestRequest req);

  Future<User> createFavoriteList(CreateFavoriteListRequest req);

  Future<User> deleteFavoriteList(DeleteFavoriteListRequest req);

  Future<User> createPhrasesList(CreatePhrasesListRequest req);

  Future<User> addPhraseToPhraseList(AddPhraseToPhraseListRequest req);

  Future<User> sendTestResult(SendTestResultRequest req);
}
