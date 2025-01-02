import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:zibit_flutter/workers/wrkr_auth_service.dart';
import 'package:zibit_flutter/workers/wrkr_api_service.dart';
import 'package:zibit_flutter/workers/wrkr_singleton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginService _loginService; // Declare as late
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loginService = LoginService(context); // Initialize in initState
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    const String endpoint =
        '/Query/UpdateOrCreateUserBySocialID'; // Specific endpoint

    try {
      final response = await _apiService.callAPI(endpoint, userData);

      // Extract userId, name, and email from response and store them in the singleton
      if (response is List && response.isNotEmpty) {
        final fields = response[0]['fields'];
        final userId = fields.firstWhere(
          (field) =>
              field['name'] == 'NewUserID' ||
              field['name'] == 'UpdatedUserID' ||
              field['name'] == 'UserId', // Check for 'UserId'
          orElse: () => {'value': null},
        )['value'];

        if (userId != null) {
          // Save userId, name, and email in the singleton
          AppSingleton().userId = userId; // Save userId globally
          AppSingleton().name = userData['firstName'] +
              ' ' +
              userData['lastName']; // Combine names
          AppSingleton().email = userData['email']; // Save email globally

          print('User ID saved in singleton: ${AppSingleton().userId}');
          print('User Name saved in singleton: ${AppSingleton().name}');
          print('User Email saved in singleton: ${AppSingleton().email}');
        } else {
          throw Exception('UserID not found in response.');
        }
      } else {
        throw Exception('Unexpected API response format.');
      }
    } catch (error) {
      throw Exception('Error while saving user data: $error');
    }
  }

  void _handleGoogleLogin() async {
    try {
      final user = await _loginService.signInWithGoogle();
      if (user != null) {
        print('Google Login Success: $user');

        final userData = {
          "socialID":
              user['socialID'] ?? user['id'], // Check for alternate key names
          "socialType": "Google",
          "email": user['email'],
          "firstName": user['name']?.split(' ')?.first ?? '',
          "lastName": user['name']?.split(' ')?.last ?? '',
          "username": user['email'],
          "phoneNumber": '',
          "dateOfBirth": null,
          "gender": '',
          "country": '',
          "languagePreference": "en",
          "themePreference": "dark",
          "notificationPreferences": "all",
        };

        print('User data being sent to API: $userData');

        try {
          await saveUserData(userData);

          print('User data saved successfully.');
          Navigator.pushReplacementNamed(context, '/frame');
        } catch (apiError) {
          print('Failed to save user data: $apiError');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save user data: $apiError')),
          );
        }
      } else {
        print('Google Login Cancelled');
      }
    } catch (e) {
      print('Error during Google login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _handleGoogleLogin,
              child: Text('Login with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
