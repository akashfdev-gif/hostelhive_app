import 'package:hostel_hive/features/splash_screen/splash_screen.dart';
import 'package:hostel_hive/features/walkthrough_screen/walkthrough_screen.dart';
import 'package:hostel_hive/features/auth_screen/get_otp/get_otp_screen.dart';
import 'package:hostel_hive/features/auth_screen/verify_otp/verify_otp_screen.dart';
import 'package:hostel_hive/features/successful_screen/successful_screen.dart';
import 'package:hostel_hive/features/dashboard_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String walkthroughScreen = '/walkthrough_screen';
  static const String getOtpScreen = '/get_otp_screen';
  static const String verifyOtpScreen = '/verify_otp_screen';
  static const String successfulScreen = '/successful_screen';
  static const String dashboardScreen = '/dashboard_screen';
  static const String homeScreen = dashboardScreen;
  static const String initialRoute = splashScreen;

  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        walkthroughScreen: WalkthroughScreen.builder,
        getOtpScreen: GetOtpScreen.builder,
        verifyOtpScreen: VerifyOtpScreen.builder,
        successfulScreen: SuccessfulScreen.builder,
        dashboardScreen: DashboardScreen.builder,
      };
}
