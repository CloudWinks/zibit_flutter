import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zibit_flutter/globals/glbl_user_model.dart';
import 'package:zibit_flutter/workers/wrkr_auth_service.dart';
import 'package:zibit_flutter/workers/wrkr_api_service.dart';
import 'package:zibit_flutter/workers/wrkr_error_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginService _loginService;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loginService = LoginService(context);
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    const String endpoint = '/Query/UpdateOrCreateUserBySocialID';

    try {
      final response = await _apiService.callAPI(endpoint, userData);

      if (response is List && response.isNotEmpty) {
        final fields = response[0]['fields'];
        final userId = fields.firstWhere(
          (field) => 
              field['name'] == 'NewUserID' || 
              field['name'] == 'UpdatedUserID' || 
              field['name'] == 'UserId',
          orElse: () => {'value': null},
        )['value'];
        final userIdValue = userId is String ? int.parse(userId) : userId;
        if (userId != null) {
          final userModel = Provider.of<UserModel>(context, listen: false);
          userModel.updateUserData(
            userId: userIdValue as int, // Convert string to int
            email: userData['email'],
            firstName: userData['firstName'],
            lastName: userData['lastName'],
            username: userData['email'], // Assuming username is email for now
            phoneNumber: userData['phoneNumber'],
            dateOfBirth: userData['dateOfBirth'] != null ? DateTime.parse(userData['dateOfBirth']) : null,
            gender: userData['gender'],
            country: userData['country'],
            languagePreference: userData['languagePreference'],
            themePreference: userData['themePreference'],
            notificationPreferences: userData['notificationPreferences'],
            googleID: userData['socialID'],
            facebookID: null, // Not applicable for Google login
            lastLogin: DateTime.now(),
          );
          print('User data updated: userId: $userId, name: ${userModel.firstName} ${userModel.lastName}, email: ${userModel.email}');
          Navigator.pushReplacementNamed(context, '/frame');
        }
      }
    } catch (error) {
      ErrorHandler.handleError(error, customMessage: 'Failed to save user data', context: context);
    }
  }

  void _handleGoogleLogin() async {
    try {
      final user = await _loginService.signInWithGoogle();
      if (user != null) {
        print('Google Login Success: $user');

        final userData = {
          "socialID": user['socialID'] ?? user['id'],
          "socialType": "Google",
          "email": user['email'],
          "firstName": user['name']?.split(' ')?.first ?? '',
          "lastName": user['name']?.split(' ')?.last ?? '',
          // Note: You might want to fetch or set these from user data or defaults
          "username": user['email'],
          "phoneNumber": '', // Assuming no phone number from Google login
          "dateOfBirth": null, // Not provided by Google login
          "gender": '', // Not provided by Google login
          "country": '', // Not provided by Google login
          "languagePreference": "en",
          "themePreference": "dark",
          "notificationPreferences": "all",
        };

        print('User data being sent to API: $userData');

        try {
          await saveUserData(userData);
          print('User data saved successfully.');
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