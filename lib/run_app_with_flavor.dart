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
import 'package:sentry/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/domain/lesson/index.dart';
import 'package:wr_app/domain/system/index.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/article/article_persistence.dart';
import 'package:wr_app/infrastructure/article/article_persistence_mock.dart';
import 'package:wr_app/infrastructure/auth/auth_persistence.dart';
import 'package:wr_app/infrastructure/auth/auth_persistence_mock.dart';
import 'package:wr_app/infrastructure/note/note_persistence.dart';
import 'package:wr_app/infrastructure/note/note_persistence_mock.dart';
import 'package:wr_app/presentation/app.dart';
import 'package:wr_app/presentation/article/notifier/article_notifier.dart';
import 'package:wr_app/presentation/note/notifier/flash_card_notifier.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/usecase/article_service.dart';
import 'package:wr_app/usecase/note_service.dart';
import 'package:wr_app/util/apple_signin.dart';
import 'package:wr_app/util/cloud_functions.dart';
import 'package:wr_app/util/flavor.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/notification.dart';
import 'package:wr_app/util/sentry.dart';

/// initialize singleton instances and inject to GetIt
Future<void> setupGlobalSingletons(Flavor flavor) async {
  // load .env
  await DotEnv().load('secrets/.env');
  final env = DotEnv().env;

  // flavor
  GetIt.I.registerSingleton<Flavor>(flavor);
  InAppLogger.info('⚙ Flavor $flavor');

  // firebase analytics
  final analytics = FirebaseAnalytics();
  GetIt.I.registerSingleton<FirebaseAnalytics>(analytics);
  InAppLogger.info('🔥 FirebaseAnalytics Initialized');

  // pub spec
  final pubSpec = await PackageInfo.fromPlatform();
  GetIt.I.registerSingleton<PackageInfo>(pubSpec);
  InAppLogger.info('📄 Load pubspec.yml');

  // shared preferences
  final pref = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(pref);
  InAppLogger.info('🔥 SharedPreferences Initialized');

  // contentful client
  final client = Client(env['CONTENTFUL_SPACE_ID'], env['CONTENTFUL_TOKEN']);
  GetIt.I.registerSingleton<Client>(client);
  InAppLogger.info('🔥 Contentful Initialized');

  // initialize admob
  await FirebaseAdMob.instance.initialize(appId: env['ADMOB_APP_ID']);
  InAppLogger.info('🔥 Admob Initialized');

  // notificator
  final notificator = AppNotifier();
  await notificator.setup();
  GetIt.I.registerSingleton<AppNotifier>(notificator);
  InAppLogger.info('🔥 notificator Initialized');

  // sign in with apple
  final appleSignInAvailable = await AppleSignInAvailable.check();
  GetIt.I.registerSingleton<AppleSignInAvailable>(appleSignInAvailable);
  InAppLogger.info('🔥 sign in with apple Initialized');

  // sentry client
  // TODO: 書く場所考える
  assert(env['SENTRY_DSN'] != '');
  final _sentry = SentryClient(dsn: env['SENTRY_DSN']);
  GetIt.I.registerSingleton<SentryClient>(_sentry);
  InAppLogger.info('🔥 sentry Initialized');
}

/// runApp() with flavor
Future<void> runAppWithFlavor(final Flavor flavor) async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await setupGlobalSingletons(flavor);

  final analytics = GetIt.I<FirebaseAnalytics>();

  const useEmulator = false;
  const useMock = false;

  if (useEmulator) {
    final env = DotEnv().env;
    final origin = env['FUNCTIONS_EMULATOR_ORIGIN'];
    assert(origin != '');
    InAppLogger.info('❗ Using Emulator @ $origin');
    useCloudFunctionsEmulator(origin);
  }

  if (useMock) {
    InAppLogger.info('❗ Using Mock');
  }
  print('debug mode? $isInDebugMode');

  // repos
  final userPersistence = useMock ? UserPersistenceMock() : UserPersistence();
  final articlePersistence =
      useMock ? ArticlePersistenceMock() : ArticlePersistence();
  final lessonPersistence =
      useMock ? LessonPersistenceMock() : LessonPersistence();
  final authPersistence = useMock ? AuthPersistenceMock() : AuthPersistence();
  final systemPersistence = SystemPersistence();
  final notePersistence = useMock ? NotePersistenceMock() : NotePersistence();

  // services
  final userService = UserService(
      authPersistence: authPersistence, userPersistence: userPersistence);
  final articleService = ArticleService(articlePersistence: articlePersistence);
  final lessonService = LessonService(lessonPersistence: lessonPersistence);
  final systemService = SystemService(systemPersistence: systemPersistence);
  final noteService = NoteService(notePersistence: notePersistence);

  // provide notifiers
  // TODO: 全部rootに注入するの良くない
  await runZonedGuarded<Future<void>>(() async {
    runApp(
      MultiProvider(
        providers: [
          // Firebase Analytics
          Provider.value(
              value: FirebaseAnalyticsObserver(analytics: analytics)),
          // system
          ChangeNotifierProvider.value(
            value: SystemNotifier(systemService: systemService, flavor: flavor),
          ),
          // ユーザーデータ
          ChangeNotifierProvider.value(
            value: UserNotifier(
                userService: userService, noteService: noteService),
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
          ChangeNotifierProvider.value(value: NoteNotifier()),
        ],
        child: runZonedGuarded(
          () => WRApp(),
          (error, stackTrace) async {
            try {
              print('called sentry');
              final sentry = GetIt.I<SentryClient>();
              await sentry.captureException(
                exception: error,
                stackTrace: stackTrace,
              );
              print('Error sent to sentry.io: $error');
            } catch (e) {
              print('Sending report to sentry.io failed: $e');
              print('Original error: $error');
            }
          },
        ),
      ),
    );
  }, (error, stackTrace) async {
    await sentryReportError(error, stackTrace);
  });
}
