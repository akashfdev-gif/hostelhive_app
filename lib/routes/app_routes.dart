import 'package:hostel_hive/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String homeScreen = '/home_screen';
  static const String initialRoute = splashScreen;

  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        homeScreen: (context) => const Scaffold(
              body: Center(
                child: Text('Home Screen Placeholder'),
              ),
            ),
      };
}
