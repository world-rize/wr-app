// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:contentful/client.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';
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
import 'package:wr_app/presentation/article/notifier/article_notifier.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/presentation/maintenance.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/shop_notifier.dart';
import 'package:wr_app/presentation/voice_player.dart';
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

void showMaintenance() {
  runZonedGuarded(
    () => runApp(Maintenance()),
    (error, stackTrace) => sentryReportError(
      error: error,
      stackTrace: stackTrace,
    ),
  );
}

/// initialize singleton instances and inject to GetIt
Future<void> setupGlobalSingletons(Flavor flavor) async {
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

  // contentful client
  final client = Client(env.contentfulSpaceId, env.contentfulToken);
  GetIt.I.registerSingleton<Client>(client);
  InAppLogger.info('🔥 Contentful Initialized');

  // initialize admob
  Admob.initialize(testDeviceIds: [env.admobAppId]);
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
  // TODO: 書く場所考える
  final _sentry = SentryClient(dsn: env.sentryDsn);
  GetIt.I.registerSingleton<SentryClient>(_sentry);
  InAppLogger.info('🔥 sentry Initialized');
}

/// runApp() with flavor
Future<void> runAppWithFlavor(final Flavor flavor) async {
  try {
    Provider.debugCheckInvalidValueType = null;
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    await setupGlobalSingletons(flavor);

    final env = GetIt.I<EnvKeys>();

    if (env.useEmulator) {
      final origin = env.functionsEmulatorOrigin;
      InAppLogger.info('❗ Using Emulator @ $origin');
      useCloudFunctionsEmulator(origin);
    }

    const useMock = false;

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
    final shopPersistence = useMock ? ShopPersistenceMock() : ShopPersistence();

    // services
    final userService = UserService(userPersistence: userPersistence);
    final articleService =
        ArticleService(articlePersistence: articlePersistence);
    final lessonService = LessonService(lessonPersistence: lessonPersistence);
    final systemService = SystemService(systemPersistence: systemPersistence);
    final authService = AuthService(
        authPersistence: authPersistence, userPersistence: userPersistence);
    final shopService = ShopService(
        userPersistence: userPersistence, shopPersistence: shopPersistence);
    final noteService = NoteService(notePersistence: notePersistence);

    // maintenance check
    final appInfo = await systemService.getAppInfo();
    print(appInfo);
    if (!appInfo.isValid) {
      showMaintenance();
    }

    // TODO: re-architecture
    // notifier とストア分離する (StoreProvider)
    // notifier は StatefulNotifier を Stateless化するものなので
    // 1 Stateful画面 1 ChangeNotifier
    //  Dao に CRUI
    // 下から上の更新に依存したい
    // 下から上(update): ProxyProvider
    // 上から下(get): GetIt<UserNotifier>

    // functions いらない説
    final userNotifier = UserNotifier(userService: userService);
    final authNotifier = AuthNotifier(authService: authService);
    final shopNotifier = ShopNotifier(shopService: shopService);
    authNotifier.addListener(() {
      userNotifier.user = authNotifier.user;
    });
    final noteNotifier = NoteNotifier(noteService: noteService);
    noteNotifier.addListener(() {
      InAppLogger.debug('update note');
      userNotifier.user = noteNotifier.user;
    });
    userNotifier.addListener(() {
      authNotifier.user = userNotifier.user;
      noteNotifier.user = userNotifier.user;
      shopNotifier.user = userNotifier.user;
    });

    final app = MultiProvider(
      providers: [
        Provider.value(
            value:
                SystemNotifier(systemService: systemService, flavor: flavor)),
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
        ChangeNotifierProvider.value(
          value: LessonNotifier(
            userService: userService,
            lessonService: lessonService,
          ),
        ),
        ChangeNotifierProvider.value(
          value: VoicePlayer(
            onError: (e) {
              print(e);
            },
          ),
        ),
        // Article
        ChangeNotifierProvider.value(
          value: ArticleNotifier(
            articleService: articleService,
          ),
        ),
        ChangeNotifierProvider.value(
          value: shopNotifier,
        ),
      ],
      child: WRApp(),
    );

    runZonedGuarded(
      () => runApp(app),
      (error, stackTrace) => sentryReportError(
        error: error,
        stackTrace: stackTrace,
      ),
    );
  } on Exception catch (e) {
    // set up error
    InAppLogger.error(e);
    final sentry = GetIt.I<SentryClient>();
    await sentry.captureException(exception: e);
  }
}
