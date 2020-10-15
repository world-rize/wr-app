// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:wr_app/infrastructure/shop/shop_persistence.dart';
import 'package:wr_app/infrastructure/shop/shop_persistence_mock.dart';
import 'package:wr_app/presentation/app.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/presentation/maintenance.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/usecase/article_service.dart';
import 'package:wr_app/usecase/auth_service.dart';
import 'package:wr_app/usecase/note_service.dart';
import 'package:wr_app/usecase/shop_service.dart';
import 'package:wr_app/util/apple_signin.dart';
import 'package:wr_app/util/cloud_functions.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/util/flavor.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/notification.dart';
import 'package:wr_app/util/sentry.dart';

/// initialize singleton instances and inject to GetIt
Future<void> setupGlobalSingletons({
  @required Flavor flavor,
  @required bool useMock,
}) async {
  // load .env
  await DotEnv().load('secrets/.env');
  final env = EnvKeys.fromEnv(env: DotEnv().env);

  // env keys
  GetIt.I.registerSingleton<EnvKeys>(env);
  InAppLogger.info('⚙ Env');

  // flavor
  GetIt.I.registerSingleton<Flavor>(flavor);
  InAppLogger.info('⚙ Flavor $flavor');

  // firebase analytics
  final analytics = FirebaseAnalytics();
  GetIt.I.registerSingleton<FirebaseAnalytics>(analytics);
  InAppLogger.info('🔥 FirebaseAnalytics Initialized');

  final observer = FirebaseAnalyticsObserver(analytics: analytics);
  GetIt.I.registerSingleton<FirebaseAnalyticsObserver>(observer);
  InAppLogger.info('🔥 FirebaseAnalyticsObserver Initialized');

  // pub spec
  final pubSpec = await PackageInfo.fromPlatform();
  GetIt.I.registerSingleton<PackageInfo>(pubSpec);
  InAppLogger.info('📄 Load pubspec.yml');

  // shared preferences
  final pref = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(pref);
  InAppLogger.info('🔥 SharedPreferences Initialized');

  // initialize admob
  Admob.initialize(env.admobAppId);
  InAppLogger.info('🔥 Admob Initialized');

  // notificator
  final notificator = NotificationNotifier();
  await notificator.setup();
  GetIt.I.registerSingleton<NotificationNotifier>(notificator);
  InAppLogger.info('🔥 notificator Initialized');

  // sign in with apple
  final appleSignInAvailable = await AppleSignInAvailable.check();
  GetIt.I.registerSingleton<AppleSignInAvailable>(appleSignInAvailable);
  InAppLogger.info('🔥 sign in with apple Initialized');

  // sentry client
  final _sentry = SentryClient(dsn: env.sentryDsn);
  GetIt.I.registerSingleton<SentryClient>(_sentry);
  InAppLogger.info('🔥 sentry Initialized');

  // repos
  final userPersistence = useMock ? UserPersistenceMock() : UserPersistence();
  final articlePersistence =
      useMock ? ArticlePersistenceMock() : ArticlePersistence();
  final lessonPersistence =
      useMock ? LessonPersistenceMock() : LessonPersistence();
  final authPersistence = useMock ? AuthPersistenceMock() : AuthPersistence();
  final systemPersistence = SystemPersistence();
  final notePersistence = useMock ? NotePersistenceMock() : NotePersistence();
  final shopPersistence = useMock ? ShopPersistenceMock() : ShopPersistence();

  // services
  final userService = UserService(userPersistence: userPersistence);
  final articleService = ArticleService(articlePersistence: articlePersistence);
  final lessonService = LessonService(lessonPersistence: lessonPersistence);
  final systemService = SystemService(systemPersistence: systemPersistence);
  final authService = AuthService(
      authPersistence: authPersistence, userPersistence: userPersistence);
  final shopService = ShopService(shopPersistence: shopPersistence);
  final noteService = NoteService(notePersistence: notePersistence);
  GetIt.I.registerSingleton<UserService>(userService);
  GetIt.I.registerSingleton<ArticleService>(articleService);
  GetIt.I.registerSingleton<LessonService>(lessonService);
  GetIt.I.registerSingleton<SystemService>(systemService);
  GetIt.I.registerSingleton<AuthService>(authService);
  GetIt.I.registerSingleton<ShopService>(shopService);
  GetIt.I.registerSingleton<NoteService>(noteService);
  InAppLogger.info('🔥 usecase/services Initialized');
}

/// runApp() with flavor
Future<void> runAppWithFlavor(final Flavor flavor) async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  const useMock = false;
  if (useMock) {
    InAppLogger.info('❗ Using Mock');
  }

  await setupGlobalSingletons(flavor: flavor, useMock: useMock);
  final env = GetIt.I<EnvKeys>();
  final sentry = GetIt.I<SentryClient>();

  if (env.useEmulator) {
    final origin = env.functionsEmulatorOrigin;
    InAppLogger.info('❗ Using Emulator @ $origin');
    useCloudFunctionsEmulator(origin);
  }

  print('debug mode? $isInDebugMode');

  // repos
  final userPersistence = useMock ? UserPersistenceMock() : UserPersistence();
  final lessonPersistence =
      useMock ? LessonPersistenceMock() : LessonPersistence();
  final authPersistence = useMock ? AuthPersistenceMock() : AuthPersistence();
  final systemPersistence = SystemPersistence();
  final notePersistence = useMock ? NotePersistenceMock() : NotePersistence();

  // services
  final userService = UserService(userPersistence: userPersistence);
  final lessonService = LessonService(lessonPersistence: lessonPersistence);
  final systemService = SystemService(systemPersistence: systemPersistence);
  final authService = AuthService(
      authPersistence: authPersistence, userPersistence: userPersistence);
  final noteService = NoteService(notePersistence: notePersistence);

  // メンテナンスかどうか
  if (!await systemService.getAppInfo().then((value) => value.isValid)) {
    runZonedGuarded(
      () => runApp(Maintenance()),
      (error, stackTrace) => sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      ),
    );
  } else {
    // functions いらない説
    final userNotifier = UserNotifier(userService: userService);
    final authNotifier = AuthNotifier(authService: authService);
    authNotifier.addListener(() {
      userNotifier.user = authNotifier.user;
    });
    final noteNotifier = NoteNotifier(noteService: noteService);
    final lessonNotifier = LessonNotifier(
      userService: userService,
      lessonService: lessonService,
    );
    noteNotifier.addListener(() {
      InAppLogger.debug('update note');
      userNotifier.user = noteNotifier.user;
    });

    userNotifier.addListener(() {
      authNotifier.user = userNotifier.user;
      noteNotifier.user = userNotifier.user;
    });

    final app = MultiProvider(
      providers: [
        // system
        ChangeNotifierProvider.value(
          value: SystemNotifier(systemService: systemService, flavor: flavor),
        ),
        // ユーザーデータ
        ChangeNotifierProvider.value(value: userNotifier),
        // Auth
        ChangeNotifierProvider.value(value: authNotifier),
        // Note
        ChangeNotifierProvider.value(value: noteNotifier),
        // Lesson
        ChangeNotifierProvider.value(value: lessonNotifier),
      ],
      child: WRApp(),
    );

    runZonedGuarded(
      () => runApp(app),
      (error, stackTrace) => sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      ),
    );
  }
}
