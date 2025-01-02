import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

class LoginService {
  final GlobalKey<NavigatorState> _navigatorKey;
  final GoogleSignIn _googleSignIn;

  LoginService(BuildContext context) 
    : _navigatorKey = Provider.of<GlobalKey<NavigatorState>>(context, listen: false),
      _googleSignIn = GoogleSignIn(
          clientId: '572898597844-cnqh7i6clhb3njerg0r70odilc7pies9.apps.googleusercontent.com');

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return null; // The user canceled the sign-in

      final GoogleSignInAuthentication auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken != null) {
        // Decode the ID token to extract the 'sub' field
        try {
          final parts = idToken.split('.');
          if (parts.length == 3) {
            final payload =
                base64Url.normalize(parts[1]); // Second part is the payload
            final payloadMap =
                jsonDecode(utf8.decode(base64Url.decode(payload)));

            // Debugging: Print the entire payload for verification
            print('Decoded payload: $payloadMap');

            if (payloadMap.containsKey('sub')) {
              return {
                'email': account.email,
                'name': account.displayName,
                'photoUrl': account.photoUrl,
                'socialID':
                    payloadMap['sub'], // Extracted 'sub' field as SocialID
              };
            } else {
              print('Error: "sub" field not found in payload');
            }
          } else {
            print('Error: Invalid ID token format');
          }
        } catch (e) {
          print('Error while decoding ID token: $e');
        }
      } else {
        print('Error: idToken is null');
      }

      throw Exception('Failed to retrieve or decode idToken');
    } catch (error) {
      throw Exception('Google Sign-In failed: $error');
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await FacebookAuth.instance.logOut();
      print('User signed out successfully');
    } catch (error) {
      throw Exception('Sign-Out failed: $error');
    }
  }
}

Future<Map<String, dynamic>?> signInWithFacebook() async {
  try {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      return {
        'email': userData['email'],
        'name': userData['name'],
        'photoUrl': userData['picture']['data']['url'],
        'socialID': userData['id'],
      };
    } else {
      throw Exception('Facebook Sign-In failed: ${result.status}');
    }
  } catch (error) {
    throw Exception('Facebook Sign-In failed: $error');
  }
}
