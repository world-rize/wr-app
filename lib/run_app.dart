// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:contentful/client.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
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
import 'package:wr_app/util/notification.dart';

Future<void> runAppWithFlavor(final Flavor flavor) async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  await setupGlobalSingletons();

  final analytics = GetIt.I<FirebaseAnalytics>();
  final analyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);

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
      Provider.value(value: analyticsObserver),
      // system
      ChangeNotifierProvider.value(
        value: SystemNotifier(systemService: systemService, flavor: flavor),
      ),
      // ユーザーデータ
      ChangeNotifierProvider.value(
        value: UserNotifier(service: userService),
      ),
      // Lesson
      ChangeNotifierProvider.value(
        value: LessonNotifier(
          userService: userService,
          lessonService: lessonService,
        ),
      ),
      // Article
      ChangeNotifierProvider.value(
        value: ArticleNotifier(articleService: articleService),
      ),
    ],
    child: WRApp(),
  ));
}

Future<void> setupGlobalSingletons() async {
  // load .env
  await DotEnv().load('.env/.env');

  // firebase analytics
  final analytics = FirebaseAnalytics();
  GetIt.I.registerSingleton<FirebaseAnalytics>(analytics);
  InAppLogger.log('🔥 FirebaseAnalytics Initialized');

  // pub spec
  final pubSpec = await PackageInfo.fromPlatform();
  GetIt.I.registerSingleton<PackageInfo>(pubSpec);
  InAppLogger.log('📄 Load pubspec.yml');

  // shared preferences
  final pref = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(pref);
  InAppLogger.log('🔥 SharedPreferences Initialized');

  // contentful client
  final env = DotEnv().env;
  final client = Client(env['CONTENTFUL_SPACE_ID'], env['CONTENTFUL_TOKEN']);
  GetIt.I.registerSingleton<Client>(client);
  InAppLogger.log('🔥 Contentful Initialized');

  // initialize admob
  await FirebaseAdMob.instance.initialize(appId: env['ADMOB_APP_ID']);
  InAppLogger.log('🔥 Admob Initialized');

  // notificator
  final notificator = AppNotifier();
  await notificator.setup();
  GetIt.I.registerSingleton<AppNotifier>(notificator);
  InAppLogger.log('🔥 notificator Initialized');
}
