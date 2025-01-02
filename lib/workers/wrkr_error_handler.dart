import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zibit_flutter/main.dart';

class ErrorHandler {
  static void handleError(dynamic error, {String? customMessage, BuildContext? context}) {
    BuildContext? actualContext = context;
    if (actualContext == null) {
      // Try to get context from the global navigator key if not provided
      actualContext = navigatorKey.currentContext;
    }
    if (actualContext == null) {
      print('No context available to show error for: $error');
      return;
    }

    String errorMessage = customMessage ?? 'An unexpected error occurred';
    
    if (error is Exception) {
      String errorMessage = _getErrorMessage(error);
          print('Error: $errorMessage');
    }

    ScaffoldMessenger.of(actualContext).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 3),
      ),
    );

    print('Error: $error');
  }
static String _getErrorMessage(Exception error) {
  if (error is SocketException) {
    return 'Network error. Please check your internet connection.';
  } else if (error is TimeoutException) {
    return 'The request timed out. Please try again.';
  } else if (error is FormatException) {
    return 'Data format error. Please try again.';
  }
  // Default error message for any other exception
  return 'An error occurred: ${error.toString()}';
}
}