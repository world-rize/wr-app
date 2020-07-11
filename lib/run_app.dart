// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:contentful/client.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/domain/article/article_notifier.dart';
import 'package:wr_app/domain/article/article_repository.dart';
import 'package:wr_app/domain/article/article_service.dart';
import 'package:wr_app/domain/auth/auth_repository.dart';
import 'package:wr_app/domain/lesson/lesson_notifier.dart';
import 'package:wr_app/domain/lesson/lesson_repository.dart';
import 'package:wr_app/domain/lesson/lesson_service.dart';
import 'package:wr_app/domain/system/system_notifier.dart';
import 'package:wr_app/domain/system/system_repository.dart';
import 'package:wr_app/domain/user/preferences_notifier.dart';
import 'package:wr_app/domain/user/user_notifier.dart';
import 'package:wr_app/domain/user/user_repository.dart';
import 'package:wr_app/domain/user/user_service.dart';
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

  // notification
  // final notifier = AppNotifier();

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

  // repos
  final userRepository = UserRepository();
  final articleRepository = ArticleRepository();
  final lessonRepository = LessonRepository();
  final authRepository = AuthRepository();
  final systemRepository = SystemRepository();

  // services
  final userService = UserService(
      authRepository: authRepository, userRepository: userRepository);
  final articleService = ArticleService(articleRepository: articleRepository);
  final lessonService = LessonService(lessonRepository: lessonRepository);

  // アプリ全体にストアを Provide する
  runApp(MultiProvider(
    providers: [
      // Firebase Analytics
      // TODO(someone): create Analytics Store
      Provider.value(value: analytics),
      Provider.value(value: analyticsObserver),
      // 通知
      // Provider.value(value: notifier),
      // 環境変数
      Provider.value(
        value: SystemNotifier(flavor: flavor, pubSpec: pubSpec),
      ),
      // ユーザーデータ
      ChangeNotifierProvider.value(value: UserNotifier(service: userService)),
      // Lesson
      ChangeNotifierProvider.value(
          value: LessonNotifier(lessonService: lessonService)),
      // 設定
      ChangeNotifierProvider.value(value: PreferenceNotifier(pref: pref)),
      // system
      ChangeNotifierProvider.value(
          value: SystemNotifier(flavor: flavor, pubSpec: pubSpec)),
      // Article
      ChangeNotifierProvider.value(
          value:
              ArticleNotifier(client: client, articleService: articleService)),
    ],
    child: WRApp(),
  ));
}
