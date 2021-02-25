import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();

  static final NavigationService _instance = NavigationService._();

  factory NavigationService() {
    return _instance;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static push({@required Widget child}) {
    return NavigationService().navigatorKey.currentState.push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return child;
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(1,0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
  }
}
