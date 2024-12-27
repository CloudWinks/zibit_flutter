import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:zibit_flutter/screens/scrn_message.dart';

class ExceptionHandler {
  static void init() {
    // Handle Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails details) {
      log('Caught Flutter error: ${details.exception}');
      _logError(details.exception.toString(), details.stack ?? StackTrace.current);
    };

    // Handle Dart-native errors
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      log('Caught Dart error: $error');
      _logError(error.toString(), stack);
      return true; // Prevents app from crashing
    };
  }

  static Future<void> _logError(String error, StackTrace stack) async {
    // Gather device info
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.androidInfo; // Adjust for iOS if needed

    final deviceDetails = '''
************ DEVICE INFORMATION ************
Brand: ${deviceInfo.brand}
Device: ${deviceInfo.device}
Model: ${deviceInfo.model}
Id: ${deviceInfo.id}
Product: ${deviceInfo.product}

************ FIRMWARE ************
SDK: ${deviceInfo.version.sdkInt}
Release: ${deviceInfo.version.release}
Incremental: ${deviceInfo.version.incremental}
''';

    // Log or save the error
    log('Error: $error\nDevice Info: $deviceDetails\nStackTrace: $stack');

    // Optionally store the log in a database or send to a server
    // Example: Save to SQLite or send via HTTP

    // Navigate to an error screen
    _navigateToErrorScreen(error, deviceDetails);
  }

  static void _navigateToErrorScreen(String error, String deviceInfo) {
    // Replace with your global navigator context or use navigator key
    final navigatorKey = GlobalKey<NavigatorState>();

    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => ScrnMessage(errorMessage: error, deviceInfo: deviceInfo),
    ));
  }
}
