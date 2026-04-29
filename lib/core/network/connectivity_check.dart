import 'dart:async';
import 'dart:io';
import 'package:hostel_hive/core/localization/app_localization.dart';
import 'package:hostel_hive/core/utils/size_utils.dart';
import 'package:hostel_hive/themes/custom_text_style.dart';
import 'package:hostel_hive/themes/theme_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart'; 
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/main.dart'; // Make sure scaffoldMessengerKey is defined here

ConnectivityService connectivity = ConnectivityService.instance;

class ConnectivityService {
  // Singleton instance
  ConnectivityService._();
  static ConnectivityService? _instance;

  static ConnectivityService get instance =>
      _instance ??= ConnectivityService._();

  final Connectivity _connectivity = Connectivity();

  // Broadcast stream for connection status updates
  final StreamController<bool> _connectionController =
      StreamController<bool>.broadcast();
  Stream<bool> get connectionStream => _connectionController.stream;

  bool _isConnected = true;
  Timer? _debounceTimer;
  bool _bannerShown = false; // Track banner state

  /// Get current connection status
  bool get isConnected => _isConnected;

  /// Call this method once during app startup
  Future<void> initialize() async {
    // Listen to changes in connectivity (WiFi, mobile, none)
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _handleConnectivityChange(results);
    });
  }

  /// Handles changes in network connectivity
  void _handleConnectivityChange(List<ConnectivityResult> results) {
    // Cancel any ongoing debounce
    _debounceTimer?.cancel();

    // Instantly notify if offline
    if (results.contains(ConnectivityResult.none)) {
      _updateConnectionState(false);
      _showNoInternetBanner();
      return;
    }

    // Debounce reconnection check to avoid false positives
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final bool connected = await _checkInternetConnection();
      _updateConnectionState(connected);
      if (connected) {
        _hideNoInternetBanner();
      } else {
        _showNoInternetBanner();
      }
    });
  }

  /// Notifies listeners if connection state changes
  void _updateConnectionState(bool connected) {
    if (connected != _isConnected) {
      _isConnected = connected;
      _connectionController.add(_isConnected);
    }
  }

  /// Checks both network interface and actual internet reachability
  Future<bool> _checkInternetConnection() async {
    try {
      final List<ConnectivityResult> results =
          await _connectivity.checkConnectivity();
      if (results.contains(ConnectivityResult.none)) {
        return false;
      }

      // Try pinging a reliable domain (Google)
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 30));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Show a MaterialBanner for no internet
  void _showNoInternetBanner() {
    if (_bannerShown) return;
    _bannerShown = true;

    scaffoldMessengerKey.currentState
      ?..hideCurrentMaterialBanner()
      ..showMaterialBanner(
        MaterialBanner(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          contentTextStyle:
              CustomTextStyle.textSmBold.copyWith(color: appTheme.otherWhite),
          minActionBarHeight: 0,
          content: Text(
            'msg_no_internet'.tr,
          ),
          leading: Icon(Icons.wifi_off, color: appTheme.otherWhite),
          backgroundColor: appTheme.gray900,
          actions: [SizedBox.shrink()],
        ),
      );
  }

  /// Hide the MaterialBanner
  void _hideNoInternetBanner() {
    if (!_bannerShown) return;
    scaffoldMessengerKey.currentState?.hideCurrentMaterialBanner();
    _bannerShown = false;
  }

  void dispose() {
    _debounceTimer?.cancel();
    _connectionController.close();
  }
}
