abstract class Failure implements Exception {
  const Failure({
    this.exception,
    this.message,
  });

  final Exception? exception;
  final String? message;
}
