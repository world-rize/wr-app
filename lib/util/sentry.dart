import 'package:get_it/get_it.dart';
import 'package:sentry/io_client.dart';

bool get isInDebugMode {
  var inDebugMode = false;
  assert(inDebugMode = true);
  inDebugMode = false;
  return inDebugMode;
}

/// Reports [error] along with its [stackTrace] to Sentry.io.
Future<Null> sentryReportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');

  // Errors thrown in development mode are unlikely to be interesting. You can
  // check if you are running in dev mode using an assertion and omit sending
  // the report.
  if (isInDebugMode) {
    print(stackTrace);
    print('In dev mode. Not sending report to Sentry.io.');
    return;
  }

  print('Reporting to Sentry.io...');

  final response = await GetIt.instance<SentryClient>().captureException(
    exception: error,
    stackTrace: stackTrace,
  );

  if (response.isSuccessful) {
    print('Success! Event ID: ${response.eventId}');
  } else {
    print('Failed to report to Sentry.io: ${response.error}');
  }
}
