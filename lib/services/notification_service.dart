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

    _firebaseMessaging.subscribeToTopic("all");

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        NavigationService().scaffoldKey.currentState.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 10),
                content: GestureDetector(
                  onTap: () {
                    NavigationService()
                        .scaffoldKey
                        .currentState
                        .hideCurrentSnackBar();
                    _serialiseAndNavigate(message);
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(message['notification']["title"]),
                        Text(message['notification']["body"]),
                      ],
                    ),
                  ),
                ),
              ),
            );
      },
      onBackgroundMessage: myBackgroundMessageHandler,
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
