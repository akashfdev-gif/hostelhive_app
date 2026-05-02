import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/core/network/connectivity_check.dart';

class NavigatorService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static List<String> allowedOfflineRoutes = [];
  static Future<dynamic> pushNamed(
    String routeName, {
    dynamic arguments,
  }) async {
    if (connectivity.isConnected || allowedOfflineRoutes.contains(routeName)) {
      final result = await navigatorKey.currentState
          ?.pushNamed(routeName, arguments: arguments);

      return result;
    } else {
      Fluttertoast.showToast(msg: 'msg_check_internet'.tr);
    }
  }

  static void goBack() {
    return navigatorKey.currentState?.pop();
  }

  static bool? canGoBack() {
    return navigatorKey.currentState?.canPop();
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    bool Function(Route<dynamic>)? routePredicate,
    dynamic arguments,
  }) async {
    final result = await navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName, routePredicate ?? (route) => false,
        arguments: arguments);

    return result;
  }

  static Future<dynamic> popAndPushNamed(
    String routeName, {
    dynamic arguments,
  }) async {
    final result = await navigatorKey.currentState
        ?.popAndPushNamed(routeName, arguments: arguments);

    return result;
  }
}
