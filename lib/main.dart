import 'dart:io';

import 'package:crimyo/services/navigation_service.dart';
import 'package:crimyo/services/notification_service.dart';
import 'package:flutter/material.dart';

import 'package:crimyo/constants.dart';
import 'package:crimyo/my_http_overrides.dart';
import 'package:crimyo/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    NotificationService().initialise();

    return MaterialApp(
      title: 'CRİMYO Mobil Uygulama',
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