import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import 'package:crimyo/models/post.dart';
import 'package:crimyo/screens/document/document_screen.dart';
import 'package:crimyo/screens/post_detail/post_detail_screen.dart';
import 'package:crimyo/services/navigation_service.dart';
import 'package:crimyo/services/local_notification.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static const MethodChannel channel = MethodChannel('crimyo/channel');

  static const Map<String, String> channelMap = {
    "id": "info_channel",
    "name": "Bilgilendirme",
    "description": "Bilgilendirmelerden haberdar olun",
  };

  static createNotificationChannel() async {
    try {
      await channel.invokeMethod('createNotificationChannel', channelMap);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future initialise() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    _firebaseMessaging.subscribeToTopic("all");

    // TODO remove this line ↓
    print("FCM_TOKEN ${await _firebaseMessaging.getToken()}");

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        GetIt.instance.get<LocalNotification>().show(
              int.parse("${message["data"]["id"] ?? 1}"),
              message["notification"]["title"],
              message["notification"]["body"],
              payload: json.encode(message),
            );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        serialiseAndNavigate(json.encode(message));
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        serialiseAndNavigate(json.encode(message));
      },
    );
  }

  static serialiseAndNavigate(String payload) {
    Map<String, dynamic> message = json.decode(payload);
    var notificationData = message["data"];
    var view = notificationData["view"];
    var url = notificationData["url"];
    var title = message["notification"]["title"] ?? "";

    if (view != null) {
      var route;

      switch (view) {
        case "post":
          route = MaterialPageRoute(
            builder: (context) => PostDetailScreen(
              post: Post(
                url: url,
              ),
            ),
          );
          break;
        case "document":
          route = MaterialPageRoute(
            builder: (context) => DocumentScreen(
              url: url,
              title: title,
            ),
          );
          break;
        default:
          break;
      }

      if (route != null) {
        NavigationService().navigatorKey.currentState.push(route);
      }
    }
  }
}
