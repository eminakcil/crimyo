import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:crimyo/models/post.dart';
import 'package:crimyo/screens/document/document_screen.dart';
import 'package:crimyo/screens/post_detail/post_detail_screen.dart';
import 'package:crimyo/services/navigation_service.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
    }
    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
    }
  }

  Future initialise() async {
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    _firebaseMessaging.subscribeToTopic("lla");

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        showDialog(
          context: NavigationService().navigatorKey.currentContext,
          barrierDismissible: false,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                content: ListTile(
                  title: Text(message["notification"]["title"]),
                  subtitle: Text(message["notification"]["body"]),
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Kapat"),
                  ),
                  if (message["data"]["view"] != null)
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _serialiseAndNavigate(message);
                      },
                      child: Text("Git"),
                    ),
                ],
              ),
            );
          },
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _serialiseAndNavigate(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _serialiseAndNavigate(message);
      },
    );
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message["data"];
    var view = notificationData["view"];
    var url = notificationData["url"];

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
            builder: (context) => DocumentScreen(url: url),
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
