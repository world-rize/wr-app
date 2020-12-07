class NoteLimitExceeded implements Exception {
  NoteLimitExceeded(this.cause);

  String cause;
}
