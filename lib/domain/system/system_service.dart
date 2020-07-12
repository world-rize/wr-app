// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/system/system_repository.dart';

class SystemService {
  final SystemRepository _systemRepository;

  const SystemService({
    @required SystemRepository systemRepository,
  }) : _systemRepository = systemRepository;
}
