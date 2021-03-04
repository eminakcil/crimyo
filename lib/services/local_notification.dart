import 'package:crimyo/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  LocalNotification() {
    // Android initialization settings
    var ais = AndroidInitializationSettings("ic_notification");
    // IOS initialization settings
    var iis = IOSInitializationSettings();

    var initalizationSettings = InitializationSettings(
      android: ais,
      iOS: iis,
    );

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(
      initalizationSettings,
      onSelectNotification: (payload) =>
          NotificationService.serialiseAndNavigate(payload),
    );
  }

  show(
    int id,
    String title,
    String body, {
    String payload,
  }) {
    var androidNotificationDetails = AndroidNotificationDetails(
      NotificationService.channelMap["id"],
      NotificationService.channelMap["name"],
      NotificationService.channelMap["description"],
      color: Color(0xFFFE0000),
    );
    var iOSNotificationDetails = IOSNotificationDetails();
    var notificationDetail = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    _flutterLocalNotificationsPlugin.show(id, title, body, notificationDetail,
        payload: payload);
  }
}
