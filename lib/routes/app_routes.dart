import 'package:hostel_hive/features/splash_screen/splash_screen.dart';
import 'package:hostel_hive/features/walkthrough_screen/walkthrough_screen.dart';
import 'package:hostel_hive/features/auth_screen/role_selection/role_selection_screen.dart';
import 'package:hostel_hive/features/auth_screen/sign_in/sign_in_screen.dart';
import 'package:hostel_hive/features/auth_screen/sign_up/sign_up_screen.dart';
import 'package:hostel_hive/features/successful_screen/successful_screen.dart';
import 'package:hostel_hive/features/dashboard_screen/dashboard_screen.dart';
import 'package:hostel_hive/features/weekly_menu_screen/weekly_menu_screen.dart';
import 'package:hostel_hive/features/food_feedback_screen/food_feedback_screen.dart';
import 'package:hostel_hive/features/admin_screens/admin_dashboard_screen.dart';
import 'package:hostel_hive/features/add_new_complaints/add_new_complaint_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String walkthroughScreen = '/walkthrough_screen';
  static const String roleSelectionScreen = '/role_selection_screen';
  static const String signInScreen = '/sign_in_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String successfulScreen = '/successful_screen';
  static const String dashboardScreen = '/dashboard_screen';
  static const String adminDashboardScreen = '/admin_dashboard_screen';
  static const String weeklyMenuScreen = '/weekly_menu_screen';
  static const String foodFeedbackScreen = '/food_feedback_screen';
  static const String addNewComplaintScreen = '/add_new_complaints_screen';
  static const String homeScreen = dashboardScreen;
  static const String initialRoute = splashScreen;

  static Map<String, WidgetBuilder> get routes => {
        splashScreen: SplashScreen.builder,
        walkthroughScreen: WalkthroughScreen.builder,
        roleSelectionScreen: RoleSelectionScreen.builder,
        signInScreen: SignInScreen.builder,
        signUpScreen: SignUpScreen.builder,
        successfulScreen: SuccessfulScreen.builder,
        dashboardScreen: DashboardScreen.builder,
        adminDashboardScreen: AdminDashboardScreen.builder,
        weeklyMenuScreen: WeeklyMenuScreen.builder,
        foodFeedbackScreen: FoodFeedbackScreen.builder,
        addNewComplaintScreen: AddNewComplaintScreen.builder,
      };
}
