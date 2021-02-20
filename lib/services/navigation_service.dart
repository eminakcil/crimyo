import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();

  static final NavigationService _instance = NavigationService._();

  factory NavigationService() {
    return _instance;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<ScaffoldState> scaffoldKey;
}
