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
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/article/article_persistence.dart';
import 'package:wr_app/infrastructure/article/article_persistence_mock.dart';
import 'package:wr_app/infrastructure/auth/article_persistence.dart';
import 'package:wr_app/infrastructure/auth/auth_persistence_mock.dart';
import 'package:wr_app/presentation/app.dart';
import 'package:wr_app/presentation/article/notifier/article_notifier.dart';
import 'package:wr_app/usecase/article_service.dart';
import 'package:wr_app/util/flavor.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/notification.dart';

/// initialize singleton instances and inject to GetIt
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

/// runApp() with flavor
Future<void> runAppWithFlavor(final Flavor flavor) async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  await setupGlobalSingletons();

  final analytics = GetIt.I<FirebaseAnalytics>();

  const useMock = false;
  // repos
  final userPersistence =
      useMock ? UserPersistenceMock() : UserPersistenceMock();
  final articlePersistence =
      useMock ? ArticlePersistenceMock() : ArticlePersistence();
  final lessonPersistence =
      useMock ? LessonPersistenceMock() : LessonPersistence();
  final authPersistence = useMock ? AuthPersistence() : AuthPersistenceMock();
  final systemRepository = SystemPersistence();

  // services
  final userService = UserService(
      authPersistence: authPersistence, userPersistence: userPersistence);
  final articleService = ArticleService(articlePersistence: articlePersistence);
  final lessonService = LessonService(lessonPersistence: lessonPersistence);
  final systemService = SystemService(systemPersistence: systemRepository);

  // provide notifiers
  // TODO: 全部rootに注入するの良くない
  runApp(MultiProvider(
    providers: [
      // Firebase Analytics
      Provider.value(value: FirebaseAnalyticsObserver(analytics: analytics)),
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
        value: ArticleNotifier(
          articleService: articleService,
        ),
      ),
    ],
    child: WRApp(),
  ));
}
