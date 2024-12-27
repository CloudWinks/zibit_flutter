import 'package:flutter/material.dart';
import 'package:zibit_flutter/workers/wrkr_request_handler.dart';
import 'package:zibit_flutter/screens/scrn_login_screen';

class ScrSplash extends StatefulWidget {
  const ScrSplash({super.key});

  @override
  _ScrSplashState createState() => _ScrSplashState();
}

class _ScrSplashState extends State<ScrSplash> {
  late RequestHandler apiHandler;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    print('Initializing API Handler...');
    apiHandler = RequestHandler(
        baseUrl:
            'http://192.168.68.61:8083/api/Query/UpdateOrCreateUserBySocialID');
    // 'http://192.168.68.61:8083/api/Test');

    try {
      //  print('Fetching CWApps...');
      // Fetch CWApps data (optional, depending on your app logic)
      //  await apiHandler.queryCWApps('CWApps');
      // print('CWApps fetched successfully.');
      await Future.delayed(const Duration(seconds: 3));

      // Navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load data: $e';
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
              'assets/zibit.png',
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
              'Welcome to Zibit',
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
