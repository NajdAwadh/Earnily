import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  Notifications();

  static final _Notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        //  'channel description',
        importance: Importance.max,
      ),
      // iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _Notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );
}
