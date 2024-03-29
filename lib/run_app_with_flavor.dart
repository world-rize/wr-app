// Copyright © 2020 WorldRIZe. All rights reserved.

import 'dart:async';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wr_app/infrastructure/api/functions.dart';
import 'package:wr_app/infrastructure/auth/auth_repository.dart';
import 'package:wr_app/infrastructure/lesson/favorite_repository.dart';
import 'package:wr_app/infrastructure/lesson/lesson_repository.dart';
import 'package:wr_app/infrastructure/note/note_repository.dart';
import 'package:wr_app/infrastructure/system/system_repository.dart';
import 'package:wr_app/infrastructure/user/user_repository.dart';
import 'package:wr_app/presentation/app.dart';
import 'package:wr_app/presentation/auth_notifier.dart';
import 'package:wr_app/presentation/lesson_notifier.dart';
import 'package:wr_app/presentation/maintenance.dart';
import 'package:wr_app/presentation/note/notifier/note_notifier.dart';
import 'package:wr_app/presentation/system_notifier.dart';
import 'package:wr_app/presentation/user_notifier.dart';
import 'package:wr_app/presentation/voice_player.dart';
import 'package:wr_app/usecase/auth_service.dart';
import 'package:wr_app/usecase/lesson_service.dart';
import 'package:wr_app/usecase/note_service.dart';
import 'package:wr_app/usecase/system_service.dart';
import 'package:wr_app/usecase/user_service.dart';
import 'package:wr_app/util/apple_signin.dart';
import 'package:wr_app/util/cloud_functions.dart';
import 'package:wr_app/util/env_keys.dart';
import 'package:wr_app/util/flavor.dart';
import 'package:wr_app/util/logger.dart';
import 'package:wr_app/util/migrations.dart';
import 'package:wr_app/util/notification.dart';
import 'package:wr_app/util/sentry.dart';

/// initialize singleton instances and inject to GetIt
/// [useMock] によって差し替える
Future<void> setupGlobalSingletons({
  @required Flavor flavor,
  @required bool useMock,
}) async {
  await Firebase.initializeApp();

  if (useMock) {
    InAppLogger.info('❗ Using Mock');
  }

  // load .env
  await DotEnv().load('secrets/.env');
  final env = EnvKeys.fromEnv(env: DotEnv().env);

  if (env.useEmulator) {
    final origin = env.functionsEmulatorOrigin;
    InAppLogger.info('❗ Using Emulator @ $origin');
    useCloudFunctionsEmulator(origin);
  }

  // firestore
  GetIt.I.registerSingleton<FirebaseFirestore>(
      useMock ? MockFirestoreInstance() : FirebaseFirestore.instance);

  // firebase auth
  GetIt.I.registerSingleton<FirebaseAuth>(
      useMock ? MockFirebaseAuth() : FirebaseAuth.instance);

  // google sign in
  GetIt.I.registerSingleton<GoogleSignIn>(
      useMock ? MockGoogleSignIn() : GoogleSignIn());

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

  // repos
  final userRepository = UserRepository(store: GetIt.I<FirebaseFirestore>());
  final lessonRepository = LessonRepository();
  final authRepository = AuthRepository(
    auth: GetIt.I<FirebaseAuth>(),
    googleSignIn: GetIt.I<GoogleSignIn>(),
  );
  final systemRepository = SystemRepository();

  final noteRepository = NoteRepository(store: GetIt.I<FirebaseFirestore>());
  final favoriteRepository =
      FavoriteRepository(store: GetIt.I<FirebaseFirestore>());

  final migrationExecutor =
      MigrationExecutor(store: GetIt.I<FirebaseFirestore>());

  // services
  final userService = UserService(
    authRepository: authRepository,
    userRepository: userRepository,
    favoriteRepository: favoriteRepository,
    noteRepository: noteRepository,
    userApi: UserAPI(),
  );

  final lessonService = LessonService(
      lessonRepository: lessonRepository,
      favoriteRepository: favoriteRepository);
  final systemService = SystemService(systemRepository: systemRepository);
  final authService = AuthService(
      authRepository: authRepository, userRepository: userRepository);
  final noteService = NoteService(noteRepository: noteRepository);

  // DI Services
  GetIt.I.registerSingleton<UserService>(userService);
  GetIt.I.registerSingleton<SystemService>(systemService);
  GetIt.I.registerSingleton<AuthService>(authService);
  GetIt.I.registerSingleton<NoteService>(noteService);
  GetIt.I.registerSingleton<LessonService>(lessonService);

  GetIt.I.registerSingleton<MigrationExecutor>(migrationExecutor);
}

/// runApp() with flavor
Future<void> runAppWithFlavor(final Flavor flavor) async {
  // override flutter error
  // <https://flutter.dev/docs/cookbook/maintenance/error-reporting>
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode && false) {
      // In development mode, simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode, report to the application zone to report to
      // Sentry.
      sentryReportError(error: details.exception, stackTrace: details.stack);
    }
  };

  await runZonedGuarded<Future>(
    () async {
      Provider.debugCheckInvalidValueType = null;
      WidgetsFlutterBinding.ensureInitialized();

      const useMock = false;

      await setupGlobalSingletons(flavor: flavor, useMock: useMock);

      final systemService = GetIt.I<SystemService>();
      final userService = GetIt.I<UserService>();
      final authService = GetIt.I<AuthService>();
      final noteService = GetIt.I<NoteService>();
      final lessonService = GetIt.I<LessonService>();

      // maintenance check
      final appInfo = await systemService.getAppInfo();
      print(appInfo);
      if (!appInfo.isValid) {
        runApp(Maintenance());
      }

      final userNotifier = UserNotifier(userService: userService);
      final authNotifier =
          AuthNotifier(authService: authService, userService: userService);
      final noteNotifier = NoteNotifier(noteService: noteService);
      final lessonNotifier = LessonNotifier(lessonService: lessonService);
      authNotifier.addListener(() {
        if (authNotifier.user == null) {
          InAppLogger.debug('user is null');
        }
        userNotifier.user = authNotifier.user;
        noteNotifier.user = authNotifier.user;
        lessonNotifier.user = authNotifier.user;
      });

      // FIXME: rootに置くのはMaterialAppよりも上に置かないと、MaterialPageRouteからProviderを使えないので
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
          ChangeNotifierProvider.value(value: lessonNotifier),
          ChangeNotifierProvider.value(value: VoicePlayer()),
        ],
        child: WRApp(),
      );

      runApp(app);
    },
    (error, stackTrace) {
      sentryReportError(error: error, stackTrace: stackTrace);
    },
  );
}
