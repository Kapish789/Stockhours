import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationsService {
  final _notifications = FlutterLocalNotificationsPlugin();

  Future initLocalNotification() async {
    const android = AndroidInitializationSettings("@drawable/ic_launcher");
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: ios);

    await _notifications.initialize(settings,
        onDidReceiveNotificationResponse: (details) {
      debugPrint(details.payload);
    });
  }

  Future<NotificationDetails> _notificationsDetials() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channel id",
        "channel name",
        channelDescription: "channel description",
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  Future<void> showNotification(
      int id, String? title, String? body, String? payload) async {
    _notifications.show(id, title, body, await _notificationsDetials(),
        payload: payload);
  }

  Future<void> scheduleNotification(
    int id,
    String? title,
    String? body,
    String? payload,
    DateTime date,
  ) async {
    _notifications.zonedSchedule(id, title, body,
        tz.TZDateTime.from(date, tz.local), await _notificationsDetials(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
