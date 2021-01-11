import 'package:data_classes/data_classes.dart';
import 'package:get_it/get_it.dart';
import 'package:sentry/io_client.dart';
import 'package:wr_app/util/flavor.dart';
import 'package:wr_app/util/logger.dart';

bool get isInDebugMode {
  // Assume you're in production mode.
  var inDebugMode = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code only sets `inDebugMode` to true
  // in a development environment.
  assert(inDebugMode = true);

  return inDebugMode;
}

/// Reports [error] along with its [stackTrace] to Sentry.io.
Future<void> sentryReportError({
  @required dynamic error,
  @required dynamic stackTrace,
}) async {
  InAppLogger.error(error);

  // Errors thrown in development mode are unlikely to be interesting. You can
  // check if you are running in dev mode using an assertion and omit sending
  // the report.
  if (isInDebugMode && false) {
    print(stackTrace);
    print('In dev mode. Not sending report to Sentry.io.');
    return;
  }

  final flavor = GetIt.I<Flavor>();
  final response = await GetIt.I<SentryClient>().capture(
    event: Event(
      exception: error,
      stackTrace: stackTrace,
      environment: flavor.toShortString(),
    ),
  );

  if (response.isSuccessful) {
    InAppLogger.info('Reporting Success! Event ID: ${response.eventId}');
  } else {
    InAppLogger.error('Failed to report to Sentry.io: ${response.error}');
  }
}
