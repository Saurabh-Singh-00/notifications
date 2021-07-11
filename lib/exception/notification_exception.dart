class NotificationException implements Exception {
  final String? message;
  final String code;

  NotificationException({required this.code, required this.message});
}
