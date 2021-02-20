import 'dart:io';

import 'package:crimyo/models/post.dart';
import 'package:crimyo/screens/post_detail/post_detail_screen.dart';
import 'package:crimyo/services/navigation_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    var postUrl = notificationData["post_url"];


    if (view != null) {
      if (view == "post") {
        NavigationService().navigatorKey.currentState.push(
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(post: Post(url: postUrl)),
          ),
        );
      }
    }
  }
}
