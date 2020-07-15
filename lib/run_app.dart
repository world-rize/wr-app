// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:contentful/client.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/domain/article/index.dart';
import 'package:wr_app/domain/auth/index.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/ui/app.dart';
import 'package:wr_app/util/flavor.dart';
import 'package:wr_app/util/logger.dart';

Future<void> runAppWithFlavor(final Flavor flavor) async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  // firebase analytics
  final analytics = FirebaseAnalytics();
  final analyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);
  InAppLogger.log('🔥 FirebaseAnalytics Initialized');

  // pub spec
  final pubSpec = await PackageInfo.fromPlatform();
  InAppLogger.log('📄 Load pubspec.yml');
  InAppLogger.log('\t${pubSpec.appName} ${pubSpec.version}');

  // shared preferences
  final pref = await SharedPreferences.getInstance();
  InAppLogger.log('🔥 SharedPreferences Initialized');

  // dotenv
  await DotEnv().load('.env/.env');
  InAppLogger.log('🔥 DotEnv Initialized');

  // contentful client
  final env = DotEnv().env;
  final client = Client(env['CONTENTFUL_SPACE_ID'], env['CONTENTFUL_TOKEN']);
  InAppLogger.log('🔥 Contentful Initialized');

  // admob
  await FirebaseAdMob.instance.initialize(appId: env['ADMOB_APP_ID']);
  InAppLogger.log('🔥 Admob Initialized');

  const useMock = true;

  // repos
  final userRepository = useMock ? UserMockRepository() : UserRepository();
  final articleRepository =
      useMock ? ArticleMockRepository() : ArticleRepository();
  final lessonRepository =
      useMock ? LessonMockRepository() : LessonRepository();
  final authRepository = useMock ? AuthMockRepository() : AuthRepository();
  final systemRepository = SystemRepository();

  // services
  final userService = UserService(
      authRepository: authRepository, userRepository: userRepository);
  final articleService = ArticleService(articleRepository: articleRepository);
  final lessonService = LessonService(lessonRepository: lessonRepository);
  final systemService = SystemService(systemRepository: systemRepository);

  // アプリ全体にストアを Provide する
  runApp(MultiProvider(
    providers: [
      // Firebase Analytics
      // TODO(someone): create Analytics Store
      Provider.value(value: analytics),
      Provider.value(value: analyticsObserver),
      // system
      Provider.value(
        value: SystemNotifier(
            systemService: systemService, flavor: flavor, pubSpec: pubSpec),
      ),
      // ユーザーデータ
      ChangeNotifierProvider.value(value: UserNotifier(service: userService)),
      // Lesson
      ChangeNotifierProvider.value(
          value: LessonNotifier(
              userService: userService, lessonService: lessonService)),
      // 設定
      ChangeNotifierProvider.value(value: PreferenceNotifier(pref: pref)),
      // Article
      ChangeNotifierProvider.value(
          value:
              ArticleNotifier(client: client, articleService: articleService)),
    ],
    child: WRApp(),
  ));
}
