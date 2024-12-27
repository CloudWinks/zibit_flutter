import 'package:flutter/material.dart';
import 'package:zibit_flutter/screens/scrn_splash.dart';

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
      home: const ScrSplash(), // Set Splash Screen as the initial screen
    );
  }
}
