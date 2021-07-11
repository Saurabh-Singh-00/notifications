import 'dart:async';

import 'package:flutter/services.dart';
import 'package:notifications/exception/notification_exception.dart';
import 'package:notifications/model/notification.dart';

export 'package:notifications/model/notification.dart';
export 'package:notifications/exception/notification_exception.dart';

class Notifications {
  static const MethodChannel _channel = const MethodChannel('notifications');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<bool?> showNotification(ProxyNotification notification) async {
    bool? succeeded;
    try {
      succeeded =
          await _channel.invokeMethod('showNotification', notification.toMap());
      return succeeded;
    } on PlatformException catch (e) {
      throw NotificationException(code: e.code, message: e.message);
    }
  }
}