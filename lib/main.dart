import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zibit_flutter/globals/glbl_user_model.dart';
import 'package:zibit_flutter/globals/glbl_app_model.dart';
import 'package:zibit_flutter/screens/scrn_splash.dart';
//import 'package:zibit_flutter/screens/scrn_home.dart';
import 'package:zibit_flutter/screens/scrn_frame.dart';
import 'package:zibit_flutter/screens/scrn_login_screen.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
  MultiProvider(
      providers: [
                // Provide the global navigator key
        Provider<GlobalKey<NavigatorState>>.value(value: navigatorKey),
        
        // User and App models

        ChangeNotifierProvider(create: (context) => UserModel(userId: 0, email: '')),
        ChangeNotifierProvider(create: (context) => AppModel(appid: 0)),
        // Other providers if needed...
      ],
      child: MyApp(),
    ),
    );
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
   //     '/home': (context) => const HomeScreen(
   //           cwApps: [], // Provide default value, this can be updated dynamically
   //         ),
      },
    );
  }
}
