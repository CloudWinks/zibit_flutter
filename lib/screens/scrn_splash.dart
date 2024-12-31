import 'package:flutter/material.dart';
import 'package:zibit_flutter/screens/scrn_login_screen.dart';

class ScrSplash extends StatefulWidget {
  const ScrSplash({super.key});

  @override
  _ScrSplashState createState() => _ScrSplashState();
}

class _ScrSplashState extends State<ScrSplash> {
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      print('Splash screen initialization...');
      await Future.delayed(const Duration(seconds: 3));

      // Navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to initialize: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              'assets/cloudwinkslogo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            if (errorMessage.isEmpty)
              const CircularProgressIndicator()
            else
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to CloudWinks',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
