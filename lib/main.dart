import 'package:flutter/material.dart';
import 'package:zibit_flutter/screens/scrn_splash.dart';
import 'package:zibit_flutter/screens/scrn_home.dart';
import 'package:zibit_flutter/screens/scrn_frame.dart';
import 'package:zibit_flutter/screens/scrn_login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zibit Migration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash', // Set the initial route to splash screen
      routes: {
        '/login': (context) => LoginScreen(),
        '/frame': (context) => const ScrnFrame(),
        '/splash': (context) => const ScrSplash(),
        '/home': (context) => const HomeScreen(
              cwApps: [], // Provide default value, this can be updated dynamically
            ),
      },
    );
  }
}
