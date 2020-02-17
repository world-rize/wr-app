// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/foundation.dart';
import 'package:wr_app/model/phrase.dart';
import 'package:wr_app/store/masterdata.dart';

class UserStore with ChangeNotifier {
  Phrase pickedUpFavoritePhrase = MasterDataStore.dummyPhrase();
  Phrase pickedUpNewComingPhrase = MasterDataStore.dummyPhrase();

  UserStore();
}
