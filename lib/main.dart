import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:crimyo/services/navigation_service.dart';
import 'package:crimyo/services/notification_service.dart';
import 'package:crimyo/constants.dart';
import 'package:crimyo/my_http_overrides.dart';
import 'package:crimyo/screens/home/home_screen.dart';

import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  HttpOverrides.global = new MyHttpOverrides();
  await Firebase.initializeApp();
  await NotificationService.createNotificationChannel();
  setupLocators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    NotificationService().initialise();

    return MaterialApp(
      title: 'CRIMYO',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService().navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}