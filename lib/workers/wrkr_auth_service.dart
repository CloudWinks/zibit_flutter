import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return null; // The user canceled the sign-in
      final GoogleSignInAuthentication auth = await account.authentication;
      return {
        'email': account.email,
        'name': account.displayName,
        'photoUrl': account.photoUrl,
        'idToken': '1326538', //auth.idToken,
      };
    } catch (error) {
      throw Exception('Google Sign-In failed: $error');
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
}
